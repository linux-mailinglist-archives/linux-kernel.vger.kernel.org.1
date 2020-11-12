Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFFD2B124B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 00:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgKLXAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 18:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgKLXAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 18:00:32 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE03C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 15:00:31 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id q10so5960633pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 15:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjN41sX5qjrZFdnqs5FTcpwE8cevolsZVCKbUpaXMpY=;
        b=ZA7ZfI8MWSiXS7AZkGgFD1bkrkW1aNC29iy8wrCtuDTNNQ8d4nb6NqqyRWd0LbZJWx
         PnT0TxZ5Zn4VvWTa/gvoPhVsdEU5qdFGpnGHLSxPwpioP9gBkJdKa5oglMlNfgKkKIkZ
         MdU4hXgfTfalu5OsqcgO9UuZsFxbWvtfEb8V19U756z01OtQphAnbJ4O407mpKUopo3k
         uMKOFpjrziWNQQhBG9v4nl5jA1WDrFt+JS+YcbbGSfSFHrrAtdGZUSPNYgVitRv64Gj3
         M1YmfLqkYd26omnlUO+84qjxfnzZXpXBbMFpOPAbAY+HnpG5AtH1O2MtzZzZH+SBpAAk
         byWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjN41sX5qjrZFdnqs5FTcpwE8cevolsZVCKbUpaXMpY=;
        b=toUTLcgw+ZNrYuixDFhIzkV/Q5ZOMzvjo6qoJ/TYYcVILOLEtDdC0YMEPDzR43UKoz
         hhQwLzh5e7q7Bt0XiZ/NHin+RIyIZGYGUGiiFbGVbrdbYGz7ryerTuTWSnLvj7xg91JH
         Bq2RUg8gY80YpZndUFLDxXn+IVOEsi3TcGH1hfeMk/ComFo5NS0EaLt0bcZK/kvYgyK/
         ClkX4NY597QnUPxeVTzSQOyECzTo5KGlqWODBR+h3AZ+LGpLcEvDCJKnwjgoNAGmgus9
         pkEMA4SpB9PBKnNkhBbT1YGX6lM0M6I9Q6mSHTdlB1Y4d24Btd52AE9NShXgi0LfNEiP
         LJ+A==
X-Gm-Message-State: AOAM530isPvemqMmlnO7UYoGlU5P41gAkrBg+Ofkq2mzMuFr2iF/kXM/
        Qoq6KjQ71ifVMck/E/RY/X/PPQPZJkbPMOpDFeXYhQ==
X-Google-Smtp-Source: ABdhPJzhW5OGR3SOnBOJ/bdTcqYxkR+Ie1nyTBybuHelmvZvjTkLyOkpby7U4aWuzcyUFw24aqfQQRmXqCEi9GgaTBA=
X-Received: by 2002:a17:90b:3111:: with SMTP id gc17mr30483pjb.41.1605222031183;
 Thu, 12 Nov 2020 15:00:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046662.git.andreyknvl@google.com> <936c0c198145b663e031527c49a6895bd21ac3a0.1605046662.git.andreyknvl@google.com>
 <20201111151336.GA517454@elver.google.com>
In-Reply-To: <20201111151336.GA517454@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 13 Nov 2020 00:00:20 +0100
Message-ID: <CAAeHK+zXyNEVwLcpB16BAQDKA6OdE9H0BdOFhDo-Osgd4OSSTg@mail.gmail.com>
Subject: Re: [PATCH v2 19/20] kasan, mm: allow cache merging with no metadata
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

