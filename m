Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037E12E957D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 14:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhADND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 08:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbhADND5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 08:03:57 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB5CC061795
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 05:03:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ga15so4545051ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 05:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8O+ttpYkwTO3a0EGi2ouz131vv9Xb7LUAbH0VJvMp/w=;
        b=Qa/zdwZB4u4GydjyhxJ6EJJs65+9OE3RBuQ+xSsK7JAyNX/ihvkMUuGHAXtbKuq7Ya
         +/AAQYMJpuNgpQkfOXLKoIr0VV+g/LP6UbokXZwzpTRkhYXSgO5uKdqxcF2iHCmcTEG/
         4FoOmo/wzDQ6YbFjIQM7zrSAVZlLh3sKxscgAIjFIdafJURjPpehFd1CNQgJk8mxKATb
         Eioo0H6uEFVOWKsGrpQMhCqVWEgnnIcLkNxx01QPLFNr9Vf3SCaF/oT/rEtQ1nsgnpcu
         aGlZOvza2bbg2frEUEgYmYFuMHRIhVonE7lETCWAxQRW3eJBxXf5BjMHiI6T6AH3K4+o
         9ykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8O+ttpYkwTO3a0EGi2ouz131vv9Xb7LUAbH0VJvMp/w=;
        b=UGhK4u25IjD6AB59EWRkv8U1fDbahAV1+9kOEXzKiQgS2YU6L9IDC16PDcT2kDw33o
         SZzbWQ552hZCE11GYja3h/Y4BnLL/uMh65/4Bp/zNaRJ30tqStMYPJPzolxlBsIQV88D
         /gQvsQ8QDZqm/RdOOSXx2fwB4WMBZ0+/TAVPXA17IV0GRmviRTTQqdhLP2oOI7cXHWXb
         OOq7Py6XvpdzNEpcxhGHSblSgfo3mZL3cKE+KzUHpzd83BkdnfDEOD/bxlTvgJK5RoZA
         sK8emw/up/jjGRrBiU55iMh/ejcRR96D0hi3FXJYTqoVQzqkXx+pfz2mKMpg24MZIkI6
         oLvA==
X-Gm-Message-State: AOAM533RTwi33JJ+tlXaPWpm86IeUfoe9V+/bWrfDNMffS3yjDBVFB9Y
        fT+12zmKGpSJ8cXRTr0cs51zqOT3mjAiF5ig1W6vSw==
X-Google-Smtp-Source: ABdhPJwr5lLCVjK6e9Pw6KsJU/cwudyOoPfv8XRSmtlIh96BT0DX0v+BhJ0xDE/2FnS2Tt+ywwIWk1/doOOJsutdGi0=
X-Received: by 2002:a17:906:3953:: with SMTP id g19mr65713000eje.429.1609765395934;
 Mon, 04 Jan 2021 05:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20210104113744.10681-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVFZsKb7=z4NJAbgHY9fEL-cNQqahEpoynjeMG7-wAuiQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVFZsKb7=z4NJAbgHY9fEL-cNQqahEpoynjeMG7-wAuiQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 4 Jan 2021 14:03:04 +0100
Message-ID: <CAMpxmJUGfbMbuKYpwoqojoxjNX_XAV2A-1NuxHoFzm-Z0Q_J=Q@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: Kconfig: Update help description for GPIO_RCAR config
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 1:26 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Mon, Jan 4, 2021 at 12:37 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > The gpio-rcar driver also supports RZ/G SoC's, update the description to
> > reflect this.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Patch applied, thanks!

Bartosz
