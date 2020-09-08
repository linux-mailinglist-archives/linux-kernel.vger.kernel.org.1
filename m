Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9645C26136F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 17:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgIHPVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 11:21:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:15159 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730273AbgIHPQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:16:51 -0400
IronPort-SDR: f+qnvgQbTTIj9+R2VJO38GyFzoxshrSzbDmvhVZwav36J6kNq5GY3VBA/TPt1bcNYOrM/yNesn
 335Wao+Im7Ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="222350543"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="222350543"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 07:47:16 -0700
IronPort-SDR: puPDPc9u2j1rpXBb9lkAFy9hUk9VxiuIy5q/f3cgrvaUGVA1uCpxSlgSAOXrarnxTE+c5vsTim
 B/lcp8Cq+Crw==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="448812218"
Received: from mgarber-mobl1.amr.corp.intel.com (HELO [10.212.179.134]) ([10.212.179.134])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 07:47:15 -0700
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
To:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        hui.wang@canonical.com, Vinod Koul <vkoul@kernel.org>,
        srinivas.kandagatla@linaro.org, ranjani.sridharan@linux.intel.com,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
 <20200908121133.GA5551@sirena.org.uk>
 <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
 <20200908143312.GC5551@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ce68a159-de6d-2d8a-c8a2-3e527cb1239e@linux.intel.com>
Date:   Tue, 8 Sep 2020 09:47:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908143312.GC5551@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/8/20 9:33 AM, Mark Brown wrote:
> On Tue, Sep 08, 2020 at 02:28:48PM +0200, Jaroslav Kysela wrote:
>> Dne 08. 09. 20 v 14:11 Mark Brown napsal(a):
> 
>>> I don't have this patch and since I seem to get copied on quite a lot of
>>> soundwire only serieses I just delete them unread mostly.

We now try to use the ASoC/SoundWire prefix for cover letters to 
highlight that a patchset changes things across two trees, does this 
help or do we need a different way of flagging these patches?

>> It can be fetched from lore (mbox format):
> 
>> https://lore.kernel.org/alsa-devel/20200818140656.29014-2-yung-chuan.liao@linux.intel.com/raw
> 
> Sure, I can go get stuff from the list archives but my list of things to
> go through is in my inbox.
> 
