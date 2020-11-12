Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8CC2B01CC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKLJMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:12:17 -0500
Received: from mail-mw2nam12on2058.outbound.protection.outlook.com ([40.107.244.58]:30929
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725966AbgKLJMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:12:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EWaFTkVT+W6scdBp9ggDEp+ewi7eYuSKojPZmHptanx0ITSR9Bs5wsdtKd41Uw1K6TjRv65RAlDlTAzBNakT9PdAH9v+lbL8v1TpFJZXk2Sl4lak2BZXteIdMifr2s7xFerp0MXzamfVrM5y23YlyEnuEzEX/mUikZNhzT4u/1h16oWPO7msAKHi2Av3D6PqreSCJtlmLLRjcAlxIfmHpRVGlQ+0kc08u6uypPG8+xQmx+enz2cNQcM0/Oqdc8O14fD8i7EsoQ2uyJFhSarNAfJC3HY+puHp2sy+v/Dv6IX17qkV1v3lcB+2dPPyybItAhSwUgsO7bf7OswYAC85Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXsSrjeqxcYSvcr4n+QpYklVAMccsYdU96hAQy9szrY=;
 b=UqI4ZTIx7dAkDLqR4SlTxcgs1tee/TpMAJWqm2lVosK7ZJq1S+ZhDp8SYn6LEDgjtBIDUCjon5aOYOagnKc3Vhlj8jXsk3efLyW68PhMFW3su0RZp7k5VIocRkupuAsCzH/6fogi1wzlEfXCG9I07uuLrJ9ZUs+TtrmQvu0vI6a5ct1+p/AgvcsHvfZ1CJ7CXNoV7APtaeUNJHq8M2DbbNPbnoD9iEKMgJwRc1Ma65aiU+zMjjwlIeamEXUjYvO39SZrbFdl0Y3Zya+WxzLg7nBjMHaNBeWK94J701PbR3Ex7xcNteAgXZNnKhJZsRRHkKO6kmmiIhlTKjn/pDn6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXsSrjeqxcYSvcr4n+QpYklVAMccsYdU96hAQy9szrY=;
 b=lz89PEgHSyO1If8hJ8OUbknP1iDQQ+iNmzZSX3EWTNW0iK+cleJRvbP48LWwU8aLt/yzuvHmvfdgDoMhhRmaCiz23N5uZSTMamfvoTSsvysomPvJ2XdrKVwZ975UqTaMgG8sQWMxvGx7GvbYvTB7HAub52HDl6j4EaoumvIqF48=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sifive.com;
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BY5PR13MB3617.namprd13.prod.outlook.com (2603:10b6:a03:21b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21; Thu, 12 Nov
 2020 09:12:13 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::2c46:9095:ba12:6513%8]) with mapi id 15.20.3564.021; Thu, 12 Nov 2020
 09:12:13 +0000
From:   Yash Shah <yash.shah@sifive.com>
To:     robh+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com
Cc:     aou@eecs.berkeley.edu, Jonathan.Cameron@huawei.com, wsa@kernel.org,
        sam@ravnborg.org, sagar.kadam@sifive.com, anup@brainfault.org,
        bp@suse.de, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: [PATCH 1/2] RISC-V: Update l2 cache DT documentation to add support for SiFive FU740
