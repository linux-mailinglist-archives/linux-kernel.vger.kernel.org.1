Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9ED276741
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 05:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgIXD1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 23:27:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14268 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbgIXD1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 23:27:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 42232317F7D5E91447CD;
        Thu, 24 Sep 2020 11:27:32 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 24 Sep 2020
 11:27:25 +0800
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: hisilicon: add binding for
 SD5203 SoC
To:     Rob Herring <robh@kernel.org>
CC:     Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200919064555.3616-1-thunder.leizhen@huawei.com>
 <20200919064555.3616-2-thunder.leizhen@huawei.com>
 <20200923205905.GA1296543@bogus>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <76a3d247-d3e4-bd8c-2c4e-252908024cb0@huawei.com>
Date:   Thu, 24 Sep 2020 11:27:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200923205905.GA1296543@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/24 4:59, Rob Herring wrote:
> On Sat, Sep 19, 2020 at 02:45:52PM +0800, Zhen Lei wrote:
>> Add devicetree binding for Hisilicon SD5203 SoC.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt | 5 +++++
>>  1 file changed, 5 insertions(+)
> 
> Please convert this to DT schema format first.

OK, I will do it.

> 
>>
>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> index a97f643e7d1c760..5d80070bfb13fc0 100644
>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>> @@ -56,6 +56,11 @@ HiP07 D05 Board
>>  Required root node properties:
>>  	- compatible = "hisilicon,hip07-d05";
>>  
>> +SD5203 SoC
>> +Required root node properties:
>> +	- compatible = "hisilicon,sd5203";
>> +
>> +
>>  Hisilicon system controller
>>  
>>  Required properties:
>> -- 
>> 1.8.3
>>
>>
> 
> .
> 

