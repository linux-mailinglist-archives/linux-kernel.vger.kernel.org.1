Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5402D2CBE3A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbgLBN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:27:30 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:62516 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729901AbgLBN13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:27:29 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DObdS002317;
        Wed, 2 Dec 2020 05:26:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=LgDWTaI65VVFqH3buBBusgp+5RRYKjmqtkD7DuHc+bM=;
 b=J2biWGUXb3DME41SdLK+iynuEVBe+Q+qYWwr3rmF1kvbe9F7+g0BdZOksmGSRgfP20oX
 9JaXLJYhshSoYgpyAWiKCw0jOTTz4xJu5sZuFqN4+UkFDpGJZRDuBxmE0+FO4ScgWQ18
 6vp7fw/3AC+6GUuNnc5TQTKzJDw5yqROk4W9ancjQcQypq0LWv9nP8H2rcEREr41XSzp
 kCGz653pv6WQJXonBCbXkV4Y5oITk1nFa6MRgstWnpEjPdOvcYnvW55dmjHbB4Jlel+V
 U1jUD4XsAt+90vdYm2/TzQyG8BK7vqfxcKN2wZlXILK3pMGPsFRWwp5gpY30oOOxsxCl Og== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 355vn6aph2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:26:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjYwdW3CZzA/rB/c1e4noT+UEXi9M2GGDn/9ACmKwGOcqy8SOatzOvArcd8uYw9JTWqAoB3Uk7g9vwglBU/2i4noVSj2tZcMb35sHnVhbHxQdM/r/AhRgPsWZio8krYLYrzvRLXiTMCmmcMyQdhS/SUZ5Ews2hPehiPzjq6OPmmRVX7iap5cztcQh1uYzGi+X8KlAU3S41esL88iuem4hgl6egmHzmO5m9QjVa+z6ldlz3n6h3qMOp6PKJ6Z4GyUtbNuB2ZOmG6ytX3vfr/RgXpoqVVbCJh9AxtsBGNekGVeibRmBWBuGsXHzhovM1OFLK/sqkpf4fCbc1w0grKiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgDWTaI65VVFqH3buBBusgp+5RRYKjmqtkD7DuHc+bM=;
 b=OiEPiWhM0mXdsjHbV+dZfd1JhOr5CLWWAcbQ4Ku+RgEtuCPt1uhbdilfjQxOcVmkYV24FVIlMuHydJzYzuAq8IL20+Ef0Pz19lG5Y0mLN/8jk96fKrNjoxwqZpoS3RjlLdpNI4c8XPYj2G+Bc6AuS8bhwcpTKW878ycyfwpRrCSywC0hKB59j/qZSw2H+hfEoo7Z4gpuHdHr8wa4HSLFNG4UtSWTe8LtXHlym58E0KL0YeJ0/0FmFdMdrAF2r86u9di/FBDSOvsZ1AK/y2JT2uQ4VqNUaIGX2IKx/eVPKnGVBhCwZomi3XaY7KaJJjvVb4GrlYJd0utPY3bD9NAiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgDWTaI65VVFqH3buBBusgp+5RRYKjmqtkD7DuHc+bM=;
 b=B8u3J6YJlEXj7cdPwyzmDtpR/WlpkhKFs9KyJ7cLs7drPpvD8F/jOn+F6pjHYPtuF1oVZBJyeIhkyUhDafiO57Jw8U30ucjszAFc5kyD9juMbsf93b3jDYozURqCzJPlAthXBuNzilZaLH3Ymh6Kmjh+8XnEOQB9OxfCpVfx7dg=
