Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6732EC7B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 02:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhAGB1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 20:27:53 -0500
Received: from mga09.intel.com ([134.134.136.24]:21945 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbhAGB1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 20:27:52 -0500
IronPort-SDR: s0RxL2a4zAD9OIyxTCTy0VkvlQP6Yq+x2eSt31+gSNR5/WGTnKJTG8BuTK04JFPpWEWpTWybP3
 cBWJnIpHKiQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="177511512"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="177511512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 17:26:06 -0800
IronPort-SDR: jzL1YFjGafPDx2idGwAvsKr+rzjXe8L4W+nKAGn8kVJJUaezW9UBr/wrA/0qzDVUpWj5XdPucn
 2HTqzuAMQ5pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="462860266"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jan 2021 17:26:04 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iommu: Delete iommu_dev_has_feature()
To:     John Garry <john.garry@huawei.com>, joro@8bytes.org,
        will@kernel.org
References: <1609940111-28563-1-git-send-email-john.garry@huawei.com>
 <1609940111-28563-7-git-send-email-john.garry@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f05ee600-705a-0c94-2a12-78eb8538234b@linux.intel.com>
Date:   Thu, 7 Jan 2021 09:18:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609940111-28563-7-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 9:35 PM, John Garry wrote:
> Function iommu_dev_has_feature() has never been referenced in the tree,
> and there does not appear to be anything coming soon to use it, so delete
> it.

It will be used by the device driver which want to support the aux-
domain capability, for example, below series is under discussion.

https://lore.kernel.org/linux-pci/160408357912.912050.17005584526266191420.stgit@djiang5-desk3.ch.intel.com/

The typical use case is

         if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
                 rc = iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_AUX);
                 if (rc < 0) {
                         dev_warn(dev, "Failed to enable aux-domain: 
%d\n", rc);
                         return rc;
                 }
         }

So please don't remove it.

Best regards,
baolu

> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iommu.c | 11 -----------
>   include/linux/iommu.h |  7 -------
>   2 files changed, 18 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 20201ef97b8f..91f7871f5a37 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2853,17 +2853,6 @@ EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>   /*
>    * Per device IOMMU features.
>    */
> -bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
> -{
> -	const struct iommu_ops *ops = dev->bus->iommu_ops;
> -
> -	if (ops && ops->dev_has_feat)
> -		return ops->dev_has_feat(dev, feat);
> -
> -	return false;
> -}
> -EXPORT_SYMBOL_GPL(iommu_dev_has_feature);
> -
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 72059fcfa108..91d94c014f47 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -626,7 +626,6 @@ static inline void dev_iommu_priv_set(struct device *dev, void *priv)
>   int iommu_probe_device(struct device *dev);
>   void iommu_release_device(struct device *dev);
>   
> -bool iommu_dev_has_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
>   bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
> @@ -975,12 +974,6 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
>   	return NULL;
>   }
>   
> -static inline bool
> -iommu_dev_has_feature(struct device *dev, enum iommu_dev_features feat)
> -{
> -	return false;
> -}
> -
>   static inline bool
>   iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
>   {
> 
