Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C229FBB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgJ3CuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgJ3CuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:50:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71BAC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id d25so5309178ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kiZ/FvhUKgnzktM7r0SIhiQ+o9jRSo0aasuFIIfF3Y4=;
        b=cI/RSXbZ3J08HVkL+vxrbM0y0ixEiW+UufDqi9EAkN5pqVxxegRDoJPui5zHfZ7qjJ
         W8J63y0QQOu8sjqOyYPK2vOVdbuWG8XtwGWniWLz3CsMmEp9olTucaQhSUiHdGohBk9s
         HCF02zZFCKFSvDrXYT3Jcd3/Dfg2xKE+Jo7v9WHylqDTi35IZRyIolZA3vpGaLIlo5SR
         8sbesLXWXbq5qxOr76b+jAy8CSLL9RIjyZiGrFk6bz02n2Fw/atjkAG3KwkVj8bq3LkC
         GCP/2Oop9izxkyn5RHaKefvSPajk5eXfdHcNgyE7zZ8gG7pjo7ejTNlbjHakBsLWi3SU
         8PBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kiZ/FvhUKgnzktM7r0SIhiQ+o9jRSo0aasuFIIfF3Y4=;
        b=PKzsZiq1HhSIflyXE8z11mjCENzLnP4bBBYC8Z3ma7vImwA5RsYoRogEp9KY9UIaWc
         6fSTxNI78stdPs1Cl3s1NaC/dOaT8Kn7BMFHr2Kj5atdUB9f6RHyI7/0DUorDsT5nbYn
         7rkbAwSwk8xwc34XWgm/UBhcPLkbOJlmtzte/SkMqCrjpcG8apdnPFa3BxWEZ2DR2QtP
         KYXr/XWEOczbWumTzUMVTShezVAAH3V+lIJTDIu4pJrbDcJkPQ8eARXuVFybvyIq+K9w
         3W84uxM+nPZC36r5CJneC8U4oSA6i56KtI83IBJjhV6m9v5Qaa7XmEfX5dgKcSlmajDN
         mBKw==
X-Gm-Message-State: AOAM531gaoThOZmXNyNQDQoIxIZfsuVCwE6t3e8XiQQ8Ezu1aLNm8L1n
        KeytaSCm3PBYcG25FMetsUVo/Zd1uGMY8/ZFy5SB7w==
X-Google-Smtp-Source: ABdhPJzeJARslRAT+guaj4Ff3DrOlfqS+AGv0L6pZO5uH8AEy32OHFCAY9odVyg2ahuPLAqwrFcx0LUf5ahITqeZkLk=
X-Received: by 2002:a2e:9c84:: with SMTP id x4mr96553lji.326.1604026208097;
 Thu, 29 Oct 2020 19:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <20201029131649.182037-6-elver@google.com>
In-Reply-To: <20201029131649.182037-6-elver@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 30 Oct 2020 03:49:41 +0100
Message-ID: <CAG48ez005N4SVKNXDL7k1C+JPiEbY7eTBJ+kL53N7g=bgWGAeQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/9] mm, kfence: insert KFENCE hooks for SLUB
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
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
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, joern@purestorage.com,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 2:17 PM Marco Elver <elver@google.com> wrote:
> Inserts KFENCE hooks into the SLUB allocator.
>
> To pass the originally requested size to KFENCE, add an argument
> 'orig_size' to slab_alloc*(). The additional argument is required to
> preserve the requested original size for kmalloc() allocations, which
> uses size classes (e.g. an allocation of 272 bytes will return an object
> of size 512). Therefore, kmem_cache::size does not represent the
> kmalloc-caller's requested size, and we must introduce the argument
> 'orig_size' to propagate the originally requested size to KFENCE.
>
> Without the originally requested size, we would not be able to detect
> out-of-bounds accesses for objects placed at the end of a KFENCE object
> page if that object is not equal to the kmalloc-size class it was
> bucketed into.
>
> When KFENCE is disabled, there is no additional overhead, since
> slab_alloc*() functions are __always_inline.
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Jann Horn <jannh@google.com>

if you fix one nit:

[...]
> diff --git a/mm/slub.c b/mm/slub.c
[...]
> @@ -2658,7 +2664,8 @@ static inline void *get_freelist(struct kmem_cache *s, struct page *page)
>   * already disabled (which is the case for bulk allocation).
>   */
>  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -                         unsigned long addr, struct kmem_cache_cpu *c)
> +                         unsigned long addr, struct kmem_cache_cpu *c,
> +                         size_t orig_size)

orig_size is added as a new argument, but never used. (And if you
remove this argument, __slab_alloc will also not be using its
orig_size argument anymore.)



>  {
>         void *freelist;
>         struct page *page;
> @@ -2763,7 +2770,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>   * cpu changes by refetching the per cpu area pointer.
>   */
>  static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> -                         unsigned long addr, struct kmem_cache_cpu *c)
> +                         unsigned long addr, struct kmem_cache_cpu *c,
> +                         size_t orig_size)
>  {
>         void *p;
>         unsigned long flags;
> @@ -2778,7 +2786,7 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>         c = this_cpu_ptr(s->cpu_slab);
>  #endif
>
> -       p = ___slab_alloc(s, gfpflags, node, addr, c);
> +       p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>         local_irq_restore(flags);
>         return p;
>  }
