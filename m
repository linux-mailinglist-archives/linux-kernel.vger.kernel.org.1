Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B449C2AFCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgKLBk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgKLBFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:05:36 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D14C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:05:36 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id x15so1915467pll.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l+cNXIP3GmliSWhOXa8yhQOrloSbuarLwUXvnWs+zAI=;
        b=n0qYkfxGcsN3ZW9aWm/QkCdI8bHjvnfVht/Fi7YS+hV3ovtp6k5BdFKeMPUCvdKtQg
         yrSGLpYGVKcsqcKrImq8/KgvO4MaxvqGxZqGviQArjiCPfGxnpzcptW5VVTM54raXUYy
         ZnYHW4Iv8eZHGdQ1z80SEqlmBWidnvr/HfLcjEoxpC9SDF91R2l8EFGySgyq4IDmRfhL
         uuu3YvKfVY5IqLtu+izhq8qZHvdQKPiXIbfx3M914vEgIdA5spHCi3VbItsOfDr4rZkb
         a64IAiZcTGRcskbDUrr9Ops/Gww9HpHQAs04TdXSc8RcjCIXBBcp1gH1ZSV9yqh5aHl0
         sDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l+cNXIP3GmliSWhOXa8yhQOrloSbuarLwUXvnWs+zAI=;
        b=tE/QvObP1LuIU+6IuMxuTkQI1ZDHFHgIKxHvWwJHLicJbM3N1XpioE68kzTdollnKm
         pEIeZ7oFG6aL2DEzlKTrCeIHKnMeqbZ1poTt+ssbdntN7pmwZMxft8929p1t9qrAhrRz
         31UtFE2d9GFuPGRrnziODQE+tPdRmqMmcxzX9O7dYeaSVSj1iXifspOs/HMLsxDjl5Pi
         2r/TFh3pEEmaWL2/9IGZTbKN2rqhgNiuZL4fhPAVcJc5aRewUm9o03K5dgP9tPAMNkPU
         YZr8QSgsYid/r1BVVpecSxVRaBI/f3EuhzQM6gR5QJxoh1jMyFh9WfCX20IkyQNfM2vp
         7KJQ==
X-Gm-Message-State: AOAM531VNv/Goi2FxV4cSeJWT6Xv3ayMAHlrRkONs0bZjH8GUp6ql5hZ
        0X3jBsc7/EzkTtj/ymIu1Et7hsAD3v+UFWkCgHkRrQ==
X-Google-Smtp-Source: ABdhPJzFbcJ6kRTi/93+JXZozCLUgwNoFEvMmFxGRX2hNHNBmz4Hzky6rpp/GmMZlpROB0iW8qkW1g1lgntzWEYjj/Q=
X-Received: by 2002:a17:902:bb95:b029:d7:db34:2ddb with SMTP id
 m21-20020a170902bb95b02900d7db342ddbmr9884528pls.85.1605143135417; Wed, 11
 Nov 2020 17:05:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <ee33aa1d9c57c3f2b2c700e8f2c6c24db8703612.1605046662.git.andreyknvl@google.com>
 <20201111185326.GP517454@elver.google.com>
In-Reply-To: <20201111185326.GP517454@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 12 Nov 2020 02:05:24 +0100
Message-ID: <CAAeHK+zZu60aYGkzj34vqQ8pM=afLXGNqVECt68f5oDjHhQwqA@mail.gmail.com>
Subject: Re: [PATCH v2 14/20] kasan, mm: rename kasan_poison_kfree
To:     Marco Elver <elver@google.com>
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

On Wed, Nov 11, 2020 at 7:53 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > Rename kasan_poison_kfree() to kasan_slab_free_mempool() as it better
> > reflects what this annotation does.
>
> This function is again so simple, and now it seems it's mempool
> specific, can't we just remove it and open-code it in mempool.c?

The simplification introduced in the previous patch is based on a
false assumption and will be reverted. Thus will keep this as a
separate function.

