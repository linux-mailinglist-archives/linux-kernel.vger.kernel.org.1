Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08FE2AF273
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKKNrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgKKNrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:47:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC3EC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:47:05 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id v143so1659050qkb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 05:47:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=abCIw+qBhh3O/GScLoUzmdV0ZiAv0OKYISMWyJ4sHI4=;
        b=rNZcWRwL9mTjmRWoW9+EkwOek121ELpD51EGPKO35FU0gWhrEfsH+mZA8MeQSvqt7e
         IBV/RoD2WvmP7SwwIVTVcqtd0jlhkY1Xi2HcYkH5lvduBiELxUIT2eYCe1PcfEP1OAoj
         1J964okltZG93sktyIDgSU2YUfwP6RpGRGJCOTsDio3f7bghim2NNE0SIszNzrqA9AkN
         o70a5yomTtwDPU2EWZsOJN6selh4ENTfwejmP5dk/Yk7WPRvqBioznGwp3ZuEs7uYne9
         ZKGHRhmu7UDjKXv5pbXXUQqFoaxYJj0Am2Zq7534MdqiwuieNql06nS0w1r+MNWzfXNe
         q/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=abCIw+qBhh3O/GScLoUzmdV0ZiAv0OKYISMWyJ4sHI4=;
        b=PGtT4vqnSTb3qhFYmGWRqO/o1LeOfa8dGsspoFwrmfbQn5Lmnfr4jRYmob/Bk/+Hdd
         fa/7zXo3Zr75jeC7iVn70yVfVwSeWN0eu7btYUVth6/xu9Wo0pS4iNmSNq3ph8+hnTS+
         xjOndZUgkLIPdf4fHYn5vgI5QdfrmWR2+j94kP6bdppQXz9dDa0STMvnSRjumXViPSxY
         SA708TB+Wrjbof4IZVcq5xViWM0HaWFUI2xHb2NEd4EP+x6Zkgynw+t9uSepjK1W3YsV
         NpVYnlaPXULaXGDSO9i2pXlPkwa8vX7pnv31qyKn3N6VxI3PmEzxisaABDvzyEdFtZSe
         i/hw==
X-Gm-Message-State: AOAM5308nqhRfeHkDrdtV6oALZiMyiy6OmRS50xvTMJRa6jg6tS7FuSO
        LcRIBzx8CtcGYFwi7O7Pf7vUIH6okFFX/vAnTzz5Pw==
X-Google-Smtp-Source: ABdhPJwzYc+pIoGR4ZubW9Q4+Ha7fE4IW8pakoJT+AEbfB6XEZOA+xub6Z121AEU6QI1xHbYigGHmJyHFSuw4ViNuu0=
X-Received: by 2002:a05:620a:211b:: with SMTP id l27mr1923525qkl.352.1605102424991;
 Wed, 11 Nov 2020 05:47:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <8f1316319d050f2019e03dac28a37ce1dd5206db.1605046192.git.andreyknvl@google.com>
In-Reply-To: <8f1316319d050f2019e03dac28a37ce1dd5206db.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 14:46:53 +0100
Message-ID: <CAG_fn=WsQmcmw2tEY5hdZuCXXWHDoFb05r0BAGZt8BxUM4U2gQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/44] kasan: only build init.c for software modes
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
> The new mode won't be using shadow memory, so only build init.c that
> contains shadow initialization code for software modes.
>
> No functional changes for software modes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I8d68c47345afc1dbedadde738f34a874dcae5080
> ---
>  mm/kasan/Makefile | 6 +++---
>  mm/kasan/init.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
> index 370d970e5ab5..7cf685bb51bd 100644
> --- a/mm/kasan/Makefile
> +++ b/mm/kasan/Makefile
> @@ -29,6 +29,6 @@ CFLAGS_report.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_tags.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>  CFLAGS_tags_report.o :=3D $(CC_FLAGS_KASAN_RUNTIME)
>
> -obj-$(CONFIG_KASAN) :=3D common.o init.o report.o
> -obj-$(CONFIG_KASAN_GENERIC) +=3D generic.o generic_report.o quarantine.o
> -obj-$(CONFIG_KASAN_SW_TAGS) +=3D tags.o tags_report.o
> +obj-$(CONFIG_KASAN) :=3D common.o report.o
> +obj-$(CONFIG_KASAN_GENERIC) +=3D init.o generic.o generic_report.o quara=
ntine.o
> +obj-$(CONFIG_KASAN_SW_TAGS) +=3D init.o tags.o tags_report.o
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index dfddd6c39fe6..1a71eaa8c5f9 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * This file contains some kasan initialization code.
> + * This file contains KASAN shadow initialization code.
>   *
>   * Copyright (c) 2015 Samsung Electronics Co., Ltd.
>   * Author: Andrey Ryabinin <ryabinin.a.a@gmail.com>
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
