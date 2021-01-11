Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02DA2F0BA3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbhAKEAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAKEAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:00:55 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED67C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:00:14 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id n8so2019126ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aHEcr4bSN1zx2FiEMYBhMzgQIQxqAhuq0PemUwVcZMc=;
        b=17Yxy068PsRgBYF8Z92oLby9dxH4xCw0G3KUSVK5aO7ukRRPstyXKGXxnHINqOemMp
         bU+NJ7KZAgJRAVo1zy+w+gzx0dM0gHBT+TQt0yxMMgKCsw5tPTwi5KdwHDmcU01JhPNV
         Bq9F+wWEQQ5tV7c9UmvAI+X3CWzL3R0e2Vo4y/OJhC+Q/1amaASVE7w5mH5k+bbFG1jA
         wRgBprCrTIrNPjuO56ZRm3Vjyv4ZJsDDjbmGyCJXoMCA2T0TBPAWe+/DQKLeJZ+CIrJP
         7gPBedFvoO6wG3diINpIwu3pGaOmD8MLRNwJOiAvB/SGca5vL0Y3LUbVHbfy/laplQwT
         s0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aHEcr4bSN1zx2FiEMYBhMzgQIQxqAhuq0PemUwVcZMc=;
        b=YAlgsdMh6zSm3OmPkLWpgXfcRGcaEZoKyUYfABPOrDrU8BUNpzc+JTFCA0s+ynjgGz
         ytnOOTQzqw0UMay8wSz97eJ+xFD2iF7Recf32xy/0n8DlLWLSS+alDA3UKrHSk+Yxmjs
         UPO50VINSOCq3ZCvJuMIP6kDLhiz7zxsbJJFaqv4TzRMibvi824A/M8Iw3WPT9L2Q/0m
         p7T0HTNw8yQOYarfCLCwBZBU/rsk1sVx7VkatYNlM8lu6+mOuBC8aG7se58CZUoK77h+
         E7vUK7gKTIXQeDkKYSTmAAZcTHcTNcmutaO+R3uIZH2F/fABfIWTDW3QOXaeko2x7Sac
         BA8g==
X-Gm-Message-State: AOAM532afrUK+XLvTTcbFZxN6gKg5zYPzvkYzVPrm4QG6M9gUli4ZGus
        DhOrlrr+oHc1ZOoHV35PKZWVi12QB+wGczNHCs6w5A==
X-Google-Smtp-Source: ABdhPJx0b8YVu7rdN1I7HqOu9IoKI4q9eHnmGHiqxjmUPNYuhHmSXBuJjGwjX9ZjFoRWPWz4LF2jbblYZ1gYh8hSE7c=
X-Received: by 2002:a05:651c:202:: with SMTP id y2mr6385586ljn.162.1610337613243;
 Sun, 10 Jan 2021 20:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com> <20210107092652.3438696-4-atish.patra@wdc.com>
In-Reply-To: <20210107092652.3438696-4-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Jan 2021 09:30:01 +0530
Message-ID: <CAAhSdy3XsG3J1nE-nQhiJe5vVTa-1f09t=FY4AMRv7HtdoK=-w@mail.gmail.com>
Subject: Re: [PATCH 3/4] RISC-V: Fix L1_CACHE_BYTES for RV32
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
> SMP_CACHE_BYTES/L1_CACHE_BYTES should be defined as 32 instead of
> 64 for RV32. Otherwise, there will be hole of 32 bytes with each memblock
> allocation if it is requested to be aligned with SMP_CACHE_BYTES.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

> ---
>  arch/riscv/include/asm/cache.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cache.h b/arch/riscv/include/asm/cache.h
> index 9b58b104559e..c9c669ea2fe6 100644
> --- a/arch/riscv/include/asm/cache.h
> +++ b/arch/riscv/include/asm/cache.h
> @@ -7,7 +7,11 @@
>  #ifndef _ASM_RISCV_CACHE_H
>  #define _ASM_RISCV_CACHE_H
>
> +#ifdef CONFIG_64BIT
>  #define L1_CACHE_SHIFT         6
> +#else
> +#define L1_CACHE_SHIFT         5
> +#endif
>
>  #define L1_CACHE_BYTES         (1 << L1_CACHE_SHIFT)
>
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
