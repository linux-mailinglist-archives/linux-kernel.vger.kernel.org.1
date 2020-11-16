Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE42B436E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbgKPMQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:16:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgKPMQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:16:11 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A17A622263;
        Mon, 16 Nov 2020 12:16:07 +0000 (UTC)
Date:   Mon, 16 Nov 2020 12:16:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexander Potapenko <glider@google.com>,
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
Subject: Re: [PATCH RFC v2 04/21] kasan: unpoison stack only with
 CONFIG_KASAN_STACK
Message-ID: <X7Jthb9D5Ekq93sS@trantor>
References: <cover.1603372719.git.andreyknvl@google.com>
 <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
 <CAAeHK+xvGZNwTtvkzNnU7Hh7iUiPKFNDKDpKT8UPcqQk6Ah3yQ@mail.gmail.com>
 <CACT4Y+Z3UCwAY2Mm1KiQMBXVhc2Bobi-YrdiNYtToNgMRjOE4g@mail.gmail.com>
 <CANpmjNPNqHsOfcw7Wh+XQ_pPT1610-+B9By171t7KMS3aB2sBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPNqHsOfcw7Wh+XQ_pPT1610-+B9By171t7KMS3aB2sBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:50:00PM +0100, Marco Elver wrote:
> On Mon, 16 Nov 2020 at 11:59, Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Thu, Oct 29, 2020 at 8:57 PM 'Andrey Konovalov' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > > On Tue, Oct 27, 2020 at 1:44 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > >
> > > > On Thu, Oct 22, 2020 at 3:19 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > > > >
> > > > > There's a config option CONFIG_KASAN_STACK that has to be enabled for
> > > > > KASAN to use stack instrumentation and perform validity checks for
> > > > > stack variables.
> > > > >
> > > > > There's no need to unpoison stack when CONFIG_KASAN_STACK is not enabled.
> > > > > Only call kasan_unpoison_task_stack[_below]() when CONFIG_KASAN_STACK is
> > > > > enabled.
> > > > >
> > > > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > > > Link: https://linux-review.googlesource.com/id/If8a891e9fe01ea543e00b576852685afec0887e3
> > > > > ---
> > > > >  arch/arm64/kernel/sleep.S        |  2 +-
> > > > >  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
> > > > >  include/linux/kasan.h            | 10 ++++++----
> > > > >  mm/kasan/common.c                |  2 ++
> > > > >  4 files changed, 10 insertions(+), 6 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> > > > > index ba40d57757d6..bdadfa56b40e 100644
> > > > > --- a/arch/arm64/kernel/sleep.S
> > > > > +++ b/arch/arm64/kernel/sleep.S
> > > > > @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
> > > > >          */
> > > > >         bl      cpu_do_resume
> > > > >
> > > > > -#ifdef CONFIG_KASAN
> > > > > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> > > > >         mov     x0, sp
> > > > >         bl      kasan_unpoison_task_stack_below
> > > > >  #endif
> > > > > diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> > > > > index c8daa92f38dc..5d3a0b8fd379 100644
> > > > > --- a/arch/x86/kernel/acpi/wakeup_64.S
> > > > > +++ b/arch/x86/kernel/acpi/wakeup_64.S
> > > > > @@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
> > > > >         movq    pt_regs_r14(%rax), %r14
> > > > >         movq    pt_regs_r15(%rax), %r15
> > > > >
> > > > > -#ifdef CONFIG_KASAN
> > > > > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> > > > >         /*
> > > > >          * The suspend path may have poisoned some areas deeper in the stack,
> > > > >          * which we now need to unpoison.
> > > > > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > > > > index 3f3f541e5d5f..7be9fb9146ac 100644
> > > > > --- a/include/linux/kasan.h
> > > > > +++ b/include/linux/kasan.h
> > > > > @@ -68,8 +68,6 @@ static inline void kasan_disable_current(void) {}
> > > > >
> > > > >  void kasan_unpoison_memory(const void *address, size_t size);
> > > > >
> > > > > -void kasan_unpoison_task_stack(struct task_struct *task);
> > > > > -
> > > > >  void kasan_alloc_pages(struct page *page, unsigned int order);
> > > > >  void kasan_free_pages(struct page *page, unsigned int order);
> > > > >
> > > > > @@ -114,8 +112,6 @@ void kasan_restore_multi_shot(bool enabled);
> > > > >
> > > > >  static inline void kasan_unpoison_memory(const void *address, size_t size) {}
> > > > >
> > > > > -static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> > > > > -
> > > > >  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
> > > > >  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> > > > >
> > > > > @@ -167,6 +163,12 @@ static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> > > > >
> > > > >  #endif /* CONFIG_KASAN */
> > > > >
> > > > > +#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> > > >
> > > > && defined(CONFIG_KASAN_STACK) for consistency
> > >
> > > CONFIG_KASAN_STACK is different from other KASAN configs. It's always
> > > defined, and its value is what controls whether stack instrumentation
> > > is enabled.
> >
> > Not sure why we did this instead of the following, but okay.
> >
> >  config KASAN_STACK
> > -       int
> > -       default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
> > -       default 0
> > +       bool
> > +       default y if KASAN_STACK_ENABLE || CC_IS_GCC
> > +       default n
> 
> I wondered the same, but then looking at scripts/Makefile.kasan I
> think it's because we directly pass it to the compiler:
>     ...
>     $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
>     ...

Try this instead:

      $(call cc-param,asan-stack=$(if $(CONFIG_KASAN_STACK),1,0)) \

-- 
Catalin
