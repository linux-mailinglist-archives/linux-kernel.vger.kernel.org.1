Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDEF2B5BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbgKQJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:40:29 -0500
Received: from mga01.intel.com ([192.55.52.88]:57995 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgKQJk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:40:28 -0500
IronPort-SDR: xVRL7Cg5a+eLtfPTsa80Qdb/PnRdiOylA0hYG5MQcOFLS7iRoTh2pvyFl5AhvVfIR3+9BYWdAj
 PT3CdOiyqL6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="188948466"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="188948466"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 01:40:28 -0800
IronPort-SDR: 9AsrYM+adnWGB4Kk6D6oTAxWpSRW8QvUGbbtkQOgp7+RD7Psnm1sC0mJDUnJN6yC6ZbOXqUnyW
 guA7es+NYjaQ==
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="367806571"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.201]) ([10.254.210.201])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 01:40:27 -0800
Cc:     baolu.lu@linux.intel.com
Subject: Re: [PATCH] iommu: fix return error code in iommu_probe_device()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20201117025238.3425422-1-yangyingliang@huawei.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <835ab066-b6b8-a211-4941-c01781031de8@linux.intel.com>
Date:   Tue, 17 Nov 2020 17:40:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201117025238.3425422-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yingliang,

On 2020/11/17 10:52, Yang Yingliang wrote:
> If iommu_group_get() failed, it need return error code
> in iommu_probe_device().
> 
> Fixes: cf193888bfbd ("iommu: Move new probe_device path...")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/iommu/iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b53446bb8c6b..6f4a32df90f6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -253,8 +253,10 @@ int iommu_probe_device(struct device *dev)
>   		goto err_out;
>   
>   	group = iommu_group_get(dev);
> -	if (!group)
> +	if (!group) {
> +		ret = -ENODEV;

Can you please explain why you use -ENODEV here?

Best regards,
baolu

>   		goto err_release;
> +	}
>   
>   	/*
>   	 * Try to allocate a default domain - needs support from the
> 
