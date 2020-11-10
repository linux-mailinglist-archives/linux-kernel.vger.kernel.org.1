Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BE92AD85B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732134AbgKJOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:12:45 -0500
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:52782
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730059AbgKJOMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:12:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVw718i/kzRXWheQAyluIbL9LA/Dk0QxMIt5muvdP5x9kQrFu7MjdluCKpOxAfQkL+fVrPp8Cq7xLIqfqQb4mCONz3g37GwcHtQL3hM+1aT7pg3vaOsxhRZe2hGLxYzPNL/0zdFyBJ0dkcM1v9k1aZfRKANf+XtAxr0gmZua3mL1O4pqyHEkDqlg7s+CUnr4wNq9738+oreUqjw1yW5pldDLpx9jR8ELWZmVInQiphB2z35hLO7bzkb3J9bFpQIG6YqRk3n9gOFvuLCyHE5sZEMyymSm9iqgMHZ/LKQIGhlmNoLNI7o2AlaurHEtINy8TpDGYsnWzQ2iiRIMFOJt+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlCjeFFIoQ5+ViSEam7mGZZbb79CVzNu4mUPe+u8z54=;
 b=giofUpd9zjyFavGte5YjXhLTQqE2UoKcYN53zh8iCORuHOhZXIGEXPGOtCgDxMR46+MEzKkZAkfp4yxc3+0fZkK1FwKLZW2UXT7fOtd/kxFyNCpf0h2eDXRK4A+N9ACoBXruJEwz8PVP7UwKJ9+OrKPpJgMqtdOQ57I8KyHZkwnYnjrykdi2UrgD6NB5YouYnYkak1BMRK5jk+C8qPo10aN4hyCaoPWk7SzTAKOekG7dGQf/vQSfpsZgxJJM/SzF1lJqEKD/CQtkv+kVCX6pIWkdflu4eldf/o4g/NbnFGBgwRmpA+KevOEm+P8t2pXT7Ihw8HbXyORC+fOX4AaQ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlCjeFFIoQ5+ViSEam7mGZZbb79CVzNu4mUPe+u8z54=;
 b=YZ5OXZvJrgYG5DnrEFnQGGkJfmk7wj+AHCP5MywJp1qleFsZthhRznmqR5CbGHcuOdWVffqn0aJCB/R2Mr8GSB3PQypF6mSGnM/ryWlfiIu95o+sEGIVOuORc4zX0/UroH//q8gZScp2Ig88TOayKUc18pszxQpq9Q04Su0uy5o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB4931.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 14:12:28 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 14:12:28 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH V3 3/5] dt-bindings: firmware: imx-scu: Add SECVIO resource
Date:   Tue, 10 Nov 2020 15:12:12 +0100
Message-Id: <1605017534-87305-4-git-send-email-franck.lenormand@oss.nxp.com>
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
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 14:12:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b831691-c2cb-4454-0798-08d88582a4ae
X-MS-TrafficTypeDiagnostic: AM0PR04MB4931:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4931A169AD1ED66B0CB5D587D3E90@AM0PR04MB4931.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHrk91hftUtS0SInk8THU4kZphMuKF4FPeEzOvXx052C2+yfJmQAdhNNPch/zfKiBgydNaPCZ0+FjTVb2RH5S9E7laBgXMAYyD6dwlVpNtZ4nEY9BM5BT8p40SNmt9jiZJmfCXeNw8DwLYJlOkcEaW0gDvV2tfd07pMZW6uBSeGRgzUYAgH4evrg5pmr3LuW1lH60S3EE+cvcRzg8uRGve8LfFavixL4Mnr3QdQ8j812GRLc2tGMZT/pYM3xsQ0CUKnD/SA0FHsHRYrrI/ngX0/JGSPhpKhtT1I8OYO0MHFH88A9ddBrRxZdQaPb9IZMyucXPMJdRVk0rNkIpQE8Bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4744005)(498600001)(2906002)(2616005)(16526019)(8676002)(9686003)(186003)(66556008)(66946007)(5660300002)(6486002)(6506007)(52116002)(26005)(956004)(6666004)(83380400001)(6512007)(86362001)(66476007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YK9ZNH49RAfAVY7agMTek1gpJy3E+AZKX8C0AU4W/p8XJcaL7M7gWkfmQkMb5QFjLr1y/kMZAi5nXD4OH0KIvFN3CxhCIx6NO3UovtMh6+DrAsep4V5KVxrf7azw6va9uaLpkrT/SbGNl1dpRwHDh8eVZikyu/iGgRthkbz8qDyZ9Am0O/EufETI10xuyiIN02ZIJT+AqlZgsQa0fyMkM8fayyJahlrW/PiFJciFQm0GNzZxVYnn6d10lKdVs3IiOpYepuV95u8cFSNxIWIYDi+e40pjIQgiu4ORxpSCtYof8OF4G56HZ3CJ2PxIwyBJDt8Je67086gS5EsjPGPGQAKnWlQFu/shsl2qa6S5z4uNbUzs9ITs3KwnJI8AV3niBrJ8+RQhhfR8lJTxRFQW8GciGkg4jXddIPuZH+uVGpL2j1z5lqyXm7gR1UTdyBomWK8UStJ5rLWyet0ImWBY/uBb8cDGQrjThjKAa9S8jhnOJu4sDs5O9gWv/1B+3Yi461T4+8KvqqAYiww85QIboNNyN3+m4jBnB+AVG4Yq4JqK9T5XTx0YMLYUzMo7AkXs/yae+2DfTNdcJk7b1kUJt+jbUzOUuZaaoEob1Q0u/bccmO3xC9Ahnxt6vUcjysDn
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b831691-c2cb-4454-0798-08d88582a4ae
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:12:23.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVpQvlynYaAC9aP8iSLgJ8f2c+Khb8bODQGZTAtaDa4Urq0i8mq/TM8M0ZmZrtgNyTyvzP2/PZIybSo1AGoNfhhjslpRbe//sUro9rT+o4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4931
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

The SNVS can trigger interruption when detecting a security
violation.
This patch adds the definition of the resource.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 include/dt-bindings/firmware/imx/rsrc.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/firmware/imx/rsrc.h b/include/dt-bindings/firmware/imx/rsrc.h
index 54278d5..fe5f25f 100644
--- a/include/dt-bindings/firmware/imx/rsrc.h
+++ b/include/dt-bindings/firmware/imx/rsrc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2018 NXP
+ * Copyright 2017-2018, 2020 NXP
  */
 
 #ifndef __DT_BINDINGS_RSCRC_IMX_H
@@ -50,6 +50,7 @@
 #define IMX_SC_R_DC_1_BLIT2		38
 #define IMX_SC_R_DC_1_BLIT_OUT		39
 #define IMX_SC_R_DC_1_WARP		42
+#define IMX_SC_R_SECVIO			44
 #define IMX_SC_R_DC_1_VIDEO0		45
 #define IMX_SC_R_DC_1_VIDEO1		46
 #define IMX_SC_R_DC_1_FRAC0		47
-- 
2.7.4

