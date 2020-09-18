Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65463270082
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIRPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRPGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:06:33 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:06:33 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so3630083pfk.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TokX/cApb7HEDUJUqNTQw5zrxkPkqdM85vur5KC2Xr4=;
        b=QngUTfXWesbMq8rO+ocht18+krYak4lpZf5vLUJOJg4gYNJ7EHk2UNXACXLWrlot/G
         bpGsGlVN6DU9k5wKgdIWkfCFA7ESAR19tM7NiS8LZ+o7KAN2FiUTB4rwsDsEAzRk7YOo
         +0qRRyorJUpDIX65+zAPvOUugM7YqbjggjxA/YDwYyc1XKfmBgHRjcqdyTBYHIfw482B
         U5+cuowsWjWnTWks6fwusSgk0mZSLPFDZVyTGSSMd+Yd9EqzFlJDeDPn8bUC9RLsLc6R
         7UwJPvmAdBcCZ2C9HnHTpMx5AuVwjq+q9vtwNTt+3UT0DFgeMhjUQ7P56gtU0eSt0quP
         uQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TokX/cApb7HEDUJUqNTQw5zrxkPkqdM85vur5KC2Xr4=;
        b=OKuia2rYVqMu1nOud2r67nczCyoxi/p3zXSYthRNyGCB2/XG37HvB0pBGYUpwGnp2/
         bh3lU8sK9AAYc/7nP0FNBR8gHLJdPr9SSIS00/153jXkkcWLsNVOxRaVovcdJYm0I8Yj
         XxSnbpLej+QD2xlAu0Wrb5bjso3bMqLNhoMmh0ij9ciOTdcNGHNLv2karRuhNLkHQ5uf
         p+DeGNSoHAijKEt/X0axyenSE8SctzP1BY+HjIAI9MCLIcqGTb4rJIqOZDERxuGlHZzI
         AnZ8F47Gf6wiN49f1Kbt2S2miEr4m5Q6ZCUsQPazZJdoB/VsdXPdh3BE/zk0tGdGY1om
         yUtQ==
X-Gm-Message-State: AOAM531iC3uxIixkeBYvkjxc86Jr/6qauCnzXgAaFa4bfHLdnY0Mrrx7
        vcRU2yMsz7DMZZvGDieRLMLCjJ2KUVmHUDDx+UkgrQ==
X-Google-Smtp-Source: ABdhPJzWTmWqIO4o1NHRtchE/7VfeSDWkcclq8WfIDQdB/vbq0h+ZsNZRaTzGOSEtWfEOLd6NZ7xvgrJQeIxj7FvqYk=
X-Received: by 2002:a62:1d51:0:b029:13e:d13d:a0fc with SMTP id
 d78-20020a621d510000b029013ed13da0fcmr33038595pfd.24.1600441592809; Fri, 18
 Sep 2020 08:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <329ece34759c5208ae32a126dc5c978695ab1776.1600204505.git.andreyknvl@google.com>
 <20200918123249.GC2384246@elver.google.com>
