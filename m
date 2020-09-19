Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6815D2709CF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 04:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgISCCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 22:02:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726009AbgISCCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 22:02:23 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D84F1914A9015C7DD5F5;
        Sat, 19 Sep 2020 10:02:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 19 Sep 2020
 10:02:12 +0800
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
 <4873e234-d06c-930e-6645-a832164e18ea@huawei.com>
 <0928ac6a-2295-4e87-5191-4fd4580f87b5@huawei.com>
 <CAL_JsqK3635vQGK+mw+GKz5Sj2YKEt6+sj8MNo0d3hFESbfUKw@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <1c5f44ba-7093-9828-c9d7-186dbd7f6892@huawei.com>
Date:   Sat, 19 Sep 2020 10:02:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqK3635vQGK+mw+GKz5Sj2YKEt6+sj8MNo0d3hFESbfUKw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/19 2:55, Rob Herring wrote:
> On Wed, Sep 16, 2020 at 9:30 PM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>>
>>
>>
>> On 2020/9/15 14:12, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2020/9/15 4:31, Rob Herring wrote:
>>>> On Thu, Sep 03, 2020 at 08:05:03PM +0800, Zhen Lei wrote:
>>>>> Add DT bindings for the Hisilicon SD5203 vector interrupt controller.
>>>>>
>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>> ---
>>>>>  .../hisilicon,sd5203-vic.txt                  | 27 +++++++++++++++++++
>>>>
>>>> Bindings should be in DT schema format now.
>>
>> Do I need to change the existing "snps,dw-apb-ictl.txt" to DT schema format?
> 
> That would be nice, but not necessary for minor changes.

I had done it before you replied to me. Can you check it out?

https://www.spinics.net/lists/devicetree/msg378632.html

> 
> Rob
> 
> .
> 

