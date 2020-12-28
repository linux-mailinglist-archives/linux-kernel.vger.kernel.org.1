Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C801F2E36C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 12:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgL1Lyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 06:54:39 -0500
Received: from www.zeus03.de ([194.117.254.33]:51840 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgL1Lyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 06:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=GVdOtH335TkaH5kygu3p2MNtTpP
        ay4NkZzKJpxUzzg8=; b=nD8hTNytL3Mr0yFgxJzOHgNT8h3jK5hrn8npyPv25BJ
        0u1pcoeF38t6EOegfH5r9UvJ16DsdOqpwTwAc1yzVICIphjumyMFQgre1VzPh7wg
        R6HF/F1xW9fo2CPo6rdXEUDAhpu01ozKhy3O4Ei6SPXjX3ZwkZ0OEnaMTremZwQc
        =
Received: (qmail 1745226 invoked from network); 28 Dec 2020 12:53:56 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Dec 2020 12:53:56 +0100
X-UD-Smtp-Session: l3s3148p1@NbvF7YS3CpUgAwDPXwIpAOUwDQytQs2L
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: smp: remove unused variable
Date:   Mon, 28 Dec 2020 12:53:48 +0100
Message-Id: <20201228115349.57334-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used anymore after refactoring:

arch/arm64/kernel/smp.c: In function ‘arch_show_interrupts’:
arch/arm64/kernel/smp.c:810:16: warning: unused variable ‘irq’ [-Wunused-variable]
  810 |   unsigned int irq = irq_desc_get_irq(ipi_desc[i]);

Fixes: 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 6bc3a3698c3d..376343d6f13a 100644
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
2.29.2

