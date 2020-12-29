Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522572E6EF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgL2IgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:36:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:26292 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgL2IgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:36:01 -0500
IronPort-SDR: NlETc2W29k6af+j3QkfSRaoKxQYw2v/Doel41/8f6GL4zJNFO5l93sDq+huM5/ggos9rYZHeTb
 nUQvm20nPyLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="155676153"
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="155676153"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 00:34:16 -0800
IronPort-SDR: mNqGDTo8bZC9r7pqFGGOIL3Uj28r1wTmeoVadAPW1Yar8IYzyBYq0De1Ie37+CCYrMkC36x9Mn
 +L+6M1cpnVPg==
X-IronPort-AV: E=Sophos;i="5.78,457,1599548400"; 
   d="scan'208";a="375976030"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.128]) ([10.254.213.128])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 00:34:13 -0800
Cc:     baolu.lu@linux.intel.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, ashok.raj@intel.com,
        jun.j.tian@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Guo Kaijie <Kaijie.Guo@intel.com>,
        Xin Zeng <xin.zeng@intel.com>
Subject: Re: [PATCH v3 1/3] iommu/vt-d: Move intel_iommu info from struct
 intel_svm to struct intel_svm_dev
To:     Liu Yi L <yi.l.liu@intel.com>, joro@8bytes.org, will@kernel.org
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-2-yi.l.liu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <274709e9-cd09-3c54-ccfb-ef871f0adcdc@linux.intel.com>
Date:   Tue, 29 Dec 2020 16:34:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201229032513.486395-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yi,

On 2020/12/29 11:25, Liu Yi L wrote:
> Current struct intel_svm has a field to record the struct intel_iommu
> pointer for a PASID bind. And struct intel_svm will be shared by all
> the devices bind to the same process. The devices may be behind different
> DMAR units. As the iommu driver code uses the intel_iommu pointer stored
> in intel_svm struct to do cache invalidations, it may only flush the cache
> on a single DMAR unit, for others, the cache invalidation is missed.
> 
> As intel_svm struct already has a device list, this patch just moves the
> intel_iommu pointer to be a field of intel_svm_dev struct.
> 
> Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Raj Ashok <ashok.raj@intel.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Reported-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Reported-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Guo Kaijie <Kaijie.Guo@intel.com>
> Signed-off-by: Xin Zeng <xin.zeng@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

This fix looks good to me. Thanks!

Cc: stable@vger.kernel.org # v5.0+
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c   | 9 +++++----
>   include/linux/intel-iommu.h | 2 +-
>   2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 4fa248b98031..69566695d032 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -142,7 +142,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>   	}
>   	desc.qw2 = 0;
>   	desc.qw3 = 0;
> -	qi_submit_sync(svm->iommu, &desc, 1, 0);
> +	qi_submit_sync(sdev->iommu, &desc, 1, 0);
>   
>   	if (sdev->dev_iotlb) {
>   		desc.qw0 = QI_DEV_EIOTLB_PASID(svm->pasid) |
> @@ -166,7 +166,7 @@ static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_d
>   		}
>   		desc.qw2 = 0;
>   		desc.qw3 = 0;
> -		qi_submit_sync(svm->iommu, &desc, 1, 0);
> +		qi_submit_sync(sdev->iommu, &desc, 1, 0);
>   	}
>   }
>   
> @@ -211,7 +211,7 @@ static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>   	 */
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(sdev, &svm->devs, list)
> -		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
> +		intel_pasid_tear_down_entry(sdev->iommu, sdev->dev,
>   					    svm->pasid, true);
>   	rcu_read_unlock();
>   
> @@ -363,6 +363,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	}
>   	sdev->dev = dev;
>   	sdev->sid = PCI_DEVID(info->bus, info->devfn);
> +	sdev->iommu = iommu;
>   
>   	/* Only count users if device has aux domains */
>   	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> @@ -546,6 +547,7 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
>   		goto out;
>   	}
>   	sdev->dev = dev;
> +	sdev->iommu = iommu;
>   
>   	ret = intel_iommu_enable_pasid(iommu, dev);
>   	if (ret) {
> @@ -575,7 +577,6 @@ intel_svm_bind_mm(struct device *dev, unsigned int flags,
>   			kfree(sdev);
>   			goto out;
>   		}
> -		svm->iommu = iommu;
>   
>   		if (pasid_max > intel_pasid_max_id)
>   			pasid_max = intel_pasid_max_id;
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index d956987ed032..94522685a0d9 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -758,6 +758,7 @@ struct intel_svm_dev {
>   	struct list_head list;
>   	struct rcu_head rcu;
>   	struct device *dev;
> +	struct intel_iommu *iommu;
>   	struct svm_dev_ops *ops;
>   	struct iommu_sva sva;
>   	u32 pasid;
> @@ -771,7 +772,6 @@ struct intel_svm {
>   	struct mmu_notifier notifier;
>   	struct mm_struct *mm;
>   
> -	struct intel_iommu *iommu;
>   	unsigned int flags;
>   	u32 pasid;
>   	int gpasid; /* In case that guest PASID is different from host PASID */
> 
