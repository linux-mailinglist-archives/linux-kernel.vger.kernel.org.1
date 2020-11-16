Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C41E2B41D9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgKPLAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgKPLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:00:44 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6B3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:00:42 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so12525479qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 03:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FX8GD+b8oMZGG7RMfkMYcB2Sb5EDK5FE7PKEweB+0bg=;
        b=Ojt003UlpmkrS+sQ1TQUN2zeBxWoQgiHTyQyOraAFHTpOpuEz7EnHTOYMGbWE0fs0B
         EF5O7dcxHUGo2tlteywoPZTgAuyQztFbOPomED6EGVvuLowGkFCbPXHs1Ol/fyjQjsc1
         pn5cgVfOrt0iblSESh5xPqcL/mU+ZJGrHPnCpJ1Z7Niof6IVup10P22Vvq/VTHS4+hzJ
         gZFYUvHtfjzo7Y5R2twqZFQpH2tDdd6CzWtxSiW8TOmesIyG02+2lpspMTvhNDl7Sb8J
         71eG1H27trjJb4xeC8LjH8QhWd7TEQ6pQmRQrvmQs26Q3mfUqqhqkqFkwcJUHOA11Fsm
         IsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FX8GD+b8oMZGG7RMfkMYcB2Sb5EDK5FE7PKEweB+0bg=;
        b=C0ONknAR7q+R4HMtm1oJLHubJp3cl7ezBP1zAvYa8XkEKy/GmNC4jPIs9VxYBEbATg
         +HR7SgDdpptKjVsh3qqOt/nQTi0vKMVsE9K6FthkyPGJ9e9DUrwVCsBlKDdhxtFTrPZB
         FF3uf4W5iMpgRY/EiJYWErcyzWDAYHqDOVjQmM/p9tX32zIdM34u2T/oYFPBknbmvkuq
         BTAnnryZmPHZIrizEjgaMZZwgN6ksLRXUwlxxL4zecIbbTKmabuaB/EGYvIHVj07Iqt6
         IcrXWXPxwl0MpX0A6BujjNqM/JCzg/spZBzfjbFt7LixFy/oXGiaWEAnYpa0wj0UJL4a
         7xNg==
X-Gm-Message-State: AOAM53225RcmN/L6f8vzlKGvFORYumxr0vtko/O6Ut7FXDZioZSTCwl0
        D4IqP5ix1EHTWwyHoxogBaVKf1msnHoWVLiQeSKbOQ==
X-Google-Smtp-Source: ABdhPJxCni13N4vuA3KlP+ykcZHvRiV94mZVfVD08+wGb2YPqeZdS5VQhMa8uyPTHN5SQXcnL/RPYTFZBQGAWOWAWwM=
X-Received: by 2002:aed:2b47:: with SMTP id p65mr13025705qtd.337.1605524441642;
 Mon, 16 Nov 2020 03:00:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <d65e2fc1d7fc03b7ced67e401ff1ea9143b3382d.1605305978.git.andreyknvl@google.com>
In-Reply-To: <d65e2fc1d7fc03b7ced67e401ff1ea9143b3382d.1605305978.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 16 Nov 2020 12:00:30 +0100
Message-ID: <CACT4Y+a4ZoBm3jC308kradyeYcXKMMux4uTSgs4cWkby5Th+bw@mail.gmail.com>
Subject: Re: [PATCH mm v3 04/19] kasan, arm64: unpoison stack only with CONFIG_KASAN_STACK
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
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
> Reviewed-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
> ---
>  arch/arm64/kernel/sleep.S        |  2 +-
>  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
>  include/linux/kasan.h            | 10 ++++++----
>  mm/kasan/common.c                |  2 ++
>  4 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index ba40d57757d6..bdadfa56b40e 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
>          */
>         bl      cpu_do_resume
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>         mov     x0, sp
>         bl      kasan_unpoison_task_stack_below
>  #endif
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index c8daa92f38dc..5d3a0b8fd379 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>         movq    pt_regs_r14(%rax), %r14
>         movq    pt_regs_r15(%rax), %r15
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>         /*
>          * The suspend path may have poisoned some areas deeper in the stack,
>          * which we now need to unpoison.
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 0c89e6fdd29e..f2109bf0c5f9 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -76,8 +76,6 @@ static inline void kasan_disable_current(void) {}
>
>  void kasan_unpoison_range(const void *address, size_t size);
>
> -void kasan_unpoison_task_stack(struct task_struct *task);
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
>
> @@ -122,8 +120,6 @@ void kasan_restore_multi_shot(bool enabled);
>
>  static inline void kasan_unpoison_range(const void *address, size_t size) {}
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
> index 0a420f1dbc54..7648a2452a01 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -64,6 +64,7 @@ void kasan_unpoison_range(const void *address, size_t size)
>         unpoison_range(address, size);
>  }
>
> +#if CONFIG_KASAN_STACK
>  static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
>  {
>         void *base = task_stack_page(task);
> @@ -90,6 +91,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>
>         unpoison_range(base, watermark - base);
>  }
> +#endif /* CONFIG_KASAN_STACK */
>
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
> --
> 2.29.2.299.gdc1121823c-goog
>
