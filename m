Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF71A2CA51B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391280AbgLAOIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:08:34 -0500
Received: from foss.arm.com ([217.140.110.172]:43596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387443AbgLAOIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:08:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2F0A30E;
        Tue,  1 Dec 2020 06:07:46 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03C943F718;
        Tue,  1 Dec 2020 06:07:42 -0800 (PST)
Date:   Tue, 1 Dec 2020 14:07:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH v3 06/23] kvm: arm64: Add kvm-arm.protected early kernel
 parameter
Message-ID: <20201201140734.GA86881@C02TD0UTHF1T.local>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-7-dbrazdil@google.com>
 <20201127163254.zxdrszlveaxhluwn@bogus>
 <20201201131913.u7m2eifvtus74dra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201131913.u7m2eifvtus74dra@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 01:19:13PM +0000, David Brazdil wrote:
> Hey Sudeep,
> 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 526d65d8573a..06c89975c29c 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -2259,6 +2259,11 @@
> > >  			for all guests.
> > >  			Default is 1 (enabled) if in 64-bit or 32-bit PAE mode.
> > >  
> > > +	kvm-arm.protected=
> > > +			[KVM,ARM] Allow spawning protected guests whose state
> > > +			is kept private from the host. Only valid for non-VHE.
> > > +			Default is 0 (disabled).
> > > +
> > 
> > Sorry for being pedantic. Can we reword this to say valid for
> > !CONFIG_ARM64_VHE ? I read this as valid only for non-VHE hardware, it may
> > be just me, but if you agree please update so that it doesn't give remote
> > idea that it is not valid on VHE enabled hardware.
> > 
> > I was trying to run this on the hardware and was trying to understand the
> > details on how to do that.
> 
> I see what you're saying, but !CONFIG_ARM64_VHE isn't accurate either. The
> option makes sense if:
>   1) all cores booted in EL2
>      == is_hyp_mode_available()
>   2) ID_AA64MMFR1_EL1.VH=0 or !CONFIG_ARM64_VHE
>      == !is_kernel_in_hyp_mode()
> 
> The former feels implied for KVM, the latter could be 'Valid if the kernel
> is running in EL1'? WDYT?

I reckon we can avoid the restriction if we instead add an early stub
like with have for KASLR. That way we could parse the command line
early, and if necessary re-initialize EL2 and drop to EL1 before the
main kernel has to make any decisions about how to initialize things.
That would allow us to have a more general kvm-arm.mode option where a
single kernel Image could support:

* "protected" mode on nVHE or VHE HW
* "nvhe" mode on nVHE or VHE HW
* "vhe" mode on VHE HW

... defaulting to VHE/nVHE modes depending on HW support.

That would also be somewhat future-proof if we have to add other
variants of protected mode in future, as we could extend the mode option
with parameters for each mode.

Thanks,
Mark.
