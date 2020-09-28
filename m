Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C29A27B557
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 21:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgI1Teu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 15:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1Tet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 15:34:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74357C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 12:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SVVt673+CBkGesVVi65p5GK+Sq59pADfZtIFLQRkELk=; b=Cv+Rj1qLsnkTaY0gvf9+w2C0zN
        cVDHFG5u7qrRWH09Cp32Tq9UcKn7U83LtfNGDSF006MUjyfYS0wzwBUvcdlVWLfcTvsAfM30B2MFR
        ijmE+RRx3Wju2QhRkK+9B429YGjbBAVQuoD82U+3hk1fZjcdEqmuiP/TPjimSmtwQEcb9x6l1XTWH
        7mVw5wvXVOtAVF21Lc0mizlOrUJklkjZnqiuXUAPS9OzbaZsUrCRi7m9SwrHpnRrzcFqryytiTHo+
        KOTq8n0rf52XtvufFETht3VnUQiwUUCxXyoezKKdKddc9/Gukgjkpvfomi7rogne901Gp0JBWKiGX
        9ct8p21g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMyuq-0007rD-RF; Mon, 28 Sep 2020 19:34:29 +0000
Date:   Mon, 28 Sep 2020 20:34:28 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 03/30] mm: thp: use single linked list for THP
 page table page deposit.
Message-ID: <20200928193428.GB30994@casper.infradead.org>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200928175428.4110504-4-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928175428.4110504-4-zi.yan@sent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 01:54:01PM -0400, Zi Yan wrote:
>  		struct {	/* Page table pages */
> -			unsigned long _pt_pad_1;	/* compound_head */
> -			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> +			struct llist_head deposit_head; /* pgtable deposit list head */
> +			struct llist_node deposit_node; /* pgtable deposit list node */

If you're going to use two pointers anyway, you might as well use a
list_head.  But I don't think you need to; you could either use a union
of these or you could use the page_address() of the page to store as
much information as you like!

