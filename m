Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00402FBB34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391447AbhASP3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391638AbhASP1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:27:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4642C061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 07:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9SdVCTr5RtENV5upn/rU9VC9X6XHYMAQhYyklwuow6I=; b=r6y945BEZul6pRcpcA5ykCihA0
        Ae4HrojblkggZV3csM55ZIrdN9YR9ANUTWGDoK6/0BKH1ouP7Z9LquJ2d8pUvqLEfTkQJtTnc+Qxx
        VJkhYWjse4546XjYVeU1aAmAd1JDkfBwOcSQo1OuyUSspelmUHfNAxPt4n1VO+hMcpZ0YBGRrXaOM
        6T4Fa0Zx03mJzZPevgRNn7MBjvv/jxRC/mKFc2jEn5KUXJkwTJ3VmBlZCR3kZixm1skOEe9wNhzwW
        ejhwCOmjEzq74EfKbFOOxlVVYfUCJWX8YoSjiZaG+WMDlm3QVXYBw0U2GxJynTgCbDqUaQixiT5QP
        A7jshzNQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l1su1-00EUfP-Vk; Tue, 19 Jan 2021 15:26:46 +0000
Date:   Tue, 19 Jan 2021 15:26:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com
Subject: Re: [PATCH 1/2 v2] dma-iommu: use static-key to minimize the impact
 in the fast-path
Message-ID: <20210119152641.GA3453587@infradead.org>
References: <20210119111616.12761-1-lijiang@redhat.com>
 <20210119111616.12761-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119111616.12761-2-lijiang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 07:16:15PM +0800, Lianbo Jiang wrote:
> +static DEFINE_STATIC_KEY_FALSE(__deferred_attach);

Why the strange underscores?  Wouldn't iommu_deferred_attach_enabled
be a better name?

> -	if (unlikely(iommu_dma_deferred_attach(dev, domain)))
> +	if (static_branch_unlikely(&__deferred_attach) &&
> +	    iommu_dma_deferred_attach(dev, domain))

Also insted of duplicating this logic in three places, maybe rename
iommu_dma_deferred_attach to __iommu_dma_deferred_attach and create
a small inline wrapper for it?
