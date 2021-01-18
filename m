Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AFC2FA79B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 18:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436514AbhARRdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:33:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59129 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393606AbhARR2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:28:02 -0500
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1YJA-00033D-4p
        for linux-kernel@vger.kernel.org; Mon, 18 Jan 2021 17:27:16 +0000
Received: by mail-lf1-f69.google.com with SMTP id a10so6867383lfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y+F3xum/Kfc0s4a7NIXADFe5DKglu0DQNppY8qILCAo=;
        b=Z0oqxzQvw4nG17R54dTo2dDCmziHM+nYYOeKqDmqo/fwQPBLQwmy3QAMSrQr9PH2rV
         uNz2vRfYvwLwtmKr0UPy8VB4kajPwJZuDXjK+LM7Br4U0O0Bamqtk/l/RwIiZJJnJEIN
         d6z4OOLZNj/cnY3WS2knsorIVvmR7+FAa/aojyHbMoyyfdNYu0Ah3c1JAgEdE94a7XuU
         gUDUcAMoQgW1fnWoZGRW1xvwSMMK0eYYBTdjlL++vlSXO+a+EHlT2z7icY+B8k+w8zTH
         otafdqPOA/MOB6ZWEWG+vdbKguyL0fImpMSNor6c/zVXXbbXougfPg8aEkW4LTP3YpAq
         6a4w==
X-Gm-Message-State: AOAM531YvzFK5nr+7Hs28G050hR/TqCa8NjBebBzfKpP8NUDJHfBUzv+
        Xy7lEjMylXlXImtsyTMaiyoCFQViQWotPALFfuFCfcFQqZ591ub+Ox4CxcQETUcUUfWsQnIwcGu
        zQR7nwW/b79WL93U9bjMmRR5S6f/BYjv/dRkJzYzMOeQon1ENFdcc1KirnA==
X-Received: by 2002:ac2:561b:: with SMTP id v27mr68203lfd.425.1610990835602;
        Mon, 18 Jan 2021 09:27:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyYmaz7Mag/kez3M93Cx3y078QCv8AQVETwR/huIC1MYo4C13IX0QrWoS1GnvkepFD5e7x9Ed3noF1EGli4q+w=
X-Received: by 2002:ac2:561b:: with SMTP id v27mr68191lfd.425.1610990835325;
 Mon, 18 Jan 2021 09:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20210118130937.164650-1-kai.heng.feng@canonical.com> <s5hzh16idnj.wl-tiwai@suse.de>
In-Reply-To: <s5hzh16idnj.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Jan 2021 01:27:03 +0800
Message-ID: <CAAd53p7ipG7wnRjYmhm0P0Tm893QDfN+TjzeFkTf23CL_0220w@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Balance runtime/system PM if direct-complete
 is disabled
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Takashi Iwai <tiwai@suse.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Harsha Priya <harshapriya.n@intel.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 9:21 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 18 Jan 2021 14:09:36 +0100,
> Kai-Heng Feng wrote:
> >
> > HDA controller can't be runtime-suspended after commit 215a22ed31a1
> > ("ALSA: hda: Refactor codjc PM to use direct-complete optimization"),
> > which enables direct-complete for HDA codec.
> >
> > The HDA codec driver didn't expect direct-complete will be disabled
> > after it returns a positive value from prepare() callback. However,
> > there are some places that PM core can disable direct-complete. For
> > instance, system hibernation or when codec has subordinates like LEDs.
>
> Hmm.  This sounds rather like the approach using the direct-complete
> isn't well suited for the purpose? The increasing number of
> regression reports worries me.

Direct-complete works fine on HDA controller but so far not so on HDA codec.
I think the main reason is that the codec doesn't have the middle
layer to handle the detail, while HDA controller has PCI bus to deal
with them.

>
> > So if a device is prepared for direct-complete but PM core still calls
> > codec's suspend or freeze callback, resume the device to keep PM
> > operations balanced.
>
> I find the ping-pong of the resume/suspend there a bit odd.  It's no
> refcount management but it invokes the real resume there, which is
> involved with lots of operations.

Yes. I'll find a better approach to address this.

>
> Can we rather skip the hda_codec_suspend() call instead (while
> changing dev->power.power_state)?

Maybe we can revert the most of the commit, and just leave
hda_codec_pm_complete(), which is the most relevant part of the patch.
Let me test a bit and send a new patch. Let me know if you don't like
this approach.

A question a bit unrelated to the discussion - how does
snd_hdac_power_up_pm() work for concurrent resume?
It can work for recursive call, but what if there are concurrent
resume request, but pm_runtime_get_sync() is still running?
The second call may access the codec which hasn't completed resume.

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> > Reported-by: Kenneth R. Crudup <kenny@panix.com>
> > Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> >  sound/pci/hda/hda_codec.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
> > index 687216e74526..0afbced979df 100644
> > --- a/sound/pci/hda/hda_codec.c
> > +++ b/sound/pci/hda/hda_codec.c
> > @@ -2997,6 +2997,9 @@ static void hda_codec_pm_complete(struct device *dev)
> >
> >  static int hda_codec_pm_suspend(struct device *dev)
> >  {
> > +     if (pm_runtime_status_suspended(dev))
> > +             pm_runtime_resume(dev);
> > +
> >       dev->power.power_state = PMSG_SUSPEND;
> >       return hda_codec_suspend(dev);
> >  }
> > @@ -3009,6 +3012,9 @@ static int hda_codec_pm_resume(struct device *dev)
> >
> >  static int hda_codec_pm_freeze(struct device *dev)
> >  {
> > +     if (pm_runtime_status_suspended(dev))
> > +             pm_runtime_resume(dev);
> > +
> >       dev->power.power_state = PMSG_FREEZE;
> >       return hda_codec_suspend(dev);
> >  }
> > --
> > 2.29.2
> >
