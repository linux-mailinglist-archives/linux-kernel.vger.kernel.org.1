Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4072F3777
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389851AbhALRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:45:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35849 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728583AbhALRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:45:45 -0500
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kzNj4-0003Uq-US
        for linux-kernel@vger.kernel.org; Tue, 12 Jan 2021 17:45:03 +0000
Received: by mail-lf1-f72.google.com with SMTP id v187so1334499lfa.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suRULWjvyvwLLkjv322Q9lcXNMqjmrzWw3W6X82LJRo=;
        b=emcH3j23gF57ea/e7axX+tX+5UQN0WgypXrc6oRftY5iNhPRw7WnIIxohI6NsoLuDF
         0xtXDsOFvFOdrqHvm6OedBEisnnhWBIXPsv0QnaqkyHvU+JDVxeMUBhVI1/A/Y1PZSxi
         eP6Hmy5oBi3aaY4ApRK92TH6P4YNV+5WWc6yjSvqEkXXEwa5uu7BGY1OYUHwwyGuVzAr
         QLOjQberANJrc3i+cvbwEwYheydSGp+em440ijNQrt3d117Z9y3RHhT/c/BlP+i/uFk+
         CS9CXxyQxEa0Tjm72QCvagHghQm7VmjRLF7KLZ3SWCXLjBB76+qcjxUa9jHUZl6ayHLy
         dU5A==
X-Gm-Message-State: AOAM5320/Fxm5aide39PelDKt3TR/ebsPifaul19eiGq+axbyPLGpTMf
        9Eys3RYyraUaDx1pAZjNAlT8fRXWGDxQNZIO0dCbP7UMC1CRyEkx71SFqTeVd0qaNvp8xHHBUGg
        iHWX0kSYxICrNVbUQUt/GCuTbu9/TELVJvG3sYP7o6A3YOIl24G+39ZT7uw==
X-Received: by 2002:a19:8316:: with SMTP id f22mr45489lfd.10.1610473502105;
        Tue, 12 Jan 2021 09:45:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3ezkhzyKn1TJn7lwMcaTCjEJDk2t2c2uIeLsEIyN5rMwG+2TmQPqTbNWq4exLlRzBD4IBFPl8ruBo/890cqA=
X-Received: by 2002:a19:8316:: with SMTP id f22mr45468lfd.10.1610473501732;
 Tue, 12 Jan 2021 09:45:01 -0800 (PST)
MIME-Version: 1.0
References: <20210112130704.1201406-1-kai.heng.feng@canonical.com> <s5h1reqs3av.wl-tiwai@suse.de>
In-Reply-To: <s5h1reqs3av.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 13 Jan 2021 01:44:48 +0800
Message-ID: <CAAd53p4O8ut-qKzB-qWFobXcAeWpVdHhdczLBu+aWsV=SyPCDA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] ALSA: hda/realtek: Power up codec when setting LED
 via COEF and GPIO
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:17 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 12 Jan 2021 14:06:59 +0100,
> Kai-Heng Feng wrote:
> >
> > System takes a very long time to suspend after commit 215a22ed31a1
> > ("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
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
> > That commit keeps the codec suspended during the system suspend. However,
> > led_suspend() for mute and micmute led writes codec register, triggers
> > a pending wake up. The wakeup is then handled in __device_suspend() by
> > the following:
> > - pm_runtime_disable() to handle the wakeup event.
> > - device is no longer is suspended state, direct-complete isn't taken.
> > - pm_runtime_enable() to balance disable_depth.
> >
> > if (dev->power.direct_complete) {
> >       if (pm_runtime_status_suspended(dev)) {
> >               pm_runtime_disable(dev);
> >               if (pm_runtime_status_suspended(dev)) {
> >                       pm_dev_dbg(dev, state, "direct-complete ");
> >                       goto Complete;
> >               }
> >
> >               pm_runtime_enable(dev);
> >       }
> >       dev->power.direct_complete = false;
> > }
> >
> > Since direct-complete doens't apply anymore, the codec's system suspend
> > routine is used.
> >
> > This doesn't play well with SOF driver. When its runtime resume is
> > called for system suspend, hda_codec_jack_check() schedules
> > jackpoll_work which uses snd_hdac_is_power_on() to check whether codec
> > is suspended. Because of the previous pm_runtime_enable(),
> > snd_hdac_is_power_on() returns false and jackpoll continues to run, and
> > snd_hda_power_up_pm() cannot power up an already suspended codec in
> > multiple attempts, causes the long delay on system suspend.
> >
> > When direct-complete path is taken, snd_hdac_is_power_on() returns true
> > and hda_jackpoll_work() is skipped by accident. This is still not
> > correct, and it will be addressed by later patch.
> >
> > Explicitly runtime resume codec on setting LED to solve the issue.
> >
> > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
>
> Hmm, I really don't get this.
>
> alc_update_gpio_data() calls snd_hda_codec_write() in the end, and
> this function goes over bus->exec_verb call.  And for the legacy HDA
> codec, it's codec_exec_verb in hda_codec.c, which has already
> snd_hda_power_up_pm().
>
> What's the missing piece?

Thanks for pointing this out!

The missing piece here is that the issue only happens when both mute
and micmute LED are off, so alc_update_gpio_data() doesn't do anything
to turn the LED off during suspend.
If LED is on, turning off LED will indeed resume the codec and the
issue doesn't happen.
So this patch is unnecessary. Will send v4.

Kai-Heng


>
>
>
> thanks,
>
> Takashi
>
> > ---
> > v3:
> >  New patch.
> >
> >  sound/pci/hda/patch_realtek.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index 3c1d2a3fb1a4..304a7bc89fcd 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -4164,7 +4164,10 @@ static void alc_update_gpio_led(struct hda_codec *codec, unsigned int mask,
> >  {
> >       if (polarity)
> >               enabled = !enabled;
> > +     /* temporarily power up/down for setting GPIO */
> > +     snd_hda_power_up_pm(codec);
> >       alc_update_gpio_data(codec, mask, !enabled); /* muted -> LED on */
> > +     snd_hda_power_down_pm(codec);
> >  }
> >
> >  /* turn on/off mute LED via GPIO per vmaster hook */
> > @@ -4287,8 +4290,10 @@ static void alc_update_coef_led(struct hda_codec *codec,
> >       if (polarity)
> >               on = !on;
> >       /* temporarily power up/down for setting COEF bit */
> > +     snd_hda_power_up_pm(codec);
> >       alc_update_coef_idx(codec, led->idx, led->mask,
> >                           on ? led->on : led->off);
> > +     snd_hda_power_down_pm(codec);
> >  }
> >
> >  /* update mute-LED according to the speaker mute state via COEF bit */
> > --
> > 2.29.2
> >
