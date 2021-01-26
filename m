Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E89E304DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbhAZXYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:24:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:15320 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbhAZFsE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:48:04 -0500
IronPort-SDR: shQQSpAW0f8ZM47h6wR/++kw31VKym4joQxKbw/aofMKEHmcAES8ILMys5LM6qcEHlA5ifIK6p
 Jzpb8uIGZyPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="179073455"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="179073455"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
IronPort-SDR: 6jbKixDNgQvr5WU5bSbrEgfIDJQqG0ayGqnEOS9HsBfx0OSJYvqZ6pdPqrXjSZKAlXxYx8nOqL
 B42O48fR2yJA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="573946855"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 6090C6371;
        Mon, 25 Jan 2021 21:40:41 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 549D3363486; Mon, 25 Jan 2021 21:40:41 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "Li, Tingqian" <tingqian.li@intel.com>, Li@linux.intel.com
Subject: [PATCH v3 24/34] dt-bindings: misc: Add Keem Bay vpumgr
Date:   Mon, 25 Jan 2021 21:40:26 -0800
Message-Id: <20210126054036.61587-25-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Li, Tingqian" <tingqian.li@intel.com>

  Add DT binding schema for VPU on Keem Bay ASoC platform


Signed-off-by: Li, Tingqian <tingqian.li@intel.com>
---
 .../bindings/misc/intel,keembay-vpu-mgr.yaml  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
new file mode 100644
index 000000000000..7fad14274ee2
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-vpu-mgr.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+# Copyright (C) 2020 Intel
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/intel,keembay-vpu-mgr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Intel VPU manager bindings
+
+maintainers:
+  - Li, Tingqian <tingqian.li@intel.com>
+  - Zhou, Luwei <luwei.zhou@intel.com>
+
+description: |
+  The Intel VPU manager provides shared memory and process
+  depedent context management for Intel VPU hardware IP.
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - intel,keembay-vpu-mgr
+        - intel,keembay-vpusmm
+
+  memory-region:
+    description:
+      phandle to a node describing reserved memory (System RAM memory)
+      used by VPU (see bindings/reserved-memory/reserved-memory.txt)
+    maxItems: 1
+
+  intel,keembay-vpu-ipc-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      the index of the VPU slice to be managed. Default is 0.
+
+required:
+  - compatible
+  - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    vpumgr0 {
+        compatible = "intel,keembay-vpu-mgr";
+        memory-region = <&vpu_reserved>;
+        intel,keembay-vpu-ipc-id = <0x0>;
+    };
-- 
2.17.1

