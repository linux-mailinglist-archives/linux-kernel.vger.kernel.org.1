Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE19A304DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbhAZXUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:20:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:33188 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbhAZFmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:42:36 -0500
IronPort-SDR: Tt8sEtsT6JXD81tyfqmNrhomE6W1xx4xwHgj6Lci3D77BNVEOCI8Kc7ZOXC1CRXyQC1Kt9zizr
 OghmW+sDhDxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264675334"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264675334"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
IronPort-SDR: oe4gAPvj2+32iyxAyHwDLWPD7MnwV0ovrYybMXl5FQDxIOfT2DCAvNeRP/pP0cJ+y08/+E41kq
 Wt625D1tzdYA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="350563118"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 08A60636B;
        Mon, 25 Jan 2021 21:40:41 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id F097F363332; Mon, 25 Jan 2021 21:40:40 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: [PATCH v3 17/34] xlink-ipc: Add xlink ipc device tree bindings
Date:   Mon, 25 Jan 2021 21:40:19 -0800
Message-Id: <20210126054036.61587-18-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Add device tree bindings for the xLink IPC driver which enables xLink to
control and communicate with the VPU IP present on the Intel Keem Bay
SoC.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
---
 .../misc/intel,keembay-xlink-ipc.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
new file mode 100644
index 000000000000..699e43c4cd40
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink-ipc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) Intel Corporation. All rights reserved.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink-ipc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay xlink IPC
+
+maintainers:
+  - Kelly Seamus <seamus.kelly@intel.com>
+
+description: |
+  The Keem Bay xlink IPC driver enables the communication/control sub-system
+  for internal IPC communications within the Intel Keem Bay SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: intel,keembay-xlink-ipc
+
+  memory-region:
+    items:
+      - description: reference to the CSS xlink IPC reserved memory region.
+      - description: reference to the MSS xlink IPC reserved memory region.
+
+  intel,keembay-vpu-ipc-id:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: The numeric ID identifying the VPU within the xLink stack.
+
+  intel,keembay-vpu-ipc-name:
+    $ref: "/schemas/types.yaml#/definitions/string"
+    description: User-friendly name for the VPU within the xLink stack.
+
+  intel,keembay-vpu-ipc:
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+    description: reference to the corresponding intel,keembay-vpu-ipc node.
+
+examples:
+  - |
+    xlink-ipc {
+        compatible = "intel,keembay-xlink-ipc";
+        memory-region = <&css_xlink_reserved>,
+                        <&mss_xlink_reserved>;
+        intel,keembay-vpu-ipc-id = <0x0>;
+        intel,keembay-vpu-ipc-name = "vpu-slice-0";
+        intel,keembay-vpu-ipc = <&vpuipc>;
+    };
-- 
2.17.1

