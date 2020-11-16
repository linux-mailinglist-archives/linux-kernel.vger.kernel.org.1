Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618CC2B48F2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730889AbgKPPPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730710AbgKPPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:15:10 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941DFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:15:10 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so24068369wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 07:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tZbF54K8tolVCl75FRWFPLUDutXX6oQr5R1sT2PK7H4=;
        b=XyBmRmKWX1lpnGehzVf4zs1ATCdGQDADzNpb+PAvAOfKe3fz8SU+SXYr17Yvo0QQwF
         tYwQgfymQg4AXxQRZQLGIL0bJS539SBmzADGCZCG62JHWHfDDSd1Csa2codMbjQsy06M
         wkBCd/k40mwpkr0V2ibON1r8sTuQS7b87AGkV6QCyHTUYhby5yWU5nXPy9XpUO+aV/yC
         5v3mqK4PhMq/UZ4frDMpMaWVRT2nx7IZV54fLSE3r6m8IKsArTZmUnTNVGssmTYFi4MS
         bFE3Q5xzWNxCYmlrzeRNV4XXChMKTHu8o/ausyxjkDWCRqHc42kHvwu2F86oW3C8cUnD
         Imiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tZbF54K8tolVCl75FRWFPLUDutXX6oQr5R1sT2PK7H4=;
        b=oEkezFX5qn9w98c0jikPBsjFUT8bcLr3mFewY6UYN2LtaiAVxCcjf3tqo+3eyrZOlx
         M84lp3o7cRDKnEjKeNTVAb4bmNsFQGEjRWXl6FmuZ53oxmTMGNNpGdadu6paNaPtdOEX
         GtSoFu60uC3b4n6gZBTT0uRLrz/CQvrh+D7Nk0Jfmh6C3FtiI+nn3ZfBHoSCJgcyerhI
         Lok0NRRQsOhf4U/ryR8DG8t6bQgjTKslayCZGaxIj3IFmVSgHy9A2kV122m8oweEUFXE
         Olb+FLxRI+v+QRUTrG89SBj+uGf6lu/H2GlEnHhI3buei/vUE8ahMFa95ys24nfIQG6G
         8uJw==
X-Gm-Message-State: AOAM532Ob67PLfVMQEiHNnnwPV9GB7gZJELA0pFwwJ7e3PhxMnzpmJ/c
        pPzNkMDqx6qBIC3lDHDTTVJPGg==
X-Google-Smtp-Source: ABdhPJzI2LggIWQJeI7hhmX65FksBmExScC0cJKxshFFEyrSOMRuUj972Rx4tPLFOqSCxzT9nns4AQ==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr5744356wmi.146.1605539709052;
        Mon, 16 Nov 2020 07:15:09 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id i10sm23358160wrs.22.2020.11.16.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 07:15:08 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:15:01 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm v3 11/19] kasan: add and integrate kasan boot
 parameters
Message-ID: <20201116151501.GC1357314@elver.google.com>
References: <cover.1605305978.git.andreyknvl@google.com>
 <deb1af093f19c8848346682245513af059626412.1605305978.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb1af093f19c8848346682245513af059626412.1605305978.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> Hardware tag-based KASAN mode is intended to eventually be used in
