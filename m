Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0662F0BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbhAKD7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbhAKD7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:59:41 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55566C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 19:59:01 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id p13so2015313ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 19:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cAZNgRoYkzoP/BhJ9P6BIGZW8pFnUjY93pDjiW7NME=;
        b=lPp5vs7bcac0seBLFXigYh8T8CRIzbqwfqeJQqIY8Zg3c3dsvEecwg3f5K9aG5frIc
         UgcK38xPhVYBfPmZzr0ilMolRlyXVmPChbHqJZUt5/3GQtCDzaMmbvDR9iUDrQPGnXAO
         OuDAUJl7+7PQQflYSTa3O9YrmOPFf4DzyL8eR8bF54jYz5dF2R3mMQm1fmzb/fLJ+1zb
         rU3q2KTVeueNbTnWT9KcA/yu8tSYxIvgMRJppmOuPDmOzxrq63b1sNkntRO2+a6ED3rX
         JGxs8GiyOADfzzc3FkcmwpHi2KJEJg8KLTeSutGPh6lISKHbqmwLi6qOx8MmA00cVGtR
         IKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cAZNgRoYkzoP/BhJ9P6BIGZW8pFnUjY93pDjiW7NME=;
        b=HRhjUewKb6xdTRLvKulNMTnmjys4CLUxBv8bmAmiP513GhrrkaNN8y3vo2G2rwOo75
         HDek4xQ3bosouMyZYqr90xwLCx7wH4a0wZXj/978AdhbBJFuFu/3j0Me8kvA8Ph6iD9t
         qT/KfzaijVbgULbGMNTfmC+bkeLiHjqV23XQVZsttbp09WUvywuH2x8IpzLpYHAsMG+D
         31Naq0cMiUzDL4N4Esh+QsBySMfPjQoj4Ax/5AHHTJ9qJumeqFqG3bAF+GCCcStjTSya
         zZazJY4oEuPXJSIqLvaZnC1x2Soo8ZHa3Ob6vhbdkSlN8zQxWS15g4fWsYEzROWTiRUk
         AnZQ==
X-Gm-Message-State: AOAM531gtBOJKGaPNO+BfELCG3LhKIMTQ4jTjYMczRLztDF/cH2TlidQ
        OKmF//LrxpEZ5YAcsBhroqcPdcaaEsIwZgJm2qVgEA==
X-Google-Smtp-Source: ABdhPJyjA7Xd2SY/nPT2Ibiuxa5VDtx2rZYvW6pqu5Woy+jyyau4j3Yb6SuGX8YGMnYm65G+vp62WShyrLs61GPCQsE=
X-Received: by 2002:a2e:8e98:: with SMTP id z24mr6326578ljk.83.1610337539722;
 Sun, 10 Jan 2021 19:58:59 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com> <20210107092652.3438696-3-atish.patra@wdc.com>
In-Reply-To: <20210107092652.3438696-3-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Jan 2021 09:28:48 +0530
Message-ID: <CAAhSdy0AdK3YbnqmG_rBAneDSHBZwFSEr5+HkkUm-3SO_--zAQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] RISC-V: Set current memblock limit
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
> Currently, linux kernel can not use last 4k bytes of addressable space because
> IS_ERR_VALUE macro treats those as an error. This will be an issue for RV32
> as any memblock allocator potentially allocate chunk of memory from the end
> of DRAM (2GB) leading bad address error even though the address was technically
> valid.
>
> Fix this issue by limiting the memblock if available memory spans the entire
> address space.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/mm/init.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index bf5379135e39..da53902ef0fc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -157,9 +157,10 @@ static void __init setup_initrd(void)
>  void __init setup_bootmem(void)
>  {
>         phys_addr_t mem_start = 0;
> -       phys_addr_t start, end = 0;
> +       phys_addr_t start, dram_end, end = 0;
>         phys_addr_t vmlinux_end = __pa_symbol(&_end);
>         phys_addr_t vmlinux_start = __pa_symbol(&_start);
> +       phys_addr_t max_mapped_addr = __pa(PHYS_ADDR_MAX);

Using PHYS_ADDR_MAX as the max virtual address does not look right.

Better use __pa(~(ulong)0) here. Otherwise looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

>         u64 i;
>
>         /* Find the memory region containing the kernel */
> @@ -181,7 +182,18 @@ void __init setup_bootmem(void)
>         /* Reserve from the start of the kernel to the end of the kernel */
>         memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
>
> -       max_pfn = PFN_DOWN(memblock_end_of_DRAM());
> +       dram_end = memblock_end_of_DRAM();
> +
> +       /*
> +        * memblock allocator is not aware of the fact that last 4K bytes of
> +        * the addressable memory can not be mapped because of IS_ERR_VALUE
> +        * macro. Make sure that last 4k bytes are not usable by memblock
> +        * if end of dram is equal to maximum addressable memory.
> +        */
> +       if (max_mapped_addr == (dram_end - 1))
> +               memblock_set_current_limit(max_mapped_addr - 4096);
> +
> +       max_pfn = PFN_DOWN(dram_end);
>         max_low_pfn = max_pfn;
>         dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
>         set_max_mapnr(max_low_pfn);
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
