Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEE62C4E1A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 05:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgKZEwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 23:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387705AbgKZEwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 23:52:41 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C884C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 20:52:41 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id g1so679246ilk.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 20:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sDklPCBSDngDVVB9iqv91v571+XOJMImwRyy6FkmCZQ=;
        b=D9/hcrRHg0RFirj0OCtux5afxgDTvkT1TmebOXEd2NCmanzryQQK+1+Ki6AChd3hJO
         GZMjYWX7MONr8UtDTt8KRIIympnbZsxGj9pBE9I23+WUgkZthRdoxD5Zszlp0NC6QMHM
         TM/yObf4BkB1SE/2Ki2M9d4pZNY6e2p1YSfHlOFQoCc1UljJEq2bVFq+MeHxwIzxg9uK
         t42VYloNAasJdJeVYVFDc3BrCZw1AmZg8Croz8+FgLeQ44tdT21T+zs11UTMOjuBl8Yj
         iMhbHN8gqDN2T+4QBQtJCfiLhZVgBdet66N7uGiv9UuoyrDqr+L5b+nDgwL5BrmdEQuJ
         XTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sDklPCBSDngDVVB9iqv91v571+XOJMImwRyy6FkmCZQ=;
        b=rBebLWlgmhZo/+BtAgBfreb2ChO94mT4mzpuNXztf0O/hPv+eLHapJy/LVmb2IgnWV
         d+55KqZ+Qbbacp7rjqvVw+vIT8IscNpm4mrjkEvNUPNiU8R9lVmfEolNaX2JQWSGgLt7
         eShF6LkIRLMiBpXWqJEhByiyBKQSmMR8HZaMBmdS2MQRAzFunMZmwzAf+Qn6ZOPabNQF
         SOO6vfL7k04BmJGc8BRvrEZfis1t7sIK9jWLxTVKpp4QBAfuNtK2YxZK30Kj3t7WuCxb
         sSPrkRZH+9W0nD27wQiBwwhMjnwxGeNLiIHQJTiNSCq8e2AB8Gd1XbUV5xz24UsANkm9
         mIIQ==
X-Gm-Message-State: AOAM533Uqlf8EzviMOOp8PPa0t/l39fVZoABY+HKDl2TuGStXpkoACbk
        KomkYQLWsjlSYZf5L4VziJIKPJEEpgj6qA==
X-Google-Smtp-Source: ABdhPJz2/EsdZl2ZpBPptMIR825pX3h04q4itLK7ZTujfRUxp4kbqoE148hcGCw3lr68vCoPT5kVaA==
X-Received: by 2002:a05:6e02:e44:: with SMTP id l4mr1140572ilk.208.1606366360337;
        Wed, 25 Nov 2020 20:52:40 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id i8sm2479613ilj.1.2020.11.25.20.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 20:52:39 -0800 (PST)
Date:   Wed, 25 Nov 2020 21:52:34 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
Message-ID: <20201126045234.GA1014081@google.com>
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 04:27:27PM +0800, Alex Shi wrote:
> The current relock logical will change lru_lock when found a new
> lruvec, so if 2 memcgs are reading file or alloc page at same time,
> they could hold the lru_lock alternately, and wait for each other for
> fairness attribute of ticket spin lock.
> 
> This patch will sort that all lru_locks and only hold them once in
> above scenario. That could reduce fairness waiting for lock reget.
> Than, vm-scalability/case-lru-file-readtwice could get ~5% performance
> gain on my 2P*20core*HT machine.
> 
> Suggested-by: Konstantin Khlebnikov <koct9i@gmail.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/swap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 490553f3f9ef..c787b38bf9c0 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -1009,24 +1009,65 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
>  	trace_mm_lru_insertion(page, lru);
>  }
>  
> +struct lruvecs {
> +	struct list_head lists[PAGEVEC_SIZE];
> +	struct lruvec *vecs[PAGEVEC_SIZE];
> +};
> +
> +/* Sort pvec pages on their lruvec */
> +int sort_page_lruvec(struct lruvecs *lruvecs, struct pagevec *pvec)
> +{
> +	int i, j, nr_lruvec;
> +	struct page *page;
> +	struct lruvec *lruvec = NULL;
> +
> +	lruvecs->vecs[0] = NULL;
> +	for (i = nr_lruvec = 0; i < pagevec_count(pvec); i++) {
> +		page = pvec->pages[i];
> +		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
> +
> +		/* Try to find a same lruvec */
> +		for (j = 0; j <= nr_lruvec; j++)
> +			if (lruvec == lruvecs->vecs[j])
> +				break;
> +
> +		/* A new lruvec */
> +		if (j > nr_lruvec) {
> +			INIT_LIST_HEAD(&lruvecs->lists[nr_lruvec]);
> +			lruvecs->vecs[nr_lruvec] = lruvec;
> +			j = nr_lruvec++;
> +			lruvecs->vecs[nr_lruvec] = 0;
> +		}
> +
> +		list_add_tail(&page->lru, &lruvecs->lists[j]);
> +	}
> +
> +	return nr_lruvec;
> +}
> +
>  /*
>   * Add the passed pages to the LRU, then drop the caller's refcount
>   * on them.  Reinitialises the caller's pagevec.
>   */
>  void __pagevec_lru_add(struct pagevec *pvec)
>  {
> -	int i;
> -	struct lruvec *lruvec = NULL;
> +	int i, nr_lruvec;
>  	unsigned long flags = 0;
> +	struct page *page;
> +	struct lruvecs lruvecs;
>  
> -	for (i = 0; i < pagevec_count(pvec); i++) {
> -		struct page *page = pvec->pages[i];
> +	nr_lruvec = sort_page_lruvec(&lruvecs, pvec);

Simply looping pvec multiple times (15 at most) for different lruvecs
would be better because 1) it requires no extra data structures and
therefore has better cache locality (theoretically faster) 2) it only
loops once when !CONFIG_MEMCG and !CONFIG_NUMA and therefore has no
impact on Android and Chrome OS.

> -		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
> -		__pagevec_lru_add_fn(page, lruvec);
> +	for (i = 0; i < nr_lruvec; i++) {
> +		spin_lock_irqsave(&lruvecs.vecs[i]->lru_lock, flags);
> +		while (!list_empty(&lruvecs.lists[i])) {
> +			page = lru_to_page(&lruvecs.lists[i]);
> +			list_del(&page->lru);
> +			__pagevec_lru_add_fn(page, lruvecs.vecs[i]);
> +		}
> +		spin_unlock_irqrestore(&lruvecs.vecs[i]->lru_lock, flags);
>  	}
> -	if (lruvec)
> -		unlock_page_lruvec_irqrestore(lruvec, flags);
> +
>  	release_pages(pvec->pages, pvec->nr);
>  	pagevec_reinit(pvec);
>  }
> -- 
> 2.29.GIT
> 
