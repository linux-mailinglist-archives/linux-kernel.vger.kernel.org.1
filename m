Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE482E04CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 04:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgLVDjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 22:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgLVDjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:39:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C9AC061793
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:39:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id x126so7663261pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 19:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mQRnP/VE3MNPubHtDGscBCYTtM3M8Hnq7UmsE7TsaOU=;
        b=aIf0pGKPSreq5IVVApVQmbb6IeRO6q0rWAZSyCbchKd3JzFF0dl9OPfFoHGNFNiHwF
         L+PGmSJ8KKPAvSREpdpX6LSXrbYNPfsG8FVdHbjA8LD/1ePrfwtDbx3AWnxEuINxSew3
         /G8z6kj9+V4oGzdjwzEy8MUC6hMWUMjOAvTi37ZruuJMuB+w38j3U49XOQ18xz5C7BVz
         wUZXDjqM9Gt/WugmBrxR3FkzKW14NzEwrqYBEZvE9HaWZrMRdAjZMSLqC75JVU3Rd9C8
         EcLCcFmN4/gMoHTqSqYVnXFo6AfOR/TIvdNCCQ3C5sK/AllRIAKhmLggrfk4onGmXCyA
         2+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mQRnP/VE3MNPubHtDGscBCYTtM3M8Hnq7UmsE7TsaOU=;
        b=IEEQaXdP9017EZGHmKfp24wl3DJvIJeIXt3xFZ04UGKZrVUUj0xhNwmY9Qij/y1KjB
         p+sO0SWH6OeLZ5PQsNS4zlmgyfj/i/cdnzHM+0aFoWaAAYMDSNULQ+Fll/nHbKusy/lR
         HOQWbkU75LbZ8a9Gj+AmvczTWs+wuQqd+6KaD9LLbjse16jLGo3Xh2Mh1T3h4FpjZT4P
         okt8tC9XOc0edh3V1k5yqS7AlKzj0B7tRiJQIDjcqhM1eN5ZYRWYbwbr3nwoFGW8jR1k
         Z58ZTGd76WcY9ueOvyksKMPP/mE5jk139lyC50EBEDB1MGTIoy8zdAIGFIVlITugfZqa
         acig==
X-Gm-Message-State: AOAM531C5AmXK9lkM+V3YCROM9v4AKZO7NnIHW4Z0W8lh5QTYZiqP2y1
        z1QOhvzuY1xTMroVnorKdXdotw==
X-Google-Smtp-Source: ABdhPJzRa1gPuiUdV7wKyv/rJCmjaS+AMnNm3WPKmFO8ip/FFKsK2HgBJHAyyXooG0/zw4pVdGEMrA==
X-Received: by 2002:a63:609:: with SMTP id 9mr18084864pgg.391.1608608340308;
        Mon, 21 Dec 2020 19:39:00 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id nk11sm17068952pjb.26.2020.12.21.19.38.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Dec 2020 19:38:59 -0800 (PST)
Date:   Mon, 21 Dec 2020 19:38:57 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Hui Su <sh_def@163.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/memcg: remove rcu locking for lock_page_lruvec
 function series
In-Reply-To: <1608186532-81218-2-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2012211901580.1045@eggly.anvils>
References: <1608186532-81218-1-git-send-email-alex.shi@linux.alibaba.com> <1608186532-81218-2-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020, Alex Shi wrote:

> The rcu_read_lock was used to block memcg destory, but with the detailed
> calling conditions, the memcg won't gone since the page is hold. So we
> don't need it now, let's remove them to save locking load in debugging.

"
lock_page_lruvec() and its variants used rcu_read_lock() with the
intention of safeguarding against the mem_cgroup being destroyed
concurrently; but so long as they are called under the specified
conditions (as they are), there is no way for the page's mem_cgroup
to be destroyed.  Delete the unnecessary rcu_read_lock() and _unlock().
"

This has little to do with a "locking load in debugging" - so what?
But everything to do with deleting bogosity, the sooner the better.

> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Hugh Dickins <hughd@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

This really surprised me!  Nice change, but how on earth did we not
notice until now?  The rcu_read_lock() seems to have come in, without
explanation, somewhere between lru_lock v9 and v11 (I never saw v10); and
I guess I was so used to needing rcu_read_lock() in my own implementation,
that I was blind to its irrelevance in yours.  Cc'ing Alex Duyck, since
he was generally very alert to this kind of thing - be good to have his
Ack too.  Also Cc'ing Hui Su, who sent a similar but unexplained patch
just before yours.

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/memcontrol.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e6b50d068b2f..98bbee1d2faf 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1356,10 +1356,8 @@ struct lruvec *lock_page_lruvec(struct page *page)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock(&lruvec->lru_lock);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> @@ -1371,10 +1369,8 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock_irq(&lruvec->lru_lock);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> @@ -1386,10 +1382,8 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
>  	struct lruvec *lruvec;
>  	struct pglist_data *pgdat = page_pgdat(page);
>  
> -	rcu_read_lock();
>  	lruvec = mem_cgroup_page_lruvec(page, pgdat);
>  	spin_lock_irqsave(&lruvec->lru_lock, *flags);
> -	rcu_read_unlock();
>  
>  	lruvec_memcg_debug(lruvec, page);
>  
> -- 
> 2.29.GIT
