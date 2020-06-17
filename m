Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA0C1FD0D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFQPYl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 17 Jun 2020 11:24:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44598 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgFQPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 11:24:41 -0400
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jlZvZ-0001Yw-De
        for linux-kernel@vger.kernel.org; Wed, 17 Jun 2020 15:24:37 +0000
Received: by mail-pj1-f72.google.com with SMTP id d14so1799751pjw.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 08:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=683Q9JCe9F/UMYLnm+lPw6gboNB4i1YDCLWv7+DNnwo=;
        b=ic/96Glt640UsVe8NjOYvHvZzPEHZj9s9x0udfNrcPg3Kma169Ca6SSp6wapnPPPCZ
         RYbV0n4Q8VBp6u3VF+QocHvvbjNDzEh85mZaoQWOMQEj5NEZi7eLvkQn2r7oD6vDg3hN
         2rGSkeBfQU7sIrRoFJT7bHoK5j94zRudGGTDMrx/fA4yKVBdJQo19H6Xu3Y4FJ6+iMzd
         8w9B+oqAE57zA02kUmC6VnHRaYBbhioehv4qnsrwLeOPWKQ+neEYtGDNvK/iWdWczwIB
         ElUQouWp4BZWJn0CQWOpShPClfkYf03tYelinGTUZX0vfUNyfDSRnBu/api1APSL3QoQ
         Abwg==
X-Gm-Message-State: AOAM533QrTFgJYtjRMGZSkLu0o7PGHiUszxt/x+4JAseGdJos/vqwwWR
        AX0NLlRmnYbrCneaChFaGHlg8M9ps502W5ChfXPFLuQYd9BlrGSD+v7eyILw0dXRHKWIq3Vhcmj
        Wj9bSyP5HEKH2fGG1YHukBb8eh8x9SHn7qVQHy7ACKA==
X-Received: by 2002:a62:18d3:: with SMTP id 202mr7139450pfy.180.1592407475636;
        Wed, 17 Jun 2020 08:24:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeqn+JCnh0gio1iUG8+0i1DDlnENVKupwKJxgzTMv91B6Efx8p6AdEfQch5sNAOMSOcliaBg==
X-Received: by 2002:a62:18d3:: with SMTP id 202mr7139416pfy.180.1592407475178;
        Wed, 17 Jun 2020 08:24:35 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id l3sm203953pgm.59.2020.06.17.08.24.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 08:24:34 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/2] ALSA: hda/realtek: Add COEF controlled micmute LED
 support
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hd05xzz3d.wl-tiwai@suse.de>
Date:   Wed, 17 Jun 2020 23:24:30 +0800
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Wenwen Wang <wenwen@cs.uga.edu>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Hui Wang <hui.wang@canonical.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <934401DE-7A4E-4B2C-8B06-E2AA203A9336@canonical.com>
References: <20200617102906.16156-1-kai.heng.feng@canonical.com>
 <s5hd05xzz3d.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 17, 2020, at 19:55, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Wed, 17 Jun 2020 12:29:01 +0200,
> Kai-Heng Feng wrote:
>> 
>> Currently, HDA codec LED class can only be used by GPIO controlled LED.
>> However, there are some new systems that control LED via COEF instead of
>> GPIO.
>> 
>> In order to support those systems, create a new helper that can be
>> facilitated by both COEF controlled and GPIO controlled LED.
>> 
>> In addition to that, add LED_CORE_SUSPENDRESUME flag since some systems
>> don't restore the LED properly after suspend.
>> 
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Thanks for the quick follow up, the issues I pointed were fixed.
> 
> But, now looking at the code change again, I'm no longer sure whether
> it's the right move.
> 
> Basically, the led cdev should serve only for turning on/off the LED
> as given.  But your patch changes it to call the generic mixer
> updater, which is rather the one who would call the led cdev state
> update itself.  That is, it's other way round.
> 
> IMO, what we need is to make all places calling
> snd_hda_gen_add_micmute_led() to create led cdev, and change those
> calls with snd_hda_gen_fixup_micmute_led().

Ok, so it's the same as patch v1.
How should we handle vendors other than HP?
Only create led cdev if the ID matches to HP?

> 
> It'll be a bit more changes and likely not fitting with 5.8, but the
> whole result will be more consistent.

A bit off topic, but do you think it's reasonable to also create led cdev for mute LED, in addition to micmute LED?
I just found that the LEDs are still on during system suspend, and led cdev has the ability to turn off the LEDs on system suspend.

Kai-Heng

