Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1392CB039
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgLAWhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:37:11 -0500
Received: from mga06.intel.com ([134.134.136.31]:7601 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgLAWg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:36:57 -0500
IronPort-SDR: 4ixOzWTCUC1SsAgt1Lmtm2sZuvMppZICNn9RZkdmBMtNirCTfEMJfjplMm5jfuJF4yYFQORLmc
 iLaINXqx6ZLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="234524374"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="234524374"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:14 -0800
IronPort-SDR: +uFoOKl0+W/zBu9FkiWjDagcYeGZO2kC8YuZ77QxAReTS3vRnA9xvm50ArYSykOz0hAN74pAc2
 if3hGL7oNzfQ==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="405290669"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:14 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 4D2CA6363;
        Tue,  1 Dec 2020 14:35:14 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kkEEs-000H4L-5Y; Tue, 01 Dec 2020 14:35:14 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: [PATCH 02/22] dt-bindings: Add bindings for Keem Bay IPC driver
Date:   Tue,  1 Dec 2020 14:34:51 -0800
Message-Id: <20201201223511.65542-3-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201223511.65542-1-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add DT binding documentation for the Intel Keem Bay IPC driver, which
enables communication between the Computing Sub-System (CSS) and the
Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
Bay.

Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 .../bindings/soc/intel/intel,keembay-ipc.yaml | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml

diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
new file mode 100644
index 000000000000..6e21c54d8f34
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-ipc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Keem Bay IPC
+
+maintainers:
+  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+
+description:
+  The Keem Bay IPC driver enables Inter-Processor Communication (IPC) with the
+  Visual Processor Unit (VPU) embedded in the Intel Movidius SoC code named
+  Keem Bay.
+
+properties:
+  compatible:
+    const: intel,keembay-ipc
+
+  reg:
+    items:
+      - description: The CSS (CPU) FIFO registers
+      - description: The MSS (VPU) FIFO registers
+
+  reg-names:
+    items:
+      - const: css_fifo
+      - const: mss_fifo
+
+  interrupts:
+    items:
+      - description: CSS FIFO not-empty interrupt
+
+  interrupt-controller: true
+
+  memory-region:
+    items:
+      - description: Reserved memory region used for CSS IPC buffers
+      - description: Reserved memory region used for MSS IPC buffers
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    ipc@203300f0 {
+          compatible = "intel,keembay-ipc";
+          reg = <0x203300f0 0x310>, /* CPU TIM FIFO */
+                <0x208200f0 0x310>; /* VPU TIM FIFO */
+          reg-names = "css_fifo", "mss_fifo";
+          interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+          memory-region = <&css_ipc_reserved>, <&mss_ipc_reserved>;
+    };
-- 
2.17.1

