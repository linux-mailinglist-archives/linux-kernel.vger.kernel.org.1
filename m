Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE052F2F39
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbhALMgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:36:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10652 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbhALMgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:36:42 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DFVQW1gZwz15s2n;
        Tue, 12 Jan 2021 20:34:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.498.0; Tue, 12 Jan 2021
 20:35:52 +0800
Subject: Re: [PATCH v3 2/3] dt-bindings: arm: hisilicon: Add binding for L3
 cache controller
To:     Arnd Bergmann <arnd@kernel.org>
CC:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210112015602.497-1-thunder.leizhen@huawei.com>
 <20210112015602.497-3-thunder.leizhen@huawei.com>
 <CAK8P3a0VcLtOrvXKEd2dDuP8HhKzU+uB0U6OiJXtefQQYjTheg@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <a11515e2-1fc6-be7d-f50c-8e3ad20f9e6c@huawei.com>
Date:   Tue, 12 Jan 2021 20:35:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0VcLtOrvXKEd2dDuP8HhKzU+uB0U6OiJXtefQQYjTheg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/12 16:46, Arnd Bergmann wrote:
> On Tue, Jan 12, 2021 at 2:56 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
> 
>> +---
>> +$id: http://devicetree.org/schemas/arm/hisilicon/l3cache.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hisilicon L3 cache controller
>> +
>> +maintainers:
>> +  - Wei Xu <xuwei5@hisilicon.com>
>> +
>> +description: |
>> +  The Hisilicon L3 outer cache controller supports a maximum of 36-bit physical
>> +  addresses. The data cached in the L3 outer cache can be operated based on the
>> +  physical address range or the entire cache.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: hisilicon,l3cache
>> +
> 
> The compatible string needs to be a little more specific, I'm sure
> you cannot guarantee that this is the only L3 cache controller ever
> designed in the past or future by HiSilicon.
> 
> Normally when you have an IP block that is itself unnamed but that is specific
> to one or a few SoCs but that has no na, the convention is to include the name
> of the first SoC that contained it.

Right, thanks for your suggestion, I will rename it to "hisilicon,hi1381-l3cache"
and "hisilicon,hi1215-l3cache".

> 
> Can you share which products actually use this L3 cache controller?

This L3 cache controller is used on Hi1381 and Hi1215 board. I don't know where
these two boards are used. Our company is too large. Software is delivered level
by level. I'm only involved in the Kernel-related part.

> 
> On a related note, what does the memory map look like on this chip?

memory@a00000 {
     device_type = "memory";
     reg = <0x0 0xa00000 0x0 0x1aa00000>, <0x1 0xe0000000 0x0 0x1d000000>, <0x0 0x1f400000 0x0 0xb5c00000>;
};

Currently, the DTS is being maintained by ourselves, I'll try to upstream it later.

> Do you support more than 4GB of total installed memory? If you

Currently, the total size does not exceed 4 GB. However, the physical address is wider than 32 bits.

> do, this becomes a problem in the future as highmem support
> winds down. In fact  anything more than 1GB on a 32-bit system
> requires more work on the kernel to be completed before we remove
> highmem, and will incur a slowdown. If the total is under 4GB but the
> memory is not in a contiguous physical address range. See my
> Linaro connect presentation[1] for further information on the topic.

Great.

> 
>        Arnd
> 
> [1] https://connect.linaro.org/resources/lvc20/lvc20-106/
> 
> .
> 

