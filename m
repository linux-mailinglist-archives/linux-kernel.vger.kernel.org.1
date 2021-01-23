Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4D13012E5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 04:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbhAWD53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 22:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbhAWD5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 22:57:24 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C67C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:56:43 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id m5so5091255pjv.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 19:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZFKvUjQEqDP7dqlPLI+l3jxa5NuIGx5+bmxfTHNs2ZM=;
        b=xk8eS4U00k+Z8ur0NGybpW7vUIoEx6pspc4cIHNb9Ty0wJuHbgD3GVQb/xwh/uiSV8
         8xYi4Wc+933ZmNr2rrDjgiRbLdU0a9APUhC7tDxWH2CRTJvdapyXsip8djw7SJWrnwAa
         fhIZJw7YHNjsHHYB03CY0YPDo3uL0orTFDBNeC/kE8fCqzw3KbIHzm2vede8lzeLV8Xb
         Uia3xl3LIshFXOY83UN4FY+czx6wsL8OtWKF7Dba14uTVMQqck4+giiEfXx+IH1wOCt4
         FqdvrUadniai8La6s/2G3FhSnCbvAh+wUUwTILf6AyRTK9Ld+Q0meX+k/mEEdZ77lDnI
         vN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZFKvUjQEqDP7dqlPLI+l3jxa5NuIGx5+bmxfTHNs2ZM=;
        b=sCgQwn27Kr0qq6uLWkep254JBFL3gGaGE8HU5NziOMY6M0lFp1jVG35lAXeWAjbUli
         qaPAUbpDN/vTp+Fu3b4PqVgRn1DO36h5+SwBpdiaABKu8z5AK80opL5vV/G8Is0AypjP
         65/+ydkiLF21ZHgui6jtPEX9SSdfJ/B0aKxdQsFBdoVEIMWXQE/z8RCj4QQu6AiEOMoe
         /crse2Z58DCK58FdZCXguggq0ImLyAIySoB30ueUueVqjN1vFWKMm1hf2f0QsZfjOl3o
         NzscO6ZXdwQheJjmHdC7FfXNR8GkF/pUDx5wdFKdIJtCf46DiWlMEzi8lGD9FFj5JMN9
         22Rg==
X-Gm-Message-State: AOAM531JkrmkpH3NzuDqJOpyvp7Jp97m/OD4Z++RnprBS5Ta5SSrFMbX
        ZbTq5hY70rr3LapSe1A/Z/jEqY7DJ59xUg==
X-Google-Smtp-Source: ABdhPJxM9hCcASZqov6JudlqdumnnZI8ha8I3iIJt9EaNAd8HOaEcV8/DV7TrtTgkRmYnRTLu0CAuw==
X-Received: by 2002:a17:902:7596:b029:da:b7a3:cdd0 with SMTP id j22-20020a1709027596b02900dab7a3cdd0mr7837480pll.14.1611374202834;
        Fri, 22 Jan 2021 19:56:42 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c5sm10690982pjo.4.2021.01.22.19.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 19:56:41 -0800 (PST)
Date:   Fri, 22 Jan 2021 19:56:41 -0800 (PST)
X-Google-Original-Date: Fri, 22 Jan 2021 19:52:19 PST (-0800)
Subject:     Re: [PATCH v2 1/1] riscv/kasan: add KASAN_VMALLOC support
In-Reply-To: <20210116055836.22366-2-nylon7@andestech.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        kasan-dev@googlegroups.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, aryabinin@virtuozzo.com, glider@google.com,
        dvyukov@google.com, nylon7717@gmail.com, alankao@andestech.com,
        nickhu@andestech.com, nylon7@andestech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     nylon7@andestech.com
Message-ID: <mhng-443fd141-b9a3-4be6-a056-416877f99ea4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 21:58:35 PST (-0800), nylon7@andestech.com wrote:
> It references to x86/s390 architecture.
>
> So, it doesn't map the early shadow page to cover VMALLOC space.
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
>  arch/riscv/mm/kasan_init.c | 57 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
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
> index 12ddd1f6bf70..4b9149f963d3 100644
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
> +	void *ptr = memblock_alloc_try_nid(size, size,
> +		__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
> +
> +	if (!ptr)
> +		panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d from=%llx\n",
> +			__func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
> +
> +	return ptr;
> +}
>
>  extern pgd_t early_pg_dir[PTRS_PER_PGD];
>  asmlinkage void __init kasan_early_init(void)
> @@ -83,6 +96,40 @@ static void __init populate(void *start, void *end)
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
> +		p4d_k  = p4d_offset(pgd_k, vaddr);
> +
> +		vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
> +		pud_dir = pud_offset(p4d_dir, vaddr);
> +		pud_k = pud_offset(p4d_k, vaddr);
> +
> +		if (pud_present(*pud_dir)) {
> +			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
> +			pud_populate(&init_mm, pud_dir, p);
> +		}
> +		vaddr += PAGE_SIZE;
> +	}
> +}
> +
>  void __init kasan_init(void)
>  {
>  	phys_addr_t _start, _end;
> @@ -90,7 +137,15 @@ void __init kasan_init(void)
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

Thanks, this is on for-next.
