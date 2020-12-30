Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE112E7A99
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 16:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgL3PqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 10:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgL3PqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 10:46:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A39B21D1B;
        Wed, 30 Dec 2020 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609343121;
        bh=P+xne73UctVsVnC1Gr0TZD3UqOR9IIi7bTByxK8n7+0=;
        h=From:To:Cc:Subject:Date:From;
        b=TqzxMtV7+WQSjHIkSNVg3un2pQSVy6qb919XD1hfBTjenNmvf5xdbzXg0d/Nbmoto
         GBlN7oDDjouAI9hgb0q3sq5etgTRWeX+R/r0WXllDtlTOroTykqug7kI9rPyMs7zsB
         hG5AiJMI6kZ9NlfQpNJNDbtMHc6naF0o4xGl69N2ir8mHfSNsG/elFiWQ8MBuaVgG4
         xIOaF7Rycl/+s3eBtNmv7knqoN9WY5EHh/JUKZouGFUrBTBwp+5pafZ8N22amFK82k
         cptXaLMJw8993VE7un1pBEmxa/oQ0i0xbQUU8VjwMdrVV0JMUIvoEC24z5ZOaUQaJa
         8KFVNj+d//jpg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/smp: Remove unused 'irq' variable
Date:   Wed, 30 Dec 2020 16:45:04 +0100
Message-Id: <20201230154516.680413-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only use of this variable was removed in a recent patch:

arch/arm64/kernel/smp.c:810:16: error: unused variable 'irq' [-Werror,-Wunused-variable]
                unsigned int irq = irq_desc_get_irq(ipi_desc[i]);

Fixes: 5089bc51f81f ("arm64/smp: Use irq_desc_kstat_cpu() in arch_show_interrupts()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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

