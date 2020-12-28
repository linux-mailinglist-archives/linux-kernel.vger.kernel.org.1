Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461C92E6999
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgL1ROP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:14:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44273 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbgL1ROO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:14:14 -0500
Received: from mail-oo1-f71.google.com ([209.85.161.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ktw5L-0000I1-OK
        for linux-kernel@vger.kernel.org; Mon, 28 Dec 2020 17:13:31 +0000
Received: by mail-oo1-f71.google.com with SMTP id f23so6060388oov.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3AREO2qVhTwtQVFWu5d92puZAYkGCodAaQymslEY8ZI=;
        b=NGItugQ95yn1I3bL8s6TcEkhG6v4tQ7MZbKjc0EZ06wD5ZKDP6OH1EpOOr8G4L2v7a
         DSETAKjtSV2k4FThA0CVi8fpghjiWtOsOjUDMKBN7xWGphUI31zg7l7Gd0bpdB/s+NXL
         JoDnx1IvGFi8PjU60sKERDulhBUzwxHxSPGpw0IgxDommrMChuAfrWA2kQEzw5VUU3S1
         Be+a8jO6LUkHhN32sYFd5nd3TFRdyEC/rOuhYJ7hZSpo1NXhDAeKeRTGhGNinH8ddPM3
         F43p/g/p20bl4Xum70Ih7rqHXdwth0BaEvnvFnFlV7O7V1wuQWahYYc0P+ImWpY2TB7a
         jCvg==
X-Gm-Message-State: AOAM531I4SpHlnjo+lWIspkbIjlc8krOSXOuLPyaW0DDVa3ATVtIUH35
        l2RyNMkgJ1eUo2A0DrKTPo6uMHLojbFB4945/xv3jk4YD3zioe1e0wLQT8gYWICDyzsQKjHK5zc
        U7uPllOjZNAJ+AiHQOh0sfn6Hsi2pPJWuDKDS+wDat4SeuOQmu3sWLor5/g==
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr6080580otj.188.1609175610633;
        Mon, 28 Dec 2020 09:13:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyxJtyk21lN8oCPqZD3h/TV0OTLqyx6QSCXYVEQKeWNXngzpE6iT2U9TeSZxLS+1UCaeSSY2VtrdMoRXv9hJUQ=
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr6080557otj.188.1609175610344;
 Mon, 28 Dec 2020 09:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20201225164727.103280-1-kai.heng.feng@canonical.com> <s5hft3tf1r2.wl-tiwai@suse.de>
In-Reply-To: <s5hft3tf1r2.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 29 Dec 2020 01:13:17 +0800
Message-ID: <CAAd53p6jYWp3NdDmfAq76rcMkj26nrkFxmLjLa75CV30otWVig@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Resume codec for system suspend if LED is
 controlled by codec
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 3:46 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 25 Dec 2020 17:47:23 +0100,
> Kai-Heng Feng wrote:
> >
> > Laptop with codec controlled LEDs takes a very long time to suspend
> > after commit 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use
> > direct-complete optimization"):
> > [   90.065964] PM: suspend entry (s2idle)
> > [   90.067337] Filesystems sync: 0.001 seconds
> > [   90.185758] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > [   90.188713] OOM killer disabled.
> > [   90.188714] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > [   90.190024] printk: Suspending console(s) (use no_console_suspend to debug)
> > [   90.904912] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C], continue to suspend
> > [  321.262505] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> > [  328.426919] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> > [  329.490933] ACPI: EC: interrupt blocked
> >
> > That commit keeps codec suspended during the system suspend. This
> > doesn't play well with codec controlled mute and micmute LEDs, because
> > LED core will use codec registers to turn off those LEDs.
> >
> > Currently, all users of create_mute_led_cdev() use codec to control
> > LED, so unconditionally runtime resume those codecs before system
> > suspend to solve the problem.
> >
> > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> A puzzling point is that it's applied only to the cases with the led
> cdev.  Or does it basically apply for the ASoC controller?
> That is, if you run with legacy HDA (snd-intel-dspcfg.dsp_driver=1),
> does the issue appear as well on those machines?

No, the issue doesn't happen with snd-intel-dspcfg.dsp_driver=1. It
only happens when SOF driver is in use.
My analysis was wrong, I will send a new patch to address the root cause.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> > ---
> >  include/sound/hda_codec.h   | 1 +
> >  sound/pci/hda/hda_codec.c   | 7 +++++++
> >  sound/pci/hda/hda_generic.c | 1 +
> >  3 files changed, 9 insertions(+)
> >
> > diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
> > index 2e8d51937acd..b01d76abe008 100644
> > --- a/include/sound/hda_codec.h
> > +++ b/include/sound/hda_codec.h
> > @@ -255,6 +255,7 @@ struct hda_codec {
> >       unsigned int relaxed_resume:1;  /* don't resume forcibly for jack */
> >       unsigned int forced_resume:1; /* forced resume for jack */
> >       unsigned int mst_no_extra_pcms:1; /* no backup PCMs for DP-MST */
> > +     unsigned int resume_for_sleep:1;  /* runtime resume for system sleep */
> >
> >  #ifdef CONFIG_PM
> >       unsigned long power_on_acct;
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 687216e74526..b890d9b4339e 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -2983,6 +2983,13 @@ static int hda_codec_runtime_resume(struct device *dev)
> >  #ifdef CONFIG_PM_SLEEP
> >  static int hda_codec_pm_prepare(struct device *dev)
> >  {
> > +     struct hda_codec *codec = dev_to_hda_codec(dev);
> > +
> > +     if (codec->resume_for_sleep) {
> > +             pm_runtime_resume(dev);
> > +             return 0;
> > +     }
> > +
> >       return pm_runtime_suspended(dev);
> >  }
> >
> > diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
> > index 8060cc86dfea..6d259d5bb5bb 100644
> > --- a/sound/pci/hda/hda_generic.c
> > +++ b/sound/pci/hda/hda_generic.c
> > @@ -3913,6 +3913,7 @@ static int create_mute_led_cdev(struct hda_codec *codec,
> >       cdev->brightness_set_blocking = callback;
> >       cdev->brightness = ledtrig_audio_get(micmute ? LED_AUDIO_MICMUTE : LED_AUDIO_MUTE);
> >       cdev->flags = LED_CORE_SUSPENDRESUME;
> > +     codec->resume_for_sleep = 1;
> >
> >       return devm_led_classdev_register(&codec->core.dev, cdev);
> >  }
> > --
> > 2.29.2
> >
