Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F0C2DE900
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 19:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgLRSl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 13:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbgLRSl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 13:41:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A4C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 10:40:45 -0800 (PST)
Date:   Fri, 18 Dec 2020 18:40:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608316843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aI4YjByaniYm46eNLbWPyS3QStnm6uMyDSCetfQmMwI=;
        b=vvbyhHIOLLBVCmCzOA8g+YXOGhkwK4OsnniQVsEoZEosYh56U2wS6VcDX5IO1I6hugrczb
        M3rvvCD0q8z+AreiM+zlIZ1LgYSzpgBYmXNLjeJMN9Ovhwz+C1d5Ch7WJrwTu9ALgjOAB0
        qlGQzmv/s98hj5dQW0JZp0r2ZgNK5g+bUF6SXt7y+bKnt9JS6oBugL5Li6lLEqModu5K1J
        VhE9et3/UzbQun/posknyqoEg3seAYNA44eOs2MSdMrEs19O3pF9JnTsCypN4TusYJ+XFg
        rOgXgb0m72rk21aV6d14SiE978vdy9XP2tAp/yV+n6FrlwXLMK31sJcWLqG4NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608316843;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aI4YjByaniYm46eNLbWPyS3QStnm6uMyDSCetfQmMwI=;
        b=BU/85o+Eh1nLwiU8AasLzkIVBrshjuwx9bZfqq5wQj5UvhmbqtSfHlZwJTGv4q7CH+awSa
        AG9oDwFfpUs8i9Cg==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/bcm2836: Fix IPI acknowledgement
 after conversion to handle_percpu_devid_irq
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
References: <c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net>
MIME-Version: 1.0
Message-ID: <160831684292.22759.15563002516530918910.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     d7f39c40ebb6986e7371510d1c20a4efee4a7f0d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/d7f39c40ebb6986e7371510d1c20a4efee4a7f0d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 18 Dec 2020 18:03:46 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 18 Dec 2020 18:34:17 

irqchip/bcm2836: Fix IPI acknowledgement after conversion to handle_percpu_devid_irq

It appears that despite its name, the bcm2836_arm_irqchip_ipi_eoi()
callback is an acknowledgement, and not an EOI. This means that
we lose IPIs that are made pending between the handling of the
IPI and the write to LOCAL_MAILBOX0_CLR0. With the right timing,
things fail nicely.

This used to work with handle_percpu_devid_fasteoi_ipi(), which
started by eoi-ing the interrupt. With the standard fasteoi flow,
this doesn't work anymore.

So let's use this callback for what it is, an ack. Your favourite
RPi-2/3 is back up and running.

Fixes: ffdad793d579 ("irqchip/bcm2836: Make IPIs use handle_percpu_devid_irq()")
Cc: Valentin Schneider <valentin.schneider@arm.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/c9fb4ab3-a5cb-648c-6de3-c6a871e60870@roeck-us.net
---
 drivers/irqchip/irq-bcm2836.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 5f5eb88..25c9a9c 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -167,7 +167,7 @@ static void bcm2836_arm_irqchip_handle_ipi(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void bcm2836_arm_irqchip_ipi_eoi(struct irq_data *d)
+static void bcm2836_arm_irqchip_ipi_ack(struct irq_data *d)
 {
 	int cpu = smp_processor_id();
 
@@ -195,7 +195,7 @@ static struct irq_chip bcm2836_arm_irqchip_ipi = {
 	.name		= "IPI",
 	.irq_mask	= bcm2836_arm_irqchip_dummy_op,
 	.irq_unmask	= bcm2836_arm_irqchip_dummy_op,
-	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
+	.irq_ack	= bcm2836_arm_irqchip_ipi_ack,
 	.ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
 };
 
