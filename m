Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6912D13E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgLGOnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgLGOnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:43:40 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385CC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:43:00 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b26so10179533pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 06:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5xJHpzkWq3fPFICAliDXY3lW0eacrQxvWesbPVfrbE=;
        b=EUAmfB9SgQWGY0xQeiOXG4pQKS43QKzYf3yuQ8Ye8ujw4OpjxQlgbf7IFawwWV6J8+
         LZWGoT3a398qvBw0Wokn0cie7dA/rEBL30q7Dtcg8FMNzvRI6+D3lh1NDq0hIBkCII8m
         kXXClFXnHpU2dAaE3Wsz9V347BXi4Ga2c1IP3LXXISZ4NS7ZDmWpjIGQRiiND02ffFqg
         nMuiI9+cAfVytHw4ZAWkVLIi2fUK6pkvtRYTMQEc3rw5IeUV4abTqgb8BdkZu9fef4E2
         08pO9BV9k0l9CdkSYJa92yP/oajzhQJjELkO17ZflxwWQxgHQ9RYUyo5XDqYpT/sfS6u
         NjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5xJHpzkWq3fPFICAliDXY3lW0eacrQxvWesbPVfrbE=;
        b=g5HBA074+n5blDIj+W4gGgmDbq2WciWdWjCF2+7iSYsB3j4t8eZVr/HuIjdoP1Mv5y
         Tn3fAkMjkMBsp/pMsQKaSZt/BAUtRJTRrQ0V4mOZy+pwu5My2Jz78VQ2nLJI7LrSD6tf
         4T+BBAd+U/iS5Ay4CVkgfu52KpFaF1IeKJcg1GjNT/7Dbdv89BVROgSUO1DMX8rGkXF5
         mAaD+jz1o1R+Y84EE9KqxNV1COz/OOjiz26XIHfKKgS/D4Jqx5l3l0OhLxXUSmeTgicF
         pAGhL3mWBPqC3kgYKE/2m6mhn+kZhKFai2WWrLSASrOXvNjd78fTksFypsXab2DBVMOo
         WQZg==
X-Gm-Message-State: AOAM532VW80cWMWs0LSyxHVezy4Jmvk3WSbQ49Qnatjqe/SM8pPxxX1f
        CuOViT0lQAQSPYRKt9s/MpCHp0Z0Y4F3QKOmtT7HSQ==
X-Google-Smtp-Source: ABdhPJyiFFoSswfMQwRHj9c+4GSiFy7hnaCjcOgu/Zq+G/6ZotsSkCqJ+4mSPA0JgGTgrNSFNWee2/6qmNg5DLjBWh0=
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id
 b1-20020aa787010000b029019e0561d476mr5707847pfo.2.1607352179512; Mon, 07 Dec
 2020 06:42:59 -0800 (PST)
MIME-Version: 1.0
References: <20201207142204.GA18516@rlk>
In-Reply-To: <20201207142204.GA18516@rlk>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Dec 2020 22:42:23 +0800
Message-ID: <CAMZfGtV8CS_Sh+N5xYsxiHCz2K2KVFrHw0ohrrboNucXucekOw@mail.gmail.com>
Subject: Re: [External] [PATCH] mm/page_alloc: simplify kmem cgroup
 charge/uncharge code
To:     Hui Su <sh_def@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 10:22 PM Hui Su <sh_def@163.com> wrote:
>
> Since the commit 60cd4bcd6238 ("memcg: localize memcg_kmem_enabled()
> check"), we have supplied the api which users don't have to explicitly
> check memcg_kmem_enabled().
>
> Signed-off-by: Hui Su <sh_def@163.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

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
> --
> 2.29.2
>
>


-- 
Yours,
Muchun
