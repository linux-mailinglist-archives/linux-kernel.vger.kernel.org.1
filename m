Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5890128A209
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388399AbgJJWxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:53:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731310AbgJJTIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:08:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5ABD8CCF04EED35C079F;
        Sat, 10 Oct 2020 18:54:43 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 10 Oct 2020
 18:54:35 +0800
Subject: Re: [PATCH v6 11/17] dt-bindings: arm: hisilicon: convert
 hisilicon,cpuctrl bindings to json-schema
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-12-thunder.leizhen@huawei.com>
 <20201001064008.GE3018@kozik-lap>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f4e4a1bb-7a1d-b9a3-58f0-8c52bfdd0801@huawei.com>
Date:   Sat, 10 Oct 2020 18:54:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201001064008.GE3018@kozik-lap>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/1 14:40, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2020 at 11:17:06AM +0800, Zhen Lei wrote:
>> Convert the Hisilicon CPU controller binding to DT schema format using
>> json-schema.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../bindings/arm/hisilicon/controller/cpuctrl.yaml | 29 ++++++++++++++++++++++
>>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |  8 ------
>>  2 files changed, 29 insertions(+), 8 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
>> new file mode 100644
>> index 000000000000000..f6a314db3a59416
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/cpuctrl.yaml
>> @@ -0,0 +1,29 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/cpuctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon CPU controller
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  The clock registers and power registers of secondary cores are defined
>> +  in CPU controller, especially in HIX5HD2 SoC.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: hisilicon,cpuctrl
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
> 
> Your own DTS file (arch/arm/boot/dts/hisi-x5hd2.dtsi) does not validate
> against this dtschema.

OK, I saw it. I just sent out a set of patches, to clean up all Hisilicon-related
errors detected by DT schema on arm32. Because many new YAML files are generated
this time, so I use the dtbs_check to check all the files at a times. The error
information did not contain the compatible string, So I didn't see it.

> 
> Best regards,
> Krzysztof
> 
> .
> 

