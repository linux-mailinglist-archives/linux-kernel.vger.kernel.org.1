Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248192AF629
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgKKQW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgKKQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:22:55 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927D5C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:22:53 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 11so2186727qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4pxKBBNtw3w8bZtwKeY4uxxTPtkqCJlv14cZKnd12N8=;
        b=s9iQSPUglwrvmQwLwgXuMEj6H28/AimZHja85rvGX+tLj99A4l1iqBEHTEclvRsHfd
         3fUWbiR+5M2ai+bHlIPMjOd5siskc1yErwkqdmWIqcbfAK5hO905Cnmrq/bQ7LG1pemr
         k9ryGXn/yOG2fPKPVAZGkRgPPPliBYTT5nqPfbhmALjlADfqwdN+c7avsoVEnNmulObj
         tWgqhIryOG1dN9FGm1ZQ0qYEN+k9rCq1waKS8U19VQCGPI5Fx9t27QDoI45oPYmwbRqp
         ilesuh0vMYM3d2odArUiO0MwYVLDQb0/Lx30JWplwHEf/adjZth0wy8bs27BtmoVdKid
         7pKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4pxKBBNtw3w8bZtwKeY4uxxTPtkqCJlv14cZKnd12N8=;
        b=RmJtKlg0fyRQx0PegyZNFIa/zIjS5neIjFCKvQlc5TEv983Z+77PNQ7HgDMJs+tEmy
         s+ZyrysG/eIs122c4lJodiBbj3zoII4Hy9RKQFOVWXjFwbo/plUZNoo8ysC7DBer5pjj
         dPSlfdAj6BlYHi9iuiMpVv8fgXg6FoosglDvGqtE3oj/mvWz4hx9n8dgvo+AXLO18lOV
         Z3718WphvCEauYIfD6TG+aLku42cMYZw08Cyr9RDjKDHIypndMZfWamn8w+6OTKcgX1Y
         QSp6fb+bqjH6KGJSTSW1MRmIfSc4kf8lIVt7A0GhLnwqeoqhg12swo5sZgUnS3+Beoyj
         e4Eg==
X-Gm-Message-State: AOAM533vyG2J/I5xUX1IWJVnvPxvbDBwjYDy99b/Gkjv3u8bHpf2kpuM
        7uxxCh2Bip8CJRtDgYEGNazLYzPzmOMlsVDc0UKZlQ==
X-Google-Smtp-Source: ABdhPJyZ5r3kYPuU7gwtGqg486U42ir13f81X89CZm/u1v7tfHVjUMEZGDjDkIUZKgN4kIPnMXXVNWESEJa/is5dxIA=
X-Received: by 2002:a37:b545:: with SMTP id e66mr8830539qkf.392.1605111772271;
 Wed, 11 Nov 2020 08:22:52 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <0fd556cf79c3eb44f3c22a63b9ad70d07d8e1045.1605046192.git.andreyknvl@google.com>
