Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48C227D48D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbgI2ReO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:34:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728205AbgI2ReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:34:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2BD42075F;
        Tue, 29 Sep 2020 17:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601400853;
        bh=j0fCGiLcbnkITaxQRT0Ke2lzkcknLm9OTwR/cvXL0XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/6aevJ8x5eLSFiTmIwukWzyhkAbSNY5IS3lu9gBeiCTqp3Deya4iQV85YYPrPNR+
         uITte911QYHvItarSn0LYoaR4TvndgCdpIsTrblTpxrHXZsFbZQLiQwAOS7SQqNv4m
         4wxmWcDhYBM7gDR4fQcBa4vnb8E/ha/kp8TvnAcQ=
Date:   Tue, 29 Sep 2020 18:34:07 +0100
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
Subject: Re: [PATCH v4 05/10] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200929173407.GC14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-6-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922204910.7265-6-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:49:05PM +0100, David Brazdil wrote:
> The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
> because they always needed to use TPIDR_EL2 for base, while
> adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
> _EL1 based on VHE/nVHE.
> 
> Simplify this now that the hyp mode case can be handled using the
> __KVM_VHE/NVHE_HYPERVISOR__ macros.
> 
> Acked-by: Andrew Scull <ascull@google.com>
> Acked-by: Will Deacon <will@kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++----------
>  arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
>  arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
>  3 files changed, 21 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index 54d181177656..86e0ef79a799 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -218,6 +218,23 @@ lr	.req	x30		// link register
>  	str	\src, [\tmp, :lo12:\sym]
>  	.endm
>  
> +	/*
> +	 * @dst: destination register (32 or 64 bit wide)

nit: this comment is wrong as I don't think mrs can take a W register
as the destination argument. I'm assuming Marc can fix that up.

Will
