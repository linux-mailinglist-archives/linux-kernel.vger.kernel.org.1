Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C96061A10D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 17:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgDGP64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 11:58:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgDGP64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:58:56 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A1C92072A;
        Tue,  7 Apr 2020 15:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586275135;
        bh=ltIOImB02Z71XhE+ab4AZjqWho6FXnB/SdX/vjB8BxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dmp90ubmZP2czndVvQXWl03wmMM9mO/JPcATNHy2z9xFFl+W4sASxc89XShQvJ65d
         4xBUn2UodHNybm6HuKbb4TjlB2WCP09XP22hvEsQ/aWcT7vXtKseuW/MtYicFijNS1
         GJpAlD3EXfNGs7i9RmNFzytbek/t01G3FwTWAehI=
Date:   Wed, 8 Apr 2020 00:58:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/9] riscv: introduce interfaces to patch kernel code
Message-Id: <20200408005850.5e1a7666013f080ff60020e2@kernel.org>
In-Reply-To: <a491ce48973a0b4f0eed3fe4e97d6a07cb6d6ae8.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
        <a491ce48973a0b4f0eed3fe4e97d6a07cb6d6ae8.1586265122.git.zong.li@sifive.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zong,

On Tue,  7 Apr 2020 22:46:47 +0800
Zong Li <zong.li@sifive.com> wrote:

> On strict kernel memory permission, we couldn't patch code without
> writable permission. Preserve two holes in fixmap area, so we can map
> the kernel code temporarily to fixmap area, then patch the instructions.
> 
> We need two pages here because we support the compressed instruction, so
> the instruction might be align to 2 bytes. When patching the 32-bit
> length instruction which is 2 bytes alignment, it will across two pages.
> 
> Introduce two interfaces to patch kernel code:
> riscv_patch_text_nosync:
>  - patch code without synchronization, it's caller's responsibility to
>    synchronize all CPUs if needed.
> riscv_patch_text:
>  - patch code and always synchronize with stop_machine()
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/riscv/include/asm/fixmap.h |   2 +
>  arch/riscv/include/asm/patch.h  |  12 ++++
>  arch/riscv/kernel/Makefile      |   4 +-
>  arch/riscv/kernel/patch.c       | 120 ++++++++++++++++++++++++++++++++
>  4 files changed, 137 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/patch.h
>  create mode 100644 arch/riscv/kernel/patch.c
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 42d2c42f3cc9..2368d49eb4ef 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -27,6 +27,8 @@ enum fixed_addresses {
>  	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>  	FIX_PTE,
>  	FIX_PMD,
> +	FIX_TEXT_POKE1,
> +	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
>  	__end_of_fixed_addresses
>  };
> diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
> new file mode 100644
> index 000000000000..9a7d7346001e
> --- /dev/null
> +++ b/arch/riscv/include/asm/patch.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 SiFive
> + */
> +
> +#ifndef _ASM_RISCV_PATCH_H
> +#define _ASM_RISCV_PATCH_H
> +
> +int patch_text_nosync(void *addr, const void *insns, size_t len);
> +int patch_text(void *addr, u32 insn);
> +
> +#endif /* _ASM_RISCV_PATCH_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f40205cb9a22..d189bd3d8501 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -4,7 +4,8 @@
>  #
>  
>  ifdef CONFIG_FTRACE
> -CFLAGS_REMOVE_ftrace.o = -pg
> +CFLAGS_REMOVE_ftrace.o	= -pg
> +CFLAGS_REMOVE_patch.o	= -pg
>  endif
>  
>  extra-y += head.o
> @@ -26,6 +27,7 @@ obj-y	+= traps.o
>  obj-y	+= riscv_ksyms.o
>  obj-y	+= stacktrace.o
>  obj-y	+= cacheinfo.o
> +obj-y	+= patch.o
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
>  obj-$(CONFIG_RISCV_M_MODE)	+= clint.o
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> new file mode 100644
> index 000000000000..5b4f0d37097f
> --- /dev/null
> +++ b/arch/riscv/kernel/patch.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 SiFive
> + */
> +
> +#include <linux/spinlock.h>
> +#include <linux/mm.h>
> +#include <linux/uaccess.h>
> +#include <linux/stop_machine.h>
> +#include <asm/kprobes.h>
> +#include <asm/cacheflush.h>
> +#include <asm/fixmap.h>
> +
> +struct patch_insn_patch {
> +	void *addr;
> +	u32 insn;
> +	atomic_t cpu_count;
> +};
> +
> +#ifdef CONFIG_MMU
> +static void *patch_map(void *addr, int fixmap)
> +{
> +	uintptr_t uintaddr = (uintptr_t) addr;
> +	struct page *page;
> +
> +	if (core_kernel_text(uintaddr))
> +		page = phys_to_page(__pa_symbol(addr));
> +	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> +		page = vmalloc_to_page(addr);
> +	else
> +		return addr;
> +
> +	BUG_ON(!page);
> +
> +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> +					 (uintaddr & ~PAGE_MASK));
> +}
> +NOKPROBE_SYMBOL(patch_map);
> +
> +static void patch_unmap(int fixmap)
> +{
> +	clear_fixmap(fixmap);
> +}
> +NOKPROBE_SYMBOL(patch_unmap);
> +

Please leave a comment here about text_mutex,

> +static int patch_insn_write(void *addr, const void *insn, size_t len)
> +{
> +	void *waddr = addr;
> +	bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> +	int ret;

Or use lockdep_assert_held(&text_mutex); here so that user can easily
understand they have to lock the text_mutex before calling this.

Thank you,

> +
> +	if (across_pages)
> +		patch_map(addr + len, FIX_TEXT_POKE1);
> +
> +	waddr = patch_map(addr, FIX_TEXT_POKE0);
> +
> +	ret = probe_kernel_write(waddr, insn, len);
> +
> +	patch_unmap(FIX_TEXT_POKE0);
> +
> +	if (across_pages)
> +		patch_unmap(FIX_TEXT_POKE1);
> +
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(patch_insn_write);
> +#else
> +static int patch_insn_write(void *addr, const void *insn, size_t len)
> +{
> +	return probe_kernel_write(addr, insn, len);
> +}
> +NOKPROBE_SYMBOL(patch_insn_write);
> +#endif /* CONFIG_MMU */
> +
> +int patch_text_nosync(void *addr, const void *insns, size_t len)
> +{
> +	u32 *tp = addr;
> +	int ret;
> +
> +	ret = patch_insn_write(tp, insns, len);
> +
> +	if (!ret)
> +		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> +
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(patch_text_nosync);
> +
> +static int patch_text_cb(void *data)
> +{
> +	struct patch_insn_patch *patch = data;
> +	int ret = 0;
> +
> +	if (atomic_inc_return(&patch->cpu_count) == 1) {
> +		ret =
> +		    patch_text_nosync(patch->addr, &patch->insn,
> +					    GET_INSN_LENGTH(patch->insn));
> +		atomic_inc(&patch->cpu_count);
> +	} else {
> +		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
> +			cpu_relax();
> +		smp_mb();
> +	}
> +
> +	return ret;
> +}
> +NOKPROBE_SYMBOL(patch_text_cb);
> +
> +int patch_text(void *addr, u32 insn)
> +{
> +	struct patch_insn_patch patch = {
> +		.addr = addr,
> +		.insn = insn,
> +		.cpu_count = ATOMIC_INIT(0),
> +	};
> +
> +	return stop_machine_cpuslocked(patch_text_cb,
> +				       &patch, cpu_online_mask);
> +}
> +NOKPROBE_SYMBOL(patch_text);
> -- 
> 2.26.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
