Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3D826BDA3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIPHEo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Sep 2020 03:04:44 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3605 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbgIPHEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:04:35 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 56F863036FD63F611675;
        Wed, 16 Sep 2020 15:04:31 +0800 (CST)
Received: from DGGEMI424-HUB.china.huawei.com (10.1.199.153) by
 dggemi402-hub.china.huawei.com (10.3.17.135) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 16 Sep 2020 15:04:30 +0800
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.78]) by
 DGGEMI424-HUB.china.huawei.com ([10.1.199.153]) with mapi id 14.03.0487.000;
 Wed, 16 Sep 2020 15:04:24 +0800
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
Thread-Index: AdaLYvuHeQKSQv5lQ9G9IAytgjmwLv//klKA//55OFA=
Date:   Wed, 16 Sep 2020 07:04:24 +0000
Message-ID: <343E0E168479F04FACCB176989D12DE7EE3206@dggemi522-mbs.china.huawei.com>
References: <343E0E168479F04FACCB176989D12DE7EE1D2D@dggemi522-mbs.china.huawei.com>
 <a87d26bc52b25247dd23e5cb1cd56bad@kernel.org>
In-Reply-To: <a87d26bc52b25247dd23e5cb1cd56bad@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.184.59]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Our team just discussed this issue again and consulted our GIC hardware 
design team. They think the RD can afford busy waiting. So we still think 
maybe 0 is better, at least for our hardware.

In addition, if not 0, as I said before, in our measurement, it takes only 
hundreds of nanoseconds, or 1~2 microseconds, to finish parsing the VPT 
in most cases. So maybe 1 microseconds, or smaller, is more appropriate. 
Anyway, 10 microseconds is too much.

But it has to be said that it does depend on the hardware implementation.

Besides, I'm not sure where are the start and end point of the total scheduling 
latency of a vcpu you said, which includes many events. Is the parse time of 
the VPT not clear enough?

-----Original Message-----
From: Marc Zyngier [mailto:maz@kernel.org] 
Sent: 2020-09-15 22:48
To: lushenming <lushenming@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>; Jason Cooper <jason@lakedaemon.net>; linux-kernel@vger.kernel.org; Wanghaibin (D) <wanghaibin.wang@huawei.com>; yuzenghui <yuzenghui@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll on the GICR_VPENDBASER.Dirty bit

On 2020-09-15 15:04, lushenming wrote:
> Thanks for your quick response.
> 
> Okay, I agree that busy-waiting may add more overhead at the RD level.
> But I think that the delay time can be adjusted. In our latest 
> hardware implementation, we optimize the search of the VPT, now even 
> the VPT full of interrupts (56k) can be parsed within 2 microseconds.

It's not so much when the VPT is full that it is bad. It is when the pending interrupts are not cached, and that you don't know *where* to look for them in the VPT.

> It is true that the parse speeds of various hardware are different, 
> but does directly waiting for 10 microseconds make the optimization of 
> those fast hardware be completely masked? Maybe we can set the delay 
> time smaller, like 1 microseconds?

That certainly would be more acceptable. But I still question the impact of such a change compared to the cost of a vcpu entry. I suggest you come up with measurements that actually show that polling this register more often significantly reduces the entry latency. Only then can we make an educated decision.

Thanks,

         M.
--
Jazz is not dead. It just smells funny...
