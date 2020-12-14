Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD5F2D939C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 08:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438972AbgLNHV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 02:21:57 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2477 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438937AbgLNHVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 02:21:41 -0500
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4CvXpv1Phzz53MJ;
        Mon, 14 Dec 2020 15:20:23 +0800 (CST)
Received: from [10.174.187.128] (10.174.187.128) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 14 Dec 2020 15:20:56 +0800
Subject: Re: [RFC PATCH] KVM: arm64: Add prejudgement for relaxing permissions
 only case in stage2 translation fault handler
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
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
References: <20201211080115.21460-1-wangyanan55@huawei.com>
 <20201211080115.21460-2-wangyanan55@huawei.com>
 <8d006755e5afce7e49b03993316c4fcc@kernel.org>
 <20201211100026.GA11352@willie-the-truck>
From:   "wangyanan (Y)" <wangyanan55@huawei.com>
Message-ID: <2ab9323a-40a1-d223-f692-0a19207e16a9@huawei.com>
Date:   Mon, 14 Dec 2020 15:20:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201211100026.GA11352@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.187.128]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will, Marc,

On 2020/12/11 18:00, Will Deacon wrote:
> On Fri, Dec 11, 2020 at 09:49:28AM +0000, Marc Zyngier wrote:
>> On 2020-12-11 08:01, Yanan Wang wrote:
>>> @@ -461,25 +462,56 @@ static int stage2_map_set_prot_attr(enum
>>> kvm_pgtable_prot prot,
>>>   	return 0;
>>>   }
>>>
>>> +static bool stage2_set_valid_leaf_pte_pre(u64 addr, u32 level,
>>> +					  kvm_pte_t *ptep, kvm_pte_t new,
>>> +					  struct stage2_map_data *data)
>>> +{
>>> +	kvm_pte_t old = *ptep, old_attr, new_attr;
>>> +
>>> +	if ((old ^ new) & (~KVM_PTE_LEAF_ATTR_PERMS))
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * Skip updating if we are trying to recreate exactly the same mapping
>>> +	 * or to reduce the access permissions only. And update the valid leaf
>>> +	 * PTE without break-before-make if we are trying to add more access
>>> +	 * permissions only.
>>> +	 */
>>> +	old_attr = (old & KVM_PTE_LEAF_ATTR_PERMS) ^
>>> KVM_PTE_LEAF_ATTR_HI_S2_XN;
>>> +	new_attr = (new & KVM_PTE_LEAF_ATTR_PERMS) ^
>>> KVM_PTE_LEAF_ATTR_HI_S2_XN;
>>> +	if (new_attr <= old_attr)
>>> +		return true;
>>> +
>>> +	WRITE_ONCE(*ptep, new);
>>> +	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
>> I think what bothers me the most here is that we are turning a mapping into
>> a permission update, which makes the code really hard to read, and mixes
>> two things that were so far separate.
>>
>> I wonder whether we should instead abort the update and simply take the
>> fault
>> again, if we ever need to do it.
> That's a nice idea. If we could enforce that we don't alter permissions on
> the map path, and instead just return e.g. -EAGAIN then that would be a
> very neat solution and would cement the permission vs translation fault
> division.

I agree with that we can indeed simplify the code, separate 
permission-relaxing and

mapping by the *straightly return* way, although the cost is one more 
vCPU trap on

permission fault next time possibly.

So how about the new two diffs below? I split them into two patches with 
different aims.

Thanks,

Yanan.


diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 23a01dfcb27a..a74a62283012 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -170,10 +170,9 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, 
kvm_pte_t *childp)
         smp_store_release(ptep, pte);
  }

-static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
-                                  u32 level)
+static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
  {
-       kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(pa);
+       kvm_pte_t pte = kvm_phys_to_pte(pa);
         u64 type = (level == KVM_PGTABLE_MAX_LEVELS - 1) ? 
KVM_PTE_TYPE_PAGE :
KVM_PTE_TYPE_BLOCK;

@@ -181,12 +180,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, 
u64 pa, kvm_pte_t attr,
         pte |= FIELD_PREP(KVM_PTE_TYPE, type);
         pte |= KVM_PTE_VALID;

-       /* Tolerate KVM recreating the exact same mapping. */
-       if (kvm_pte_valid(old))
-               return old == pte;
-
-       smp_store_release(ptep, pte);
-       return true;
+       return pte;
  }

  static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, 
