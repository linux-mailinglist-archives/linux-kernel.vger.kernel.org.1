Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209701FEF7E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 12:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgFRKQ2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 18 Jun 2020 06:16:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47508 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgFRKQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:16:25 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jlrao-0006Qe-4b
        for linux-kernel@vger.kernel.org; Thu, 18 Jun 2020 10:16:22 +0000
Received: by mail-pg1-f200.google.com with SMTP id 72so3720587pgb.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 03:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=tafBBnafCbfI5o9MOV+64xc9E0d/3o9toKXYsB0LHjg=;
        b=POG3rsAGFqHp6iP3oVPlm4CqZY2wFVG3ABnSIzQ3Vn2ORbFTgTjXhK/cbg+2CqekHh
         l6oaHKqqvX9mjPs5NsbGcAQAi1kShuCOVGRA644oVeNiVyxikDuxngTMtn+x4S6ESv8f
         vHeO0bfkYoszeciZ6rcwTK0PTQqB49u6jhQe2YZYufqPyf0gjoTGDtvR7dwmGCCkVfoZ
         Nta1CPeWl1oJ/BZ1Ys7J6n3QNgjDbOvaRQA82iCZogCx2SSupzIa/IJVl/yhY0MMfHG2
         /dbC/z5rwqIoUQ2zP8UnP5g7dDhETGM2+SjvpmvSbDQiTDDGU1Fr648rF6cM/m4+9+K1
         ed2g==
X-Gm-Message-State: AOAM533y9nZMss03vqzVmvXQPj3xrUB3BkJL+7rqbfWtiEzui7ECE7kD
        sLfOe3PzFz/KSJ/qOqOjUrYp0NkO6+kaamyp/LFNUCPEtVK8QyzSh3eJeMPNfuBGsB17fj1ExsC
        NS7tsLIeTtAAxnc7Ke8whjvcyZgsH6DEz7ShvMETPdQ==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr2706882pgp.160.1592475380563;
        Thu, 18 Jun 2020 03:16:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcrIMx+GxkoyBuQ/qT0KMBZ9GgjwPYV2GO9uzuY+3d9c7k8NOQNlyofE6oHwexJY5ElbUkBA==
X-Received: by 2002:a65:43cb:: with SMTP id n11mr2706856pgp.160.1592475380156;
        Thu, 18 Jun 2020 03:16:20 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id x20sm2044113pjr.44.2020.06.18.03.16.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 03:16:19 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 1/2] ALSA: hda/realtek: Add COEF controlled micmute LED
 support
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <s5hwo44ygku.wl-tiwai@suse.de>
Date:   Thu, 18 Jun 2020 18:16:15 +0800
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
Message-Id: <50F84AE3-CA74-4231-86F2-30D7C7920B4D@canonical.com>
References: <20200617102906.16156-1-kai.heng.feng@canonical.com>
 <s5hd05xzz3d.wl-tiwai@suse.de>
 <934401DE-7A4E-4B2C-8B06-E2AA203A9336@canonical.com>
 <s5h366tzo6x.wl-tiwai@suse.de>
 <DB5A1DD9-4D61-466F-A7DE-4219534DFA4D@canonical.com>
 <s5hwo44ygku.wl-tiwai@suse.de>
To:     Takashi Iwai <tiwai@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 18, 2020, at 15:32, Takashi Iwai <tiwai@suse.de> wrote:
> 
> On Thu, 18 Jun 2020 07:15:21 +0200,
> Kai-Heng Feng wrote:
>> 
>> 
>> 
>>> On Jun 17, 2020, at 23:50, Takashi Iwai <tiwai@suse.de> wrote:
>>> 
>>> On Wed, 17 Jun 2020 17:24:30 +0200,
>>> Kai-Heng Feng wrote:
>>>> 
>>>> 
>>>> 
>>>>> On Jun 17, 2020, at 19:55, Takashi Iwai <tiwai@suse.de> wrote:
>>>>> 
>>>>> On Wed, 17 Jun 2020 12:29:01 +0200,
>>>>> Kai-Heng Feng wrote:
>>>>>> 
>>>>>> Currently, HDA codec LED class can only be used by GPIO controlled LED.
>>>>>> However, there are some new systems that control LED via COEF instead of
>>>>>> GPIO.
>>>>>> 
>>>>>> In order to support those systems, create a new helper that can be
>>>>>> facilitated by both COEF controlled and GPIO controlled LED.
>>>>>> 
>>>>>> In addition to that, add LED_CORE_SUSPENDRESUME flag since some systems
>>>>>> don't restore the LED properly after suspend.
>>>>>> 
>>>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> 
>>>>> Thanks for the quick follow up, the issues I pointed were fixed.
>>>>> 
>>>>> But, now looking at the code change again, I'm no longer sure whether
>>>>> it's the right move.
>>>>> 
>>>>> Basically, the led cdev should serve only for turning on/off the LED
>>>>> as given.  But your patch changes it to call the generic mixer
>>>>> updater, which is rather the one who would call the led cdev state
>>>>> update itself.  That is, it's other way round.
>>>>> 
>>>>> IMO, what we need is to make all places calling
>>>>> snd_hda_gen_add_micmute_led() to create led cdev, and change those
>>>>> calls with snd_hda_gen_fixup_micmute_led().
>>>> 
>>>> Ok, so it's the same as patch v1.
>>>> How should we handle vendors other than HP?
>>>> Only create led cdev if the ID matches to HP?
>>> 
>>> It's fine to create a LED classdev for other vendors, too.  But the
>>> problem is that it wasn't consistent.  With the LED classdev, we
>>> should use only cdev, instead of mixing up different ways.
>> 
>> Ok, now I get what you meant...
>> 
>>> 
>>> I wrote a few patches to convert those mic-mute LED stuff to classdev,
>>> including some cleanups.  The patches are found in
>>> topic/hda-micmute-led branch of sound git tree.  Could you check it?
>>> 
>>> Note that it's totally untested.  Also it doesn't contain yet
>>> LED_CORE_SUSPENDRESUME, which should be done in another patch in
>>> anyway.
>> 
>> Other than LED_CORE_SUSPENDRESUME, it works great!
>> 
>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Good to hear!
> 
>>>>> It'll be a bit more changes and likely not fitting with 5.8, but the
>>>>> whole result will be more consistent.
>>>> 
>>>> A bit off topic, but do you think it's reasonable to also create led cdev for mute LED, in addition to micmute LED?
>>>> I just found that the LEDs are still on during system suspend, and led cdev has the ability to turn off the LEDs on system suspend.
>>> 
>>> Yes, it makes sense, too.  But the playback mute handling is a bit
>>> more complicated than the mic-mute LED because it's implemented with a
>>> vmaster hook.  I'll take a look later.
>> 
>> Thanks. I'll be happy to test it.
> 
> OK, I worked on this further and converted the whole mute LED handling
> with LED classdev.
> 
> The topic/hda-micmute-led branch was updated again.  Could you give it
> a try?  If that's OK, I'll add your tested-by tag and submit the
> patches to ML later.

Thanks for the work, it works great.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> 
> The old patchset is saved in topic/hda-micmute-led-old branch just for
> a reference.
> 
> 
> thanks,
> 
> Takashi

