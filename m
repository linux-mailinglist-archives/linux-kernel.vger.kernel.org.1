Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3655C2AF6E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKKQtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgKKQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:49:31 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4F3C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:49:30 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id h12so1716692qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dHIwVHj/jWzL1sw9rtjN4XGVp52gznrPRFC4/UO5JAw=;
        b=AJNMeYOadlwPEbynoTiRoaaQWQJ/rV90P8nJoz2vES0fiWAtYdQ4P+Rt8ICZaIia/o
         QOKWxRfxaK2rjzkAgQnAaP6YMT/Epnq21X02HLJvpiYD3L29wfdF2OokoQrcBTjoIJi/
         zUqFXdNjznrtGYxpf+E8wDMkr0nfI1FhMVeJ0dEGKy/HPQ3Dm0moxtytGE+i5Y2FD8N2
         Jo66Qa+GshupEM/kKi31gd/wKBPlnhsFRZVvgSu1QIDNR1Tsa7B5rsKgQbvsiCS4kot0
         09CIX7DTJW4gj/tQ5P1gjfJN17/WBMivswgac0Suw9jAU6Mze30RxcCysNPPEA+CBF1B
         kKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dHIwVHj/jWzL1sw9rtjN4XGVp52gznrPRFC4/UO5JAw=;
        b=FD+RwADe7ECXmNLpED4AwAkP4cQCDsc6d2Erh65HopbOO4jMSL7JAFqVDn4ED3SQPM
         bf5xwBWel03OXvPZvPk2YFMP5k99TFWOZ/sBWo0t2zGMIYfhlinT4qf/2Mgvu/D7LhhX
         IzrDCdfsH3qAF2zJuWB6dBPiynhDKQgrKi2N44D/D1oeGrF0b3rNZoNL8AupA6+E7JSB
         xg5x38d/vjtx3wM41U4zwDMXsXlkanidyDtDTOcHX08BSvsRFBcMJNUnusI5jvxDetvQ
         aSFjmoFcFbXhvogCDwK2mUR2Hu3JHV/g4JKulFxE3bonZNANMEBVls1niQZLwkWSJTj0
         aucA==
X-Gm-Message-State: AOAM530Oi7IzNHfTuMAo95+P0Lcsz5GQYE94fkDiuDavFb2Tszlg8p+O
        S/RR41wqpVc7KDY7iuRPHKke5eXMUSrscBosMpY81A==
X-Google-Smtp-Source: ABdhPJwjig6fpjowOP840jmc+kQ2gIR1Dy5LX8/g2T53j3ea4lFOAg5xbJv3X2ZJnClMIqG6zhTVgzInEwS8twOLruQ=
X-Received: by 2002:ac8:454d:: with SMTP id z13mr21816261qtn.175.1605113369540;
 Wed, 11 Nov 2020 08:49:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605046192.git.andreyknvl@google.com> <3d24722ca600b65a186a55ae47777a00a7c9407c.1605046192.git.andreyknvl@google.com>
In-Reply-To: <3d24722ca600b65a186a55ae47777a00a7c9407c.1605046192.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 11 Nov 2020 17:49:17 +0100
Message-ID: <CAG_fn=XsoJeoYQvO4vi2W0RyxnwBQ5N=wcaRD84OEZy2+Gxtbw@mail.gmail.com>
Subject: Re: [PATCH v9 42/44] kasan, arm64: enable CONFIG_KASAN_HW_TAGS
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
> Hardware tag-based KASAN is now ready, enable the configuration option.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

> ---
> Change-Id: I6eb1eea770e6b61ad71c701231b8d815a7ccc853
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 456741645f01..c35e73efd407 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -135,6 +135,7 @@ config ARM64
>         select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN if !(ARM64_16K_PAGES && ARM64_VA_BITS_48)
>         select HAVE_ARCH_KASAN_SW_TAGS if (HAVE_ARCH_KASAN && !ARM64_MTE)
> +       select HAVE_ARCH_KASAN_HW_TAGS if (HAVE_ARCH_KASAN && ARM64_MTE)
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_MMAP_RND_BITS
>         select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
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
