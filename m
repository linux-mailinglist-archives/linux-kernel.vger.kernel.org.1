Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C94029AC69
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900227AbgJ0Mof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:44:35 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46268 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440617AbgJ0Mof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:44:35 -0400
Received: by mail-qk1-f194.google.com with SMTP id a23so916446qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MOEEMcwz+wOCi9BVmbcGJ1vQkzTsdFXXOfPV2diYyTk=;
        b=SZkHXu8h3EbHH8VtHFgHa8YSVtI8rlRYExnbQhnfyyYBCthfOoGxvqz0E/yMDoUuRW
         VapDNHEwmX/cOcZIM5C7y3L6erFugKiVAz9wtT/PhTrugbUwhbR35OZ2ypo8omGUgiRk
         8k6HtGR6KVlnsnMUwKciKJGsRRJjdaRj6HroxhUneaEHvHsENGd6Fji5L8jCbR2xRKgq
         HWhqI7MvIZH3GfnP9uXJvh+PjfXojYFr/su3BR89abRB62VPPFofWza27Fyy500xhBTp
         0AAPshb5YzZNlPaD9suuA6x8hSDtp/oZP5RTRlKFyDk2sQRXwyv5asGHXi2pSY/Zqf8h
         laqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MOEEMcwz+wOCi9BVmbcGJ1vQkzTsdFXXOfPV2diYyTk=;
        b=ZoEPc72HkruoRG4IU+3S41goyd3oevIhmEP3kZ1mGmMFJxQsU21o2IQdEcLl5/QSol
         0uynPAJ/yL7L7Z2umK5gAVczN60/wGI7Cx+9ExPj9hC2TFXoIjmzneDt3BW3EQA5QtnX
         2lxNjr3RF3/m0FvyUSWTxGtgrVPgJJO2L1pWzZe2e3Wj/cm7/U/JnOKPCWcX3vP/YXOG
         68wWHPGpgJT6a1PKMb7BQQ15K7hiy4nOLZIVV84s3mxQUR3s2sKDHx3llweccNJDRkY0
         H/0XDA4BKUI96MeihPhqfH3i8Do1DNI4stx+ngN0YLYNi7w6wmUdm4qZfklwdg2ywUQ3
         o0tQ==
X-Gm-Message-State: AOAM533jXo1exfVZ1VYwpv6RirAiCaa8Iq4gtEDdH9mpzY56O2kvytE0
        0nlDdKD/q4OWdn+JDosiUEVRTScjlCnVl0qEJidB4w==
X-Google-Smtp-Source: ABdhPJx+Lvo6IRixu35Gi+oFg35TIGbuidBJCx4l+BJ8meN9LeiD7vrHedNkPakIK35QGEFDWRTJcE6aA1GSTNBOUHA=
X-Received: by 2002:a05:620a:1657:: with SMTP id c23mr1953011qko.231.1603802673106;
 Tue, 27 Oct 2020 05:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
In-Reply-To: <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Oct 2020 13:44:22 +0100
Message-ID: <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/21] kasan: unpoison stack only with CONFIG_KASAN_STACK
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> There's a config option CONFIG_KASAN_STACK that has to be enabled for
> KASAN to use stack instrumentation and perform validity checks for
> stack variables.
>
> There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
> Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
> enabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
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
> index 3f3f541e5d5f..7be9fb9146ac 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -68,8 +68,6 @@ static inline void kasan_disable_current(void) {}
>
>  void kasan_unpoison_memory(const void *address, size_t size);
>
> -void kasan_unpoison_task_stack(struct task_struct *task);
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
>
> @@ -114,8 +112,6 @@ void kasan_restore_multi_shot(bool enabled);
>
>  static inline void kasan_unpoison_memory(const void *address, size_t size) {}
>
> -static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> -
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>
> @@ -167,6 +163,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>
>  #endif /* CONFIG_KASAN */
>
> +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK

&& defined(CONFIG_KASAN_STACK) for consistency

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

#ifdef CONFIG_ is the form used toughout the kernel code

>  static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
>  {
>         void *base = task_stack_page(task);
> @@ -84,6 +85,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>
>         kasan_unpoison_memory(base, watermark - base);
>  }
> +#endif /* CONFIG_KASAN_STACK */
>
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
