Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68A882F4B60
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbhAMMej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:34:39 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10721 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbhAMMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:34:39 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DG6KK0HRMzl4cq;
        Wed, 13 Jan 2021 20:32:37 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 13 Jan 2021
 20:33:47 +0800
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: hisilicon: Add binding for L3
 cache controller
To:     Arnd Bergmann <arnd@kernel.org>
CC:     devicetree <devicetree@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20210112015602.497-1-thunder.leizhen@huawei.com>
 <20210112015602.497-3-thunder.leizhen@huawei.com>
 <CAK8P3a0VcLtOrvXKEd2dDuP8HhKzU+uB0U6OiJXtefQQYjTheg@mail.gmail.com>
 <a11515e2-1fc6-be7d-f50c-8e3ad20f9e6c@huawei.com>
 <CAK8P3a1jcg3CEP0QhtTP4gES9MHLdrHPZffkSxtxbr78FScrrg@mail.gmail.com>
 <f563115c-4461-eee0-ee8d-1fd8f4dbbe63@huawei.com>
 <82720d56-733d-28e9-b682-bcc769ad70ab@huawei.com>
 <CAK8P3a15VnJUWsxhZqPY8dYdCHqswErPJJo+iieJfc7Yc06sJg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <244468d6-2f02-cf3f-0dfb-453de6647969@huawei.com>
Date:   Wed, 13 Jan 2021 20:33:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a15VnJUWsxhZqPY8dYdCHqswErPJJo+iieJfc7Yc06sJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/13 19:15, Arnd Bergmann wrote:
> On Wed, Jan 13, 2021 at 9:13 AM Leizhen (ThunderTown)
> <thunder.leizhen@huawei.com> wrote:
>> On 2021/1/13 15:44, Leizhen (ThunderTown) wrote:
>>> On 2021/1/12 21:55, Arnd Bergmann wrote:
>>>> On Tue, Jan 12, 2021 at 1:35 PM Leizhen (ThunderTown)
>>>> <thunder.leizhen@huawei.com> wrote:
>>>>> On 2021/1/12 16:46, Arnd Bergmann wrote:
>>>>>> On Tue, Jan 12, 2021 at 2:56 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>>>
>>>>>>> +---
>>>>>>> +$id: http://devicetree.org/schemas/arm/hisilicon/l3cache.yaml#
>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>> +
>>>>>>> +title: Hisilicon L3 cache controller
>>>>>>> +
>>>>>>> +maintainers:
>>>>>>> +  - Wei Xu <xuwei5@hisilicon.com>
>>>>>>> +
>>>>>>> +description: |
>>>>>>> +  The Hisilicon L3 outer cache controller supports a maximum of 36-bit physical
>>>>>>> +  addresses. The data cached in the L3 outer cache can be operated based on the
>>>>>>> +  physical address range or the entire cache.
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    items:
>>>>>>> +      - const: hisilicon,l3cache
>>>>>>> +
>>>>>>
>>>>>> The compatible string needs to be a little more specific, I'm sure
>>>>>> you cannot guarantee that this is the only L3 cache controller ever
>>>>>> designed in the past or future by HiSilicon.
>>>>>>
>>>>>> Normally when you have an IP block that is itself unnamed but that is specific
>>>>>> to one or a few SoCs but that has no na, the convention is to include the name
>>>>>> of the first SoC that contained it.
>>>>>
>>>>> Right, thanks for your suggestion, I will rename it to "hisilicon,hi1381-l3cache"
>>>>> and "hisilicon,hi1215-l3cache".
>>>
>>> Sorry, Just received a response from the hardware developers, the SoC names need to
>>> be changed:
>>> hi1381 --> kunpeng509
>>> hi1215 --> kunpeng506
>>>
>>> So I want to rename the compatible string to "hisilicon,kunpeng-l3v1", Kunpeng L3
>>
>> I thought about it. Let's name it "hisilicon,kunpeng-l3cache", and then add v2 in
>> the future. Maybe the SoC name is changed later, and v2 is not required.
> 
> I would prefer the more specific name to be listed as well. You can
> use the generic
> "hisilicon,kunpeng-l3cache" as the key that the driver uses, but
> please also include
> the chip specific one here.

Oh, yes. Sometimes, the "syscon" is used this way . The first string describes
the component information，and the second string is used to match the driver.

compatible = "hisilicon,kunpeng506-l3cache", "hisilicon,kunpeng-l3cache"


> We tend to use the chip identifiers
> (hi1381, ...), but if
> the marketing names (kunpeng509, ...) are now what they are known as in the

The hardware developers told me that hi1381 is the internal chip identifier,
and should be deprecated. kunpeng509 is both chip identifier and marketing name.

Kunpeng is the pinyin of two Chinese characters. They are two mythical animals.

> data sheet, then use that. The problem with marketing names is that they are
> more often unrelated to the technology underneath. It's possible that there
> might be e.g. kunpeng507 chip that sold to the same customers but very different
> internally from kunpeng506/kunpeng509. This also happens with the chip numbers,

It shouldn't make a big difference，unless the first two numbers are different.

> but those tend to be more stable (at least for other manufacturers).
> 
>        Arnd
> 
> .
> 

