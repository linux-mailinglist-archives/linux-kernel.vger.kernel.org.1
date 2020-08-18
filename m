Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC311248B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgHRQKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 12:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgHRQKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:10:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863BEC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sks+YpGBOU4o5+prB+fPm+RZPeb7HCcfoore0HyIIVs=; b=RpSSmTL8+Q0fUzX/6x0fZWIQbm
        pWkqNSJ6xdJBXm3nP8g2FJMORjV6RY3nqtJtW96uGFjUFZfQzDU5yWqLPiimOvCCO1kvjzjvzo7q8
        +JdxSb68PAC6angpC83DmKTvd6/tqe59v3IDDcp38+8NEpV8mAoC/Fr+PiAintL13vLfNz+Crthqo
        IlKLfGg2KJ7GcFqbBd4N9z1s0TtCRIvhoDagGX4oJdgmhvIDKIuvc0hFry98jKeDb1k2VzC7WA0e6
        hiIsKy7aXvrHO8Lo8GWISkb6KSGOlslI8W6tAT/m9/C7LV/JYUYQVOaWA84ZWSPCsOoS/5FoB6Fqm
        DXjJYsUA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k84Bb-0006lM-1W; Tue, 18 Aug 2020 16:10:07 +0000
Date:   Tue, 18 Aug 2020 17:10:06 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     Cho KyongHo <pullip.cho@samsung.com>, janghyuck.kim@samsung.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        hyesoo.yu@samsung.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dma-mapping: introduce relaxed version of dma sync
Message-ID: <20200818161006.GA25124@infradead.org>
References: <CGME20200818075050epcas2p15c780650f5f6b4a54ce731c273d24c98@epcas2p1.samsung.com>
 <1597736591-20457-1-git-send-email-pullip.cho@samsung.com>
 <20200818082852.GA15145@willie-the-truck>
 <20200818093739.GB191752@KEI>
 <20200818100756.GA15543@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818100756.GA15543@willie-the-truck>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:07:57AM +0100, Will Deacon wrote:
> > > so I'm not sure
> > > that we should be complicating the implementation like this to try to
> > > make it "fast".
> > > 
> > I agree that this patch makes the implementation of dma API a bit more
> > but I don't think this does not impact its complication seriously.
> 
> It's death by a thousand cuts; this patch further fragments the architecture
> backends and leads to arm64-specific behaviour which consequently won't get
> well tested by anybody else. Now, it might be worth it, but there's not
> enough information here to make that call.

So it turns out I misread the series (*cough*, crazy long lines,
*cough*), and it does not actually expose a new API as I thought, but
it still makes a total mess of the internal interface.  It turns out
that on the for cpu side we already have arch_sync_dma_for_cpu_all,
which should do all that is needed.  We could do the equivalent for
the to device side, but only IFF there really is a major benefit for
something that actually is mainstream and matters.