> 
> 
> thanks,
> 
> Takashi
> 
> 
>> ---
>> v3:
>> - Wording.
>> - Properly prefix exported symbol.
>> v2:
>> - Prevent platforms like Dell, Lenovoe and Huawei create double LED
>>   class devices.
>> sound/pci/hda/hda_generic.c   |  7 ++++---
>> sound/pci/hda/hda_generic.h   |  1 +
>> sound/pci/hda/patch_realtek.c | 29 ++++++++++++++++-------------
>> 3 files changed, 21 insertions(+), 16 deletions(-)
>> 
>> diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
>> index f4e9d9445e18..e4f534e9a88c 100644
>> --- a/sound/pci/hda/hda_generic.c
>> +++ b/sound/pci/hda/hda_generic.c
>> @@ -3897,7 +3897,7 @@ enum {
>> 	MICMUTE_LED_FOLLOW_MUTE,
>> };
>> 
>> -static void call_micmute_led_update(struct hda_codec *codec)
>> +void snd_hda_gen_call_micmute_led_update(struct hda_codec *codec)
>> {
>> 	struct hda_gen_spec *spec = codec->spec;
>> 	unsigned int val;
>> @@ -3924,6 +3924,7 @@ static void call_micmute_led_update(struct hda_codec *codec)
>> 	if (spec->micmute_led.update)
>> 		spec->micmute_led.update(codec);
>> }
>> +EXPORT_SYMBOL_GPL(snd_hda_gen_call_micmute_led_update);
>> 
>> static void update_micmute_led(struct hda_codec *codec,
>> 			       struct snd_kcontrol *kcontrol,
>> @@ -3945,7 +3946,7 @@ static void update_micmute_led(struct hda_codec *codec,
>> 			spec->micmute_led.capture |= mask;
>> 		else
>> 			spec->micmute_led.capture &= ~mask;
>> -		call_micmute_led_update(codec);
>> +		snd_hda_gen_call_micmute_led_update(codec);
>> 	}
>> }
>> 
>> @@ -3982,7 +3983,7 @@ static int micmute_led_mode_put(struct snd_kcontrol *kcontrol,
>> 	if (mode == spec->micmute_led.led_mode)
>> 		return 0;
>> 	spec->micmute_led.led_mode = mode;
>> -	call_micmute_led_update(codec);
>> +	snd_hda_gen_call_micmute_led_update(codec);
>> 	return 1;
>> }
>> 
>> diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
>> index fb9f1a90238b..062be242339a 100644
>> --- a/sound/pci/hda/hda_generic.h
>> +++ b/sound/pci/hda/hda_generic.h
>> @@ -353,6 +353,7 @@ unsigned int snd_hda_gen_path_power_filter(struct hda_codec *codec,
>> void snd_hda_gen_stream_pm(struct hda_codec *codec, hda_nid_t nid, bool on);
>> int snd_hda_gen_fix_pin_power(struct hda_codec *codec, hda_nid_t pin);
>> 
>> +void snd_hda_gen_call_micmute_led_update(struct hda_codec *codec);
>> int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
>> 				void (*hook)(struct hda_codec *));
>> void snd_hda_gen_fixup_micmute_led(struct hda_codec *codec,
>> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
>> index 6d73f8beadb6..0587d1e96b19 100644
>> --- a/sound/pci/hda/patch_realtek.c
>> +++ b/sound/pci/hda/patch_realtek.c
>> @@ -4114,10 +4114,10 @@ static int micmute_led_set(struct led_classdev *led_cdev,
>> 			   enum led_brightness brightness)
>> {
>> 	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
>> -	struct alc_spec *spec = codec->spec;
>> +	struct hda_gen_spec *spec = codec->spec;
>> 
>> -	alc_update_gpio_led(codec, spec->gpio_mic_led_mask,
>> -			    spec->micmute_led_polarity, !!brightness);
>> +	spec->micmute_led.led_mode = !brightness;
>> +	snd_hda_gen_call_micmute_led_update(codec);
>> 	return 0;
>> }
>> 
>> @@ -4126,7 +4126,17 @@ static struct led_classdev micmute_led_cdev = {
>> 	.max_brightness = 1,
>> 	.brightness_set_blocking = micmute_led_set,
>> 	.default_trigger = "audio-micmute",
>> +	.flags = LED_CORE_SUSPENDRESUME,
>> };
>> +
>> +static void alc_register_micmute_led(struct hda_codec *codec)
>> +{
>> +		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
>> +		if (devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev))
>> +			codec_warn(codec, "failed to register micmute LED\n");
>> +}
>> +#else
>> +static inline void alc_register_micmute_led(struct hda_codec *codec) {}
>> #endif
>> 
>> /* setup mute and mic-mute GPIO bits, add hooks appropriately */
>> @@ -4136,9 +4146,6 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
>> 				  unsigned int micmute_mask)
>> {
>> 	struct alc_spec *spec = codec->spec;
>> -#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>> -	int err;
>> -#endif
>> 
>> 	alc_fixup_gpio(codec, action, mute_mask | micmute_mask);
>> 
>> @@ -4151,13 +4158,7 @@ static void alc_fixup_hp_gpio_led(struct hda_codec *codec,
>> 	if (micmute_mask) {
>> 		spec->gpio_mic_led_mask = micmute_mask;
>> 		snd_hda_gen_add_micmute_led(codec, alc_gpio_micmute_update);
>> -
>> -#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
>> -		micmute_led_cdev.brightness = ledtrig_audio_get(LED_AUDIO_MICMUTE);
>> -		err = devm_led_classdev_register(&codec->core.dev, &micmute_led_cdev);
>> -		if (err)
>> -			codec_warn(codec, "failed to register micmute LED\n");
>> -#endif
>> +		alc_register_micmute_led(codec);
>> 	}
>> }
>> 
>> @@ -4305,6 +4306,7 @@ static void alc285_fixup_hp_coef_micmute_led(struct hda_codec *codec,
>> 		spec->mic_led_coefbit_on = 1<<13;
>> 		spec->mic_led_coefbit_off = 0;
>> 		snd_hda_gen_add_micmute_led(codec, alc_hp_cap_micmute_update);
>> +		alc_register_micmute_led(codec);
>> 	}
>> }
>> 
>> @@ -4319,6 +4321,7 @@ static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
>> 		spec->mic_led_coefbit_on = 2<<2;
>> 		spec->mic_led_coefbit_off = 1<<2;
>> 		snd_hda_gen_add_micmute_led(codec, alc_hp_cap_micmute_update);
>> +		alc_register_micmute_led(codec);
>> 	}
>> }
>> 
>> -- 
>> 2.17.1
>> 

