Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDE2D7340
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 11:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394087AbgLKKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 05:01:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:37080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390706AbgLKKBO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 05:01:14 -0500
Date:   Fri, 11 Dec 2020 10:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607680833;
        bh=jFOIRQmF8QhbnoVrQUBYI2SL8ohUqFFx7/jNj606aGc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ECLlIotuaiZ4dGQjFw7VRauGeaiinR7H+nU6z0KrbpH1BBQDSMsprwcVPGqVVOamg
         u4DsAn+WXLS9N+hU83gF+q1RfVfyweBneFjKxqmfy6tP4joYToNhGHGTCE8PfY7SfA
         K0DZMBdeg+zFD0qsN+SZHHcvWrdNWvJvyN/EnHS2vv2VaYAQpr1dhYRbi2S14pEO3K
         NeFVSKA3vqhKAHMi0tIxXWJfvQa8Fjtk7k0NFgW7MQDdjlFGdWnOXFqsVby0Ku7bM7
         vYeonkGRRqXtleLB61ma3hN2rFcUoHcmfzCpLO625rb++tNZ6UFaSNjhjUijxxJcPd
         Tp1P2H6BQwIrg==
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Yanan Wang <wangyanan55@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
Subject: Re: [RFC PATCH] KVM: arm64: Add prejudgement for relaxing
 permissions only case in stage2 translation fault handler
Message-ID: <20201211100026.GA11352@willie-the-truck>
References: <20201211080115.21460-1-wangyanan55@huawei.com>
 <20201211080115.21460-2-wangyanan55@huawei.com>
 <8d006755e5afce7e49b03993316c4fcc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d006755e5afce7e49b03993316c4fcc@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 09:49:28AM +0000, Marc Zyngier wrote:
> On 2020-12-11 08:01, Yanan Wang wrote:
> > @@ -461,25 +462,56 @@ static int stage2_map_set_prot_attr(enum
> > kvm_pgtable_prot prot,
> >  	return 0;
> >  }
> > 
> > +static bool stage2_set_valid_leaf_pte_pre(u64 addr, u32 level,
> > +					  kvm_pte_t *ptep, kvm_pte_t new,
> > +					  struct stage2_map_data *data)
> > +{
> > +	kvm_pte_t old = *ptep, old_attr, new_attr;
> > +
> > +	if ((old ^ new) & (~KVM_PTE_LEAF_ATTR_PERMS))
> > +		return false;
> > +
> > +	/*
> > +	 * Skip updating if we are trying to recreate exactly the same mapping
> > +	 * or to reduce the access permissions only. And update the valid leaf
> > +	 * PTE without break-before-make if we are trying to add more access
> > +	 * permissions only.
> > +	 */
> > +	old_attr = (old & KVM_PTE_LEAF_ATTR_PERMS) ^
> > KVM_PTE_LEAF_ATTR_HI_S2_XN;
> > +	new_attr = (new & KVM_PTE_LEAF_ATTR_PERMS) ^
> > KVM_PTE_LEAF_ATTR_HI_S2_XN;
> > +	if (new_attr <= old_attr)
> > +		return true;
> > +
> > +	WRITE_ONCE(*ptep, new);
> > +	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, level);
> 
> I think what bothers me the most here is that we are turning a mapping into
> a permission update, which makes the code really hard to read, and mixes
> two things that were so far separate.
> 
> I wonder whether we should instead abort the update and simply take the
> fault
> again, if we ever need to do it.

That's a nice idea. If we could enforce that we don't alter permissions on
the map path, and instead just return e.g. -EAGAIN then that would be a
very neat solution and would cement the permission vs translation fault
division.

Will
