Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D10B27679E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIXER7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:17:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbgIXER7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:17:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 61A8BD468DB62FD34F31;
        Thu, 24 Sep 2020 12:17:56 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 12:17:49 +0800
Subject: Re: [PATCH v5 5/6] dt-bindings: dw-apb-ictl: convert to json-schema
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
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
References: <20200918112202.3418-1-thunder.leizhen@huawei.com>
 <20200918112202.3418-6-thunder.leizhen@huawei.com>
 <20200923204911.GA1271664@bogus>
 <c5ba167c-2c66-66ec-9d0c-fe6a5755166f@huawei.com>
Message-ID: <a132b0cc-6299-6c96-ce07-bd4c5dd84bc1@huawei.com>
Date:   Thu, 24 Sep 2020 12:17:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c5ba167c-2c66-66ec-9d0c-fe6a5755166f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/24 11:26, Leizhen (ThunderTown) wrote:
> 
> 
> On 2020/9/24 4:49, Rob Herring wrote:
>> On Fri, Sep 18, 2020 at 07:22:01PM +0800, Zhen Lei wrote:
>>> Convert the Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
>>> binding to DT schema format using json-schema.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  .../interrupt-controller/snps,dw-apb-ictl.txt      | 43 -------------
>>>  .../interrupt-controller/snps,dw-apb-ictl.yaml     | 75 ++++++++++++++++++++++
>>>  2 files changed, 75 insertions(+), 43 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>>> deleted file mode 100644
>>> index 2db59df9408f4c6..000000000000000
>>> --- a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.txt
>>> +++ /dev/null
>>> @@ -1,43 +0,0 @@
>>> -Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
>>> -
>>> -Synopsys DesignWare provides interrupt controller IP for APB known as
>>> -dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs with
>>> -APB bus, e.g. Marvell Armada 1500. It can also be used as primary interrupt
>>> -controller in some SoCs, e.g. Hisilicon SD5203.
>>> -
>>> -Required properties:
>>> -- compatible: shall be "snps,dw-apb-ictl"
>>> -- reg: physical base address of the controller and length of memory mapped
>>> -  region starting with ENABLE_LOW register
>>> -- interrupt-controller: identifies the node as an interrupt controller
>>> -- #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
>>> -
>>> -Additional required property when it's used as secondary interrupt controller:
>>> -- interrupts: interrupt reference to primary interrupt controller
>>> -
>>> -The interrupt sources map to the corresponding bits in the interrupt
>>> -registers, i.e.
>>> -- 0 maps to bit 0 of low interrupts,
>>> -- 1 maps to bit 1 of low interrupts,
>>> -- 32 maps to bit 0 of high interrupts,
>>> -- 33 maps to bit 1 of high interrupts,
>>> -- (optional) fast interrupts start at 64.
>>> -
>>> -Example:
>>> -	/* dw_apb_ictl is used as secondary interrupt controller */
>>> -	aic: interrupt-controller@3000 {
>>> -		compatible = "snps,dw-apb-ictl";
>>> -		reg = <0x3000 0xc00>;
>>> -		interrupt-controller;
>>> -		#interrupt-cells = <1>;
>>> -		interrupt-parent = <&gic>;
>>> -		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
>>> -	};
>>> -
>>> -	/* dw_apb_ictl is used as primary interrupt controller */
>>> -	vic: interrupt-controller@10130000 {
>>> -		compatible = "snps,dw-apb-ictl";
>>> -		reg = <0x10130000 0x1000>;
>>> -		interrupt-controller;
>>> -		#interrupt-cells = <1>;
>>> -	};
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
>>> new file mode 100644
>>> index 000000000000000..70c12979c843bf0
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/snps,dw-apb-ictl.yaml
>>> @@ -0,0 +1,75 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/interrupt-controller/snps,dw-apb-ictl.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Synopsys DesignWare APB interrupt controller (dw_apb_ictl)
>>> +
>>> +maintainers:
>>> +  - Marc Zyngier <marc.zyngier@arm.com>
>>
>> Usually this would be an owner for this IP block, not the subsystem 
>> maintainer.
> 
> OK, I will change it to the author of the file "snps,dw-apb-ictl.txt".
> 
> 
>>
>>> +
>>> +description:
>>> +  Synopsys DesignWare provides interrupt controller IP for APB known as
>>> +  dw_apb_ictl. The IP is used as secondary interrupt controller in some SoCs
>>> +  with APB bus, e.g. Marvell Armada 1500. It can also be used as primary
>>> +  interrupt controller in some SoCs, e.g. Hisilicon SD5203.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/interrupt-controller.yaml#
>>
>> You can drop this, it's already applied based on node name.
> But if we drop this, the "snps,dw-apb-ictl.yaml" can not require that the node name
> must match '^interrupt-controller(@[0-9a-f,]+)*$'. The problem of Patch 6/6 was
> discovered by this.
> 
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: snps,dw-apb-ictl
>>> +
>>> +  interrupt-controller: true
>>> +
>>> +  reg:
>>> +    description:
>>> +      Physical base address of the controller and length of memory mapped
>>> +      region starting with ENABLE_LOW register.
>>
>> Need to define how many reg regions (maxItems: 1).
> 
> OK, I will add it.
> 
>>
>>> +
>>> +  interrupts:
>>> +    description:
>>> +      Interrupt reference to primary interrupt controller.
>>> +
>>> +      The interrupt sources map to the corresponding bits in the interrupt
>>> +      registers, i.e.
>>> +      - 0 maps to bit 0 of low interrupts,
>>> +      - 1 maps to bit 1 of low interrupts,
>>> +      - 32 maps to bit 0 of high interrupts,
>>> +      - 33 maps to bit 1 of high interrupts,
>>> +      - (optional) fast interrupts start at 64.
>>> +    minItems: 1
>>> +    maxItems: 65
>>
>> 65 connections to the primary interrupt controller? I think this is for 
>> the child interrupts? If so, move to #interrupt-cells description 
>> instead.
> Oh, yes. The property "interrupts" here describes which interrupts are used in the
> primary interrupt controller. We don't known how many will be connected but at least one.
> I will remove "maxItems: 65", it's my mistake.

