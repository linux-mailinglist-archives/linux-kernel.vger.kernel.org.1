Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6582B945F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgKSOPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:15:42 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11104 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727816AbgKSOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:15:11 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJE91hQ001984;
        Thu, 19 Nov 2020 06:14:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=2FRl9J8d7oWeZ0PugVlUhpMzlKLgpL865+PO9vJESJs=;
 b=qxcEeyP7nQaVim8FjoQssjVNNkvB+StBy+kuVZoy3brXLnABAq8QX1f408gO5yxJXckG
 fa7dvPNQrsf8HEJORRCpzNbivBYeByKN+nDQ55w8r8bIBGKJcAImqKKTwnxeDSHHt7Gl
 mrZlc9MIfRIx93ysaegX/gRr9yY5HVQRoZB7v2dmxVIs4J0LZZIpin+On1QJiMDDGpWu
 nPfzBqtJ0t2gy1+xY7Dniliuava1yamIlpXnf+MXVYG9Tzg3GrVU1K3VTcaJd7ocLh73
 WZMtB07weYWMilVYrW5kNEdD4avVUWV+J3Msty2wYq/uxihIPUKLs9yVZC540Y9Zhwtb Ew== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34tbq34ytb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 06:14:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/oUCgpcfllbfVVZTTePG0ImkOz2LRGTO/p8jxp1yLhm1uNqFRnqTsxYPSvaiytvEmNS1f4HZ6d1+KQU9W57yWM4sh7E35eKmo4u+Kip5SAlnE+Y+lMyS7z8TVb/4O4cZQ8INHxa6ygiydttQhsSt1IKYcPPKX4Ro0za7t7TL5Ie+BuX4HP35SfvK3FPXdtjmXNub0xQxVf3b29lx50Q8wMjGp3TWFivNJxgacz7gUapupgfS9cOcClwhlWiWGIRrnMY4cHVhNoWkeCiyPvOLU5rQ51MjVdYqERXN/UxucQYhV5RoPxlaehnJ8HFyMyi5IWBgCX61DDyPh926Z+16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FRl9J8d7oWeZ0PugVlUhpMzlKLgpL865+PO9vJESJs=;
 b=IqCg6YDrg4clJwGrE1NZT2u+jK263YuuNzhDhgCILPMvTpLMghvPO/zK379/E+goMPb7zvMogFF5iiSx0fwZzulSZAL4JNx28t6b1LRIsHgZKw5pjmPsWw/0Tm842lGzeEsJ5UvUAJSuOR+f4mg5u9XmYbN4rzWoH8/2u8w/28VsV/kVg2HLCDVdGqN1+BbrayLGJu46xdV0GubyzDGEDLkmMLAMubqh/tkEecez9dNr0TfvijWM0T1O2sdhN7mUf1rAfbpncn91S5AZy4jbjexgMsdKkphdKBfIIVptneKGJW1Bb7nFK/uBOC3nKW1QdPBt/LJd8Y4e3wXcC3PlOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FRl9J8d7oWeZ0PugVlUhpMzlKLgpL865+PO9vJESJs=;
 b=CWh67bqlEtj8nSrD090gtKG22+9fZZJ6ZtUp2IYCiDvBUaWXkSJbmyyWxXcSbpOCvUw+NX65MEF364riLOxvjo81wPwcX66HjEAPJSczNDOrLFCTbO+8Uk4FBVNrzgS/Zgix6Y0nQEftlvso6MNmGepmSXu+l3ssnqp7LBjBTEY=
Received: from BN3PR03CA0083.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::43) by SN6PR07MB5391.namprd07.prod.outlook.com
 (2603:10b6:805:67::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Thu, 19 Nov
 2020 14:14:36 +0000
Received: from BN8NAM12FT015.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:7a4d:cafe::31) by BN3PR03CA0083.outlook.office365.com
 (2a01:111:e400:7a4d::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Thu, 19 Nov 2020 14:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT015.mail.protection.outlook.com (10.13.183.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Thu, 19 Nov 2020 14:14:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERJB022418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 19 Nov 2020 06:14:34 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Nov 2020 15:14:27 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 19 Nov 2020 15:14:27 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERvo011791;
        Thu, 19 Nov 2020 15:14:27 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AJEERaJ011788;
        Thu, 19 Nov 2020 15:14:27 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 09/10] usb: cdns3: Change file names for cdns3 driver.
Date:   Thu, 19 Nov 2020 15:13:06 +0100
Message-ID: <20201119141307.8342-10-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119141307.8342-1-pawell@cadence.com>
References: <20201119141307.8342-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03423ad9-8945-4e4c-e913-08d88c9571bd
X-MS-TrafficTypeDiagnostic: SN6PR07MB5391:
X-Microsoft-Antispam-PRVS: <SN6PR07MB5391FCF03E19CE303CA99CFDDDE00@SN6PR07MB5391.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:152;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZdf238Hk32kKtfkrXLte7ZYf60uZnfCo3jFPUYboUj4J9cC9+io0q5V1DHiHh+BCrly8W44RRap508mmLy64ZJFlZCXSB85x2d+wcpYprgA2luBTwnIK0qbL0v0tb0q06kotNRQHyk07wWNCZzZTFX6uiPCne5FqEmYCQEeSIqbkprnj0vq3rTZL39hKDwq0B8lxzwqwC23nNzOMce5r+f4W/1V4T4ndi3Q+5eHfIbeYcuwn10rvO9pS9Xqz3czLP8PoWJrjRHME/gHkAu/bx81wIzg4TQ+jkTfebgjsqokrhF87D41GrgZYBY6nASnGLLXbZ++xhRq9AUlimlLN1p2Ll3VPOKxkWJjdCf3PUtrwgUoOlrf2eWSW3bBZmiIxV2CdIxtbiRpLMmlmXbdII2XVxEtbXWwi30Uf/zw1a0=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(36092001)(46966005)(107886003)(82740400003)(1076003)(426003)(356005)(336012)(70586007)(6666004)(8936002)(2616005)(8676002)(83380400001)(82310400003)(47076004)(36906005)(6916009)(7636003)(86362001)(26005)(478600001)(42186006)(316002)(54906003)(4326008)(36756003)(5660300002)(186003)(70206006)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 14:14:35.7813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03423ad9-8945-4e4c-e913-08d88c9571bd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT015.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5391
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190107
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
index 9e0a82063873..d507a23c7047 100644
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

