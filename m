Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925C22B816A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgKRQEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgKRQEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:04:14 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BC4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:04:14 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id a13so2269590qkl.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mlFiY9rY2V1HzrQlBE+sq5fSkw65JXH+u+EE2Nk2n44=;
        b=bkJ9XPUmNNJ7/6NIKcAbzPhmQpCAtoRYSGEL4qMTRyQA5Pqkkzp/Mt31P4NRs5W9Yj
         ppD0Suno3fMJ75wBayjUV0JjcDrWqdxc3Vu0R6mZV8O+W5pfS3tO6n2Dwmcs8Hf8MKtM
         1VS49R0oKaHkuv+RKHCrEfeY1NdvtaAPPYfvWWZofovIPNIVJJ8yW6BSL+U9xpSZrfEn
         MkfcV1l7E3mzVM1MoHKgOIayblHGQNDveOaA5G1mgm2EQ5jXdl4miLiNzThpf5am5lJo
         03CiB2iVbdKFGn0Y4i2zx6OAm25M+fb0G3ZpRnzMjGPokXNfC+gcRr7jWicaP+smvCUd
         w+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mlFiY9rY2V1HzrQlBE+sq5fSkw65JXH+u+EE2Nk2n44=;
        b=CaFjYJfJHrEp7BeT1xLqhyIrptNEuq42EcQsgxLPf8tuKcAMFvpo/OIr0Vke6VFiBf
         XnEMzSCy1CNb+AVqR0IBSyU0txVkcimz4eAfIYRSAvmNyedrvwSUThg8c9pvXNcpNPgb
         kRQ4qeSS3Cul8zS3Fkxcn6f/zRRwmQARrcgDq1cUTT6ZJ5EWUx4mbltdSkH0lvNsRRHz
         SKQq3SFJnuOXh9JYiPCfAqns/wCmSE2dl1yiwyDdjwWNSqSPCI2t59Og0cK2C0VfjLqz
         H840Doo3xJgEYQ98DkjS0mIW1EwiFJ/fqRbX1O3iR//0eziTcAISyUX9tXlb//UUT2BF
         KgeA==
X-Gm-Message-State: AOAM530obBmnUVVUWNQwE/2PRpNF4cHAP56Nz6m0u6vAb8PSrySbhT87
        7jtTPFPLHoymSJEV77Y7RM1O7NMLrx3uvmtiIAL9fQ==
X-Google-Smtp-Source: ABdhPJwEPbJwrFv+0QgMETmeDZm0HCOqFCDLwfbZRkv+G6SWeQ2jvh0BYURYXScv2GYkJs9kwCrbu/srzzkQHjHfs1g=
X-Received: by 2002:a05:620a:f95:: with SMTP id b21mr5514724qkn.403.1605715453444;
 Wed, 18 Nov 2020 08:04:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com> <da7fc94554c52c63f957d82e46c5bc8a718b2b96.1605305705.git.andreyknvl@google.com>
