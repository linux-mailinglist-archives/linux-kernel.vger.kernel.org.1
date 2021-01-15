Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27572F708F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 03:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbhAOCZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 21:25:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732085AbhAOCZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 21:25:03 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C33C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:24:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id j13so4334936pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 18:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Cu1r4kHEpk1ipx1WHIOmDfUVLP4Os78haqvXs5XVFiU=;
        b=Zud2h77QBS795wG6yXJKYrE+EwcIZRELGrnX5yhmhtv4zDM0D/nOUTiAvTXeVP2sIO
         L/GSnmxhC8D6JQ6YgphQ4pJjFpxOQa4SyVKkuilYcZlfavsyfqtFjm8plUrNEuW4slPm
         /x528V9+0E7RU2i4JTSfp5f7gF2I1kCLUoqRjVWM0+kgzVnNnAt83iWDiO+sSUZVSbT4
         Qg8dFew5Ph4PFw+zlDZKoZYpypd2Gf8TCDH/GUMIocKwriLl+Aodh9Fu7wl+/wjEjVmG
         RNq7gTt489xXkC1FjodlAIF7iZ5Y5FjQq3VYhMFsFsiClZau/uySQ4uVQMw6vaoLRQXq
         7v4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Cu1r4kHEpk1ipx1WHIOmDfUVLP4Os78haqvXs5XVFiU=;
        b=PAI0EK476EJbpwMpxsIcEEK+2FvCltetu+mVGlB64J8kkfmJclI9V5S64LGlpzLATt
         GeyU7OzWeCyLjsccfYlN6jn/F2nA4Crf7rt9i56xmU28+CKMSKNyko7WIW1tGgSUjNBL
         npIWbEs6wj434XFYpKsKIJT4Ro8TH5PUDDaNlWhT13hhfBo0icDnJm2h/PztlBw0DUJL
         d1gTx7wuZY7ZsbPrxqQfqLs6E5xQ7G1MVQTCVzUh2ct4lWkFcJDjZcmHkPQE+PjamWBc
         CyWqp+wpAa8lscMbiZGpdcz3bx8omEP8UVih2jPVJhKlzJJSlz1pF3NrqV0/eq5Bjerc
         K64g==
X-Gm-Message-State: AOAM533yPCm9aDJZqgoo4P1ETA3A1rFfW2izYWTpS1n+Rq2AghUDR/Nt
        020Xa2j5y2ETXp/IPuKPIgaWWA==
X-Google-Smtp-Source: ABdhPJwZH1E+fKAbcid8dzJLVB3v/Csakmz5hxoyrQbsXKM3WODJcZDSzmxxQFad2rYO5A2oXoftYA==
X-Received: by 2002:a17:90b:a47:: with SMTP id gw7mr8102445pjb.1.1610677462419;
        Thu, 14 Jan 2021 18:24:22 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x12sm6401588pfj.25.2021.01.14.18.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 18:24:21 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:24:21 -0800 (PST)
X-Google-Original-Date: Thu, 14 Jan 2021 18:24:20 PST (-0800)
Subject:     Re: [PATCH 1/1] riscv/kasan: add KASAN_VMALLOC support
In-Reply-To: <20210113022822.9230-2-nylon7@andestech.com>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, dvyukov@google.com,
        glider@google.com, aryabinin@virtuozzo.com, alankao@andestech.com,
        nickhu@andestech.com, nylon7@andestech.com, nylon7717@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nylon7@andestech.com
