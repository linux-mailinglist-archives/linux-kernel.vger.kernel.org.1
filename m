Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3529DCE1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgJ2AdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731746AbgJ1WXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:19 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775FBC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:23:19 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b69so506992qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/44VlBK6OKm+RXk0OJTWh6hF3WHJ///hTwLxttFcS6M=;
        b=moy3QtjPyL3cZ9xsAR+crMwlJ3jr7ixVIebxppVrc8dGFCovMimfDfFD90LygZcrsh
         Rx3LGU4VxFLTFIzKoaXqh75BHUiacUo02JaByhdySLZupWOYbHwbpwILgLI1FSLGWBjC
         ZLc2N+6dGWVTyl/zDZjvlcTglANqUFxj7H3XV381T1NhVv4/7m64Q15gIQhNfrKpYuFG
         I3xEltXbMvRa+iaqGSNHYKa6jgEz3JXVVURdPoh/DM45eUheJRBx83WeIojfALhx7q02
         jywkx5zTOHyz2jCXytrzHix59yRvFRwuawP0qHmWCoXaBpSMNWSWpKQyrOtBpw/up7tG
         n19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/44VlBK6OKm+RXk0OJTWh6hF3WHJ///hTwLxttFcS6M=;
        b=Eqhm5X8wQ3TsJuZcyUPXqXglRg9puuWBcEhhMi/rJ14Wjk3+y4k5G2xOAf2WgoDQPq
         dWuRLaTAKUGKeziyUZqdlPycLZS56wVVhKWx0wAAwTN20jiIq4sSdlcgSyJ+q12TXfjk
         POdypRAA9G/ySBXYimdmrEKqRnvLe3i1zhtcWh6nAbbQgpmn4xWSIyx9jT/sj1M9CJl+
         lgvfRtiCp31W/ptCYJqIZIwTJvxh3bB7PVcuoY3opd0xIJmTBC8TNKNowhxBNgGNB+yK
         FZAs09tIzpq3UPXDGS74Ifpq+nLx089c9TE8QaMe5arDWznVfHVkAKLpnmLfaq7/Ny6N
         hZ6g==
X-Gm-Message-State: AOAM533hiwlcnF/QX3qeDL7Ke1W7+FMG9rgC6hDUWdXLoQ1aSzZBVM1O
        k4W1qOdTiE7RlBk5gJ52f9himFh/c/8/GzaiACUH2HOjWWdulw==
X-Google-Smtp-Source: ABdhPJxWIdsJfS6ydyqUNERfH2TM2/Kde07YNypvw2f5tV+AK4gxs6r74i0fEIC6gEuqLgxHTNr/UVLd8f9srNcIMgo=
X-Received: by 2002:a05:620a:1188:: with SMTP id b8mr6917152qkk.265.1603885134792;
 Wed, 28 Oct 2020 04:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ae2caac58051ea4182c0278a1c1e4a945c3a1529.1603372719.git.andreyknvl@google.com>
In-Reply-To: <ae2caac58051ea4182c0278a1c1e4a945c3a1529.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 12:38:43 +0100
Message-ID: <CACT4Y+bG_xHcJqmXWKJseR7DWT=hg0AyJzmt8vC85jjL6JO-ZQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 13/21] arm64: kasan: Add cpu_supports_tags helper
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
> Add an arm64 helper called cpu_supports_mte() that exposes information
> about whether the CPU supports memory tagging and that can be called
> during early boot (unlike system_supports_mte()).
>
> Use that helper to implement a generic cpu_supports_tags() helper, that
> will be used by hardware tag-based KASAN.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ib4b56a42c57c6293df29a0cdfee334c3ca7bdab4

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  arch/arm64/include/asm/memory.h    |  1 +
>  arch/arm64/include/asm/mte-kasan.h |  6 ++++++
>  arch/arm64/kernel/mte.c            | 20 ++++++++++++++++++++
>  mm/kasan/kasan.h                   |  4 ++++
>  4 files changed, 31 insertions(+)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index b5d6b824c21c..f496abfcf7f5 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -232,6 +232,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
>  }
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> +#define arch_cpu_supports_tags()               cpu_supports_mte()
>  #define arch_init_tags(max_tag)                        mte_init_tags(max_tag)
>  #define arch_get_random_tag()                  mte_get_random_tag()
>  #define arch_get_mem_tag(addr)                 mte_get_mem_tag(addr)
> diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> index a4c61b926d4a..4c3f2c6b4fe6 100644
> --- a/arch/arm64/include/asm/mte-kasan.h
> +++ b/arch/arm64/include/asm/mte-kasan.h
> @@ -9,6 +9,7 @@
>
>  #ifndef __ASSEMBLY__
>
> +#include <linux/init.h>
>  #include <linux/types.h>
>
>  /*
> @@ -30,6 +31,7 @@ u8 mte_get_random_tag(void);
>  void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
>
>  void mte_init_tags(u64 max_tag);
> +bool __init cpu_supports_mte(void);
>
>  #else /* CONFIG_ARM64_MTE */
>
> @@ -54,6 +56,10 @@ static inline void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
>  static inline void mte_init_tags(u64 max_tag)
>  {
>  }
> +static inline bool cpu_supports_mte(void)
> +{
> +       return false;
> +}
>
>  #endif /* CONFIG_ARM64_MTE */
>
> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> index ca8206b7f9a6..8fcd17408515 100644
> --- a/arch/arm64/kernel/mte.c
> +++ b/arch/arm64/kernel/mte.c
> @@ -134,6 +134,26 @@ void mte_init_tags(u64 max_tag)
>         gcr_kernel_excl = ~incl & SYS_GCR_EL1_EXCL_MASK;
>  }
>
> +/*
> + * This function can be used during early boot to determine whether the CPU
> + * supports MTE. The alternative that must be used after boot is completed is
> + * system_supports_mte(), but it only works after the cpufeature framework
> + * learns about MTE.
> + */
> +bool __init cpu_supports_mte(void)
> +{
> +       u64 pfr1;
> +       u32 val;
> +
> +       if (!IS_ENABLED(CONFIG_ARM64_MTE))
> +               return false;
> +
> +       pfr1 = read_cpuid(ID_AA64PFR1_EL1);
> +       val = cpuid_feature_extract_unsigned_field(pfr1, ID_AA64PFR1_MTE_SHIFT);
> +
> +       return val >= ID_AA64PFR1_MTE;
> +}
> +
>  static void update_sctlr_el1_tcf0(u64 tcf0)
>  {
>         /* ISB required for the kernel uaccess routines */
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index da08b2533d73..f7ae0c23f023 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -240,6 +240,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define set_tag(addr, tag)     ((void *)arch_kasan_set_tag((addr), (tag)))
>  #define get_tag(addr)          arch_kasan_get_tag(addr)
>
> +#ifndef arch_cpu_supports_tags
> +#define arch_cpu_supports_tags() (false)
> +#endif
>  #ifndef arch_init_tags
>  #define arch_init_tags(max_tag)
>  #endif
> @@ -253,6 +256,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
>  #endif
>
> +#define cpu_supports_tags()                    arch_cpu_supports_tags()
>  #define init_tags(max_tag)                     arch_init_tags(max_tag)
>  #define get_random_tag()                       arch_get_random_tag()
>  #define get_mem_tag(addr)                      arch_get_mem_tag(addr)
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
