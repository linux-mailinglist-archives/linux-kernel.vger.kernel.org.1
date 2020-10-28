Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531BF29D613
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbgJ1WLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730667AbgJ1WLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:11:30 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B27CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:30 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x20so529856qkn.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/dbD6k4zYkgkO9i/jaBjHmJBv6HsgR1Y1s5z72VaeM=;
        b=jzDu0zGYV0sCIMDYmrlx17KFFoRGJVXaSP+JM88dVWILaYVrfQJE2VXQPgnQ08FRxE
         QVcSp4+JL+KPNLAVXckuIZnlh8outKNgN+r4OZy5Fg0EHiTuhqZWp7HA0Ur6plHHHYAY
         y7GCrQk65iuRcFAU2fhrOJIfSSX0Ynw+7qInYaqmCDYybwiImcylQ7pO4d3l28LpeU3O
         TJeSXadzPxxdW6NfHewQqmkw0OQvxiT9NG7G+DSlRxNymzsTIfX577sXouL34sZlZCUC
         i3YxGbxHXGXWVLkZ6Ya64js4/WG1rMD9FwW2zjJriSu0CK8TA1Jn8vXRILl0KfvspuuK
         scYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/dbD6k4zYkgkO9i/jaBjHmJBv6HsgR1Y1s5z72VaeM=;
        b=dTuB7ct2Se+mEO/PxAAaKI4SLtTqZdgSkNF3+/nh3grKcGFExohr/74moSWQRuZMbc
         bQ1V96K08Xk/BEzBw1iMAPemNHyLLSFvIhijvbo2EK51s0QxbZ3Albaan38HIYv7bOs4
         VzLot+CDougHxk+MvVGofIsEtASb2aUNhGqdPIL331Gs4rdQgtgOSQTDX70TkoNoSQaB
         I2OuzGVP4BJMliq6iGj824Q63oA8kYIF02CtP9mwwEOTFtJG9IS7C0J/WIJ416QJ7xJC
         HqhL5ivv0WFGn5VhqBW7iCe1ISx42JqcD5Pjcf+6PwehW7VK711fNVx8QOlOMn6uXQpo
         hcXw==
X-Gm-Message-State: AOAM530UQLkX8eOFz/oAtwYs/5wR7HOSaei1N22U2sYB+4HOHqMB2WWK
        HNf/kJRqb4+PSvJlR2bn+H8whCLYPxIxuLC7TiFkEt59MqqsjQ==
X-Google-Smtp-Source: ABdhPJxF7GbY5uAzlHVamEE2HLYsj+a+74v1Wuj5gYY+3vUFn7x8Uhm0uxbnb1tBMmwbqvDYgBze6LvlaqOptayTr5E=
X-Received: by 2002:ac8:44ae:: with SMTP id a14mr8151829qto.67.1603903670610;
 Wed, 28 Oct 2020 09:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <21fa5f4eb6ee132a57b716ff6245f2c98de2d204.1603372719.git.andreyknvl@google.com>
In-Reply-To: <21fa5f4eb6ee132a57b716ff6245f2c98de2d204.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 17:47:39 +0100
Message-ID: <CACT4Y+Z-BVAVy-WLLT7x8iFAzk+VoPSaiHK3xh9ya_2xJ-7hZA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 15/21] kasan: check kasan_enabled in annotations
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
> Declare the kasan_enabled static key in include/linux/kasan.h and in
> include/linux/mm.h and check it in all kasan annotations. This allows to
> avoid any slowdown caused by function calls when kasan_enabled is
> disabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I2589451d3c96c97abbcbf714baabe6161c6f153e
> ---
>  include/linux/kasan.h | 210 ++++++++++++++++++++++++++++++++----------
>  include/linux/mm.h    |  27 ++++--
>  mm/kasan/common.c     |  60 ++++++------
>  3 files changed, 211 insertions(+), 86 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 2b9023224474..8654275aa62e 100644
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
> @@ -66,40 +67,154 @@ static inline void kasan_disable_current(void) {}
>
>  #ifdef CONFIG_KASAN
>
> -void kasan_alloc_pages(struct page *page, unsigned int order);
> -void kasan_free_pages(struct page *page, unsigned int order);
> +struct kasan_cache {
> +       int alloc_meta_offset;
> +       int free_meta_offset;
> +};
> +
> +#ifdef CONFIG_KASAN_HW_TAGS
> +DECLARE_STATIC_KEY_FALSE(kasan_enabled);
> +#else
> +DECLARE_STATIC_KEY_TRUE(kasan_enabled);
> +#endif
>
> -void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> -                       slab_flags_t *flags);
> +void __kasan_alloc_pages(struct page *page, unsigned int order);
> +static inline void kasan_alloc_pages(struct page *page, unsigned int order)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_alloc_pages(page, order);

