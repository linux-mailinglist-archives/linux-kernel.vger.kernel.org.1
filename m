Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53A982B87C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKRWbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:31:53 -0500
Received: from mail-eopbgr760055.outbound.protection.outlook.com ([40.107.76.55]:28897
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbgKRWbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:31:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgEohdX7i9ANUS2P6wGd5pfNFxV/+76YbtdekqKWcASoOyd6z/1Eh8lVC5s6yx+C7RHxlBhK6E0bK08OKacudyw4R4Pffj2Eh5kVcu7dMQlAxosGysc+79vMKZxH8eyChEpiU3Qx39vnEA/+5yFQfxIsWlgJhEQiFe1+9zDCE8rU1OCUG8eW/vWgLho1mrm9WqrVe8ePo+XQgRlOXK4pkiWMiyP1Av8DV98soAYShmkvzryZDye38l++qW/ZSvabxhtz2FKDF2tk+Btm7B2HbwoUzWfDQ87qxTX6cww6YhwqhPp+kPdyGNBBZNK4i9DETeJsWDitoa3f8u/dAQv74w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cjfyMtgUqQABapKTYnO3yVIjT9CsscIpv9z/ItT+9I=;
 b=GR1DHthi9KKiDeuXdeYjtG5ZNj5zGeuhRN1gkgYbK6l/nt1ywdmInOw13Y/BtF6+88LzSM2LxIDWKnq+JEh8ynA0yzjlpx/GrhZNOjpUHTZetBuBKWxUehxjpBkUnsgtRrKBwNgJAhsPY5EvNUAoHmYANpEksy4AoZ9OGjAteQQY8M3JP/HslS9ZUlfV4aPmyBa380BvOS2xR+UFQ73mkBeGg4sfHcXa5SqddyL7TCbm90JlrYIZKX9kyhal9Oy5PwYi4dPqdleWKU8m1qbIYPXgZs9UVLUfsf7suogTgFbEuuQTdBrLS9vKWWjpmJ++m96yqcyDroKmChRGX/tKVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cjfyMtgUqQABapKTYnO3yVIjT9CsscIpv9z/ItT+9I=;
 b=lk9ERVG7d6aw4JJysYnoJ22mNE8NJSV22mTcivVgzTEiqIW2u3YBtKLoA84CKY1saXGZTtgsPHXY7y9rpuBjfx6u2yEr6VHy6csN0E6G2gnzGmB7m/ois9HKibiL/vBkZUDauMvAgJb6hBT8QGGxZSZbDuwH26pzNgOeWeKoo7k=
Received: from DM6PR13CA0054.namprd13.prod.outlook.com (2603:10b6:5:134::31)
 by BN7PR02MB3956.namprd02.prod.outlook.com (2603:10b6:406:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Wed, 18 Nov
 2020 22:31:49 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::d8) by DM6PR13CA0054.outlook.office365.com
 (2603:10b6:5:134::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend
 Transport; Wed, 18 Nov 2020 22:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 22:31:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 18 Nov 2020 14:31:48 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 18 Nov 2020 14:31:48 -0800
Envelope-to: michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 tejas.patel@xilinx.com,
 manish.narani@xilinx.com,
 wendy.liang@xilinx.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.2.167] (port=36246 helo=xsjjliang50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <wendy.liang@xilinx.com>)
        id 1kfVzQ-0002Bf-SQ; Wed, 18 Nov 2020 14:31:48 -0800
From:   Wendy Liang <wendy.liang@xilinx.com>
To:     <michal.simek@xilinx.com>, <rajan.vaja@xilinx.com>,
        <gregkh@linuxfoundation.org>, <tejas.patel@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Wendy Liang <wendy.liang@xilinx.com>
Subject: [PATCH] firmware: xlnx-zynqmp: fix compilation warning
Date:   Wed, 18 Nov 2020 14:31:46 -0800
Message-ID: <1605738706-375-1-git-send-email-wendy.liang@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 385975cd-4c3d-4c55-1261-08d88c11bd6e
X-MS-TrafficTypeDiagnostic: BN7PR02MB3956:
X-Microsoft-Antispam-PRVS: <BN7PR02MB39562CF664D2514047CEA306B0E10@BN7PR02MB3956.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QoU1nNX6FveFecA9XENQ/WGuRkG4y0RWVOsmiXydA890PFbRGHmO3oBldwYLqinhareQyWj5D+4HmelXUGqJu+TAeRPBlH6nwrO6qdv14+Shpi74xsk05/29l3buP4hmYaxsXpFJbg81sQWqYc5CnNaA6PmmSA4ea5o9mvYr5vpL1a/CHV91Y5xo8U85FNxL0O2nmnD40qZoj83DHnWo2DUmXjjFr1uxAarRtUyqCbN6YQpNXgK0MA56D3dLwBlsoCNpUYTCIcXOqhrLow8qJQjN7IulXB1aVjJqGMcHdqk+wZai2PU5mAcHb4vdsY5UKHOWj22TY7bwTUSX/fsNPxXIIhwE6ESqDWlIlI/vx+HpguJcn833zLdbrb+Y45ZjGRA9h+KgGGmAsU+G5bzp3k7vqW+EDfh2kEYt/soK2Gg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(26005)(83380400001)(54906003)(110136005)(426003)(9786002)(2906002)(316002)(70206006)(82740400003)(7696005)(8676002)(107886003)(82310400003)(336012)(47076004)(2616005)(8936002)(356005)(44832011)(478600001)(4326008)(7636003)(36906005)(186003)(5660300002)(6636002)(36756003)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 22:31:49.2735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 385975cd-4c3d-4c55-1261-08d88c11bd6e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3956
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
 include/linux/firmware/xlnx-zynqmp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df8..7b6f9fc 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -13,6 +13,10 @@
 #ifndef __FIRMWARE_ZYNQMP_H__
 #define __FIRMWARE_ZYNQMP_H__
 
+#if !IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
+#include <linux/err.h>
+#endif
+
 #define ZYNQMP_PM_VERSION_MAJOR	1
 #define ZYNQMP_PM_VERSION_MINOR	0
 
-- 
2.7.4

