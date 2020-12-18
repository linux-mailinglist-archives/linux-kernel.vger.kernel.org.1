Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57AC2DDDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 06:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgLRFKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 00:10:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49221 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgLRFKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 00:10:33 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kq81W-00062c-N0
        for linux-kernel@vger.kernel.org; Fri, 18 Dec 2020 05:09:50 +0000
Received: by mail-lf1-f71.google.com with SMTP id a10so667146lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 21:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pY1xZSc1oftgiAUqf+iKoHq/WX75Jh9PZIkO1oo2OtQ=;
        b=GF/PErUHh4snZXgahjC8diQ8g7lciXJWtvoZ87B8nvU/6ub66Fp450JrTcQH1Bm4o5
         XuPIjEGB5mGfCMObpCM7LzX2rBamP0pJo0PnGEomLyGa0iTNHSAPSnLTBpCRDoUXdC9p
         lPvktgh+FzC7qzfH9X5WCDpZyD5j22Vj7R5cPGEEOG2p4bMywFkz+ZrMLl3siW2+ZToL
         WQIgWmwPXpnfB1/SZc1ZoerYZW1Bn8xy0sQTwoDl6yIDkEh83F7l3DPZ7zdPFxkUPMds
         BmCD5MsLlFWTkfkeUWKlATsskyIEN4R1beEge+BH5oRSmmdIBbkCRcdLGEQQvDEHgxN3
         dPMg==
X-Gm-Message-State: AOAM531br5jXNRCrh+tloosgUFPQV3n2S2wt45Yb/iqcDuRBBN3fpBRe
        6QSdateBsut59+8yLJFKEMQIJo4wGoPTxwVoFlfS9mG5SKM+r+xq5rOL4T1iSnOuU7sKnooeQU0
        6h2YYRt4eSrgH2+fU7LBD/5qBx83+yDDPFInSxNt9NHoxd3KtwqIb07cAaA==
X-Received: by 2002:a19:4084:: with SMTP id n126mr877942lfa.290.1608268189967;
        Thu, 17 Dec 2020 21:09:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP3dO0JnfLiAYXjB2txwEFjyq/84nQyU+fpWUn+fNYlCjFHBrR+Zr6WJO5yXO9fJSPn5lwEE1gLGICFRds1+M=
X-Received: by 2002:a19:4084:: with SMTP id n126mr877924lfa.290.1608268189671;
 Thu, 17 Dec 2020 21:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de> <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
In-Reply-To: <s5hmtydn0yg.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 18 Dec 2020 13:09:38 +0800
Message-ID: <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
Subject: Re: [PATCH v2] ALSA: hda: Continue to probe when codec probe fails
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Bjorn, Alan and linux-pci]

On Thu, Dec 17, 2020 at 12:57 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 16 Dec 2020 17:22:17 +0100,
> Takashi Iwai wrote:
> >
> > On Wed, 16 Dec 2020 17:07:45 +0100,
> > Kai-Heng Feng wrote:
> > >
> > > On Wed, Dec 16, 2020 at 11:58 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Wed, 16 Dec 2020 16:50:20 +0100,
> > > > Kai-Heng Feng wrote:
> > > > >
> > > > > On Wed, Dec 16, 2020 at 11:41 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > >
> > > > > > On Wed, 16 Dec 2020 13:47:24 +0100,
> > > > > > Kai-Heng Feng wrote:
> > > > > > >
> > > > > > > Similar to commit 9479e75fca37 ("ALSA: hda: Keep the controller
> > > > > > > initialization even if no codecs found"), when codec probe fails, it
> > > > > > > doesn't enable runtime suspend, and can prevent graphics card from
> > > > > > > getting powered down:
> > > > > > > [    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized
> > > > > > >
> > > > > > > $ cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status
> > > > > > > active
> > > > > > >
> > > > > > > So mark there's no codec and continue probing to let runtime PM to work.
> > > > > > >
> > > > > > > BugLink: https://bugs.launchpad.net/bugs/1907212
> > > > > > > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > > >
> > > > > > Hm, but if the probe fails, doesn't it mean something really wrong?
> > > > > > IOW, how does this situation happen?
> > > > >
> > > > > The HDA controller is forcely created by quirk_nvidia_hda(). So
> > > > > probably there's really not an HDA controller.
> > > >
> > > > I still don't understand how non-zero codec_mask is passed.
> > > > The non-zero codec_mask means that BIOS or whatever believes that
> > > > HD-audio codecs are present and let HD-audio controller reporting the
> > > > presence.  What error did you get at probing?
> > >
> > > [    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized
> > > Full dmesg here:
> > > https://launchpadlibrarian.net/510351476/dmesg.log
> >
> > The actual problems are shown before that line.
> >
> > [    4.178848] pci 0000:01:00.1: can't change power state from D3cold to D0 (config space inaccessible)
> > [    4.179502] snd_hda_intel 0000:01:00.1: can't change power state from D3cold to D0 (config space inaccessible)
> > [    4.179511] snd_hda_intel 0000:01:00.1: can't change power state from D3hot to D0 (config space inaccessible)
> > ....
> > [    4.280571] hdaudio hdaudioC1D0: no AFG or MFG node found
> > [    4.280633] hdaudio hdaudioC1D1: no AFG or MFG node found
> > [    4.280685] hdaudio hdaudioC1D2: no AFG or MFG node found
> > [    4.280736] hdaudio hdaudioC1D3: no AFG or MFG node found
> > [    4.280788] hdaudio hdaudioC1D4: no AFG or MFG node found
> > [    4.280839] hdaudio hdaudioC1D5: no AFG or MFG node found
> > [    4.280892] hdaudio hdaudioC1D6: no AFG or MFG node found
> > [    4.280943] hdaudio hdaudioC1D7: no AFG or MFG node found
> >
> > Could you check the codec_mask value read in
> > sound/hda/hdac_controller.c?  I guess it reads 0xff.
> >
> > If that's the case, it can be corrected by the patch below.
> > But, we should check the cause of the first error (inaccessible config
> > space) in anyway; this must be the primary reason of the whole chain
> > of errors.
>
> Now I took a deeper look at the code.  So we hit errors after errors:
> - The first problem is that quirk_nvidia_hda() enabled HD-audio even
>   if it's non-functional by some reason.  We may need additional
>   checks there.

Quite possibly the system doesn't power up HDA controller when there's
no external monitor.
So when it's connected to external monitor, it's still needed for HDMI audio.
Let me ask the user to confirm this.

>
> - The second problem is that pci_enable_device() ignores the error
>   returned from pci_set_power_state() if it's -EIO.  And the
>   inaccessible access error returns -EIO, although it's rather a fatal
>   problem.  So the driver believes as the PCI device gets enabled
>   properly.

This was introduced in 2005, by Alan's 11f3859b1e85 ("[PATCH] PCI: Fix
regression in pci_enable_device_bars") to fix UHCI controller.

>
> - The third problem is that HD-audio driver blindly believes the
>   codec_mask read from the register even if it's a read failure as I
>   already showed.

This approach has least regression risk.

Kai-Heng

> Ideally we should address in the first place.
>
>
> Takashi
