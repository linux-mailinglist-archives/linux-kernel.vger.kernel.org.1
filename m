Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF82D55A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbgLJIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:50:32 -0500
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:48225
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388190AbgLJIuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:50:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRpKZNaokpgNXnezblgJBSJ8QKvtPfmKFd/q6AzTz13Tt7h0+Vz2GO7dadiWlTlum27gIDjo98tDa+JvAW855WkFwQup2gZObWU7TczVd7T5HoL9F9eHOJ2yyfetmkYq6Gm35LcF/0vIW97xDzhvk2pReImR8cjNab9j+JPYsnVisNSxJgaXhfBze0fsoAZeWl7/w+X7lJFpQJZQvo4kCn8Awd/pqJiX7wCur4LEQwFCS/nd+F6VF1Nh98WY0E2dGyaNvFFBLjzSHWrMGfhTSEVsncEyFwMYoC2mnMrOfy/dI4KarWv+3wjkc8CQOo7NPAXXT3fl6dpEvZela+ZsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4/dNxtFNG6pRfgwBcw7Dz/2s6SFql0A6aFbOeAzMXY=;
 b=kdBB56u7XMinebOb6sZRywInG1PcXMltsPZT+ftZS8X2GIPXGhySCjgD8udzeK7rh2up17DW6UI3VshrmCuFcDCqdRLJcZhNg/VBiQ7Mz4POyobjwVcTLDFyBZUWmD1Cw0AdMeeK18l5nYnXOKRdZpOmZPkxhEAxQBOSNt2Ld2Td+4zJJxl3kdt2GJdrjoJspJWpwP58AYew0VBqSA4KV+ekH5RStaLBW6mKpgt6P97CZDXu8nUS/p5FWPjreFFqxLl+HcLXhKeGxdoNPxS972/PCU/lNjiYeUyVU0X1xlSC/KM7qQagiUtovQ5w9JEjKrgU0cKwkh9+Y+z9xwYVGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4/dNxtFNG6pRfgwBcw7Dz/2s6SFql0A6aFbOeAzMXY=;
 b=bWwyHgTF2WLQspAKYFh4oGCRf9osYD3paSyBtXZgtXff8ZIiJVoxnA2+k7P/Xl/r1paxle2Z8KV253+9UQ8CGwLXAHcsuTCKATboSD1mZzWk8pjrnyNZrQxLU5lmKICScy+umpyTG7H0LWGym+9hnDa17PIPWdvv6TMwPcaB7F8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB6962.eurprd04.prod.outlook.com
 (2603:10a6:208:188::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 08:48:55 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6%8]) with mapi id 15.20.3654.013; Thu, 10 Dec 2020
 08:48:55 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v4 2/5] firmware: imx: scu-irq: Add API to retrieve status of IRQ
