Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC782F5D66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbhANJ2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:28:52 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2353 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbhANJ2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:28:50 -0500
Received: from dggeme709-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4DGf802hKGz13hBP;
        Thu, 14 Jan 2021 17:26:24 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme709-chm.china.huawei.com (10.1.199.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 14 Jan 2021 17:28:04 +0800
Subject: Re: [PATCH v2 3/3] KVM: arm64: Mark the page dirty only if the fault
 is handled successfully
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
        <zhukeqian1@huawei.com>, <yuzenghui@huawei.com>
References: <20201216122844.25092-1-wangyanan55@huawei.com>
 <20201216122844.25092-4-wangyanan55@huawei.com>
 <20210113155101.GB11892@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <6cd9c7ba-cb73-bb77-3cfc-e06b204a76d9@huawei.com>
Date:   Thu, 14 Jan 2021 17:28:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210113155101.GB11892@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme702-chm.china.huawei.com (10.1.199.98) To
 dggeme709-chm.china.huawei.com (10.1.199.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/1/13 23:51, Will Deacon wrote:
> On Wed, Dec 16, 2020 at 08:28:44PM +0800, Yanan Wang wrote:
>> We now mark the page dirty and set the bitmap before calling fault handlers
>> in user_mem_abort(), and we might end up having spurious dirty pages if
>> update of permissions or mapping has failed.
>> So, mark the page dirty only if the fault is handled successfully.
>>
>> Let the guest directly enter again but not return to userspace if we were
>> trying to recreate the same mapping or only change access permissions
>> with BBM, which is not permitted in the mapping path.
>>
>> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
>> ---
>>   arch/arm64/kvm/mmu.c | 18 ++++++++++++++----
>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
>> index 75814a02d189..72e516a10914 100644
>> --- a/arch/arm64/kvm/mmu.c
>> +++ b/arch/arm64/kvm/mmu.c
>> @@ -879,11 +879,8 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   	if (vma_pagesize == PAGE_SIZE && !force_pte)
>>   		vma_pagesize = transparent_hugepage_adjust(memslot, hva,
>>   							   &pfn, &fault_ipa);
>> -	if (writable) {
>> +	if (writable)
>>   		prot |= KVM_PGTABLE_PROT_W;
>> -		kvm_set_pfn_dirty(pfn);
>> -		mark_page_dirty(kvm, gfn);
>> -	}
>>   
>>   	if (fault_status != FSC_PERM && !device)
>>   		clean_dcache_guest_page(pfn, vma_pagesize);
>> @@ -911,6 +908,19 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>>   					     memcache);
>>   	}
>>   
>> +	/* Mark the page dirty only if the fault is handled successfully */
>> +	if (writable && !ret) {
>> +		kvm_set_pfn_dirty(pfn);
>> +		mark_page_dirty(kvm, gfn);
>> +	}
>> +
>> +	/* Let the guest directly enter again if we were trying to recreate the
>> +	 * same mapping or only change access permissions with BBM, which is not
>> +	 * permitted in the mapping path.
>> +	 */
>> +	if (ret == -EAGAIN)
>> +		ret = 0;
> Maybe just 'return ret != -EAGAIN ? ret : 0;' at the end of the function?
Yes, it's more concise.
