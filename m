Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0EA12D214B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 04:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgLHDIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 22:08:51 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9392 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgLHDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 22:08:50 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CqlTw3ttJz77TJ;
        Tue,  8 Dec 2020 11:07:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Dec 2020
 11:07:55 +0800
Subject: Re: [PATCH v2 3/3] dt-bindings: reset: convert Hisilicon reset
 controller bindings to json-schema
To:     Rob Herring <robh@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20201204014236.1158-1-thunder.leizhen@huawei.com>
 <20201204014236.1158-4-thunder.leizhen@huawei.com>
 <20201207231055.GA1021342@robh.at.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <dd095383-d165-5eee-4469-51173d0b1eaa@huawei.com>
Date:   Tue, 8 Dec 2020 11:07:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201207231055.GA1021342@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/8 7:10, Rob Herring wrote:
> On Fri, Dec 04, 2020 at 09:42:36AM +0800, Zhen Lei wrote:
>> Convert the Hisilicon reset controller binding to DT schema format using
>> json-schema.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../bindings/reset/hisilicon,hi3660-reset.txt      | 44 -------------
>>  .../bindings/reset/hisilicon,hi3660-reset.yaml     | 77 ++++++++++++++++++++++
>>  2 files changed, 77 insertions(+), 44 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>>  create mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>> deleted file mode 100644
>> index aefd26710f9e87d..000000000000000
>> --- a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.txt
>> +++ /dev/null
>> @@ -1,44 +0,0 @@
>> -Hisilicon System Reset Controller
>> -======================================
>> -
>> -Please also refer to reset.txt in this directory for common reset
>> -controller binding usage.
>> -
>> -The reset controller registers are part of the system-ctl block on
>> -hi3660 and hi3670 SoCs.
>> -
>> -Required properties:
>> -- compatible: should be one of the following:
>> -		 "hisilicon,hi3660-reset" for HI3660
>> -		 "hisilicon,hi3670-reset", "hisilicon,hi3660-reset" for HI3670
>> -- hisilicon,rst-syscon: phandle of the reset's syscon.
>> -- #reset-cells : Specifies the number of cells needed to encode a
>> -  reset source.  The type shall be a <u32> and the value shall be 2.
>> -
>> -	 Cell #1 : offset of the reset assert control
>> -	           register from the syscon register base
>> -		   offset + 4: deassert control register
>> -		   offset + 8: status control register
>> -	 Cell #2 : bit position of the reset in the reset control register
>> -
>> -Example:
>> -	iomcu: iomcu@ffd7e000 {
>> -		compatible = "hisilicon,hi3660-iomcu", "syscon";
>> -		reg = <0x0 0xffd7e000 0x0 0x1000>;
>> -	};
>> -
>> -	iomcu_rst: iomcu_rst_controller {
>> -		compatible = "hisilicon,hi3660-reset";
>> -		hisilicon,rst-syscon = <&iomcu>;
>> -		#reset-cells = <2>;
>> -	};
>> -
>> -Specifying reset lines connected to IP modules
>> -==============================================
>> -example:
>> -
>> -        i2c0: i2c@..... {
>> -                ...
>> -		resets = <&iomcu_rst 0x20 3>; /* offset: 0x20; bit: 3 */
>> -                ...
>> -        };
>> diff --git a/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
>> new file mode 100644
>> index 000000000000000..9bf40952e5b7d28
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/hisilicon,hi3660-reset.yaml
>> @@ -0,0 +1,77 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/hisilicon,hi3660-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon System Reset Controller
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  Please also refer to reset.txt in this directory for common reset
>> +  controller binding usage.
>> +  The reset controller registers are part of the system-ctl block on
>> +  hi3660 and hi3670 SoCs.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: hisilicon,hi3660-reset
>> +      - items:
>> +          - const: hisilicon,hi3670-reset
>> +          - const: hisilicon,hi3660-reset
>> +
>> +  hisilicon,rst-syscon:
>> +    description: phandle of the reset's syscon.
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +
>> +  '#reset-cells':
>> +    description: |
>> +      Specifies the number of cells needed to encode a reset source.
>> +      Cell #1 : offset of the reset assert control register from the syscon
>> +                register base
>> +                offset + 4: deassert control register
>> +                offset + 8: status control register
>> +      Cell #2 : bit position of the reset in the reset control register
>> +    const: 2
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/hi3660-clock.h>
>> +
>> +    iomcu: iomcu@ffd7e000 {
>> +        compatible = "hisilicon,hi3660-iomcu", "syscon";
>> +        reg = <0xffd7e000 0x1000>;
>> +    };
>> +
>> +    iomcu_rst: iomcu_rst_controller {
>> +        compatible = "hisilicon,hi3660-reset";
>> +        hisilicon,rst-syscon = <&iomcu>;
> 
> Really, if you are going to break things, this node should be a child of 
> iomcu instead and you don't need this property (just get the parent). Or 
> just add '#reset-cells' to iomcu.

There are two compatible strings, which belong to two different functional
modules. This should be done to keep the code architecture clear.

drivers/clk/hisilicon/clk-hi3660.c		//compatible = "hisilicon,hi3660-iomcu"
drivers/reset/hisilicon/reset-hi3660.c		//compatible = "hisilicon,hi3660-reset"

> 
>> +        #reset-cells = <2>;
>> +    };
>> +
>> +    /* Specifying reset lines connected to IP modules */
>> +    i2c@ffd71000 {
>> +        compatible = "snps,designware-i2c";
>> +        reg = <0xffd71000 0x1000>;
>> +        interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        clock-frequency = <400000>;
>> +        clocks = <&crg_ctrl HI3660_CLK_GATE_I2C0>;
>> +        resets = <&iomcu_rst 0x20 3>;
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&i2c0_pmx_func &i2c0_cfg_func>;
>> +        status = "disabled";
>> +    };
>> +...
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

