Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CD209EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404822AbgFYMy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 08:54:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:42828 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403941AbgFYMy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:54:28 -0400
IronPort-SDR: aRIoltQ/LkVhLChJbSSU9YQMgOOJG/pBfSRD14B36jEYaWEMw2765MdcVeq96ralNpld4zHOiT
 Ir594yd96KNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="132312346"
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="132312346"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 05:54:26 -0700
IronPort-SDR: 604t9fzSsToorAiXk1e2QV9ssp+DA11lpkBgLXjc441qtWdtpCW7bq++NhHiVciHxVJKCHpF1O
 AKsWP6VHxW3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,279,1589266800"; 
   d="scan'208";a="263914182"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.52]) ([10.255.28.52])
  by fmsmga007.fm.intel.com with ESMTP; 25 Jun 2020 05:54:23 -0700
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 7/7] iommu/vt-d: Disable multiple GPASID-dev bind
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-8-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e8725709-8720-ade2-34a3-999f0cf61fde@linux.intel.com>
Date:   Thu, 25 Jun 2020 20:54:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592926996-47914-8-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/23 23:43, Jacob Pan wrote:
> For the unlikely use case where multiple aux domains from the same pdev
> are attached to a single guest and then bound to a single process
> (thus same PASID) within that guest, we cannot easily support this case
> by refcounting the number of users. As there is only one SL page table
> per PASID while we have multiple aux domains thus multiple SL page tables
> for the same PASID.
> 
> Extra unbinding guest PASID can happen due to race between normal and
> exception cases. Termination of one aux domain may affect others unless
> we actively track and switch aux domains to ensure the validity of SL
> page tables and TLB states in the shared PASID entry.
> 
> Support for sharing second level PGDs across domains can reduce the
> complexity but this is not available due to the limitations on VFIO
> container architecture. We can revisit this decision once sharing PGDs
> are available.
> 
> Overall, the complexity and potential glitch do not warrant this unlikely
> use case thereby removed by this patch.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Fixes: 56722a4398a30 ("iommu/vt-d: Add bind guest PASID support")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 6c87c807a0ab..d386853121a2 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -277,20 +277,16 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   			goto out;
>   		}
>   
> +		/*
> +		 * Do not allow multiple bindings of the same device-PASID since
> +		 * there is only one SL page tables per PASID. We may revisit
> +		 * once sharing PGD across domains are supported.
> +		 */
>   		for_each_svm_dev(sdev, svm, dev) {
> -			/*
> -			 * For devices with aux domains, we should allow
> -			 * multiple bind calls with the same PASID and pdev.
> -			 */
> -			if (iommu_dev_feature_enabled(dev,
> -						      IOMMU_DEV_FEAT_AUX)) {
> -				sdev->users++;
> -			} else {
> -				dev_warn_ratelimited(dev,
> -						     "Already bound with PASID %u\n",
> -						     svm->pasid);
> -				ret = -EBUSY;
> -			}
> +			dev_warn_ratelimited(dev,
> +					     "Already bound with PASID %u\n",
> +					     svm->pasid);
> +			ret = -EBUSY;
>   			goto out;
>   		}
>   	} else {
> 
