Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AA2E0483
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 03:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725902AbgLVCus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 21:50:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41900 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLVCur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:50:47 -0500
Received: from mail-lf1-f71.google.com ([209.85.167.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krXkT-0003Aq-Be
        for linux-kernel@vger.kernel.org; Tue, 22 Dec 2020 02:50:05 +0000
Received: by mail-lf1-f71.google.com with SMTP id t194so14124934lff.15
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 18:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2WMaOhgXeDwILxq6jfp+AN/tR6hFKnoPSJxCRZJRSk=;
        b=nvrK+nmrhafjyKi0x1SO2ahsQIaic/S3BBxnc9C4nFBDF6JNoYsjUxSxsCarQ1+C+a
         6mjWndxBI5VjnrtMcpty4Rg+PYx8BvGxTMZaTZAPQuJtlYJLpLkioR+XnYaQnfFQqvbI
         Ei1z7C+RpdT+fOPNrjb72yLdx/vPPuQAgQWcuYj8z576rkux1TUUK850wOjjUdEDagDR
         0BEYjek8vUT4hsfvigRckigLl0nhRjxrRrzmv5C16x3B+W+K+bGdrr2/cYMs9UEORujs
         y5FndjgkWa/FI0I4no91O6R8haOOTFgqyh0Yfqma1OTvCoNh64dWLT9gxc2U4BjGxg1n
         TQtA==
X-Gm-Message-State: AOAM531RByJ49kDrDHce8qQDy/JtyVIiomPo9s4W1qPZzGEdPxs1sy8U
        DsektCe7OQCFsQ5M87ohMnL6gOYT88U3m+2dTgBdos9wnHwS50rkG45Q8FzHsbR9anWBJBprPhy
        vPb6n2WQT0S4MFVL25pYGXMoQG7+W1K1F6jKoF7RyBW6bGsWwornk7H84BQ==
X-Received: by 2002:a19:dc5:: with SMTP id 188mr8244388lfn.513.1608605404813;
        Mon, 21 Dec 2020 18:50:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2RV37UUec/PcA87XKutLKbjDR6qoXQSMlpRpU1eKlPPw5UWb60W7kMgtYOQIg5DFid2leHa/hfFsclEh336A=
X-Received: by 2002:a19:dc5:: with SMTP id 188mr8244369lfn.513.1608605404522;
 Mon, 21 Dec 2020 18:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de> <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com>
 <s5h7dpfk06y.wl-tiwai@suse.de> <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
 <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
In-Reply-To: <CAKb7UvjWX7xbwMKtnad5EVy16nY1M-A13YJeRWyUwHzemcVswA@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 22 Dec 2020 10:49:53 +0800
Message-ID: <CAAd53p4=bSX26QzsPyV1sxADiuVn2sowWyb5JFDoPZQ+ZYoCzA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v2] ALSA: hda: Continue to probe when codec
 probe fails
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Takashi Iwai <tiwai@suse.de>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        tiwai@suse.com, Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 1:56 AM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Mon, Dec 21, 2020 at 11:33 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > [+Cc nouveau]
> >
> > On Fri, Dec 18, 2020 at 4:06 PM Takashi Iwai <tiwai@suse.de> wrote:
> > [snip]
> > > > Quite possibly the system doesn't power up HDA controller when there's
> > > > no external monitor.
> > > > So when it's connected to external monitor, it's still needed for HDMI audio.
> > > > Let me ask the user to confirm this.
> > >
> > > Yeah, it's the basic question whether the HD-audio is supposed to work
> > > on this machine at all.  If yes, the current approach we take makes
> > > less sense - instead we should rather make the HD-audio controller
> > > working.
> >
> > Yea, confirmed that the Nvidia HDA works when HDMI is connected prior boot.
> >
> > > > > - The second problem is that pci_enable_device() ignores the error
> > > > >   returned from pci_set_power_state() if it's -EIO.  And the
> > > > >   inaccessible access error returns -EIO, although it's rather a fatal
> > > > >   problem.  So the driver believes as the PCI device gets enabled
> > > > >   properly.
> > > >
> > > > This was introduced in 2005, by Alan's 11f3859b1e85 ("[PATCH] PCI: Fix
> > > > regression in pci_enable_device_bars") to fix UHCI controller.
> > > >
> > > > >
> > > > > - The third problem is that HD-audio driver blindly believes the
> > > > >   codec_mask read from the register even if it's a read failure as I
> > > > >   already showed.
> > > >
> > > > This approach has least regression risk.
> > >
> > > Yes, but it assumes that HD-audio is really non-existent.
> >
> > I really don't know any good approach to address this.
> > On Windows, HDA PCI is "hidden" until HDMI cable is plugged, then the
> > driver will flag the magic bit to make HDA audio appear on the PCI
> > bus.
> > IIRC the current approach is to make nouveau and device link work.
>
> I don't have the full context of this discussion, but the kernel
> force-enables the HDA subfunction nowadays, irrespective of nouveau or
> nvidia or whatever:

That's the problem.

The nvidia HDA controller on the affected system only gets its power
after HDMI cable plugged, so the probe on boot fails.

Kai-Heng

>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/quirks.c?h=v5.10#n5267
>
> Cheers,
>
>   -ilia
