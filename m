Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8160A29A8BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896716AbgJ0KAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:00:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896065AbgJ0KAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:00:50 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AC121D24;
        Tue, 27 Oct 2020 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603792849;
        bh=2hAVw7qTLLEVUjRphlgAEOwljehMZXHfQC2jV2K8ui0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOyB0HW/7z4g1FehneF2cfcYLtAIowP4KQMZ7ef+hnI65OHvV+UODT7Wc1S7b44i+
         MReM9XB2fwBhhFkUxqUuEkojM2zjDvmK8w7FuHpWpfSbX98lLw3oCHQuOc5UBhZdGd
         ya0LdjCCp3h0366X6EZ7+DL31CdpMvhor91EJh5A=
Date:   Tue, 27 Oct 2020 12:00:40 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v2 3/6] RISC-V: Enforce protections for kernel sections
 early
Message-ID: <20201027100040.GK1154158@kernel.org>
References: <20201026230254.911912-1-atish.patra@wdc.com>
 <20201026230254.911912-4-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026230254.911912-4-atish.patra@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 04:02:51PM -0700, Atish Patra wrote:
> Currently, all memblocks are mapped with PAGE_KERNEL_EXEC and the strict
> permissions are only enforced after /init starts. This leaves the kernel
> vulnerable from possible buggy built-in modules.
> 
> Apply permissions to individual sections as early as possible.
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/set_memory.h |  2 ++
>  arch/riscv/kernel/setup.c           |  2 ++
>  arch/riscv/mm/init.c                | 11 +++++++++--
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index 4c5bae7ca01c..4cc3a4e2afd3 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -15,11 +15,13 @@ int set_memory_ro(unsigned long addr, int numpages);
>  int set_memory_rw(unsigned long addr, int numpages);
>  int set_memory_x(unsigned long addr, int numpages);
>  int set_memory_nx(unsigned long addr, int numpages);
> +void protect_kernel_text_data(void);
>  #else
>  static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
>  static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
> +static inline void protect_kernel_text_data(void) {};
>  #endif
>  
>  int set_direct_map_invalid_noflush(struct page *page);
> diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> index 7d6a04ae3929..b722c5bf892c 100644
> --- a/arch/riscv/kernel/setup.c
> +++ b/arch/riscv/kernel/setup.c
> @@ -22,6 +22,7 @@
>  #include <asm/cpu_ops.h>
>  #include <asm/early_ioremap.h>
>  #include <asm/setup.h>
> +#include <asm/set_memory.h>
>  #include <asm/sections.h>
>  #include <asm/sbi.h>
>  #include <asm/tlbflush.h>
> @@ -92,6 +93,7 @@ void __init setup_arch(char **cmdline_p)
>  #if IS_ENABLED(CONFIG_RISCV_SBI)
>  	sbi_init();
>  #endif
> +	protect_kernel_text_data();
>  #ifdef CONFIG_SWIOTLB
>  	swiotlb_init(1);
>  #endif
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index ea933b789a88..5f196f8158d4 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -608,7 +608,7 @@ static inline void setup_vm_final(void)
>  #endif /* CONFIG_MMU */
>  
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> -void mark_rodata_ro(void)
> +void protect_kernel_text_data(void)
>  {
>  	unsigned long text_start = (unsigned long)_text;
>  	unsigned long text_end = (unsigned long)_etext;
> @@ -617,9 +617,16 @@ void mark_rodata_ro(void)
>  	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
>  

A comment about that rodata permissions are set later would be nice
here.

>  	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
> -	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>  	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>  	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> +}
> +
> +void mark_rodata_ro(void)
> +{
> +	unsigned long rodata_start = (unsigned long)__start_rodata;
> +	unsigned long data_start = (unsigned long)_data;
> +
> +	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>  
>  	debug_checkwx();
>  }
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
