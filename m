Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE4C27519C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgIWGfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgIWGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:35:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B391C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 23:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aAcU33sEyT651Bs441cN7gzu/F03SOeGyybtKcmc9Ys=; b=dla6zQQDgw0JL53/m4TbDgU8gz
        Ao7Un4pai7/CIFY8v6dOifGkde9PZs0lj5aEUqcc/CWBK5m67a8BO2o7WhvvuadO1JhB80PsqP3XZ
        8R/zBKE6ZDepREYp+LCSodyCgmO82nM7q99WS986olWy3Wy40v3CNPK1DP3aN4FQyshPshcl0hF3j
        7pNswzRxvrusOdDPE1GkZO62Ag5N0jFnpU0AjOfiLJi/up93jVBKdPGuSyQxiPTKFz7tzpKhYQ5Da
        +SRxnCW834TcZZxZDNPADi3hsOl3OzIjpupatdbIgQOBYgrMI2PtnYhbQFsMxcjhn8Gw3aqiPZP58
        Xubw++QA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKyMv-0005dm-HR; Wed, 23 Sep 2020 06:35:09 +0000
Date:   Wed, 23 Sep 2020 07:35:09 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com, niketa@fb.com, akpm@linux-foundation.org,
        sjenning@redhat.com, ddstreet@ieee.org, konrad.wilk@oracle.com,
        hannes@cmpxchg.org
Subject: Re: [PATCH 2/2] mm,swap: skip swap readahead if page was obtained
 instantaneously
Message-ID: <20200923063509.GB17027@infradead.org>
References: <20200922020148.3261797-1-riel@surriel.com>
 <20200922020148.3261797-3-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922020148.3261797-3-riel@surriel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:01:48PM -0400, Rik van Riel wrote:
> +	struct page *page;
>  	unsigned long entry_offset = swp_offset(entry);
>  	unsigned long offset = entry_offset;
>  	unsigned long start_offset, end_offset;
> @@ -668,11 +669,18 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
>  		end_offset = si->max - 1;
>  
>  	blk_start_plug(&plug);
> +	/* If we read the page without waiting on IO, skip readahead. */
> +	page = swap_cluster_read_one(entry, offset, gfp_mask, vma, addr, false);
> +	if (page && PageUptodate(page))
> +		goto skip_unplug;
> +

At least for the normal block device path the plug will prevent the
I/O submission from actually happening and thus PageUptodate from
becoming true.  I think we need to split the different code paths
more cleanly.

Btw, what device type and media did you test this with?  What kind of
numbers did you get on what workload?
