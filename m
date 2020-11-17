Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CC32B64FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbgKQNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731249AbgKQNZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:25:39 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3031DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:25:39 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so20281420qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 05:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WIETnv3xre8DddqB3eoABg/F+YsdxEpmfCm9JSQKUFk=;
        b=Ws9G6B7b9T2ql8gNctR3OGyYWvuBi6KB9dYkvha/s4Fdy+VKgIhfUwaNglXhaP6T1e
         6QlEGtPHpVS2HMAOYaPpmPDgZ/FKLEV2qVeOHRnL55hiJ45OYnjJp9cEq4LI1ujP1ywv
         MGtBEhMlob6/Aon+sdujY3CV5/Rw5Eh5tzfEBdx1i+UsA9/39T76sFL1Mq4/OPOdUqqB
         Z7k1KFGI8V/Zm9VsGDv6GszybCCSg1/KTFJHXqWY37xtH+4qKxRrSvYG6HE72PMu71BY
         1GsK03br4KCOGeQPO3QHSfAxPeHtnCmC+y5DYWSEklCdfF475a0BAWQQ4cVFTPllxTN/
         m6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WIETnv3xre8DddqB3eoABg/F+YsdxEpmfCm9JSQKUFk=;
        b=DknOTvCzoxVUqimXYypNUwg1YEKVSyfIWoDLmgFsHeH2G1QA/wRr3hi5g0wRwYFSdy
         ifnG8pW78CWg6mL5JNvEdbMJe8d/T+X3vH4mCR6ZTRL19//bY7LdT4cVekZrG8j3BCnP
         l4032kYi8DUhcoY2cDMTPhznu/uPBVrttr0CbmsiI6gvJQbbgHlu6Q3MZgjDZdKe8WpX
         SktQQhaAYwWrDpwFPjkrclyx/Kw0UD9j6hFdBLzVjTLKHHzdw8ECufUZeu1d91gGmo+z
         QxbzsPOdd50O6/78pV/A152+A3r1DN0GNVntjWEuY4nvlZDWEgIGUlWsisI6SIcrLHdk
         GXqw==
X-Gm-Message-State: AOAM532U8LDI80p5WLo+IvSbqbSndew1cPaL6MgG9lIgzOm1mlR9tz+p
        /WuKbLaIGpXG02vHiE2NFGUSXGnUmKoZuTeU540tGA==
X-Google-Smtp-Source: ABdhPJxyYRSCHeuJLL6jo54bMELiM3vOiXgrTULSLW30Z9NUQKn0110b8QbG6skCbWCzpB52giTilG3a1QL9Mb0/h7o=
X-Received: by 2002:a37:9747:: with SMTP id z68mr18952443qkd.424.1605619538042;
 Tue, 17 Nov 2020 05:25:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <6f0a1e72783ddac000ac08e7315b1d7c0ca4ec51.1605305978.git.andreyknvl@google.com>
In-Reply-To: <6f0a1e72783ddac000ac08e7315b1d7c0ca4ec51.1605305978.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Nov 2020 14:25:26 +0100
Message-ID: <CACT4Y+azmp-xczEt5rQmejtrnQ=e9PFC15tOHTjA3nHfgQ5gpg@mail.gmail.com>
Subject: Re: [PATCH mm v3 18/19] kasan, mm: allow cache merging with no metadata
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> The reason cache merging is disabled with KASAN is because KASAN puts its
> metadata right after the allocated object. When the merged caches have
> slightly different sizes, the metadata ends up in different places, which
> KASAN doesn't support.
>
> It might be possible to adjust the metadata allocation algorithm and make
> it friendly to the cache merging code. Instead this change takes a simpler
> approach and allows merging caches when no metadata is present. Which is
> the case for hardware tag-based KASAN with kasan.mode=prod.
>
> Co-developed-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Signed-off-by: Vincenzo Frascino <Vincenzo.Frascino@arm.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba

Somehow gerrit contains an old version... so I was going to
independently propose what Marco already proposed as simplification...
until I looked at the patch in the email :)

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  include/linux/kasan.h | 21 +++++++++++++++++++--
>  mm/kasan/common.c     | 11 +++++++++++
>  mm/slab_common.c      |  3 ++-
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 16cf53eac29b..173a8e81d001 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -81,17 +81,30 @@ struct kasan_cache {
>  };
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> +
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +
>  static __always_inline bool kasan_enabled(void)
>  {
>         return static_branch_likely(&kasan_flag_enabled);
>  }
> -#else
> +
> +#else /* CONFIG_KASAN_HW_TAGS */
> +
>  static inline bool kasan_enabled(void)
>  {
>         return true;
>  }
> -#endif
> +
> +#endif /* CONFIG_KASAN_HW_TAGS */
> +
> +slab_flags_t __kasan_never_merge(void);
> +static __always_inline slab_flags_t kasan_never_merge(void)
> +{
> +       if (kasan_enabled())
> +               return __kasan_never_merge();
> +       return 0;
> +}
>
>  void __kasan_unpoison_range(const void *addr, size_t size);
>  static __always_inline void kasan_unpoison_range(const void *addr, size_t size)
> @@ -238,6 +251,10 @@ static inline bool kasan_enabled(void)
>  {
>         return false;
>  }
> +static inline slab_flags_t kasan_never_merge(void)
> +{
> +       return 0;
> +}
>  static inline void kasan_unpoison_range(const void *address, size_t size) {}
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index cf874243efab..a5a4dcb1254d 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -87,6 +87,17 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  }
>  #endif /* CONFIG_KASAN_STACK */
>
> +/*
> + * Only allow cache merging when stack collection is disabled and no metadata
> + * is present.
> + */
> +slab_flags_t __kasan_never_merge(void)
> +{
> +       if (kasan_stack_collection_enabled())
> +               return SLAB_KASAN;
> +       return 0;
> +}
> +
>  void __kasan_alloc_pages(struct page *page, unsigned int order)
>  {
>         u8 tag;
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 0b5ae1819a8b..075b23ce94ec 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -19,6 +19,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/proc_fs.h>
>  #include <linux/debugfs.h>
> +#include <linux/kasan.h>
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
>  #include <asm/page.h>
> @@ -54,7 +55,7 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
>   */
>  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>                 SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> -               SLAB_FAILSLAB | SLAB_KASAN)
> +               SLAB_FAILSLAB | kasan_never_merge())
>
>  #define SLAB_MERGE_SAME (SLAB_RECLAIM_ACCOUNT | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_ACCOUNT)
> --
> 2.29.2.299.gdc1121823c-goog
>