Oh, I think I should change "minItems: 1" to "maxItems: 1" further， because there is only one
connection currently.

> 
> Property "#interrupt-cells" describes how many cells of one "interrupts" item. So I will
> move these descriptions under the top property "properties:"
> 
>>
>>> +
>>> +  "#interrupt-cells":
>>> +    description:
>>> +      Number of cells to encode an interrupt-specifier.
>>
>> Drop. No need to redefine common properties.
> 
> This is useful. See below, I add "const: 1" to require that the value of
> "#interrupt-cells" can only be one.
> 
> #interrupt-cells = <1>;
> 
> I followed the description in "snps,dw-apb-ictl.txt".
> -- #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
> 
>>
>>> +    const: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupt-controller
>>> +  - '#interrupt-cells'
>>> +
>>> +examples:
>>> +  - |
>>> +    /* dw_apb_ictl is used as secondary interrupt controller */
>>> +    aic: interrupt-controller@3000 {
>>> +        compatible = "snps,dw-apb-ictl";
>>> +        reg = <0x3000 0xc00>;
>>> +        interrupt-controller;
>>> +        #interrupt-cells = <1>;
>>> +        interrupt-parent = <&gic>;
>>> +        interrupts = <0 3 4>;
>>> +    };
>>> +
>>> +    /* dw_apb_ictl is used as primary interrupt controller */
>>> +    vic: interrupt-controller@10130000 {
>>> +        compatible = "snps,dw-apb-ictl";
>>> +        reg = <0x10130000 0x1000>;
>>> +        interrupt-controller;
>>> +        #interrupt-cells = <1>;
>>> +    };
>>> -- 
>>> 1.8.3
>>>
>>>
>>
>> .
>>

