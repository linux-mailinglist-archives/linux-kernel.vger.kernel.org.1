Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45C28F406
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgJON4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbgJON4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:56:47 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A364C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:56:47 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e20so2927189otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=azn7RcXRIW2AkXttJaklQSujumQoQGs8XWpCExsNCq0=;
        b=KiIrGHoul2ccs3Wbr+R7w5nkCZlbsedwsT+JbKS7d/oEt0G7/k2rhKJ4uZyWk8NxQQ
         UTeUPsHhdPtA57r6FXXVfW1Z01iiyuwDAVV0bBgs5wOsx7ZuJZl4h+j6TPHGhCYm69ZZ
         VPjGO95Qo/wUWG0tVqKeOCw+1Q0hXZKE/8q8wrh+AyT728toYhQ+l+YxkA0nGUMyePpV
         mxqVGnkUgoDupK71DnX80GbQMwfcPfLIw1scDaPGfJrGm2un7q5V5DlucxfrHi4MDaEy
         mugIUVAPdHWBb/J6GadBK5G2hTosjOASAm8NBkvK5WwLzwD6KWyebu1h9q1HRXCgjlh/
         KYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=azn7RcXRIW2AkXttJaklQSujumQoQGs8XWpCExsNCq0=;
        b=saAt5rWpEZrR2XD6sMe8sGJSPugRI0OxkZQHuoeZootne0JTvL9CW4DCIQH7OapwLr
         BCu3H8X57QnHER75EMy6NmUtm2Y+R0zNcDyrv6mZJFo6G//mRHhEGrDCdx3qJY1ko+ef
         COhBgsgteTOGK6rRMHz4EPNASuhqRYf2eLePwW0oLWT9ywa7zc0csMakUaHFPkur1uZM
         pLvqOaCfnwhBxbHivPEyq0saiFHt4SWvt4iWV5zZ+ScfJ5O/7SRNHqw1pvI9fYwb+SwZ
         ohYmcCzEIj+PTbnI+bcuD3mHgS4pjSTxH/oe84HAJlo+tApHGcMXkXooWgwT9WK3YJE+
         zsoQ==
X-Gm-Message-State: AOAM5301lvZyoxa6sXQ3epHbkU4bY649tXmX8FTPQHncLI4ufzyYzrpk
        Xwm5BcCHI/5cSdQYwuhrDDQc9obkZQKhCUQXqW7A2Q==
X-Google-Smtp-Source: ABdhPJzVV9coYq2xzHcpUhiaf+N1W83ww+hMmic49Epx8ftziyXtVM+Oyi7XWWieom42y6gqfbT5tC07MLXLXU8hMo8=
X-Received: by 2002:a9d:649:: with SMTP id 67mr2884474otn.233.1602770206303;
 Thu, 15 Oct 2020 06:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602708025.git.andreyknvl@google.com> <c44b27703fb2fa11029ecd92522a66988295dfb6.1602708025.git.andreyknvl@google.com>
In-Reply-To: <c44b27703fb2fa11029ecd92522a66988295dfb6.1602708025.git.andreyknvl@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 15 Oct 2020 15:56:34 +0200
Message-ID: <CANpmjNMkZc6X+Z=Bw-hOXO3n9fzq4F3mOnHgieyifkoZM=_Mdw@mail.gmail.com>
Subject: Re: [PATCH RFC 8/8] kasan: add and integrate kasan_mode boot param
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
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

