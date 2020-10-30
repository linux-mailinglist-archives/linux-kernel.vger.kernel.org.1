Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255DD29FC40
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgJ3DnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:43:04 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:34378 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbgJ3DnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:43:01 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6C7FFC00BE;
        Fri, 30 Oct 2020 03:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604029380; bh=kjSG/8bFRPHkB2CFhnWfjh3ZEfK5o+yA97DGB8dFr8Q=;
        h=From:To:Cc:Subject:Date:From;
        b=BHCZ7qExbozK0aztY3F+sO2bo5sMXt3MQCMvIei+aHMEQmme6f7GoSn5F6N16QbGa
         RNLb4mppRiQ47BkQy46JjM/ycrcLEYjAKERrG7ceL1u8pLcORqsiaqA1tHVqV4x2DR
         yycR2UpJGAcQiQJsvbmtiDy2if7YTifraxJ9emc5QkcoAnQuC9WByhzZjMl4czCIEe
         Xc/fIKrAM79L5Z17Up4+2japJZOJuPXu+EPvlDmx3Njlj9JrVj0m1Qh7aRm9Ne6nHy
         ImAZEcP1QTpb7nagOp2YdYB9guHmyCn+GM5GdLRTDXlh5aHEsXU0BWg217aInhbh91
         icafQBl+WmbRA==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 21938A0072;
        Fri, 30 Oct 2020 03:42:56 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Subject: [PATCH] ARC: [plat-hsdk] Remap CCMs super early in asm boot trampoline
Date:   Thu, 29 Oct 2020 20:42:54 -0700
Message-Id: <20201030034254.4166696-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARC HSDK platform stopped booting on released v5.10-rc1, getting stuck
in startup of non master SMP cores.

This was bisected to upstream commit 7fef431be9c9ac25
"(mm/page_alloc: place pages to tail in __free_pages_core())"
That commit itself is harmless, it just exposed a subtle assumption in
our platform code (hence CC'ing linux-mm just as FYI in case some other
arches / platforms trip on it).

The upstream commit is semantically disruptive as it reverses the order
of page allocations (actually it can be good test for hardware
verification to exercise different memory patterns altogether).
For ARC HSDK platform that meant a remapped memory region (pertaining to
unused Closely Coupled Memory) started getting used early for dynamice
allocations, while not effectively remapped on all the cores, triggering
memory error exception on those cores.

The fix is to move the CCM remapping from early platform code to to early core
boot code. And while it is undesirable to riddle common boot code with
platform quirks, there is no other way to do this since the faltering code
involves setting up stack itself so even function calls are not allowed at
that point.

If anyone is interested, all the gory details can be found at Link below.

Link: https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/32
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/kernel/head.S        | 17 ++++++++++++++++-
 arch/arc/plat-hsdk/platform.c | 17 -----------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 17fd1ed700cc..9152782444b5 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -67,7 +67,22 @@
 	sr	r5, [ARC_REG_LPB_CTRL]
 1:
 #endif /* CONFIG_ARC_LPB_DISABLE */
-#endif
+
+	/* On HSDK, CCMs need to remapped super early */
+#ifdef CONFIG_ARC_SOC_HSDK
+	mov	r6, 0x60000000
+	lr	r5, [ARC_REG_ICCM_BUILD]
+	breq	r5, 0, 1f
+	sr	r6, [ARC_REG_AUX_ICCM]
+1:
+	lr	r5, [ARC_REG_DCCM_BUILD]
+	breq	r5, 0, 2f
+	sr	r6, [ARC_REG_AUX_DCCM]
+2:
+#endif	/* CONFIG_ARC_SOC_HSDK */
+
+#endif	/* CONFIG_ISA_ARCV2 */
+
 	; Config DSP_CTRL properly, so kernel may use integer multiply,
 	; multiply-accumulate, and divide operations
 	DSP_EARLY_INIT
diff --git a/arch/arc/plat-hsdk/platform.c b/arch/arc/plat-hsdk/platform.c
index 0b63fc095b99..b3ea1fa11f87 100644
--- a/arch/arc/plat-hsdk/platform.c
+++ b/arch/arc/plat-hsdk/platform.c
@@ -17,22 +17,6 @@ int arc_hsdk_axi_dmac_coherent __section(".data") = 0;
 
 #define ARC_CCM_UNUSED_ADDR	0x60000000
 
-static void __init hsdk_init_per_cpu(unsigned int cpu)
-{
-	/*
-	 * By default ICCM is mapped to 0x7z while this area is used for
-	 * kernel virtual mappings, so move it to currently unused area.
-	 */
-	if (cpuinfo_arc700[cpu].iccm.sz)
-		write_aux_reg(ARC_REG_AUX_ICCM, ARC_CCM_UNUSED_ADDR);
-
-	/*
-	 * By default DCCM is mapped to 0x8z while this area is used by kernel,
-	 * so move it to currently unused area.
-	 */
-	if (cpuinfo_arc700[cpu].dccm.sz)
-		write_aux_reg(ARC_REG_AUX_DCCM, ARC_CCM_UNUSED_ADDR);
-}
 
 #define ARC_PERIPHERAL_BASE	0xf0000000
 #define CREG_BASE		(ARC_PERIPHERAL_BASE + 0x1000)
@@ -339,5 +323,4 @@ static const char *hsdk_compat[] __initconst = {
 MACHINE_START(SIMULATION, "hsdk")
 	.dt_compat	= hsdk_compat,
 	.init_early     = hsdk_init_early,
-	.init_per_cpu	= hsdk_init_per_cpu,
 MACHINE_END
-- 
2.25.1

