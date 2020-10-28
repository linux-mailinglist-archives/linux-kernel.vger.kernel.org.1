Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CE829D8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbgJ1WlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388382AbgJ1Wj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:39:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB41BC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:39:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q199so527340qke.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gj1Q53KOuMFzpLJ+wtLX5dUP0ORJzeWOcnEBSsd3zsg=;
        b=uvnv6eHJe/dDr45Kvj32vroIsWN2bAAj80zmfZJ4dTfzwfmcBo3FUkSCmPYHxwjRuK
         2HfSWkQJyeRuT6YNCy0qSouEOvx/qI5p0TMUgf4ennvg3eTngtRXNmXExf9cK+3iVWpy
         RVIQis4Q0dFJfPBtNVwFgTRPbCXUTbF1CokrK/aRAExm6xLhHiwNH02MZFK4FwUuPRzI
         TZA4P8Eb3AtaNHOBTkaRF5ekDMgU/qIYgmStlzzu2fNewnK4SS6tncL6K0ruHLSaXBFm
         hwMViguDS3vEn3DwIuskyMAAWVbKV/MEIg4hHq/+cL6L7J3jeyaDHYukwgAMZEWyTheu
         2ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gj1Q53KOuMFzpLJ+wtLX5dUP0ORJzeWOcnEBSsd3zsg=;
        b=eVMr0lU16ImDRf06GPEYrM2PEgtetfKtwUkWQzwI9wuLMq5Mwi1eNZiwldH5NhDYQT
         Gdq2LxJ1zr7Sgy+/tR50dMFdhdScqHy/ycLuo3Vp6BGRiJkEYUbYTRvuwxuu8FiIvooM
         PtqyqaGn9587jXxVJKBtAbSzllEqQRYFphp+TMCo/jp+tljR4Dq3f4o9poQGHL+I0ike
         iBxL+ZjDCa9mSlZpxY8XGpFwihGNVsiT4jyciOww61pn7VYpRaCvJ44FR0XAerUGTl1e
         4TaTEK5Lu1GcLgf52EdeMigIRmt+hXCEFvS+kb1tPMnRoi9fPvI0MqXFkJbsEMPuhX5S
         OG2A==
X-Gm-Message-State: AOAM532AWULNnifG6zvSabm6VKrOfk2dz/oq0UzZZIAjTWnawVLCpO6A
        0b8Ty7osIQOOCnG8vIQKZDuNkz7lyXNzrsw+CV82G1Hp7e36mg==
X-Google-Smtp-Source: ABdhPJwz5LI1wTtoz7JkcOu7YaHctZL9O9XEBtkrHvdSRG0C6VVe9BPS3JLFJlc1ic3m7WuwJ8uKbxu1cBuZ0pb79/E=
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr7606223qtu.337.1603904147897;
 Wed, 28 Oct 2020 09:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ce573435398f21d3e604f104c29ba65eca70d9e7.1603372719.git.andreyknvl@google.com>
In-Reply-To: <ce573435398f21d3e604f104c29ba65eca70d9e7.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 17:55:36 +0100
Message-ID: <CACT4Y+YF9bL8jRjVMfryr+LExYjH-rNdDEq2SvuQD+rGT4mVJQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 16/21] kasan: optimize poisoning in kmalloc and krealloc
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

On Thu, Oct 22, 2020 at 3:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Since kasan_kmalloc() always follows kasan_slab_alloc(), there's no need
> to reunpoison the object data, only to poison the redzone.
>
> This requires changing kasan annotation for early SLUB cache to
> kasan_slab_alloc(). Otherwise kasan_kmalloc() doesn't untag the object.
> This doesn't do any functional changes, as kmem_cache_node->object_size
> is equal to sizeof(struct kmem_cache_node).
>
> Similarly for kasan_krealloc(), as it's called after ksize(), which
> already unpoisoned the object, there's no need to do it again.

Have you considered doing this the other way around: make krealloc
call __ksize and unpoison in kasan_krealloc?
This has the advantage of more precise poisoning as ksize will
unpoison the whole underlying object.

But then maybe we will need to move first checks in ksize into __ksize
as we may need them in krealloc as well.





> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I4083d3b55605f70fef79bca9b90843c4390296f2
> ---
>  mm/kasan/common.c | 31 +++++++++++++++++++++----------
>  mm/slub.c         |  3 +--
>  2 files changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c5ec60e1a4d2..a581937c2a44 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -360,8 +360,14 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>                 tag = assign_tag(cache, object, false, keep_tag);
>
> -       /* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
> -       kasan_unpoison_memory(set_tag(object, tag), size);
> +       /*
> +        * Don't unpoison the object when keeping the tag. Tag is kept for:
> +        * 1. krealloc(), and then the memory has already been unpoisoned via ksize();
> +        * 2. kmalloc(), and then the memory has already been unpoisoned by kasan_kmalloc().
> +        * Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS.
> +        */
> +       if (!keep_tag)
> +               kasan_unpoison_memory(set_tag(object, tag), size);
>         kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>                 KASAN_KMALLOC_REDZONE);
>
> @@ -384,10 +390,9 @@ void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object
>  }
>  EXPORT_SYMBOL(__kasan_kmalloc);
>
> -void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
> -                                               gfp_t flags)
> +static void * __must_check ____kasan_kmalloc_large(struct page *page, const void *ptr,
> +                                               size_t size, gfp_t flags, bool realloc)
>  {
> -       struct page *page;
>         unsigned long redzone_start;
>         unsigned long redzone_end;
>
> @@ -397,18 +402,24 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
>         if (unlikely(ptr == NULL))
>                 return NULL;
>
> -       page = virt_to_page(ptr);
> -       redzone_start = round_up((unsigned long)(ptr + size),
> -                               KASAN_GRANULE_SIZE);
> +       redzone_start = round_up((unsigned long)(ptr + size), KASAN_GRANULE_SIZE);
>         redzone_end = (unsigned long)ptr + page_size(page);
>
> -       kasan_unpoison_memory(ptr, size);
> +       /* ksize() in __do_krealloc() already unpoisoned the memory. */
> +       if (!realloc)
> +               kasan_unpoison_memory(ptr, size);
>         kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>                 KASAN_PAGE_REDZONE);
>
>         return (void *)ptr;
>  }
>
> +void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
> +                                               gfp_t flags)
> +{
> +       return ____kasan_kmalloc_large(virt_to_page(ptr), ptr, size, flags, false);
> +}
> +
>  void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flags)
>  {
>         struct page *page;
> @@ -419,7 +430,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
>         page = virt_to_head_page(object);
>
>         if (unlikely(!PageSlab(page)))
> -               return __kasan_kmalloc_large(object, size, flags);
> +               return ____kasan_kmalloc_large(page, object, size, flags, true);
>         else
>                 return ____kasan_kmalloc(page->slab_cache, object, size,
>                                                 flags, true);
> diff --git a/mm/slub.c b/mm/slub.c
> index 1d3f2355df3b..afb035b0bf2d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3535,8 +3535,7 @@ static void early_kmem_cache_node_alloc(int node)
>         init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
>         init_tracking(kmem_cache_node, n);
>  #endif
> -       n = kasan_kmalloc(kmem_cache_node, n, sizeof(struct kmem_cache_node),
> -                     GFP_KERNEL);
> +       n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL);
>         page->freelist = get_freepointer(kmem_cache_node, n);
>         page->inuse = 1;
>         page->frozen = 0;
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
