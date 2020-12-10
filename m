Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2782D583F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgLJKaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:30:10 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:23325
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729974AbgLJK3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:29:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zu7Yl6VZJ4dlFG/5luwVXBpxfbcBZZ/jvJJA+Yqy3SyvSJu9hYuHW3gCMeCmloKodOG0cnWQ4aw+i30zZo/TzY4L8qhS6eifgjI5HDqbHf4j/+Fu1lOoFFqlfwycWnMmZ4iLCa1E0RJTuauvcgXkvRuJvsdfv18tQ808gEiX6kJRYYwdzB2j66rBA2f4Fk1ox12laIt1UEfe34WXkkbHoTc0TffN+xQYvHW29Y00iLxEkb7wul6SqLfpL2YX/9QbZwb4UBS3k8XoDf5fEA6H9dXb6AFc2RKtoh3TBpc6xYJjPfi4C8BwXgJuL9q1UUacEOL5sdla4qoZi+GiAHIdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmb1CK5yjZ6yBw7ppx6+BtA+rT5yi5GNp2Pp+1yA93M=;
 b=SU9vwiqpuzjgPYx3b3iv1S+AJb3YNDP9bb+ATQhkTpbJfU3mq7CxTDrih5bpplFAnZYOMc/JmbRxjuIP4j1adBB3f5S4H9iut2ACWA5uIKOsRTBrbhGXcscx58Lu/RBI5m1GR5qMHFuHJ6YjzpoVJ2jFnJjBpL1m1VQ8KqoMXmGV7sVsXz5DNWRzcDM+igNb+im/bRVmqPIptHiFXGpxZOCv8IlW51wDeP9ko0W4TxFCMFRmLz53E36KgUBA5D5c/dMMdgdn2deipwPSNKL8rGkbUHP1TLR62FO1GVcF6I977rFYIUBsCkzZ9NE3a+Ft9fr7P0Z/H69w2Jq6fmt7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmb1CK5yjZ6yBw7ppx6+BtA+rT5yi5GNp2Pp+1yA93M=;
 b=tG0bap1M7DF/BB0WYdHA1b6c45NsBxTtFM5jT7PfmeLUeZS1VzDv700R13D2lwTZRsrYrpMKBmm5nhu01/b+0uILVVkD52X35JHisixxjCBMwEgUWGSl4OastOBW3R8BV68XeE67m+iaD1v0pySlUTs23yVZdS4WE4HxJDeLGhA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BYAPR13MB2838.namprd13.prod.outlook.com (2603:10b6:a03:fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.11; Thu, 10 Dec
 2020 10:28:25 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae%8]) with mapi id 15.20.3654.015; Thu, 10 Dec 2020
 10:28:25 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     bp@suse.de, anup@brainfault.org, Jonathan.Cameron@huawei.com,
        wsa@kernel.org, sam@ravnborg.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        sagar.kadam@sifive.com, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v3 1/2] dt-bindings: riscv: Update l2 cache DT documentation to add support for SiFive FU740
