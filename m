Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA4E2F2A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 09:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405596AbhALIrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 03:47:49 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:46871 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732738AbhALIrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 03:47:48 -0500
Received: by mail-oi1-f173.google.com with SMTP id q205so1544799oig.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 00:47:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D79yAvxFkBso3i6vK6yIO4bEcxdNj8cx5BWEVmuRDLo=;
        b=VUJPK4pU03Pedm0UiUda30x3YSY43Tk2PKjThMPxOZRk2+fbJ0uxL43te2hzbFZssK
         JB/9JOpCvBcZ9E6tuJURUibIIgdVwFQ5u3I5vfL/28pnuCDo09eZYDGeL2oOlql+BIOo
         CvKAJa2eoHGCHCQ5x36ieDXZGTj7v+izEztzUVLWhvAlTtJ9GP0mNRI3vfNaj4YH2Y7U
         ACkcsTh3cbpnwME4ugTPSodOmjfVJEpEX0ZSNPzBi+XAJjM0wGM3dEjbC+HjuLss3QNP
         xF6sZ05ihltzokotjYXsoiQp/huWrHbtzHvBjAD9S2jnaakkjsAUzMDms2P+JFFwGBXS
         yLQA==
X-Gm-Message-State: AOAM532RIQMQM5btr8PRRQobmFUd8W1qrB7P09cInVDVmx+9KJ6DnAnK
        /zWAG6i2aH9tx3v/seCFSqADEf2aFgimKCl4I1o=
X-Google-Smtp-Source: ABdhPJwpEXUQy50oYlHo5BtbF9034MvmIwzn2LxzbtoY0yQ++MTL5s0bBXWpwFRvz+Lqlo3gwrddRJosW6EMo6hPB/4=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr1719601oia.148.1610441227636;
 Tue, 12 Jan 2021 00:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20210111125702.360745-1-geert+renesas@glider.be> <X/0nmQ/XBpj6PJAh@pendragon.ideasonboard.com>
In-Reply-To: <X/0nmQ/XBpj6PJAh@pendragon.ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Jan 2021 09:46:56 +0100
Message-ID: <CAMuHMdVaJgHv0kRSLaFfPzD5hiJKQCg30D=7SAv0cPwR9j5DZw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: nwl-dsi: Avoid potential multiplication
 overflow on 32-bit
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Tue, Jan 12, 2021 at 5:38 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Mon, Jan 11, 2021 at 01:57:02PM +0100, Geert Uytterhoeven wrote:
> > As nwl_dsi.lanes is u32, and NSEC_PER_SEC is 1000000000L, the second
> > multiplication in
> >
> >     dsi->lanes * 8 * NSEC_PER_SEC
> >
> > will overflow on a 32-bit platform.  Fix this by making the constant
> > unsigned long long, forcing 64-bit arithmetic.
> >
> > While iMX8 is arm64, this driver is currently used on 64-bit platforms
> > only, where long is 64-bit, so this cannot happen.  But the issue may
> > start to happen when the driver is reused for a 32-bit SoC, or when code
> > is copied for a new driver.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/gpu/drm/bridge/nwl-dsi.c
> > +++ b/drivers/gpu/drm/bridge/nwl-dsi.c
> > @@ -195,7 +195,7 @@ static u32 ps2bc(struct nwl_dsi *dsi, unsigned long long ps)
> >       u32 bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
> >
> >       return DIV64_U64_ROUND_UP(ps * dsi->mode.clock * bpp,
> > -                               dsi->lanes * 8 * NSEC_PER_SEC);
> > +                               dsi->lanes * 8ULL * NSEC_PER_SEC);
>
> I wonder if we could get rid of a whole class of bugs by turning
> NSEC_PER_SEC into a ULL, but I suppose there are valid cases where a
> 32-bit integer is enough.

Indeed, and 64-bit arithmetic is more expensive on 32-bit platforms.
I considered that change, but doing so would require updates all over
the place (e.g. printing a value derived from NSEC_PER_SEC, divisions
 that need to be changed to do_div or div_u64(), ...)

Note that the selftests already use such a definition.

> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

> How did you come across this by the way ?

https://lore.kernel.org/linux-renesas-soc/CAMuHMdXQvPY_mYicjPKjDSCwdO_rP-9PJOvqD0J6=S3Opr1ycg@mail.gmail.com/
and of course I grepped for similar use patterns...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
