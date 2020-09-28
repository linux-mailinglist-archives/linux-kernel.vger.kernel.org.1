Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271C827AC80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1LQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:16:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14308 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgI1LQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:16:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0CE04475641B164B3636;
        Mon, 28 Sep 2020 19:16:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 28 Sep 2020
 19:16:14 +0800
Subject: Re: [PATCH v3 10/21] dt-bindings: arm: hisilicon: convert hisilicon,
 pcie-sas-subctrl bindings to json-schema
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Libin <huawei.libin@huawei.com>
References: <20200927062129.4573-1-thunder.leizhen@huawei.com>
 <20200927062129.4573-11-thunder.leizhen@huawei.com>
 <20200928104646.000073ce@Huawei.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <bb03bacc-49b8-5e61-ec7f-ee81eb253d4e@huawei.com>
Date:   Mon, 28 Sep 2020 19:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928104646.000073ce@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/28 17:46, Jonathan Cameron wrote:
> On Sun, 27 Sep 2020 14:21:18 +0800
> Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> Convert the Hisilicon HiP05/HiP06 PCIe-SAS subsystem controller binding
>> to DT schema format using json-schema.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> 
> One small thing inline to fix.
> 
> Jonathan
> 
>> ---
>>  .../controller/hisilicon,pcie-sas-subctrl.txt      | 15 ---------
>>  .../controller/hisilicon,pcie-sas-subctrl.yaml     | 37 ++++++++++++++++++++++
>>  2 files changed, 37 insertions(+), 15 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>> deleted file mode 100644
>> index 43efdaf408f6fe1..000000000000000
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -Hisilicon HiP05/HiP06 PCIe-SAS sub system controller
>> -
>> -Required properties:
>> -- compatible : "hisilicon,pcie-sas-subctrl", "syscon";
>> -- reg : Register address and size
>> -
>> -The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
>> -HiP05 or HiP06 Soc to implement some basic configurations.
>> -
>> -Example:
>> -	/* for HiP05 PCIe-SAS sub system */
>> -	pcie_sas: system_controller@b0000000 {
>> -		compatible = "hisilicon,pcie-sas-subctrl", "syscon";
>> -		reg = <0xb0000000 0x10000>;
>> -	};
>> \ No newline at end of file
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
>> new file mode 100644
>> index 000000000000000..8d1341022de587d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml
>> @@ -0,0 +1,37 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon HiP05/HiP06 PCIe-SAS subsystem controller
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  The PCIe-SAS sub system controller is shared by PCIe and SAS controllers in
>> +  HiP05 or HiP06 Soc to implement some basic configurations.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: hisilicon,pcie-sas-subctrl
>> +      - const: syscon
>> +
>> +  reg:
>> +    description: Register address and size
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +examples:
>> +  - |
>> +    /* for HiP05 PCIe-SAS sub system */
>> +    pcie_sas: system_controller@b0000000 {
>> +        compatible = "hisilicon,pcie-sas-subctrl", "syscon";
>> +        reg = <0xb0000000 0x10000>;
>> +    };
>> +...
>> \ No newline at end of file
> 
> Trivial, but fix that by adding one.

I think I can directly delete "\ No newline at end of file".
I looked at some files and all of them did not add blank lines at the end.
Whether there is a blank line at enf of file or not, the scripts/checkpatch
does not report any warning.

> 
> Jonathan
> 
> 
> 
> .
> 

