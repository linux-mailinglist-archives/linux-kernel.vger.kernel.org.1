Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B052AF364
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKKOUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:20:20 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9254BC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:20:19 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so1341667qtp.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JMEn4lYfqSDEvjbMdtc4A2bwMj+MmSPwjJgTPuD5gJo=;
        b=GFal+cQow0Qjk5lNhjw8e+r2OEerm1rZ9j6xJQ6wLclouuxb32+yaI/XHplYRS2V/L
         o+TghGBtQXi5k/Te+e3rvhVWgytv+U/4tkc/Z6ZQuFY45OBj1UNNOOpEbJKXTX8Yq4PE
         3+444ZuKPGJVPlEV3yaGkep9xaLi7U38YlIV7dIa79529Ei7sZGU+D0+ZomW4D0A91Qc
         lP47MamAEwOHaE65rE4mOUBEGPhhESSdKEoYcQhL3yk8ZI1a2NnP5CEOfwk7XOLA0PtT
         LnBvtjbcQA67qM9eMkJ+r2+/txTneMeeRHBoJ4wt0QreqSWgO/Kszjw4hCaNmhTATxMJ
         7tLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JMEn4lYfqSDEvjbMdtc4A2bwMj+MmSPwjJgTPuD5gJo=;
        b=JY17u1u49WOBDgeTqZIzB9qH6DLbnh9ET2l7A+lb2QcvRJP9Zs7T1fds7v8rZSAzQc
         +Myi+dUsAVwU9eKlHM43TWuen7PiR0FNmEQ9MCyq7ei0CafFm4E1NhLQg/aQ3ZJ/Luw0
         hm/xaVy+dJo4xK+eweSoC4smFk+Er/+9myQBW+bVvVz7E3He7XU0wTMmqAEdCQZ2CS/h
         1eZM43cvOIE0bBp/vaSyGmJLRB4VAi8KfZMlZJSXDJjcn5CBY2PF78tHJjLBgPL3jR3/
         dWVDQhE2dJnefASFWlY3jDPps1tvEv6cUy3PPcmNfhZxtQnExqe6KS5ATiJ3up5ixtYW
         kSJA==
X-Gm-Message-State: AOAM532YrSEyDJ5fHXjEySVnHbfxqBupyGvoDx7eUD71pZNPo/Yx26G7
        da878T00aVhgQReaw+qaZt5gznGGa781YK0DxmHSTw==
X-Google-Smtp-Source: ABdhPJxsl2FT8v0gKKSfiyzq0nZ+AM/YBVaPtxAlOvp8/Vl46KzKhLZ8b9e2SozNu96fbbuuensy8LjfPhdlu9XC6yk=
X-Received: by 2002:ac8:5c85:: with SMTP id r5mr18883719qta.8.1605104418550;
 Wed, 11 Nov 2020 06:20:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <fc3f94183e4229363d0a891abc791af5b85d20f7.1605046192.git.andreyknvl@google.com>
In-Reply-To: <fc3f94183e4229363d0a891abc791af5b85d20f7.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 15:20:07 +0100
Message-ID: <CAG_fn=Vojbt7Cqb=oiEsda1f4RpUXmfR7Pd38Tiadk1Vy2-uQQ@mail.gmail.com>
Subject: Re: [PATCH v9 12/44] kasan: don't duplicate config dependencies
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
> Both KASAN_GENERIC and KASAN_SW_TAGS have common dependencies, move
> those to KASAN.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I77e475802e8f1750b9154fe4a6e6da4456054fcd
> ---
>  lib/Kconfig.kasan | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 8f0742a0f23e..ec59a0e26d09 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -24,6 +24,8 @@ menuconfig KASAN
>                    (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
>         depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
>         depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
> +       select CONSTRUCTORS
> +       select STACKDEPOT
>         help
>           Enables KASAN (KernelAddressSANitizer) - runtime memory debugge=
r,
>           designed to find out-of-bounds accesses and use-after-free bugs=
.
> @@ -46,10 +48,7 @@ choice
>  config KASAN_GENERIC
>         bool "Generic mode"
>         depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
> -       depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
>         select SLUB_DEBUG if SLUB
> -       select CONSTRUCTORS
> -       select STACKDEPOT
>         help
>           Enables generic KASAN mode.
>
> @@ -70,10 +69,7 @@ config KASAN_GENERIC
>  config KASAN_SW_TAGS
>         bool "Software tag-based mode"
>         depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
> -       depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
>         select SLUB_DEBUG if SLUB
> -       select CONSTRUCTORS
> -       select STACKDEPOT
>         help
>           Enables software tag-based KASAN mode.
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
