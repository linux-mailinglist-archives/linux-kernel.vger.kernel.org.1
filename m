Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF372455A2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 06:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgHPEJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 00:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgHPEJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 00:09:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394CBC061786
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+w7jWuDj+prWa0IEJcK+RwKnK1Y4vdCU//6WZuG/yR0=; b=n88tpd+3bXfovuKM3r7p8BYPUP
        CqVWIdLlaREhk0lIMsntjd4Q2OpO0FR5bKHA8lHcoxhCLCAdeM8+2qMogRlujRp+FkEpch3E3a02S
        o1t603FyW2VZAmGfurnoszG4rNGvFK8z2D6mC09a0MFGiENXzmPUse/8j52OTo0HmZSUqh7uc3Sj1
        qeDq9W332dpXi+idfm75qkTe0YB6C/Vx3VfsBNmnRSFpBO68z6ZDgq/a8NjMfYNLfIcirlEMHuLmb
        ZMifEAFZZCcPzPIGbEYewonEmwQmOK9BAyZ8+kYOoQUm3WnRspaOlMSYNFxlMt25lH5sITZVL9EgI
        PzbQrkHw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k79yj-000195-9K; Sun, 16 Aug 2020 04:09:05 +0000
Date:   Sun, 16 Aug 2020 05:09:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
Message-ID: <20200816040905.GF17456@casper.infradead.org>
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 11:47:56AM +0800, Alex Shi wrote:
> +++ b/mm/page_alloc.c
> @@ -467,6 +467,8 @@ static inline int pfn_to_bitidx(struct page *page, unsigned long pfn)
>  	return (pfn >> pageblock_order) * NR_PAGEBLOCK_BITS;
>  }
>  
> +#define BITS_PER_CHAR	8

include/linux/bits.h:#define BITS_PER_BYTE              8

>  	bitmap = get_pageblock_bitmap(page, pfn);
>  	bitidx = pfn_to_bitidx(page, pfn);
> -	word_bitidx = bitidx / BITS_PER_LONG;
> -	bitidx &= (BITS_PER_LONG-1);
> +	word_bitidx = bitidx / BITS_PER_CHAR;
> +	bitidx &= (BITS_PER_CHAR-1);

It's not a word any more.  it's a byte.