In-Reply-To: <da7fc94554c52c63f957d82e46c5bc8a718b2b96.1605305705.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 18 Nov 2020 17:04:02 +0100
Message-ID: <CAG_fn=URYEvbfdZrdpZs8Uv7ui15oeBDNqB2WTXE2erFucQG4w@mail.gmail.com>
Subject: Re: [PATCH mm v10 23/42] kasan: introduce CONFIG_KASAN_HW_TAGS
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:17 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> This patch adds a configuration option for a new KASAN mode called
> hardware tag-based KASAN. This mode uses the memory tagging approach
> like the software tag-based mode, but relies on arm64 Memory Tagging
> Extension feature for tag management and access checking.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
> ---
>  lib/Kconfig.kasan | 61 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 44 insertions(+), 17 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index c0e9e7874122..f5fa4ba126bf 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
>  config HAVE_ARCH_KASAN_SW_TAGS
>         bool
>
> -config HAVE_ARCH_KASAN_VMALLOC
> +config HAVE_ARCH_KASAN_HW_TAGS
> +       bool
> +
> +config HAVE_ARCH_KASAN_VMALLOC
>         bool
>
>  config CC_HAS_KASAN_GENERIC
> @@ -15,16 +18,19 @@ config CC_HAS_KASAN_GENERIC
>  config CC_HAS_KASAN_SW_TAGS
>         def_bool $(cc-option, -fsanitize=3Dkernel-hwaddress)
>
> +# This option is only required for software KASAN modes.
> +# Old GCC versions don't have proper support for no_sanitize_address.
> +# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D89124 for details.
>  config CC_HAS_WORKING_NOSANITIZE_ADDRESS
>         def_bool !CC_IS_GCC || GCC_VERSION >=3D 80300
>
>  menuconfig KASAN
>         bool "KASAN: runtime memory debugger"
> -       depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> -                  (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
> +       depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> +                    (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) &=
& \
> +                   CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
> +                  HAVE_ARCH_KASAN_HW_TAGS
>         depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> -       depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> -       select CONSTRUCTORS
>         select STACKDEPOT
>         help
>           Enables KASAN (KernelAddressSANitizer) - runtime memory debugge=
r,
> @@ -37,18 +43,24 @@ choice
>         prompt "KASAN mode"
>         default KASAN_GENERIC
>         help
> -         KASAN has two modes: generic KASAN (similar to userspace ASan,
> -         x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
> -         software tag-based KASAN (a version based on software memory
> -         tagging, arm64 only, similar to userspace HWASan, enabled with
> -         CONFIG_KASAN_SW_TAGS).
> +         KASAN has three modes:
> +         1. generic KASAN (similar to userspace ASan,
> +            x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
> +         2. software tag-based KASAN (arm64 only, based on software
> +            memory tagging (similar to userspace HWASan), enabled with
> +            CONFIG_KASAN_SW_TAGS), and
> +         3. hardware tag-based KASAN (arm64 only, based on hardware
> +            memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
> +
> +         All KASAN modes are strictly debugging features.
>
> -         Both generic and tag-based KASAN are strictly debugging feature=
s.
> +         For better error reports enable CONFIG_STACKTRACE.
>
>  config KASAN_GENERIC
>         bool "Generic mode"
>         depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
>         select SLUB_DEBUG if SLUB
> +       select CONSTRUCTORS
>         help
>           Enables generic KASAN mode.
>
> @@ -61,8 +73,6 @@ config KASAN_GENERIC
>           and introduces an overhead of ~x1.5 for the rest of the allocat=
ions.
>           The performance slowdown is ~x3.
>
> -         For better error detection enable CONFIG_STACKTRACE.
> -
>           Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_S=
LAB
>           (the resulting kernel does not boot).
>
> @@ -70,11 +80,15 @@ config KASAN_SW_TAGS
>         bool "Software tag-based mode"
>         depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
>         select SLUB_DEBUG if SLUB
> +       select CONSTRUCTORS
>         help
>           Enables software tag-based KASAN mode.
>
> -         This mode requires Top Byte Ignore support by the CPU and there=
fore
> -         is only supported for arm64. This mode requires Clang.
> +         This mode require software memory tagging support in the form o=
f
> +         HWASan-like compiler instrumentation.
> +
> +         Currently this mode is only implemented for arm64 CPUs and reli=
es on
> +         Top Byte Ignore. This mode requires Clang.
>
>           This mode consumes about 1/16th of available memory at kernel s=
tart
>           and introduces an overhead of ~20% for the rest of the allocati=
ons.
> @@ -82,15 +96,27 @@ config KASAN_SW_TAGS
>           casting and comparison, as it embeds tags into the top byte of =
each
>           pointer.
>
> -         For better error detection enable CONFIG_STACKTRACE.
> -
>           Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_S=
LAB
>           (the resulting kernel does not boot).
>
> +config KASAN_HW_TAGS
> +       bool "Hardware tag-based mode"
> +       depends on HAVE_ARCH_KASAN_HW_TAGS
> +       depends on SLUB
> +       help
> +         Enables hardware tag-based KASAN mode.
> +
> +         This mode requires hardware memory tagging support, and can be =
used
> +         by any architecture that provides it.
> +
> +         Currently this mode is only implemented for arm64 CPUs starting=
 from
> +         ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ign=
ore.
> +
>  endchoice
>
>  choice
>         prompt "Instrumentation type"
> +       depends on KASAN_GENERIC || KASAN_SW_TAGS
>         default KASAN_OUTLINE
>
>  config KASAN_OUTLINE
> @@ -114,6 +140,7 @@ endchoice
>
>  config KASAN_STACK_ENABLE
>         bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !C=
OMPILE_TEST
> +       depends on KASAN_GENERIC || KASAN_SW_TAGS
>         help
>           The LLVM stack address sanitizer has a know problem that
>           causes excessive stack usage in a lot of functions, see
> --
> 2.29.2.299.gdc1121823c-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
