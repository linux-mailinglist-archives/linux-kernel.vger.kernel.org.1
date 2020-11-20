Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D992BB11F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 18:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbgKTRAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 12:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgKTRAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 12:00:30 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129FFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:00:30 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id s123so4693432vsc.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Es09CmfMnx2iJZBBdLp4lDW6e6+C2VXona6ERYo6k1E=;
        b=k9Lhec36El1bLXlChXPEWKudwSkFLceqgmruk/lpnbMYW+mMViCISWHnhG4unIK0Xi
         yw5hqFD3JA8tESc4Xy7JBgA6WzOAgoTH61mxzzNH+UVKXTZC66whu2wsZeqwGqNqNeKt
         /LzyNJJUXexR6n9RYrxGTVkRn5QC/lZ2D/ctDSVyhrTKpAn4oHfk56y3+dcfZlgxnJoq
         4Rqa+N/mEkoj0LsYBgqv90H6TKohqyE8JIQI5NUzEwqb+CQppAKfGz6BspFdXGcxAyBR
         R0cTgCBXXp/O1qwociQgogrof3AHET7jWWTKGUrS9V/PHmN2R/RinKLZJ/AKfuZBnnZT
         VYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Es09CmfMnx2iJZBBdLp4lDW6e6+C2VXona6ERYo6k1E=;
        b=V1IJLwlwGFAHwHxpbwaAlERzuc0nPyFdMtN/Pyjs+dX24ffTbUJLWFwEEc4reuLgSo
         K2E2To1cJiWKGarN6ULhOthuHcal2sqTRqz4FSgAvnvG65UNEKrdLJdDI1YaDRAxXODI
         nkr2p8zDk8iV0vWT141Gb/TToMpGI+42GKc99kM5h8XW517/w8FeIXcUS4833R5KXxnw
         gqk0QHrEcbgnNiomZQIowKmrlzsrch/5ANixEdd1WvpcC20MVzcc1e091MyPib/6umTg
         xR1aM+PBqbQZ4o5Iqu0sTlZN+iRhv4UVdxJ7U9HI14hNtwA0WyEoq8v9MphRPOak3fK3
         Mv+w==
X-Gm-Message-State: AOAM531fQ5I0Da0QAvowyJzx/Qsb1VuHf8aZHLQp/25lh0IT9CNpoSEc
        8gkkjmiB4BdevBbF2itzC2ziXmPLctnIh8iRNfku3g==
X-Google-Smtp-Source: ABdhPJwKvfDh1t9M26U004VbvZ6ro62SEkWrqoVnMmhxiXv7A0GIhFwnsb/8qY1gBRpF0fe9NAXbnLLA6NknZ7aCVwg=
X-Received: by 2002:a67:ec3:: with SMTP id 186mr10871742vso.14.1605891628938;
 Fri, 20 Nov 2020 09:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20201022202355.3529836-1-samitolvanen@google.com>
 <20201022202355.3529836-2-samitolvanen@google.com> <20201119130036.GA4331@willie-the-truck>
In-Reply-To: <20201119130036.GA4331@willie-the-truck>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 20 Nov 2020 09:00:17 -0800
Message-ID: <CABCJKuc4W0F+8cVhGGRMnpCSwGC3wnZqvJf6zkCubEec8R88yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] scs: switch to vmapped shadow stacks
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 5:00 AM Will Deacon <will@kernel.org> wrote:
>
> Hi Sami,
>
> On Thu, Oct 22, 2020 at 01:23:54PM -0700, Sami Tolvanen wrote:
> > The kernel currently uses kmem_cache to allocate shadow call stacks,
> > which means an overflow may not be immediately detected and can
> > potentially result in another task's shadow stack to be overwritten.
> >
> > This change switches SCS to use virtually mapped shadow stacks,
> > which increases shadow stack size to a full page and provides more
> > robust overflow detection similarly to VMAP_STACK.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  include/linux/scs.h |  7 +----
> >  kernel/scs.c        | 63 ++++++++++++++++++++++++++++++++++++++-------
> >  2 files changed, 55 insertions(+), 15 deletions(-)
>
> Cheers for posting this. I _much_ prefer handling the SCS this way, but I
> have some comments on the implementation below.
>
> > diff --git a/include/linux/scs.h b/include/linux/scs.h
> > index 6dec390cf154..86e3c4b7b714 100644
> > --- a/include/linux/scs.h
> > +++ b/include/linux/scs.h
> > @@ -15,12 +15,7 @@
> >
> >  #ifdef CONFIG_SHADOW_CALL_STACK
> >
> > -/*
> > - * In testing, 1 KiB shadow stack size (i.e. 128 stack frames on a 64-bit
> > - * architecture) provided ~40% safety margin on stack usage while keeping
> > - * memory allocation overhead reasonable.
> > - */
> > -#define SCS_SIZE             SZ_1K
> > +#define SCS_SIZE             PAGE_SIZE
>
> We could make this SCS_ORDER and then forget about alignment etc.

