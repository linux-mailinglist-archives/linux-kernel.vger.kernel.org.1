Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571392B5D74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKQK4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbgKQK4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:56:50 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5139C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:56:48 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id y11so10336426qvu.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 02:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ELfOh3o2Oz00GU28PxWEqBY//Oi7TOLxsG1nguiQlU=;
        b=V/pl5jqIh+2ezoffKlNITSMBE0cztAbTM+xvLzTsn+2LWIa2+mhS/l/P2vxcQhj8M6
         htu/SliDlpXQDIXZutlBibaqXHG/jXytFbOgRrA4r6wPZ/ne35vx4cMg104hQi61rujX
         yBvhh4hKGvZkV7P2WxykAOH6xwLyhmNtWT9Q5pgLnUi6/tIHqJjFz8Bet/Q8PI9YqlbE
         nNXLQuSbymSqn5+UOY/4lzVv120jtyXv2caC86g2sr4Mhq2UPXV3hT4S+vsuWPZJyY7d
         XHnpSaW4NZznafoOpG1kXPT7mX+DnQAdJapvgqZJfs6IGlXgUhGgNK2LZsWEamgEf2Ao
         RoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ELfOh3o2Oz00GU28PxWEqBY//Oi7TOLxsG1nguiQlU=;
        b=cFBdTc+DIvJhkpERwY57vHSeUl4F3BHw0yBvxHX+/bvCIag28DJeTMsvJiQNC/wG8f
         TU2u0asp+dXkVCkrDgKkn8yovB/WekfHdTcVe4DhQqPnCzUYihSa+SPDFYbvxiRFS7By
         0Ur670uq++yxkrzFrl8hv4srIjz2a+cZ46bNuxzlCyu2R62kwyxE1SMDyhFnkGU0YKXp
         f9nwcmsjgTi/ZfrVy+aUFqgyNsRIqqUlJTOB8QFjzpYTieaSXThV67i+esRQUKtdL2x+
         6tqylQFQGD8KRObDiQkidaC9mJtqPGdX3REEihZuJB344kZJqNSphPWHsuEdUHkqul0e
         tsdA==
X-Gm-Message-State: AOAM5301XkFgY8I85ylfSIaJcsUKeXob8GB+RS3vFblgrSfGGvrnP0QQ
        ryBRNEhLaG8bC+WwAA9OrygMzBn236N3U1LQ2H/CiA==
X-Google-Smtp-Source: ABdhPJxOpGPOi9L+fxrQF4m5lulcs6Mojw3PctNg0DwDGHv8FpOzPPM7+6WQHYQF9xcA2a+jDhrSZtMS2VLAlanH6Uk=
X-Received: by 2002:a05:6214:20a3:: with SMTP id 3mr253140qvd.13.1605610607646;
 Tue, 17 Nov 2020 02:56:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305978.git.andreyknvl@google.com> <4c2a23ccb3572459da7585a776d2d45f6e8b8580.1605305978.git.andreyknvl@google.com>
