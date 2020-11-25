Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263E2C3B78
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgKYI6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgKYI6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:58:25 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6735F206F7;
        Wed, 25 Nov 2020 08:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606294704;
        bh=8Q4bTxIUuJKKptiq+uTMfjcIsOJnS/D6f/eeKCwPg8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/jNOA/1Kqu8E37w9KQd65Aq1/1d32e7vY1YyX/WKrzDHTaU7uINHclRnz7FZw+XE
         37d1eZORSIDtx1GQmaUzDCweunoQum5x66x9ciwmg3yQ3tyiYW1h8gTYOlWvjgVIDu
         l+t3Ns5bkM402Ax/r66GOBu3pB8TDMmZCwgg5+hI=
Date:   Wed, 25 Nov 2020 10:58:18 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     akpm@linux-foundation.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm: Move free_unref_page to mm/internal.h
Message-ID: <20201125085818.GM8537@kernel.org>
References: <20201125034655.27687-1-willy@infradead.org>
 <20201125034655.27687-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125034655.27687-2-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 03:46:55AM +0000, Matthew Wilcox (Oracle) wrote:
> Code outside mm/ should not be calling free_unref_page().  Also
> move free_unref_page_list().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  include/linux/gfp.h | 2 --
>  mm/internal.h       | 3 +++
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index c603237e006c..6e479e9c48ce 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -580,8 +580,6 @@ void * __meminit alloc_pages_exact_nid(int nid, size_t size, gfp_t gfp_mask);
>  
>  extern void __free_pages(struct page *page, unsigned int order);
>  extern void free_pages(unsigned long addr, unsigned int order);
> -extern void free_unref_page(struct page *page);
> -extern void free_unref_page_list(struct list_head *list);
>  
>  struct page_frag_cache;
>  extern void __page_frag_cache_drain(struct page *page, unsigned int count);
> diff --git a/mm/internal.h b/mm/internal.h
> index 75ae680d0a2c..5864815947fe 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -201,6 +201,9 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
>  					gfp_t gfp_flags);
>  extern int user_min_free_kbytes;
>  
> +extern void free_unref_page(struct page *page);
> +extern void free_unref_page_list(struct list_head *list);
> +
>  extern void zone_pcp_update(struct zone *zone);
>  extern void zone_pcp_reset(struct zone *zone);
>  extern void zone_pcp_disable(struct zone *zone);
> -- 
> 2.29.2
> 

-- 
Sincerely yours,
Mike.
