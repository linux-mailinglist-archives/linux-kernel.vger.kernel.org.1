Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5992327DE98
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbgI3Cue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:50:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14731 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729446AbgI3Cud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:50:33 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8F2B331F9658EF0A7C8F;
        Wed, 30 Sep 2020 10:50:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 10:50:20 +0800
Subject: Re: [PATCH v5 15/17] dt-bindings: arm: hisilicon: convert Hi6220
 domain controller bindings to json-schema
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <20200929141454.2312-1-thunder.leizhen@huawei.com>
 <20200929141454.2312-16-thunder.leizhen@huawei.com>
 <5a6a9cd5-e235-e610-bbca-6d2d4547f051@huawei.com>
Message-ID: <91ae61b2-4bb0-e322-f231-325b7ee08e66@huawei.com>
Date:   Wed, 30 Sep 2020 10:50:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <5a6a9cd5-e235-e610-bbca-6d2d4547f051@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/30 9:38, Leizhen (ThunderTown) wrote:
> Hi, Rob:
>   I'm so glad to see you applied my patches in this morning. However, this patch
> is not applied and without any comment. Did you miss it?

Oh, I got it, missed the property "#reset-cells". What a shame! I will post the new one.

> 
> 
> On 2020/9/29 22:14, Zhen Lei wrote:
>> Convert the Hisilicon Hi6220 domain controllers binding to DT schema
>> format using json-schema. All of them are grouped into one yaml file, to
>> help users understand differences and avoid repeated descriptions.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../hisilicon/controller/hi6220-domain-ctrl.yaml   | 64 ++++++++++++++++++++++
>>  .../controller/hisilicon,hi6220-aoctrl.txt         | 18 ------
>>  .../controller/hisilicon,hi6220-mediactrl.txt      | 18 ------
>>  .../controller/hisilicon,hi6220-pmctrl.txt         | 18 ------
>>  4 files changed, 64 insertions(+), 54 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
>> new file mode 100644
>> index 000000000000000..32c562720d877c9
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi6220-domain-ctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon Hi6220 domain controller
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  Hisilicon designs some special domain controllers for mobile platform,
>> +  such as: the power Always On domain controller, the Media domain
>> +  controller(e.g. codec, G3D ...) and the Power Management domain
>> +  controller.
>> +
>> +  The compatible names of each domain controller are as follows:
>> +  Power Always ON domain controller  --> hisilicon,hi6220-aoctrl
>> +  Media domain controller            --> hisilicon,hi6220-mediactrl
>> +  Power Management domain controller --> hisilicon,hi6220-pmctrl
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - hisilicon,hi6220-aoctrl
>> +          - hisilicon,hi6220-mediactrl
>> +          - hisilicon,hi6220-pmctrl
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#clock-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    ao_ctrl@f7800000 {
>> +        compatible = "hisilicon,hi6220-aoctrl", "syscon";
>> +        reg = <0xf7800000 0x2000>;
>> +        #clock-cells = <1>;
>> +    };
>> +
>> +    media_ctrl@f4410000 {
>> +        compatible = "hisilicon,hi6220-mediactrl", "syscon";
>> +        reg = <0xf4410000 0x1000>;
>> +        #clock-cells = <1>;
>> +    };
>> +
>> +    pm_ctrl@f7032000 {
>> +        compatible = "hisilicon,hi6220-pmctrl", "syscon";
>> +        reg = <0xf7032000 0x1000>;
>> +        #clock-cells = <1>;
>> +    };
>> +...
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>> deleted file mode 100644
>> index 5a723c1d45f4a17..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>> +++ /dev/null
>> @@ -1,18 +0,0 @@
>> -Hisilicon Hi6220 Power Always ON domain controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-aoctrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, many clock registers are defined
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this system controller to control the power always
>> -on domain for mobile platform.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	ao_ctrl: ao_ctrl@f7800000 {
>> -		compatible = "hisilicon,hi6220-aoctrl", "syscon";
>> -		reg = <0x0 0xf7800000 0x0 0x2000>;
>> -		#clock-cells = <1>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>> deleted file mode 100644
>> index dcfdcbcb6455771..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>> +++ /dev/null
>> @@ -1,18 +0,0 @@
>> -Hisilicon Hi6220 Media domain controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-mediactrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, many clock registers are defined
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this system controller to control the multimedia
>> -domain(e.g. codec, G3D ...) for mobile platform.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	media_ctrl: media_ctrl@f4410000 {
>> -		compatible = "hisilicon,hi6220-mediactrl", "syscon";
>> -		reg = <0x0 0xf4410000 0x0 0x1000>;
>> -		#clock-cells = <1>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
>> deleted file mode 100644
>> index 972842f07b5a2ce..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
>> +++ /dev/null
>> @@ -1,18 +0,0 @@
>> -Hisilicon Hi6220 Power Management domain controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,hi6220-pmctrl"
>> -- reg : Register address and size
>> -- #clock-cells: should be set to 1, some clock registers are define
>> -  under this controller and this property must be present.
>> -
>> -Hisilicon designs this system controller to control the power management
>> -domain for mobile platform.
>> -
>> -Example:
>> -	/*for Hi6220*/
>> -	pm_ctrl: pm_ctrl@f7032000 {
>> -		compatible = "hisilicon,hi6220-pmctrl", "syscon";
>> -		reg = <0x0 0xf7032000 0x0 0x1000>;
>> -		#clock-cells = <1>;
>> -	};
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> .
> 

