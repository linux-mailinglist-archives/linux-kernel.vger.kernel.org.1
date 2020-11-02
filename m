Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02BD42A2DED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKBPRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgKBPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:17:16 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E9FC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:17:15 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so799670pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 07:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3SSjI8L6tAN7wnaresierGkcZcom6o46dDNzyiPHjlU=;
        b=DkhU/qMVrvN1fx4wAGkNA9axcRMaO84W+G/hRGQCobjjbFdT50hJC+Y0P1+WsLC/fC
         nQjYHCHoPj9rXVGzQWB7TF3L7FxjLAfh1rLJIGaWPqojCrRG0UyO/MrQueQN3REsMBzk
         xy1+ZQCYCtioNMDJCLMNTShS0wp/dl83ZmeYPRRQTr9bOuUbhQ7KBGqBzCZmwqZde+3U
         OjIDIuDW4ct8N6zFiAhT3BmW1YmvSSl3Ned6jfQhv2SiRUlcE8mMSszc2T9KHg5xG3gl
         OJI2jAfwQkYpHdrke4KFyQMb2LyDzkNTrO/VuDGvlmGcTc0/fyjQFik6WagkeD6Dp+jf
         DeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3SSjI8L6tAN7wnaresierGkcZcom6o46dDNzyiPHjlU=;
        b=uaykFhchNVnPlw2yw5A2Sijp4d4mAQMhnYqj2f+VxlAyh1NBcbAtvnZ9xd3yNzribt
         ty506R3Ax3ywcQM13Mn2lzmOSWvD2N02ut5evkT6F0kGyTllfVNq/Wy6Gojws+Nt38YJ
         CM5WYrC1LPBszCUZWPmheK4tMaHCFykiJVOkTbYPSDTbhHFGSkJrap6XpcdwVijk6oO0
         u0tuvQC/DqHpoFJ+froCKc6TdnXvldDnevYZJ167NL7EpRyajWW75Ctrb5A5zmakJDsf
         LPHUNrq8uHX+nljv+olY01RZkmJ4BXz4m9oq6UoPGVj5gvuUWCAUky/ZypMeOuxW1f0f
         llaQ==
X-Gm-Message-State: AOAM533K7B4ONd8CWMZ1CFK7PdHKkwOeUmqGotxqaNZY1Pfz2sEvIqZX
        XPPf97K6DNElvb6sp5QRAkRUJ44QK/uyhQ+ZnHrVog==
X-Google-Smtp-Source: ABdhPJyRJC3YZ5USOl/mcJCYzr7fXk7g4cY3TwW4VhXjTLtE65jadiAZBn5mzk3cAxoYI7xitmatRSaV0b0XNSTpUyU=
X-Received: by 2002:a63:d456:: with SMTP id i22mr13760189pgj.440.1604330235200;
 Mon, 02 Nov 2020 07:17:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <ce573435398f21d3e604f104c29ba65eca70d9e7.1603372719.git.andreyknvl@google.com>
 <CACT4Y+YF9bL8jRjVMfryr+LExYjH-rNdDEq2SvuQD+rGT4mVJQ@mail.gmail.com>
In-Reply-To: <CACT4Y+YF9bL8jRjVMfryr+LExYjH-rNdDEq2SvuQD+rGT4mVJQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 2 Nov 2020 16:17:04 +0100
Message-ID: <CAAeHK+zTPyX6h+8uJvjKwryA1U3L0ErufSoAmNvBu=QC5bomXw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 16/21] kasan: optimize poisoning in kmalloc and krealloc
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Wed, Oct 28, 2020 at 5:55 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Oct 22, 2020 at 3:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > Since kasan_kmalloc() always follows kasan_slab_alloc(), there's no need
> > to reunpoison the object data, only to poison the redzone.
> >
> > This requires changing kasan annotation for early SLUB cache to
> > kasan_slab_alloc(). Otherwise kasan_kmalloc() doesn't untag the object.
> > This doesn't do any functional changes, as kmem_cache_node->object_size
> > is equal to sizeof(struct kmem_cache_node).
> >
> > Similarly for kasan_krealloc(), as it's called after ksize(), which
> > already unpoisoned the object, there's no need to do it again.
>
> Have you considered doing this the other way around: make krealloc
> call __ksize and unpoison in kasan_krealloc?
> This has the advantage of more precise poisoning as ksize will
> unpoison the whole underlying object.
>
> But then maybe we will need to move first checks in ksize into __ksize
> as we may need them in krealloc as well.