> production as a security mitigation. Therefore there's a need for finer
> control over KASAN features and for an existence of a kill switch.
> 
> This change adds a few boot parameters for hardware tag-based KASAN that
> allow to disable or otherwise control particular KASAN features.
> 
> The features that can be controlled are:
> 
> 1. Whether KASAN is enabled at all.
> 2. Whether KASAN collects and saves alloc/free stacks.
> 3. Whether KASAN panics on a detected bug or not.
> 
> With this change a new boot parameter kasan.mode allows to choose one of
> three main modes:
> 
> - kasan.mode=off - KASAN is disabled, no tag checks are performed
> - kasan.mode=prod - only essential production features are enabled
> - kasan.mode=full - all KASAN features are enabled
> 
> The chosen mode provides default control values for the features mentioned
> above. However it's also possible to override the default values by
> providing:
> 
> - kasan.stacktrace=off/on - enable alloc/free stack collection
>                             (default: on for mode=full, otherwise off)
> - kasan.fault=report/panic - only report tag fault or also panic
>                              (default: report)
> 
> If kasan.mode parameter is not provided, it defaults to full when
> CONFIG_DEBUG_KERNEL is enabled, and to prod otherwise.
> 
> It is essential that switching between these modes doesn't require
> rebuilding the kernel with different configs, as this is required by
> the Android GKI (Generic Kernel Image) initiative [1].
> 
> [1] https://source.android.com/devices/architecture/kernel/generic-kernel-image
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/If7d37003875b2ed3e0935702c8015c223d6416a4

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/common.c  |  22 +++++--
>  mm/kasan/hw_tags.c | 151 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/kasan/kasan.h   |  16 +++++
>  mm/kasan/report.c  |  14 ++++-
>  4 files changed, 196 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 1ac4f435c679..a11e3e75eb08 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -135,6 +135,11 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  	unsigned int redzone_size;
>  	int redzone_adjust;
>  
> +	if (!kasan_stack_collection_enabled()) {
> +		*flags |= SLAB_KASAN;
> +		return;
> +	}
> +
>  	/* Add alloc meta. */
>  	cache->kasan_info.alloc_meta_offset = *size;
>  	*size += sizeof(struct kasan_alloc_meta);
> @@ -171,6 +176,8 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>  
>  size_t kasan_metadata_size(struct kmem_cache *cache)
>  {
> +	if (!kasan_stack_collection_enabled())
> +		return 0;
>  	return (cache->kasan_info.alloc_meta_offset ?
>  		sizeof(struct kasan_alloc_meta) : 0) +
>  		(cache->kasan_info.free_meta_offset ?
> @@ -263,11 +270,13 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>  {
>  	struct kasan_alloc_meta *alloc_meta;
>  
> -	if (!(cache->flags & SLAB_KASAN))
> -		return (void *)object;
> +	if (kasan_stack_collection_enabled()) {
> +		if (!(cache->flags & SLAB_KASAN))
> +			return (void *)object;
>  
> -	alloc_meta = kasan_get_alloc_meta(cache, object);
> -	__memset(alloc_meta, 0, sizeof(*alloc_meta));
> +		alloc_meta = kasan_get_alloc_meta(cache, object);
> +		__memset(alloc_meta, 0, sizeof(*alloc_meta));
> +	}
>  
>  	if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>  		object = set_tag(object, assign_tag(cache, object, true, false));
> @@ -307,6 +316,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  	rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
>  	poison_range(object, rounded_up_size, KASAN_KMALLOC_FREE);
>  
> +	if (!kasan_stack_collection_enabled())
> +		return false;
> +
>  	if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
>  			unlikely(!(cache->flags & SLAB_KASAN)))
>  		return false;
> @@ -357,7 +369,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>  	poison_range((void *)redzone_start, redzone_end - redzone_start,
>  		     KASAN_KMALLOC_REDZONE);
>  
> -	if (cache->flags & SLAB_KASAN)
> +	if (kasan_stack_collection_enabled() && (cache->flags & SLAB_KASAN))
>  		set_alloc_info(cache, (void *)object, flags);
>  
>  	return set_tag(object, tag);
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 863fed4edd3f..30ce88935e9d 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -8,18 +8,115 @@
>  
>  #define pr_fmt(fmt) "kasan: " fmt
>  
> +#include <linux/init.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
>  #include <linux/memory.h>
>  #include <linux/mm.h>
> +#include <linux/static_key.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
>  #include "kasan.h"
>  
> +enum kasan_arg_mode {
> +	KASAN_ARG_MODE_DEFAULT,
> +	KASAN_ARG_MODE_OFF,
> +	KASAN_ARG_MODE_PROD,
> +	KASAN_ARG_MODE_FULL,
> +};
> +
> +enum kasan_arg_stacktrace {
> +	KASAN_ARG_STACKTRACE_DEFAULT,
> +	KASAN_ARG_STACKTRACE_OFF,
> +	KASAN_ARG_STACKTRACE_ON,
> +};
> +
> +enum kasan_arg_fault {
> +	KASAN_ARG_FAULT_DEFAULT,
> +	KASAN_ARG_FAULT_REPORT,
> +	KASAN_ARG_FAULT_PANIC,
> +};
> +
> +static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> +static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
> +static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
> +
> +/* Whether KASAN is enabled at all. */
> +DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_enabled);
> +EXPORT_SYMBOL(kasan_flag_enabled);
> +
> +/* Whether to collect alloc/free stack traces. */
> +DEFINE_STATIC_KEY_FALSE_RO(kasan_flag_stacktrace);
> +
> +/* Whether panic or disable tag checking on fault. */
> +bool kasan_flag_panic __ro_after_init;
> +
> +/* kasan.mode=off/prod/full */
> +static int __init early_kasan_mode(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "off"))
> +		kasan_arg_mode = KASAN_ARG_MODE_OFF;
> +	else if (!strcmp(arg, "prod"))
> +		kasan_arg_mode = KASAN_ARG_MODE_PROD;
> +	else if (!strcmp(arg, "full"))
> +		kasan_arg_mode = KASAN_ARG_MODE_FULL;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("kasan.mode", early_kasan_mode);
> +
> +/* kasan.stack=off/on */
> +static int __init early_kasan_flag_stacktrace(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "off"))
> +		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_OFF;
> +	else if (!strcmp(arg, "on"))
> +		kasan_arg_stacktrace = KASAN_ARG_STACKTRACE_ON;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("kasan.stacktrace", early_kasan_flag_stacktrace);
> +
> +/* kasan.fault=report/panic */
> +static int __init early_kasan_fault(char *arg)
> +{
> +	if (!arg)
> +		return -EINVAL;
> +
> +	if (!strcmp(arg, "report"))
> +		kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
> +	else if (!strcmp(arg, "panic"))
> +		kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +early_param("kasan.fault", early_kasan_fault);
> +
>  /* kasan_init_hw_tags_cpu() is called for each CPU. */
>  void kasan_init_hw_tags_cpu(void)
>  {
> +	/*
> +	 * There's no need to check that the hardware is MTE-capable here,
> +	 * as this function is only called for MTE-capable hardware.
> +	 */
> +
> +	/* If KASAN is disabled, do nothing. */
> +	if (kasan_arg_mode == KASAN_ARG_MODE_OFF)
> +		return;
> +
>  	hw_init_tags(KASAN_TAG_MAX);
>  	hw_enable_tagging();
>  }
> @@ -27,6 +124,60 @@ void kasan_init_hw_tags_cpu(void)
>  /* kasan_init_hw_tags() is called once on boot CPU. */
>  void __init kasan_init_hw_tags(void)
>  {
> +	/* If hardware doesn't support MTE, do nothing. */
> +	if (!system_supports_mte())
> +		return;
> +
> +	/* Choose KASAN mode if kasan boot parameter is not provided. */
> +	if (kasan_arg_mode == KASAN_ARG_MODE_DEFAULT) {
> +		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
> +			kasan_arg_mode = KASAN_ARG_MODE_FULL;
> +		else
> +			kasan_arg_mode = KASAN_ARG_MODE_PROD;
> +	}
> +
> +	/* Preset parameter values based on the mode. */
> +	switch (kasan_arg_mode) {
> +	case KASAN_ARG_MODE_DEFAULT:
> +		/* Shouldn't happen as per the check above. */
> +		WARN_ON(1);
> +		return;
> +	case KASAN_ARG_MODE_OFF:
> +		/* If KASAN is disabled, do nothing. */
> +		return;
> +	case KASAN_ARG_MODE_PROD:
> +		static_branch_enable(&kasan_flag_enabled);
> +		break;
> +	case KASAN_ARG_MODE_FULL:
> +		static_branch_enable(&kasan_flag_enabled);
> +		static_branch_enable(&kasan_flag_stacktrace);
> +		break;
> +	}
> +
> +	/* Now, optionally override the presets. */
> +
> +	switch (kasan_arg_stacktrace) {
> +	case KASAN_ARG_STACKTRACE_DEFAULT:
> +		break;
> +	case KASAN_ARG_STACKTRACE_OFF:
> +		static_branch_disable(&kasan_flag_stacktrace);
> +		break;
> +	case KASAN_ARG_STACKTRACE_ON:
> +		static_branch_enable(&kasan_flag_stacktrace);
> +		break;
> +	}
> +
> +	switch (kasan_arg_fault) {
> +	case KASAN_ARG_FAULT_DEFAULT:
> +		break;
> +	case KASAN_ARG_FAULT_REPORT:
> +		kasan_flag_panic = false;
> +		break;
> +	case KASAN_ARG_FAULT_PANIC:
> +		kasan_flag_panic = true;
> +		break;
> +	}
> +
>  	pr_info("KernelAddressSanitizer initialized\n");
>  }
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8aa83b7ad79e..d01a5ac34f70 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -6,6 +6,22 @@
>  #include <linux/kfence.h>
>  #include <linux/stackdepot.h>
>  
> +#ifdef CONFIG_KASAN_HW_TAGS
> +#include <linux/static_key.h>
> +DECLARE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
> +static inline bool kasan_stack_collection_enabled(void)
> +{
> +	return static_branch_unlikely(&kasan_flag_stacktrace);
> +}
> +#else
> +static inline bool kasan_stack_collection_enabled(void)
> +{
> +	return true;
> +}
> +#endif
> +
> +extern bool kasan_flag_panic __ro_after_init;
> +
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_GRANULE_SIZE	(1UL << KASAN_SHADOW_SCALE_SHIFT)
>  #else
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 76a0e3ae2049..ffa6076b1710 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -99,6 +99,10 @@ static void end_report(unsigned long *flags)
>  		panic_on_warn = 0;
>  		panic("panic_on_warn set ...\n");
>  	}
> +#ifdef CONFIG_KASAN_HW_TAGS
> +	if (kasan_flag_panic)
> +		panic("kasan.fault=panic set ...\n");
> +#endif
>  	kasan_enable_current();
>  }
>  
> @@ -161,8 +165,8 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>  		(void *)(object_addr + cache->object_size));
>  }
>  
> -static void describe_object(struct kmem_cache *cache, void *object,
> -				const void *addr, u8 tag)
> +static void describe_object_stacks(struct kmem_cache *cache, void *object,
> +					const void *addr, u8 tag)
>  {
>  	struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
>  
> @@ -190,7 +194,13 @@ static void describe_object(struct kmem_cache *cache, void *object,
>  		}
>  #endif
>  	}
> +}
>  
> +static void describe_object(struct kmem_cache *cache, void *object,
> +				const void *addr, u8 tag)
> +{
> +	if (kasan_stack_collection_enabled())
> +		describe_object_stacks(cache, object, addr, tag);
>  	describe_object_addr(cache, object, addr);
>  }
>  
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
