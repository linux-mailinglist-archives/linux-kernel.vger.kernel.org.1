Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C042CF386
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgLDSCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgLDSCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:02:44 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70AC061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 10:01:57 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id e25so7870409wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 10:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GunWet4p4NzVbI1r1RYLjYsxsi2RUASEtxkEDiSdayU=;
        b=Jfc+OXEDeUa9mmISz8ZsnfdTU5azIgUzZSQjepScJvm9Yeu8TYr4EJM80uzI2fPPUb
         +VHfBX79uMGHB9tHKddRRiKYoDNVPsF81RdvXjX2YfemDOeWnvFmz3ZxiR/7JPAX22f6
         5tMT6fGr07JcUY7GB6TGOBnJAKFTflWYID7FgrAq2cOxXoeSVAUMIZbgYmETKwvczVHC
         i2uHt2MIyl9qCZGghiulFP8richVb8xc9cRAfdQic9NmrXZkgiKYKb9exgtCKAG2qi7s
         +K6FOWmZssDvDm3FjzNmaKJV02LM7JGkf/1TCuPcURVOz8hqELdq/Q7z3jGSEoQGCoBB
         FD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GunWet4p4NzVbI1r1RYLjYsxsi2RUASEtxkEDiSdayU=;
        b=GiIK7wdr5MMgMw9E2qNCjAgCghd+1mWj3hS7sK8BFPSIrsPdB0e3QeONm8oegLkZ/1
         qFKvo8+9Ki4/TMEGIsLk/xZcrq5p2a6f8u0YdnJJNE5R37/L3E0nkJerWqD2GfkVW56E
         OUaW7ejAny03f+726b6ioa2mDi6rsFYQA3+qE/IG8FuGINx3SEU/u4PAISl4B/i/5Izf
         RfgdQiJPl5mlXaWAg/+utrtWNDA5kNBBRsmTbQpNAifJvG9rHbfZm2/CHTNEmZhsziZh
         ljqOAY6k49HRCzKqFDsVClx/JKtAwd/y3w6ZnHHLCk4h0q0tpD++GFaH9aQFd5R/59n4
         Z0uw==
X-Gm-Message-State: AOAM5331i78xV+3CshKK7Yq/T6FiijJLMop1wYTwojCTfJYqTA1oJKu8
        2WXhcB3bPBE67NEiAx7t8p3g9w==
X-Google-Smtp-Source: ABdhPJxSC8KwxX3qUAPvNVm0RO0ZB//wClhZM8fadV8xFb6AM2n7EFO2SRqrA/auNGP2dVoT3/qMcQ==
X-Received: by 2002:a7b:c157:: with SMTP id z23mr5577311wmi.35.1607104916154;
        Fri, 04 Dec 2020 10:01:56 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id u66sm4104667wmg.30.2020.12.04.10.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 10:01:55 -0800 (PST)
Date:   Fri, 4 Dec 2020 18:01:52 +0000
From:   Quentin Perret <qperret@google.com>
To:     Fuad Tabba <tabba@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
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
Message-ID: <X8p5kLSIq2MoQZ24@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-17-qperret@google.com>
 <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+EHjTyJnZ8e=AN7H_k+oZb0VTWAgMicMY8Rqe2Di_3A87hm0A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 Dec 2020 at 12:57:33 (+0000), Fuad Tabba wrote:
<snip>
> > +int hyp_create_idmap(void);
> > +int hyp_map_vectors(void);
> > +int hyp_back_vmemmap(phys_addr_t phys, unsigned long size, phys_addr_t back);
> > +int hyp_cpu_set_vector(enum arm64_hyp_spectre_vector slot);
> > +int hyp_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot);
> > +int __hyp_create_mappings(unsigned long start, unsigned long size,
> > +                         unsigned long phys, unsigned long prot);
> > +unsigned long __hyp_create_private_mapping(phys_addr_t phys, size_t size,
> > +                                          unsigned long prot);
> > +
> 
> nit: I also thought that the hyp_create_mappings function names are a
> bit confusing, since there's the create_hyp_mappings functions which
> use the aforementioned *hyp_pgtable.

Sure, happy to re-name those (and hyp_pgtable above). Any suggestions?


<snip>
> > +SYM_FUNC_START(__kvm_init_switch_pgd)
> > +       /* Turn the MMU off */
> > +       pre_disable_mmu_workaround
> > +       mrs     x2, sctlr_el2
> > +       bic     x3, x2, #SCTLR_ELx_M
> > +       msr     sctlr_el2, x3
> > +       isb
> > +
> > +       tlbi    alle2
> > +
> > +       /* Install the new pgtables */
> > +       ldr     x3, [x0, #NVHE_INIT_PGD_PA]
> > +       phys_to_ttbr x4, x3
> > +alternative_if ARM64_HAS_CNP
> > +       orr     x4, x4, #TTBR_CNP_BIT
> > +alternative_else_nop_endif
> > +       msr     ttbr0_el2, x4
> > +
> > +       /* Set the new stack pointer */
> > +       ldr     x0, [x0, #NVHE_INIT_STACK_HYP_VA]
> > +       mov     sp, x0
> > +
> > +       /* And turn the MMU back on! */
> > +       dsb     nsh
> > +       isb
> > +       msr     sctlr_el2, x2
> > +       isb
> > +       ret     x1
> > +SYM_FUNC_END(__kvm_init_switch_pgd)
> > +
> 
> Should the instruction cache be flushed here (ic iallu), to discard
> speculatively fetched instructions?

Hmm, Will? Thoughts?

Thanks,
Quentin
