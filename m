Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723C9224CF8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 18:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgGRQSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 12:18:34 -0400
Received: from out28-146.mail.aliyun.com ([115.124.28.146]:40649 "EHLO
        out28-146.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgGRQSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 12:18:34 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436284|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.267473-0.0231451-0.709382;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I3xh4B._1595089102;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I3xh4B._1595089102)
          by smtp.aliyun-inc.com(10.147.42.135);
          Sun, 19 Jul 2020 00:18:23 +0800
Subject: Re: [PATCH v6 2/2] clocksource: Ingenic: Add support for the Ingenic
 X1000 OST.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200710170259.29028-1-zhouyanjie@wanyeetech.com>
 <20200710170259.29028-3-zhouyanjie@wanyeetech.com>
 <dd01a117-265a-e64b-5871-22f0f752834a@linaro.org>
 <f0dd2ea5-0627-35cf-5a58-aaff0bcb22cd@wanyeetech.com>
 <9c64bc35-c043-6e4b-cfc3-50f19e4cb315@linaro.org>
 <512ODQ.64YN0BEY1JJG@crapouillou.net>
 <096c8788-3c50-3eae-1c8e-c0c7487b00af@wanyeetech.com>
 <S29ODQ.X11A9NSVRIIJ@crapouillou.net>
 <36aec769-da25-20dd-2ca4-351f7c5369fb@wanyeetech.com>
 <MAAODQ.8WWI41VIHCH92@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <7fc3c80a-da57-6398-ed21-aff3f9ede041@wanyeetech.com>
