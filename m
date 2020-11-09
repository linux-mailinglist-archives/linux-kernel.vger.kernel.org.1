Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9FB2AAFB8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 04:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgKIDFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 22:05:42 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2302 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIDFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 22:05:41 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CTwps2BZzz13PKq;
        Mon,  9 Nov 2020 11:05:25 +0800 (CST)
Received: from [10.174.177.103] (10.174.177.103) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 9 Nov 2020 11:05:38 +0800
Subject: Re: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS
 executes the residual commands in the queue again when the ITS wakes up from
 sleep mode.
To:     Marc Zyngier <maz@kernel.org>
CC:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
        <rui.xiang@huawei.com>
References: <20201107104226.14282-1-xuqiang36@huawei.com>
 <b278ce4baea0cf79403f793721d16a8b@kernel.org>
From:   "xuqiang (M)" <xuqiang36@huawei.com>
Message-ID: <32592d73-9800-f420-eb00-474d9ded6155@huawei.com>
Date:   Mon, 9 Nov 2020 11:05:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b278ce4baea0cf79403f793721d16a8b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.103]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/11/8 0:54, Marc Zyngier 写道:
> [dropping Jason, whose email address has been bouncing for weeks now]
>
> On 2020-11-07 10:42, Xu Qiang wrote:
>> On my platform, ITS_FLAGS_SAVE_SUSPEND_STATE is not set,thus do nothing
>
> Which platform?
Hisi Ascend platform
>
>> in its suspend and resuse function.On the other hand,firmware stores
>> GITS_CTRL,GITS_CBASER,GITS_CWRITER and GITS_BASER<n> in the suspend,
>> and restores these registers in the resume. As a result, the ITS 
>> executes
>> the residual commands in the queue.
>
> Which firmware are you using? I just had a look at the trusted 
> firmware source
> code, and while it definitely does something that *looks* like what 
> you are
> describing, it doesn't re-enable the ITS on resume.
>
> So what are you running?

I am using ATF. Since ITS_FLAGS_SAVE_SUSPEND_STATE is not set,ITS driver 
of OS will

not re-enable ITS in th resume. To make ITS work properly, we changed 
the ATF code

to re-enable ITS on resume.

>
>>
>> Memory corruption may occur in the following scenarios:
>>
>> The kernel sends three commands in the following sequence:
>> 1.mapd(deviceA, ITT_addr1, valid:1)
>> 2.mapti(deviceA):ITS write ITT_addr1 memory;
>> 3.mapd(deviceA, ITT_addr1, valid:0) and kfree(ITT_addr1);
>
> The ITS doesn't 'kfree' stuff.
ITS driver kfree ITT_addr1.
>
>> 4.mapd(deviceA, ITT_addr2, valid:1);
>> 5.mapti(deviceA):ITS write ITT_addr2 memory;
>
> I don't think this example is relevant. The core of the problem is that
> the ITS gets re-enabled by your firmware. What are the affected systems?
>
>>
>> To solve this problem,dropping the checks for 
>> ITS_FLAGS_SAVE_SUSPEND_STATE.
>>
>> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 0fec31931e11..06f2c1c252b9 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -42,7 +42,6 @@
>>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING        (1ULL << 0)
>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375    (1ULL << 1)
>>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144    (1ULL << 2)
>> -#define ITS_FLAGS_SAVE_SUSPEND_STATE        (1ULL << 3)
>>
>>  #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
>>  #define RDIST_FLAGS_RD_TABLES_PREALLOCATED    (1 << 1)
>> @@ -4741,9 +4740,6 @@ static int its_save_disable(void)
>>      list_for_each_entry(its, &its_nodes, entry) {
>>          void __iomem *base;
>>
>> -        if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
>> -            continue;
>> -
>>          base = its->base;
>>          its->ctlr_save = readl_relaxed(base + GITS_CTLR);
>>          err = its_force_quiescent(base);
>> @@ -4762,9 +4758,6 @@ static int its_save_disable(void)
>>          list_for_each_entry_continue_reverse(its, &its_nodes, entry) {
>>              void __iomem *base;
>>
>> -            if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
>> -                continue;
>> -
>>              base = its->base;
>>              writel_relaxed(its->ctlr_save, base + GITS_CTLR);
>>          }
>> @@ -4784,9 +4777,6 @@ static void its_restore_enable(void)
>>          void __iomem *base;
>>          int i;
>>
>> -        if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
>> -            continue;
>> -
>>          base = its->base;
>>
>>          /*
>> @@ -5074,9 +5064,6 @@ static int __init its_probe_one(struct resource 
>> *res,
>>          ctlr |= GITS_CTLR_ImDe;
>>      writel_relaxed(ctlr, its->base + GITS_CTLR);
>>
>> -    if (GITS_TYPER_HCC(typer))
>> -        its->flags |= ITS_FLAGS_SAVE_SUSPEND_STATE;
>> -
>>      err = its_init_domain(handle, its);
>>      if (err)
>>          goto out_free_tables;
>
> I'm OK with the patch itself, but I don't want to paper over broken 
> firmware.
> I'll get TF-A fixed one way or another, but I want to be sure yours is 
> too.
> If firmware does its job correctly, we shouldn't have to do all of this.
>
>         M.

Thanks

         Xu.

