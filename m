Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBE227D482
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgI2RbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2RbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:31:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AB3B2076B;
        Tue, 29 Sep 2020 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601400659;
        bh=ZXt7Xlne8O4MeeCwfkNnfkAu3Jkzhnlfgn/f/Lyi+XQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BqjJ64HL0rL6kTbXLKtkhMwe+607jWI3ODEOSusQB4LnnZOZoy1o0wUnALLXNfigf
         XdKaidx2BNKgnijeVFxsXwptbciO2gzQKNkhSPtD13DrtbfxLd3QEQNSMXI6bH+lOR
         5o/Y7OEfIlhv/C8yQRQobAcD3UkCvAmF/QeJGU2w=
Date:   Tue, 29 Sep 2020 18:30:53 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v4 04/10] kvm: arm64: Remove __hyp_this_cpu_read
Message-ID: <20200929173053.GB14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-5-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922204910.7265-5-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:49:04PM +0100, David Brazdil wrote:
> this_cpu_ptr is meant for use in kernel proper because it selects between
> TPIDR_EL1/2 based on nVHE/VHE. __hyp_this_cpu_ptr was used in hyp to always
> select TPIDR_EL2. Unify all users behind this_cpu_ptr and friends by
> selecting _EL2 register under __KVM_NVHE_HYPERVISOR__. VHE continues
> selecting the register using alternatives.
> 
> Under CONFIG_DEBUG_PREEMPT, the kernel helpers perform a preemption check
> which is omitted by the hyp helpers. Preserve the behavior for nVHE by
> overriding the corresponding macros under __KVM_NVHE_HYPERVISOR__. Extend
> the checks into VHE hyp code.
> 
> Acked-by: Andrew Scull <ascull@google.com>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h          | 20 ----------------
>  arch/arm64/include/asm/percpu.h           | 28 +++++++++++++++++++++--
>  arch/arm64/kvm/hyp/include/hyp/debug-sr.h |  4 ++--
>  arch/arm64/kvm/hyp/include/hyp/switch.h   |  8 +++----
>  arch/arm64/kvm/hyp/nvhe/switch.c          |  2 +-
>  arch/arm64/kvm/hyp/vhe/switch.c           |  2 +-
>  arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |  4 ++--
>  7 files changed, 36 insertions(+), 32 deletions(-)

Looks good, thanks for the respin!

Acked-by: Will Deacon <will@kernel.org>

Will
