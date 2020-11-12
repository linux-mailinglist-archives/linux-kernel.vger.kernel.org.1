Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7642B0995
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgKLQKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgKLQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:10:13 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F734C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:10:13 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h15so5682237qkl.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+3ppqmizYm8DpeBPL8i/N6SBpHLSBfkZuqB8tufUogw=;
        b=K9N+LydTs0kBOblpwDKh9mZ1qGhKQtnb7uvKuT6MmVyp+HQ1bKNNPHVFkpWmwxbg97
         XQ5Xv+8EQXl+W6nT3yrm+yZHkeuEFsj0le62/9dUItHsJm0pUaCcrJsBA2OKnz589IJU
         nvRM5poEdyHkpIMwvAyJ8RG7c3dMBGaCY1Y6QqZxMTq9SHDD4ul3HmJith96U2avjcdn
         /eEESFGMYakyBDXWEdVQ9hTN4sBvLDLE/XcGxkwKNYLWYj1wu1GEmDd226v7YqOAl6Kx
         D3eh8toITDf6jiQfZgajYp7NhWcwwBIu5G6E14l1caYq8xjAcoEeDDjxdL8XsNpPQuc3
         jt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+3ppqmizYm8DpeBPL8i/N6SBpHLSBfkZuqB8tufUogw=;
        b=AO1tQUIfbb9585gzTWPz4lEghFvSJ4rRHBWL8H3uTvTKo6aWCraXsPg2DEi+JSRnfJ
         VY8VgXKxARb5GCu7ASH1LF5BsU51+GUFuOW8FbLBFMCy/0TS8nB7mEJSnFXqPF3P4OnW
         GVYWyNfYVRKV2VSCEtMBWZrnpoU0NX88wOgw5riOjNCds6uhp8ZPVeHKPQD7GRb20T7r
         QCdkGV3v0i/Jt5FdDxj/KNvvTac8uz55tUnMDJ+z4Cyx45O+92LKJq+Dw2Dw88RpQseU
         OkXvUKEVSj4JTdn4CyqvAvZlwUQ7ir5qaemJmh9szzeI/5Lx/XFAtd2swfAqBKdE4HUX
         D9/g==
X-Gm-Message-State: AOAM532ZJzwAv/vAxjJUOGzgl1GmjC2SVbC5xRJ/GbHGFtncCfXAtRJN
        r9lwLLA288TGxcl+pLvOIKt9Obrpa/4aHHYGT+2a0Q==
X-Google-Smtp-Source: ABdhPJyNngKXEw8Eg5rU2fPzQTn4/pPGWxfQYeQ8gc7roGY7nCwBwDcgO8PnYOzeXDAgfb5tJj0WLVVVHu0HqmCQixI=
X-Received: by 2002:a37:bf04:: with SMTP id p4mr506714qkf.326.1605197412318;
 Thu, 12 Nov 2020 08:10:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <d0060171a76ace31b26fef1f2713da209099fb99.1605046192.git.andreyknvl@google.com>
In-Reply-To: <d0060171a76ace31b26fef1f2713da209099fb99.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 12 Nov 2020 17:10:00 +0100
Message-ID: <CAG_fn=VixcPo9fTcn0QSRLkFRsC+gcy-w=96BPEjMUc=e5fc_w@mail.gmail.com>
Subject: Re: [PATCH v9 41/44] kasan, mm: reset tags when accessing metadata
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

On Tue, Nov 10, 2020 at 11:12 PM Andrey Konovalov <andreyknvl@google.com> w=
rote:
>
> Kernel allocator code accesses metadata for slab objects, that may lie
> out-of-bounds of the object itself, or be accessed when an object is free=
d.
> Such accesses trigger tag faults and lead to false-positive reports with
> hardware tag-based KASAN.
>
> Software KASAN modes disable instrumentation for allocator code via
> KASAN_SANITIZE Makefile macro, and rely on kasan_enable/disable_current()
> annotations which are used to ignore KASAN reports.
>
> With hardware tag-based KASAN neither of those options are available, as
> it doesn't use compiler instrumetation, no tag faults are ignored, and MT=
E
> is disabled after the first one.
>
> Instead, reset tags when accessing metadata (currently only for SLUB).
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>


