Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46A52C1DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 06:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKXFxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 00:53:51 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:59321
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729002AbgKXFxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 00:53:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz2KDE1/Bf2b7D8lHfeIORzhARUuIPspM9vMo/Gz51pZOsY06NF7gUEu0Zc1KBqhD2dBICQUbwPqqZOJVhM77G/NfjtCObGZGro144lGyXmdJr381QraKAjcIW8upS7idy3MgP8lyF6oHyas883rgfQaLzGBYV42sSYRuIx+/BOE/bc1WAF72OKZpyWyUwjDgeOTOvxjQ7+/hgs2cDanwF65KOoRelEP00VgtLAQ3YEvrJnlY92+kxrCKUsrQA1zLm21MFu0T6eHBPF3Ky+oFI38904IjLXAS+morHG9hSbKJ3Dd+UqrBLlnsf5rUCfkbLwEnAYWcpyT4/rOhY8HvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtPeYj+5DdqMLDfodjel1sTpRUpnQJtyWixP4r7mey8=;
 b=TBAvnulIFntiieavSQR6lUyVab5i3GnUZ1SApZCWcixAAnj/Y1ftl6A8kGIqrrUS4tqQcVwNrh/FwCVyjD3aGsZlyJi2KoUcBle5EgtRvX45kI8uApzly+/G0F3LkuLFFDpFd9bGUy+dmDbjoL11f8qNPtnZdqybzpKmQYi9n5ZJSolxN9VTCDM1Dw+UTZEaQApnuzWyyPW8ZJTkTFIKPp5ZAzLE81wnbPVatvjCTSaSR6gT5Llw5XxHqfWpH9MATZXaxAm0jwnTavnbc/dqZ9BHoNxFmJrFITyQbKPEo4ZRxelvEISuFkTBVIbtQB3A4gzw3a3oVGUB5ANHJjb1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=xilinx.com; dmarc=bestguesspass action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtPeYj+5DdqMLDfodjel1sTpRUpnQJtyWixP4r7mey8=;
 b=UoSsPx29KmT7LUQHB6HjFILUHz7kyGXBpfjS0MvDeW/x9AwofLS6pl6GHGftkvTbvNREfBsL6ufyUEIjrkz28m2tXJSxYpubu3O8KBV5RmQTLyFG0WDPtc3SxkdJ3bear0r4xVcgNb40emY4Iuj9R9k41imC0lv2Y+sZf3Bb1pQ=
