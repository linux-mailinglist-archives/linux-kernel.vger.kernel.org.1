Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6840B2EFA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbhAHV30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:29:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:22454 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729874AbhAHV3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:29:22 -0500
IronPort-SDR: VgW9qu1Lv0GMC/7gJfMMYxozmlV5FQVmk0uSw6T4VfxKH4Wj8D/htTBRLk+RFXsUyDdfSwMPX1
 BXvVZJZ/9IEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="241732875"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="241732875"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:04 -0800
IronPort-SDR: bON76ihHiY5Nk3TducXRgJJS6UThINuMenxwewxiBJ6B4oPQJK8MOwFjKWgMOXuVaEPGt9/BxS
 4tML0uo9ji7Q==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="362470724"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:05 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 1D7026365;
        Fri,  8 Jan 2021 13:26:05 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGm-0009cZ-W5; Fri, 08 Jan 2021 13:26:05 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: [PATCH v2 19/34] xlink-core: Add xlink core device tree bindings
Date:   Fri,  8 Jan 2021 13:25:45 -0800
Message-Id: <20210108212600.36850-20-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Add device tree bindings for keembay-xlink.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Seamus Kelly <seamus.kelly@intel.com>
Signed-off-by: Ryan Carnaghi <ryan.r.carnaghi@intel.com>
---
 .../bindings/misc/intel,keembay-xlink.yaml    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
new file mode 100644
index 000000000000..89c34018fa04
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,keembay-xlink.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) Intel Corporation. All rights reserved.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel,keembay-xlink.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay xlink
+
+maintainers:
+  - Seamus Kelly <seamus.kelly@intel.com>
+
+description: |
+  The Keem Bay xlink driver enables the communication/control sub-system
+  for internal and external communications to the Intel Keem Bay SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: intel,keembay-xlink
+
+examples:
+  - |
+    xlink {
+        compatible = "intel,keembay-xlink";
+    };
-- 
2.17.1