Date:   Thu, 10 Dec 2020 09:48:47 +0100
Message-Id: <1607590130-11065-3-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607590130-11065-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1607590130-11065-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [81.1.10.98]
X-ClientProxiedBy: AM0PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:208:be::45) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR04CA0104.eurprd04.prod.outlook.com (2603:10a6:208:be::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 08:48:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 352d4263-a407-4ae8-87b5-08d89ce86d52
X-MS-TrafficTypeDiagnostic: AM0PR04MB6962:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB696240B1322E73E937DD2F2AD3CB0@AM0PR04MB6962.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gkvaf8sO/n77L8O+rt/sqY53kovNYz6hYj3vEMEHiFkhf83TslnEP5M8oWkIC+V7tGFBf+SPxjalSZ7hqMWHxKYghy6nRi5y9aMLL3rqhwtJ2hcMEHwDsqd0gDwf7wjONPYqPDfKKxdHxxRGil24CuHfUwD1NuYrCLNT+yWAHouQ3dgbnplWQjDyu+8KRqFOywt3ej63rg9C16yDP77E7mgst4gz6dzyZ2h/BRKO1fpdNfhBLViSfQJt66CISygaav7CM6q9I1LFETKJfb08rFoRRLbICj7fImTHJ9R4U3jfmZdSyUK3ly9d2n6xpaCHcINkTWxchvKweXvZ3zrmdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(376002)(366004)(26005)(478600001)(956004)(2616005)(9686003)(6666004)(6486002)(83380400001)(8936002)(2906002)(6512007)(8676002)(86362001)(186003)(66476007)(6506007)(66556008)(5660300002)(66946007)(316002)(4326008)(52116002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?8e7Zi65RRrAi42nMDvBU5XANQjfiCoxLcZg4JlSNPcomnKj7ni42uOF0JrE1?=
 =?us-ascii?Q?MEpv4R1aN44fQv89TTs9mBODayHqRTiYVeSQEyx0ZEkJc686IMD1iJSRy+eX?=
 =?us-ascii?Q?HxWwE9StbUL3gNgU9FkpnGBBAveclZL5YaZDc/jcIb7+0y4vGJxFBoXcVnFq?=
 =?us-ascii?Q?Eb4lvZaBR2hnVtZrSdMVkW48Kzzl6otUy6IbMc/Or6ytzOCiz0iAzz2+8j7z?=
 =?us-ascii?Q?n91LvlukJDEi/w/rTI07iLdOEilBvEjooA/mmRmBwjZVsYYqQkgK6HLfHT0k?=
 =?us-ascii?Q?p9B6vnABxouK3RMc0E/J4aoLCLay1FlvdGURSsrhYfuDDzppks+a5KQDuJJD?=
 =?us-ascii?Q?xNx2zGpNpR8yYgdT0cpi6LNI7CwE9yHBSVFo6jlNO6lpToISmviTIQDyZ4Yj?=
 =?us-ascii?Q?Cn6OE2I6n3ZyUD+PtIrHJ8H+kisKarK/fDOOUSUOb6JOI1MFe2JPtMy2PZqG?=
 =?us-ascii?Q?MKUTIfA2VNd9tyljMDjg0gxH4XDuc1gWd4M9SvJKZypETIT+s5Qso2mQR7Mn?=
 =?us-ascii?Q?PHHknaAzt8qeUwjh7PPHnoDM0aX20+kOGiu+vHY4JfeeBUDLr+BfyorQEn+O?=
 =?us-ascii?Q?XroGakWGjoiNyHsOwW43Vvvu/RaOhsS2O75eVo+TbBInuN9EECLLgmtcrf9u?=
 =?us-ascii?Q?sNwNkZTg5cszambRHcZ8cqX9a8ZNwBPF8OH3NE/V1mpRZjhuj0OD1jXOr7gc?=
 =?us-ascii?Q?OT4nHSYxQQkXWAh1vYaP00mA3PcZDtUK2X1/Cs4X8Al5I78KTST8vCPeWi9A?=
 =?us-ascii?Q?NaJMyA50pQDKonxauwQfpQuh0bIE+CHru7cMHXk1RdfAwHzIUlOXanIBoqNd?=
 =?us-ascii?Q?vjJmKCwrKFwjC/EH4f0ZkQUQM/bByMt6sEEm/x/sYmPBzVStULHBKpifgymp?=
 =?us-ascii?Q?bfjPSrBOiF1JRrqOk/KF+Hec4jeg5JE1qrLz6UkBzsDXDGwHFw7VltQX5SMW?=
 =?us-ascii?Q?0FZJPazNWZjpgefuvHsyhMUFaUxsa2MIuByuTzfW0Pc=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:48:55.1606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 352d4263-a407-4ae8-87b5-08d89ce86d52
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBEDUMjbBYKrF6rMcvHpx7K9x58kgRlJBlk7w0/a6o7rE3MVqNlUNbJ+6GVA9y7lQHVGmmZKFOZyNS/pg9BHsyWIBnDtzxPlJe9lFFhVSUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

This patch adds the API to retrieve the status of an IRQ.

It also adds values used to process SECVIO IRQ from the SCU.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 48 +++++++++++++++++++++++++++-----------
 include/linux/firmware/imx/sci.h   |  4 ++++
 2 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index d9dcc20..bb0b5aa 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Copyright 2019 NXP
+ * Copyright 2019-2020 NXP
  *
  * Implementation of the SCU IRQ functions using MU.
  *
@@ -66,29 +66,18 @@ static int imx_scu_irq_notifier_call_chain(unsigned long status, u8 *group)
 
 static void imx_scu_irq_work_handler(struct work_struct *work)
 {
-	struct imx_sc_msg_irq_get_status msg;
-	struct imx_sc_rpc_msg *hdr = &msg.hdr;
 	u32 irq_status;
 	int ret;
 	u8 i;
 
 	for (i = 0; i < IMX_SC_IRQ_NUM_GROUP; i++) {
-		hdr->ver = IMX_SC_RPC_VERSION;
-		hdr->svc = IMX_SC_RPC_SVC_IRQ;
-		hdr->func = IMX_SC_IRQ_FUNC_STATUS;
-		hdr->size = 2;
-
-		msg.data.req.resource = mu_resource_id;
-		msg.data.req.group = i;
-
-		ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+		ret = imx_scu_irq_get_status(i, &irq_status);
 		if (ret) {
 			pr_err("get irq group %d status failed, ret %d\n",
 			       i, ret);
 			return;
 		}
 
-		irq_status = msg.data.resp.status;
 		if (!irq_status)
 			continue;
 
@@ -97,6 +86,39 @@ static void imx_scu_irq_work_handler(struct work_struct *work)
 	}
 }
 
+/**
+ * imx_scu_irq_get_status() - Get the status of the IRQs of a group
+ *
+ * @group: The group of IRQ to retrieve status
+ * @irq_status: Status of the IRQs retrieved
+ *
+ * @return Returns 0 for success and < 0 for errors
+ */
+int imx_scu_irq_get_status(u8 group, u32 *irq_status)
+{
+	struct imx_sc_msg_irq_get_status msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_IRQ;
+	hdr->func = IMX_SC_IRQ_FUNC_STATUS;
+	hdr->size = 2;
+
+	msg.data.req.resource = mu_resource_id;
+	msg.data.req.group = group;
+
+	ret = imx_scu_call_rpc(imx_sc_irq_ipc_handle, &msg, true);
+	if (ret)
+		return ret;
+
+	if (irq_status)
+		*irq_status = msg.data.resp.status;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_scu_irq_get_status);
+
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable)
 {
 	struct imx_sc_msg_irq_enable msg;
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 914dce1..20a16a7 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -17,9 +17,13 @@
 #include <linux/firmware/imx/svc/rm.h>
 #include <linux/firmware/imx/svc/seco.h>
 
+#define IMX_SC_IRQ_GROUP_WAKE       3U /* Wakeup interrupts */
+#define IMX_SC_IRQ_SECVIO            BIT(6)    /* Security violation */
+
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
 int imx_scu_irq_unregister_notifier(struct notifier_block *nb);
 int imx_scu_irq_group_enable(u8 group, u32 mask, u8 enable);
 int imx_scu_soc_init(struct device *dev);
+int imx_scu_irq_get_status(u8 group, u32 *irq_status);
 #endif /* _SC_SCI_H */
-- 
2.7.4

