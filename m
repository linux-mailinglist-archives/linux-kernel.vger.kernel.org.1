Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E472C24F3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbgKXLtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:49:12 -0500
Received: from verein.lst.de ([213.95.11.211]:54156 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728491AbgKXLtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:49:11 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E3A5F6736F; Tue, 24 Nov 2020 12:49:06 +0100 (CET)
Date:   Tue, 24 Nov 2020 12:49:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jianxiong Gao <jxgao@google.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        konrad.wilk@oracle.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] [PATCH] Adding offset keeping option when mapping data
 via SWIOTLB.
Message-ID: <20201124114906.GA22619@lst.de>
References: <20201123221807.3344263-1-jxgao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123221807.3344263-1-jxgao@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 02:18:07PM -0800, Jianxiong Gao wrote:
> NVMe driver and other applications may depend on the data offset
> to operate correctly. Currently when unaligned data is mapped via
> SWIOTLB, the data is mapped as slab aligned with the SWIOTLB. When
> booting with --swiotlb=force option and using NVMe as interface,
> running mkfs.xfs on Rhel fails because of the unalignment issue.
> This patch adds an option to make sure the mapped data preserves
> its offset of the orginal addrss. Tested on latest kernel that
> this patch fixes the issue.
> 
> Signed-off-by: Jianxiong Gao <jxgao@google.com>
> Acked-by: David Rientjes <rientjes@google.com>

I think we actually need to do this by default.  There are plenty
of other hardware designs that rely on dma mapping not adding
offsets that did not exist, e.g. ahci and various RDMA NICs.
