Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2D32B41D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgKPK7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgKPK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:59:41 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27350C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:59:41 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id 3so12546549qtx.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 02:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w2fKHHmUBTp3QBPbH39v+ua/WX4NZLnRZytlRMmRIjc=;
        b=gZ4lBG2fLiRggX8aU3Y735M5w8ithrBeYR1RMxMWAspT1nrsIO9Zg5xxlApTuWvn1U
         nES/ZecDWNZyh1BuU6ePxlEB3xUOquA+uSDYYzj2bD4VIx2Px/JKnUVt6Dk3jNa4w50s
         cBjh95caTOMLtlWiq8llOzgyBMmKwdqsjscQkWJXO98uoY7Q6Lx6cWBmZZojm8gDPu+M
         QJ4hH+Yr3ot/u64KygN3+1nMr1aW4D41DSHeU6d8QMLazqEzw0gVqxrvtjYNr8XqTK7N
         jQ8YC87FWN1n/reHNlo82ogb5sFVWiSGb2f+TB6F7CoV412TJ30bSRWUahycmas0AhcE
         jftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w2fKHHmUBTp3QBPbH39v+ua/WX4NZLnRZytlRMmRIjc=;
        b=kNwOZUt9Z9Obt4v6TZWPuRUMfblXM1ST1vTYHnLl1QH7mS2DMvUeJpD8C12XRSBYGX
         qVvYHu5PSkeGXOYtutL5x/9YFU6HatGq3AF94jaKTQaNOYpa/Wx0Veu6Aqx2q+s+KgF4
         yPhPywqss3ckxwD5GoZ+7AHPJafGmyyaXJ3A8Buf0NXkkTzkMkFqepWy6TkC0WvvGuBL
         rC7WLkysC7uN25eyOSjEr/hppM89G3/DPgVj7wkHjKZTs5RfhpWM1XpvsnJwQ7bVsQnn
         sWVWVmGVNhf+1QzLaZZwGHieFIjspKo2L/adz3xQWgjn3WjhS1EMeZJFVGFdBAOzhYRg
         7oDg==
X-Gm-Message-State: AOAM532VGVk1vucra7a4oulKbR0iYumSI4S6WzGKU4zqX3SZXc1z6tvI
        0SW4i5qWu6mwuJoVW14GpIVDUzh1uE29/73YbLf4Iw==
X-Google-Smtp-Source: ABdhPJwWY3+kd6v17X4xZ+1bVQCpPFzoudy9ZL/aHamRr49rTthClU7ec0PQSoiPb8XAvzUwdPVDF4PsQPK0f7VtTW0=
X-Received: by 2002:ac8:c04:: with SMTP id k4mr14023201qti.66.1605524379709;
 Mon, 16 Nov 2020 02:59:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com> <CAAeHK+xvGZNwTtvkzNnU7Hh7iUiPKFNDKDpKT8UPcqQk6Ah3yQ@mail.gmail.com>
In-Reply-To: <CAAeHK+xvGZNwTtvkzNnU7Hh7iUiPKFNDKDpKT8UPcqQk6Ah3yQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 16 Nov 2020 11:59:28 +0100
Message-ID: <CACT4Y+Z3UCwAY2Mm1KiQMBXVhc2Bobi-YrdiNYtToNgMRjOE4g@mail.gmail.com>
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

On Thu, Oct 29, 2020 at 8:57 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, Oct 27, 2020 at 1:44 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > >
> > > There's a config option CONFIG_KASAN_STACK that has to be enabled for
> > > KASAN to use stack instrumentation and perform validity checks for
> > > stack variables.
> > >
> > > There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
> > > Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
> > > enabled.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
> > > ---
> > >  arch/arm64/kernel/sleep.S        |  2 +-
> > >  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
> > >  include/linux/kasan.h            | 10 ++++++----
> > >  mm/kasan/common.c                |  2 ++
> > >  4 files changed, 10 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> > > index ba40d57757d6..bdadfa56b40e 100644
> > > --- a/arch/arm64/kernel/sleep.S
> > > +++ b/arch/arm64/kernel/sleep.S
> > > @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
> > >          */
> > >         bl      cpu_do_resume
> > >
> > > -#ifdef CONFIG_KASAN
> > > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> > >         mov     x0, sp
> > >         bl      kasan_unpoison_task_stack_below
> > >  #endif
> > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> > > index c8daa92f38dc..5d3a0b8fd379 100644
> > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > @@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
> > >         movq    pt_regs_r14(%rax), %r14
> > >         movq    pt_regs_r15(%rax), %r15
> > >
> > > -#ifdef CONFIG_KASAN
> > > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> > >         /*
> > >          * The suspend path may have poisoned some areas deeper in the stack,
> > >          * which we now need to unpoison.
> > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > index 3f3f541e5d5f..7be9fb9146ac 100644
> > > --- a/include/linux/kasan.h
> > > +++ b/include/linux/kasan.h
> > > @@ -68,8 +68,6 @@ static inline void kasan_disable_current(void) {}
> > >
> > >  void kasan_unpoison_memory(const void *address, size_t size);
> > >
> > > -void kasan_unpoison_task_stack(struct task_struct *task);
> > > -
> > >  void kasan_alloc_pages(struct page *page, unsigned int order);
> > >  void kasan_free_pages(struct page *page, unsigned int order);
> > >
> > > @@ -114,8 +112,6 @@ void kasan_restore_multi_shot(bool enabled);
> > >
> > >  static inline void kasan_unpoison_memory(const void *address, size_t size) {}
> > >
> > > -static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> > > -
> > >  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
> > >  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> > >
> > > @@ -167,6 +163,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> > >
> > >  #endif /* CONFIG_KASAN */
> > >
> > > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> >
> > && defined(CONFIG_KASAN_STACK) for consistency
>
> CONFIG_KASAN_STACK is different from other KASAN configs. It's always
> defined, and its value is what controls whether stack instrumentation
> is enabled.

Not sure why we did this instead of the following, but okay.

 config KASAN_STACK
-       int
-       default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
-       default 0
+       bool
+       default y if KASAN_STACK_ENABLE || CC_IS_GCC
+       default n
