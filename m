Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5551527005D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgIRPAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRPAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:00:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63B1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:00:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e4so3112886pln.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43HOBOFmwhtePq8PeIBCEBCa6ILf8VtzLC2fB6iIXLI=;
        b=ZwMp8rTYude/m8e4AjpmPmYXmn1OyxxT0b81WxynRHwoKm5tuUil33CmvmAZC7k0Qu
         TIEgiSbT4v0NU7cFsGzdRTvKOGW/Piv7H5wYRnVqEaU2LdXftO30ow2qZr5LU/jGZs/F
         LU0/2O1pWp1thAILGKv55VJq5nuPvIJBDsDilogN4vevzKSrySLFVRNmItHNNfeuCyQE
         Ex3P75hm8fMhl2CoWyzJkUzjOwf6PxqnKaJEIo0oDwCzQP89NgWfdZylrEp3KNY0CczH
         flk3gVjF/lb44LmKGwYnAS2Uzb7URYTYVhVHoT2+qzczraIj3fKQFeN5v7Lits9zP4yY
         w69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43HOBOFmwhtePq8PeIBCEBCa6ILf8VtzLC2fB6iIXLI=;
        b=fpRUH4wuJ2Qy9XilD8a9oNvFLwUpAouoVEpw1/Ag8cUBSaSiF883wlbbfjAMxn9RxB
         HgK4Mb/2ehjceQ9uFwGa5yVDtUbLzkmFmgcTAv9Wn1qGGxAjvfwQXFMSRbEqW044NCWR
         MMHMXNql7Ar94fNprh53gLKJAKjiylQuYtrs2gBWJpj0uWck69ERmLYbNVupRs/sGf3U
         flbgvxvv5LOuq9Ar/p6sA91hySJy5HQp8YRxjmwdVo2B9MQVH/txDMqgGMD+kWqMkkdo
         gEayVf9balgJ4Gq3NFQYoqispQey2PNgD6/jHCANL/IIss6ObB9I1sWZrORfxY7pjcw0
         bxlQ==
X-Gm-Message-State: AOAM531TGEQN13NfrrLfHXP/9iCmI2sJ4bURen3xJCGOe2aAg9MWOlMe
        rMvR6YSEA/ipORtqC3H5uRYEWzVpwrKf1w83AEZOeXNnU/Ys3A==
X-Google-Smtp-Source: ABdhPJxzGZXU3x/rtx4bWTn+tg8BBnZsw9+h4p5kvRQigJEqvqcpV9eMKwoMwAXnogjuZ+Hlr5Ql3jaPFhNeu+MiVlU=
X-Received: by 2002:a17:902:b117:b029:d1:e5e7:bdf5 with SMTP id
 q23-20020a170902b117b02900d1e5e7bdf5mr15071472plr.85.1600441216910; Fri, 18
 Sep 2020 08:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600204505.git.andreyknvl@google.com> <74133d1a57c47cb8fec791dd5d1e6417b0579fc3.1600204505.git.andreyknvl@google.com>
 <20200918125216.GD2384246@elver.google.com>
