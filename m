Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F3727CEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgI2NNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbgI2NNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:13:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1689BC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:13:43 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so4750253wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTFDtrWAFNtSx+STL9ivxdzcSQCqNLxR2RvvS87FYs8=;
        b=Lq57cMFjJdsZitlNgytm7PsrAOH3c5fyYhhIrlpRYUvEz+9FkNlEgU3qVOAcJ0wuFW
         +xn3neApnxiN+gj66GSFdigtNadD1ZHNCZXv6sfa8RiQSsMF+f+o1kSNYXryQqzMasHX
         JT2aFyQzlCtJVcEDR2ut0tjnkOERq4fG8VuBM1ZPGHKWT0P+DWCh0/AvKZ9yWyZv76fE
         +OdQA9RlpxxFeDDERUSkYcdO0ltny8r91ypfnmSGwOja5+NxtDYhJSkAHbo7m9XlWxGG
         CMDIWJ0JlfEe51eyKpYc23+bWPe9XFUr+IGASvf+0qQZlj8kKWMYiJlvOiXFpznXleA5
         Iz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTFDtrWAFNtSx+STL9ivxdzcSQCqNLxR2RvvS87FYs8=;
        b=Arl8Efq8UVNpse8WlFfOeZ9+uRr+CsCNRGQc/7NgKRkn0VCbsjZfODu0gcpwHf+rnN
         MRW9lp+JcMrMocS89uwfpbfEByKwSn0Q+QIm8zY2H+Tz4GQlo+6tPreSMlDWYXhDGBe4
         Dp9c8zj1JRKIl04iq/RQNLhV/inhqThjZ5EsQtY0IyQJfAVkD6E1frhFeYidYqX7R+XQ
         YK6yU0kqTNU5OD1VJavFxsSHfzEbopdnx9R5yO3FjXQpeUsbPgclrbv6acbqxn40ntDS
         bKAZ4sQtKd/lWbhw0uMOYtnWp8mYpykXeq393Qnl18WodUZKHALMQFPS7fss0oBRCt0f
         zMkQ==
X-Gm-Message-State: AOAM532sPDjOMqqSY1xBR8XKayMNdTYWyBHg9kA8KA/XCuXUeFHjkD8p
        xPpcPr+yrTtLEP1s+oOp02HFonGwmNe5zhr2Y5wG9A==
X-Google-Smtp-Source: ABdhPJzw/Zb4GAgOYha9l6GBhoHEbXOYGxJdrW488S4mgz+iiVYDyyZg9YqgYZzaKC9YtLUJm/IWtLrVjvkYqHlU+Hs=
X-Received: by 2002:a7b:c749:: with SMTP id w9mr4247992wmk.29.1601385221422;
 Tue, 29 Sep 2020 06:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-7-elver@google.com>
 <CAAeHK+yMmGSTpwC1zPxaoBmXsfmmhuLJ3b2N3qUXUjO5U0tM3Q@mail.gmail.com>
In-Reply-To: <CAAeHK+yMmGSTpwC1zPxaoBmXsfmmhuLJ3b2N3qUXUjO5U0tM3Q@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 29 Sep 2020 15:13:30 +0200
Message-ID: <CAG_fn=VkLKE5OBFatheWGNGy7jcw8iuFqjqCARGu-uWOte6HOw@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] kfence, kasan: make KFENCE compatible with KASAN
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan.Cameron@huawei.com, Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, sjpark@amazon.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 2:21 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Mon, Sep 21, 2020 at 3:26 PM Marco Elver <elver@google.com> wrote:
> >
> > From: Alexander Potapenko <glider@google.com>
> >
> > We make KFENCE compatible with KASAN for testing KFENCE itself. In
> > particular, KASAN helps to catch any potential corruptions to KFENCE
> > state, or other corruptions that may be a result of freepointer
> > corruptions in the main allocators.
> >
> > To indicate that the combination of the two is generally discouraged,
> > CONFIG_EXPERT=y should be set. It also gives us the nice property that
> > KFENCE will be build-tested by allyesconfig builds.
> >
> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> > Co-developed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > ---
> >  lib/Kconfig.kfence | 2 +-
> >  mm/kasan/common.c  | 7 +++++++
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.kfence b/lib/Kconfig.kfence
> > index 4c2ea1c722de..6825c1c07a10 100644
> > --- a/lib/Kconfig.kfence
> > +++ b/lib/Kconfig.kfence
> > @@ -10,7 +10,7 @@ config HAVE_ARCH_KFENCE_STATIC_POOL
> >
> >  menuconfig KFENCE
> >         bool "KFENCE: low-overhead sampling-based memory safety error detector"
> > -       depends on HAVE_ARCH_KFENCE && !KASAN && (SLAB || SLUB)
> > +       depends on HAVE_ARCH_KFENCE && (!KASAN || EXPERT) && (SLAB || SLUB)
> >         depends on JUMP_LABEL # To ensure performance, require jump labels
> >         select STACKTRACE
> >         help
> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> > index 950fd372a07e..f5c49f0fdeff 100644
> > --- a/mm/kasan/common.c
> > +++ b/mm/kasan/common.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/init.h>
> >  #include <linux/kasan.h>
> >  #include <linux/kernel.h>
> > +#include <linux/kfence.h>
> >  #include <linux/kmemleak.h>
> >  #include <linux/linkage.h>
> >  #include <linux/memblock.h>
> > @@ -396,6 +397,9 @@ static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> >         tagged_object = object;
> >         object = reset_tag(object);
> >
> > +       if (is_kfence_address(object))
> > +               return false;
> > +
> >         if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
> >             object)) {
> >                 kasan_report_invalid_free(tagged_object, ip);
> > @@ -444,6 +448,9 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
> >         if (unlikely(object == NULL))
> >                 return NULL;
> >
> > +       if (is_kfence_address(object))
> > +               return (void *)object;
> > +
> >         redzone_start = round_up((unsigned long)(object + size),
> >                                 KASAN_SHADOW_SCALE_SIZE);
> >         redzone_end = round_up((unsigned long)object + cache->object_size,
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
>
> With KFENCE + KASAN both enabled we need to bail out in all KASAN
> hooks that get called from the allocator, right? Do I understand
> correctly that these two are the only ones that are called for
> KFENCE-allocated objects due to the way KFENCE is integrated into the
> allocator?

Yes, these two places were sufficient; we've checked that KFENCE and
KASAN work together.
