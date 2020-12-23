Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7783E2E1AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgLWKLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:11:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:6877 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbgLWKLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:11:44 -0500
IronPort-SDR: +Nt7X/0Cc04cuO2hEDAs2hFDTPCyr7baQU1mSW3Q7U/y5rlYJa71Q3A9jPCzuuiK+OGuBZxV+O
 lbutTWspXC+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="237554434"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="237554434"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 02:09:59 -0800
IronPort-SDR: ZVdrO9nG7xzKLhM7QSvFAzVsLK1/FyPy8bPAawVG5tUoYDsKFYf9wyPsBvvzZJ6JkCrU8+Vr3v
 VXn0EiQdL2kg==
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="417147655"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.13]) ([10.254.209.13])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2020 02:09:56 -0800
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        ashok.raj@intel.com, jun.j.tian@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
To:     Liu Yi L <yi.l.liu@intel.com>, joro@8bytes.org, will@kernel.org,
        jacob.jun.pan@linux.intel.com
References: <20201223062720.29364-1-yi.l.liu@intel.com>
 <20201223062720.29364-4-yi.l.liu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <176f7835-a5cf-e049-22b7-724636f74af0@linux.intel.com>
Date:   Wed, 23 Dec 2020 18:09:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201223062720.29364-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On 2020/12/23 14:27, Liu Yi L wrote:
> iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
> loops the devices which are full-attached to the domain. For sub-devices,
> this is ineffective. This results in invalid caching entries left on the
> device. Fix it by adding loop for subdevices as well. Also, the domain->
> has_iotlb_device needs to be updated when attaching to subdevices.
> 
> Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain attach/detach")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 63 +++++++++++++++++++++++++++----------
>   1 file changed, 47 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index acfe0a5b955e..e97c5ac1d7fc 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -726,6 +726,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
>   	return nid;
>   }
>   
> +static void domain_update_iotlb(struct dmar_domain *domain);
> +
>   /* Some capabilities may be different across iommus */
>   static void domain_update_iommu_cap(struct dmar_domain *domain)
>   {
> @@ -739,6 +741,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
>   	 */
>   	if (domain->nid == NUMA_NO_NODE)
>   		domain->nid = domain_update_device_node(domain);
> +
> +	domain_update_iotlb(domain);
>   }
>   
>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
> @@ -1459,6 +1463,18 @@ iommu_support_dev_iotlb (struct dmar_domain *domain, struct intel_iommu *iommu,
>   	return NULL;
>   }
>   
> +static bool dev_iotlb_enabled(struct device_domain_info *info)
> +{
> +	struct pci_dev *pdev;
> +
> +	if (!info->dev || !dev_is_pci(info->dev))
> +		return false;
> +
> +	pdev = to_pci_dev(info->dev);
> +
> +	return !!pdev->ats_enabled;
> +}

I know this is just separated from below function. But isn't "(info &&
info->ats_enabled)" is enough?

> +
>   static void domain_update_iotlb(struct dmar_domain *domain)
>   {
>   	struct device_domain_info *info;
> @@ -1466,17 +1482,20 @@ static void domain_update_iotlb(struct dmar_domain *domain)
>   
>   	assert_spin_locked(&device_domain_lock);
>   
> -	list_for_each_entry(info, &domain->devices, link) {
> -		struct pci_dev *pdev;
> -
> -		if (!info->dev || !dev_is_pci(info->dev))
> -			continue;
> -
> -		pdev = to_pci_dev(info->dev);
> -		if (pdev->ats_enabled) {
> +	list_for_each_entry(info, &domain->devices, link)
> +		if (dev_iotlb_enabled(info)) {
>   			has_iotlb_device = true;
>   			break;
>   		}
> +
> +	if (!has_iotlb_device) {
> +		struct subdev_domain_info *sinfo;
> +
> +		list_for_each_entry(sinfo, &domain->subdevices, link_domain)
> +			if (dev_iotlb_enabled(get_domain_info(sinfo->pdev))) {

Please make the code easier for reading by:

			info = get_domain_info(sinfo->pdev);
			if (dev_iotlb_enabled(info))
				....

Best regards,
baolu

> +				has_iotlb_device = true;
> +				break;
> +			}
>   	}
>   
>   	domain->has_iotlb_device = has_iotlb_device;
> @@ -1557,25 +1576,37 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
>   #endif
>   }
>   
> +static void __iommu_flush_dev_iotlb(struct device_domain_info *info,
> +				    u64 addr, unsigned int mask)
> +{
> +	u16 sid, qdep;
> +
> +	if (!info || !info->ats_enabled)
> +		return;
> +
> +	sid = info->bus << 8 | info->devfn;
> +	qdep = info->ats_qdep;
> +	qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> +			   qdep, addr, mask);
> +}
> +
>   static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
>   				  u64 addr, unsigned mask)
>   {
> -	u16 sid, qdep;
>   	unsigned long flags;
>   	struct device_domain_info *info;
> +	struct subdev_domain_info *sinfo;
>   
>   	if (!domain->has_iotlb_device)
>   		return;
>   
>   	spin_lock_irqsave(&device_domain_lock, flags);
> -	list_for_each_entry(info, &domain->devices, link) {
> -		if (!info->ats_enabled)
> -			continue;
> +	list_for_each_entry(info, &domain->devices, link)
> +		__iommu_flush_dev_iotlb(info, addr, mask);
>   
> -		sid = info->bus << 8 | info->devfn;
> -		qdep = info->ats_qdep;
> -		qi_flush_dev_iotlb(info->iommu, sid, info->pfsid,
> -				qdep, addr, mask);
> +	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> +		__iommu_flush_dev_iotlb(get_domain_info(sinfo->pdev),
> +					addr, mask);
>   	}
>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   }
> 
