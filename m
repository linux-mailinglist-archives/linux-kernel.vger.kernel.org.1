Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A652E932E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 11:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbhADKTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 05:19:22 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:42897 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbhADKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 05:19:22 -0500
Received: by mail-oi1-f172.google.com with SMTP id l200so31571455oig.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 02:19:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XFpfLf9mWehUw2PJN8CRjS+dWmT0qzE0K6fB6jhwX0=;
        b=bgRMpm0qhQc6GZh9IpOkuxTegzMt3qmqaofPkPkRYSrOmPM/0pOWANENxLHTkt0O9K
         g5XAoXK6IJfKCpIbcKPJRQOBH5kcywqeTb2hCmmsaFiRjlcCzLYrokln2AnZakoPLIfc
         FSw1T63xoAzVnBGdejX3GUbvb07ZPF4hV074nXX5bVsM4xXMIUJD861rERlGZRUGOoiP
         4DTW5AEemcxn93wDalEeU6zlhNCMPOS35/Oj088+MbWgLixGWWJEWfGMuekQ59KG7A6l
         fkM4WD0D/AuMALC27uTfAoyyxn15P/7grRBrpabC8ntn8C2w7HstrRY21Lxr1ES8U3DB
         x8/A==
X-Gm-Message-State: AOAM531+daaQIgLNPT0DLA55/mVhUf2D4JbWK9XarMMEW3vLyDVRtnwl
        9+d4dAnydIgnQ+ON96246wrb+4F3GdRgN61Injw=
X-Google-Smtp-Source: ABdhPJyfeHcWsciQOKh8z39NZjk2o+rH3M0PSL4xfRfka/yyWWOfDG6MXVHVpcp81d01HPV52a4ej6rndkDPxvaQ5S0=
X-Received: by 2002:aca:4b16:: with SMTP id y22mr17289986oia.148.1609755521123;
 Mon, 04 Jan 2021 02:18:41 -0800 (PST)
MIME-Version: 1.0
References: <1609750546-17118-1-git-send-email-chensong_2000@189.cn>
In-Reply-To: <1609750546-17118-1-git-send-email-chensong_2000@189.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 11:18:30 +0100
Message-ID: <CAMuHMdXi0x+VrJO8V_qU8dw+WrzBGqsz_m+nfT7uYWgcUwyUqA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: board: Remove macro board_staging
To:     chensong_2000@189.cn
Cc:     Greg KH <greg@kroah.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

Thanks for your patch!

On Mon, Jan 4, 2021 at 9:55 AM Song Chen <chensong_2000@189.cn> wrote:
> Macro is not supposed to have flow control in it's
> statement, remove.

Why not?

>
> Signed-off-by: Song Chen <chensong_2000@189.cn>
>
> ---
> Changes in v2:
> 1, kzm9d_init and armadillo800eva_init are not compatible
> with the definition of device_initcall, fixed.
> ---
>  drivers/staging/board/armadillo800eva.c | 15 ++++++++++-----
>  drivers/staging/board/board.h           | 11 -----------
>  drivers/staging/board/kzm9d.c           | 23 ++++++++++++++---------
>  3 files changed, 24 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/staging/board/armadillo800eva.c b/drivers/staging/board/armadillo800eva.c
> index 0225234..9896c7ba 100644
> --- a/drivers/staging/board/armadillo800eva.c
> +++ b/drivers/staging/board/armadillo800eva.c
> @@ -78,11 +78,16 @@ static const struct board_staging_dev armadillo800eva_devices[] __initconst = {
>         },
>  };
>
> -static void __init armadillo800eva_init(void)
> +static int __init armadillo800eva_init(void)
>  {
> -       board_staging_gic_setup_xlate("arm,pl390", 32);
> -       board_staging_register_devices(armadillo800eva_devices,
> -                                      ARRAY_SIZE(armadillo800eva_devices));
> +       if (of_machine_is_compatible("renesas,armadillo800eva")) {
> +               board_staging_gic_setup_xlate("arm,pl390", 32);
> +               board_staging_register_devices(armadillo800eva_devices,
> +                                              ARRAY_SIZE(armadillo800eva_devices));
> +               return 0;
> +       }
> +
> +       return -ENODEV;
>  }
>
> -board_staging("renesas,armadillo800eva", armadillo800eva_init);
> +device_initcall(armadillo800eva_init);

This change makes it more difficult to have multiple entries sharing
the same init function.  See also the various *OF_DECLARE() macros.

Note that a similar patch was (IMHO rightfully) rejected 3 years ago:
https://lore.kernel.org/lkml/20170220175506.GA30142@kroah.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
