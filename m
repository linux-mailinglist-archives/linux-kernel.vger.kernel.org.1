Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAF72AD6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgKJMq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:46:27 -0500
Received: from foss.arm.com ([217.140.110.172]:55192 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgKJMqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:46:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CA0E1396;
        Tue, 10 Nov 2020 04:46:24 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EF68F3F6CF;
        Tue, 10 Nov 2020 04:46:21 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 11/11] dts: bindings: Document device tree binding for Arm TRBE
Date:   Tue, 10 Nov 2020 18:15:09 +0530
Message-Id: <1605012309-24812-12-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents the device tree binding in use for Arm TRBE.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/devicetree/bindings/arm/trbe.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.txt

diff --git a/Documentation/devicetree/bindings/arm/trbe.txt b/Documentation/devicetree/bindings/arm/trbe.txt
new file mode 100644
index 0000000..4bb5b09
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
+	       "arm,arm-trbe"
+
+- interrupts : Exactly 1 PPI must be listed. For heterogeneous systems where
+	       TRBE is only supported on a subset of the CPUs, please consult
+	       the arm,gic-v3 binding for details on describing a PPI partition.
+
+** Example:
+
+trbe {
+	compatible = "arm,arm-trbe";
+	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+};
-- 
2.7.4

