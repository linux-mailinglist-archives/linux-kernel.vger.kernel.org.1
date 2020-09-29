Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A3F27BA54
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgI2Bh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:37:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727238AbgI2Bh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:37:28 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B91D2B98ABC79E62AE2F;
        Tue, 29 Sep 2020 09:37:25 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 09:37:15 +0800
Subject: Re: [PATCH v6 5/6] dt-bindings: dw-apb-ictl: convert to json-schema
To:     Rob Herring <robh@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        "Vineet Gupta" <vgupta@synopsys.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200924071754.4509-1-thunder.leizhen@huawei.com>
 <20200924071754.4509-6-thunder.leizhen@huawei.com>
 <20200928182645.GA3030999@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <784bc919-7a3e-b332-a6d8-35d0e3494f2f@huawei.com>
Date:   Tue, 29 Sep 2020 09:37:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928182645.GA3030999@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/29 2:26, Rob Herring wrote:
> On Thu, Sep 24, 2020 at 03:17:53PM +0800, Zhen Lei wrote:
>> Convert the Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
>> binding to DT schema format using json-schema.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../interrupt-controller/snps,dw-apb-ictl.txt      | 43 -------------
>>  .../interrupt-controller/snps,dw-apb-ictl.yaml     | 74 ++++++++++++++++++++++
>>  2 files changed, 74 insertions(+), 43 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>> deleted file mode 100644
>> index 2db59df9408f4c6..000000000000000
>> --- a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>> +++ /dev/null
>> @@ -1,43 +0,0 @@
>> -Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
>> -
>> -Synopsys DesignWare provides interrupt controller IP for APB known as
>> -dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs with
>> -APB bus, e.g. Marvell Armada 1500. It can also be used as primary interrupt
>> -controller in some SoCs, e.g. Hisilicon SD5203.
>> -
>> -Required properties:
>> -- compatible: shall be "snps,dw-apb-ictl"
>> -- reg: physical base address of the controller and length of memory mapped
>> -  region starting with ENABLE_LOW register
>> -- interrupt-controller: identifies the node as an interrupt controller
>> -- #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
>> -
>> -Additional required property when it's used as secondary interrupt controller:
>> -- interrupts: interrupt reference to primary interrupt controller
>> -
>> -The interrupt sources map to the corresponding bits in the interrupt
>> -registers, i.e.
>> -- 0 maps to bit 0 of low interrupts,
>> -- 1 maps to bit 1 of low interrupts,
>> -- 32 maps to bit 0 of high interrupts,
>> -- 33 maps to bit 1 of high interrupts,
>> -- (optional) fast interrupts start at 64.
>> -
>> -Example:
>> -	/* dw_apb_ictl is used as secondary interrupt controller */
>> -	aic: interrupt-controller@3000 {
>> -		compatible = "snps,dw-apb-ictl";
>> -		reg = <0x3000 0xc00>;
>> -		interrupt-controller;
>> -		#interrupt-cells = <1>;
>> -		interrupt-parent = <&gic>;
>> -		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>> -	};
>> -
>> -	/* dw_apb_ictl is used as primary interrupt controller */
>> -	vic: interrupt-controller@10130000 {
>> -		compatible = "snps,dw-apb-ictl";
>> -		reg = <0x10130000 0x1000>;
>> -		interrupt-controller;
>> -		#interrupt-cells = <1>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
>> new file mode 100644
>> index 000000000000000..1b05d36b5f7b943
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
>> @@ -0,0 +1,74 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/interrupt-controller/snps,dw-apb-ictl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
>> +
>> +maintainers:
>> +  - Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>> +
>> +description: |
>> +  Synopsys DesignWare provides interrupt controller IP for APB known as
>> +  dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs
>> +  with APB bus, e.g. Marvell Armada 1500. It can also be used as primary
>> +  interrupt controller in some SoCs, e.g. Hisilicon SD5203.
>> +
>> +  The interrupt sources map to the corresponding bits in the interrupt
>> +  registers, i.e.
>> +  - 0 maps to bit 0 of low interrupts,
>> +  - 1 maps to bit 1 of low interrupts,
>> +  - 32 maps to bit 0 of high interrupts,
>> +  - 33 maps to bit 1 of high interrupts,
>> +  - (optional) fast interrupts start at 64.
>> +
>> +allOf:
>> +  - $ref: /schemas/interrupt-controller.yaml#
> 
> Don't need this. It's already selected based on node name.

OK, I will drop it.

> 
>> +
>> +properties:
>> +  compatible:
>> +    const: snps,dw-apb-ictl
>> +
>> +  interrupt-controller: true
>> +
>> +  reg:
>> +    description: |
>> +      Physical base address of the controller and length of memory mapped
>> +      region starting with ENABLE_LOW register.
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    description: Interrupt reference to primary interrupt controller.
> 
> May not be primary. Could be another level in the middle. In any case, 
> it's outside the scope of this binding, so just drop description.

OK, I will drop this description. So I have learned that only the new
binding properties need to be described. Instead of keeping the original
description during the conversion.

> 
>> +    maxItems: 1
>> +
>> +  "#interrupt-cells":
>> +    description: Number of cells to encode an interrupt-specifier.
> 
> Can drop this.

OK

> 
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupt-controller
>> +  - '#interrupt-cells'
> 
> additionalProperties: false
> 
>> +
>> +examples:
>> +  - |
>> +    /* dw_apb_ictl is used as secondary interrupt controller */
>> +    aic: interrupt-controller@3000 {
> 
> Drop unused label (aic).

OK

> 
>> +        compatible = "snps,dw-apb-ictl";
>> +        reg = <0x3000 0xc00>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +        interrupt-parent = <&gic>;
>> +        interrupts = <0 3 4>;
>> +    };
>> +
>> +    /* dw_apb_ictl is used as primary interrupt controller */
>> +    vic: interrupt-controller@10130000 {
> 
> Same here.

OK, I will delete it.

> 
>> +        compatible = "snps,dw-apb-ictl";
>> +        reg = <0x10130000 0x1000>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <1>;
>> +    };
>> +...
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

