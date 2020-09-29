Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6A27BB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbgI2DS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:18:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42780 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbgI2DS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:18:27 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AF216A48257E7E1D1A7C;
        Tue, 29 Sep 2020 11:18:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 11:18:15 +0800
Subject: Re: [PATCH v4 12/20] dt-bindings: arm: hisilicon: convert
 hisilicon,hi3798cv200-perictrl bindings to json-schema
To:     Rob Herring <robh@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-13-thunder.leizhen@huawei.com>
 <20200928191425.GA3099266@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0568ed90-c6ac-ae1c-45ee-cdc6526d3fcf@huawei.com>
Date:   Tue, 29 Sep 2020 11:18:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928191425.GA3099266@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/29 3:14, Rob Herring wrote:
> On Mon, Sep 28, 2020 at 11:13:16PM +0800, Zhen Lei wrote:
>> Convert the Hisilicon Hi3798CV200 Peripheral Controller binding to DT
>> schema format using json-schema.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../controller/hisilicon,hi3798cv200-perictrl.txt  | 21 ----------
>>  .../controller/hisilicon,hi3798cv200-perictrl.yaml | 45 ++++++++++++++++++++++
>>  2 files changed, 45 insertions(+), 21 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>> deleted file mode 100644
>> index 0d5282f4670658d..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>> +++ /dev/null
>> @@ -1,21 +0,0 @@
>> -Hisilicon Hi3798CV200 Peripheral Controller
>> -
>> -The Hi3798CV200 Peripheral Controller controls peripherals, queries
>> -their status, and configures some functions of peripherals.
>> -
>> -Required properties:
>> -- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
>> -  and "simple-mfd".
>> -- reg: Register address and size of Peripheral Controller.
>> -- #address-cells: Should be 1.
>> -- #size-cells: Should be 1.
>> -
>> -Examples:
>> -
>> -	perictrl: peripheral-controller@8a20000 {
>> -		compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
>> -			     "simple-mfd";
>> -		reg = <0x8a20000 0x1000>;
>> -		#address-cells = <1>;
>> -		#size-cells = <1>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
>> new file mode 100644
>> index 000000000000000..4e547017e368393
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon Hi3798CV200 Peripheral Controller
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  The Hi3798CV200 Peripheral Controller controls peripherals, queries
>> +  their status, and configures some functions of peripherals.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: hisilicon,hi3798cv200-perictrl
>> +      - const: syscon
>> +      - const: simple-mfd
>> +
>> +  reg:
>> +    description: Register address and size
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 1
> 
> That implies child nodes. You need some sort of schema for them.

OK, I will drop #address-cells and #size-cells in this binding.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    perictrl: peripheral-controller@8a20000 {
>> +        compatible = "hisilicon,hi3798cv200-perictrl", "syscon", "simple-mfd";
>> +        reg = <0x8a20000 0x1000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +    };
>> +...
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