In-Reply-To: <20200918125216.GD2384246@elver.google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 18 Sep 2020 17:00:06 +0200
Message-ID: <CAAeHK+z40FP0xJo+uc-Y49LEBTb-G54nNWqePJm9J-2SJ8v5sQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/37] kasan, arm64: implement HW_TAGS runtime
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 2:52 PM Marco Elver <elver@google.com> wrote:
>
> [ Sorry for the additional email on this patch; trying to consolidate
>   comments now. ]
>
> On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> > Provide implementation of KASAN functions required for the hardware
> > tag-based mode. Those include core functions for memory and pointer
> > tagging (tags_hw.c) and bug reporting (report_tags_hw.c). Also adapt
> > common KASAN code to support the new mode.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> > Change-Id: I8a8689ba098174a4d0ef3f1d008178387c80ee1c
> > ---
> >  arch/arm64/include/asm/memory.h   |  4 +-
> >  arch/arm64/kernel/setup.c         |  1 -
> >  include/linux/kasan.h             |  6 +--
> >  include/linux/mm.h                |  2 +-
> >  include/linux/page-flags-layout.h |  2 +-
> >  mm/kasan/Makefile                 |  5 ++
> >  mm/kasan/common.c                 | 14 +++---
> >  mm/kasan/kasan.h                  | 17 +++++--
> >  mm/kasan/report_tags_hw.c         | 47 +++++++++++++++++++
> >  mm/kasan/report_tags_sw.c         |  2 +-
> >  mm/kasan/shadow.c                 |  2 +-
> >  mm/kasan/tags_hw.c                | 78 +++++++++++++++++++++++++++++++
> >  mm/kasan/tags_sw.c                |  2 +-
> >  13 files changed, 162 insertions(+), 20 deletions(-)
> >  create mode 100644 mm/kasan/report_tags_hw.c
> >  create mode 100644 mm/kasan/tags_hw.c
> [...]
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 41c7f1105eaa..412a23d1546b 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -118,7 +118,7 @@ void kasan_free_pages(struct page *page, unsigned int order)
> >   */
> >  static inline unsigned int optimal_redzone(unsigned int object_size)
> >  {
> > -     if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > +     if (!IS_ENABLED(CONFIG_KASAN_GENERIC))
> >               return 0;
> >
> >       return
> > @@ -183,14 +183,14 @@ size_t kasan_metadata_size(struct kmem_cache *cache)
> >  struct kasan_alloc_meta *get_alloc_info(struct kmem_cache *cache,
> >                                       const void *object)
> >  {
> > -     return (void *)object + cache->kasan_info.alloc_meta_offset;
> > +     return (void *)reset_tag(object) + cache->kasan_info.alloc_meta_offset;
> >  }
> >
> >  struct kasan_free_meta *get_free_info(struct kmem_cache *cache,
> >                                     const void *object)
> >  {
> >       BUILD_BUG_ON(sizeof(struct kasan_free_meta) > 32);
> > -     return (void *)object + cache->kasan_info.free_meta_offset;
> > +     return (void *)reset_tag(object) + cache->kasan_info.free_meta_offset;
> >  }
> >
> >  void kasan_poison_slab(struct page *page)
> > @@ -272,7 +272,8 @@ void * __must_check kasan_init_slab_obj(struct kmem_cache *cache,
> >       alloc_info = get_alloc_info(cache, object);
> >       __memset(alloc_info, 0, sizeof(*alloc_info));
>
> Suggested edit below (assuming the line-break wasn't intentional; this
> should still be within checkpatch.pl's 100 col limit):
> ------
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
> -                       IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>                 object = set_tag(object,
>                                 assign_tag(cache, object, true, false));
>
> @@ -343,8 +342,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>         redzone_end = round_up((unsigned long)object + cache->object_size,
>                                 KASAN_GRANULE_SIZE);
>
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
> -                       IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> +       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>                 tag = assign_tag(cache, object, false, keep_tag);
> ------
>
> > -     if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > +     if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
> > +                     IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> >               object = set_tag(object,
> >                               assign_tag(cache, object, true, false));
> >
> > @@ -342,10 +343,11 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
> >       redzone_end = round_up((unsigned long)object + cache->object_size,
> >                               KASAN_GRANULE_SIZE);
> >
> > -     if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> > +     if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) ||
> > +                     IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> >               tag = assign_tag(cache, object, false, keep_tag);
> >
> > -     /* Tag is ignored in set_tag without CONFIG_KASAN_SW_TAGS */
> > +     /* Tag is ignored in set_tag without CONFIG_KASAN_SW/HW_TAGS */
> >       kasan_unpoison_memory(set_tag(object, tag), size);
> >       kasan_poison_memory((void *)redzone_start, redzone_end - redzone_start,
> >               KASAN_KMALLOC_REDZONE);
> [...]
> > diff --git a/mm/kasan/report_tags_hw.c b/mm/kasan/report_tags_hw.c
> > new file mode 100644
> > index 000000000000..c2f73c46279a
> > --- /dev/null
> > +++ b/mm/kasan/report_tags_hw.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This file contains hardware tag-based KASAN specific error reporting code.
> > + *
> > + * Copyright (c) 2020 Google, Inc.
> > + * Author: Andrey Konovalov <andreyknvl@google.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
>
> I do not think we put the "This program is ..." preamble in new files
> anymore. It should be covered by SPDX tag above.
>
> > + */
> > +
> > +#include <linux/kasan.h>
> > +#include <linux/kernel.h>
> > +#include <linux/memory.h>
> > +#include <linux/mm.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> [...]
> > diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> > index 4888084ecdfc..ca69726adf8f 100644
> > --- a/mm/kasan/shadow.c
> > +++ b/mm/kasan/shadow.c
> > @@ -111,7 +111,7 @@ void kasan_unpoison_memory(const void *address, size_t size)
> >
> >               if (IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> >                       *shadow = tag;
> > -             else
> > +             else /* CONFIG_KASAN_GENERIC */
> >                       *shadow = size & KASAN_GRANULE_MASK;
> >       }
> >  }
> > diff --git a/mm/kasan/tags_hw.c b/mm/kasan/tags_hw.c
> > new file mode 100644
> > index 000000000000..c93d43379e39
> > --- /dev/null
> > +++ b/mm/kasan/tags_hw.c
> > @@ -0,0 +1,78 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * This file contains core hardware tag-based KASAN code.
> > + *
> > + * Copyright (c) 2020 Google, Inc.
> > + * Author: Andrey Konovalov <andreyknvl@google.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
>
> I do not think we put the "This program is ..." preamble in new files
> anymore. It should be covered by SPDX tag above.
>
> > + */
> > +
> > +#include <linux/kasan.h>
> > +#include <linux/kernel.h>
> > +#include <linux/memory.h>
> > +#include <linux/mm.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
> > +
> > +#include "kasan.h"
> > +
> > +void kasan_init_tags(void)
> > +{
> > +     init_tags(KASAN_TAG_MAX);
> > +}
> > +
> > +void *kasan_reset_tag(const void *addr)
> > +{
> > +     return reset_tag(addr);
> > +}
> > +
>
> To help readability, would this edit be ok?
> ------
>  void kasan_poison_memory(const void *address, size_t size, u8 value)
>  {
> -       set_mem_tag_range(reset_tag(address),
> -               round_up(size, KASAN_GRANULE_SIZE), value);
> +       set_mem_tag_range(reset_tag(address), round_up(size, KASAN_GRANULE_SIZE), value);
>  }
>
>  void kasan_unpoison_memory(const void *address, size_t size)
>  {
> -       set_mem_tag_range(reset_tag(address),
> -               round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> +       set_mem_tag_range(reset_tag(address), round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
>  }
> ------
>
> > +void kasan_poison_memory(const void *address, size_t size, u8 value)
> > +{
> > +     set_mem_tag_range(reset_tag(address),
> > +             round_up(size, KASAN_GRANULE_SIZE), value);
> > +}
> > +
> > +void kasan_unpoison_memory(const void *address, size_t size)
> > +{
> > +     set_mem_tag_range(reset_tag(address),
> > +             round_up(size, KASAN_GRANULE_SIZE), get_tag(address));
> > +}
> > +
> > +u8 random_tag(void)
> > +{
> > +     return get_random_tag();
> > +}
> > +
> > +bool check_invalid_free(void *addr)
> > +{
> > +     u8 ptr_tag = get_tag(addr);
> > +     u8 mem_tag = get_mem_tag(addr);
> > +
>
>
> Why not just:
> ------
> -       if (shadow_byte == KASAN_TAG_INVALID)
> -               return true;
> -       if (tag != KASAN_TAG_KERNEL && tag != shadow_byte)
> -               return true;
> -       return false;
> +       return shadow_byte == KASAN_TAG_INVALID ||
> +              (tag != KASAN_TAG_KERNEL && tag != shadow_byte);
>  }
> ------
>
> > +     if (mem_tag == KASAN_TAG_INVALID)
> > +             return true;
> > +     if (ptr_tag != KASAN_TAG_KERNEL && ptr_tag != mem_tag)
> > +             return true;
> > +     return false;
> > +}
> > +

Will fix all these in v3, thanks!
