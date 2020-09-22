Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46082746F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIVQsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:48:39 -0400
Received: from mail-bn8nam11on2047.outbound.protection.outlook.com ([40.107.236.47]:32000
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgIVQsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:48:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C14kYJ01ky9e/9FQVIoB1brmKiVI0SJISQHJ3vgqh6SqZnGOAaUyupA+Bw+y0kPdR+IY1cm3hS0pEk0f5bOHcKf6pEzcc1VdIIgA3RTkv4JJlsU9pioPbRSSDqJ523znuyh6xtUQVQvMdMkl1dtI/fO07zsuohtlLbKlOPAgDzxk1X78QP/ddu/nqvdglVs6Y9CYYaanNQD+JhW5RtB0sjYVVCbSAZtT6iNnZ0wCQufRT2im/nXDsfgS0PRPrnXzjm6UBSKHmTrn6upsuXco75iA5eEzBraNNmzvvC9Y94EhL3pi2z9GRra6hHJl6cn4CWO34IaFyJexs44/BBGstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxV/1kG90ZZlDdy1Q5MOCk1TWaRIhR0BGhHB2gUunXA=;
 b=j9WOP9W2FoQtOB154p9XZ3FhjL3avEew2NNbXHJj2jbqelTzaR5ONNP9DKhiYGPr8DJJgXUCrfNVfLoEF2WQQtnP+/xVAAUrBIgruOu6uilqdhzh3bxEI+rtTbRjrg715IEzpjWDmdUobPGqgNle7Ws3B28xGMJ5qIbn+wPFnAmmCejgr0LNdS4UvxEavN+UXFpGglCn29eS5Y9Ei9hu5xsl7VTeKsicbYWL08+yOerjuZVNjFL8p5AjP7DPa1nSX6aM+T4RMfyAVkOYv0uACG+5NO5vQA8omC8l67ZvYEhT/JygaMuPQiFW9+q+kU77yasmJqvW1cOSk8xHaFJSYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WxV/1kG90ZZlDdy1Q5MOCk1TWaRIhR0BGhHB2gUunXA=;
 b=keIruwH9fegxFyc6ZDQT95RHmoAK7+czrzNNg4d7U6/WapMVCuQiA6SoUkzu6DD+aJBStUUGoNGBbMTNl+DxNKjf6I7S3kA8+mhAQL011qPiM4799rXzDhWlaiEQvi0TCoJHmLfpogJCRzSi+Z6Bs5CNcnC1952Ixqsr/7mPWXk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4313.namprd13.prod.outlook.com (2603:10b6:5:31::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4; Tue, 22 Sep
 2020 16:48:35 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3412.019; Tue, 22 Sep 2020
 16:48:35 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v3 1/1] dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema
Date:   Tue, 22 Sep 2020 22:18:08 +0530
Message-Id: <1600793288-3881-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600793288-3881-1-git-send-email-sagar.kadam@sifive.com>
References: <1600793288-3881-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR01CA0167.apcprd01.prod.exchangelabs.com (2603:1096:4:28::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3412.20 via Frontend Transport; Tue, 22 Sep 2020 16:48:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34c6a8e8-541f-4d3f-8646-08d85f1758ba
X-MS-TrafficTypeDiagnostic: DM6PR13MB4313:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB43133D58453D7B166535A853973B0@DM6PR13MB4313.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rrZTLDkbSl5pkDxi/GeCYXN2rPlpi6FmCluPv9zx+f2p9GJAafycI1THwDy3bBc6as8hYZQxtCOxCkaRnZa69LDrfq8vPhmRDEuWbi+seg079YCECQW0xnjRJKoIEDKu6TtAx9pi218P0t0JT5AAhx0+qP1OKCbkhXp0sP+94VRMrIVmiKXgM0oMrUx6UmE6UBMfnD37a/1N6VJMBrK7UDetVncz7u6LaQDNnu4ajtNJXspYgbnSo4IE4yC7i+5GkUpHgoMxlWCbvELFDbjCIhTGWl7ImNwIaUYSnrUAiyKr7PHDfNlmQGa7PW9soHkp5PwgR1vY3ortjXCyAK6BnJI/+5hEED3PlbVUxS/Rk/bloX02Z6Fdj7kfHCz/WPIGU9aOjIAhMQ5QZDAN/7rt3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39850400004)(83170400001)(956004)(2616005)(6666004)(42882007)(44832011)(4326008)(316002)(6486002)(966005)(36756003)(5660300002)(52116002)(16526019)(186003)(26005)(66946007)(66476007)(66556008)(478600001)(6506007)(6512007)(8936002)(83380400001)(107886003)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +MYxUbyQe2073YYYby5cTBdseZoJR9Phsea82r3heZvhZMM7pKj5zWwOKhovcph0mmxTjeYgfV5IL0tTiHfCJ/j9q1wxF8ldqHf8198pdm81s5pJaqsg1VC+6cFIsxY/4qm5jdsQaksbCnuVQ06ZMfFsgJ12mi8r/VK8bJlXszuKrQnkQXQS28jIpNaE+qxbA1OteR9/XQ7dqwYzt/Ay2dDDzDPmscUUgXiUBU8isQfjvy3UzJND6YMr7vCCd7PRX9dt3OQdD4F7Xd8x9aK11YSIQotNb9+zx2irMNGm+XbZ47asvXk3EdchTVht0CJaMkQ6xdj6HtjFvPddk5LyLAvjzN9mu2c1aZzgQM2qmDwJin9eeqIYKagU8RYxmhSMO+3FcmCy3Wjl86C/vrK+hpOZsO0qbSOJOCZqIparB6FH4wsrwl3Jfp7N0cOAGM/ngX7+mQRhgPdb2A2+ldD3L2wT6P6jXDAzxQJDi3zOr+ABwXG6PTbPyoxIfmn82/VdiqyOL1GFrAavbB42d5sRGLz3RzTnmygWkl3CGpXegCi7UCh4tqDTHYJNrad40Yuus8HZa8ziHwi5N+eyrBz44h+FpiGHVT0oZkHuL2rCRsNqCEwJEXc7DIsABAJizL8HvDxesTPdi3RgIxuoB3j9Pw==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c6a8e8-541f-4d3f-8646-08d85f1758ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 16:48:35.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ca09Qa4x4szY+xuG4+Rayrp+m88p1DsBKKbqrjrT2KWTNKFC7HipviR+QtXJp362JIGLKhhyaMekIIinrCGwAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4313
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cache
controller to YAML format.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 90 ++++++++++++++++++++++
 2 files changed, 90 insertions(+), 51 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
 create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
deleted file mode 100644
index 73d8f19..0000000
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
+++ /dev/null
@@ -1,51 +0,0 @@
-SiFive L2 Cache Controller
---------------------------
-The SiFive Level 2 Cache Controller is used to provide access to fast copies
-of memory for masters in a Core Complex. The Level 2 Cache Controller also
-acts as directory-based coherency manager.
-All the properties in ePAPR/DeviceTree specification applies for this platform
-
-Required Properties:
---------------------
-- compatible: Should be "sifive,fu540-c000-ccache" and "cache"
-
-- cache-block-size: Specifies the block size in bytes of the cache.
-  Should be 64
-
-- cache-level: Should be set to 2 for a level 2 cache
-
-- cache-sets: Specifies the number of associativity sets of the cache.
-  Should be 1024
-
-- cache-size: Specifies the size in bytes of the cache. Should be 2097152
-
-- cache-unified: Specifies the cache is a unified cache
-
-- interrupts: Must contain 3 entries (DirError, DataError and DataFail signals)
-
-- reg: Physical base address and size of L2 cache controller registers map
-
-Optional Properties:
---------------------
-- next-level-cache: phandle to the next level cache if present.
-
-- memory-region: reference to the reserved-memory for the L2 Loosely Integrated
-  Memory region. The reserved memory node should be defined as per the bindings
-  in reserved-memory.txt
-
-
-Example:
-
-	cache-controller@2010000 {
-		compatible = "sifive,fu540-c000-ccache", "cache";
-		cache-block-size = <64>;
-		cache-level = <2>;
-		cache-sets = <1024>;
-		cache-size = <2097152>;
-		cache-unified;
-		interrupt-parent = <&plic0>;
-		interrupts = <1 2 3>;
-		reg = <0x0 0x2010000 0x0 0x1000>;
-		next-level-cache = <&L25 &L40 &L36>;
-		memory-region = <&l2_lim>;
-	};
diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
new file mode 100644
index 0000000..c135dad
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2020 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive L2 Cache Controller
+
+maintainers:
+  - Sagar Kadam <sagar.kadam@sifive.com>
+  - Yash Shah <yash.shah@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+
+description:
+  The SiFive Level 2 Cache Controller is used to provide access to fast copies
+  of memory for masters in a Core Complex. The Level 2 Cache Controller also
+  acts as directory-based coherency manager.
+  All the properties in ePAPR/DeviceTree specification applies for this platform.
+
+allOf:
+  - $ref: /schemas/cache-controller.yaml#
+
+properties:
+  compatible:
+    items:
+     - enum:
+        - sifive,fu540-c000-ccache
+    description: |
+      Should have "sifive,fu540-c000-ccache" and "cache"
+
+  cache-block-size:
+    const: 64
+
+  cache-level:
+    const: 2
+
+  cache-sets:
+    const: 1024
+
+  cache-size:
+    const: 2097152
+
+  cache-unified: true
+
+  interrupts:
+    description: |
+      Must contain entries for DirError, DataError and DataFail signals.
+    minItems: 3
+    maxItems: 3
+
+  reg:
+    maxItems: 1
+
+  next-level-cache: true
+
+  memory-region:
+    description: |
+      The reference to the reserved-memory for the L2 Loosely Integrated Memory region.
+      The reserved memory node should be defined as per the bindings in reserved-memory.txt.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - cache-block-size
+  - cache-level
+  - cache-sets
+  - cache-size
+  - cache-unified
+  - interrupts
+  - reg
+
+examples:
+  - |
+    cache-controller@2010000 {
+        compatible = "sifive,fu540-c000-ccache";
+        cache-block-size = <64>;
+        cache-level = <2>;
+        cache-sets = <1024>;
+        cache-size = <2097152>;
+        cache-unified;
+        reg = <0x2010000 0x1000>;
+        interrupt-parent = <&plic0>;
+        interrupts = <1>,
+                     <2>,
+                     <3>;
+        next-level-cache = <&L25>;
+        memory-region = <&l2_lim>;
+    };
-- 
2.7.4

