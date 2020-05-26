Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A50C11A3A3E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgDITNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 15:13:01 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:6114
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgDITMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W6XjQOlKCtZ4xmNPyKIGbUzcVm0XsOkdLFxmtWhg8RmIjulI7Ybzv+crGVXvUW3sTcBQwCRI+4XXTCA9FpFLACpC5wE6bJVs9OFuenS1es2kWZXqCs89MEg5wJkgjkHjzM0FUapzwd9aG+8jguwSmIe7VTUKsLUmsawxhE8lhRI5NisL0nsUjqsL3t0oHVJ41l8SY/zrFrdr897Ee6afCEaC0Fg6vHzo4JwiauoslBx0CRBPw5/K9hJcwcd0n/lQryHwE0uoDAkg5krfNmFLunGv3bZRW4dORm4EZw61qr0dLFAPtEBxTYIihwn6QcupjjJl/RxYoB8e5cq//oTP0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T32OOAPHxyyBNEPv25Ih83UMrYS5F6JrbYgIF8E0JTg=;
 b=arLqtOTo2TDqGEOf7v5vFaOh8+GY6P20+q/yz+/E8j8P15RW//1hawNG74VKpN6+c6s1GmZmThC5HfKwEuFKY8wUXBhMHyZBaPVggqT4Hx4A2E2ImgtDjDBLt6qz9FJG7XCWXfGdC3Zfq3a2r3Z2H+fTE/eKBoK88SAEfIO620j2D7cQWPRDjLzZ1IV6coe8ToVn7xpcrGKIIYmDMMj6spCN51hHUarMD6pff4QWsstGmam58ZAzRs62oQD1A2/aEN/LZRGXH076bEFn50OX07YC0o7Jlgf8dh9wjWiiUsgDT0y8//5a4PQi/0+wYqHHNNGbieEeg7ynP12M5TUh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T32OOAPHxyyBNEPv25Ih83UMrYS5F6JrbYgIF8E0JTg=;
 b=S/fb9Xv2UWMch4oantt8hgCvDBmfg++e1o30Jsc52hUJoqn44pVPYmBPrcXFqo9SA4JydcCJK6YPxFcuhpg1Szk43SPg0R99Nrmu7RQsQYjpKTszG9MJEmEr5X1sLT6OxcsixItU8MyuI+oaUd6avc7ypz4PVnvF45P+X1xbPUM=
Received: from MN2PR19CA0017.namprd19.prod.outlook.com (2603:10b6:208:178::30)
 by SN4PR0201MB3630.namprd02.prod.outlook.com (2603:10b6:803:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 19:12:51 +0000
Received: from BL2NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::f9) by MN2PR19CA0017.outlook.office365.com
 (2603:10b6:208:178::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT030.mail.protection.outlook.com (10.152.77.172) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:50
 +0000
Received: from [149.199.38.66] (port=44322 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcb9-00060R-I1; Thu, 09 Apr 2020 12:12:23 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbZ-0007NV-WE; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-IQ; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 14/25] firmware: xilinx: Remove eemi ops for init_finalize
Date:   Thu,  9 Apr 2020 12:12:03 -0700
Message-Id: <1586459534-8997-15-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(2906002)(5660300002)(82740400003)(426003)(7696005)(36756003)(26005)(54906003)(47076004)(7416002)(336012)(316002)(186003)(6636002)(81166007)(8936002)(6666004)(2616005)(70586007)(70206006)(107886003)(4326008)(356004)(81156014)(8676002)(44832011)(478600001)(9786002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 039d5ba7-3ff9-4666-fc66-08d7dcb9ff30
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3630:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB36308C14CC0CD10BE1E7E261B8C10@SN4PR0201MB3630.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvClq04AjOJrKFHD57TNobCKDFVYnsUnsWtSZPHZtWwuJyh4Qei95zElzptjd8W43cvfGsFDHYvTg4tZgTmElClAvpOVIUWW4sgbgdr5W5n1/EtyBkghiHD2yiYx1/p7Xnt5Z/okcTXhvL4xvghdNGCU4EuvwzDLAhvaJpfak3m/QXV5fSXWwi75UBB+ts4AIvPyFPdxCrDoEQrwifwQumfHhmshf/3HrA0krEJo/ZtBbLgwyaflq071MTWkqT5KFoSCE7QCErQTpMY+ZcvoMZlk0BPLgDMKmuin1ZYgm67q8Z/6mEor+X5TV6Mm3ZKyP6uAYIYlV1bJkYOwEcpyx1zihkndxwG7GUeYefzAnw6ggbvMJu0tsrymGDHKkQjqIyJaAPddODsAF0mu+ZA9muIVOp2velYtOsZOkonrM0JMTU7NxjAxmeyhiVbUvne50lC4pmJt2Vv9PcangzJ3UjgRU2U6cAp0P15DHSP9H7MVCl1FS/Q2XpnQp6GbcodgmoPO6wSBcBjvid0BiepeOw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:50.4515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039d5ba7-3ff9-4666-fc66-08d7dcb9ff30
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3630
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of eemi ops for init_finalize.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 4 ++--
 drivers/soc/xilinx/zynqmp_power.c    | 9 +--------
 include/linux/firmware/xlnx-zynqmp.h | 6 +++++-
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 4380853..869366f 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -710,10 +710,11 @@ static int zynqmp_pm_fpga_get_status(u32 *value)
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_init_finalize(void)
+int zynqmp_pm_init_finalize(void)
 {
 	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_init_finalize);
 
 /**
  * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
@@ -808,7 +809,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.init_finalize = zynqmp_pm_init_finalize,
 	.set_suspend_mode = zynqmp_pm_set_suspend_mode,
 	.request_node = zynqmp_pm_request_node,
 	.release_node = zynqmp_pm_release_node,
diff --git a/drivers/soc/xilinx/zynqmp_power.c b/drivers/soc/xilinx/zynqmp_power.c
index d327d9e..f4a9371 100644
--- a/drivers/soc/xilinx/zynqmp_power.c
+++ b/drivers/soc/xilinx/zynqmp_power.c
@@ -182,14 +182,7 @@ static int zynqmp_pm_probe(struct platform_device *pdev)
 	u32 pm_api_version;
 	struct mbox_client *client;
 
-	eemi_ops = zynqmp_pm_get_eemi_ops();
-	if (IS_ERR(eemi_ops))
-		return PTR_ERR(eemi_ops);
-
-	if (!eemi_ops->init_finalize)
-		return -ENXIO;
-
-	eemi_ops->init_finalize();
+	zynqmp_pm_init_finalize();
 	zynqmp_pm_get_api_version(&pm_api_version);
 
 	/* Check PM API version number */
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 200f9e0..9aa5fe8 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,7 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*init_finalize)(void);
 	int (*set_suspend_mode)(u32 mode);
 	int (*request_node)(const u32 node,
 			    const u32 capabilities,
@@ -336,6 +335,7 @@ int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);
 int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
 			   const enum zynqmp_pm_reset_action assert_flag);
 int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32 *status);
+int zynqmp_pm_init_finalize(void);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -424,6 +424,10 @@ static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset,
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_init_finalize(void)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

