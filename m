Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6902B8103
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgKRPna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgKRPn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:43:29 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C83EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:43:29 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 63so1206452qva.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ii8uMwZ11exGNZ0QuXQOuB3dAaW5Ak4GBCBwnjIahGo=;
        b=o2elT4rINyVBV6BS5aB0ifPHqNX9mYDaobsn69M6IaY1usexvUYK9bF6WDGHa47c2w
         HDuxyZnJdgFGCf45cUPY0MSima5dqX0FOH97IGhewfnyI2G3/6HKsVx4AkHi6WAtXYX1
         p9YUAEKIv/LWnOlu+IgcKCGOg6SYSNNoVCJ4BWDPTa4moU/RaVFPSXraHeP3bZyh1V//
         R1GJwaDbUX2LiwOOWLuDc3Q/F5M82/WgorGO12TnPxti1RVItz6+ZNKcT7kcrmQQMNCF
         RX0ygEcIF6fGaNWJzvA6uSaj4RLdNmm+TLM/jcc4c0ZAjLsau4tijF9aaHjHl+0b98Io
         5lTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ii8uMwZ11exGNZ0QuXQOuB3dAaW5Ak4GBCBwnjIahGo=;
        b=NKUPF1n2poAPmtCmg6FS/1g+hr9Kzcoa9ToXGLJOMydy6hT3mL+r42Td1jlfDkFceM
         RLkjlReuPTFTrN4hOuwUEc1LLlJ0YEKVU1B9NwIjJjrNkmZgMaOQDi3yuERNCuyWwqWE
         dlGSNhDSzA5yjd/Sw1gCgfI6XDh7bRppeXrG1MxxyJEJRG1M/0ekcMYa/WS5uQpMW6ge
         RRDuYhAHfQxhHzaiS41AFWZ2/JVeikHuclxg7ZiCfBGTsTN3I+UWl6AiXwitifFuMmf3
         Xbraau7Pp02HojdxazPurasI/csvYHjl9A0/qlDVbvuH2BuNC5vNHwSJB6qs3AJ99P8V
         Fjyw==
X-Gm-Message-State: AOAM533SvMon1pqIqZkRI+RcGFTB8ccZwXE0zr415PhOFDVaW6kgEiMZ
        mQaro1LIpeg9fA6r4fEG75yc500QXkuAY7yRjoZHfA==
X-Google-Smtp-Source: ABdhPJxLmAnSOWQI2Qf7LFLVct0WnciQlBPqR78aT5f710dElggYdwcvRDEM1AAuM9lbZrNxAZg3O4Ws6bHAYu910jk=
X-Received: by 2002:a0c:9e53:: with SMTP id z19mr5380322qve.23.1605714207999;
 Wed, 18 Nov 2020 07:43:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com> <f10443693b4dfd63477519e5f2e4fdc439c8c3c8.1605305705.git.andreyknvl@google.com>
In-Reply-To: <f10443693b4dfd63477519e5f2e4fdc439c8c3c8.1605305705.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 18 Nov 2020 16:43:16 +0100
Message-ID: <CAG_fn=We3geXieMD1PzFGj+d6wj8_uEpkE=UOn=jfFEciQM2gQ@mail.gmail.com>
Subject: Re: [PATCH mm v10 41/42] kasan: add documentation for hardware
 tag-based mode
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
> Add documentation for hardware tag-based KASAN mode and also add some
> clarifications for software tag-based mode.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: Ib46cb444cfdee44054628940a82f5139e10d0258
> ---
>  Documentation/dev-tools/kasan.rst | 80 +++++++++++++++++++++++--------
>  1 file changed, 59 insertions(+), 21 deletions(-)
>
> diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/=
kasan.rst
> index 2d55d788971c..ffbae8ce5748 100644
> --- a/Documentation/dev-tools/kasan.rst
> +++ b/Documentation/dev-tools/kasan.rst
> @@ -5,12 +5,14 @@ Overview
>  --------
>
>  KernelAddressSANitizer (KASAN) is a dynamic memory error detector design=
ed to
> -find out-of-bound and use-after-free bugs. KASAN has two modes: generic =
KASAN
> -(similar to userspace ASan) and software tag-based KASAN (similar to use=
rspace
> -HWASan).
> +find out-of-bound and use-after-free bugs. KASAN has three modes:
> +1. generic KASAN (similar to userspace ASan),
> +2. software tag-based KASAN (similar to userspace HWASan),
> +3. hardware tag-based KASAN (based on hardware memory tagging).
>
> -KASAN uses compile-time instrumentation to insert validity checks before=
 every
> -memory access, and therefore requires a compiler version that supports t=
hat.
> +Software KASAN modes (1 and 2) use compile-time instrumentation to inser=
t
> +validity checks before every memory access, and therefore require a comp=
iler
> +version that supports that.
>
>  Generic KASAN is supported in both GCC and Clang. With GCC it requires v=
ersion
>  8.3.0 or later. Any supported Clang version is compatible, but detection=
 of
> @@ -19,7 +21,7 @@ out-of-bounds accesses for global variables is only sup=
ported since Clang 11.
>  Tag-based KASAN is only supported in Clang.
>
>  Currently generic KASAN is supported for the x86_64, arm, arm64, xtensa,=
 s390
