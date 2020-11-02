Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2516B2A2BDE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgKBNow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBNov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:44:51 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6985C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:44:51 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id s24so8158719ioj.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEmtsbdHqC4I+5fjYJ4G6hPGEzEHqNgzPZHsu1Q5zg4=;
        b=HqtjOjV0zxhZexN2cFiIHJOI6PbtrCk33lKM2c6LqOMzVhxYCOLdqvY5lqSZRtMWgY
         T4NgDMcXkOfpLLIDnhtWatS9TES/3hH1ABnf4OLPVFfEEhKyVVzqUBtvL9PC9Labvsw+
         ECdD6emjwnJOtp3tXmTnU/FxiNMeR35cwkpC0GpJYkMZ4kJdAF3CPeGJ+gACUfx7MF5X
         59sVScjfS8DKSq9IC3/C40AWByOCx5BW+Z4Bmvul3/LXXI240kKpe+XjkGXIejrkIIJz
         pn+/uH6Wn/KEhWqPCFAKeC0OPHTpkAybC+cHNvhpsQjQ0tOoy5BqZPbZJsEPE27s4lOe
         /fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEmtsbdHqC4I+5fjYJ4G6hPGEzEHqNgzPZHsu1Q5zg4=;
        b=RaDnKE3EhZg7Ylhw59Nh04eP4Igs3wRAzP/YBS0lPYhnKa4bairCvECTXh4ZgxJ45g
         bmUmPp4SO2IVlXtE11yKw37jZvB9jE+yvHh923MSx6YrtmGiP3qvLrb+Nw+N4u+bA/LK
         HE3m7QoUjC7ZE1Z2H77LjzT6Ow342+ghJuHxPjSvSNFvTBDglpiE4LS9KsUw0LAVmnew
         jVIUy1nJM/ibYKjx6JiZMmJfGaIin0B20gacjCzUdJCG+/ksWRthIdFT1Tk7iL6izgsZ
         d+w0CZfuweo004fA9ZDbBwzqeNOFLu1AOJO2BKe6bvighljMRvuwOSIQF4wOC4G3z8VN
         2hpA==
X-Gm-Message-State: AOAM530lUHJccm8fEKR7FUxYkRRb9hU0ckSDmLf+uDODzgdVU3vnKVOM
        F5rJrIM06x3ofic0Gcd4osnq1/Lz51s0rcFAAtc=
X-Google-Smtp-Source: ABdhPJyDkcGCR51lzq2gNFwGY9/fzfqgodyPlOs/h+p/gvOLefUiUIji9Dx270NJ9tPYrKODeReoXUQGA8dahPTB4uM=
X-Received: by 2002:a6b:e010:: with SMTP id z16mr975916iog.84.1604324691116;
 Mon, 02 Nov 2020 05:44:51 -0800 (PST)
MIME-Version: 1.0
References: <20201028141646.GA75933@rlk>
In-Reply-To: <20201028141646.GA75933@rlk>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Mon, 2 Nov 2020 14:44:39 +0100
Message-ID: <CAM9Jb+gsuN_0Wo8XKP8jnLi+gCT-EX5UJBraDPd5zUn9NeOqsw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/list_lru: optimize condition of exiting the loop
To:     Hui Su <sh_def@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, gustavo@embeddedor.com,
        Muchun Song <songmuchun@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In list_lru_walk(), nr_to_walk type is 'unsigned long',
> so nr_to_walk won't be '< 0'.
>
> In list_lru_walk_node(), nr_to_walk type is 'unsigned long',
> so *nr_to_walk won't be '< 0' too.
>
> We can use '!nr_to_walk' instead of 'nr_to_walk <= 0', which
> is more precise.
>
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  include/linux/list_lru.h | 2 +-
>  mm/list_lru.c            | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index 9dcaa3e582c9..b7bc4a2636b9 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -214,7 +214,7 @@ list_lru_walk(struct list_lru *lru, list_lru_walk_cb isolate,
>         for_each_node_state(nid, N_NORMAL_MEMORY) {
>                 isolated += list_lru_walk_node(lru, nid, isolate,
>                                                cb_arg, &nr_to_walk);
> -               if (nr_to_walk <= 0)
> +               if (!nr_to_walk)
>                         break;
>         }
>         return isolated;
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 5aa6e44bc2ae..35be4de9fd77 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -294,7 +294,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>
>         isolated += list_lru_walk_one(lru, nid, NULL, isolate, cb_arg,
>                                       nr_to_walk);
> -       if (*nr_to_walk > 0 && list_lru_memcg_aware(lru)) {
> +       if (*nr_to_walk && list_lru_memcg_aware(lru)) {
>                 for_each_memcg_cache_index(memcg_idx) {
>                         struct list_lru_node *nlru = &lru->node[nid];
>
> @@ -304,7 +304,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
>                                                         nr_to_walk);
>                         spin_unlock(&nlru->lock);
>
> -                       if (*nr_to_walk <= 0)
> +                       if (!*nr_to_walk)
>                                 break;
>                 }
>         }

Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
