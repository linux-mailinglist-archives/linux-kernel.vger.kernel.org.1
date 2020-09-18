Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7326F95F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIRJe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:34:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13299 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgIRJe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:34:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62A12F0BF20DA5957E2B;
        Fri, 18 Sep 2020 17:34:26 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 18 Sep 2020
 17:34:19 +0800
Subject: Re: [PATCH v2 7/9] clocksource: sp804: add support for Hisilicon
 sp804 timer
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
References: <20200912114536.2910-1-thunder.leizhen@huawei.com>
 <20200912114536.2910-8-thunder.leizhen@huawei.com>
 <5efc0de3-754b-2b48-7769-d9ac7f5e21b0@linaro.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <9fc18476-48a7-27d4-c1c7-cd6566696f3a@huawei.com>
Date:   Fri, 18 Sep 2020 17:34:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5efc0de3-754b-2b48-7769-d9ac7f5e21b0@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/18 16:53, Daniel Lezcano wrote:
> On 12/09/2020 13:45, Zhen Lei wrote:
>> The ARM SP804 supports a maximum of 32-bit counter, but Hisilicon extends
>> it to 64-bit. That means, the registers: TimerXload, TimerXValue and
>> TimerXBGLoad are 64bits, all other registers are the same as those in the
>> SP804. The driver code can be completely reused except that the register
>> offset is different.
>>
>> Use compatible = "hisilicon,sp804" mark as Hisilicon sp804 timer.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/clocksource/timer-sp.h    | 12 ++++++++++++
>>  drivers/clocksource/timer-sp804.c | 15 +++++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
>> index 1ab75cbed0e0..6ca8d82e8544 100644
>> --- a/drivers/clocksource/timer-sp.h
>> +++ b/drivers/clocksource/timer-sp.h
>> @@ -31,6 +31,18 @@
>>  #define TIMER_MIS	0x14			/*  CVR ro */
>>  #define TIMER_BGLOAD	0x18			/*  CVR rw */
>>  
>> +
>> +#define HISI_TIMER_1_BASE	0x00
>> +#define HISI_TIMER_2_BASE	0x40
>> +#define HISI_TIMER_LOAD		0x00
>> +#define HISI_TIMER_VALUE	0x08
>> +#define HISI_TIMER_CTRL		0x10
>> +#define HISI_TIMER_INTCLR	0x14
>> +#define HISI_TIMER_RIS		0x18
>> +#define HISI_TIMER_MIS		0x1c
>> +#define HISI_TIMER_BGLOAD	0x20
> 
> Why not put them in timer-sp804.c directly ?

I just want to put them together with TIMER_xxx, but ignore that HISI_TIMER_xxx
is used only in file timer-sp804.c

OK, I will move them into timer-sp804.c

> 
> [ ... ]
> 

