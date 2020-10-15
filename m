Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3863628EA85
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732464AbgJOByv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:54:51 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727440AbgJOByh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:37 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B9DADF54352C2B7ADA1;
        Thu, 15 Oct 2020 09:54:33 +0800 (CST)
Received: from [10.174.178.67] (10.174.178.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 15 Oct
 2020 09:54:30 +0800
Subject: Re: [PATCH v2] thunderbolt: Add the missed ida_simple_remove() in
 ring_request_msix()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20201014014604.167968-1-jingxiangfeng@huawei.com>
 <20201014084821.GR4077@smile.fi.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <mika.westerberg@linux.intel.com>, <YehezkelShB@gmail.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F87ABD6.4090508@huawei.com>
Date:   Thu, 15 Oct 2020 09:54:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20201014084821.GR4077@smile.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/14 16:48, Andy Shevchenko wrote:
> On Wed, Oct 14, 2020 at 09:46:04AM +0800, Jing Xiangfeng wrote:
>> ring_request_msix() misses to call ida_simple_remove() in an error path.
>> Add a label 'err_ida_remove' and jump to it.
> ...
>
>> @@ -406,11 +406,22 @@ static int ring_request_msix(struct tb_ring *ring, bool no_suspend)
>>   	ring->vector = ret;
> ^^^
>
>>   	ring->irq = pci_irq_vector(ring->nhi->pdev, ring->vector);
>> -	if (ring->irq < 0)
>> -		return ring->irq;
>> +	if (ring->irq < 0) {
>> +		ret = ring->irq;
>> +		goto err_ida_remove;
>> +	}
> What about
> 	ret = pci_irq_vector(ring->nhi->pdev, ring->vector);
> 	if (ret < 0)
> 		goto err_ida_remove;
>
> 	ring->irq = ret;
>
> ?
Yeah, I agree. Thanks for your suggestions.

>
> (See also context above)
>
>>   	irqflags = no_suspend ? IRQF_NO_SUSPEND : 0;
>> -	return request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);
>> +	ret = request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);
>> +	if (ret)
>> +		goto err_ida_remove;
>> +
>> +	return 0;
>> +
>> +err_ida_remove:
>> +	ida_simple_remove(&nhi->msix_ida, ring->vector);
>> +
>> +	return ret;
>>   }
>>   
>>   static void ring_release_msix(struct tb_ring *ring)
>> -- 
>> 2.17.1
>>

