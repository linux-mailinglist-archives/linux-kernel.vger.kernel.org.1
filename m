Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E8829AC55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900160AbgJ0Mlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:41:32 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33384 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900143AbgJ0MlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:41:08 -0400
Received: by mail-qk1-f195.google.com with SMTP id t128so947778qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41n2Ilf3HkOC7w8XKi7whm47sc4vWGvgMbmf7JM80uI=;
        b=PKPUtEjztRwRcC5I0ZItCbRnOWC8v3jyMCs4H/ZWaFGSsWnmUfalQ7nSdN4tBd9WrJ
         uygW6+kmLOIL3Bdfmx2MZwdPaZnTWaMeOjHxj4YJY+bR8z8ay8EDX0fqVdCa6DuD5OAx
         nq2gOdGEkE/NBCQyF7I0AtStE53cbOf0w+9U1maEe0l8ahnQ2/m/lT21FG+dy0ibIXzK
         6tzBechDWT7+xu8sWVQNfkIegRlwIatv7RuM2Sf9kCE2RAyrulE0+PLmugN0lXMBCBiI
         zCv5kKC1AHbgWvY5X54+rfa4Uq4OqIUJ9bty5BpAvSOvu47+5BDwMUKowLPLz89YmUri
         q9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41n2Ilf3HkOC7w8XKi7whm47sc4vWGvgMbmf7JM80uI=;
        b=t5CCYJ1O7J5foZs6Vmhr52qG7u16SuQngiihEfqZOOQJIuDvr83W0dKRrunDGtFSMY
         lditcpDIRmnjKW27i0F0ExywUJ5xuMf5m7cDlxGxw+Kuy+SBLROTKeln/7dwPd/NccO5
         p922nm5gr2Y7yQpAD2nDi5iq3ATRZ0kmwNojkV7LqIuh/gn3knso9FLKQHSE4rK9MVoR
         S5QoTTzfmHuqAR7rBckv9gKNxVS1DD5UL5xPg3KtFLshfP7pQ5sw+b+lgZHTlmKlLbz/
         U3OFel3UWgo7/Q/T6gk+9XpL77ksH7XIkZeq5LHgBv8wc4ueDOJoaWcLljothMyhGkE3
         xljA==
X-Gm-Message-State: AOAM5304msmd8KKw4uI8Vj2gMv4UjP2t7luLZDTHmmkTfIqTl8AGPeLB
        ozRQoI4lHt7BzJFj530woCP6zNDpFt06JdG+eZ0CTg==
X-Google-Smtp-Source: ABdhPJwr6bsa6RoFIy+vIGTgkWnF0qsGtc7jnu1WZbhrs8mB0xY4uLS0wjkzRV/TpbIhHK6QK2oF9TwAYegpkpmBzIc=
X-Received: by 2002:a37:9747:: with SMTP id z68mr1809588qkd.424.1603802464374;
 Tue, 27 Oct 2020 05:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <b205406ea24f189da7fa94f0fc78de8d856858d9.1603372719.git.andreyknvl@google.com>
