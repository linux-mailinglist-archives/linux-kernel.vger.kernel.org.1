Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F302F6F57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbhAOAPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 19:15:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:46320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbhAOAPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 19:15:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 31EF3B27D;
        Fri, 15 Jan 2021 00:14:57 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     James.Bottomley@HansenPartnership.com
Cc:     deller@gmx.de, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] parisc: Remove leftover reference to the power_tasklet
Date:   Thu, 14 Jan 2021 16:14:48 -0800
Message-Id: <20210115001448.117247-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was removed long ago, back in:

     6e16d9409e1 ([PARISC] Convert soft power switch driver to kthread)

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 arch/parisc/include/asm/irq.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/parisc/include/asm/irq.h b/arch/parisc/include/asm/irq.h
index 959e79cd2c14..378f63c4015b 100644
--- a/arch/parisc/include/asm/irq.h
+++ b/arch/parisc/include/asm/irq.h
@@ -47,7 +47,4 @@ extern unsigned long txn_affinity_addr(unsigned int irq, int cpu);
 extern int cpu_claim_irq(unsigned int irq, struct irq_chip *, void *);
 extern int cpu_check_affinity(struct irq_data *d, const struct cpumask *dest);
 
-/* soft power switch support (power.c) */
-extern struct tasklet_struct power_tasklet;
-
 #endif	/* _ASM_PARISC_IRQ_H */
-- 
2.26.2

