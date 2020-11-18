Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320E02B80A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgKRPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgKRPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:36:23 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811BFC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:36:23 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so1878478qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 07:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DAmalSkle6LseckfE0Oz3lBRGT6/gmH8HIzwoCuD14c=;
        b=PCVKLLBRHYl043FjQjIsPmGX7j3TlSec/OQUdfpcm4pq3DA+xtMRXQ1jINWibM3i39
         osN1Rlq20l3aNZq2Jz/0vqsZsniGguLBP0pcNh53D/rSiY6Boh07OaA5dXVwKTt+Ffpi
         bJ7KRcAY/kLS0BUHcZpk6Q+NZyGxONOoUM1uhc3hNC23kR8Gs0Gsnq5oL9FIeufLVvwe
         9FqMyvG3r6Km4TPxC6C8ZNqsFPj1Lh6s7VA8dU31GPXU0bFRPPdCHf+PiU7PbWJ0ctCF
         sDfk9PRf8/PasW742kyCj7crJTz/99XXm4IBQgv82CoX4jivVbUo1+HxgSg1lk0rSmVR
         /IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DAmalSkle6LseckfE0Oz3lBRGT6/gmH8HIzwoCuD14c=;
        b=BfELpeIH5ILNqsNBGCbQ98LQbdod1AxbsdL9B7WHbAjDvVBBgLhqlD+pQrwfWYgojI
         gK9KiugIs6hZLkWnu2athVGWaDklkiV6DblccjDIBI517131krWCFSOKJBk/YkNNZAsk
         YSjYo9zrSmWMmNb/javS9pvo/kOggTM+H/FAs3Hhj7tCI7Fgp+Xh0NL1+deS48vVnyWE
         5RNT4JQQ+LGbw/pIQuTcYa5pNoWXzuIh+E664aQvcWGpW2BM3PBes5hqHmdQh7UnE1CP
         JYRvPH/bF8uiXzyV652MAiSi7gDF2pAeWIH0A4D7Wl4B6LapsfcsElF8hbMjT4uEbGR9
         BV6A==
X-Gm-Message-State: AOAM531UlKl5Ocl3VXq+W7jqmlEPzxhBjZ8c/dajmU3f6a0OYPSRMJRP
        VeaGbq1/z/ZXHP93983ywbaotUunOGwvnPdtYWezJA==
X-Google-Smtp-Source: ABdhPJzSQfkub20IJSqj/+wbaZPCpGATqv/FYVyT3KxnaJLpklHYozX1ctQotjKQ5XKjGJMN0mAolRH8/V6la+oox8Q=
X-Received: by 2002:ac8:5c85:: with SMTP id r5mr5115177qta.8.1605713782397;
 Wed, 18 Nov 2020 07:36:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com> <19601c2110760228adf7594385db4508f62a5721.1605305705.git.andreyknvl@google.com>
