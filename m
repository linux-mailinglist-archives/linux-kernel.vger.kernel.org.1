Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF52A0600
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgJ3MzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:55:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:41701 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgJ3MzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:55:02 -0400
IronPort-SDR: 8g4/bP29pOJTW2/7tWSTB9SrHOzJdcjcK/414CA89c5TUzBMZ0bB9D2Vuk7H4D2pgIfCoJCJ7i
 kLjy2rNoklqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="168730382"
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="168730382"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 05:55:01 -0700
IronPort-SDR: EQEJIWfEwF9HnjLzf2NvqY/yF+Agy3SzVDSC7NzNZ1QYd5tQlCOS0evb1dYdDAnpIcJJ8EI9ba
 n1f5Ha+xYAiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,433,1596524400"; 
   d="scan'208";a="425338716"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2020 05:54:56 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yi.l.liu@intel.com,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Fix sid not set issue in
 intel_svm_bind_gpasid()
To:     Yi Sun <yi.y.sun@linux.intel.com>, joro@8bytes.org,
        dwmw2@infradead.org, jean-philippe@linaro.org
References: <1604025444-6954-1-git-send-email-yi.y.sun@linux.intel.com>
 <1604025444-6954-2-git-send-email-yi.y.sun@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fa69b000-b790-ae8c-2a40-618ca2631ac4@linux.intel.com>
Date:   Fri, 30 Oct 2020 20:48:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1604025444-6954-2-git-send-email-yi.y.sun@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/20 10:37 AM, Yi Sun wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Should get correct sid and set it into sdev. Because we execute
> 'sdev->sid != req->rid' in the loop of prq_event_thread().
> 
> Fixes: eb8d93ea3c1d ("iommu/vt-d: Report page request faults for guest SVA")
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>

Cc: stable@ver.kernel.org
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/svm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index f1861fa..7584669 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -279,6 +279,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
>   	struct intel_svm_dev *sdev = NULL;
>   	struct dmar_domain *dmar_domain;
> +	struct device_domain_info *info;
>   	struct intel_svm *svm = NULL;
>   	int ret = 0;
>   
> @@ -310,6 +311,10 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
>   		return -EINVAL;
>   
> +	info = get_domain_info(dev);
> +	if (!info)
> +		return -EINVAL;
> +
>   	dmar_domain = to_dmar_domain(domain);
>   
>   	mutex_lock(&pasid_mutex);
> @@ -357,6 +362,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   		goto out;
>   	}
>   	sdev->dev = dev;
> +	sdev->sid = PCI_DEVID(info->bus, info->devfn);
>   
>   	/* Only count users if device has aux domains */
>   	if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
> 
