Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DC27BFED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgI2Iq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:46:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:54800 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgI2Iq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:46:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2AE81ACA3;
        Tue, 29 Sep 2020 08:46:54 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D591D1E12E9; Tue, 29 Sep 2020 10:46:53 +0200 (CEST)
Date:   Tue, 29 Sep 2020 10:46:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] mm/filemap: Add mapping_seek_hole_data
Message-ID: <20200929084653.GC10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-5-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:34, Matthew Wilcox (Oracle) wrote:
> Rewrite shmem_seek_hole_data() and move it to filemap.c.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
...
> +/**
> + * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
> + * @mapping: Address space to search.
> + * @start: First byte to consider.
> + * @end: Limit of search (exclusive).
> + * @whence: Either SEEK_HOLE or SEEK_DATA.
> + *
> + * If the page cache knows which blocks contain holes and which blocks
> + * contain data, your filesystem can use this function to implement
> + * SEEK_HOLE and SEEK_DATA.  This is useful for filesystems which are
> + * entirely memory-based such as tmpfs, and filesystems which support
> + * unwritten extents.
> + *
> + * Return: The requested offset on successs, or -ENXIO if @whence specifies
> + * SEEK_DATA and there is no data after @start.  There is an implicit hole
> + * after @end - 1, so SEEK_HOLE returns @end if all the bytes between @start
> + * and @end contain data.
> + */
> +loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
> +		loff_t end, int whence)
> +{
> +	XA_STATE(xas, &mapping->i_pages, start >> PAGE_SHIFT);
> +	pgoff_t max = (end - 1) / PAGE_SIZE;
> +	bool seek_data = (whence == SEEK_DATA);
> +	struct page *page;
> +
> +	if (end <= start)
> +		return -ENXIO;
> +
> +	rcu_read_lock();
> +	while ((page = xas_find_get_entry(&xas, max, XA_PRESENT))) {
> +		loff_t pos = xas.xa_index * PAGE_SIZE;

OK, but for ordinary filesystems this could be problematic because of
exceptional entries?

Also for shmem you've dropped the PageUptodate check which I'm not sure is
safe?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