u64 addr,
@@ -341,12 +335,17 @@ static int hyp_map_set_prot_attr(enum 
kvm_pgtable_prot prot,
  static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
                                     kvm_pte_t *ptep, struct 
hyp_map_data *data)
  {
+       kvm_pte_t new, old = *ptep;
         u64 granule = kvm_granule_size(level), phys = data->phys;

         if (!kvm_block_mapping_supported(addr, end, phys, level))
                 return false;

-       WARN_ON(!kvm_set_valid_leaf_pte(ptep, phys, data->attr, level));
+       /* Tolerate KVM recreating the exact same mapping. */
+       new = kvm_init_valid_leaf_pte(phys, data->attr, level);
+       if (old != new && !WARN_ON(kvm_pte_valid(old)))
+               smp_store_release(ptep, new);
+
         data->phys += granule;
         return true;
  }
@@ -465,21 +464,29 @@ static bool stage2_map_walker_try_leaf(u64 addr, 
u64 end, u32 level,
                                        kvm_pte_t *ptep,
                                        struct stage2_map_data *data)
  {
+       kvm_pte_t new, old = *ptep;
         u64 granule = kvm_granule_size(level), phys = data->phys;
+       struct page *page = virt_to_page(ptep);

         if (!kvm_block_mapping_supported(addr, end, phys, level))
                 return false;

-       if (kvm_pte_valid(*ptep))
-               put_page(virt_to_page(ptep));
+       new = kvm_init_valid_leaf_pte(phys, data->attr, level);
+       if (kvm_pte_valid(old)) {
+               /* Tolerate KVM recreating the exact same mapping. */
+               if (old == new)
+                       goto out;

-       if (kvm_set_valid_leaf_pte(ptep, phys, data->attr, level))
-               goto out;
+               /* There's an existing different valid leaf entry, so 
perform
+                * break-before-make.
+                */
+               kvm_set_invalid_pte(ptep);
+               kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, 
level);
+               put_page(page);
+       }

-       /* There's an existing valid leaf entry, so perform 
break-before-make */
-       kvm_set_invalid_pte(ptep);
-       kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
-       kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
+       smp_store_release(ptep, new);
+       get_page(page);
  out:
         data->phys += granule;
         return true;
@@ -521,7 +528,7 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, 
u32 level, kvm_pte_t *ptep,
         }

         if (stage2_map_walker_try_leaf(addr, end, level, ptep, data))
-               goto out_get_page;
+               return 0;

         if (WARN_ON(level == KVM_PGTABLE_MAX_LEVELS - 1))
                 return -EINVAL;
@@ -545,9 +552,8 @@ static int stage2_map_walk_leaf(u64 addr, u64 end, 
u32 level, kvm_pte_t *ptep,
         }

         kvm_set_table_pte(ptep, childp);
-
-out_get_page:
         get_page(page);
+
         return 0;
  }


diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index a74a62283012..e3c6133567c4 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -45,6 +45,10 @@

  #define KVM_PTE_LEAF_ATTR_HI_S2_XN     BIT(54)

+#define KVM_PTE_LEAF_ATTR_S2_PERMS (KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
+        KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
+ KVM_PTE_LEAF_ATTR_HI_S2_XN)
+
  struct kvm_pgtable_walk_data {
         struct kvm_pgtable                   *pgt;
         struct kvm_pgtable_walker       *walker;
@@ -473,8 +477,13 @@ static bool stage2_map_walker_try_leaf(u64 addr, 
u64 end, u32 level,

         new = kvm_init_valid_leaf_pte(phys, data->attr, level);
         if (kvm_pte_valid(old)) {
-               /* Tolerate KVM recreating the exact same mapping. */
-               if (old == new)
+               /*
+                * Skip updating the PTE with break-before-make if we 
are trying
+                * to recreate the exact same mapping or only change the 
access
+                * permissions. Actually, change of permissions will be 
handled
+                * through the relax_perms path next time if necessary.
+                */
+               if (!((old ^ new) & (~KVM_PTE_LEAF_ATTR_S2_PERMS)))
                         goto out;

                 /* There's an existing different valid leaf entry, so 
perform



