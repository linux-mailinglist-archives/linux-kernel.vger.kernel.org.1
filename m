Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F301A3A46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 21:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDITN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 15:13:29 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:41665
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726740AbgDITM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:12:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXN4udbAS+qHmGx2FLBZlhW/3PEDjk+hWByTj3F4LX3zShDrlVzilH1qaYYVGS7f0vsQlf4VEVEy395P5QwJXi/xhLnUJicBCwg5gX0u9snjFG/98BdWTK4DQpUjBnfTDonP8/THs+PPc7dIiHOlBPrLC9Kbof0tsugUjrG612YkkVsdoAToI6uCsClgYD70PMK92irmQ9gqGURXTvmVFydYsUQq5LdwsSFqFOAXNiGLfw0RKsiULqy+EeBLwLzdl+1wj4lVJ6oqTGGzYbEWwMQgFUO/5pSHmrcl0Orzorcf1D0yfrEKGfN+dTu6BZsvNvtyntP7+6ahWJEUVpjRXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8vxUs/0dedErrEdwi1bx+iB6oF92F7WrtxM2KNCHZM=;
 b=MBb6GXGhYrE2BPs3DhANTsyA71D7/6EGLiqHOoZCCgVm0Zf6lUlJ8mLZLaNZJW50oryj3ldIQDBOc2q1UQgITr1oioF/KJGF1RljuhaLcC1Zz0CNBJhiHAPT1qmRBtDmprCYfWcEcwW9cBXzRjy543qK6pObT5DZgs+gqTCdQY6PY4Troz7ePDo9wCCG8DZqPIsBGEExqmeEvx45wAT54BqKObVAHupGcDkrSpBlFITWavdsA9RKGcVNQ7pKBhmBmVyULIHL1XrJQnyntrpnyMvD2J3VaPWhhPl7GWLov4ahxK4uYtXSAuvtXO6KOywC3TO3lOkXdqPbIZaiA8ZClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8vxUs/0dedErrEdwi1bx+iB6oF92F7WrtxM2KNCHZM=;
 b=rpi7R3aOxeiPR22+i+nFW9ZKxOEpyVswO9ETNQ2I1tnR3AhFDjIL4Q+dN8IcIR0Nkbotu18sC1Eci0SbzuGPsn5uptjWg5nzPBgOufUClrAn3AUjrpGTOw3L8c/5h2H0IwZ24g3bc7tbfuHsMi2ruaEPnnXbp9M7cBBKeQ1sf14=
