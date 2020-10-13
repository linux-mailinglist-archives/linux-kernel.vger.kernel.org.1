Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EF428CE4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgJMM07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgJMM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:26:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A389AC0613D0;
        Tue, 13 Oct 2020 05:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Vx9B6T8bICpioAlzEd5JffMc8VKDN49NunY21LOeXI=; b=Ova8boCdYxsjqoPe5SgGZE9a6p
        c57sdOEboKXe4T0r4yu5+BaXyF6bxeK6h/AkSd9P1PFwhCTABSRnObkN5tzBMsNIN7QAeqvtG/z52
        vyRGfre4+fZ1yV3A1TzteDF1UguEyWSFaImr1dY0S0ylvb7nn9ARGzXeFPyvkQi7ugJOMx8Mphauz
        /pHUgavIymQvd0CpGVeTN9b8NU5kTIyoCpH1owGnqBlNCKcRwyYlnN3lnU1laEIzV0gOndI10mCBr
        WavkXbtSvJ1EzmLyvzAf3jKkiZlJjys8chkKnzmAlNi17Q/XlFRTUN7feyfJL8QM7kT4JzMMnMmnd
        t22YBLJQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSJOI-0006CZ-6I; Tue, 13 Oct 2020 12:26:54 +0000
Date:   Tue, 13 Oct 2020 13:26:54 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Kucharski <william.kucharski@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/24] mm: pagemap.h: fix two kernel-doc markups
Message-ID: <20201013122654.GE20115@casper.infradead.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <54ea6dd0fc37c48aef3fc3ae454c54a80db313dc.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54ea6dd0fc37c48aef3fc3ae454c54a80db313dc.1602590106.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:14:37PM +0200, Mauro Carvalho Chehab wrote:
> Changeset 6c8adf8446a3 ("mm: add find_lock_head") renamed the
> index parameter, but forgot to update the kernel-doc markups
> accordingly.

The patch is correct (thank you!), but the description here references
a git commit id that's only found in the -next tree and is unstable.

Andrew, can you fold this into the offending commit?

> Fixes: 6c8adf8446a3 ("mm: add find_lock_head")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/pagemap.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 7dd3523093db..932a260a29f2 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -342,9 +342,9 @@ static inline struct page *find_get_page_flags(struct address_space *mapping,
>  /**
>   * find_lock_page - locate, pin and lock a pagecache page
>   * @mapping: the address_space to search
> - * @offset: the page index
> + * @index: the page index
>   *
> - * Looks up the page cache entry at @mapping & @offset.  If there is a
> + * Looks up the page cache entry at @mapping & @index.  If there is a
>   * page cache page, it is returned locked and with an increased
>   * refcount.
>   *
> @@ -361,9 +361,9 @@ static inline struct page *find_lock_page(struct address_space *mapping,
>  /**
>   * find_lock_head - Locate, pin and lock a pagecache page.
>   * @mapping: The address_space to search.
> - * @offset: The page index.
> + * @index: The page index.
>   *
> - * Looks up the page cache entry at @mapping & @offset.  If there is a
> + * Looks up the page cache entry at @mapping & @index.  If there is a
>   * page cache page, its head page is returned locked and with an increased
>   * refcount.
>   *
> -- 
> 2.26.2
> 
