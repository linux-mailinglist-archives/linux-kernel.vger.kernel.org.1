Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CB52D7884
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406501AbgLKPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35634 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406435AbgLKO7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:33 -0500
Date:   Fri, 11 Dec 2020 14:58:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GXFdIE/t2mBA7/rty2UC8czmc5CGR1dOG+E/OhYYUss=;
        b=GFsJRmD01DeuR3AWAMAjTP/mZN2cDZqWhLRFSSdy60Wk7WMXBR1G6ijU+xD86x+AUKbqHG
        sh2kBzYnTmE2ZYAg+WsTE9hp9OS7rTlaafZxzc50mADAAtv/EFKYDKRbHx9/Eh8W6SIMVk
        auk4IdmrHiknb+ydZiwgaIUCDaCVFCcKx+2tJSp65Fwk2nsJs0As+RvMgjDlnScdManM4H
        lnthaiZrI0nbWyEr3khos68NrlueHDCVGq0zp8WZSxFGYvR+IkOSlSkGlEGypABQim0Ir/
        I9qnsYfhB4rlA/NXSTgUOhz/TaJeRGwJtIvjPjsh8TW5pw16xsh8aPIHSlbB5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698722;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GXFdIE/t2mBA7/rty2UC8czmc5CGR1dOG+E/OhYYUss=;
        b=EJj7ux1+xcg8T6V8ILvwxiOc0uXWEn9e1xiH7CgWFcD4nB7KPgajBH3c9rbSr5zyk3bj5A
        mjHJQi7KfPhQMYAw==
From:   "irqchip-bot for John Garry" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] ACPI: Drop acpi_dev_irqresource_disabled()
Cc:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        tglx@linutronix.de
In-Reply-To: <1606905417-183214-4-git-send-email-john.garry@huawei.com>
References: <1606905417-183214-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <160769872206.3364.573437199198282902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1c3f69b4543af0aad514c127298e5ea40392575d
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1c3f69b4543af0aad514c127298e5ea40392575d
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Wed, 02 Dec 2020 18:36:55 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

ACPI: Drop acpi_dev_irqresource_disabled()

The functionality of acpi_dev_irqresource_disabled() is same as in common
irqresource_disabled(), so drop acpi_dev_irqresource_disabled() in favour
of that function.

Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/1606905417-183214-4-git-send-email-john.garry@huawei.com
---
 drivers/acpi/resource.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ad04824..5820319 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -380,13 +380,6 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
 
-static void acpi_dev_irqresource_disabled(struct resource *res, u32 gsi)
-{
-	res->start = gsi;
-	res->end = gsi;
-	res->flags = IORESOURCE_IRQ | IORESOURCE_DISABLED | IORESOURCE_UNSET;
-}
-
 static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 				     u8 triggering, u8 polarity, u8 shareable,
 				     bool legacy)
@@ -394,7 +387,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 	int irq, p, t;
 
 	if (!valid_IRQ(gsi)) {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 		return;
 	}
 
@@ -426,7 +419,7 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
 		res->start = irq;
 		res->end = irq;
 	} else {
-		acpi_dev_irqresource_disabled(res, gsi);
+		irqresource_disabled(res, gsi);
 	}
 }
 
@@ -463,7 +456,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 		 */
 		irq = &ares->data.irq;
 		if (index >= irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		acpi_dev_get_irqresource(res, irq->interrupts[index],
@@ -473,7 +466,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		ext_irq = &ares->data.extended_irq;
 		if (index >= ext_irq->interrupt_count) {
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 			return false;
 		}
 		if (is_gsi(ext_irq))
@@ -481,7 +474,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
 					 ext_irq->triggering, ext_irq->polarity,
 					 ext_irq->shareable, false);
 		else
-			acpi_dev_irqresource_disabled(res, 0);
+			irqresource_disabled(res, 0);
 		break;
 	default:
 		res->flags = 0;
