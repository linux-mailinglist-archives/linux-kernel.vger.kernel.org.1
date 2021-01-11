Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB162F0B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 04:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhAKDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 22:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbhAKDzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 22:55:48 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268A3C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 19:55:07 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 23so35747434lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 19:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sr+DncRAcarFLKh+c+QBPllXcM43qLzk8obliPGN9Yw=;
        b=D9J3THCj5CqRjAq44aFvUouVNflCAlU6BtEqn9WlmQJdBqibVt4+C1olA6K1Hx+oYJ
         MxyqZKzagqRPw6w4zr+dYjFjMG9u90U75FQec6J9WTDjDMXzZCJv5LDT1QE2gRNKQj6G
         31jfKQS5Crz8lkofGpdlY7GyrI5yMxVpS7rOA0PQbHi6PgtLqBT/JvLLcdkIVieX7MQW
         I5GzmOhbaaF5FQ9IvAAoL83TQBdwKH6/+++4gqH4y2vWp1Fx+UFTZpVmcmrM0H9strQh
         g4j04MaExqNuNETyzynJ/K+81zakwGhxeEMd78Y6FqP+DQkhO+OVcOoiinLPH4lLPgMA
         zTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sr+DncRAcarFLKh+c+QBPllXcM43qLzk8obliPGN9Yw=;
        b=TNfohvOk/9o8sC4jXWKPLi3dSklcCssg+AYJIMSWgvB9ZM7qqmSzVIFpf5PfV/Eo8S
         SsmMEBhM79QGs1g9v33AvFpNE0ChOclvlLrCLgeH4IBqIliCljJ2PFf4kaN5y4+Ao3cG
         rjFj35J55ziCb50RemgVIl1nKLhB/+9g1Czm9P2LRdWg7O/cxCW87GsGiLl5MQyV0SJZ
         goPzz+UbntD3PkVs0QUy9QkZnVrR+WjwZyzrQmiQt+8ZlZwdRYpopXD0MWdC82WJdbrT
         8Ve2OdsInaRP4Q21eNgub/UyqAHQWRcV10f6IxfnMBfTadT1KlAkHFcDY0YrYjZgvoGO
         KJBw==
X-Gm-Message-State: AOAM532AvXQhP/Bw7wuFmi0xOZyp2ELBLKjrR0o9T+Pu7FZPhTiZABRm
        cfpCLev7Yx5ZTRcp9XnLd6u9QefHCsYl+eFGTRssWA==
X-Google-Smtp-Source: ABdhPJwSTCYozEDXX/n9jG6dUUyxKByayKPK2cjAmLTDI35N2IEkJUHSvfV/zxQ6DiYjOCAZazMut9CGI1Wj6X+013U=
X-Received: by 2002:a05:6512:34c5:: with SMTP id w5mr6213401lfr.214.1610337304823;
 Sun, 10 Jan 2021 19:55:04 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com> <20210107092652.3438696-2-atish.patra@wdc.com>
In-Reply-To: <20210107092652.3438696-2-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 11 Jan 2021 09:24:52 +0530
Message-ID: <CAAhSdy1h3ALfg5VVC8_Tq24mji=4Ds9DByqwmE2A3b_Kq2ZphQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] RISC-V: Do not allocate memblock while iterating
 reserved memblocks
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
> Currently, resource tree allocates memory blocks while iterating on the
> list. It leads to following kernel warning because memblock allocation
> also invokes memory block reservation API.
>
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at kernel/resource.c:795
> __insert_resource+0x8e/0xd0
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 5.10.0-00022-ge20097fb37e2-dirty #549
> [    0.000000] epc: c00125c2 ra : c001262c sp : c1c01f50
> [    0.000000]  gp : c1d456e0 tp : c1c0a980 t0 : ffffcf20
> [    0.000000]  t1 : 00000000 t2 : 00000000 s0 : c1c01f60
> [    0.000000]  s1 : ffffcf00 a0 : ffffff00 a1 : c1c0c0c4
> [    0.000000]  a2 : 80c12b15 a3 : 80402000 a4 : 80402000
> [    0.000000]  a5 : c1c0c0c4 a6 : 80c12b15 a7 : f5faf600
> [    0.000000]  s2 : c1c0c0c4 s3 : c1c0e000 s4 : c1009a80
> [    0.000000]  s5 : c1c0c000 s6 : c1d48000 s7 : c1613b4c
> [    0.000000]  s8 : 00000fff s9 : 80000200 s10: c1613b40
> [    0.000000]  s11: 00000000 t3 : c1d4a000 t4 : ffffffff
>
> This is also unnecessary as we can pre-compute the total memblocks required
> for each memory region and allocate it before the loop. It save precious
> boot time not going through memblock allocation code every time.
>
> Fixes: 00ab027a3b82 ("RISC-V: Add kernel image sections to the resource tree")
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

> ---
>  arch/riscv/kernel/setup.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 1d85e9bf783c..3fa3f26dde85 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -127,7 +127,9 @@ static void __init init_resources(void)
>  {
>         struct memblock_region *region = NULL;
>         struct resource *res = NULL;
> -       int ret = 0;
> +       struct resource *mem_res = NULL;
> +       size_t mem_res_sz = 0;
> +       int ret = 0, i = 0;
>
>         code_res.start = __pa_symbol(_text);
>         code_res.end = __pa_symbol(_etext) - 1;
> @@ -145,16 +147,17 @@ static void __init init_resources(void)
>         bss_res.end = __pa_symbol(__bss_stop) - 1;
>         bss_res.flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
> +       mem_res_sz = (memblock.memory.cnt + memblock.reserved.cnt) * sizeof(*mem_res);
> +       mem_res = memblock_alloc(mem_res_sz, SMP_CACHE_BYTES);
> +       if (!mem_res)
> +               panic("%s: Failed to allocate %zu bytes\n", __func__, mem_res_sz);
>         /*
>          * Start by adding the reserved regions, if they overlap
>          * with /memory regions, insert_resource later on will take
>          * care of it.
>          */
>         for_each_reserved_mem_region(region) {
> -               res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
> -               if (!res)
> -                       panic("%s: Failed to allocate %zu bytes\n", __func__,
> -                             sizeof(struct resource));
> +               res = &mem_res[i++];
>
>                 res->name = "Reserved";
>                 res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> @@ -171,8 +174,10 @@ static void __init init_resources(void)
>                  * Ignore any other reserved regions within
>                  * system memory.
>                  */
> -               if (memblock_is_memory(res->start))
> +               if (memblock_is_memory(res->start)) {
> +                       memblock_free((phys_addr_t) res, sizeof(struct resource));
>                         continue;
> +               }
>
>                 ret = add_resource(&iomem_resource, res);
>                 if (ret < 0)
> @@ -181,10 +186,7 @@ static void __init init_resources(void)
>
>         /* Add /memory regions to the resource tree */
>         for_each_mem_region(region) {
> -               res = memblock_alloc(sizeof(struct resource), SMP_CACHE_BYTES);
> -               if (!res)
> -                       panic("%s: Failed to allocate %zu bytes\n", __func__,
> -                             sizeof(struct resource));
> +               res = &mem_res[i++];
>
>                 if (unlikely(memblock_is_nomap(region))) {
>                         res->name = "Reserved";
> @@ -205,9 +207,9 @@ static void __init init_resources(void)
>         return;
>
>   error:
> -       memblock_free((phys_addr_t) res, sizeof(struct resource));
>         /* Better an empty resource tree than an inconsistent one */
>         release_child_resources(&iomem_resource);
> +       memblock_free((phys_addr_t) mem_res, mem_res_sz);
>  }
>
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
