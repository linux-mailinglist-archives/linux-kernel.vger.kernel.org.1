Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1DAE2AF343
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKKON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKON0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:13:26 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B906C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:13:26 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id r12so901825qvq.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aZg/3dO+K+3/7egp9giqF6NxjGJW8QC5duS9to8aMlY=;
        b=Xw7CFjGzL8Kjfg/8OXuLrwhbg9ZP9ZHm/ZXt4h4x8mpl0H2vS4DZiwHFDn4SKHJ0mw
         tyjfvfVlgZQcF1VyCUd8kEy/ehZXpKHASrIJGa9KsHxzkTWcmFgv+09aEPXfS3D2zix0
         FjEtZ1so6G8zYcXxpsrnXKwYXqmUICjTddFkNf7NI22OsCfIqu1BN+i5N31nYwBl+kR+
         OPwqoRtYgbsU6nwtsZ81Z5mLoLiIckYMPEkXV8cfal2djwPNI2A0CrtKjCw1dVp4KKEh
         VzdXTpNLJ5UB4sJaANPV3Ri2Cvz4/Nt3L82gx/cZqJCsiMM2Lsllm8UgJFczjhV/uo57
         mjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aZg/3dO+K+3/7egp9giqF6NxjGJW8QC5duS9to8aMlY=;
        b=eoLbZW0DcQF4++9dMJcuM6kHnmg6rd9VMSf+43juvJdduj7wTE7T3nHKScYa6YFVhH
         yLklRvlrulrIWoffvQDpgjOmKryfhBD4S8xEimLaKXfOc5fGgvF5epav3pV0RCS0C/FH
         tjUhAb1gUUccS9e5xf6q5vqpfHo0bpCeuJhYPTwSRAhjKc4upbVyjtGdpgwuSa3AI4RM
         8P28sCKnsGD2iAYnTz2xHL5F6JdGUmM1WFAnwHuzQIg5qXFmF3Ax5pPc3pCa5Gw0ys8/
         5HuX2Edo1Zw9/FXUpXVA9HmGKUZWWumYDbGGZKoaHy2rv4jYIhJolllc3+vIQ3x6AJPy
         8B0A==
X-Gm-Message-State: AOAM532+HCxycKZhBv5/8nZw9GXyg+GT7uOQCYEVlvvJ+2OLt/20ml/K
        BpitdqrET5mHA0y50A7a4pNm9Gxwwi7f417IToOR3A==
X-Google-Smtp-Source: ABdhPJy0oA37tH29jq6K/3f8eXTURhzdJBnfxbCpoDa4SIF888pNpma8ToBbSmYwnn/LMwKyWPnPeW4+dy1W+1T0FZk=
X-Received: by 2002:a0c:9e53:: with SMTP id z19mr24630768qve.23.1605104005104;
 Wed, 11 Nov 2020 06:13:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <85aba371903b749412fac34e44e54c89e5ddae30.1605046192.git.andreyknvl@google.com>
In-Reply-To: <85aba371903b749412fac34e44e54c89e5ddae30.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 15:13:13 +0100
Message-ID: <CAG_fn=VuM=4axS6ex7_MgCeZ47o+Scon1WuFGStF78T36sHayw@mail.gmail.com>
Subject: Re: [PATCH v9 10/44] kasan: define KASAN_GRANULE_PAGE
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 11:11 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> Define KASAN_GRANULE_PAGE as (KASAN_GRANULE_SIZE << PAGE_SHIFT), which is
> the same as (KASAN_GRANULE_SIZE * PAGE_SIZE), and use it across KASAN cod=
e
> to simplify it.

What's the physical sense behind KASAN_GRANULE_PAGE? Is it something
more than just a product of two constants?
The name suggests it might be something page-sized, but in reality it is no=
t.

