Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE7228A444
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbgJJWxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:53:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731308AbgJJTIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:08:17 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C63C1A7FBBDFF02DE59F;
        Sat, 10 Oct 2020 18:56:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Sat, 10 Oct 2020
 18:56:41 +0800
Subject: Re: [PATCH v6 16/17] dt-bindings: arm: hisilicon: convert
 hisilicon,hi3798cv200-perictrl bindings to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-17-thunder.leizhen@huawei.com>
 <20201001063517.GC3018@kozik-lap>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <8c6b5b55-967c-f582-9781-dd8cf0034dee@huawei.com>
Date:   Sat, 10 Oct 2020 18:56:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201001063517.GC3018@kozik-lap>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/1 14:35, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2020 at 11:17:11AM +0800, Zhen Lei wrote:
>> Convert the Hisilicon Hi3798CV200 Peripheral Controller binding to DT
>> schema format using json-schema.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../hisilicon/controller/hi3798cv200-perictrl.yaml | 64 ++++++++++++++++++++++
>>  .../controller/hisilicon,hi3798cv200-perictrl.txt  | 21 -------
>>  2 files changed, 64 insertions(+), 21 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
>> new file mode 100644
>> index 000000000000000..cba1937aad9a8d3
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hi3798cv200-perictrl.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hi3798cv200-perictrl.yaml#
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
>> +    maxItems: 1
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  ranges: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#address-cells"
>> +  - "#size-cells"
>> +  - ranges
>> +
>> +additionalProperties:
>> +  type: object
> 
> You need to describe all additional properties or objects.

OK, I will do it in v5.11

> 
> Best regards,
> Krzysztof
> 
> .
> 

