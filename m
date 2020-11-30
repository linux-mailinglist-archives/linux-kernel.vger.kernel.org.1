Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B07812C8370
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgK3LpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:59430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgK3LpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:45:03 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA195206C0;
        Mon, 30 Nov 2020 11:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606736662;
        bh=q82LeZLj+xOvMtauyebaFwznOwFNc6Yx8wgfJmNh8SY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0Z/mBgI9D5ebSNshYuyVnBmQL9bcEj5x5NEnO8qrexx73of1xIse9RjSJSGMw+lJ8
         l0jG0FIjeLqPKjOIcaY0LGYz2SI7UnHEdSaVnz3+XTLAEWWbz3IX3vvn5VFpqPDN32
         fsmvTEcJMbKZ/czI5OUdOXrtKKb3V9uPspKppI7g=
Date:   Mon, 30 Nov 2020 11:44:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] scs: switch to vmapped shadow stacks
Message-ID: <20201130114417.GA24563@willie-the-truck>
References: <20201124195940.27061-1-samitolvanen@google.com>
 <20201124195940.27061-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124195940.27061-2-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:59:39AM -0800, Sami Tolvanen wrote:
> The kernel currently uses kmem_cache to allocate shadow call stacks,
> which means an overflows may not be immediately detected and can
> potentially result in another task's shadow stack to be overwritten.
> 
> This change switches SCS to use virtually mapped shadow stacks for
> tasks, which increases shadow stack size to a full page and provides
> more robust overflow detection, similarly to VMAP_STACK.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/scs.h | 12 ++++-----
>  kernel/scs.c        | 66 +++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 61 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/scs.h b/include/linux/scs.h
> index 6dec390cf154..2a506c2a16f4 100644
> --- a/include/linux/scs.h
> +++ b/include/linux/scs.h
> @@ -15,12 +15,8 @@
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  
> -/*
> - * In testing, 1 KiB shadow stack size (i.e. 128 stack frames on a 64-bit
> - * architecture) provided ~40% safety margin on stack usage while keeping
> - * memory allocation overhead reasonable.
> - */
> -#define SCS_SIZE		SZ_1K
> +#define SCS_ORDER		0
> +#define SCS_SIZE		(PAGE_SIZE << SCS_ORDER)
>  #define GFP_SCS			(GFP_KERNEL | __GFP_ZERO)
>  
>  /* An illegal pointer value to mark the end of the shadow stack. */
> @@ -33,6 +29,8 @@
>  #define task_scs(tsk)		(task_thread_info(tsk)->scs_base)
>  #define task_scs_sp(tsk)	(task_thread_info(tsk)->scs_sp)
>  
> +void *scs_alloc(int node);
> +void scs_free(void *s);
>  void scs_init(void);
>  int scs_prepare(struct task_struct *tsk, int node);
>  void scs_release(struct task_struct *tsk);
> @@ -61,6 +59,8 @@ static inline bool task_scs_end_corrupted(struct task_struct *tsk)
>  
>  #else /* CONFIG_SHADOW_CALL_STACK */
>  
> +static inline void *scs_alloc(int node) { return NULL; }
> +static inline void scs_free(void *s) {}
>  static inline void scs_init(void) {}
>  static inline void scs_task_reset(struct task_struct *tsk) {}
>  static inline int scs_prepare(struct task_struct *tsk, int node) { return 0; }
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 4ff4a7ba0094..25b0dd5aa0e2 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -5,50 +5,94 @@
>   * Copyright (C) 2019 Google LLC
>   */
>  
> +#include <linux/cpuhotplug.h>
>  #include <linux/kasan.h>
>  #include <linux/mm.h>
>  #include <linux/scs.h>
> -#include <linux/slab.h>
> +#include <linux/vmalloc.h>
>  #include <linux/vmstat.h>
>  
> -static struct kmem_cache *scs_cache;
> -
>  static void __scs_account(void *s, int account)
>  {
> -	struct page *scs_page = virt_to_page(s);
> +	struct page *scs_page = vmalloc_to_page(s);
>  
>  	mod_node_page_state(page_pgdat(scs_page), NR_KERNEL_SCS_KB,
>  			    account * (SCS_SIZE / SZ_1K));
>  }
>  
> -static void *scs_alloc(int node)
> +/* Matches NR_CACHED_STACKS for VMAP_STACK */
> +#define NR_CACHED_SCS 2
> +static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
> +
> +void *scs_alloc(int node)
>  {
> -	void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
> +	int i;
> +	void *s;
> +
> +	for (i = 0; i < NR_CACHED_SCS; i++) {
> +		s = this_cpu_xchg(scs_cache[i], NULL);
> +		if (s) {
> +			kasan_unpoison_vmalloc(s, SCS_SIZE);
> +			memset(s, 0, SCS_SIZE);
> +			goto out;
> +		}
> +	}
> +
> +	s = __vmalloc_node_range(SCS_SIZE, 1, VMALLOC_START, VMALLOC_END,
> +				 GFP_SCS, PAGE_KERNEL, 0, node,
> +				 __builtin_return_address(0));
>  
>  	if (!s)
>  		return NULL;

Sorry I didn't spot this before, but if you put the xchg/vmalloc code
into a new __scs_alloc() function then you can drop the label and this
becomes:

	s = __scs_alloc(...);
	if (!s)
		return NULL;

	*__scs_maghic(s) = SCS_ENG_MAGIC;
	...

With that:

Acked-by: Will Deacon <will@kernel.org>

Will
