Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27199280521
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 19:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbgJAR1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 13:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbgJAR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 13:27:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B3EC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 10:27:42 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so6719786wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 10:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z6gRseKf/QBoG3LPhRd6/dtXrjTURXY+qNj3glhnuQo=;
        b=UbnsuLPi5hU64uZg9IXopaK3JdjQM0OaDR9n4BFkhsiLIz3aqWk1BLa4jxuK85MBYE
         WhpGKDWx74cUHxAWb1RcUq/BQotQD6VRCRsUy7oTAgacJ02M+lerEQAe8Gbc+ce4fDKz
         hC0g0vdS0XIg6jmOxkeiWme9MgBoi/8ZFfuEOIdj6AOAL0OlvG78OUG/LPhEukVPfrub
         s5HUU+ytoKF/IksTibXXMHYTDumW3ZxGFYZ9jiWmhLB2sxjZruz0ZvREaS5HvpUdFUlx
         YNKMspCQU+nKI/KUSZFjX04OlU9nJR7sEWCnO0a6vX8I2xa10BHM/PB2RU6Ro1c39mbu
         PEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6gRseKf/QBoG3LPhRd6/dtXrjTURXY+qNj3glhnuQo=;
        b=DuYMnwN3ATzvCtV+R9lKj6/PJZtPMa31ov6Qh7bg25hteq//ujsdCitwR8tpCsBuOT
         8obGsRmKVOVNoiAKjxjcrRBVfLeT8vXDga+XPCeRBPRcUMJAaW6WLgSMHaBu628tp7YM
         6YPfhR/ChjTehk9dxZ4mC9IyEHRfdKHCnOQhlW6P0syp7dCELgnlFeHCebMHF+Gz8X0/
         pErIlEiNFGVP6Q2FtMUgmRUzlPTXACzEpjp0BngQn9jE9htOUQoyWQzGjaCGQSiU7Mwi
         3xXOpNWxyzMSk2nUNSE3exKqpB5Kq9CE85jJBZzEpOlSJI9RfC5Orb89zdjMKSTuWk6g
         vzRw==
X-Gm-Message-State: AOAM531kzqQz7GrAGOIc6ih3Uv/13hyfaK//AwRNL9GIFSDAUVeICIb4
        WrsrSfEN5QMf0L+77yLWcpYtcA==
X-Google-Smtp-Source: ABdhPJx4A6tTU5GGX3z/cw+YnaHIuzcei1dwoeDaJQ+rtSh9ar+uXSKPfDSE0hWaOJVeE/cDssWWlw==
X-Received: by 2002:adf:dd0b:: with SMTP id a11mr9987807wrm.422.1601573260984;
        Thu, 01 Oct 2020 10:27:40 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id p3sm772060wmm.40.2020.10.01.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 10:27:40 -0700 (PDT)
