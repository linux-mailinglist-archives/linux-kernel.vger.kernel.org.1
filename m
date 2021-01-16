Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7B2F8DE9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbhAPRL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728531AbhAPRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:11:00 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDE4C06135A;
        Sat, 16 Jan 2021 07:50:50 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id v184so5946045wma.1;
        Sat, 16 Jan 2021 07:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=x+00tIBf/QefUex9fblzjYl8TVeelPB225Pi420+hDY=;
        b=plFPi22y1+imtJRfUHti77svL+kZBuzp5qyZDcOiHMP2+n+0/Acj/PDpFpa7hrrOYR
         1SN5YXQUzXOr5+MEU2ZlVgYY9Ef03M66UNUpYv6+lkWybj7r/p4j/skU+gNomxyeZMrL
         ldAbJCAvC+fI9P7XIFu4aaDwyqNwZ9Q5JJ875Hrv+Xl6ZWN/trptb0ecxQ42yiO+ePTc
         u8gstUBtd89iHDiy+yqrr5mWK1MiSgq/UTjFZzsX75wm0AOGRuGnPd9KQcEbSzZidck5
         p3urffKVECdgsB0dvUbthXqOFTYsivgcDFddD6Ak9/NszbRcQWQRs3Pyn8nrMU9JvTkJ
         iUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=x+00tIBf/QefUex9fblzjYl8TVeelPB225Pi420+hDY=;
        b=E6OgCbZgi2UcDS+rgG9l9FE8T+2OtT2SiACrCd0uIzYXUcRVtscei9qvPinqVBbqlb
         ybiza1Mi0cA2bGh4rMg0Af7QUnEmF/BTmJYsuKRkQVdTG+Ejce+wpTGK1EymsBmU24iQ
         jQkd7LRG+BO7U1H2hrixH3R9pYOdJJc2cYmKgESJDTeptaEIhSXZOAsq8QF8OIFifeVK
         sWqURG6dE/JDf6rtdOXIGSEr1x3tH7W55aD2ryNKVDqF39HebY7RlbEpKTVMcxx4B6Xm
         n2KRLUYPUGUJ+f5279GNOXTB6KEk2gZzxwFthP6WQr6cL7fkNdxyrTDpJWzbH0NOCzJY
         b1hQ==
X-Gm-Message-State: AOAM533mQuMfia+UVOAMxySnDZcjk0l9vg3D2+esqKu3SdRfy/1mfQRM
        Jc5PRROzKC+Vtidvp7u9pH4=
X-Google-Smtp-Source: ABdhPJwV1ftSvgQ9GSkbR7qmb2GHxkGVLRGKlny5KKMHQ3z0eLqDXCdkKL4jT9t79JwW8nifC8z4eA==
X-Received: by 2002:a7b:c115:: with SMTP id w21mr2300075wmi.114.1610812248994;
        Sat, 16 Jan 2021 07:50:48 -0800 (PST)
Received: from [0.0.0.0] ([2a01:4f8:c17:e10a::1])
        by smtp.gmail.com with ESMTPSA id o8sm18256383wrm.17.2021.01.16.07.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Jan 2021 07:50:47 -0800 (PST)
Subject: Re: [PATCH v3 3/3] ASoC: rt715:add micmute led state control supports
To:     Mark Brown <broonie@kernel.org>, Perry Yuan <Perry.Yuan@dell.com>
Cc:     oder_chiou@realtek.com, perex@perex.cz, tiwai@suse.com,
        hdegoede@redhat.com, mgross@linux.intel.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Mario.Limonciello@dell.com
References: <20210112171814.5404-1-Perry_Yuan@Dell.com>
 <20210112175406.GF4646@sirena.org.uk>
From:   Perry Yuan <perry979106@gmail.com>
Message-ID: <bd2aea87-2f91-2748-424b-50b3b6feb22b@gmail.com>
Date:   Sat, 16 Jan 2021 23:50:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210112175406.GF4646@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,
  Thanks for your review feedback.

On 2021/1/13 1:54, Mark Brown wrote:
> On Wed, Jan 13, 2021 at 01:18:14AM +0800, Perry Yuan wrote:
> 
>> Some new Dell system is going to support audio internal micphone
>> privacy setting from hardware level with micmute led state changing
>> When micmute hotkey pressed by user, soft mute will need to be enabled
>> firstly in case of pop noise, and codec driver need to react to mic
>> mute event to EC(embedded controller) notifying that SW mute is completed
>> Then EC will do the hardware mute physically within the timeout reached
> 
>> This patch allow codec rt715 driver to ack EC when micmute key pressed
>> through this micphone led control interface like hda_generic provided
>> ACPI method defined in dell-privacy micmute led trigger will be called
>> for notifying the EC that software mute has been completed
> 
> It feels like there's an abstraction problem here with this being hard
> coded in a specific CODEC driver.
> 

I will remove the CONFIG_DELL_PRIVACY ,because other vendors and other 
platforms maybe need to set their Mic mute led state when they enable 
soundwire and sof driver for audio function.
We can avoid hardcode in codec driver, indeed it is need for this new
soundwire & sof architecture of alsa.

>>   #include <linux/soundwire/sdw.h>
>> @@ -244,6 +245,7 @@ static int rt715_sdca_get_volsw(struct snd_kcontrol *kcontrol,
>>   	unsigned int max = mc->max;
>>   	int val;
>>   
>> +	pr_err("++++++rt715_sdca_get_volsw++\n");
>>   	val = snd_soc_component_read(component, mc->reg);
>>   	if (val < 0)
>>   		return -EINVAL;
> 
> This shouldn't be in the patch.
It is my mistake to leave the debug line here.
will be removed in next V4 .
> 
>> @@ -287,6 +291,18 @@ static int rt715_sdca_put_volsw(struct snd_kcontrol *kcontrol,
>>   			return err;
>>   	}
>>   
>> +#if IS_ENABLED(CONFIG_DELL_PRIVACY)
>> +	/* dell privacy LED trigger state changed by muted/unmute switch */
>> +	if (mc->invert) {
>> +		if (ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1]) {
>> +			rt715->micmute_led = LED_OFF;
>> +		} else {
>> +			rt715->micmute_led = LED_ON;
>> +		}
>> +		ledtrig_audio_set(LED_AUDIO_MICMUTE, rt715->micmute_led);
>> +	}
>> +#endif
>> +
> 
> This doesn't look good.  There's nothing Dell specific here, and nothing
> about this is conditional on any sort of runtime detection of Dell
> systems, it's not obvious why this is conditional on DELL_PRIVACY or why
> we only report the state if the control is inverted.

I will remove the CONFIG_DELL_PRIVACY for the mic mute led operation is 
not only needed for dell platforms but also other Vendors all need to 
set micmute led necessaryily.
> 
> I'm also not convinced that it's a good idea to set the mute LED if only
> one channel in a stereo microphone is muted, that seems likely to lead
> to surprising behaviour for users.
> 
At first, i just want to handle val0 == 1 && val1 == 1 and val0 == 0 && 
val1 == 0 only. Intel suggested i need to cover all about other cases, 
the mute led should be off if any channel of mic is on.
So i change the led state when any one channel is muted or unmuted.

> TBH I don't understand why this isn't being done in generic code.
> 
>> +	bool micmute_led;
> 
> What is this for, it never seems to be read except for in the function
> where it's set?
> 

Do you mean i can use a local micmute_led var in the function?

