Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD52FD840
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 19:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391972AbhATS3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 13:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404454AbhATSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 13:22:24 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30603C061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:21:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g3so12971484plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 10:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FztgeQYvJKPvTHinIajZixrVm6a1I7cVr2Glq2/9i0w=;
        b=W3T8XEhaf9K+imFAPKhIEnKr0YrjazEIOLw+UPe4a7fGB1/Do+hKikZcAFwT1jHsWx
         GaHsIeYD7mgWRT7wjIWkcdqwZv3UyveFeaH2M5smlNykayHg2L5iVlOi6/J+7gdKdQ+u
         WtYwBCeNxJDg5JF5Z8QSItox+v1lsKsD2iMg0GTsG/x2xt4S2+aL9EBrRMZeqDKA/WgB
         9mO8s6XRzYlf79ZxAKf/tT1oqVXb5Ar0J7a+MJO8QaUh4XAJAZ5zWEXvS7D7mt+EeNw2
         96X3RPYRwqzeDsTk1sKaja00yNT5CVkBxn0ZGzCUOhnDD/ICskkC5Yxl9+Jlq0ERnOZO
         zNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FztgeQYvJKPvTHinIajZixrVm6a1I7cVr2Glq2/9i0w=;
        b=BHZX18V65RDrZfuXoJuzjhdqMslEHDWKTTKZM+/UdV8dTD0wyjxLqfI89zOVPEA34t
         3yPSvKuHJMRPfY1/dih2R7pelusw+PV1tZ4C78DkAI95F0iHurmMdnu/QyMNx+ONI+bM
         9BlrY3P8kPL9RlJv1Rl+SdCrOmMDSoBgnECbLj/omOaixQzK4ufuO/j/BEu+Vex6Kl7h
         TeVUBlB8yNGNHP6/q/nSQAFRNyblPboImLnWXVjp8+XrdONss45u834a7xkxs6quhO+k
         Ml+YZy+KYNZQ8oNo6Qaskh57ZP8mk2HUhbMrNg6zNcp265xAa7RK4N36O/p4/RWcd9Uq
         /2dQ==
X-Gm-Message-State: AOAM530o+1Ap5Kkz09B0dzzsYwGlo5AlYWsy3hp7Pr9ApShwugr0d8Yj
        L4NQN6Q3/ryMVbaqu5fFhA0QSxJDht//1kS7mHNlMyePIJ3IQA==
X-Google-Smtp-Source: ABdhPJzNCwyPxlTxOcha/B3O+SRaZ+4OHivPiUcH3zrLFlzmALW91MKtuNsic/ILMnymXIm+/TCiRtc5HzfuxMQcIqg=
X-Received: by 2002:a17:902:9f87:b029:de:9e09:ee94 with SMTP id
 g7-20020a1709029f87b02900de9e09ee94mr11102200plq.29.1611166903481; Wed, 20
 Jan 2021 10:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20210120173612.20913-1-will@kernel.org> <20210120173612.20913-8-will@kernel.org>
In-Reply-To: <20210120173612.20913-8-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 Jan 2021 10:21:33 -0800
Message-ID: <CAKwvOdkqGy9O8yAnyeJO-P3WssRa1=OS=Q-T2ZV1vGwdwi=6+A@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] mm: Use static initialisers for immutable fields
 of 'struct vm_fault'
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 9:36 AM Will Deacon <will@kernel.org> wrote:
>
> In preparation for const-ifying the anonymous struct field of
> 'struct vm_fault', ensure that it is initialised using static
> initialisers.

FWIW these are known as "designated initializers", ie.

struct foo my_foo = {
  .bar = 42,
};

https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  mm/shmem.c    |  6 +++---
>  mm/swapfile.c | 11 ++++++-----
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7c6b6d8f6c39..1b254fbfdf52 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1520,11 +1520,11 @@ static struct page *shmem_swapin(swp_entry_t swap, gfp_t gfp,
>  {
>         struct vm_area_struct pvma;
>         struct page *page;
> -       struct vm_fault vmf;
> +       struct vm_fault vmf = {
> +               .vma = &pvma,
> +       };
>
>         shmem_pseudo_vma_init(&pvma, info, index);
> -       vmf.vma = &pvma;
> -       vmf.address = 0;
>         page = swap_cluster_readahead(swap, gfp, &vmf);
>         shmem_pseudo_vma_destroy(&pvma);
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 9fffc5af29d1..2b570a566276 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1951,8 +1951,6 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>         si = swap_info[type];
>         pte = pte_offset_map(pmd, addr);
>         do {
> -               struct vm_fault vmf;
> -
>                 if (!is_swap_pte(*pte))
>                         continue;
>
> @@ -1968,9 +1966,12 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>                 swap_map = &si->swap_map[offset];
>                 page = lookup_swap_cache(entry, vma, addr);
>                 if (!page) {
> -                       vmf.vma = vma;
> -                       vmf.address = addr;
> -                       vmf.pmd = pmd;
> +                       struct vm_fault vmf = {
> +                               .vma = vma,
> +                               .address = addr,
> +                               .pmd = pmd,
> +                       };
> +
>                         page = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
>                                                 &vmf);
>                 }
> --
> 2.30.0.284.gd98b1dd5eaa7-goog
>


--
Thanks,
~Nick Desaulniers
