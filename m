Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DE12F35E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405554AbhALQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727201AbhALQek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:34:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1241DC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mBioehHDUzlvAsPzae77HJfwX+E6M+3CVgwDUqEdzwQ=; b=U3gMFkibCIPYY7WCMckP1Qz2w3
        ehyPhKN/2d/DP7Gd5aG2g+3s/ZqAYAeQre+ra5TeoRwPg1ypLFH9UUlsin+PmI5oq5zzqNpejl4MT
        znWNWxSLdgcSYxRrBG85TkYMEYzlqOvsXl4dDwXla4lI/BwLhKxyMmrkiaSraNgKlbkGJStBPhhz2
        NJ3Rts5EJe7yOHQJkn580Y2oqYqO7GisUZGNzMiT0RqkuTve4tCiM5wyq8ysoHa0eX/sdf1t00oQ/
        yl38By6JYvCQe/vCKnAbzFQWzhUjpUDUkaOyOW0HLfhZqybTc3Oju99rYpQDzE/zOli9ssgnVbUNB
        cxs8EabQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kzMbT-0052bL-NA; Tue, 12 Jan 2021 16:33:19 +0000
Date:   Tue, 12 Jan 2021 16:33:07 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>, will@kernel.org,
        joro@8bytes.org, pdaly@codeaurora.org, pratikp@codeaurora.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Optimize iommu_map_sg() performance
Message-ID: <20210112163307.GA1199965@infradead.org>
References: <1610376862-927-1-git-send-email-isaacm@codeaurora.org>
 <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ad6db90-1d86-db2a-ccb5-dc3f01213289@arm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 04:00:59PM +0000, Robin Murphy wrote:
> Out of curiosity, how much of the difference is attributable to actual
> indirect call overhead vs. the additional massive reduction in visits to
> arm_smmu_rpm_{get,put} that you fail to mention? There are ways to optimise
> indirect calling that would benefit *all* cases, rather than just one
> operation for one particular driver.

Do we have systems that use different iommu_ops at the same time?
If not this would be a prime candidate for static call optimizations.

Also I've been pondering adding direct calls to the iommu dma ops like
we do for DMA direct.  This would allow to stop using dma_ops entirely
for arm64.
