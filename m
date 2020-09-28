Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C26627AC56
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgI1K7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:59:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbgI1K7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:59:14 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9E8D15D22591EFFDF869;
        Mon, 28 Sep 2020 18:59:11 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 28 Sep 2020
 18:59:01 +0800
Subject: Re: [PATCH v3 08/21] dt-bindings: arm: hisilicon: convert system
 controller bindings to json-schema
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
 <20200927062129.4573-9-thunder.leizhen@huawei.com>
 <20200928104453.00000d0d@Huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8745e078-1624-735b-5d41-85412a344ed5@huawei.com>
Date:   Mon, 28 Sep 2020 18:59:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928104453.00000d0d@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/28 17:44, Jonathan Cameron wrote:
> On Sun, 27 Sep 2020 14:21:16 +0800
> Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> Convert the Hisilicon system controller and its variants binding to DT
>> schema format using json-schema. All of them are grouped into one yaml
>> file, to help users understand differences and avoid repeated
>> descriptions.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> Hi, one quick comment on indentation inline.  Having received some fixes
> for this from Rob recently it was still fresh in my mind!
> 
>> ---
>>  .../controller/hi3620/hisilicon,hi6220-sysctrl.txt |  19 ----
>>  .../controller/hipxx/hisilicon,hip01-sysctrl.txt   |  19 ----
>>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 -----
>>  .../hisilicon/controller/hisilicon,sysctrl.yaml    | 115 +++++++++++++++++++++
>>  .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 ---
>>  5 files changed, 115 insertions(+), 77 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3620/hisilicon,hi6220-sysctrl.txt
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hipxx/hisilicon,hip01-sysctrl.txt
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
>>
> 
> ...
> 
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.yaml
>> new file mode 100644
>> index 000000000000000..b65807574d92f95
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
>> +        - const: hisilicon,sysctrl
> 
> I believe indentation is wrt to the keyword not the -
> 
> https://lore.kernel.org/lkml/20200812203618.2656699-1-robh@kernel.org/
> 
> so should be
>          - items:
>              - const: hisilicon,sysctrl.

OK, I will correct it.

> 
>> +      - items:
>> +        - const: hisilicon,sysctrl
>> +        - const: syscon
>> +      - items:
>> +        - const: hisilicon,hip01-sysctrl
>> +        - const: hisilicon,sysctrl
>> +      - items:
>> +        - const: hisilicon,hi6220-sysctrl
>> +        - const: syscon
>> +      - items:
>> +        - const: hisilicon,hi3519-sysctrl
>> +        - const: syscon
>> +
>> +  reg:
>> +    description: Register address and size
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
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
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
> 
> 
> 
> .
> 

