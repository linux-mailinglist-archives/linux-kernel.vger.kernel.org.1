Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428342E8A09
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 03:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbhACCl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 21:41:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:18641 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbhACCl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 21:41:56 -0500
IronPort-SDR: dKjyHvQvux+q0F1dQy8OzihyaQJJFGQ8Wo/oBvyoD2SVT3zqXXryUyi0gn/FwOMEQE9vtPJ+Jn
 3qmEDxNEHIEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9852"; a="195362287"
X-IronPort-AV: E=Sophos;i="5.78,470,1599548400"; 
   d="scan'208";a="195362287"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 18:40:11 -0800
IronPort-SDR: P+etS6HLK4+UjGSY7334oDp07VxB1Xm/gJX+SVuH5+ytpFsKZdT0MEYg0sVVsDOnInXX5ZB8gK
 I1Qey11Nbz4Q==
X-IronPort-AV: E=Sophos;i="5.78,470,1599548400"; 
   d="scan'208";a="377852225"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.85]) ([10.255.29.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 18:40:08 -0800
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/intel: Fix memleak in intel_irq_remapping_alloc
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
Date:   Sun, 3 Jan 2021 10:40:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2021/1/2 17:50, Dinghao Liu wrote:
> When irq_domain_get_irq_data() or irqd_cfg() fails
> meanwhile i == 0, data allocated by kzalloc() has not
> been freed before returning, which leads to memleak.
> 
> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>   drivers/iommu/intel/irq_remapping.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
> index aeffda92b10b..cdaeed36750f 100644
> --- a/drivers/iommu/intel/irq_remapping.c
> +++ b/drivers/iommu/intel/irq_remapping.c
> @@ -1354,6 +1354,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>   		irq_cfg = irqd_cfg(irq_data);
>   		if (!irq_data || !irq_cfg) {
>   			ret = -EINVAL;
> +			kfree(data);
> +			data = NULL;

Do you need to check (i == 0) here? @data will not be used anymore as it
goes to out branch, why setting it to NULL here?

Best regards,
baolu

>   			goto out_free_data;
>   		}
>   
> 
