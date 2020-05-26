Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0AA91A3137
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 10:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDIIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 04:50:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59507 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726470AbgDIIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586422246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u2fceF1M14wMp/BK97Chv1GweqKhrjPEWHzm2vGZbl0=;
        b=GvzOKeJoFecl2xtxZnQD5/SpSjcMKKu8Ae81nASP0k2DaXbW47inF5bz7hQc/qr2JF5FSC
        CQOe8RtTxYWnYPjrrT2oRdIuw0KpYl69seESrLuaA/YeynGr990mk0bITC3vMQxMj/GRAO
        cJBGKNF5nM80o+ZJ4o7ds7PdlYwWeGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-1h2Ir3s-PW2xwFgPcFGy8A-1; Thu, 09 Apr 2020 04:50:44 -0400
X-MC-Unique: 1h2Ir3s-PW2xwFgPcFGy8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BDA1107ACC9;
        Thu,  9 Apr 2020 08:50:41 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E37519A253;
        Thu,  9 Apr 2020 08:50:35 +0000 (UTC)
Subject: Re: [PATCH v11 07/10] iommu/vt-d: Add svm/sva invalidate function
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <7867ade8-3e11-30af-b123-7f8ac3722b81@redhat.com>
Date:   Thu, 9 Apr 2020 10:50:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585939334-21396-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 4/3/20 8:42 PM, Jacob Pan wrote:
> When Shared Virtual Address (SVA) is enabled for a guest OS via
> vIOMMU, we need to provide invalidation support at IOMMU API and driver
> level. This patch adds Intel VT-d specific function to implement
> iommu passdown invalidate API for shared virtual address.
> 
> The use case is for supporting caching structure invalidation
> of assigned SVM capable devices. Emulated IOMMU exposes queue
> invalidation capability and passes down all descriptors from the guest
> to the physical IOMMU.
> 
> The assumption is that guest to host device ID mapping should be
> resolved prior to calling IOMMU driver. Based on the device handle,
> host IOMMU driver can replace certain fields before submit to the
> invalidation queue.
> 
> ---
> v11 - Removed 2D map array, use -EINVAL in granularity lookup array.
>       Fixed devTLB invalidation granularity mapping. Disregard G=1 case
>       and use address selective invalidation only.
> 
> v7 review fixed in v10
> ---
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 158 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 94c7993dac6a..045c5c08d71d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5594,6 +5594,163 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>  	aux_domain_remove_dev(to_dmar_domain(domain), dev);
>  }
>  
> +/*
> + * 2D array for converting and sanitizing IOMMU generic TLB granularity to
> + * VT-d granularity. Invalidation is typically included in the unmap operation
> + * as a result of DMA or VFIO unmap. However, for assigned devices guest
> + * owns the first level page tables. Invalidations of translation caches in the
> + * guest are trapped and passed down to the host.
> + *
> + * vIOMMU in the guest will only expose first level page tables, therefore
> + * we do not support IOTLB granularity for request without PASID (second level).
> + *
> + * For example, to find the VT-d granularity encoding for IOTLB
> + * type and page selective granularity within PASID:
> + * X: indexed by iommu cache type
> + * Y: indexed by enum iommu_inv_granularity
> + * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
> + */
> +
> +const static int inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
> +	/*
> +	 * PASID based IOTLB invalidation: PASID selective (per PASID),
> +	 * page selective (address granularity)
> +	 */
> +	{-EINVAL, QI_GRAN_NONG_PASID, QI_GRAN_PSI_PASID},
> +	/* PASID based dev TLBs */
> +	{-EINVAL, -EINVAL, QI_DEV_IOTLB_GRAN_PASID_SEL},
> +	/* PASID cache */
> +	{-EINVAL, -EINVAL, -EINVAL}
> +};
> +
> +static inline int to_vtd_granularity(int type, int granu)
> +{
> +	return inv_type_granu_table[type][granu];
> +}
> +
> +static inline u64 to_vtd_size(u64 granu_size, u64 nr_granules)
> +{
> +	u64 nr_pages = (granu_size * nr_granules) >> VTD_PAGE_SHIFT;
> +
> +	/* VT-d size is encoded as 2^size of 4K pages, 0 for 4k, 9 for 2MB, etc.
> +	 * IOMMU cache invalidate API passes granu_size in bytes, and number of
> +	 * granu size in contiguous memory.
> +	 */
> +	return order_base_2(nr_pages);
> +}
> +
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
> +		struct device *dev, struct iommu_cache_invalidate_info *inv_info)
> +{
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct device_domain_info *info;
> +	struct intel_iommu *iommu;
> +	unsigned long flags;
> +	int cache_type;
> +	u8 bus, devfn;
> +	u16 did, sid;
> +	int ret = 0;
> +	u64 size = 0;
> +
> +	if (!inv_info || !dmar_domain ||
> +		inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> +		return -EINVAL;
> +
> +	if (!dev || !dev_is_pci(dev))
> +		return -ENODEV;

Check (domain->flags & DOMAIN_FLAG_NESTING_MODE)?
> +
> +	iommu = device_to_iommu(dev, &bus, &devfn);
> +	if (!iommu)
> +		return -ENODEV;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	spin_lock(&iommu->lock);
> +	info = iommu_support_dev_iotlb(dmar_domain, iommu, bus, devfn);
> +	if (!info) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +	did = dmar_domain->iommu_did[iommu->seq_id];
> +	sid = PCI_DEVID(bus, devfn);
> +
> +	/* Size is only valid in non-PASID selective invalidation */
> +	if (inv_info->granularity != IOMMU_INV_GRANU_PASID)
> +		size = to_vtd_size(inv_info->addr_info.granule_size,
> +				   inv_info->addr_info.nb_granules);
> +
> +	for_each_set_bit(cache_type, (unsigned long *)&inv_info->cache, IOMMU_CACHE_INV_TYPE_NR) {
> +		int granu = 0;
> +		u64 pasid = 0;
> +
> +		granu = to_vtd_granularity(cache_type, inv_info->granularity);
> +		if (granu == -EINVAL) {
> +			pr_err("Invalid cache type and granu combination %d/%d\n", cache_type,
> +				inv_info->granularity);
rate unlimited traces here and after.
ret = -EINVAL?
also related to the discussion we had on the VFIO series. What is the
error policy?
> +			break;
> +		}
> +
> +		/* PASID is stored in different locations based on granularity */
not sure the above comment really is requested
> +		if (inv_info->granularity == IOMMU_INV_GRANU_PASID &&
> +			inv_info->pasid_info.flags & IOMMU_INV_PASID_FLAGS_PASID)
> +			pasid = inv_info->pasid_info.pasid;
> +		else if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> +			inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_PASID)
> +			pasid = inv_info->addr_info.pasid;
> +
> +		switch (BIT(cache_type)) {
> +		case IOMMU_CACHE_INV_TYPE_IOTLB:
> +			if ((inv_info->granularity == IOMMU_INV_GRANU_ADDR) &&
> +				size && (inv_info->addr_info.addr & ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> +				pr_err("Address out of range, 0x%llx, size order %llu\n",
> +					inv_info->addr_info.addr, size);
> +				ret = -ERANGE;
> +				goto out_unlock;
> +			}
> +
> +			qi_flush_piotlb(iommu, did,
> +					pasid,
> +					mm_to_dma_pfn(inv_info->addr_info.addr),
This does not sound correct to me:
inv_info->addr_info.addr and inv_info->addr_info.flags are not valid in
case of PASID-selective invalidation
> +					(granu == QI_GRAN_NONG_PASID) ? -1 : 1 << size,
> +					inv_info->addr_info.flags & IOMMU_INV_ADDR_FLAGS_LEAF);
> +
> +			/*
> +			 * Always flush device IOTLB if ATS is enabled. vIOMMU
> +			 * in the guest may assume IOTLB flush is inclusive,
> +			 * which is more efficient.
> +			 */
> +			if (info->ats_enabled)
> +				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
> +						pasid, info->ats_qdep,
> +						inv_info->addr_info.addr, size,
same
> +						granu);
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_DEV_IOTLB:
> +			if (info->ats_enabled)
> +				qi_flush_dev_iotlb_pasid(iommu, sid, info->pfsid,
> +						inv_info->addr_info.pasid, info->ats_qdep,
nit: use pasid directly
> +						inv_info->addr_info.addr, size,
> +						granu);
> +			else
> +				pr_warn("Passdown device IOTLB flush w/o ATS!\n");
> +			break;
> +		case IOMMU_CACHE_INV_TYPE_PASID:
> +			qi_flush_pasid_cache(iommu, did, granu, inv_info->pasid_info.pasid);
> +			break;
> +		default:
> +			dev_err(dev, "Unsupported IOMMU invalidation type %d\n",
> +				cache_type);
> +			ret = -EINVAL;
> +		}
> +	}
> +out_unlock:
> +	spin_unlock(&iommu->lock);
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +
> +	return ret;
> +}
> +#endif
> +
>  static int intel_iommu_map(struct iommu_domain *domain,
>  			   unsigned long iova, phys_addr_t hpa,
>  			   size_t size, int iommu_prot, gfp_t gfp)
> @@ -6179,6 +6336,7 @@ const struct iommu_ops intel_iommu_ops = {
>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> +	.cache_invalidate	= intel_iommu_sva_invalidate,
>  	.sva_bind_gpasid	= intel_svm_bind_gpasid,
>  	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
>  #endif
> 
Thanks

Eric

