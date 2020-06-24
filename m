Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98961206C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 08:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbgFXGaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 02:30:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:6135 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388262AbgFXGaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:30:02 -0400
IronPort-SDR: FucgLOVTk94fsZ1QmUtKkxLN8IYLI4O4BSwTMFuA5eMx4UQunjt/hcFzYRbxpkIbUTCTJeIm7g
 WDaJU4FaYKZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="132778391"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="132778391"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 23:30:01 -0700
IronPort-SDR: heLb5YqZ34s7Gf1o2pn7jMTrEA/w/dhHL5mZWjYGISN0S7EVZuUpysveKoBos56JldFv7oufvg
 RcmiUtbsKi7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; 
   d="scan'208";a="423268446"
Received: from msaix-mobl2.ccr.corp.intel.com (HELO [10.255.28.245]) ([10.255.28.245])
  by orsmga004.jf.intel.com with ESMTP; 23 Jun 2020 23:29:58 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 3/5] iommu/uapi: Use named union for user data
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-4-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <96f6d717-e9b3-2a6b-5cff-c38dbe97aa7c@linux.intel.com>
Date:   Wed, 24 Jun 2020 14:29:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592931837-58223-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2020/6/24 1:03, Jacob Pan wrote:
> IOMMU UAPI data size is filled by the user space which must be validated
> by ther kernel. To ensure backward compatibility, user data can only be
> extended by either re-purpose padding bytes or extend the variable sized
> union at the end. No size change is allowed before the union. Therefore,
> the minimum size is the offset of the union.
> 
> To use offsetof() on the union, we must make it named.
> 
> Link: https://lkml.org/lkml/2020/6/11/834
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 24 ++++++++++++------------
>   drivers/iommu/intel/svm.c   |  2 +-
>   include/uapi/linux/iommu.h  |  4 ++--
>   3 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 50fc62413a35..59cba214ef13 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5409,8 +5409,8 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   
>   	/* Size is only valid in address selective invalidation */
>   	if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
> -		size = to_vtd_size(inv_info->addr_info.granule_size,
> -				   inv_info->addr_info.nb_granules);
> +		size = to_vtd_size(inv_info->granu.addr_info.granule_size,
> +				   inv_info->granu.addr_info.nb_granules);
>   
>   	for_each_set_bit(cache_type,
>   			 (unsigned long *)&inv_info->cache,
> @@ -5431,20 +5431,20 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   		 * granularity.
>   		 */
>   		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
> -		    (inv_info->pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
> -			pasid = inv_info->pasid_info.pasid;
> +		    (inv_info->granu.pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID))
> +			pasid = inv_info->granu.pasid_info.pasid;
>   		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> -			 (inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
> -			pasid = inv_info->addr_info.pasid;
> +			 (inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID))
> +			pasid = inv_info->granu.addr_info.pasid;
>   
>   		switch (BIT(cache_type)) {
>   		case IOMMU_CACHE_INV_TYPE_IOTLB:
>   			/* HW will ignore LSB bits based on address mask */
>   			if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
>   			    size &&
> -			    (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> +				(inv_info->granu.addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {

Nit: Keep it aligned. With this tweaked,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

>   				WARN_ONCE(1, "Address out of range, 0x%llx, size order %llu\n",
> -					  inv_info->addr_info.addr, size);
> +					  inv_info->granu.addr_info.addr, size);
>   			}
>   
>   			/*
> @@ -5452,9 +5452,9 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   			 * We use npages = -1 to indicate that.
>   			 */
>   			qi_flush_piotlb(iommu, did, pasid,
> -					mm_to_dma_pfn(inv_info->addr_info.addr),
> +					mm_to_dma_pfn(inv_info->granu.addr_info.addr),
>   					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
> -					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
> +					inv_info->granu.addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
>   
>   			if (!info->ats_enabled)
>   				break;
> @@ -5475,13 +5475,13 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>   				size = 64 - VTD_PAGE_SHIFT;
>   				addr = 0;
>   			} else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR)
> -				addr = inv_info->addr_info.addr;
> +				addr = inv_info->granu.addr_info.addr;
>   
>   			if (info->ats_enabled)
>   				qi_flush_dev_iotlb_pasid(iommu, sid,
>   						info->pfsid, pasid,
>   						info->ats_qdep,
> -						inv_info->addr_info.addr,
> +						inv_info->granu.addr_info.addr,
>   						size);
>   			else
>   				pr_warn_ratelimited("Passdown device IOTLB flush w/o ATS!\n");
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index d386853121a2..713b3a218483 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -338,7 +338,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	spin_lock(&iommu->lock);
>   	ret = intel_pasid_setup_nested(iommu, dev,
>   				       (pgd_t *)(uintptr_t)data->gpgd,
> -				       data->hpasid, &data->vtd, dmar_domain,
> +				       data->hpasid, &data->vendor.vtd, dmar_domain,
>   				       data->addr_width);
>   	spin_unlock(&iommu->lock);
>   	if (ret) {
> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> index 303f148a5cd7..1afc6610b0ad 100644
> --- a/include/uapi/linux/iommu.h
> +++ b/include/uapi/linux/iommu.h
> @@ -263,7 +263,7 @@ struct iommu_cache_invalidate_info {
>   	union {
>   		struct iommu_inv_pasid_info pasid_info;
>   		struct iommu_inv_addr_info addr_info;
> -	};
> +	} granu;
>   };
>   
>   /**
> @@ -329,7 +329,7 @@ struct iommu_gpasid_bind_data {
>   	/* Vendor specific data */
>   	union {
>   		struct iommu_gpasid_bind_data_vtd vtd;
> -	};
> +	} vendor;
>   };
>   
>   #endif /* _UAPI_IOMMU_H */
> 
