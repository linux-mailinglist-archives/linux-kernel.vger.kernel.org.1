Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF0F2EA323
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbhAECBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:01:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:30392 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbhAECBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:01:15 -0500
IronPort-SDR: Gd4MNNWaAg7AJhpcopRaRyUbKSXcHWdEFEoE1Htd1GFK1th66P9xLThTuS6J3pKFDfT8NpBkJ9
 mU2YjR5kzg+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156230692"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156230692"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 17:59:30 -0800
IronPort-SDR: Op2msTBlwNLPz07pYNPWll39t/VmwFkbbW+1+wSBDD7gaLf08oZ5Lk3wdkaNVHfXtXi5KZ0rDa
 vijOeRe91zSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="462143879"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Jan 2021 17:59:27 -0800
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
 <6e1ce9ac-ac17-2b16-84d3-a18c011768f2@linux.intel.com>
 <3b0b2129.17762.176c6e9114d.Coremail.dinghao.liu@zju.edu.cn>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <dda6e03a-147a-a482-4f31-f3dcb8aa47bd@linux.intel.com>
Date:   Tue, 5 Jan 2021 09:51:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3b0b2129.17762.176c6e9114d.Coremail.dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 2:22 PM, dinghao.liu@zju.edu.cn wrote:
>> On 2021/1/3 12:08, dinghao.liu@zju.edu.cn wrote:
>>>> Hi,
>>>>
>>>> On 2021/1/2 17:50, Dinghao Liu wrote:
>>>>> When irq_domain_get_irq_data() or irqd_cfg() fails
>>>>> meanwhile i == 0, data allocated by kzalloc() has not
>>>>> been freed before returning, which leads to memleak.
>>>>>
>>>>> Fixes: b106ee63abccb ("irq_remapping/vt-d: Enhance Intel IR driver to support hierarchical irqdomains")
>>>>> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>>>>> ---
>>>>>     drivers/iommu/intel/irq_remapping.c | 2 ++
>>>>>     1 file changed, 2 insertions(+)
>>>>>
>>>>> diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
>>>>> index aeffda92b10b..cdaeed36750f 100644
>>>>> --- a/drivers/iommu/intel/irq_remapping.c
>>>>> +++ b/drivers/iommu/intel/irq_remapping.c
>>>>> @@ -1354,6 +1354,8 @@ static int intel_irq_remapping_alloc(struct irq_domain *domain,
>>>>>     		irq_cfg = irqd_cfg(irq_data);
>>>>>     		if (!irq_data || !irq_cfg) {
>>>>>     			ret = -EINVAL;
>>>>> +			kfree(data);
>>>>> +			data = NULL;
>>>>
>>>> Do you need to check (i == 0) here? @data will not be used anymore as it
>>>> goes to out branch, why setting it to NULL here?
>>>>
>>>
>>> data will be passed to ire_data->chip_data when i == 0 and
>>> intel_free_irq_resources() will free it on failure. Thus I
>>
>> Isn't it going to "goto out_free_data"? If "i == 0", the allocated @data
>> won't be freed by intel_free_irq_resources(), hence memory leaking. Does
>> this patch aim to fix this?
>>
>> Best regards,
>> baolu
>>
> 
> Correct, this is what I mean. When i > 0, data has been passed to
> irq_data->chip_data, which will be freed in intel_free_irq_resources()
> on failure. So there is no memleak in this case. The memleak only occurs
> on failure when i == 0 (data has not been passed to irq_data->chip_data).

So how about

diff --git a/drivers/iommu/intel/irq_remapping.c 
b/drivers/iommu/intel/irq_remapping.c
index aeffda92b10b..685200a5cff0 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1353,6 +1353,8 @@ static int intel_irq_remapping_alloc(struct 
irq_domain *domain,
                 irq_data = irq_domain_get_irq_data(domain, virq + i);
                 irq_cfg = irqd_cfg(irq_data);
                 if (!irq_data || !irq_cfg) {
+                       if (!i)
+                               kfree(data);
                         ret = -EINVAL;
                         goto out_free_data;
                 }

> I set data to NULL after kfree() in this patch to prevent double-free
> when the failure occurs at i > 0.

if i>0, @data has been passed and will be freed by
intel_free_irq_resources() on the failure path. No need to free or
clear, right?

Best regards,
baolu

> 
> Regards,
> Dinghao
> 
>>> set it to NULL to prevent double-free. However, if we add
>>> a check (i == 0) here, we will not need to set it to NULL.
>>> If this is better, I will resend a new patch soon.
>>>
>>> Regards,
>>> Dinghao
>>>