Date:   Thu, 1 Oct 2020 19:27:34 +0200
From:   elver@google.com
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/39] kasan: group vmalloc code
Message-ID: <20201001172734.GA4162920@elver.google.com>
References: <cover.1600987622.git.andreyknvl@google.com>
 <4f59e6ddef35c6a3b93b0951a47e7e9b8a680667.1600987622.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f59e6ddef35c6a3b93b0951a47e7e9b8a680667.1600987622.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 12:50AM +0200, Andrey Konovalov wrote:
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
> 
> Group all vmalloc-related function declarations in include/linux/kasan.h,
> and their implementations in mm/kasan/common.c.
> 
> No functional changes.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Change-Id: Ie20b6c689203cd6de4fd7f2c465ec081c00c5f15
> ---
>  include/linux/kasan.h | 41 +++++++++++++----------
>  mm/kasan/common.c     | 78 ++++++++++++++++++++++---------------------
>  2 files changed, 63 insertions(+), 56 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 087fba34b209..bd5b4965a269 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -69,19 +69,6 @@ struct kasan_cache {
>  	int free_meta_offset;
>  };
>  
> -/*
> - * These functions provide a special case to support backing module
> - * allocations with real shadow memory. With KASAN vmalloc, the special
> - * case is unnecessary, as the work is handled in the generic case.
> - */
> -#ifndef CONFIG_KASAN_VMALLOC
> -int kasan_module_alloc(void *addr, size_t size);
> -void kasan_free_shadow(const struct vm_struct *vm);
> -#else
> -static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
> -static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> -#endif
> -
>  int kasan_add_zero_shadow(void *start, unsigned long size);
>  void kasan_remove_zero_shadow(void *start, unsigned long size);
>  
> @@ -150,9 +137,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  	return false;
>  }
>  
> -static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
> -static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> -
>  static inline int kasan_add_zero_shadow(void *start, unsigned long size)
>  {
>  	return 0;
> @@ -205,13 +189,16 @@ static inline void *kasan_reset_tag(const void *addr)
>  #endif /* CONFIG_KASAN_SW_TAGS */
>  
>  #ifdef CONFIG_KASAN_VMALLOC
> +
>  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>  void kasan_poison_vmalloc(const void *start, unsigned long size);
>  void kasan_unpoison_vmalloc(const void *start, unsigned long size);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
>  			   unsigned long free_region_end);
> -#else
> +
> +#else /* CONFIG_KASAN_VMALLOC */
> +
>  static inline int kasan_populate_vmalloc(unsigned long start,
>  					unsigned long size)
>  {
> @@ -226,7 +213,25 @@ static inline void kasan_release_vmalloc(unsigned long start,
>  					 unsigned long end,
>  					 unsigned long free_region_start,
>  					 unsigned long free_region_end) {}
> -#endif
> +
> +#endif /* CONFIG_KASAN_VMALLOC */
> +
> +#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
> +
> +/*
> + * These functions provide a special case to support backing module
> + * allocations with real shadow memory. With KASAN vmalloc, the special
> + * case is unnecessary, as the work is handled in the generic case.
> + */
> +int kasan_module_alloc(void *addr, size_t size);
> +void kasan_free_shadow(const struct vm_struct *vm);
> +
> +#else /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
> +
> +static inline int kasan_module_alloc(void *addr, size_t size) { return 0; }
> +static inline void kasan_free_shadow(const struct vm_struct *vm) {}
> +
> +#endif /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
>  
>  #ifdef CONFIG_KASAN_INLINE
>  void kasan_non_canonical_hook(unsigned long addr);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 33d863f55db1..89e5ef9417a7 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -536,44 +536,6 @@ void kasan_kfree_large(void *ptr, unsigned long ip)
>  	/* The object will be poisoned by page_alloc. */
>  }
>  
> -#ifndef CONFIG_KASAN_VMALLOC
> -int kasan_module_alloc(void *addr, size_t size)
> -{
> -	void *ret;
> -	size_t scaled_size;
> -	size_t shadow_size;
> -	unsigned long shadow_start;
> -
> -	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
> -	scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
> -	shadow_size = round_up(scaled_size, PAGE_SIZE);
> -
> -	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
> -		return -EINVAL;
> -
> -	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
> -			shadow_start + shadow_size,
> -			GFP_KERNEL,
> -			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
> -			__builtin_return_address(0));
> -
> -	if (ret) {
> -		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
> -		find_vm_area(addr)->flags |= VM_KASAN;
> -		kmemleak_ignore(ret);
> -		return 0;
> -	}
> -
> -	return -ENOMEM;
> -}
> -
> -void kasan_free_shadow(const struct vm_struct *vm)
> -{
> -	if (vm->flags & VM_KASAN)
> -		vfree(kasan_mem_to_shadow(vm->addr));
> -}
> -#endif
> -
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  static bool shadow_mapped(unsigned long addr)
>  {
> @@ -685,6 +647,7 @@ core_initcall(kasan_memhotplug_init);
>  #endif
>  
>  #ifdef CONFIG_KASAN_VMALLOC
> +
>  static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>  				      void *unused)
>  {
> @@ -923,4 +886,43 @@ void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  				       (unsigned long)shadow_end);
>  	}
>  }
> +
> +#else /* CONFIG_KASAN_VMALLOC */
> +
> +int kasan_module_alloc(void *addr, size_t size)
> +{
> +	void *ret;
> +	size_t scaled_size;
> +	size_t shadow_size;
> +	unsigned long shadow_start;
> +
> +	shadow_start = (unsigned long)kasan_mem_to_shadow(addr);
> +	scaled_size = (size + KASAN_SHADOW_MASK) >> KASAN_SHADOW_SCALE_SHIFT;
> +	shadow_size = round_up(scaled_size, PAGE_SIZE);
> +
> +	if (WARN_ON(!PAGE_ALIGNED(shadow_start)))
> +		return -EINVAL;
> +
> +	ret = __vmalloc_node_range(shadow_size, 1, shadow_start,
> +			shadow_start + shadow_size,
> +			GFP_KERNEL,
> +			PAGE_KERNEL, VM_NO_GUARD, NUMA_NO_NODE,
> +			__builtin_return_address(0));
> +
> +	if (ret) {
> +		__memset(ret, KASAN_SHADOW_INIT, shadow_size);
> +		find_vm_area(addr)->flags |= VM_KASAN;
> +		kmemleak_ignore(ret);
> +		return 0;
> +	}
> +
> +	return -ENOMEM;
> +}
> +
> +void kasan_free_shadow(const struct vm_struct *vm)
> +{
> +	if (vm->flags & VM_KASAN)
> +		vfree(kasan_mem_to_shadow(vm->addr));
> +}
> +
>  #endif
> -- 
> 2.28.0.681.g6f77f65b4e-goog
> 
