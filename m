Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E62F03CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 22:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbhAIV1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 16:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:27:01 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3EBC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 13:26:21 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so31586922lfc.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 13:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=spScs5BI5KiRRQrhecZKN4jkNwdDHtwVKRu7ZMdvkPQ=;
        b=XLT6s6rsCMercT6qkvbUhtp35zEHZrRmlL47aYyE6c14wSp3tUTSS7M/fAces2aleg
         ICuOhvvHeVQI5gtBKv5yFjo3hP0RyGTetvCTdq/pmScVPwoJahSt3DRJHPXSE9yB1nnD
         txjRsr51eIR4g1vQPU0W1Uta3p/u2tO8wN86Ha6HTth1DDR7+87Yb7oA7QgiivR5tsd8
         ETIcC7blbrazNWd2f6VbAdRWfKWfzYih7g/3b1U0smQUZzaMqZ2UTAq6lHptUHq0TJae
         5Fif2KRsK7F2F00AZtisWEUqV/TbwijcK9ZHIw9G3SjFk/dwfpFilHHlHU0xSbOaVlmu
         90Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=spScs5BI5KiRRQrhecZKN4jkNwdDHtwVKRu7ZMdvkPQ=;
        b=dIfBDZzqBEbzjbgxnIPmZqxFZLqHFT/vi770lVnF+ou0cQxAvOWaAPE1NJzP3pqM7a
         Urgu7yRi/bLHDZPid1JpAy8FV+9ZfjGpiLakk5+yH05WQdc3ng67BqxsYRKxnWT9yBQ1
         auIhSosWWDl2mReZZo9B0/FT9C/etnHNt+iZGzI80suQlVeqtH/qKmXbPNTEOnvWLYIZ
         A/IMgsXN/MMYEt2/qHkxagiyWsu0vEnWa/MRTQQgD5TNtF3iviCGVYkCaFs6ePw6yFGx
         f3uUsb2ZScwknktxUuMId89/NRsyWWYgtjNEdfCHetGlHck0nxHoq4Zle/ANOF7Prfx6
         CPjQ==
X-Gm-Message-State: AOAM533ysnrwCBrZ325BHdmv1WBTro+iKgxb4KsXGjVGCRu51/llJ8cc
        AKlLKUHf2td0ES6fFt7/W4Kuf+StE2ddgASiRHKeIw==
X-Google-Smtp-Source: ABdhPJwMMwVLVu0j0Nvz+H/adawTsmdnEhz93v3RChjdhFXmLqXyARbCvh+/qihWD88k1tp1QcVZgSA+vyX4k6yPxQo=
X-Received: by 2002:a05:6512:74e:: with SMTP id c14mr4610942lfs.529.1610227579697;
 Sat, 09 Jan 2021 13:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20210109044622.8312-1-hailongliiu@yeah.net>
In-Reply-To: <20210109044622.8312-1-hailongliiu@yeah.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Jan 2021 22:26:08 +0100
Message-ID: <CACRpkdb73diprma9Z1-4nm5A9OTQMeGVK=Hcqiwny9VOVdA=QQ@mail.gmail.com>
Subject: Re: [PATCH] arm/kasan:fix the arry size of kasan_early_shadow_pte
To:     Hailong liu <hailongliiu@yeah.net>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ziliang Guo <guo.ziliang@zte.com.cn>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        Russell King <linux@armlinux.org.uk>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 5:51 AM Hailong liu <hailongliiu@yeah.net> wrote:

> From: Hailong Liu <liu.hailong6@zte.com.cn>
>
> The size of kasan_early_shadow_pte[] now is PTRS_PER_PTE which defined to
> 512 for arm architecture. This means that it only covers the prev Linux p=
te
> entries, but not the HWTABLE pte entries for arm.
>
> The reason it works well current is that the symbol kasan_early_shadow_pa=
ge
> immediately following kasan_early_shadow_pte in memory is page aligned,
> which makes kasan_early_shadow_pte look like a 4KB size array. But we can=
't
> ensure the order always right with different compiler/linker, nor more bs=
s
> symbols be introduced.
>
> We had a test with QEMU + vexpress=EF=BC=9Aput a 512KB-size symbol with a=
ttribute
> __section(".bss..page_aligned") after kasan_early_shadow_pte, and poison =
it
> after kasan_early_init(). Then enabled CONFIG_KASAN, it failed to boot up=
.
>
> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> Signed-off-by: Ziliang Guo <guo.ziliang@zte.com.cn>

OK I see the problem, I think.

> +#ifndef PTE_HWTABLE_PTRS
> +#define PTE_HWTABLE_PTRS 0
> +#endif

Can this even happen? We have either pgtable-2level.h or
pgtable-3level.h, both of which define PTE_HWTABLE_PTRS.

>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> -extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
> +extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS];

Yeah this looks exactly like bm_pte so it makes sense.

If you drop the first ifndef,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
