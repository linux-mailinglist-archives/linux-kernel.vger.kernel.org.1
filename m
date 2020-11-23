Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BAB2C02FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 11:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgKWKId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 05:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgKWKIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 05:08:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A476AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 02:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GMC0zoD4ESumTpUR0l7CFso7jCjRLzfG8oaHAbiw8Nw=; b=cUJ1n0nj5UYC6H8uzqFXNKi1sj
        VJVEgsND3cpDxCRsPqQ5bBuGflv1l5bMovoQ2AU/2kJHb6TKWvpEMLuEyC72YYc6TtxcIyT8suqEf
        4hLFc9qxeFlZVYf+TGJ2rJ9KKmUQSFyzC2oLgvfvqy4pdlLpIShVXCfo/bZhxzBvX+J6Vv7WNg2my
        F6gpVj9v06mb46gfYvD82o+K6mq48jXWrAL8bPpTT2ZiWpmJXMPBN3BvCwfLogoc/HIq/OcwMqifE
        slkh8yn9PgWFg8wu/TPKBu70jzqfjf/qE/Uu+l2tnemGHNvM0Xl1AMIi9vZ6ICa1J2Z73y6VowtlK
        Z/IeNhqg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kh8lc-0006wE-Sr; Mon, 23 Nov 2020 10:08:16 +0000
Date:   Mon, 23 Nov 2020 10:08:16 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Tom Murphy <murphyt7@tcd.ie>,
        David Woodhouse <dwmw2@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v5 3/7] iommu: Allow the dma-iommu api to use bounce
 buffers
Message-ID: <20201123100816.GA26619@infradead.org>
References: <20201120101719.3172693-1-baolu.lu@linux.intel.com>
 <20201120101719.3172693-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120101719.3172693-4-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	/*
> +	 * If both the physical buffer start address and size are
> +	 * page aligned, we don't need to use a bounce page.
> +	 */
> +	if (IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev) &&
> +	    iova_offset(iovad, phys | org_size)) {
> +		aligned_size = iova_align(iovad, org_size);
> +		phys = swiotlb_tbl_map_single(dev,
> +				phys_to_dma(dev, io_tlb_start),
> +				phys, org_size, aligned_size, dir, attrs);

swiotlb_tbl_map_single takes one less argument in 5.10-rc now.
