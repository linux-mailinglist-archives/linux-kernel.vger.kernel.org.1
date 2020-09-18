Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCED727012D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgIRPg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgIRPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:36:28 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF66C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:36:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x69so7482787oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HOkTaJCWTKIpK+3x2SmmkvtVfO2tEwf9L1qfcnwH58=;
        b=MSGZJCQTueSyBkbGaTvUK+9fmTVvVaEsaP2HRwsVahJHE/eiRWOEtGM9gLA4RqPW3j
         JjKRkp1O03VrNP3Kx5bibC3TAvTzNnTykdABAdedoXgp8aNaymEM0WYdZGplKuL4F5to
         lKiEcDD6Ys+v7ml1ZKJnumtEjCzqvCAQVNuPvSbG5XoNXM3z4Kj7hKaLPjI/hXtYkHFR
         EuYIvheMCqyGlcDTCb9QGoC2sYY54u9gH41v7ALWW9olmGCw/fY7sopO5xVhff1LgOx3
         zcFHiyS5oYLF4YtoTpAcU75kHczcKzKyh7/afT2Bi2IseFMOqPby+r5wXkLih5Rx2OaX
         IqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HOkTaJCWTKIpK+3x2SmmkvtVfO2tEwf9L1qfcnwH58=;
        b=bH+WbqLffsweqvHarBbugS3UWsEBrpsFHem4b+ymcUvR53ob2p6IAVEIE5ascnCGCa
         hPcz7fbNIeyOaI/lFh44KfftuSMWoE/wOw0dynTJ+mwIoHEMoIQ6aZxljnCb41Z7zksR
         Bz0IMWCH/cKC7IoT5fMQLeE0r9Yo+M+fYXvYMvHnbfxtTxN/aTcKvwK/3CjBG/BTCQoC
         H3wIZ7S3fCt1bxm8hswHKqK8/WBg7uHyBMzEbXwGZBKhquKpoVklQ38glnOZtK8tis6e
         t31KHXNBjbDBWeOb4U2K8t5U0A57r8v3kheQ4QVZILDwhA54npQ6gFLfQVcL7gZq4P8e
         wC2Q==
X-Gm-Message-State: AOAM531Ol++UgCotp/38h2LDwJGBCVj+4tpk7S1/Pa2c94h0uNb8QC8i
        ZMYhuuBL824KousSO83gy/vgxNz4Em/Ncy887BVUJA==
X-Google-Smtp-Source: ABdhPJycDxki73QRk6YNewS2d6puW0XKYyUxUjwLmPM/TGzjNjKjIoHd8iB0G0aOGmeO0UG5zTvBivPJqmtPFr5qgpI=
X-Received: by 2002:aca:5158:: with SMTP id f85mr10175640oib.121.1600443387052;
 Fri, 18 Sep 2020 08:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <329ece34759c5208ae32a126dc5c978695ab1776.1600204505.git.andreyknvl@google.com>
 <20200918123249.GC2384246@elver.google.com> <CAAeHK+wF_tkBqHd7ESSa5jOy50AW1WfzSAM-qNf_+iMkLwptTQ@mail.gmail.com>
In-Reply-To: <CAAeHK+wF_tkBqHd7ESSa5jOy50AW1WfzSAM-qNf_+iMkLwptTQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 18 Sep 2020 17:36:15 +0200
Message-ID: <CANpmjNNrBX624GJWY3GK6YR9xoYX8BwstXaRYXJT1QgSFORSaQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/37] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
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

