Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21C29E225
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgJ2CLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgJ1ViA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:00 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5E7C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:38:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id r7so454829qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xtWeH9vKHS87nYy3SpCk02misk39ek51FjthjBeLR7U=;
        b=nVxi4QmlPRwCG5ENSq6Y/kcS/R/tAH6ALJ5DL1Q0SkjHocaBBe36+73OwpRYK1p73k
         6NlXVzpjzeSPJ7ZvL1Pv8y2esMIkA4EFuj80+WjoF+OJln9RmRcsiIpFQ4dP6MPPj4sG
         r1lWtlA77yP3pANJ3SG0zMXOAvmkKI614IV98c5NvoDiNMflp4X9Z8o2NzRkVbV6K39o
         yU7WAl2vG5YJ3sT6tFPeIqr56Q5knPRmQleMuj4npWX4M+2JlNrElSFx7ZOWYiit4qO/
         Kyi3h/oDiTddlytJM+UuIHGAgHWEiGwTi4a21qCmNUr5gSrOqJv8/CmIjEGXE9h+IA5k
         QE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xtWeH9vKHS87nYy3SpCk02misk39ek51FjthjBeLR7U=;
        b=StikMaCndjjmmtMAZPxgWVoRBHmLgV1kfzM+3A5gEmenxFXTnHZHua6m0TZga5iQs6
         iC1Z/WQDJitTnrJ8Av2MfA+GEp0vNJarx/V83Dgsxi0g/mIChy19wY2/OaMugSPNNLVL
         IEO8cNv1fEhR8e7CWclAW3wokMD8bwWhfwJri6uwOZVGvXtR6tIQsuANLoG/KPFLW8go
         kr+OupEac+kpPxwoXh/zEi8Y9L1+ytzCJFVFRu/Z/yd9fMSEI11AQ/Y/SzWLkV2cmNk2
         GaJgna8dnH/7uvYgEAAg+On2bTEIN2ta/25H2kukAQKsRubUU9bkutMuHUzcqzBhdnVC
         BVFA==
X-Gm-Message-State: AOAM5303rjbUjLkR386rhr7F9hGXj03JlLHXs1d3dI/MFKfwxhIIoJil
        sHKMN9W1fILRIDqej8lHuSkrAph3GjcC8H2tP56URFIKmqxHLg==
X-Google-Smtp-Source: ABdhPJz/AewA5C088h4+b6/U+Mjkm80aV8Lk6rSvIZIJVDXlLxxf0tWbupmZlj8P/uKrQE4AnpQA2e+GJOdJ1tn2wvM=
X-Received: by 2002:ac8:44ae:: with SMTP id a14mr6754128qto.67.1603885007705;
 Wed, 28 Oct 2020 04:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6f87cb86aeeca9f4148d435ff01ad7d21af4bdfc.1603372719.git.andreyknvl@google.com>
In-Reply-To: <6f87cb86aeeca9f4148d435ff01ad7d21af4bdfc.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 12:36:36 +0100
Message-ID: <CACT4Y+bJxJ+EeStyytnnRyjRwoZNPGJ9ws20GfoCBFGWvUSBPg@mail.gmail.com>
Subject: Re: [PATCH RFC v2 12/21] kasan: inline and rename kasan_unpoison_memory
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
> Currently kasan_unpoison_memory() is used as both an external annotation
> and as internal memory poisoning helper. Rename external annotation to
> kasan_unpoison_data() and inline the internal helper for for hardware
> tag-based mode to avoid undeeded function calls.
>
> There's the external annotation kasan_unpoison_slab() that is currently
> defined as static inline and uses kasan_unpoison_memory(). With this
> change it's turned into a function call. Overall, this results in the
> same number of calls for hardware tag-based mode as
> kasan_unpoison_memory() is now inlined.

Can't we leave kasan_unpoison_slab as is? Or there are other reasons
to uninline it?
It seems that uninling it is orthogonal to the rest of this patch.

> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ia7c8b659f79209935cbaab3913bf7f082cc43a0e
> ---
>  include/linux/kasan.h | 16 ++++++----------
>  kernel/fork.c         |  2 +-
>  mm/kasan/common.c     | 10 ++++++++++
>  mm/kasan/hw_tags.c    |  6 ------
>  mm/kasan/kasan.h      |  7 +++++++
>  mm/slab_common.c      |  2 +-
>  6 files changed, 25 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 6377d7d3a951..2b9023224474 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -66,14 +66,15 @@ static inline void kasan_disable_current(void) {}
>
>  #ifdef CONFIG_KASAN
>
> -void kasan_unpoison_memory(const void *address, size_t size);
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
>
>  void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         slab_flags_t *flags);
>
> +void kasan_unpoison_data(const void *address, size_t size);
> +void kasan_unpoison_slab(const void *ptr);
> +
>  void kasan_poison_slab(struct page *page);
>  void kasan_unpoison_object_data(struct kmem_cache *cache, void *object);
>  void kasan_poison_object_data(struct kmem_cache *cache, void *object);
> @@ -98,11 +99,6 @@ struct kasan_cache {
>         int free_meta_offset;
>  };
>
> -size_t __ksize(const void *);
> -static inline void kasan_unpoison_slab(const void *ptr)
> -{
> -       kasan_unpoison_memory(ptr, __ksize(ptr));
> -}
>  size_t kasan_metadata_size(struct kmem_cache *cache);
>
>  bool kasan_save_enable_multi_shot(void);
> @@ -110,8 +106,6 @@ void kasan_restore_multi_shot(bool enabled);
>
>  #else /* CONFIG_KASAN */
>
> -static inline void kasan_unpoison_memory(const void *address, size_t size) {}
> -
>  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
>  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
>
> @@ -119,6 +113,9 @@ static inline void kasan_cache_create(struct kmem_cache *cache,
>                                       unsigned int *size,
>                                       slab_flags_t *flags) {}
>
> +static inline void kasan_unpoison_data(const void *address, size_t size) { }
> +static inline void kasan_unpoison_slab(const void *ptr) { }
> +
>  static inline void kasan_poison_slab(struct page *page) {}
>  static inline void kasan_unpoison_object_data(struct kmem_cache *cache,
>                                         void *object) {}
> @@ -158,7 +155,6 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
>         return false;
>  }
>
> -static inline void kasan_unpoison_slab(const void *ptr) { }
>  static inline size_t kasan_metadata_size(struct kmem_cache *cache) { return 0; }
>
>  #endif /* CONFIG_KASAN */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b41fecca59d7..858d78eee6ec 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -225,7 +225,7 @@ static unsigned long *alloc_thread_stack_node(struct task_struct *tsk, int node)
>                         continue;
>
>                 /* Mark stack accessible for KASAN. */
> -               kasan_unpoison_memory(s->addr, THREAD_SIZE);
> +               kasan_unpoison_data(s->addr, THREAD_SIZE);
>
>                 /* Clear stale pointers from reused stack. */
>                 memset(s->addr, 0, THREAD_SIZE);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 9008fc6b0810..1a5e6c279a72 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -184,6 +184,16 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>         return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>
> +void kasan_unpoison_data(const void *address, size_t size)
> +{
> +       kasan_unpoison_memory(address, size);
> +}
> +
> +void kasan_unpoison_slab(const void *ptr)
> +{
> +       kasan_unpoison_memory(ptr, __ksize(ptr));
> +}
> +
>  void kasan_poison_slab(struct page *page)
>  {
>         unsigned long i;
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index f03161f3da19..915142da6b57 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -24,12 +24,6 @@ void __init kasan_init_tags(void)
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
>
> -void kasan_unpoison_memory(const void *address, size_t size)
> -{
> -       set_mem_tag_range(reset_tag(address),
> -                         round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> -}
> -
>  void kasan_set_free_info(struct kmem_cache *cache,
>                                 void *object, u8 tag)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 8d84ae6f58f1..da08b2533d73 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -280,6 +280,12 @@ static inline void kasan_poison_memory(const void *address, size_t size, u8 valu
>                           round_up(size, KASAN_GRANULE_SIZE), value);
>  }
>
> +static inline void kasan_unpoison_memory(const void *address, size_t size)
> +{
> +       set_mem_tag_range(reset_tag(address),
> +                         round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> +}
> +
>  static inline bool check_invalid_free(void *addr)
>  {
>         u8 ptr_tag = get_tag(addr);
> @@ -292,6 +298,7 @@ static inline bool check_invalid_free(void *addr)
>  #else /* CONFIG_KASAN_HW_TAGS */
>
>  void kasan_poison_memory(const void *address, size_t size, u8 value);
> +void kasan_unpoison_memory(const void *address, size_t size);
>  bool check_invalid_free(void *addr);
>
>  #endif /* CONFIG_KASAN_HW_TAGS */
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 53d0f8bb57ea..f1b0c4a22f08 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1176,7 +1176,7 @@ size_t ksize(const void *objp)
>          * We assume that ksize callers could use whole allocated area,
>          * so we need to unpoison this area.
>          */
> -       kasan_unpoison_memory(objp, size);
> +       kasan_unpoison_data(objp, size);
>         return size;
>  }
>  EXPORT_SYMBOL(ksize);
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
