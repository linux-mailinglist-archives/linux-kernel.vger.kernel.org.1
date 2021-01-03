Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E4E2E8B08
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 06:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbhACFvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 00:51:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:3749 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbhACFvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 00:51:15 -0500
IronPort-SDR: UedIH9wEWaFzvH3jRUuwCB7Uu4FB0Qh3sKHmdxRHKrhxuPfL9wnLSqabIt6UrmLKXZ4oGZXO6e
 BzLQ9NZti7kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9852"; a="156639442"
X-IronPort-AV: E=Sophos;i="5.78,471,1599548400"; 
   d="scan'208";a="156639442"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 21:49:30 -0800
IronPort-SDR: AZJ3z3f/50BAGBVx8UDBX5zmZx51m+XlxeNwiNuVsZHKwRwbKAFslm7Yam1MbcUTkq6wc4xLWU
 WtLbyvtH3ijQ==
X-IronPort-AV: E=Sophos;i="5.78,471,1599548400"; 
   d="scan'208";a="377891336"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.29.85]) ([10.255.29.85])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2021 21:49:27 -0800
Cc:     baolu.lu@linux.intel.com, kjlu@umn.edu,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/intel: Fix memleak in intel_irq_remapping_alloc
To:     dinghao.liu@zju.edu.cn
References: <20210102095029.29053-1-dinghao.liu@zju.edu.cn>
 <18add30d-a830-c531-6fd2-58a1898b157f@linux.intel.com>
 <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
Date:   Sun, 3 Jan 2021 13:49:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <50870a42.15f1a.176c66eaf92.Coremail.dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/3 12:08, dinghao.liu@zju.edu.cn wrote:
>> Hi,
>>
>> On 2021/1/2 17:50, Dinghao Liu wrote:
>>> When irq_domain_get_irq_data() or irqd_cfg() fails
>>> meanwhile i == 0, data allocated by kzalloc() has not
>>> been freed before returning, which leads to memleak.
>>>
>>> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
>>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>>> ---
>>>    drivers/iommu/intel/irq_remapping.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
>>> index aeffda92b10b..cdaeed36750f 100644
>>> --- a/drivers/iommu/intel/irq_remapping.c
>>> +++ b/drivers/iommu/intel/irq_remapping.c
>>> @@ -1354,6 +1354,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>>>    		irq_cfg = irqd_cfg(irq_data);
>>>    		if (!irq_data || !irq_cfg) {
>>>    			ret = -EINVAL;
>>> +			kfree(data);
>>> +			data = NULL;
>>
>> Do you need to check (i == 0) here? @data will not be used anymore as it
>> goes to out branch, why setting it to NULL here?
>>
> 
> data will be passed to ire_data->chip_data when i == 0 and
> intel_free_irq_resources() will free it on failure. Thus I

Isn't it going to "goto out_free_data"? If "i == 0", the allocated @data
won't be freed by intel_free_irq_resources(), hence memory leaking. Does
this patch aim to fix this?

Best regards,
baolu

> set it to NULL to prevent double-free. However, if we add
> a check (i == 0) here, we will not need to set it to NULL.
> If this is better, I will resend a new patch soon.
> 
> Regards,
> Dinghao
> 
