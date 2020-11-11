Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FF72AF49A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgKKPS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgKKPS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:18:56 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878B6C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:18:56 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id h12so1487162qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3XxacOuX3QMvhk3diut0JoyxopS0EmCY/QAdadNPdVM=;
        b=gyKbCHEvMSsk8Irp2rXztZu1dowW4d7MJeILveQ2vZu+MGAuBTlLZZfmurmnsW0dq6
         Pz0stgrwWryX/EpsrWfAjlwofnpJz2zHTUwDOHUKOlKICRUt2SylO8mh3Ey8Saa19sgK
         wHd2/ZjLoWBU89By2001w9A8SlfNuPkoE+eE3vGcr8QrRlaPMNzcUhEYVvgjHPL/C0Y2
         33zdC9PFn1cQEL4CUAcHpbkIkvzTqAAS5r/+2oav9jUkzts6lpKmozQzOJ6G/JZTWrDz
         HRUm03gTixCRn89R0tWszQYcUPyHSTU+wHyyBrGL5DyRPyIrwyWTrB8B+poDKe7fiFzY
         Pkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3XxacOuX3QMvhk3diut0JoyxopS0EmCY/QAdadNPdVM=;
        b=ohWsEBNn98p7hyECPlxlfbMD1Hd9i0a1r2Jku/BM5Mx5Mfa1XufL3bFCbJjR0RwPnb
         Artm9PKBcpOwkqlko5pjfEDOvH0Uh1Ekrkjk0ekaZB/0vUM2vl5iXAHw7ME/EMoY7M8m
         onkvj5YsqueNzqEu3fb7xXLK5az1B6A/hSTrMPvy8ahQL7KfJI2fpehbOwD8FcEfWlIw
         exKJIQcHNJPpmOt5Ep3VK8zzCivzsgHysHcjHF6fobx7tsYXWgTraYzGJz630RO+XKJj
         a+QyZwTx3jr9oPp17f/tzKGPSUOSXFZ6fc2Vs1LhjYrazZ89sUUk5Kj2lwuYqdaL8wFl
         mSXg==
X-Gm-Message-State: AOAM530J+V0ZpyrvdERgiMK1sWp2w7QCBGK/XXn95JZGu2GYnl//IWlD
        8CvBWUXxWZWwy7vZKc4m4XS6KF5sGFXq5ZrLcZPUAg==
X-Google-Smtp-Source: ABdhPJzzTtpZKzryIB5iY91wMMpoKoaRlpfD/zhQ3TLmjx6u5ZGI+L4GdfLl8xeG2FfGSbieam7/2814RlEfmz8oxvg=
X-Received: by 2002:ac8:5c85:: with SMTP id r5mr19136944qta.8.1605107935487;
 Wed, 11 Nov 2020 07:18:55 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <f24f24cf8c75844531a01668b314aced88f5f3e1.1605046192.git.andreyknvl@google.com>
In-Reply-To: <f24f24cf8c75844531a01668b314aced88f5f3e1.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:18:43 +0100
Message-ID: <CAG_fn=UbOixaO_CZgNw8vqpzZJDdb5LFQgq3CWs7Shru4ZtJyg@mail.gmail.com>
Subject: Re: [PATCH v9 22/44] kasan: rename SHADOW layout macros to META
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
> This is a preparatory commit for the upcoming addition of a new hardware
> tag-based (MTE-based) KASAN mode.
>
> Hardware tag-based KASAN won't be using shadow memory, but will reuse
> these macros. Rename "SHADOW" to implementation-neutral "META".
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: Id2d836bf43b401bce1221cc06e745185f17b1cc
> ---
>  mm/kasan/report.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 594bad2a3a5e..8c588588c88f 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -33,11 +33,11 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> -/* Shadow layout customization. */
> -#define SHADOW_BYTES_PER_BLOCK 1
> -#define SHADOW_BLOCKS_PER_ROW 16
> -#define SHADOW_BYTES_PER_ROW (SHADOW_BLOCKS_PER_ROW * SHADOW_BYTES_PER_B=
LOCK)
> -#define SHADOW_ROWS_AROUND_ADDR 2
> +/* Metadata layout customization. */
> +#define META_BYTES_PER_BLOCK 1
> +#define META_BLOCKS_PER_ROW 16
> +#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> +#define META_ROWS_AROUND_ADDR 2
>
>  static unsigned long kasan_flags;
>
> @@ -240,7 +240,7 @@ static void print_address_description(void *addr, u8 =
tag)
>
>  static bool row_is_guilty(const void *row, const void *guilty)
>  {
> -       return (row <=3D guilty) && (guilty < row + SHADOW_BYTES_PER_ROW)=
;
> +       return (row <=3D guilty) && (guilty < row + META_BYTES_PER_ROW);
>  }
>
>  static int shadow_pointer_offset(const void *row, const void *shadow)
> @@ -249,7 +249,7 @@ static int shadow_pointer_offset(const void *row, con=
st void *shadow)
>          *    3 + (BITS_PER_LONG/8)*2 chars.
>          */
>         return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
> -               (shadow - row) / SHADOW_BYTES_PER_BLOCK + 1;
> +               (shadow - row) / META_BYTES_PER_BLOCK + 1;
>  }
>
>  static void print_memory_metadata(const void *addr)
> @@ -259,15 +259,15 @@ static void print_memory_metadata(const void *addr)
>         const void *shadow_row;
>
>         shadow_row =3D (void *)round_down((unsigned long)shadow,
> -                                       SHADOW_BYTES_PER_ROW)
> -               - SHADOW_ROWS_AROUND_ADDR * SHADOW_BYTES_PER_ROW;
> +                                       META_BYTES_PER_ROW)
> +               - META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
>
>         pr_err("Memory state around the buggy address:\n");
>
> -       for (i =3D -SHADOW_ROWS_AROUND_ADDR; i <=3D SHADOW_ROWS_AROUND_AD=
DR; i++) {
> +       for (i =3D -META_ROWS_AROUND_ADDR; i <=3D META_ROWS_AROUND_ADDR; =
i++) {
>                 const void *kaddr =3D kasan_shadow_to_mem(shadow_row);
>                 char buffer[4 + (BITS_PER_LONG/8)*2];
> -               char shadow_buf[SHADOW_BYTES_PER_ROW];
> +               char shadow_buf[META_BYTES_PER_ROW];
>
>                 snprintf(buffer, sizeof(buffer),
>                         (i =3D=3D 0) ? ">%px: " : " %px: ", kaddr);
> @@ -276,17 +276,17 @@ static void print_memory_metadata(const void *addr)
>                  * function, because generic functions may try to
>                  * access kasan mapping for the passed address.
>                  */
> -               memcpy(shadow_buf, shadow_row, SHADOW_BYTES_PER_ROW);
> +               memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
>                 print_hex_dump(KERN_ERR, buffer,
> -                       DUMP_PREFIX_NONE, SHADOW_BYTES_PER_ROW, 1,
> -                       shadow_buf, SHADOW_BYTES_PER_ROW, 0);
> +                       DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
> +                       shadow_buf, META_BYTES_PER_ROW, 0);
>
>                 if (row_is_guilty(shadow_row, shadow))
>                         pr_err("%*c\n",
>                                 shadow_pointer_offset(shadow_row, shadow)=
,
>                                 '^');
>
> -               shadow_row +=3D SHADOW_BYTES_PER_ROW;
> +               shadow_row +=3D META_BYTES_PER_ROW;
>         }
>  }
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