On Wed, 14 Oct 2020 at 22:45, Andrey Konovalov <andreyknvl@google.com> wrote:
>
> TODO: no meaningful description here yet, please see the cover letter
>       for this RFC series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/If7d37003875b2ed3e0935702c8015c223d6416a4
> ---
>  mm/kasan/common.c  | 69 +++++++++++++++++++++++++---------------------
>  mm/kasan/generic.c |  4 +++
>  mm/kasan/hw_tags.c | 53 +++++++++++++++++++++++++++++++++++
>  mm/kasan/kasan.h   |  8 ++++++
>  mm/kasan/report.c  | 10 +++++--
>  mm/kasan/sw_tags.c |  4 +++
>  6 files changed, 115 insertions(+), 33 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index a3e67d49b893..d642d5fce1e5 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -135,35 +135,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>         unsigned int redzone_size;
>         int redzone_adjust;
>
> -       /* Add alloc meta. */
> -       cache->kasan_info.alloc_meta_offset = *size;
> -       *size += sizeof(struct kasan_alloc_meta);
> -
> -       /* Add free meta. */
> -       if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> -           (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> -            cache->object_size < sizeof(struct kasan_free_meta))) {
> -               cache->kasan_info.free_meta_offset = *size;
> -               *size += sizeof(struct kasan_free_meta);
> -       }
> -
> -       redzone_size = optimal_redzone(cache->object_size);
> -       redzone_adjust = redzone_size - (*size - cache->object_size);
> -       if (redzone_adjust > 0)
> -               *size += redzone_adjust;
> -
> -       *size = min_t(unsigned int, KMALLOC_MAX_SIZE,
> -                       max(*size, cache->object_size + redzone_size));
> +       if (static_branch_unlikely(&kasan_debug)) {
> +               /* Add alloc meta. */
> +               cache->kasan_info.alloc_meta_offset = *size;
> +               *size += sizeof(struct kasan_alloc_meta);
> +
> +               /* Add free meta. */
> +               if (IS_ENABLED(CONFIG_KASAN_GENERIC) &&
> +                   (cache->flags & SLAB_TYPESAFE_BY_RCU || cache->ctor ||
> +                    cache->object_size < sizeof(struct kasan_free_meta))) {
> +                       cache->kasan_info.free_meta_offset = *size;
> +                       *size += sizeof(struct kasan_free_meta);
> +               }
>
> -       /*
> -        * If the metadata doesn't fit, don't enable KASAN at all.
> -        */
> -       if (*size <= cache->kasan_info.alloc_meta_offset ||
> -                       *size <= cache->kasan_info.free_meta_offset) {
> -               cache->kasan_info.alloc_meta_offset = 0;
> -               cache->kasan_info.free_meta_offset = 0;
> -               *size = orig_size;
> -               return;
> +               redzone_size = optimal_redzone(cache->object_size);
> +               redzone_adjust = redzone_size - (*size - cache->object_size);
> +               if (redzone_adjust > 0)
> +                       *size += redzone_adjust;
> +
> +               *size = min_t(unsigned int, KMALLOC_MAX_SIZE,
> +                               max(*size, cache->object_size + redzone_size));
> +
> +               /*
> +                * If the metadata doesn't fit, don't enable KASAN at all.
> +                */
> +               if (*size <= cache->kasan_info.alloc_meta_offset ||
> +                               *size <= cache->kasan_info.free_meta_offset) {
> +                       cache->kasan_info.alloc_meta_offset = 0;
> +                       cache->kasan_info.free_meta_offset = 0;
> +                       *size = orig_size;
> +                       return;
> +               }
>         }
>
>         *flags |= SLAB_KASAN;
> @@ -180,6 +182,7 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
>  struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
>                                               const void *object)
>  {
> +       WARN_ON(!static_branch_unlikely(&kasan_debug));

The WARN_ON condition itself should be unlikely, so that would imply
that the static branch here should be likely since you're negating it.
And AFAIK, this function should only be called if kasan_debug is true.

>         return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
>  }
>
> @@ -187,6 +190,7 @@ struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
>                                             const void *object)
>  {
>         BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
> +       WARN_ON(!static_branch_unlikely(&kasan_debug));

Same here.

>         return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
>  }
>
> @@ -266,8 +270,10 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>         if (!(cache->flags & SLAB_KASAN))
>                 return (void *)object;
>
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +       if (static_branch_unlikely(&kasan_debug)) {
> +               alloc_meta = kasan_get_alloc_meta(cache, object);
> +               __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +       }
>
>         if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>                 object = set_tag(object, assign_tag(cache, object, true, false));
> @@ -305,6 +311,7 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>         kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
>
>         if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
> +                       !static_branch_unlikely(&kasan_debug) ||
>                         unlikely(!(cache->flags & SLAB_KASAN)))
>                 return false;
>
> @@ -351,7 +358,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>                 KASAN_KMALLOC_REDZONE);
>
> -       if (cache->flags & SLAB_KASAN)
> +       if (static_branch_unlikely(&kasan_debug) && cache->flags & SLAB_KASAN)
>                 set_alloc_info(cache, (void *)object, flags);
>
>         return set_tag(object, tag);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d259e4c3aefd..9d968eaedc98 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -33,6 +33,10 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +/* See the comments in hw_tags.c */
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_debug);
> +
>  /*
>   * All functions below always inlined so compiler could
>   * perform better optimizations in each of __asan_loadX/__assn_storeX
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index b372421258c8..fc6ab1c8b155 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -8,6 +8,8 @@
>
>  #define pr_fmt(fmt) "kasan: " fmt
>
> +#include <linux/init.h>
> +#include <linux/jump_label.h>
>  #include <linux/kasan.h>
>  #include <linux/kernel.h>
>  #include <linux/memory.h>
> @@ -17,8 +19,57 @@
>
>  #include "kasan.h"
>
> +enum kasan_mode {
> +       KASAN_MODE_OFF,
> +       KASAN_MODE_ON,
> +       KASAN_MODE_DEBUG,
> +};
> +
> +static enum kasan_mode kasan_mode __ro_after_init;
> +
> +/* Whether KASAN is enabled at all. */
> +/* TODO: ideally no KASAN callbacks when this is disabled. */
> +DEFINE_STATIC_KEY_FALSE_RO(kasan_enabled);
> +
> +/* Whether to collect debugging info, e.g. alloc/free stack traces. */
> +DEFINE_STATIC_KEY_FALSE_RO(kasan_debug);
> +
> +/* Whether to use syncronous or asynchronous tag checking. */
> +static bool kasan_sync __ro_after_init;

