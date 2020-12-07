Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0042D0DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgLGKUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:20:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLGKUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:20:50 -0500
Date:   Mon, 7 Dec 2020 10:20:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607336409;
        bh=Li8eED23jwkjCXrIrIn4+IUiJ6tDcvVO2vCH088mQUY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0FLanr1uDR47XUL7aujD4qaGGbywqubDEU6lzDVlMfvD//mkVCklE2WbkUreeRsF
         ncinZWVrT2AwhNXtAEu7udfm5Ra44P7u6N9cLOu/LTTtGgycvdW1qNx4sraOioIoZa
         Da8B9TcxWiwOV9b6KYOOrEl8DkLL8fOXAlVl3poIBu2FmWmwSifU2/yOUzhHm9V9a5
         IHbrCePeoiha2DCMfA9Y2DmGUWeOiHG51ryLDmLYje36rUYJpCcefNliCtTfAzSYBy
         7wY+z4MDM/D1pz+TTNx8Xpg/glPzWozfh9TkevI0IP/OMkug1QZ34pk3+XhTTjugpZ
         dykDvjQEoh9qQ==
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Fuad Tabba <tabba@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        Android KVM <android-kvm@google.com>
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20201207102002.GA3825@willie-the-truck>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com>
 <X8p5kLSIq2MoQZ24@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8p5kLSIq2MoQZ24@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 06:01:52PM +0000, Quentin Perret wrote:
> On Thursday 03 Dec 2020 at 12:57:33 (+0000), Fuad Tabba wrote:
> <snip>
> > > +int hyp_create_idmap(void);
> > > +int hyp_map_vectors(void);
> > > +int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
> > > +int hyp_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
> > > +int hyp_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> > > +int __hyp_create_mappings(unsigned long start, unsigned long size,
> > > +                         unsigned long phys, unsigned long prot);
> > > +unsigned long __hyp_create_private_mapping(phys_addr_t phys, size_t size,
> > > +                                          unsigned long prot);
> > > +
> > 
> > nit: I also thought that the hyp_create_mappings function names are a
> > bit confusing, since there's the create_hyp_mappings functions which
> > use the aforementioned *hyp_pgtable.
> 
> Sure, happy to re-name those (and hyp_pgtable above). Any suggestions?
> 
> 
> <snip>
> > > +SYM_FUNC_START(__kvm_init_switch_pgd)
> > > +       /* Turn the MMU off */
> > > +       pre_disable_mmu_workaround
> > > +       mrs     x2, sctlr_el2
> > > +       bic     x3, x2, #SCTLR_ELx_M
> > > +       msr     sctlr_el2, x3
> > > +       isb
> > > +
> > > +       tlbi    alle2
> > > +
> > > +       /* Install the new pgtables */
> > > +       ldr     x3, [x0, #NVHE_INIT_PGD_PA]
> > > +       phys_to_ttbr x4, x3
> > > +alternative_if ARM64_HAS_CNP
> > > +       orr     x4, x4, #TTBR_CNP_BIT
> > > +alternative_else_nop_endif
> > > +       msr     ttbr0_el2, x4
> > > +
> > > +       /* Set the new stack pointer */
> > > +       ldr     x0, [x0, #NVHE_INIT_STACK_HYP_VA]
> > > +       mov     sp, x0
> > > +
> > > +       /* And turn the MMU back on! */
> > > +       dsb     nsh
> > > +       isb
> > > +       msr     sctlr_el2, x2
> > > +       isb
> > > +       ret     x1
> > > +SYM_FUNC_END(__kvm_init_switch_pgd)
> > > +
> > 
> > Should the instruction cache be flushed here (ic iallu), to discard
> > speculatively fetched instructions?
> 
> Hmm, Will? Thoughts?

The I-cache is physically tagged, so not sure what invalidation would
achieve here. Fuad -- what do you think could go wrong specifically?

Will
