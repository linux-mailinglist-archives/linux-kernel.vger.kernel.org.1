Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705042CA581
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgLAOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:24:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbgLAOYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:24:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ADAC20757;
        Tue,  1 Dec 2020 14:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606832611;
        bh=C+v67/0KcQr9kW1xIWsErc3mmwvhcoTEt92CQWvx2fI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPrqK70xrZXr4bydVCcxhOZvnaGb8rhQHlJpV9GdEVv9RtZFMI0lvO+wTFTWu4yi3
         hEZqFE5SR/hEY1zqXfTOy1O3nIXbEHWmfal89ypLAm0t6O1Fjsn/ZgTvQN7Ms7hVKh
         8D/0rwJlqoCpv3aYm4oxaXGqIG7Jsu68J0B0H44c=
Date:   Tue, 1 Dec 2020 14:23:25 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     "wangyanan (Y)" <wangyanan55@huawei.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into
 a block entry
Message-ID: <20201201142324.GD26973@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-3-wangyanan55@huawei.com>
 <20201130133421.GB24837@willie-the-truck>
 <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
 <20201130160119.GA25051@willie-the-truck>
 <868a4403-10d3-80f3-4ae1-a490813c55e2@huawei.com>
 <20201201134606.GB26973@willie-the-truck>
 <03ab1bdd8459831ad05993807e39e5bd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ab1bdd8459831ad05993807e39e5bd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 02:05:03PM +0000, Marc Zyngier wrote:
> On 2020-12-01 13:46, Will Deacon wrote:
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 0271b4a3b9fe..12526d8c7ae4 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -493,7 +493,7 @@ static int stage2_map_walk_table_pre(u64 addr, u64
> > end, u32 level,
> >  		return 0;
> > 
> >  	kvm_set_invalid_pte(ptep);
> > -	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, 0);
> > +	/* TLB invalidation is deferred until the _post handler */
> >  	data->anchor = ptep;
> >  	return 0;
> >  }
> > @@ -547,11 +547,21 @@ static int stage2_map_walk_table_post(u64 addr,
> > u64 end, u32 level,
> >  				      struct stage2_map_data *data)
> >  {
> >  	int ret = 0;
> > +	kvm_pte_t pte = *ptep;
> > 
> >  	if (!data->anchor)
> >  		return 0;
> > 
> > -	free_page((unsigned long)kvm_pte_follow(*ptep));
> > +	kvm_set_invalid_pte(ptep);
> > +
> > +	/*
> > +	 * Invalidate the whole stage-2, as we may have numerous leaf
> > +	 * entries below us which would otherwise need invalidating
> > +	 * individually.
> > +	 */
> > +	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
> 
> That's a big hammer, and we so far have been pretty careful not to
> over-invalidate. Is the block-replacing-table *without* an unmap
> in between the only case where this triggers?

Yes, this only happens in that case. The alternative would be to issue
invalidations for every single entry we unmap, which I can implement if
you prefer, but it felt worse to me given that by-IPA invalidation
isn't really great either).

Will
