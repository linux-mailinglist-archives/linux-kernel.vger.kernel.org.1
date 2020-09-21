Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C364427328E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgIUTMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbgIUTMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:12:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E052BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8o7GVAomh929Hvy+xaXufBwE8CQqTnicVvJhMbCZ9+k=; b=mehcTMqJtwQu3rPUjsEisC7ECq
        7+58K3Z4EekBFXZ3wYEUeQuCa/fWdcNhiPeHAeErok/v8ZUYK3e3gg5/B4dsAsGOOcHKMJll0ZrgT
        uIxyCNSUGOAg2UN4gsizGdkbduG7XDlLurQP7j3hPoeoUDi05V5iO3YFhaKjX5x3pQ8mdKFxJmqgA
        L9SsTOYSux1ZLBO0Whate1mY/A8G4ym2vhOpFFpaMiIWVUAzrHfwOrb8cuL3VnUqrmtLSbCIIumHR
        mHpwBBr1xVe0+QICrLKcrhz2TwTDJC2BnukZFO6wyPDyqecyMJcK7af7LQwFO3njp1VzvRCXlr6uE
        ADgc0Q1w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKRED-0003Cg-2P; Mon, 21 Sep 2020 19:11:57 +0000
Date:   Mon, 21 Sep 2020 20:11:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/6] drm/i915: use vmap in shmem_pin_map
Message-ID: <20200921191157.GX32101@casper.infradead.org>
References: <20200918163724.2511-1-hch@lst.de>
 <20200918163724.2511-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918163724.2511-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 06:37:21PM +0200, Christoph Hellwig wrote:
>  void shmem_unpin_map(struct file *file, void *ptr)
>  {
> +	long i = shmem_npages(file);
> +
>  	mapping_clear_unevictable(file->f_mapping);
> -	__shmem_unpin_map(file, ptr, shmem_npte(file));
> +	vunmap(ptr);
> +
> +	for (i = 0; i < shmem_npages(file); i++) {
> +		struct page *page;
> +
> +		page = shmem_read_mapping_page_gfp(file->f_mapping, i,
> +						   GFP_KERNEL);
> +		if (!WARN_ON(IS_ERR(page))) {
> +			put_page(page);
> +			put_page(page);
> +		}
> +	}
>  }

This is awkward.  I'd like it if we had a vfree() variant which called
put_page() instead of __free_pages().  I'd like it even more if we
used release_pages() instead of our own loop that called put_page().

Perhaps something like this ...

+++ b/mm/vmalloc.c
@@ -2262,7 +2262,7 @@ static void __vunmap(const void *addr, int deallocate_page
s)
 
        vm_remove_mappings(area, deallocate_pages);
 
-       if (deallocate_pages) {
+       if (deallocate_pages == 1) {
                int i;
 
                for (i = 0; i < area->nr_pages; i++) {
@@ -2271,8 +2271,12 @@ static void __vunmap(const void *addr, int deallocate_pages)
                        BUG_ON(!page);
                        __free_pages(page, 0);
                }
-               atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
+       } else if (deallocate_pages == 2) {
+               release_pages(area->pages, area->nr_pages);
+       }
 
+       if (deallocate_pages) {
+               atomic_long_sub(area->nr_pages, &nr_vmalloc_pages);
                kvfree(area->pages);
        }
@@ -2369,6 +2373,14 @@ void vunmap(const void *addr)
 }
 EXPORT_SYMBOL(vunmap);
 
+void vunmap_put_pages(const void *addr)
+{
+       BUG_ON(in_interrupt());
+       might_sleep();
+       if (addr)
+               __vunmap(addr, 2);
+}
+
 /**
  * vmap - map an array of pages into virtually contiguous space
  * @pages: array of page pointers

only with kernel-doc and so on.  I bet somebody has a better idea for a name.