The patch looks fine per se, but I think with the suggestion in the
previous patch, this should be:

      if (kasan_is_enabled())
             __kasan_alloc_pages(page, order);

No overhead for other modes and less logic duplication.

> +}
>
> -void kasan_unpoison_data(const void *address, size_t size);
> -void kasan_unpoison_slab(const void *ptr);
> +void __kasan_free_pages(struct page *page, unsigned int order);
> +static inline void kasan_free_pages(struct page *page, unsigned int order)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_free_pages(page, order);
> +}
>
> -void kasan_poison_slab(struct page *page);
> -void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
> -void kasan_poison_object_data(struct kmem_cache *cache, void *object);
> -void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> -                                       const void *object);
> +void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
> +                               slab_flags_t *flags);
> +static inline void kasan_cache_create(struct kmem_cache *cache,
> +                       unsigned int *size, slab_flags_t *flags)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_cache_create(cache, size, flags);
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
> +size_t __kasan_metadata_size(struct kmem_cache *cache);
> +static inline size_t kasan_metadata_size(struct kmem_cache *cache)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_metadata_size(cache);
> +       return 0;
> +}
>
> -void * __must_check kasan_slab_alloc(struct kmem_cache *s, void *object,
> -                                       gfp_t flags);
> -bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> +void __kasan_unpoison_data(const void *addr, size_t size);
> +static inline void kasan_unpoison_data(const void *addr, size_t size)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_unpoison_data(addr, size);
> +}
>
> -struct kasan_cache {
> -       int alloc_meta_offset;
> -       int free_meta_offset;
> -};
> +void __kasan_unpoison_slab(const void *ptr);
> +static inline void kasan_unpoison_slab(const void *ptr)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_unpoison_slab(ptr);
> +}
> +
> +void __kasan_poison_slab(struct page *page);
> +static inline void kasan_poison_slab(struct page *page)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_poison_slab(page);
> +}
> +
> +void __kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
> +static inline void kasan_unpoison_object_data(struct kmem_cache *cache, void *object)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_unpoison_object_data(cache, object);
> +}
> +
> +void __kasan_poison_object_data(struct kmem_cache *cache, void *object);
> +static inline void kasan_poison_object_data(struct kmem_cache *cache, void *object)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_poison_object_data(cache, object);
> +}
> +
> +void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
> +                                         const void *object);
> +static inline void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> +                                                     const void *object)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_init_slab_obj(cache, object);
> +       return (void *)object;
> +}
> +
> +bool __kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip);
> +static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned long ip)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_slab_free(s, object, ip);
> +       return false;
> +}
>
> -size_t kasan_metadata_size(struct kmem_cache *cache);
> +void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
> +                                      void *object, gfp_t flags);
> +static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
> +                                                  void *object, gfp_t flags)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_slab_alloc(s, object, flags);
> +       return object;
> +}
> +
> +void * __must_check __kasan_kmalloc(struct kmem_cache *s, const void *object,
> +                                   size_t size, gfp_t flags);
> +static inline void * __must_check kasan_kmalloc(struct kmem_cache *s, const void *object,
> +                                               size_t size, gfp_t flags)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_kmalloc(s, object, size, flags);
> +       return (void *)object;
> +}
> +
> +void * __must_check __kasan_kmalloc_large(const void *ptr,
> +                                         size_t size, gfp_t flags);
> +static inline void * __must_check kasan_kmalloc_large(const void *ptr,
> +                                                     size_t size, gfp_t flags)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_kmalloc_large(ptr, size, flags);
> +       return (void *)ptr;
> +}
> +
> +void * __must_check __kasan_krealloc(const void *object,
> +                                    size_t new_size, gfp_t flags);
> +static inline void * __must_check kasan_krealloc(const void *object,
> +                                                size_t new_size, gfp_t flags)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               return __kasan_krealloc(object, new_size, flags);
> +       return (void *)object;
> +}
> +
> +void __kasan_poison_kfree(void *ptr, unsigned long ip);
> +static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_poison_kfree(ptr, ip);
> +}
> +
> +void __kasan_kfree_large(void *ptr, unsigned long ip);
> +static inline void kasan_kfree_large(void *ptr, unsigned long ip)
> +{
> +       if (static_branch_likely(&kasan_enabled))
> +               __kasan_kfree_large(ptr, ip);
> +}
>
>  bool kasan_save_enable_multi_shot(void);
>  void kasan_restore_multi_shot(bool enabled);
> @@ -108,14 +223,12 @@ void kasan_restore_multi_shot(bool enabled);
>
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
> @@ -126,36 +239,33 @@ static inline void *kasan_init_slab_obj(struct kmem_cache *cache,
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
>  }
> -static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
> -static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
> -                               size_t size, gfp_t flags)
> +static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> +                                  gfp_t flags)
>  {
> -       return (void *)object;
> +       return object;
>  }
> -static inline void *kasan_krealloc(const void *object, size_t new_size,
> -                                gfp_t flags)
> +static inline void *kasan_kmalloc(struct kmem_cache *s, const void *object,
> +                               size_t size, gfp_t flags)
>  {
>         return (void *)object;
>  }
>
> -static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> -                                  gfp_t flags)
> +static inline void *kasan_kmalloc_large(const void *ptr, size_t size, gfp_t flags)
>  {
> -       return object;
> +       return (void *)ptr;
>  }
> -static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> -                                  unsigned long ip)
> +static inline void *kasan_krealloc(const void *object, size_t new_size,
> +                                gfp_t flags)
>  {
> -       return false;
> +       return (void *)object;
>  }
> -
> -static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
> +static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
> +static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
>
>  #endif /* CONFIG_KASAN */
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a3cac68c737c..701e9d7666d6 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1412,22 +1412,36 @@ static inline bool cpupid_match_pid(struct task_struct *task, int cpupid)
>  #endif /* CONFIG_NUMA_BALANCING */
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
> +
> +#ifdef CONFIG_KASAN_HW_TAGS
> +DECLARE_STATIC_KEY_FALSE(kasan_enabled);
> +#else
> +DECLARE_STATIC_KEY_TRUE(kasan_enabled);
> +#endif
> +
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
> -       return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> +       if (static_branch_likely(&kasan_enabled))
> +               return (page->flags >> KASAN_TAG_PGSHIFT) & KASAN_TAG_MASK;
> +       return 0xff;
>  }
>
>  static inline void page_kasan_tag_set(struct page *page, u8 tag)
>  {
> -       page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
> -       page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> +       if (static_branch_likely(&kasan_enabled)) {
> +               page->flags &= ~(KASAN_TAG_MASK << KASAN_TAG_PGSHIFT);
> +               page->flags |= (tag & KASAN_TAG_MASK) << KASAN_TAG_PGSHIFT;
> +       }
>  }
>
>  static inline void page_kasan_tag_reset(struct page *page)
>  {
> -       page_kasan_tag_set(page, 0xff);
> +       if (static_branch_likely(&kasan_enabled))
> +               page_kasan_tag_set(page, 0xff);
>  }
> -#else
> +
> +#else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
> +
>  static inline u8 page_kasan_tag(const struct page *page)
>  {
>         return 0xff;
> @@ -1435,7 +1449,8 @@ static inline u8 page_kasan_tag(const struct page *page)
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
> index cc129ef62ab1..c5ec60e1a4d2 100644
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
> @@ -165,7 +165,7 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>         *flags |= SLAB_KASAN;
>  }
>
> -size_t kasan_metadata_size(struct kmem_cache *cache)
> +size_t __kasan_metadata_size(struct kmem_cache *cache)
>  {
>         if (static_branch_unlikely(&kasan_stack))
>                 return (cache->kasan_info.alloc_meta_offset ?
> @@ -188,17 +188,17 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>         return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
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
> @@ -208,12 +208,12 @@ void kasan_poison_slab(struct page *page)
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
> @@ -266,7 +266,7 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object,
>  #endif
>  }
>
> -void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> +void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>                                                 const void *object)
>  {
>         struct kasan_alloc_meta *alloc_meta;
> @@ -285,7 +285,7 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>         return (void *)object;
>  }
>
> -static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> +static bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>                               unsigned long ip, bool quarantine)
>  {
>         u8 tag;
> @@ -329,9 +329,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>         return false;
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
> @@ -339,7 +339,7 @@ static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
>         kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
>  }
>
> -static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
> +static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>                                 size_t size, gfp_t flags, bool keep_tag)
>  {
>         unsigned long redzone_start;
> @@ -371,20 +371,20 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
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
> @@ -409,7 +409,7 @@ void * __must_check kasan_kmalloc_large(const void *ptr, size_t size,
>         return (void *)ptr;
>  }
>
> -void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
> +void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flags)
>  {
>         struct page *page;
>
> @@ -419,13 +419,13 @@ void * __must_check kasan_krealloc(const void *object, size_t size, gfp_t flags)
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
> @@ -438,11 +438,11 @@ void kasan_poison_kfree(void *ptr, unsigned long ip)
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
> 2.29.0.rc1.297.gfa9743e501-goog
>
