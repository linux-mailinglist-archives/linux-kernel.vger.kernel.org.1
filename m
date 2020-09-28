Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6527B60A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgI1UNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1UNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:13:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6464DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 13:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=t2Q0uIBZ/RzOgL5GzysOkr7fCQhRlmEFsQdJ/RR5oT0=; b=Hh0jWyOLmF2ubwBcGSJg9VHd0c
        00enI/j0nkFWm9hZNU3/FCYw7ZgJ0g8eCVenH3BCTKdaYtaTQFNYEveagYc51mzw+FQiUPpLgkWJH
        FZARv2Fb0LOfTartGA6NV2F1P5kRnIAR3ZfizO1mWvGGG8jN+HcuFWhwYvBY8yxXon7TJzLXirxGJ
        KxkwaeI7DYNuwgI6LOEsAURn4Z7d8PZmnBMiLrm4AFjuhl5NdBeL/NQm41JtJrJ0ENMIIsWFFZyEv
        EltP7D0BscL07X6zUliaCskgs24B2vaeSADDRMdPyBKk01rEH9lZ2BuxT+y1JwRYg8rVw2Oc7neIW
        32u1/wOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMzWg-00022X-DV; Mon, 28 Sep 2020 20:13:34 +0000
Date:   Mon, 28 Sep 2020 21:13:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] Overhaul multi-page lookups for THP
Message-ID: <20200928201334.GC30994@casper.infradead.org>
References: <20200914130042.11442-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914130042.11442-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ping

On Mon, Sep 14, 2020 at 02:00:30PM +0100, Matthew Wilcox (Oracle) wrote:
> The critical patch to review here is patch 11, "Handle truncates that
> split THPs".  This code is shared with shmem, and while xfstests passes
> (both with the tmpfs filesystem and with THPs enabled for XFS), it is
> terribly subtle.
> 
> I posted a similar patch series a few weeks ago [1], but this goes a few
> steps further than that one did.  In addition to the unification of
> find_get_entries() and pagevec_lookup_entries(), this patch series
> includes:
> 
>  - Only return the head pages from tagged lookups
>  - Factor a lot of common code out of the various batch lookup routines
>  - Add mapping_seek_hole_data()
>  - Only return head pages from find_get_entries
> 
> I also have a patch to iomap to use mapping_seek_hole_data(), but I'm
> not including that as part of this batch of patches -- I'll send it
> through the iomap tree once mapping_seek_hole_data() lands upstream.
> 
> [1] https://lore.kernel.org/linux-mm/20200819184850.24779-1-willy@infradead.org/
> 
> Matthew Wilcox (Oracle) (12):
>   mm: Make pagecache tagged lookups return only head pages
>   mm/shmem: Use pagevec_lookup in shmem_unlock_mapping
>   mm/filemap: Add helper for finding pages
>   mm/filemap: Add mapping_seek_hole_data
>   mm: Add and use find_lock_entries
>   mm: Add an 'end' parameter to find_get_entries
>   mm: Add an 'end' parameter to pagevec_lookup_entries
>   mm: Remove nr_entries parameter from pagevec_lookup_entries
>   mm: Pass pvec directly to find_get_entries
>   mm: Remove pagevec_lookup_entries
>   mm/truncate,shmem: Handle truncates that split THPs
>   mm/filemap: Return only head pages from find_get_entries
> 
>  include/linux/pagemap.h |   5 +-
>  include/linux/pagevec.h |   4 -
>  mm/filemap.c            | 267 +++++++++++++++++++++++++++-------------
>  mm/internal.h           |   5 +
>  mm/shmem.c              | 214 +++++++-------------------------
>  mm/swap.c               |  38 +-----
>  mm/truncate.c           | 249 ++++++++++++++-----------------------
>  7 files changed, 329 insertions(+), 453 deletions(-)
> 
> -- 
> 2.28.0
> 
