Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0400E2AF372
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgKKOXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKOXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:23:47 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D76C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:23:45 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id b16so1122014qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UloFlAe4eE6dBOKuaOljn+MXY+P4+o9Y9O9NjdtVr4Y=;
        b=Y3VD18rW6Mkcyy+sI26KIOCxIFEy130EdiK3BKfRiqpWvWkxQ+oyq/DcuRswHRSiCC
         jnsNcRgemJcQiD/n4CbRSAa3fKkMAm33WDdGeJ1QozG1HDoOq7jVTf/Q8a3fe+exSvPO
         rwFQ0256H+E+/F0z3H9AOTkuzG031CtXVUdW3BhaexPH4SAvULaSvzR6v6hAgaHNoOVF
         T0UBcgSUuJ5np7vNU5V8FS8JD0uooL2elfMlubLa4H4cCCE4fR7h8ajCarV7VBbQA8o3
         93NtWwulPvOpJDmCCGsvY6GIL+Xa1FVRFRBdfZ2QIZCRCPNO/tBJ+OTKlzfCvE1wEv2o
         MrHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UloFlAe4eE6dBOKuaOljn+MXY+P4+o9Y9O9NjdtVr4Y=;
        b=FxhSG0ag44TnebYzRiFk6ADQCi9LKL9bpz4dfpzLB/3+I8ZpiZuQAl1BCXSnl3I5rb
         ydigA5iduL2Tz6ZYzj2qa3Pbr5udaqEKPWocPykochnlKoyYPvEN6Bb/pKnzQ+H0lSit
         8FheEQmVHUrd1IsiRHMSH6La8YeLN/kIH7oYLLYffC8yJ2Av3U6y6ElAB8Zkgx9kiCOl
         0jeN+iGMyL5Hkaz6FR2AVRDLW4f4qIZ8C2Jqhq7+yxvlecZ6F2tgo2gZhNHIA26njU0O
         qTXmQshdYv2eFkgHebuI6pRLJj0UOaX9lfkiCtoYBoIVitU9/qqDz4SwNd2wTo29Ivf7
         Ye3Q==
X-Gm-Message-State: AOAM530rtT+PUD+zkpvS98DjqUy4AEFNBncItNbG0YctmB4x5WGNpMLk
        6wJRmkTI63ePGCuhIaBMBtu6trBPWRZu0rKfNTdA6A==
X-Google-Smtp-Source: ABdhPJzHUAKQWPGbmybh6ShDMZd1OwaBAGmCgdaIFdpQpb4uWrpuYS+v5Cs2ngVicNeakb1vFxozgDI96Cs/DC5/IJM=
X-Received: by 2002:ac8:5c85:: with SMTP id r5mr18898460qta.8.1605104624442;
 Wed, 11 Nov 2020 06:23:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <427d46e86c81f3ec77147b0ade4bd551d878cf7a.1605046192.git.andreyknvl@google.com>
In-Reply-To: <427d46e86c81f3ec77147b0ade4bd551d878cf7a.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 15:23:33 +0100
Message-ID: <CAG_fn=XBE+aRBizrJgNGsJ5FGPtSAHWqL26k2pCRxvutJ-LbTg@mail.gmail.com>
Subject: Re: [PATCH v9 13/44] kasan: hide invalid free check implementation
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
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> For software KASAN modes the check is based on the value in the shadow
> memory. Hardware tag-based KASAN won't be using shadow, so hide the
> implementation of the check in check_invalid_free().
>
> Also simplify the code for software tag-based mode.
>
> No functional changes for software modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I5fae9531c9fc948eb4d4e0c589744032fc5a0789
> ---
>  mm/kasan/common.c  | 19 +------------------
>  mm/kasan/generic.c |  7 +++++++
>  mm/kasan/kasan.h   |  2 ++
>  mm/kasan/sw_tags.c |  9 +++++++++
>  4 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 123abfb760d4..543e6bf2168f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -272,25 +272,9 @@ void * __must_check kasan_init_slab_obj(struct kmem_=
cache *cache,
>         return (void *)object;
>  }
>
> -static inline bool shadow_invalid(u8 tag, s8 shadow_byte)
> -{
> -       if (IS_ENABLED(CONFIG_KASAN_GENERIC))
> -               return shadow_byte < 0 ||
> -                       shadow_byte >=3D KASAN_GRANULE_SIZE;
> -
> -       /* else CONFIG_KASAN_SW_TAGS: */
> -       if ((u8)shadow_byte =3D=3D KASAN_TAG_INVALID)
> -               return true;
> -       if ((tag !=3D KASAN_TAG_KERNEL) && (tag !=3D (u8)shadow_byte))
> -               return true;
> -
> -       return false;
> -}
> -
>  static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>                               unsigned long ip, bool quarantine)
>  {
> -       s8 shadow_byte;
>         u8 tag;
>         void *tagged_object;
>         unsigned long rounded_up_size;
> @@ -309,8 +293,7 @@ static bool __kasan_slab_free(struct kmem_cache *cach=
e, void *object,
>         if (unlikely(cache->flags & SLAB_TYPESAFE_BY_RCU))
>                 return false;
>
> -       shadow_byte =3D READ_ONCE(*(s8 *)kasan_mem_to_shadow(object));
> -       if (shadow_invalid(tag, shadow_byte)) {
> +       if (check_invalid_free(tagged_object)) {
>                 kasan_report_invalid_free(tagged_object, ip);
>                 return true;
>         }
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index ec4417156943..e1af3b6c53b8 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -187,6 +187,13 @@ bool check_memory_region(unsigned long addr, size_t =
size, bool write,
>         return check_memory_region_inline(addr, size, write, ret_ip);
>  }
>
> +bool check_invalid_free(void *addr)
> +{
> +       s8 shadow_byte =3D READ_ONCE(*(s8 *)kasan_mem_to_shadow(addr));
> +
> +       return shadow_byte < 0 || shadow_byte >=3D KASAN_GRANULE_SIZE;
> +}
> +
>  void kasan_cache_shrink(struct kmem_cache *cache)
>  {
>         quarantine_remove_cache(cache);
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 1865bb92d47a..3eff57e71ff5 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -164,6 +164,8 @@ void kasan_poison_memory(const void *address, size_t =
size, u8 value);
>  bool check_memory_region(unsigned long addr, size_t size, bool write,
>                                 unsigned long ret_ip);
>
> +bool check_invalid_free(void *addr);
> +
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>
> diff --git a/mm/kasan/sw_tags.c b/mm/kasan/sw_tags.c
> index 4bdd7dbd6647..b2638c2cd58a 100644
> --- a/mm/kasan/sw_tags.c
> +++ b/mm/kasan/sw_tags.c
> @@ -121,6 +121,15 @@ bool check_memory_region(unsigned long addr, size_t =
size, bool write,
>         return true;
>  }
>
> +bool check_invalid_free(void *addr)
> +{
> +       u8 tag =3D get_tag(addr);
> +       u8 shadow_byte =3D READ_ONCE(*(u8 *)kasan_mem_to_shadow(reset_tag=
(addr)));
> +
> +       return (shadow_byte =3D=3D KASAN_TAG_INVALID) ||
> +               (tag !=3D KASAN_TAG_KERNEL && tag !=3D shadow_byte);
> +}
> +
>  #define DEFINE_HWASAN_LOAD_STORE(size)                                 \
>         void __hwasan_load##size##_noabort(unsigned long addr)          \
>         {                                                               \
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
