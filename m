Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F17D2C7EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 08:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgK3H30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 02:29:26 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8530 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgK3H3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 02:29:25 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CkxfW4GWzzhkS2;
        Mon, 30 Nov 2020 15:28:19 +0800 (CST)
Received: from [10.174.177.149] (10.174.177.149) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 30 Nov 2020 15:28:39 +0800
Subject: Re: [PATCH 2/3] powerpc/pseries/hotplug-cpu: fix memleak in
 dlpar_cpu_add_by_count
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20201128102001.95323-1-miaoqinglang@huawei.com>
 <871rgby5lb.fsf@mpe.ellerman.id.au>
From:   Qinglang Miao <miaoqinglang@huawei.com>
Message-ID: <b74f479e-e68b-d8e6-d11c-2611bd4e8a20@huawei.com>
Date:   Mon, 30 Nov 2020 15:28:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <871rgby5lb.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.149]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/11/30 9:51, Michael Ellerman Ð´µÀ:
> Qinglang Miao <miaoqinglang@huawei.com> writes:
>> kfree(cpu_drcs) should be called when it fails to perform
>> of_find_node_by_path("/cpus") in dlpar_cpu_add_by_count,
>> otherwise there would be a memleak.
>>
>> In fact, the patch a0ff72f9f5a7 ought to remove kfree in
>> find_dlpar_cpus_to_add rather than dlpar_cpu_add_by_count.
>> I guess there might be a mistake when apply that one.
>>
>> Fixes: a0ff72f9f5a7 ("powerpc/pseries/hotplug-cpu: Remove double free in error path")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   arch/powerpc/platforms/pseries/hotplug-cpu.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> This is already fixed in my next by:
> 
>    a40fdaf1420d ("Revert "powerpc/pseries/hotplug-cpu: Remove double free in error path"")
> 
> cheers'Revert' sounds resonable to this one, glad to know that.
> 
>> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> index f2837e33b..4bb1c9f2b 100644
>> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> @@ -743,6 +743,7 @@ static int dlpar_cpu_add_by_count(u32 cpus_to_add)
>>   	parent = of_find_node_by_path("/cpus");
>>   	if (!parent) {
>>   		pr_warn("Could not find CPU root node in device tree\n");
>> +		kfree(cpu_drcs);
>>   		return -1;
>>   	}
>>   
>> -- 
>> 2.23.0
> .
> 
