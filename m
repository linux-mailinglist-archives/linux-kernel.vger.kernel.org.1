Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECDF287FCD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 03:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbgJIBK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 21:10:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgJIBK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 21:10:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0EDA1FD2288C3F2A90E;
        Fri,  9 Oct 2020 09:10:23 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 9 Oct 2020 09:10:18 +0800
Subject: Re: [PATCH -next] gnss: simplify the return expression of gnss_uevent
To:     Johan Hovold <johan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20200921131028.91837-1-miaoqinglang@huawei.com>
 <20201008144247.GJ26280@localhost>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <ff65fc05-b992-ed76-909d-37935287307a@huawei.com>
Date:   Fri, 9 Oct 2020 09:10:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20201008144247.GJ26280@localhost>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/10/8 22:42, Johan Hovold Ð´µÀ:
> On Mon, Sep 21, 2020 at 09:10:28PM +0800, Qinglang Miao wrote:
>> Simplify the return expression.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> 
> The current code was written with an explicit error path on purpose, and
> there's no need to change it.
> 
> Same applies to your other gnss ubx patch.
> 
Glad for knowing that and it sounds resonable to me.

Thanks.
>> ---
>>   drivers/gnss/core.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
>> index e6f94501c..e6b9ac9da 100644
>> --- a/drivers/gnss/core.c
>> +++ b/drivers/gnss/core.c
>> @@ -368,13 +368,8 @@ ATTRIBUTE_GROUPS(gnss);
>>   static int gnss_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   {
>>   	struct gnss_device *gdev = to_gnss_device(dev);
>> -	int ret;
>>   
>> -	ret = add_uevent_var(env, "GNSS_TYPE=%s", gnss_type_name(gdev));
>> -	if (ret)
>> -		return ret;
>> -
>> -	return 0;
>> +	return add_uevent_var(env, "GNSS_TYPE=%s", gnss_type_name(gdev));
>>   }
>>   
>>   static int __init gnss_module_init(void)
> 
> Johan
> .
> 
