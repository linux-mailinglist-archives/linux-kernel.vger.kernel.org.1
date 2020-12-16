Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50562DC36D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgLPPvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:51:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50798 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgLPPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:51:16 -0500
Received: from mail-oi1-f200.google.com ([209.85.167.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kpZ4U-0004vA-BJ
        for linux-kernel@vger.kernel.org; Wed, 16 Dec 2020 15:50:34 +0000
Received: by mail-oi1-f200.google.com with SMTP id m65so12475662oib.19
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 07:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UDu4fCku1n4Yn+GSCPwGXPBk9ghy9F+fH/bPZYikwFM=;
        b=cbnFf5t4XgMIsb0Y5g0S39XjhNmHJ0RLJpVR+K85fTLsCl62h3venOnrGaqVeanWwG
         U9Q3payyOdG2VZ0iiL+8YgA6q/EnTQcGaloLsmrl0m6Q8Dqx6RtPPEp+HcTON3w6ujSx
         Ywvjov9jzHXMXY1yAhAansElTO3yXh/ZKJcgqbmJhcy6werat3mr+sJDy8n+Wk257krS
         mFV83WhnMo3UGyFThyvTLGC0F2H2T6L/XR74E9B9JViWIOLXktetg43HxEGQ9Yvoamgm
         YpUL5BMJhBC6PBdbzUa8tdSVKrWNuOCVFj8fH/wXjV9ANv+FUsVmfYfDKjc5lBi7DKAi
         7YPA==
X-Gm-Message-State: AOAM531c97HdUZ9OklVs53sHTK3ZvFluI4Y3YWNlaEHRHpP3frEf/f0E
        Sgktxf7CSyfG3MnFPQSvcNdrvGRs5Efeg/NbZb3i0v+zMc/OE4Z7VS2rzkAHMetlLpRn/1BTjDt
        dN7GGq8AzPOW16feKeSi8EB7Mgchwf0j3o9eq47a15738A7KxEkaklwsudQ==
X-Received: by 2002:aca:ccc1:: with SMTP id c184mr2370074oig.121.1608133833280;
        Wed, 16 Dec 2020 07:50:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9u6/rdkGACUL71kk8r218k44q33lvl1DdzcqZEhpTlQ6LOkUUe5DktifQtuIFFfmCGbSthMgBQPLRJPHBP3k=
X-Received: by 2002:aca:ccc1:: with SMTP id c184mr2370051oig.121.1608133832928;
 Wed, 16 Dec 2020 07:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
In-Reply-To: <s5h5z51oj12.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 16 Dec 2020 23:50:20 +0800
Message-ID: <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda: Continue to probe when codec probe fails
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 11:41 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 16 Dec 2020 13:47:24 +0100,
> Kai-Heng Feng wrote:
> >
> > Similar to commit 9479e75fca37 ("ALSA: hda: Keep the controller
> > initialization even if no codecs found"), when codec probe fails, it
> > doesn't enable runtime suspend, and can prevent graphics card from
> > getting powered down:
> > [    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized
> >
> > $ cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status
> > active
> >
> > So mark there's no codec and continue probing to let runtime PM to work.
> >
> > BugLink: https://bugs.launchpad.net/bugs/1907212
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>
> Hm, but if the probe fails, doesn't it mean something really wrong?
> IOW, how does this situation happen?

The HDA controller is forcely created by quirk_nvidia_hda(). So
probably there's really not an HDA controller.

>
> The usual no-codec state is for the devices that have a bogus HD-audio
> bus remaining while codecs aren't hooked or disabled by BIOS.  For
> that, it makes to leave the controller driver and let it idle.  But if
> you get really an error, it's something to fix there, not to just
> ignore in general.

The best approach I can think of is to make current two steps probe
into one. So when probe fails, the driver won't bind to the device.
What's the reason behind the two steps approach?

Kai-Heng

>
>
> thanks,
>
> Takashi
>
> > ---
> >  sound/pci/hda/hda_intel.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 6852668f1bcb..872a703dee43 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -2328,7 +2328,7 @@ static int azx_probe_continue(struct azx *chip)
> >       if (bus->codec_mask) {
> >               err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
> >               if (err < 0)
> > -                     goto out_free;
> > +                     bus->codec_mask = 0;
> >       }
> >
> >  #ifdef CONFIG_SND_HDA_PATCH_LOADER
> > --
> > 2.29.2
> >
