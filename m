Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2822D55A8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbgLJIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:50:42 -0500
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:43714
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388197AbgLJIuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:50:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBxrvVtfh5KOtSVhXGz8fXz+gzW2GESDugxlMIvV/1Og9G2vKnixM4Mdtk5IWDQl/jXSIQOBeQ6bQezHeu8rAEqC6aJJYTKfcKcnaqGu/u+7rbODfHTE1Zr0m4CeGTzDch7T0YQWBpieRdsWXOA4ycJDoyK8n7+/gL7kZaKQR9k/YKTWJm7nmequhFq4bh110mQUjnL8ACyh5p8KZWQ9GIxWq1t7MIbOHmOCmLFVwnwBgRSFFoCaMZmJSSC3lM/NQy2YspchOmCAxFtf6YGaUmQCIGE1FQ1e1BVbxQJ/Tz6wj9Pf6Z3qvymr+omIbv3WOB/bsjO4JsG/ZYKnpZgJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDvPh7V5Nw5tvT43AEsMu4TE4sDdvPg89a7EFM6B5U=;
 b=WGkrkYZpN3aJhAR7MAGqiQ0fUwIaacv2u9JtEFp3uckE2fFMxdcblsnz+bXXl1TligUR3tR4EALpwwtVv718tWXYhXVkWhOcGrZkPoy7w7kbpTWI90v2k4ZKbBeW9zyriDm78lzSbjR+aieNf+49FeIYx1KFt+b8yZSD2ocK4HKQpe3LnTTePwhKjq3q9mUx8Xyw16wjISlL797OVwtDE+hR0DaLnTdJVXkUNjIj3un49j271ET583eKuHaQi6cBxzAlmu0UUFy0xqpe7QhVuVelP5YivITYdoo41dvIpyZ6UzaJPThlRpzs8fa3RRXWicKcrEyM8BPdxieEhcYYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDvPh7V5Nw5tvT43AEsMu4TE4sDdvPg89a7EFM6B5U=;
 b=W7UTVdC8dMdGPDwUobV1eMZs1QkWShvDhPa46gFvoP2Qax4duSCDHA/OVqQd26aFCUEa0u23p1VVYX++swE73Jv35mi2tRMTiaOR2XdZmjhuSX4xVX5vb5GrDoB+IyFQA/10pS2JohWjyi8hYBNEqXN6VZMFiFN8Rpdk8W5I6WU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB6962.eurprd04.prod.outlook.com
 (2603:10a6:208:188::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 08:48:54 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6%8]) with mapi id 15.20.3654.013; Thu, 10 Dec 2020
 08:48:54 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v4 1/5] firmware: imx: scu-seco: Add Secure Controller APIS
