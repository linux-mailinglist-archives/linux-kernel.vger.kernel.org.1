Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F7E26FC93
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIRMdk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Sep 2020 08:33:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbgIRMdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:33:40 -0400
X-Greylist: delayed 924 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 08:33:40 EDT
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 9A48BA5AE5313591991A;
        Fri, 18 Sep 2020 20:18:14 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.78]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0487.000;
 Fri, 18 Sep 2020 20:18:04 +0800
From:   lushenming <lushenming@huawei.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        yuzenghui <yuzenghui@huawei.com>
Subject: RE: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll
 on the GICR_VPENDBASER.Dirty bit
Thread-Topic: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll
 on the GICR_VPENDBASER.Dirty bit
Thread-Index: AdaLYvuHeQKSQv5lQ9G9IAytgjmwLv//klKA//55OFCAArI6AP/8SMLg
Date:   Fri, 18 Sep 2020 12:18:03 +0000
Message-ID: <343E0E168479F04FACCB176989D12DE7EE333B@dggemi522-mbs.china.huawei.com>
References: <343E0E168479F04FACCB176989D12DE7EE1D2D@dggemi522-mbs.china.huawei.com>
 <a87d26bc52b25247dd23e5cb1cd56bad@kernel.org>
 <343E0E168479F04FACCB176989D12DE7EE3206@dggemi522-mbs.china.huawei.com>
 <8c9f4731295af025302e084ba546b74b@kernel.org>
In-Reply-To: <8c9f4731295af025302e084ba546b74b@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.187.99]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marc,

I measured the time from vcpu_load() (include it) to __guest_enter() on Kunpeng 920. On average, It takes 2.55 microseconds (not first run && the VPT is empty). So waiting for 10 microseconds in 
vcpu scheduling really hurts performance.

And I agree that delaying the execution of its_wait_vpt_parse_complete() might be a  viable solution.

-----Original Message-----
From: Marc Zyngier [mailto:maz@kernel.org] 
Sent: 2020-09-16 16:40
To: lushenming <lushenming@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>; Jason Cooper <jason@lakedaemon.net>; linux-kernel@vger.kernel.org; Wanghaibin (D) <wanghaibin.wang@huawei.com>; yuzenghui <yuzenghui@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll on the GICR_VPENDBASER.Dirty bit

On 2020-09-16 08:04, lushenming wrote:
> Hi,
> 
> Our team just discussed this issue again and consulted our GIC 
> hardware design team. They think the RD can afford busy waiting. So we 
> still think maybe 0 is better, at least for our hardware.
> 
> In addition, if not 0, as I said before, in our measurement, it takes 
> only hundreds of nanoseconds, or 1~2 microseconds, to finish parsing 
> the VPT in most cases. So maybe 1 microseconds, or smaller, is more 
> appropriate.
> Anyway, 10 microseconds is too much.
> 
> But it has to be said that it does depend on the hardware 
> implementation.

Exactly. And given that the only publicly available implementation is a software model, I am reluctant to change "performance" related things based on benchmarks that can't be verified and appears to me as a micro optimization.

> Besides, I'm not sure where are the start and end point of the total 
> scheduling latency of a vcpu you said, which includes many events. Is 
> the parse time of the VPT not clear enough?

Measure the time it takes from kvm_vcpu_load() to the point where the vcpu enters the guest. How much, in proportion, do these 1/2/10ms represent?

Also, a better(?) course of action would maybe to consider whether we should split the its_vpe_schedule() call into two distinct operations: one that programs the VPE to be resident, and another that poll the Dirty bit *much
later* on the entry path, giving the GIC a chance to work in parallel with the CPU on the entry path.

If your HW is a quick as you say it is, it would pretty much guarantee a clear read of GICR_VPENDBASER without waiting.

         M.
--
Jazz is not dead. It just smells funny...
