Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB902C5AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404114AbgKZRfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:35:42 -0500
Received: from foss.arm.com ([217.140.110.172]:41610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403842AbgKZRfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:35:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B2F331B;
        Thu, 26 Nov 2020 09:35:41 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.234])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5C053F23F;
        Thu, 26 Nov 2020 09:35:37 -0800 (PST)
Date:   Thu, 26 Nov 2020 17:35:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 04/23] arm64: Move MAIR_EL1_SET to asm/memory.h
Message-ID: <20201126173534.GE38486@C02TD0UTHF1T.local>
References: <20201126155421.14901-1-dbrazdil@google.com>
 <20201126155421.14901-5-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126155421.14901-5-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 03:54:02PM +0000, David Brazdil wrote:
> KVM currently initializes MAIR_EL2 to the value of MAIR_EL1. In
> preparation for initializing MAIR_EL2 before MAIR_EL1, move the constant
> into a shared header file. Since it is used for EL1 and EL2, rename to
> MAIR_ELx_SET.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/memory.h | 13 +++++++++++++
>  arch/arm64/mm/proc.S            | 15 +--------------
>  2 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index cd61239bae8c..54a22cb5b17b 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -152,6 +152,19 @@
>  #define MT_S2_FWB_NORMAL	6
>  #define MT_S2_FWB_DEVICE_nGnRE	1
>  
> +/*
> + * Default MAIR_ELx. MT_NORMAL_TAGGED is initially mapped as Normal memory and
> + * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> + */
> +#define MAIR_ELx_SET							\
> +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
> +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))

Patch 7 initializes MAIR_EL2 with this directly rather than copying it
from MAIR_EL1, which means that MT_NORMAL_TAGGED will never be tagged
within the nVHE hyp code.

Is that expected? I suspect it's worth a comment here (introduced in
patch 7), just to make that clear.

Otherwise this looks fine to me.

Thanks,
Mark.


> +
>  #ifdef CONFIG_ARM64_4K_PAGES
>  #define IOREMAP_MAX_ORDER	(PUD_SHIFT)
>  #else
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 23c326a06b2d..e3b9aa372b96 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -45,19 +45,6 @@
>  #define TCR_KASAN_FLAGS 0
>  #endif
>  
> -/*
> - * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
> - * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> - */
> -#define MAIR_EL1_SET							\
> -	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> -	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
> -	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> -	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
> -
>  #ifdef CONFIG_CPU_PM
>  /**
>   * cpu_do_suspend - save CPU registers context
> @@ -425,7 +412,7 @@ SYM_FUNC_START(__cpu_setup)
>  	/*
>  	 * Memory region attributes
>  	 */
> -	mov_q	x5, MAIR_EL1_SET
> +	mov_q	x5, MAIR_ELx_SET
>  #ifdef CONFIG_ARM64_MTE
>  	/*
>  	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
