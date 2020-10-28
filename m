Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A780329D916
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbgJ1Wn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389494AbgJ1Wny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:43:54 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0682C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:43:53 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z6so571810qkz.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Xc9c29FA+GYfQKQjFulHFDr1xP7AG55TTtOHUWqRAY=;
        b=E6BSgQbSGDlSTN7HPIHDJ/BdEgY80jDDm8vopkX+hEVwsGV3h2/mbYrYGqdylcyxdA
         5+tNaqX6KrlOEq55j6lEqPli9lKhuXjb0z+XRBMrr011C6Irw7dy3nKagZIFCzd+jikP
         aEUkI3xU4D2N5VIjVxfUmWDiBt2hbIuJIGDYr8jc9LDxNaU8pxygPZjqjrzuIfAgwkV6
         ger3g6fw395Uf8aHjfbXf7TBi4WbAh2xI7NfS86JzAq2cARkaiW6RxjV6MD+2yz6DsN1
         C/yVBhRhE3aws8UaT+aeuCSEFuCGy7vasZ6dt1HczXEpyQRRZ0IHtZYv2CehjEo4RSvv
         JYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Xc9c29FA+GYfQKQjFulHFDr1xP7AG55TTtOHUWqRAY=;
        b=KQEiPpzJIgQ4qriGQaWBJjVzX6F8XCHdeocvQgcPafAiWbythN4gjK+uUnBiu2Oxdw
         /C56gwlGTjWxoZGmGLUARPzW7GxmdyjPl7d1KpVBAgIh15iJ3ZEc6twGddEdvDhoPUYm
         78qnGq9I2DxlHqJ8WDF5GUiizDxS+s4P6pw/vgLvRzvomEM3QVKc9j7/FN4y9ElBhfWe
         M1U5ffzUbs8KLCm6eo2sUfHsYntPxMxPEzPSdAJioTEKnWE7jWLuZhjkSPE0351WqQzO
         9XrbRQ2OdaMCadsEYfTIwt2dw+H30R/a9GjckEU9AgPH+UJz7oPJxUNNkAWXyvPuOoe1
         iWWQ==
X-Gm-Message-State: AOAM532o7xoY3WOUuCbfsaOgaLHhC5N8NfTBrhsIlY6/fUDamiD7RFDz
        0XP+Lx+kG2Sr5mSfPC+ZvvBOJ4ngD0odjDINGsxPDVRQ4lGcSA==
X-Google-Smtp-Source: ABdhPJwqOIb+3XgNehLv0cxHQ2ZjoGlJK+b6tjZ4gdRgnShqGfKBRmmQ5ljY9OpQAZG7k35gaoiZa/jbhr/jRgYQYxQ=
X-Received: by 2002:a05:620a:1188:: with SMTP id b8mr8384202qkk.265.1603904295369;
 Wed, 28 Oct 2020 09:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <5a6f32308101c49da5eef652437bd3da9234c0da.1603372719.git.andreyknvl@google.com>
In-Reply-To: <5a6f32308101c49da5eef652437bd3da9234c0da.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 17:58:03 +0100
Message-ID: <CACT4Y+Z88xqdz4vbPeLzPwxX77FJUxbz+bqiSs1aMDVSGxcpUg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 18/21] kasan: rename kasan_poison_kfree
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
> Rename kasan_poison_kfree() into kasan_slab_free_mempool() as it better
> reflects what this annotation does.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  include/linux/kasan.h | 16 ++++++++--------
>  mm/kasan/common.c     | 16 ++++++++--------
>  mm/mempool.c          |  2 +-
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 8654275aa62e..2ae92f295f76 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -162,6 +162,13 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned
>         return false;
>  }
>
> +void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
> +static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_slab_free_mempool(ptr, ip);
> +}
> +
>  void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
>                                        void *object, gfp_t flags);
>  static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
> @@ -202,13 +209,6 @@ static inline void * __must_check kasan_krealloc(const void *object,
>         return (void *)object;
>  }
>
> -void __kasan_poison_kfree(void *ptr, unsigned long ip);
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
> -{
> -       if (static_branch_likely(&kasan_enabled))
> -               __kasan_poison_kfree(ptr, ip);
> -}
> -
>  void __kasan_kfree_large(void *ptr, unsigned long ip);
>  static inline void kasan_kfree_large(void *ptr, unsigned long ip)
>  {
> @@ -244,6 +244,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>  {
>         return false;
>  }
> +static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
>  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
>                                    gfp_t flags)
>  {
> @@ -264,7 +265,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
>  {
>         return (void *)object;
>  }
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
>  static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
>
>  #endif /* CONFIG_KASAN */
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index b82dbae0c5d6..5622b0ec0907 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -334,6 +334,14 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>         return ____kasan_slab_free(cache, object, ip, true);
>  }
>
> +void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
> +{
> +       struct page *page;
> +
> +       page = virt_to_head_page(ptr);
> +       ____kasan_slab_free(page->slab_cache, ptr, ip, false);
> +}
> +
>  static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>  {
>         kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> @@ -436,14 +444,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
>                                                 flags, true);
>  }
>
> -void __kasan_poison_kfree(void *ptr, unsigned long ip)
> -{
> -       struct page *page;
> -
> -       page = virt_to_head_page(ptr);
> -       ____kasan_slab_free(page->slab_cache, ptr, ip, false);
> -}
> -
>  void __kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>         if (ptr != page_address(virt_to_head_page(ptr)))
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 79bff63ecf27..0e8d877fbbc6 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -106,7 +106,7 @@ static inline void poison_element(mempool_t *pool, void *element)
>  static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  {
>         if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> -               kasan_poison_kfree(element, _RET_IP_);
> +               kasan_slab_free_mempool(element, _RET_IP_);
>         if (pool->alloc == mempool_alloc_pages)
>                 kasan_free_pages(element, (unsigned long)pool->pool_data);
>  }
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
