Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768AA26D7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIQJc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbgIQJcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:32:21 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B7EB2074B;
        Thu, 17 Sep 2020 09:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600335140;
        bh=DFqDqNzqH797OlAwNq4RFVqjaZBNIPYvNn60NrF2Utc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U7eM0oc4TpV3tdV5YtVT+FS588phrXnHfJOmz7FX/HzYyLHRJCROEExC3DApTRdIp
         dSgiqQeQPUDXTVJGFvPJ29CfvoHAK6w5O/bW4z7/Ek4KEgaDuJVXqAhYwu7qNkKQQx
         C94oQ2DymxLieWao7l+QaaGshNCImjPEFNXMVizA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kIqH4-00CaeB-Dh; Thu, 17 Sep 2020 10:32:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 17 Sep 2020 10:32:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: Re: [PATCH v4 1/4] genirq: define an empty function set_handle_irq()
 if !GENERIC_IRQ_MULTI_HANDLER
In-Reply-To: <0a2bc6bf-db9e-6467-dfcc-27f37d2db816@huawei.com>
References: <20200915084305.3085-1-thunder.leizhen@huawei.com>
 <20200915084305.3085-2-thunder.leizhen@huawei.com>
 <0a2bc6bf-db9e-6467-dfcc-27f37d2db816@huawei.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <22defc7e8bf8d4dd91565473e1a67f22@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: thunder.leizhen@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, robh+dt@kernel.org, guoren@kernel.org, devicetree@vger.kernel.org, linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com, lvhaoyu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com, chenjianguo3@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-17 04:46, Leizhen (ThunderTown) wrote:
> On 2020/9/15 16:43, Zhen Lei wrote:
>> To avoid compilation error if an irqchip driver references the 
>> function
>> set_handle_irq() but may not select GENERIC_IRQ_MULTI_HANDLER on some
>> systems.
> 
> Hi, Marc:
>   Do you agree with this method?
> 
>   Otherwise, I should use "#ifdef CONFIG_GENERIC_IRQ_MULTI_HANDLER ... 
> #endif"
> to perform the compilation isolation. This may make the code less 
> beautiful.
> 
>> 
>> For example, the Synopsys DesignWare APB interrupt controller
>> (dw_apb_ictl) is used as the secondary interrupt controller on arc, 
>> csky,
>> arm64, and most arm32 SoCs, and it's also used as the primary 
>> interrupt
>> controller on Hisilicon SD5203 (an arm32 SoC). The latter need to use
>> set_handle_irq() to register the top-level IRQ handler, but this multi
>> irq handler registration mechanism is not implemented on arc system.
>> 
>> The input parameter "handle_irq" maybe defined as static and only
>> set_handle_irq() references it. This will trigger "defined but not 
>> used"
>> warning. So add "(void)handle_irq" to suppress it.
>> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  include/linux/irq.h | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/include/linux/irq.h b/include/linux/irq.h
>> index 1b7f4dfee35b397..0848a2aaa9b40b1 100644
>> --- a/include/linux/irq.h
>> +++ b/include/linux/irq.h
>> @@ -1252,6 +1252,8 @@ void irq_matrix_free(struct irq_matrix *m, 
>> unsigned int cpu,
>>   * top-level IRQ handler.
>>   */
>>  extern void (*handle_arch_irq)(struct pt_regs *) __ro_after_init;
>> +#else
>> +#define set_handle_irq(handle_irq)	do { (void)handle_irq; } while (0)
>>  #endif
>> 
>>  #endif /* _LINUX_IRQ_H */
>> 

You shouldn't just make it a NOP. Consider adding a WARN_ON(1), so that
people can realize this cannot work without the required architecture 
support.

         M.
-- 
Jazz is not dead. It just smells funny...
