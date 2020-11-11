Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F392AF409
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKKOsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgKKOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:48:25 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28460C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:48:25 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id y22so2336862oti.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iW+SeLw4qDkPhrVByahN0lhroGswkKPImUUWFzcSB/M=;
        b=pIExn6DjZDiz41nnB+UVtf3RChKQkaTI1pK/tdQzJ2zalz0k0Ghxk8v+NMnwHyl4xj
         MwY5G2gXVFixJE1wz7nOsETnN409hNLrqPv/srUWmbiI/PuP72WLam9jRxZqhNSE/i4a
         GKMWDAVngBkFUtFsGdMoXz8YA1k7/ax80qXN2bW2484x5TaXuSKX0icDg2P22qlnMSBF
         LJMVvrYRv3EcyqVccIJVSEjuqO6/cafVpP4t1WL0tSYvnpx/7jcEQcjrJ2/lypKMxpHO
         VQFC8lU+0Caww7yDGVnQ9lNzaFhXnhorIhKacX5hJdEGPeTD40B3ZCrIamloVnP0djpt
         fV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iW+SeLw4qDkPhrVByahN0lhroGswkKPImUUWFzcSB/M=;
        b=JIfoOoG+Jv9WPHmq8iH2hNeZEgcoCKc+NX+BH1VodJUDxxgg8mCFhxdt/U1RR5JvRq
         QuTRb/ZDDIyR4Dyuso6Plgv8vHWkPSnKmoa/GtMfSqqNlL4/5YYGqiwFiK61qnYCSt1i
         rbiT1+4t3rEHDJCCCwmzQrl1j4L26gJD35oppS8EEHh0IQbcoxi6NuZQgQQVXR27hpHu
         HoBS71pyLR1JS2YzpYFg1PLrhxPHMvmhdlVL0igovSUZQLwgptXkXgYMPZOG4Hi4ADMw
         AIy/jT0+Ia8KGLvlPipTBdgtHAk7JKrJ9inNIXwJ4aKb2xfaqDNLQEa2q8HeHavA+gX4
         jmhw==
X-Gm-Message-State: AOAM532NNyo9AYkGo9UuY9uCWNJRpUQeb2dKr9x3CdOZRApzG6xB+8/y
        s0cm1hmzNarzodgOrOStTCcjsDxIngAchOKa5wRNT0wewh/MmA==
X-Google-Smtp-Source: ABdhPJxcrgaM0+jksvAj+ymOWurbMF3Iu3XACvQ1HFwd1s+eyWrBBDZp4E8Lt2+ys8P75/it9t4z3t/JetwfAk2T0ps=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr16663023oth.251.1605106104189;
 Wed, 11 Nov 2020 06:48:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <22c1a837d4d0c0b241a700c88f180f5e831a1953.1605046662.git.andreyknvl@google.com>
In-Reply-To: <22c1a837d4d0c0b241a700c88f180f5e831a1953.1605046662.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 11 Nov 2020 15:48:12 +0100
Message-ID: <CANpmjNOLQm3Em4uNKyrFsxD4umr0M22XYzah7TOGaJaSYCZe1Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/20] kasan, mm: check kasan_enabled in annotations
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 23:20, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> Declare the kasan_enabled static key in include/linux/kasan.h and in
> include/linux/mm.h and check it in all kasan annotations. This allows to
> avoid any slowdown caused by function calls when kasan_enabled is
> disabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I2589451d3c96c97abbcbf714baabe6161c6f153e
> ---
>  include/linux/kasan.h | 220 ++++++++++++++++++++++++++++++++----------
>  include/linux/mm.h    |  22 +++--
>  mm/kasan/common.c     |  60 ++++++------
>  3 files changed, 216 insertions(+), 86 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index f1a5042ae4fc..779f8e703982 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_KASAN_H
>  #define _LINUX_KASAN_H
>
> +#include <linux/jump_label.h>
>  #include <linux/types.h>
>
>  struct kmem_cache;
> @@ -74,56 +75,179 @@ static inline void kasan_disable_current(void) {}
>
>  #ifdef CONFIG_KASAN
>
> -void kasan_alloc_pages(struct page *page, unsigned int order);
> -void kasan_free_pages(struct page *page, unsigned int order);
> +struct kasan_cache {
> +       int alloc_meta_offset;
> +       int free_meta_offset;
> +};
>
> -void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> -                       slab_flags_t *flags);
> +#ifdef CONFIG_KASAN_HW_TAGS
> +DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +static inline kasan_enabled(void)

