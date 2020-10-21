Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E6294B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441770AbgJUKcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:32:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56272 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438897AbgJUKcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:32:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGRdp4V1FzB09bF;
        Wed, 21 Oct 2020 12:32:46 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id jnZ2Vh4Sltdf; Wed, 21 Oct 2020 12:32:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGRdp39xqzB09bB;
        Wed, 21 Oct 2020 12:32:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7E52C8B7F6;
        Wed, 21 Oct 2020 12:32:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8NBdCwGsqdJN; Wed, 21 Oct 2020 12:32:47 +0200 (CEST)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5762E8B7EA;
        Wed, 21 Oct 2020 12:32:47 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/mm: Add mask of always present MMU features
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <06bf0e094463533e7aec6900bddd435171e9f44f.1602517171.git.christophe.leroy@csgroup.eu>
Message-ID: <4bc99005-f3c0-045b-e0d5-f8b6f2b2e90d@csgroup.eu>
Date:   Wed, 21 Oct 2020 12:32:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <06bf0e094463533e7aec6900bddd435171e9f44f.1602517171.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 12/10/2020 à 17:39, Christophe Leroy a écrit :
> On the same principle as commit 773edeadf672 ("powerpc/mm: Add mask
> of possible MMU features"), add mask for MMU features that are
> always there in order to optimise out dead branches.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Features must be anded with MMU_FTRS_POSSIBLE instead of ~0, otherwise
>      MMU_FTRS_ALWAYS is ~0 when no #ifdef matches.

This is still not enough. For BOOK3S/32, MMU_FTRS_POSSIBLE is still too much.
We need a #ifdef CONFIG_PPC_BOOK3S_32 with 0.

Christophe

> ---
>   arch/powerpc/include/asm/mmu.h | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
> index 255a1837e9f7..64e7e7f7cda9 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -201,8 +201,30 @@ enum {
>   		0,
>   };
>   
> +enum {
> +	MMU_FTRS_ALWAYS =
> +#ifdef CONFIG_PPC_8xx
> +		MMU_FTR_TYPE_8xx &
> +#endif
> +#ifdef CONFIG_40x
> +		MMU_FTR_TYPE_40x &
> +#endif
> +#ifdef CONFIG_PPC_47x
> +		MMU_FTR_TYPE_47x &
> +#elif defined(CONFIG_44x)
> +		MMU_FTR_TYPE_44x &
> +#endif
> +#if defined(CONFIG_E200) || defined(CONFIG_E500)
> +		MMU_FTR_TYPE_FSL_E &
> +#endif
> +		MMU_FTRS_POSSIBLE,
> +};
> +
>   static inline bool early_mmu_has_feature(unsigned long feature)
>   {
> +	if (MMU_FTRS_ALWAYS & feature)
> +		return true;
> +
>   	return !!(MMU_FTRS_POSSIBLE & cur_cpu_spec->mmu_features & feature);
>   }
>   
> @@ -231,6 +253,9 @@ static __always_inline bool mmu_has_feature(unsigned long feature)
>   	}
>   #endif
>   
> +	if (MMU_FTRS_ALWAYS & feature)
> +		return true;
> +
>   	if (!(MMU_FTRS_POSSIBLE & feature))
>   		return false;
>   
> 