Received: from BN6PR08CA0087.namprd08.prod.outlook.com (2603:10b6:404:b6::25)
 by CY4PR07MB3847.namprd07.prod.outlook.com (2603:10b6:903:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 2 Dec
 2020 13:26:16 +0000
Received: from BN8NAM12FT041.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::9c) by BN6PR08CA0087.outlook.office365.com
 (2603:10b6:404:b6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Wed, 2 Dec 2020 13:26:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT041.mail.protection.outlook.com (10.13.182.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Wed, 2 Dec 2020 13:26:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6oF007337
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 2 Dec 2020 05:26:14 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 2 Dec 2020 14:26:07 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Dec 2020 14:26:07 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ7Pr010823;
        Wed, 2 Dec 2020 14:26:07 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B2DQ7n0010822;
        Wed, 2 Dec 2020 14:26:07 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 09/10] usb: cdns3: Change file names for cdns3 driver.
Date:   Wed, 2 Dec 2020 14:25:47 +0100
Message-ID: <20201202132548.10736-10-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201202132548.10736-1-pawell@cadence.com>
References: <20201202132548.10736-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba92b72-6821-4e44-eb84-08d896c5d858
X-MS-TrafficTypeDiagnostic: CY4PR07MB3847:
X-Microsoft-Antispam-PRVS: <CY4PR07MB3847BD4F46F5D8F2E10A5355DDF30@CY4PR07MB3847.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:152;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+WrW1ixXu1aR6prmZEpVMsihLdkEmrYf4EeCR9MoI5g8xQfSkmt2NIMXMU7X2wtMwNUiHyuAHRNk6qoJnaKFatI3NHn1zGKPZgwq0ctXyx/xClz3UykDY4gNX3zRYEJyNM1kAxuW7pvFcS2pxXuCk2exX1PJYm6ktxMRx4Twu/P16XBgvmn5bsUvlEWzhBJGeSwFGevWYJXKszaMdqC15ll5gcnRef04IWmR0Fl0v/Yiz+IR4wCJvt6If9c4KfbrhCeAZGU3DtJV3g+ltKVC1IrlQDWE6HjWbIS5gc+S5C5DUEY9Up9ECGkod/AwhyON5oIzQsMuI6xbDOd4jEd+lVrYzRM93yBRuxz79DF3+/ml1VV4nR7QOWc9KRX4JeB+Em347RrFxZieL7Mbv1NL3V+IUOfnNlD8l1in/icAVg=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(36092001)(46966005)(426003)(26005)(5660300002)(4326008)(82310400003)(2906002)(107886003)(42186006)(6916009)(8936002)(316002)(36906005)(356005)(8676002)(47076004)(82740400003)(186003)(36756003)(1076003)(2616005)(7636003)(70586007)(70206006)(54906003)(336012)(83380400001)(6666004)(478600001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 13:26:15.3805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba92b72-6821-4e44-eb84-08d896c5d858
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT041.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3847
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=1 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds prefix cdns3- to all file names related only to
cdns3 driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Makefile                     | 6 +++---
 drivers/usb/cdns3/{debug.h => cdns3-debug.h}   | 0
 drivers/usb/cdns3/{ep0.c => cdns3-ep0.c}       | 4 ++--
 drivers/usb/cdns3/{gadget.c => cdns3-gadget.c} | 4 ++--
 drivers/usb/cdns3/{gadget.h => cdns3-gadget.h} | 0
 drivers/usb/cdns3/{trace.c => cdns3-trace.c}   | 2 +-
 drivers/usb/cdns3/{trace.h => cdns3-trace.h}   | 6 +++---
 7 files changed, 11 insertions(+), 11 deletions(-)
 rename drivers/usb/cdns3/{debug.h => cdns3-debug.h} (100%)
 rename drivers/usb/cdns3/{ep0.c => cdns3-ep0.c} (99%)
 rename drivers/usb/cdns3/{gadget.c => cdns3-gadget.c} (99%)
 rename drivers/usb/cdns3/{gadget.h => cdns3-gadget.h} (100%)
 rename drivers/usb/cdns3/{trace.c => cdns3-trace.c} (89%)
 rename drivers/usb/cdns3/{trace.h => cdns3-trace.h} (99%)

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index a4fdaabdbe18..01a9a9620044 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 # define_trace.h needs to know how to find our header
-CFLAGS_trace.o					:= -I$(src)
+CFLAGS_cdns3-trace.o				:= -I$(src)
 CFLAGS_cdnsp-trace.o				:= -I$(src)
 
 cdns-usb-common-y				:= core.o drd.o
@@ -10,10 +10,10 @@ obj-$(CONFIG_USB_CDNS3)				+= cdns3.o
 obj-$(CONFIG_USB_CDNS_SUPPORT)			+= cdns-usb-common.o
 
 cdns-usb-common-$(CONFIG_USB_CDNS_HOST) 	+= host.o
-cdns3-$(CONFIG_USB_CDNS3_GADGET)		+= gadget.o ep0.o
+cdns3-$(CONFIG_USB_CDNS3_GADGET)		+= cdns3-gadget.o cdns3-ep0.o
 
 ifneq ($(CONFIG_USB_CDNS3_GADGET),)
-cdns3-$(CONFIG_TRACING)				+= trace.o
+cdns3-$(CONFIG_TRACING)				+= cdns3-trace.o
 endif
 
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)		+= cdns3-pci-wrap.o
diff --git a/drivers/usb/cdns3/debug.h b/drivers/usb/cdns3/cdns3-debug.h
similarity index 100%
rename from drivers/usb/cdns3/debug.h
rename to drivers/usb/cdns3/cdns3-debug.h
diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
similarity index 99%
rename from drivers/usb/cdns3/ep0.c
rename to drivers/usb/cdns3/cdns3-ep0.c
index d3121a32cc68..b0390fe9a396 100644
--- a/drivers/usb/cdns3/ep0.c
+++ b/drivers/usb/cdns3/cdns3-ep0.c
@@ -13,8 +13,8 @@
 #include <linux/usb/composite.h>
 #include <linux/iopoll.h>
 
-#include "gadget.h"
-#include "trace.h"
+#include "cdns3-gadget.h"
+#include "cdns3-trace.h"
 
 static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc = {
 	.bLength = USB_DT_ENDPOINT_SIZE,
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
similarity index 99%
rename from drivers/usb/cdns3/gadget.c
rename to drivers/usb/cdns3/cdns3-gadget.c
index 5890e535aefc..9b8b0cd3d2c2 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -63,8 +63,8 @@
 
 #include "core.h"
 #include "gadget-export.h"
-#include "gadget.h"
-#include "trace.h"
+#include "cdns3-gadget.h"
+#include "cdns3-trace.h"
 #include "drd.h"
 
 static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/cdns3-gadget.h
similarity index 100%
rename from drivers/usb/cdns3/gadget.h
rename to drivers/usb/cdns3/cdns3-gadget.h
diff --git a/drivers/usb/cdns3/trace.c b/drivers/usb/cdns3/cdns3-trace.c
similarity index 89%
rename from drivers/usb/cdns3/trace.c
rename to drivers/usb/cdns3/cdns3-trace.c
index 459fa72d9c74..b9858acaef02 100644
--- a/drivers/usb/cdns3/trace.c
+++ b/drivers/usb/cdns3/cdns3-trace.c
@@ -8,4 +8,4 @@
  */
 
 #define CREATE_TRACE_POINTS
-#include "trace.h"
+#include "cdns3-trace.h"
diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/cdns3-trace.h
similarity index 99%
rename from drivers/usb/cdns3/trace.h
rename to drivers/usb/cdns3/cdns3-trace.h
index 0a2a3269bfac..8648c7a7a9dd 100644
--- a/drivers/usb/cdns3/trace.h
+++ b/drivers/usb/cdns3/cdns3-trace.h
@@ -19,8 +19,8 @@
 #include <asm/byteorder.h>
 #include <linux/usb/ch9.h>
 #include "core.h"
-#include "gadget.h"
-#include "debug.h"
+#include "cdns3-gadget.h"
+#include "cdns3-debug.h"
 
 #define CDNS3_MSG_MAX	500
 
@@ -565,6 +565,6 @@ DEFINE_EVENT(cdns3_log_request_handled, cdns3_request_handled,
 #define TRACE_INCLUDE_PATH .
 
 #undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_FILE trace
+#define TRACE_INCLUDE_FILE cdns3-trace
 
 #include <trace/define_trace.h>
-- 
2.17.1

