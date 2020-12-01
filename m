Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AB72C9A81
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 10:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbgLAI6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387895AbgLAI6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:58:15 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FA0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 00:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DT5y9dV2xExdx2CqBhWqvdiaJUbzEJPFpqaFu1q3ylU=; b=C6zbQPxyxUe/xk+UC3Dtia53cX
        UyzNyHhnMOE9Vq7LbPfFlIaUfp2ygKJfq2MDXZfSwrUgs0J2yAEQlpi9aXRBkWd8vMaoz/Yzx6Vr8
        z1NenE19/PsipG88RDYZEFVknycW/EgQI46ZzrLhM9HkbEFpd58Aghe6ZELzx1T9TaPij00fVE70b
        mpNDHMT1Q9ENtfciW4y5WtgaWsKWNQMk1+OX2fQDaqnsRwx+4ACKHaImXkCcOxs+svIRSqGRXYP2p
        IgOmbWpt5AIGR+28e94A2Wsc/ngyRhEFl9n/cKKnmWD94IesOeBZNPMWahI7NhOrAQxWxGxeDFiLP
        Pvs+v9+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk1TR-0008EH-8I; Tue, 01 Dec 2020 08:57:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 379B73060AE;
        Tue,  1 Dec 2020 09:57:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 295DC20423019; Tue,  1 Dec 2020 09:57:22 +0100 (CET)
Date:   Tue, 1 Dec 2020 09:57:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     x86@kernel.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de
Subject: Re: [RFC][PATCH 5/9] mm: Rename pmd_read_atomic()
Message-ID: <20201201085722.GR2414@hirez.programming.kicks-ass.net>
References: <20201130112705.900705277@infradead.org>
 <20201130113603.079835817@infradead.org>
 <20201130153120.GZ5487@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130153120.GZ5487@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:31:20AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 30, 2020 at 12:27:10PM +0100, Peter Zijlstra wrote:
> > There's no point in having the identical routines for PTE/PMD have
> > different names.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >  include/linux/pgtable.h    |    7 +------
> >  mm/hmm.c                   |    2 +-
> >  mm/mapping_dirty_helpers.c |    2 +-
> >  mm/mprotect.c              |    2 +-
> >  mm/userfaultfd.c           |    2 +-
> >  5 files changed, 5 insertions(+), 10 deletions(-)
> > 
> > +++ b/include/linux/pgtable.h
> > @@ -1244,11 +1244,6 @@ static inline int pud_trans_unstable(pud
> >  #endif
> >  }
> >  
> > -static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
> > -{
> > -	return pmdp_get_lockless(pmdp);
> > -}
> > -
> >  #ifndef arch_needs_pgtable_deposit
> >  #define arch_needs_pgtable_deposit() (false)
> >  #endif
> > @@ -1275,7 +1270,7 @@ static inline pmd_t pmd_read_atomic(pmd_
> >   */
> >  static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
> >  {
> > -	pmd_t pmdval = pmd_read_atomic(pmd);
> > +	pmd_t pmdval = pmdp_get_lockless(pmd);
> >  	/*
> >  	 * The barrier will stabilize the pmdval in a register or on
> >  	 * the stack so that it will stop changing under the code.
> > +++ b/mm/hmm.c
> > @@ -356,7 +356,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
> >  		 * huge or device mapping one and compute corresponding pfn
> >  		 * values.
> >  		 */
> > -		pmd = pmd_read_atomic(pmdp);
> > +		pmd = pmdp_get_lockless(pmdp);
> >  		barrier();
> >  		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
> >  			goto again;
> 
> The pagewalk API doesn't call the functions with interrupts disabled,
> doesn't this mean we hit this assertion?
> 
> +#if CONFIG_PGTABLE_LEVELS > 2
> +static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
> +{
> +       pmd_t pmd;
> +
> +       lockdep_assert_irqs_disabled();
> +
> 
> It is only holding the read side of the mmap_sem here

Hurmph, good point. I'll see what I can do about that.
