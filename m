Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C232827AC8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI1LTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:19:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgI1LTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:19:38 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A42B32B9EE50A936988A;
        Mon, 28 Sep 2020 19:19:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 28 Sep 2020
 19:19:24 +0800
Subject: Re: [PATCH v3 21/21] dt-bindings: arm: hisilicon: convert LPC
 controller bindings to json-schema
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
 <20200927062129.4573-22-thunder.leizhen@huawei.com>
 <20200928105258.000016c5@Huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8256791c-26e3-eee6-38e1-985cd795b40d@huawei.com>
Date:   Mon, 28 Sep 2020 19:19:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928105258.000016c5@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/28 17:52, Jonathan Cameron wrote:
> On Sun, 27 Sep 2020 14:21:29 +0800
> Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> Convert the Hisilicon Hip06 SoCs implement a Low Pin Count (LPC)
>> controller binding to DT schema format using json-schema.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> As only single entries in the oneOf, can just use an enum.

Oh, yes, using enum will look simpler.

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>>  .../arm/hisilicon/hisilicon-low-pin-count.txt      | 33 ------------
>>  .../arm/hisilicon/hisilicon-low-pin-count.yaml     | 63 ++++++++++++++++++++++
>>  2 files changed, 63 insertions(+), 33 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>> deleted file mode 100644
>> index 10bd35f9207f2ee..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.txt
>> +++ /dev/null
>> @@ -1,33 +0,0 @@
>> -Hisilicon Hip06 Low Pin Count device
>> -  Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
>> -  provides I/O access to some legacy ISA devices.
>> -  Hip06 is based on arm64 architecture where there is no I/O space. So, the
>> -  I/O ports here are not CPU addresses, and there is no 'ranges' property in
>> -  LPC device node.
>> -
>> -Required properties:
>> -- compatible:  value should be as follows:
>> -	(a) "hisilicon,hip06-lpc"
>> -	(b) "hisilicon,hip07-lpc"
>> -- #address-cells: must be 2 which stick to the ISA/EISA binding doc.
>> -- #size-cells: must be 1 which stick to the ISA/EISA binding doc.
>> -- reg: base memory range where the LPC register set is mapped.
>> -
>> -Note:
>> -  The node name before '@' must be "isa" to represent the binding stick to the
>> -  ISA/EISA binding specification.
>> -
>> -Example:
>> -
>> -isa@a01b0000 {
>> -	compatible = "hisilicon,hip06-lpc";
>> -	#address-cells = <2>;
>> -	#size-cells = <1>;
>> -	reg = <0x0 0xa01b0000 0x0 0x1000>;
>> -
>> -	ipmi0: bt@e4 {
>> -		compatible = "ipmi-bt";
>> -		device_type = "ipmi";
>> -		reg = <0x01 0xe4 0x04>;
>> -	};
>> -};
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml
>> new file mode 100644
>> index 000000000000000..a43f8b65547c10f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon-low-pin-count.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/hisilicon-low-pin-count.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon Hip06 Low Pin Count device
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  Hisilicon Hip06 SoCs implement a Low Pin Count (LPC) controller, which
>> +  provides I/O access to some legacy ISA devices.
>> +  Hip06 is based on arm64 architecture where there is no I/O space. So, the
>> +  I/O ports here are not CPU addresses, and there is no 'ranges' property in
>> +  LPC device node.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: '^isa@[0-9a-f]+$'
>> +    description: |
>> +      The node name before '@' must be "isa" to represent the binding stick
>> +      to the ISA/EISA binding specification.
>> +
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +        - const: hisilicon,hip06-lpc
>> +      - items:
>> +        - const: hisilicon,hip07-lpc
> 
>        enum:
>          - hisilicon,hip06-lpc
>          - hisilicon,hip07-lpc
> 
>> +
>> +  reg:
>> +    description: base memory range where the LPC register set is mapped.
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    description: must be 2 which stick to the ISA/EISA binding doc.
>> +    const: 2
>> +
>> +  '#size-cells':
>> +    description: must be 1 which stick to the ISA/EISA binding doc.
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    isa@a01b0000 {
>> +        compatible = "hisilicon,hip06-lpc";
>> +        #address-cells = <2>;
>> +        #size-cells = <1>;
>> +        reg = <0xa01b0000 0x1000>;
>> +
>> +        ipmi0: bt@e4 {
>> +            compatible = "ipmi-bt";
>> +            device_type = "ipmi";
>> +            reg = <0x01 0xe4 0x04>;
>> +        };
>> +    };
>> +...
>> \ No newline at end of file
> 
> 
> 
> .
> 

