Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C2026D0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgIQBy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:54:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12801 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgIQByW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:54:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4C4479FA31C5FF9D6CFA;
        Thu, 17 Sep 2020 09:38:32 +0800 (CST)
Received: from [127.0.0.1] (10.74.185.4) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 17 Sep 2020
 09:38:22 +0800
Subject: Re: [PATCH v2] KVM: arm64: fix doc warnings in mmu code
To:     Will Deacon <will@kernel.org>
References: <1600221639-4471-1-git-send-email-tanxiaofei@huawei.com>
 <20200916083756.GD27496@willie-the-truck>
CC:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <5F62BE0E.9060208@huawei.com>
Date:   Thu, 17 Sep 2020 09:38:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20200916083756.GD27496@willie-the-truck>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.185.4]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Will,

Thanks for your advices, will accept all of them.

On 2020/9/16 16:37, Will Deacon wrote:
> On Wed, Sep 16, 2020 at 10:00:39AM +0800, Xiaofei Tan wrote:
>> Fix following warnings caused by mismatch bewteen function parameters
>> and comments.
>> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'mmu' not described in '__unmap_stage2_range'
>> arch/arm64/kvm/mmu.c:128: warning: Function parameter or member 'may_block' not described in '__unmap_stage2_range'
>> arch/arm64/kvm/mmu.c:128: warning: Excess function parameter 'kvm' description in '__unmap_stage2_range'
>> arch/arm64/kvm/mmu.c:499: warning: Function parameter or member 'writable' not described in 'kvm_phys_addr_ioremap'
>> arch/arm64/kvm/mmu.c:538: warning: Function parameter or member 'mmu' not described in 'stage2_wp_range'
>> arch/arm64/kvm/mmu.c:538: warning: Excess function parameter 'kvm' description in 'stage2_wp_range'
>>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>  arch/arm64/kvm/mmu.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index e8a51799..909e995 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -114,9 +114,10 @@ static bool kvm_is_device_pfn(unsigned long pfn)
>>   */
>>  /**
>>   * unmap_stage2_range -- Clear stage2 page table entries to unmap a range
>> - * @kvm:   The VM pointer
>> + * @mmu:   pointer to mmu structure to operate on
>>   * @start: The intermediate physical base address of the range to unmap
>>   * @size:  The size of the area to unmap
>> + * @may_block: The flag that if block is allowed here
> 
> Whether or not we are permitted to block.
> 
>>   *
>>   * Clear a range of stage-2 mappings, lowering the various ref-counts.  Must
>>   * be called while holding mmu_lock (unless for freeing the stage2 pgd before
>> @@ -493,6 +494,7 @@ void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu)
>>   * @guest_ipa:	The IPA at which to insert the mapping
>>   * @pa:		The physical address of the device
>>   * @size:	The size of the mapping
>> + * @writable:   If it is writable here
> 
> Whether or not to create a writable mapping.
> 
>>   */
>>  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>  			  phys_addr_t pa, unsigned long size, bool writable)
>> @@ -530,7 +532,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>>  
>>  /**
>>   * stage2_wp_range() - write protect stage2 memory region range
>> - * @kvm:	The KVM pointer
>> + * @mmu:        pointer to mmu structure to operate on
> 
> The KVM stage-2 MMU pointer.
> 
> Will
> 
> .
> 

-- 
 thanks
tanxiaofei

