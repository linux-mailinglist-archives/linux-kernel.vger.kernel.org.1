Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7182CD55E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgLCMU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgLCMU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:20:56 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A032C08C5F2
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:20:03 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id z3so1106884qtw.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 04:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=0YG4wbx5uXn5ZVc8LUjokfiUnek0XP00ZZjOe0WJxYE=;
        b=htPUd+NfDQhpS40j5lrHjNKKG7rGEqt/XAy15Gy4jCIT+ysNxBMY/VqgcC+2pbu0KM
         IgRe+7LoUCUovVJ3nAoYy+UTw57vLIMPhyMQccinnfj9GxV88/ZtM0yXOekmaoCxR6gQ
         fOHKpeOVgYwPC/CrVdoIpBFi6xC9hLtegzFyAe1Bp/TdUxABJ3RKwvc69b3CddXXutql
         qQJqNod4dekUrMD4lOdSXwzSGIyM1PTkb9c/0ZW+KQepDDZNr5/Pmf3AqaXgc9OJPVwH
         ZyA36V4QZURCtvFHBiDDJVT9f36gEXXmvaC6M9yx8kqWbT+9To7Z2Zgx7vfGBnh0/IJ0
         SAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=0YG4wbx5uXn5ZVc8LUjokfiUnek0XP00ZZjOe0WJxYE=;
        b=oxmGKxLw2HsdAYBeKWEvIOzBExtj6NQlsGVQx57IGPcaASCRzsGxaFFn2viaLpHGmb
         GTg2wwo+PDnEoQydRVtQQpmgbQpqGQJ7CJX1IiSFjF7PLYTsILGQYvsbtC5qeGxmbBzD
         Ud6w9+aSt6C9EXvxObntBSt87lGbf/EnKlagE7AmcVr+q6eMJoIQNdBtj1qPhUK9Tjx5
         iFDfBcLuC1sj5sC0N1JxiPlwJzPg3WZ+KOFbPTa/BWRklnLRtya66v0WQJJZ+JS8hrx2
         t4b19V2NbqQm0ibeZCMIVK4ARZ6RcGnnielK6FUgY4re2ZMTnRT0n/MY9CevvMPPQaDQ
         6uAQ==
X-Gm-Message-State: AOAM531hcDcYLUPELh3Afmg9uhxtcUvS0tdh70BOriOtpADwgWEMn23J
        Hymuy8gAApIWMPzZGgFo/o4kNavoFrBs74Z008Eu7tMh+bg=
X-Google-Smtp-Source: ABdhPJzsYP0w8jKrH5meaVwG1sMDh6W0b7QKYFjfYhXXElXPIHoIExJhd0KeaCU596idLDriqczWSKKSZQiYjhnoR0s=
X-Received: by 2002:ac8:3a84:: with SMTP id x4mr2805779qte.55.1606998002440;
 Thu, 03 Dec 2020 04:20:02 -0800 (PST)
MIME-Version: 1.0
References: <1606995362-16413-1-git-send-email-zhaoyang.huang@unisoc.com>
In-Reply-To: <1606995362-16413-1-git-send-email-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 3 Dec 2020 20:19:51 +0800
Message-ID: <CAGWkznH+W7o3R7LLrtVzRoNuxD33JBaZ0DzMwtfOZpBWHJDoeg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix a race on nr_swap_pages
To:     Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is show_swap_cache_info() which races with get_swap_xxx

On Thu, Dec 3, 2020 at 7:36 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> The scenario on which "Free swap -4kB" happens in my system, which is caused by
>  get_swap_page_of_type or get_swap_pages racing with show_mem. Remove the race
>  here.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/swapfile.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index cf63b5f..13201b6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -974,6 +974,8 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>         /* Only single cluster request supported */
>         WARN_ON_ONCE(n_goal > 1 && size == SWAPFILE_CLUSTER);
>
> +       spin_lock(&swap_avail_lock);
> +
>         avail_pgs = atomic_long_read(&nr_swap_pages) / size;
>         if (avail_pgs <= 0)
>                 goto noswap;
> @@ -986,8 +988,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>
>         atomic_long_sub(n_goal * size, &nr_swap_pages);
>
> -       spin_lock(&swap_avail_lock);
> -
>  start_over:
>         node = numa_node_id();
>         plist_for_each_entry_safe(si, next, &swap_avail_heads[node], avail_lists[node]) {
> @@ -1061,14 +1061,13 @@ swp_entry_t get_swap_page_of_type(int type)
>
>         spin_lock(&si->lock);
>         if (si->flags & SWP_WRITEOK) {
> -               atomic_long_dec(&nr_swap_pages);
>                 /* This is called for allocating swap entry, not cache */
>                 offset = scan_swap_map(si, 1);
>                 if (offset) {
> +                       atomic_long_dec(&nr_swap_pages);
>                         spin_unlock(&si->lock);
>                         return swp_entry(type, offset);
>                 }
> -               atomic_long_inc(&nr_swap_pages);
>         }
>         spin_unlock(&si->lock);
>  fail:
> --
> 1.9.1
>
