Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C7128CC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 13:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388050AbgJMLLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 07:11:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:35282 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730427AbgJMLL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 07:11:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C9Xt06ppGz9tyJ6;
        Tue, 13 Oct 2020 13:11:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 099tqmx7-Qeg; Tue, 13 Oct 2020 13:11:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C9Xt05zS3z9tyJ1;
        Tue, 13 Oct 2020 13:11:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1DCC88B7B0;
        Tue, 13 Oct 2020 13:11:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kuv8l0jP_LWq; Tue, 13 Oct 2020 13:11:22 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B99258B7A7;
        Tue, 13 Oct 2020 13:11:21 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9D74166446; Tue, 13 Oct 2020 11:11:21 +0000 (UTC)
Message-Id: <05d98136b24bbf11525445414bb18cffe2724f48.1602587470.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4fc9e30b2b09933c8dfd7a50924dfbdf9ea6a80f.1602587470.git.christophe.leroy@csgroup.eu>
References: <4fc9e30b2b09933c8dfd7a50924dfbdf9ea6a80f.1602587470.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/2] powerpc/feature: Remove CPU_FTR_NODSISRALIGN
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 13 Oct 2020 11:11:21 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU_FTR_NODSISRALIGN has not been used since
commit 31bfdb036f12 ("powerpc: Use instruction emulation
infrastructure to handle alignment faults")

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2:
- Applying atfer the removal of CPU_FTRS_GENERIC_32 which remove one use of CPU_FTR_NODSISRALIGN
- Replaced the entry in dt_cpu_feature_match_table[] by a comment instead of removing it blindly.
- Removed the entry in ibm_pa_features[] instead of only clearing the feature bit.
---
 arch/powerpc/include/asm/cputable.h | 22 ++++++++++------------
 arch/powerpc/kernel/dt_cpu_ftrs.c   |  9 +--------
 arch/powerpc/kernel/prom.c          |  1 -
 3 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index c596bab134e2..0101d5d9d4a6 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -137,7 +137,6 @@ static inline void cpu_feature_keys_init(void) { }
 #define CPU_FTR_DBELL			ASM_CONST(0x00000004)
 #define CPU_FTR_CAN_NAP			ASM_CONST(0x00000008)
 #define CPU_FTR_DEBUG_LVL_EXC		ASM_CONST(0x00000010)
-#define CPU_FTR_NODSISRALIGN		ASM_CONST(0x00000020)
 #define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x00000040)
 #define CPU_FTR_LWSYNC			ASM_CONST(0x00000080)
 #define CPU_FTR_NOEXECUTE		ASM_CONST(0x00000100)
@@ -219,7 +218,7 @@ static inline void cpu_feature_keys_init(void) { }
 
 #ifndef __ASSEMBLY__
 
-#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN)
+#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE)
 
 #define MMU_FTR_PPCAS_ARCH_V2 	(MMU_FTR_TLBIEL | MMU_FTR_16M_PAGE)
 
@@ -378,33 +377,33 @@ static inline void cpu_feature_keys_init(void) { }
 	    CPU_FTR_COMMON | CPU_FTR_FPU_UNAVAILABLE  | CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_CLASSIC32	(CPU_FTR_COMMON)
 #define CPU_FTRS_8XX	(CPU_FTR_NOEXECUTE)
-#define CPU_FTRS_40X	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
-#define CPU_FTRS_44X	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
-#define CPU_FTRS_440x6	(CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE | \
+#define CPU_FTRS_40X	(CPU_FTR_NOEXECUTE)
+#define CPU_FTRS_44X	(CPU_FTR_NOEXECUTE)
+#define CPU_FTRS_440x6	(CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_INDEXED_DCR)
 #define CPU_FTRS_47X	(CPU_FTRS_440x6)
 #define CPU_FTRS_E200	(CPU_FTR_SPE_COMP | \
-	    CPU_FTR_NODSISRALIGN | CPU_FTR_COHERENT_ICACHE | \
+	    CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DEBUG_LVL_EXC)
 #define CPU_FTRS_E500	(CPU_FTR_MAYBE_CAN_DOZE | \
-	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
+	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | \
 	    CPU_FTR_NOEXECUTE)
 #define CPU_FTRS_E500_2	(CPU_FTR_MAYBE_CAN_DOZE | \
 	    CPU_FTR_SPE_COMP | CPU_FTR_MAYBE_CAN_NAP | \
-	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
-#define CPU_FTRS_E500MC	(CPU_FTR_NODSISRALIGN | \
+	    CPU_FTR_NOEXECUTE)
+#define CPU_FTRS_E500MC	( \
 	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV)
 /*
  * e5500/e6500 erratum A-006958 is a timebase bug that can use the
  * same workaround as CPU_FTR_CELL_TB_BUG.
  */
-#define CPU_FTRS_E5500	(CPU_FTR_NODSISRALIGN | \
+#define CPU_FTRS_E5500	( \
 	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_CELL_TB_BUG)
-#define CPU_FTRS_E6500	(CPU_FTR_NODSISRALIGN | \
+#define CPU_FTRS_E6500	( \
 	    CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_DEBUG_LVL_EXC | CPU_FTR_EMB_HV | CPU_FTR_ALTIVEC_COMP | \
@@ -554,7 +553,6 @@ enum {
 #define CPU_FTRS_DT_CPU_BASE			\
 	(CPU_FTR_LWSYNC |			\
 	 CPU_FTR_FPU_UNAVAILABLE |		\
-	 CPU_FTR_NODSISRALIGN |			\
 	 CPU_FTR_NOEXECUTE |			\
 	 CPU_FTR_COHERENT_ICACHE |		\
 	 CPU_FTR_STCX_CHECKS_ADDRESS |		\
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 1098863e17ee..e15fe7f337ba 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -273,13 +273,6 @@ static int __init feat_enable_idle_nap(struct dt_cpu_feature *f)
 	return 1;
 }
 
-static int __init feat_enable_align_dsisr(struct dt_cpu_feature *f)
-{
-	cur_cpu_spec->cpu_features &= ~CPU_FTR_NODSISRALIGN;
-
-	return 1;
-}
-
 static int __init feat_enable_idle_stop(struct dt_cpu_feature *f)
 {
 	u64 lpcr;
@@ -641,7 +634,7 @@ static struct dt_cpu_feature_match __initdata
 	{"tm-suspend-hypervisor-assist", feat_enable, CPU_FTR_P9_TM_HV_ASSIST},
 	{"tm-suspend-xer-so-bug", feat_enable, CPU_FTR_P9_TM_XER_SO_BUG},
 	{"idle-nap", feat_enable_idle_nap, 0},
-	{"alignment-interrupt-dsisr", feat_enable_align_dsisr, 0},
+	/* alignment-interrupt-dsisr ignored */
 	{"idle-stop", feat_enable_idle_stop, 0},
 	{"machine-check-power8", feat_enable_mce_power8, 0},
 	{"performance-monitor-power8", feat_enable_pmu_power8, 0},
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index c1545f22c077..ae3c41730367 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -165,7 +165,6 @@ static struct ibm_pa_feature {
 #ifdef CONFIG_PPC_RADIX_MMU
 	{ .pabyte = 40, .pabit = 0, .mmu_features  = MMU_FTR_TYPE_RADIX | MMU_FTR_GTSE },
 #endif
-	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features = CPU_FTR_NODSISRALIGN },
 	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
 				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
 	/*
-- 
2.25.0

