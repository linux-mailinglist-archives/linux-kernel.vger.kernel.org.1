Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7C1A327C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 12:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgDIKao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 06:30:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgDIKao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:30:44 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0DB98905BA12401A2919;
        Thu,  9 Apr 2020 18:30:41 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 18:30:34 +0800
Subject: Re: [PATCH] irqchip/mbigen: Free msi_desc on device teardown
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wuyun.wu@huawei.com>,
        <wanghaibin.wang@huawei.com>
References: <20200408114352.1604-1-yuzenghui@huawei.com>
 <20200409102718.73875cd9@why>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <c308446a-557f-8fe1-520e-45558dd3aac5@huawei.com>
Date:   Thu, 9 Apr 2020 18:30:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200409102718.73875cd9@why>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/4/9 17:27, Marc Zyngier wrote:
> On Wed, 8 Apr 2020 19:43:52 +0800
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
> Hi Zenghui,
> 
>> Using irq_domain_free_irqs_common() on the irqdomain free path will
>> leave the MSI descriptor unfreed when platform devices get removed.
>> Properly free it by MSI domain free function.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   drivers/irqchip/irq-mbigen.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
>> index 6b566bba263b..ff7627b57772 100644
>> --- a/drivers/irqchip/irq-mbigen.c
>> +++ b/drivers/irqchip/irq-mbigen.c
>> @@ -220,10 +220,16 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
>>   	return 0;
>>   }
>>   
>> +static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>> +				   unsigned int nr_irqs)
>> +{
>> +	platform_msi_domain_free(domain, virq, nr_irqs);
>> +}
>> +
>>   static const struct irq_domain_ops mbigen_domain_ops = {
>>   	.translate	= mbigen_domain_translate,
>>   	.alloc		= mbigen_irq_domain_alloc,
>> -	.free		= irq_domain_free_irqs_common,
>> +	.free		= mbigen_irq_domain_free,
>>   };
>>   
>>   static int mbigen_of_create_domain(struct platform_device *pdev,
> 
> Should this deserve a:
> 
> Fixes: 9650c60ebfec0 ("irqchip/mbigen: Create irq domain for each
> mbigen device")

Yes, please help to add it.

> 
> Otherwise queued for post -rc1.

Thanks!


Zenghui