This might be a good idea. I won't implement this for the next
version, but will look into this after that. Thanks!

>
>
>
>
>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/I4083d3b55605f70fef79bca9b90843c4390296f2
> > ---
> >  mm/kasan/common.c | 31 +++++++++++++++++++++----------
> >  mm/slub.c         |  3 +--
> >  2 files changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index c5ec60e1a4d2..a581937c2a44 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -360,8 +360,14 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
> >         if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> >                 tag = assign_tag(cache, object, false, keep_tag);
> >
> > -       /* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
> > -       kasan_unpoison_memory(set_tag(object, tag), size);
> > +       /*
> > +        * Don't unpoison the object when keeping the tag. Tag is kept for:
> > +        * 1. krealloc(), and then the memory has already been unpoisoned via ksize();
> > +        * 2. kmalloc(), and then the memory has already been unpoisoned by kasan_kmalloc().
> > +        * Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS.
> > +        */
> > +       if (!keep_tag)
> > +               kasan_unpoison_memory(set_tag(object, tag), size);
> >         kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
> >                 KASAN_KMALLOC_REDZONE);
> >
> > @@ -384,10 +390,9 @@ void * __must_check __kasan_kmalloc(struct kmem_cache *cache, const void *object
> >  }
> >  EXPORT_SYMBOL(__kasan_kmalloc);
> >
> > -void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
> > -                                               gfp_t flags)
> > +static void * __must_check ____kasan_kmalloc_large(struct page *page, const void *ptr,
> > +                                               size_t size, gfp_t flags, bool realloc)
> >  {
> > -       struct page *page;
> >         unsigned long redzone_start;
> >         unsigned long redzone_end;
> >
> > @@ -397,18 +402,24 @@ void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
> >         if (unlikely(ptr == NULL))
> >                 return NULL;
> >
> > -       page = virt_to_page(ptr);
> > -       redzone_start = round_up((unsigned long)(ptr + size),
> > -                               KASAN_GRANULE_SIZE);
> > +       redzone_start = round_up((unsigned long)(ptr + size), KASAN_GRANULE_SIZE);
> >         redzone_end = (unsigned long)ptr + page_size(page);
> >
> > -       kasan_unpoison_memory(ptr, size);
> > +       /* ksize() in __do_krealloc() already unpoisoned the memory. */
> > +       if (!realloc)
> > +               kasan_unpoison_memory(ptr, size);
> >         kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
> >                 KASAN_PAGE_REDZONE);
> >
> >         return (void *)ptr;
> >  }
> >
> > +void * __must_check __kasan_kmalloc_large(const void *ptr, size_t size,
> > +                                               gfp_t flags)
> > +{
> > +       return ____kasan_kmalloc_large(virt_to_page(ptr), ptr, size, flags, false);
> > +}
> > +
> >  void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flags)
> >  {
> >         struct page *page;
> > @@ -419,7 +430,7 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
> >         page = virt_to_head_page(object);
> >
> >         if (unlikely(!PageSlab(page)))
> > -               return __kasan_kmalloc_large(object, size, flags);
> > +               return ____kasan_kmalloc_large(page, object, size, flags, true);
> >         else
> >                 return ____kasan_kmalloc(page->slab_cache, object, size,
> >                                                 flags, true);
> > diff --git a/mm/slub.c b/mm/slub.c
> > index 1d3f2355df3b..afb035b0bf2d 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3535,8 +3535,7 @@ static void early_kmem_cache_node_alloc(int node)
> >         init_object(kmem_cache_node, n, SLUB_RED_ACTIVE);
> >         init_tracking(kmem_cache_node, n);
> >  #endif
> > -       n = kasan_kmalloc(kmem_cache_node, n, sizeof(struct kmem_cache_node),
> > -                     GFP_KERNEL);
> > +       n = kasan_slab_alloc(kmem_cache_node, n, GFP_KERNEL);
> >         page->freelist = get_freepointer(kmem_cache_node, n);
> >         page->inuse = 1;
> >         page->frozen = 0;
> > --
> > 2.29.0.rc1.297.gfa9743e501-goog
> >
