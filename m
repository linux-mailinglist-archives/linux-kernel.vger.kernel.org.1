Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C879E27BB4A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgI2DJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:09:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14766 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbgI2DJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:09:38 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D6152A856192C72ECB9E;
        Tue, 29 Sep 2020 11:09:34 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 11:09:26 +0800
Subject: Re: [PATCH v4 07/20] dt-bindings: arm: hisilicon: convert system
 controller bindings to json-schema
To:     Rob Herring <robh@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-8-thunder.leizhen@huawei.com>
 <20200928191310.GA3092001@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c492e70f-a24a-4956-3302-ff52ef70dc73@huawei.com>
Date:   Tue, 29 Sep 2020 11:09:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928191310.GA3092001@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/29 3:13, Rob Herring wrote:
> On Mon, Sep 28, 2020 at 11:13:11PM +0800, Zhen Lei wrote:
>> Convert the Hisilicon system controller and its variants binding to DT
>> schema format using json-schema. All of them are grouped into one yaml
>> file, to help users understand differences and avoid repeated
>> descriptions.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../controller/hisilicon,hi6220-sysctrl.txt        |  19 ----
>>  .../controller/hisilicon,hip01-sysctrl.txt         |  19 ----
>>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 -----
>>  .../hisilicon/controller/hisilicon,sysctrl.yaml    | 115 +++++++++++++++++++++
>>  .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 ---
>>  5 files changed, 115 insertions(+), 77 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>> deleted file mode 100644
>> index 07e318eda254f52..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>> +++ /dev/null
>> @@ -1,19 +0,0 @@
>> -Hisilicon Hi6220 system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-sysctrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, many clock registers are defined
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this controller as one of the system controllers,
>> -its main functions are the same as Hisilicon system controller, but
>> -the register offset of some core modules are different.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	sys_ctrl: sys_ctrl@f7030000 {
>> -		compatible = "hisilicon,hi6220-sysctrl", "syscon";
>> -		reg = <0x0 0xf7030000 0x0 0x2000>;
>> -		#clock-cells = <1>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>> deleted file mode 100644
>> index db2dfdce799db91..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>> +++ /dev/null
>> @@ -1,19 +0,0 @@
>> -Hisilicon HiP01 system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hip01-sysctrl"
>> -- reg : Register address and size
>> -
>> -The HiP01 system controller is mostly compatible with hisilicon
>> -system controller,but it has some specific control registers for
>> -HIP01 SoC family, such as slave core boot, and also some same
>> -registers located at different offset.
>> -
>> -Example:
>> -
>> -	/* for hip01-ca9x2 */
>> -	sysctrl: system-controller@10000000 {
>> -		compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
>> -		reg = <0x10000000 0x1000>;
>> -		reboot-offset = <0x4>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>> deleted file mode 100644
>> index 963f7f1ca7a2f0c..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>> +++ /dev/null
>> @@ -1,25 +0,0 @@
>> -Hisilicon system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,sysctrl"
>> -- reg : Register address and size
>> -
>> -Optional properties:
>> -- smp-offset : offset in sysctrl for notifying slave cpu booting
>> -		cpu 1, reg;
>> -		cpu 2, reg + 0x4;
>> -		cpu 3, reg + 0x8;
>> -		If reg value is not zero, cpun exit wfi and go
>> -- resume-offset : offset in sysctrl for notifying cpu0 when resume
>> -- reboot-offset : offset in sysctrl for system reboot
>> -
>> -Example:
>> -
>> -	/* for Hi3620 */
>> -	sysctrl: system-controller@fc802000 {
>> -		compatible = "hisilicon,sysctrl";
>> -		reg = <0xfc802000 0x1000>;
>> -		smp-offset = <0x31c>;
>> -		resume-offset = <0x308>;
>> -		reboot-offset = <0x4>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml
>> new file mode 100644
>> index 000000000000000..37b214e0a401d7d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml
>> @@ -0,0 +1,115 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,sysctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon system controller
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  The Hisilicon system controller is used on many Hisilicon boards, it can be
>> +  used to assist the slave core startup, reboot the system, etc.
>> +
>> +  There are some variants of the Hisilicon system controller, such as HiP01,
>> +  Hi3519, Hi6220 system controller, each of them is mostly compatible with the
>> +  Hisilicon system controller, but some same registers located at different
>> +  offset. In addition, the HiP01 system controller has some specific control
>> +  registers for HIP01 SoC family, such as slave core boot.
>> +
>> +  The compatible names of each system controller are as follows:
>> +  Hisilicon system controller   --> hisilicon,sysctrl
>> +  HiP01     system controller   --> hisilicon,hip01-sysctrl
>> +  Hi6220    system controller   --> hisilicon,hi6220-sysctrl
>> +  Hi3519    system controller   --> hisilicon,hi3519-sysctrl
>> +
>> +allOf:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: hisilicon,hi6220-sysctrl
>> +    then:
>> +      required:
>> +        - '#clock-cells'
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: hisilicon,sysctrl
>> +      - items:
>> +          - const: hisilicon,sysctrl
>> +          - const: syscon
> 
> Of these 2, the 1st case should be fixed (add 'syscon' in the dts 
> files).

OK, I will fix it.

> 
>> +      - items:
>> +          - const: hisilicon,hip01-sysctrl
>> +          - const: hisilicon,sysctrl
>> +      - items:
>> +          - const: hisilicon,hi6220-sysctrl
>> +          - const: syscon
>> +      - items:
>> +          - const: hisilicon,hi3519-sysctrl
>> +          - const: syscon
> 
> All the cases with 'syscon' can be a single entry. Use 'enum' for the 
> 1st string.

OK, I will do it.

> 
>> +
>> +  reg:
>> +    description: Register address and size
> 
> That's every 'reg' property. Drop it.

OK, I will drop the description.

> 
>> +    maxItems: 1
>> +
>> +  smp-offset:
>> +    description: |
>> +      offset in sysctrl for notifying slave cpu booting
>> +      cpu 1, reg;
>> +      cpu 2, reg + 0x4;
>> +      cpu 3, reg + 0x8;
>> +      If reg value is not zero, cpun exit wfi and go
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  resume-offset:
>> +    description: offset in sysctrl for notifying cpu0 when resume
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  reboot-offset:
>> +    description: offset in sysctrl for system reboot
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +
>> +  '#clock-cells':
>> +    description: the number of cells occupied by one clock ID.
> 
> Drop.

OK, I will drop the description.

> 
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> additionalProperties: false
> 
> (and in other patches)

OK, I will do it.

> 
>> +
>> +examples:
>> +  - |
>> +    /* Hisilicon system controller */
>> +    system-controller@fc802000 {
>> +        compatible = "hisilicon,sysctrl";
>> +        reg = <0xfc802000 0x1000>;
>> +        smp-offset = <0x31c>;
>> +        resume-offset = <0x308>;
>> +        reboot-offset = <0x4>;
>> +    };
>> +
>> +    /* HiP01 system controller */
>> +    system-controller@10000000 {
>> +        compatible = "hisilicon,hip01-sysctrl", "hisilicon,sysctrl";
>> +        reg = <0x10000000 0x1000>;
>> +        reboot-offset = <0x4>;
>> +    };
>> +
>> +    /* Hi6220 system controller */
>> +    system-controller@f7030000 {
>> +        compatible = "hisilicon,hi6220-sysctrl", "syscon";
>> +        reg = <0xf7030000 0x2000>;
>> +        #clock-cells = <1>;
>> +    };
>> +
>> +    /* Hi3519 system controller */
>> +    system-controller@12010000 {
>> +        compatible = "hisilicon,hi3519-sysctrl", "syscon";
>> +        reg = <0x12010000 0x1000>;
>> +    };
>> +...
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
>> deleted file mode 100644
>> index 8defacc44dd5b9e..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -* Hisilicon Hi3519 System Controller Block
>> -
>> -This bindings use the following binding:
>> -Documentation/devicetree/bindings/mfd/syscon.yaml
>> -
>> -Required properties:
>> -- compatible: "hisilicon,hi3519-sysctrl".
>> -- reg: the register region of this block
>> -
>> -Examples:
>> -sysctrl: system-controller@12010000 {
>> -	compatible = "hisilicon,hi3519-sysctrl", "syscon";
>> -	reg = <0x12010000 0x1000>;
>> -};
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