>
> > No functional changes.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Link: https://linux-review.googlesource.com/id/I5026f87364e556b506ef1baee725144bb04b8810
> > ---
> >  include/linux/kasan.h | 16 ++++++++--------
> >  mm/kasan/common.c     | 16 ++++++++--------
> >  mm/mempool.c          |  2 +-
> >  3 files changed, 17 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 779f8e703982..534ab3e2935a 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -177,6 +177,13 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object, unsigned
> >       return false;
> >  }
> >
> > +void __kasan_slab_free_mempool(void *ptr, unsigned long ip);
> > +static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip)
> > +{
> > +     if (kasan_enabled())
> > +             __kasan_slab_free_mempool(ptr, ip);
> > +}
> > +
> >  void * __must_check __kasan_slab_alloc(struct kmem_cache *s,
> >                                      void *object, gfp_t flags);
> >  static inline void * __must_check kasan_slab_alloc(struct kmem_cache *s,
> > @@ -217,13 +224,6 @@ static inline void * __must_check kasan_krealloc(const void *object,
> >       return (void *)object;
> >  }
> >
> > -void __kasan_poison_kfree(void *ptr, unsigned long ip);
> > -static inline void kasan_poison_kfree(void *ptr, unsigned long ip)
> > -{
> > -     if (kasan_enabled())
> > -             __kasan_poison_kfree(ptr, ip);
> > -}
> > -
> >  void __kasan_kfree_large(void *ptr, unsigned long ip);
> >  static inline void kasan_kfree_large(void *ptr, unsigned long ip)
> >  {
> > @@ -263,6 +263,7 @@ static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
> >  {
> >       return false;
> >  }
> > +static inline void kasan_slab_free_mempool(void *ptr, unsigned long ip) {}
> >  static inline void *kasan_slab_alloc(struct kmem_cache *s, void *object,
> >                                  gfp_t flags)
> >  {
> > @@ -282,7 +283,6 @@ static inline void *kasan_krealloc(const void *object, size_t new_size,
> >  {
> >       return (void *)object;
> >  }
> > -static inline void kasan_poison_kfree(void *ptr, unsigned long ip) {}
> >  static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
> >
> >  #endif /* CONFIG_KASAN */
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 819403548f2e..60793f8695a8 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -336,6 +336,14 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
> >       return ____kasan_slab_free(cache, object, ip, true);
> >  }
> >
> > +void __kasan_slab_free_mempool(void *ptr, unsigned long ip)
> > +{
> > +     struct page *page;
> > +
> > +     page = virt_to_head_page(ptr);
> > +     ____kasan_slab_free(page->slab_cache, ptr, ip, false);
> > +}
> > +
> >  static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> >  {
> >       kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> > @@ -427,14 +435,6 @@ void * __must_check __kasan_krealloc(const void *object, size_t size, gfp_t flag
> >                                               flags, true);
> >  }
> >
> > -void __kasan_poison_kfree(void *ptr, unsigned long ip)
> > -{
> > -     struct page *page;
> > -
> > -     page = virt_to_head_page(ptr);
> > -     ____kasan_slab_free(page->slab_cache, ptr, ip, false);
> > -}
> > -
> >  void __kasan_kfree_large(void *ptr, unsigned long ip)
> >  {
> >       if (ptr != page_address(virt_to_head_page(ptr)))
> > diff --git a/mm/mempool.c b/mm/mempool.c
> > index f473cdddaff0..b1f39fa75ade 100644
> > --- a/mm/mempool.c
> > +++ b/mm/mempool.c
> > @@ -104,7 +104,7 @@ static inline void poison_element(mempool_t *pool, void *element)
> >  static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
> >  {
> >       if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> > -             kasan_poison_kfree(element, _RET_IP_);
> > +             kasan_slab_free_mempool(element, _RET_IP_);
>
> This is already a kasan-prefixed function, so if
> kasan_slab_free_mempool() is only ever called in this function, we
> should just call kasan_slab_free() here directly with the 2 extra args
> it requires open-coded.
>
> >       else if (pool->alloc == mempool_alloc_pages)
> >               kasan_free_pages(element, (unsigned long)pool->pool_data);
> >  }
>
> Thanks,
> -- Marco
