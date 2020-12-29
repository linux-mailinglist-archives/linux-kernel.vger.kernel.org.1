Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968272E6F11
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:44:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgL2InV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:43:21 -0500
Received: from mga11.intel.com ([192.55.52.93]:7003 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgL2InV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:43:21 -0500
IronPort-SDR: 0wUL2/imjy1ORTpV905tUJHbEQy5uBjfwO4lDQnlcEQ6A32aLxd6MsZ8ikH0Mayvcfiv+9a2op
 9dT7feI84jzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="172963055"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="172963055"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 00:41:35 -0800
IronPort-SDR: Lr5VZeKrmI70xAdjYiNIdUs8pTXMa3RoOoed4mhyolDUiJ0GRapWqmqxA9A4NfuZTGRXhsCm3a
 K7JqplBwDsyA==
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="375977681"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.128]) ([10.254.213.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 00:41:32 -0800
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        jun.j.tian@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iommu/vt-d: Fix ineffective devTLB invalidation
 for subdevices
To:     Liu Yi L <yi.l.liu@intel.com>, joro@8bytes.org, will@kernel.org
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-4-yi.l.liu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c109eb64-2805-5e87-2283-b52c5704a31f@linux.intel.com>
Date:   Tue, 29 Dec 2020 16:41:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201229032513.486395-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On 2020/12/29 11:25, Liu Yi L wrote:
> iommu_flush_dev_iotlb() is called to invalidate caches on device. It only
> loops the devices which are full-attached to the domain. For sub-devices,
> this is ineffective. This results in invalid caching entries left on the
> device. Fix it by adding loop for subdevices as well. Also, the domain->
> has_iotlb_device needs to be updated when attaching to subdevices.
> 
> Fixes: 67b8e02b5e761 ("iommu/vt-d: Aux-domain specific domain attach/detach")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 53 ++++++++++++++++++++++++++-----------
>   1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index d7720a836268..d48a60b61ba6 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -719,6 +719,8 @@ static int domain_update_device_node(struct dmar_domain *domain)
>   	return nid;
>   }
>   
> +static void domain_update_iotlb(struct dmar_domain *domain);
> +
>   /* Some capabilities may be different across iommus */
>   static void domain_update_iommu_cap(struct dmar_domain *domain)
>   {
> @@ -744,6 +746,8 @@ static void domain_update_iommu_cap(struct dmar_domain *domain)
>   		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw - 1);
>   	else
>   		domain->domain.geometry.aperture_end = __DOMAIN_MAX_ADDR(domain->gaw);
> +
> +	domain_update_iotlb(domain);
>   }
>   
>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
> @@ -1464,17 +1468,22 @@ static void domain_update_iotlb(struct dmar_domain *domain)
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
> +		if (info && info->ats_enabled) {
>   			has_iotlb_device = true;
>   			break;
>   		}
> +
> +	if (!has_iotlb_device) {
> +		struct subdev_domain_info *sinfo;
> +
> +		list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
> +			info = get_domain_info(sinfo->pdev);
> +			if (info && info->ats_enabled) {
> +				has_iotlb_device = true;
> +				break;
> +			}
> +		}
>   	}
>   
>   	domain->has_iotlb_device = has_iotlb_device;
> @@ -1555,25 +1564,37 @@ static void iommu_disable_dev_iotlb(struct device_domain_info *info)
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

Nit:
	list_for_each_entry(sinfo, &domain->subdevices, link_domain) {
		info = get_domain_info(sinfo->pdev);
		__iommu_flush_dev_iotlb(info, addr, mask);
	}

Others look good to me.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

>   	spin_unlock_irqrestore(&device_domain_lock, flags);
>   }
> 