In-Reply-To: <b205406ea24f189da7fa94f0fc78de8d856858d9.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Oct 2020 13:40:53 +0100
Message-ID: <CACT4Y+YriYDCw0_8p8gxWPLuSrv2OCZp=HRSM315wTTkyCkJPA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/21] kasan: rename get_alloc/free_info
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
> Rename get_alloc_info() and get_free_info() to kasan_get_alloc_meta()
> and kasan_get_free_meta() to better reflect what those do and avoid
> confusion with kasan_set_free_info().
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/Ib6e4ba61c8b12112b403d3479a9799ac8fff8de1

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c         | 16 ++++++++--------
>  mm/kasan/generic.c        | 12 ++++++------
>  mm/kasan/hw_tags.c        |  4 ++--
>  mm/kasan/kasan.h          |  8 ++++----
>  mm/kasan/quarantine.c     |  4 ++--
>  mm/kasan/report.c         | 12 ++++++------
>  mm/kasan/report_sw_tags.c |  2 +-
>  mm/kasan/sw_tags.c        |  4 ++--
>  8 files changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 5712c66c11c1..8fd04415d8f4 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -175,14 +175,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
>                 sizeof(struct kasan_free_meta) : 0);
>  }
>
> -struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
> -                                       const void *object)
> +struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
> +                                             const void *object)
>  {
>         return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
>  }
>
> -struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
> -                                     const void *object)
> +struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
> +                                           const void *object)
>  {
>         BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
>         return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
> @@ -259,13 +259,13 @@ static u8 assign_tag(struct kmem_cache *cache, const void *object,
>  void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
>                                                 const void *object)
>  {
> -       struct kasan_alloc_meta *alloc_info;
> +       struct kasan_alloc_meta *alloc_meta;
>
>         if (!(cache->flags & SLAB_KASAN))
>                 return (void *)object;
>
> -       alloc_info = get_alloc_info(cache, object);
> -       __memset(alloc_info, 0, sizeof(*alloc_info));
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
> +       __memset(alloc_meta, 0, sizeof(*alloc_meta));
>
>         if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>                 object = set_tag(object, assign_tag(cache, object, true, false));
> @@ -345,7 +345,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>                 KASAN_KMALLOC_REDZONE);
>
>         if (cache->flags & SLAB_KASAN)
> -               kasan_set_track(&get_alloc_info(cache, object)->alloc_track, flags);
> +               kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
>
>         return set_tag(object, tag);
>  }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index e1af3b6c53b8..de6b3f03a023 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -331,7 +331,7 @@ void kasan_record_aux_stack(void *addr)
>  {
>         struct page *page = kasan_addr_to_page(addr);
>         struct kmem_cache *cache;
> -       struct kasan_alloc_meta *alloc_info;
> +       struct kasan_alloc_meta *alloc_meta;
>         void *object;
>
>         if (!(page && PageSlab(page)))
> @@ -339,13 +339,13 @@ void kasan_record_aux_stack(void *addr)
>
>         cache = page->slab_cache;
>         object = nearest_obj(cache, page, addr);
> -       alloc_info = get_alloc_info(cache, object);
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
>
>         /*
>          * record the last two call_rcu() call stacks.
>          */
> -       alloc_info->aux_stack[1] = alloc_info->aux_stack[0];
> -       alloc_info->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
> +       alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
> +       alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT);
>  }
>
>  void kasan_set_free_info(struct kmem_cache *cache,
> @@ -353,7 +353,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>  {
>         struct kasan_free_meta *free_meta;
>
> -       free_meta = get_free_info(cache, object);
> +       free_meta = kasan_get_free_meta(cache, object);
>         kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
>
>         /*
> @@ -367,5 +367,5 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  {
>         if (*(u8 *)kasan_mem_to_shadow(object) != KASAN_KMALLOC_FREETRACK)
>                 return NULL;
> -       return &get_free_info(cache, object)->free_track;
> +       return &kasan_get_free_meta(cache, object)->free_track;
>  }
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 7f0568df2a93..2a38885014e3 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -56,7 +56,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>  {
>         struct kasan_alloc_meta *alloc_meta;
>
> -       alloc_meta = get_alloc_info(cache, object);
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
>         kasan_set_track(&alloc_meta->free_track[0], GFP_NOWAIT);
>  }
>
> @@ -65,6 +65,6 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>  {
>         struct kasan_alloc_meta *alloc_meta;
>
> -       alloc_meta = get_alloc_info(cache, object);
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
>         return &alloc_meta->free_track[0];
>  }
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 5c0116c70579..456b264e5124 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -148,10 +148,10 @@ struct kasan_free_meta {
>  #endif
>  };
>
> -struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
> -                                       const void *object);
> -struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
> -                                       const void *object);
> +struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
> +                                               const void *object);
> +struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
> +                                               const void *object);
>
>  void kasan_poison_memory(const void *address, size_t size, u8 value);
>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index a0792f0d6d0f..0da3d37e1589 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -166,7 +166,7 @@ void quarantine_put(struct kmem_cache *cache, void *object)
>         unsigned long flags;
>         struct qlist_head *q;
>         struct qlist_head temp = QLIST_INIT;
> -       struct kasan_free_meta *info = get_free_info(cache, object);
> +       struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
>
>         /*
>          * Note: irq must be disabled until after we move the batch to the
> @@ -179,7 +179,7 @@ void quarantine_put(struct kmem_cache *cache, void *object)
>         local_irq_save(flags);
>
>         q = this_cpu_ptr(&cpu_quarantine);
> -       qlist_put(q, &info->quarantine_link, cache->size);
> +       qlist_put(q, &meta->quarantine_link, cache->size);
>         if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
>                 qlist_move_all(q, &temp);
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index f8817d5685a7..dee5350b459c 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -162,12 +162,12 @@ static void describe_object_addr(struct kmem_cache *cache, void *object,
>  static void describe_object(struct kmem_cache *cache, void *object,
>                                 const void *addr, u8 tag)
>  {
> -       struct kasan_alloc_meta *alloc_info = get_alloc_info(cache, object);
> +       struct kasan_alloc_meta *alloc_meta = kasan_get_alloc_meta(cache, object);
>
>         if (cache->flags & SLAB_KASAN) {
>                 struct kasan_track *free_track;
>
> -               print_track(&alloc_info->alloc_track, "Allocated");
> +               print_track(&alloc_meta->alloc_track, "Allocated");
>                 pr_err("\n");
>                 free_track = kasan_get_free_track(cache, object, tag);
>                 if (free_track) {
> @@ -176,14 +176,14 @@ static void describe_object(struct kmem_cache *cache, void *object,
>                 }
>
>  #ifdef CONFIG_KASAN_GENERIC
> -               if (alloc_info->aux_stack[0]) {
> +               if (alloc_meta->aux_stack[0]) {
>                         pr_err("Last call_rcu():\n");
> -                       print_stack(alloc_info->aux_stack[0]);
> +                       print_stack(alloc_meta->aux_stack[0]);
>                         pr_err("\n");
>                 }
> -               if (alloc_info->aux_stack[1]) {
> +               if (alloc_meta->aux_stack[1]) {
>                         pr_err("Second to last call_rcu():\n");
> -                       print_stack(alloc_info->aux_stack[1]);
> +                       print_stack(alloc_meta->aux_stack[1]);
>                         pr_err("\n");
>                 }
>  #endif
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index aebc44a29e83..317100fd95b9 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -46,7 +46,7 @@ const char *get_bug_type(struct kasan_access_info *info)
>         if (page && PageSlab(page)) {
>                 cache = page->slab_cache;
>                 object = nearest_obj(cache, page, (void *)addr);
> -               alloc_meta = get_alloc_info(cache, object);
> +               alloc_meta = kasan_get_alloc_meta(cache, object);
>
>                 for (i = 0; i < KASAN_NR_FREE_STACKS; i++)
>                         if (alloc_meta->free_pointer_tag[i] == tag)
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index ccc35a311179..c10863a45775 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -172,7 +172,7 @@ void kasan_set_free_info(struct kmem_cache *cache,
>         struct kasan_alloc_meta *alloc_meta;
>         u8 idx = 0;
>
> -       alloc_meta = get_alloc_info(cache, object);
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
>
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>         idx = alloc_meta->free_track_idx;
> @@ -189,7 +189,7 @@ struct kasan_track *kasan_get_free_track(struct kmem_cache *cache,
>         struct kasan_alloc_meta *alloc_meta;
>         int i = 0;
>
> -       alloc_meta = get_alloc_info(cache, object);
> +       alloc_meta = kasan_get_alloc_meta(cache, object);
>
>  #ifdef CONFIG_KASAN_SW_TAGS_IDENTIFY
>         for (i = 0; i < KASAN_NR_FREE_STACKS; i++) {
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
