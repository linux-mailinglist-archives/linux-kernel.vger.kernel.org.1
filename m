Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F008528CE67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgJMMdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:33:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50414 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727395AbgJMMdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:33:35 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D7A01669E8BDD336A8F;
        Tue, 13 Oct 2020 20:33:31 +0800 (CST)
Received: from [10.174.178.67] (10.174.178.67) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 13 Oct
 2020 20:33:29 +0800
Subject: Re: [PATCH] thunderbolt: Add the missed ida_simple_remove() in
 ring_request_msix()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20201013024518.195557-1-jingxiangfeng@huawei.com>
 <20201013114325.GK4077@smile.fi.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <mika.westerberg@linux.intel.com>, <YehezkelShB@gmail.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F859E98.5080506@huawei.com>
Date:   Tue, 13 Oct 2020 20:33:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20201013114325.GK4077@smile.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/13 19:43, Andy Shevchenko wrote:
> On Tue, Oct 13, 2020 at 10:45:18AM +0800, Jing Xiangfeng wrote:
>> ring_request_msix() misses to call ida_simple_remove() in an error path.
>> Add the missed function call to fix it.
> ...
>
>>   	ring->irq = pci_irq_vector(ring->nhi->pdev, ring->vector);
>> -	if (ring->irq < 0)
>> +	if (ring->irq < 0) {
>> +		ida_simple_remove(&nhi->msix_ida, ret);
>>   		return ring->irq;
>> +	}
>>   
>>   	irqflags = no_suspend ? IRQF_NO_SUSPEND : 0;
>>   	return request_irq(ring->irq, ring_msix, irqflags, "thunderbolt", ring);
> According to your logic don't you need it here as well?
Hm indeed. Will fix too.

Thanks for your review.
>

