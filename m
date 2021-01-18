Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE302F9D35
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389477AbhARKvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389819AbhARK3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:29:12 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84C9C061786
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:28:17 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e17so1769407qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/TkzcR6kWeiv6t4IoqwMwIdTH7b0PFudFxRU7qciUjA=;
        b=DROzjAF/QDbj0tr+au8yUVh8IsGBdQALoMrUzGGAjnsbAIG601LX1NKeK0DGQeFlfC
         KFUnLTXRwPQ+BsYNICcqEFxf6IdGCrrF/bO3qFV+UlGCGh1DBPLPbhqHoEEZqEWws5N9
         VHn6GEkFXRB8DJmCJ6qLxelY9kemc9C7zO57IURj1IUwnDeOArbb+wftAyOzxwy0mhXW
         szjEAVY3sGoXTWyC4mhtkf8AqikT9ZC4RPaXJUsgWnlRbgw3sFmKkFkKiOxRzczAfoLx
         Eqb8tV/ZTB2KbdmeRJfOr25QvJe1MMa1MQNSW6dUG2c56VtJDkruQlzHcGrgGUmxLnuN
         1/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/TkzcR6kWeiv6t4IoqwMwIdTH7b0PFudFxRU7qciUjA=;
        b=t3mv5P0jMn3P7JdyfbArQQXVa54VNR5gUwPdzmuhwDF3nbkRAfEYHo6qBLukqaakKn
         2G5akRoCJhgyFqawberuQt8ziEYzn17JTht6xJdA+BkuQDdYs9ngYc3IZPk4rhlB4juI
         alfEu7iyPmD5aqWGMvGw3DOKAfD17LxR6/gDq9myeMAQcxwC2968Y3Jtb6yALDb26R9J
         nByC+glAnFWFFKSoRdxNkLJvAGGWF+nHjcm3Tm2atvbM/ewQq5m2/4lEeYoRpmgwuU0U
         N11Ad03fD/fFqFGgq9DYvEyRRrGE17u/IvYbKOa98RzWxLjHxh9UEGq95a/sfwG2ZCBq
         oX1A==
X-Gm-Message-State: AOAM532YVMunG+LQZh7tRsggTb99LZaaUhLeAG8qb6Td3KiTRSeeOZfK
        XbV/rOGR1vfjt+phYj5E4+JqnH62KCXrN9hmOcQgDA==
X-Google-Smtp-Source: ABdhPJy9UVrXbeUYiMAsuNdsUca4XuVLWSbQ+G5mjrfOa30MUGTsoWYCcLjFFRwwOVX481hx0YNn4X6qLqhQrSHnZIY=
X-Received: by 2002:ac8:6cf:: with SMTP id j15mr22124864qth.180.1610965696933;
 Mon, 18 Jan 2021 02:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20210118092159.145934-1-elver@google.com>
In-Reply-To: <20210118092159.145934-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 18 Jan 2021 11:28:05 +0100
Message-ID: <CAG_fn=VDdRLmFaKDkrUk=evkQJDboMm50w6R53w2CWhNGz_o6g@mail.gmail.com>
Subject: Re: [PATCH mm 1/4] kfence: add missing copyright and description headers
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 10:22 AM Marco Elver <elver@google.com> wrote:
>
> Add missing copyright and description headers to KFENCE source files.
>
> Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
> ---
> If appropriate, to be squashed into:
>
>         mm: add Kernel Electric-Fence infrastructure
> ---
>  include/linux/kfence.h | 6 ++++++
>  mm/kfence/core.c       | 5 +++++
>  mm/kfence/kfence.h     | 6 ++++++
>  mm/kfence/report.c     | 5 +++++
>  4 files changed, 22 insertions(+)
>
> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> index c2c1dd100cba..a70d1ea03532 100644
> --- a/include/linux/kfence.h
> +++ b/include/linux/kfence.h
> @@ -1,4 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Kernel Electric-Fence (KFENCE). Public interface for allocator and fa=
ult
> + * handler integration. For more info see Documentation/dev-tools/kfence=
.rst.
> + *
> + * Copyright (C) 2020, Google LLC.
> + */
>
>  #ifndef _LINUX_KFENCE_H
>  #define _LINUX_KFENCE_H
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index a5f8aa410a30..cfe3d32ac5b7 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * KFENCE guarded object allocator and fault handling.
> + *
> + * Copyright (C) 2020, Google LLC.
> + */
>
>  #define pr_fmt(fmt) "kfence: " fmt
>
> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> index 97282fa77840..1accc840dbbe 100644
> --- a/mm/kfence/kfence.h
> +++ b/mm/kfence/kfence.h
> @@ -1,4 +1,10 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Kernel Electric-Fence (KFENCE). For more info please see
> + * Documentation/dev-tools/kfence.rst.
> + *
> + * Copyright (C) 2020, Google LLC.
> + */
>
>  #ifndef MM_KFENCE_KFENCE_H
>  #define MM_KFENCE_KFENCE_H
> diff --git a/mm/kfence/report.c b/mm/kfence/report.c
> index 1996295ae71d..901bd7ee83d8 100644
> --- a/mm/kfence/report.c
> +++ b/mm/kfence/report.c
> @@ -1,4 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
> +/*
> + * KFENCE reporting.
> + *
> + * Copyright (C) 2020, Google LLC.
> + */
>
>  #include <stdarg.h>
>
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
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
