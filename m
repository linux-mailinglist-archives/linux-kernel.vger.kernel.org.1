Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F039E298812
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771329AbgJZILe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:11:34 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42442 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1771280AbgJZILB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:11:01 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E7821A0C07;
        Mon, 26 Oct 2020 09:10:59 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A02841A1168;
        Mon, 26 Oct 2020 09:10:53 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E88A2402BB;
        Mon, 26 Oct 2020 09:10:46 +0100 (CET)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [RESEND 11/11] dt-bindings: interrupt-controller: update bindings for supporting more SoCs
Date:   Mon, 26 Oct 2020 16:01:27 +0800
Message-Id: <20201026080127.40499-11-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201026080127.40499-1-biwen.li@oss.nxp.com>
References: <20201026080127.40499-1-biwen.li@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Biwen Li <biwen.li@nxp.com>

Update bindings for Layerscape external irqs,
support more SoCs(LS1043A, LS1046A, LS1088A,
LS208xA, LX216xA)

Signed-off-by: Biwen Li <biwen.li@nxp.com>
---
 .../bindings/interrupt-controller/fsl,ls-extirq.txt      | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
index f0ad7801e8cf..90ef8917ac02 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -1,6 +1,7 @@
 * Freescale Layerscape external IRQs
 
-Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A
+LS1088A, LS208xA, LX216xA) support inverting
 the polarity of certain external interrupt lines.
 
 The device node must be a child of the node representing the
@@ -8,12 +9,16 @@ Supplemental Configuration Unit (SCFG).
 
 Required properties:
 - compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+  "fsl,ls1043a-extirq": for LS1043A, LS1046A.
+  "fsl,ls1088a-extirq": for LS1088A, LS208xA, LX216xA.
+
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
-- 
2.17.1

