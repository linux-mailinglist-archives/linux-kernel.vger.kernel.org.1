Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C4A2F3FD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394715AbhALWhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:60852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbhALWhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:37:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3FCC23135
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610490992;
        bh=J7QjE17AqjvLbO+CmL4RXKquFskuE4WPyKHGjh/GR24=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SBIoRO8d20IodXaunRyz4gn2Dxrm6UG06lAmRWV+tUrcIu9hmoPj4tnv3QVrkEC2s
         IV8l/vucqrbh4lMDkPa/bUCT+ylCbm09ZBVTtVNiYSjBhZaqbs9wqPorwi6GyLPKYl
         HMltuwO6HjQiUMpX/MO0pqVO7+hUaElnCLsf0UqQHiOF1XDmzfmcPhf35SoMXaZM41
         DarDJDcu8U1ypMErKQktsclHm6ewPZct1w8K8uHORgU0ZYn8EbTqskxIPG4cZf2cAg
         Y+utnJ9BMBNv3VTGeyzz1C9oSXqe5BHJMqTxnla4MUUPS/dZzohSgWAt77D5eNh7Lg
         jlpuC1KmNZLLw==
Received: by mail-oi1-f175.google.com with SMTP id p5so45532oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:36:32 -0800 (PST)
X-Gm-Message-State: AOAM530ZTM1f3diFc1FQuGpf6LSPghVsC77PatRFYeTxTO+swsleVN7U
        PYYwzv/rHWZicejVL1Thpi+uk27HlS5t60skOWU=
X-Google-Smtp-Source: ABdhPJyeEnuE9UYAY27XsYeaPsmwUePzkTqE4uAODRytnOoCWCRDeZPL5gxUWRj+3mYi22jOIXZCO7NimdvtkCBQ3WA=
X-Received: by 2002:aca:e103:: with SMTP id y3mr814199oig.11.1610490992060;
 Tue, 12 Jan 2021 14:36:32 -0800 (PST)
MIME-Version: 1.0
References: <20210112203250.2576775-1-arnd@kernel.org> <20210112203250.2576775-2-arnd@kernel.org>
 <cde511d6-fa14-0cab-f00c-f75ad2d8281c@linux.intel.com>
In-Reply-To: <cde511d6-fa14-0cab-f00c-f75ad2d8281c@linux.intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 12 Jan 2021 23:36:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3rOG8eCNQbk01-_t7RtyJknWbo-9tKo3959KhU5tcXsg@mail.gmail.com>
Message-ID: <CAK8P3a3rOG8eCNQbk01-_t7RtyJknWbo-9tKo3959KhU5tcXsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: intel: fix soundwire dependencies
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:03 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 1/12/21 2:32 PM, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > The Kconfig logic around SND_SOC_SOF_INTEL_SOUNDWIRE tries to
> > ensure that all sound modules can be built with the minimal
> > dependencies, but this fails in some configurations:
> >
> > x86_64-linux-ld: sound/hda/intel-dsp-config.o: in function `snd_intel_dsp_driver_probe':
> > intel-dsp-config.c:(.text+0x134): undefined reference to `sdw_intel_acpi_scan'
> >
> > Specifically, this happens if the dsp-config driver is built-in but does
> > not need to use soundwire, while CONFIG_SOUNDWIRE_INTEL is enabled as
> > a loadable module.
> >
> > An easier and more correct way to do this is to remove
> > CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE_LINK and instead have
> > the two drivers that can link against SOUNDWIRE_INTEL,
> > i.e. DSP_CONFIG and SND_SOC_SOF_HDA, select that driver whenever
> > SND_SOC_SOF_INTEL_SOUNDWIRE_LINK is set.
> >
> > This however means that SND_SOC_SOF_INTEL_SOUNDWIRE cannot be selected
> > by users when SOUNDWIRE is only usable by loadable modules and one or
> > more drivers using SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE is built-in.
>
> The problem is real, but the proposal isn't completely right, there is
> absolutely no logical link or functional dependency between
> INTEL_DSP_CONFIG and SOUNDWIRE.

If that is true, would it be possible to move the call to
sdw_intel_acpi_scan() out of these drivers and one layer
higher where the dependency actually is?

I was indeed wondering whether the intel-dsp-config.c is just
another layering violation: this is another generic piece
of code that seems to contain too much knowledge about
specific hardware implementations.

> We have a similar case with HDaudio, the two buses can be selected as
> tristates, but the SOF configuration needs to match.
>
> In both cases, either we add a 'depends' and users need to make sure the
> configurations match on the two sides. Or we use select but one of the
> selections will be overridden and becomes meaningless.

Maybe something like this:

config SND_SOC_SOF_INTEL_SOUNDWIRE
-        bool "SOF support for SoundWire"
+       tristate "SOF support for SoundWire"
-       depends on SOUNDWIRE && ACPI
+       depends on SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
+       depends on SOUNDWIRE
+       depends on ACPI
+       depends on !(SOUNDWIRE=m && SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y)
+       select SOUNDWIRE_INTEL

I have not tried it, but that should keep it all in one place.

> Arnd, do you mind if I give it a try on my side?

I have no specific attachment to my patch, this was just what I came up
with to fix the build regression locally.

       Arnd
