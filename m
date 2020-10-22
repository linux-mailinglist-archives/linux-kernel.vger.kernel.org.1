Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FCD295AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509830AbgJVIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:53:46 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34476 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509816AbgJVIxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:53:43 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F24F21A0F01;
        Thu, 22 Oct 2020 10:53:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 704DE1A0E9C;
        Thu, 22 Oct 2020 10:53:36 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C4446402F7;
        Thu, 22 Oct 2020 10:53:28 +0200 (CEST)
From:   Biwen Li <biwen.li@oss.nxp.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, zhiqiang.hou@nxp.com, tglx@linutronix.de,
        jason@lakedaemon.net, maz@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiafei.pan@nxp.com, xiaobo.xie@nxp.com,
        linux-arm-kernel@lists.infradead.org, Biwen Li <biwen.li@nxp.com>
Subject: [PATCH 11/11] dt-bindings: interrupt-controller: update bindings for supporting more SoCs
Date:   Thu, 22 Oct 2020 16:44:10 +0800
Message-Id: <20201022084410.28249-11-biwen.li@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022084410.28249-1-biwen.li@oss.nxp.com>
References: <20201022084410.28249-1-biwen.li@oss.nxp.com>
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
 .../bindings/interrupt-controller/fsl,ls-extirq.txt         | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
index f0ad7801e8cf..6c55eb25cf93 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -1,6 +1,7 @@
 * Freescale Layerscape external IRQs
 
-Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A
+LS1088A, LS208xA, LX216xA) support inverting
 the polarity of certain external interrupt lines.
 
 The device node must be a child of the node representing the
@@ -8,6 +9,9 @@ Supplemental Configuration Unit (SCFG).
 
 Required properties:
 - compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+  "fsl,ls1043a-extirq": for LS1043A, LS1046A.
+  "fsl,ls1088a-extirq": for LS1088A, LS208xA, LX216xA.
+
 - #interrupt-cells: Must be 2. The first element is the index of the
   external interrupt line. The second element is the trigger type.
 - #address-cells: Must be 0.
-- 
2.17.1

