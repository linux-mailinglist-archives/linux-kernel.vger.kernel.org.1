Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8E52D0EB7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgLGLLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 06:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbgLGLLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 06:11:01 -0500
Date:   Mon, 7 Dec 2020 11:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607339420;
        bh=G9EsmmXSsnROa35VPjXLwGmctcwNCJzvlkxZBxdE0ik=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=fKXZWTLvBHBgphzv4ZC46t36HsgceZS7konE/taGhYyjKdKxYOPMG9ZjMC1oooYZv
         27gZ8nJP4+WS+B22v4HGz8S4t77abN5hDNNW6Zo2WsXr2oGAWGLaG3/kEQtco3NMgl
         s+v8NRs5QTH0P4tw53Z2c3gg/cLOTGFL3Azb/AeBZKUWW83/OEseCryb4FXvnaPJo7
         8OrRSgADA82mbbZvtOG02lJucVBxQIqhFBV4xKOA2EAZdrP6ZXzBdC22mvWix1TZkW
         2FtE9gp8W6gezN54iQPMKVsm+ZDworf/e04EFIfvVjBNnd5zR2JXrp+a3siCvKrPsb
         uTa0r+K4UO4Eg==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        Android KVM <android-kvm@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fuad Tabba <tabba@google.com>, Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>
Subject: Re: [RFC PATCH 16/27] KVM: arm64: Prepare Hyp memory protection
Message-ID: <20201207111013.GA4379@willie-the-truck>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com>
 <X8p5kLSIq2MoQZ24@google.com>
 <20201207102002.GA3825@willie-the-truck>
 <20201207110528.GA18365@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207110528.GA18365@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:05:45AM +0000, Mark Rutland wrote:
> On Mon, Dec 07, 2020 at 10:20:03AM +0000, Will Deacon wrote:
> > On Fri, Dec 04, 2020 at 06:01:52PM +0000, Quentin Perret wrote:
> > > On Thursday 03 Dec 2020 at 12:57:33 (+0000), Fuad Tabba wrote:
> > > <snip>
> > > > > +SYM_FUNC_START(__kvm_init_switch_pgd)
> > > > > +       /* Turn the MMU off */
> > > > > +       pre_disable_mmu_workaround
> > > > > +       mrs     x2, sctlr_el2
> > > > > +       bic     x3, x2, #SCTLR_ELx_M
> > > > > +       msr     sctlr_el2, x3
> > > > > +       isb
> > > > > +
> > > > > +       tlbi    alle2
> > > > > +
> > > > > +       /* Install the new pgtables */
> > > > > +       ldr     x3, [x0, #NVHE_INIT_PGD_PA]
> > > > > +       phys_to_ttbr x4, x3
> > > > > +alternative_if ARM64_HAS_CNP
> > > > > +       orr     x4, x4, #TTBR_CNP_BIT
> > > > > +alternative_else_nop_endif
> > > > > +       msr     ttbr0_el2, x4
> > > > > +
> > > > > +       /* Set the new stack pointer */
> > > > > +       ldr     x0, [x0, #NVHE_INIT_STACK_HYP_VA]
> > > > > +       mov     sp, x0
> > > > > +
> > > > > +       /* And turn the MMU back on! */
> > > > > +       dsb     nsh
> > > > > +       isb
> > > > > +       msr     sctlr_el2, x2
> > > > > +       isb
> > > > > +       ret     x1
> > > > > +SYM_FUNC_END(__kvm_init_switch_pgd)
> > > > > +
> > > > 
> > > > Should the instruction cache be flushed here (ic iallu), to discard
> > > > speculatively fetched instructions?
> > > 
> > > Hmm, Will? Thoughts?
> > 
> > The I-cache is physically tagged, so not sure what invalidation would
> > achieve here. Fuad -- what do you think could go wrong specifically?
> 
> While the MMU is off, instruction fetches can be made from the PoC
> rather than the PoU, so where instructions have been modified/copied and
> not cleaned to the PoC, it's possible to fetch stale copies into the
> I-caches. The physical tag doesn't prevent that.

Oh yeah, we even have a comment about that in
idmap_kpti_install_ng_mappings(). Maybe we should wrap disable_mmu and
enable_mmu in some macros so we don't have to trip over this every time (and
this would mean we could get rid of pre_disable_mmu_workaround too).

> In the regular CPU boot paths, __enabble_mmu() has an IC IALLU after
> enabling the MMU to ensure that we get rid of anything stale (e.g. so
> secondaries don't miss ftrace patching, which is only cleaned to the
> PoU).
> 
> That might not be a problem here, if things are suitably padded and
> never dynamically patched, but if so it's probably worth a comment.

It's fragile enough that we should just do the invalidation.

Will
