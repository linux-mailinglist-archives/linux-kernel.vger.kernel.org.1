Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E9F2B4513
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgKPNx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:53:27 -0500
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:17408
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbgKPNx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:53:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCUv3Iaw4l1LgzDoHN+kCGC8bYBpMW4DYu5C+DNytAhRRV4RwxW6HqlT+NlvZve6oRIPjJFs1JyoE+6fIoxxwgGX9gqdDTKikpwAPjHKaNS+PQtI/vvizvRAjbsShgqzpQvenAT9+Sa/Zp6t/HNGEkRZ52W0GOYWi0SpIFcy9G40Oo+SgPGz/1iPvI2GTUf7WEW0BFZWONVDG6VK3KPD8zHcsV6TCNpDZB3BlIp0Bd6TBMp34z120bIizS6UmVGHD/3AGXHGQK7hVP28QD4wSiCtPZWZR4rCd9i2OqscZCJ7c0i0zyCl7bgd6mQ0hfECz7uuT4d67mrGCggzVDQi4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYTxPPTn1GXNbwxLtYFIf0tDkVDAGIEVs5EMN3wQYwU=;
 b=dhNU7elo5zDfVbZt0pBgUE72MmyUmFZeo7xoOvfUUav4vlpa6zkawTl/pmK2UTPnnE3CFYIq5bpN9Z3tGw3RvMJ/huLbc4vXgO67RLVwWMZVzthp9FkNrv1g5+GOKlzAKtmmlIOa5LsHPDjZTwXbGspXzVuxK2s+Go8w4DrQeCgKom4z46bbnwv//WuwFHAfmbiFPmUvmjPmzo6XchwNB8Kx25GH3/07GXUE5Dxh1MSkTfmDZcC9bX6TV8zqAmtKMrSpO4X5yAE3vDX6B3LXhVnZOwAkTVMX2Bcn15toJa1ttkXm1A38Og6X5kMfrvXgYXxv1kL9512rRrvOwb2MmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYTxPPTn1GXNbwxLtYFIf0tDkVDAGIEVs5EMN3wQYwU=;
 b=AdwKpJMQVJVTMloxMzya2fQOabDwOqeL3l0U55QcskuzfGu27E0IS8apdApMQUl1ZD1dPNE9CdvE3y4cgfhE/IN4V5L0orfxoI2tlNRDn99zNqoFFTNe5o7X559QjVWjCETUrdjOeY8G6ZQlylEv4p20I9YEMaIS+ugSwnSGigU=
Received: from BL0PR02CA0003.namprd02.prod.outlook.com (2603:10b6:207:3c::16)
 by DM5PR02MB2860.namprd02.prod.outlook.com (2603:10b6:3:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Mon, 16 Nov
 2020 13:53:22 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::2f) by BL0PR02CA0003.outlook.office365.com
 (2603:10b6:207:3c::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend
 Transport; Mon, 16 Nov 2020 13:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 13:53:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 05:52:29 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 16 Nov 2020 05:52:29 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 ravi.patel@xilinx.com,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.106] (port=37581 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keevk-0004pS-9I; Mon, 16 Nov 2020 05:52:28 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 74B511211AF; Mon, 16 Nov 2020 19:22:27 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <rajan.vaja@xilinx.com>,
        <gregkh@linuxfoundation.org>, <manish.narani@xilinx.com>,
        <ravi.patel@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
Subject: [PATCH] firmware: xilinx: Fix SD DLL node reset issue
Date:   Mon, 16 Nov 2020 19:22:24 +0530
Message-ID: <1605534744-15649-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad6a4989-6c3a-4fa5-327f-08d88a36fb50
X-MS-TrafficTypeDiagnostic: DM5PR02MB2860:
X-Microsoft-Antispam-PRVS: <DM5PR02MB286017F6A0DDE1B43B5CBE3EC1E30@DM5PR02MB2860.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mBw4pGFlOgR7uF8zbP0+ncRsWQMPYLMPqvP1k3AzUxqdHMIx2F0nGN9uLh/kT9ntjjx74l1rYpR5URvewQyAPk7RV1NFQAnXMp/eWRIiJWxDIsIBI3PACwQN+cH57+uKlpSsmE1lFsf71ENHDspswut6WsCqMaDEatgTr6Slq6vRHFvEE1VcfjWFzqzs3ZAQ1VLupH/+HLok8+l+qGSam7b5MfDvwRF/CKHVVMER8Yjgd7PmmihHnS07c83Szljr2ZbRwB1UrgPRwba/8o/d9cSWlLfhdqHcKUWyIJ2zeq279TGlDL+O9CHK4crKqUqw8LcjARXMwT/K2cuLEMcq8lpruQiCWTf/uJvuFKL1eFd8K1yPerW7f3cFQ63C+wUyI3TIb6rKG311MWefvnQT1iHm+AMZbiy9ubdaxDzaaTM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39850400004)(46966005)(5660300002)(4326008)(426003)(6266002)(186003)(7636003)(83380400001)(356005)(36756003)(107886003)(82740400003)(2616005)(47076004)(82310400003)(44832011)(336012)(54906003)(8676002)(8936002)(6666004)(4744005)(42186006)(70206006)(6636002)(36906005)(478600001)(2906002)(316002)(26005)(110136005)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 13:53:21.2591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6a4989-6c3a-4fa5-327f-08d88a36fb50
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB2860
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the SD DLL node reset issue where incorrect node is being referenced
instead of SD DLL node.

Fixes: 426c8d85df7a ("firmware: xilinx: Use APIs instead of IOCTLs")

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8d1ff2454e2e..7696bd24f182 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -612,7 +612,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
  */
 int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
 {
-	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY,
+	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SD_DLL_RESET,
 				   type, 0, NULL);
 }
 EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
-- 
2.17.1

