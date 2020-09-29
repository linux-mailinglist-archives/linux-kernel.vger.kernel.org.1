Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3895327B92C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgI2BDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgI2BDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:03:09 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91BDA207C4;
        Tue, 29 Sep 2020 01:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601341388;
        bh=qUqNMPceAYwULHvwzL9M1XQiqeX3zMRo9KGrVYcVkjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=obogJ7/blmlFwHh/iTIA/RUNLMj7jn6jcs7QiXkMIruzgBluF9VFsVfT3i15rgo7O
         XbQJ1BDtk1Q6M+lMrbdoR5ZTN5JZ/xgxWJvJeVPWtXFrEkS91d7lN8T3IAVHH8UvKa
         gt7PQeeXFm+elZPC6zZ3J2gzctGqE/Ey1Q5hOAW8=
Date:   Mon, 28 Sep 2020 18:03:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-Id: <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
In-Reply-To: <20200926213919.26642-1-willy@infradead.org>
References: <20200926213919.26642-1-willy@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 22:39:19 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Here is a very rare race which leaks memory:

Not worth a cc:stable?

> Page P0 is allocated to the page cache.  Page P1 is free.
> 
> Thread A                Thread B                Thread C
> find_get_entry():
> xas_load() returns P0
> 						Removes P0 from page cache
> 						P0 finds its buddy P1
> 			alloc_pages(GFP_KERNEL, 1) returns P0
> 			P0 has refcount 1
> page_cache_get_speculative(P0)
> P0 has refcount 2
> 			__free_pages(P0)

			__free_pages(P0, 1), I assume.

> 			P0 has refcount 1
> put_page(P0)

but this is implicitly order 0

> P1 is not freed

huh.

> Fix this by freeing all the pages in __free_pages() that won't be freed
> by the call to put_page().  It's usually not a good idea to split a page,
> but this is a very unlikely scenario.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4947,6 +4947,9 @@ void __free_pages(struct page *page, unsigned int order)
>  {
>  	if (put_page_testzero(page))
>  		free_the_page(page, order);
> +	else if (!PageHead(page))
> +		while (order-- > 0)
> +			free_the_page(page + (1 << order), order);

Well that's weird and scary looking.  `page' has non-zero refcount yet
we go and free random followon pages.  Methinks it merits an
explanatory comment?
