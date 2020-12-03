Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6942CDBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgLCQ7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:59:49 -0500
Received: from foss.arm.com ([217.140.110.172]:45274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgLCQ7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:59:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24ADA11D4;
        Thu,  3 Dec 2020 08:59:03 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.0.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495BC3F575;
        Thu,  3 Dec 2020 08:59:00 -0800 (PST)
Date:   Thu, 3 Dec 2020 16:58:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v6 0/2] MTE support for KVM guest
Message-ID: <20201203165856.GH96754@C02TD0UTHF1T.local>
References: <20201127152113.13099-1-steven.price@arm.com>
 <20201203160943.GG96754@C02TD0UTHF1T.local>
 <77e65f06-563b-3b30-ab36-9670e8cc03a4@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77e65f06-563b-3b30-ab36-9670e8cc03a4@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 04:49:49PM +0000, Steven Price wrote:
> On 03/12/2020 16:09, Mark Rutland wrote:
> > On Fri, Nov 27, 2020 at 03:21:11PM +0000, Steven Price wrote:
> > > It's been a week, and I think the comments on v5 made it clear that
> > > enforcing PROT_MTE requirements on the VMM was probably the wrong
> > > approach. So since I've got swap working correctly without that I
> > > thought I'd post a v6 which hopefully addresses all the comments so far.
> > > 
> > > This series adds support for Arm's Memory Tagging Extension (MTE) to
> > > KVM, allowing KVM guests to make use of it. This builds on the existing
> > > user space support already in v5.10-rc4, see [1] for an overview.
> > 
> > >   arch/arm64/include/asm/kvm_emulate.h       |  3 +++
> > >   arch/arm64/include/asm/kvm_host.h          |  8 ++++++++
> > >   arch/arm64/include/asm/pgtable.h           |  2 +-
> > >   arch/arm64/include/asm/sysreg.h            |  3 ++-
> > >   arch/arm64/kernel/mte.c                    | 18 +++++++++++++-----
> > >   arch/arm64/kvm/arm.c                       |  9 +++++++++
> > >   arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
> > >   arch/arm64/kvm/mmu.c                       | 16 ++++++++++++++++
> > >   arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
> > >   include/uapi/linux/kvm.h                   |  1 +
> > >   10 files changed, 82 insertions(+), 12 deletions(-)
> > 
> > I note that doesn't fixup arch/arm64/kvm/inject_fault.c, where in
> > enter_exception64() we have:
> > 
> > | // TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
> > 
> > ... and IIUC when MTE is present, TCO should be set when delivering an
> > exception, so I believe that needs to be updated to set TCO.
> 
> Well spotted! As you say TCO should be set when delivering an exception, so
> we need the following:
> 
> -       // TODO: TCO (if/when ARMv8.5-MemTag is exposed to guests)
> +       if (kvm_has_mte(vcpu->kvm))
> +               new |= PSR_TCO_BIT;

Something of that sort, yes.

It'd be worth a look for any mention of TCO or MTE in case there are
other bits that need a fixup.

> > Given that MTE-capable HW does that unconditionally, this is going to be
> > a mess for big.LITTLE. :/
> 
> I'm not sure I follow. Either all CPUs support MTE in which this isn't a
> problem, or the MTE feature just isn't exposed. We don't support a mix of
> MTE and non-MTE CPUs. There are several aspects of MTE which effective mean
> it's an all-or-nothing feature for the system.

So long as the host requires uniform MTE support, I agree that's not a
problem.

The fun is that the CPUs themselves will set TCO upon a real exception
regardless of whether the host is aware, and on a mismatched system some
CPUs will do that while others will not. In such a case the host and
guest will end up seeing the SPSR TCO bit set sometimes upon exceptions
from EL1 or EL2, and I hope that MTE-unaware CPUs ignore the bit upon
ERET, or we're going to have significant problems.

Thanks,
Mark.
