Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DECE2C1FB7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgKXISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:18:30 -0500
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:53665
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730355AbgKXIS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:18:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f+eWc+LH7qohOy2hM4+NNvlPCJelalM8k3qfVrmrR9WsEM5QahKS/CRCubIbJVfz+4NNAvcv2kmB/PByKLbGujd0TIgk4AFIdxnXrn2MKjbTl9z3YUmCGu4QqNaH6t+SAaV8FmqcAs9NBp8hcz59mgZ80bmuxUGbi5C/HTGv634EDymtoDOfl0WaWV7GTfEj4yGjNTQtuU8G6xLMFtAnzJAF2kSOA5eqktvPlMQv+JpvQgG6CoP1bOrdTMFSk2+wYOMn5uXgSoXIL1/HR0GmR/KNaUBgoU/7cWFD7YGZQnbyJXqAhFqIWXSVEWUUjGiunK4b2F8W7WYlfDhdFhYXyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE6BNcXPEMlNz756PnrK2CE+Wm1MUt6gjl5aYi7/kwc=;
 b=d1SbMl98NmsNWy65vlkGWg0I5Yjm3pRQOTMox17pFfSExxaaUjJpKmcbdDvLrtsNsOdibcpdI4+GQR6L0k/AuUjoSUTq0Kf786JW/uH0fDH9FWaOQSGZFAezDHJRfJjVOhJO+NfxpD117/aMy8WdzpWzdctxVtKPyM6Y9elJb+6HW4I+i8SngXDIOfZL+MjqjTBaQlPhzCHmwwxIDQgmCmShpGghnbzFvi3DiZNvFvP+54Z9Sc+2HMKTZPbNfq+2HHR75wvUo+qwI4kHbbZ11ldrwkz2olUKsKO1O9kkaYzNr9OCc/zmxE2AzxyjYXNYGYilnUROFdIXwCyglg9/yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sE6BNcXPEMlNz756PnrK2CE+Wm1MUt6gjl5aYi7/kwc=;
 b=Z6Xa0LrgTyCYn/tDdzXGwlBdH42kgL04OV7PVSEqOf3sWpbMoyGHSrMxjb9wkUCIvN3E13T3WkNBfsiXVBRnMRNU4XjI/+xh5MVq1pr8ON5hpGB9K3UGBNcqQls0A1Xc1JfxUgvrBj5cbhOa9HzuYGZKE2Fqhhh9VFMSHYPSwic=
Received: from SN1PR12CA0073.namprd12.prod.outlook.com (2603:10b6:802:20::44)
 by BN6PR02MB2323.namprd02.prod.outlook.com (2603:10b6:404:36::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Tue, 24 Nov
 2020 08:18:27 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::5c) by SN1PR12CA0073.outlook.office365.com
 (2603:10b6:802:20::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Tue, 24 Nov 2020 08:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 08:18:26 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 24 Nov 2020 00:18:25 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 24 Nov 2020 00:18:25 -0800
Envelope-to: michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 tejas.patel@xilinx.com,
 manish.narani@xilinx.com,
 wendy.liang@xilinx.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.167] (port=44484 helo=xsjjliang50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1khTWr-00055D-1q; Tue, 24 Nov 2020 00:18:25 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <michal.simek@xilinx.com>, <rajan.vaja@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tejas.patel@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH v2] firmware: xlnx-zynqmp: fix compilation warning
Date:   Tue, 24 Nov 2020 00:18:18 -0800
Message-ID: <1606205898-12642-1-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 494b5570-f558-45c0-093b-08d89051849a
X-MS-TrafficTypeDiagnostic: BN6PR02MB2323:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2323D8082725591B618E01E1B0FB0@BN6PR02MB2323.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUsRKueC/cAeZT3DoNhTH0y474rYpDJ7H+AZhe+k3W7qIUtFL8aJzxaD7ttFXa+8ZjBxpmvK8yQn1GR5vNU8yghY76uUNGNGNqs0YnOB2D+hwtE85WDuZIY5XLQOMLmAAL71NEkhkvKHWPYEOl6VUih9wpmYFPS6EvwCha2OsSGsR1TyLaZKvl+ouZ6Ufy10TGv4el4UBZ3FZve3BoQ3rILMq20PC/xUCXY+mQzESFs3NLHNUY+UTaUPvzcImegIDHj94sX1JqeUTRcpmVSa2FY0cv9L969ZYvPsCiLubAGZgVA4mKWD4FfxhPYHMKHKLhiVxi5jMkWPnRdaCb2NadXLuM4qB/XMTVf/NdiXKaQhm5ARAiLws5u8Nj9PnBHPR/pNiNdgiCQcIxpiQC7pvkuvUJom1EjrU6gmn+D+eYQ=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966005)(356005)(6666004)(47076004)(6636002)(107886003)(7636003)(36756003)(2906002)(9786002)(70206006)(70586007)(478600001)(4326008)(36906005)(7696005)(110136005)(82740400003)(82310400003)(8936002)(5660300002)(44832011)(54906003)(83380400001)(316002)(426003)(186003)(26005)(2616005)(8676002)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 08:18:26.3503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 494b5570-f558-45c0-093b-08d89051849a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2323
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation warning when ZYNQMP_FIRMWARE is not defined.

include/linux/firmware/xlnx-zynqmp.h: In function
'zynqmp_pm_get_eemi_ops':
 include/linux/firmware/xlnx-zynqmp.h:363:9: error: implicit
 declaration of function 'ERR_PTR'
 [-Werror=implicit-function-declaration]
     363 |  return ERR_PTR(-ENODEV);

include/linux/firmware/xlnx-zynqmp.h:363:18: note: each undeclared
identifier is reported only once for each function it appears in
   include/linux/firmware/xlnx-zynqmp.h: In function
'zynqmp_pm_get_api_version':
   include/linux/firmware/xlnx-zynqmp.h:367:10: error: 'ENODEV'
undeclared (first use in this function)
     367 |  return -ENODEV;
         |          ^~~~~~

Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
---
v2:
* Always include linux/err.h
---
 include/linux/firmware/xlnx-zynqmp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df8..f84244e 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -13,6 +13,8 @@
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
 
+#include <linux/err.h>
+
 #define ZYNQMP_PM_VERSION_MAJOR	1
 #define ZYNQMP_PM_VERSION_MINOR	0
 
-- 
2.7.4

