Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C717026C813
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgIPSkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:40:40 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3130 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728062AbgIPS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIQfeF014147;
        Wed, 16 Sep 2020 11:28:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=K6qOnJN6usSCAfPPATIMyYfgLkcxVTCLrAjaeLhc8tA=;
 b=Pf8TE4/pTIZPqHGyjnX3PKGXC/4VzNfjpxvivfqtQUOm8Tqq/OCWzcwohmwVyrvsoKZB
 DEMtv5xPIBUtnu03DMO/7tFRzT4Zs39nY8jh6BbKZj9hHiUSHeWVoGhs/SvfATXASmen
 +/R9haMPiqzU2h/TYt/i7PBg5R9PWKVfmKrLLJiURfje1NaKI6MQV3Lwi00AzxWYIqUF
 6ZJWNdNCvcs1637QJtjqq/SZIMO6Zq4iWEU5V4sVigiezVwQx+Zs+g5fLWqjBeKfwYUZ
 imSz43BZdap6Y+VcOdU0bxkk3lPfgTww6Jbnn9BeMkJgzydUS0W+P1oGn4bi4800+iGe DQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmm7ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/QnaBBGUbTwil0joKV0A+f9WP/3wAEpil7ZF8M1Tzsf/1X6Dqs1SQaVsuK2sRgvfOnO+h3YEhRsC8ffaYtyOAsUTqlAfe4SqzkzfhxiFloAxbBWgV0uuy9beSJYvvnjVD7KuVh0T65Un7CrtqrdpfZQCXrHuyRAwoosR38vJ1plC/g3HFIOpmFW+hED3AjuSitV3V1bRfNbD2kDEbrfNThuoM7sZrtYEsYjM3vpRCrUOBYKPg2iHafHY6Z4+Tzlp2laP74GvP9LgEkYnZ31aMoLUhczwdroia+Mr5wv7Uce43yLAA17/nFFKnHN5cCWez+KDIg9x7DSE+t2snt3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6qOnJN6usSCAfPPATIMyYfgLkcxVTCLrAjaeLhc8tA=;
 b=kzktJhDhc5tRKUugjmRwFfaxCuY7SQMd3Q1Qi3J8ZQYgOVXsgEOmZzM+CGwgbi5H21Af1XcyQr8/CIWSjEjP/E3ppVEf3ezwsGehlBrwZ/TQhJZQlRfxlMY18HUDBP9Qu865lZRF0VDtovuCaAWt+qE0OaIYz1JtxJtKqhsM4il8Q2tifoHC5BHi1bwwVlXui1IP7WsfbAglizjBlcAP5gUGYW+XYSiCBnCartS6kgDQAOagh1fOtBWglTBUKMyHSz2v+yVKQI1h/S1zhJGB9ZHqVp6Hm1vjsKJZRR3N06bbLWNQevlVpkyK04BCqJvrhQqi6XDtsCR5yWbIdPfgxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6qOnJN6usSCAfPPATIMyYfgLkcxVTCLrAjaeLhc8tA=;
 b=oADMrFqRDFtz/L8sFK81HIWKTOB7HVWeRq3+BtKhmEE+5xLuacgu8w3PTNqSkH1lUPr0n0hZWjUUyJ8XX+piU2zBg6CusQDBv40Usj8+dg/yWWwicCC6LuWHsIiudv7DJ3iah77/KTpqSAhmWfxnQ9gUFMKpOSWnT8UkgvLGlE8=
Received: from DM3PR08CA0014.namprd08.prod.outlook.com (2603:10b6:0:52::24) by
 SN6PR07MB5182.namprd07.prod.outlook.com (2603:10b6:805:77::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 18:28:37 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::74) by DM3PR08CA0014.outlook.office365.com
 (2603:10b6:0:52::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhT016248
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISW7u009278;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISWFI009277;
        Wed, 16 Sep 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 6/7] dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
Date:   Wed, 16 Sep 2020 20:28:30 +0200
Message-ID: <1600280911-9214-7-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99c382a2-2c0f-4096-4955-08d85a6e542b
X-MS-TrafficTypeDiagnostic: SN6PR07MB5182:
X-Microsoft-Antispam-PRVS: <SN6PR07MB518257F4E6FB214480B42FB5C5210@SN6PR07MB5182.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8I3yfmheoZkYIbe6BAsblf0BNIFcqwglKmPGpIrjocuedAXJoEkCtMDZbgtkWkzHzgxk6R1Qy+KRWr/PkeVVZOwOyIzzfHZNB5TrabZ5cc8FvWuP+1A7deXvRCgdBXebs/sqkhiMAiVAzcoiRmi3CdkPAQavgNq9B+OwO+udElwlSIAzTJrICRSwFd94NBHPIWtH050SrjL3VuNtDOYM7BCaruJQsyUC7GPcOBzHfehOsl2GEmefH/i62Vmacdbgpi7u0jfIRlaCTsZcjp5owgHnXIqpLBoiP3Xf7n06ylzRc298HuwCNPTcNQcYUlzyO/4BS3M5z4GjwBbR/K6cmLUycpDrwOoCUwG0C0L0H8apYHjCrc+tWAeTX9gJTDbE04wAMurzK8kaAlYymdz3nTMkx9zOc/CXGaunJ6M8Y/qkGKu4eWjh40CDgqED7P+GPX5G3qZEvc/uXArODG4FKCVMNgSFd5czMH+f7hBKjE=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39850400004)(36092001)(46966005)(186003)(42186006)(478600001)(86362001)(36906005)(36756003)(356005)(7636003)(70206006)(4326008)(316002)(2906002)(70586007)(26005)(110136005)(82310400003)(8676002)(336012)(83380400001)(5660300002)(8936002)(426003)(54906003)(47076004)(82740400003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:37.6911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c382a2-2c0f-4096-4955-08d85a6e542b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5182
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=922 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to specify Spread Spectrum Clocking mode used.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/phy/phy-cadence-torrent.yaml           |  9 +++++++++
 include/dt-bindings/phy/phy-cadence-torrent.h       | 13 +++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 4071438be2ba..a7ee19d27c19 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -87,6 +87,15 @@ patternProperties:
         enum: [1, 2, 4]
         default: 4
 
+      cdns,ssc-mode:
+        description:
+          Specifies the Spread Spectrum Clocking mode used. It can be NO_SSC,
+          EXTERNAL_SSC or INTERNAL_SSC.
+          Refer include/dt-bindings/phy/phy-cadence-torrent.h for the constants to be used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        default: 0
+
       cdns,max-bit-rate:
         description:
           Maximum DisplayPort link bit rate to use, in Mbps
diff --git a/include/dt-bindings/phy/phy-cadence-torrent.h b/include/dt-bindings/phy/phy-cadence-torrent.h
new file mode 100644
index 000000000000..e387b6a95741
--- /dev/null
+++ b/include/dt-bindings/phy/phy-cadence-torrent.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for Cadence Torrent SERDES.
+ */
+
+#ifndef _DT_BINDINGS_TORRENT_SERDES_H
+#define _DT_BINDINGS_TORRENT_SERDES_H
+
+#define TORRENT_SERDES_NO_SSC		0
+#define TORRENT_SERDES_EXTERNAL_SSC	1
+#define TORRENT_SERDES_INTERNAL_SSC	2
+
+#endif /* _DT_BINDINGS_TORRENT_SERDES_H */
-- 
2.26.1