In-Reply-To: <0fd556cf79c3eb44f3c22a63b9ad70d07d8e1045.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:22:41 +0100
Message-ID: <CAG_fn=X_Suw5LALHm9f9s=ZgNSVZgHAjsghL5MLBPZ4EK7ghWA@mail.gmail.com>
Subject: Re: [PATCH v9 38/44] kasan, arm64: expand CONFIG_KASAN checks
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> Some #ifdef CONFIG_KASAN checks are only relevant for software KASAN
> modes (either related to shadow memory or compiler instrumentation).
> Expand those into CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I91e661e2c1627783cb845d877c6371dfc8779505
> ---
>  arch/arm64/Kconfig                 |  2 +-
>  arch/arm64/Makefile                |  2 +-
>  arch/arm64/include/asm/assembler.h |  2 +-
>  arch/arm64/include/asm/memory.h    |  2 +-
>  arch/arm64/include/asm/string.h    |  5 +++--
>  arch/arm64/kernel/head.S           |  2 +-
>  arch/arm64/kernel/image-vars.h     |  2 +-
>  arch/arm64/kernel/kaslr.c          |  3 ++-
>  arch/arm64/kernel/module.c         |  6 ++++--
>  arch/arm64/mm/ptdump.c             |  6 +++---
>  include/linux/kasan-checks.h       |  2 +-
>  include/linux/kasan.h              |  7 ++++---
>  include/linux/moduleloader.h       |  3 ++-
>  include/linux/string.h             |  2 +-
>  mm/ptdump.c                        | 13 ++++++++-----
>  scripts/Makefile.lib               |  2 ++
>  16 files changed, 36 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c84a0e6b4650..456741645f01 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -330,7 +330,7 @@ config BROKEN_GAS_INST
>
>  config KASAN_SHADOW_OFFSET
>         hex
> -       depends on KASAN
> +       depends on KASAN_GENERIC || KASAN_SW_TAGS
>         default 0xdfffa00000000000 if (ARM64_VA_BITS_48 || ARM64_VA_BITS_=
52) && !KASAN_SW_TAGS
>         default 0xdfffd00000000000 if ARM64_VA_BITS_47 && !KASAN_SW_TAGS
>         default 0xdffffe8000000000 if ARM64_VA_BITS_42 && !KASAN_SW_TAGS
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 50ad9cbccb51..0b31a3f06f15 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -141,7 +141,7 @@ head-y              :=3D arch/arm64/kernel/head.o
>
>  ifeq ($(CONFIG_KASAN_SW_TAGS), y)
>  KASAN_SHADOW_SCALE_SHIFT :=3D 4
> -else
> +else ifeq ($(CONFIG_KASAN_GENERIC), y)
>  KASAN_SHADOW_SCALE_SHIFT :=3D 3
>  endif
>
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/=
assembler.h
> index ddbe6bf00e33..bf125c591116 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -473,7 +473,7 @@ USER(\label, ic     ivau, \tmp2)                    /=
/ invalidate I line PoU
>  #define NOKPROBE(x)
>  #endif
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define EXPORT_SYMBOL_NOKASAN(name)
>  #else
>  #define EXPORT_SYMBOL_NOKASAN(name)    EXPORT_SYMBOL(name)
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/mem=
ory.h
> index 419bbace29d5..656aaddb7014 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -72,7 +72,7 @@
>   * address space for the shadow region respectively. They can bloat the =
stack
>   * significantly, so double the (minimum) stack size when they are in us=
e.
>   */
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>  #define KASAN_SHADOW_END       ((UL(1) << (64 - KASAN_SHADOW_SCALE_SHIFT=
)) \
>                                         + KASAN_SHADOW_OFFSET)
> diff --git a/arch/arm64/include/asm/string.h b/arch/arm64/include/asm/str=
ing.h
> index b31e8e87a0db..3a3264ff47b9 100644
> --- a/arch/arm64/include/asm/string.h
> +++ b/arch/arm64/include/asm/string.h
> @@ -5,7 +5,7 @@
>  #ifndef __ASM_STRING_H
>  #define __ASM_STRING_H
>
> -#ifndef CONFIG_KASAN
> +#if !(defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
>  #define __HAVE_ARCH_STRRCHR
>  extern char *strrchr(const char *, int c);
>
> @@ -48,7 +48,8 @@ extern void *__memset(void *, int, __kernel_size_t);
>  void memcpy_flushcache(void *dst, const void *src, size_t cnt);
>  #endif
>
> -#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && =
\
> +       !defined(__SANITIZE_ADDRESS__)
>
>  /*
>   * For files that are not instrumented (e.g. mm/slub.c) we
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index d8d9caf02834..fdcb99d7ba23 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -448,7 +448,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>         bl      __pi_memset
>         dsb     ishst                           // Make zero page visible=
 to PTW
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         bl      kasan_early_init
>  #endif
>  #ifdef CONFIG_RANDOMIZE_BASE
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-var=
s.h
> index c615b285ff5b..4282edd2fe81 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -37,7 +37,7 @@ __efistub_strncmp             =3D __pi_strncmp;
>  __efistub_strrchr              =3D __pi_strrchr;
>  __efistub___clean_dcache_area_poc =3D __pi___clean_dcache_area_poc;
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  __efistub___memcpy             =3D __pi_memcpy;
>  __efistub___memmove            =3D __pi_memmove;
>  __efistub___memset             =3D __pi_memset;
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index b181e0544b79..e8e17e91aa02 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -151,7 +151,8 @@ u64 __init kaslr_early_init(u64 dt_phys)
>         /* use the top 16 bits to randomize the linear region */
>         memstart_offset_seed =3D seed >> 48;
>
> -       if (IS_ENABLED(CONFIG_KASAN))
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +           IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>                 /*
>                  * KASAN does not expect the module region to intersect t=
he
>                  * vmalloc region, since shadow memory is allocated for e=
ach
> diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
> index 2a1ad95d9b2c..fe21e0f06492 100644
> --- a/arch/arm64/kernel/module.c
> +++ b/arch/arm64/kernel/module.c
> @@ -30,7 +30,8 @@ void *module_alloc(unsigned long size)
>         if (IS_ENABLED(CONFIG_ARM64_MODULE_PLTS))
>                 gfp_mask |=3D __GFP_NOWARN;
>
> -       if (IS_ENABLED(CONFIG_KASAN))
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +           IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>                 /* don't exceed the static module region - see below */
>                 module_alloc_end =3D MODULES_END;
>
> @@ -39,7 +40,8 @@ void *module_alloc(unsigned long size)
>                                 NUMA_NO_NODE, __builtin_return_address(0)=
);
>
>         if (!p && IS_ENABLED(CONFIG_ARM64_MODULE_PLTS) &&
> -           !IS_ENABLED(CONFIG_KASAN))
> +           !IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> +           !IS_ENABLED(CONFIG_KASAN_SW_TAGS))
>                 /*
>                  * KASAN can only deal with module allocations being serv=
ed
>                  * from the reserved module region, since the remainder o=
f
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index 807dc634bbd2..04137a8f3d2d 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -29,7 +29,7 @@
>  enum address_markers_idx {
>         PAGE_OFFSET_NR =3D 0,
>         PAGE_END_NR,
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         KASAN_START_NR,
>  #endif
>  };
> @@ -37,7 +37,7 @@ enum address_markers_idx {
>  static struct addr_marker address_markers[] =3D {
>         { PAGE_OFFSET,                  "Linear Mapping start" },
>         { 0 /* PAGE_END */,             "Linear Mapping end" },
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         { 0 /* KASAN_SHADOW_START */,   "Kasan shadow start" },
>         { KASAN_SHADOW_END,             "Kasan shadow end" },
>  #endif
> @@ -383,7 +383,7 @@ void ptdump_check_wx(void)
>  static int ptdump_init(void)
>  {
>         address_markers[PAGE_END_NR].start_address =3D PAGE_END;
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         address_markers[KASAN_START_NR].start_address =3D KASAN_SHADOW_ST=
ART;
>  #endif
>         ptdump_initialize();
> diff --git a/include/linux/kasan-checks.h b/include/linux/kasan-checks.h
> index ac6aba632f2d..ca5e89fb10d3 100644
> --- a/include/linux/kasan-checks.h
> +++ b/include/linux/kasan-checks.h
> @@ -9,7 +9,7 @@
>   * even in compilation units that selectively disable KASAN, but must us=
e KASAN
>   * to validate access to an address.   Never use these in header files!
>   */
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  bool __kasan_check_read(const volatile void *p, unsigned int size);
>  bool __kasan_check_write(const volatile void *p, unsigned int size);
>  #else
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 1d6ec3325163..b6fc14b3da53 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -237,7 +237,8 @@ static inline void kasan_release_vmalloc(unsigned lon=
g start,
>
>  #endif /* CONFIG_KASAN_VMALLOC */
>
> -#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
> +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && =
\
> +               !defined(CONFIG_KASAN_VMALLOC)
>
>  /*
>   * These functions provide a special case to support backing module
> @@ -247,12 +248,12 @@ static inline void kasan_release_vmalloc(unsigned l=
ong start,
>  int kasan_module_alloc(void *addr, size_t size);
>  void kasan_free_shadow(const struct vm_struct *vm);
>
> -#else /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
> +#else /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASAN=
_VMALLOC */
>
>  static inline int kasan_module_alloc(void *addr, size_t size) { return 0=
; }
>  static inline void kasan_free_shadow(const struct vm_struct *vm) {}
>
> -#endif /* CONFIG_KASAN && !CONFIG_KASAN_VMALLOC */
> +#endif /* (CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS) && !CONFIG_KASA=
N_VMALLOC */
>
>  #ifdef CONFIG_KASAN_INLINE
>  void kasan_non_canonical_hook(unsigned long addr);
> diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
> index 4fa67a8b2265..9e09d11ffe5b 100644
> --- a/include/linux/moduleloader.h
> +++ b/include/linux/moduleloader.h
> @@ -96,7 +96,8 @@ void module_arch_cleanup(struct module *mod);
>  /* Any cleanup before freeing mod->module_init */
>  void module_arch_freeing_init(struct module *mod);
>
> -#if defined(CONFIG_KASAN) && !defined(CONFIG_KASAN_VMALLOC)
> +#if (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)) && =
\
> +               !defined(CONFIG_KASAN_VMALLOC)
>  #include <linux/kasan.h>
>  #define MODULE_ALIGN (PAGE_SIZE << KASAN_SHADOW_SCALE_SHIFT)
>  #else
> diff --git a/include/linux/string.h b/include/linux/string.h
> index b1f3894a0a3e..016a157e2251 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -266,7 +266,7 @@ void __write_overflow(void) __compiletime_error("dete=
cted write beyond size of o
>
>  #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FO=
RTIFY_SOURCE)
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  extern void *__underlying_memchr(const void *p, int c, __kernel_size_t s=
ize) __RENAME(memchr);
>  extern int __underlying_memcmp(const void *p, const void *q, __kernel_si=
ze_t size) __RENAME(memcmp);
>  extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t=
 size) __RENAME(memcpy);
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index ba88ec43ff21..4354c1422d57 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -4,7 +4,7 @@
>  #include <linux/ptdump.h>
>  #include <linux/kasan.h>
>
> -#ifdef CONFIG_KASAN
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  /*
>   * This is an optimization for KASAN=3Dy case. Since all kasan page tabl=
es
>   * eventually point to the kasan_early_shadow_page we could call note_pa=
ge()
> @@ -31,7 +31,8 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long a=
ddr,
>         struct ptdump_state *st =3D walk->private;
>         pgd_t val =3D READ_ONCE(*pgd);
>
> -#if CONFIG_PGTABLE_LEVELS > 4 && defined(CONFIG_KASAN)
> +#if CONFIG_PGTABLE_LEVELS > 4 && \
> +               (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW=
_TAGS))
>         if (pgd_page(val) =3D=3D virt_to_page(lm_alias(kasan_early_shadow=
_p4d)))
>                 return note_kasan_page_table(walk, addr);
>  #endif
> @@ -51,7 +52,8 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long a=
ddr,
>         struct ptdump_state *st =3D walk->private;
>         p4d_t val =3D READ_ONCE(*p4d);
>
> -#if CONFIG_PGTABLE_LEVELS > 3 && defined(CONFIG_KASAN)
> +#if CONFIG_PGTABLE_LEVELS > 3 && \
> +               (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW=
_TAGS))
>         if (p4d_page(val) =3D=3D virt_to_page(lm_alias(kasan_early_shadow=
_pud)))
>                 return note_kasan_page_table(walk, addr);
>  #endif
> @@ -71,7 +73,8 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long a=
ddr,
>         struct ptdump_state *st =3D walk->private;
>         pud_t val =3D READ_ONCE(*pud);
>
> -#if CONFIG_PGTABLE_LEVELS > 2 && defined(CONFIG_KASAN)
> +#if CONFIG_PGTABLE_LEVELS > 2 && \
> +               (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW=
_TAGS))
>         if (pud_page(val) =3D=3D virt_to_page(lm_alias(kasan_early_shadow=
_pmd)))
>                 return note_kasan_page_table(walk, addr);
>  #endif
> @@ -91,7 +94,7 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long a=
ddr,
>         struct ptdump_state *st =3D walk->private;
>         pmd_t val =3D READ_ONCE(*pmd);
>
> -#if defined(CONFIG_KASAN)
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>         if (pmd_page(val) =3D=3D virt_to_page(lm_alias(kasan_early_shadow=
_pte)))
>                 return note_kasan_page_table(walk, addr);
>  #endif
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 94133708889d..213677a5ed33 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -148,10 +148,12 @@ endif
>  # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KAS=
AN_SANITIZE)
>  #
>  ifeq ($(CONFIG_KASAN),y)
> +ifneq ($(CONFIG_KASAN_HW_TAGS),y)
>  _c_flags +=3D $(if $(patsubst n%,, \
>                 $(KASAN_SANITIZE_$(basetarget).o)$(KASAN_SANITIZE)y), \
>                 $(CFLAGS_KASAN), $(CFLAGS_KASAN_NOSANITIZE))
>  endif
> +endif
>
>  ifeq ($(CONFIG_UBSAN),y)
>  _c_flags +=3D $(if $(patsubst n%,, \
> --
> 2.29.2.222.g5d2a92d10f8-goog
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
