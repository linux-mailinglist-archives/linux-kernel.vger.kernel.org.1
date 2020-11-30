Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2512C7DED
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 06:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgK3Fo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 00:44:27 -0500
Received: from mail-dm6nam11on2064.outbound.protection.outlook.com ([40.107.223.64]:53728
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbgK3Fo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 00:44:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPhGbjxRSbMPD2Yp+ygmCWlg1HaKFjerSkK11xIThLKmKwI/62cEisUmZNFhNpWT/095Xc99O2IRPrbQCJ5DzfgAsxYxd9q0Ei9mffbGFkZ5LvODpcukmP038rruUK53RYqAnNZMQUE7ZJNQgaUFucxMWh022Byf6EwgG/b7TmF81hPbi7UHqeG1a3cRWIEOM170gAGQ9HKcviJC/wg1LdMDgGBKxdkRuJ8XACboLFpxUwio9vG4mm84/0WuK47MC3OnGV+NyqbR3F4zeIIMFqfnAGC95CQyuuyqPKdGnCDw56Zi65k4BAnqNrvdNl/LJvm3ZyGB5w/ZtzZ+4O8QNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpmaZZ49zlPkbh8FG6aGAJoSYp8F6ygjf42ozGBh2h8=;
 b=XWunLLr+Y6Cfae6XLuSoCbIb6Iy2L/I4bOR6bQ/HvB8ANDRLT3dMYyZKmvCg4DwqVwFHgAahms4H35MhmJ2c9uPbN/tz3Yr34cELEAp9Vs9hHFqk6g3sZpCXzv25eSMplSKpPLM4/fjsE56vEPZeSEcl4n7vXV8m657DrzSUC6v1n0CjeeOjabCOI9amOicEg/NgjfBlJk7SRIEGu8AFWLGl/dAORF9VImaapX0EtqMHQP+cNHBQCkp/7Xl0ojsyHZoOIQ6oGtdVAZxTLWZQ1dr+/GxnZyWBRvlBPzWJMpOX0/WZwRnvywm/sCalejuNcoFKxut+uIIZigMjXzrwkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpmaZZ49zlPkbh8FG6aGAJoSYp8F6ygjf42ozGBh2h8=;
 b=Ls46MmPyixDlIZFbbr8Hsepa5Js0YZTxPL6h2fpii74AjKjg4QR8XuMk+Kt9bHEwgnBfs6lCN+89oNEeKiht0cfTTMKNIhOUIKLqGhLRa9GH3u7htUsacQV8HpVprLiiFNjDGwxjWNi7llCSJkvOEk2aYIRMDZ7XaIz6nu116W0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BYAPR13MB2440.namprd13.prod.outlook.com (2603:10b6:a02:ce::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9; Mon, 30 Nov
 2020 05:43:32 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae%7]) with mapi id 15.20.3632.016; Mon, 30 Nov 2020
 05:43:32 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     bp@suse.de, anup@brainfault.org, Jonathan.Cameron@huawei.com,
        wsa@kernel.org, sam@ravnborg.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        sagar.kadam@sifive.com, sachin.ghadi@sifive.com,
        Yash Shah <yash.shah@sifive.com>
Subject: [PATCH v2 1/2] RISC-V: Update l2 cache DT documentation to add support for SiFive FU740
Date:   Mon, 30 Nov 2020 11:13:03 +0530
Message-Id: <1606714984-16593-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18)
 To BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BM1PR01CA0102.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 05:43:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a69e8320-a87d-47de-dc3e-08d894f2df9e
