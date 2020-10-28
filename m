Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D97E29DA85
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390335AbgJ1XYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733103AbgJ1XLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:11:01 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD61C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:11:01 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j129so613135qke.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BV2fbXkevBYTBJzl8kvjc7MGIINM37SNxFV2YU5u4pc=;
        b=HT0S21FFEt+LKY4oXEUf6dkQ35v/XmYt4KlAwtTWz9MoKDVcYmi7ulko2Bd2xyQ/8x
         oG7TKCxunRYdFQCN24qaZtz/6sFftchSJ38Jw7Jk7zMVsZZwNbbiwY4dZTVLYaMutFVv
         zPknJDk+RMuhoxzzx4+mIT7kbu2EMzbsSblPQRZZcsLKgZb5oL6t9hH4AQJJXKVcBLH8
         +yj8zElTJxXtWM/3H7Jf4iI/FKvYIkUMWjFCYM6oEkxDr0yZNV7PchuN/5ZqO9hNWoZS
         xU1fa2y8jGP9UImBjMRQVIyf5/ehx8LCaq9xo8ntDGf+vXH0I0DprD+DWc90kNK5fcyc
         IkYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BV2fbXkevBYTBJzl8kvjc7MGIINM37SNxFV2YU5u4pc=;
        b=l80lvxrzYXjaI4o+gOFvQCHzMTyqQEX/q+ymp/w52Ko0zHRGuG8fIQdUSfNSf4LUpE
         pn3ayqOLQwvaiEwnASiOr8vKYGsILFVMye0b5COF5FRb7vBSeghHEdpuKioQwP4z09UB
         7SmgH8Pt+hzaSjA8f/D24iUkRTTmHN4Zj3bb7Utdw3l4w+n4vJLfmal9A4ht2rfrVAM+
         eJwuSoYhtqcGJnEmyfQ0vDP2rwBmA0OkqH8Kg2G9LDoSEUnhJykM0mfuoMY1vQ+3NNLu
         LYTEw1bIeoG2uVxW5ygVThSjp1son0GpWuNXzPDgFVJAf7ZRdBvEohsIdtoGEFC8iYhZ
         Gpmw==
X-Gm-Message-State: AOAM533nkTSJOQSzvDYStwibDdDBc04Y4ghuej9hq0gPKhqUnLMn59b4
        t/nWLeZnatCeI7uCjggHSJ61zieJrfCLHNGKuh2BRoNNgLGmLg==
X-Google-Smtp-Source: ABdhPJxl0qO8to3NJbfQAtehDg9+4/Sk3NGfn1TAKewWw3jUDYOR0ExTd1zLbMw7hj0IRx8TPOBHLOINw/p26OyC7Mg=
X-Received: by 2002:a05:620a:5b9:: with SMTP id q25mr6625803qkq.501.1603883314438;
 Wed, 28 Oct 2020 04:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <56b19be34ee958103481bdfc501978556a168b42.1603372719.git.andreyknvl@google.com>
In-Reply-To: <56b19be34ee958103481bdfc501978556a168b42.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 12:08:23 +0100
Message-ID: <CACT4Y+ZVjEQaQExenOPg-tXQKRE5wUEm_iDn5DUQH_4QC-DBzg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/21] kasan: inline random_tag for HW_TAGS
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
> Using random_tag() currently results in a function call. Move its
> definition to mm/kasan/kasan.h and turn it into a static inline function
> for hardware tag-based mode to avoid uneeded function call.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Iac5b2faf9a912900e16cca6834d621f5d4abf427
> ---
>  mm/kasan/hw_tags.c |  5 -----
>  mm/kasan/kasan.h   | 37 ++++++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index c3a0e83b5e7a..4c24bfcfeff9 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -36,11 +36,6 @@ void kasan_unpoison_memory(const void *address, size_t size)
>                           round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>
> -u8 random_tag(void)
> -{
> -       return get_random_tag();
> -}
> -
>  bool check_invalid_free(void *addr)
>  {
>         u8 ptr_tag = get_tag(addr);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 0ccbb3c4c519..94ba15c2f860 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -188,6 +188,12 @@ static inline bool addr_has_metadata(const void *addr)
>
>  #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
> +#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +void print_tags(u8 addr_tag, const void *addr);
> +#else
> +static inline void print_tags(u8 addr_tag, const void *addr) { }
> +#endif
> +
>  bool check_invalid_free(void *addr);
>
>  void *find_first_bad_addr(void *addr, size_t size);
> @@ -223,23 +229,6 @@ static inline void quarantine_reduce(void) { }
>  static inline void quarantine_remove_cache(struct kmem_cache *cache) { }
>  #endif
>
> -#if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> -
> -void print_tags(u8 addr_tag, const void *addr);
> -
> -u8 random_tag(void);
> -
> -#else
> -
> -static inline void print_tags(u8 addr_tag, const void *addr) { }
> -
> -static inline u8 random_tag(void)
> -{
> -       return 0;
> -}
> -
> -#endif
> -
>  #ifndef arch_kasan_set_tag
>  static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  {
> @@ -273,6 +262,20 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define get_mem_tag(addr)                      arch_get_mem_tag(addr)
>  #define set_mem_tag_range(addr, size, tag)     arch_set_mem_tag_range((addr), (size), (tag))
>
> +#ifdef CONFIG_KASAN_SW_TAGS
> +u8 random_tag(void);
> +#elif defined(CONFIG_KASAN_HW_TAGS)
> +static inline u8 random_tag(void)
> +{
> +       return get_random_tag();

What's the difference between random_tag() and get_random_tag()? Do we
need both?


> +}
> +#else
> +static inline u8 random_tag(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