Received: from SN6PR08CA0011.namprd08.prod.outlook.com (2603:10b6:805:66::24)
 by BY5PR02MB6658.namprd02.prod.outlook.com (2603:10b6:a03:209::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Thu, 9 Apr
 2020 19:12:51 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::3c) by SN6PR08CA0011.outlook.office365.com
 (2603:10b6:805:66::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Thu, 9 Apr 2020 19:12:51 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Thu, 9 Apr 2020 19:12:51
 +0000
Received: from [149.199.38.66] (port=44387 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbA-00060v-Dr; Thu, 09 Apr 2020 12:12:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcba-0007NV-SU; Thu, 09 Apr 2020 12:12:50 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1jMcbS-0007La-9y; Thu, 09 Apr 2020 12:12:42 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     ard.biesheuvel@linaro.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, matt@codeblueprint.co.uk,
        sudeep.holla@arm.com, hkallweit1@gmail.com, keescook@chromium.org,
        dmitry.torokhov@gmail.com, michal.simek@xilinx.com
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH v4 10/25] firmware: xilinx: Remove eemi ops for clock set/get parent
Date:   Thu,  9 Apr 2020 12:11:59 -0700
Message-Id: <1586459534-8997-11-git-send-email-jolly.shah@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
References: <1586459534-8997-1-git-send-email-jolly.shah@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(346002)(376002)(46966005)(81156014)(316002)(8676002)(47076004)(5660300002)(107886003)(44832011)(7416002)(2906002)(336012)(426003)(356004)(2616005)(81166007)(4326008)(6666004)(7696005)(186003)(36756003)(26005)(6636002)(70586007)(9786002)(70206006)(478600001)(8936002)(54906003)(82740400003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba478a0f-6dd5-4dfb-1d0a-08d7dcb9ffa6
X-MS-TrafficTypeDiagnostic: BY5PR02MB6658:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6658655463769C47D448F7A6B8C10@BY5PR02MB6658.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-Forefront-PRVS: 0368E78B5B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QwiDyE2HUgIp7cazvtenIVIGpHHWn6jKmL4fnCpjhaB21czuEUBkRnLMmCKydO4vADRjq/zHN+alQnbjxH7hcCRWTxMz1WNV3CyheZqATgFRIWx8kY5t+h/qiXRw56VxwH8J+/2yI8F5jBa4yJe47MbskufMX3k+pJun1jRcK00ZXP48cq5Wj/l8VuhIO+xSBiJPImTLC0YxOvHjOB8IUSbQIm7c94pFUGjQmYAkFxh9ZIOZ2JA29WIDXZDuY145zwYKBa4lhxEcbN1eUTl7TkI3jh9rjKNdn7GKu2buq3ieM7CFewbDPoXOCViyAuhV7DxUqUYwCwOqZEyU/uu8Bmg+uxTOYIEDAnsCsG3cwpdsgMDKz++mg11JZ4Q4sgVc8+OQMFviXBZzdx1oQaK/r34JqjSqraHUtw/Ewp92AxFfcEe05uAtJtqhUfRe3B7hdOU+FUdGEvwijBbASfQHE4e8jpVGAQAVcHOuXdMHC2/Kx8VZ5ezgn2xNY3wScUajT30+m6Yy6kBYYElqM9bhA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2020 19:12:51.2201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba478a0f-6dd5-4dfb-1d0a-08d7dcb9ffa6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajan.vaja@xilinx.com>

Use direct function call instead of eemi ops for clock set/get parent.

Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
---
 drivers/clk/zynqmp/clk-mux-zynqmp.c  |  6 ++----
 drivers/firmware/xilinx/zynqmp.c     |  8 ++++----
 include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++--
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
index 0af8f74..0619414 100644
--- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
+++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
@@ -47,9 +47,8 @@ static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
 	u32 clk_id = mux->clk_id;
 	u32 val;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_getparent(clk_id, &val);
+	ret = zynqmp_pm_clock_getparent(clk_id, &val);
 
 	if (ret)
 		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
@@ -71,9 +70,8 @@ static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 	const char *clk_name = clk_hw_get_name(hw);
 	u32 clk_id = mux->clk_id;
 	int ret;
-	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 
-	ret = eemi_ops->clock_setparent(clk_id, index);
+	ret = zynqmp_pm_clock_setparent(clk_id, index);
 
 	if (ret)
 		pr_warn_once("%s() set parent failed for clock: %s, ret = %d\n",
diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 8462201..b0aa967 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -485,11 +485,12 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getrate);
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
 {
 	return zynqmp_pm_invoke_fn(PM_CLOCK_SETPARENT, clock_id,
 				   parent_id, 0, 0, NULL);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_clock_setparent);
 
 /**
  * zynqmp_pm_clock_getparent() - Get the clock parent for given id
@@ -501,7 +502,7 @@ static int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
  *
  * Return: Returns status, either success or error+reason
  */
-static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 {
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	int ret;
@@ -512,6 +513,7 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_clock_getparent);
 
 /**
  * zynqmp_is_valid_ioctl() - Check whether IOCTL ID is valid or not
@@ -744,8 +746,6 @@ static int zynqmp_pm_aes_engine(const u64 address, u32 *out)
 }
 
 static const struct zynqmp_eemi_ops eemi_ops = {
-	.clock_setparent = zynqmp_pm_clock_setparent,
-	.clock_getparent = zynqmp_pm_clock_getparent,
 	.ioctl = zynqmp_pm_ioctl,
 	.reset_assert = zynqmp_pm_reset_assert,
 	.reset_get_status = zynqmp_pm_reset_get_status,
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index a71f52c..7abb683 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -296,8 +296,6 @@ struct zynqmp_pm_query_data {
 struct zynqmp_eemi_ops {
 	int (*fpga_load)(const u64 address, const u32 size, const u32 flags);
 	int (*fpga_get_status)(u32 *value);
-	int (*clock_setparent)(u32 clock_id, u32 parent_id);
-	int (*clock_getparent)(u32 clock_id, u32 *parent_id);
 	int (*ioctl)(u32 node_id, u32 ioctl_id, u32 arg1, u32 arg2, u32 *out);
 	int (*reset_assert)(const enum zynqmp_pm_reset reset,
 			    const enum zynqmp_pm_reset_action assert_flag);
@@ -331,6 +329,8 @@ int zynqmp_pm_clock_setdivider(u32 clock_id, u32 divider);
 int zynqmp_pm_clock_getdivider(u32 clock_id, u32 *divider);
 int zynqmp_pm_clock_setrate(u32 clock_id, u64 rate);
 int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate);
+int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id);
+int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id);
 #else
 static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
 {
@@ -377,6 +377,14 @@ static inline int zynqmp_pm_clock_getrate(u32 clock_id, u64 *rate)
 {
 	return -ENODEV;
 }
+static inline int zynqmp_pm_clock_setparent(u32 clock_id, u32 parent_id)
+{
+	return -ENODEV;
+}
+static inline int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
+{
+	return -ENODEV;
+}
 #endif
 
 #endif /* __FIRMWARE_ZYNQMP_H__ */
-- 
2.7.4

