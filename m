Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E92A26C78C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgIPS34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:29:56 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:22328 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728061AbgIPS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIQfcQ014144;
        Wed, 16 Sep 2020 11:28:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=hyvP7DnHudwtrLyGu9KPZa/ElraYTDIm/Km+cQK7fck=;
 b=FzyQCsiJ4nSGOWwG3fmtD1TnI7aPjQyWDRrygvKmeBxe9pe06OvNT0SLOQZHNus3FPB0
 mVEL6XXGSqHjnMQKwjylytRV1fzcOCXvw7TuVCq4ffHMz/t6nbBj/31ZR1R4PshPVnQa
 mWCxLSeNriuV7jG0jI/YvaYlCsC/ACKCy5UUrqt/Vd54OzhQb6d76sI6rRrhDs2dA6zi
 ZN9x/Z4OFOjoDOY16BV4iqgSyZCWCV5Uq4MKqkFio80P46vTqgDb3Dn+b2MjOY/ksYji
 ExUBiwAMZn0QmYpnG4bCU+Yy2odsy6LDfcp/MhG4JFmR6/bX+yMvWPkIzLTxcM7vhG47 aA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmm7kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgAtAMRJjnveY5Oaaobf82Io9QomQRyCW+ic+P3V2yCu3xz7cIQ7ml0eFELsMrrJjZ+SLJ9h50GYInK0lrgBYbDcVEyonXAl0EJljBOVOPETZCELSkacuKtyU0lG2btv0v1OxXljODuaiWOAbO6QYwgVBsXnbcTTp+sDbxCG3z578tRk69/khK/YpOkU8ErbqYUTTakWa/AMcKdCV4gzLjfMFvRSrumRrjJJH9hFICtNykHDXbjVkckZmz/tZJ1mnoNwHN1gBpcJKfze1sXyeCg0mQhs+TAIgGKhuAZtaZjwNyJBYSQu+sZThVouMtDIYihgioIoe9n2QXRp/DRUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyvP7DnHudwtrLyGu9KPZa/ElraYTDIm/Km+cQK7fck=;
 b=Xo8ZNc5L73803lGTqjrPs+iZPfQCrNzP/fltQzWHc7bmeaOO7ouqA5qzb5EUPW7YS7wOxyT2iURieU/SrEcXyYIbO09sWXuA8HapAzdVuviNYFq4yOJ7+zCtCj89+A8UL2YHNfi/lzdQqDbz6zyOETWVbFXta4Im//ZzfhKkmgWlymJ1ZWOTbD/S+HWSwtnGesUSF9kiLQ8c5eStbBvaQjQq84c9U32s60RPQv1B2O3Sdha60u1iK5aOOL6pszu3+omh8XbZWhNOjkvwoSSjI5fBsjGx2M3RUUPinu191/id194ibC/XjAdNB4axFKDed1oeU5UUNiUuOTzUPfrnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyvP7DnHudwtrLyGu9KPZa/ElraYTDIm/Km+cQK7fck=;
 b=QSM9tcYhUlFUJvhcjgpT2P4xU3NvtzdmKMsVh0CRqvip0xr+9BZgnG0AfYGTFVSJiuZWt8EXssu6RYyrUxDVik+5lygVEPKcHW6g3NbM41grKaAa8QpqiD+qF4j5VNsMvRE7n6zP+9I8laYao/r/UicQusN5eBcFN8PU7Irbwx4=
