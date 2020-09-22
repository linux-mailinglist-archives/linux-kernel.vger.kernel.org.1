Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4FC273A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgIVGNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729094AbgIVGNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:13:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED48C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:13:23 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so14602519otl.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WBUjk5sa2qSjZc05mc4Eihluz20Uyb3yXZp0vXYSAao=;
        b=WB/3I6zQHZvM8TfVLEJMlPFQrTIpfsU1zdOf1VurZPu72ZMZEaoo7SH356HOoSJJOw
         EKwBCy7d/TyKnNeXXKOUW5zk+bqIOjLHCJ6ZiSFyYEnC+Euj4h8fo14+jrnzeu2jgIBF
         53xrD3/b4xTaGC/iTpL/ulzQHeY26XpyZ/b+299hSLzBpDXltk+x+4eBjq7eYELQzz1x
         gKXJ+0lEUiZNnjiD6gENrAppDXE/pvR++XVaVbjUnX2tjQsXzoGS6TdcYZ0EtsVe4Bw3
         JcV/h1yIyD756SHiiB2UFeko7C0okLxWUaCBg6mcoEecwVx0KqJHQp0ZLszZ9HV/C8F7
         8bpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WBUjk5sa2qSjZc05mc4Eihluz20Uyb3yXZp0vXYSAao=;
        b=KPemcY4xyQICWDe4RIgBFFXVRv4lBRb3FZ5qVq3bTwjXjWlLiMr7O21aw/6qUCHVEh
         PE6KMBfw6zHRTAwItIhrMiyByhvYOCIrA9K+1Je1ns08sYY60gC88QDgPHtrCpNSYgGp
         Ipgv4/b/aCw9/PbbW66h75VvvS+dxnXgbvMw5MdiBrVmDxr8/kFkkxsuWetG/1CXKieg
         jE4b/q2mbqKoVxy7AN5sHpxVC180XjeLGhRyLUeCCCPCDJ8UUacYdEYGVJiHKy1gPd+g
         99ktrjiKHQtjyhVPzN7u230teEidXxUJ1pX8g5K+NbkD1PcOt4LA4O7DozucpAXdTyGk
         hXnw==
X-Gm-Message-State: AOAM532LSpdEVZ/YA8fsKH2G12UI9RC+Gd65klmLBDgorv1rCcbvtQuH
        B5rk+Bz5fYVQJ8DVZfb6+AO7NQ==
X-Google-Smtp-Source: ABdhPJxHTfoPta25AJAE5KGLMyigkV+kpo5kxM+XL4/T/LV9u02+BIX4BSvwURmGDy4M5Ox0xceunw==
X-Received: by 2002:a9d:2925:: with SMTP id d34mr1879677otb.140.1600755202300;
        Mon, 21 Sep 2020 23:13:22 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h135sm7396281oib.50.2020.09.21.23.13.19
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 21 Sep 2020 23:13:21 -0700 (PDT)
Date:   Mon, 21 Sep 2020 23:13:17 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v18 25/32] mm/mlock: remove lru_lock on TestClearPageMlocked
 in munlock_vma_page
In-Reply-To: <1598273705-69124-26-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2009212253320.6434@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <1598273705-69124-26-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020, Alex Shi wrote:

> In the func munlock_vma_page, the page must be PageLocked as well as
> pages in split_huge_page series funcs. Thus the PageLocked is enough
> to serialize both funcs.
> 
> So we could relief the TestClearPageMlocked/hpage_nr_pages which are not
> necessary under lru lock.
> 
> As to another munlock func __munlock_pagevec, which no PageLocked
> protection and should remain lru protecting.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

I made some comments on the mlock+munlock situation last week:
I won't review this 24/32 and 25/32 now, but will take a look
at your github tree tomorrow instead.  Perhaps I'll find you have
already done the fixes, perhaps I'll find you have merged these back
into earlier patches.  And I won't be reviewing beyond this point:
this is enough for now, I think.

Hugh

> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/mlock.c | 41 +++++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 26 deletions(-)
> 
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 0448409184e3..46a05e6ec5ba 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -69,9 +69,9 @@ void clear_page_mlock(struct page *page)
>  	 *
>  	 * See __pagevec_lru_add_fn for more explanation.
>  	 */
> -	if (!isolate_lru_page(page)) {
> +	if (!isolate_lru_page(page))
>  		putback_lru_page(page);
> -	} else {
> +	else {
>  		/*
>  		 * We lost the race. the page already moved to evictable list.
>  		 */
> @@ -178,7 +178,6 @@ static void __munlock_isolation_failed(struct page *page)
>  unsigned int munlock_vma_page(struct page *page)
>  {
>  	int nr_pages;
> -	struct lruvec *lruvec;
>  
>  	/* For try_to_munlock() and to serialize with page migration */
>  	BUG_ON(!PageLocked(page));
> @@ -186,37 +185,22 @@ unsigned int munlock_vma_page(struct page *page)
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
>  	/*
> -	 * Serialize split tail pages in __split_huge_page_tail() which
> -	 * might otherwise copy PageMlocked to part of the tail pages before
> -	 * we clear it in the head page. It also stabilizes thp_nr_pages().
> -	 * TestClearPageLRU can't be used here to block page isolation, since
> -	 * out of lock clear_page_mlock may interfer PageLRU/PageMlocked
> -	 * sequence, same as __pagevec_lru_add_fn, and lead the page place to
> -	 * wrong lru list here. So relay on PageLocked to stop lruvec change
> -	 * in mem_cgroup_move_account().
> +	 * Serialize split tail pages in __split_huge_page_tail() by
> +	 * lock_page(); Do TestClearPageMlocked/PageLRU sequence like
> +	 * clear_page_mlock().
>  	 */
> -	lruvec = lock_page_lruvec_irq(page);
> -
> -	if (!TestClearPageMlocked(page)) {
> +	if (!TestClearPageMlocked(page))
>  		/* Potentially, PTE-mapped THP: do not skip the rest PTEs */
> -		nr_pages = 1;
> -		goto unlock_out;
> -	}
> +		return 0;
>  
>  	nr_pages = thp_nr_pages(page);
>  	__mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
>  
> -	if (__munlock_isolate_lru_page(page, lruvec, true)) {
> -		unlock_page_lruvec_irq(lruvec);
> +	if (!isolate_lru_page(page))
>  		__munlock_isolated_page(page);
> -		goto out;
> -	}
> -	__munlock_isolation_failed(page);
> -
> -unlock_out:
> -	unlock_page_lruvec_irq(lruvec);
> +	else
> +		__munlock_isolation_failed(page);
>  
> -out:
>  	return nr_pages - 1;
>  }
>  
> @@ -305,6 +289,11 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
>  
>  		/* block memcg change in mem_cgroup_move_account */
>  		lock_page_memcg(page);
> +		/*
> +		 * Serialize split tail pages in __split_huge_page_tail() which
> +		 * might otherwise copy PageMlocked to part of the tail pages
> +		 * before we clear it in the head page.
> +		 */
>  		lruvec = relock_page_lruvec_irq(page, lruvec);
>  		if (TestClearPageMlocked(page)) {
>  			/*
> -- 
> 1.8.3.1
> 
> 
