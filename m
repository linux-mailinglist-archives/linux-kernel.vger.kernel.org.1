Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E52C29AC59
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900184AbgJ0Ml5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:41:57 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46926 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900154AbgJ0MlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:41:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id a23so907749qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0WSVQEGSlOmtaeUZ3M4C4CAr2aYtzYDFb3Hz1iLTMF8=;
        b=UMOH9tN9cRSeE3vqgrC7b4Xw4Z+jRzjlh2yVsnZ3YEdcbfFSLs+oCQESgJnMTZ8nIh
         W6e0KgXWbYLK4lgMJfCL+flgQ3bpd4Tpv7CU1B0SbGvvBNbReYP/HuU1vpn4OvucZitg
         Raba86EeUzNKk6nvUzF7j68OhyYslwCOh47A7oIwpB6l0Ayk6S/tPfbvXGE6naK2MBGW
         /zthLNFbnSCS8//whSDtHe95WGW0r7gP/+JarTUYQqYUD6LoVZfk8LuGw5x4n9qZs6K2
         nwxsqHEFczak759sjA+NjGlhQxjdSmD5CeddkhVBF38VeLNm4LB2gSJPHdvs3uOEmfju
         BNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0WSVQEGSlOmtaeUZ3M4C4CAr2aYtzYDFb3Hz1iLTMF8=;
        b=rN9C40g+xKX3DjMb24cOElHiRp8jnWvSQVdBb1fqD6m77+yVTZlu6YlQQsUNz+dU/4
         HuoLppw7vOv3YeCBBT1BlluOADC/scPTi+aHg07TicIa2lV/qLVNoCLAQzQzO1UOrL5Z
         jZyTnuYNZseeIZBYkmBY11m2L0QQHkqxJOp1jBHW3MJmVl0pN5PKLioq7J9r6qBWWO+M
         a37lwuJYwPcEJZeqrGnd0Yw6CCENbWFG/02LvfNwVmT/9dLI8hkx0V37UsYW88JhjBz0
         It5hWZjX/pVuGWLcPzWpwDqSBDxzDMpbCozokW5kPWljfHs9iqxoP1zCbMVV+QU4BnHR
         NhWQ==
X-Gm-Message-State: AOAM5306WWtlSTXUhcDPxKfMMBbj37rih60irKg8oaIEZacG13IV9tg9
        7gQMUnKFkK89NlzdKamelwRGlESYqLhU+M6lbc1NNQ==
X-Google-Smtp-Source: ABdhPJzeCOTIT+z3O6NE9HLXrbPisUui6Q4rs7ispRERno/r+2ZWxwle5JD3oLkx32lFdhp7ceeyYAOnF6WEGfI/zig=
X-Received: by 2002:a05:620a:1657:: with SMTP id c23mr1940261qko.231.1603802484307;
 Tue, 27 Oct 2020 05:41:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <595f9936a80b62ab89b884d71e904eaa884a96c2.1603372719.git.andreyknvl@google.com>
In-Reply-To: <595f9936a80b62ab89b884d71e904eaa884a96c2.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Oct 2020 13:41:13 +0100
Message-ID: <CACT4Y+aLbptEajrccpMrMPAPivmm0DHXgpV-Jt=h-axjqx6BcA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 03/21] kasan: introduce set_alloc_info
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
> Add set_alloc_info() helper and move kasan_set_track() into it. This will
> simplify the code for one of the upcoming changes.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I0316193cbb4ecc9b87b7c2eee0dd79f8ec908c1a

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 8fd04415d8f4..a880e5a547ed 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -318,6 +318,11 @@ bool kasan_slab_free(struct kmem_cache *cache, void *object, unsigned long ip)
>         return __kasan_slab_free(cache, object, ip, true);
>  }
>
> +static void set_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags)
> +{
> +       kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> +}
> +
>  static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>                                 size_t size, gfp_t flags, bool keep_tag)
>  {
> @@ -345,7 +350,7 @@ static void *__kasan_kmalloc(struct kmem_cache *cache, const void *object,
>                 KASAN_KMALLOC_REDZONE);
>
>         if (cache->flags & SLAB_KASAN)
> -               kasan_set_track(&kasan_get_alloc_meta(cache, object)->alloc_track, flags);
> +               set_alloc_info(cache, (void *)object, flags);
>
>         return set_tag(object, tag);
>  }
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
