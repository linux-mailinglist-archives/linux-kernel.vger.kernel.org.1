Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E412E36D7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 13:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgL1MAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 07:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbgL1MAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:00:34 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072DFC061795
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 03:59:54 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id x20so23294034lfe.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 03:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQXhRRDzjlbyFL6HuKDo1qcz0JWdNrGspVv13+VGFG8=;
        b=TLGqJjuprzMMitUd3G2MLt/hoY1pE/ifUzV5yAl16eEysA9YhxucEjaQHFNqGcelRb
         WIGJqosgxLCaMxJUfCqzaze/AT+U0dd8bzfilexccjnhf+/xUy8tkvTc9EYMSRepnhl6
         Io458XPzFLf/Yq84pXF6PhYIvJhPGwkY25oLe3LuuPvwXSNIMkUyDTZCQcAgAxADbVO7
         HE9prWnTd4TwEZTesxiL02Xw7kHbxwE219/+vkhoYzykYa3fOL44JYUWrg5oH1Yym/YT
         ui37Qv7/1OzQqdOAI/L8tA+Y74tVuFhDZ/akgA91cjJUsC2zvzGhKmWMfmS9Cj+M/A1Z
         1JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQXhRRDzjlbyFL6HuKDo1qcz0JWdNrGspVv13+VGFG8=;
        b=kw0z3riFhG752mfs2Gm2k49hw4Sd0nIxZ+nXXlNENxVgr2dsL74pHI7QrKvyrB0sdr
         Ei8NvJGBWnYunNQK4D2I8ytSwxU4ir9kTRlfU9WZeaWse9id4WmX1VAqRkFVrq+1ZPzc
         7zh6QTgYvUu0g0ksEmmUeFrnVzWoG/SejSvS3mQ23QbkzMR7Eex/iZ/1wwYa4kVEYTEf
         NpDziKYbtAxRRq68fJ5TvuouI01qgmibtlX9rzunNDDJrTnI+s/MYosFkm4lMofPfpsC
         bZI3U4YT8fxlGTFRZ0exDwObMFgRIKASBTh7AMmb2218z4ZAZ0iKjDB8VKnHYCuI03a6
         MpIg==
X-Gm-Message-State: AOAM531nD2ynJSQhnPaLq2JfD0Ts95zdU0yxLLrfntiLetUs5eoxE4Np
        3LdQrc4MmLzReLHjpgFl557u1QkEcxzr64TDWqbVew==
X-Google-Smtp-Source: ABdhPJx+bmRmvOvTWYfCwO3iZKYn8ngz/btucRMsO8fxpFJYcl0o+weX50AldeSzSaIizIB0Fh9I0MKgFChOg8OCVcw=
X-Received: by 2002:a2e:3312:: with SMTP id d18mr23130837ljc.284.1609156792508;
 Mon, 28 Dec 2020 03:59:52 -0800 (PST)
MIME-Version: 1.0
References: <20201226163037.43691-1-vitaly.wool@konsulko.com>
In-Reply-To: <20201226163037.43691-1-vitaly.wool@konsulko.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 28 Dec 2020 17:29:41 +0530
Message-ID: <CAAhSdy1M5pMjYHNWdOicb3N3fjTfQLEgE8tFb74sqGbPE_9eyQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: add BUILTIN_DTB support for MMU-enabled targets
To:     Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 10:03 PM Vitaly Wool <vitaly.wool@konsulko.com> wrote:
>
> Sometimes, especially in a production system we may not want to
> use a "smart bootloader" like u-boot to load kernel, ramdisk and
> device tree from a filesystem on eMMC, but rather load the kernel
> from a NAND partition and just run it as soon as we can, and in
> this case it is convenient to have device tree compiled into the
> kernel binary. Since this case is not limited to MMU-less systems,
> let's support it for these which have MMU enabled too.
>
> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
>  arch/riscv/Kconfig   |  1 -
>  arch/riscv/mm/init.c | 12 ++++++++++--
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 2b41f6d8e458..9464b4e3a71a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -419,7 +419,6 @@ endmenu
>
>  config BUILTIN_DTB
>         def_bool n
> -       depends on RISCV_M_MODE
>         depends on OF
>
>  menu "Power management options"
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 87c305c566ac..5d1c7a3ec01c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -194,12 +194,20 @@ void __init setup_bootmem(void)
>         setup_initrd();
>  #endif /* CONFIG_BLK_DEV_INITRD */
>
> +       /*
> +        * If DTB is built in, no need to reserve its memblock.
> +        * OTOH, initial_boot_params has to be set to properly copy DTB
> +        * before unflattening later on.
> +        */
> +       if (IS_ENABLED(CONFIG_BUILTIN_DTB))
> +               initial_boot_params = __va(dtb_early_pa);

Don't assign initial_boot_params directly here because the
early_init_dt_scan() will do it.

The setup_vm() is supposed to setup dtb_early_va and dtb_early_pa
for MMU-enabled case so please add a "#ifdef" over there for the
built-in DTB case.

> +       else
> +               memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> +
>         /*
>          * Avoid using early_init_fdt_reserve_self() since __pa() does
>          * not work for DTB pointers that are fixmap addresses
>          */

This comment needs to be updated and moved along the memblock_reserve()
statement.

> -       memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
> -
>         early_init_fdt_scan_reserved_mem();
>         dma_contiguous_reserve(dma32_phys_limit);
>         memblock_allow_resize();
> --
> 2.29.2
>

This patch should be based upon Damiens builtin DTB patch.
Refer, https://www.spinics.net/lists/linux-gpio/msg56616.html

Regards,
Anup
