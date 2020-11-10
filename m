Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 256232ACA59
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbgKJBXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:23:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7508 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:23:21 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CVVVP1Qcqzhhg1;
        Tue, 10 Nov 2020 09:23:09 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Nov 2020 09:23:14 +0800
Subject: Re: [PATCH] firmware: arm_scmi: fix missing destroy_workqueue() on
 error in scmi_notification_init
To:     Cristian Marussi <cristian.marussi@arm.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20201109091517.55895-1-miaoqinglang@huawei.com>
 <20201109175136.GB42652@e120937-lin>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <661de7b2-b910-0e4f-42a4-8a0238d99fc8@huawei.com>
Date:   Tue, 10 Nov 2020 09:23:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201109175136.GB42652@e120937-lin>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/10 1:51, Cristian Marussi Ð´µÀ:
> On Mon, Nov 09, 2020 at 05:15:17PM +0800, Qinglang Miao wrote:
>> Add the missing destroy_workqueue() before return from
>> scmi_notification_init in the error handling case when
>> fails to do devm_kcalloc().
>>
>> Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   drivers/firmware/arm_scmi/notify.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
>> index 2754f9d01636..3048e57d9731 100644
>> --- a/drivers/firmware/arm_scmi/notify.c
>> +++ b/drivers/firmware/arm_scmi/notify.c
>> @@ -1476,8 +1476,10 @@ int scmi_notification_init(struct scmi_handle *handle)
>>   
>>   	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
>>   						sizeof(char *), GFP_KERNEL);
>> -	if (!ni->registered_protocols)
>> +	if (!ni->registered_protocols) {
>> +		destroy_workqueue(ni->notify_wq);
>>   		goto err;
>> +	}
>>   
> 
> Good catch, looks good to me.
> 
> Even better you could move the above alloc_workqueue() block down here
> so that you can avoid all together the additional destroy_workqueue() on
> the above error path.
> 
> Thanks
> 
> Cristian
It sounds convincible to me Cristian, thanks for your advice ;D

I will send a v2 patch on this one in no time.
> 
> 
>>   	mutex_init(&ni->pending_mtx);
>>   	hash_init(ni->pending_events_handlers);
>> -- 
>> 2.23.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> .
> 
