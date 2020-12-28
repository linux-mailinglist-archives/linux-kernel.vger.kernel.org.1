Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB72E34D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 08:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgL1HtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 02:49:05 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:40588 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgL1HtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 02:49:05 -0500
Received: by mail-oi1-f180.google.com with SMTP id p5so10746376oif.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 23:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwOG3Rdx+Bs9ShvxTgTiz6VxgWYDrwpnieaPNAu4NdY=;
        b=CdjbBI2f2AgpXNliP07UkVSn9vOCln2SxV6Bs9rRZBf7KZtpBV3jUVNEoXVXKqQCRn
         0yZashmn2tkVNQJCjOwjJwZyISrnsqynm1yPYH/Oe7R+LaJiuZI3XEJidFD/iutyI0W8
         Fj1h4QyFY615hqmS74tlDYOIHwzhv3qVX2QORdv8IbuKZHJqKK9QAFtFn1a9WViDZbhn
         hLfAwUmUYIDsYe9Ax086k5G1+41Kiqr82R+G5K2fChYit0ElWqTEGHpGdf9CEGUbJk7a
         5j+TL9lf5KCIR3CwUPFlDWPBSxMci/0XJITZqCr8c9QXRpVLGpLW7C0ns0p8JVSERmN3
         uxNQ==
X-Gm-Message-State: AOAM531XsavSNll3snIXOhEu2ahr70iWCjCnVYjS/VYSwZoYbM/MeOXd
        jU3Y6+htyfK9zENDfh9x/ggnQkQdu4gbg6iMvhA=
X-Google-Smtp-Source: ABdhPJwW0Vvce+v0PSbZ1Mvc9RPUJU5cugHMBwWn8Y1tNZW8mmOYAhFLEzUFhQrRSi/SoFtEuooxidWJ9VE/63Vjtd4=
X-Received: by 2002:aca:3cc5:: with SMTP id j188mr11316836oia.54.1609141704170;
 Sun, 27 Dec 2020 23:48:24 -0800 (PST)
MIME-Version: 1.0
References: <1609121265-207018-1-git-send-email-bodefang@126.com>
In-Reply-To: <1609121265-207018-1-git-send-email-bodefang@126.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Dec 2020 08:48:12 +0100
Message-ID: <CAMuHMdXH8qw9SMD4=SDNUeZUTm2ar1hO7Ev23r9ypFziZstKUw@mail.gmail.com>
Subject: Re: [PATCH] m68k: let clk_enable() return immediately if clk is NULL
To:     Defang Bo <bodefang@126.com>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Defang,

On Mon, Dec 28, 2020 at 3:08 AM Defang Bo <bodefang@126.com> wrote:
> Similar to commit<742859adc721>("m68k: let clk_disable() return immediately if clk is NULL").
> there should be a check for clk to prevent NULL pointer dereference.
>
> Signed-off-by: Defang Bo <bodefang@126.com>

Thanks for your patch!

> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -90,6 +90,9 @@ EXPORT_SYMBOL(clk_get);
>  int clk_enable(struct clk *clk)
>  {
>         unsigned long flags;

Please keep the blank line between variable declarations and
statements (no complaint from scripts/checkpatch.pl? See
Documentation/process/submitting-patches.rst
).

> +       if (!clk)
> +               return -EINVAL;
> +
>         spin_lock_irqsave(&clk_lock, flags);
>         if ((clk->enabled++ == 0) && clk->clk_ops)
>                 clk->clk_ops->enable(clk);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
