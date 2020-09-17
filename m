Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598B326D1E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgIQDqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:46:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgIQDqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:46:30 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B7E0813A712CA9F16AFF;
        Thu, 17 Sep 2020 11:46:26 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 11:46:18 +0800
Subject: Re: [PATCH v4 1/4] genirq: define an empty function set_handle_irq()
 if !GENERIC_IRQ_MULTI_HANDLER
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
References: <20200915084305.3085-1-thunder.leizhen@huawei.com>
 <20200915084305.3085-2-thunder.leizhen@huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0a2bc6bf-db9e-6467-dfcc-27f37d2db816@huawei.com>
Date:   Thu, 17 Sep 2020 11:46:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200915084305.3085-2-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/15 16:43, Zhen Lei wrote:
> To avoid compilation error if an irqchip driver references the function
> set_handle_irq() but may not select GENERIC_IRQ_MULTI_HANDLER on some
> systems.

Hi, Marc:
  Do you agree with this method?

  Otherwise, I should use "#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER ... #endif"
to perform the compilation isolation. This may make the code less beautiful.

> 
> For example, the Synopsys DesignWare APB interrupt controller
> (dw_apb_ictl) is used as the secondary interrupt controller on arc, csky,
> arm64, and most arm32 SoCs, and it's also used as the primary interrupt
> controller on Hisilicon SD5203 (an arm32 SoC). The latter need to use
> set_handle_irq() to register the top-level IRQ handler, but this multi
> irq handler registration mechanism is not implemented on arc system.
> 
> The input parameter "handle_irq" maybe defined as static and only
> set_handle_irq() references it. This will trigger "defined but not used"
> warning. So add "(void)handle_irq" to suppress it.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  include/linux/irq.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/irq.h b/include/linux/irq.h
> index 1b7f4dfee35b397..0848a2aaa9b40b1 100644
> --- a/include/linux/irq.h
> +++ b/include/linux/irq.h
> @@ -1252,6 +1252,8 @@ void irq_matrix_free(struct irq_matrix *m, unsigned int cpu,
>   * top-level IRQ handler.
>   */
>  extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
> +#else
> +#define set_handle_irq(handle_irq)	do { (void)handle_irq; } while (0)
>  #endif
>  
>  #endif /* _LINUX_IRQ_H */
> 

