Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E332EABF4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbhAENbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727502AbhAENbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:31:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 738DB22AB0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609853422;
        bh=Y3X+Ao3y9OwHazKid/hJ8+zkt+P/z3Xwtv2v+7aWPVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jZhctHDwmph0iXETpDjKf8iw7CkcVyDkcNKzFkek7/sF3ZYEKOHz5K3m2nOa8C4EH
         6wtr+tCbSxHWs4FDsn+k4NUavzrL4CXQCI2qUgCCSWFc2/VvVLipcObRLiYbYFj37U
         o+Q4FXnnKZjAp+mPsr1BbV13+zDb/aEDkH0atrhq83Xmg8MkvETJOpXBJiSHNQ0XGt
         kg5cPGtj9ADtg++FUAbjIRshLSskhbJU30cDnpjqRhJ0hsx1KZgl1iMohpDXRb+WKs
         Jq1Nh/ILB0oTae9/VMqzsNBnTaV7jwcyc7UNNK7iFvS8CTSshn5FWWHcsuiWPnosf3
         JEUgUiZxaJkVg==
Received: by mail-ot1-f50.google.com with SMTP id j12so29203263ota.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:30:22 -0800 (PST)
X-Gm-Message-State: AOAM5332pEW8zFkIdPVA0e7O+P1gePrwoZKGaefMBlIGXZoFvjRAdCnd
        q+xXVx6oSvS0lK5a89aImPtsbc4j87ZWMSQXJRM=
X-Google-Smtp-Source: ABdhPJxs3WdKC1hUGYMHRUaOZwuzm9ovdWwReGeDftdobzTgRjaq1WsuJjcw99u+KB5nHsa4XKeWFWTSEjbkBMFo2gE=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr56051876otr.210.1609853421829;
 Tue, 05 Jan 2021 05:30:21 -0800 (PST)
MIME-Version: 1.0
References: <20210103135257.3611821-1-arnd@kernel.org> <3c19a5d5-8883-f917-a96a-f51bb188d115@perex.cz>
In-Reply-To: <3c19a5d5-8883-f917-a96a-f51bb188d115@perex.cz>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 5 Jan 2021 14:30:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2fbL3zTP=krdLr0cVKh5f0OmDge2QEGego9iu4z3bvqw@mail.gmail.com>
Message-ID: <CAK8P3a2fbL3zTP=krdLr0cVKh5f0OmDge2QEGego9iu4z3bvqw@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
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

On Mon, Jan 4, 2021 at 4:00 PM Jaroslav Kysela <perex@perex.cz> wrote:
> Dne 03. 01. 21 v 14:52 Arnd Bergmann napsal(a):

> > diff --git a/include/sound/intel-dsp-config.h b/include/sound/intel-dsp-config.h
> > index d4609077c258..94667e870029 100644
> > --- a/include/sound/intel-dsp-config.h
> > +++ b/include/sound/intel-dsp-config.h
> > @@ -18,24 +18,7 @@ enum {
> >       SND_INTEL_DSP_DRIVER_LAST = SND_INTEL_DSP_DRIVER_SOF
> >  };
> >
> > -#if IS_ENABLED(CONFIG_SND_INTEL_DSP_CONFIG)
>
> The SOF drivers selects the DSP config code only when required (for specific
> platforms - see sound/soc/sof/intel/Kconfig).
>
> It seems that the above if should be modified as:
>
> #if IS_BUILDIN(CONFIG_SND_INTEL_DSP_CONFIG) || (defined(MODULE) &&
> IS_MODULE(CONFIG_SND_INTEL_DSP_CONFIG))
>
> So the buildin drivers which do not require the DSP config probe can be
> compiled without this dependency.

This would be the same as

#if IS_REACHABLE(CONFIG_SND_INTEL_DSP_CONFIG)

but using that macro is almost always a bad idea, as it tends to hide
dependency problems and causes things to silently not work right
when the Kconfig rules are incorrect.

      Arnd
