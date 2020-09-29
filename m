Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71727C09E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgI2JNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:13:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:55442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgI2JNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1FC37AC3C;
        Tue, 29 Sep 2020 09:13:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C86D31E12E9; Tue, 29 Sep 2020 11:13:48 +0200 (CEST)
Date:   Tue, 29 Sep 2020 11:13:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/12] mm: Make pagecache tagged lookups return only
 head pages
Message-ID: <20200929091348.GI10896@quack2.suse.cz>
References: <20200914130042.11442-1-willy@infradead.org>
 <20200914130042.11442-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-09-20 14:00:31, Matthew Wilcox (Oracle) wrote:
> Pagecache tags are used for dirty page writeback.  Since dirtiness is
> tracked on a per-THP basis, we only want to return the head page rather
> than each subpage of a tagged page.  All the filesystems which use huge
> pages today are in-memory, so there are no tagged huge pages today.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index f5fda3038782..7d8cf1a25628 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1968,7 +1968,7 @@ unsigned find_get_pages_contig(struct address_space *mapping, pgoff_t index,
>  EXPORT_SYMBOL(find_get_pages_contig);
>  
>  /**
> - * find_get_pages_range_tag - find and return pages in given range matching @tag
> + * find_get_pages_range_tag - Find and return head pages matching @tag.
>   * @mapping:	the address_space to search
>   * @index:	the starting page index
>   * @end:	The final page index (inclusive)
> @@ -1976,8 +1976,8 @@ EXPORT_SYMBOL(find_get_pages_contig);
>   * @nr_pages:	the maximum number of pages
>   * @pages:	where the resulting pages are placed
>   *
> - * Like find_get_pages, except we only return pages which are tagged with
> - * @tag.   We update @index to index the next page for the traversal.
> + * Like find_get_pages(), except we only return head pages which are tagged
> + * with @tag.   We update @index to index the next page for the traversal.
>   *
>   * Return: the number of pages which were found.
>   */
> @@ -2011,9 +2011,9 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
>  		if (unlikely(page != xas_reload(&xas)))
>  			goto put_page;
>  
> -		pages[ret] = find_subpage(page, xas.xa_index);
> +		pages[ret] = page;
>  		if (++ret == nr_pages) {
> -			*index = xas.xa_index + 1;
> +			*index = page->index + thp_nr_pages(page);
>  			goto out;
>  		}
>  		continue;
> -- 
> 2.28.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
