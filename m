Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F5C2EFA78
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbhAHV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:28:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:22454 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbhAHV2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:28:00 -0500
IronPort-SDR: BdpdPfQ7KKFIT8M3iHNrnLvnBS6unnG7SRHvsXJZaZxBT11dt9zbiqyCS97xxZuH1kldqhJCtb
 KwFqYiUMscPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="241732856"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="241732856"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:03 -0800
IronPort-SDR: ektsspMCFItQz5LOenD66wUWPea46axxBGcbQ5j2IWKuBYubVFfOfrBDCq1j9RSKGz0/jWDRAZ
 g58MOI4qiXJg==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="388292702"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:02 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 95BE76368;
        Fri,  8 Jan 2021 13:26:03 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGl-0009bq-Fx; Fri, 08 Jan 2021 13:26:03 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 04/34] dt-bindings: Add bindings for Keem Bay IPC driver
Date:   Fri,  8 Jan 2021 13:25:30 -0800
Message-Id: <20210108212600.36850-5-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
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