Message-ID: <mhng-681abd1f-506e-4e1a-88e7-f48af7e6cc0e@penguin>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 18:28:22 PST (-0800), nylon7@andestech.com wrote:
> It's reference x86/s390 architecture.
>
> So, it's don't map the early shadow page to cover VMALLOC space.
>
> Prepopulate top level page table for the range that would otherwise be
> empty.
>
> lower levels are filled dynamically upon memory allocation while
> booting.
>
> Signed-off-by: Nylon Chen <nylon7@andestech.com>
> Signed-off-by: Nick Hu <nickhu@andestech.com>
> ---
>  arch/riscv/Kconfig         |  1 +
>  arch/riscv/mm/kasan_init.c | 66 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 66 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 81b76d44725d..15a2c8088bbe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -57,6 +57,7 @@ config RISCV
>  	select HAVE_ARCH_JUMP_LABEL
>  	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
> +	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
>  	select HAVE_ARCH_KGDB
>  	select HAVE_ARCH_KGDB_QXFER_PKT
>  	select HAVE_ARCH_MMAP_RND_BITS if MMU
> diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
> index 12ddd1f6bf70..ee332513d728 100644
> --- a/arch/riscv/mm/kasan_init.c
> +++ b/arch/riscv/mm/kasan_init.c
> @@ -9,6 +9,19 @@
>  #include <linux/pgtable.h>
>  #include <asm/tlbflush.h>
>  #include <asm/fixmap.h>
> +#include <asm/pgalloc.h>
> +
> +static __init void *early_alloc(size_t size, int node)
> +{
> +        void *ptr = memblock_alloc_try_nid(size, size,
> +                        __pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
> +
> +        if (!ptr)
> +                panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d from=%llx\n",
> +                      __func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
> +
> +        return ptr;
> +}
>
>  extern pgd_t early_pg_dir[PTRS_PER_PGD];
>  asmlinkage void __init kasan_early_init(void)
> @@ -83,6 +96,49 @@ static void __init populate(void *start, void *end)
>  	memset(start, 0, end - start);
>  }
>
> +void __init kasan_shallow_populate(void *start, void *end)
> +{
> +	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
> +	unsigned long vend = PAGE_ALIGN((unsigned long)end);
> +	unsigned long pfn;
> +	int index;
> +	void *p;
> +	pud_t *pud_dir, *pud_k;
> +	pmd_t *pmd_dir, *pmd_k;
> +	pgd_t *pgd_dir, *pgd_k;
> +	p4d_t *p4d_dir, *p4d_k;
> +
> +	while (vaddr < vend) {
> +		index = pgd_index(vaddr);
> +		pfn = csr_read(CSR_SATP) & SATP_PPN;
> +		pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
> +		pgd_k = init_mm.pgd + index;
> +		pgd_dir = pgd_offset_k(vaddr);
> +		set_pgd(pgd_dir, *pgd_k);
> +
> +		p4d_dir = p4d_offset(pgd_dir, vaddr);
> +		p4d_k  = p4d_offset(pgd_k,vaddr);
> +
> +		vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
> +		pud_dir = pud_offset(p4d_dir, vaddr);
> +		pud_k = pud_offset(p4d_k,vaddr);
> +
> +		if (pud_present(*pud_dir)) {
> +			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +			pud_populate(&init_mm, pud_dir, p);
> +		}
> +
> +		pmd_dir = pmd_offset(pud_dir, vaddr);
> +		pmd_k = pmd_offset(pud_k,vaddr);
> +		set_pmd(pmd_dir, *pmd_k);
> +		if (pmd_present(*pmd_dir)) {
> +			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +			pmd_populate(&init_mm, pmd_dir, p);
> +		}
> +		vaddr += PAGE_SIZE;
> +	}
> +}
> +
>  void __init kasan_init(void)
>  {
>  	phys_addr_t _start, _end;
> @@ -90,7 +146,15 @@ void __init kasan_init(void)
>
>  	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
>  				    (void *)kasan_mem_to_shadow((void *)
> -								VMALLOC_END));
> +								VMEMMAP_END));
> +	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
> +		kasan_shallow_populate(
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
> +	else
> +		kasan_populate_early_shadow(
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
> +			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
>
>  	for_each_mem_range(i, &_start, &_end) {
>  		void *start = (void *)_start;

There are a bunch of checkpatch issues here.
