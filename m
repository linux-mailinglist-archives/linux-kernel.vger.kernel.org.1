Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF67C304DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388476AbhAZXWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:22:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:36176 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388749AbhAZFp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:45:56 -0500
IronPort-SDR: aqFKfmdrTz2lseyxru/qTFtjCRvU3ITy555zT6lp3MIuyCoTOWkchV2CdjtDm3C5+Sjf1CYqU1
 V8COU58TT2zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159028895"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159028895"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:42 -0800
IronPort-SDR: M9StvD7+nwHww6D2RTuWG5RkXRrbAAqwJDfAPwVRwMIZjTjhuUjXbKA+pWT2AyMc5iFLpH/pkn
 ePpfZLSphojA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="353335765"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:42 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 4982E6369;
        Mon, 25 Jan 2021 21:40:40 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 3D30D36261C; Mon, 25 Jan 2021 21:40:40 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v3 02/34] dt-bindings: mailbox: Add Intel VPU IPC mailbox bindings
Date:   Mon, 25 Jan 2021 21:40:04 -0800
Message-Id: <20210126054036.61587-3-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add bindings for the Intel VPU IPC mailbox driver.

Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 .../mailbox/intel,vpu-ipc-mailbox.yaml        | 69 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
new file mode 100644
index 000000000000..923a6d619a64
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2020 Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/intel,vpu-ipc-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel VPU IPC mailbox
+
+maintainers:
+  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+
+description: |
+  Intel VPU SoCs like Keem Bay have hardware FIFOs to enable Inter-Processor
+  Communication (IPC) between the CPU and the VPU.
+
+  Specifically, there is one HW FIFO for the CPU (aka Application Processor -
+  AP) and one for the VPU. Each FIFO can hold 128 entries of 32 bits each. A
+  "FIFO-not-empty" interrupt is raised every time there is at least a message
+  in the FIFO. The CPU FIFO raises interrupts to the CPU, while the VPU FIFO
+  raises interrupts to VPU. When the CPU wants to send a message to the VPU it
+  writes to the VPU FIFO, similarly, when the VPU want to send a message to the
+  CPU, it writes to the CPU FIFO.
+
+  Refer to ./mailbox.txt for generic information about mailbox device-tree
+  bindings.
+
+properties:
+  compatible:
+    const: intel,vpu-ipc-mailbox
+
+  reg:
+    items:
+      - description: The CPU FIFO registers
+      - description: The VPU FIFO registers
+
+  reg-names:
+    items:
+      - const: cpu_fifo
+      - const: vpu_fifo
+
+  interrupts:
+    items:
+      - description: CPU FIFO-not-empty interrupt
+
+  "#mbox-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    vpu_ipc_mailbox@203300f0 {
+        compatible = "intel,vpu-ipc-mailbox";
+        #mbox-cells = <1>;
+        reg = <0x203300f0 0x310>,
+              <0x208200f0 0x310>;
+        reg-names = "cpu_fifo", "vpu_fifo";
+        interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 992fe3b0900a..2b82526a00dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9181,6 +9181,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/intel-vbtn.c
 
+INTEL VPU IPC MAILBOX
+M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
+M:	Mark Gross <mgross@linux.intel.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/mailbox/intel,vpu-ipc-mailbox.yaml
+
 INTEL WIRELESS 3945ABG/BG, 4965AGN (iwlegacy)
 M:	Stanislaw Gruszka <stf_xl@wp.pl>
 L:	linux-wireless@vger.kernel.org
-- 
2.17.1

