Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0E729DA24
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390271AbgJ1XPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgJ1XPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:15:04 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A68C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:15:03 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id h12so794841qtu.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LpV8BNT61wGJwZlYcom8dCyYgF7yubMkbVCW0bXEnSU=;
        b=QbVXD6TTS9r0aM9SY3EBCIdIq7L2P1bDxT3kjHt8/hskLi9X0zbzlP1VtPMSaWcvXu
         sYIVsKzEPYjH1MkQiZEoErcnLyJod1IXcbkQkwzPYWlQSSkpHZFMeQDTjufWdHOLseZW
         KGnk7BMn8PY7nlZy7uap1xuTlQcJ2JYIBIRutqRTmd1ZoY8tuTsrbx8drarnOQeRLplD
         kuCk1HGATn/F+5gkxb0/DcjXAK7GC+wV6yULXF+8kv/1b9OwO5yfDejlD8ytak7n4NdC
         XFIpuWdhRuU2BxoKAY+YVPLWRUdURvyM6BI4k2MA1ZgEZll4XJInwjjODA/zEcqDtSKT
         SKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpV8BNT61wGJwZlYcom8dCyYgF7yubMkbVCW0bXEnSU=;
        b=ouFMxS2EYHhGf8TBNK+BDM3sMaV7tBsNsFBGlNZkQ3BjVlAloTl7HfzL7gzrDfkI1X
         z0m8VV4p5Ays9LGfv0HvaXJ9jNsfs3Um6i0kast7+RQD6P2aH0ao/2XRMGgGEAK5U7Rf
         tTKiynGRrHRhPEICtHxF8mNtBPydBqSTQvRPfAwpqD/KCP+aQBoxiKqlKyl1M/gyslOC
         UuX55WTtG+s8gC9fZhPX/B8yZRSZ27XjmwIAG4nfem57Ys3QAzHf9SPHYdJI37w8V5FQ
         WPMkEsaJ+r1XJWrm/yvK9k2CbW6Id4KiQ5L1YiLHyUjJZWg7jkdPSAIIH8AEa9Q68GWk
         eZDQ==
X-Gm-Message-State: AOAM533ilSZ7tP05lBsjLlxU3NbeoIP16Ib82hR7JXFHvuY+teRczmUk
        RZizP3aAJ06vGLPMVfnD7NXZqfA1vW+iUSa8klDvORWtYr/kPQ==
X-Google-Smtp-Source: ABdhPJw4iWwZX/mNS7yOmSD3qD8ofrcNgUCYIm6iRu2BHgr9DU+Ro8n+glrpRveN2o7IOXcXaQyr5GdDqeiQgxl0/+Y=
X-Received: by 2002:a37:7b44:: with SMTP id w65mr7174670qkc.350.1603888049269;
 Wed, 28 Oct 2020 05:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6a4a7626bf280871518656f4fa89cb064740baf7.1603372719.git.andreyknvl@google.com>
