Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D41E967A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 11:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgEaJLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 05:11:31 -0400
Received: from foss.arm.com ([217.140.110.172]:56038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEaJLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:11:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18F591045;
        Sun, 31 May 2020 02:11:30 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58C973F52E;
        Sun, 31 May 2020 02:11:29 -0700 (PDT)
Subject: Re: [PATCH RFC] KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset
 when S2FWB is supported
To:     Marc Zyngier <maz@kernel.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200415072835.1164-1-yuzenghui@huawei.com>
 <e99bc07d-0dd4-055c-808f-fd9cde88d2fc@arm.com>
 <a1a1961a-2eae-b26c-e607-ab5c0c929f37@arm.com>
 <13db879dff56d091f98f7c5416ab1535@kernel.org>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <ff9e2eb5-cbc4-b831-bc59-d194c966d04e@arm.com>
Date:   Sun, 31 May 2020 10:12:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <13db879dff56d091f98f7c5416ab1535@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 5/30/20 5:31 PM, Marc Zyngier wrote:
> Hi Alex,
>
> On 2020-05-30 11:46, Alexandru Elisei wrote:
>> Hi,
>
> [...]
>
>>>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>>>> index 48d0ec44ad77..e6378162cdef 100644
>>>> --- a/virt/kvm/arm/arm.c
>>>> +++ b/virt/kvm/arm/arm.c
>>>> @@ -983,8 +983,11 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu
>>>> *vcpu,
>>>>      /*
>>>>       * Ensure a rebooted VM will fault in RAM pages and detect if the
>>>>       * guest MMU is turned off and flush the caches as needed.
>>>> +     *
>>>> +     * S2FWB enforces all memory accesses to RAM being cacheable, we
>>>> +     * ensure that the cache is always coherent.
>>>>       */
>>>> -    if (vcpu->arch.has_run_once)
>>>> +    if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>>> I think userspace does not invalidate the icache when loading a new kernel image,
>>> and if the guest patched instructions, they could potentially still be in the
>>> icache. Should the icache be invalidated if FWB is present?
>>
>> I noticed that this was included in the current pull request and I
>> remembered that
>> I wasn't sure about this part. Did some more digging and it turns out that FWB
>> implies no cache maintenance needed for *data to instruction*
>> coherence. From ARM
>> DDI 0487F.b, page D5-2635:
>>
>> "When ARMv8.4-S2FWB is implemented, the architecture requires that
>> CLIDR_EL1.{LOUU, LOIUS} are zero so that no levels of data cache need to be
>> cleaned in order to manage coherency with instruction fetches".
>>
>> However, there's no mention that I found for instruction to data coherence,
>> meaning that the icache would still need to be invalidated on each vcpu in order
>> to prevent fetching of patched instructions from the icache. Am I
>> missing something?
>
> I think you are right, and this definitely matches the way we deal with
> the icache on the fault path. For some bizarre reason, I always assume
> that FWB implies DIC, which isn't true at all.
>
> I'm planning to address it as follows. Please let me know what you think.
>
> Thanks,
>
>         M.
>
> From f7860d1d284f41afea176cc17e5c9d895ae665e9 Mon Sep 17 00:00:00 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Sat, 30 May 2020 17:22:19 +0100
> Subject: [PATCH] KVM: arm64: Flush the instruction cache if not unmapping the
>  VM on reboot
>
> On a system with FWB, we don't need to unmap Stage-2 on reboot,
> as even if userspace takes this opportunity to repaint the whole
> of memory, FWB ensures that the data side stays consistent even
> if the guest uses non-cacheable mappings.
>
> However, the I-side is not necessarily coherent with the D-side
> if CTR_EL0.DIC is 0. In this case, invalidate the i-cache to
> preserve coherency.
>
> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Fixes: 892713e97ca1 ("KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset when
> S2FWB is supported")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kvm/arm.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index b0b569f2cdd0..d6988401c22a 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -989,11 +989,17 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu
> *vcpu,
>       * Ensure a rebooted VM will fault in RAM pages and detect if the
>       * guest MMU is turned off and flush the caches as needed.
>       *
> -     * S2FWB enforces all memory accesses to RAM being cacheable, we
> -     * ensure that the cache is always coherent.
> +     * S2FWB enforces all memory accesses to RAM being cacheable,
> +     * ensuring that the data side is always coherent. We still
> +     * need to invalidate the I-cache though, as FWB does *not*
> +     * imply CTR_EL0.DIC.
>       */
> -    if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
> -        stage2_unmap_vm(vcpu->kvm);
> +    if (vcpu->arch.has_run_once) {
> +        if (!cpus_have_final_cap(ARM64_HAS_STAGE2_FWB))
> +            stage2_unmap_vm(vcpu->kvm);
> +        else
> +            __flush_icache_all();
> +    }
>
>      vcpu_reset_hcr(vcpu);
>
>
Looks good, __flush_icache_all checks CTR_EL0.DIC before doing icache maintenance:

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

