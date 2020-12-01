Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FF52C98DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgLAILT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:11:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:47920 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgLAILT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:11:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606810232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MGzl2nOb3KiDpgdpAOqgUoee3zM2sP5KMdEu1eaWBnk=;
        b=YI2SaO5wcat10Ip5qGVCLc0TcbYPddKdnPqNgWABlkJtiV77zGgClDcNiFYK+Bdx9Dqc2K
        uGcXdIUIcEpGzlIVKxOXBGWigLZ4FhnPHtHbysfwhzfJPk7BI2bXuHC8TjKFopAfuuWZRv
        5BIv5SRJKEKttXPPLNXawJjQZgDUGGI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74001AC2F;
        Tue,  1 Dec 2020 08:10:32 +0000 (UTC)
Date:   Tue, 1 Dec 2020 09:10:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     vbabka@suse.cz, Konstantin Khlebnikov <koct9i@gmail.com>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/swap.c: pre-sort pages in pagevec for
 pagevec_lru_move_fn
Message-ID: <20201201081031.GQ17338@dhcp22.suse.cz>
References: <20201126155553.GT4327@casper.infradead.org>
 <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606809735-43300-1-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 01-12-20 16:02:13, Alex Shi wrote:
> Pages in pagevec may have different lruvec, so we have to do relock in
> function pagevec_lru_move_fn(), but a relock may cause current cpu wait
> for long time on the same lock for spinlock fairness reason.
> 
> Before per memcg lru_lock, we have to bear the relock since the spinlock
> is the only way to serialize page's memcg/lruvec. Now TestClearPageLRU
> could be used to isolate pages exculsively, and stable the page's
> lruvec/memcg. So it gives us a chance to sort the page's lruvec before
> moving action in pagevec_lru_move_fn. Then we don't suffer from the
> spinlock's fairness wait.

Do you have any data to show any improvements from this?

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/swap.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 490553f3f9ef..17d8990e5ca7 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -201,29 +201,95 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
>  }
>  EXPORT_SYMBOL_GPL(get_kernel_page);
>  
> +/* Pratt's gaps for shell sort, https://en.wikipedia.org/wiki/Shellsort */
> +static int gaps[] = { 6, 4, 3, 2, 1, 0};
> +
> +/* Shell sort pagevec[] on page's lruvec.*/
> +static void shell_sort(struct pagevec *pvec, unsigned long *lvaddr)
> +{
> +	int g, i, j, n = pagevec_count(pvec);
> +
> +	for (g=0; gaps[g] > 0 && gaps[g] <= n/2; g++) {
> +		int gap = gaps[g];
> +
> +		for (i = gap; i < n; i++) {
> +			unsigned long tmp = lvaddr[i];
> +			struct page *page = pvec->pages[i];
> +
> +			for (j = i - gap; j >= 0 && lvaddr[j] > tmp; j -= gap) {
> +				lvaddr[j + gap] = lvaddr[j];
> +				pvec->pages[j + gap] = pvec->pages[j];
> +			}
> +			lvaddr[j + gap] = tmp;
> +			pvec->pages[j + gap] = page;
> +		}
> +	}
> +}
> +
> +/* Get lru bit cleared page and their lruvec address, release the others */
> +void sort_isopv(struct pagevec *pvec, struct pagevec *isopv,
> +		unsigned long *lvaddr)
> +{
> +	int i, j;
> +	struct pagevec busypv;
> +
> +	pagevec_init(&busypv);
> +
> +	for (i = 0, j = 0; i < pagevec_count(pvec); i++) {
> +		struct page *page = pvec->pages[i];
> +
> +		pvec->pages[i] = NULL;
> +
> +		/* block memcg migration during page moving between lru */
> +		if (!TestClearPageLRU(page)) {
> +			pagevec_add(&busypv, page);
> +			continue;
> +		}
> +		lvaddr[j++] = (unsigned long)
> +				mem_cgroup_page_lruvec(page, page_pgdat(page));
> +		pagevec_add(isopv, page);
> +	}
> +	pagevec_reinit(pvec);
> +	if (pagevec_count(&busypv))
> +		release_pages(busypv.pages, busypv.nr);
> +
> +	shell_sort(isopv, lvaddr);
> +}
> +
>  static void pagevec_lru_move_fn(struct pagevec *pvec,
>  	void (*move_fn)(struct page *page, struct lruvec *lruvec))
>  {
> -	int i;
> +	int i, n;
>  	struct lruvec *lruvec = NULL;
>  	unsigned long flags = 0;
> +	unsigned long lvaddr[PAGEVEC_SIZE];
> +	struct pagevec isopv;
>  
> -	for (i = 0; i < pagevec_count(pvec); i++) {
> -		struct page *page = pvec->pages[i];
> +	pagevec_init(&isopv);
>  
> -		/* block memcg migration during page moving between lru */
> -		if (!TestClearPageLRU(page))
> -			continue;
> +	sort_isopv(pvec, &isopv, lvaddr);
>  
> -		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
> -		(*move_fn)(page, lruvec);
> +	n = pagevec_count(&isopv);
> +	if (!n)
> +		return;
>  
> -		SetPageLRU(page);
> +	lruvec = (struct lruvec *)lvaddr[0];
> +	spin_lock_irqsave(&lruvec->lru_lock, flags);
> +
> +	for (i = 0; i < n; i++) {
> +		/* lock new lruvec if lruvec changes, we have sorted them */
> +		if (lruvec != (struct lruvec *)lvaddr[i]) {
> +			spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> +			lruvec = (struct lruvec *)lvaddr[i];
> +			spin_lock_irqsave(&lruvec->lru_lock, flags);
> +		}
> +
> +		(*move_fn)(isopv.pages[i], lruvec);
> +
> +		SetPageLRU(isopv.pages[i]);
>  	}
> -	if (lruvec)
> -		unlock_page_lruvec_irqrestore(lruvec, flags);
> -	release_pages(pvec->pages, pvec->nr);
> -	pagevec_reinit(pvec);
> +	spin_unlock_irqrestore(&lruvec->lru_lock, flags);
> +	release_pages(isopv.pages, isopv.nr);
>  }
>  
>  static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec)
> -- 
> 2.29.GIT
> 

-- 
Michal Hocko
SUSE Labs
