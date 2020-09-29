Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E04127CDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387490AbgI2MsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbgI2MsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:48:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804B0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 05:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/97h64tIJwyLQyzv5Dro7vzAYTz4jYB25Nlue1WuQiU=; b=khvgauTxg+7IG6QAlN+P1O/0Os
        7NkmsSgU4ivSgLJTK+vkAYTcBJ+Zfk2ZzbnQE/Gh3N/Wt3ZQtVF02Gh9dw6ECdcBqKVx2jrcA0NOR
        FjALslkEAhVMevICUsFjDwv84emfeo9ERAJSwoKikNCkc1O17af3KVct76RECeTOPgLw+Z8t2OZQ7
        GQfSF2Ax51kYj+H8DKkQzBZ+gcfDPjAMJkjnjbLzYVGRp7BZEycDbr7fTTffp2LUoeiyyDod/67ad
        1obaXnbic+67x0Xd7QWmqhYPFRubMglg8Vn+u8CussEhkdUlrBdWCQ491pLi2X5PcjcTlUfzSw4/8
        kh+0b2yQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNF38-0006g3-OY; Tue, 29 Sep 2020 12:48:06 +0000
Date:   Tue, 29 Sep 2020 13:48:06 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] mm: Add and use find_lock_entries
Message-ID: <20200929124806.GC20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-6-willy@infradead.org>
 <20200929085855.GD10896@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929085855.GD10896@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:58:55AM +0200, Jan Kara wrote:
> On Mon 14-09-20 14:00:35, Matthew Wilcox (Oracle) wrote:
> > We have three functions (shmem_undo_range(), truncate_inode_pages_range()
> > and invalidate_mapping_pages()) which want exactly this function, so
> > add it to filemap.c.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > diff --git a/mm/shmem.c b/mm/shmem.c
> ...
> > index b65263d9bb67..a73ce8ce28e3 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -905,12 +905,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> >  
> >  	pagevec_init(&pvec);
> >  	index = start;
> > -	while (index < end) {
> > -		pvec.nr = find_get_entries(mapping, index,
> > -			min(end - index, (pgoff_t)PAGEVEC_SIZE),
> > -			pvec.pages, indices);
> > -		if (!pvec.nr)
> > -			break;
> > +	while (index < end && find_lock_entries(mapping, index, end - 1,
> > +			&pvec, indices)) {
> >  		for (i = 0; i < pagevec_count(&pvec); i++) {
> >  			struct page *page = pvec.pages[i];
> >  
> > @@ -925,18 +921,10 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> >  								index, page);
> >  				continue;
> >  			}
> > +			index += thp_nr_pages(page) - 1;
> >  
> > -			VM_BUG_ON_PAGE(page_to_pgoff(page) != index, page);
> > -
> > -			if (!trylock_page(page))
> > -				continue;
> > -
> > -			if ((!unfalloc || !PageUptodate(page)) &&
> > -			    page_mapping(page) == mapping) {
> > -				VM_BUG_ON_PAGE(PageWriteback(page), page);
> > -				if (shmem_punch_compound(page, start, end))
> > -					truncate_inode_page(mapping, page);
> > -			}
> > +			if (!unfalloc || !PageUptodate(page))
> > +				truncate_inode_page(mapping, page);
> 
> Is dropping shmem_punch_compound() really safe? AFAICS it can also call
> split_huge_page() which will try to split THP to be able to truncate it.
> That being said there's another loop in shmem_undo_range() which will try
> again so what you did might make a difference with performance but not much
> else. But still it would be good to at least comment about this in the
> changelog...

OK, I need to provide better argumentation in the changelog.

shmem_punch_compound() handles partial THPs.  By the end of this series,
we handle the partial pages in the next part of the function ... the
part where we're handling partial PAGE_SIZE pages.  At this point in
the series, it's safe to remove the shmem_punch_compound() call because
the new find_lock_entries() loop will only return THPs that lie entirely
within the range.
