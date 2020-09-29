Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A313827BD58
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 08:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgI2Gst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 02:48:49 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:25419 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727422AbgI2Gsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 02:48:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C0qjL6l32z9v2cQ;
        Tue, 29 Sep 2020 08:48:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id F3MwH_Ln5k8e; Tue, 29 Sep 2020 08:48:38 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C0qjL4G8Kz9v2c7;
        Tue, 29 Sep 2020 08:48:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BD358B79F;
        Tue, 29 Sep 2020 08:48:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Kz0F3K92a1fH; Tue, 29 Sep 2020 08:48:39 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 541EA8B76C;
        Tue, 29 Sep 2020 08:48:39 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3540465E8A; Tue, 29 Sep 2020 06:48:39 +0000 (UTC)
Message-Id: <3e8a13ee83418630c753c30cb722ae682d5b2d39.1601362098.git.christophe.leroy@csgroup.eu>
In-Reply-To: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601362098.git.christophe.leroy@csgroup.eu>
References: <27951fa6c9a8f80724d1bc81a6117ac32343a55d.1601362098.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v3 8/8] powerpc: Remove get_tb_or_rtc()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Sep 2020 06:48:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

601 is gone, get_tb_or_rtc() is equivalent to get_tb().

Replace the former by the later.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/time.h | 5 -----
 arch/powerpc/kernel/irq.c       | 2 +-
 arch/powerpc/kernel/time.c      | 6 +++---
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index caf68a4bc19e..410ed72eef1c 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -85,11 +85,6 @@ static inline u64 get_tb(void)
 }
 #endif /* !CONFIG_PPC64 */
 
-static inline u64 get_tb_or_rtc(void)
-{
-	return get_tb();
-}
-
 static inline void set_tb(unsigned int upper, unsigned int lower)
 {
 	mtspr(SPRN_TBWL, 0);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index bf21ebd36190..2d188f81ebdb 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -104,7 +104,7 @@ static inline notrace unsigned long get_irq_happened(void)
 
 static inline notrace int decrementer_check_overflow(void)
 {
- 	u64 now = get_tb_or_rtc();
+	u64 now = get_tb();
 	u64 *next_tb = this_cpu_ptr(&decrementers_next_tb);
  
 	return now >= *next_tb;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 13c820c15d37..760ea359a7f7 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -595,7 +595,7 @@ void timer_interrupt(struct pt_regs *regs)
 		irq_work_run();
 	}
 
-	now = get_tb_or_rtc();
+	now = get_tb();
 	if (now >= *next_tb) {
 		*next_tb = ~(u64)0;
 		if (evt->event_handler)
@@ -937,7 +937,7 @@ static void __init clocksource_init(void)
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev)
 {
-	__this_cpu_write(decrementers_next_tb, get_tb_or_rtc() + evt);
+	__this_cpu_write(decrementers_next_tb, get_tb() + evt);
 	set_dec(evt);
 
 	/* We may have raced with new irq work */
@@ -1071,7 +1071,7 @@ void __init time_init(void)
 	tb_to_ns_scale = scale;
 	tb_to_ns_shift = shift;
 	/* Save the current timebase to pretty up CONFIG_PRINTK_TIME */
-	boot_tb = get_tb_or_rtc();
+	boot_tb = get_tb();
 
 	/* If platform provided a timezone (pmac), we correct the time */
 	if (timezone_offset) {
-- 
2.25.0

