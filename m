Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA49F2D416C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgLILwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:52:05 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:63180 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbgLILvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:51:47 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Crb3W3LDYz9vBMV;
        Wed,  9 Dec 2020 12:51:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PpTAKL4yDMRD; Wed,  9 Dec 2020 12:51:03 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Crb3W2CJGz9vBMT;
        Wed,  9 Dec 2020 12:51:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1CC498B7E6;
        Wed,  9 Dec 2020 12:51:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NZt4qmfxD-eb; Wed,  9 Dec 2020 12:51:04 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6657E8B7DB;
        Wed,  9 Dec 2020 12:51:03 +0100 (CET)
Subject: Re: [PATCH v1 2/6] powerpc/8xx: Always pin kernel text TLB
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
 <203b89de491e1379f1677a2685211b7c32adfff0.1606231483.git.christophe.leroy@csgroup.eu>
 <87lfe7s1j3.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a726961f-f440-b553-6c46-341a860dc90a@csgroup.eu>
Date:   Wed, 9 Dec 2020 12:50:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <87lfe7s1j3.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 09/12/2020 à 11:43, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> There is no big poing in not pinning kernel text anymore, as now
>> we can keep pinned TLB even with things like DEBUG_PAGEALLOC.
>>
>> Remove CONFIG_PIN_TLB_TEXT, making it always right.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/Kconfig               |  3 +--
>>   arch/powerpc/kernel/head_8xx.S     | 20 +++-----------------
>>   arch/powerpc/mm/nohash/8xx.c       |  3 +--
>>   arch/powerpc/platforms/8xx/Kconfig |  7 -------
>>   4 files changed, 5 insertions(+), 28 deletions(-)
>>
> ...
>> diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
>> index 231ca95f9ffb..19a3eec1d8c5 100644
>> --- a/arch/powerpc/mm/nohash/8xx.c
>> +++ b/arch/powerpc/mm/nohash/8xx.c
>> @@ -186,8 +186,7 @@ void mmu_mark_initmem_nx(void)
>>   	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, false);
>>   	mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
>>   
>> -	if (IS_ENABLED(CONFIG_PIN_TLB_TEXT))
>> -		mmu_pin_tlb(block_mapped_ram, false);
>> +	mmu_pin_tlb(block_mapped_ram, false);
>>   }
> 
> This broke mpc885_ads_defconfig with:

:surprise:

How did I get it working ? Anyway, thanks for fixing it.

Christophe


> 
>    ld: arch/powerpc/mm/nohash/8xx.o: in function `mmu_mark_initmem_nx':
>    /home/michael/linux/arch/powerpc/mm/nohash/8xx.c:189: undefined reference to `mmu_pin_tlb'
>    make[1]: *** [/home/michael/linux/Makefile:1164: vmlinux] Error 1
>    make: *** [Makefile:185: __sub-make] Error 2
> 
> Fixed by:
> 
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 35707e86c5f3..52702f3db6df 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -702,7 +702,6 @@ FixupDAR:/* Entry point for dcbx workaround. */
>   	mtspr	SPRN_DER, r8
>   	blr
>   
> -#ifdef CONFIG_PIN_TLB
>   _GLOBAL(mmu_pin_tlb)
>   	lis	r9, (1f - PAGE_OFFSET)@h
>   	ori	r9, r9, (1f - PAGE_OFFSET)@l
> @@ -802,7 +801,6 @@ _GLOBAL(mmu_pin_tlb)
>   	mtspr	SPRN_SRR1, r10
>   	mtspr	SPRN_SRR0, r11
>   	rfi
> -#endif /* CONFIG_PIN_TLB */
>   
>   /*
>    * We put a few things here that have to be page-aligned.
> 
> 
> cheers
> 
