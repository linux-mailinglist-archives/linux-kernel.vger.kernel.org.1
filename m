Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C132EAC20
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbhAENoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbhAENoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:44:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DFD222BE9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609854214;
        bh=EiuoZfhXsqgKt5omLL6GGtbH9zsizSgQXK7RGIvfpkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mC+Xo8YbPCV+2rl6EA8BrpjyZIcJirSwv5a1LKmf7iCBWXRHNSyMRJLqRBkcYDKsY
         tIf8T3f5YIqad2P3A5k3wjACrntdny7rlzk7cOd88QiEeUiikNVxYjirlkxE+wD7Rs
         h7ULwFKKaf73POnaGEQyPVhqKnjIIx1nfGWHQgv0fdUmELhK5OQEEuZMPBxVrWWRFS
         ouzXsPnC9S6l+wKvztYQt4n/IbV6vAVTLs25PobNRshU11zP2zIAEcJiKBnlYggVzO
         Kvqpcv2CJiPDKuzfITyPPXGAayxrhH2WErKQ8AkEaF/J3RtTLDn6ve/fVt0UNXqeOM
         dufk1cG434H9g==
Received: by mail-ot1-f54.google.com with SMTP id i6so29301442otr.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:43:34 -0800 (PST)
X-Gm-Message-State: AOAM5334+k2feDL1ZpcPtDnlOUcFXHJyJ7tkvsGbZJeFHOPhOjfFTzXH
        Q0Qn18pBUlNpOwtyOBwRlUgS4ZfX9FmXlbNoCdA=
X-Google-Smtp-Source: ABdhPJzO01xuMyg90ioZEwJ1xUG44ShymQlC2JBZNSSKovRByhT+UIeWN7gbxD3FYJPhvU28mpdriKAGBKxdzLErsMo=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr58181727ots.251.1609854213337;
 Tue, 05 Jan 2021 05:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20210103135257.3611821-1-arnd@kernel.org> <3c19a5d5-8883-f917-a96a-f51bb188d115@perex.cz>
 <s5hble491zu.wl-tiwai@suse.de>
In-Reply-To: <s5hble491zu.wl-tiwai@suse.de>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 14:43:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1FZSfzu3TA6VMhqP+3H5OD3+BhH5W=vVYEkL+ExHqpMQ@mail.gmail.com>
Message-ID: <CAK8P3a1FZSfzu3TA6VMhqP+3H5OD3+BhH5W=vVYEkL+ExHqpMQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 4:05 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Mon, 04 Jan 2021 16:00:05 +0100, Jaroslav Kysela wrote:
> >
> > Dne 03. 01. 21 v 14:52 Arnd Bergmann napsal(a):
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > The sof-pci-dev driver fails to link when built into the kernel
> > > and CONFIG_SND_INTEL_DSP_CONFIG is set to =m:
> > >
> > > arm-linux-gnueabi-ld: sound/soc/sof/sof-pci-dev.o: in function `sof_pci_probe':
> > > sof-pci-dev.c:(.text+0x1c): undefined reference to `snd_intel_dsp_driver_probe'
> > >
> > > All other drivers using this interface already use a 'select
> > > SND_INTEL_DSP_CONFIG' statement to force the it to be present, so it
> > > seems reasonable to do the same here.
> > >
> > > The stub implementation in the header makes the problem harder to find,
> > > as it avoids the link error when SND_INTEL_DSP_CONFIG is completely
> > > disabled, without any obvious upsides. Remove these stubs to make it
> > > clearer that the driver is in fact needed here.
> > >
> > > Fixes: 82d9d54a6c0e ("ALSA: hda: add Intel DSP configuration / probe code")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > >  include/sound/intel-dsp-config.h | 17 -----------------
> > >  sound/soc/sof/Kconfig            |  2 ++
> > >  2 files changed, 2 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/include/sound/intel-dsp-config.h b/include/sound/intel-dsp-config.h
> > > index d4609077c258..94667e870029 100644
> > > --- a/include/sound/intel-dsp-config.h
> > > +++ b/include/sound/intel-dsp-config.h
> > > @@ -18,24 +18,7 @@ enum {
> > >     SND_INTEL_DSP_DRIVER_LAST = SND_INTEL_DSP_DRIVER_SOF
> > >  };
> > >
> > > -#if IS_ENABLED(CONFIG_SND_INTEL_DSP_CONFIG)
> >
> > The SOF drivers selects the DSP config code only when required (for specific
> > platforms - see sound/soc/sof/intel/Kconfig).
> >
> > It seems that the above if should be modified as:
> >
> > #if IS_BUILDIN(CONFIG_SND_INTEL_DSP_CONFIG) || (defined(MODULE) &&
> > IS_MODULE(CONFIG_SND_INTEL_DSP_CONFIG))
> >
> > So the buildin drivers which do not require the DSP config probe can be
> > compiled without this dependency.
>
> As I wrote in another post, a part of the problem is that SOF PCI and
> ACPI drivers call snd_intel_dsp_driver_probe() unconditionally, even
> if no Intel driver is bound.

Makes sense. Is there an existing Kconfig that could be used to
decide whether the drivers use SND_INTEL_DSP_CONFIG or not?
Could it be part of the device specific driver_data?

According to sof_pci_ids[], all PCI IDs are Intel specific, but I can't
tell which ones need the DSP config.

> So even if changing like the above (or
> better to use IS_REACHABLE() macro) works around the issue, the call
> pattern needs to be reconsidered.

If the callers are fixed to address this, then I would expect the
IS_REACHABLE() or IS_ENABLED() to no longer be needed
either.

       Arnd
