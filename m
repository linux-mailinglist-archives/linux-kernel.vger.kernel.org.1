Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9122727B6C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 22:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgI1U5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 16:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgI1U5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 16:57:04 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00FA92080A;
        Mon, 28 Sep 2020 20:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601326624;
        bh=7QSESI5ibs3UZkTDPr/lNjD28U/TPwZzxzhvs4wH5tE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0PX/j912vIkge8ZEw/pcfXuE91ceov+mqg1dW73/u1/AdUs0yOe2cuiMWtwF13zNR
         WQ8P7iEXfKVGvlrxRU3QAYOrVlzyrIquGswDyer6Z8S0BCFe5h++KzBl2aZjQVbiGH
         LvCla2wdxjcMv/GzTbR1tdTgv7b6alN3OB4jyFlk=
Date:   Mon, 28 Sep 2020 21:56:58 +0100
From:   Will Deacon <will@kernel.org>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Vennila Megavannan <vemegava@linux.microsoft.com>,
        jean-philippe@linaro.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com,
        iommu@lists.linux-foundation.org, tyhicks@linux.microsoft.com,
        srinath.mannam@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] iommu/arm: Add module parameter to set msi iova
 address
Message-ID: <20200928205658.GB12218@willie-the-truck>
References: <20200914181307.117792-1-vemegava@linux.microsoft.com>
 <20200921204545.GA3811@willie-the-truck>
 <85f7d1ae-71a9-4e95-8a30-03cc699d4794@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85f7d1ae-71a9-4e95-8a30-03cc699d4794@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 08:32:43AM +0200, Auger Eric wrote:
> On 9/21/20 10:45 PM, Will Deacon wrote:
> > On Mon, Sep 14, 2020 at 11:13:07AM -0700, Vennila Megavannan wrote:
> >> From: Srinath Mannam <srinath.mannam@broadcom.com>
> >>
> >> Add provision to change default value of MSI IOVA base to platform's
> >> suitable IOVA using module parameter. The present hardcoded MSI IOVA base
> >> may not be the accessible IOVA ranges of platform.
> >>
> >> If any platform has the limitaion to access default MSI IOVA, then it can
> >> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> >>
> >> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> >> Co-developed-by: Vennila Megavannan <vemegava@linux.microsoft.com>
> >> Signed-off-by: Vennila Megavannan <vemegava@linux.microsoft.com>
> >> ---
> >>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
> >>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 5 ++++-
> >>  2 files changed, 8 insertions(+), 2 deletions(-)
> > 
> > This feels pretty fragile. Wouldn't it be better to realise that there's
> > a region conflict with iommu_dma_get_resv_regions() and move the MSI window
> > accordingly at runtime?
> 
> Since cd2c9fcf5c66 ("iommu/dma: Move PCI window region reservation back
> into dma specific path"), the PCI host bridge windows are not exposed by
> iommu_dma_get_resv_regions() anymore. If I understood correctly, what is
> attempted here is to avoid the collision between such PCI host bridge
> window and the MSI IOVA range.

Either way, I think the kernel should figure this out at runtime and not
rely on a cmdline option to tell it where to place the region.

Will
