Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070C12E6EE3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 09:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL2ISj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 03:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgL2ISi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 03:18:38 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A4C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 00:17:57 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id A8Hr2400a4C55Sk018HrBb; Tue, 29 Dec 2020 09:17:55 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kuACV-000vOA-Bz; Tue, 29 Dec 2020 09:17:51 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kuACU-006QD1-Te; Tue, 29 Dec 2020 09:17:50 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] arm64/smp: Remove unused irq variable in arch_show_interrupts()
Date:   Tue, 29 Dec 2020 09:17:48 +0100
Message-Id: <20201229081748.1530671-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    arch/arm64/kernel/smp.c: In function ‘arch_show_interrupts’:
    arch/arm64/kernel/smp.c:808:16: warning: unused variable ‘irq’ [-Wunused-variable]
      808 |   unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
	  |                ^~~

The removal of the last user forgot to remove the variable.

Fixes: 5089bc51f81f05ad ("arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Update Fixes tag, as the offending commit was rebased just before
    being sent upstream.

 arch/arm64/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6bc3a3698c3d1ea9..376343d6f13aec5d 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -807,7 +807,6 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	unsigned int cpu, i;
 
 	for (i = 0; i < NR_IPI; i++) {
-		unsigned int irq = irq_desc_get_irq(ipi_desc[i]);
 		seq_printf(p, "%*s%u:%s", prec - 1, "IPI", i,
 			   prec >= 4 ? " " : "");
 		for_each_online_cpu(cpu)
-- 
2.25.1

