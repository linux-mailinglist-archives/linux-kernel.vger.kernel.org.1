Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537C42C58DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403918AbgKZP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391496AbgKZP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:56:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE73C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qz4o1lO69kgW02RmX+EDGr87UNMxuLYtFUOYFYrec8c=; b=VPOLJXTxQnz/Knjtl/blwvOkoG
        VylHSRv9gdJNTpdLzdXbVUt/ajOlUiXFNWLm0bFErMrUWmTiE7OwmLWmMS98pTIzhZXABsivIWc4j
        RK+/ADZI9JHg6VPlinBCXRJ6SLXGqj3uEejJXxLXlGV8srF0bUN677DEIbDeeu5ofjju0EPNdOvRm
        apMHdTUkCkp9CyZ1LoSHYiG19wpwsKVVYQd/vnw8jL8yS5IGiPHiMoqZ29N90qrc3xCKWUMIMRSHZ
        WHCfPlWO8YE+ZtVDnzQj69Uq+THybVy463Z/gaRyjE34ms/77I3nYgDkdQ30TjZYgEEohJWPaBE+T
        3XmIdxmg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kiJcf-0007k5-OK; Thu, 26 Nov 2020 15:55:53 +0000
Date:   Thu, 26 Nov 2020 15:55:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yu Zhao <yuzhao@google.com>, Alex Shi <alex.shi@linux.alibaba.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] mm/swap.c: reduce lock contention in lru_cache_add
Message-ID: <20201126155553.GT4327@casper.infradead.org>
References: <1605860847-47445-1-git-send-email-alex.shi@linux.alibaba.com>
 <20201126045234.GA1014081@google.com>
 <ed19e3f7-33cb-20ae-537e-a7ada2036895@linux.alibaba.com>
 <20201126072402.GA1047005@google.com>
 <464fa387-9dfd-a8c7-3d86-040f26fd4115@suse.cz>
 <c3d53633-af28-79c1-f42c-d5b851af4d56@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d53633-af28-79c1-f42c-d5b851af4d56@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 04:44:04PM +0100, Vlastimil Babka wrote:
> However, Matthew wanted to increase pagevec size [1] and once 15^2 becomes
> 63^2, it starts to be somewhat more worrying.
> 
> [1] https://lore.kernel.org/linux-mm/20201105172651.2455-1-willy@infradead.org/

Well, Tim wanted it ;-)

I would suggest that rather than an insertion sort (or was it a bubble
sort?), we should be using a Shell sort.  It's ideal for these kinds of
smallish arrays.

https://en.wikipedia.org/wiki/Shellsort