> ---
> Change-Id: I39f3c4d4f29299d4fbbda039bedf230db1c746fb
> ---
>  mm/page_alloc.c  |  4 +++-
>  mm/page_poison.c |  2 +-
>  mm/slub.c        | 29 ++++++++++++++++-------------
>  3 files changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 24b45261e2bd..f1648aee8d88 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1195,8 +1195,10 @@ static void kernel_init_free_pages(struct page *pa=
ge, int numpages)
>
>         /* s390's use of memset() could override KASAN redzones. */
>         kasan_disable_current();
> -       for (i =3D 0; i < numpages; i++)
> +       for (i =3D 0; i < numpages; i++) {
> +               page_kasan_tag_reset(page + i);
>                 clear_highpage(page + i);
> +       }
>         kasan_enable_current();
>  }
>
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index ae0482cded87..e6c994af7518 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -53,7 +53,7 @@ static void poison_page(struct page *page)
>
>         /* KASAN still think the page is in-use, so skip it. */
>         kasan_disable_current();
> -       memset(addr, PAGE_POISON, PAGE_SIZE);
> +       memset(kasan_reset_tag(addr), PAGE_POISON, PAGE_SIZE);
>         kasan_enable_current();
>         kunmap_atomic(addr);
>  }
> diff --git a/mm/slub.c b/mm/slub.c
> index b30be2385d1c..df2fd5b57df1 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -249,7 +249,7 @@ static inline void *freelist_ptr(const struct kmem_ca=
che *s, void *ptr,
>  {
>  #ifdef CONFIG_SLAB_FREELIST_HARDENED
>         /*
> -        * When CONFIG_KASAN_SW_TAGS is enabled, ptr_addr might be tagged=
.
> +        * When CONFIG_KASAN_SW/HW_TAGS is enabled, ptr_addr might be tag=
ged.
>          * Normally, this doesn't cause any issues, as both set_freepoint=
er()
>          * and get_freepointer() are called with a pointer with the same =
tag.
>          * However, there are some issues with CONFIG_SLUB_DEBUG code. Fo=
r
> @@ -275,6 +275,7 @@ static inline void *freelist_dereference(const struct=
 kmem_cache *s,
>
>  static inline void *get_freepointer(struct kmem_cache *s, void *object)
>  {
> +       object =3D kasan_reset_tag(object);
>         return freelist_dereference(s, object + s->offset);
>  }
>
> @@ -304,6 +305,7 @@ static inline void set_freepointer(struct kmem_cache =
*s, void *object, void *fp)
>         BUG_ON(object =3D=3D fp); /* naive detection of double free or co=
rruption */
>  #endif
>
> +       freeptr_addr =3D (unsigned long)kasan_reset_tag((void *)freeptr_a=
ddr);
>         *(void **)freeptr_addr =3D freelist_ptr(s, fp, freeptr_addr);
>  }
>
> @@ -538,8 +540,8 @@ static void print_section(char *level, char *text, u8=
 *addr,
>                           unsigned int length)
>  {
>         metadata_access_enable();
> -       print_hex_dump(level, text, DUMP_PREFIX_ADDRESS, 16, 1, addr,
> -                       length, 1);
> +       print_hex_dump(level, kasan_reset_tag(text), DUMP_PREFIX_ADDRESS,
> +                       16, 1, addr, length, 1);
>         metadata_access_disable();
>  }
>
> @@ -570,7 +572,7 @@ static struct track *get_track(struct kmem_cache *s, =
void *object,
>
>         p =3D object + get_info_end(s);
>
> -       return p + alloc;
> +       return kasan_reset_tag(p + alloc);
>  }
>
>  static void set_track(struct kmem_cache *s, void *object,
> @@ -583,7 +585,8 @@ static void set_track(struct kmem_cache *s, void *obj=
ect,
>                 unsigned int nr_entries;
>
>                 metadata_access_enable();
> -               nr_entries =3D stack_trace_save(p->addrs, TRACK_ADDRS_COU=
NT, 3);
> +               nr_entries =3D stack_trace_save(kasan_reset_tag(p->addrs)=
,
> +                                             TRACK_ADDRS_COUNT, 3);
>                 metadata_access_disable();
>
>                 if (nr_entries < TRACK_ADDRS_COUNT)
> @@ -747,7 +750,7 @@ static __printf(3, 4) void slab_err(struct kmem_cache=
 *s, struct page *page,
>
>  static void init_object(struct kmem_cache *s, void *object, u8 val)
>  {
> -       u8 *p =3D object;
> +       u8 *p =3D kasan_reset_tag(object);
>
>         if (s->flags & SLAB_RED_ZONE)
>                 memset(p - s->red_left_pad, val, s->red_left_pad);
> @@ -777,7 +780,7 @@ static int check_bytes_and_report(struct kmem_cache *=
s, struct page *page,
>         u8 *addr =3D page_address(page);
>
>         metadata_access_enable();
> -       fault =3D memchr_inv(start, value, bytes);
> +       fault =3D memchr_inv(kasan_reset_tag(start), value, bytes);
>         metadata_access_disable();
>         if (!fault)
>                 return 1;
> @@ -873,7 +876,7 @@ static int slab_pad_check(struct kmem_cache *s, struc=
t page *page)
>
>         pad =3D end - remainder;
>         metadata_access_enable();
> -       fault =3D memchr_inv(pad, POISON_INUSE, remainder);
> +       fault =3D memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainde=
r);
>         metadata_access_disable();
>         if (!fault)
>                 return 1;
> @@ -1118,7 +1121,7 @@ void setup_page_debug(struct kmem_cache *s, struct =
page *page, void *addr)
>                 return;
>
>         metadata_access_enable();
> -       memset(addr, POISON_INUSE, page_size(page));
> +       memset(kasan_reset_tag(addr), POISON_INUSE, page_size(page));
>         metadata_access_disable();
>  }
>
> @@ -1566,10 +1569,10 @@ static inline bool slab_free_freelist_hook(struct=
 kmem_cache *s,
>                          * Clear the object and the metadata, but don't t=
ouch
>                          * the redzone.
>                          */
> -                       memset(object, 0, s->object_size);
> +                       memset(kasan_reset_tag(object), 0, s->object_size=
);
>                         rsize =3D (s->flags & SLAB_RED_ZONE) ? s->red_lef=
t_pad
>                                                            : 0;
> -                       memset((char *)object + s->inuse, 0,
> +                       memset((char *)kasan_reset_tag(object) + s->inuse=
, 0,
>                                s->size - s->inuse - rsize);
>
>                 }
> @@ -2883,10 +2886,10 @@ static __always_inline void *slab_alloc_node(stru=
ct kmem_cache *s,
>                 stat(s, ALLOC_FASTPATH);
>         }
>
> -       maybe_wipe_obj_freeptr(s, object);
> +       maybe_wipe_obj_freeptr(s, kasan_reset_tag(object));
>
>         if (unlikely(slab_want_init_on_alloc(gfpflags, s)) && object)
> -               memset(object, 0, s->object_size);
> +               memset(kasan_reset_tag(object), 0, s->object_size);
>
>         slab_post_alloc_hook(s, objcg, gfpflags, 1, &object);
>
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
