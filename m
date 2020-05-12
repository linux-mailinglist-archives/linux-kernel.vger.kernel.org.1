Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59171CF2F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgELK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 06:56:20 -0400
Received: from foss.arm.com ([217.140.110.172]:52338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbgELK4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 06:56:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A26A530E;
        Tue, 12 May 2020 03:56:19 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.28.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD7243F71E;
        Tue, 12 May 2020 03:56:17 -0700 (PDT)
Date:   Tue, 12 May 2020 11:56:14 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH] arm64/cpufeature: Add ID_AA64MMFR0_PARANGE_MASK
Message-ID: <20200512105614.GC60359@C02TD0UTHF1T.local>
References: <1589249606-27177-1-git-send-email-anshuman.khandual@arm.com>
 <20200512105343.GB60359@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512105343.GB60359@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 11:53:43AM +0100, Mark Rutland wrote:
> >
> >  	/* Clamp the IPA limit to the PA size supported by the kernel */
> >  	ipa_max = (pa_max > PHYS_MASK_SHIFT) ? PHYS_MASK_SHIFT : pa_max;
> > @@ -411,7 +411,8 @@ int kvm_arm_setup_stage2(struct kvm *kvm, unsigned long type)
> >  		phys_shift = KVM_PHYS_SHIFT;
> >  	}
> >  
> > -	parange = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1) & 7;
> > +	parange = id_aa64mmfr0_parange(read_sanitised_ftr_reg
> > +						(SYS_ID_AA64MMFR0_EL1));
> 
> Can't we add a system_ipa_range() helper, and avoid more boilerplate in
> each of these?
> 
> e.g.
> 
> int system_ipa_range(void)
> {
> 	u64 mmfr0;
> 	int parange;
> 
> 	mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
> 	parange = cpuid_feature_extract_unsigned_field(mmfr0,
> 		ID_AA64MMFR0_PARANGE_SHIFT);
> 	
> 	return parange;
> }

As Per MarcZ's comments, that should be system_pa_range() rather than
system_ipa_range().

Mark.
