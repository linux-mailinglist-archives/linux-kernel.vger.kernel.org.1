Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3839529922D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785702AbgJZQU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:20:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785696AbgJZQU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:20:28 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544D122450;
        Mon, 26 Oct 2020 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603729227;
        bh=G33hCKwQFU1BcEHKW6aHNcvL1mubaR9dMFFJesMH4nc=;
        h=From:To:Cc:Subject:Date:From;
        b=tR1vPb0Hr6QzXDfN/V/723l4FdFYCVw9Q0n9fnqSybeQgECamAbIBtWVOIbpasZ0g
         uLllkBe5a08Y6zc/RAVffOohO7jjrVZAWAwet6tvkBcpnRbu85MD+lmRutjfeVFA4X
         UljafwYFbbA7Vfs7T8bIyT9z6js96Ao8u2abkveg=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] irqdomain: fix -Wshadow warning
Date:   Mon, 26 Oct 2020 17:20:05 +0100
Message-Id: <20201026162022.3710091-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building with W=2, there are tons of warnings about conflicting
local and global definitions of 'nr_irqs' in common header files:

include/linux/irqdomain.h: In function 'irq_domain_alloc_irqs':
include/linux/irqdomain.h:482:17: warning: declaration of 'nr_irqs' shadows a global declaration [-Wshadow]
  482 |    unsigned int nr_irqs, int node, void *arg)
      |    ~~~~~~~~~~~~~^~~~~~~
In file included from ../include/linux/interrupt.h:10,
                 from ../include/linux/kernel_stat.h:9,
                 from ../include/linux/cgroup.h:26,
                 from ../include/linux/perf_event.h:57,
                 from ../include/linux/trace_events.h:10,
                 from ../include/trace/syscall.h:7,
                 from ../include/linux/syscalls.h:84,
                 from ../init/main.c:21:
include/linux/irqnr.h:8:12: note: shadowed declaration is here
    8 | extern int nr_irqs;
      |            ^~~~~~~

Rename the local in irqdomain.h to shut up those warnings

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/irqdomain.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 71535e87109f..3942f456f616 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -479,9 +479,9 @@ extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
 
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
-			unsigned int nr_irqs, int node, void *arg)
+			unsigned int num_irqs, int node, void *arg)
 {
-	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
+	return __irq_domain_alloc_irqs(domain, -1, num_irqs, node, arg, false,
 				       NULL);
 }
 
-- 
2.27.0

