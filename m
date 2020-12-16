Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A2F2DC3BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 17:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgLPQIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 11:08:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51297 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgLPQIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 11:08:40 -0500
Received: from mail-ot1-f71.google.com ([209.85.210.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kpZLJ-00060S-MP
        for linux-kernel@vger.kernel.org; Wed, 16 Dec 2020 16:07:57 +0000
Received: by mail-ot1-f71.google.com with SMTP id q5so11200406otc.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 08:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPCF3dLDbYf8y5UYGzvfCqBCOHtihFhp16cOFRHaP1U=;
        b=ICWjt2F+n4C8qcZoldnZpOX+8/Lykstt2we/Tr1XLLv26nvkqxjt1NJo7y9WIRZ1UY
         24fzvWyf3c1gffh3dxk50ZqxKJ/kRZGqtQDtRmLdqScZD8s5wSGXjwfiFVp1/n71ykVV
         uus+1Gx/jsMSgkK+YtTJrYHX1KGuWyYbw8+QUV4J5eeXw999uaO6x63lFjBAaM67R9Oc
         94mGeGZlnXzPn2USbSmcX+MyHfGp+5sLFjHFyetFgsyhnbsruiG9wKeflHElw/fSWst0
         y6dCF08whokLP58CIuIvXJzHHDx3+5+61HOYu03HPD0T0SACZNFr0ybuzM2VBj7gzf9C
         4+iA==
X-Gm-Message-State: AOAM531mPxu+qonoGCgcaTZwE+txQ7IDRBBT5BOrViNbbXbeTq0Ft9nH
        BSFvBqJOoLa8Z+3Yz4OI9yKebZ9Fj+nyfGbZc12/ei8LMuyxtWjiMt0Fy28fdNlvupVrWH4g4AZ
        qCKFP3QvdJyubkDh+RXUcKtc244uOKExN8Xfm4JnHvPX1qBHaxq9HAfginQ==
X-Received: by 2002:a9d:ece:: with SMTP id 72mr25708107otj.358.1608134876643;
        Wed, 16 Dec 2020 08:07:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYhP6aMERTUDkaq4ZYfDI4l+IvAEAErYrDxrvbT0KAwGUMhBXxRbvR0BswTkrl1eIUAwbPsxwaUO5wiS9tmYs=
X-Received: by 2002:a9d:ece:: with SMTP id 72mr25708095otj.358.1608134876354;
 Wed, 16 Dec 2020 08:07:56 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com> <s5hzh2dn3oa.wl-tiwai@suse.de>
In-Reply-To: <s5hzh2dn3oa.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 17 Dec 2020 00:07:45 +0800
Message-ID: <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
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

On Wed, Dec 16, 2020 at 11:58 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 16 Dec 2020 16:50:20 +0100,
> Kai-Heng Feng wrote:
> >
> > On Wed, Dec 16, 2020 at 11:41 PM Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Wed, 16 Dec 2020 13:47:24 +0100,
> > > Kai-Heng Feng wrote:
> > > >
> > > > Similar to commit 9479e75fca37 ("ALSA: hda: Keep the controller
> > > > initialization even if no codecs found"), when codec probe fails, it
> > > > doesn't enable runtime suspend, and can prevent graphics card from
> > > > getting powered down:
> > > > [    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized
> > > >
> > > > $ cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status
> > > > active
> > > >
> > > > So mark there's no codec and continue probing to let runtime PM to work.
> > > >
> > > > BugLink: https://bugs.launchpad.net/bugs/1907212
> > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >
> > > Hm, but if the probe fails, doesn't it mean something really wrong?
> > > IOW, how does this situation happen?
> >
> > The HDA controller is forcely created by quirk_nvidia_hda(). So
> > probably there's really not an HDA controller.
>
> I still don't understand how non-zero codec_mask is passed.
> The non-zero codec_mask means that BIOS or whatever believes that
> HD-audio codecs are present and let HD-audio controller reporting the
> presence.  What error did you get at probing?

[    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized
Full dmesg here:
https://launchpadlibrarian.net/510351476/dmesg.log

>
>
> > > The usual no-codec state is for the devices that have a bogus HD-audio
> > > bus remaining while codecs aren't hooked or disabled by BIOS.  For
> > > that, it makes to leave the controller driver and let it idle.  But if
> > > you get really an error, it's something to fix there, not to just
> > > ignore in general.
> >
> > The best approach I can think of is to make current two steps probe
> > into one. So when probe fails, the driver won't bind to the device.
> > What's the reason behind the two steps approach?
>
> It's a sort of must, as the module loading is involved with binding
> with the codecs, as well as (optionally) request_firmware()
> invocation.

Ok. I also tried to use device_release_driver(), but azx_remove()
calls "cancel_work_sync(&hda->probe_work)" so there will be a
deadlock.

Kai-Heng

>
>
> Takashi



-- 
Kai-Heng
