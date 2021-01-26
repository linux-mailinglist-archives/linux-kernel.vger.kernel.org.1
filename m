Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C46C304DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388176AbhAZXU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:20:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:36176 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388333AbhAZFmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:42:36 -0500
IronPort-SDR: /xu2OpLgAuDur+7K+A2D2Aq9QfNREKKF3dz+CXW+Vuk0GbHblqdgjyvjWm8qL8cm2KJNEXpGmv
 TU8KKohrpjaQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159028886"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159028886"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:42 -0800
IronPort-SDR: tcScTWdAP7qZEACFRmSHHhY7/yMzCkqsbW155suT35MCpG8iSBGpbhtbJT/oiOddoyJsm7Q/5W
 iQtsOrddIg/Q==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="353335758"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:42 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 6065B6365;
        Mon, 25 Jan 2021 21:40:40 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 53FE8362FAE; Mon, 25 Jan 2021 21:40:40 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 04/34] dt-bindings: Add bindings for Keem Bay IPC driver
Date:   Mon, 25 Jan 2021 21:40:06 -0800
Message-Id: <20210126054036.61587-5-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

Add DT binding documentation for the Intel Keem Bay IPC driver, which
enables communication between the Computing Sub-System (CSS) and the
Multimedia Sub-System (MSS) of the Intel Movidius SoC code named Keem
Bay.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 .../bindings/soc/intel/intel,keembay-ipc.yaml | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml

diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
new file mode 100644
index 000000000000..586fe73f4cd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-ipc.yaml
@@ -0,0 +1,45 @@
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
+  memory-region:
+    items:
+      - description:
+          Reserved memory region used by the CPU to allocate IPC packets.
+      - description:
+          Reserved memory region used by the VPU to allocate IPC packets.
+
+  mboxes:
+    description: VPU IPC Mailbox.
+
+required:
+  - compatible
+  - memory-region
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    ipc {
+          compatible = "intel,keembay-ipc";
+          memory-region = <&ipc_cpu_reserved>, <&ipc_vpu_reserved>;
+          mboxes = <&vpu_ipc_mbox 0>;
+    };
-- 
2.17.1

