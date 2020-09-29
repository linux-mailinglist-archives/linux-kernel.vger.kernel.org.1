Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3858B27BB44
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgI2DF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:05:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58390 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbgI2DF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:05:59 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E66DA94227C7F1786525;
        Tue, 29 Sep 2020 11:05:57 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 11:05:50 +0800
Subject: Re: [PATCH v4 03/20] dt-bindings: arm: hisilicon: add binding for
 SD5203 SoC
To:     Rob Herring <robh@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-4-thunder.leizhen@huawei.com>
 <20200928190748.GA3090434@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f8e79802-eb6b-9af1-2be1-7e830dec5a6b@huawei.com>
Date:   Tue, 29 Sep 2020 11:05:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200928190748.GA3090434@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/29 3:07, Rob Herring wrote:
> On Mon, Sep 28, 2020 at 11:13:07PM +0800, Zhen Lei wrote:
>> Add devicetree binding for Hisilicon SD5203 SoC.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
>> index 6d17309c7c84308..3337eebc61da812 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.yaml
>> @@ -59,4 +59,8 @@ properties:
>>        - description: HiP07 D05 Board
>>          items:
>>            - const: hisilicon,hip07-d05
>> +
>> +      - description: SD5203 Board
> 
> This should be a board compatible and then a SoC compatible.

OK, I will fix it.

> 
>> +        items:
>> +          - const: hisilicon,sd5203
>>  ...
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

