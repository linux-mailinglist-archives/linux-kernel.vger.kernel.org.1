Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810572B3130
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 23:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKNWgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 17:36:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60962 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKNWga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 17:36:30 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605393388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yzAUr8F/qvv0SbzuApNQRQ/+Feyqjj5P+GI1CLFSiQs=;
        b=24kQplwoSlPxbZqisHO6h5YHruF967rKQ+zmydChrC9egwS/xir5n87M+gRc8uVNCjaDUE
        oD6PDNSJQYWA9Ws3DIZQ2O1lqZNFNg0Vms/uKD1aO41dc6/Eya8y/1ZIfCeUCJqjCaoUbu
        Db5ozIdZKki7p5woZ22Is/xZvMSQzDNltt1iW2nKVBvGYFQYIrp9FxWJtcRlOJyYmrD7BT
        V1KGqnf8ZitzOLatj6Lrx6bNo7OyxlauufjE/psYQQ83bDeEEd12Z4JXf1Ulfzl9RFTlJU
        leXiiosmqqWi2vL4yQNk1hcvrJJjxMhL65sT3dmOC8x1UwXHP1zfSa+4EseGww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605393388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=yzAUr8F/qvv0SbzuApNQRQ/+Feyqjj5P+GI1CLFSiQs=;
        b=3zpN1YdaWuzaIDEYtHUSdCm6tfPNB1Vqt/3afccx7XbSHfcjxdWaUSlzTVcWFgivBuEv+5
        Lq6Blu6dCdZBzKDg==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>
Subject: genirq/irqdomain: Make irq_domain_disassociate() static
Date:   Sat, 14 Nov 2020 23:36:28 +0100
Message-ID: <87a6vja7mb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h |    2 --
 kernel/irq/irqdomain.c    |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -387,8 +387,6 @@ extern int irq_domain_associate(struct i
 extern void irq_domain_associate_many(struct irq_domain *domain,
 				      unsigned int irq_base,
 				      irq_hw_number_t hwirq_base, int count);
-extern void irq_domain_disassociate(struct irq_domain *domain,
-				    unsigned int irq);
 
 extern unsigned int irq_create_mapping(struct irq_domain *host,
 				       irq_hw_number_t hwirq);
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -496,7 +496,7 @@ static void irq_domain_set_mapping(struc
 	}
 }
 
-void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
+static void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
 {
 	struct irq_data *irq_data = irq_get_irq_data(irq);
 	irq_hw_number_t hwirq;
