Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08B32AD859
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgKJOMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:12:37 -0500
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:52782
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgKJOMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:12:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm5Ff5FT4Cs6XUuckf+gUwY1pPpY5MXht3l/LHLEA4S2jw7TI5d6rDffyDXmi2k9qbps+tVSC6yy/K180JAiS6CewTKl2DXelCxDO3/a9hjBfcImH77tze8KD2K+oF7dzwUZcWHlFQp9cnB9DmxaUvqSXoB5IFd9jjPQfDYNk/f5tTOoNccN2jq8rbEz88svdGmObi2iaDVXr1hhW05tioSRVjyKCqiHTxWo3512PI1K9vUs6qHElgLSES3J2F/j0GrnCcVz0qXrP+elA8n7PRp1/WF2XGdTigGAeG85NXguOh73kG9ahY6Xri8dQvgV1pGI+UsIiR/4GO2+NsaL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDvPh7V5Nw5tvT43AEsMu4TE4sDdvPg89a7EFM6B5U=;
 b=PS+UT9Y/Rf6ZReuF080b16sx0qO6UAUcJT6bxXO1XCZkIJO0il7EiLndfFmXe0yxgoJv93J9EIVXoGk43rgO4ooYSbh9zxVmGxw6CDyGr8uZ3DrFEuN3GhB9wJgNSRoDhnbVKe1TDOE8Ytx7tMqCrdKUkV7hanvlXJcjkhvORe7pFC25Nsz9xmB4HTf9vTsSpy1rSuzdtHjz1AWWJsXRGISYzni3gt9INBEMgZpx5l/y/o6J2/NAflqtPKT5+l0T95OPB9Yng32gb02Flhlp5jn9YMho2yD5ntsc7f2rgN8yu/q3dua8X1lEbzYYHa7UIRQugz0gBH2qPvXkOh87fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HDvPh7V5Nw5tvT43AEsMu4TE4sDdvPg89a7EFM6B5U=;
 b=emBVrNrMa+PhYfPnpN4TaJArVIR+YPG4FWf6K4DGJsE4oze4HJJLR/vmIP3EfnZTqGYORexrZht1lTDpNBuJi+f52YJdikzj6DPjqymqarz0iyMmitagu8T0mmMIMS3UHTCeVPp95PaCSt4MFNBBNp395BMalrnNAL00h3R4cQc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB4931.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 14:12:20 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 14:12:20 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH V3 1/5] firmware: imx: scu-seco: Add Secure Controller APIS
Date:   Tue, 10 Nov 2020 15:12:10 +0100
Message-Id: <1605017534-87305-2-git-send-email-franck.lenormand@oss.nxp.com>
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
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 14:12:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f25e1aa5-e912-4630-14c8-08d88582a32b
X-MS-TrafficTypeDiagnostic: AM0PR04MB4931:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4931B1F940D6B4B37DB3D73BD3E90@AM0PR04MB4931.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:176;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YbYsaL1jgIckmUKTbmuzwzd6nu8ylycgAzhlvE424tSNgC8MnSpKgc5QMQRptRUwfhb+1jAjSjCOLVB4t2pD8whFYfcQbUOTvv0HGammeCFD0hS39uK2lpvTubfRf5id6VpsJcYmpHhgalS/AUjycwEWfgdDymkWnP/Xj3XQhUdyV7BvO2PiopbrIBmDL7KwfQqJUXxHBbG6v48FEnJ7+PIeFR8q+vlExhaRqmiZa1mg3qxa9GlgHpwJ0P9MbkUSWY+i0awRm0YVf+hcu2XdUt/xT/0A4H1W/MxArfOT6Ub1VCxuisp4NWVXHGgt1veHjg5k50a0zeaJA4uDAwjcTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(2906002)(2616005)(16526019)(8676002)(9686003)(186003)(66556008)(66946007)(5660300002)(6486002)(30864003)(6506007)(52116002)(26005)(956004)(6666004)(83380400001)(6512007)(86362001)(66476007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: s8NTP6djR7DNvRT16Y+2KrW3YQbZ5cu6oxdrkNdVzPoDphxj3NAzdbquom3PNg2zEbTdE3oP9wGIDvVXQRSG4yMr+6qo619HjIDl0N1b8HHPY7KjqSgwnRCuC4gmzMSexKvbAqmH1EQB0tl57GJpTIIHfDinNFWfHjLqKPK/nfcaEp0C0ZdzpC0kvCYMiAbTNevrZ+1ZTL15Si5g3rgnfCiuhKiRB+IB+tN2xqL8z0zY0V04BMTil90EqtM2Ncf+tp1BR3UqHYSrsg4h9D3ubCEJf9OKDCNE4oetQCPPDFeet9j8+mcFZqw4lli0zk9mx7iiK5HIwhW45fm3IxfHX2HEb5fcechGC4v2lZgdR4bujJcMPSJjdWHgVWF9vfrafGdA4BQ7LtmcLu7iPoKa8NPzE7aln9KKKW52RUVshxwf7CSVSP8jgwg+0a27TomljznP5eIiLEB4kMFzJ/iPwZHzGQtwkHkOOgroOUmwZLUYuTAyaMLo3vVC28d57ZqJBKb7FJ9d9XxingHTkwm1KMUsHJ6mFtST0cPe0JpBmOhkyVLv/3TH14ZQB78/YzT2WR+FIeL9IQz3H1eiCZtlqG3/zAGPM1JSsW/CdtmKRmO5UxmA5l0vEdQg9Pb0tXXTtk0/8Mfgg0ee73uRvkTbgg==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f25e1aa5-e912-4630-14c8-08d88582a32b
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:12:20.6616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5wsN6gnKomA27mKzsXzYB6WzA1/g9Z1pTsNvxDHFabNJUrptTtqOE0GjZytQ0N4wR0jcBJAXihXVNrBrCAJL+KMsK7yL8FMmd9S7fPL+j60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4931
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

