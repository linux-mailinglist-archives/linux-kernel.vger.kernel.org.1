Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE792A95AA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgKFLqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:46:30 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39448 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgKFLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:44:51 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6BhNKx009744;
        Fri, 6 Nov 2020 03:44:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=uClgMYJ8S/WxTNZFRQmiURCnjY+PPHkHr1YrvbfAJmg=;
 b=G0MifP8m19FJXd0ww3MCD5arZ2tKpia0LvFSCFylWYqX+sVJkk7z+K2pSoQEto4dHHaF
 d40k0MPXaLpLdP9pYbWsYH4PTIKHL7Kc0RnvQkZ4eF16ozvL6rNb+jo64K1nkStXZo8p
 vvd0iTW9K5X4iMwSLiJnixThzOu8kpjVyiPn56Mrf6gm7blLSJIg0ySnGG/NJKQ/jA0c
 lLoS5R9rjxytf0wDnV6BsesB/S8yDnkJTWYE6OSq311j3xfiy5J/+0Uk61+9criuD/jr
 0NDWjPpxXRY0I6j1MIOOPV/AWhP7ihDbVlLApv/tkZnjOzvMoqF0VowY1qbnnFsmJ/Oe rA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34h4fvsr8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 03:44:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHVloUICcBWaRir1xWzTHMlOwhYw2eoDM2F9VJBo7gOhGCH04jzywlLhDxZybBWcGUDMrb30MiwrTAnMRHY6+tskv9OcRcPqby0RNm7bjfxLdbnpwn12iQSISaSxkfCi7uojqZU6OVnZxq/p7gjcy4qucl9wwJY8ozNb2reO289OIa9VR0X0+ofmiN0xUQ4YeU+yfjBtyaXjoqChbcucXqrkj0BF+AYyiOqilvLHQsM817nQSJhTSqKaz/gKglShBI8YtF9YTEjQehwGJ5RlcJ6YLpvlulU9m2VYzYAJRNVa/K821qfg2gIykeOrZQ4dDYBKXADqL21HEW5SO89Nrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uClgMYJ8S/WxTNZFRQmiURCnjY+PPHkHr1YrvbfAJmg=;
 b=iaVS37g7OYtoEYFLf5OIZNHWDY9Vt0Voks2BbVGkIlXI5KRWydrZXQ4B9t4iEyoSjbN2BP+DjVW9x5rnRmGMdyvszsOdYi3FI3gSt+t10ARipiL6qSFEos+VoOXUtVPuME/zqDIudETbx2he7yS2vjwo1H2vYmQQBiG8x42oKp5VrI8HLCJJxaoFDMspbhfaBfKCChbD309IpdczNyaP+dJ8pkwp7KzEuBJtcx/aCAGVQAT2ajXe6QpyPbDjReOLblUiEUVSsUzu6dGaWhP3eMryVULtaGDeug+/3/qHk8Ucnxc9HOMANzAOh1K/7RD20ezK9DKoubsWJ3W2Vn/D7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uClgMYJ8S/WxTNZFRQmiURCnjY+PPHkHr1YrvbfAJmg=;
 b=mZWNzMU5Xti6Is0t4jinMZXYMXCjP2RCjze+rrK0j/3B6iMcUxd8QbhDc/kSuOaAyS5maadmApaL0DodCLT9gcKCKn5TmiBIRmMg0ruq+Ri/++rxgiYD9NF9C9jehpclszYatw0Z3Mb1FH7uk7OIb3GW4wJZm7haILs8WxwlnOU=
Received: from BN6PR19CA0052.namprd19.prod.outlook.com (2603:10b6:404:e3::14)
 by BY5PR07MB6625.namprd07.prod.outlook.com (2603:10b6:a03:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 11:44:25 +0000
Received: from BN8NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::c) by BN6PR19CA0052.outlook.office365.com
 (2603:10b6:404:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 11:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT051.mail.protection.outlook.com (10.13.182.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 11:44:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0A6BiFAt094912
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 03:44:22 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiFLn001601;
        Fri, 6 Nov 2020 12:44:15 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0A6BiFJH001600;
        Fri, 6 Nov 2020 12:44:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 09/10] usb: cdns3: Change file names for cdns3 driver.
Date:   Fri, 6 Nov 2020 12:42:59 +0100
Message-ID: <20201106114300.1245-10-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201106114300.1245-1-pawell@cadence.com>
References: <20201106114300.1245-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f6af06a-6b76-4b6c-32e7-08d882494e79
X-MS-TrafficTypeDiagnostic: BY5PR07MB6625:
X-Microsoft-Antispam-PRVS: <BY5PR07MB66253BBD1E23CBE95E6C06EEDDED0@BY5PR07MB6625.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:152;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2wtcmYjOLty4o+VMtvZpmG+aBDRiurpgGCByvz/9edR2oustjnd734YMq7CSqecdR6ACAb4y8KOmdVZL5lDGbAxA9wJXsU209H3qqIeHoAltkWKsY+FqVsjZYeNU3eXJRRcA7pHB9rCzCQIyURQ6ah4MEwEDNmiHBgUxMcqW9Wqv7c8T5vB+uhw0/k6epUSkJEmcVsKuedUWCbUUqwN1LWkqJeV1hfpXx/12ZRR5ytE9nyUP9J/xlwFAa+6cVcFR7030uNnSbRu8dCrrPuZ11FQTVR9j7QYDADY5o1oTNvb9DYQKXrqSBmk+jJr/W4N6YYyOhYaHOegcFWiecWvTRJ4m9yLw/JE1lSERvUPIdZaGarOD6bkz4r9C38p8rdbKoTBdNH/oetpFoeMA00iNKcSJ80nEkX8di4QYwYcu88=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(36092001)(46966005)(1076003)(70206006)(82310400003)(70586007)(107886003)(83380400001)(26005)(8936002)(2906002)(186003)(5660300002)(36756003)(42186006)(47076004)(316002)(36906005)(81166007)(54906003)(356005)(4326008)(6916009)(82740400003)(478600001)(8676002)(336012)(6666004)(86362001)(426003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 11:44:23.2215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f6af06a-6b76-4b6c-32e7-08d882494e79
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6625
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds prefix cdns3- to all file names related only to
cdsn3 driver.

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

