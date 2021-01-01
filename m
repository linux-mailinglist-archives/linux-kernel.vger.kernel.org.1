Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5112E82DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 04:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbhAADJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 22:09:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9664 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbhAADJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 22:09:47 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D6VMc07wHz15h91;
        Fri,  1 Jan 2021 11:08:12 +0800 (CST)
Received: from [10.174.184.196] (10.174.184.196) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 1 Jan 2021 11:08:55 +0800
Subject: Re: [PATCH RFC] KVM: arm64: vgic: Decouple the check of the
 EnableLPIs bit from the ITS LPI translation
To:     Marc Zyngier <maz@kernel.org>
CC:     Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20201231062813.714-1-lushenming@huawei.com>
 <683134bdea8a22d3bb784117dcfe17a1@kernel.org>
 <cf530279-4c68-c7de-f87e-1236ce0241cf@huawei.com>
 <85dd45f580eaa7a0b8ec91ac0b7ca066@kernel.org>
From:   Shenming Lu <lushenming@huawei.com>
Message-ID: <032ab609-0602-a3d6-5877-489e583ba0a8@huawei.com>
Date:   Fri, 1 Jan 2021 11:08:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <85dd45f580eaa7a0b8ec91ac0b7ca066@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.184.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/31 20:22, Marc Zyngier wrote:
> On 2020-12-31 11:58, Shenming Lu wrote:
>> On 2020/12/31 16:57, Marc Zyngier wrote:
>>> Hi Shemming,
>>>
>>> On 2020-12-31 06:28, Shenming Lu wrote:
>>>> When the EnableLPIs bit is set to 0, any ITS LPI requests in the
>>>> Redistributor would be ignored. And this check is independent from
>>>> the ITS LPI translation. So it might be better to move the check
>>>> of the EnableLPIs bit out of the LPI resolving, and also add it
>>>> to the path that uses the translation cache.
>>>
>>> But by doing that, you are moving the overhead of checking for
>>> EnableLPIs from the slow path (translation walk) to the fast
>>> path (cache hit), which seems counter-productive.
>>
>> Oh, I didn't notice the overhead of the checking, I thought it would
>> be negligible...
> 
> It probably doesn't show on a modern box, but some of the slower
> systems might see it. Overall, this is a design decision to keep
> the translation cache as simple and straightforward as possible:
> if anything affects the output of the cache, we invalidate it,
> and that's it.

Ok, get it.

> 
>>
>>>
>>>> Besides it seems that
>>>> by this the invalidating of the translation cache caused by the LPI
>>>> disabling is unnecessary.
>>>>
>>>> Not sure if I have missed something... Thanks.
>>>
>>> I am certainly missing the purpose of this patch.
>>>
>>> The effect of EnableLPIs being zero is to drop the result of any
>>> translation (a new pending bit) on the floor. Given that, it is
>>> immaterial whether this causes a new translation or hits in the
>>> cache, as the result is still to not pend a new interrupt.
>>>
>>> I get the feeling that you are trying to optimise for the unusual
>>> case where EnableLPIs is 0 *and* you have a screaming device
>>> injecting tons of interrupt. If that is the case, I don't think
>>> this is worth it.
>>
>> In fact, I just found (imagining) that if the EnableLPIs bit is 0,
>> the kvm_vgic_v4_set_forwarding() would fail when performing the LPI
>> translation, but indeed we don't try to pend any interrupts there...
>>
>> By the way, it seems that the LPI disabling would not affect the
>> injection of VLPIs...
> 
> Yes, good point. We could unmap the VPE from all ITS, which would result
> in all translations to be discarded, but this has the really bad side
> effect of *also* preventing the delivery of vSGIs, which isn't what
> you'd expect.
> 
> Overall, I don't think there is a good way to support this, and maybe
> we should just prevent EnableLPIs to be turned off when using direct
> injection. After all, the architecture does allow that for GICv3
> implementations, which is what we emulate.

Agreed, if there is no good way, we could just make the EnableLPIs clearing
unsupported...

Thanks(Happy 2021),
Shenming

> 
> Thanks,
> 
>         M.
