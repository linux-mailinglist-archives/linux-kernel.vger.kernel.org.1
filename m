Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18212DFE19
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLUQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:34:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60040 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLUQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:34:15 -0500
Received: from mail-lf1-f70.google.com ([209.85.167.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1krO7o-0008SI-Qh
        for linux-kernel@vger.kernel.org; Mon, 21 Dec 2020 16:33:33 +0000
Received: by mail-lf1-f70.google.com with SMTP id 140so11194474lfm.23
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1DJCzPnkhqRPedetC6f30gfeqZjj9GSnRoXOKXqtenM=;
        b=iGaevfbfBdO9EBzWNPcntJMFLVDuQsE9N/Zz+Dv1/DAsNqJUFsvezU62T2J9M7uY38
         LVng268QiPcWWWk8KZGENjdRk/AqSLAWB2lLyGTEDVfKWSBmEwd0eMW3SEGY18RNZtPO
         M4m2h64zY2uQ55P5n0oXgOobXeF1ZIDMLLBLt01ssAR2Cm34GzlF3liFIB7hPheiUxF4
         h1ftzNxJZXvJG7/eXxyfGtqe3LkyGj1T+YRa1shGI9CGp/LsUL2SmzRg3/grX1rJvrnR
         o3EQngMXz4FTAehIDwodo1Nso1PB6+mUZPvuF4+nq1RC5Zfn9Yo6YKmjv2f3iffklK2d
         ikaw==
X-Gm-Message-State: AOAM530bnoqrCzi4gUv+d7BACNtNxQ47TwyTG0txp218gTlbm6kIVmms
        XZPuq6XhZ4SNS7b/M9VAufbuCiVGb6Ye6Y6EZs3OlHQe6UAvImSwgD9U62RQfAq95/Lazd8A+Bb
        tmPjvHZHQrtzoH/eNpYp5umPozB4Bbi/y5hiQfKHdlqbsDwuY/OasalCP5Q==
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr7354276lji.126.1608568411903;
        Mon, 21 Dec 2020 08:33:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtnLVxc3tdNQMXpGXmxOqiYwSpbFnGFhsFaqolhzWgqF0GoirNF1t7rUczUrKsKTQYUeDw3QVY7adO187jKOU=
X-Received: by 2002:a2e:9b8a:: with SMTP id z10mr7354267lji.126.1608568411594;
 Mon, 21 Dec 2020 08:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
 <20201216124726.2842197-1-kai.heng.feng@canonical.com> <s5h5z51oj12.wl-tiwai@suse.de>
 <CAAd53p6kORC1GsW5zt+=0=J5ki43iriO-OqtFvf5W67LWhyyhA@mail.gmail.com>
 <s5hzh2dn3oa.wl-tiwai@suse.de> <CAAd53p6Ef2zFX_t3y1c6O7BmHnxYGtGSfgzXAMQSom1ainWXzg@mail.gmail.com>
 <s5hsg85n2km.wl-tiwai@suse.de> <s5hmtydn0yg.wl-tiwai@suse.de>
 <CAAd53p6MMFh=HCNF9pyrJc9hVMZWFe7_8MvBcBHVWARqHU_TTA@mail.gmail.com> <s5h7dpfk06y.wl-tiwai@suse.de>
In-Reply-To: <s5h7dpfk06y.wl-tiwai@suse.de>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 22 Dec 2020 00:33:20 +0800
Message-ID: <CAAd53p53w0H6tsb4JgQtFTkYinniicTYBs2uk7tc=heP2dM_Cw@mail.gmail.com>
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
        Linux PCI <linux-pci@vger.kernel.org>,
        nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc nouveau]

On Fri, Dec 18, 2020 at 4:06 PM Takashi Iwai <tiwai@suse.de> wrote:
[snip]
> > Quite possibly the system doesn't power up HDA controller when there's
> > no external monitor.
> > So when it's connected to external monitor, it's still needed for HDMI audio.
> > Let me ask the user to confirm this.
>
> Yeah, it's the basic question whether the HD-audio is supposed to work
> on this machine at all.  If yes, the current approach we take makes
> less sense - instead we should rather make the HD-audio controller
> working.

Yea, confirmed that the Nvidia HDA works when HDMI is connected prior boot.

> > > - The second problem is that pci_enable_device() ignores the error
> > >   returned from pci_set_power_state() if it's -EIO.  And the
> > >   inaccessible access error returns -EIO, although it's rather a fatal
> > >   problem.  So the driver believes as the PCI device gets enabled
> > >   properly.
> >
> > This was introduced in 2005, by Alan's 11f3859b1e85 ("[PATCH] PCI: Fix
> > regression in pci_enable_device_bars") to fix UHCI controller.
> >
> > >
> > > - The third problem is that HD-audio driver blindly believes the
> > >   codec_mask read from the register even if it's a read failure as I
> > >   already showed.
> >
> > This approach has least regression risk.
>
> Yes, but it assumes that HD-audio is really non-existent.

I really don't know any good approach to address this.
On Windows, HDA PCI is "hidden" until HDMI cable is plugged, then the
driver will flag the magic bit to make HDA audio appear on the PCI
bus.
IIRC the current approach is to make nouveau and device link work.

Kai-Heng

>
>
> thanks,
>
> Takashi
