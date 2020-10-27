Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9935B29AC6C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440760AbgJ0Mpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:45:39 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34668 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411752AbgJ0Mpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:45:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id h12so815435qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KC5kbhX2B/WcBTAKVbARUxq55uts8rGyp+acLwUDFR4=;
        b=QuhHjliQxgJS/kyWZwHMuClIrCrAn//vg871+u9tYKtsWpyAzlCothQa2DtWKGQyev
         qczxSynZ7Xvb0RO2vMOpD1JZxI5i+OOlrot85T2ys5/UbR9FtFl9bMMLBgRNFHKffIYR
         QT7+/CL6OcMRY7FJMoN5KXdtrl0CMEAeGpnRojS6GrQn0uHOmYR25Mb6u3RzdENf3oqA
         iqVtGW/Hxp9y+rGaLHyNofKw7G6zMtITwYYR7ahB28cmEUsN5qfU+DpTr5WmL+IELhjq
         yLNnJH2VhTjvGKcn1acniGUfXgqcbg0B/QSC4L0/jFcE1vD7BHOyJ8pzTftMeK0vo86C
         0iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KC5kbhX2B/WcBTAKVbARUxq55uts8rGyp+acLwUDFR4=;
        b=To5lXdCIfRZ6kyvHnVKmQPOvmeLe6sRxg09/rTc1Ycvl+And8RsrLQ62hrVeS6/vOm
         Bj7ocreyKTFlWBJdJh9q6jCErEonfz31tjcXBb2WNNijmvpPN7kEnA9IRF8+znFyOXUR
         kuf5WYC3UWkJY8uGeGaG6zBbYaz4XuXY/G4LMkyUC3cmOswtJC6JentAVJ6d7j9SnGmT
         VQ7JcT5SJxJM8GeueetxP/34DoJ0DVQcbSyhzgfRlVcCU8xhWnNd0GfFr9ml/DY6ih5F
         Mf4Is82nvywZCu3DWS/lrhe4xFdNGAFES0Ge81p06acPkdg99dtXY+kXXVvzl6A11i9Q
         ZyqA==
X-Gm-Message-State: AOAM532TJvs+glMvKC6jcllqki+M16EQ7hH1Km7o/7Cp/AfK1Fz5Jzzv
        v2CVYANSmt9XA89AhFXJBDpN23evbZ9b0LM/WuBeTA==
X-Google-Smtp-Source: ABdhPJxG8yd6gbrzat04i4FrkjnLcubwbx/qvjTgBrR4WSSCia+T4WDx0s/wc15IBxinWHomYMAzaZRtIGRoGww2zG4=
X-Received: by 2002:ac8:44b1:: with SMTP id a17mr1901995qto.43.1603802737168;
 Tue, 27 Oct 2020 05:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Oct 2020 13:45:25 +0100
Message-ID: <CACT4Y+avTTkH-y4gVd=X0KqhugzTqrGVx9+Z06cYA2kF+HvffA@mail.gmail.com>
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

On Tue, Oct 27, 2020 at 1:44 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > There's a config option CONFIG_KASAN_STACK that has to be enabled for
> > KASAN to use stack instrumentation and perform validity checks for
> > stack variables.
> >
> > There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
> > Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
> > enabled.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
> > ---
> >  arch/arm64/kernel/sleep.S        |  2 +-
> >  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
> >  include/linux/kasan.h            | 10 ++++++----
> >  mm/kasan/common.c                |  2 ++
> >  4 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> > index ba40d57757d6..bdadfa56b40e 100644
> > --- a/arch/arm64/kernel/sleep.S
> > +++ b/arch/arm64/kernel/sleep.S
> > @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
> >          */
> >         bl      cpu_do_resume
> >
> > -#ifdef CONFIG_KASAN
> > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK

And similarly here

> >         mov     x0, sp
> >         bl      kasan_unpoison_task_stack_below
> >  #endif
> > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> > index c8daa92f38dc..5d3a0b8fd379 100644
> > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > @@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
> >         movq    pt_regs_r14(%rax), %r14
> >         movq    pt_regs_r15(%rax), %r15
> >
> > -#ifdef CONFIG_KASAN
> > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK

and here

> >         /*
> >          * The suspend path may have poisoned some areas deeper in the stack,
> >          * which we now need to unpoison.
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 3f3f541e5d5f..7be9fb9146ac 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -68,8 +68,6 @@ static inline void kasan_disable_current(void) {}
> >
> >  void kasan_unpoison_memory(const void *address, size_t size);
> >
> > -void kasan_unpoison_task_stack(struct task_struct *task);
> > -
> >  void kasan_alloc_pages(struct page *page, unsigned int order);
> >  void kasan_free_pages(struct page *page, unsigned int order);
> >
> > @@ -114,8 +112,6 @@ void kasan_restore_multi_shot(bool enabled);
> >
> >  static inline void kasan_unpoison_memory(const void *address, size_t size) {}
> >
> > -static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> > -
> >  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
> >  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> >
> > @@ -167,6 +163,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> >
> >  #endif /* CONFIG_KASAN */
> >
> > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
>
> && defined(CONFIG_KASAN_STACK) for consistency
>
> > +void kasan_unpoison_task_stack(struct task_struct *task);
> > +#else
> > +static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> > +#endif
> > +
> >  #ifdef CONFIG_KASAN_GENERIC
> >
> >  void kasan_cache_shrink(struct kmem_cache *cache);
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index a880e5a547ed..a3e67d49b893 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -58,6 +58,7 @@ void kasan_disable_current(void)
> >  }
> >  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> >
> > +#if CONFIG_KASAN_STACK
>
> #ifdef CONFIG_ is the form used toughout the kernel code
>
> >  static void __kasan_unpoison_stack(struct task_struct *task, const void *sp)
> >  {
> >         void *base = task_stack_page(task);
> > @@ -84,6 +85,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
> >
> >         kasan_unpoison_memory(base, watermark - base);
> >  }
> > +#endif /* CONFIG_KASAN_STACK */
> >
> >  void kasan_alloc_pages(struct page *page, unsigned int order)
> >  {
> > --
> > 2.29.0.rc1.297.gfa9743e501-goog
> >
