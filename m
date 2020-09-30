Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF427EB68
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgI3Ova (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730107AbgI3Ova (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:51:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3118DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W4DdKoxfvdKsR8PRimAS7ldYMonqH3ldpjLy8Yobicg=; b=s6lW8g8/tKXaBJs3rxSlbvUNJA
        hFxZ7gOhGXgfbeJ/YxLKWpuCIblP0e3j7k997PlaZVgtRPe6ys+Mk1iM6D+QaX2OG+5JuScfyLrr4
        IfrxjIEv1vRpf229BAxp5IpUDVoAIrinRAL+nT/K7+DKYeMoVYsr+FqgeR5DLy1rM+oJHTOGeHGrw
        MCUwWJkcNytj4pjUmk9ektPnD2zfvoTAc6oWI0MAuEh20Lh5c4OIBbc91INP95rwPQgiR54RmvH+p
        kN28qGuWq9l1QP9RJFZBAUGonyvmJSAx9Askw7QydzGJQe9BSBKW90t5oGMcry9F2bhuN0jp/Un3v
        uwoBWRgg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNdRr-000651-0H; Wed, 30 Sep 2020 14:51:15 +0000
Date:   Wed, 30 Sep 2020 15:51:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] mm/truncate,shmem: Handle truncates that split
 THPs
Message-ID: <20200930145114.GQ20115@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-12-willy@infradead.org>
 <20200930115919.GS10896@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930115919.GS10896@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:59:19PM +0200, Jan Kara wrote:
> > @@ -931,33 +904,39 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> >  		index++;
> >  	}
> >  
> > -	if (partial_start) {
> > -		struct page *page = NULL;
> > -		shmem_getpage(inode, start - 1, &page, SGP_READ);
> > -		if (page) {
> > -			unsigned int top = PAGE_SIZE;
> > -			if (start > end) {
> > -				top = partial_end;
> > -				partial_end = 0;
> > -			}
> > -			zero_user_segment(page, partial_start, top);
> > -			set_page_dirty(page);
> > -			unlock_page(page);
> > -			put_page(page);
> > +	index = -1;
> > +	if (end != -1 && ((lend + 1) % PAGE_SIZE))
> 				    ^^
> Hum, is this guaranteed to compile properly on 32-bit archs without
> optimization? It would be 64-bit division... Maybe we don't care, it just
> caught my eye...

Looks like GCC properly reduces it:

00000000 <f>:
int f(long long x)
{
	if ((x + 1) % 4096)
   0:	8b 44 24 04          	mov    0x4(%esp),%eax
   4:	83 c0 01             	add    $0x1,%eax
   7:	25 ff 0f 00 00       	and    $0xfff,%eax
   c:	0f 95 c0             	setne  %al
   f:	0f b6 c0             	movzbl %al,%eax
		return 1;
	return 0;
}
  12:	c3                   	ret    

> BTW you could just drop end != -1 part because end == -1 iff lend == -1 so
> (lend + 1) % PAGE_SIZE is stronger.

Yes.  I think that actually makes it easier to read.

> > +		index = lend >> PAGE_SHIFT;
> > +	page = NULL;
> > +	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
> > +	if (page) {
> > +		bool same_page;
> > +
> > +		page = thp_head(page);
> > +		same_page = lend + 1 < page_offset(page) + thp_size(page);
> 			    ^^^^^^^^ Just lend here?

Oops.  Yes.  If lstart is 4096 and lend is 8191, this is definitely same_page.

> > -	if (partial_end) {
> > -		struct page *page = NULL;
> > +
> > +	if (index != -1)
> >  		shmem_getpage(inode, end, &page, SGP_READ);
> > -		if (page) {
> > -			zero_user_segment(page, 0, partial_end);
> > -			set_page_dirty(page);
> > -			unlock_page(page);
> > -			put_page(page);
> > -		}
> > +	if (page) {
> > +		page = thp_head(page);
> > +		set_page_dirty(page);
> > +		if (!truncate_inode_partial_page(page, lstart, lend))
> > +			end = page->index;
> > +		unlock_page(page);
> > +		put_page(page);
> >  	}
> > -	if (start >= end)
> > -		return;
> 
> You use 'index' effectively as bool in all of the above (only ever check
> index != -1). And effectively you only use it to communicate whether tail
> partial page got already handled or not. Maybe there's some less cryptic
> way to achieve that? Even separate bool just for that would be probably
> better that this.

As you note below, it makes more sense in truncate.c and for my own
sanity I was trying to keep the two functions as similar as possible.
I'm not sure why I looked up the page with 'end' instead of 'index'.

This didn't end up being as big a simplification as I thought it was going
to be.  I think I'll reintroduce partial_end as a bool, like you suggest.

> >  	index = start;
> >  	while (index < end) {
> 
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index d62aeffbffcc..06ed2f93069d 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -224,6 +224,53 @@ int truncate_inode_page(struct address_space *mapping, struct page *page)
> >  	return 0;
> >  }
> >  
> > +/*
> > + * Handle partial (transparent) pages.  The page may be entirely within the
> > + * range if a split has raced with us.  If not, we zero the part of the
> > + * page that's within the (start, end] range, and then split the page if
>                              ^ '[' here - start is inclusive as well...

Good point.

> > + * it's a THP.  split_page_range() will discard pages which now lie beyond
> > + * i_size, and we rely on the caller to discard pages which lie within a
> > + * newly created hole.
> > + *
> > + * Returns false if THP splitting failed so the caller can can avoid
> 							  ^^^^^^^ just 'can'

You're going to put Randy out of a job ;-)

