Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22B72F1691
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 14:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbhAKNyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 08:54:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731147AbhAKNyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 08:54:03 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C694922283;
        Mon, 11 Jan 2021 13:53:20 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kyxdG-006hJn-Sx; Mon, 11 Jan 2021 13:53:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 11 Jan 2021 13:53:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jing Zhang <jingzhangos@google.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Ajay Patil <pajay@qti.qualcomm.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v3 04/21] arm64: Provide an 'upgrade to VHE' stub
 hypercall
In-Reply-To: <20210111132811.2455113-5-maz@kernel.org>
References: <20210111132811.2455113-1-maz@kernel.org>
 <20210111132811.2455113-5-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <017892d274a0a2ba20ad83f3eb9bc6e3@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, mark.rutland@arm.com, jingzhangos@google.com, psodagud@codeaurora.org, sramana@codeaurora.org, suzuki.poulose@arm.com, catalin.marinas@arm.com, alexandru.elisei@arm.com, james.morse@arm.com, pajay@qti.qualcomm.com, kernel-team@android.com, dbrazdil@google.com, will@kernel.org, ardb@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-11 13:27, Marc Zyngier wrote:
> As we are about to change the way a VHE system boots, let's
> provide the core helper, in the form of a stub hypercall that
> enables VHE and replicates the full EL1 context at EL2, thanks
> to EL1 and VHE-EL2 being extremely similar.
> 
> On exception return, the kernel carries on at EL2. Fancy!
> 
> Nothing calls this new hypercall yet, so no functional change.

Famous last words...

> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/virt.h |  7 +++-
>  arch/arm64/kernel/hyp-stub.S  | 67 +++++++++++++++++++++++++++++++++--
>  2 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/virt.h 
> b/arch/arm64/include/asm/virt.h
> index ee6a48df89d9..7379f35ae2c6 100644
> --- a/arch/arm64/include/asm/virt.h
> +++ b/arch/arm64/include/asm/virt.h
> @@ -35,8 +35,13 @@
>   */
>  #define HVC_RESET_VECTORS 2
> 
> +/*
> + * HVC_VHE_RESTART - Upgrade the CPU from EL1 to EL2, if possible
> + */
> +#define HVC_VHE_RESTART	3
> +
>  /* Max number of HYP stub hypercalls */
> -#define HVC_STUB_HCALL_NR 3
> +#define HVC_STUB_HCALL_NR 4
> 
>  /* Error returned when an invalid stub number is passed into x0 */
>  #define HVC_STUB_ERR	0xbadca11
> diff --git a/arch/arm64/kernel/hyp-stub.S 
> b/arch/arm64/kernel/hyp-stub.S
> index 160f5881a0b7..0a84602344eb 100644
> --- a/arch/arm64/kernel/hyp-stub.S
> +++ b/arch/arm64/kernel/hyp-stub.S
> @@ -8,9 +8,9 @@
> 
>  #include <linux/init.h>
>  #include <linux/linkage.h>
> -#include <linux/irqchip/arm-gic-v3.h>
> 
>  #include <asm/assembler.h>
> +#include <asm/el2_setup.h>
>  #include <asm/kvm_arm.h>
>  #include <asm/kvm_asm.h>
>  #include <asm/ptrace.h>
> @@ -47,10 +47,13 @@ SYM_CODE_END(__hyp_stub_vectors)
> 
>  SYM_CODE_START_LOCAL(el1_sync)
>  	cmp	x0, #HVC_SET_VECTORS
> -	b.ne	2f
> +	b.ne	1f
>  	msr	vbar_el2, x1
>  	b	9f
> 
> +1:	cmp	x0, #HVC_VHE_RESTART
> +	b	mutate_to_vhe

And of course, I managed to send the *wrong* version of this patch.
This should obviously be a "b.eq", otherwise none of the other
hypercalls are reachable...

The correct version of this is now pushed in my tree[1].

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=hack/arm64-early-cpufeature
-- 
Jazz is not dead. It just smells funny...