Received: from SN4PR0601CA0023.namprd06.prod.outlook.com
 (2603:10b6:803:2f::33) by DM5PR02MB3305.namprd02.prod.outlook.com
 (2603:10b6:4:65::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 24 Nov
 2020 05:53:45 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2f:cafe::5d) by SN4PR0601CA0023.outlook.office365.com
 (2603:10b6:803:2f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Tue, 24 Nov 2020 05:53:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 05:53:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 23 Nov 2020 21:53:44 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 23 Nov 2020 21:53:44 -0800
Envelope-to: michal.simek@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 ravi.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 TEJASP@xilinx.com,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 arnd@arndb.de
Received: from [172.19.2.91] (port=39362 helo=xsjjollys50.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <rajan.vaja@xilinx.com>)
        id 1khRGq-0001Sd-5l; Mon, 23 Nov 2020 21:53:44 -0800
From:   Rajan Vaja <rajan.vaja@xilinx.com>
To:     <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <TEJASP@xilinx.com>,
        <arnd@arndb.de>, Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Ravi Patel <ravi.patel@xilinx.com>,
        "Rajan Vaja" <rajan.vaja@xilinx.com>
Subject: [PATCH] firmware: xilinx: Use hash-table for api feature check
Date:   Mon, 23 Nov 2020 21:52:41 -0800
Message-ID: <1606197161-25976-1-git-send-email-rajan.vaja@xilinx.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae1f76f3-04a1-41ed-31cc-08d8903d4e19
X-MS-TrafficTypeDiagnostic: DM5PR02MB3305:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3305C7ADA8E6688B25970A47B7FB0@DM5PR02MB3305.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Blv97Docn6iOMHMdgniSEqhlBP7J50xbFn4tFMUA+Gc745YWrdYQRLGrkOJ6jDwMZH8BDaZyRNH42j0vI8NaU3mD8CC1cFyH3UfY0IZAvg/pz6IaC/neFvFA4NW8B1wgo0aFVGPA28K9lf541xQ3UFf/TLL5T08MeozwbIQ0Q+pB/jyo0MzjS2FyvtlwS5M5rpfWOkSIgwZcRXy1chEVHcWtwIkXDzvyG1YSqFj3x6a225b8rJUPxs6oCrhjH3i+nMMIkwvo8YCOcYAzQL0FiLcHNfvtRrnE4ttDOUHKrRgFIRUl4dIYAoyCqyhb2iwaAzniWSDvtQFW/QAtFk2AcQ/la+1z/rdxKI6tIqiL6iDicgHtrVEJZj5fxL4v8b6/mPB2Kkj5bAvmMRrQDBFJbZIRcNqjDEaOLYXPrVCB6Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966005)(44832011)(2616005)(9786002)(107886003)(36756003)(8936002)(7696005)(6636002)(8676002)(6666004)(4326008)(82310400003)(5660300002)(83380400001)(316002)(37006003)(2906002)(186003)(70206006)(70586007)(47076004)(82740400003)(36906005)(426003)(26005)(336012)(7636003)(6862004)(478600001)(54906003)(356005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 05:53:44.9794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1f76f3-04a1-41ed-31cc-08d8903d4e19
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3305
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>

Currently array of fix length PM_API_MAX is used to cache
the pm_api version (valid or invalid). However ATF based
PM APIs values are much higher then PM_API_MAX.
So to include ATF based PM APIs also, use hash-table to
store the pm_api version status.

Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ravi Patel <ravi.patel@xilinx.com>
Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c     | 63 ++++++++++++++++++++++++++++--------
 include/linux/firmware/xlnx-zynqmp.h |  4 ---
 2 files changed, 49 insertions(+), 18 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index efb8a66..349ab39 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -20,12 +20,28 @@
 #include <linux/of_platform.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/hashtable.h>
 
 #include <linux/firmware/xlnx-zynqmp.h>
 #include "zynqmp-debug.h"
 
+/* Max HashMap Order for PM API feature check (1<<7 = 128) */
+#define PM_API_FEATURE_CHECK_MAX_ORDER  7
+
 static bool feature_check_enabled;
-static u32 zynqmp_pm_features[PM_API_MAX];
+DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
+
+/**
+ * struct pm_api_feature_data - PM API Feature data
+ * @pm_api_id:		PM API Id, used as key to index into hashmap
+ * @feature_status:	status of PM API feature: valid, invalid
+ * @hentry:		hlist_node that hooks this entry into hashtable
+ */
+struct pm_api_feature_data {
+	u32 pm_api_id;
+	int feature_status;
+	struct hlist_node hentry;
+};
 
 static const struct mfd_cell firmware_devs[] = {
 	{
@@ -142,29 +158,37 @@ static int zynqmp_pm_feature(u32 api_id)
 	int ret;
 	u32 ret_payload[PAYLOAD_ARG_CNT];
 	u64 smc_arg[2];
+	struct pm_api_feature_data *feature_data;
 
 	if (!feature_check_enabled)
 		return 0;
 
-	/* Return value if feature is already checked */
-	if (api_id > ARRAY_SIZE(zynqmp_pm_features))
-		return PM_FEATURE_INVALID;
+	/* Check for existing entry in hash table for given api */
+	hash_for_each_possible(pm_api_features_map, feature_data, hentry,
+			       api_id) {
+		if (feature_data->pm_api_id == api_id)
+			return feature_data->feature_status;
+	}
 
-	if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
-		return zynqmp_pm_features[api_id];
+	/* Add new entry if not present */
+	feature_data = kmalloc(sizeof(*feature_data), GFP_KERNEL);
+	if (!feature_data)
+		return -ENOMEM;
 
+	feature_data->pm_api_id = api_id;
 	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
 	smc_arg[1] = api_id;
 
 	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
-	if (ret) {
-		zynqmp_pm_features[api_id] = PM_FEATURE_INVALID;
-		return PM_FEATURE_INVALID;
-	}
+	if (ret)
+		ret = -EOPNOTSUPP;
+	else
+		ret = ret_payload[1];
 
-	zynqmp_pm_features[api_id] = ret_payload[1];
+	feature_data->feature_status = ret;
+	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
 
-	return zynqmp_pm_features[api_id];
+	return ret;
 }
 
 /**
@@ -200,9 +224,12 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
 	 * Make sure to stay in x0 register
 	 */
 	u64 smc_arg[4];
+	int ret;
 
-	if (zynqmp_pm_feature(pm_api_id) == PM_FEATURE_INVALID)
-		return -ENOTSUPP;
+	/* Check if feature is supported or not */
+	ret = zynqmp_pm_feature(pm_api_id);
+	if (ret < 0)
+		return ret;
 
 	smc_arg[0] = PM_SIP_SVC | pm_api_id;
 	smc_arg[1] = ((u64)arg1 << 32) | arg0;
@@ -1252,9 +1279,17 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
 
 static int zynqmp_firmware_remove(struct platform_device *pdev)
 {
+	struct pm_api_feature_data *feature_data;
+	int i;
+
 	mfd_remove_devices(&pdev->dev);
 	zynqmp_pm_api_debugfs_exit();
 
+	hash_for_each(pm_api_features_map, i, feature_data, hentry) {
+		hash_del(&feature_data->hentry);
+		kfree(feature_data);
+	}
+
 	return 0;
 }
 
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index 5968df8..41a1bab 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -50,10 +50,6 @@
 #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
 #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
 
-/* Feature check status */
-#define PM_FEATURE_INVALID		-1
-#define PM_FEATURE_UNCHECKED		0
-
 /*
  * Firmware FPGA Manager flags
  * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
-- 
2.7.4

