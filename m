Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F96B2E9194
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 09:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbhADIQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 03:16:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36933 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbhADIQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:16:25 -0500
Received: from mail-oi1-f199.google.com ([209.85.167.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kwL1i-0001HS-5y
        for linux-kernel@vger.kernel.org; Mon, 04 Jan 2021 08:15:42 +0000
Received: by mail-oi1-f199.google.com with SMTP id j203so20567081oif.22
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 00:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R6nqnTM+ujmxlgjwGvBpR5yONq8+2Nvfgjpa+0ulriU=;
        b=NU6mnwTW05s4ms11dvGDj+eizFp7f1ZJSN40kpoFA8B7j3yK8djI4fScafcO6GiK5P
         3ESgFvDHBQ6unwu4o1rU4ADL2U0hXhswwKTr0pwnhCbH7Gcj8IxpxLlromQHB0cjOp5I
         yI9MO5S0vDgMzoK6iuVDuYuN+MqdJua2nbo8KOTlm1xtrCV6M/xwpnsL74g3HHd8fjjl
         nPZspC42pNMTNErA7FPtwtj80lTax0/aeoc+CzNHS/XvQbwCAwr3fQa5dTJkGKoy7Xaf
         BvtnO4zPv/sSO81ThuAjiviRd9WmRGVUaOaF/gqoNIBTYMs+ctHIx5GWm8vpQRNEZMMH
         x3vw==
X-Gm-Message-State: AOAM5317Mh8SJNjCSWq1T/XW25EiwBgY0pgW+cahwz9T8b7DfMcmOiT1
        7X+hGHbJ7m76jAMMRqWhrGkJxHNU5Z9W0N054kzFbSGihggob5jeCDypblIeGUwE58lsHLzOfSb
        lj+5H0gnCj7Z43XBfYu5M+U5PdyEVALy+hrx1Wy0gqeZr7KmQoHmJhhfrnA==
X-Received: by 2002:a9d:4816:: with SMTP id c22mr49517980otf.358.1609748141084;
        Mon, 04 Jan 2021 00:15:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznzVsJM7hEPKoepjCa/BnR/MmTOPrGUy7hOexPPjjxu4Y5y8KLmh34CeekI7i0+XEYbZ1hm8LQ1uU5cX5sTpE=
X-Received: by 2002:a9d:4816:: with SMTP id c22mr49517972otf.358.1609748140795;
 Mon, 04 Jan 2021 00:15:40 -0800 (PST)
MIME-Version: 1.0
References: <20201229133817.190160-1-kai.heng.feng@canonical.com>
 <20201229133817.190160-2-kai.heng.feng@canonical.com> <s5hr1n6b5yp.wl-tiwai@suse.de>
 <CAAd53p77EGZqFcMrDSNQU+TkdWMgath7+M-41hwn5WOhDpZqcg@mail.gmail.com> <s5ha6ttaxmy.wl-tiwai@suse.de>
In-Reply-To: <s5ha6ttaxmy.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 4 Jan 2021 16:15:28 +0800
Message-ID: <CAAd53p5d2jOEo=udVB58FjcTGJHGHs7ovH0B-gjwuas-L6Y4rQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: SOF: Intel: hda: Avoid checking jack on system suspend
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        daniel.baluta@nxp.com, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 1, 2021 at 4:07 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Thu, 31 Dec 2020 19:06:43 +0100,
> Kai-Heng Feng wrote:
> >
> > On Thu, Dec 31, 2020 at 6:55 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Tue, 29 Dec 2020 14:38:15 +0100,
> > > Kai-Heng Feng wrote:
> > > >
> > > > System takes a very long time to suspend after commit 215a22ed31a1
> > > > ("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
> > > > [   90.065964] PM: suspend entry (s2idle)
> > > > [   90.067337] Filesystems sync: 0.001 seconds
> > > > [   90.185758] Freezing user space processes ... (elapsed 0.002 seconds) done.
> > > > [   90.188713] OOM killer disabled.
> > > > [   90.188714] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > > > [   90.190024] printk: Suspending console(s) (use no_console_suspend to debug)
> > > > [   90.904912] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C], continue to suspend
> > > > [  321.262505] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> > > > [  328.426919] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
> > > > [  329.490933] ACPI: EC: interrupt blocked
> > > >
> > > > That commit keeps codec suspended during the system suspend. However,
> > > > SOF driver's runtime resume, which is for system suspend, calls
> > > > hda_codec_jack_check() and schedules jackpoll_work. The jackpoll
> > > > work uses snd_hda_power_up_pm() which tries to resume the codec in
> > > > system suspend path, hence blocking the suspend process.
> > > >
> > > > So only check jack status if it's not in system PM process.
> > >
> > > After your previous patch set, the legacy HDA does queue the
> > > jackpoll_work only if jackpoll_interval is set.  I suppose rather the
> > > same rule would be applied?
> >
> > It's queued in hda_codec_pm_complete(), which happens at the end of PM process.
> > This one is queued in the middle of PM suspend, so it's not the same here.
>
> But why do we need the jack status check explicitly there if
> hda_codec_pm_complete() already does it (via re-queuing the resume)?

Because hda_resume() is called for both system and runtime resume, but
hda_codec_pm_complete() only gets called for system resume. So we
still need to cover the runtime resume case.

However, we can use pm_request_resume() to wakeup the codec and do the
jack detection, instead of queueing jackpoll_work directly. I'll do
the change in v2.

Kai-Heng

>
> thanks,
>
> Takashi
>
> >
> > Kai-Heng
> >
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > >
> > > >
> > > > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > ---
> > > >  sound/soc/sof/intel/hda-dsp.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
> > > > index 7d00107cf3b2..1c5e05b88a90 100644
> > > > --- a/sound/soc/sof/intel/hda-dsp.c
> > > > +++ b/sound/soc/sof/intel/hda-dsp.c
> > > > @@ -685,7 +685,8 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
> > > >       /* check jack status */
> > > >       if (runtime_resume) {
> > > >               hda_codec_jack_wake_enable(sdev, false);
> > > > -             hda_codec_jack_check(sdev);
> > > > +             if (sdev->system_suspend_target == SOF_SUSPEND_NONE)
> > > > +                     hda_codec_jack_check(sdev);
> > > >       }
> > > >
> > > >       /* turn off the links that were off before suspend */
> > > > --
> > > > 2.29.2
> > > >
> >
