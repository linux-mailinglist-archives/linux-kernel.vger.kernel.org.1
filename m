Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72782A0BD2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgJ3Qyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:54:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:9998 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726058AbgJ3Qyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:54:36 -0400
IronPort-SDR: nGyGXZK18pW6S2W6un9df1JturJ9PoFNlHIbOnKZ6/kHGlXCjJXVGc61TzYysTL1JTJ8H/30ny
 VScsMeqsELuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="253342504"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="253342504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:54:36 -0700
IronPort-SDR: PLekFtLEEY6YTiYO9pHHlQ2RtiqVwr2QLS6Dk/6e85wc5VXor0qhwFoEcmpxbknRBx5PX/4SMx
 bENMMqlCIQ5w==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="469577604"
Received: from rdchavez-mobl2.amr.corp.intel.com (HELO [10.212.91.180]) ([10.212.91.180])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 09:54:34 -0700
Subject: Re: [PATCH 2/2] ASoC: intel: sof_rt5682: Add quirk for Dooly
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "Wang, Rander" <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>
References: <20201030063654.25877-1-brent.lu@intel.com>
 <20201030063654.25877-3-brent.lu@intel.com>
 <c83b3f20-2afd-12da-c349-31f35f8f6aa5@linux.intel.com>
 <DM6PR11MB3642F7AB13991ACF8A32B1DE97150@DM6PR11MB3642.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <95b8d2f7-3b8d-ee61-c99f-a62fce165618@linux.intel.com>
Date:   Fri, 30 Oct 2020 11:54:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR11MB3642F7AB13991ACF8A32B1DE97150@DM6PR11MB3642.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/20 11:44 AM, Lu, Brent wrote:
> , Brent Lu wrote:
>>> This DMI product family string of this board is "Google_Hatch" so the
>>> DMI quirk will take place. However, this board is using rt1015 speaker
>>> amp instead of max98357a specified in the quirk. Therefore, we need an
>>> new DMI quirk for this board.
>>
>> Do you actually need a DMI quirk for this platform?
>>
>> the .driver_data below uses the exact same settings as what you would use
>> with the generic solution based on ACPI IDs, see below.
>>
>> Wondering if patch1 would be enough?
>>
> 
> Dooly has DMI family string " Google_Hatch" so the DMI quirk will overwrite the
> driver_data. I asked google but they prefer not removing this string so it seems to
> me that one extra DMI quirk is needed.

I find this pretty funny. The PRODUCT_FAMILY was added to reduce the 
number of quirks, but of course there's a variant that has nothing to do 
with this 'FAMILY'.

You should add a comment on this, to make sure this information remains 
in the code and we don't lose it during code cleanups.

> 
>                  {
>                                  .callback = sof_rt5682_quirk_cb,
>                                  .matches = {
>                                                  DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Hatch"),
>                                  },
>                                  .driver_data = (void *)(SOF_RT5682_MCLK_EN |
>                                                                                  SOF_RT5682_MCLK_24MHZ |
>                                                                                  SOF_RT5682_SSP_CODEC(0) |
>                                                                                  SOF_SPEAKER_AMP_PRESENT |
>                                                                                  SOF_RT5682_SSP_AMP(1)),
>                  },
> 
> The other way is using acpi_dev_present() in probe to update the quirk with correct
> codec setting. Which one do you think is better?

The DMI quirk you added is probably better for now, I don't know if the 
odds of getting things right with acpi_dev_present() are that high or if 
we are going to get even more variants on top of this variant (e.g. 
tweeter/booster cases...).
If we get too many quirks we'll see later if we can simplify.

So if you don't mind adding a comment on the 'Dooly' quirk in a v3 that 
series is good to go.  Thank you!

