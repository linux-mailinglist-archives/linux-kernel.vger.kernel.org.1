Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F251A28C932
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 09:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbgJMH0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 03:26:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:3795 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389874AbgJMH0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 03:26:06 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C9Rt20RnVz9ty2y;
        Tue, 13 Oct 2020 09:26:02 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id q8TQQma3hDCz; Tue, 13 Oct 2020 09:26:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C9Rt167Kgz9ty2x;
        Tue, 13 Oct 2020 09:26:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 651348B7A2;
        Tue, 13 Oct 2020 09:26:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FSV7VUvim1I2; Tue, 13 Oct 2020 09:26:02 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BC918B79A;
        Tue, 13 Oct 2020 09:26:01 +0200 (CEST)
Subject: Re: [PATCH] powerpc/features: Remove CPU_FTR_NODSISRALIGN
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0346768708b69bdbfec82f6e5b0364962b9b6932.1602489812.git.christophe.leroy@csgroup.eu>
 <875z7ea8t7.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <cb22e9a8-4a8c-38d9-66f1-24af5ebd7520@csgroup.eu>
Date:   Tue, 13 Oct 2020 09:25:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <875z7ea8t7.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/10/2020 à 09:23, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> CPU_FTR_NODSISRALIGN has not been used since
>> commit 31bfdb036f12 ("powerpc: Use instruction emulation
>> infrastructure to handle alignment faults")
>>
>> Remove it.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/include/asm/cputable.h | 22 ++++++++++------------
>>   arch/powerpc/kernel/dt_cpu_ftrs.c   |  8 --------
>>   arch/powerpc/kernel/prom.c          |  2 +-
>>   3 files changed, 11 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
>> index 9780c55f9811..accdc1286f37 100644
>> --- a/arch/powerpc/include/asm/cputable.h
>> +++ b/arch/powerpc/include/asm/cputable.h
>> @@ -137,7 +137,6 @@ static inline void cpu_feature_keys_init(void) { }
>>   #define CPU_FTR_DBELL			ASM_CONST(0x00000004)
>>   #define CPU_FTR_CAN_NAP			ASM_CONST(0x00000008)
>>   #define CPU_FTR_DEBUG_LVL_EXC		ASM_CONST(0x00000010)
>> -#define CPU_FTR_NODSISRALIGN		ASM_CONST(0x00000020)
>>   #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x00000040)
>>   #define CPU_FTR_LWSYNC			ASM_CONST(0x00000080)
>>   #define CPU_FTR_NOEXECUTE		ASM_CONST(0x00000100)
>> @@ -219,7 +218,7 @@ static inline void cpu_feature_keys_init(void) { }
>>   
>>   #ifndef __ASSEMBLY__
>>   
>> -#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN)
>> +#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE)
>>   
>>   #define MMU_FTR_PPCAS_ARCH_V2 	(MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE)
>>   
>> @@ -378,33 +377,33 @@ static inline void cpu_feature_keys_init(void) { }
>>   	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE  | CPU_FTR_NOEXECUTE)
>>   #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON)
>>   #define CPU_FTRS_8XX	(CPU_FTR_NOEXECUTE)
>> -#define CPU_FTRS_40X	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
>> -#define CPU_FTRS_44X	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
>> -#define CPU_FTRS_440x6	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE | \
>> +#define CPU_FTRS_40X	(CPU_FTR_NOEXECUTE)
>> +#define CPU_FTRS_44X	(CPU_FTR_NOEXECUTE)
>> +#define CPU_FTRS_440x6	(CPU_FTR_NOEXECUTE | \
>>   	    CPU_FTR_INDEXED_DCR)
>>   #define CPU_FTRS_47X	(CPU_FTRS_440x6)
>>   #define CPU_FTRS_E200	(CPU_FTR_SPE_COMP | \
>> -	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
>> +	    CPU_FTR_COHERENT_ICACHE | \
>>   	    CPU_FTR_NOEXECUTE | \
>>   	    CPU_FTR_DEBUG_LVL_EXC)
>>   #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | \
>> -	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
>> +	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | \
>>   	    CPU_FTR_NOEXECUTE)
>>   #define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | \
>>   	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | \
>> -	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
>> -#define CPU_FTRS_E500MC	(CPU_FTR_NODSISRALIGN | \
>> +	    CPU_FTR_NOEXECUTE)
>> +#define CPU_FTRS_E500MC	( \
>>   	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
>>   	    CPU_FTR_DBELL | CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
>>   /*
>>    * e5500/e6500 erratum A-006958 is a timebase bug that can use the
>>    * same workaround as CPU_FTR_CELL_TB_BUG.
>>    */
>> -#define CPU_FTRS_E5500	(CPU_FTR_NODSISRALIGN | \
>> +#define CPU_FTRS_E5500	( \
>>   	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
>>   	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
>>   	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_CELL_TB_BUG)
>> -#define CPU_FTRS_E6500	(CPU_FTR_NODSISRALIGN | \
>> +#define CPU_FTRS_E6500	( \
>>   	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
>>   	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
>>   	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
>> @@ -554,7 +553,6 @@ enum {
>>   #define CPU_FTRS_DT_CPU_BASE			\
>>   	(CPU_FTR_LWSYNC |			\
>>   	 CPU_FTR_FPU_UNAVAILABLE |		\
>> -	 CPU_FTR_NODSISRALIGN |			\
>>   	 CPU_FTR_NOEXECUTE |			\
>>   	 CPU_FTR_COHERENT_ICACHE |		\
>>   	 CPU_FTR_STCX_CHECKS_ADDRESS |		\
>> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> index 1098863e17ee..c598961d9f15 100644
>> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
>> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
>> @@ -273,13 +273,6 @@ static int __init feat_enable_idle_nap(struct dt_cpu_feature *f)
>>   	return 1;
>>   }
>>   
>> -static int __init feat_enable_align_dsisr(struct dt_cpu_feature *f)
>> -{
>> -	cur_cpu_spec->cpu_features &= ~CPU_FTR_NODSISRALIGN;
>> -
>> -	return 1;
>> -}
>> -
>>   static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
>>   {
>>   	u64 lpcr;
>> @@ -641,7 +634,6 @@ static struct dt_cpu_feature_match __initdata
>>   	{"tm-suspend-hypervisor-assist", feat_enable, CPU_FTR_P9_TM_HV_ASSIST},
>>   	{"tm-suspend-xer-so-bug", feat_enable, CPU_FTR_P9_TM_XER_SO_BUG},
>>   	{"idle-nap", feat_enable_idle_nap, 0},
>> -	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
>>   	{"idle-stop", feat_enable_idle_stop, 0},
>>   	{"machine-check-power8", feat_enable_mce_power8, 0},
>>   	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index c1545f22c077..a5a5acb627fe 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -165,7 +165,7 @@ static struct ibm_pa_feature {
>>   #ifdef CONFIG_PPC_RADIX_MMU
>>   	{ .pabyte = 40, .pabit = 0, .mmu_features  = MMU_FTR_TYPE_RADIX | MMU_FTR_GTSE },
>>   #endif
>> -	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features = CPU_FTR_NODSISRALIGN },
>> +	{ .pabyte = 1,  .pabit = 1, .invert = 1, },
>>   	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
>>   				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
> 
> I didn't follow this change. Should the line be dropped?
> 

Don't know. I have to look closer, I don't know what it is used for.

Christophe
