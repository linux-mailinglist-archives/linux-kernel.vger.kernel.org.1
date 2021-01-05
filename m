Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8102EA6B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbhAEIjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:39:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:21264 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbhAEIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:39:54 -0500
IronPort-SDR: 1huZwnIguLSFcmFzyQEicRkhd1rrfmFxD9P28DarCKWBiv5FtfQRX+WLpF/xvAp1XxHdoHGaUi
 t5ZgLs/qHwJQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="174497023"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="174497023"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 00:38:08 -0800
IronPort-SDR: fjso8MDkRt0bDaK8tjG9nFUo6M26/FF0GM8Ay7tk7D+GSlb6ccB7iq6K9rt2D8VZzbMpAgT+rI
 6JOCBkzCDFLw==
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; 
   d="scan'208";a="421700560"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.171.36]) ([10.249.171.36])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 00:38:06 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iommu/intel: Fix memleak in
 intel_irq_remapping_alloc
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
References: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ca8f9997-4310-710e-07a5-e2f0be57e916@linux.intel.com>
Date:   Tue, 5 Jan 2021 16:38:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210105051837.32118-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/5 13:18, Dinghao Liu wrote:
> When irq_domain_get_irq_data() or irqd_cfg() fails
> at i == 0, data allocated by kzalloc() has not been
> freed before returning, which leads to memleak.
> 
> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> 
> Changelog:
> 
> v2: - Add a check against i instead of setting data to NULL.
> ---
>   drivers/iommu/intel/irq_remapping.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index aeffda92b10b..685200a5cff0 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1353,6 +1353,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>   		irq_data = irq_domain_get_irq_data(domain, virq + i);
>   		irq_cfg = irqd_cfg(irq_data);
>   		if (!irq_data || !irq_cfg) {
> +			if (!i)
> +				kfree(data);
>   			ret = -EINVAL;
>   			goto out_free_data;
>   		}
> 
