Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19EB2D1794
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgLGR3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgLGR3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:29:40 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7CBC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 09:29:00 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id e7so5607938ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 09:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbFZ9/aJq6+MRerHGTSlgnWQbD0N46Qq1m/62tax3Q0=;
        b=FrTRSLmtoCaBB+p8XGyT5sms3TPD14eQAkpc8U34a38NA6wO7e6EHfZ3U7rsNMinmd
         vuNPZx22yX9OSQZEM6lAcnpTdNF+m/sTgimRK+EgpJhR1HMD76izF4sZwK21tAx1fttl
         ZCh5qLnwtfr2lfNajRlpFN43cs0eLphShP5SyIgXUw1fZdrxR6vVrf7na9OFEVXli4M5
         vC0zg9ijnyVx0koTGb7EiOXZxe/w4pivFk7inhtU80clXFpdwipjWdRA2526YOBBXE0D
         gQGBZO23AaeJ/kaaHSvfP//RPVxL0Axbu2PIOuwtmj0A/ONTOj/Gs3Nctf1FrsPI+cz6
         Lm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbFZ9/aJq6+MRerHGTSlgnWQbD0N46Qq1m/62tax3Q0=;
        b=nIQrh3XS+4p4XZTmnBKnxU/5lQ0Ihk5LFFO6d8YIYz6XIySIlV4m/YtU/nq3gfTZ0B
         OkRhGcEyZKBLM0V8clhAgexj5695g3k+QpXe3o91Z/vA46djCdhnoDzT5hw8q0bb1r35
         O4hsEomwUzAa11vltcF7WVX3zWOXdkUivBuIH1x3UY4BBKYTNr+zThyrD4W7SJru7aX5
         aWiNc3giCYFBrb2GBchOWr9ZF4razjfMRrsO/hKU9NbeE2YoGEFyvzGreAUZAisKbjaz
         bxxjDBCiYbYAkx6Wd+IwI/Mpy7Mq/MvSDWPRwVigCRdcij+QSRmWSsOCiIOATvXxFqSq
         GGpg==
X-Gm-Message-State: AOAM532WkxPbqhIeGOF1ZGYwyjpi8bMEP6x01idIKtp8NQOGyQw7W75U
        dVYp4Z5AF1wsXxbAcTcnor/1vJlh3JcUCO/p4cYPgA==
X-Google-Smtp-Source: ABdhPJy28XMxrw04eVdjjzg7k8ZRJbkzlBNFitQCJs8TqSimrJHuDOVi6Y+r40mvWP61BqZLIDzwW789n1EaxQBah70=
X-Received: by 2002:a2e:8416:: with SMTP id z22mr324668ljg.347.1607362138096;
 Mon, 07 Dec 2020 09:28:58 -0800 (PST)
MIME-Version: 1.0
References: <20201207142204.GA18516@rlk>
In-Reply-To: <20201207142204.GA18516@rlk>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 7 Dec 2020 09:28:46 -0800
Message-ID: <CALvZod45tRyx+7VagQQ=9SqabNR5Y=f0U0T0AFtOFWdzUgJbxQ@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: simplify kmem cgroup charge/uncharge code
To:     Hui Su <sh_def@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 6:22 AM Hui Su <sh_def@163.com> wrote:
>
> Since the commit 60cd4bcd6238 ("memcg: localize memcg_kmem_enabled()
> check"), we have supplied the api which users don't have to explicitly
> check memcg_kmem_enabled().
>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  mm/page_alloc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index eaa227a479e4..dc990a899ded 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1214,8 +1214,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>                  * Do not let hwpoison pages hit pcplists/buddy
>                  * Untie memcg state and reset page's owner
>                  */
> -               if (memcg_kmem_enabled() && PageKmemcg(page))
> -                       __memcg_kmem_uncharge_page(page, order);
> +               if (PageKmemcg(page))
> +                       memcg_kmem_uncharge_page(page, order);
>                 reset_page_owner(page, order);
>                 return false;
>         }
> @@ -1244,8 +1244,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
>         }
>         if (PageMappingFlags(page))
>                 page->mapping = NULL;
> -       if (memcg_kmem_enabled() && PageKmemcg(page))
> -               __memcg_kmem_uncharge_page(page, order);
> +       if (PageKmemcg(page))
> +               memcg_kmem_uncharge_page(page, order);
>         if (check_free)
>                 bad += check_free_page(page);
>         if (bad)
> @@ -4965,8 +4965,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>         page = __alloc_pages_slowpath(alloc_mask, order, &ac);
>
>  out:
> -       if (memcg_kmem_enabled() && (gfp_mask & __GFP_ACCOUNT) && page &&
> -           unlikely(__memcg_kmem_charge_page(page, gfp_mask, order) != 0)) {
> +       if ((gfp_mask & __GFP_ACCOUNT) && page &&
> +           unlikely(memcg_kmem_charge_page(page, gfp_mask, order) != 0)) {
>                 __free_pages(page, order);
>                 page = NULL;
>         }


The reason to keep __memcg_kmem_[un]charge_page functions is that they
were called in the very hot path. Can you please check the performance
impact of your change and if the generated code is actually same or
different.
