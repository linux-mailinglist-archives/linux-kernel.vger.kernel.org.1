Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539BB2A4AF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 17:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgKCQPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 11:15:03 -0500
Received: from mga06.intel.com ([134.134.136.31]:3252 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728029AbgKCQPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 11:15:00 -0500
IronPort-SDR: jILnJpGm0j4rUe+pLF33+TVFc1USsC50Ybn3nhl7sNvw7w0AtRudN13xbQr9DPYewyovGupYxP
 agrEjK9kOtSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="230709172"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="230709172"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 08:15:00 -0800
IronPort-SDR: 8HuAY75XhSfQhszJ2sDcMZ9CbaSCwurL5LJKgivLZjKrgD6ljdv/XwWm/aQZkL1D2Zuint6U/9
 z0mrBYehc4Nw==
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="528532333"
Received: from ctanriov-mobl1.amr.corp.intel.com (HELO [10.212.114.78]) ([10.212.114.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 08:14:59 -0800
Subject: Re: [PATCH] ASoC: rt715:add Mic Mute LED control support
To:     Mark Brown <broonie@kernel.org>, Perry Yuan <Perry.Yuan@dell.com>
Cc:     oder_chiou@realtek.com, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com,
        Limonciello Mario <Mario.Limonciello@dell.com>,
        linux-kernel@vger.kernel.org, tiwai@suse.com
References: <20201103125859.8759-1-Perry_Yuan@Dell.com>
 <20201103131253.GA5545@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5f2c1282-4401-276a-8dad-127fa1f449fd@linux.intel.com>
Date:   Tue, 3 Nov 2020 10:13:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103131253.GA5545@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow this patch was filtered by alsa-devel servers?

On 11/3/20 7:12 AM, Mark Brown wrote:
> On Tue, Nov 03, 2020 at 04:58:59AM -0800, Perry Yuan wrote:
>> From: perry_yuan <perry_yuan@dell.com>
>>
>> Some new Dell system is going to support audio internal micphone
>> privacy setting from hardware level with micmute led state changing
>>
>> This patch allow to change micmute led state through this micphone
>> led control interface like hda_generic provided.
> 
> If this is useful it should be done at the subsystem level rather than
> open coded in a specific CODEC driver, however I don't undersand why it
> is.
> 
>> +static int rt715_micmute_led_mode_put(struct snd_kcontrol *kcontrol,
>> +      struct snd_ctl_elem_value *ucontrol)
>> +{
>> +    struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
>> +    struct rt715_priv *rt715 = snd_soc_component_get_drvdata(component);
>> +    int led_mode = ucontrol->value.integer.value[0];
>> +
>> +    rt715->micmute_led = led_mode;
>> +#if IS_ENABLED(CONFIG_LEDS_TRIGGER_AUDIO)
>> +    ledtrig_audio_set(LED_AUDIO_MICMUTE,
>> +               rt715->micmute_led ? LED_ON : LED_OFF);
>> +#endif
>> +  return 0;
>> +}
> 
> This is just adding a userspace API to set a LED via the standard LED
> APIs.  Since the LED subsystem already has a perfectly good userspace
> API why not use that?  There is no visible value in this being in the
> sound subsystem.

I also don't quite follow. This looks as inspired from HDaudio code, but 
with a lot of simplifications.

If the intent was that when userspace decides to mute the LED is turned 
on, wouldn't it be enough to just track the state of a 'capture switch' 
responsible for mute, i.e. when the capture Switch is 'off' the LED is 
on. I don't see the point of having a new control, you would be adding 
more work for PulseAudio/UCM whereas connecting the capture switch to a 
led comes with zero work in userspace. See e.g. how the mute mic LED was 
handled in the SOF code handling DMICs, we didn't add a new control but 
turned the LED in the switch .put callback, see

https://elixir.bootlin.com/linux/latest/source/sound/soc/sof/control.c#L18

https://elixir.bootlin.com/linux/latest/source/sound/soc/sof/control.c#L153

Actually thinking more about it, having two controls for 'mute LED' and 
'capture switch' could lead to inconsistent states where the LED is on 
without mute being activated. we should really bolt the LED activation 
to the capture switch, that way the mute and LED states are aligned.


