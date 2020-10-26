Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D45299058
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782861AbgJZPBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:01:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:51324 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1782298AbgJZPBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:01:13 -0400
IronPort-SDR: hRVzwCn9RyPMAEF1ZpgHIiyst1H9VNmwdEodOfLyHQSMW9mwQcpD6bqz48nuJ1hSyZxigW0Io3
 JGLvByQrieZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="232124342"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="232124342"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 08:01:11 -0700
IronPort-SDR: Zo2kyjlk1l4vY7HXpQLotX/peNNFhR7Mk9SSzqu/xK6f9Xak118WO1ozmHhGdlk850jIdtICBo
 H1nq/CDc9NJQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="360396118"
Received: from mpetitt-mobl1.amr.corp.intel.com (HELO [10.254.103.61]) ([10.254.103.61])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 08:01:11 -0700
Subject: Re: Patch "ASoC: topology: disable size checks for bytes_ext controls
 if needed" has been added to the 4.9-stable tree
To:     Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Cc:     stable-commits@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
References: <20201026055347.0F79E20882@mail.kernel.org>
 <20201026121123.GA2474358@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e1aae5d8-3820-9126-d1a9-225f093dfde7@linux.intel.com>
Date:   Mon, 26 Oct 2020 10:01:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201026121123.GA2474358@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/20 7:11 AM, Greg KH wrote:
> On Mon, Oct 26, 2020 at 01:53:46AM -0400, Sasha Levin wrote:
>> This is a note to let you know that I've just added the patch titled
>>
>>      ASoC: topology: disable size checks for bytes_ext controls if needed
>>
>> to the 4.9-stable tree which can be found at:
>>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>> The filename of the patch is:
>>       asoc-topology-disable-size-checks-for-bytes_ext-cont.patch
>> and it can be found in the queue-4.9 subdirectory.
>>
>> If you, or anyone else, feels it should not be added to the stable tree,
>> please let <stable@vger.kernel.org> know about it.
>>
> 
> This breaks the build, so I'm dropping it from everywhere it had
> problems.
> 
> Also, why 5.4.y and not 4.19.y, but 4.14.y and 4.9.y?

Ah yes, there's a missed dependency on
fbd3eb7f66c5b ('ALSA: control: Add verification for kctl accesses')

I thought all of this was 20 years old but that commit added the option 
SND_CTL_VALIDATION which exposed the problem with this topology patch. 
Given the date (January 2020), I don't think it makes sense before 5.6?

I don't think this could have compiled prior to 5.6, I e.g. checked on 
4.14.202 and the define SNDRV_CTL_ELEM_ACCESS_SKIP_CHECK was not defined 
either.

git grep SNDRV_CTL_ELEM_ACCESS_SKIP_CHECK
sound/soc/soc-topology.c:                       k->access |= 
SNDRV_CTL_ELEM_ACCESS_SKIP_CHECK;

Summary: I suggested this patch be dropped for all versions that don't 
contain fbd3eb7f66c5b. Takashi, do you concur?

Thanks for spotting this.
-Pierre
