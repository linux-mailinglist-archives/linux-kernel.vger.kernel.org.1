Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC228E45A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbgJNQ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:26:03 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:56616 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgJNQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:26:03 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07824846|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0156896-0.00103705-0.983273;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.IjFtjag_1602692759;
Received: from 192.168.10.195(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.IjFtjag_1602692759)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 15 Oct 2020 00:26:00 +0800
Subject: Re: [PATCH 1/1] dt-bindings: clock: Add new OST support for the
 upcoming new driver.
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sernia.zhou@foxmail.com
References: <20201007181407.46889-1-zhouyanjie@wanyeetech.com>
 <20201007181407.46889-2-zhouyanjie@wanyeetech.com>
 <20201013132953.GA3367990@bogus>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <a16d9fc7-07f7-6a56-c0e4-5d39b34577a9@wanyeetech.com>
Date:   Thu, 15 Oct 2020 00:25:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20201013132953.GA3367990@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

在 2020/10/13 下午9:29, Rob Herring 写道:
> On Thu, Oct 08, 2020 at 02:14:07AM +0800, 周琰杰 (Zhou Yanjie) wrote:
>> The new OST has one global timer and two or four percpu timers, so there will be three
>> combinations in the upcoming new OST driver: the original GLOBAL_TIMER + PERCPU_TIMER,
>> the new GLOBAL_TIMER + PERCPU_TIMER0/1 and GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this,
>> add the macro definition about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that
>> all the combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER and
>> OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any combinations, the clock
>> can be registered (by calling clk_hw_register()) from index 0.
> Wrap lines at <80 characters.


Sorry, I will fix it in the next version.


>
>> I'm sure that exchanging the ABI values of OST_CLK_PERCPU_TIMER and OST_CLK_GLOBAL_TIMER
>> will not affect the existing related drivers and the SoCs whitch using these drivers, so
>> we should be able to exchange them safely.
> Why exactly is this okay?


These definitions are currently only used in two places, one is when 
using "assigned-clocks" to configure the clock in the DTS file; the 
other is when registering the clock in the sysost driver. When 
exchanging the values of "OST_CLK_PERCPU_TIMER" and 
"OST_CLK_GLOBAL_TIMER", the corresponding values will be changed 
synchronously when the clock is driven to register and when the clock is 
configured through "assigned-clocks". Therefore, there is no situation 
that causes the wrong clock to the configured. And it has been tested on 
X1000 and X1000 and X1830 SoCs, all working fine.

I'm sorry because I didn't think carefully when writing this header 
file, and caused the current trouble.


Thanks and best regards!


>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>   include/dt-bindings/clock/ingenic,sysost.h | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
>> index 9ac88e90babf..063791b01ab3 100644
>> --- a/include/dt-bindings/clock/ingenic,sysost.h
>> +++ b/include/dt-bindings/clock/ingenic,sysost.h
>> @@ -1,12 +1,16 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   /*
>> - * This header provides clock numbers for the ingenic,tcu DT binding.
>> + * This header provides clock numbers for the Ingenic OST DT binding.
>>    */
>>   
>>   #ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>>   #define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>>   
>> -#define OST_CLK_PERCPU_TIMER	0
>> -#define OST_CLK_GLOBAL_TIMER	1
>> +#define OST_CLK_PERCPU_TIMER	1
>> +#define OST_CLK_GLOBAL_TIMER	0
>> +#define OST_CLK_PERCPU_TIMER0	1
>> +#define OST_CLK_PERCPU_TIMER1	2
>> +#define OST_CLK_PERCPU_TIMER2	3
>> +#define OST_CLK_PERCPU_TIMER3	4
>>   
>>   #endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
>> -- 
>> 2.11.0
>>
