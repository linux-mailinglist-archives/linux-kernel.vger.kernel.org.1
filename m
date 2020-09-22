Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E85227445E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVOgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVOgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:36:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F4DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 07:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=u3YeIXCT+AG4vi1F0coTjYeWDIv5hXBb8Fo6mRGjaEQ=; b=S1ylR72KAde9/JozVWndgysyCo
        zrOd6tCZswcFuJIwKAu89x4A8JIBKHl98dBDgJyYg2rf8T5eoW26aLR/ZdxUu7jPGiDrZHDZ6YBYk
        lLY1HgX6sDbwJ+QZmrTh4JKOvcWp7jjqE7giQLRsEl1Aeitc0pf+Eyk3h7QTYa/dlt+Six5R6RI63
        KvZGYOhoDm/prGFwcJxMtEkPI+llcUIdMIYvEqp0A2FBS2rcFpuiszeuKBYGarEwXIJCF5DLD0sks
        xW4wKVqlEs3CaW2600c28KwpWr0gvE3r92zdwzeSfGwCJaJ8DJ7wkzkrXFSV7ejDBK/eK9uQtAqrQ
        JOSJMqnA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKjOh-0000kW-QN; Tue, 22 Sep 2020 14:35:59 +0000
Date:   Tue, 22 Sep 2020 15:35:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Piggin <npiggin@suse.de>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Daisuke Nishimura <nishimura@mxp.nes.nec.co.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page_alloc: Fix freeing non-compound pages
Message-ID: <20200922143559.GF32101@casper.infradead.org>
References: <20200922140017.26387-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922140017.26387-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 03:00:17PM +0100, Matthew Wilcox (Oracle) wrote:
>  void __free_pages(struct page *page, unsigned int order)
>  {
>  	if (put_page_testzero(page))
>  		free_the_page(page, order);
> +	else
> +		while (order-- > 0)
> +			free_the_page(page + (1 << order), order);
>  }
>  EXPORT_SYMBOL(__free_pages);

... a three line patch and one of them is wrong.

-       else
+       else if (!PageHead(page))

Anyone got a smart idea about how to _test_ this code path?  I'm
wondering about loading one kernel module which wanders through memmap
calling
	if (page_cache_get_speculative(page)) put_page(page);
and another kernel module that calls
	__free_pages(alloc_page(GFP_KERNEL, 1), 1);

and putting in a printk to let me know when we hit it.
