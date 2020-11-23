Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25812C04DB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgKWLrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbgKWLrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:47:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A24C82074B;
        Mon, 23 Nov 2020 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606132031;
        bh=2PtTmOJEIKueGGOEndNNTAvxa8jv28ItaoA+w5cJ7ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fS2ygnXRKaVKl4yrUEJ1wu6gxcKFF9B8z1SqnqIBryRZo8H3iMw8c/PuRyGBRVI4s
         Gkull3LJtsdvMhMitK/U+14Nivs7X3Og57TUZ5utLIEpOuw8cEy4sSibAXSeOSK0BF
         x9jmfc8UdRdBxKuq4H5+wxRwysi8KA/rB6mtk1ds=
Date:   Mon, 23 Nov 2020 11:47:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 3/7] iommu: Allow the dma-iommu api to use bounce
 buffers
Message-ID: <20201123114705.GA10233@willie-the-truck>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
 <20201120101719.3172693-4-baolu.lu@linux.intel.com>
 <20201123100816.GA26619@infradead.org>
 <73ac6a6b-ede9-b306-6d8f-c73f22e1e8e3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ac6a6b-ede9-b306-6d8f-c73f22e1e8e3@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 07:40:57PM +0800, Lu Baolu wrote:
> On 2020/11/23 18:08, Christoph Hellwig wrote:
> > > +	/*
> > > +	 * If both the physical buffer start address and size are
> > > +	 * page aligned, we don't need to use a bounce page.
> > > +	 */
> > > +	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> > > +	    iova_offset(iovad, phys | org_size)) {
> > > +		aligned_size = iova_align(iovad, org_size);
> > > +		phys = swiotlb_tbl_map_single(dev,
> > > +				phys_to_dma(dev, io_tlb_start),
> > > +				phys, org_size, aligned_size, dir, attrs);
> > 
> > swiotlb_tbl_map_single takes one less argument in 5.10-rc now.
> > 
> 
> Yes. But Will's iommu/next branch is based on 5.10-rc3. I synced with
> him, we agreed to keep it 5.10-rc3 and resolve this conflict when
> merging it.

That's right, although I failed to appreciate the conflict was due to a
change in function prototype rather than just a context collision. So
I've updated the vt-d branch to contain the stuff fron Konrad:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/iommu/vt-d

Sorry for messing you around!

Will