Date:   Thu, 12 Nov 2020 14:41:13 +0530
Message-Id: <1605172274-44916-1-git-send-email-yash.shah@sifive.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [159.117.144.156]
X-ClientProxiedBy: BMXPR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:d::17) To BY5PR13MB4453.namprd13.prod.outlook.com
 (2603:10b6:a03:1d1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from osubuntu003.open-silicon.com (159.117.144.156) by BMXPR01CA0007.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:d::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 12 Nov 2020 09:11:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3fb37b69-d609-479d-e071-08d886eaf98b
X-MS-TrafficTypeDiagnostic: BY5PR13MB3617:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR13MB361703E5690BAA82032DD3F482E70@BY5PR13MB3617.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6vkFWcyXEdPicz1aSHtW0H3+XZC8T7FXMoDyLYROIHNfouuwiwbIWTLNYlEjtNICPKtjv220tVXHzMtWSaG3HMU2ZCdJ03Ucclcd3pyv+GLZVd/OJZPOTrLSiBdDK2fM7zNxeLnp+AaXaq0rgq3CC5xh5X6OyIJgRZmPLXP6fepi3y7WqIGqNn02PF564OPizcdGfxw+CzTfVR/a9l49qw3zk2FVI4psChEX2xyLWq2kJ6AvDLum7ZtgAQUXP7/ZYhS/5GPIvuZKqBG9TuR1N6bJhz+vAGyG4R+OukM9mtCr5OqU+UJvNMkqy0sf4SXB3wL1bGHL8U3GAMN5tqeaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(376002)(346002)(39850400004)(396003)(136003)(7416002)(8676002)(44832011)(52116002)(83380400001)(6486002)(478600001)(6512007)(8936002)(5660300002)(6666004)(36756003)(26005)(316002)(66476007)(6506007)(186003)(16526019)(15650500001)(2616005)(42882007)(956004)(83170400001)(4326008)(2906002)(66946007)(66556008)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gXmTCI/vGvVf+pZ3K8ance/wKL5ccunuyDCyGQWjZr+ZnHkl9YqJ+EeI6g3fdqPQUrCehMtFXHK//EWa8Qi128gH29pLw8z2FdM3yxKclBS131a/UfDX0yE4Ymb0+l6ueYHU0iqB862ySHRZ9THiTRqIfmOhleC2R+4lDP6ztCg1UiFpWxVUbJUZCqWme4+y0a8wpZqX3+cVHxBTjt08pgx2OC6Q0Ger/o8S4dyMmnfYSUkKmYAEAY+CMlROiLSNL1QyVWI1j5XEzzHMYAC2myHTErGouZkKO8SYVSa/ViiEamZMdaJd+D2CXd42hayoujET3mcZB0IBThSyGTPA+UvmmxdtK2tijRvV0BGNlr2//iXTT4iNhAsMGmBe/tlzD/QsLE60NVx/sDj9RZLgY0YDMgbqpJ+cEBrDp8xyX185FeOHQNIoC4SsVXsH/l3nCIrTAlOSJwpvZ5+mP/TeNCPYepbTiuGKHIn4kWTScvgpyv4qaegAD0P2/6y7ELie2fw0+GnTQQ+IPu+eVZzoOuVRakU8V7GLCaYDKpEg5WjD8CWqeQg1Fw4yCFlLqaZAXwO3xZ5G151GbkxgMmTv8VXw0ehEtVfBXEwfsLW3M+g2zLp1df2bp9znopiFi8Xv4U7Wl+LphkvAVmMW8mIbdoTLJ6PxbQ3S+MIpaDFZABWPw/A3tIcZb+SFNYjwQkx8s1DOEjDG6VPqrLDo3QK5mPrrBJ/Th5oKS/bI0mnVkeuS1rjpZBy/iPbbj8FdMmL3CepMjxkFCgXAK3QJrhCo404oyghDUNRFpDTl/361pOTW99p8lvnU79m5pXv8auNgQij+ZkOkYhSzdFTMVnq0FGVEmdn5618lvO8VuAjQWBUchzEueT16wD0Bi8Qaw4ycVQiKvlN2IEWLspdcuYgxYw==
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb37b69-d609-479d-e071-08d886eaf98b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 09:11:44.2925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRbJroKoWCER/QPtH2my8ti1ceIGsyIeWmbjq7LuVmyyhWgI4FQ2ULGoMwUl8KgnycgrnYGPo0rIIUNDkDdhGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB3617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
compared to 3 in FU540. Update the DT documentation accordingly with
"compatible" and "interrupt" property changes.

Signed-off-by: Yash Shah <yash.shah@sifive.com>
---
 .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 33 +++++++++++++++++-----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
index efc0198..4873d5c 100644
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
@@ -51,12 +54,6 @@ properties:
 
   cache-unified: true
 
-  interrupts:
-    description: |
-      Must contain entries for DirError, DataError and DataFail signals.
-    minItems: 3
-    maxItems: 3
-
   reg:
     maxItems: 1
 
@@ -67,6 +64,28 @@ properties:
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
+      minItems: 3
+      maxItems: 3
+
+else:
+  properties:
+    interrupts:
+      description: |
+        Must contain entries for DirError, DirFail, DataError, DataFail signals.
+      minItems: 4
+      maxItems: 4
+
 additionalProperties: false
 
 required:
-- 
2.7.4

