Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDD32EB347
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbhAETEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:04:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730685AbhAETEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:04:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96F7322D04;
        Tue,  5 Jan 2021 19:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609873443;
        bh=y0kYfN+LrAWhyyR25aSsaoJEkY35C1Yxkk8M7N/E2J4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvR75V8aW0d0ciN0smmFj7XNGclzJY1D0fCdUoBbFP3bv698eiuihjO6DssKLyqo1
         kYOq+e+47GaI40L7VXDgoPkPuHoj3ZX4YyoL6aHLvrDnGWmvLwOCdfM9zXpo1K2kXV
         dee8BFxFjsocF9h5r4v8pCwqTRDcpmFGl9SGXS7FyuScE71WXHux89tUxs83MJMK+/
         QjOAIWQVmWRyQKQJpwKd29WwFgbgFMdLIvNZvYK/l9Zc6xuBNa31aT/aCvD1dt+MaH
         vgoxkSv91SzuBdpk3MxebNk8vQPGx1ONrqxgWs9hmxRJwsJZ4wnCK9awCDSMyooSN/
         m32xt5SMBPR5A==
Date:   Tue, 5 Jan 2021 19:03:58 +0000
From:   Will Deacon <will@kernel.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Fix unaligned addresses for
 intel_flush_svm_range_dev()
Message-ID: <20210105190357.GA12182@willie-the-truck>
References: <20201231005323.2178523-1-baolu.lu@linux.intel.com>
 <20201231005323.2178523-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231005323.2178523-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 31, 2020 at 08:53:20AM +0800, Lu Baolu wrote:
> The VT-d hardware will ignore those Addr bits which have been masked by
> the AM field in the PASID-based-IOTLB invalidation descriptor. As the
> result, if the starting address in the descriptor is not aligned with
> the address mask, some IOTLB caches might not invalidate. Hence people
> will see below errors.
> 
> [ 1093.704661] dmar_fault: 29 callbacks suppressed
> [ 1093.704664] DMAR: DRHD: handling fault status reg 3
> [ 1093.712738] DMAR: [DMA Read] Request device [7a:02.0] PASID 2
>                fault addr 7f81c968d000 [fault reason 113]
>                SM: Present bit in first-level paging entry is clear
> 
> Fix this by using aligned address for PASID-based-IOTLB invalidation.
> 
> Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
> Reported-and-tested-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 69566695d032..b16a4791acfb 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -118,8 +118,10 @@ void intel_svm_check(struct intel_iommu *iommu)
>  	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
>  }
>  
> -static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
> -				unsigned long address, unsigned long pages, int ih)
> +static void __flush_svm_range_dev(struct intel_svm *svm,
> +				  struct intel_svm_dev *sdev,
> +				  unsigned long address,
> +				  unsigned long pages, int ih)
>  {
>  	struct qi_desc desc;
>  
> @@ -170,6 +172,22 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>  	}
>  }
>  
> +static void intel_flush_svm_range_dev(struct intel_svm *svm,
> +				      struct intel_svm_dev *sdev,
> +				      unsigned long address,
> +				      unsigned long pages, int ih)
> +{
> +	unsigned long shift = ilog2(__roundup_pow_of_two(pages));
> +	unsigned long align = (1ULL << (VTD_PAGE_SHIFT + shift));
> +	unsigned long start = ALIGN_DOWN(address, align);
> +	unsigned long end = ALIGN(address + (pages << VTD_PAGE_SHIFT), align);
> +
> +	while (start < end) {
> +		__flush_svm_range_dev(svm, sdev, start, align >> VTD_PAGE_SHIFT, ih);
> +		start += align;
> +	}
> +}

Given that this only seems to be called from intel_invalidate_range(), which
has to compute 'pages' only to have it pulled apart again here, perhaps it
would be cleaner for intel_flush_svm_range() to take something like an
'order' argument instead?

What do you think?

Will
