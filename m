Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57E12A2BF4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbgKBNtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKBNtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:49:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C988C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:49:04 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 13so11165459pfy.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WpF3sGCaFtVS1Eh20j27YgKkWsI2ZncIVFxEJni7Be4=;
        b=GSlJIwMxdX5CBk/cKQG3VsM4ru4+Q/uvclPVySn8U60UWDJcYGPlQ5jkRJzNG0i/Qa
         Y1hqI7Fbn6U+29sQiEOZvWAitHhQEnb0L8oGWkzWPfi0hGjwt9HYjQCK8ItkVDHP7MY0
         cdcr/Wqikh4CH36iTncUM+M5zWPpuVQG0sdk15zf8GbhSsftpBG7Cuz7ZzIcGjHPD3vY
         EfEY49KetKEyXja4u4yzYJqpoiKMdWL/R+tTq8ea90J0MXIlX+/Hc+PTycJwOp1e+eQL
         7Mios4ebR5qMFmkgPy0DlRs+ygTh7rKLLewLUWtMM9QZspv2vwEJNXqsCBRC2m9catOD
         R4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpF3sGCaFtVS1Eh20j27YgKkWsI2ZncIVFxEJni7Be4=;
        b=c34R8naY6g5lRB+ZbfSVzRHRX8HTT+L/tgg/vKIW2Jh+rc+hUkJdeDXth11Up6Ncmk
         Fr5nFePiH1wl7+KeVNlItREq7zbVMwAuzkeOwtCFLfmDb4ZEs9wOS2yypyjrIMtJxAiE
         9MEcq9G4hytV+rVIllx1xRW8RqLYWPlCwNihQaPmLSegxuD4U6LaRHte67N2sT83f+FU
         lX08ED7aQtCg0b1d5ViJxIfyd0QDl/vAzWjY2VxYzMzPWPK9JshepXg+2tps92WEYyQa
         I7ISIiPdjUAIrqbbajgsf6hOhn29cdqmtmANX/VLhPSls2s6KwsQmjmWyLqcDBkBSE4s
         /1MA==
X-Gm-Message-State: AOAM5310qzxwQaLEqQfLCFhqQVXNcDByDLn4/C2RNP/yp5jDwMmL1Csc
        RcJZMERer+SsbnUOuv2vWbYyAkj2EzwsTeTk70kPJg==
X-Google-Smtp-Source: ABdhPJxMGgNruSBgB1KLqECniO90ERSveN//g/NnKzYcrbtcD98wF7ERQBa3YmbwMzRZf4COZcWiWxSYT+Tbd0XsTb0=
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id
 s7-20020aa782870000b0290142250139ecmr21136648pfm.59.1604324944055; Mon, 02
 Nov 2020 05:49:04 -0800 (PST)
MIME-Version: 1.0
References: <20201028141646.GA75933@rlk>
In-Reply-To: <20201028141646.GA75933@rlk>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 2 Nov 2020 21:48:25 +0800
Message-ID: <CAMZfGtXYLLsS-kGAPD6xxygSC7nyub-OsAtXCTehW-n2ik9m7w@mail.gmail.com>
Subject: Re: [External] [PATCH v2] mm/list_lru: optimize condition of exiting
 the loop
To:     Hui Su <sh_def@163.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, gustavo@embeddedor.com,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:17 PM Hui Su <sh_def@163.com> wrote:
>
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

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

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
> --
> 2.29.0
>
>


--
Yours,
Muchun