In-Reply-To: <20200918123249.GC2384246@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 17:06:21 +0200
Message-ID: <CAAeHK+wF_tkBqHd7ESSa5jOy50AW1WfzSAM-qNf_+iMkLwptTQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/37] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 2:32 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> > This patch adds a configuration option for a new KASAN mode called
> > hardware tag-based KASAN. This mode uses the memory tagging approach
> > like the software tag-based mode, but relies on arm64 Memory Tagging
> > Extension feature for tag management and access checking.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> > Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
> > ---
> >  lib/Kconfig.kasan | 56 +++++++++++++++++++++++++++++++++--------------
> >  1 file changed, 39 insertions(+), 17 deletions(-)
> >
> > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > index b4cf6c519d71..17c9ecfaecb9 100644
> > --- a/lib/Kconfig.kasan
> > +++ b/lib/Kconfig.kasan
> > @@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
> >  config HAVE_ARCH_KASAN_SW_TAGS
> >       bool
> >
> > -config       HAVE_ARCH_KASAN_VMALLOC
> > +config HAVE_ARCH_KASAN_HW_TAGS
> > +     bool
> > +
> > +config HAVE_ARCH_KASAN_VMALLOC
> >       bool
> >
> >  config CC_HAS_KASAN_GENERIC
> > @@ -20,10 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
> >
> >  menuconfig KASAN
> >       bool "KASAN: runtime memory debugger"
> > -     depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> > -                (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
> > +     depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> > +                  (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
> > +                 CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
> > +                HAVE_ARCH_KASAN_HW_TAGS
> >       depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> > -     depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> >       select SLUB_DEBUG if SLUB
>
> Is SLUB_DEBUG necessary with HW_TAGS?

I'll check and drop it if it's unnecessary.

> >       select CONSTRUCTORS
> >       select STACKDEPOT
> > @@ -38,13 +42,18 @@ choice
> >       prompt "KASAN mode"
> >       default KASAN_GENERIC
> >       help
> > -       KASAN has two modes: generic KASAN (similar to userspace ASan,
> > -       x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
> > -       software tag-based KASAN (a version based on software memory
> > -       tagging, arm64 only, similar to userspace HWASan, enabled with
> > -       CONFIG_KASAN_SW_TAGS).
> > +       KASAN has three modes:
> > +       1. generic KASAN (similar to userspace ASan,
> > +          x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
> > +       2. software tag-based KASAN (arm64 only, based on software
> > +          memory tagging (similar to userspace HWASan), enabled with
> > +          CONFIG_KASAN_SW_TAGS), and
> > +       3. hardware tag-based KASAN (arm64 only, based on hardware
> > +          memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
> >
> > -       Both generic and tag-based KASAN are strictly debugging features.
> > +       All KASAN modes are strictly debugging features.
> > +
> > +       For better error detection enable CONFIG_STACKTRACE.
>
> I don't think CONFIG_STACKTRACE improves error detection, right? It only
> makes the reports more readable

Yes, will fix.

> >
> >  config KASAN_GENERIC
> >       bool "Generic mode"
> > @@ -61,8 +70,6 @@ config KASAN_GENERIC
> >         and introduces an overhead of ~x1.5 for the rest of the allocations.
> >         The performance slowdown is ~x3.
> >
> > -       For better error detection enable CONFIG_STACKTRACE.
> > -
> >         Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
> >         (the resulting kernel does not boot).
> >
> > @@ -72,9 +79,11 @@ config KASAN_SW_TAGS
> >       help
> >         Enables software tag-based KASAN mode.
> >
> > -       This mode requires Top Byte Ignore support by the CPU and therefore
> > -       is only supported for arm64. This mode requires Clang version 7.0.0
> > -       or later.
> > +       This mode require software memory tagging support in the form of
> > +       HWASan-like compiler instrumentation.
> > +
> > +       Currently this mode is only implemented for arm64 CPUs and relies on
> > +       Top Byte Ignore. This mode requires Clang version 7.0.0 or later.
> >
> >         This mode consumes about 1/16th of available memory at kernel start
> >         and introduces an overhead of ~20% for the rest of the allocations.
> > @@ -82,15 +91,27 @@ config KASAN_SW_TAGS
> >         casting and comparison, as it embeds tags into the top byte of each
> >         pointer.
> >
> > -       For better error detection enable CONFIG_STACKTRACE.
> > -
> >         Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
> >         (the resulting kernel does not boot).
> >
> > +config KASAN_HW_TAGS
> > +     bool "Hardware tag-based mode"
> > +     depends on HAVE_ARCH_KASAN_HW_TAGS
> > +     depends on SLUB
> > +     help
> > +       Enables hardware tag-based KASAN mode.
> > +
> > +       This mode requires hardware memory tagging support, and can be used
> > +       by any architecture that provides it.
> > +
> > +       Currently this mode is only implemented for arm64 CPUs starting from
> > +       ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ignore.
> > +
> >  endchoice
> >
> >  choice
> >       prompt "Instrumentation type"
> > +     depends on KASAN_GENERIC || KASAN_SW_TAGS
> >       default KASAN_OUTLINE
> >
> >  config KASAN_OUTLINE
> > @@ -114,6 +135,7 @@ endchoice
> >
> >  config KASAN_STACK_ENABLE
> >       bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> > +     depends on KASAN_GENERIC || KASAN_SW_TAGS
> >       help
> >         The LLVM stack address sanitizer has a know problem that
> >         causes excessive stack usage in a lot of functions, see
>
> How about something like the below change (introduce KASAN_INSTRUMENTED
> Kconfig var) to avoid the repeated "KASAN_GENERIC || KASAN_SW_TAGS".
> This could then also be used in the various .c/.h files (and make some
> of the code more readable hopefully).

I tried doing that initially, but it didn't really look good. The
reason is that we actually have two properties that are currently
common for the software modes, but aren't actually tied to each other:
instrumentation and shadow memory. Therefore we will end up with two
new configs: KASAN_INSTRUMENTED and KASAN_USES_SHADOW (or something),
and things get quite confusing. I think it's better to keep
KASAN_GENERIC || KASAN_SW_TAGS everywhere.