In-Reply-To: <19601c2110760228adf7594385db4508f62a5721.1605305705.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 18 Nov 2020 16:36:10 +0100
Message-ID: <CAG_fn=U3uSm3-dDoDJ6RG2-p4SmcG0sB0z3yjX4Xypf7U67qVg@mail.gmail.com>
Subject: Re: [PATCH mm v10 09/42] kasan: define KASAN_MEMORY_PER_SHADOW_PAGE
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:16 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> Define KASAN_MEMORY_PER_SHADOW_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT)=
,
> which is the same as (KASAN_GRANULE_SIZE * PAGE_SIZE) for software modes
> that use shadow memory, and use it across KASAN code to simplify it.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I0b627b24187d06c8b9bb2f1d04d94b3d06945e73
> ---
>  mm/kasan/init.c   | 10 ++++------
>  mm/kasan/kasan.h  |  2 ++
>  mm/kasan/shadow.c | 16 +++++++---------
>  3 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 1a71eaa8c5f9..bc0ad208b3a7 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -441,9 +441,8 @@ void kasan_remove_zero_shadow(void *start, unsigned l=
ong size)
>         addr =3D (unsigned long)kasan_mem_to_shadow(start);
>         end =3D addr + (size >> KASAN_SHADOW_SCALE_SHIFT);
>
> -       if (WARN_ON((unsigned long)start %
> -                       (KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
> -           WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
> +       if (WARN_ON((unsigned long)start % KASAN_MEMORY_PER_SHADOW_PAGE) =
||
> +           WARN_ON(size % KASAN_MEMORY_PER_SHADOW_PAGE))
>                 return;
>
>         for (; addr < end; addr =3D next) {
> @@ -476,9 +475,8 @@ int kasan_add_zero_shadow(void *start, unsigned long =
size)
>         shadow_start =3D kasan_mem_to_shadow(start);
>         shadow_end =3D shadow_start + (size >> KASAN_SHADOW_SCALE_SHIFT);
>
> -       if (WARN_ON((unsigned long)start %
> -                       (KASAN_GRANULE_SIZE * PAGE_SIZE)) ||
> -           WARN_ON(size % (KASAN_GRANULE_SIZE * PAGE_SIZE)))
> +       if (WARN_ON((unsigned long)start % KASAN_MEMORY_PER_SHADOW_PAGE) =
||
> +           WARN_ON(size % KASAN_MEMORY_PER_SHADOW_PAGE))
>                 return -EINVAL;
>
>         ret =3D kasan_populate_early_shadow(shadow_start, shadow_end);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 53b095f56f28..eec88bf28c64 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -8,6 +8,8 @@
>  #define KASAN_GRANULE_SIZE     (1UL << KASAN_SHADOW_SCALE_SHIFT)
>  #define KASAN_GRANULE_MASK     (KASAN_GRANULE_SIZE - 1)
>
> +#define KASAN_MEMORY_PER_SHADOW_PAGE   (KASAN_GRANULE_SIZE << PAGE_SHIFT=
)
> +
>  #define KASAN_TAG_KERNEL       0xFF /* native kernel pointers tag */
>  #define KASAN_TAG_INVALID      0xFE /* inaccessible memory tag */
>  #define KASAN_TAG_MAX          0xFD /* maximum value for random tags */
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index 4264bfbdca1a..80522d2c447b 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -174,7 +174,7 @@ static int __meminit kasan_mem_notifier(struct notifi=
er_block *nb,
>         shadow_end =3D shadow_start + shadow_size;
>
>         if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
> -               WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT))=
)
> +               WARN_ON(start_kaddr % KASAN_MEMORY_PER_SHADOW_PAGE))
>                 return NOTIFY_BAD;
>
>         switch (action) {
> @@ -445,22 +445,20 @@ void kasan_release_vmalloc(unsigned long start, uns=
igned long end,
>         unsigned long region_start, region_end;
>         unsigned long size;
>
> -       region_start =3D ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
> -       region_end =3D ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
> +       region_start =3D ALIGN(start, KASAN_MEMORY_PER_SHADOW_PAGE);
> +       region_end =3D ALIGN_DOWN(end, KASAN_MEMORY_PER_SHADOW_PAGE);
>
> -       free_region_start =3D ALIGN(free_region_start,
> -                                 PAGE_SIZE * KASAN_GRANULE_SIZE);
> +       free_region_start =3D ALIGN(free_region_start, KASAN_MEMORY_PER_S=
HADOW_PAGE);
>
>         if (start !=3D region_start &&
>             free_region_start < region_start)
> -               region_start -=3D PAGE_SIZE * KASAN_GRANULE_SIZE;
> +               region_start -=3D KASAN_MEMORY_PER_SHADOW_PAGE;
>
> -       free_region_end =3D ALIGN_DOWN(free_region_end,
> -                                    PAGE_SIZE * KASAN_GRANULE_SIZE);
> +       free_region_end =3D ALIGN_DOWN(free_region_end, KASAN_MEMORY_PER_=
SHADOW_PAGE);
>
>         if (end !=3D region_end &&
>             free_region_end > region_end)
> -               region_end +=3D PAGE_SIZE * KASAN_GRANULE_SIZE;
> +               region_end +=3D KASAN_MEMORY_PER_SHADOW_PAGE;
>
>         shadow_start =3D kasan_mem_to_shadow((void *)region_start);
>         shadow_end =3D kasan_mem_to_shadow((void *)region_end);
> --
> 2.29.2.299.gdc1121823c-goog
>


--=20
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