In-Reply-To: <4c2a23ccb3572459da7585a776d2d45f6e8b8580.1605305978.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Nov 2020 11:56:36 +0100
Message-ID: <CACT4Y+a8DFk_CqAV0JWSG57D-gQkSgEERYaHQwZAcPNUtZDvdQ@mail.gmail.com>
Subject: Re: [PATCH mm v3 07/19] kasan: inline kasan_reset_tag for tag-based modes
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
> Using kasan_reset_tag() currently results in a function call. As it's
> called quite often from the allocator code, this leads to a noticeable
> slowdown. Move it to include/linux/kasan.h and turn it into a static
> inline function. Also remove the now unneeded reset_tag() internal KASAN
> macro and use kasan_reset_tag() instead.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Marco Elver <elver@google.com>

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> Link: https://linux-review.googlesource.com/id/I4d2061acfe91d480a75df00b07c22d8494ef14b5
> ---
>  include/linux/kasan.h     | 5 ++++-
>  mm/kasan/common.c         | 6 +++---
>  mm/kasan/hw_tags.c        | 9 ++-------
>  mm/kasan/kasan.h          | 4 ----
>  mm/kasan/report.c         | 4 ++--
>  mm/kasan/report_hw_tags.c | 2 +-
>  mm/kasan/report_sw_tags.c | 4 ++--
>  mm/kasan/shadow.c         | 4 ++--
>  mm/kasan/sw_tags.c        | 9 ++-------
>  9 files changed, 18 insertions(+), 29 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index f2109bf0c5f9..1594177f86bb 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -193,7 +193,10 @@ static inline void kasan_record_aux_stack(void *ptr) {}
>
>  #if defined(CONFIG_KASAN_SW_TAGS) || defined(CONFIG_KASAN_HW_TAGS)
>
> -void *kasan_reset_tag(const void *addr);
> +static inline void *kasan_reset_tag(const void *addr)
> +{
> +       return (void *)arch_kasan_reset_tag(addr);
> +}
>
>  bool kasan_report(unsigned long addr, size_t size,
>                 bool is_write, unsigned long ip);
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index fabd843eff3d..1ac4f435c679 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -180,14 +180,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
>  struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
>                                               const void *object)
>  {
> -       return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
> +       return kasan_reset_tag(object) + cache->kasan_info.alloc_meta_offset;
>  }
>
>  struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>                                             const void *object)
>  {
>         BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
> -       return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
> +       return kasan_reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>
>  void kasan_poison_slab(struct page *page)
> @@ -284,7 +284,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>
>         tag = get_tag(object);
>         tagged_object = object;
> -       object = reset_tag(object);
> +       object = kasan_reset_tag(object);
>
>         if (is_kfence_address(object))
>                 return false;
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 68e77363e58b..a34476764f1d 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -31,18 +31,13 @@ void __init kasan_init_hw_tags(void)
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
>
> -void *kasan_reset_tag(const void *addr)
> -{
> -       return reset_tag(addr);
> -}
> -
>  void poison_range(const void *address, size_t size, u8 value)
>  {
>         /* Skip KFENCE memory if called explicitly outside of sl*b. */
>         if (is_kfence_address(address))
>                 return;
>
> -       hw_set_mem_tag_range(reset_tag(address),
> +       hw_set_mem_tag_range(kasan_reset_tag(address),
>                         round_up(size, KASAN_GRANULE_SIZE), value);
>  }
>
> @@ -52,7 +47,7 @@ void unpoison_range(const void *address, size_t size)
>         if (is_kfence_address(address))
>                 return;
>
> -       hw_set_mem_tag_range(reset_tag(address),
> +       hw_set_mem_tag_range(kasan_reset_tag(address),
>                         round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 0eab7e4cecb8..5e8cd2080369 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -248,15 +248,11 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
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
>  #define set_tag(addr, tag)     ((void *)arch_kasan_set_tag((addr), (tag)))
> -#define reset_tag(addr)                ((void *)arch_kasan_reset_tag(addr))
>  #define get_tag(addr)          arch_kasan_get_tag(addr)
>
>  #ifdef CONFIG_KASAN_HW_TAGS
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index df16bef0d810..76a0e3ae2049 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -328,7 +328,7 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>         unsigned long flags;
>         u8 tag = get_tag(object);
>
> -       object = reset_tag(object);
> +       object = kasan_reset_tag(object);
>
>  #if IS_ENABLED(CONFIG_KUNIT)
>         if (current->kunit_test)
> @@ -361,7 +361,7 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
>         disable_trace_on_warning();
>
>         tagged_addr = (void *)addr;
> -       untagged_addr = reset_tag(tagged_addr);
> +       untagged_addr = kasan_reset_tag(tagged_addr);
>
>         info.access_addr = tagged_addr;
>         if (addr_has_metadata(untagged_addr))
> diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
> index da543eb832cd..57114f0e14d1 100644
> --- a/mm/kasan/report_hw_tags.c
> +++ b/mm/kasan/report_hw_tags.c
> @@ -22,7 +22,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>
>  void *find_first_bad_addr(void *addr, size_t size)
>  {
> -       return reset_tag(addr);
> +       return kasan_reset_tag(addr);
>  }
>
>  void metadata_fetch_row(char *buffer, void *row)
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index 317100fd95b9..7604b46239d4 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -41,7 +41,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>         int i;
>
>         tag = get_tag(info->access_addr);
> -       addr = reset_tag(info->access_addr);
> +       addr = kasan_reset_tag(info->access_addr);
>         page = kasan_addr_to_page(addr);
>         if (page && PageSlab(page)) {
>                 cache = page->slab_cache;
> @@ -72,7 +72,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>  void *find_first_bad_addr(void *addr, size_t size)
>  {
>         u8 tag = get_tag(addr);
> -       void *p = reset_tag(addr);
> +       void *p = kasan_reset_tag(addr);
>         void *end = p + size;
>
>         while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index d8a122f887a0..37153bd1c126 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -82,7 +82,7 @@ void poison_range(const void *address, size_t size, u8 value)
>          * some of the callers (e.g. kasan_poison_object_data) pass tagged
>          * addresses to this function.
>          */
> -       address = reset_tag(address);
> +       address = kasan_reset_tag(address);
>
>         /* Skip KFENCE memory if called explicitly outside of sl*b. */
>         if (is_kfence_address(address))
> @@ -103,7 +103,7 @@ void unpoison_range(const void *address, size_t size)
>          * some of the callers (e.g. kasan_unpoison_object_data) pass tagged
>          * addresses to this function.
>          */
> -       address = reset_tag(address);
> +       address = kasan_reset_tag(address);
>
>         /*
>          * Skip KFENCE memory if called explicitly outside of sl*b. Also note
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 6d7648cc3b98..e17de2619bbf 100644
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
> @@ -107,7 +102,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>         if (tag == KASAN_TAG_KERNEL)
>                 return true;
>
> -       untagged_addr = reset_tag((const void *)addr);
> +       untagged_addr = kasan_reset_tag((const void *)addr);
>         if (unlikely(untagged_addr <
>                         kasan_shadow_to_mem((void *)KASAN_SHADOW_START))) {
>                 return !kasan_report(addr, size, write, ret_ip);
> @@ -126,7 +121,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
>  bool check_invalid_free(void *addr)
>  {
>         u8 tag = get_tag(addr);
> -       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag(addr)));
> +       u8 shadow_byte = READ_ONCE(*(u8 *)kasan_mem_to_shadow(kasan_reset_tag(addr)));
>
>         return (shadow_byte == KASAN_TAG_INVALID) ||
>                 (tag != KASAN_TAG_KERNEL && tag != shadow_byte);
> --
> 2.29.2.299.gdc1121823c-goog
>
