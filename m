Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B702EFEB0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhAIIwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 03:52:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbhAIIwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 03:52:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF856239D4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 08:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610182291;
        bh=+3p0GPX6m/SLC0USc3LVqoMdRz5ohyAvww3paZyNaM0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N1uENVcJBphns04y0r8iPHenMcGCSGxN2k9fADy/mm3VqP8INDmAREFj+5sYmrfAq
         evzpFEIWjHaKH4RR1hVnGZhPV7dG+/TQK8tmyO6fbOZ0q6Ha6lbLQ96ydVytqBEn66
         A5zR1ci/un4TA3wtveJKa5E9ZDyLc+GxatDOZOLa1bcWDqlATocxQmeN+YTkMlETo7
         478tpyUrA6qptgMy5LT0kM4ZDPwI5PGHOTFnO13iGWLU5iVxEQDVD8hqfjhqtjw/R1
         WX/ENSU4DVz3+R4YA5QrxiJ+9A85LaTIbxrBQa0IB3wjBRo5ZThA153NMenRPJUaR7
         LcLyTCJhsnSXg==
Received: by mail-oi1-f173.google.com with SMTP id 15so14300375oix.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 00:51:31 -0800 (PST)
X-Gm-Message-State: AOAM532dyKo5gqaPn5/rEQP27ZBF2nJLNZ05yEI2aWEhuavYGjXALKS/
        pytPqyuy3MjIWN46Cg687g065L5fxnZYNp/ESo0=
X-Google-Smtp-Source: ABdhPJwdkMDJT75A5HtUk8+o57IPNQdLOmxnTI2NqZqtc0lMYbJUnqGk/J1ATi5vQU3dRL4svI+kve/p6ewZbGRtIPY=
X-Received: by 2002:aca:210f:: with SMTP id 15mr4645635oiz.174.1610182290984;
 Sat, 09 Jan 2021 00:51:30 -0800 (PST)
MIME-Version: 1.0
References: <20210109044622.8312-1-hailongliiu@yeah.net>
In-Reply-To: <20210109044622.8312-1-hailongliiu@yeah.net>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 9 Jan 2021 09:51:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGBo_EBg+SYRd_cwPwQRq1NmRwJNyV6vjMMgA_S7Yff=A@mail.gmail.com>
Message-ID: <CAMj1kXGBo_EBg+SYRd_cwPwQRq1NmRwJNyV6vjMMgA_S7Yff=A@mail.gmail.com>
Subject: Re: [PATCH] arm/kasan:fix the arry size of kasan_early_shadow_pte
To:     Hailong liu <hailongliiu@yeah.net>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ziliang Guo <guo.ziliang@zte.com.cn>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+ Linus)

On Sat, 9 Jan 2021 at 05:50, Hailong liu <hailongliiu@yeah.net> wrote:
>
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
> ---
>  include/linux/kasan.h | 6 +++++-
>  mm/kasan/init.c       | 3 ++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5e0655fb2a6f..fe1ae73ff8b5 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -35,8 +35,12 @@ struct kunit_kasan_expectation {
>  #define KASAN_SHADOW_INIT 0
>  #endif
>
> +#ifndef PTE_HWTABLE_PTRS
> +#define PTE_HWTABLE_PTRS 0
> +#endif
> +
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
> -extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
> +extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS];
>  extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
>  extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
>  extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index bc0ad208b3a7..7ca0b92d5886 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -64,7 +64,8 @@ static inline bool kasan_pmd_table(pud_t pud)
>         return false;
>  }
>  #endif
> -pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
> +pte_t kasan_early_shadow_pte[PTRS_PER_PTE + PTE_HWTABLE_PTRS]
> +       __page_aligned_bss;
>
>  static inline bool kasan_pte_table(pmd_t pmd)
>  {
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
