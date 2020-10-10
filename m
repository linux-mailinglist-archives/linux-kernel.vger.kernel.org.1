Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F26A28A01B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 13:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgJJK61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 06:58:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15203 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729361AbgJJK0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:26:30 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C5BB9DBF3FB1A7289762;
        Sat, 10 Oct 2020 18:07:17 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Sat, 10 Oct 2020
 18:07:08 +0800
Subject: Re: [PATCH v6 14/17] dt-bindings: arm: hisilicon: convert
 hisilicon,hip04-bootwrapper bindings to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-15-thunder.leizhen@huawei.com>
 <20201001064156.GF3018@kozik-lap>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <c912d2ee-c3cf-df85-4c10-f97ad8d9dcc2@huawei.com>
Date:   Sat, 10 Oct 2020 18:07:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201001064156.GF3018@kozik-lap>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/1 14:41, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2020 at 11:17:09AM +0800, Zhen Lei wrote:
>> Convert the Hisilicon Bootwrapper boot method binding to DT schema format
>> using json-schema.
>>
>> The property boot-method contains two groups of physical address range
>> information: bootwrapper and relocation. The "uint32-array" type is not
>> suitable for it, because the field "address" and "size" may occupy one or
>> two cells respectively. Use "minItems: 1" and "maxItems: 2" to allow it
>> can be written in "<addr size addr size>" or "<addr size>, <addr size>"
>> format.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../hisilicon/controller/hip04-bootwrapper.yaml    | 34 ++++++++++++++++++++++
>>  .../controller/hisilicon,hip04-bootwrapper.txt     |  9 ------
>>  2 files changed, 34 insertions(+), 9 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
>> new file mode 100644
>> index 000000000000000..7378159e61df998
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hip04-bootwrapper.yaml
>> @@ -0,0 +1,34 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hip04-bootwrapper.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bootwrapper boot method
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: Bootwrapper boot method (software protocol on SMP)
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: hisilicon,hip04-bootwrapper
>> +
>> +  boot-method:
>> +    description: |
>> +      Address and size of boot method.
>> +      [0]: bootwrapper physical address
>> +      [1]: bootwrapper size
>> +      [2]: relocation physical address
>> +      [3]: relocation size
> 
> Intead: items with each item description (bootwrapper address,
> relocation address). This way also min/max Items should not be needed.

I think it's needed. "reg" also specifies maxItems.

> 
> Best regards,
> Krzysztof
> 
> 
>> +    minItems: 1
>> +    maxItems: 2
>> +
> 
> .
> 

