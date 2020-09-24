Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113C4276ECC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgIXKdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:33:08 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B2C0613CE;
        Thu, 24 Sep 2020 03:33:08 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 3723B295; Thu, 24 Sep 2020 12:33:06 +0200 (CEST)
Date:   Thu, 24 Sep 2020 12:33:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org,
        jonathanh@nvidia.com, vdumpa@nvidia.com
Subject: Re: [PATCH 0/3] iommu/tegra-smmu: Some small fixes
Message-ID: <20200924103304.GN27174@8bytes.org>
References: <20200911071643.17212-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911071643.17212-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 12:16:40AM -0700, Nicolin Chen wrote:
> These are a series of small fixes for tegra-smmu driver.
> They might not be critial bugs as current mainline does
> not enable a lot of clients, but be nicer to have since
> we are going to enable the DMA domain for other clients
> in the near future.
> 
> Nicolin Chen (3):
>   iommu/tegra-smmu: Do not use PAGE_SHIFT and PAGE_MASK
>   iommu/tegra-smmu: Fix iova->phys translation
>   iommu/tegra-smmu: Allow to group clients in same swgroup
> 
>  drivers/iommu/tegra-smmu.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)

Applied, thanks.
