Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412522E191A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgLWGsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:48:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:30565 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgLWGsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:48:53 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D13gY3z92z9v0Pt;
        Wed, 23 Dec 2020 07:48:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id c4hFcbjmvPbH; Wed, 23 Dec 2020 07:48:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D13gY2VkQz9v0Ps;
        Wed, 23 Dec 2020 07:48:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3A9A58B783;
        Wed, 23 Dec 2020 07:48:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SMRvtiXKDCs8; Wed, 23 Dec 2020 07:48:10 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ADDED8B75F;
        Wed, 23 Dec 2020 07:48:09 +0100 (CET)
Subject: Re: [PATCH] powerpc/32s: Fix RTAS machine check with VMAP stack
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu>
Message-ID: <6ed0b74d-8d01-4a20-faed-891496fb77b4@csgroup.eu>
Date:   Wed, 23 Dec 2020 07:48:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bc77d61d1c18940e456a2dee464f1e2eda65a3f0.1608621048.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 22/12/2020 à 08:11, Christophe Leroy a écrit :
> When we have VMAP stack, exception prolog 1 sets r1, not r11.

But exception prolog 1 uses r1 to setup r1 when machine check happens in kernel.
So r1 must be restored when the branch is not taken. See subsequent patch I just sent out.

Christophe

> 
> Fixes: da7bb43ab9da ("powerpc/32: Fix vmap stack - Properly set r1 before activating MMU")
> Fixes: d2e006036082 ("powerpc/32: Use SPRN_SPRG_SCRATCH2 in exception prologs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/kernel/head_book3s_32.S | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
> index 349bf3f0c3af..fbc48a500846 100644
> --- a/arch/powerpc/kernel/head_book3s_32.S
> +++ b/arch/powerpc/kernel/head_book3s_32.S
> @@ -260,9 +260,16 @@ __secondary_hold_acknowledge:
>   MachineCheck:
>   	EXCEPTION_PROLOG_0
>   #ifdef CONFIG_PPC_CHRP
> +#ifdef CONFIG_VMAP_STACK
> +	mtspr	SPRN_SPRG_SCRATCH2,r1
> +	mfspr	r1, SPRN_SPRG_THREAD
> +	lwz	r1, RTAS_SP(r1)
> +	cmpwi	cr1, r1, 0
> +#else
>   	mfspr	r11, SPRN_SPRG_THREAD
>   	lwz	r11, RTAS_SP(r11)
>   	cmpwi	cr1, r11, 0
> +#endif
>   	bne	cr1, 7f
>   #endif /* CONFIG_PPC_CHRP */
>   	EXCEPTION_PROLOG_1 for_rtas=1
> 