s/syncronous/synchronous/

> +static int __init early_kasan_mode(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (strcmp(arg, "on") == 0)
> +               kasan_mode = KASAN_MODE_ON;
> +       else if (strcmp(arg, "debug") == 0)

s/strcmp(..) == 0/!strcmp(..)/  ?

> +               kasan_mode = KASAN_MODE_DEBUG;
> +       return 0;
> +}
> +early_param("kasan_mode", early_kasan_mode);
> +
>  void __init kasan_init_tags(void)
>  {
> +       /* TODO: system_supports_tags() always returns 0 here, fix. */
> +       if (0 /*!system_supports_tags()*/)
> +               return;
> +
> +       switch (kasan_mode) {
> +       case KASAN_MODE_OFF:
> +               return;
> +       case KASAN_MODE_ON:
> +               static_branch_enable(&kasan_enabled);
> +               break;
> +       case KASAN_MODE_DEBUG:
> +               static_branch_enable(&kasan_enabled);
> +               static_branch_enable(&kasan_debug);
> +               kasan_sync = true;
> +               break;
> +       }
> +
> +       /* TODO: choose between sync and async based on kasan_sync. */
>         init_tags(KASAN_TAG_MAX);
>
>         pr_info("KernelAddressSanitizer initialized\n");
> @@ -60,6 +111,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>  {
>         struct kasan_alloc_meta *alloc_meta;
>
> +       WARN_ON(!static_branch_unlikely(&kasan_debug));

What actually happens if any of these are called with !kasan_debug and
the warning triggers? Is it still valid to execute the below, or
should it bail out? Or possibly even disable KASAN entirely?

>         alloc_meta = kasan_get_alloc_meta(cache, object);
>         kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
>  }
> @@ -69,6 +121,7 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  {
>         struct kasan_alloc_meta *alloc_meta;
>
> +       WARN_ON(!static_branch_unlikely(&kasan_debug));
>         alloc_meta = kasan_get_alloc_meta(cache, object);
>         return &alloc_meta->free_track[0];
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 47d6074c7958..3712e7a39717 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -279,6 +279,14 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
>  #define get_mem_tag(addr)                      arch_get_mem_tag(addr)
>  #define set_mem_tag_range(addr, size, tag)     arch_set_mem_tag_range((addr), (size), (tag))
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +DECLARE_STATIC_KEY_FALSE(kasan_enabled);
> +DECLARE_STATIC_KEY_FALSE(kasan_debug);
> +#else
> +DECLARE_STATIC_KEY_TRUE(kasan_enabled);
> +DECLARE_STATIC_KEY_TRUE(kasan_debug);
> +#endif
> +
>  /*
>   * Exported functions for interfaces called from assembly or from generated
>   * code. Declarations here to avoid warning about missing declarations.
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index dee5350b459c..ae956a29ad4e 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -159,8 +159,8 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>                 (void *)(object_addr + cache->object_size));
>  }
>
> -static void describe_object(struct kmem_cache *cache, void *object,
> -                               const void *addr, u8 tag)
> +static void describe_object_stacks(struct kmem_cache *cache, void *object,
> +                                       const void *addr, u8 tag)
>  {
>         struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
>
> @@ -188,7 +188,13 @@ static void describe_object(struct kmem_cache *cache, void *object,
>                 }
>  #endif
>         }
> +}
>
> +static void describe_object(struct kmem_cache *cache, void *object,
> +                               const void *addr, u8 tag)
> +{
> +       if (static_branch_unlikely(&kasan_debug))
> +               describe_object_stacks(cache, object, addr, tag);
>         describe_object_addr(cache, object, addr);
>  }
>
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 099af6dc8f7e..50e797a16e17 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -33,6 +33,10 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +/* See the comments in hw_tags.c */
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_debug);
> +
>  static DEFINE_PER_CPU(u32, prng_state);
>
>  void __init kasan_init_tags(void)
> --
> 2.28.0.1011.ga647a8990f-goog
>
