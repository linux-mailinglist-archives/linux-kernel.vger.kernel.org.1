Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A4430256C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbhAYNUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:20:51 -0500
Received: from foss.arm.com ([217.140.110.172]:47250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728721AbhAYNQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:16:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11A311FB;
        Mon, 25 Jan 2021 05:15:56 -0800 (PST)
Received: from [10.57.40.145] (unknown [10.57.40.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 427C83F66E;
        Mon, 25 Jan 2021 05:15:53 -0800 (PST)
Subject: Re: [PATCH v5 13/21] arm64: Allow ID_AA64MMFR1_EL1.VH to be
 overridden from the command line
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        kernel-team@android.com
References: <20210125105019.2946057-1-maz@kernel.org>
 <20210125105019.2946057-14-maz@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b43570e9-585d-3229-df2f-9af9777b55ec@arm.com>
Date:   Mon, 25 Jan 2021 13:15:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125105019.2946057-14-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/21 10:50 AM, Marc Zyngier wrote:
> As we want to be able to disable VHE at runtime, let's match
> "id_aa64mmfr1.vh=" from the command line as an override.
> This doesn't have much effect yet as our boot code doesn't look
> at the cpufeature, but only at the HW registers.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Acked-by: David Brazdil <dbrazdil@google.com>
> ---
>   arch/arm64/include/asm/cpufeature.h |  2 ++
>   arch/arm64/kernel/cpufeature.c      |  5 ++++-
>   arch/arm64/kernel/idreg-override.c  | 11 +++++++++++
>   3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index 4179cfc8ed57..b0ed37da4067 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -818,6 +818,8 @@ static inline unsigned int get_vmid_bits(u64 mmfr1)
>   	return 8;
>   }
>   
> +extern struct arm64_ftr_override id_aa64mmfr1_override;
> +
>   u32 get_kvm_ipa_limit(void);
>   void dump_cpu_features(void);
>   
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4b84a1e1dc51..c1d6712c4249 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -557,6 +557,8 @@ static const struct arm64_ftr_bits ftr_raz[] = {
>   
>   #define ARM64_FTR_REG(id, table) ARM64_FTR_REG_OVERRIDE(id, table, &no_override)
>   
> +struct arm64_ftr_override id_aa64mmfr1_override;

Does this need to be ro_after_init ?

Otherwise, looks good to me:

Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
