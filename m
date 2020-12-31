Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83522E8189
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 19:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbgLaSHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 13:07:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36647 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgLaSHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 13:07:39 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kv2Lf-0004w2-TL
        for linux-kernel@vger.kernel.org; Thu, 31 Dec 2020 18:06:56 +0000
Received: by mail-lf1-f70.google.com with SMTP id m67so12244293lfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 10:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDj432l99j0xoDiBy5UNgfzTx7FTAcBiF2LYc+uCoyU=;
        b=lzjkMhxQic2ZbnKp1+S9pGFg+wuNKduZVz6uPTTS4DDUyvya3gcDUYtIn7QPT8RVyB
         Y2HiDiseH9DzxDFwdSBwAD91VlaO2RazvFyNx1lADSYGTi8dQ5I7kayvRLwZ907fDYde
         0aWBTwczWmo3PY4ZOxLebD3QxqOVI2YuHL1HVQsJbFjMe7k1x4n27074TIoFaJH+XKIq
         guYwZ/K+6krycMB+q2xsQ4gUtaE7DxrMehlh+RlmztTGwEv89O0VAqscDE006iSUaPXO
         B/Tc+2sx8blMG580uugHd+6UA9zyKscfyACPxYn2MnnAXmvMPJGB5ZQNiB9mDmuqjVjI
         L2aQ==
X-Gm-Message-State: AOAM5326+gQaGERMHjpRyybxN0QxCZBpsBClPbta/09tfAtG+v6/ktVh
        MXg1WsGpOoOwRpqnOK63aPgPcWINJ27acWABCsKxa4Wqw92nYAgpWXOyJDL9/keixRHjNjFrBwD
        vYfN15mRgz9rrjlRhXcvxYU9T/ADC2jQFnhGkQx6tRvg1Tu1voel3Bx6tsw==
X-Received: by 2002:a2e:3201:: with SMTP id y1mr28334526ljy.12.1609438015219;
        Thu, 31 Dec 2020 10:06:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyomzGuJYL0lgRaiEO2TvrE1LLBAmPBetoODYiJzvNGvAIg7FcxXQ0JLlat/oHCujvg7jfiyAP+kfmkP7JY9kY=
X-Received: by 2002:a2e:3201:: with SMTP id y1mr28334512ljy.12.1609438014965;
 Thu, 31 Dec 2020 10:06:54 -0800 (PST)
MIME-Version: 1.0
References: <20201229133817.190160-1-kai.heng.feng@canonical.com>
 <20201229133817.190160-2-kai.heng.feng@canonical.com> <s5hr1n6b5yp.wl-tiwai@suse.de>
In-Reply-To: <s5hr1n6b5yp.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 1 Jan 2021 02:06:43 +0800
Message-ID: <CAAd53p77EGZqFcMrDSNQU+TkdWMgath7+M-41hwn5WOhDpZqcg@mail.gmail.com>
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

On Thu, Dec 31, 2020 at 6:55 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 29 Dec 2020 14:38:15 +0100,
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
> > That commit keeps codec suspended during the system suspend. However,
> > SOF driver's runtime resume, which is for system suspend, calls
> > hda_codec_jack_check() and schedules jackpoll_work. The jackpoll
> > work uses snd_hda_power_up_pm() which tries to resume the codec in
> > system suspend path, hence blocking the suspend process.
> >
> > So only check jack status if it's not in system PM process.
>
> After your previous patch set, the legacy HDA does queue the
> jackpoll_work only if jackpoll_interval is set.  I suppose rather the
> same rule would be applied?

It's queued in hda_codec_pm_complete(), which happens at the end of PM process.
This one is queued in the middle of PM suspend, so it's not the same here.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> >
> > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  sound/soc/sof/intel/hda-dsp.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
> > index 7d00107cf3b2..1c5e05b88a90 100644
> > --- a/sound/soc/sof/intel/hda-dsp.c
> > +++ b/sound/soc/sof/intel/hda-dsp.c
> > @@ -685,7 +685,8 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
> >       /* check jack status */
> >       if (runtime_resume) {
> >               hda_codec_jack_wake_enable(sdev, false);
> > -             hda_codec_jack_check(sdev);
> > +             if (sdev->system_suspend_target == SOF_SUSPEND_NONE)
> > +                     hda_codec_jack_check(sdev);
> >       }
> >
> >       /* turn off the links that were off before suspend */
> > --
> > 2.29.2
> >
