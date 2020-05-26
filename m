Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904C61C5415
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgEELMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 07:12:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgEELMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:12:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A88C20735;
        Tue,  5 May 2020 11:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588677166;
        bh=aqQGzN9qYZSgDY+zbPTiKpLxyYu05CkwvJktzlbaFXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcmzyUy+7wAHnwGGrAinJ1tPmzRK3XYBBi4NFpI0imGA0Xq1Y+a5vct9u00Zv4svr
         /pzdcE9N4IojYNwxNmXeNFDqjLMc2V6q+ZurACaX8wqfEoBOcaWQsQ+oKJES57ND36
         /d/JJ8/3P33x8kHDfvcYUyIF5hT2X14UJCQ0N0hA=
Date:   Tue, 5 May 2020 12:12:41 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 04/16] arm64/cpufeature: Introduce ID_PFR2 CPU register
Message-ID: <20200505111241.GF19710@willie-the-truck>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-5-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588426445-24344-5-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 07:03:53PM +0530, Anshuman Khandual wrote:
> This adds basic building blocks required for ID_PFR2 CPU register which
> provides information about the AArch32 programmers model which must be
> interpreted along with ID_PFR0 and ID_PFR1 CPU registers. This is added
> per ARM DDI 0487F.a specification.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/cpu.h    |  1 +
>  arch/arm64/include/asm/sysreg.h |  4 ++++
>  arch/arm64/kernel/cpufeature.c  | 11 +++++++++++
>  arch/arm64/kernel/cpuinfo.c     |  1 +
>  arch/arm64/kvm/sys_regs.c       |  2 +-
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index b4a40535a3d8..464e828a994d 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -46,6 +46,7 @@ struct cpuinfo_arm64 {
>  	u32		reg_id_mmfr3;
>  	u32		reg_id_pfr0;
>  	u32		reg_id_pfr1;
> +	u32		reg_id_pfr2;
>  
>  	u32		reg_mvfr0;
>  	u32		reg_mvfr1;
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index e5317a6367b6..c977449e02db 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -153,6 +153,7 @@
>  #define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
>  #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
>  #define SYS_MVFR2_EL1			sys_reg(3, 0, 0, 3, 2)
> +#define SYS_ID_PFR2_EL1			sys_reg(3, 0, 0, 3, 4)

nit: but please group these defines by name rather than encoding.

Will
