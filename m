Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5582C9761
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 07:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgLAGFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 01:05:06 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2386 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgLAGFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 01:05:05 -0500
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ClWkW0TyDz4yHX;
        Tue,  1 Dec 2020 14:03:47 +0800 (CST)
Received: from [10.174.186.123] (10.174.186.123) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Dec 2020 14:04:18 +0800
Subject: Re: [RFC PATCH 3/3] KVM: arm64: Add usage of stage 2 fault lookup
 level in user_mem_abort()
To:     Will Deacon <will@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>,
        <jiangkunkun@huawei.com>, <wangjingyi11@huawei.com>,
        <lushenming@huawei.com>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-4-wangyanan55@huawei.com>
 <20201130134913.GC24837@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <a508c1cd-45af-5b53-7754-92334fe95c47@huawei.com>
Date:   Tue, 1 Dec 2020 14:04:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201130134913.GC24837@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.186.123]
X-ClientProxiedBy: dggeme716-chm.china.huawei.com (10.1.199.112) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020/11/30 21:49, Will Deacon wrote:
> On Mon, Nov 30, 2020 at 08:18:47PM +0800, Yanan Wang wrote:
>> If we get a FSC_PERM fault, just using (logging_active && writable) to determine
>> calling kvm_pgtable_stage2_map(). There will be two more cases we should consider.
>>
>> (1) After logging_active is configged back to false from true. When we get a
>> FSC_PERM fault with write_fault and adjustment of hugepage is needed, we should
>> merge tables back to a block entry. This case is ignored by still calling
>> kvm_pgtable_stage2_relax_perms(), which will lead to an endless loop and guest
>> panic due to soft lockup.
>>
>> (2) We use (FSC_PERM && logging_active && writable) to determine collapsing
>> a block entry into a table by calling kvm_pgtable_stage2_map(). But sometimes
>> we may only need to relax permissions when trying to write to a page other than
>> a block. In this condition, using kvm_pgtable_stage2_relax_perms() will be fine.
>>
>> The ISS filed bit[1:0] in ESR_EL2 regesiter indicates the stage2 lookup level
>> at which a D-abort or I-abort occured. By comparing granule of the fault lookup
>> level with vma_pagesize, we can strictly distinguish conditions of calling
>> kvm_pgtable_stage2_relax_perms() or kvm_pgtable_stage2_map(), and the above
>> two cases will be well considered.
>>
>> Suggested-by: Keqian Zhu <zhukeqian1@huawei.com>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/include/asm/esr.h         |  1 +
>>   arch/arm64/include/asm/kvm_emulate.h |  5 +++++
>>   arch/arm64/kvm/mmu.c                 | 11 +++++++++--
>>   3 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
>> index 22c81f1edda2..85a3e49f92f4 100644
>> --- a/arch/arm64/include/asm/esr.h
>> +++ b/arch/arm64/include/asm/esr.h
>> @@ -104,6 +104,7 @@
>>   /* Shared ISS fault status code(IFSC/DFSC) for Data/Instruction aborts */
>>   #define ESR_ELx_FSC		(0x3F)
>>   #define ESR_ELx_FSC_TYPE	(0x3C)
>> +#define ESR_ELx_FSC_LEVEL	(0x03)
>>   #define ESR_ELx_FSC_EXTABT	(0x10)
>>   #define ESR_ELx_FSC_SERROR	(0x11)
>>   #define ESR_ELx_FSC_ACCESS	(0x08)
>> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
>> index 5ef2669ccd6c..2e0e8edf6306 100644
>> --- a/arch/arm64/include/asm/kvm_emulate.h
>> +++ b/arch/arm64/include/asm/kvm_emulate.h
>> @@ -350,6 +350,11 @@ static __always_inline u8 kvm_vcpu_trap_get_fault_type(const struct kvm_vcpu *vc
>>   	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_TYPE;
>>   }
>>   
>> +static __always_inline u8 kvm_vcpu_trap_get_fault_level(const struct kvm_vcpu *vcpu)
>> +{
>> +	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC_LEVEL;
>> +{
>> +
>>   static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
>>   {
>>   	switch (kvm_vcpu_trap_get_fault(vcpu)) {
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 1a01da9fdc99..75814a02d189 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -754,10 +754,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	gfn_t gfn;
>>   	kvm_pfn_t pfn;
>>   	bool logging_active = memslot_is_logging(memslot);
>> -	unsigned long vma_pagesize;
>> +	unsigned long fault_level = kvm_vcpu_trap_get_fault_level(vcpu);
>> +	unsigned long vma_pagesize, fault_granule;
>>   	enum kvm_pgtable_prot prot = KVM_PGTABLE_PROT_R;
>>   	struct kvm_pgtable *pgt;
>>   
>> +	fault_granule = 1UL << ARM64_HW_PGTABLE_LEVEL_SHIFT(fault_level);
> I like the idea, but is this macro reliable for stage-2 page-tables, given
> that we could have a concatenated pgd?
>
> Will
> .

Yes, it's fine even when we have a concatenated pgd table.

No matter a concatenated pgd will be made or not, the initial lookup 
level (start _level) is set in VTCR_EL2 register.

The MMU hardware walker will know the start_level according to 
information in VTCR_EL2.

This idea runs well in practice on host where ia_bits is 40, PAGE_SIZE 
is 4k, and a concatenated pgd is made for guest stage2.

According to the kernel info printed, the start_level is 1, and stage 2 
translation runs as expected.


Yanan

