Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0172B8167
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgKRQBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 11:01:33 -0500
Received: from foss.arm.com ([217.140.110.172]:58194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726829AbgKRQBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:01:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34F7B1396;
        Wed, 18 Nov 2020 08:01:31 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7793B3F7BB;
        Wed, 18 Nov 2020 08:01:28 -0800 (PST)
Subject: Re: [PATCH v4 2/2] arm64: kvm: Introduce MTE VCPU feature
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
References: <20201026155727.36685-1-steven.price@arm.com>
 <20201026155727.36685-3-steven.price@arm.com>
 <8507a92b4ba3bbc45814b7197bd4e2fb@kernel.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <d6b2f135-9c5e-8ad9-aedb-60ad897e9bb0@arm.com>
Date:   Wed, 18 Nov 2020 16:01:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8507a92b4ba3bbc45814b7197bd4e2fb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2020 19:35, Marc Zyngier wrote:
> Hi Steven,
> 
> On 2020-10-26 15:57, Steven Price wrote:
>> Add a new VM feature 'KVM_ARM_CAP_MTE' which enables memory tagging
>> for a VM. This exposes the feature to the guest and automatically tags
>> memory pages touched by the VM as PG_mte_tagged (and clears the tags
>> storage) to ensure that the guest cannot see stale tags, and so that the
>> tags are correctly saved/restored across swap.
>>
>> Signed-off-by: Steven Price <steven.price@arm.com>
>> Reviewed-by: Andrew Jones <drjones@redhat.com>
>> ---
>>  arch/arm64/include/asm/kvm_emulate.h |  3 +++
>>  arch/arm64/include/asm/kvm_host.h    |  3 +++
>>  arch/arm64/kvm/arm.c                 |  9 +++++++++
>>  arch/arm64/kvm/mmu.c                 | 20 ++++++++++++++++++++
>>  arch/arm64/kvm/sys_regs.c            |  6 +++++-
>>  include/uapi/linux/kvm.h             |  1 +
>>  6 files changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h
>> b/arch/arm64/include/asm/kvm_emulate.h
>> index 5ef2669ccd6c..66c0d9e7c2b4 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -79,6 +79,9 @@ static inline void vcpu_reset_hcr(struct kvm_vcpu 
>> *vcpu)
>>      if (cpus_have_const_cap(ARM64_MISMATCHED_CACHE_TYPE) ||
>>          vcpu_el1_is_32bit(vcpu))
>>          vcpu->arch.hcr_el2 |= HCR_TID2;
>> +
>> +    if (vcpu->kvm->arch.mte_enabled)
> 
> Please add a predicate (vcpu_has_mte() or kvm_has_mte()?) for this.

Sure

>> +        vcpu->arch.hcr_el2 |= HCR_ATA;
>>  }
>>
>>  static inline unsigned long *vcpu_hcr(struct kvm_vcpu *vcpu)
>> diff --git a/arch/arm64/include/asm/kvm_host.h
>> b/arch/arm64/include/asm/kvm_host.h
>> index 95ab7345dcc8..cd993aec0440 100644
>> --- a/arch/arm64/include/asm/kvm_host.h
>> +++ b/arch/arm64/include/asm/kvm_host.h
>> @@ -118,6 +118,9 @@ struct kvm_arch {
>>       */
>>      unsigned long *pmu_filter;
>>      unsigned int pmuver;
>> +
>> +    /* Memory Tagging Extension enabled for the guest */
>> +    bool mte_enabled;
>>  };
>>
>>  struct kvm_vcpu_fault_info {
>> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
>> index f56122eedffc..7ee93bcac017 100644
>> --- a/arch/arm64/kvm/arm.c
>> +++ b/arch/arm64/kvm/arm.c
>> @@ -89,6 +89,12 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>>          r = 0;
>>          kvm->arch.return_nisv_io_abort_to_user = true;
>>          break;
>> +    case KVM_CAP_ARM_MTE:
>> +        if (!system_supports_mte() || kvm->created_vcpus)
>> +            return -EINVAL;
> 
> You also want to avoid 32bit guests. Also, what is the rational for

Interesting point, however if I understand correctly the 32 bit flag is 
a VCPU flag. And at this point kvm->created_vcpus==0, so I don't believe 
we actually know whether the guest is 32 bit or not at the point of this 
test. And since this is a per-VM flag it actually can make sense for a 
heterogeneous VM if anyone is crazy enough to want such a thing.

> this being a VM capability as opposed to a CPU feature, similar
> to SVE and PMU?

v1/v2 actually had it as a CPU feature. However you need a per-VM flag 
to enforce the use of tagged memory (the code in user_mem_abort() below).

>> +        r = 0;
>> +        kvm->arch.mte_enabled = true;
>> +        break;
>>      default:
>>          r = -EINVAL;
>>          break;
>> @@ -210,6 +216,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, 
>> long ext)
>>           */
>>          r = 1;
>>          break;
>> +    case KVM_CAP_ARM_MTE:
>> +        r = system_supports_mte();
> 
> Same comment about 32bit.

