Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3959A1F21FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 00:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgFHWyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 18:54:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgFHWyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:54:00 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A0DD2076A;
        Mon,  8 Jun 2020 22:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591656839;
        bh=aFtqwt+bYOZhJ7U9irm3TzEiOtvg48f3YiInMbcBYs0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=sV9brVTS0fbsMYHJ/0OiYUYepwLpKHZZvVEPsCcTclhj201DpvYC6IxwM1XDwdEIe
         K1aFJ5vaHAov9BwrlY9IHX4mYNHZkTNxt1DgO7EyhoVEcdrayUCUJJ00a6kr5y+QET
         7Agxg++7d8MkC5wB88ZPCM3NNvh4ps0v1mIPE2Lo=
Date:   Mon, 8 Jun 2020 15:53:58 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Christoph Hellwig <hch@infradead.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        tamas@tklengyel.com, roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 01/11] swiotlb-xen: use vmalloc_to_page on vmalloc
 virt addresses
In-Reply-To: <20200608070411.GA15742@infradead.org>
Message-ID: <alpine.DEB.2.21.2006081539110.2815@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s> <20200603222247.11681-1-sstabellini@kernel.org> <20200608070411.GA15742@infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks you for the review.


On Mon, 8 Jun 2020, Christoph Hellwig wrote:
> Well, this isn't just RPi4, but basically any ARM or ARM64 system
> with non-coherent DMA (which is most of them).

Well... yes :-)


> > +	struct page *pg;
> 
> Please spell out page.

OK


> >  
> >  	if (hwdev && hwdev->coherent_dma_mask)
> >  		dma_mask = hwdev->coherent_dma_mask;
> > @@ -346,9 +347,11 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
> >  	/* Convert the size to actually allocated. */
> >  	size = 1UL << (order + XEN_PAGE_SHIFT);
> >  
> > +	pg = is_vmalloc_addr(vaddr) ? vmalloc_to_page(vaddr) :
> > +				      virt_to_page(vaddr);
> 
> Please use plain old if/else to make this more readable.

Sure
