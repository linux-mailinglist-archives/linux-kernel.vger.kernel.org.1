Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811F42D14CB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgLGPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:33:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:45604 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgLGPdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:33:40 -0500
IronPort-SDR: 7KEl/CzNqJPxOd3t31lygppcR3LQuJdTzhUSMCxVkImBFVHQmsek/GvTwbf6M/FgA6SsLzjBSA
 Pv+M55dFRyaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="152959505"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="152959505"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 07:31:52 -0800
IronPort-SDR: KbTnrTTSS8jKBpjcxMVefEXDoYDTPU/AOAd+FkIDApCygwxT5ouyQYva6f++U2HTAUPogyYROn
 WtD076O+oLsw==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="541531614"
Received: from singhyax-mobl2.amr.corp.intel.com (HELO [10.255.229.103]) ([10.255.229.103])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 07:31:50 -0800
Subject: Re: [PATCH 1/7] soundwire: bus: use sdw_update_no_pm when
 initializing a device
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-2-yung-chuan.liao@linux.intel.com>
 <20201205074508.GQ8403@vkoul-mobl>
 <1db93c2e-3c87-bc5e-ddeb-56424870b897@linux.intel.com>
 <20201207044334.GA8403@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <668b4d5c-d9eb-0256-ce26-df38e32cc520@linux.intel.com>
Date:   Mon, 7 Dec 2020 09:31:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201207044334.GA8403@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/20 10:43 PM, Vinod Koul wrote:
> On 05-12-20, 08:59, Pierre-Louis Bossart wrote:
>> Thanks for the review Vinod.
>>
>> On 12/5/20 1:45 AM, Vinod Koul wrote:
>>> On 03-12-20, 04:46, Bard Liao wrote:
>>>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>>
>>>> When a Slave device is resumed, it may resume the bus and restart the
>>>> enumeration. During that process, we absolutely don't want to call
>>>> regular read/write routines which will wait for the resume to
>>>> complete, otherwise a deadlock occurs.
>>>>
>>>> Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of read/write functions')
>>>
>>> Change looks okay, but not sure why this is a fix for adding no pm
>>> version?
>>
>> when we added the no_pm version, we missed the two cases below where
>> sdw_update() was used and that creates a deadlock. To me that's a conceptual
>> bug, we didn't fully use the no_pm versions, hence the Fixes tag.
> 
> Documentation says:
> "A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
> is used to make it easy to determine where a bug originated, which can help
> review a bug fix. This tag also assists the stable kernel team in determining
> which stable kernel versions should receive your fix. This is the preferred
> method for indicating a bug fixed by the patch. See :ref:`describe_changes`
> for more details."
> 
> I do not this this helps here as this does not help distros etc
> I would say this is incremental development which improved a case not
> done properly earlier, unless you would like this to be backported.. In
> that case it helps folks...

IMHO the changes in the series are absolutely required to have a 
reliable suspend-resume operation and will need to be back-ported. When 
I said 'conceptual bug', I didn't mean a hypothetical case, I really 
meant that a proven race condition and timeouts will occur. That's not 
good... We will provide the list of this patches to distros that are 
known to support SoundWire as a 'must apply'.

If you look at the series, we provided Fixes tags for all patches except 
'cosmetic' ones which don't fundamentally change the behavior (Patch 3, 
patch 7) or when the code has not reached Linus' tree (patch 5).

That said, 5.10 was the first release where SoundWire started to be 
functional so there's no need to apply these patches to earlier versions 
of the stable tree.

Does this help?
