Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5743F2F1E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390299AbhAKSml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbhAKSml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:42:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65CE22251F;
        Mon, 11 Jan 2021 18:41:57 +0000 (UTC)
Date:   Mon, 11 Jan 2021 18:41:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v3 09/21] arm64: cpufeature: Add global feature override
 facility
Message-ID: <20210111184154.GC17941@gaia>
References: <20210111132811.2455113-1-maz@kernel.org>
 <20210111132811.2455113-10-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111132811.2455113-10-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Jan 11, 2021 at 01:27:59PM +0000, Marc Zyngier wrote:
> Add a facility to globally override a feature, no matter what
> the HW says. Yes, this is dangerous.

Yeah, it's dangerous. We can make it less so if we only allow safe
values (e.g. lower if FTR_UNSIGNED).

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 9a555809b89c..465d2cb63bfc 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -75,6 +75,8 @@ struct arm64_ftr_reg {
>  	u64				sys_val;
>  	u64				user_val;
>  	const struct arm64_ftr_bits	*ftr_bits;
> +	u64				*override_val;
> +	u64				*override_mask;
>  };

At the arm64_ftr_reg level, we don't have any information about the safe
values for a feature. Could we instead move this to arm64_ftr_bits? We
probably only need a single field. When populating the feature values,
we can make sure it doesn't go above the hardware one.

I attempted a feature modification for MTE here, though I dropped the
entire series in the meantime as we clarified the ARM ARM:

https://lore.kernel.org/linux-arm-kernel/20200515171612.1020-24-catalin.marinas@arm.com/

Srinivas copied it in his patch (but forgot to give credit ;)):

https://lore.kernel.org/linux-arm-msm/1610152163-16554-3-git-send-email-sramana@codeaurora.org/

The above adds a filter function but, instead, just use your mechanism in
this series for idreg.feature setting via cmdline. The arm64_ftr_value()
function extracts the hardware value and lowers it if a cmdline argument
was passed.

-- 
Catalin