It's still convenient to have SCS_SIZE defined, I think. I can
certainly define SCS_ORDER and use that to define SCS_SIZE, but do you
think we'll need an order >0 here at some point in future?

> >  #define GFP_SCS                      (GFP_KERNEL | __GFP_ZERO)
> >
> >  /* An illegal pointer value to mark the end of the shadow stack. */
> > diff --git a/kernel/scs.c b/kernel/scs.c
> > index 4ff4a7ba0094..2136edba548d 100644
> > --- a/kernel/scs.c
> > +++ b/kernel/scs.c
> > @@ -5,50 +5,95 @@
> >   * Copyright (C) 2019 Google LLC
> >   */
> >
> > +#include <linux/cpuhotplug.h>
> >  #include <linux/kasan.h>
> >  #include <linux/mm.h>
> >  #include <linux/scs.h>
> > -#include <linux/slab.h>
> > +#include <linux/vmalloc.h>
> >  #include <linux/vmstat.h>
> >
> > -static struct kmem_cache *scs_cache;
> > -
> >  static void __scs_account(void *s, int account)
> >  {
> > -     struct page *scs_page = virt_to_page(s);
> > +     struct page *scs_page = vmalloc_to_page(s);
> >
> >       mod_node_page_state(page_pgdat(scs_page), NR_KERNEL_SCS_KB,
> >                           account * (SCS_SIZE / SZ_1K));
> >  }
> >
> > +/* Matches NR_CACHED_STACKS for VMAP_STACK */
> > +#define NR_CACHED_SCS 2
> > +static DEFINE_PER_CPU(void *, scs_cache[NR_CACHED_SCS]);
> > +
> >  static void *scs_alloc(int node)
> >  {
> > -     void *s = kmem_cache_alloc_node(scs_cache, GFP_SCS, node);
> > +     int i;
> > +     void *s;
> > +
> > +     for (i = 0; i < NR_CACHED_SCS; i++) {
> > +             s = this_cpu_xchg(scs_cache[i], NULL);
> > +             if (s) {
> > +                     memset(s, 0, SCS_SIZE);
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     /*
> > +      * We allocate a full page for the shadow stack, which should be
> > +      * more than we need. Check the assumption nevertheless.
> > +      */
> > +     BUILD_BUG_ON(SCS_SIZE > PAGE_SIZE);i
>
> With SCS_ORDER, you can drop this.
>
> > +
> > +     s = __vmalloc_node_range(PAGE_SIZE, SCS_SIZE,
> > +                              VMALLOC_START, VMALLOC_END,
> > +                              GFP_SCS, PAGE_KERNEL, 0,
> > +                              node, __builtin_return_address(0));
>
> Do we actually need vmalloc here? If we used alloc_pages() + vmap()

Does it matter that vmap() always uses NUMA_NO_NODE? We'll also lose
the ability to use vfree_atomic() in scs_release() unless we use
VM_MAP_PUT_PAGES and allocate the page array passed to vmap() with
kvmalloc(), which I think we need to do to avoid sleeping in
scs_free().

> instead, then we could avoid the expensive call to vmalloc_to_page()
> in __scs_account().

We still need vmalloc_to_page() in scs_release(). I suppose we could
alternatively follow the example in kernel/fork.c and cache the
vm_struct from find_vm_area() and use vm->pages[0] for the accounting.
Thoughts?

>
> >
> >       if (!s)
> >               return NULL;
> >
> > +out:
> >       *__scs_magic(s) = SCS_END_MAGIC;
> >
> >       /*
> >        * Poison the allocation to catch unintentional accesses to
> >        * the shadow stack when KASAN is enabled.
> >        */
> > -     kasan_poison_object_data(scs_cache, s);
> > +     kasan_poison_vmalloc(s, SCS_SIZE);
> >       __scs_account(s, 1);
> >       return s;
> >  }
> >
> >  static void scs_free(void *s)
> >  {
> > +     int i;
> > +
> >       __scs_account(s, -1);
> > -     kasan_unpoison_object_data(scs_cache, s);
> > -     kmem_cache_free(scs_cache, s);
> > +     kasan_unpoison_vmalloc(s, SCS_SIZE);
>
> I don't see the point in unpoisoning here tbh; vfree_atomic() re-poisons
> almost immediately, so we should probably defer this to scs_alloc() and
> only when picking the stack out of the cache.

Sure, I'll change this in v2.

>
> > +
> > +     for (i = 0; i < NR_CACHED_SCS; i++)
>
> Can you add a comment about the re-entrancy here and why we're using
> this_cpu_cmpxchg() please?

I'll add a comment.

Sami
