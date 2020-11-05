Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803132A7D93
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgKELzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:55:05 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2300 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKELzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:55:05 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CRhld2Cfwz13Kkx;
        Thu,  5 Nov 2020 19:54:53 +0800 (CST)
Received: from [10.174.177.103] (10.174.177.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 5 Nov 2020 19:55:02 +0800
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS
 executes the residual commands in the queue again when the ITS wakes up from
 sleep mode.
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>, <rui.xiang@huawei.com>
References: <20201103081123.119969-1-xuqiang36@huawei.com>
 <87imamtiav.wl-maz@kernel.org>
From:   "xuqiang (M)" <xuqiang36@huawei.com>
Message-ID: <8395dfbb-a90e-6903-abe9-cd6f7c48f441@huawei.com>
Date:   Thu, 5 Nov 2020 19:54:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87imamtiav.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.103]
X-ClientProxiedBy: dggeme703-chm.china.huawei.com (10.1.199.99) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel sends three commands in the following sequence:

1.mapd(deviceA, ITT_addr1, valid:1)

2.mapti(deviceA):ITS write ITT_addr1 memory;

3.mapd(deviceA, ITT_addr1, valid:0) and kfree(ITT_addr1);

4.mapd(deviceA, ITT_addr2, valid:1);

5.mapti(deviceA):ITS write ITT_addr2 memory;

In this case, the processor enters the sleep mode. After the kernel 
performs the suspend operation, the firmware performs the store 
operation and saves GITS_CBASER and GITS_CWRITER registers.

Then, the processor is woken up, and the firmware restores GITS_CBASER 
and GITS_CWRITER registers. Because GITS_CWRITER register is not 0, ITS 
will read the above command sequence execution from the command queue, 
causing ITT_addr1 memory to be trampled.

Thanks,

                 Xu


在 2020/11/4 2:19, Marc Zyngier 写道:
> On Tue, 03 Nov 2020 08:11:23 +0000,
> Xu Qiang <xuqiang36@huawei.com> wrote:
>> During wakeup, the ATF restore interface restores the values of
>> the cbaser and cwriter registers. As a result, the ITS executes
>> the residual commands in the queue, which may cause memory corruption.
>>
>> To solve this problem, clear all data in the command queue
>> in the suspend interface of the ITS driver.
>>
>> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index 0fec31931e11..b8487f78ac21 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -4741,6 +4741,14 @@ static int its_save_disable(void)
>>   	list_for_each_entry(its, &its_nodes, entry) {
>>   		void __iomem *base;
>>   
>> +		/*
>> +		 * Clear the command queue so that the ITS will not re-execute
>> +		 * the remaining commands in the command queue when
>> +		 * the cwriter and cbaser registers are restored
>> +		 * in the restore interface of the firmware.
>> +		 */
>> +		memset(its->cmd_base, 0, ITS_CMD_QUEUE_SZ);
>> +
>>   		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
>>   			continue;
> You are wiping the ITS queue before even stopping the ITS. How well is
> that going to work? What if there is something in flight?
>
> I don't understand what you are trying to do here, nor how ATF is
> involved. So please describe the whole sequence of events, and we'll
> decide whether that's something we need to fix.
>
> Thanks,
>
> 	M.
>
