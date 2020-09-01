Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10996258AA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 10:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIAIsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 04:48:11 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3081 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbgIAIsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:48:11 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 07087318D0CCF9839338;
        Tue,  1 Sep 2020 16:48:09 +0800 (CST)
Received: from [10.140.157.78] (10.140.157.78) by
 dggeme755-chm.china.huawei.com (10.3.19.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Sep 2020 16:48:08 +0800
Subject: Re: Adjust interrupt Priority for ARM64 GIC
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
References: <5a6e65cf-d2fe-0107-2318-0e3c81d57000@huawei.com>
 <51146530616bb8fdf23c637ff5bee44e@kernel.org>
From:   Dongjiu Geng <gengdongjiu@huawei.com>
Message-ID: <003822ee-c43b-9572-7a64-fda049ecb05f@huawei.com>
Date:   Tue, 1 Sep 2020 16:48:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <51146530616bb8fdf23c637ff5bee44e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.140.157.78]
X-ClientProxiedBy: dggeme712-chm.china.huawei.com (10.1.199.108) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/1 15:48, Marc Zyngier wrote:
> Hi Dongjiu,
> 
> In the future, please use my kernel.org address, as I don't work
> for ARM anymore, and would have missed this email if I wasn't pointed
> to it.
> 
> On 2020-08-14 18:10, Dongjiu Geng wrote:
>> Hi Marc,
>>    In the Linux kernel, we can not adjust the  interrupt Priority, For
>> all the interrupts, the interrupt Priority are fixed to 0xa0.
>> In some scenarios, it needs to change the Priority. so I want to
>> upstream a serie patch to support to change the Priority through
>> procfs. do you agree I upstream this feature? thanks~
> 
> No, that's not something I would ever consider, and for multiple
> reasons:
> 
> - Linux only supports a single priority, meaning that interrupts are
>   themselves aren't preemptable. Dealing with things like (pseudo) NMI
>   is invasive enough, and I can't see a good reason to relax the
>   single priority requirement.
> 
> - Building on top of the above, the whole scheduler and locking model
>   relies on the non-preemptable property of an interrupt.
> 
> - I cannot see a good reason to leave the priority control to userspace.
>   That's a sure recipe for userspace-controlled livelocks.
> 
> Now, I'm sure you want to introduce this for a reason, and you are not
> explaining it ("some scenarios" doesn't quite cut it). If you care to
> explain these "scenarios", maybe there is something we can do.
Marc，
    Thanks for answer.
    In the real-time system(RTOS), we want the timer tick irq is responded as
soon as possible to trigger kernel do task schedule. Non-preemptable  IRQ decreases the Real-Time Performance of Real-Time Operating System

> 
> But please don't waste time implementing any sort of priority change,
> there is no way I'll consider it as such.
> 
> Thanks,
> 
>         M.
