Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8114D223377
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 08:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgGQGN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 02:13:57 -0400
Received: from out28-75.mail.aliyun.com ([115.124.28.75]:35910 "EHLO
        out28-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgGQGN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:13:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07956585|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.26011-0.00462829-0.735262;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I37bnt8_1594966428;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I37bnt8_1594966428)
          by smtp.aliyun-inc.com(10.147.44.129);
          Fri, 17 Jul 2020 14:13:49 +0800
Subject: Re: [PATCH v6 2/2] clocksource: Ingenic: Add support for the Ingenic
 X1000 OST.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, tglx@linutronix.de,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200710170259.29028-1-zhouyanjie@wanyeetech.com>
 <20200710170259.29028-3-zhouyanjie@wanyeetech.com>
 <dd01a117-265a-e64b-5871-22f0f752834a@linaro.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <f0dd2ea5-0627-35cf-5a58-aaff0bcb22cd@wanyeetech.com>
Date:   Fri, 17 Jul 2020 14:13:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <dd01a117-265a-e64b-5871-22f0f752834a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

在 2020/7/17 下午12:20, Daniel Lezcano 写道:
> On 10/07/2020 19:02, 周琰杰 (Zhou Yanjie) wrote:
>> X1000 and SoCs after X1000 (such as X1500 and X1830) had a separate
>> OST, it no longer belongs to TCU. This driver will register both a
>> clocksource and a sched_clock to the system.
>>
>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>> Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>> ---
>>
>> Notes:
>>      v1->v2:
>>      Fix compile warnings.
>>      Reported-by: kernel test robot <lkp@intel.com>
>>      
>>      v2->v3:
>>      No change.
>>      
>>      v3->v4:
>>      1.Rename "ost" to "sysost"
>>      1.Remove unrelated changes.
>>      2.Remove ost_clock_parent enum.
>>      3.Remove ost->percpu_timer_channel/ost->global_timer_channel.
>>      4.Set up independent .recalc_rate/.set_rate for percpu/global timer.
>>      5.No longer call functions in variable declarations.
>>      
>>      v4->v5:
>>      Use "of_io_request_and_map()" instead "of_iomap()".
>>      Suggested-by: Paul Cercueil <paul@crapouillou.net>
>>      
>>      v5->v6:
>>      No change.
>>
>>   drivers/clocksource/Kconfig          |  11 +
>>   drivers/clocksource/Makefile         |   1 +
>>   drivers/clocksource/ingenic-sysost.c | 539 +++++++++++++++++++++++++++++++++++
>>   3 files changed, 551 insertions(+)
>>   create mode 100644 drivers/clocksource/ingenic-sysost.c
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 91418381fcd4..1bca8b8fb30f 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -696,6 +696,17 @@ config INGENIC_TIMER
>>   	help
>>   	  Support for the timer/counter unit of the Ingenic JZ SoCs.
>>   
>> +config INGENIC_SYSOST
>> +	bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
> We usually use silent options and let the platform's Kconfig enable it.
> We show up the option only when COMPILE_TEST is enabled.
>
> Is there a reason to do it differently?


Do you mean

bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"

or

default MACH_INGENIC ?

This driver has some origins from "INGENIC_TIMER" driver and "INGENIC_OST" driver.
Early Ingenic processors used TCU (timer/counter unit, has 6 or 8 generic timer channels) to provide clocksource and clockevent (both with only 16bit precision). This part of the processor can only use "INGENIC_TIMER" driver.

Later processors provide an independent 32bit or 64bit timer channel (still under TCU, known as ost channel, this channel can not generate interrupt) to provid higher precision clocksource. The "INGENIC_OST" driver is for this channel. These processors can use "INGENIC_TIMER" driver, but using "INGENIC_OST" driver to provide higher precision clocksource would be a better choice (clockevent still needs to be provided by generic timer channel of TCU, and still 16bit precision).

And the recent processors provide a SYSOST components, it is independent from TCU, including a 64bit timer channel for clocksource and a 32bit timer channel for clockevent. Although these processors can also use "INGENIC_TIMER" driver, but the better choice is completely independent use of "INGENIC_SYSOST" driver to provide higher precision clocksource and clockevent.

You may have already noticed that this independent SYSOST component is like an upgraded and streamlined TCU, which only retains one generic timer channel that can generate interrupts, upgrade it from 16bit to 32bit, and then retain the 64bit ost channel. so the driver code and Kconfig code of this patch is largely referenced
"INGENIC_TIMER" driver and "INGENIC_OST" driver.

Thanks and best regards!

>> +	default MACH_INGENIC
>> +	depends on MIPS || COMPILE_TEST
>> +	depends on COMMON_CLK
>> +	select MFD_SYSCON
>> +	select TIMER_OF
>> +	select IRQ_DOMAIN
>> +	help
>> +	  Support for the SYSOST of the Ingenic X Series SoCs.
>> +
> [ ... ]
>
>
