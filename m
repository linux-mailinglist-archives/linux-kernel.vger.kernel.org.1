Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F7D2E7FCD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 13:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLaL7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 06:59:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10014 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLaL7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 06:59:46 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D669c1H9Mzj1r4;
        Thu, 31 Dec 2020 19:58:12 +0800 (CST)
Received: from [10.174.184.196] (10.174.184.196) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Thu, 31 Dec 2020 19:58:53 +0800
Subject: Re: [PATCH RFC] KVM: arm64: vgic: Decouple the check of the
 EnableLPIs bit from the ITS LPI translation
To:     Marc Zyngier <maz@kernel.org>
CC:     Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>
References: <20201231062813.714-1-lushenming@huawei.com>
 <683134bdea8a22d3bb784117dcfe17a1@kernel.org>
From:   Shenming Lu <lushenming@huawei.com>
Message-ID: <cf530279-4c68-c7de-f87e-1236ce0241cf@huawei.com>
Date:   Thu, 31 Dec 2020 19:58:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <683134bdea8a22d3bb784117dcfe17a1@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.184.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/31 16:57, Marc Zyngier wrote:
> Hi Shemming,
> 
> On 2020-12-31 06:28, Shenming Lu wrote:
>> When the EnableLPIs bit is set to 0, any ITS LPI requests in the
>> Redistributor would be ignored. And this check is independent from
>> the ITS LPI translation. So it might be better to move the check
>> of the EnableLPIs bit out of the LPI resolving, and also add it
>> to the path that uses the translation cache.
> 
> But by doing that, you are moving the overhead of checking for
> EnableLPIs from the slow path (translation walk) to the fast
> path (cache hit), which seems counter-productive.

Oh, I didn't notice the overhead of the checking, I thought it would
be negligible...

> 
>> Besides it seems that
>> by this the invalidating of the translation cache caused by the LPI
>> disabling is unnecessary.
>>
>> Not sure if I have missed something... Thanks.
> 
> I am certainly missing the purpose of this patch.
> 
> The effect of EnableLPIs being zero is to drop the result of any
> translation (a new pending bit) on the floor. Given that, it is
> immaterial whether this causes a new translation or hits in the
> cache, as the result is still to not pend a new interrupt.
> 
> I get the feeling that you are trying to optimise for the unusual
> case where EnableLPIs is 0 *and* you have a screaming device
> injecting tons of interrupt. If that is the case, I don't think
> this is worth it.

In fact, I just found (imagining) that if the EnableLPIs bit is 0,
the kvm_vgic_v4_set_forwarding() would fail when performing the LPI
translation, but indeed we don't try to pend any interrupts there...

By the way, it seems that the LPI disabling would not affect the
injection of VLPIs...

Thanks,
Shenming

> 
> Thanks,
> 
>         M.
> 
>>
>> Signed-off-by: Shenming Lu <lushenming@huawei.com>
>> ---
>>  arch/arm64/kvm/vgic/vgic-its.c     | 9 +++++----
>>  arch/arm64/kvm/vgic/vgic-mmio-v3.c | 4 +---
>>  2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
>> index 40cbaca81333..f53446bc154e 100644
>> --- a/arch/arm64/kvm/vgic/vgic-its.c
>> +++ b/arch/arm64/kvm/vgic/vgic-its.c
>> @@ -683,9 +683,6 @@ int vgic_its_resolve_lpi(struct kvm *kvm, struct
>> vgic_its *its,
>>      if (!vcpu)
>>          return E_ITS_INT_UNMAPPED_INTERRUPT;
>>
>> -    if (!vcpu->arch.vgic_cpu.lpis_enabled)
>> -        return -EBUSY;
>> -
>>      vgic_its_cache_translation(kvm, its, devid, eventid, ite->irq);
>>
>>      *irq = ite->irq;
>> @@ -738,6 +735,9 @@ static int vgic_its_trigger_msi(struct kvm *kvm,
>> struct vgic_its *its,
>>      if (err)
>>          return err;
>>
>> +    if (!irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
>> +        return -EBUSY;
>> +
>>      if (irq->hw)
>>          return irq_set_irqchip_state(irq->host_irq,
>>                           IRQCHIP_STATE_PENDING, true);
>> @@ -757,7 +757,8 @@ int vgic_its_inject_cached_translation(struct kvm
>> *kvm, struct kvm_msi *msi)
>>
>>      db = (u64)msi->address_hi << 32 | msi->address_lo;
>>      irq = vgic_its_check_cache(kvm, db, msi->devid, msi->data);
>> -    if (!irq)
>> +
>> +    if (!irq || !irq->target_vcpu->arch.vgic_cpu.lpis_enabled)
>>          return -EWOULDBLOCK;
>>
>>      raw_spin_lock_irqsave(&irq->irq_lock, flags);
>> diff --git a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> index 15a6c98ee92f..7b0749f7660d 100644
>> --- a/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> +++ b/arch/arm64/kvm/vgic/vgic-mmio-v3.c
>> @@ -242,10 +242,8 @@ static void vgic_mmio_write_v3r_ctlr(struct kvm_vcpu *vcpu,
>>
>>      vgic_cpu->lpis_enabled = val & GICR_CTLR_ENABLE_LPIS;
>>
>> -    if (was_enabled && !vgic_cpu->lpis_enabled) {
>> +    if (was_enabled && !vgic_cpu->lpis_enabled)
>>          vgic_flush_pending_lpis(vcpu);
>> -        vgic_its_invalidate_cache(vcpu->kvm);
>> -    }
>>
>>      if (!was_enabled && vgic_cpu->lpis_enabled)
>>          vgic_enable_lpis(vcpu);
> 
