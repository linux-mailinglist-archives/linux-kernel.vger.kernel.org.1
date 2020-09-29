Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E2E27D098
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbgI2OG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgI2OG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:06:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33614C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=viXSxvUTI8HhUOod2bOuMX3/wUHqXf4haaO3VlhNCpQ=; b=teujRbnGhuAVQFaJzPZg7wrFDB
        3zeBOvrZ+vk2DrwJw87lkPJjUWurJyxwxPPlhOPyQqvEB/ljnl6sP9jWi+VTcXcy2hFwRjQwCGtbV
        PQlDh5WBlEJIiU6AQilTAsj+kCeN+iakY4wYjCEfM5W7yXqF0OuamrmxEzFT3AsEbsVRaNH3BwpaM
        Z+Kqy+tnAHiKrsw6C8zkdDdwXmFy0t3LgtcxhnAjZYrER58he7YhvNkOWPui29sjj1fC7k/NsPEgs
        qZdGI+Hs77Bc9byL3yHm629h0YxmAdg/BU7yBX2c2M6NCC0J2+GjV2N/Y3OURB+aSCKBRQ3GOPLmV
        T9WGVDXQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNGGs-0004G1-Op; Tue, 29 Sep 2020 14:06:22 +0000
Date:   Tue, 29 Sep 2020 15:06:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de, rdunlap@infradead.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-ID: <20200929140622.GE20115@casper.infradead.org>
References: <20200926213919.26642-1-willy@infradead.org>
 <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
 <20200929034026.GA20115@casper.infradead.org>
 <20200929072622.GN2645148@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929072622.GN2645148@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 10:26:22AM +0300, Mike Rapoport wrote:
> This sentence presumes existing description/prior knowledge about
> put_page().
> 
> Maybe
> 
>   This function can free multi-page allocations that were not allocated
>   with %__GFP_COMP, unlike put_page() that would free only the first page
>   in such case. __free_pages() does not ...

Thanks.  After waking up this morning I did a more extensive rewrite:

/**
 * __free_pages - Free pages allocated with alloc_pages().
 * @page: The page pointer returned from alloc_pages().
 * @order: The order of the allocation.
 *
 * This function can free multi-page allocations that are not compound
 * pages.  It does not check that the @order passed in matches that of
 * the allocation, so it is easy to leak memory.  Freeing more memory
 * than was allocated will probably emit a warning.
 *
 * If the last reference to this page is speculative, it will be released
 * by put_page() which only frees the first page of a non-compound
 * allocation.  To prevent the remaining pages from being leaked, we free
 * the subsequent pages here.  If you want to use the page's reference
 * count to decide when to free the allocation, you should allocate a
 * compound page, and use put_page() instead of __free_pages().
 *
 * Context: May be called in interrupt context or holding a normal
 * spinlock, but not in NMI context or while holding a raw spinlock.
 */

