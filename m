Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A373E2947B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 07:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440405AbgJUFSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 01:18:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440398AbgJUFSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 01:18:51 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5701D21D6C;
        Wed, 21 Oct 2020 05:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603257531;
        bh=C8dQdkv3mlE3dSkLdyzKxia49yjugNb94xNvwlhOYvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uxBPJcrsFjytd1NxCXM4vBfjEbsNA5N+NXUBfjDsBTKdc1Y0tikAgrL6fTKwG2v+c
         i08g7msZHFBkOiEc14xz9jKKmRpx7MUaBMn6CIDoCVHFcshuLrVcVeIeqeWFDYLuot
         1dzDNThqqMXy1z6r0x5nlmEvoTxAE0op1DIZh1Kw=
Date:   Wed, 21 Oct 2020 07:19:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Furquan Shaikh <furquan@google.com>
Cc:     linux-kernel@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Ard Biesheuvel <ardb@kernel.org>, dlaurie@google.com
Subject: Re: [PATCH] firmware: gsmi: Drop the use of dma_pool_* API functions
Message-ID: <20201021051931.GA967331@kroah.com>
References: <20201021050141.377787-1-furquan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021050141.377787-1-furquan@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:01:41PM -0700, Furquan Shaikh wrote:
> GSMI driver uses dma_pool_* API functions for buffer allocation
> because it requires that the SMI buffers are allocated within 32-bit
> physical address space. However, this does not work well with IOMMU
> since there is no real device and hence no domain associated with the
> device.
> 
> Since this is not a real device, it does not require any device
> address(IOVA) for the buffer allocations. The only requirement is to
> ensure that the physical address allocated to the buffer is within
> 32-bit physical address space. This change allocates a page using
> `get_zeroed_page()` and passes in GFP_DMA32 flag to ensure that the
> page allocation is done in the DMA32 zone. All the buffer allocation
> requests for gsmi_buf are then satisfed using this pre-allocated page
> for the device.

Are you sure that "GFP_DMA32" really does what you think it does?  A
"normal" call with GFP_KERNEL" will give you memory that is properly
dma-able.

We should not be adding new GFP_DMA* users in the kernel in these days,
just call dma_alloc*() and you should be fine.

thanks,

greg k-h
