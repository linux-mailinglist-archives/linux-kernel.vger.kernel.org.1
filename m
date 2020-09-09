Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80522627FA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 09:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgIIHF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 03:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgIIHFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:05:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7934BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 00:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OisEO4jaSIfeERIhkIAL872QnJzJXCLXxgUqnKpDARE=; b=SrydzyYRh+xGXT0KW6s048zloI
        52J0q13JFWSZKNdGubmRKwYrmt1vcToWiUp8aPCggtl7svrazZbQDIYelaDpdcoplz1wyl2qx7M7B
        Ny83Jqaay5fvT5oDuSdx2jjPa2SHsHaAvOug4P6P1Lby6vNzYCSYsS/OnOn5H3AepNNLWrd8wIsq0
        iRcT2Co0fVyMFXdJ4LNKzD+XKCfGgJdCylieR7oSDGdv6Tf0okYTkuvPlCHJzSr4Ma0YXqJR8DSUP
        3reQwJMbCDIus+ocYSl3r0fwjMa1RRSzTNLzjunQipU4u6MbFbE2PkFYBQroexsWLKxzjM492lLgU
        wDNPOfCw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFuAm-0007pZ-Le; Wed, 09 Sep 2020 07:05:40 +0000
Date:   Wed, 9 Sep 2020 08:05:40 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Tom Murphy <murphyt7@tcd.ie>, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/5] iommu: Add iommu_dma_free_cpu_cached_iovas
 function
Message-ID: <20200909070540.GA28245@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-3-murphyt7@tcd.ie>
 <b30be538-a4dd-987e-78df-ff23b703bbe3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b30be538-a4dd-987e-78df-ff23b703bbe3@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static inline void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> +                                                  struct iommu_domain
> *domain)

This adds a crazy long line.  Which is rather pointless as other
bits of code in the patch use the more compact two tab indentations
for the prototype continuation lines anyway.