As above, we don't know if we're launching a 32 bit guest or not.

>> +        break;
>>      case KVM_CAP_STEAL_TIME:
>>          r = kvm_arm_pvtime_supported();
>>          break;
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 19aacc7d64de..38fe25310ca1 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -862,6 +862,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu,
>> phys_addr_t fault_ipa,
>>      if (vma_pagesize == PAGE_SIZE && !force_pte)
>>          vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>                                 &pfn, &fault_ipa);
>> +
>> +    /*
>> +     * The otherwise redundant test for system_supports_mte() allows the
>> +     * code to be compiled out when CONFIG_ARM64_MTE is not present.
>> +     */
>> +    if (system_supports_mte() && kvm->arch.mte_enabled && 
>> pfn_valid(pfn)) {
>> +        /*
>> +         * VM will be able to see the page's tags, so we must ensure
>> +         * they have been initialised.
>> +         */
>> +        struct page *page = pfn_to_page(pfn);
>> +        long i, nr_pages = compound_nr(page);
>> +
>> +        /* if PG_mte_tagged is set, tags have already been 
>> initialised */
>> +        for (i = 0; i < nr_pages; i++, page++) {
>> +            if (!test_and_set_bit(PG_mte_tagged, &page->flags))
>> +                mte_clear_page_tags(page_address(page));
>> +        }
>> +    }
> 
> What are the visibility requirements for the tags, specially if the
> guest has its MMU off? Is there any cache management that needs to
> occur?

If the guest has its MMU off then the memory would be tread as Untagged 
by the architecture (the stage 1 page table must provide the 'tagged' 
flag). Architecturally the tag bits handled the same as the data bits so 
no extra/different cache management is required. The only exception in 
the architecture is that the tag values are optionally exposed in the 
normal PA space (in a potentially non-coherent way) - but if that is the 
case that PA space shouldn't be touched by Linux.

> Another thing is device-like memory that is managed by userspace,
> such as the QEMU emulated flash, for which there also might be tags.
> How is that dealt with? In general, what are the expectations for
> tags on memory shared between host and guest? Who owns them?

Actual device-like memory shouldn't be expected to have tags - they 
wouldn't have tags on a real host.

In terms of memory shared between host and guest - the tags are also 
shared, effectively tags are just data. Clearly the host and guest need 
to decide how to share the tag space. In general I would expect the tags 
to be ignored (and tag checking to be disabled) in those shared regions. 
Sadly the architecture doesn't provide a method to prevent the guest 
accessing tags in a region (without also crippling cacheability).

This is one of the areas that is potentially tricky for migration 
because the VMM may want to use MTE but must disable tag checking while 
touching the guest's memory because the guest may be using the tag 
memory for it's own purposes. There is some discussion about this in the 
cover letter of v2:

https://lore.kernel.org/kvmarm/20200904160018.29481-1-steven.price@arm.com/
Thanks,

Steve

>> +
>>      if (writable) {
>>          prot |= KVM_PGTABLE_PROT_W;
>>          kvm_set_pfn_dirty(pfn);
>> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
>> index 430e36e1a13d..35a3dc448231 100644
>> --- a/arch/arm64/kvm/sys_regs.c
>> +++ b/arch/arm64/kvm/sys_regs.c
>> @@ -1132,7 +1132,8 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>>              arm64_get_spectre_v2_state() == SPECTRE_UNAFFECTED)
>>              val |= (1UL << ID_AA64PFR0_CSV2_SHIFT);
>>      } else if (id == SYS_ID_AA64PFR1_EL1) {
>> -        val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>> +        if (!vcpu->kvm->arch.mte_enabled)
>> +            val &= ~(0xfUL << ID_AA64PFR1_MTE_SHIFT);
>>      } else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>>          val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
>>               (0xfUL << ID_AA64ISAR1_API_SHIFT) |
>> @@ -1394,6 +1395,9 @@ static bool access_mte_regs(struct kvm_vcpu
>> *vcpu, struct sys_reg_params *p,
>>  static unsigned int mte_visibility(const struct kvm_vcpu *vcpu,
>>                     const struct sys_reg_desc *rd)
>>  {
>> +    if (vcpu->kvm->arch.mte_enabled)
>> +        return 0;
>> +
>>      return REG_HIDDEN_USER | REG_HIDDEN_GUEST;
>>  }
>>
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index ca41220b40b8..3e6fb5b580a9 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -1053,6 +1053,7 @@ struct kvm_ppc_resize_hpt {
>>  #define KVM_CAP_X86_USER_SPACE_MSR 188
>>  #define KVM_CAP_X86_MSR_FILTER 189
>>  #define KVM_CAP_ENFORCE_PV_FEATURE_CPUID 190
>> +#define KVM_CAP_ARM_MTE 191
>>
>>  #ifdef KVM_CAP_IRQ_ROUTING
> 
> Thanks,
> 
>          M.

