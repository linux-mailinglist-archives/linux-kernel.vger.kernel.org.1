Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A922D2AA5FC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 15:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgKGObz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 09:31:55 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:42279 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbgKGOby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 09:31:54 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CT07q4nCKz9tygW;
        Sat,  7 Nov 2020 15:31:51 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id DsY-2jS-mUj0; Sat,  7 Nov 2020 15:31:51 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CT07q3VJ6z9tygV;
        Sat,  7 Nov 2020 15:31:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE1078B778;
        Sat,  7 Nov 2020 15:31:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id i14aiMwmoye9; Sat,  7 Nov 2020 15:31:52 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F0A98B75B;
        Sat,  7 Nov 2020 15:31:52 +0100 (CET)
Subject: Re: [PATCH] powerpc/64s: Remove RFI
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <fe28c9c37c43f2647c0590cc1b3c9d593f60bd86.1604662224.git.christophe.leroy@csgroup.eu>
Message-ID: <d4da61ab-0f9d-ba20-f17f-20aa45646a97@csgroup.eu>
Date:   Sat, 7 Nov 2020 15:31:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <fe28c9c37c43f2647c0590cc1b3c9d593f60bd86.1604662224.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/11/2020 à 12:36, Christophe Leroy a écrit :
> Last use of RFI on PPC64 was removed by
> commit b8e90cb7bc04 ("powerpc/64: Convert the syscall exit path to
> use RFI_TO_USER/KERNEL").
> 
> Remove the macro.

Forget this crazy patch. I missed two RFI in head_64.S ....

Christophe

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/include/asm/ppc_asm.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/ppc_asm.h
> index 511786f0e40d..bedf3eb52ebc 100644
> --- a/arch/powerpc/include/asm/ppc_asm.h
> +++ b/arch/powerpc/include/asm/ppc_asm.h
> @@ -495,7 +495,6 @@ END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_BUG, CPU_FTR_CELL_TB_BUG, 96)
>   #endif
>   
>   #ifdef CONFIG_PPC_BOOK3S_64
> -#define RFI		rfid
>   #define MTMSRD(r)	mtmsrd	r
>   #define MTMSR_EERI(reg)	mtmsrd	reg,1
>   #else
> 
