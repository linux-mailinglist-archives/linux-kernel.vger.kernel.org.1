Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B783E2AD85A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbgKJOMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:12:42 -0500
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:52782
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgKJOMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:12:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDcUjUw5QpXhTo2biMN5j+5mVo4Ktu68F9CMdE4jcS+Sw4LriXr9tgUeRinKKhiDq/96ZuGZC9APPPUQ4JZum9nro+bkQ9maj0dOYkEle9UnKH9mpt5kyNJtWA5x1IAdj8dTsVr68VWxoboXeLdoNP/DrYtCNwjdGq5O2KeN57klK8J4NOJQzlb0xAxskRCmrAfn1tBZeCsinfyi9YzvVsswufqjxKbH8yommkpiDrdhF8Czc0mmvWaQm8TKFLqVp9R40+B6d0W8Sg/jqrcY2wR8sQB5JQbXy2Y1ZPBdmRzP0Q0H82x/tDHpOWTScGOAz/lJwIv61KxCdi96bnoQdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4/dNxtFNG6pRfgwBcw7Dz/2s6SFql0A6aFbOeAzMXY=;
 b=CoEIL/qQSKf72QFu+b7xd3Zw9sUowBvMs95UfEeedhuhFgoF0dUquC7ckgvUuEiXpD86B8PvB+xTMVGt6kBmd7n6cJlYl/UwJDhmig9+vKcPhM8jCnj46ugV12kUlOeW1kAnrcjzYGjOltdl/4/n9NcTTOXixu1dUTQpr/dwK4zoR+l4yNw0Z3EAP5PMY2FCvwGz06AqLsz2Nbvh0Qy6C1qt5qRrS0BB4u2Tk3PVdaGXkKmexdHA4249i6BkaE8DvFnbVe2TeV3CERDVQuTWTN9F9vAh7wMIn2vCX9X3p5Umup43/lCrUv74Va/KPM/oSW4XzotwpFgWHsSYucrI8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4/dNxtFNG6pRfgwBcw7Dz/2s6SFql0A6aFbOeAzMXY=;
 b=gU6TBrXKzE7TuQBwrG5vIJoZ76vqR8i1pWYG0lsf0ZKmXYddeb6ElVO7KbDKctI26aweB/6UaJ5OMfWcDc+7Qncgf5t1hONUm6mlyqB3G5oq6+kpjLt3iVodDBUk/ZgM1dcUV93LpGv9Y22scWo17E5/kh62/M5u8rrLoR0drfY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB4931.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 14:12:22 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 14:12:22 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH V3 2/5] firmware: imx: scu-irq: Add API to retrieve status of IRQ
Date:   Tue, 10 Nov 2020 15:12:11 +0100
Message-Id: <1605017534-87305-3-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605017534-87305-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1605017534-87305-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [81.1.10.98]
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 14:12:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d0ff6c0d-cf6f-454b-8bae-08d88582a3f6
X-MS-TrafficTypeDiagnostic: AM0PR04MB4931:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4931E3C3EA2F39277585366DD3E90@AM0PR04MB4931.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IAqFx06I/Yn9GzH+LySYbelzXLDyEhZfFTXgP5pJYf2HtwcNAXAZXCK+yLYonWKx7f5D79Gw+IrE3wnsuBHirfbzn9xoCoF6ZWhtyCcYtc4q+RtneR0GRPnE7EZlM15rbvqm/M0nkHm1x15524Xf6sVN3nooqhn9VrjAp0DVcw2hE4xgw9JfDybIhXQReUd+yxgxRDoovEbtPWn8RzGLcq32T+R0e+WtOZNNjK0DAGaVWcGZKIrwJ34X5hXDyX7KOvLzy6zrUsI6QJ4Wz6MQdxqLmTsuDIu1sZHGf/l+It8/VfpXyB9yXkIf3a0/O7ln/YjTzvUctVVgqjYjv9uBcQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(2906002)(2616005)(16526019)(8676002)(9686003)(186003)(66556008)(66946007)(5660300002)(6486002)(6506007)(52116002)(26005)(956004)(6666004)(83380400001)(6512007)(86362001)(66476007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: A5d5skD6sP4yC5e3NXGnKgl216X74VnMDW3ulJU2MhD2RuTOENMKZeqs4jft4MFOCtrLyjaeArYGlSiV+tY7TPdw//Cs/KXGu5aSdh07KORNDYlK/bwPhM7M7DNoWNHg9Ewh+HTS/k52e/galS4D6OxNweC4PnoGv36BLuzTmKWcI0u6UT10cvYnyEAkmo88ZKONCNRy53LmbKlVAWawO8PmY2ABYZTmHVBVrrsz6hIPPcoQ1218K/tjfUDHRyQciletxBmzqRkiQu3MnVArcUL8MoP5bR0IvwmEcXnjD6iorJDg3IH6ZMmkijuvKFi7WQJDHV1bI6pBr91TNEJk8ivnHf+taxRmIoMDj2X1nGkHytG2+ISETDn+Ze3hbGesWWHebpQiJ6M73UXD9ND/zAWIOhDWx6FOUV7JhTPAEX4KlI2oSzLASvzNzI5rOeDn3pv+/mEi4EMnR6w6nXDxNhV0G8foAkF1kkfYJQI1X4wz7rBXOLVDK7iCR7VdeMjiYFza2Nr0baHRMVjK/dUD87ivViVPX/5zRJt4vS5pkdNT60siDQEFVwZC6LpPd1DDEr3BbdopX2nZmNSqMsBqaT4Tv6yKpRV5Y3bQAHJO4K/bpnUsemQlp66uzWBySLqkRZ+D0BrQW7iGQwJ0S05p1A==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ff6c0d-cf6f-454b-8bae-08d88582a3f6
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:12:21.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3z7uUrCYPrBiqd2ZWVAUJU1uKKPSmYzs9wWberTBakgzxcTAQ0VUPPmquLh+iiTO8/C9yyPG56qcjJ4/oC1r3o+7LkHJ/9Lop50RVRwv28w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4931
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

