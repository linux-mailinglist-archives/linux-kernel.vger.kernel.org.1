Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D10276C4C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgIXIsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:48:52 -0400
Received: from 8bytes.org ([81.169.241.247]:46202 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgIXIsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:48:52 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5200C295; Thu, 24 Sep 2020 10:48:50 +0200 (CEST)
Date:   Thu, 24 Sep 2020 10:48:48 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Yu Kuai <yukuai3@huawei.com>, kgene@kernel.org, krzk@kernel.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH] iommu/exynos: add missing put_device() call in
 exynos_iommu_of_xlate()
Message-ID: <20200924084848.GD27174@8bytes.org>
References: <CGME20200918011240eucas1p1e16e5b1b11a4ea6c078ffeceaf554966@eucas1p1.samsung.com>
 <20200918011335.909141-1-yukuai3@huawei.com>
 <9f5b25ee-3dad-1798-fe55-9c1af9cde513@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f5b25ee-3dad-1798-fe55-9c1af9cde513@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 05:27:59PM +0200, Marek Szyprowski wrote:
> Hi
> 
> On 18.09.2020 03:13, Yu Kuai wrote:
> > if of_find_device_by_node() succeed, exynos_iommu_of_xlate() doesn't have
> > a corresponding put_device(). Thus add put_device() to fix the exception
> > handling for this function implementation.
> >
> > Fixes: aa759fd376fb ("iommu/exynos: Add callback for initializing devices from device tree")
> > Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> 
> Thanks for the fix!
> 
> Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

Applied for v5.9, thanks.
