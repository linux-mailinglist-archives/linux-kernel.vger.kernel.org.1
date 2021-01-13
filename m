Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C84E2F4CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbhAMOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:16:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31798 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbhAMOQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:16:25 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10DEDuXB022095;
        Wed, 13 Jan 2021 06:15:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ysCNV9PA5qipkkATM6BrhhjNvhSAEF6ztCbjI5u3T5E=;
 b=Mylfp3eWHS84vRrD98Xuih8RAqWPc41ocQtiXOZaTuBf5haXTenWpNTCtYWELUqEn6MS
 WPw12yKdZH2oM1aegYxw6asYKmXLRQvnIDWAohzVeIp4NYEU0y+hCEWHlVJlgI3cUKCa
 r/vTRzVRRTdnv996otAU+YjgA7eAI1eZj/nDvCXYxqj64y6iRPnhnYSo+2wBTBuB4Nb4
 XaOAxqCUuIGwd/JVe9OV5MtfeF0sVq6AIdikjYy9PREvRkrdsfVaXHn2gvtXl939hkKW
 wGf+XLweWYwCgs1k9Hyt3uUQ+YwkFBTUJmXFyjFyapHTwIJibe4UlXrDG9UFMzDWyAQ7 5g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2056.outbound.protection.outlook.com [104.47.36.56])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3618temsh8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jan 2021 06:15:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/mH4Fp+MtVXqFtTnaE8FBZwHNsoz0/USMGHpNAmQAqlAr93HLbpYUphuvAzj++Lk56f7MMIo1dkB3q34cRoOiOyhJ8G7sD025Ggt2oh5a4A4hag/T0u/ji3dAdLUKKbTVyHxyaVb90E4Qf5UNBmbtgCjtAE5cPSv01EGqPrtXZt1yK+nP9OomcL3+OjoVghEmAZRN6Wut7F1qy9ccJW2Sw5q5Z6BJoAtCOzdknVb8XDyrJYDS25JIJ4d+G1LgCRF3/tKHf8XrmYYd7xZYPKEnkI8LABTofZtirrmP2qFzLbceIjcRsaEzIzmZ3E+SXPt+EQ+Pohhne4K5pPIf+new==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysCNV9PA5qipkkATM6BrhhjNvhSAEF6ztCbjI5u3T5E=;
 b=S62NsLeTyH7rAGmlcgDJlzQ3s1n2hdY5exaSYXWXaT/on+Qa7XyGrgCA4Bh1ANaNJf6L6AUnHUtD7De8KTqEptBUe1hfYi64OiFvrTs59yNxZB7KSE7J2nOlq6qtyhi3r8/h3cUGlykOb81uQbLS4h5qX4YXLxX2rcapGqzpO8hK04r5b4vX7ODT071GnBAfE2pBHdSf20wIYwW+zw+zHRN6Oh5nFmJ8Ko+Lf5gsH1/OSgmWZXLkBVIYLeRPqpllC9WSPTk/J0kyEIBvYpDLop/fyEON38KgEkG0c3Bte0rpWvgS3pVrbMyOLbNnz2JDc58eot0oktb3On3yJXdZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysCNV9PA5qipkkATM6BrhhjNvhSAEF6ztCbjI5u3T5E=;
 b=Vx0KIxw1Y2ce+Raofs8wPnZIZMfnd8LSkbiIS654X+D9ecVHHe89XnvoeKptr0/MHlE3vtgPszitJE+BpIP5MA8c64UvrFxihuxRnw5tSuKiMvR11QoM7/ygazkrvrzdwp6LoELIzFitY3XJYs/zzAAxShwtvm52lOmbiRwbIbk=
