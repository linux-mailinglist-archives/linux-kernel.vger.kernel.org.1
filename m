Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C12D786B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436618AbgLKPAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35738 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406453AbgLKO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:38 -0500
Date:   Fri, 11 Dec 2020 14:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6djCgbLXaMD9v6HbNJK3oD3FE5gTLY/JW285Yb5L6SY=;
        b=wPaJ0Lgibx/2i2b7bxDs66YX/8nHVmLd5jBsGaDLrVRa+n506vyxjGaUeHNi4H6z4JkY1i
        fIhX3wTtNANouGffP5w3mTu9rRKxSeVFpg+PqrZmuOrOn9p9LQrDQo2sVKayovTRIUy1NS
        vUgIXNAK7dpBGXNT3+aJ5FYOORUW7qFJEzC0iftRbcyC+AdCk8Hf7IsSTbmcBJWeyk8S/d
        8gRfUd4lsNqS+xtQCtxI25plAmoDws8aKTmJmoDRRiuuG/ZUX5O3TVcoI63qbi5hA86Z6H
        yfJQQ4Fv5QuoermT1p/zTlEOTzsCoWuoMoopdFSziTbTrtkU4MRjOXMN2/ry8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698726;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6djCgbLXaMD9v6HbNJK3oD3FE5gTLY/JW285Yb5L6SY=;
        b=wnvlb7FnAr/42LkxlJ1dtZTfmr/qt3XKmibApvvDy/xL1GUkTyBNrucfh48WGFr166jvLh
        cvXR0YAK+cyNDfAA==
From:   "irqchip-bot for Biwen Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller: update
 bindings for supporting more SoCs
Cc:     Biwen Li <biwen.li@nxp.com>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>, tglx@linutronix.de
In-Reply-To: <20201130101515.27431-11-biwen.li@oss.nxp.com>
References: <20201130101515.27431-11-biwen.li@oss.nxp.com>
MIME-Version: 1.0
Message-ID: <160769872582.3364.4412521407126046603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     9898a59358d7cb925f63bb77bd40224d1bc4857e
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/9898a59358d7cb925f63bb77bd40224d1bc4857e
Author:        Biwen Li <biwen.li@nxp.com>
AuthorDate:    Mon, 30 Nov 2020 18:15:15 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:45:21 

dt-bindings: interrupt-controller: update bindings for supporting more SoCs

Update bindings for Layerscape external irqs,
support more SoCs(LS1043A, LS1046A, LS1088A,
LS208xA, LX216xA)

Signed-off-by: Biwen Li <biwen.li@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20201130101515.27431-11-biwen.li@oss.nxp.com
---
 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
index f0ad780..4d47df1 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -1,6 +1,7 @@
 * Freescale Layerscape external IRQs
 
-Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A
+LS1088A, LS208xA, LX216xA) support inverting
 the polarity of certain external interrupt lines.
 
 The device node must be a child of the node representing the
@@ -8,12 +9,15 @@ Supplemental Configuration Unit (SCFG).
 
 Required properties:
 - compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+  "fsl,ls1043a-extirq": for LS1043A, LS1046A.
+  "fsl,ls1088a-extirq": for LS1088A, LS208xA, LX216xA.
 - #interrupt-cells: Must be 2. The first element is the index of the
   external interrupt line. The second element is the trigger type.
 - #address-cells: Must be 0.
 - interrupt-controller: Identifies the node as an interrupt controller
 - reg: Specifies the Interrupt Polarity Control Register (INTPCR) in
-  the SCFG.
+  the SCFG or the External Interrupt Control Register (IRQCR) in
+  the ISC.
 - interrupt-map: Specifies the mapping from external interrupts to GIC
   interrupts.
 - interrupt-map-mask: Must be <0xffffffff 0>.
