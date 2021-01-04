Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72E92E9B56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbhADQt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 11:49:56 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45597 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbhADQtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 11:49:55 -0500
Received: by mail-ot1-f52.google.com with SMTP id n42so26561560ota.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 08:49:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fkrQP4tLbvvA8Dq58BtGeBgLkf6qqiDBKQsJadGDrI=;
        b=tDKS1hRzqr0adUOxOgYF6BZifsNPT5gyeXVjdO22Zx1XBfOD4gfbKNQAGKf7AkHphk
         EBwPrEXhgQkJkqZ7qnUZ2fun65kxZ5T1Kp5D/7tmskhogZGc2ZC9dT1ta8cAUwe5KB2I
         L0wJviC4/X0Q45QjXf6dut/M56mMKKlgD3BcWfgV1lPqsVdVQ7P5XeBNt07g02MWVN3z
         TK1FuEapqBdlRpPWoeVN9+5hJXSUwjx0YyYihZj94KflMHSabb2UPKbicUJm007hmpnK
         C/cqP7UxV3Lc/QKDVPUduC9b4eM99uGmeGhm3o5k8s0u8h0BwMkyvoH+dsCS/cQHOUzX
         aurw==
X-Gm-Message-State: AOAM531YVpWy17PAVs9xJA5RU5gkI3jTs4eb0R0Un4ORzTgAexllg7OP
        qnk45BAeffLmQBqMeZXEoYWIM7sFXLFwaJVT9Pc=
X-Google-Smtp-Source: ABdhPJw/fX5bDYgvVjAZ3/BXEfeMxMiKSCRsFXnDni2smUO6Y2LjN6+8nWI9zHhWsMEQkXD5+HFg8UlLyux2KP2cNiA=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr53508152oth.250.1609778954548;
 Mon, 04 Jan 2021 08:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20210104164500.1311091-1-geert@linux-m68k.org>
In-Reply-To: <20210104164500.1311091-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Jan 2021 17:49:03 +0100
Message-ID: <CAMuHMdXG_B-3y1MWh64T6LU3Gmo6UQGGWU8EbLApjDeXVLL3GQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/soc/litex: Add restart handler
To:     Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>
Cc:     Gabriel Somlo <gsomlo@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 4, 2021 at 5:45 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Let the LiteX SoC Controller a register a restart handler, which resets
> the LiteX SoC by writing 1 to CSR_CTRL_RESET_ADDR.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Tested with linux-on-litex-vexriscv.
>
> This patch is based on upstream, i.e. not on top of Gabriel Somlo's
> "[PATCH v5 0/4] drivers/soc/litex: support 32-bit subregisters, 64-bit
> CPUs"
> (https://lore.kernel.org/lkml/20201227161320.2194830-1-gsomlo@gmail.com/)

Bummer, and that's why the RESET_REG_* definitions are no longer
next to the SCRATCH_REG_* definitions :-(

Well, I assume that will be fixed by evolution ;-)

> v2:
>   - Rebase on top of v5.11-rc1,
>   - Change reset handler priority to recommended default value of 128
>     (was 192).
>
> (v1 was not sent to a mailing list)
> ---
>  drivers/soc/litex/litex_soc_ctrl.c | 33 +++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
> index 1217cafdfd4d1d2b..d729ad50d4ffca5e 100644
> --- a/drivers/soc/litex/litex_soc_ctrl.c
> +++ b/drivers/soc/litex/litex_soc_ctrl.c
> @@ -15,6 +15,11 @@
>  #include <linux/module.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> +#include <linux/reboot.h>
> +
> +/* reset register located at the base address */
> +#define RESET_REG_OFF           0x00
> +#define RESET_REG_VALUE         0x00000001
>
>  /*
>   * LiteX SoC Generator, depending on the configuration, can split a single

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
