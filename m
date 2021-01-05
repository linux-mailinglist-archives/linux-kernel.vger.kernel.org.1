Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C402EB353
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbhAETHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730715AbhAETHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:07:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B64922D6E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609873595;
        bh=em6Wcd1cNVrSFksfZmMQXKnok9oFteFLPjfrYs8yeRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kWmRnAD042BgHpVn0UDLqMMXyhf3D/feTxZzBROYUZzuLNmPlc5C3MEJkC06EK1Na
         oVWVL6tAuI01REcblwYQHQlOQ6R3b5IVL1oaCJxOOtHpadlrLeCSiEqoYupQf6gtkm
         oDFuAGkGW9+BKNAMObfOkJCBNm9xp26CqNsO7/6fpOwrQpUadBEEWVdQRAh9eysZzT
         wr1xr6ZEDOtA69UET+PFa7pBOPkCvUth49tVXxfAd9kMQ9fRjapfpuOMBvJuiL2PJ+
         Y8Nm3nCDzXPz8BlWoy5xwJqmC0yNFZLggs348FYbSjOPiAy3uYi7jfe41rzuy2rSgi
         5llMH51E3GsNg==
Received: by mail-oo1-f54.google.com with SMTP id s19so201981oos.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:06:35 -0800 (PST)
X-Gm-Message-State: AOAM531K13I/TqeekV+rjK3FXUGPNRvx/LTwrqL8vXV5CJt6GmwELNgK
        egNSLD1h6Z7xzXeNiATJ85TRaUAXahYridjHJ2Q=
X-Google-Smtp-Source: ABdhPJwdyOnq1x7GkNeY2G3v5lintDrKvasGwW+XQKgeTPdvPxUp1SMnwbI5EcXy6vPdDIvPP23owpLVUunPQyJ2dKg=
X-Received: by 2002:a4a:9c01:: with SMTP id y1mr367592ooj.15.1609873594701;
 Tue, 05 Jan 2021 11:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20210103135257.3611821-1-arnd@kernel.org> <3c19a5d5-8883-f917-a96a-f51bb188d115@perex.cz>
 <s5hble491zu.wl-tiwai@suse.de> <CAK8P3a1FZSfzu3TA6VMhqP+3H5OD3+BhH5W=vVYEkL+ExHqpMQ@mail.gmail.com>
 <alpine.DEB.2.22.394.2101051631320.864696@eliteleevi.tm.intel.com>
In-Reply-To: <alpine.DEB.2.22.394.2101051631320.864696@eliteleevi.tm.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 20:06:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0PXXHXLK36SB_4eia6z0u3nbBPanATwZEhposKOScqcw@mail.gmail.com>
Message-ID: <CAK8P3a0PXXHXLK36SB_4eia6z0u3nbBPanATwZEhposKOScqcw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
To:     Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 4:39 PM Kai Vehmanen
<kai.vehmanen@linux.intel.com> wrote:

> > Could it be part of the device specific driver_data?
>
> This would certainly be a clean way and allow to remove the Intel-specific
> calls from sof_pci_probe(). As a short-term solution, IS_REACHABLE()
> seems ok as well.

I looked at it some more and my conclusion is that the problem is
the way the drivers mix device specific and generic data: The generic
acpi or pci driver should never need to know about individual devices
and their dependencies. Instead of just exporting some generic
helper functions, these are the top-level drivers and the device
specific drivers are the ones exporting the data.

It's a common mistake,  but it always leads to complexity like this
and we tend to end up having to undo it all.

I prototyped a patch to do this for the acpi driver, and it seems
much more straightforward this way, please have a look.

commit a83ecfed5b31dfc862e04c9bf77d2107a1047c9b
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Jan 5 19:47:35 2021 +0100

    ASoC: SOF: Intel: avoid reverse module dependency

    The SOF-ACPI driver is backwards from the normal Linux model, it has a
    generic driver that knows about all the specific drivers, as opposed to
    having hardware specific drivers that link against a common framework.

    This requires ugly Kconfig magic and leads to missed dependencies as
    seen in this link error:

    arm-linux-gnueabi-ld: sound/soc/sof/sof-pci-dev.o: in function
`sof_acpi_probe':
    sof-pci-dev.c:(.text+0x1c): undefined reference to
`snd_intel_dsp_driver_probe'

    Change it to use the normal probe order of starting with a specific
    device in a driver, turning the sof-acpi-dev.c driver into a library.

    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 sound/soc/sof/intel/Kconfig  |  34 +++---------
 sound/soc/sof/intel/bdw.c    |  51 ++++++++++++++++--
 sound/soc/sof/intel/byt.c    | 104 ++++++++++++++++++++++++++++++++----
 sound/soc/sof/intel/shim.h   |  10 ++--
 sound/soc/sof/sof-acpi-dev.c | 122 ++-----------------------------------------
 5 files changed, 156 insertions(+), 165 deletions(-)

The PCI driver is left as an exercise to the reader.

      Arnd
