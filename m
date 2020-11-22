Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD72BC5A7
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgKVMi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 07:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727424AbgKVMi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 07:38:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79704C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 04:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5mvrRco+6zDGbq0cuOCU8qWHo3zdUAHcOoBWofVG+/0=; b=QtJc18e2apC1W/CyNfkvR0zpEP
        Fw/0fegddaFknahWzsUFAeu9F2rAzuiR3z1/uknYKyZjUH+nIuerKGiSvfPSGByafKI4sL8ZeUEWa
        N7U1feR2h05JO4TUetarLx8/qL2jmGWlwSRMMqQSkMDjJaovi2n5r9av3X/mInUSnkNsKyrQxoX8b
        /iI2xFjhJKXo7HTPY9pUgt5t2kmjWOZxVwnfp+Mx9sVsTLmywRJo8dlfLAvZcYQwIvXrCVn1Mwl29
        fVpqpghkhf3iFzbYFkkwE7UZXg1RSe7q+GjVc2K/SQ+DE88uwbyg944g3u3xM8KE34kgFwxOGWyLp
        6tCYilaA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kgoau-0001qG-HR; Sun, 22 Nov 2020 12:35:52 +0000
Date:   Sun, 22 Nov 2020 12:35:52 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mm/vmscan: __isolate_lru_page_prepare clean up
Message-ID: <20201122123552.GF4327@casper.infradead.org>
References: <1605859413-53864-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201120151307.4d9e3ef092ba01a325db7ce2@linux-foundation.org>
 <a355270e-5949-ebb2-30cb-a3723f6c93f8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a355270e-5949-ebb2-30cb-a3723f6c93f8@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 08:00:19PM +0800, Alex Shi wrote:
>  mm/compaction.c |  2 +-
>  mm/vmscan.c     | 69 +++++++++++++++++++++++--------------------------
>  2 files changed, 34 insertions(+), 37 deletions(-)

How is it possible you're changing the signature of a function without
touching a header file?  Surely __isolate_lru_page_prepare() must be declared
in mm/internal.h ?

> +++ b/mm/vmscan.c
> @@ -1536,19 +1536,17 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>   * page:	page to consider
>   * mode:	one of the LRU isolation modes defined above
>   *
> - * returns 0 on success, -ve errno on failure.
> + * returns ture on success, false on failure.

"true".

> @@ -1674,35 +1672,34 @@ static unsigned long isolate_lru_pages(unsigned long nr_to_scan,
>  		 * only when the page is being freed somewhere else.
>  		 */
>  		scan += nr_pages;
> -		switch (__isolate_lru_page_prepare(page, mode)) {
> -		case 0:
> +		if (!__isolate_lru_page_prepare(page, mode)) {
> +			/* else it is being freed elsewhere */

I don't think the word "else" helps here.  Just
			/* It is being freed elsewhere */

> +		if (!TestClearPageLRU(page)) {
>  			/*
> +			 * This page may in other isolation path,
> +			 * but we still hold lru_lock.
>  			 */

I don't think this comment helps me understand what's going on here.
Maybe:

			/* Another thread is already isolating this page */

> +			put_page(page);
>  			list_move(&page->lru, src);
> +			continue;
>  		}
