Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E592AF4A5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgKKPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:22:18 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C92CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:22:18 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id n63so1513393qte.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qP4CSavCKNiU1+9udAKKC5xpzE+JMfMUoD8Vn5vSarA=;
        b=ZsqrL7UqboEVbmwb1xfP06XCTlfvvfqvOkGZL4UzWJZASDhQmvtBWdxbAYU6VsanQc
         PlSlhZDLGl1/w0TznIjmS0cegGpqDKu0U52bznh1/bCnTCDpV74hSoRkJGm98IlTnULw
         B/C8QeyZhA5qo6aq0PPIeisRzfDKYfi9sedlUw34GniGn4ivh9hv9MftjMPtMjVseSCY
         JMIT8sQqyEpCgEaG4l1j5+eoj9dJLct0Y2xbzKEpImLdM4aieKVuqs/IlxKBB727CLuP
         Cyvg5sLq6dcV1AmeZZlswu8M+AbUl/hP7LA7VhevaMQCxDYvAF/pfK5RyfSXg6n2qJ2S
         My3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qP4CSavCKNiU1+9udAKKC5xpzE+JMfMUoD8Vn5vSarA=;
        b=tE6M6wAh0At++Yi+5R1OGSwi282NJHfXB49hAW4CaVRXN24MtzExTBKNoCv7uJccQ+
         /a9wL0weLZcMVjiJy3HjK9yYkCXQ+yU4mh9DSoLYafPlEThExx5rOMy3wj2/tWCSyKtr
         4FuCBwqrcZa2pEyN3jn+exZym99zPILABbz8u6jx6Czo7WcGbkm0JooYTDqzt56V708J
         EuRvr2NAr0nttLIM3B43PDoZvop2xThbzt4H+hkRHWK1n3f2e0SNcNTrU8V9VjLcGCCq
         p5g2WW+pJgO7dEki+91IZS4OwWwPJCorkXSl4MOJMLGqL5a8YgHya9WuOjGxZ4aCt4N2
         E/Qw==
X-Gm-Message-State: AOAM531qV5RKrEKQRs2wx2wOMAjWVJQK2yuXjOhF6Tx/t4qHnAzCXPQm
        eYhbLmihfa2DTq0qge0TX36UhcKWZbRMK8JQi/h1tw==
X-Google-Smtp-Source: ABdhPJxiZxZyN0qQpD9W+/3tNiuAMbdabEcibaJ3sZTL/vTnOOPC8H4lZkBzg8XTxfiFAOjkwABI+I7VhIzvt8sfJjs=
X-Received: by 2002:ac8:5c85:: with SMTP id r5mr19151032qta.8.1605108137054;
 Wed, 11 Nov 2020 07:22:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <560e04850b62da4fd69caa92b4ce3bebf275ea59.1605046192.git.andreyknvl@google.com>