Date:   Sun, 19 Jul 2020 00:18:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <MAAODQ.8WWI41VIHCH92@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/7/19 上午12:11, Paul Cercueil 写道:
>
>
> Le sam. 18 juil. 2020 à 23:55, Zhou Yanjie <zhouyanjie@wanyeetech.com> 
> a écrit :
>> Hi Paul,
>>
>> 在 2020/7/18 下午11:44, Paul Cercueil 写道:
>>> Hi Zhou,
>>>
>>> Le sam. 18 juil. 2020 à 21:42, Zhou Yanjie 
>>> <zhouyanjie@wanyeetech.com> a écrit :
>>>> Hello Paul and Daniel,
>>>>
>>>> 在 2020/7/18 下午9:12, Paul Cercueil 写道:
>>>>> Hi Daniel,
>>>>>
>>>>> Le ven. 17 juil. 2020 à 10:02, Daniel Lezcano 
>>>>> <daniel.lezcano@linaro.org> a écrit :
>>>>>> On 17/07/2020 08:13, Zhou Yanjie wrote:
>>>>>>>  Hi Daniel,
>>>>>>>
>>>>>>>  在 2020/7/17 下午12:20, Daniel Lezcano 写道:
>>>>>>>>  On 10/07/2020 19:02, 周琰杰 (Zhou Yanjie) wrote:
>>>>>>>>>  X1000 and SoCs after X1000 (such as X1500 and X1830) had a 
>>>>>>>>> separate
>>>>>>>>>  OST, it no longer belongs to TCU. This driver will register 
>>>>>>>>> both a
>>>>>>>>>  clocksource and a sched_clock to the system.
>>>>>>>>>
>>>>>>>>>  Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>>>>>>>>>  Co-developed-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>>>>>>>>>  Signed-off-by: 漆鹏振 (Qi Pengzhen) <aric.pzqi@ingenic.com>
>>>>>>>>>  Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>>>>>>>>>  Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>>>>>>>>>  ---
>>>>>>>>>
>>>>>>>>>  Notes:
>>>>>>>>>       v1->v2:
>>>>>>>>>       Fix compile warnings.
>>>>>>>>>       Reported-by: kernel test robot <lkp@intel.com>
>>>>>>>>>            v2->v3:
>>>>>>>>>       No change.
>>>>>>>>>            v3->v4:
>>>>>>>>>       1.Rename "ost" to "sysost"
>>>>>>>>>       1.Remove unrelated changes.
>>>>>>>>>       2.Remove ost_clock_parent enum.
>>>>>>>>>       3.Remove 
>>>>>>>>> ost->percpu_timer_channel/ost->global_timer_channel.
>>>>>>>>>       4.Set up independent .recalc_rate/.set_rate for 
>>>>>>>>> percpu/global
>>>>>>>>>  timer.
>>>>>>>>>       5.No longer call functions in variable declarations.
>>>>>>>>>            v4->v5:
>>>>>>>>>       Use "of_io_request_and_map()" instead "of_iomap()".
>>>>>>>>>       Suggested-by: Paul Cercueil <paul@crapouillou.net>
>>>>>>>>>            v5->v6:
>>>>>>>>>       No change.
>>>>>>>>>
>>>>>>>>>    drivers/clocksource/Kconfig          |  11 +
>>>>>>>>>    drivers/clocksource/Makefile         |   1 +
>>>>>>>>>    drivers/clocksource/ingenic-sysost.c | 539
>>>>>>>>>  +++++++++++++++++++++++++++++++++++
>>>>>>>>>    3 files changed, 551 insertions(+)
>>>>>>>>>    create mode 100644 drivers/clocksource/ingenic-sysost.c
>>>>>>>>>
>>>>>>>>>  diff --git a/drivers/clocksource/Kconfig 
>>>>>>>>> b/drivers/clocksource/Kconfig
>>>>>>>>>  index 91418381fcd4..1bca8b8fb30f 100644
>>>>>>>>>  --- a/drivers/clocksource/Kconfig
>>>>>>>>>  +++ b/drivers/clocksource/Kconfig
>>>>>>>>>  @@ -696,6 +696,17 @@ config INGENIC_TIMER
>>>>>>>>>        help
>>>>>>>>>          Support for the timer/counter unit of the Ingenic JZ 
>>>>>>>>> SoCs.
>>>>>>>>>    +config INGENIC_SYSOST
>>>>>>>>>  +    bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
>>>>>>>>  We usually use silent options and let the platform's Kconfig 
>>>>>>>> enable it.
>>>>>>>>  We show up the option only when COMPILE_TEST is enabled.
>>>>>>>>
>>>>>>>>  Is there a reason to do it differently?
>>>>>>>
>>>>>>>
>>>>>>>  Do you mean
>>>>>>>
>>>>>>>  bool "Clocksource/timer using the SYSOST in Ingenic X SoCs"
>>>>>>>
>>>>>>>  or
>>>>>>>
>>>>>>>  default MACH_INGENIC ?
>>>>>>
>>>>>> Both, no default here.
>>>>>>
>>>>>> eg.
>>>>>>
>>>>>> bool "Clocksource/timer using the SYSOST in Ingenic X SoCs" if 
>>>>>> COMPILE_TEST
>>>>>>
>>>>>> and
>>>>>>
>>>>>> in arch/mips/Kconfig in the config MACH_INGENIC section :
>>>>>>
>>>>>> ...
>>>>>> select INGENIC_SYSOST
>>>>>> ...
>>>>>
>>>>> Disagreed. That's not how we do things on MIPS. Selecting 
>>>>> MACH_INGENIC means "this kernel will support Ingenic SoCs", 
>>>>> but not that it will only support these. Hence the depends on 
>>>>> MIPS / default MACH_INGENIC.
>>>>>
>>>>> As for the select INGENIC_SYSOST, this driver only applies to a 
>>>>> few SoCs, I certainly don't want it to be force-enabled. I 
>>>>> don't even wait it to be force-enabled on X1000, since it is 
>>>>> optional there too.
>>>>>
>>>>> Cheers,
>>>>> -Paul
>>>>
>>>>
>>>> If we still need to keep the "default MACH_INGENIC", then Daniel 
>>>> can directly apply the v6 version.
>>>>
>>>> If we need to use the silent options, maybe we can enable them 
>>>> separately according to 
>>>> MACH_JZ4740/MACH_JZ4770/MACH_JZ4780/MACH_X1000/MACH_X1830.
>>>>
>>>> In fact, I think X1000 and X1830 need to enable this driver in most 
>>>> cases, because the current test has found that use TCU to provide 
>>>> clocksource and clockevent will cause data loss/error when 
>>>> transmitting data through spi or ethernet. And these errors no 
>>>> longer appear after using OST.
>>>
>>> This is likely because the clock is too fast, try to reduce it by a 
>>> factor 2 or 4, it should behave better.
>>>
>>
>> Yes, it is indeed because the clock is too fast, especially the TCU 
>> only has 16-bit, which makes this problem more serious. I even 
>> reduced the timing clock to the lowest possible 23kHz (divided by 
>> 1024). The problem has been alleviated, but it cannot completely 
>> solved, and finally there is no problem after opening the OST.
>>
>>
>>> If it turns out OST is really needed, then it should be selected 
>>> from MACH_X1000/X1830, not MACH_INGENIC.
>>>
>>
>> Sure, I will do it in v8.
>>
>> Thanks and best regards!
>
> Please do it in a separate patch then (but in the same patchset).
>