These are missing types, as noticed by Andrew:
https://marc.info/?l=linux-mm-commits&m=160505097028591&w=2

> +{
> +       return static_branch_likely(&kasan_flag_enabled);
> +}

I think this should be __always_inline, as not inlining is a bug.

Also, I believe that all the below wrappers need to become
__always_inline, as we really cannot tolerate them not being inlined.

> +#else
> +static inline kasan_enabled(void)
> +{
> +       return true;
> +}

(Some of these could be on 1 line, but I don't mind.)

> +#endif

> -void kasan_unpoison_data(const void *address, size_t size);
> -void kasan_unpoison_slab(const void *ptr);
> +void __kasan_alloc_pages(struct page *page, unsigned int order);
> +static inline void kasan_alloc_pages(struct page *page, unsigned int order)
> +{
> +       if (kasan_enabled())
> +               __kasan_alloc_pages(page, order);
> +}
>
> -void kasan_poison_slab(struct page *page);
> -void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
> -void kasan_poison_object_data(struct kmem_cache *cache, void *object);
> -void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> -                                       const void *object);
> +void __kasan_free_pages(struct page *page, unsigned int order);
> +static inline void kasan_free_pages(struct page *page, unsigned int order)
> +{
> +       if (kasan_enabled())
> +               __kasan_free_pages(page, order);
> +}
>
> -void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
> -                                               gfp_t flags);
> -void kasan_kfree_large(void *ptr, unsigned long ip);
> -void kasan_poison_kfree(void *ptr, unsigned long ip);
> -void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
> -                                       size_t size, gfp_t flags);
> -void * __must_check kasan_krealloc(const void *object, size_t new_size,
> -                                       gfp_t flags);
> +void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> +                               slab_flags_t *flags);
> +static inline void kasan_cache_create(struct kmem_cache *cache,
> +                       unsigned int *size, slab_flags_t *flags)
> +{
> +       if (kasan_enabled())
> +               __kasan_cache_create(cache, size, flags);
> +}
>
> -void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
> -                                       gfp_t flags);
> -bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> +size_t __kasan_metadata_size(struct kmem_cache *cache);
> +static inline size_t kasan_metadata_size(struct kmem_cache *cache)
> +{
> +       if (kasan_enabled())
> +               return __kasan_metadata_size(cache);
> +       return 0;
> +}
>
> -struct kasan_cache {
> -       int alloc_meta_offset;
> -       int free_meta_offset;
> -};
> +void __kasan_unpoison_data(const void *addr, size_t size);
> +static inline void kasan_unpoison_data(const void *addr, size_t size)
> +{
> +       if (kasan_enabled())
> +               __kasan_unpoison_data(addr, size);
> +}
> +
> +void __kasan_unpoison_slab(const void *ptr);
> +static inline void kasan_unpoison_slab(const void *ptr)
> +{
> +       if (kasan_enabled())
> +               __kasan_unpoison_slab(ptr);
> +}
> +
> +void __kasan_poison_slab(struct page *page);
> +static inline void kasan_poison_slab(struct page *page)
> +{
> +       if (kasan_enabled())
> +               return __kasan_poison_slab(page);
> +}
> +
> +void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
> +static inline void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
> +{
> +       if (kasan_enabled())
> +               return __kasan_unpoison_object_data(cache, object);
> +}
> +
> +void __kasan_poison_object_data(struct kmem_cache *cache, void *object);
> +static inline void kasan_poison_object_data(struct kmem_cache *cache, void *object)
> +{
> +       if (kasan_enabled())
> +               __kasan_poison_object_data(cache, object);
> +}
> +
> +void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
> +                                         const void *object);
> +static inline void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> +                                                     const void *object)
> +{
> +       if (kasan_enabled())
> +               return __kasan_init_slab_obj(cache, object);
> +       return (void *)object;
> +}
> +
> +bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> +static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip)
> +{
> +       if (kasan_enabled())
> +               return __kasan_slab_free(s, object, ip);
> +       return false;
> +}
> +
> +void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
> +                                      void *object, gfp_t flags);
> +static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
> +                                                  void *object, gfp_t flags)
> +{
> +       if (kasan_enabled())
> +               return __kasan_slab_alloc(s, object, flags);
> +       return object;
> +}
>
> -size_t kasan_metadata_size(struct kmem_cache *cache);
> +void * __must_check __kasan_kmalloc(struct kmem_cache *s, const void *object,
> +                                   size_t size, gfp_t flags);
> +static inline void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
> +                                               size_t size, gfp_t flags)
> +{
> +       if (kasan_enabled())
> +               return __kasan_kmalloc(s, object, size, flags);
> +       return (void *)object;
> +}
> +
> +void * __must_check __kasan_kmalloc_large(const void *ptr,
> +                                         size_t size, gfp_t flags);
> +static inline void * __must_check kasan_kmalloc_large(const void *ptr,
> +                                                     size_t size, gfp_t flags)
> +{
> +       if (kasan_enabled())
> +               return __kasan_kmalloc_large(ptr, size, flags);
> +       return (void *)ptr;
> +}
> +
> +void * __must_check __kasan_krealloc(const void *object,
> +                                    size_t new_size, gfp_t flags);
> +static inline void * __must_check kasan_krealloc(const void *object,
> +                                                size_t new_size, gfp_t flags)
> +{
> +       if (kasan_enabled())
> +               return __kasan_krealloc(object, new_size, flags);
> +       return (void *)object;
> +}
> +
> +void __kasan_poison_kfree(void *ptr, unsigned long ip);
> +static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
> +{
> +       if (kasan_enabled())
> +               __kasan_poison_kfree(ptr, ip);
> +}
> +
> +void __kasan_kfree_large(void *ptr, unsigned long ip);
> +static inline void kasan_kfree_large(void *ptr, unsigned long ip)
> +{
> +       if (kasan_enabled())
> +               __kasan_kfree_large(ptr, ip);
> +}
>
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
>
>  #else /* CONFIG_KASAN */
>
> +static inline kasan_enabled(void)
> +{
> +       return false;
> +}
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> -
>  static inline void kasan_cache_create(struct kmem_cache *cache,
>                                       unsigned int *size,
>                                       slab_flags_t *flags) {}
> -
> -static inline void kasan_unpoison_data(const void *address, size_t size) { }
> -static inline void kasan_unpoison_slab(const void *ptr) { }
> -
> +static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> +static inline void kasan_unpoison_data(const void *address, size_t size) {}
> +static inline void kasan_unpoison_slab(const void *ptr) {}
>  static inline void kasan_poison_slab(struct page *page) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>                                         void *object) {}
> @@ -134,36 +258,32 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
>  {
>         return (void *)object;
>  }
> -
> -static inline void *kasan_kmalloc_large(void *ptr, size_t size, gfp_t flags)
> +static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> +                                  unsigned long ip)
>  {
> -       return ptr;
> +       return false;
> +}
> +static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> +                                  gfp_t flags)
> +{
> +       return object;
>  }
> -static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
>  static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
>                                 size_t size, gfp_t flags)
>  {
>         return (void *)object;
>  }
> +static inline void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
> +{
> +       return (void *)ptr;
> +}
>  static inline void *kasan_krealloc(const void *object, size_t new_size,
>                                  gfp_t flags)
>  {
>         return (void *)object;
>  }
> -
> -static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> -                                  gfp_t flags)
> -{
> -       return object;
> -}
> -static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> -                                  unsigned long ip)
> -{
> -       return false;
> -}
> -
> -static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> +static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
> +static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
>
>  #endif /* CONFIG_KASAN */
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0793d03a4183..8d84a6b2fa3c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -31,6 +31,7 @@
>  #include <linux/sizes.h>
>  #include <linux/sched.h>
>  #include <linux/pgtable.h>
> +#include <linux/kasan.h>
>
>  struct mempolicy;
>  struct anon_vma;
> @@ -1414,22 +1415,30 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
>  #endif /* CONFIG_NUMA_BALANCING */
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
> -       return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> +       if (kasan_enabled())
> +               return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> +       return 0xff;
>  }
>
>  static inline void page_kasan_tag_set(struct page *page, u8 tag)
>  {
> -       page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
> -       page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> +       if (kasan_enabled()) {
> +               page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
> +               page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> +       }
>  }
>
>  static inline void page_kasan_tag_reset(struct page *page)
>  {
> -       page_kasan_tag_set(page, 0xff);
> +       if (kasan_enabled())
> +               page_kasan_tag_set(page, 0xff);
>  }
> -#else
> +
> +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> +
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
>         return 0xff;
> @@ -1437,7 +1446,8 @@ static inline u8 page_kasan_tag(const struct page *page)
>
>  static inline void page_kasan_tag_set(struct page *page, u8 tag) { }
>  static inline void page_kasan_tag_reset(struct page *page) { }
> -#endif
> +
> +#endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
>
>  static inline struct zone *page_zone(const struct page *page)
>  {
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index efad5ed6a3bd..385863eaec2c 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -81,7 +81,7 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  }
>  #endif /* CONFIG_KASAN_STACK */
>
> -void kasan_alloc_pages(struct page *page, unsigned int order)
> +void __kasan_alloc_pages(struct page *page, unsigned int order)
>  {
>         u8 tag;
>         unsigned long i;
> @@ -95,7 +95,7 @@ void kasan_alloc_pages(struct page *page, unsigned int order)
>         kasan_unpoison_memory(page_address(page), PAGE_SIZE << order);
>  }
>
> -void kasan_free_pages(struct page *page, unsigned int order)
> +void __kasan_free_pages(struct page *page, unsigned int order)
>  {
>         if (likely(!PageHighMem(page)))
>                 kasan_poison_memory(page_address(page),
> @@ -122,8 +122,8 @@ static inline unsigned int optimal_redzone(unsigned int object_size)
>                 object_size <= (1 << 16) - 1024 ? 1024 : 2048;
>  }
>
> -void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> -                       slab_flags_t *flags)
> +void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> +                         slab_flags_t *flags)
>  {
>         unsigned int orig_size = *size;
>         unsigned int redzone_size;
> @@ -168,7 +168,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>         *flags |= SLAB_KASAN;
>  }
>
> -size_t kasan_metadata_size(struct kmem_cache *cache)
> +size_t __kasan_metadata_size(struct kmem_cache *cache)
>  {
>         if (!kasan_stack_collection_enabled())
>                 return 0;
> @@ -191,17 +191,17 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>         return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>
> -void kasan_unpoison_data(const void *address, size_t size)
> +void __kasan_unpoison_data(const void *addr, size_t size)
>  {
> -       kasan_unpoison_memory(address, size);
> +       kasan_unpoison_memory(addr, size);
>  }
>
> -void kasan_unpoison_slab(const void *ptr)
> +void __kasan_unpoison_slab(const void *ptr)
>  {
>         kasan_unpoison_memory(ptr, __ksize(ptr));
>  }
>
> -void kasan_poison_slab(struct page *page)
> +void __kasan_poison_slab(struct page *page)
>  {
>         unsigned long i;
>
> @@ -211,12 +211,12 @@ void kasan_poison_slab(struct page *page)
>                         KASAN_KMALLOC_REDZONE);
>  }
>
> -void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
> +void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
>  {
>         kasan_unpoison_memory(object, cache->object_size);
>  }
>
> -void kasan_poison_object_data(struct kmem_cache *cache, void *object)
> +void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  {
>         kasan_poison_memory(object,
>                         round_up(cache->object_size, KASAN_GRANULE_SIZE),
> @@ -269,7 +269,7 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object,
>  #endif
>  }
>
> -void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> +void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>                                                 const void *object)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> @@ -288,7 +288,7 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>         return (void *)object;
>  }
>
> -static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> +static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>                               unsigned long ip, bool quarantine)
>  {
>         u8 tag;
> @@ -331,9 +331,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>         return IS_ENABLED(CONFIG_KASAN_GENERIC);
>  }
>
> -bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
> +bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>  {
> -       return __kasan_slab_free(cache, object, ip, true);
> +       return ____kasan_slab_free(cache, object, ip, true);
>  }
>
>  static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> @@ -341,7 +341,7 @@ static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>         kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
>  }
>
> -static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
> +static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>                                 size_t size, gfp_t flags, bool keep_tag)
>  {
>         unsigned long redzone_start;
> @@ -373,20 +373,20 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         return set_tag(object, tag);
>  }
>
> -void * __must_check kasan_slab_alloc(struct kmem_cache *cache, void *object,
> -                                       gfp_t flags)
> +void * __must_check __kasan_slab_alloc(struct kmem_cache *cache,
> +                                       void *object, gfp_t flags)
>  {
> -       return __kasan_kmalloc(cache, object, cache->object_size, flags, false);
> +       return ____kasan_kmalloc(cache, object, cache->object_size, flags, false);
>  }
>
> -void * __must_check kasan_kmalloc(struct kmem_cache *cache, const void *object,
> -                               size_t size, gfp_t flags)
> +void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object,
> +                                       size_t size, gfp_t flags)
>  {
> -       return __kasan_kmalloc(cache, object, size, flags, true);
> +       return ____kasan_kmalloc(cache, object, size, flags, true);
>  }
> -EXPORT_SYMBOL(kasan_kmalloc);
> +EXPORT_SYMBOL(__kasan_kmalloc);
>
> -void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
> +void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
>                                                 gfp_t flags)
>  {
>         struct page *page;
> @@ -411,7 +411,7 @@ void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
>         return (void *)ptr;
>  }
>
> -void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
> +void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flags)
>  {
>         struct page *page;
>
> @@ -421,13 +421,13 @@ void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
>         page = virt_to_head_page(object);
>
>         if (unlikely(!PageSlab(page)))
> -               return kasan_kmalloc_large(object, size, flags);
> +               return __kasan_kmalloc_large(object, size, flags);
>         else
> -               return __kasan_kmalloc(page->slab_cache, object, size,
> +               return ____kasan_kmalloc(page->slab_cache, object, size,
>                                                 flags, true);
>  }
>
> -void kasan_poison_kfree(void *ptr, unsigned long ip)
> +void __kasan_poison_kfree(void *ptr, unsigned long ip)
>  {
>         struct page *page;
>
> @@ -440,11 +440,11 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
>                 }
>                 kasan_poison_memory(ptr, page_size(page), KASAN_FREE_PAGE);
>         } else {
> -               __kasan_slab_free(page->slab_cache, ptr, ip, false);
> +               ____kasan_slab_free(page->slab_cache, ptr, ip, false);
>         }
>  }
>
> -void kasan_kfree_large(void *ptr, unsigned long ip)
> +void __kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>         if (ptr != page_address(virt_to_head_page(ptr)))
>                 kasan_report_invalid_free(ptr, ip);
> --
> 2.29.2.222.g5d2a92d10f8-goog
>
