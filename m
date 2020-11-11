Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1523D2AF5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgKKQNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgKKQNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:13:22 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE853C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:13:21 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so3034479wrf.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WwThXO74wAdZUw9ureBsdbo33+GC/qabfRYu0sfQ7ak=;
        b=djjmtjGBk5gDB/hROrxHCiGtDZAZL60t9zoHD5GsK82Aub2f4s3e8/Ulq9ERjEh1DE
         Y0A8wuBQ9h8pOE4rXfZfG5+Ri54eyY589jflGgoW13qec35X4CLZ7I3ayHSwnNnjeiL0
         toGTyCTU2btoMKHwuaQjzCr29rp5NjQt1GrXCVoISrwi6QRDcH607nUvhS7KMpzvwAOm
         CbF/sRGoh/S13tZhrlJGfujKQPRdbFqxXf1/veX2gczEykzMa59BzQGn+/pVLgAscfFB
         zQNM5rucsQ1b4IQyoih7TMyt5RtQb+BGXTz+owYovqbYLvQ/iw90aEMnV1qO4fyNA/r3
         pzAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WwThXO74wAdZUw9ureBsdbo33+GC/qabfRYu0sfQ7ak=;
        b=QBOk2ccosPLaAvRUCa6JEdwE7Ta+e+EKzu/nmZuWA2kteO3KUY+LZUDFpMdLO4mXWC
         5onVZrPIKZ52iCqYy/wZve5SiCw1us/9wvAaRzIA119I8MIVoGKbLldsgSVyokfrhI0e
         QNkmohbIj7YL3VZb8+6XEaoY3vWoJXcH5pJf54KIYa03g8K5rPCwif0RczGVlm90BAAV
         M1n5ZyeS2gBSejTlcp9bAOtpuabX8NrUGPu3AMuxI2m8zj5Rsb6Ar6BqH1qYyYM4YHxu
         cDy8+Ki+cYYGZttzSTD1l7/RL0Srdw7OHE2Dwcn/Hcmte0rr6wLHxiSxIUq5vIYQO8wm
         qPvg==
X-Gm-Message-State: AOAM5330SFD/WoW3VWzPiF6DSlbVZOmc3wNVWTMhPKX1BHLsvxDtOM3S
        ZvLe/2WsPpAeRh+0MiWpWASEIg==
X-Google-Smtp-Source: ABdhPJz+5eUmuNniwu1ZE84a9/FZtwS0urxMa0j8Iv8QOyZNsXFL+gglblNtmVZdlqC8lQNRXFmd7g==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr21313985wrv.122.1605111200317;
        Wed, 11 Nov 2020 08:13:20 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id b8sm3334226wrv.57.2020.11.11.08.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:13:19 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:13:13 +0100
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/20] kasan, arm64: unpoison stack only with
 CONFIG_KASAN_STACK
Message-ID: <20201111161313.GF517454@elver.google.com>
References: <cover.1605046662.git.andreyknvl@google.com>
 <7e95d4739f5617b2c1acf52f37e01f1ca83750b5.1605046662.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e95d4739f5617b2c1acf52f37e01f1ca83750b5.1605046662.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> There's a config option CONFIG_KASAN_STACK that has to be enabled for
> KASAN to use stack instrumentation and perform validity checks for
> stack variables.
> 
> There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
> Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
> enabled.
> 
> Note, that CONFIG_KASAN_STACK is an option that is currently always
> defined when CONFIG_KASAN is enabled, and therefore has to be tested
> with #if instead of #ifdef.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
> ---
>  arch/arm64/kernel/sleep.S        |  2 +-
>  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
>  include/linux/kasan.h            | 10 ++++++----
>  mm/kasan/common.c                |  2 ++
>  4 files changed, 10 insertions(+), 6 deletions(-)

Reviewed-by: Marco Elver <elver@google.com>

> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index ba40d57757d6..bdadfa56b40e 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
>  	 */
>  	bl	cpu_do_resume
>  
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>  	mov	x0, sp
>  	bl	kasan_unpoison_task_stack_below
>  #endif
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index c8daa92f38dc..5d3a0b8fd379 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>  	movq	pt_regs_r14(%rax), %r14
>  	movq	pt_regs_r15(%rax), %r15
>  
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>  	/*
>  	 * The suspend path may have poisoned some areas deeper in the stack,
>  	 * which we now need to unpoison.
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index f22bdef82111..b9b9db335d87 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -76,8 +76,6 @@ static inline void kasan_disable_current(void) {}
>  
>  void kasan_unpoison_memory(const void *address, size_t size);
>  
> -void kasan_unpoison_task_stack(struct task_struct *task);
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
>  
> @@ -122,8 +120,6 @@ void kasan_restore_multi_shot(bool enabled);
>  
>  static inline void kasan_unpoison_memory(const void *address, size_t size) {}
>  
> -static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> -
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>  
> @@ -175,6 +171,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>  
>  #endif /* CONFIG_KASAN */
>  
> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> +void kasan_unpoison_task_stack(struct task_struct *task);
> +#else
> +static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> +#endif
> +
>  #ifdef CONFIG_KASAN_GENERIC
>  
>  void kasan_cache_shrink(struct kmem_cache *cache);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a880e5a547ed..a3e67d49b893 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -58,6 +58,7 @@ void kasan_disable_current(void)
>  }
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>  
> +#if CONFIG_KASAN_STACK
>  static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
>  {
>  	void *base = task_stack_page(task);
> @@ -84,6 +85,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  
>  	kasan_unpoison_memory(base, watermark - base);
>  }
> +#endif /* CONFIG_KASAN_STACK */
>  
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
> -- 
> 2.29.2.222.g5d2a92d10f8-goog
> 