On Wed, Nov 11, 2020 at 4:13 PM Marco Elver <elver@google.com> wrote:
>
> On Tue, Nov 10, 2020 at 11:20PM +0100, Andrey Konovalov wrote:
> > The reason cache merging is disabled with KASAN is because KASAN puts its
> > metadata right after the allocated object. When the merged caches have
> > slightly different sizes, the metadata ends up in different places, which
> > KASAN doesn't support.
> >
> > It might be possible to adjust the metadata allocation algorithm and make
> > it friendly to the cache merging code. Instead this change takes a simpler
> > approach and allows merging caches when no metadata is present. Which is
> > the case for hardware tag-based KASAN with kasan.mode=prod.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Link: https://linux-review.googlesource.com/id/Ia114847dfb2244f297d2cb82d592bf6a07455dba
> > ---
> >  include/linux/kasan.h | 26 ++++++++++++++++++++++++--
> >  mm/kasan/common.c     | 11 +++++++++++
> >  mm/slab_common.c      | 11 ++++++++---
> >  3 files changed, 43 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> > index 534ab3e2935a..c754eca356f7 100644
> > --- a/include/linux/kasan.h
> > +++ b/include/linux/kasan.h
> > @@ -81,17 +81,35 @@ struct kasan_cache {
> >  };
> >
> >  #ifdef CONFIG_KASAN_HW_TAGS
> > +
> >  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> > +
> >  static inline kasan_enabled(void)
> >  {
> >       return static_branch_likely(&kasan_flag_enabled);
> >  }
> > -#else
> > +
> > +slab_flags_t __kasan_never_merge(slab_flags_t flags);
> > +static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
> > +{
> > +     if (kasan_enabled())
> > +             return __kasan_never_merge(flags);
> > +     return flags;
> > +}
> > +
> > +#else /* CONFIG_KASAN_HW_TAGS */
> > +
> >  static inline kasan_enabled(void)
> >  {
> >       return true;
> >  }
> > -#endif
> > +
> > +static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
> > +{
> > +     return flags;
> > +}
> > +
> > +#endif /* CONFIG_KASAN_HW_TAGS */
> >
> >  void __kasan_alloc_pages(struct page *page, unsigned int order);
> >  static inline void kasan_alloc_pages(struct page *page, unsigned int order)
> > @@ -240,6 +258,10 @@ static inline kasan_enabled(void)
> >  {
> >       return false;
> >  }
> > +static inline slab_flags_t kasan_never_merge(slab_flags_t flags)
> > +{
> > +     return flags;
> > +}
> >  static inline void kasan_alloc_pages(struct page *page, unsigned int order) {}
> >  static inline void kasan_free_pages(struct page *page, unsigned int order) {}
> >  static inline void kasan_cache_create(struct kmem_cache *cache,
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 940b42231069..25b18c145b06 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -81,6 +81,17 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
> >  }
> >  #endif /* CONFIG_KASAN_STACK */
> >
> > +/*
> > + * Only allow cache merging when stack collection is disabled and no metadata
> > + * is present.
> > + */
> > +slab_flags_t __kasan_never_merge(slab_flags_t flags)
> > +{
> > +     if (kasan_stack_collection_enabled())
> > +             return flags;
> > +     return flags & ~SLAB_KASAN;
> > +}
> > +
> >  void __kasan_alloc_pages(struct page *page, unsigned int order)
> >  {
> >       u8 tag;
> > diff --git a/mm/slab_common.c b/mm/slab_common.c
> > index f1b0c4a22f08..3042ee8ea9ce 100644
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/proc_fs.h>
> >  #include <linux/debugfs.h>
> > +#include <linux/kasan.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/page.h>
> > @@ -49,12 +50,16 @@ static DECLARE_WORK(slab_caches_to_rcu_destroy_work,
> >                   slab_caches_to_rcu_destroy_workfn);
> >
> >  /*
> > - * Set of flags that will prevent slab merging
> > + * Set of flags that will prevent slab merging.
> > + * Use slab_never_merge() instead.
> >   */
> >  #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
> >               SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
> >               SLAB_FAILSLAB | SLAB_KASAN)
>
> Rather than changing this to require using slab_never_merge() which
> removes SLAB_KASAN, could we not just have a function
> kasan_never_merge() that returns KASAN-specific flags that should never
> result in merging -- because as-is now, making kasan_never_merge()
> remove the SLAB_KASAN flag seems the wrong way around.
>
> Could we not just do this:
>
>   #define SLAB_NEVER_MERGE (SLAB_RED_ZONE | SLAB_POISON | SLAB_STORE_USER | \
>                 SLAB_TRACE | SLAB_TYPESAFE_BY_RCU | SLAB_NOLEAKTRACE | \
>                 SLAB_FAILSLAB | kasan_never_merge())
>
> ??

The issue here was that SLAB_KASAN is defined in slab.h, which
includes kasan.h, so we can't have a static inline definition of this
function for generic and software tag-based modes. So we can do this,
as long as we're fine with having kasan_never_merge() to be an actual
function call for all KASAN modes. I guess it's not a problem, so
let's do it this way.

>
> Of course that might be problematic if this always needs to be a
> compile-time constant, but currently that's not a requirement.
>
> > +/* KASAN allows merging in some configurations and will remove SLAB_KASAN. */
> > +#define slab_never_merge() (kasan_never_merge(SLAB_NEVER_MERGE))
>
> Braces unnecessary.