>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
> Change-Id: I0b627b24187d06c8b9bb2f1d04d94b3d06945e73
> ---
>  mm/kasan/init.c   | 10 ++++------
>  mm/kasan/kasan.h  |  1 +
>  mm/kasan/shadow.c | 16 +++++++---------
>  3 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 1a71eaa8c5f9..26b2663b3a42 100644
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
> +       if (WARN_ON((unsigned long)start % KASAN_GRANULE_PAGE) ||
> +           WARN_ON(size % KASAN_GRANULE_PAGE))
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
> +       if (WARN_ON((unsigned long)start % KASAN_GRANULE_PAGE) ||
> +           WARN_ON(size % KASAN_GRANULE_PAGE))
>                 return -EINVAL;
>
>         ret =3D kasan_populate_early_shadow(shadow_start, shadow_end);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index c31e2c739301..1865bb92d47a 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -7,6 +7,7 @@
>
>  #define KASAN_GRANULE_SIZE     (1UL << KASAN_SHADOW_SCALE_SHIFT)
>  #define KASAN_GRANULE_MASK     (KASAN_GRANULE_SIZE - 1)
> +#define KASAN_GRANULE_PAGE     (KASAN_GRANULE_SIZE << PAGE_SHIFT)
>
>  #define KASAN_TAG_KERNEL       0xFF /* native kernel pointers tag */
>  #define KASAN_TAG_INVALID      0xFE /* inaccessible memory tag */
> diff --git a/mm/kasan/shadow.c b/mm/kasan/shadow.c
> index ca0cc4c31454..1fadd4930d54 100644
> --- a/mm/kasan/shadow.c
> +++ b/mm/kasan/shadow.c
> @@ -161,7 +161,7 @@ static int __meminit kasan_mem_notifier(struct notifi=
er_block *nb,
>         shadow_end =3D shadow_start + shadow_size;
>
>         if (WARN_ON(mem_data->nr_pages % KASAN_GRANULE_SIZE) ||
> -               WARN_ON(start_kaddr % (KASAN_GRANULE_SIZE << PAGE_SHIFT))=
)
> +               WARN_ON(start_kaddr % KASAN_GRANULE_PAGE))
>                 return NOTIFY_BAD;
>
>         switch (action) {
> @@ -432,22 +432,20 @@ void kasan_release_vmalloc(unsigned long start, uns=
igned long end,
>         unsigned long region_start, region_end;
>         unsigned long size;
>
> -       region_start =3D ALIGN(start, PAGE_SIZE * KASAN_GRANULE_SIZE);
> -       region_end =3D ALIGN_DOWN(end, PAGE_SIZE * KASAN_GRANULE_SIZE);
> +       region_start =3D ALIGN(start, KASAN_GRANULE_PAGE);
> +       region_end =3D ALIGN_DOWN(end, KASAN_GRANULE_PAGE);
>
> -       free_region_start =3D ALIGN(free_region_start,
> -                                 PAGE_SIZE * KASAN_GRANULE_SIZE);
> +       free_region_start =3D ALIGN(free_region_start, KASAN_GRANULE_PAGE=
);
>
>         if (start !=3D region_start &&
>             free_region_start < region_start)
> -               region_start -=3D PAGE_SIZE * KASAN_GRANULE_SIZE;
> +               region_start -=3D KASAN_GRANULE_PAGE;
>
> -       free_region_end =3D ALIGN_DOWN(free_region_end,
> -                                    PAGE_SIZE * KASAN_GRANULE_SIZE);
> +       free_region_end =3D ALIGN_DOWN(free_region_end, KASAN_GRANULE_PAG=
E);
>
>         if (end !=3D region_end &&
>             free_region_end > region_end)
> -               region_end +=3D PAGE_SIZE * KASAN_GRANULE_SIZE;
> +               region_end +=3D KASAN_GRANULE_PAGE;
>
>         shadow_start =3D kasan_mem_to_shadow((void *)region_start);
>         shadow_end =3D kasan_mem_to_shadow((void *)region_end);
> --
> 2.29.2.222.g5d2a92d10f8-goog
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
