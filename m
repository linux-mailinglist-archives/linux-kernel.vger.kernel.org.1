Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D052480C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 10:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHRIhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgHRIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 04:37:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D345C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z+RycezjV2WVCujs2S8itL6PhqDnVUaq7qp6xVdLAo4=; b=sChHbAxde70X2xuGN/HW+28KHz
        HI6YetzZL7SCINwQdD5+hHwkS6qWOP4voGDc8BYsONfhYhnkoQjB8JI7DJJ9WQFCYfhWEbCSaLAB/
        omXVKQnx1SSatRgDqyYjcqU0OpvgaD2swot7bjhdFztT6gzNDrjEARqivLy9gDHU+rpvRWfZnA8TU
        EXesWd61vo9k2yjd6ObDCJVrP1fhwDN5MYWt/fXfGTXqq8r+QJLiuZzA0MqYq9MFwmi9U6wOVFmOZ
        0288DMbrkGzzFf92AljB7ECFX3C4q0e5AVJDUpv6hEAlOSfHWemTogfSP8tf0Sw1RswoQai5g6knN
        CYOJR6QQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7x7Q-0002kj-2n; Tue, 18 Aug 2020 08:37:20 +0000
Date:   Tue, 18 Aug 2020 09:37:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Cho KyongHo <pullip.cho@samsung.com>, joro@8bytes.org,
        catalin.marinas@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        janghyuck.kim@samsung.com, hyesoo.yu@samsung.com
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818083720.GA9451@infradead.org>
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <20200818082852.GA15145@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818082852.GA15145@willie-the-truck>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 09:28:53AM +0100, Will Deacon wrote:
> On Tue, Aug 18, 2020 at 04:43:10PM +0900, Cho KyongHo wrote:
> > Cache maintenance operations in the most of CPU architectures needs
> > memory barrier after the cache maintenance for the DMAs to view the
> > region of the memory correctly. The problem is that memory barrier is
> > very expensive and dma_[un]map_sg() and dma_sync_sg_for_{device|cpu}()
> > involves the memory barrier per every single cache sg entry. In some
> > CPU micro-architecture, a single memory barrier consumes more time than
> > cache clean on 4KiB. It becomes more serious if the number of CPU cores
> > are larger.
> 
> Have you got higher-level performance data for this change? It's more likely
> that the DSB is what actually forces the prior cache maintenance to
> complete, so it's important to look at the bigger picture, not just the
> apparent relative cost of these instructions.
> 
> Also, it's a miracle that non-coherent DMA even works, so I'm not sure
> that we should be complicating the implementation like this to try to
> make it "fast".

And without not just an important in-tree user but one that actually
matters and can show how this is correct the whole proposal is complete
nonstarter.
