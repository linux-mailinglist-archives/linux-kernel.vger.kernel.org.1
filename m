Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CBB269E3F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgIOGMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:12:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbgIOGMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:12:36 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 344B0E86A9033D05D8CC;
        Tue, 15 Sep 2020 14:12:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 14:12:22 +0800
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: add Hisilicon
 SD5203 vector interrupt controller
To:     Rob Herring <robh@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200903120504.2308-1-thunder.leizhen@huawei.com>
 <20200903120504.2308-2-thunder.leizhen@huawei.com>
 <20200914203110.GA185427@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4873e234-d06c-930e-6645-a832164e18ea@huawei.com>
Date:   Tue, 15 Sep 2020 14:12:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200914203110.GA185427@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/15 4:31, Rob Herring wrote:
> On Thu, Sep 03, 2020 at 08:05:03PM +0800, Zhen Lei wrote:
>> Add DT bindings for the Hisilicon SD5203 vector interrupt controller.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  .../hisilicon,sd5203-vic.txt                  | 27 +++++++++++++++++++
> 
> Bindings should be in DT schema format now.

Hi, Rob Herring:

As Marc Zyngier's suggestion, I discarded adding an independent SD5203-VIC
driver, but make the dw-apb-ictl irqchip driver to support hierarchy irq domain.
So this new file was also dropped. Now, I updated the descriptions in the existing
file "snps,dw-apb-ictl.txt" in the following versions.

> 
>>  1 file changed, 27 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
>> new file mode 100644
>> index 000000000000..a08292e868b0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/hisilicon,sd5203-vic.txt
>> @@ -0,0 +1,27 @@
>> +Hisilicon SD5203 vector interrupt controller (VIC)
>> +
>> +Hisilicon SD5203 VIC based on Synopsys DesignWare APB interrupt controller, but
>> +there's something special:
>> +1. The maximum number of irqs supported is 32. The registers ENABLE, MASK and
>> +   FINALSTATUS are 32 bits.
>> +2. There is only one VIC, it's used as primary interrupt controller.
>> +
>> +Required properties:
>> +- compatible: shall be "hisilicon,sd5203-vic"
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region starting with ENABLE_LOW register
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #interrupt-cells: number of cells to encode an interrupt-specifier, shall be 1
>> +
>> +The interrupt sources map to the corresponding bits in the interrupt
>> +registers, i.e.
>> +- 0 maps to bit 0 of low interrupts,
>> +- 1 maps to bit 1 of low interrupts,
>> +
>> +Example:
>> +	vic: interrupt-controller@10130000 {
>> +		compatible = "hisilicon,sd5203-vic";
>> +		reg = <0x10130000 0x1000>;
>> +		interrupt-controller;
>> +		#interrupt-cells = <1>;
>> +	};
>> -- 
>> 2.26.0.106.g9fadedd
>>
>>
> 
> .
> 

