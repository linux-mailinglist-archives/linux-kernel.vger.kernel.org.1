Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8789C2DB55E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgLOUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:48:51 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:59808 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgLOUss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:48:48 -0500
Received: from localhost.localdomain ([93.22.37.143])
        by mwinf5d65 with ME
        id 4kn32400N35JPTR03kn3FK; Tue, 15 Dec 2020 21:47:04 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 15 Dec 2020 21:47:04 +0100
X-ME-IP: 93.22.37.143
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     maz@kernel.org, tglx@linutronix.de, mripard@kernel.org,
        dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH V2] irqdomain: Add documentation for irq_create_of_mapping()
Date:   Tue, 15 Dec 2020 21:46:59 +0100
Message-Id: <20201215204659.148709-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a description for 'irq_create_of_mapping()' and make explicit the fact
that the resources allocated by this function can be freed by calling
'irq_dispose_mapping()' when needed (i.e. error handling path, remove
function, ...)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
The wording can certainly be improved.

My goal is only to make clear if patches such as:
   https://lore.kernel.org/lkml/20201214202117.146293-1-christophe.jaillet@wanadoo.fr/
are needed or not.

v2: Fix typo and improve style
---
 kernel/irq/irqdomain.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 6aacd342cd14..d761ece8d43e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -858,6 +858,15 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 }
 EXPORT_SYMBOL_GPL(irq_create_fwspec_mapping);
 
+/**
+ * irq_create_of_mapping() - Map an interrupt
+ * @irq_data: Structure of_phandle_args returned by a previous
+ *            of_irq_parse_xxx() call.
+ *
+ * The resources allocated by this function should be freed by
+ * calling irq_dispose_mapping() when the mapping is not useful
+ * anymore.
+ */
 unsigned int irq_create_of_mapping(struct of_phandle_args *irq_data)
 {
 	struct irq_fwspec fwspec;
-- 
2.27.0

