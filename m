Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3E91E9C03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 05:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgFADYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 23:24:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726218AbgFADYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 23:24:47 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B78B58EEB6B23FA263E9;
        Mon,  1 Jun 2020 11:24:44 +0800 (CST)
Received: from [10.173.222.27] (10.173.222.27) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 1 Jun 2020 11:24:37 +0800
Subject: Re: [PATCH RFC] KVM: arm64: Sidestep stage2_unmap_vm() on vcpu reset
 when S2FWB is supported
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <maz@kernel.org>
References: <20200415072835.1164-1-yuzenghui@huawei.com>
 <e99bc07d-0dd4-055c-808f-fd9cde88d2fc@arm.com>
 <a1a1961a-2eae-b26c-e607-ab5c0c929f37@arm.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4c5c76d6-7dc3-e598-76cd-602a3cdc2f26@huawei.com>
Date:   Mon, 1 Jun 2020 11:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a1a1961a-2eae-b26c-e607-ab5c0c929f37@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On 2020/5/30 18:46, Alexandru Elisei wrote:
> Hi,
> 
> On 4/20/20 5:10 PM, Alexandru Elisei wrote:

[ For some unknown reasons, I had missed your reply one month ago.
   Sorry, I'm going to fix my email settings ... ]

>> Hi,
>>
>> On 4/15/20 8:28 AM, Zenghui Yu wrote:
>>> stage2_unmap_vm() was introduced to unmap user RAM region in the stage2
>>> page table to make the caches coherent. E.g., a guest reboot with stage1
>>> MMU disabled will access memory using non-cacheable attributes. If the
>>> RAM and caches are not coherent at this stage, some evicted dirty cache
>>> line may go and corrupt guest data in RAM.
>>>
>>> Since ARMv8.4, S2FWB feature is mandatory and KVM will take advantage
>>> of it to configure the stage2 page table and the attributes of memory
>>> access. So we ensure that guests always access memory using cacheable
>>> attributes and thus, the caches always be coherent.
>>>
>>> So on CPUs that support S2FWB, we can safely reset the vcpu without a
>>> heavy stage2 unmapping.
>>>
>>> Cc: Marc Zyngier <maz@kernel.org>
>>> Cc: Christoffer Dall <christoffer.dall@arm.com>
>>> Cc: James Morse <james.morse@arm.com>
>>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>>> ---
>>>
>>> If this is correct, there should be a great performance improvement on
>>> a guest reboot (or reset) on systems support S2FWB. But I'm afraid that
>>> I've missed some points here, so please comment!
>>>
>>> The commit 957db105c997 ("arm/arm64: KVM: Introduce stage2_unmap_vm")
>>> was merged about six years ago and I failed to track its histroy and
>>> intention. Instead of a whole stage2 unmapping, something like
>>> stage2_flush_vm() looks enough to me. But again, I'm unsure...
>>>
>>> Thanks for having a look!
>> I had a chat with Christoffer about stage2_unmap_vm, and as I understood it, the
>> purpose was to make sure that any changes made by userspace were seen by the guest
>> while the MMU is off. When a stage 2 fault happens, we do clean+inval on the
>> dcache, or inval on the icache if it was an exec fault. This means that whatever
>> the host userspace writes while the guest is shut down and is still in the cache,
>> the guest will be able to read/execute.
>>
>> This can be relevant if the guest relocates the kernel and overwrites the original
>> image location, and userspace copies the original kernel image back in before
>> restarting the vm.

Yes, I-cache coherency is what I had missed! So without a S2 unmapping
on reboot, if there's any stale and "valid" cache line in the I-cache,
guest may fetch the wrong instructions directly from it, and bad things
will happen... (We will otherwise get a translation fault and a
permission fault and invalidate the I-cache as needed.)

>>
>>>   virt/kvm/arm/arm.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
>>> index 48d0ec44ad77..e6378162cdef 100644
>>> --- a/virt/kvm/arm/arm.c
>>> +++ b/virt/kvm/arm/arm.c
>>> @@ -983,8 +983,11 @@ static int kvm_arch_vcpu_ioctl_vcpu_init(struct kvm_vcpu *vcpu,
>>>   	/*
>>>   	 * Ensure a rebooted VM will fault in RAM pages and detect if the
>>>   	 * guest MMU is turned off and flush the caches as needed.
>>> +	 *
>>> +	 * S2FWB enforces all memory accesses to RAM being cacheable, we
>>> +	 * ensure that the cache is always coherent.
>>>   	 */
>>> -	if (vcpu->arch.has_run_once)
>>> +	if (vcpu->arch.has_run_once && !cpus_have_const_cap(ARM64_HAS_STAGE2_FWB))
>> I think userspace does not invalidate the icache when loading a new kernel image,
>> and if the guest patched instructions, they could potentially still be in the
>> icache. Should the icache be invalidated if FWB is present?
> 
> I noticed that this was included in the current pull request and I remembered that
> I wasn't sure about this part. Did some more digging and it turns out that FWB
> implies no cache maintenance needed for *data to instruction* coherence. From ARM
> DDI 0487F.b, page D5-2635:
> 
> "When ARMv8.4-S2FWB is implemented, the architecture requires that
> CLIDR_EL1.{LOUU, LOIUS} are zero so that no levels of data cache need to be
> cleaned in order to manage coherency with instruction fetches".
> 
> However, there's no mention that I found for instruction to data coherence,
> meaning that the icache would still need to be invalidated on each vcpu in order
> to prevent fetching of patched instructions from the icache. Am I missing something?

Thanks for the head up and Marc's fix!


Thanks both,
Zenghui