On Fri, 18 Sep 2020 at 17:06, 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Fri, Sep 18, 2020 at 2:32 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> > > This patch adds a configuration option for a new KASAN mode called
> > > hardware tag-based KASAN. This mode uses the memory tagging approach
> > > like the software tag-based mode, but relies on arm64 Memory Tagging
> > > Extension feature for tag management and access checking.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > > ---
> > > Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
> > > ---
> > >  lib/Kconfig.kasan | 56 +++++++++++++++++++++++++++++++++--------------
> > >  1 file changed, 39 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> > > index b4cf6c519d71..17c9ecfaecb9 100644
> > > --- a/lib/Kconfig.kasan
> > > +++ b/lib/Kconfig.kasan
> > > @@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
> > >  config HAVE_ARCH_KASAN_SW_TAGS
> > >       bool
> > >
> > > -config       HAVE_ARCH_KASAN_VMALLOC
> > > +config HAVE_ARCH_KASAN_HW_TAGS
> > > +     bool
> > > +
> > > +config HAVE_ARCH_KASAN_VMALLOC
> > >       bool
> > >
> > >  config CC_HAS_KASAN_GENERIC
> > > @@ -20,10 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
> > >
> > >  menuconfig KASAN
> > >       bool "KASAN: runtime memory debugger"
> > > -     depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> > > -                (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
> > > +     depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> > > +                  (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
> > > +                 CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
> > > +                HAVE_ARCH_KASAN_HW_TAGS
> > >       depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> > > -     depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> > >       select SLUB_DEBUG if SLUB
> >
> > Is SLUB_DEBUG necessary with HW_TAGS?
>
> I'll check and drop it if it's unnecessary.
>
> > >       select CONSTRUCTORS
> > >       select STACKDEPOT
> > > @@ -38,13 +42,18 @@ choice
> > >       prompt "KASAN mode"
> > >       default KASAN_GENERIC
> > >       help
> > > -       KASAN has two modes: generic KASAN (similar to userspace ASan,
> > > -       x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
> > > -       software tag-based KASAN (a version based on software memory
> > > -       tagging, arm64 only, similar to userspace HWASan, enabled with
> > > -       CONFIG_KASAN_SW_TAGS).
> > > +       KASAN has three modes:
> > > +       1. generic KASAN (similar to userspace ASan,
> > > +          x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
> > > +       2. software tag-based KASAN (arm64 only, based on software
> > > +          memory tagging (similar to userspace HWASan), enabled with
> > > +          CONFIG_KASAN_SW_TAGS), and
> > > +       3. hardware tag-based KASAN (arm64 only, based on hardware
> > > +          memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
> > >
> > > -       Both generic and tag-based KASAN are strictly debugging features.
> > > +       All KASAN modes are strictly debugging features.
> > > +
> > > +       For better error detection enable CONFIG_STACKTRACE.
> >
> > I don't think CONFIG_STACKTRACE improves error detection, right? It only
> > makes the reports more readable
>
> Yes, will fix.
>
> > >
> > >  config KASAN_GENERIC
> > >       bool "Generic mode"
> > > @@ -61,8 +70,6 @@ config KASAN_GENERIC
> > >         and introduces an overhead of ~x1.5 for the rest of the allocations.
> > >         The performance slowdown is ~x3.
> > >
> > > -       For better error detection enable CONFIG_STACKTRACE.
> > > -
> > >         Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
> > >         (the resulting kernel does not boot).
> > >
> > > @@ -72,9 +79,11 @@ config KASAN_SW_TAGS
> > >       help
> > >         Enables software tag-based KASAN mode.
> > >
> > > -       This mode requires Top Byte Ignore support by the CPU and therefore
> > > -       is only supported for arm64. This mode requires Clang version 7.0.0
> > > -       or later.
> > > +       This mode require software memory tagging support in the form of
> > > +       HWASan-like compiler instrumentation.
> > > +
> > > +       Currently this mode is only implemented for arm64 CPUs and relies on
> > > +       Top Byte Ignore. This mode requires Clang version 7.0.0 or later.
> > >
> > >         This mode consumes about 1/16th of available memory at kernel start
> > >         and introduces an overhead of ~20% for the rest of the allocations.
> > > @@ -82,15 +91,27 @@ config KASAN_SW_TAGS
> > >         casting and comparison, as it embeds tags into the top byte of each
> > >         pointer.
> > >
> > > -       For better error detection enable CONFIG_STACKTRACE.
> > > -
> > >         Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
> > >         (the resulting kernel does not boot).
> > >
> > > +config KASAN_HW_TAGS
> > > +     bool "Hardware tag-based mode"
> > > +     depends on HAVE_ARCH_KASAN_HW_TAGS
> > > +     depends on SLUB
> > > +     help
> > > +       Enables hardware tag-based KASAN mode.
> > > +
> > > +       This mode requires hardware memory tagging support, and can be used
> > > +       by any architecture that provides it.
> > > +
> > > +       Currently this mode is only implemented for arm64 CPUs starting from
> > > +       ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ignore.
> > > +
> > >  endchoice
> > >
> > >  choice
> > >       prompt "Instrumentation type"
> > > +     depends on KASAN_GENERIC || KASAN_SW_TAGS
> > >       default KASAN_OUTLINE
> > >
> > >  config KASAN_OUTLINE
> > > @@ -114,6 +135,7 @@ endchoice
> > >
> > >  config KASAN_STACK_ENABLE
> > >       bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> > > +     depends on KASAN_GENERIC || KASAN_SW_TAGS
> > >       help
> > >         The LLVM stack address sanitizer has a know problem that
> > >         causes excessive stack usage in a lot of functions, see
> >
> > How about something like the below change (introduce KASAN_INSTRUMENTED
> > Kconfig var) to avoid the repeated "KASAN_GENERIC || KASAN_SW_TAGS".
> > This could then also be used in the various .c/.h files (and make some
> > of the code more readable hopefully).
>
> I tried doing that initially, but it didn't really look good. The
> reason is that we actually have two properties that are currently
> common for the software modes, but aren't actually tied to each other:
> instrumentation and shadow memory. Therefore we will end up with two
> new configs: KASAN_INSTRUMENTED and KASAN_USES_SHADOW (or something),
> and things get quite confusing. I think it's better to keep
> KASAN_GENERIC || KASAN_SW_TAGS everywhere.

Ah, I see. So in some cases the reason the #ifdef exists is because of
instrumentation, in other cases because there is some shadow memory
(right?).

The only other option I see is to call it what it is ("KASAN_SW" or
"KASAN_SOFTWARE"), but other than that, I don't mind if it stays
as-is.

Thanks,
-- Marco