Date:   Thu, 10 Dec 2020 09:48:46 +0100
Message-Id: <1607590130-11065-2-git-send-email-franck.lenormand@oss.nxp.com>
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
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR04CA0104.eurprd04.prod.outlook.com (2603:10a6:208:be::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 08:48:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc59866f-cfba-4033-8929-08d89ce86cb2
X-MS-TrafficTypeDiagnostic: AM0PR04MB6962:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB69622E567A65916BD1DBA574D3CB0@AM0PR04MB6962.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9fThuyIytkT26kmj2ldmA1VJtvy+xPPgSLSUYA7fhhtiR7pPKHKYE6ADuTRmUfbLNTtAin3/iJNMqDZnbDo6mDjsyCcgM235ZsGc07l8rgMyfIZQXs1b3wfOC8VXp9VVUP9Rppn4x/KU5dfzdI2Iq0aoxzfFeHPRDn0hqblsdW7DAstOcJrDI7ce5ga9TKzbw41UTbu2Z85zt0zrsUcAgWw9xigsfplzqCwh3h9hehO/iXGP7f7jhg4qklrf0H74rJGwSv2MKi7RwC6ZP8Us9sn2adFTMj1q8uP9XNFVxhNoApaAijpm20snZcizsGQZbUnhiLgtlpG6Y+SJvQoMfg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(376002)(366004)(26005)(478600001)(956004)(2616005)(30864003)(9686003)(6666004)(6486002)(83380400001)(8936002)(2906002)(6512007)(8676002)(86362001)(186003)(66476007)(6506007)(66556008)(5660300002)(66946007)(316002)(4326008)(52116002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SXtYmIrnqhtVHDjsMJpvQygNKZJqfkMXbAjpN/Ftp9BS1b78mi4v67GgInyU?=
 =?us-ascii?Q?SqiVzD7LoqRhaoNGQ5spGOCBjSZQ9Q7NfP5dPwRRAGgKp2i4lUbtLMMH+9BW?=
 =?us-ascii?Q?Ej0dqPOSh1Yjfo6e4u+4N6nJs7pIQ4Wb0txPOKIiSTgwxeA8KSX9y6GLB5K/?=
 =?us-ascii?Q?cjPZBQ/AngVVxjfkGKkfYGe9OBTOq+nLAOXJc3t6SU9JhukOsuzg9U78eCoG?=
 =?us-ascii?Q?ptneD6X9zGIRBvhAF5XBFn98ozB9eFq/zUMxpwFCuDfEs5zyE/vmU6+jcyih?=
 =?us-ascii?Q?Q3iFSLUAX5rg57Wko2GHIgyGzqZKFVfINS/99N5XcsZGdmDNwyv0r6d9vaCN?=
 =?us-ascii?Q?MtEfvOsrEHgVxLmvEekkmPTc85qkf7nPf0oyAoX5Er+fqEJT71msBiQvLvyv?=
 =?us-ascii?Q?f2Se4fqSzOeu/Qr7K99lE8cZomHJrl2jQpeznuNVlpsO87ykfPHUeToSra6o?=
 =?us-ascii?Q?q7nhLv0VSCyk5Z07nwk+5dNHBPYTihLevcjfkA53R1O/vj70DT5QbUCnkpc3?=
 =?us-ascii?Q?WqVYkyWpGwLZR1C8E+dQopBX+Sh3T3RDKPiFcyfMcj1KKTDMRwe5Jy8KaBSm?=
 =?us-ascii?Q?Bo0WKXcaFqAtA6vV/uWAssYAsVassOae5jtqYjH2toC66n5Vm7xy3tX6MH4F?=
 =?us-ascii?Q?4lpIM1yJ9uR5ELceAcwDonbqpziUy5wG0Y42tCX0IaUPAGPudRdLI0XtqAEs?=
 =?us-ascii?Q?iyo93IpjjzuK1xoRilYQknYs2ZkVeuvMlPj9/yRYxS1dJHtK/04bsZ074R5Z?=
 =?us-ascii?Q?2PhtX8P0cg8BRzwEccX+wKCt14M/MviD3x+TG5iat8ZTx9aPZ8AAxbxBEk5B?=
 =?us-ascii?Q?yULeCoErKX2YR+Ri1oLECbx90GDg5wYB1pdazOoX8BfL8Pr6G0bWcP1uw9/J?=
 =?us-ascii?Q?4NQUbds51iYE9Ihrt5uWPWj0vMF3lXgR1DQ3R9g6bi1rGpGbQ69NsXQXgPKY?=
 =?us-ascii?Q?iky8jW3zWLZYlf6uHOUfusenddtOqpDE349x8CUz5ic=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:48:54.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: dc59866f-cfba-4033-8929-08d89ce86cb2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhYBoN67+r5jz7RvJMr4l6rkBBHkaJ734DV8sHem71yxkQ/UCZAcWZgS/vbWNn4raZpXhAraDULKjpnZHaoHhMwMfOWQ0045zkzgdqU7mlQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

This patch adds the APIs:
 - imx_sc_seco_build_info: get commit and sha of SECO
 - imx_sc_seco_secvio_enable: enable SNVS IRQ handling
 - imx_sc_seco_secvio_config: configure SNVS register
 - imx_sc_seco_secvio_dgo_config: configure SNVS DGO register

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 drivers/firmware/imx/Makefile         |   2 +-
 drivers/firmware/imx/imx-scu.c        |   8 +-
 drivers/firmware/imx/seco.c           | 253 ++++++++++++++++++++++++++++++++++
 include/linux/firmware/imx/ipc.h      |   1 +
 include/linux/firmware/imx/sci.h      |   1 +
 include/linux/firmware/imx/svc/seco.h |  73 ++++++++++
 6 files changed, 334 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/imx/seco.c
 create mode 100644 include/linux/firmware/imx/svc/seco.h

diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index b76acba..f23e2b0 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
-obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
+obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o seco.o
 obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index dca79ca..bf768d2 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -241,9 +241,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 		 * APIs are defined as void function in SCU firmware, so they
 		 * should be treated as return success always.
 		 */
-		if ((saved_svc == IMX_SC_RPC_SVC_MISC) &&
-			(saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
-			 saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS))
+		if ((saved_svc == IMX_SC_RPC_SVC_MISC &&
+			 (saved_func == IMX_SC_MISC_FUNC_UNIQUE_ID ||
+			  saved_func == IMX_SC_MISC_FUNC_GET_BUTTON_STATUS)) ||
+			(saved_svc == IMX_SC_RPC_SVC_SECO &&
+			 (saved_func == IMX_SC_SECO_FUNC_BUILD_INFO)))
 			ret = 0;
 	}
 
diff --git a/drivers/firmware/imx/seco.c b/drivers/firmware/imx/seco.c
new file mode 100644
index 0000000..fd11bd4
--- /dev/null
+++ b/drivers/firmware/imx/seco.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2020 NXP
+ *
+ * File containing client-side RPC functions for the SECO service. These
+ * functions are ported to clients that communicate to the SC.
+ */
+
+#include <linux/firmware/imx/sci.h>
+
+struct imx_sc_msg_seco_get_build_id {
+	struct imx_sc_rpc_msg hdr;
+	u32 version;
+	u32 commit;
+};
+
+/**
+ * imx_sc_seco_build_info() - Get version and commit ID of the SECO
+ *
+ * @ipc: IPC handle
+ * @version: Version of the SECO
+ * @commit: Commit ID of the SECO
+ *
+ * @return Returns 0 for success and < 0 for errors
+ */
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	int ret;
+	struct imx_sc_msg_seco_get_build_id msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_BUILD_INFO;
+	hdr->size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (version)
+		*version = msg.version;
+	if (commit)
+		*commit = msg.commit;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_build_info);
+
+/**
+ * imx_sc_seco_secvio_enable() - Enable the processing of secvio IRQ from the
+ * SNVS by the SECO
+ *
+ * @ipc: IPC handle
+ *
+ * @return Returns 0 for success and < 0 for errors
+ */
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	struct imx_sc_rpc_msg msg;
+	int ret;
+
+	msg.ver = IMX_SC_RPC_VERSION;
+	msg.svc = IMX_SC_RPC_SVC_SECO;
+	msg.func = IMX_SC_SECO_FUNC_SECVIO_ENABLE;
+	msg.size = 1;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_enable);
+
+struct imx_sc_msg_seco_config {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_seco_config {
+			u32 data0;
+			u32 data1;
+			u32 data2;
+			u32 data3;
+			u32 data4;
+			u8 id;
+			u8 access;
+			u8 size;
+		} __packed __aligned(4) req;
+		struct resp_seco_config {
+			u32 data0;
+			u32 data1;
+			u32 data2;
+			u32 data3;
+			u32 data4;
+		} rsp;
+	} u;
+
+};
+
+/**
+ * imx_sc_seco_secvio_config() - Configure a set of SNVS registers for secure
+ * violation
+ *
+ * Some registers are extended by others registers, they configure the same
+ * kind of behavior, it constitutes a set
+ *
+ * @ipc: IPC handle
+ * @id: ID of the register, ie the offset of the first register of the set
+ * @access: Write (1) or Read (0) the registers
+ * @data0: Data for the first register
+ * @data1: Data for the second register
+ * @data2: Data for the third register
+ * @data3: Data for the fourth register
+ * @data4: Data for the fifth register
+ * @size: Number of register to configure
+ *
+ * @return Returns 0 for success and < 0 for errors
+ */
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	struct imx_sc_msg_seco_config msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_CONFIG;
+	hdr->size = 7;
+
+	/* Check the pointers on data are valid and set it if doing a write */
+	switch (size) {
+	case 5:
+		if (!data4)
+			return -EINVAL;
+		if (access)
+			msg.u.req.data4 = *data4;
+		fallthrough;
+	case 4:
+		if (!data3)
+			return -EINVAL;
+		if (access)
+			msg.u.req.data3 = *data3;
+		fallthrough;
+	case 3:
+		if (!data2)
+			return -EINVAL;
+		if (access)
+			msg.u.req.data2 = *data2;
+		fallthrough;
+	case 2:
+		if (!data1)
+			return -EINVAL;
+		if (access)
+			msg.u.req.data1 = *data1;
+		fallthrough;
+	case 1:
+		if (!data0)
+			return -EINVAL;
+		if (access)
+			msg.u.req.data0 = *data0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	msg.u.req.id = id;
+	msg.u.req.access = access;
+	msg.u.req.size = size;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	/* Pointers already checked so we just copy the data if reading */
+	if (!access)
+		switch (size) {
+		case 5:
+			*data4 = msg.u.rsp.data4;
+			fallthrough;
+		case 4:
+			*data3 = msg.u.rsp.data3;
+			fallthrough;
+		case 3:
+			*data2 = msg.u.rsp.data2;
+			fallthrough;
+		case 2:
+			*data1 = msg.u.rsp.data1;
+			fallthrough;
+		case 1:
+			*data0 = msg.u.rsp.data0;
+		}
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_config);
+
+struct imx_sc_msg_seco_dgo_config {
+	struct imx_sc_rpc_msg hdr;
+	union {
+		struct req_seco_dgo_config {
+			u32 data;
+			u8 id;
+			u8 access;
+		} __packed __aligned(4) req;
+		struct resp_seco_dgo_config {
+			u32 data;
+		} rsp;
+	} u;
+};
+
+/**
+ * imx_sc_seco_secvio_dgo_config() - Configure the DGO module
+ *
+ * @ipc: IPC handle
+ * @id: ID of the register, ie the offset of the register
+ * @access: Write (1) or Read (0) the registers
+ * @data: Data for the register
+ *
+ * @return Returns 0 for success and < 0 for errors
+ */
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	struct imx_sc_msg_seco_dgo_config msg;
+	struct imx_sc_rpc_msg *hdr = &msg.hdr;
+	int ret;
+
+	hdr->ver = IMX_SC_RPC_VERSION;
+	hdr->svc = IMX_SC_RPC_SVC_SECO;
+	hdr->func = IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG;
+	hdr->size = 3;
+
+	if (!data)
+		return -EINVAL;
+	if (access)
+		msg.u.req.data = *data;
+
+	msg.u.req.access = access;
+	msg.u.req.id = id;
+
+	ret = imx_scu_call_rpc(ipc, &msg, true);
+	if (ret)
+		return ret;
+
+	if (!access && data)
+		*data = msg.u.rsp.data;
+
+	return 0;
+}
+EXPORT_SYMBOL(imx_sc_seco_secvio_dgo_config);
diff --git a/include/linux/firmware/imx/ipc.h b/include/linux/firmware/imx/ipc.h
index 89105743..6924359 100644
--- a/include/linux/firmware/imx/ipc.h
+++ b/include/linux/firmware/imx/ipc.h
@@ -25,6 +25,7 @@ enum imx_sc_rpc_svc {
 	IMX_SC_RPC_SVC_PAD = 6,
 	IMX_SC_RPC_SVC_MISC = 7,
 	IMX_SC_RPC_SVC_IRQ = 8,
+	IMX_SC_RPC_SVC_SECO = 9,
 };
 
 struct imx_sc_rpc_msg {
diff --git a/include/linux/firmware/imx/sci.h b/include/linux/firmware/imx/sci.h
index 22c7657..914dce1 100644
--- a/include/linux/firmware/imx/sci.h
+++ b/include/linux/firmware/imx/sci.h
@@ -15,6 +15,7 @@
 #include <linux/firmware/imx/svc/misc.h>
 #include <linux/firmware/imx/svc/pm.h>
 #include <linux/firmware/imx/svc/rm.h>
+#include <linux/firmware/imx/svc/seco.h>
 
 int imx_scu_enable_general_irq_channel(struct device *dev);
 int imx_scu_irq_register_notifier(struct notifier_block *nb);
diff --git a/include/linux/firmware/imx/svc/seco.h b/include/linux/firmware/imx/svc/seco.h
new file mode 100644
index 0000000..3bd5e74
--- /dev/null
+++ b/include/linux/firmware/imx/svc/seco.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2020 NXP
+ *
+ * Header file containing the public API for the System Controller (SC)
+ * Security Controller (SECO) function.
+ *
+ * SECO_SVC (SVC) Security Controller Service
+ *
+ * Module for the Security Controller (SECO) service.
+ */
+
+#ifndef _SC_SECO_API_H
+#define _SC_SECO_API_H
+
+#include <linux/errno.h>
+#include <linux/firmware/imx/sci.h>
+
+/*
+ * This type is used to indicate RPC SECO function calls.
+ */
+enum imx_sc_seco_func {
+	IMX_SC_SECO_FUNC_UNKNOWN = 0,
+	IMX_SC_SECO_FUNC_BUILD_INFO = 16,
+	IMX_SC_SECO_FUNC_SECVIO_ENABLE = 25,
+	IMX_SC_SECO_FUNC_SECVIO_CONFIG = 26,
+	IMX_SC_SECO_FUNC_SECVIO_DGO_CONFIG = 27,
+};
+
+#if IS_ENABLED(CONFIG_IMX_SCU)
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit);
+
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc);
+
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size);
+
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data);
+
+#else /* IS_ENABLED(CONFIG_IMX_SCU) */
+static inline
+int imx_sc_seco_build_info(struct imx_sc_ipc *ipc, uint32_t *version,
+			   uint32_t *commit)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_enable(struct imx_sc_ipc *ipc)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+			      u32 *data0, u32 *data1, u32 *data2, u32 *data3,
+			      u32 *data4, u8 size)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline
+int imx_sc_seco_secvio_dgo_config(struct imx_sc_ipc *ipc, u8 id, u8 access,
+				  u32 *data)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* IS_ENABLED(CONFIG_IMX_SCU) */
+
+#endif /* _SC_SECO_API_H */
-- 
2.7.4

