Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947C1279F11
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 08:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgI0Gt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 02:49:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730224AbgI0Gt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 02:49:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 41C6E69F3BB150381954;
        Sun, 27 Sep 2020 14:49:23 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sun, 27 Sep 2020
 14:49:14 +0800
Subject: Re: [PATCH v6 0/6] irqchip: dw-apb-ictl: support hierarchy irq domain
To:     Marc Zyngier <maz@kernel.org>, Vineet Gupta <vgupta@synopsys.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Haoyu Lv <lvhaoyu@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Libin <huawei.libin@huawei.com>
References: <20200924071754.4509-1-thunder.leizhen@huawei.com>
 <160104911402.38543.3098076840902954515.b4-ty@kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f6436e0d-dbed-5455-134f-e209f2a3b131@huawei.com>
Date:   Sun, 27 Sep 2020 14:49:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <160104911402.38543.3098076840902954515.b4-ty@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/25 23:54, Marc Zyngier wrote:
> On Thu, 24 Sep 2020 15:17:48 +0800, Zhen Lei wrote:
>> v5 --> v6:
>> 1. add Reviewed-by: Rob Herring <robh@kernel.org> for Patch 4.
>> 2. Some modifications are made to Patch 5:
>>    1) add " |" for each "description:" property if its content exceeds one line,
>>       to tell the yaml keep the "newline" character.
>>    2) add "..." to mark the end of the yaml file.
>>    3) Change the name list of maintainers to the author of "snps,dw-apb-ictl.txt"
>> 	 maintainers:
>> 	-  - Marc Zyngier <marc.zyngier@arm.com>
>> 	+  - Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>>    4) add "maxItems: 1" for property "reg".
>>    5) for property "interrupts":
>> 	 interrupts:
>> 	-    minItems: 1
>> 	-    maxItems: 65
>> 	+    maxItems: 1
>>    6) move below descriptions under the top level property "description:"
>> 	description: |
>> 	  Synopsys DesignWare provides interrupt controller IP for APB known as
>> 	  dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs
>> 	  with APB bus, e.g. Marvell Armada 1500. It can also be used as primary
>> 	  interrupt controller in some SoCs, e.g. Hisilicon SD5203.
>>
>> [...]
> 
> Applied to irq/irqchip-next, thanks!

Thank you very much. You have provided a lot of valuable review of this patch series.

> 
> [1/6] genirq: Add stub for set_handle_irq() when !GENERIC_IRQ_MULTI_HANDLER
>       commit: ea0c80d1764449acf2f70fdb25aec33800cd0348
> [2/6] irqchip/dw-apb-ictl: Refactor priot to introducing hierarchical irq domains
>       commit: d59f7d159891466361808522b63cf3548ea3ecb0
> [3/6] irqchip/dw-apb-ictl: Add primary interrupt controller support
>       commit: 54a38440b84f8933b555c23273deca6a396f6708
> [4/6] dt-bindings: dw-apb-ictl: Update binding to describe use as primary interrupt controller
>       commit: 8156b80fd4885d0ca9748e736441cc37f4eb476a
> 
> I have dropped patch 5 as it doesn't have Rob's Ack yet (and is not that
> critical) as well as patch 6 which is better routed via the ARC tree.

OK. I will continue talking to Rob about patch 5. Rob suggested me to remove below allOf, but I have not
done it. If the allOf should be removed, the 6/6 will be discarded.
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#

> 
> Cheers,
> 
> 	M.
> 

