Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ABE2B9305
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 14:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgKSNAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 08:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:60664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKSNAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 08:00:42 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE3D21D7A;
        Thu, 19 Nov 2020 13:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605790841;
        bh=ja+JT64H0gAXExMDxLYTjSNxoWo2kCsdj3sIaapeov0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dZtiwdg8DaBZXZmXS6Ob+AqkJSsAt7Wp0rJ1sQiO0DmRUk+3SQQ7AOso9LLG4++/c
         XfMAjTawBdBrsDym3KZ1uV9mi7uSKhCKjJFqCl8FxzggC5bii73sMpg4oJ4g3kYvmE
         iliUFMORnSzBKxZNdfmt3SZnssSxYzXr8BbnAB90=
Date:   Thu, 19 Nov 2020 13:00:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] scs: switch to vmapped shadow stacks
Message-ID: <20201119130036.GA4331@willie-the-truck>
References: <20201022202355.3529836-1-samitolvanen@google.com>
 <20201022202355.3529836-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022202355.3529836-2-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

On Thu, Oct 22, 2020 at 01:23:54PM -0700, Sami Tolvanen wrote:
> The kernel currently uses kmem_cache to allocate shadow call stacks,
> which means an overflow may not be immediately detected and can
> potentially result in another task's shadow stack to be overwritten.
> 
> This change switches SCS to use virtually mapped shadow stacks,
> which increases shadow stack size to a full page and provides more
> robust overflow detection similarly to VMAP_STACK.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  include/linux/scs.h |  7 +----
>  kernel/scs.c        | 63 ++++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 55 insertions(+), 15 deletions(-)

Cheers for posting this. I _much_ prefer handling the SCS this way, but I
have some comments on the implementation below.

> diff --git a/include/linux/scs.h b/include/linux/scs.h
> index 6dec390cf154..86e3c4b7b714 100644
> --- a/include/linux/scs.h
> +++ b/include/linux/scs.h
> @@ -15,12 +15,7 @@
>  
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  
> -/*
> - * In testing, 1 KiB shadow stack size (i.e. 128 stack frames on a 64-bit
> - * architecture) provided ~40% safety margin on stack usage while keeping
> - * memory allocation overhead reasonable.
> - */
> -#define SCS_SIZE		SZ_1K
> +#define SCS_SIZE		PAGE_SIZE

We could make this SCS_ORDER and then forget about alignment etc.

>  #define GFP_SCS			(GFP_KERNEL | __GFP_ZERO)
>  
>  /* An illegal pointer value to mark the end of the shadow stack. */
> diff --git a/kernel/scs.c b/kernel/scs.c
> index 4ff4a7ba0094..2136edba548d 100644
> --- a/kernel/scs.c
> +++ b/kernel/scs.c
> @@ -5,50 +5,95 @@
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
> +/* Matches NR_CACHED_STACKS for VMAP_STACK */
> +#define NR_CACHED_SCS 2
> +static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
> +
>  static void *scs_alloc(int node)
>  {
> -	void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
> +	int i;
> +	void *s;
> +
> +	for (i = 0; i < NR_CACHED_SCS; i++) {
> +		s = this_cpu_xchg(scs_cache[i], NULL);
> +		if (s) {
> +			memset(s, 0, SCS_SIZE);
> +			goto out;
> +		}
> +	}
> +
> +	/*
> +	 * We allocate a full page for the shadow stack, which should be
> +	 * more than we need. Check the assumption nevertheless.
> +	 */
> +	BUILD_BUG_ON(SCS_SIZE > PAGE_SIZE);i

With SCS_ORDER, you can drop this.

> +
> +	s = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
> +				 VMALLOC_START, VMALLOC_END,
> +				 GFP_SCS, PAGE_KERNEL, 0,
> +				 node, __builtin_return_address(0));

Do we actually need vmalloc here? If we used alloc_pages() + vmap()
instead, then we could avoid the expensive call to vmalloc_to_page()
in __scs_account().

>  
>  	if (!s)
>  		return NULL;
>  
> +out:
>  	*__scs_magic(s) = SCS_END_MAGIC;
>  
>  	/*
>  	 * Poison the allocation to catch unintentional accesses to
>  	 * the shadow stack when KASAN is enabled.
>  	 */
> -	kasan_poison_object_data(scs_cache, s);
> +	kasan_poison_vmalloc(s, SCS_SIZE);
>  	__scs_account(s, 1);
>  	return s;
>  }
>  
>  static void scs_free(void *s)
>  {
> +	int i;
> +
>  	__scs_account(s, -1);
> -	kasan_unpoison_object_data(scs_cache, s);
> -	kmem_cache_free(scs_cache, s);
> +	kasan_unpoison_vmalloc(s, SCS_SIZE);

I don't see the point in unpoisoning here tbh; vfree_atomic() re-poisons
almost immediately, so we should probably defer this to scs_alloc() and
only when picking the stack out of the cache.

> +
> +	for (i = 0; i < NR_CACHED_SCS; i++)

Can you add a comment about the re-entrancy here and why we're using
this_cpu_cmpxchg() please?

Tnanks,

Will
