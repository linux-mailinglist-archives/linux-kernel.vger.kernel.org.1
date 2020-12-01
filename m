Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E4D2CA566
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgLAORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:17:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbgLAORU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:17:20 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0D9E20757;
        Tue,  1 Dec 2020 14:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606832199;
        bh=S4mifvOBTJLwCTBries4quwNTSN6z4tytYzuRciZLok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggLbsDS7NOCGU07E+ajv8QZVMSCibGpTkIDXfh4qUbW2DQUkepaEikpFcnxKD4Flm
         0XTMJs7jovGnVwDYZ6TiqapztwAmntWR0fJtNkGNy1fe+WXWv8VEgBE6zvlFSEObF1
         h36GmhSJGIXHVUsbYvF566yQaHWd6L0dhOwrqqX0=
Date:   Tue, 1 Dec 2020 14:16:33 +0000
From:   Will Deacon <will@kernel.org>
To:     "wangyanan (Y)" <wangyanan55@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Gavin Shan <gshan@redhat.com>,
        Quentin Perret <qperret@google.com>,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        zhukeqian1@huawei.com, yuzenghui@huawei.com,
        jiangkunkun@huawei.com, wangjingyi11@huawei.com,
        lushenming@huawei.com
Subject: Re: [RFC PATCH 1/3] KVM: arm64: Fix possible memory leak in kvm
 stage2
Message-ID: <20201201141632.GC26973@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-2-wangyanan55@huawei.com>
 <20201130132133.GA24837@willie-the-truck>
 <ef8f51d6-365b-8b05-0a10-5b4a242f6aa3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef8f51d6-365b-8b05-0a10-5b4a242f6aa3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 03:21:23PM +0800, wangyanan (Y) wrote:
> On 2020/11/30 21:21, Will Deacon wrote:
> > On Mon, Nov 30, 2020 at 08:18:45PM +0800, Yanan Wang wrote:
> > > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > > index 0271b4a3b9fe..696b6aa83faf 100644
> > > --- a/arch/arm64/kvm/hyp/pgtable.c
> > > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > > @@ -186,6 +186,7 @@ static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
> > >   		return old == pte;
> > >   	smp_store_release(ptep, pte);
> > > +	get_page(virt_to_page(ptep));
> > This is also used for the hypervisor stage-1 page-table, so I'd prefer to
> > leave this function as-is.
> I agree at this point.
> > >   	return true;
> > >   }
> > > @@ -476,6 +477,7 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
> > >   	/* There's an existing valid leaf entry, so perform break-before-make */
> > >   	kvm_set_invalid_pte(ptep);
> > >   	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
> > > +	put_page(virt_to_page(ptep));
> > >   	kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
> > >   out:
> > >   	data->phys += granule;
> > Isn't this hunk alone sufficient to solve the problem?
> > 
> > Will
> > .
> 
> Not sufficient enough. When the old ptep is valid and old pte equlas new
> pte, in this case, "True" is also returned by kvm_set_valid_leaf_pte()
> 
> and get_page() will still be called.

I had a go at fixing this without introducing refcounting to the hyp stage-1
case, and ended up with the diff below. What do you think?

Will

--->8

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0271b4a3b9fe..78e2c0dc47ae 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -170,23 +170,16 @@ static void kvm_set_table_pte(kvm_pte_t *ptep, kvm_pte_t *childp)
 	smp_store_release(ptep, pte);
 }
 
-static bool kvm_set_valid_leaf_pte(kvm_pte_t *ptep, u64 pa, kvm_pte_t attr,
-				   u32 level)
+static kvm_pte_t kvm_init_valid_leaf_pte(u64 pa, kvm_pte_t attr, u32 level)
 {
-	kvm_pte_t old = *ptep, pte = kvm_phys_to_pte(pa);
+	kvm_pte_t pte = kvm_phys_to_pte(pa);
 	u64 type = (level == KVM_PGTABLE_MAX_LEVELS - 1) ? KVM_PTE_TYPE_PAGE :
 							   KVM_PTE_TYPE_BLOCK;
 
 	pte |= attr & (KVM_PTE_LEAF_ATTR_LO | KVM_PTE_LEAF_ATTR_HI);
 	pte |= FIELD_PREP(KVM_PTE_TYPE, type);
 	pte |= KVM_PTE_VALID;
-
-	/* Tolerate KVM recreating the exact same mapping. */
-	if (kvm_pte_valid(old))
-		return old == pte;
-
-	smp_store_release(ptep, pte);
-	return true;
+	return pte;
 }
 
 static int kvm_pgtable_visitor_cb(struct kvm_pgtable_walk_data *data, u64 addr,
@@ -341,12 +334,17 @@ static int hyp_map_set_prot_attr(enum kvm_pgtable_prot prot,
 static bool hyp_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				    kvm_pte_t *ptep, struct hyp_map_data *data)
 {
+	kvm_pte_t new, old = *ptep;
 	u64 granule = kvm_granule_size(level), phys = data->phys;
 
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	WARN_ON(!kvm_set_valid_leaf_pte(ptep, phys, data->attr, level));
+	/* Tolerate KVM recreating the exact same mapping. */
+	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
+	if (old != new && !WARN_ON(kvm_pte_valid(old)))
+		smp_store_release(ptep, new);
+
 	data->phys += granule;
 	return true;
 }
@@ -465,19 +463,24 @@ static bool stage2_map_walker_try_leaf(u64 addr, u64 end, u32 level,
 				       kvm_pte_t *ptep,
 				       struct stage2_map_data *data)
 {
+	kvm_pte_t new, old = *ptep;
 	u64 granule = kvm_granule_size(level), phys = data->phys;
 
 	if (!kvm_block_mapping_supported(addr, end, phys, level))
 		return false;
 
-	if (kvm_set_valid_leaf_pte(ptep, phys, data->attr, level))
-		goto out;
+	new = kvm_init_valid_leaf_pte(phys, data->attr, level);
+	if (kvm_pte_valid(old)) {
+		/*
+		 * There's an existing valid leaf entry, so perform
+		 * break-before-make.
+		 */
+		kvm_set_invalid_pte(ptep);
+		kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
+		put_page(virt_to_page(ptep));
+	}
 
-	/* There's an existing valid leaf entry, so perform break-before-make */
-	kvm_set_invalid_pte(ptep);
-	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
-	kvm_set_valid_leaf_pte(ptep, phys, data->attr, level);
-out:
+	smp_store_release(ptep, new);
 	data->phys += granule;
 	return true;
 }
