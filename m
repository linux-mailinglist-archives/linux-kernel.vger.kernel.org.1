Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA302AF1D2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgKKNQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgKKNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:16:55 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A82C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:16:54 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g15so1165016qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L3xr+vb4NAdkO7IgO4hF3798stqYlZQgH+r9DFyhSKI=;
        b=eUne43dOwThcY1eT22nN9xS1LV5kt7SKKeiSHoAaZ8gyxuGOurZlFEIUl5v5MiOVTS
         4YaD2LM32MhkIGwX7ncmce6DCtu5DAn7iy8f8/Kz5l4KKxO0yUD1Fd8JjJzdZB1pEU+G
         7ItmYdAgZV6bUGjJT9V+FNnWkl4rRNDm6H4JSH3PbZL9GMwtgiYcgGqPbTazBaGRi2Sd
         zsl297wPBFP90XOKwMiYCgtlZZM5jMyMNXth+N2IW3qmJzTXsB2CPa+XCqSHlUQLDwq7
         Wr6YSDpf7nd+MAiPnpDMWJNLvKYcLnND0obLXB7QqYtYq938abRV4Jk0idg5ObJGAF4/
         dO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L3xr+vb4NAdkO7IgO4hF3798stqYlZQgH+r9DFyhSKI=;
        b=aVWTtfC1K7jtPwR85nfOz91MVo6eZhQFghZAg8mDO4DOFDl8r9g7f0isF5/lA4ogKJ
         v6V6lFC6uOJ90ZX2p3j49//w1/Rwd2ZS8rb7yx35n1rbmzIgPLlK9K5vW87oUdoM+aI6
         Ys28gfZpf+cQ9W5qW1RhWj3323Pvu69xHFsHO2VMBL3gTMWKsT6vuSFUM40ljBFyeNXt
         0yu3XnRcA6IyGEruweK3UfvWoyjtycG6BdsNwu7yk8xqZetNEW5eG9BNqP4efGbarUba
         xFeVWkC865fdk+hnDsWa3seu+NFBG6+LI6dmLMSRDP4jsUj73LwFafCd0MKFQQtmiufg
         EUrw==
X-Gm-Message-State: AOAM5302bF6kWtu73bl4Sfw0Xw1v725yfL+uj3TaY3GQ2E8K39VrOWQ8
        RNQTRWi5EZ7aWX8GaHkYUvd5deyOvJDa3cprWq74Og==
X-Google-Smtp-Source: ABdhPJy7smipgiXSdxWNA+y+6xcb2bLcNBPMVXYgv6wMGlLD/Jc78u/uwBD20oY5Lq/1BzdluUgqkaqKRksQsDBgFeg=
X-Received: by 2002:ac8:364d:: with SMTP id n13mr2590612qtb.369.1605100613373;
 Wed, 11 Nov 2020 05:16:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <8cf064ae41eb86697bd3aff5adf6b546d05351c1.1605046192.git.andreyknvl@google.com>
In-Reply-To: <8cf064ae41eb86697bd3aff5adf6b546d05351c1.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 14:16:42 +0100
Message-ID: <CAG_fn=X-=eqBm6R5qrexxBhYvJAKFn3mFLvK6+89Gxz_sivACw@mail.gmail.com>
Subject: Re: [PATCH v9 01/44] kasan: drop unnecessary GPL text from comment headers
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
> Don't mention "GNU General Public License version 2" text explicitly,
> as it's already covered by the SPDX-License-Identifier.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: If0a2690042a2aa0fca70cea601ae9aabe72fa233
> ---
>  mm/kasan/common.c         |  5 -----
>  mm/kasan/generic.c        |  5 -----
>  mm/kasan/generic_report.c |  5 -----
>  mm/kasan/init.c           |  5 -----
>  mm/kasan/quarantine.c     | 10 ----------
>  mm/kasan/report.c         |  5 -----
>  mm/kasan/tags.c           |  5 -----
>  mm/kasan/tags_report.c    |  5 -----
>  8 files changed, 45 deletions(-)
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 950fd372a07e..33d863f55db1 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #include <linux/export.h>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index 248264b9cb76..37ccfadd3263 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/mm/kasan/generic_report.c b/mm/kasan/generic_report.c
> index a38c7a9e192a..6bb3f66992df 100644
> --- a/mm/kasan/generic_report.c
> +++ b/mm/kasan/generic_report.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #include <linux/bitops.h>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index fe6be0be1f76..9ce8cc5b8621 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -4,11 +4,6 @@
>   *
>   * Copyright (c) 2015 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #include <linux/memblock.h>
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 4c5375810449..580ff5610fc1 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -6,16 +6,6 @@
>   * Copyright (C) 2016 Google, Inc.
>   *
>   * Based on code by Dmitry Chernenkov.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * version 2 as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
>   */
>
>  #include <linux/gfp.h>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 00a53f1355ae..d500923abc8b 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #include <linux/bitops.h>
> diff --git a/mm/kasan/tags.c b/mm/kasan/tags.c
> index e02a36a51f42..5c8b08a25715 100644
> --- a/mm/kasan/tags.c
> +++ b/mm/kasan/tags.c
> @@ -4,11 +4,6 @@
>   *
>   * Copyright (c) 2018 Google, Inc.
>   * Author: Andrey Konovalov <andreyknvl@google.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> diff --git a/mm/kasan/tags_report.c b/mm/kasan/tags_report.c
> index bee43717d6f0..5f183501b871 100644
> --- a/mm/kasan/tags_report.c
> +++ b/mm/kasan/tags_report.c
> @@ -7,11 +7,6 @@
>   *
>   * Some code borrowed from https://github.com/xairy/kasan-prototype by
>   *        Andrey Konovalov <andreyknvl@gmail.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
>   */
>
>  #include <linux/bitops.h>
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
