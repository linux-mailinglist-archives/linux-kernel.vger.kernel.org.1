Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764612733C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 22:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgIUUpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 16:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgIUUpv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 16:45:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3014720735;
        Mon, 21 Sep 2020 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600721151;
        bh=2azUc9d8t3fHwPUNHpcYBtku3ZGS3Konwm3NpWeBUPU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ol3y6mLGysrQgD+hsUG5Zs8QfPycb6c9FdF4neo3Yl2B/SVvlbRvPSbSEpjww+2bT
         uQo4nTyqiwwW8rqhc69kVyrBTohJyZSTfJKOw07y1OP8yU+hIq6ad10ko+dr9Pn/vT
         pBH3mLd+y9ggYldkOg61tDWF3qUa/bBauierV5Ks=
Date:   Mon, 21 Sep 2020 21:45:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Vennila Megavannan <vemegava@linux.microsoft.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, srinath.mannam@broadcom.com,
        jean-philippe@linaro.org, eric.auger@redhat.com,
        shameerali.kolothum.thodi@huawei.com, tyhicks@linux.microsoft.com,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2] iommu/arm: Add module parameter to set msi iova
 address
Message-ID: <20200921204545.GA3811@willie-the-truck>
References: <20200914181307.117792-1-vemegava@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914181307.117792-1-vemegava@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:13:07AM -0700, Vennila Megavannan wrote:
> From: Srinath Mannam <srinath.mannam@broadcom.com>
> 
> Add provision to change default value of MSI IOVA base to platform's
> suitable IOVA using module parameter. The present hardcoded MSI IOVA base
> may not be the accessible IOVA ranges of platform.
> 
> If any platform has the limitaion to access default MSI IOVA, then it can
> be changed using "arm-smmu.msi_iova_base=0xa0000000" command line argument.
> 
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> Co-developed-by: Vennila Megavannan <vemegava@linux.microsoft.com>
> Signed-off-by: Vennila Megavannan <vemegava@linux.microsoft.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 5 ++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)

This feels pretty fragile. Wouldn't it be better to realise that there's
a region conflict with iommu_dma_get_resv_regions() and move the MSI window
accordingly at runtime?

Will
