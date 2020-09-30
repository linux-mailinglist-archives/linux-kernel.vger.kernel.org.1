Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4527E27A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgI3HVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:21:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14742 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbgI3HVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:21:22 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 110B451DC318BD008111;
        Wed, 30 Sep 2020 15:21:20 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 15:21:13 +0800
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
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <3045a295-928a-eae6-c887-e34446a170e0@huawei.com>
Date:   Wed, 30 Sep 2020 15:21:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200930071110.GH6148@dell>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/30 15:11, Lee Jones wrote:
> On Wed, 30 Sep 2020, Zhen Lei wrote:
> 
>> Add some compatible strings for Hisilicon controllers:
>> hisilicon,hi6220-sramctrl  --> Hi6220 SRAM controller
>> hisilicon,pcie-sas-subctrl --> HiP05/HiP06 PCIe-SAS subsystem controller
>> hisilicon,peri-subctrl     --> HiP05/HiP06 PERI subsystem controller
>> hisilicon,dsa-subctrl      --> HiP05/HiP06 DSA subsystem controller
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/syscon.yaml | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> This was already applied by the time you re-sent it.
> 
> Any reason for sending it again?

Path 15 are modified. The Document patches except Patch 15 are applied,
but the config/DTS patches are not applied(They are applied after I re-sent).

> 