In-Reply-To: <560e04850b62da4fd69caa92b4ce3bebf275ea59.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 16:22:05 +0100
Message-ID: <CAG_fn=W-H8nHc_DmBOsnJOUygDJ+wg78K-QSY_wHTSHg-b8vFQ@mail.gmail.com>
Subject: Re: [PATCH v9 23/44] kasan: separate metadata_fetch_row for each mode
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
> Rework print_memory_metadata() to make it agnostic with regard to the
> way metadata is stored. Allow providing a separate metadata_fetch_row()
> implementation for each KASAN mode. Hardware tag-based KASAN will provide
> its own implementation that doesn't use shadow memory.
>
> No functional changes for software modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
> ---
> Change-Id: I5b0ed1d079ea776e620beca6a529a861e7dced95
> ---
>  mm/kasan/kasan.h          |  8 ++++++
>  mm/kasan/report.c         | 56 +++++++++++++++++++--------------------
>  mm/kasan/report_generic.c |  5 ++++
>  mm/kasan/report_sw_tags.c |  5 ++++
>  4 files changed, 45 insertions(+), 29 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index f9366dfd94c9..b5b00bff358f 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -57,6 +57,13 @@
>  #define KASAN_ABI_VERSION 1
>  #endif
>
> +/* Metadata layout customization. */
> +#define META_BYTES_PER_BLOCK 1
> +#define META_BLOCKS_PER_ROW 16
> +#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> +#define META_MEM_BYTES_PER_ROW (META_BYTES_PER_ROW * KASAN_GRANULE_SIZE)
> +#define META_ROWS_AROUND_ADDR 2
> +
>  struct kasan_access_info {
>         const void *access_addr;
>         const void *first_bad_addr;
> @@ -168,6 +175,7 @@ bool check_invalid_free(void *addr);
>
>  void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
> +void metadata_fetch_row(char *buffer, void *row);
>
>  #if defined(CONFIG_KASAN_GENERIC) && CONFIG_KASAN_STACK
>  void print_address_stack_frame(const void *addr);
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 8c588588c88f..8afc1a6ab202 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -33,12 +33,6 @@
>  #include "kasan.h"
>  #include "../slab.h"
>
> -/* Metadata layout customization. */
> -#define META_BYTES_PER_BLOCK 1
> -#define META_BLOCKS_PER_ROW 16
> -#define META_BYTES_PER_ROW (META_BLOCKS_PER_ROW * META_BYTES_PER_BLOCK)
> -#define META_ROWS_AROUND_ADDR 2
> -
>  static unsigned long kasan_flags;
>
>  #define KASAN_BIT_REPORTED     0
> @@ -238,55 +232,59 @@ static void print_address_description(void *addr, u=
8 tag)
>         print_address_stack_frame(addr);
>  }
>
> -static bool row_is_guilty(const void *row, const void *guilty)
> +static bool meta_row_is_guilty(const void *row, const void *addr)
>  {
> -       return (row <=3D guilty) && (guilty < row + META_BYTES_PER_ROW);
> +       return (row <=3D addr) && (addr < row + META_MEM_BYTES_PER_ROW);
>  }
>
> -static int shadow_pointer_offset(const void *row, const void *shadow)
> +static int meta_pointer_offset(const void *row, const void *addr)
>  {
> -       /* The length of ">ff00ff00ff00ff00: " is
> -        *    3 + (BITS_PER_LONG/8)*2 chars.
> +       /*
> +        * Memory state around the buggy address:
> +        *  ff00ff00ff00ff00: 00 00 00 05 fe fe fe fe fe fe fe fe fe fe f=
e fe
> +        *  ...
> +        *
> +        * The length of ">ff00ff00ff00ff00: " is
> +        *    3 + (BITS_PER_LONG / 8) * 2 chars.
> +        * The length of each granule metadata is 2 bytes
> +        *    plus 1 byte for space.
>          */
> -       return 3 + (BITS_PER_LONG/8)*2 + (shadow - row)*2 +
> -               (shadow - row) / META_BYTES_PER_BLOCK + 1;
> +       return 3 + (BITS_PER_LONG / 8) * 2 +
> +               (addr - row) / KASAN_GRANULE_SIZE * 3 + 1;
>  }
>
>  static void print_memory_metadata(const void *addr)
>  {
>         int i;
> -       const void *shadow =3D kasan_mem_to_shadow(addr);
> -       const void *shadow_row;
> +       void *row;
>
> -       shadow_row =3D (void *)round_down((unsigned long)shadow,
> -                                       META_BYTES_PER_ROW)
> -               - META_ROWS_AROUND_ADDR * META_BYTES_PER_ROW;
> +       row =3D (void *)round_down((unsigned long)addr, META_MEM_BYTES_PE=
R_ROW)
> +                       - META_ROWS_AROUND_ADDR * META_MEM_BYTES_PER_ROW;
>
>         pr_err("Memory state around the buggy address:\n");
>
>         for (i =3D -META_ROWS_AROUND_ADDR; i <=3D META_ROWS_AROUND_ADDR; =
i++) {
> -               const void *kaddr =3D kasan_shadow_to_mem(shadow_row);
> -               char buffer[4 + (BITS_PER_LONG/8)*2];
> -               char shadow_buf[META_BYTES_PER_ROW];
> +               char buffer[4 + (BITS_PER_LONG / 8) * 2];
> +               char metadata[META_BYTES_PER_ROW];
>
>                 snprintf(buffer, sizeof(buffer),
> -                       (i =3D=3D 0) ? ">%px: " : " %px: ", kaddr);
> +                               (i =3D=3D 0) ? ">%px: " : " %px: ", row);
> +
>                 /*
>                  * We should not pass a shadow pointer to generic
>                  * function, because generic functions may try to
>                  * access kasan mapping for the passed address.
>                  */
> -               memcpy(shadow_buf, shadow_row, META_BYTES_PER_ROW);
> +               metadata_fetch_row(&metadata[0], row);
> +
>                 print_hex_dump(KERN_ERR, buffer,
>                         DUMP_PREFIX_NONE, META_BYTES_PER_ROW, 1,
> -                       shadow_buf, META_BYTES_PER_ROW, 0);
> +                       metadata, META_BYTES_PER_ROW, 0);
>
> -               if (row_is_guilty(shadow_row, shadow))
> -                       pr_err("%*c\n",
> -                               shadow_pointer_offset(shadow_row, shadow)=
,
> -                               '^');
> +               if (meta_row_is_guilty(row, addr))
> +                       pr_err("%*c\n", meta_pointer_offset(row, addr), '=
^');
>
> -               shadow_row +=3D META_BYTES_PER_ROW;
> +               row +=3D META_MEM_BYTES_PER_ROW;
>         }
>  }
>
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 16ed550850e9..8a9c889872da 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -123,6 +123,11 @@ const char *get_bug_type(struct kasan_access_info *i=
nfo)
>         return get_wild_bug_type(info);
>  }
>
> +void metadata_fetch_row(char *buffer, void *row)
> +{
> +       memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);

I think it is important to use __memcpy() instead of memcpy() in KASAN
runtime to avoid calling instrumented code.

> +}
> +
>  #if CONFIG_KASAN_STACK
>  static bool __must_check tokenize_frame_descr(const char **frame_descr,
>                                               char *token, size_t max_tok=
_len,
> diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
> index c87d5a343b4e..add2dfe6169c 100644
> --- a/mm/kasan/report_sw_tags.c
> +++ b/mm/kasan/report_sw_tags.c
> @@ -80,6 +80,11 @@ void *find_first_bad_addr(void *addr, size_t size)
>         return p;
>  }
>
> +void metadata_fetch_row(char *buffer, void *row)
> +{
> +       memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);

Ditto.

> +}
> +
>  void print_tags(u8 addr_tag, const void *addr)
>  {
>         u8 *shadow =3D (u8 *)kasan_mem_to_shadow(addr);
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
