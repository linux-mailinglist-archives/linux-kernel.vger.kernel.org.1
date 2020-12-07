Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8C22D0E36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgLGKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:42:12 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:32188 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbgLGKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:42:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7AbJaO007276;
        Mon, 7 Dec 2020 02:41:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=LgDWTaI65VVFqH3buBBusgp+5RRYKjmqtkD7DuHc+bM=;
 b=PoRgags+3bG02ZiYDrZN7tR1pa3MQxV7Hlh4m0fdNwB3gbyheCg6N8/1NouQDVw5prgh
 JHMLsYerej/hWPSUCjIYNLkMjrhIQyRfcu2YzH7sgmYyp59siIguUIpcsvRkxXDB3nKa
 BlpEQ/RWGkv0fKvbjNOv96m7cQQIfCAyetY1hiuyJ3mrPLbuvzQRfupcdread6jgw2kk
 Bc+4J7DylLInh9i+q3UVDJGWoDTckKC/f+wkuLkDcQJXtO+SVNPadCrVg51VOh2Z1m1f
 z9MESSVJ4oewna4SiKg2mR4lHCkz3RURshbu3iUPIVxLGQMwJc5yNM5ZUxlz2yFi1Kr5 Pg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n2m801-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 02:41:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh5FbRV5hQBPiizIurLXHUwbUGeoth/5DXlDopPJxD53xoT0eIrA0hi0jbNbTscfqUx6L1o1wt6Dp7NzOdQ0ZS+ReFXHZP6fD/Hk3VOpNDdDhaA7Ie7uOdSmMkNW5oUY5XozF04kBPmJlb+xQD+nEgrPGpfCgmyUg+V2tU7gcbjRnk3pOsPsFu8xJnhutND0x89QVaDz6IRsM/DxrDVzq6Lmfgc/v7W1JE9EZsSgfT8q5YfWixoVaaNQSxwzAuT6B27+d17sMHFySWorR7k9K9iCiQnUwqNPVFUH8bVt1uVJXqjhbhMascT+GVMub/6BQ16Wd9EsFjx9HQnEWKkrLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgDWTaI65VVFqH3buBBusgp+5RRYKjmqtkD7DuHc+bM=;
 b=XIb8C+ZISpN1M5XS5B5C2EOWok0T81RSxhCGA5PPNztREBACEZFVzVYMxSTM8IC++tUnxSokhyaEUO0Rp8ZeVMbdWgfoYlCT+Y2fky2+JUnuQbGUi9LVZCUP2ENYc3+yhYUra7UxF/PMr/IqjL/5wFsHWeVxmqp9cMPIhAr+TtPXRBFiViqM7xS2eR5wRxZErRlir1Q76N7sPzpyKuIDK3y+LZOWgYowHw/30jvstGWLwoqM23gbsdvaVsd7x39u8xJn8n/HnnsFFWPZg2aiLzekAdjLkRS8EyMkUPuy6sPl+fbK4aB9XDPwrZjigvOTjyvs6Y/bjCHYNQWtTvZEVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LgDWTaI65VVFqH3buBBusgp+5RRYKjmqtkD7DuHc+bM=;
 b=h/0CNe9KlOxLSYONJaKEO5Thf6f/Bf8kcjTswtC6h9qbz3Q9Px14hwQlX0J1UU3Slyc5DC3/aqOZAQuuWnRx3yJVfDxG6aAHiCkqBhOeImMesZGaw6kMG1K3smyi/XF1YnHpXLeINw2TeBP/DOLJcthgS9YyK56p+nxCK59fgsk=
Received: from DM5PR13CA0006.namprd13.prod.outlook.com (2603:10b6:3:23::16) by
 BY5PR07MB6641.namprd07.prod.outlook.com (2603:10b6:a03:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Mon, 7 Dec
 2020 10:41:05 +0000
Received: from DM6NAM12FT038.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:23:cafe::75) by DM5PR13CA0006.outlook.office365.com
 (2603:10b6:3:23::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend
 Transport; Mon, 7 Dec 2020 10:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT038.mail.protection.outlook.com (10.13.178.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Mon, 7 Dec 2020 10:41:04 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AeuTA007278
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Dec 2020 02:41:03 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Dec 2020 11:40:57 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Dec 2020 11:40:57 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7Aev2k006456;
        Mon, 7 Dec 2020 11:40:57 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B7AevHA006455;
        Mon, 7 Dec 2020 11:40:57 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, <a-govindraju@ti.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 09/10] usb: cdns3: Change file names for cdns3 driver.
Date:   Mon, 7 Dec 2020 11:32:26 +0100
Message-ID: <20201207103227.606-10-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201207103227.606-1-pawell@cadence.com>
References: <20201207103227.606-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14f79fa1-da52-4d11-c8e7-08d89a9c9904
X-MS-TrafficTypeDiagnostic: BY5PR07MB6641:
X-Microsoft-Antispam-PRVS: <BY5PR07MB6641B43CD610AA612A7DACF3DDCE0@BY5PR07MB6641.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:152;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3eSYifi7pNAt6V7gUlLgW5e0FQmdkxZlFMTKckojZTZsf2uOKGeSwX7fQe1HfOZ9PaWl4S3mU6JLag9KUUX6x6v6RAPmWwIVMKj5KLTiUYW1jfLb+7oRqQoobcHcYAYHtLeQJUf9qOYBxQY3yMVl8b4jOV5QQcvH/xQS0MZGRcg30ERGoetKvyjFcbzR16fd1fc+KRpPjptZOyOTuXRBaR0X1olPNORyKrwmQ8y8S1uR368UrQwlsv7mE6W79baMHE0/T0wzolVbiQaSNKFB3HiPKEPjcvWbhNNS1I1TcfgPL0ym7gpAJ1OVv0rTsOm2Yu2L+ykeoa7ASXNZfzXzBez64lx0twScJWjZtdrlq6aLahxSb88qR9VMY9rEJvtph2ylAYA+zp6brytjMViEZClSSzexJu2J1IxcLsTe7qaBHosFTvIGgoyjaotPzVw+Y8TR0+yhAPQ+apBd5ow2g==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(46966005)(70206006)(70586007)(186003)(107886003)(26005)(6666004)(356005)(82740400003)(7636003)(336012)(83380400001)(47076004)(1076003)(316002)(2616005)(2906002)(478600001)(34020700004)(42186006)(86362001)(8676002)(426003)(36756003)(82310400003)(5660300002)(36906005)(8936002)(6916009)(54906003)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 10:41:04.4779
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f79fa1-da52-4d11-c8e7-08d89a9c9904
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT038.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6641
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_09:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=1 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070068
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

