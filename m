Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856492F1F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403882AbhAKTVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403864AbhAKTVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:13 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839C6C06138D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:14 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id h3so265607ils.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDbikhMgQRIBAGWvHhwnSOWp+tYdIa1L7HqD2Fuhn5o=;
        b=TNk8AsQklmM1D18YtjeuP5msks8k476ei5PZfBL/rN+WUCBbkWH5tSwvzzd5cdrK3z
         Au896fIPreNaHrPS29rJmrmXO89zRZN+HdhQ2txPclH9RI2uPkuron3RBWCrewyB6oiV
         7GbGoIPTWXbxsHAf/Y1gReu0BWWttvce4AbBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDbikhMgQRIBAGWvHhwnSOWp+tYdIa1L7HqD2Fuhn5o=;
        b=Oz6PlXjyTJFyziN4wGcuJJoCl5xZPaHoundK0apDrbxZoWXQpoEMq1uMIujknEOs/G
         aDRIF4A7ikw/bMntoLqd6KeaB2QvK40L8us8Ydc/nz5m9NoZCBXbc+aa1A09JaFJIDEN
         n51Z7mx4Eb9VgNix1e+wIA9zSSix5Kd8WBT75S73S3tkm8O7SuIqKD4CEzaa4TydhGRK
         oSWLxBLwXrMbAR1YdKhfjd9k/FsxKzcXhGNiKnvdMZ5VMoFrFUUUxOYvWyEKgHOhjZ35
         wHbgy/+ZVtJ5dIAr0XR7UQtG0y4PYKIJNVTmL8fNtxhwoA9nMFbXuWPYbSRvzM2Mpq8L
         H+Lg==
X-Gm-Message-State: AOAM530yRquaIZbtrqRcxbh/aGEIVQiSyadVk96BFlNCsCtxAVWT8XR2
        5h9o8k9ukgVXwUGFBfOTVlqEztiLm74jFmma4orO
X-Google-Smtp-Source: ABdhPJzkn7BbM4YArCF4jyHvJMfbgs77ibK0XTF30AzoxUE582rYgBVYQd58Gi8jMJG7GedknFeRdUTeZMhJ8kG+JtQ=
X-Received: by 2002:a92:512:: with SMTP id q18mr590913ile.147.1610392813919;
 Mon, 11 Jan 2021 11:20:13 -0800 (PST)
MIME-Version: 1.0
References: <20210107092652.3438696-1-atish.patra@wdc.com> <20210107092652.3438696-3-atish.patra@wdc.com>
 <CAAhSdy0AdK3YbnqmG_rBAneDSHBZwFSEr5+HkkUm-3SO_--zAQ@mail.gmail.com>
In-Reply-To: <CAAhSdy0AdK3YbnqmG_rBAneDSHBZwFSEr5+HkkUm-3SO_--zAQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 11 Jan 2021 11:20:03 -0800
Message-ID: <CAOnJCUJNC3UzNapLG9yXKF6areRZaN5UvPJOX_YsNk+PY2TFUw@mail.gmail.com>
Subject: Re: [PATCH 2/4] RISC-V: Set current memblock limit
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 7:59 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Thu, Jan 7, 2021 at 2:57 PM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > Currently, linux kernel can not use last 4k bytes of addressable space because
> > IS_ERR_VALUE macro treats those as an error. This will be an issue for RV32
> > as any memblock allocator potentially allocate chunk of memory from the end
> > of DRAM (2GB) leading bad address error even though the address was technically
> > valid.
> >
> > Fix this issue by limiting the memblock if available memory spans the entire
> > address space.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/mm/init.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index bf5379135e39..da53902ef0fc 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -157,9 +157,10 @@ static void __init setup_initrd(void)
> >  void __init setup_bootmem(void)
> >  {
> >         phys_addr_t mem_start = 0;
> > -       phys_addr_t start, end = 0;
> > +       phys_addr_t start, dram_end, end = 0;
> >         phys_addr_t vmlinux_end = __pa_symbol(&_end);
> >         phys_addr_t vmlinux_start = __pa_symbol(&_start);
> > +       phys_addr_t max_mapped_addr = __pa(PHYS_ADDR_MAX);
>
> Using PHYS_ADDR_MAX as the max virtual address does not look right.
>
> Better use __pa(~(ulong)0) here. Otherwise looks good to me.
>

ok will change it. Thanks for the review.

> Reviewed-by: Anup Patel <anup@brainfault.org>
>
> >         u64 i;
> >
> >         /* Find the memory region containing the kernel */
> > @@ -181,7 +182,18 @@ void __init setup_bootmem(void)
> >         /* Reserve from the start of the kernel to the end of the kernel */
> >         memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> >
> > -       max_pfn = PFN_DOWN(memblock_end_of_DRAM());
> > +       dram_end = memblock_end_of_DRAM();
> > +
> > +       /*
> > +        * memblock allocator is not aware of the fact that last 4K bytes of
> > +        * the addressable memory can not be mapped because of IS_ERR_VALUE
> > +        * macro. Make sure that last 4k bytes are not usable by memblock
> > +        * if end of dram is equal to maximum addressable memory.
> > +        */
> > +       if (max_mapped_addr == (dram_end - 1))
> > +               memblock_set_current_limit(max_mapped_addr - 4096);
> > +
> > +       max_pfn = PFN_DOWN(dram_end);
> >         max_low_pfn = max_pfn;
> >         dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
> >         set_max_mapnr(max_low_pfn);
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> Regards,
> Anup
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
