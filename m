Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06FE2C9793
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 07:32:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgLAGcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 01:32:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8540 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgLAGcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 01:32:41 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ClXLW74sDzhl8L;
        Tue,  1 Dec 2020 14:31:31 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 1 Dec 2020 14:31:52 +0800
Subject: Re: [PATCH] s390: cio: fix two use-after-free bugs in device.c
To:     Cornelia Huck <cohuck@redhat.com>
CC:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20201120074849.31557-1-miaoqinglang@huawei.com>
 <20201120085526.257a5596.cohuck@redhat.com>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <a78e4d86-159e-ec3a-64eb-3a035a162a2c@huawei.com>
Date:   Tue, 1 Dec 2020 14:31:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201120085526.257a5596.cohuck@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/20 15:55, Cornelia Huck Ð´µÀ:
> On Fri, 20 Nov 2020 15:48:49 +0800
> Qinglang Miao <miaoqinglang@huawei.com> wrote:
> 
>> put_device calls release function which do kfree() inside.
>> So following use of sch&cdev would cause use-after-free bugs.
>>
>> Fix these by simply adjusting the position of put_device.
>>
>> Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
>> Fixes: 74bd0d859dc3 ("s390/cio: fix unlocked access of online member")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/s390/cio/device.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
>> index b29fe8d50..69492417b 100644
>> --- a/drivers/s390/cio/device.c
>> +++ b/drivers/s390/cio/device.c
>> @@ -1664,10 +1664,10 @@ void __init ccw_device_destroy_console(struct ccw_device *cdev)
>>   	struct io_subchannel_private *io_priv = to_io_private(sch);
>>   
>>   	set_io_private(sch, NULL);
>> -	put_device(&sch->dev);
>> -	put_device(&cdev->dev);
>>   	dma_free_coherent(&sch->dev, sizeof(*io_priv->dma_area),
>>   			  io_priv->dma_area, io_priv->dma_area_dma);
>> +	put_device(&sch->dev);
>> +	put_device(&cdev->dev);
> 
> That change looks reasonable.
> 
>>   	kfree(io_priv);
>>   }
>>   
>> @@ -1774,8 +1774,8 @@ static int ccw_device_remove(struct device *dev)
>>   				      ret, cdev->private->dev_id.ssid,
>>   				      cdev->private->dev_id.devno);
>>   		/* Give up reference obtained in ccw_device_set_online(). */
>> -		put_device(&cdev->dev);
>>   		spin_lock_irq(cdev->ccwlock);
>> +		put_device(&cdev->dev);
> 
> As the comment above states, the put_device() gives up the reference
> obtained in ccw_device_set_online(). There's at least one more
> reference remaining (held by the caller of the remove function). Moving
> the put_device() does not fix anything here.
Hi, Cornelia

Sorry for the delayed reply.

Your suggestion is reasonable, there is a mistake in this patch for I 
didn't notice that there would be at least one more reference remaining.

So I sent a new patch only to move put_device after dma_free_coherent. I 
put the link as below:
https://lore.kernel.org/lkml/20201201063150.82128-1-miaoqinglang@huawei.com/

Thanks!
> 
>>   	}
>>   	ccw_device_set_timeout(cdev, 0);
>>   	cdev->drv = NULL;
> 
> .
> 
