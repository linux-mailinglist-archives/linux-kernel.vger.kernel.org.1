Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D819329D6EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbgJ1WTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732282AbgJ1WSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:18:47 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DDCC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:18:46 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c6so475295qkg.12
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Om/J11Dz/+K3ysCSaEysgFFu7qTF4HlL0YVwwzZ7OVM=;
        b=beYPvEBL3d903KFnr0mMKhvGfdVciFknBvx7Lfb6sqcWz8dPftwBhnYr5eg+ahwZJA
         oOhAdFdSRY96hBnGzZVJWy7EaHTQo/Kwy8iPsXr8YjQgWNJIKC1qU71L/MnijRv18FA7
         75FOMWUN1xhvO75zewvnXNpRrIR20qqJefmmLBDuJ7uG04paHnynL4DKtMwEYBmo7GEf
         BpYC76B6QQc9TwjEr42pfgiRn8Mdia1SdAfgcaZyErgZyNrxRHkv6T3Fiw3prnGKopgy
         NVYfCAH1X2rvniOnkats98NrMarOiNz+8MYpbxILMkg6i5Aw80gQ79iFA+qNXkBPxFQ9
         gDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Om/J11Dz/+K3ysCSaEysgFFu7qTF4HlL0YVwwzZ7OVM=;
        b=exquIQjiLX5PylR4KxMQPylZ90vXnpTHW8AaxOxKjGyBiCpAooEqv9AVVBP76An+c6
         UHfZoIcC35UfFCX4uy27S4aOt7HoxhkaaBE9aoE9D6FiA5qvnoiIBKnLJby+b4IC+Uih
         MUAEarSru0qcGsktg+Zgl7XQyfMCZAI5O6k/2Y9ea8VhL661hYBryJP1xstsfN3w8nwA
         JN54Jtbz50NcLqIFDfHtEaFupbf/pBFex5/bEYk5uECUVloUFIUupOwbGnI0af9j6x2X
         bq1+3q8/HsGiLuPynyq93wzrGs8t08gLW0fo5JpGB4SZDo0pfpQm91YXvT4fW8NXSTRy
         oR/g==
X-Gm-Message-State: AOAM532AiQJIiu+j+2ph+/xRa9p3s2A5tu2QEj7nApfWRxS7GmxVk7d1
        J4335gbOL/RSRRm+suDhTPzY8QiyHanfXneUY23D/DIk2aHgLw==
X-Google-Smtp-Source: ABdhPJwtu7WEEn2mx2PCyqU8hsiWoIohV5vy1l0kAQ9VrLA2Qae+Xn8jL9/lPq+J5T3HdoNVzM0aMM4ohQyIhDtzggw=
X-Received: by 2002:a37:a00c:: with SMTP id j12mr2444824qke.231.1603904612589;
 Wed, 28 Oct 2020 10:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603372719.git.andreyknvl@google.com> <6e866efaa7620162a9824914186ce54b29c17788.1603372719.git.andreyknvl@google.com>
In-Reply-To: <6e866efaa7620162a9824914186ce54b29c17788.1603372719.git.andreyknvl@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 28 Oct 2020 18:03:21 +0100
Message-ID: <CACT4Y+aL_yQCd5POP96yzXfQjgc-6PGweY1N2ozbiD2Y8uRAAA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 20/21] kasan: simplify assign_tag and set_tag calls
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

On Thu, Oct 22, 2020 at 3:20 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> set_tag() already ignores the tag for the generic mode, so just call it
> as is. Add a check for the generic mode to assign_tag(), and simplify its
> call in ____kasan_kmalloc().
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Link: https://linux-review.googlesource.com/id/I18905ca78fb4a3d60e1a34a4ca00247272480438

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  mm/kasan/common.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 983383ebe32a..3cd56861eb11 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -235,6 +235,9 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>  static u8 assign_tag(struct kmem_cache *cache, const void *object,
>                         bool init, bool keep_tag)
>  {
> +       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> +               return 0xff;
> +
>         /*
>          * 1. When an object is kmalloc()'ed, two hooks are called:
>          *    kasan_slab_alloc() and kasan_kmalloc(). We assign the
> @@ -277,8 +280,8 @@ void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>                 __memset(alloc_meta, 0, sizeof(*alloc_meta));
>         }
>
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> -               object = set_tag(object, assign_tag(cache, object, true, false));
> +       /* Tag is ignored in set_tag() without CONFIG_KASAN_SW/HW_TAGS */
> +       object = set_tag(object, assign_tag(cache, object, true, false));
>
>         return (void *)object;
>  }
> @@ -360,9 +363,7 @@ static void *____kasan_kmalloc(struct kmem_cache *cache, const void *object,
>                                 KASAN_GRANULE_SIZE);
>         redzone_end = round_up((unsigned long)object + cache->object_size,
>                                 KASAN_GRANULE_SIZE);
> -
> -       if (IS_ENABLED(CONFIG_KASAN_SW_TAGS) || IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> -               tag = assign_tag(cache, object, false, keep_tag);
> +       tag = assign_tag(cache, object, false, keep_tag);
>
>         /*
>          * Don't unpoison the object when keeping the tag. Tag is kept for:
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
