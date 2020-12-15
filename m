Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6352A2DADE6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 14:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgLONTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 08:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725890AbgLONTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 08:19:18 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3D722225;
        Tue, 15 Dec 2020 13:18:37 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kpADr-001URY-9d; Tue, 15 Dec 2020 13:18:35 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 15 Dec 2020 13:18:35 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     "wangyanan (Y)" <wangyanan55@huawei.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH] KVM: arm64: Add prejudgement for relaxing permissions
 only case in stage2 translation fault handler
In-Reply-To: <2ab9323a-40a1-d223-f692-0a19207e16a9@huawei.com>
References: <20201211080115.21460-1-wangyanan55@huawei.com>
 <20201211080115.21460-2-wangyanan55@huawei.com>
 <8d006755e5afce7e49b03993316c4fcc@kernel.org>
 <20201211100026.GA11352@willie-the-truck>
 <2ab9323a-40a1-d223-f692-0a19207e16a9@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <9a3bd48c4e69946bc4ade274ce2cc318@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: wangyanan55@huawei.com, will@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, gshan@redhat.com, qperret@google.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, zhukeqian1@huawei.com, yuzenghui@huawei.com, jiangkunkun@huawei.com, wangjingyi11@huawei.com, lushenming@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yanan,

On 2020-12-14 07:20, wangyanan (Y) wrote:

> diff --git a/arch/arm64/kvm/hyp/pgtable.c 
> b/arch/arm64/kvm/hyp/pgtable.c
> index a74a62283012..e3c6133567c4 100644
> --- a/arch/arm64/kvm/hyp/pgtable.c
> +++ b/arch/arm64/kvm/hyp/pgtable.c
> @@ -45,6 +45,10 @@
> 
>  #define KVM_PTE_LEAF_ATTR_HI_S2_XN     BIT(54)
> 
> +#define KVM_PTE_LEAF_ATTR_S2_PERMS (KVM_PTE_LEAF_ATTR_LO_S2_S2AP_R | \
> +        KVM_PTE_LEAF_ATTR_LO_S2_S2AP_W | \
> + KVM_PTE_LEAF_ATTR_HI_S2_XN)
> +
>  struct kvm_pgtable_walk_data {
>         struct kvm_pgtable                   *pgt;
>         struct kvm_pgtable_walker       *walker;
> @@ -473,8 +477,13 @@ static bool stage2_map_walker_try_leaf(u64 addr,
> u64 end, u32 level,
> 
>         new = kvm_init_valid_leaf_pte(phys, data->attr, level);
>         if (kvm_pte_valid(old)) {
> -               /* Tolerate KVM recreating the exact same mapping. */
> -               if (old == new)
> +               /*
> +                * Skip updating the PTE with break-before-make if we 
> are trying
> +                * to recreate the exact same mapping or only change 
> the access
> +                * permissions. Actually, change of permissions will be 
> handled
> +                * through the relax_perms path next time if necessary.
> +                */
> +               if (!((old ^ new) & (~KVM_PTE_LEAF_ATTR_S2_PERMS)))
>                         goto out;
> 
>                 /* There's an existing different valid leaf entry, so 
> perform

I think there is a bit more work to do on this.

One obvious issue is that we currently flag a page as dirty before 
handling
the fault. With an early exit, we end-up having spurious dirty pages.

It's not a big deal, but I'd rather mark the page dirty after the 
mapping
or the permission update having been successful (at the moment, it 
cannot
fails).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
