Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E501227BB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgI2Dkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgI2Dkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:40:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD36C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 20:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wuFwP1VtH4477YyK4VY8voDgPxxA0zd1F5q5JPQFuM8=; b=gmBHydwMAmNWN1EeYBh4AKHXw/
        AvBy+m69Ai3to+r6gqo0bG6rUFr09L48lr7v18UEH7W7fmJl56BXc1BIHPjtjO3P9gPzctJ09seBk
        k1+nPzTYQJBm2ISavuSSV3a2UoDHWSANYN1OQrq18Oyaao3v+52pMgJEZG8t8xI3gAjUEhsY9fwX8
        iv3DoAsAmwCVQ5wh21/SYJLVIVV1qEX3l2t3UilMqdaJ7wlok84ZsSpUhCrLYPe0wnOlMXnRYqPkG
        2YOjc9n1r2CH1iKMOxlrbgXwsY4OqNlCD48PFO2YEvlKZvF7u2R/Hq0IT4MH24UcG5dbHbHxMu2fp
        g/v3As/w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kN6V8-0002yQ-54; Tue, 29 Sep 2020 03:40:26 +0000
Date:   Tue, 29 Sep 2020 04:40:26 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nick Piggin <npiggin@gmail.com>, Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hch@lst.de, rppt@linux.ibm.com,
        rdunlap@infradead.org
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
Message-ID: <20200929034026.GA20115@casper.infradead.org>
References: <20200926213919.26642-1-willy@infradead.org>
 <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:03:07PM -0700, Andrew Morton wrote:
> Well that's weird and scary looking.  `page' has non-zero refcount yet
> we go and free random followon pages.  Methinks it merits an
> explanatory comment?

Here's some kernel-doc.  Opinions?

/**
 * __free_pages - Free pages allocated with alloc_pages().
 * @page: The page pointer returned from alloc_pages().
 * @order: The order of the allocation.
 *
 * This function differs from put_page() in that it can free multi-page
 * allocations that were not allocated with %__GFP_COMP.  This function
 * does not check that the @order passed in matches that of the
 * allocation, so it is possible to leak memory.  Freeing more memory than
 * was allocated will probably be warned about by other debugging checks.
 *
 * It is only safe to use the page reference count to determine when
 * to free an allocation if you use %__GFP_COMP (in which case, you may
 * as well use put_page() to free the page).  Another thread may have a
 * speculative reference to the first page, but it has no way of knowing
 * about the rest of the allocation, so we have to free all but the
 * first page here.
 *
 * Context: May be called in interrupt context but not NMI context.
 */

