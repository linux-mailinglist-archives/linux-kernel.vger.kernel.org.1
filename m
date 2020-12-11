Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C332F2D7879
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406522AbgLKPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406450AbgLKO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:37 -0500
Date:   Fri, 11 Dec 2020 14:58:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBOX/oetrrP8TyfMeSRZY+c6fpCLV+V6WjEzSnXYeuE=;
        b=Y2GMbsjVbBFs6ZMdukbFroANi+NPG/eF7z6sx0yVQdvDZ6SCWfIg6HXmogsA/JR2hz7bG4
        8Hhyzqo2Uph/eXyYXn590DIRfTc44KNqSF8yV/6gHWgoO/GMML9UM6jo1i1OxBhp/XrMV8
        2GAKeu67LNBkm8DnBjABNh9DHwwgOoV1qozzli0sz0tzCLN9tYJNrqqzTILYigC3CqYv7+
        bL0LzYYb0Vm+h95ESD3FMeclnAELHz8P7tuF1pXhx7aagUOiUTqThzuKxGdviQpecf0uFJ
        52IQwS/qx2Z/2Snb1ENUgwG2Ipf7OKbH9f0/kybPV6C6XW61ERsOoI1fkKyxnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBOX/oetrrP8TyfMeSRZY+c6fpCLV+V6WjEzSnXYeuE=;
        b=46hjXrllhyJll/C6WSZd8BN2CRaMMfbmW5OwdnPjiKDz/ZHsQpRBbhxVBeGKuN13AQ82jV
        KsQ5Tqv3SIsyQoBg==
From:   "irqchip-bot for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/gic: Spelling s/REturn/Return/
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201209101504.2206941-1-geert+renesas@glider.be>
References: <20201209101504.2206941-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160769872632.3364.14907130895082869275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     42a590b0fdf72498ebf47b01ddf006ee92cbfc70
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/42a590b0fdf72498ebf47b01ddf006ee92cbfc70
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 09 Dec 2020 11:15:04 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:40:17 

irqchip/gic: Spelling s/REturn/Return/

Fix a capitalization typo.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201209101504.2206941-1-geert+renesas@glider.be
---
 drivers/irqchip/irq-gic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6053245..a3c2f18 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -973,7 +973,7 @@ void gic_migrate_target(unsigned int new_cpu_id)
 /*
  * gic_get_sgir_physaddr - get the physical address for the SGI register
  *
- * REturn the physical address of the SGI register to be used
+ * Return the physical address of the SGI register to be used
  * by some early assembly code when the kernel is not yet available.
  */
 static unsigned long gic_dist_physaddr;
