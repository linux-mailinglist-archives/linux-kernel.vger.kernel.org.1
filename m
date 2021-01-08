Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD12EF514
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbhAHPpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:45:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2300 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbhAHPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:45:43 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DC6mL28x2z67YVq;
        Fri,  8 Jan 2021 23:42:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 8 Jan 2021 16:45:01 +0100
Received: from [10.47.0.72] (10.47.0.72) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Fri, 8 Jan 2021
 15:45:00 +0000
Subject: Re: [PATCH] Driver core: platform: Add extra error check in
 devm_platform_get_irqs_affinity()
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rafael@kernel.org>, <maz@kernel.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <dan.carpenter@oracle.com>
References: <1608561055-231244-1-git-send-email-john.garry@huawei.com>
 <X/h9vy/1h0E1hyN0@kroah.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e10af177-583b-636a-be14-6f781baaa61a@huawei.com>
Date:   Fri, 8 Jan 2021 15:43:56 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <X/h9vy/1h0E1hyN0@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.0.72]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/2021 15:43, Greg KH wrote:
> On Mon, Dec 21, 2020 at 10:30:55PM +0800, John Garry wrote:
>> The current check of nvec < minvec for nvec returned from
>> platform_irq_count() will not detect a negative error code in nvec.
>>
>> This is because minvec is unsigned, and, as such, nvec is promoted to
>> unsigned in that check, which will make it a huge number (if it contained
>> -EPROBE_DEFER).
>>
>> In practice, an error should not occur in nvec for the only in-tree
>> user, but add a check anyway.
>>
>> Fixes: e15f2fa959f2 ("driver core: platform: Add devm_platform_get_irqs_affinity()")
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> I hope that this can go through either irqchip or driver/core trees, thanks!
> 
> I'll take it, thanks.
> 

Hi Greg,

I think that Marc already has taken it:

https://lore.kernel.org/lkml/X%2Fh9vy%2F1h0E1hyN0@kroah.com/T/#m95ef1736dbbd801cd85a4144c8f13c2afe33bc2c

I hope it doesn't cause hassle.

Thanks,
John

