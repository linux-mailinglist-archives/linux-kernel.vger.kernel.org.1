Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABF2F430D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbhAMEUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:20:05 -0500
Received: from foss.arm.com ([217.140.110.172]:58008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbhAMEUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:20:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 041ED1474;
        Tue, 12 Jan 2021 20:18:58 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C4F723F719;
        Tue, 12 Jan 2021 20:18:54 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH V2 11/11] dts: bindings: Document device tree bindings for Arm TRBE
Date:   Wed, 13 Jan 2021 09:48:18 +0530
Message-Id: <1610511498-4058-12-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Document the device tree bindings for Trace Buffer Extension (TRBE).

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 Documentation/devicetree/bindings/arm/trbe.yaml | 46 +++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml

diff --git a/Documentation/devicetree/bindings/arm/trbe.yaml b/Documentation/devicetree/bindings/arm/trbe.yaml
new file mode 100644
index 0000000..2258595
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/trbe.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright 2021, Arm Ltd
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/trbe.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ARM Trace Buffer Extensions
+
+maintainers:
+  - Anshuman Khandual <anshuman.khandual@arm.com>
+
+description: |
+  Description of TRBE hw
+
+properties:
+  $nodename:
+    pattern: "trbe"
+  compatible:
+    items:
+      - const: arm,trace-buffer-extension
+
+  interrupts:
+    description: |
+       Exactly 1 PPI must be listed. For heterogeneous systems where
+       TRBE is only supported on a subset of the CPUs, please consult
+       the arm,gic-v3 binding for details on describing a PPI partition.
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+
+examples:
+
+ - |
+   #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+   trbe {
+     compatible = "arm,trace-buffer-extension";
+     interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+   };
+...
-- 
2.7.4

