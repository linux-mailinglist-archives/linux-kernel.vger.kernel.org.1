Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFB029F5AC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJ2T7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgJ2T5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:57:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4853CC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:57:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k9so1539743pgt.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hG781gazXbY/D36WgQVMDGpuA2RWLeNpJCXac5ZQkg8=;
        b=CkPH+9fRzdAH7NaPTpwnMk3m/39TlRMCkf+8/ibXMkhbKksFi+qhvgxmk+P+IAMmZj
         R74q96IqL5x2Rj8eepDcpzDjBoFirv2AZna3FcHVjbW8zNo5MtPCCSnOQUAVAys08YHI
         fhdH45DyNsGwdqCm/clZA7cXmj+n9qVvk9nny1hl6MKut1MqfmX1O1JURGT6UyCCJzSr
         Ktj8mESsPBeCQ1+8Tmd5d8DwgnfY+ljpiMTs2z3ZV7jzCHqdbg6MF0x+jcvhBfYMa2Vl
         wS3o8q+L6gal7g70hyHLJNQoaxEQ2sU1qpJHhTVF2dM6mvsWHSXOXm63P9KWXbllgHHK
         ZgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hG781gazXbY/D36WgQVMDGpuA2RWLeNpJCXac5ZQkg8=;
        b=W/sVc9qVhNfsBz2Df1sdx2/R6EeNwURRF0fBJb2irO44GDEk1a0Uc4uoCc8lgCghMe
         /C0wA0NaIaDMK9sGMNR4xt9M0kgz2TWad2+Ep1O6A4uA3P6QcE5+Z9QjYhPQRr+2sw3h
         HbJqetMZbS9+PR7CNT6hpsRAgYQWT4BK7YU5GIqznJOsMUCmp1ZmuocT4n4qgXpVgi/c
         FMDrRDq8QC6l1FjAXn/waIQRW27p+TABMEjMVSMV/4l3fgm3dk8N5eHsPeyiervmf4wv
         H6hA1hfzhLLwD/Lo+G6MvudPXKYabvjiNxtAZeHKXpiQNVbdPHMYshZ3d2444BLbEJFM
         AyCQ==
X-Gm-Message-State: AOAM530D3eBVVwBetF8v+/pyRCBLQzstdX/BwAGHcycY0j6WgqyZqyud
        Kl+/ZglMgq64xLnBHTfOMKUzEd1/BEKwRMzL4TvouQ==
X-Google-Smtp-Source: ABdhPJwSYqr/F3B+5xf17TLZ8k/LWZ0UMiupxEJpedRZTMTDZZRQpw9wqxYX2ktp1bBLdmPZj7VaypYWfbjHbHyJnTA=
X-Received: by 2002:a62:7695:0:b029:152:3ddd:24a3 with SMTP id
 r143-20020a6276950000b02901523ddd24a3mr5622801pfc.2.1604001474526; Thu, 29
 Oct 2020 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 29 Oct 2020 20:57:43 +0100
Message-ID: <CAAeHK+xvGZNwTtvkzNnU7Hh7iUiPKFNDKDpKT8UPcqQk6Ah3yQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/21] kasan: unpoison stack only with CONFIG_KASAN_STACK
To:     Dmitry Vyukov <dvyukov@google.com>
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

CONFIG_KASAN_STACK is different from other KASAN configs. It's always
defined, and its value is what controls whether stack instrumentation
is enabled.

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
