Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08ACB275183
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIWGcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIWGct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:32:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A161DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 23:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=khxS5mQDeFNSNFUvOu/ymTe0n2kgpx0Wdrm7P5zQ3gI=; b=lhtezNXQM5oQFMi2wL9ITtCadn
        1Rmbye50ROQD+LWV/jsSHCR+MyAQCUn8NmEQjgozH7yPRknu813GD7xL9v1Fek6v2wuG+b+JOZcgC
        FfQ+ZKsCHp9FS2gq6DprY1tdspEChk5QNKGq4WVYhJypLtXixoaLIjJPMrbgTUKS+Bx7oOw26leDu
        nDMDocuq7Ch7weJs4o6BXPdawmT1wbPEsc1iN7TAIs676XuImQjYCm6goW17MydcGM3xoR/jJhnf4
        5WJX/JBQz0YhifKLxHQfFaQLbPSqV2OUA2WotD8CVPJhkAAAkkAuKYRgecOh2JYUZb6ADFUpV7Ze+
        v0I/y7TQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKyKa-0005Ok-0I; Wed, 23 Sep 2020 06:32:44 +0000
Date:   Wed, 23 Sep 2020 07:32:43 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, niketa@fb.com, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, konrad.wilk@oracle.com,
        hannes@cmpxchg.org
Subject: Re: [PATCH 1/2] mm,swap: extract swap single page readahead into its
 own function
Message-ID: <20200923063243.GA17027@infradead.org>
References: <20200922020148.3261797-1-riel@surriel.com>
 <20200922020148.3261797-2-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922020148.3261797-2-riel@surriel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:01:47PM -0400, Rik van Riel wrote:
> +static struct page *swap_cluster_read_one(swp_entry_t entry,
> +		unsigned long offset, gfp_t gfp_mask,
> +		struct vm_area_struct *vma, unsigned long addr, bool readahead)
> +{
> +	bool page_allocated;
> +	struct page *page;
> +
> +	page =__read_swap_cache_async(swp_entry(swp_type(entry), offset),
> +				      gfp_mask, vma, addr, &page_allocated);

Missing whitespace after the "=".

> +	if (!page)
> +		return NULL;
> +	if (page_allocated) {
> +		swap_readpage(page, false);
> +		if (readahead) {
> +			SetPageReadahead(page);
> +			count_vm_event(SWAP_RA);
> +		}
> +	}
> +	put_page(page);
> +	return page;
> +}

I think swap_vma_readahead can be switched to your new helper
pretty trivially as well, as could many of the users of
read_swap_cache_async.
