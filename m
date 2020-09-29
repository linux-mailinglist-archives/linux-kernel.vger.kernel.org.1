Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F46227BB41
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgI2DFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:05:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57908 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727350AbgI2DFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:05:32 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4B263599B2FDC8C3DDA8;
        Tue, 29 Sep 2020 11:05:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 11:05:19 +0800
Subject: Re: [PATCH v4 01/20] dt-bindings: arm: hisilicon: split the
 dt-bindings of each controller into a separate file
To:     Rob Herring <robh@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-2-thunder.leizhen@huawei.com>
 <20200928190528.GA3082719@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <70ddb558-ba4e-0f33-9bf0-90e21f3e6ec8@huawei.com>
Date:   Tue, 29 Sep 2020 11:05:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928190528.GA3082719@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/29 3:05, Rob Herring wrote:
> On Mon, Sep 28, 2020 at 11:13:05PM +0800, Zhen Lei wrote:
>> Split the devicetree bindings of each Hisilicon controller from
>> hisilicon.txt into a separate file, the file name is the compatible name
>> attach the .txt file name extension.
>>
>> All Hi6220 dedicated controllers are grouped into subdirectory "hi3620".
>> All HiPxx  dedicated controllers are grouped into subdirectory "hipxx"
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../arm/hisilicon/controller/hisilicon,cpuctrl.txt |   8 +
>>  .../hisilicon/controller/hisilicon,dsa-subctrl.txt |  15 ++
>>  .../controller/hisilicon,hi3798cv200-perictrl.txt  |  21 ++
>>  .../controller/hisilicon,hi6220-aoctrl.txt         |  18 ++
>>  .../controller/hisilicon,hi6220-mediactrl.txt      |  18 ++
>>  .../controller/hisilicon,hi6220-pmctrl.txt         |  18 ++
>>  .../controller/hisilicon,hi6220-sramctrl.txt       |  16 ++
>>  .../controller/hisilicon,hi6220-sysctrl.txt        |  19 ++
>>  .../controller/hisilicon,hip01-sysctrl.txt         |  19 ++
>>  .../controller/hisilicon,hip04-bootwrapper.txt     |   9 +
>>  .../controller/hisilicon,hip04-fabric.txt          |   5 +
>>  .../controller/hisilicon,pcie-sas-subctrl.txt      |  15 ++
>>  .../arm/hisilicon/controller/hisilicon,pctrl.txt   |  13 +
>>  .../controller/hisilicon,peri-subctrl.txt          |  16 ++
>>  .../arm/hisilicon/controller/hisilicon,sysctrl.txt |  25 ++
>>  .../bindings/arm/hisilicon/hisilicon.txt           | 262 ---------------------
>>  16 files changed, 235 insertions(+), 262 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-aoctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-mediactrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-pmctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sramctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi6220-sysctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip01-sysctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-bootwrapper.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hip04-fabric.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pcie-sas-subctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,pctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,peri-subctrl.txt
>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,sysctrl.txt
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>> new file mode 100644
>> index 000000000000000..ceffac537671668
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,cpuctrl.txt
>> @@ -0,0 +1,8 @@
>> +Hisilicon CPU controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,cpuctrl"
>> +- reg : Register address and size
>> +
>> +The clock registers and power registers of secondary cores are defined
>> +in CPU controller, especially in HIX5HD2 SoC.
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
>> new file mode 100644
>> index 000000000000000..4d1c6abf03f6f97
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,dsa-subctrl.txt
>> @@ -0,0 +1,15 @@
>> +Hisilicon HiP05/HiP06 DSA sub system controller
>> +
>> +Required properties:
>> +- compatible : "hisilicon,dsa-subctrl", "syscon";
> 
> This and others with only 'reg' can just be moved to syscon.yaml.

OK, I will do it.

> 
>> +- reg : Register address and size
>> +
>> +The DSA sub system controller is shared by peripheral controllers in
>> +HiP05 or HiP06 Soc to implement some basic configurations.
>> +
>> +Example:
>> +	/* for HiP05 dsa sub system */
>> +	pcie_sas: system_controller@a0000000 {
>> +		compatible = "hisilicon,dsa-subctrl", "syscon";
>> +		reg = <0xa0000000 0x10000>;
>> +	};

...

> 
> .
> 

