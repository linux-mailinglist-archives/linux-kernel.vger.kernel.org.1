Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B512CA5BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgLAOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbgLAOd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:33:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 583F320757;
        Tue,  1 Dec 2020 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606833168;
        bh=LkPHLNioQEa32GFSH3IOprZq0laRIqzUxVI5cxem5H4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vwda/V4IDBtyI8uvixvxdqWAT9PRpD9XNxTpsr2Ih1RUZKSylaW79Yh4L50zCxMaw
         ejRcbT8+nQj9bT0q2ReyoYYKE868rjGaw83K8DJLihUcYgnWaATUDo4zmG70B3Nlef
         L99lhbXRIWM9r+wLVGpsUqaJuPRihcGtLLj/ij+E=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kk6hy-00F4Pm-6C; Tue, 01 Dec 2020 14:32:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Dec 2020 14:32:46 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
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
Subject: Re: [RFC PATCH 2/3] KVM: arm64: Fix handling of merging tables into a
 block entry
In-Reply-To: <20201201142324.GD26973@willie-the-truck>
References: <20201130121847.91808-1-wangyanan55@huawei.com>
 <20201130121847.91808-3-wangyanan55@huawei.com>
 <20201130133421.GB24837@willie-the-truck>
 <67e9e393-1836-eca7-4235-6f4a19fed652@huawei.com>
 <20201130160119.GA25051@willie-the-truck>
 <868a4403-10d3-80f3-4ae1-a490813c55e2@huawei.com>
 <20201201134606.GB26973@willie-the-truck>
 <03ab1bdd8459831ad05993807e39e5bd@kernel.org>
 <20201201142324.GD26973@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <ef817e2b5a1a386c415c7e86bc59a296@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, wangyanan55@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, gshan@redhat.com, qperret@google.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, zhukeqian1@huawei.com, yuzenghui@huawei.com, jiangkunkun@huawei.com, wangjingyi11@huawei.com, lushenming@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-01 14:23, Will Deacon wrote:
> On Tue, Dec 01, 2020 at 02:05:03PM +0000, Marc Zyngier wrote:
>> On 2020-12-01 13:46, Will Deacon wrote:
>> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>> > index 0271b4a3b9fe..12526d8c7ae4 100644
>> > --- a/arch/arm64/kvm/hyp/pgtable.c
>> > +++ b/arch/arm64/kvm/hyp/pgtable.c
>> > @@ -493,7 +493,7 @@ static int stage2_map_walk_table_pre(u64 addr, u64
>> > end, u32 level,
>> >  		return 0;
>> >
>> >  	kvm_set_invalid_pte(ptep);
>> > -	kvm_call_hyp(__kvm_tlb_flush_vmid_ipa, data->mmu, addr, 0);
>> > +	/* TLB invalidation is deferred until the _post handler */
>> >  	data->anchor = ptep;
>> >  	return 0;
>> >  }
>> > @@ -547,11 +547,21 @@ static int stage2_map_walk_table_post(u64 addr,
>> > u64 end, u32 level,
>> >  				      struct stage2_map_data *data)
>> >  {
>> >  	int ret = 0;
>> > +	kvm_pte_t pte = *ptep;
>> >
>> >  	if (!data->anchor)
>> >  		return 0;
>> >
>> > -	free_page((unsigned long)kvm_pte_follow(*ptep));
>> > +	kvm_set_invalid_pte(ptep);
>> > +
>> > +	/*
>> > +	 * Invalidate the whole stage-2, as we may have numerous leaf
>> > +	 * entries below us which would otherwise need invalidating
>> > +	 * individually.
>> > +	 */
>> > +	kvm_call_hyp(__kvm_tlb_flush_vmid, data->mmu);
>> 
>> That's a big hammer, and we so far have been pretty careful not to
>> over-invalidate. Is the block-replacing-table *without* an unmap
>> in between the only case where this triggers?
> 
> Yes, this only happens in that case. The alternative would be to issue
> invalidations for every single entry we unmap, which I can implement if
> you prefer, but it felt worse to me given that by-IPA invalidation
> isn't really great either).

Right. If that's the only case where this happens, I'm not too bothered.
What I want to make sure is that the normal table->block upgrade path
(which goes via a MMU notifier that unmaps the table) stays relatively
quick and doesn't suffer from the above.

It looks like Yanan still has some concerns though, and I'd like to
understand what they are.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