Okay, I will remove "default MACH_INGENIC" first, and then enable OST later.


> Cheers,
> -Paul
>
>>
>>> Cheers,
>>> -Paul
>>>
>>>> Thanks and best regards!
>>>>
>>>>
>>>>>
>>>>>>
>>>>>>>  This driver has some origins from "INGENIC_TIMER" driver and
>>>>>>>  "INGENIC_OST" driver.
>>>>>>>  Early Ingenic processors used TCU (timer/counter unit, has 6 or 8
>>>>>>>  generic timer channels) to provide clocksource and clockevent 
>>>>>>> (both with
>>>>>>>  only 16bit precision). This part of the processor can only use
>>>>>>>  "INGENIC_TIMER" driver.
>>>>>>>
>>>>>>>  Later processors provide an independent 32bit or 64bit timer 
>>>>>>> channel
>>>>>>>  (still under TCU, known as ost channel, this channel can not 
>>>>>>> generate
>>>>>>>  interrupt) to provid higher precision clocksource. The 
>>>>>>> "INGENIC_OST"
>>>>>>>  driver is for this channel. These processors can use 
>>>>>>> "INGENIC_TIMER"
>>>>>>>  driver, but using "INGENIC_OST" driver to provide higher precision
>>>>>>>  clocksource would be a better choice (clockevent still needs to be
>>>>>>>  provided by generic timer channel of TCU, and still 16bit 
>>>>>>> precision).
>>>>>>>
>>>>>>>  And the recent processors provide a SYSOST components, it is 
>>>>>>> independent
>>>>>>>  from TCU, including a 64bit timer channel for clocksource and a 
>>>>>>> 32bit
>>>>>>>  timer channel for clockevent. Although these processors can 
>>>>>>> also use
>>>>>>>  "INGENIC_TIMER" driver, but the better choice is completely 
>>>>>>> independent
>>>>>>>  use of "INGENIC_SYSOST" driver to provide higher precision 
>>>>>>> clocksource
>>>>>>>  and clockevent.
>>>>>>
>>>>>> Ok, the rating should do the job then.
>>>>>>
>>>>>> Thanks for the explanation.
>>>>>>
>>>>>>>  You may have already noticed that this independent SYSOST 
>>>>>>> component is
>>>>>>>  like an upgraded and streamlined TCU, which only retains one 
>>>>>>> generic
>>>>>>>  timer channel that can generate interrupts, upgrade it from 
>>>>>>> 16bit to
>>>>>>>  32bit, and then retain the 64bit ost channel. so the driver 
>>>>>>> code and
>>>>>>>  Kconfig code of this patch is largely referenced
>>>>>>>  "INGENIC_TIMER" driver and "INGENIC_OST" driver.
>>>>>>>
>>>>>>>  Thanks and best regards!
>>>>>>>
>>>>>>>>>  +    default MACH_INGENIC
>>>>>>>>>  +    depends on MIPS || COMPILE_TEST
>>>>>>>>>  +    depends on COMMON_CLK
>>>>>>>>>  +    select MFD_SYSCON
>>>>>>>>>  +    select TIMER_OF
>>>>>>>>>  +    select IRQ_DOMAIN
>>>>>>>>>  +    help
>>>>>>>>>  +      Support for the SYSOST of the Ingenic X Series SoCs.
>>>>>>>>>  +
>>>>>>>>  [ ... ]
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>>
>>>>>> -- 
>>>>>> <http://www.linaro.org/> Linaro.org │ Open source software for 
>>>>>> ARM SoCs
>>>>>>
>>>>>> Follow Linaro: <http://www.facebook.com/pages/Linaro> Facebook |
>>>>>> <http://twitter.com/#!/linaroorg> Twitter |
>>>>>> <http://www.linaro.org/linaro-blog/> Blog
>>>>>
>>>
>