Received: from DM6PR02CA0043.namprd02.prod.outlook.com (2603:10b6:5:177::20)
 by CH2PR07MB6728.namprd07.prod.outlook.com (2603:10b6:610:2f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 13 Jan
 2021 14:14:28 +0000
Received: from DM6NAM12FT052.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::d5) by DM6PR02CA0043.outlook.office365.com
 (2603:10b6:5:177::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend
 Transport; Wed, 13 Jan 2021 14:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT052.mail.protection.outlook.com (10.13.178.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Wed, 13 Jan 2021 14:14:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 10DEEOKZ016340
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 06:14:25 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 13 Jan 2021 15:14:24 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 13 Jan 2021 15:14:24 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 10DEENlp025523;
        Wed, 13 Jan 2021 15:14:23 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 10DEEMOd025522;
        Wed, 13 Jan 2021 15:14:22 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <rdunlap@infradead.org>, <a-govindraju@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        <geert@linux-m68k.org>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: fixes undefined reference to cdns_remove
Date:   Wed, 13 Jan 2021 15:14:07 +0100
Message-ID: <20210113141407.25473-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b33019a-76d8-48e2-acff-08d8b7cd89e4
X-MS-TrafficTypeDiagnostic: CH2PR07MB6728:
X-Microsoft-Antispam-PRVS: <CH2PR07MB67287F81D838D7471995648DDDA90@CH2PR07MB6728.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TkXsE9ZWysKbaAMEgdAJdsd4OvPNNk2LayLHV3iFdP613egkEoXQo8P7jwAp4yJc8Nu43bHVkVI+JKv9onxAF7FIyS+LP+/Kform70wzEfgm+PJiVGUzp6Rxys+RcGR04Gdzt41FhVT1YyBbkNvDBEN8F+msxwCBGUClYnuaZ98SY45qDBxMnkjnaVD3ZEz/UUIg4QDs7TC91YDArifQGGkYbrcbLNBBtoLHQ4D5oxWic1w3g1ZFHZroA2QBvMEcPOSlRir5soDvCq/SpzzojoaervJm2mmqCirS4hgNILbgGUscylvwgLJf5GFQWNH7o0bIbq3YGIerNGPFCx46CYxt57K/m5utxpFx3ILLwO1Od75+4CplYAsJLuT7Mm30xII76GuJGkvRafwp0anP4ROv0O7eCwL/LEhLts8UGjU07t/1/vuz1JNtEV0C71/rdgBdOJjh6IaXeP/FSbs3qhTTVUcixP1odO8TDMo8AMmhsGnkXxdHFq6yne3gli2GQfOvlHdwfELEVIEdZQqIKA==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36092001)(46966006)(316002)(8676002)(36906005)(1076003)(6916009)(54906003)(478600001)(7636003)(82740400003)(34020700004)(8936002)(4326008)(82310400003)(47076005)(86362001)(107886003)(6666004)(5660300002)(26005)(356005)(36756003)(2616005)(70586007)(426003)(336012)(42186006)(2906002)(186003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2021 14:14:28.1589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b33019a-76d8-48e2-acff-08d8b7cd89e4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT052.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-13_07:2021-01-13,2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 clxscore=1015
 mlxlogscore=812 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101130088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch fixes the following errors:
ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_remove':
cdnsp-pci.c:(.text+0x80): undefined reference to `cdns_remove'
ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_probe':
cdnsp-pci.c:(.text+0x34c): undefined reference to `cdns_init'

Issue occurs for USB/CDNS3/CDNSP kernel configuration:
CONFIG_USB=m
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_PCI_WRAP=m
CONFIG_USB_CDNSP_PCI=y

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
changelog:
v2
- added missing condition

 drivers/usb/cdns3/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 3f9b7fa8a594..61edb2f89276 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -26,7 +26,15 @@ obj-$(CONFIG_USB_CDNS3_TI)			+= cdns3-ti.o
 obj-$(CONFIG_USB_CDNS3_IMX)			+= cdns3-imx.o
 
 cdnsp-udc-pci-y					:= cdnsp-pci.o
+
+ifdef CONFIG_USB_CDNSP_PCI
+ifeq ($(CONFIG_USB),m)
+obj-m						+= cdnsp-udc-pci.o
+else
 obj-$(CONFIG_USB_CDNSP_PCI) 			+= cdnsp-udc-pci.o
+endif
+endif
+
 cdnsp-udc-pci-$(CONFIG_USB_CDNSP_GADGET)	+= cdnsp-ring.o cdnsp-gadget.o \
 						   cdnsp-mem.o cdnsp-ep0.o
 
-- 
2.17.1

