Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAEE1B4359
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgDVLfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:35:52 -0400
Received: from smtp1.lauterbach.com ([62.154.241.196]:51883 "EHLO
        smtp1.lauterbach.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgDVLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:35:52 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Apr 2020 07:35:51 EDT
Received: (qmail 23104 invoked by uid 484); 22 Apr 2020 11:29:09 -0000
X-Qmail-Scanner-Diagnostics: from 10.2.10.44 by smtp1.lauterbach.com (envelope-from <ingo.rohloff@lauterbach.com>, uid 484) with qmail-scanner-2.11 
 (mhr: 1.0. clamdscan: 0.99/21437. spamassassin: 3.4.0.  
 Clear:RC:1(10.2.10.44):. 
 Processed in 0.084966 secs); 22 Apr 2020 11:29:09 -0000
Received: from unknown (HELO ingpc2.intern.lauterbach.com) (Authenticated_SSL:irohloff@[10.2.10.44])
          (envelope-sender <ingo.rohloff@lauterbach.com>)
          by smtp1.lauterbach.com (qmail-ldap-1.03) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <maz@kernel.org>; 22 Apr 2020 11:29:08 -0000
From:   Ingo Rohloff <ingo.rohloff@lauterbach.com>
To:     maz@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ingo Rohloff <ingo.rohloff@lauterbach.com>
Subject: [PATCH] irqchip/gic-v3: fix missing "__init" for gic_smp_init()
Date:   Wed, 22 Apr 2020 13:28:57 +0200
Message-Id: <20200422112857.4300-1-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With an SMP configuration, gic_smp_init() calls set_smp_cross_call().
set_smp_cross_call() is marked with "__init".
So gic_smp_init() should also be marked with "__init".
gic_smp_init() is only called from gic_init_bases().
gic_init_bases() is also marked with "__init";
So marking gic_smp_init() with "__init" is fine.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d7006ef18a0d..98c886dab02d 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1150,7 +1150,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	isb();
 }
 
-static void gic_smp_init(void)
+static void __init gic_smp_init(void)
 {
 	set_smp_cross_call(gic_raise_softirq);
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
-- 
2.17.1