In-Reply-To: <6a4a7626bf280871518656f4fa89cb064740baf7.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 13:27:17 +0100
Message-ID: <CACT4Y+ZNenL3B91huwk=0oMJFj6FN8ShsrO9w_mnQg4wgmjSdw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 14/21] kasan: add and integrate kasan boot parameters
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
> TODO: no meaningful description here yet, please see the cover letter
>       for this RFC series.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/If7d37003875b2ed3e0935702c8015c223d6416a4
> ---
>  mm/kasan/common.c  |  92 +++++++++++++-----------
>  mm/kasan/generic.c |   5 ++
>  mm/kasan/hw_tags.c | 169 ++++++++++++++++++++++++++++++++++++++++++++-
>  mm/kasan/kasan.h   |   9 +++
>  mm/kasan/report.c  |  14 +++-
>  mm/kasan/sw_tags.c |   5 ++
>  6 files changed, 250 insertions(+), 44 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 1a5e6c279a72..cc129ef62ab1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -129,35 +129,37 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
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
> +       if (static_branch_unlikely(&kasan_stack)) {

Initially I thought kasan_stack is related to stack instrumentation.
And then wondered why we check it during slab creation.
I suggest giving it a slightly longer and more descriptive name.

... reading code further, it also disables quarantine, right?
Something to mention somewhere.



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
> @@ -165,10 +167,12 @@ void kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>
>  size_t kasan_metadata_size(struct kmem_cache *cache)
>  {
> -       return (cache->kasan_info.alloc_meta_offset ?
> -               sizeof(struct kasan_alloc_meta) : 0) +
> -               (cache->kasan_info.free_meta_offset ?
> -               sizeof(struct kasan_free_meta) : 0);
> +       if (static_branch_unlikely(&kasan_stack))
> +               return (cache->kasan_info.alloc_meta_offset ?
> +                       sizeof(struct kasan_alloc_meta) : 0) +
> +                       (cache->kasan_info.free_meta_offset ?
> +                       sizeof(struct kasan_free_meta) : 0);
> +       return 0;
>  }
>
>  struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
> @@ -270,8 +274,10 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>         if (!(cache->flags & SLAB_KASAN))
>                 return (void *)object;
>
> -       alloc_meta = kasan_get_alloc_meta(cache, object);
> -       __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +       if (static_branch_unlikely(&kasan_stack)) {

Interestingly, now SLAB_KASAN is always set when kasan_stack is not
enabled. So it seems to me we can move the SLAB_KASAN check into this
unlikely branch now.

> +               alloc_meta = kasan_get_alloc_meta(cache, object);
> +               __memset(alloc_meta, 0, sizeof(*alloc_meta));
> +       }
>
>         if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>                 object = set_tag(object, assign_tag(cache, object, true, false));
> @@ -308,15 +314,19 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>         rounded_up_size = round_up(cache->object_size, KASAN_GRANULE_SIZE);
>         kasan_poison_memory(object, rounded_up_size, KASAN_KMALLOC_FREE);
>
> -       if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
> -                       unlikely(!(cache->flags & SLAB_KASAN)))
> -               return false;
> +       if (static_branch_unlikely(&kasan_stack)) {
> +               if ((IS_ENABLED(CONFIG_KASAN_GENERIC) && !quarantine) ||
> +                               unlikely(!(cache->flags & SLAB_KASAN)))
> +                       return false;
> +
> +               kasan_set_free_info(cache, object, tag);
>
> -       kasan_set_free_info(cache, object, tag);
> +               quarantine_put(cache, object);
>
> -       quarantine_put(cache, object);
> +               return IS_ENABLED(CONFIG_KASAN_GENERIC);
> +       }
>
> -       return IS_ENABLED(CONFIG_KASAN_GENERIC);
> +       return false;
>  }
>
>  bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
> @@ -355,7 +365,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
>                 KASAN_KMALLOC_REDZONE);
>
> -       if (cache->flags & SLAB_KASAN)
> +       if (static_branch_unlikely(&kasan_stack) && (cache->flags & SLAB_KASAN))
>                 set_alloc_info(cache, (void *)object, flags);
>
>         return set_tag(object, tag);
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d259e4c3aefd..20a1e753e0c5 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -33,6 +33,11 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +/* See the comments in hw_tags.c */
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
> +EXPORT_SYMBOL(kasan_enabled);
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_stack);
> +
>  /*
>   * All functions below always inlined so compiler could
>   * perform better optimizations in each of __asan_loadX/__assn_storeX
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 915142da6b57..bccd781011ad 100644
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
> @@ -17,10 +19,175 @@
>
>  #include "kasan.h"
>
> +enum kasan_arg_mode {
> +       KASAN_ARG_MODE_OFF,
> +       KASAN_ARG_MODE_PROD,
> +       KASAN_ARG_MODE_FULL,
> +};
> +
> +enum kasan_arg_stack {
> +       KASAN_ARG_STACK_DEFAULT,
> +       KASAN_ARG_STACK_OFF,
> +       KASAN_ARG_STACK_ON,
> +};
> +
> +enum kasan_arg_trap {
> +       KASAN_ARG_TRAP_DEFAULT,
> +       KASAN_ARG_TRAP_ASYNC,
> +       KASAN_ARG_TRAP_SYNC,
> +};
> +
> +enum kasan_arg_fault {
> +       KASAN_ARG_FAULT_DEFAULT,
> +       KASAN_ARG_FAULT_REPORT,
> +       KASAN_ARG_FAULT_PANIC,
> +};
> +
> +static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
> +static enum kasan_arg_stack kasan_arg_stack __ro_after_init;
> +static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
> +static enum kasan_arg_trap kasan_arg_trap __ro_after_init;
> +
> +/* Whether KASAN is enabled at all. */
> +DEFINE_STATIC_KEY_FALSE_RO(kasan_enabled);
> +EXPORT_SYMBOL(kasan_enabled);
> +
> +/* Whether to collect alloc/free stack traces. */
> +DEFINE_STATIC_KEY_FALSE_RO(kasan_stack);
> +
> +/* Whether to use synchronous or asynchronous tag checking. */
> +static bool kasan_sync __ro_after_init;
> +
> +/* Whether panic or disable tag checking on fault. */
> +bool kasan_panic __ro_after_init;
> +
> +/* kasan.mode=off/prod/full */
> +static int __init early_kasan_mode(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               kasan_arg_mode = KASAN_ARG_MODE_OFF;
> +       else if (!strcmp(arg, "prod"))
> +               kasan_arg_mode = KASAN_ARG_MODE_PROD;
> +       else if (!strcmp(arg, "full"))
> +               kasan_arg_mode = KASAN_ARG_MODE_FULL;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.mode", early_kasan_mode);
> +
> +/* kasan.stack=off/on */
> +static int __init early_kasan_stack(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "off"))
> +               kasan_arg_stack = KASAN_ARG_STACK_OFF;
> +       else if (!strcmp(arg, "on"))
> +               kasan_arg_stack = KASAN_ARG_STACK_ON;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.stack", early_kasan_stack);
> +
> +/* kasan.trap=sync/async */
> +static int __init early_kasan_trap(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "ASYNC"))
> +               kasan_arg_trap = KASAN_ARG_TRAP_ASYNC;
> +       else if (!strcmp(arg, "sync"))
> +               kasan_arg_trap = KASAN_ARG_TRAP_SYNC;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.trap", early_kasan_trap);
> +
> +/* kasan.fault=report/panic */
> +static int __init early_kasan_fault(char *arg)
> +{
> +       if (!arg)
> +               return -EINVAL;
> +
> +       if (!strcmp(arg, "report"))
> +               kasan_arg_fault = KASAN_ARG_FAULT_REPORT;
> +       else if (!strcmp(arg, "panic"))
> +               kasan_arg_fault = KASAN_ARG_FAULT_PANIC;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +early_param("kasan.fault", early_kasan_fault);
> +
>  void __init kasan_init_tags(void)
>  {
> -       init_tags(KASAN_TAG_MAX);
> +       if (!cpu_supports_tags())
> +               return;
> +
> +       /* First, preset values based on the mode. */
> +
> +       switch (kasan_arg_mode) {
> +       case KASAN_ARG_MODE_OFF:
> +               return;
> +       case KASAN_ARG_MODE_PROD:
> +               static_branch_enable(&kasan_enabled);
> +               break;
> +       case KASAN_ARG_MODE_FULL:
> +               static_branch_enable(&kasan_enabled);
> +               static_branch_enable(&kasan_stack);
> +               kasan_sync = true;
> +               break;
> +       }
> +
> +       /* Now, optionally override the presets. */
>
> +       switch (kasan_arg_stack) {
> +       case KASAN_ARG_STACK_OFF:
> +               static_branch_disable(&kasan_stack);
> +               break;
> +       case KASAN_ARG_STACK_ON:
> +               static_branch_enable(&kasan_stack);
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       switch (kasan_arg_trap) {
> +       case KASAN_ARG_TRAP_ASYNC:
> +               kasan_sync = false;
> +               break;
> +       case KASAN_ARG_TRAP_SYNC:
> +               kasan_sync = true;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       switch (kasan_arg_fault) {
> +       case KASAN_ARG_FAULT_REPORT:
> +               kasan_panic = false;
> +               break;
> +       case KASAN_ARG_FAULT_PANIC:
> +               kasan_panic = true;
> +               break;
> +       default:
> +               break;
> +       }
> +
> +       /* TODO: choose between sync and async based on kasan_sync. */
> +       init_tags(KASAN_TAG_MAX);
>         pr_info("KernelAddressSanitizer initialized\n");
>  }
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index f7ae0c23f023..00b47bc753aa 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -2,9 +2,18 @@
>  #ifndef __MM_KASAN_KASAN_H
>  #define __MM_KASAN_KASAN_H
>
> +#include <linux/jump_label.h>
>  #include <linux/kasan.h>
>  #include <linux/stackdepot.h>
>
> +#ifdef CONFIG_KASAN_HW_TAGS
> +DECLARE_STATIC_KEY_FALSE(kasan_stack);
> +#else
> +DECLARE_STATIC_KEY_TRUE(kasan_stack);
> +#endif

kasan_stack and kasan_enabled make sense and changed only in hw_tags mode.
It would be cleaner (and faster for other modes) to abstract static keys as:

#ifdef CONFIG_KASAN_HW_TAGS
#include <linux/jump_label.h>
DECLARE_STATIC_KEY_FALSE(kasan_stack);
static inline bool kasan_stack_collection_enabled()
{
  return static_branch_unlikely(&kasan_stack);
}
#else
static inline bool kasan_stack_collection_enabled() { return true; }
#endif

This way we don't need to include and define static keys for other modes.

> +extern bool kasan_panic __ro_after_init;
> +
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  #define KASAN_GRANULE_SIZE     (1UL << KASAN_SHADOW_SCALE_SHIFT)
>  #else
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index dee5350b459c..426dd1962d3c 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -97,6 +97,10 @@ static void end_report(unsigned long *flags)
>                 panic_on_warn = 0;
>                 panic("panic_on_warn set ...\n");
>         }
> +#ifdef CONFIG_KASAN_HW_TAGS
> +       if (kasan_panic)
> +               panic("kasan.fault=panic set ...\n");
> +#endif
>         kasan_enable_current();
>  }
>
> @@ -159,8 +163,8 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
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
> @@ -188,7 +192,13 @@ static void describe_object(struct kmem_cache *cache, void *object,
>                 }
>  #endif
>         }
> +}
>
> +static void describe_object(struct kmem_cache *cache, void *object,
> +                               const void *addr, u8 tag)
> +{
> +       if (static_branch_unlikely(&kasan_stack))
> +               describe_object_stacks(cache, object, addr, tag);
>         describe_object_addr(cache, object, addr);
>  }
>
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 4db41f274702..b6d185adf2c5 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -33,6 +33,11 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> +/* See the comments in hw_tags.c */
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_enabled);
> +EXPORT_SYMBOL(kasan_enabled);
> +DEFINE_STATIC_KEY_TRUE_RO(kasan_stack);
> +
>  static DEFINE_PER_CPU(u32, prng_state);
>
>  void __init kasan_init_tags(void)
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
