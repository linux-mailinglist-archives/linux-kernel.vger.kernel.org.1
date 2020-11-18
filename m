Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E198E2B8559
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKRULx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:11:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:46282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgKRULw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:11:52 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF690246C2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 20:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605730312;
        bh=xH09zmAMJR7NQ0penF01YGocgLtiRqP/c16vo28xqMs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cQxU872/OaztpvrzHVfL0VYocUM+OEd0boZ+scemi/iOBcUE3xN+h0h0dlfC/cuF/
         usSKtwTQbKMSt0j0isXHAaGScy4lEOBJiatXkcSEO/4/D2F9Wf67WlRCKuxNGLYc+B
         FVRmgNPnIPl+get85P+KmjQXoM8caKKXad6SShD8=
Received: by mail-ed1-f51.google.com with SMTP id q3so3340998edr.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:11:51 -0800 (PST)
X-Gm-Message-State: AOAM533mPaZ8V/Ibi8XiPyZS9rliA7RvphloISBBb4/vmDkZ7CHhz2+O
        mDhksxagetYFvRr6vZ0QqqUW0X7d2HM2Rl93mGk=
X-Google-Smtp-Source: ABdhPJyuwE9rW2aLLtgf1eTOIDKPNtfAwUEfdypJSwWno4+HwFzVqFNqhTiVYC+WS/NF+0wik6+rQf5kI+AxgGY8/io=
X-Received: by 2002:a05:6402:290:: with SMTP id l16mr28013820edv.104.1605730310120;
 Wed, 18 Nov 2020 12:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20201117182310.73609-1-krzk@kernel.org> <20201118153816.fctrz6dfjiph2mgl@gilmour.lan>
In-Reply-To: <20201118153816.fctrz6dfjiph2mgl@gilmour.lan>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 18 Nov 2020 21:11:37 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdnOSYZ425FEStjBcd71NTycYDVXmH4e3aq4+wa=kbdyQ@mail.gmail.com>
Message-ID: <CAJKOXPdnOSYZ425FEStjBcd71NTycYDVXmH4e3aq4+wa=kbdyQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: sunxi: do not select COMMON_CLK to fix builds
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Samuel Holland <samuel@sholland.org>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 at 16:38, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Tue, Nov 17, 2020 at 07:23:10PM +0100, Krzysztof Kozlowski wrote:
> > COMMON_CLK is a user-selectable option with its own dependencies.  The
> > most important dependency is !HAVE_LEGACY_CLK.  User-selectable drivers
> > should not select COMMON_CLK because they will create a dependency cycle
> > and build failures.  For example on MIPS a configuration with COMMON_CLK
> > (selected by SND_SUN8I_CODEC) and HAVE_LEGACY_CLK (selected by
> > SOC_RT305X) is possible:
> >
> >   WARNING: unmet direct dependencies detected for COMMON_CLK
> >     Depends on [n]: !HAVE_LEGACY_CLK [=y]
> >     Selected by [y]:
> >     - SND_SUN8I_CODEC [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] &&
> >       (ARCH_SUNXI || COMPILE_TEST [=y]) && OF [=y] && (MACH_SUN8I || ARM64 && ARCH_SUNXI || COMPILE_TEST [=y])
> >
> >     /usr/bin/mips-linux-gnu-ld: drivers/clk/clk.o: in function `clk_set_rate':
> >     (.text+0xaeb4): multiple definition of `clk_set_rate'; arch/mips/ralink/clk.o:(.text+0x88): first defined here
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Samuel Holland <samuel@sholland.org>
>
> Acked-by: Maxime Ripard <mripard@kernel.org>
>
> however, I'm not sure the prefix is the one Mark would expect?

Good point, I'll fix it in v3.

Best regards,
Krzysztof
