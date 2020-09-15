Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032AC26B7B5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgIPA1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:27:35 -0400
Received: from verein.lst.de ([213.95.11.211]:47847 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgIOOHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:07:24 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C892268AFE; Tue, 15 Sep 2020 16:07:19 +0200 (CEST)
Date:   Tue, 15 Sep 2020 16:07:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Tai <thomas.tai@oracle.com>
Cc:     konrad.wilk@oracle.com, m.szyprowski@samsung.com, hch@lst.de,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
Message-ID: <20200915140719.GA14831@lst.de>
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 08:03:14AM -0600, Thomas Tai wrote:
> When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
> printing a warning message in swiotlb_map(). It is because dev->dma_mask
> can potentially be a null pointer. Using the dma_get_mask() macro can
> avoid the NULL pointer dereference.

dma_mask must not be zero.  This means drm is calling DMA API functions
on something weird.  This needs to be fixed in the caller.
