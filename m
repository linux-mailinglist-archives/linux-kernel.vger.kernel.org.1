Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87627A008
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgI0JRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:17:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61576 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgI0JQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg4c2PmKz9vCy2;
        Sun, 27 Sep 2020 11:16:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OvIQZTNXh6gz; Sun, 27 Sep 2020 11:16:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg4c1XKlz9vCxw;
        Sun, 27 Sep 2020 11:16:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 873FB8B771;
        Sun, 27 Sep 2020 11:16:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3FYPV4w7pxpa; Sun, 27 Sep 2020 11:16:20 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 43B938B75B;
        Sun, 27 Sep 2020 11:16:20 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2890365DE8; Sun, 27 Sep 2020 09:16:20 +0000 (UTC)
Message-Id: <472734be0d9991eee320a06824219a5b2663736b.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 03/30] powerpc/vdso: Rename syscall_map_32/64 to simplify
 vdso_setup_syscall_map()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:20 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today vdso_data structure has:
- syscall_map_32[] and syscall_map_64[] on PPC64
- syscall_map_32[] on PPC32

On PPC32, syscall_map_32[] is populated using sys_call_table[].

On PPC64, syscall_map_64[] is populated using sys_call_table[]
and syscal_map_32[] is populated using compat_sys_call_table[].

To simplify vdso_setup_syscall_map(),
- On PPC32 rename syscall_map_32[] into syscall_map[],
- On PPC64 rename syscall_map_64[] into syscall_map[],
- On PPC64 rename syscall_map_32[] into compat_syscall_map[].

That way, syscall_map[] gets populated using sys_call_table[] and
compat_syscall_map[] gets population using compat_sys_call_table[].

Also define an empty compat_syscall_map[] on PPC32 to avoid ifdefs.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso_datapage.h |  7 ++++---
 arch/powerpc/kernel/asm-offsets.c        |  6 ++++--
 arch/powerpc/kernel/vdso.c               | 12 ++----------
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index c4d320504d26..3d996db05acd 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -79,8 +79,8 @@ struct vdso_arch_data {
 	__u32 icache_block_size;		/* L1 i-cache block size     */
 	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
 	__u32 icache_log_block_size;		/* L1 i-cache log block size */
-   	__u32 syscall_map_64[SYSCALL_MAP_SIZE]; /* map of syscalls  */
-   	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
+	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
+	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
 
 	struct vdso_data data[CS_BASES];
 };
@@ -92,7 +92,8 @@ struct vdso_arch_data {
  */
 struct vdso_arch_data {
 	__u64 tb_ticks_per_sec;		/* Timebase tics / sec		0x38 */
-   	__u32 syscall_map_32[SYSCALL_MAP_SIZE]; /* map of syscalls */
+	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
+	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
 	struct vdso_data data[CS_BASES];
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 684260186dbf..e48043087208 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -399,13 +399,15 @@ int main(void)
 	/* datapage offsets for use by vdso */
 	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
 	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
-	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map_32);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
 	OFFSET(CFG_DCACHE_BLOCKSZ, vdso_arch_data, dcache_block_size);
 	OFFSET(CFG_ICACHE_LOGBLOCKSZ, vdso_arch_data, icache_log_block_size);
 	OFFSET(CFG_DCACHE_LOGBLOCKSZ, vdso_arch_data, dcache_log_block_size);
-	OFFSET(CFG_SYSCALL_MAP64, vdso_arch_data, syscall_map_64);
+	OFFSET(CFG_SYSCALL_MAP64, vdso_arch_data, syscall_map);
+	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, compat_syscall_map);
+#else
+	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map);
 #endif
 
 #ifdef CONFIG_BUG
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index b0332c609104..6d106fcafb9e 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -643,19 +643,11 @@ static void __init vdso_setup_syscall_map(void)
 	unsigned int i;
 
 	for (i = 0; i < NR_syscalls; i++) {
-#ifdef CONFIG_PPC64
 		if (sys_call_table[i] != (unsigned long)&sys_ni_syscall)
-			vdso_data->syscall_map_64[i >> 5] |=
-				0x80000000UL >> (i & 0x1f);
+			vdso_data->syscall_map[i >> 5] |= 0x80000000UL >> (i & 0x1f);
 		if (IS_ENABLED(CONFIG_COMPAT) &&
 		    compat_sys_call_table[i] != (unsigned long)&sys_ni_syscall)
-			vdso_data->syscall_map_32[i >> 5] |=
-				0x80000000UL >> (i & 0x1f);
-#else /* CONFIG_PPC64 */
-		if (sys_call_table[i] != (unsigned long)&sys_ni_syscall)
-			vdso_data->syscall_map_32[i >> 5] |=
-				0x80000000UL >> (i & 0x1f);
-#endif /* CONFIG_PPC64 */
+			vdso_data->compat_syscall_map[i >> 5] |= 0x80000000UL >> (i & 0x1f);
 	}
 }
 
-- 
2.25.0