Date:   Thu, 10 Dec 2020 15:58:02 +0530
Message-Id: <1607596083-81480-2-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607596083-81480-1-git-send-email-yash.shah@sifive.com>
References: <1607596083-81480-1-git-send-email-yash.shah@sifive.com>
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: CH0PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:610:b1::20) To BY5PR13MB4453.namprd13.prod.outlook.com
 (2603:10b6:a03:1d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by CH0PR13CA0015.namprd13.prod.outlook.com (2603:10b6:610:b1::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.9 via Frontend Transport; Thu, 10 Dec 2020 10:28:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 925f851d-2c38-4538-980b-08d89cf65384
X-MS-TrafficTypeDiagnostic: BYAPR13MB2838:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB28380EAD048ED753CA5F5CE382CB0@BYAPR13MB2838.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /uYoiUqXVMJvWmLotejBADglIU9xR1ODzmoYeKMI90Ub4a0KD0yrukG2w30lyunHr/4xV20wMAxhZQ9fLNJ4c2mwTusReH816RrxcTzkXa4g14+qq0hCwxmw6LIgkCSmcjmSZ51w8CmpYpM0fMio8RG8P8n371WB6V5QucMdJrIkKXDuGQ5XGEGmkOfBub4TVxG0EhTfs6Z31B/eFEmwtUmk5DqOhZS4i6rhe95sBrZ96DUSXhowTUIBEcS69pjLc8LK0mRBpo4vYGs+B+ku1PU17YncxmS7/a9Cn6hhvXrIqE4Vig+kHo4uqD1Y6lD6fn63A6p3r3295dvaRZts3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(376002)(366004)(136003)(346002)(15650500001)(7416002)(508600001)(26005)(8676002)(36756003)(4326008)(956004)(66476007)(2616005)(42882007)(66556008)(107886003)(44832011)(8936002)(16526019)(186003)(66946007)(83170400001)(83380400001)(6486002)(52116002)(2906002)(6666004)(5660300002)(6506007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?erTnY11vkoiMQLDllQ+X+iIjBx4BgS5gliab3iDGQqIRnByOm4m6ek1Xa4YM?=
 =?us-ascii?Q?AOl4bHn6bq2eryZaN/1Fv7m+SbaAhXDRas8WEHqATGMqtRNyfN4LbSu6t4AN?=
 =?us-ascii?Q?2pKK2RfogXa6L4ICG85khPBAMcpjkIROg7x8sEFIGSys/3ctZrTr184A/9dz?=
 =?us-ascii?Q?TfN5zHQ0vMKziqKXfoxQIXTXbGOj70QcFnY1vUGpK1Dhq5FNpAhqcTBWis/3?=
 =?us-ascii?Q?H9Do5Sj7KqqfJMPWvLzu6GZph4ibSK0+tdYfnFjlunFIgbwReBTach0Ei/G3?=
 =?us-ascii?Q?ajV5ZOYTMEy2BJsplRP/9g71bRtr+UHunqvk/uwf/zVBmw5piJ0YKICqp2OG?=
 =?us-ascii?Q?xA1BMdQtmC1Juby/F43qaH1XeYxtDvkZ4v9+VfYGplzx1pPVcP7o+MTPPVqd?=
 =?us-ascii?Q?rD5ls1jM7LZ06+YuplTViozAAHq9EwuzxUUKbi90IEBCrdUcMFbgjyZ1S8z9?=
 =?us-ascii?Q?5SqkkVZN4uSVJiW1TT7fqARsaE/MQxjnpAAEy8nFTMvC87BKdMMxZZFGyV9x?=
 =?us-ascii?Q?UomK+RHzm2nxfeesaisJ+E0csctu6hTRD0g/gT9+LqbIZmU9zukYu2Xw0W4G?=
 =?us-ascii?Q?+jzsAP/2msPOulfY3Dyl8TCJJih+X7Ntdg7LOcE8TdbjdUU8Zd/LycwNYBVj?=
 =?us-ascii?Q?LqY4EqNaDd3aZqFit66MSDcFUN8JIjhPduoD4noqbmpXiugb4Y4dUhuNR//h?=
 =?us-ascii?Q?neD2lnz+OlbbjXehbn23FfBEn/CzXEpEhzy6MF/lsIDEJlemfDLGJ/vW0ycN?=
 =?us-ascii?Q?/0yIwilLbSqcSE+yMGhxZjgvHXiept3wkGhaf1HPBHGPMAUGInQkHlBNud9n?=
 =?us-ascii?Q?L9o1hV0ZC/m3p9nf5FZ/tGmiBJ9VXqK3A4fI+X5P+taQEh87qkgF0Xdtdi1X?=
 =?us-ascii?Q?MQ7NPYnKSy7ke5wH8u90qRwCHCXQRhxRVGJNS7TUSc3555ZgIAWFqXy/hFGU?=
 =?us-ascii?Q?eucciTw6vRpvbpZrYb+BR2Fnsgz3U5IFuxzg08L2bHcp5abVJqUvkoCD+mfS?=
 =?us-ascii?Q?jxZg?=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 10:28:24.9155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-Network-Message-Id: 925f851d-2c38-4538-980b-08d89cf65384
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDXAmXcfqOhYc80BLeKJsDBHu4a0wl1vCs+MoMXqQTH7u14ZQJOaisyLM1J7KBya2T8Sbl0NDqc0I60mXPqi0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
compared to 3 in FU540. Update the DT documentation accordingly with
"compatible" and "interrupt" property changes.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 34 +++++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index efc0198..6a576dc 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
@@ -27,6 +27,7 @@ select:
       items:
         - enum:
             - sifive,fu540-c000-ccache
+            - sifive,fu740-c000-ccache
 
   required:
     - compatible
@@ -34,7 +35,9 @@ select:
 properties:
   compatible:
     items:
-      - const: sifive,fu540-c000-ccache
+      - enum:
+          - sifive,fu540-c000-ccache
+          - sifive,fu740-c000-ccache
       - const: cache
 
   cache-block-size:
@@ -52,10 +55,13 @@ properties:
   cache-unified: true
 
   interrupts:
-    description: |
-      Must contain entries for DirError, DataError and DataFail signals.
     minItems: 3
-    maxItems: 3
+    maxItems: 4
+    items:
+      - description: DirError interrupt
+      - description: DataError interrupt
+      - description: DataFail interrupt
+      - description: DirFail interrupt
 
   reg:
     maxItems: 1
@@ -67,6 +73,26 @@ properties:
       The reference to the reserved-memory for the L2 Loosely Integrated Memory region.
       The reserved memory node should be defined as per the bindings in reserved-memory.txt.
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: sifive,fu540-c000-ccache
+
+then:
+  properties:
+    interrupts:
+      description: |
+        Must contain entries for DirError, DataError and DataFail signals.
+      maxItems: 3
+
+else:
+  properties:
+    interrupts:
+      description: |
+        Must contain entries for DirError, DataError, DataFail, DirFail signals.
+      minItems: 4
+
 additionalProperties: false
 
 required:
-- 
2.7.4

