Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D222F0BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbhAKEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbhAKEFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:05:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A8C06179F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:04:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so35723281lfc.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6q6bK74e1uGqFWykBzn1UfhFP5mb0Otk6HA48F1HwJ0=;
        b=C4nnRQ5QCFjqgRoNNA42Lz3EEKsOU+VJ6t9NqBzyosLVIRvjbrNmE4YBob6IONSS1P
         nVuss5Nr2dsMA/DsEcvIR6UdEjSW+YQe+x28wgEB3GAA+yLPLKVWGWS4CHu+h57Jnnul
         MD6MJp7vwMjnVmxSV2ZZ1ZvtETLEtzonJoVatVOfzR57Qzfvs23kG2nFwbhe304/0klQ
         GunA6HWLx8Nu+0vIpvKolH+ffK8D3p+1SrEYTqS0XQ0aSI/iyy/unSGAEHMhNKoiuzdD
         x+ZhvBSWXJ/J5FTrn0fCabxKEeL+BtgyIX9/ofmEBXDB4RjpSGMI0jC+UBJtnX0jyowk
         sPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6q6bK74e1uGqFWykBzn1UfhFP5mb0Otk6HA48F1HwJ0=;
        b=qx+GPqZhIDsznlZXK9soTrytm2z7AD6HsAbL+s4UE3e2c88lAQHZ3YdxH7hZSCGArk
         bWtXqwPuXcHSA/rTFclx1KAWTx56bGerBhkIkcdAtumQkWyR6V6KPXojpwpho5x0IZEH
         ve1z+Kq3abTv/+DGBy/Bet9DGY1/rtC65U3UNVuPzLblgZfasb8F1XbMlk6SzmoCajKU
         v6vHCD7+oa+J6qqWSPweB8tMregsmceXPSyQps28Yo/U5tMt9ZaFdQ6smZphManLuGGO
         pN/GV2/o509cIwDuyJdwLomqA3GTCkwc1aQGjSMm2t7IMVq5e9LY5/sTd2ZlAu7h2GyF
         FDXw==
X-Gm-Message-State: AOAM532wPLp4BBkSglw+5tXji8Ds3XgQBRJb+eKVjb+wdFW6cDsaaOZo
        k8yz8kt2JPqmXVZK+36qMle8TM8SlYvXmdKYU3yo+UG+E/jkZw==
X-Google-Smtp-Source: ABdhPJxEWJWq6kAkGml3Vbi80k+g5JFrJYBEIDCSWA5K143y9EPCKxl2jzrEW+w0uxSJMhOjZ8BnB9QsuXQMPQYKusc=
X-Received: by 2002:a05:6512:22ca:: with SMTP id g10mr3298651lfu.87.1610337858451;
 Sun, 10 Jan 2021 20:04:18 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com> <20210107092652.3438696-5-atish.patra@wdc.com>
In-Reply-To: <20210107092652.3438696-5-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Jan 2021 09:34:07 +0530
Message-ID: <CAAhSdy3Z1zxFdPr+dSvP6GH+1NtRw7o=JS7OnOmZnqb8LPbnRQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] RISC-V: Fix maximum allowed phsyical memory for RV32
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 2:57 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Linux kernel can only map 1GB of address space for RV32 as the page offset
> is set to 0xC0000000. The current description in the Kconfig is confusing
> as it indicates that RV32 can support 2GB of physical memory. That is
> simply not true for current kernel. In future, a 2GB split support can be
> added to allow 2GB physical address space.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Just for information, Alex's also has a patch to simplify this. Refer,
"[RFC PATCH 05/12] riscv: Simplify MAXPHYSMEM config"

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

> ---
>  arch/riscv/Kconfig | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 81b76d44725d..e9e2c1f0a690 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -137,7 +137,7 @@ config PA_BITS
>
>  config PAGE_OFFSET
>         hex
> -       default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
> +       default 0xC0000000 if 32BIT && MAXPHYSMEM_1GB
>         default 0x80000000 if 64BIT && !MMU
>         default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
>         default 0xffffffe000000000 if 64BIT && MAXPHYSMEM_128GB
> @@ -247,10 +247,12 @@ config MODULE_SECTIONS
>
>  choice
>         prompt "Maximum Physical Memory"
> -       default MAXPHYSMEM_2GB if 32BIT
> +       default MAXPHYSMEM_1GB if 32BIT
>         default MAXPHYSMEM_2GB if 64BIT && CMODEL_MEDLOW
>         default MAXPHYSMEM_128GB if 64BIT && CMODEL_MEDANY
>
> +       config MAXPHYSMEM_1GB
> +               bool "1GiB"
>         config MAXPHYSMEM_2GB
>                 bool "2GiB"
>         config MAXPHYSMEM_128GB
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Regards,
Anup
