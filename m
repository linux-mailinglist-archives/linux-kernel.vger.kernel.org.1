Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBCB28A00F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 12:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgJJKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 06:37:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728877AbgJJKUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 06:20:06 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F995A09A6775A450419;
        Sat, 10 Oct 2020 18:01:24 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.134) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 10 Oct 2020
 18:01:16 +0800
Subject: Re: [PATCH v6 01/17] dt-bindings: mfd: syscon: add some compatible
 strings for Hisilicon
To:     Lee Jones <lee.jones@linaro.org>
CC:     devicetree <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20200930031712.2365-1-thunder.leizhen@huawei.com>
 <20200930031712.2365-2-thunder.leizhen@huawei.com>
 <20200930071110.GH6148@dell>
 <3045a295-928a-eae6-c887-e34446a170e0@huawei.com>
 <20201001065917.GJ6148@dell>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <e2fb074b-7a83-ac4c-9941-ca6ade12bd29@huawei.com>
Date:   Sat, 10 Oct 2020 18:01:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201001065917.GJ6148@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/1 14:59, Lee Jones wrote:
> On Wed, 30 Sep 2020, Leizhen (ThunderTown) wrote:
> 
>>
>>
>> On 2020/9/30 15:11, Lee Jones wrote:
>>> On Wed, 30 Sep 2020, Zhen Lei wrote:
>>>
>>>> Add some compatible strings for Hisilicon controllers:
>>>> hisilicon,hi6220-sramctrl  --> Hi6220 SRAM controller
>>>> hisilicon,pcie-sas-subctrl --> HiP05/HiP06 PCIe-SAS subsystem controller
>>>> hisilicon,peri-subctrl     --> HiP05/HiP06 PERI subsystem controller
>>>> hisilicon,dsa-subctrl      --> HiP05/HiP06 DSA subsystem controller
>>>>
>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>> ---
>>>>  Documentation/devicetree/bindings/mfd/syscon.yaml | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> This was already applied by the time you re-sent it.
>>>
>>> Any reason for sending it again?
>>
>> Path 15 are modified. The Document patches except Patch 15 are applied,
>> but the config/DTS patches are not applied(They are applied after I re-sent).
> 
> Could you please only send patches which have not been applied.

No experience. I'll pay attention next time.

> 

