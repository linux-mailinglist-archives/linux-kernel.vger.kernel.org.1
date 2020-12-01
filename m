Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCA12CB045
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 23:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgLAWiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 17:38:16 -0500
Received: from mga01.intel.com ([192.55.52.88]:28871 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgLAWiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 17:38:12 -0500
IronPort-SDR: h6PW1wf8R2xlUPhQsPf6gWNKGV+K+FxiMLs0nnO721Ey/DTQ7DIc6+VGeRDsemIdhewIvOXkWo
 anx1N60MpCFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="191126603"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="191126603"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:16 -0800
IronPort-SDR: Up6y4X1EPL9Ze4azVqhwuBCARa/c5g2qM1ETfA0NNWs3UYK/U/3reOXCKlxMRYD1IMzgozQz8B
 RAE3oSaiHRjg==
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="434847189"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 14:35:15 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id B7EBD636F;
        Tue,  1 Dec 2020 14:35:15 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kkEEt-000H54-Jd; Tue, 01 Dec 2020 14:35:15 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Seamus Kelly <seamus.kelly@intel.com>,
        devicetree@vger.kernel.org,
        Ryan Carnaghi <ryan.r.carnaghi@intel.com>
Subject: [PATCH 17/22] xlink-core: Add xlink core device tree bindings
Date:   Tue,  1 Dec 2020 14:35:06 -0800
Message-Id: <20201201223511.65542-18-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201201223511.65542-1-mgross@linux.intel.com>
References: <20201201223511.65542-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Seamus Kelly <seamus.kelly@intel.com>

Add device tree bindings for keembay-xlink.

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