Received: from BN6PR10CA0034.namprd10.prod.outlook.com (2603:10b6:404:109::20)
 by BYAPR07MB5960.namprd07.prod.outlook.com (2603:10b6:a03:134::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 18:28:38 +0000
Received: from BN8NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:109:cafe::3a) by BN6PR10CA0034.outlook.office365.com
 (2603:10b6:404:109::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT056.mail.protection.outlook.com (10.13.182.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:38 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhU016248
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Sep 2020 11:28:37 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISW0O009282;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISWNr009281;
        Wed, 16 Sep 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 7/7] dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for generic use
Date:   Wed, 16 Sep 2020 20:28:31 +0200
Message-ID: <1600280911-9214-8-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5260b0e-d3d6-47e7-1f93-08d85a6e548d
X-MS-TrafficTypeDiagnostic: BYAPR07MB5960:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5960CDF4C44277FE581562B9C5210@BYAPR07MB5960.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SlmHOy6DXxikmpYeWjktLfrAtyMqIS5iSfhOCNzgnS2aOEEe7U9Isw2CxIxKZYVN82WKLvaZ3ik4uVUvfePQhrl7t0X0Uehavr/9HVrLBKgGO2lvW4ztuB9HCSt5nrfbwyjbR5nvrDFYEFBVcCe0LdG6LjA/Jazx1uBXFP7WN4YWLM6RvcbM2dStH7IqlQCHhFGausolyO526tYPROaPXt7JnZXksfrhpwElw0g38oPwieRkQO9H9cXtvxT6ZYRuhRg8PK7IABn3A4dKbH0B/zJPltAg/SJQ1mKnxro1/PgPRuYobLgLj0kSt4VcC5RB7sVVEIccVG00j0EhoZLDs1+x6FH1m8eyI7j9HPaMn/zwa7gygmoEkCHnBKcrI8er3szW/upPXCAq874CnQLvWGHuNHt/mdbOWfCb5U0kOnL9kDiqU3wdPSDoy8zK9PJZJ7fsDTFPO4ojExhYKVbkeC0F0TdD1jsofqnbrae9AgdOWns5G0+M3+l+ldIDyqzYGeuJeA0dWI8BtqMIRmzHQ==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(36092001)(46966005)(426003)(356005)(5660300002)(2616005)(7636003)(47076004)(4326008)(336012)(36756003)(15650500001)(54906003)(8676002)(8936002)(83380400001)(186003)(26005)(316002)(2906002)(82740400003)(86362001)(42186006)(36906005)(70206006)(110136005)(82310400003)(70586007)(478600001)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:38.2993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5260b0e-d3d6-47e7-1f93-08d85a6e548d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5960
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=783 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY can be used in different multi-link multi-protocol
configurations including protocols other than DisplayPort also,
such as PCIe, USB, SGMII, QSGMII etc. Update the bindings to have
support for these configurations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../bindings/phy/phy-cadence-torrent.yaml     | 77 +++++++++++++++----
 1 file changed, 60 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index a7ee19d27c19..26480f89627d 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -4,11 +4,13 @@
 $id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
 $schema: "http://devicetree.org/meta-schemas/core.yaml#"
 
-title: Cadence Torrent SD0801 PHY binding for DisplayPort
+title: Cadence Torrent SD0801 PHY binding
 
 description:
   This binding describes the Cadence SD0801 PHY (also known as Torrent PHY)
-  hardware included with the Cadence MHDP DisplayPort controller.
+  hardware included with the Cadence MHDP DisplayPort controller. Torrent
+  PHY also supports multilink multiprotocol combinations including protocols
+  such as PCIe, USB, SGMII, QSGMII etc.
 
 maintainers:
   - Swapnil Jakhade <sjakhade@cadence.com>
@@ -49,13 +51,14 @@ properties:
       - const: dptx_phy
 
   resets:
-    maxItems: 1
-    description:
-      Torrent PHY reset.
-      See Documentation/devicetree/bindings/reset/reset.txt
+    minItems: 1
+    maxItems: 2
+    items:
+      - description: Torrent PHY reset.
+      - description: Torrent APB reset. This is optional.
 
 patternProperties:
-  '^phy@[0-7]+$':
+  '^phy@[0-3]$':
     type: object
     description:
       Each group of PHY lanes with a single master lane should be represented as a sub-node.
@@ -63,6 +66,8 @@ patternProperties:
       reg:
         description:
           The master lane number. This is the lowest numbered lane in the lane group.
+        minimum: 0
+        maximum: 3
 
       resets:
         minItems: 1
@@ -78,13 +83,14 @@ patternProperties:
           Specifies the type of PHY for which the group of PHY lanes is used.
           Refer include/dt-bindings/phy/phy.h. Constants from the header should be used.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 3, 4, 5, 6]
+        minimum: 1
+        maximum: 9
 
       cdns,num-lanes:
         description:
-          Number of DisplayPort lanes.
+          Number of lanes.
         $ref: /schemas/types.yaml#/definitions/uint32
-        enum: [1, 2, 4]
+        enum: [1, 2, 3, 4]
         default: 4
 
       cdns,ssc-mode:
@@ -108,6 +114,7 @@ patternProperties:
       - resets
       - "#phy-cells"
       - cdns,phy-type
+      - cdns,num-lanes
 
     additionalProperties: false
 
@@ -142,13 +149,49 @@ examples:
             #address-cells = <1>;
             #size-cells = <0>;
             phy@0 {
-                      reg = <0>;
-                      resets = <&phyrst 1>, <&phyrst 2>,
-                               <&phyrst 3>, <&phyrst 4>;
-                      #phy-cells = <0>;
-                      cdns,phy-type = <PHY_TYPE_DP>;
-                      cdns,num-lanes = <4>;
-                      cdns,max-bit-rate = <8100>;
+                reg = <0>;
+                resets = <&phyrst 1>, <&phyrst 2>,
+                         <&phyrst 3>, <&phyrst 4>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_DP>;
+                cdns,num-lanes = <4>;
+                cdns,max-bit-rate = <8100>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/phy/phy-cadence-torrent.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        torrent-phy@f0fb500000 {
+            compatible = "cdns,torrent-phy";
+            reg = <0xf0 0xfb500000 0x0 0x00100000>;
+            reg-names = "torrent_phy";
+            resets = <&phyrst 0>, <&phyrst 1>;
+            clocks = <&ref_clk>;
+            clock-names = "refclk";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            phy@0 {
+                reg = <0>;
+                resets = <&phyrst 2>, <&phyrst 3>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_PCIE>;
+                cdns,num-lanes = <2>;
+                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
+            };
+
+            phy@2 {
+                reg = <2>;
+                resets = <&phyrst 4>;
+                #phy-cells = <0>;
+                cdns,phy-type = <PHY_TYPE_SGMII>;
+                cdns,num-lanes = <1>;
+                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
             };
         };
     };
-- 
2.26.1

