Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ADD1B15FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 21:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDTTdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 15:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725550AbgDTTdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:33:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38B2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nys6FfrXrT/gkHzZ8xBczpZW1k4deji5R46CFHQSXRI=; b=IODJ9iDC6uH9h4ewqA894kbWlj
        2fuCalRawyjjvQ9m5sOYWzRepZ1K7U6sUm3IobITEqL/SRbKCAPNvCknV6JBzAlkmwmHqU7EPdT75
        khpcvu48gLcAPzN+9O17TqpPeSlZ76yqoEDjcemTImGY33gHHNG8Ndp/avwUUOBJhc40Ti22EaRvG
        HyJfb0Zj23l/Q0K7w7FxkgiwHpdAGzsSqSK5N69HbcT15OLwErUhXftIEXNliptADHm+nOZO/6ekN
        CJmvacYjNQ5wkK+HoVs6LoVOgqa5iyXwiE4CgoP2cfgl5kejlL0HJVyQdmv8Fr/tLHpOmmA0Wu8ka
        rocxg6fA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQcAI-0002MG-PZ; Mon, 20 Apr 2020 19:33:10 +0000
Date:   Mon, 20 Apr 2020 12:33:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v4 06/10] mmap locking API: convert nested write lock
 sites
Message-ID: <20200420193310.GF5820@bombadil.infradead.org>
References: <20200415004353.130248-1-walken@google.com>
 <20200415004353.130248-7-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415004353.130248-7-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 05:43:49PM -0700, Michel Lespinasse wrote:
> @@ -47,7 +48,7 @@ static inline void activate_mm(struct mm_struct *old, struct mm_struct *new)
>  	 * when the new ->mm is used for the first time.
>  	 */
>  	__switch_mm(&new->context.id);
> -	down_write_nested(&new->mmap_sem, 1);
> +	mmap_write_lock_nested(new, 1);

This should have already been using SINGLE_DEPTH_NESTING.  1 is
uninformative.