X-MS-TrafficTypeDiagnostic: BYAPR13MB2440:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR13MB24403C4B39A53F62CE39EE3282F50@BYAPR13MB2440.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bb1tFfISLvrpz0oh93DddQI8Kx5Vdq58UyS0X3dUmjDiEighS/EmRfuXs4eWzU+6yl9J0qJ7EElzch/g3TnhCAxXm3u0sUHdtJC7X1D2P+fyX1CCq3U8aaol30II4umLhVne+BXu00cZyWQDr/ktR+Ez4EG8426oN42SB6vs1nOKUGIJjTcOauVLaZ9CfhPI8jwqNmNxlqh4Y68n89ktsOMGiM27ac855xgh4XkZSav7O2A5z2zrhYRLpOCEDk/FG4CllwBTuVnyIMWPt5/ldyjNpR9ANETIdv/aYgxI1ckha2byX9UIp7iQRPHpHNqZMbnok8HTV4M+TWdgjqe1Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(376002)(396003)(136003)(346002)(39840400004)(366004)(83170400001)(15650500001)(66556008)(5660300002)(36756003)(6486002)(107886003)(6666004)(316002)(4326008)(2906002)(8936002)(42882007)(2616005)(6512007)(956004)(44832011)(478600001)(8676002)(52116002)(16526019)(66476007)(26005)(66946007)(186003)(7416002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4ZIQhfPHGneGGE8u0N04Qm64z6e94BZvQLYz2yOQEhsJMQmbI/gpltdYri+h?=
 =?us-ascii?Q?l+eG7xT+1aZVn+XPVGNvjaJSK4XW+fLkJjQXIOatl+Qvu41hz5jdua46nCYV?=
 =?us-ascii?Q?Rp9WL3mGYEka67OlGm5aBc/UStwpPvcSScWWYNnMsMUrDl9QUZu7Clt5R2Ze?=
 =?us-ascii?Q?xa9lmyKMwrNWR0PXFM0es4p9pplOktM/tWVxmyGXEHVTKAnavbzDpeyJ/o+X?=
 =?us-ascii?Q?AMKC2vDtNZSGLbEDT7x244Ry7JbDsiFevqwcGNunXJFbNGj1czD8Zi424Yrm?=
 =?us-ascii?Q?fehwqj2pQBw/JfUGxVzrlfjlTADljl/JZYFvXBrYFcVWYrf6sKsASvKsr6Cy?=
 =?us-ascii?Q?L7CJ69xxrglImFHMhUrwQQLwSDU+mOuymGDHeceTWVUZGT+voU7OORZ3nzX9?=
 =?us-ascii?Q?3Nawu0NdJJ+FP4Nb8ALuzr5h2TsYDTkl82786WRsJy8HIarXaiv39z4L+Vgd?=
 =?us-ascii?Q?caF7peKcok8IN/s+bsD/tJSR+uwr5IdQuGvPPGmpqBh9cxYUut5yxYxTX0jZ?=
 =?us-ascii?Q?KDWzDPNZOv5y+zEz4ic/tf3kHVl7d/U8YbXFmSXSSP83YKUtdbz/RtkUvWjr?=
 =?us-ascii?Q?JJIuUepSyZ9+C99eVdGTKZDZGRsISIMpDx+htnZn1QsKgWedcEOxlzvMyIo9?=
 =?us-ascii?Q?qfjv5fHXENOpJsv/YUJKBUwAc9S+GC48usU9Lz2IeMM2V4MssMItTC2CSn+y?=
 =?us-ascii?Q?VifM5EUtbuPx6aaBhb1D31G1Yzy/wTp0voAz5r2YK4ioCmWbX24//yXsvXvn?=
 =?us-ascii?Q?1xXOnbJy6KETAz847KO9VUXzPHfQA1r9OvYLlP7wmHAkQddvYk/KpE4gCfnO?=
 =?us-ascii?Q?EtiibRS02Lmu9FDbXbGH7n5mc8kxrxdYHAtMhK3eBFqWIl6Y07TAVaEphx8S?=
 =?us-ascii?Q?1nQsFUhbZnE6gkITwON+kGFoBSe+T+w/j9TZqOFGnBTwU8wHncSKKXDWu7+x?=
 =?us-ascii?Q?l1WXuEJYRIdLcOWX8hwGfgEVPeGzbU7hTxUQa4SRyhk/s65uD6bOzYgYWM6f?=
 =?us-ascii?Q?hhTx?=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 05:43:32.5700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-Network-Message-Id: a69e8320-a87d-47de-dc3e-08d894f2df9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OI3ueqy4+W6mfTV8GcclzPhJi1ZnzMbm1cIjXif4g7DGOO3Gk57dKBs5DLzX9QyJNOl8AT29CbpAyQy0qAfJQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR13MB2440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
compared to 3 in FU540. Update the DT documentation accordingly with
"compatible" and "interrupt" property changes.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
Changes in v2:
- Changes as per Rob Herring's request on v1
---
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 35 ++++++++++++++++++++--
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index efc0198..749265c 100644
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
@@ -53,9 +56,15 @@ properties:
 
   interrupts:
     description: |
-      Must contain entries for DirError, DataError and DataFail signals.
+      Must contain 3 entries for FU540 (DirError, DataError and DataFail) or 4
+      entries for other chips (DirError, DirFail, DataError, DataFail signals)
     minItems: 3
-    maxItems: 3
+    maxItems: 4
+    items:
+      - description: DirError interrupt
+      - description: DirFail interrupt
+      - description: DataError interrupt
+      - description: DataFail interrupt
 
   reg:
     maxItems: 1
@@ -67,6 +76,26 @@ properties:
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
+        Must contain entries for DirError, DirFail, DataError, DataFail signals.
+      minItems: 4
+
 additionalProperties: false
 
 required:
-- 
2.7.4

