Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC42F41EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbhAMCn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:43:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:54418 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbhAMCnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:43:25 -0500
IronPort-SDR: Ku+rg2Z1mofaPAcJouo8O+gq/O5gLynOMI6BLBXHexgf054soghzH7f9gl7is1XzUp+YmhFe7A
 YpyxGYLzoGcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="242212664"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="242212664"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 18:41:39 -0800
IronPort-SDR: AREd7oQnznsddHzTa3z54QGeZQx6RInVrOUVE9nAlPLf0TiToBCTCICK14AlmuhoVNUVQvaqh9
 TAdjZQmTT4cQ==
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="353280739"
Received: from ncorral-mobl2.amr.corp.intel.com (HELO [10.212.67.147]) ([10.212.67.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 18:41:38 -0800
Subject: Re: [PATCH v2 2/2] ASoC: rt715:add Mic Mute LED control support
To:     "Yuan, Perry" <Perry.Yuan@dell.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        "oder_chiou@realtek.com" <oder_chiou@realtek.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201228133831.17464-1-Perry_Yuan@Dell.com>
 <a12075b1-09f3-a993-eace-008224ca5f52@linux.intel.com>
 <SJ0PR19MB4528225B226C4F9AA7F7ECBE84AA0@SJ0PR19MB4528.namprd19.prod.outlook.com>
 <BY3PR19MB49130372226D65A235757BA1FAAA0@BY3PR19MB4913.namprd19.prod.outlook.com>
 <SJ0PR19MB4528FA846E29C0BB197725CA84A90@SJ0PR19MB4528.namprd19.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d133c0fe-c9c6-fc55-8c08-5e9a3cf0d6e7@linux.intel.com>
Date:   Tue, 12 Jan 2021 20:41:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SJ0PR19MB4528FA846E29C0BB197725CA84A90@SJ0PR19MB4528.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
>>>>> +	/* Privacy LED Trigger State Changed by muted/unmute switch */
>>>>> +	if (mc->invert) {
>>>>> +		val0 = ucontrol->value.integer.value[0];
>>>>> +		val1 = ucontrol->value.integer.value[1];
>>>>> +		if (val0 == 1 && val1 == 1) {
>>>>> +			rt715->micmute_led = LED_OFF;
>>>>> +			ledtrig_audio_set(LED_AUDIO_MICMUTE,
>>>>> +					rt715->micmute_led ? LED_ON :
>>>> LED_OFF);
>>>>> +		} else if (val0 == 0 && val1 == 0) {
>>>>> +			rt715->micmute_led = LED_ON;
>>>>> +			ledtrig_audio_set(LED_AUDIO_MICMUTE,
>>>>> +					rt715->micmute_led ? LED_ON :
>>>> LED_OFF);
>>>>> +		}
>>>>> +	}
>>>>> +#endif
>>>>
>>>> Should this be activated for specific DMI quirks? This driver is
>>>> used in
>>> non-Dell
>>>> platforms (I am thinking of Intel RVPs or Realtek daughterboards), I
>>>> am not sure if a build-time behavior change makes sense.
>>>>
>>>> Or conversely could we just set the LEDs unconditionally if doing so
>>>> is harmless?
>>>
>>> The current mic mute led setting path is not common used for other
>>> vendors, just Dell platform support this mic mute led set operation.
>>>
>>> Do you think that I need to add one DMI quirk in the next version ?
>>> If so, I can add that.
>>>
>>>
>>
>>
>> In the HDA audio case this is modeled off of, the code runs whether or not a
>> vendor has support for a mic mute LED.  The calls to ledtrig_audio_set should
>> be a no-op.  I agree with @Pierre-Louis Bossart in this case, we should just be
>> running it whether or not dell-privacy is compiled in.  If another vendor
>> chooses to add LED support they'll just need to set up their ledtrig supported
>> backend and not change codec code.
> 
> Hi @Pierre-Louis Bossart
> Seems like that we have two way to go.
> * DMI quirks,seems like that it needs to maintain the quirk list when vendors have new system to support.
> * We just set the mic mute led state unconditionally .
> 
> Which way would you prefer for next patch review?

Maintaining quirks is a hassle, it's much simpler and consistent with 
HDaudio if the leds are set unconditionally. Thanks!
