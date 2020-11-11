Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27422AF353
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKKOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKKOPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:15:21 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:15:20 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id v143so1753551qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UkBccG0kAG6ptvne6HOJOUn3nzbGkGD7oWbn2QDoT/s=;
        b=JqgXE+q+00P9Y1z90FNa74Dsyd6Cxp1hRSPb3NykRt/kjD1VZpRDyhinfVhTiLfKyV
         17UYy+lbjEZqPtJ3dAJMWb5Y8VmUpzCPchbsHFa5QuDtxCRilNQvGImE864dj39ZjYZg
         83CruSkbJwFsQi6BCkJHUMT0UzEPz0pwEcXqw4y8hraT0ajvm19A38jZLr+QuSjfbeFU
         lDi6s1hsAnt+oTGBc16nLH3zacHRIk4haa8/iXkGzZ5U69DBNtSpht5CyzWLA/XCDehz
         Unrl4hwdMdQm0vB0mdxGzkYnIydnXzwRKNz7scNbmu8PhJ49yYANg5TXXBJVKLuvj774
         Wjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UkBccG0kAG6ptvne6HOJOUn3nzbGkGD7oWbn2QDoT/s=;
        b=J3S3jk0EkcpL893b54KyZd7I89ypFOdMg56PKY4opPOJWtbZ9XVn57vb8Gv/XrEZMZ
         eOamnL3moUP0t+0vQOBeKTlSmOOOMJICTS9kGHV/KQoPpvxz0zU4B0Z31nbBf7T5w0Gq
         eUXjraT4I0QtDjUCU1hKf0/SSQSbr5mkGqxSfuAqHsOQ2mLValLfULgbk/a+2esaX8pS
         wc1vJQVyOCQQrJnj7BeGLAh8AFNFwstfbCW+fyFYHReJs/k3CCLoNK4clDTP6DTA0Phg
         +0ZAv4gjWyU+w5He+z8IZfwMJINYe/oJ9VUe0IYYwYRgrk5Rewzzj/iiAw+j5tDenxY+
         2IfA==
X-Gm-Message-State: AOAM533gLACh50zrZSYKwysMQFNk/qXeeUT5Jx2d1lIlp3egDa2+7lEE
        jB7o1kmlN6QEGuv0nqfa/H6rANbj6EMKdDGESfmM5g==
X-Google-Smtp-Source: ABdhPJxss+SD9uXirC0ROcyc6x5toqLCMrF+hoA1k8PUQ4YaZqCR3gQKgTS2hXBC5pD0sbFNPh9jEEQVsORw1SK8F0k=
X-Received: by 2002:a37:4552:: with SMTP id s79mr19121371qka.6.1605104119855;
 Wed, 11 Nov 2020 06:15:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <37a9648ffa16572583a7513323cc9be88a726eb1.1605046192.git.andreyknvl@google.com>
In-Reply-To: <37a9648ffa16572583a7513323cc9be88a726eb1.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 15:15:08 +0100
Message-ID: <CAG_fn=WgBr=NxYTiPGq=0HADk5e=RO3BS-OTxVVT4w=pOKu_uA@mail.gmail.com>
Subject: Re: [PATCH v9 11/44] kasan: rename report and tags files
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
> Rename generic_report.c to report_generic.c and tags_report.c to
> report_sw_tags.c, as their content is more relevant to report.c file.
> Also rename tags.c to sw_tags.c to better reflect that this file contains
> code for software tag-based mode.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: If77d21f655d52ef3e58c4c37fd6621a07f505f18
> ---
>  mm/kasan/Makefile                               | 16 ++++++++--------
>  mm/kasan/report.c                               |  2 +-
>  mm/kasan/{generic_report.c =3D> report_generic.c} |  0
>  mm/kasan/{tags_report.c =3D> report_sw_tags.c}    |  0
>  mm/kasan/{tags.c =3D> sw_tags.c}                  |  0
>  5 files changed, 9 insertions(+), 9 deletions(-)
>  rename mm/kasan/{generic_report.c =3D> report_generic.c} (100%)
>  rename mm/kasan/{tags_report.c =3D> report_sw_tags.c} (100%)
>  rename mm/kasan/{tags.c =3D> sw_tags.c} (100%)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 7cc1031e1ef8..f1d68a34f3c9 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -6,13 +6,13 @@ KCOV_INSTRUMENT :=3D n
>  # Disable ftrace to avoid recursion.
>  CFLAGS_REMOVE_common.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_generic.o =3D $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_generic_report.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_init.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_quarantine.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_report.o =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report_generic.o =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_report_sw_tags.o =3D $(CC_FLAGS_FTRACE)
>  CFLAGS_REMOVE_shadow.o =3D $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_tags.o =3D $(CC_FLAGS_FTRACE)
> -CFLAGS_REMOVE_tags_report.o =3D $(CC_FLAGS_FTRACE)
> +CFLAGS_REMOVE_sw_tags.o =3D $(CC_FLAGS_FTRACE)
>
>  # Function splitter causes unnecessary splits in __asan_load1/__asan_sto=
re1
>  # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D63533
> @@ -23,14 +23,14 @@ CC_FLAGS_KASAN_RUNTIME +=3D -DDISABLE_BRANCH_PROFILIN=
G
>
>  CFLAGS_common.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_generic.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> -CFLAGS_generic_report.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_init.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_quarantine.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_report.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_report_generic.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_report_sw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_shadow.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> -CFLAGS_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> -CFLAGS_tags_report.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
> +CFLAGS_sw_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>
>  obj-$(CONFIG_KASAN) :=3D common.o report.o
> -obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o generic_report.o shado=
w.o quarantine.o
> -obj-$(CONFIG_KASAN_SW_TAGS) +=3D init.o shadow.o tags.o tags_report.o
> +obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o report_generic.o shado=
w.o quarantine.o
> +obj-$(CONFIG_KASAN_SW_TAGS) +=3D init.o report_sw_tags.o shadow.o sw_tag=
s.o
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 7b8dcb799a78..fff0c7befbfe 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file contains common generic and tag-based KASAN error reporting=
 code.
> + * This file contains common KASAN error reporting code.
>   *
>   * Copyright (c) 2014 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/report_generic.c
> similarity index 100%
> rename from mm/kasan/generic_report.c
> rename to mm/kasan/report_generic.c
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/report_sw_tags.c
> similarity index 100%
> rename from mm/kasan/tags_report.c
> rename to mm/kasan/report_sw_tags.c
> diff --git a/mm/kasan/tags.c b/mm/kasan/sw_tags.c
> similarity index 100%
> rename from mm/kasan/tags.c
> rename to mm/kasan/sw_tags.c
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
