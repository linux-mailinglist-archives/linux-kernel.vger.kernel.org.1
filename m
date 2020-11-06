Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8762A923B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgKFJQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:16:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:54544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgKFJQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:16:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3DB2EAF1A;
        Fri,  6 Nov 2020 09:16:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0463B1E1312; Fri,  6 Nov 2020 10:16:03 +0100 (CET)
Date:   Fri, 6 Nov 2020 10:16:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mhocko@suse.com, ziy@nvidia.com, songliubraving@fb.com,
        mgorman@suse.de, jack@suse.cz, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: truncate_complete_page is not existed anymore
Message-ID: <20201106091602.GB25479@quack2.suse.cz>
References: <20201103130334.13468-1-shy828301@gmail.com>
 <20201103130334.13468-2-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103130334.13468-2-shy828301@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-11-20 05:03:30, Yang Shi wrote:
> The commit 9f4e41f4717832e34cca153ced62b4a1d7e26c0e ("mm: refactor
> truncate_complete_page()") refactored truncate_complete_page(), and it
> is not existed anymore, correct the comment in vmscan and migrate to avoid
> confusion.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Thanks! Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/migrate.c | 2 +-
>  mm/vmscan.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 5ca5842df5db..8a2e7e19e27b 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1106,7 +1106,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
>  	 * and treated as swapcache but it has no rmap yet.
>  	 * Calling try_to_unmap() against a page->mapping==NULL page will
>  	 * trigger a BUG.  So handle it here.
> -	 * 2. An orphaned page (see truncate_complete_page) might have
> +	 * 2. An orphaned page (see truncate_cleanup_page) might have
>  	 * fs-private metadata. The page can be picked up due to memory
>  	 * offlining.  Everywhere else except page reclaim, the page is
>  	 * invisible to the vm, so the page can not be migrated.  So try to
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1b8f0e059767..165cca87edc8 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1393,7 +1393,7 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>  		 *
>  		 * Rarely, pages can have buffers and no ->mapping.  These are
>  		 * the pages which were not successfully invalidated in
> -		 * truncate_complete_page().  We try to drop those buffers here
> +		 * truncate_cleanup_page().  We try to drop those buffers here
>  		 * and if that worked, and the page is no longer mapped into
>  		 * process address space (page_count == 1) it can be freed.
>  		 * Otherwise, leave the page on the LRU so it is swappable.
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
