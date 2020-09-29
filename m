Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A91A27CA64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgI2MSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:18:48 -0400
Received: from mail-eopbgr770077.outbound.protection.outlook.com ([40.107.77.77]:13487
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730238AbgI2MSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:18:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNK1XyVT1wWmQwD43zWq3cX2HvbduNrMqozINNwphPGP+2Ee8WzjVgchwjPaOwPaP08BPasf8pKwXOShFtQVt8sFn3+2EgKRFYxBOMpDK8486wrAZ6HDk6ef2GNR8+WLOO461Yp7TJuxMVRFx5e5ZWrYQShmkPRHoAEo1ml37sNTIdv6epLkVwOvgDf2P40s0hyCsRNAVnBTXyt/JcUHkxm/sdySdgzCsDjVMopNqztI1NeBordM+7YoxT8cA8AzjNf6nbwIpRayrFCUcG1p/97u9yEEvQpT0w2N9zMe/hsas74nrVd54hgp4PMkyYMwedyJuIb48GGrvddRlM3i3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxg1cSWt4hnGpVriVsdZUKDb1DgNcWR/Y/yohKOnSFI=;
 b=CpEH4PFmNjHjv7FUqTLBzoTelutyjJrR1Wvd7V5fxJzi+AgDmJjlhWEA73qE5E8qKbF0gWAVCyP8dMZmn82Kvh/brZl+Wbk7UuzGpq2SY7nIz3Ek2EnjGPUurpx3NdlvJw8lrsacyP69yaZXbLRDPl4S1M4MMft1u9BSo3voRjUZL2EsGfIPiahpvQtfKOfGS8R/stK4mJxyrp/mcOzqgl+knjBItmKaQR//IStMr0yqTvbH9SCnjPiaq8Hjn9fcLtPfzO5hTzEt/H5RbtdlvQrFUrLf8tpTQ586nM27n71w1QE8EuAcr8YbKfMqDoUZTNBMhrt9Hd6T+2I0P9kxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxg1cSWt4hnGpVriVsdZUKDb1DgNcWR/Y/yohKOnSFI=;
 b=oJXHNoEkYmfRvJBkZInZTKnZoRWlOIhNIfv0HSg3dZr9R2QuaHODeZT9E/8wupge6UiT0Tku4VmI8erfiJki7PgruziQKIdwEkJaqywg0/aGWE+qcab8OW5gfgw31Phnr5n+0zoOOBf1eA1LEkkdbFRvPQJyGQhbsSxctU7+dEU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM6PR13MB4050.namprd13.prod.outlook.com (2603:10b6:5:2ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.20; Tue, 29 Sep
 2020 12:18:39 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3433.032; Tue, 29 Sep 2020
 12:18:39 +0000
From:   Sagar Kadam <sagar.kadam@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, yash.shah@sifive.com,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v4 1/1] dt-bindings: riscv: sifive-l2-cache: convert bindings to json-schema
Date:   Tue, 29 Sep 2020 17:48:16 +0530
Message-Id: <1601381896-29716-2-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601381896-29716-1-git-send-email-sagar.kadam@sifive.com>
References: <1601381896-29716-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: SG2PR03CA0149.apcprd03.prod.outlook.com
 (2603:1096:4:c8::22) To DM6PR13MB3451.namprd13.prod.outlook.com
 (2603:10b6:5:1c3::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by SG2PR03CA0149.apcprd03.prod.outlook.com (2603:1096:4:c8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3433.20 via Frontend Transport; Tue, 29 Sep 2020 12:18:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b81b47-e42e-405e-8f04-08d86471cc06
X-MS-TrafficTypeDiagnostic: DM6PR13MB4050:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB40509CE6E76CE6D9BE4ECF1E97320@DM6PR13MB4050.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pBso/Kcs1AtYUkhqbyoHQF1VoIToJWD4Lt1vIkTQvaTN9X3AK+VDgQm0QkDGPB42RS9NTztb+Yi+UMvM1hn5powf0h1xvqvj3nzrZtJS1eYefYojLD/LsnfXTZJJcPn+uGeZBdP+dwf9OnJCb+8QWfSw2VjTOASlJnM7X0UXmNvo2LyPdKr+FIa0FtMmEZT05XxpX2bjPJ3y3TmSDZc+rFEds9zH1vD2d32ZYYG6cJVJhSyMJ73bfXFYaxh4Rj0VsmckmfYNEY2NXvxz+DXGljq7uHtOJffOjCGGB+iAWyvwq/AxwCV9lnkXnG0b26ug0LMlWUjQcy9ecpO4ENN7V7pyYKOGkW0mUJKL/djTSgvGhpqxalVctIJEX0k+dClHo90rlnl/HaLIcZLNmXWOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(396003)(346002)(366004)(376002)(8676002)(66476007)(66946007)(6506007)(966005)(66556008)(4326008)(107886003)(6486002)(83080400001)(52116002)(6916009)(83170400001)(83380400001)(316002)(2616005)(186003)(42882007)(26005)(36756003)(956004)(44832011)(6512007)(2906002)(478600001)(16526019)(6666004)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hBZsacNTgVD/jCLSwqGGmPunOOdnU6Hr2oR1Byb97vClThDwnxKyZYS+KuhDKB7/ZDM7slRttEkKGML7lY/a5JJf2i6weOv4K/knaT5D+dsVqb3XzOvibSpyhMZd9M7Uvovzmyq3kV/FA3Vvhzy3AZ//DsDaloP8o2OYqQvvTOjDUlhlLFRuOPF3miqG4qnFkp3oIF+ZxaofOpN9tQkrkeyTB3A7yXTRU5yalus5t3y5FLnL/omsN76Ve9GSFZFIdgNhTqK5xRcbXJfoWvCOUcQjMm8hCIVEFT29cTCK9DS33Z50GJDbzzf1Lyo4RN9qQRK4uU5U+vgykQL8cb0/PtCwPOtIHMA9kqIryYmc4BBhRnS1bNobGdMs0BCjrNO87XSy4g6AJpXLsmo9NipgTrdkS1C92L/VLa0za958ADo6SxMLmE7+WEIIBNZBp4lFVtahFwj/SbNCNH3iq3ytYwwinXZC/5WbLaE6p+3QmJWMrw9pvj7L+xkCIG1BppfSveychhJhwBq6zT2vhXvyC7uaASaxWmlHMjQfh8EWPArY1IcM1x89ex17ehAXBjHPestkqNSmze3Z3nfrQjw6sk+rHqu2ratLs5koDTNxGZeOzefWFrt87puTv6JpftVxlwN6EqKq9t/CfCtO2frT3Q==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b81b47-e42e-405e-8f04-08d86471cc06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 12:18:39.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qON6pGmzJ25ftdjykKPdbXPZP4L+BglSldSxqV8pCFrIT0n0xKHvs4STn6hFtoXLE6jz7//WXK2twSUEHf1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2 Cache
controller to YAML format.

Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 -----------
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 98 ++++++++++++++++++++++
 2 files changed, 98 insertions(+), 51 deletions(-)
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
index 0000000..3f4a193
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -0,0 +1,98 @@
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
+select:
+  properties:
+    compatible:
+      items:
+       - enum:
+          - sifive,fu540-c000-ccache
+
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: sifive,fu540-c000-ccache
+      - const: cache
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
+        compatible = "sifive,fu540-c000-ccache", "cache";
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

