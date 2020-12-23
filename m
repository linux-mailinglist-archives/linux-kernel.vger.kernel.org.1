Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0502E1ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbgLWKFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:05:25 -0500
Received: from foss.arm.com ([217.140.110.172]:48062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgLWKFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:05:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CC0C1509;
        Wed, 23 Dec 2020 02:04:18 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1C9A43F718;
        Wed, 23 Dec 2020 02:04:14 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>, devicetree@vger.kernel.org
Subject: [PATCH 11/11] dts: bindings: Document device tree binding for Arm TRBE
Date:   Wed, 23 Dec 2020 15:33:43 +0530
Message-Id: <1608717823-18387-12-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents the device tree binding in use for Arm TRBE.

Cc: devicetree@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V1:

- TRBE DT entry has been renamed as 'arm, trace-buffer-extension'

 Documentation/devicetree/bindings/arm/trbe.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt

diff --git a/Documentation/devicetree/bindings/arm/trbe.txt b/Documentation/devicetree/bindings/arm/trbe.txt
new file mode 100644
index 0000000..001945d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/trbe.txt
@@ -0,0 +1,20 @@
+* Trace Buffer Extension (TRBE)
+
+Trace Buffer Extension (TRBE) is used for collecting trace data generated
+from a corresponding trace unit (ETE) using an in memory trace buffer.
+
+** TRBE Required properties:
+
+- compatible : should be one of:
+	       "arm,trace-buffer-extension"
+
+- interrupts : Exactly 1 PPI must be listed. For heterogeneous systems where
+	       TRBE is only supported on a subset of the CPUs, please consult
+	       the arm,gic-v3 binding for details on describing a PPI partition.
+
+** Example:
+
+trbe {
+	compatible = "arm,trace-buffer-extension";
+	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

