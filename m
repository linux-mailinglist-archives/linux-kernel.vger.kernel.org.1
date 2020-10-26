Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C229F298F84
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781701AbgJZOiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:38:22 -0400
Received: from out28-99.mail.aliyun.com ([115.124.28.99]:51259 "EHLO
        out28-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781496AbgJZOgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:36:48 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07900329|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0156896-0.00103705-0.983273;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Iofu4nJ_1603723000;
Received: from 192.168.10.195(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Iofu4nJ_1603723000)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 26 Oct 2020 22:36:40 +0800
Subject: Re: [PATCH v2 1/1] dt-bindings: timer: Add new OST support for the
 upcoming new driver.
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20201016165602.55720-1-zhouyanjie@wanyeetech.com>
 <20201016165602.55720-2-zhouyanjie@wanyeetech.com>
 <20201026131324.GA7627@bogus>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <eb8fbfc2-cf64-7836-aca2-a513dd817943@wanyeetech.com>
Date:   Mon, 26 Oct 2020 22:36:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20201026131324.GA7627@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

在 2020/10/26 下午9:13, Rob Herring 写道:
> On Sat, Oct 17, 2020 at 12:56:02AM +0800, 周琰杰 (Zhou Yanjie) wrote:
>> The new OST has one global timer and two or four percpu timers, so there
>> will be three combinations in the upcoming new OST driver: the original
>> GLOBAL_TIMER + PERCPU_TIMER, the new GLOBAL_TIMER + PERCPU_TIMER0/1 and
>> GLOBAL_TIMER + PERCPU_TIMER0/1/2/3, For this, add the macro definition
>> about OST_CLK_PERCPU_TIMER0/1/2/3. And in order to ensure that all the
>> combinations work normally, the original ABI values of OST_CLK_PERCPU_TIMER
>> and OST_CLK_GLOBAL_TIMER need to be exchanged to ensure that in any
>> combinations, the clock can be registered (by calling clk_hw_register())
>> from index 0.
> You need to state why breaking the ABI is okay.


Sorry, I did not understand correctly before, I will add it to the 
commit message in the next version.


Thanks and best regards!


>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>
>> Notes:
>>      v1->v2:
>>      Rewrite the commit message so that each line is less than 80 characters.
>>
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