> -and riscv architectures, and tag-based KASAN is supported only for arm64=
.
> +and riscv architectures, and tag-based KASAN modes are supported only fo=
r arm64.
>
>  Usage
>  -----
> @@ -28,14 +30,16 @@ To enable KASAN configure kernel with::
>
>           CONFIG_KASAN =3D y
>
> -and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN) and
> -CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN).
> +and choose between CONFIG_KASAN_GENERIC (to enable generic KASAN),
> +CONFIG_KASAN_SW_TAGS (to enable software tag-based KASAN), and
> +CONFIG_KASAN_HW_TAGS (to enable hardware tag-based KASAN).
>
> -You also need to choose between CONFIG_KASAN_OUTLINE and CONFIG_KASAN_IN=
LINE.
> -Outline and inline are compiler instrumentation types. The former produc=
es
> -smaller binary while the latter is 1.1 - 2 times faster.
> +For software modes, you also need to choose between CONFIG_KASAN_OUTLINE=
 and
> +CONFIG_KASAN_INLINE. Outline and inline are compiler instrumentation typ=
es.
> +The former produces smaller binary while the latter is 1.1 - 2 times fas=
ter.
>
> -Both KASAN modes work with both SLUB and SLAB memory allocators.
> +Both software KASAN modes work with both SLUB and SLAB memory allocators=
,
> +hardware tag-based KASAN currently only support SLUB.
>  For better bug detection and nicer reporting, enable CONFIG_STACKTRACE.
>
>  To augment reports with last allocation and freeing stack of the physica=
l page,
> @@ -196,17 +200,24 @@ and the second to last.
>  Software tag-based KASAN
>  ~~~~~~~~~~~~~~~~~~~~~~~~
>
> -Tag-based KASAN uses the Top Byte Ignore (TBI) feature of modern arm64 C=
PUs to
> -store a pointer tag in the top byte of kernel pointers. Like generic KAS=
AN it
> -uses shadow memory to store memory tags associated with each 16-byte mem=
ory
> +Software tag-based KASAN requires software memory tagging support in the=
 form
> +of HWASan-like compiler instrumentation (see HWASan documentation for de=
tails).
> +
> +Software tag-based KASAN is currently only implemented for arm64 archite=
cture.
> +
> +Software tag-based KASAN uses the Top Byte Ignore (TBI) feature of arm64=
 CPUs
> +to store a pointer tag in the top byte of kernel pointers. Like generic =
KASAN
> +it uses shadow memory to store memory tags associated with each 16-byte =
memory
>  cell (therefore it dedicates 1/16th of the kernel memory for shadow memo=
ry).
>
> -On each memory allocation tag-based KASAN generates a random tag, tags t=
he
> -allocated memory with this tag, and embeds this tag into the returned po=
inter.
> +On each memory allocation software tag-based KASAN generates a random ta=
g, tags
> +the allocated memory with this tag, and embeds this tag into the returne=
d
> +pointer.
> +
>  Software tag-based KASAN uses compile-time instrumentation to insert che=
cks
>  before each memory access. These checks make sure that tag of the memory=
 that
>  is being accessed is equal to tag of the pointer that is used to access =
this
> -memory. In case of a tag mismatch tag-based KASAN prints a bug report.
> +memory. In case of a tag mismatch software tag-based KASAN prints a bug =
report.
>
>  Software tag-based KASAN also has two instrumentation modes (outline, th=
at
>  emits callbacks to check memory accesses; and inline, that performs the =
shadow
> @@ -215,9 +226,36 @@ simply printed from the function that performs the a=
ccess check. With inline
>  instrumentation a brk instruction is emitted by the compiler, and a dedi=
cated
>  brk handler is used to print bug reports.
>
> -A potential expansion of this mode is a hardware tag-based mode, which w=
ould
> -use hardware memory tagging support instead of compiler instrumentation =
and
> -manual shadow memory manipulation.
> +Software tag-based KASAN uses 0xFF as a match-all pointer tag (accesses =
through
> +pointers with 0xFF pointer tag aren't checked). The value 0xFE is curren=
tly
> +reserved to tag freed memory regions.
> +
> +Software tag-based KASAN currently only supports tagging of
> +kmem_cache_alloc/kmalloc and page_alloc memory.
> +
> +Hardware tag-based KASAN
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Hardware tag-based KASAN is similar to the software mode in concept, but=
 uses
> +hardware memory tagging support instead of compiler instrumentation and
> +shadow memory.
> +
> +Hardware tag-based KASAN is currently only implemented for arm64 archite=
cture
> +and based on both arm64 Memory Tagging Extension (MTE) introduced in ARM=
v8.5
> +Instruction Set Architecture, and Top Byte Ignore (TBI).
> +
> +Special arm64 instructions are used to assign memory tags for each alloc=
ation.
> +Same tags are assigned to pointers to those allocations. On every memory
> +access, hardware makes sure that tag of the memory that is being accesse=
d is
> +equal to tag of the pointer that is used to access this memory. In case =
of a
> +tag mismatch a fault is generated and a report is printed.
> +
> +Hardware tag-based KASAN uses 0xFF as a match-all pointer tag (accesses =
through
> +pointers with 0xFF pointer tag aren't checked). The value 0xFE is curren=
tly
> +reserved to tag freed memory regions.
> +
> +Hardware tag-based KASAN currently only supports tagging of
> +kmem_cache_alloc/kmalloc and page_alloc memory.
>
>  What memory accesses are sanitised by KASAN?
>  --------------------------------------------
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
