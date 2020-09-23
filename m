Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC1227534D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgIWIfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgIWIfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:35:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600850140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oL9dJa7Sz+aBGSWtLYyw5EsG81JS/XSkUyZ/FO8DkAA=;
        b=OsaHPaORyW9iBB/mj5nSBWLewvOPpg75VZPhX+NMhAuf/r36GR3WUxykibBUNDGsGFbePk
        QuP9lKUxh2hBuFVQDgnEUElHBycyR2nAbWOR8tGZHvpoNhAy0x5w97GM83ypRaSOqc8tWP
        mtCNeMw7qI8KR+PhQFLc66C7TlowIIE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ABBB7B226;
        Wed, 23 Sep 2020 08:36:17 +0000 (UTC)
Date:   Wed, 23 Sep 2020 10:35:34 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de,
        Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH 1/2] vmalloc: Free pages as a batch
Message-ID: <20200923083534.GE4887@dhcp22.suse.cz>
References: <20200921224628.20704-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921224628.20704-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 21-09-20 23:46:27, Matthew Wilcox wrote:
> Use release_pages() to free the pages allocated by vmalloc().  This is
> slightly more efficient in terms of disabling and enabling IRQs once
> per batch instead of once per page.

Hmm, does this really lead to runtime improvements? Batching IRQ is
certainly nice but release_pages is much more heavy weight and all
additional checks are simply always false for vmalloc pages so all those
checks are pointless.

Maybe storing those pages into the linked list and use
free_unref_page_list instead would achieve what you want?

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/vmalloc.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index be4724b916b3..3893fc8915c4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2263,16 +2263,8 @@ static void __vunmap(const void *addr, int deallocate_pages)
>  	vm_remove_mappings(area, deallocate_pages);
>  
>  	if (deallocate_pages) {
> -		int i;
> -
> -		for (i = 0; i < area->nr_pages; i++) {
> -			struct page *page = area->pages[i];
> -
> -			BUG_ON(!page);
> -			__free_pages(page, 0);
> -		}
> +		release_pages(area->pages, area->nr_pages);
>  		atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
> -
>  		kvfree(area->pages);
>  	}
>  
> -- 
> 2.28.0

-- 
Michal Hocko
SUSE Labs
