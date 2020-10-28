Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992DB29DFD2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbgJ2BE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgJ1WGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:06:04 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC6CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:06:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h12so661350qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BnTFjO5iPodWJwaiH+f8UvOorIZZfBBlIOwtDZT/AaY=;
        b=h3qRf1hhxPBFncyZU6ggg2vVRf3ny01avB3rYfcswnrnL7hpcvdQ/ffCr5ZbjB6NqW
         tlk7dvRBAX/tOJ++AAhJYiuW2zodOUkl8Gk58vDUuiblXQ9ZLGcDn8jLflHztUhbZWKE
         y4PN9oFn0AXRD4aSeNw4YsPkeFXja10LLv9FYGvelX2DjbrT5nR+S13oUOoPFrnLrUKo
         qOeHjJwAzGjgqJr4ADWW4oQZ0Bpi/dklAUdtQVBYAoH/se+qGLX9AA160DVpvCl9Qjit
         jv2iw7KvirDZ+Uk+DwP1LDgwoP0dH43sIQKbJHVLaZ9Lq7n6dWVC2R8vhv1jO8OKw0ev
         v/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BnTFjO5iPodWJwaiH+f8UvOorIZZfBBlIOwtDZT/AaY=;
        b=JCYHLa3b45eoBQcYEpDBNAEfquu17M2y6t5AiDLt93qG+v+MLQIvpA6eSUqRdgk8ni
         SuYpUIBkqMbOnutr1l1UR5mkvN1kDrF6YbfMFdWNon8vjf3kewTB5PIk6z2s/8rtaqmF
         DJ0ZHb0RNh/3dTS2EWk6k03/pu+vQ6dBDmtVdtbv2Or2tL80/pqCBdC1+F59T+7I8qmR
         Oq6Cedk30C6Ccjm9cH/Wt92NjEwUc4mnZaMf1EYfHaw8TMYChVa3NrZf6/amoj3C/fF3
         8eQiX+vsZ9WhebkAoN/vLQo7izlc4CL+WeI2m6QiCGU92s0It72fJTVeoRvpLeiKY5Vy
         C8aQ==
X-Gm-Message-State: AOAM533pkXw2xa2vLgk3N6oqNLrnDFeuRoBlnTiHebbwZAmeyziBwO5E
        T/Fnxy6u9HzzIodZTUl18TUoTIM3Z7RZTTOU0KJgeHSm/LoFog==
X-Google-Smtp-Source: ABdhPJzaSm5cm7TtWwkPsVr7gNmNlCL4EX8BlsO0vzHgljAGxOVHvBFFcnrWGxTyWKQ8aPnxQqB2zP5KvizdBxj5bJE=
X-Received: by 2002:a37:a00c:: with SMTP id j12mr834383qke.231.1603883132900;
 Wed, 28 Oct 2020 04:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <b75b7fe2842e916f5e39ac5355c29ae38a2c5e0a.1603372719.git.andreyknvl@google.com>
In-Reply-To: <b75b7fe2842e916f5e39ac5355c29ae38a2c5e0a.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 12:05:21 +0100
Message-ID: <CACT4Y+YcQH2mKv3y15XkWa-tKvyhRQHAw5dLVoAkFRWgFMLq1w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 09/21] kasan: inline kasan_reset_tag for tag-based modes
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
> Using kasan_reset_tag() currently results in a function call. As it's
> called quite often from the allocator code this leads to a noticeable
> slowdown. Move it to include/linux/kasan.h and turn it into a static
> inline function.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I4d2061acfe91d480a75df00b07c22d8494ef14b5
> ---
>  include/linux/kasan.h | 5 ++++-
>  mm/kasan/hw_tags.c    | 5 -----
>  mm/kasan/kasan.h      | 6 ++----
>  mm/kasan/sw_tags.c    | 5 -----
>  4 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 93d9834b7122..6377d7d3a951 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -187,7 +187,10 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>
>  void __init kasan_init_tags(void);
>
> -void *kasan_reset_tag(const void *addr);
> +static inline void *kasan_reset_tag(const void *addr)
> +{
> +       return (void *)arch_kasan_reset_tag(addr);

It seems that all implementations already return (void *), so the cast
is not needed.

> +}
>
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index b372421258c8..c3a0e83b5e7a 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -24,11 +24,6 @@ void __init kasan_init_tags(void)
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
>
> -void *kasan_reset_tag(const void *addr)
> -{
> -       return reset_tag(addr);
> -}
> -
>  void kasan_poison_memory(const void *address, size_t size, u8 value)
>  {
>         set_mem_tag_range(reset_tag(address),
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 456b264e5124..0ccbb3c4c519 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -246,15 +246,13 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>         return addr;
>  }
>  #endif
> -#ifndef arch_kasan_reset_tag
> -#define arch_kasan_reset_tag(addr)     ((void *)(addr))
> -#endif
>  #ifndef arch_kasan_get_tag
>  #define arch_kasan_get_tag(addr)       0
>  #endif
>
> +/* kasan_reset_tag() defined in include/linux/kasan.h. */
> +#define reset_tag(addr)                ((void *)kasan_reset_tag(addr))

The cast is not needed.

I would also now remove reset_tag entirely by replacing it with
kasan_reset_tag. Having 2 names for the same thing does not add
clarity.


>  #define set_tag(addr, tag)     ((void *)arch_kasan_set_tag((addr), (tag)))
> -#define reset_tag(addr)                ((void *)arch_kasan_reset_tag(addr))
>  #define get_tag(addr)          arch_kasan_get_tag(addr)
>
>  #ifndef arch_init_tags
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 099af6dc8f7e..4db41f274702 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -67,11 +67,6 @@ u8 random_tag(void)
>         return (u8)(state % (KASAN_TAG_MAX + 1));
>  }
>
> -void *kasan_reset_tag(const void *addr)
> -{
> -       return reset_tag(addr);
> -}
> -
>  bool check_memory_region(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip)
>  {
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
