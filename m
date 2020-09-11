Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C895126621A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 17:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgIKP1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 11:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgIKPUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:20:23 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BFE9207FB;
        Fri, 11 Sep 2020 15:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599837420;
        bh=UgW+C5QZjycibLoS/tcqKqhyMmI/U+lFQKYBS2XVPfA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kLZgioYIEs3XGoa0lj43AdrxF1oOXBVHEQwIQcQdQQ6uniLSEZOA///PyQk1yAr7F
         R1a1Js+N7TSzeRMpZ4rTDZblWrr0SpM4Hgoi3EmVaLPwOWEqfMpu+aU6EGEmw+os7h
         F4UtW2iKcmB2ti/DMFP5NMxyftQvYRhY/4gEzkh8=
Date:   Fri, 11 Sep 2020 10:16:59 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, poza@codeaurora.org,
        bcm-kernel-feedback-list@broadcom.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/dma: Fix IOVA reserve dma ranges
Message-ID: <20200911151659.GA868760@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911102534.25218-1-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:55:34PM +0530, Srinath Mannam wrote:
> Fix IOVA reserve failure in the case when address of first memory region
> listed in dma-ranges is equal to 0x0.
> 
> Fixes: aadad097cd46f ("iommu/dma: Reserve IOVA for PCIe inaccessible DMA address")
> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> ---
> Changes from v1:
>    Removed unnecessary changes based on Robin's review comments.
> 
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 5141d49a046b..682068a9aae7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -217,7 +217,7 @@ static int iova_reserve_pci_windows(struct pci_dev *dev,
>  			lo = iova_pfn(iovad, start);
>  			hi = iova_pfn(iovad, end);
>  			reserve_iova(iovad, lo, hi);
> -		} else {
> +		} else if (end < start) {
>  			/* dma_ranges list should be sorted */
>  			dev_err(&dev->dev, "Failed to reserve IOVA\n");

You didn't actually change the error message, but the message would be
way more useful if it included the IOVA address range, e.g., the
format used in pci_register_host_bridge():

  bus address [%#010llx-%#010llx]

Incidentally, the pr_err() in copy_reserved_iova() looks bogus; it
prints iova->pfn_low twice, when it should probably print the base and
size or (my preference) something like the above:

        pr_err("Reserve iova range %lx@%lx failed\n",
               iova->pfn_lo, iova->pfn_lo);

>  			return -EINVAL;
> -- 
> 2.17.1
> 
