Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDB925E8E0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgIEPqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 11:46:52 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46572 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726261AbgIEPqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 11:46:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1F5638EE112;
        Sat,  5 Sep 2020 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599320799;
        bh=uuZwcuWqye3Jc50GpB/RasDOKF7Bok/BlMWQ3nC8shA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IPcOeu/nD8EEaTOanrSjdimEprZPoxMXq+HbxBPlWLjLXBUHVzSjaXACgrHe+4Jy+
         aEA8fhvxKFQjuoWylT7lwvB4zCsht2sCqNnw4bvED9g5hxODMpsg6k6iUFJm9jkS/4
         5M0Ug4oKqKBSUPmoEbfMV2wu4jr7PzXO8iFTOkD0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xRcJOAM4hkOC; Sat,  5 Sep 2020 08:46:38 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id C87418EE100;
        Sat,  5 Sep 2020 08:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599320798;
        bh=uuZwcuWqye3Jc50GpB/RasDOKF7Bok/BlMWQ3nC8shA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mke0N8GmVsaGqDCnDo1Xevave0JV+Ok2cWL6w8idVDY1Ot0Fj/AbNErCQQRg3ESYs
         3jgSfrtRZagN7f0a8PfMR2oRtAz3nSfMt+fuXzkKruqdGOJlDSNW72Stg7HclqO/N+
         JuyCutuhMmqqeGaf7bkGnnUGnkZe/XQ336n3uKRs=
Message-ID: <1599320796.11726.5.camel@HansenPartnership.com>
Subject: Re: [PATCH] dma-direct: zero out DMA_ATTR_NO_KERNEL_MAPPING buf
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arch@vger.kernel.come
Date:   Sat, 05 Sep 2020 08:46:36 -0700
In-Reply-To: <20200905073528.9464-1-hdanton@sina.com>
References: <20200904152550.17964-1-hdanton@sina.com>
         <20200905073528.9464-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-09-05 at 15:35 +0800, Hillf Danton wrote:
> On Fri, 04 Sep 2020 08:34:39 -0700 James Bottomley wrote:
> > On Fri, 2020-09-04 at 23:25 +0800, Hillf Danton wrote:
> > > The DMA buffer allocated is always cleared in DMA core and this
> > > is making DMA_ATTR_NO_KERNEL_MAPPING non-special.
> > > 
> > > Fixes: d98849aff879 ("dma-direct: handle
> > > DMA_ATTR_NO_KERNEL_MAPPING
> > > in common code")
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Matthew Wilcox <willy@infradead.org>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Signed-off-by: Hillf Danton <hdanton@sina.com>
> > > ---
> > > 
> > > --- a/kernel/dma/direct.c
> > > +++ b/kernel/dma/direct.c
> > > @@ -178,9 +178,17 @@ void *dma_direct_alloc_pages(struct devi
> > >  
> > >  	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> > >  	    !force_dma_unencrypted(dev)) {
> > > +		int i;
> > > +
> > >  		/* remove any dirty cache lines on the kernel
> > > alias
> > > */
> > >  		if (!PageHighMem(page))
> > >  			arch_dma_prep_coherent(page, size);
> > > +
> > > +		for (i = 0; i < size/PAGE_SIZE; i++) {
> > > +			ret = kmap_atomic(page + i);
> > > +			memset(ret, 0, PAGE_SIZE);
> > > +			kunmap_atomic(ret);
> 
> Hi James
> > 
> > This is massively expensive on PARISC and likely other VIPT/VIVT
> > architectures.
> 
> Correct.
>
> > What's the reason for clearing it?  This could also be
> 
> 	/* we always manually zero the memory once we are done: */
> 	gfp &= ~__GFP_ZERO;
> 	gfp |= dma_direct_optimal_gfp_mask(dev, dev->coherent_dma_mask,
> 					   &phys_limit);

That's not a reason ... that comment was put in for coherent mappings. 
What is the reason we should incur all this expense for clearing pages
which aren't unmapped in the kernel, because we can update the comment?
 The usual rationale for kernel mapped pages is security, because they
may leak information but unmapped pages shouldn't have this problem.

> > really inefficient even on PIPT architectures if the memory is
> > device remote.
> > 
> > If we really have to do this, it should likely be done in the arch
> > or driver hooks because there are potentially more efficient ways
> > we can do this knowing how the architecture behaves.
> 
> I'm open to any vintage ideas in your mind wrt clearing dma buf e.g
> on platforms like PARISC. Or feel free to offload me the work if it
> makes sense to you who are rich of PARISC knowledge.

OK, I've cc'd linux-arch because this is a problem for more than just
parisc.  However, not having to do it is the best solution ... sort of
the doctor, doctor it hurts when I do this answer.

James

