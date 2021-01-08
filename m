Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC082EF74E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbhAHS0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:26:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbhAHS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:26:34 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C4EC061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:25:54 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id q20so3487489pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0EAbk42/5hnLn57GbgtjDwqdHR3jfIYT2uMLmHPvJts=;
        b=GmQA0TK1/fTvWRYlbX8p4NPq4WB22Wg7Ywbvgze/EhfVQshxKbzRchG+vtkcGQuoef
         R1n3DPD6AwLpB0NZ6vsDh6tsbfOQdqPWqWbwLhZ2z9NFT2R93LSkpRXtt9ixq6WY6ZRM
         1WyDPU8zCGq4TLif15/bk4JUs6ujHJ25HFJydxDHv63V+iRTHSRGHeXVCB7uQH8q0+l1
         sopBNNW0T04cFEroSGKOLkgAjG/QP80skKIH3DiMsBocEd6MmwUik3QEgj51blSfLrw+
         kxI2d3CDwr0ony4tio4VgC0RbmYV7iTNwGvdKwsTV9hTMcXKx6gvb5g6x3Ne4JR787kN
         Iunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0EAbk42/5hnLn57GbgtjDwqdHR3jfIYT2uMLmHPvJts=;
        b=CHuDwqNNSbhN3iJ8geQXI5MzA1kMk+IgtRaKRYk9cXJk1AP9xlVxhM7DJ6BYTNFPNi
         8e6JCtbaNtudkt9PxcEBiAk66k+8vDy/5PM33h9iB/veZls12tbLeqqAmaVp0qiiW82y
         CCf0FRUJInmRs4C4teRCIiZfSV7Mo1XksmKQ+qWlsICd5zFGmY7vCnksgRcbjuNChsPJ
         EFuHJ1Ng3ldV5SneEbLf+eCO3AB7OeQ40iwsjdtbiFYwGxMxc08O+qHCQucD4WggbXt1
         LuQIf2gDlV01lZEPAftZdqB005hR9A3gKDWq+iFh3oyjhrcK1o45eW5lykWFP4WJhGmL
         m8Ow==
X-Gm-Message-State: AOAM531lIUBVhnKjuBQB8MaQvG+m2Yjh1BZwFmS95sj39MUDdKl6VEFg
        ynyhVJiV1sjzE632bAJtXWcLMj71DvpnaubAs0BBO2g5XpY=
X-Google-Smtp-Source: ABdhPJyIbSeQV6YmcwWirU9XjduVAgHbx7V4PDlg5rOhCznobe6ijBKgyvJ9t3YwNnsM4pixotFS5VtXnV7o52yaQTg=
X-Received: by 2002:a62:2585:0:b029:1ab:7fb7:b965 with SMTP id
 l127-20020a6225850000b02901ab7fb7b965mr4980449pfl.2.1610130353786; Fri, 08
 Jan 2021 10:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20210103135621.83129-1-lecopzer@gmail.com>
In-Reply-To: <20210103135621.83129-1-lecopzer@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 8 Jan 2021 19:25:42 +0100
Message-ID: <CAAeHK+z0+hWBFha8Upu7JN-_ruBopzUkNKgBoihUPt1w6k8auA@mail.gmail.com>
Subject: Re: [PATCH] kasan: fix unaligned address is unhandled in kasan_remove_zero_shadow
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Lecopzer Chen <lecopzer@gmail.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 2:56 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> During testing kasan_populate_early_shadow and kasan_remove_zero_shadow,
> if the shadow start and end address in kasan_remove_zero_shadow() is
> not aligned to PMD_SIZE, the remain unaligned PTE won't be removed.
>
> In the test case for kasan_remove_zero_shadow():
>     shadow_start: 0xffffffb802000000, shadow end: 0xffffffbfbe000000
>     3-level page table:
>       PUD_SIZE: 0x40000000 PMD_SIZE: 0x200000 PAGE_SIZE: 4K
> 0xffffffbf80000000 ~ 0xffffffbfbdf80000 will not be removed because
> in kasan_remove_pud_table(), kasan_pmd_table(*pud) is true but the
> next address is 0xffffffbfbdf80000 which is not aligned to PUD_SIZE.
>
> In the correct condition, this should fallback to the next level
> kasan_remove_pmd_table() but the condition flow always continue to skip
> the unaligned part.
>
> Fix by correcting the condition when next and addr are neither aligned.
>
> Fixes: 0207df4fa1a86 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
> Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
> ---
>  mm/kasan/init.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/mm/kasan/init.c b/mm/kasan/init.c
> index 67051cfae41c..ae9158f7501f 100644
> --- a/mm/kasan/init.c
> +++ b/mm/kasan/init.c
> @@ -372,9 +372,10 @@ static void kasan_remove_pmd_table(pmd_t *pmd, unsigned long addr,
>
>                 if (kasan_pte_table(*pmd)) {
>                         if (IS_ALIGNED(addr, PMD_SIZE) &&
> -                           IS_ALIGNED(next, PMD_SIZE))
> +                           IS_ALIGNED(next, PMD_SIZE)) {
>                                 pmd_clear(pmd);
> -                       continue;
> +                               continue;
> +                       }
>                 }
>                 pte = pte_offset_kernel(pmd, addr);
>                 kasan_remove_pte_table(pte, addr, next);
> @@ -397,9 +398,10 @@ static void kasan_remove_pud_table(pud_t *pud, unsigned long addr,
>
>                 if (kasan_pmd_table(*pud)) {
>                         if (IS_ALIGNED(addr, PUD_SIZE) &&
> -                           IS_ALIGNED(next, PUD_SIZE))
> +                           IS_ALIGNED(next, PUD_SIZE)) {
>                                 pud_clear(pud);
> -                       continue;
> +                               continue;
> +                       }
>                 }
>                 pmd = pmd_offset(pud, addr);
>                 pmd_base = pmd_offset(pud, 0);
> @@ -423,9 +425,10 @@ static void kasan_remove_p4d_table(p4d_t *p4d, unsigned long addr,
>
>                 if (kasan_pud_table(*p4d)) {
>                         if (IS_ALIGNED(addr, P4D_SIZE) &&
> -                           IS_ALIGNED(next, P4D_SIZE))
> +                           IS_ALIGNED(next, P4D_SIZE)) {
>                                 p4d_clear(p4d);
> -                       continue;
> +                               continue;
> +                       }
>                 }
>                 pud = pud_offset(p4d, addr);
>                 kasan_remove_pud_table(pud, addr, next);
> @@ -456,9 +459,10 @@ void kasan_remove_zero_shadow(void *start, unsigned long size)
>
>                 if (kasan_p4d_table(*pgd)) {
>                         if (IS_ALIGNED(addr, PGDIR_SIZE) &&
> -                           IS_ALIGNED(next, PGDIR_SIZE))
> +                           IS_ALIGNED(next, PGDIR_SIZE)) {
>                                 pgd_clear(pgd);
> -                       continue;
> +                               continue;
> +                       }
>                 }
>
>                 p4d = p4d_offset(pgd, addr);
> --
> 2.25.1

Andrey, could you please take a look at this change?

Thanks!
