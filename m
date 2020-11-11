Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41FA2AF5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgKKQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgKKQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:11:02 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A3C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:11:02 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b16so1399387qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=225dH83D48RrYMdcBweixtFsm7zoRRCV87kzdcWWgZw=;
        b=EyFkI0AP0amRkumU51nrztnLa9GiB9YufpOXcE1f4qID1vC9kgrza35k5Nho8yRDRL
         uqeaddWMgvidmrVAblzBJ0RmJICeeR6olwF5w3Hpqmj7sDSg/SKLg5PHkZaFMmkJmeHu
         lidCeiLmJL7g3mQ3/Gn0WghBqmSD75mcPEHSwwZCpSOF8o4MTIFMHxcLOLiJvAfVWSoP
         tY9POrER0u0kiEcuqFdKrQ185ZxS89sdeDVhr2xkQyze+chNRvW1zjNI2WXm63uv54ds
         uwANYaznp9hMHVSqITVlH57hwZw9P3LQT5kagm9ctNvzpSZ9ziQ1mLJ1H70UK48TtQJc
         uiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=225dH83D48RrYMdcBweixtFsm7zoRRCV87kzdcWWgZw=;
        b=f3mxk8SCQW+CT4slGZfuiW5P0ldkAVt/cP/qGx/8nN8lXHstpfH6XWI22zpyAdpQjQ
         1RVEgZkUDcreUXQi3uKuAtJeWXInEpkBrX27hZ+GYVSOS/kkAHU9UKqZIiJrDYXnccK1
         6lRxDDLa2Lg1vY+9witCKBonCBn62r438ztibti4AltB5Xv77XU+hifDewuzTMD+J1bX
         qiyHIiWplN8feiZtIY+00pW6qZJnadJ0S+GgaZyBYvRg5xkDZYkcvDVR0MPQFrbxKHDV
         z8m3+0MRCVxiUBXogFc/99bpQnRwyPstwwu+9s8GQV/YEyY1wyy1bND17glO5GVo9Ba2
         nkug==
X-Gm-Message-State: AOAM530lEQyCBicLB0G4vcmKHoxzFLzug/Gk3KrwOIGFNsZOyptlG6XC
        McCeINjgxqGVB9NmGfl9TxPwHIYb+yVUNuDsU61I7Q==
X-Google-Smtp-Source: ABdhPJwTzo1m2Sr8laF/CiEBGPM3ZdbGWEO7fIU3/m6+DyFx6UPYO65RiP1CyS7CC7n3IMLpMXRZK7arGblHtec79fg=
X-Received: by 2002:ac8:5c85:: with SMTP id r5mr19357172qta.8.1605111060119;
 Wed, 11 Nov 2020 08:11:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <76b91f88120fc8c3e5923d6432a1d537ee584fc8.1605046192.git.andreyknvl@google.com>
In-Reply-To: <76b91f88120fc8c3e5923d6432a1d537ee584fc8.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:10:48 +0100
Message-ID: <CAG_fn=XnPQCyzJXp1YtM0swhzr2W89yMxe5FkFL6n0vAOeBoYw@mail.gmail.com>
Subject: Re: [PATCH v9 34/44] arm64: kasan: Align allocations for HW_TAGS
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
> Hardware tag-based KASAN uses the memory tagging approach, which requires
> all allocations to be aligned to the memory granule size. Align the
> allocations to MTE_GRANULE_SIZE via ARCH_SLAB_MINALIGN when
> CONFIG_KASAN_HW_TAGS is enabled.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I51ebd3f9645e6330e5a92973bf7c86b62d632c2b
> ---
>  arch/arm64/include/asm/cache.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cach=
e.h
> index 63d43b5f82f6..77cbbe3625f2 100644
> --- a/arch/arm64/include/asm/cache.h
> +++ b/arch/arm64/include/asm/cache.h
> @@ -6,6 +6,7 @@
>  #define __ASM_CACHE_H
>
>  #include <asm/cputype.h>
> +#include <asm/mte-kasan.h>
>
>  #define CTR_L1IP_SHIFT         14
>  #define CTR_L1IP_MASK          3
> @@ -51,6 +52,8 @@
>
>  #ifdef CONFIG_KASAN_SW_TAGS
>  #define ARCH_SLAB_MINALIGN     (1ULL << KASAN_SHADOW_SCALE_SHIFT)
> +#elif defined(CONFIG_KASAN_HW_TAGS)
> +#define ARCH_SLAB_MINALIGN     MTE_GRANULE_SIZE
>  #endif
>
>  #ifndef __ASSEMBLY__
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
