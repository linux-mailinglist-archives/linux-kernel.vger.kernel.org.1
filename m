Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC1B27A005
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgI0JRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:17:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23034 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgI0JQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg4t5kynz9vCy6;
        Sun, 27 Sep 2020 11:16:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QvLWqxH2Duhc; Sun, 27 Sep 2020 11:16:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg4t50Ffz9vCxw;
        Sun, 27 Sep 2020 11:16:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 25FCE8B771;
        Sun, 27 Sep 2020 11:16:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NfSfdl7Ue1Hx; Sun, 27 Sep 2020 11:16:35 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC4628B75B;
        Sun, 27 Sep 2020 11:16:34 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A216065DE8; Sun, 27 Sep 2020 09:16:34 +0000 (UTC)
Message-Id: <2954526981859ca1ccfcfc7a7c4263920e9ddfcb.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 17/30] powerpc/vdso: Use builtin symbols to locate fixup
 section
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add builtin symbols to locate fixup section and use them
instead of locating sections through elf headers at runtime.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c              | 55 +++++++------------------
 arch/powerpc/kernel/vdso32/vdso32.lds.S |  8 ++++
 arch/powerpc/kernel/vdso64/vdso64.lds.S |  8 ++++
 3 files changed, 30 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 7042e9edfb96..ba2b935a67f6 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -437,6 +437,12 @@ static int __init vdso_do_func_patch64(struct lib32_elfinfo *v32,
 
 #endif /* CONFIG_PPC64 */
 
+#define VDSO_DO_FIXUPS(type, value, bits, sec) do {					\
+	void *__start = (void *)VDSO##bits##_SYMBOL(&vdso##bits##_start, sec##_start);	\
+	void *__end = (void *)VDSO##bits##_SYMBOL(&vdso##bits##_start, sec##_end);	\
+											\
+	do_##type##_fixups((value), __start, __end);					\
+} while (0)
 
 static __init int vdso_do_find_sections(struct lib32_elfinfo *v32,
 					struct lib64_elfinfo *v64)
@@ -533,53 +539,20 @@ static __init int vdso_fixup_datapage(struct lib32_elfinfo *v32,
 static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				      struct lib64_elfinfo *v64)
 {
-	unsigned long size;
-	void *start;
-
 #ifdef CONFIG_PPC64
-	start = find_section64(v64->hdr, "__ftr_fixup", &size);
-	if (start)
-		do_feature_fixups(cur_cpu_spec->cpu_features,
-				  start, start + size);
-
-	start = find_section64(v64->hdr, "__mmu_ftr_fixup", &size);
-	if (start)
-		do_feature_fixups(cur_cpu_spec->mmu_features,
-				  start, start + size);
-
-	start = find_section64(v64->hdr, "__fw_ftr_fixup", &size);
-	if (start)
-		do_feature_fixups(powerpc_firmware_features,
-				  start, start + size);
-
-	start = find_section64(v64->hdr, "__lwsync_fixup", &size);
-	if (start)
-		do_lwsync_fixups(cur_cpu_spec->cpu_features,
-				 start, start + size);
+	VDSO_DO_FIXUPS(feature, cur_cpu_spec->cpu_features, 64, ftr_fixup);
+	VDSO_DO_FIXUPS(feature, cur_cpu_spec->mmu_features, 64, mmu_ftr_fixup);
+	VDSO_DO_FIXUPS(feature, powerpc_firmware_features, 64, fw_ftr_fixup);
+	VDSO_DO_FIXUPS(lwsync, cur_cpu_spec->cpu_features, 64, lwsync_fixup);
 #endif /* CONFIG_PPC64 */
 
 #ifdef CONFIG_VDSO32
-	start = find_section32(v32->hdr, "__ftr_fixup", &size);
-	if (start)
-		do_feature_fixups(cur_cpu_spec->cpu_features,
-				  start, start + size);
-
-	start = find_section32(v32->hdr, "__mmu_ftr_fixup", &size);
-	if (start)
-		do_feature_fixups(cur_cpu_spec->mmu_features,
-				  start, start + size);
-
+	VDSO_DO_FIXUPS(feature, cur_cpu_spec->cpu_features, 32, ftr_fixup);
+	VDSO_DO_FIXUPS(feature, cur_cpu_spec->mmu_features, 32, mmu_ftr_fixup);
 #ifdef CONFIG_PPC64
-	start = find_section32(v32->hdr, "__fw_ftr_fixup", &size);
-	if (start)
-		do_feature_fixups(powerpc_firmware_features,
-				  start, start + size);
+	VDSO_DO_FIXUPS(feature, powerpc_firmware_features, 32, fw_ftr_fixup);
 #endif /* CONFIG_PPC64 */
-
-	start = find_section32(v32->hdr, "__lwsync_fixup", &size);
-	if (start)
-		do_lwsync_fixups(cur_cpu_spec->cpu_features,
-				 start, start + size);
+	VDSO_DO_FIXUPS(lwsync, cur_cpu_spec->cpu_features, 32, lwsync_fixup);
 #endif
 
 	return 0;
diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index a4494a998f58..dd9f262e07c6 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -38,17 +38,25 @@ SECTIONS
 	PROVIDE(etext = .);
 
 	. = ALIGN(8);
+	VDSO_ftr_fixup_start = .;
 	__ftr_fixup	: { *(__ftr_fixup) }
+	VDSO_ftr_fixup_end = .;
 
 	. = ALIGN(8);
+	VDSO_mmu_ftr_fixup_start = .;
 	__mmu_ftr_fixup	: { *(__mmu_ftr_fixup) }
+	VDSO_mmu_ftr_fixup_end = .;
 
 	. = ALIGN(8);
+	VDSO_lwsync_fixup_start = .;
 	__lwsync_fixup	: { *(__lwsync_fixup) }
+	VDSO_lwsync_fixup_end = .;
 
 #ifdef CONFIG_PPC64
 	. = ALIGN(8);
+	VDSO_fw_ftr_fixup_start = .;
 	__fw_ftr_fixup	: { *(__fw_ftr_fixup) }
+	VDSO_fw_ftr_fixup_end = .;
 #endif
 
 	/*
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index 2113bf79ccda..e950bf68783a 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -39,16 +39,24 @@ SECTIONS
 	PROVIDE(etext = .);
 
 	. = ALIGN(8);
+	VDSO_ftr_fixup_start = .;
 	__ftr_fixup	: { *(__ftr_fixup) }
+	VDSO_ftr_fixup_end = .;
 
 	. = ALIGN(8);
+	VDSO_mmu_ftr_fixup_start = .;
 	__mmu_ftr_fixup	: { *(__mmu_ftr_fixup) }
+	VDSO_mmu_ftr_fixup_end = .;
 
 	. = ALIGN(8);
+	VDSO_lwsync_fixup_start = .;
 	__lwsync_fixup	: { *(__lwsync_fixup) }
+	VDSO_lwsync_fixup_end = .;
 
 	. = ALIGN(8);
+	VDSO_fw_ftr_fixup_start = .;
 	__fw_ftr_fixup	: { *(__fw_ftr_fixup) }
+	VDSO_fw_ftr_fixup_end = .;
 
 	/*
 	 * Other stuff is appended to the text segment:
-- 
2.25.0

