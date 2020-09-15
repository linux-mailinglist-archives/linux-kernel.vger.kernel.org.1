Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730F826B74F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIPAVW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 20:21:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3602 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbgIOOVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:21:41 -0400
Received: from dggemi406-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id BE050A997A71D30631CE;
        Tue, 15 Sep 2020 22:04:37 +0800 (CST)
Received: from DGGEMI522-MBS.china.huawei.com ([169.254.8.78]) by
 dggemi406-hub.china.huawei.com ([10.3.17.144]) with mapi id 14.03.0487.000;
 Tue, 15 Sep 2020 22:04:31 +0800
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
Thread-Index: AdaLYvuHeQKSQv5lQ9G9IAytgjmwLg==
Date:   Tue, 15 Sep 2020 14:04:31 +0000
Message-ID: <343E0E168479F04FACCB176989D12DE7EE1D2D@dggemi522-mbs.china.huawei.com>
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

Thanks for your quick response.

Okay, I agree that busy-waiting may add more overhead at the RD level. But I think that the delay time can be adjusted. In our latest hardware implementation, we optimize the search of the VPT, now even the VPT full of interrupts (56k) can be parsed within 2 microseconds. It is true that the parse speeds of various hardware are different, but does directly waiting for 10 microseconds make the optimization of those fast hardware be completely masked? Maybe we can set the delay time smaller, like 1 microseconds?

In addition, 10 microseconds seems to be the data that our team reported earlier, which is the parse time in worst case.

-----Original Message-----
From: Marc Zyngier [mailto:maz@kernel.org] 
Sent: 2020-09-15 15:41
To: lushenming <lushenming@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>; Jason Cooper <jason@lakedaemon.net>; linux-kernel@vger.kernel.org; Wanghaibin (D) <wanghaibin.wang@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll on the GICR_VENPENDBASER.Dirty bit

On 2020-09-15 08:22, Shenming Lu wrote:
> Every time the vPE is scheduled, the code starts polling the 
> GICR_VPENDBASER.Dirty bit until it becomes 0. It's OK. But the 
> delay_us of the poll function is directly set to 10, which is a long 
> time for most interrupts. In our measurement, it takes only 1~2 
> microseconds, or even hundreds of nanoseconds, to finish parsing the 
> VPT in most cases. However, in the current implementation, if the 
> GICR_VPENDBASER.Dirty bit is not 0 immediately after the vPE is 
> scheduled, it will directly wait for 10 microseconds, resulting in 
> meaningless waiting.
> 
> In order to avoid meaningless waiting, we can set the delay_us to 0, 
> which can exit the poll function immediately when the Dirty bit 
> becomes 0.

We clearly have a difference in interpretation of the word "meaningless".

With this, you are busy-waiting on the register, adding even more overhead at the RD level. How is that better? The whole point is to back off and let the RD do its stuff in the background. This is also based on a massive sample of *one* implementation. How is that representative?

It would be a lot more convincing if you measured the difference it makes on the total scheduling latency of a vcpu. Assuming it makes
*any* observable difference.

Thanks,

         M.

> 
> Signed-off-by: Shenming Lu <lushenming@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c
> index 548de7538632..5cfcf0c2ce1a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3803,7 +3803,7 @@ static void its_wait_vpt_parse_complete(void)
>  	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + 
> GICR_VPENDBASER,
>  						       val,
>  						       !(val & GICR_VPENDBASER_Dirty),
> -						       10, 500));
> +						       0, 500));
>  }
> 
>  static void its_vpe_schedule(struct its_vpe *vpe)
--
Jazz is not dead. It just smells funny...
