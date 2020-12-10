Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3812D55A3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgLJItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:49:45 -0500
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:36889
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgLJItp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:49:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwFsipTIeQF7Eh+buzBLHViC6hl1hQAsSGthDBGH3/jNyr+OP0cIStrE5JwE1dXtlNZ75GGiZMVmylOn6+BNA84gaVChpPZaT44F6sUqmMvtJ982Y98IOGrhLSnMkL+PQv7N3kAquFVgnUUn/kWthYpS0g/ynHZVlejg0icfNybjwbiiAs+LAOUE6tJYps9u10jjzMtYcLc3qsDr5Mb8wvMrTbRQ3EaG0fjeEkM/BNNZ5sglanYILh9bKjqAZLXlfl8p4AA19n2pcWfTLZeyfYMiWoytjOTyEll2X8Uu9agSPJmvHkus2W6MQOhWu+Lyf9uuO4DlenkkiMg7wxBZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlCjeFFIoQ5+ViSEam7mGZZbb79CVzNu4mUPe+u8z54=;
 b=HhnvIpCQQq3O8oQV5J9D+kuRYdNGonb6erVyamNnD/IDORJ791jFYG0AOnOM0GUkDFIvRFky+G4fimbx4VpF/C0AbpV0Hl4NFI6HaAvleXzncV7Bce9jWV11XyI5I1h7B+84Wi59wBR5F413blkaUiPmCwiIBAfMl1uuC9L6jHs93QvvJ3De/7se8T8UPFCls+H5lKqLWGCCimGL/6L8lUwrzXrwNtzOajnuwKEpZKgojxl3f7OS02yIOclepnKoNLar3PGx0t9DatLZRr3fsPi9Vf629QMynvmdaDoBGY9ogzybXRQWbwJvOLiMBLM9LrzxeL3luum5szb/sVwoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlCjeFFIoQ5+ViSEam7mGZZbb79CVzNu4mUPe+u8z54=;
 b=P2CxS2Jv4ssES6V2jiCfHU4z0IHAFr6Y4K8NNAwr8HK5X3nf2CrPMHaJfh2vyRa4IcJfJQUv4AcCoW5y8sadDcWRyVjX8istcGqfIbBjAicPp3tiemw2z5EKgsnlj2X8HJGw7fJ4iYTrUlToR7Fki8nPj+/SSxZOKFD2xS40aBY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB5635.eurprd04.prod.outlook.com
 (2603:10a6:208:127::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Thu, 10 Dec
 2020 08:48:56 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6%8]) with mapi id 15.20.3654.013; Thu, 10 Dec 2020
 08:48:56 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v4 3/5] dt-bindings: firmware: imx-scu: Add SECVIO resource
Date:   Thu, 10 Dec 2020 09:48:48 +0100
Message-Id: <1607590130-11065-4-git-send-email-franck.lenormand@oss.nxp.com>
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
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR04CA0104.eurprd04.prod.outlook.com (2603:10a6:208:be::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 08:48:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e0a64c41-ac46-4939-a8dc-08d89ce86df4
X-MS-TrafficTypeDiagnostic: AM0PR04MB5635:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB563502E1F247D77A00A41D42D3CB0@AM0PR04MB5635.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1417;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +1uYZ7QWgaNc774L0q1eKVP9/WVJMYPxeQ6tUHPGKpz4pdbo7vB7yv/TBmELkdh+VbEunBbe3AOX1HrDHnFyYctctCeQ7J6wsCLUaJ6hpVs+FA/qSWdMiTw3P+QXyc3wtyHiEQMI+/wfYqOnppLGqDGQVob9kbR7GaN6p/QKPNeGhTlssqusrCBZ/umlxvhaZXRPc+LqsDQV0si/CRwea69Vz8G2wLSAVaVpinBYRrDyOyc/l2DsD9kq1IKUAFSa264nwXnyWLpMyDr6ZDB2q+L/hxcTH4LWSIr9D6ARFOhp6J8msk8seGLyF46JWlDbAkhc8aLfCP8qszNu44mdZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(5660300002)(4326008)(316002)(66556008)(6666004)(52116002)(6512007)(9686003)(6486002)(26005)(66476007)(2616005)(8936002)(478600001)(186003)(8676002)(4744005)(66946007)(2906002)(6506007)(86362001)(16526019)(83380400001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QZ+cmE3ZS6+5jNFsRBUcBR7qQW3JgxZTAGi8zvvPziPy8Z4xAHU2oKVbUIen?=
 =?us-ascii?Q?xEHY4nnvbPFI5XGGrW6uK3QkpI1oFx+akz7fNyJ57UOEu96XplGSkMQz3lkG?=
 =?us-ascii?Q?7Gow/l9WzOFMAVf3o4rzEymslQrCW7uICZt8lbGweb6DKsKodXDdMgdM/q1F?=
 =?us-ascii?Q?8dJbTKpo7Qr60G1OZG9qTbbrS0L2ogH2MKlX8BVRAcwCpvm6FM/zjQKrh7VQ?=
 =?us-ascii?Q?nhB00oXiZYzMZX9DHg4TCe8/iH+5n0Ii13cctJr2R7LZOHMRiLWLAiwWIkMn?=
 =?us-ascii?Q?a7RzkYHgRkzEAbctpFw2iEXqwp4QdhBKV9b1Ah+oZmvRqVLoJDmUnQhXJ6xR?=
 =?us-ascii?Q?o1sx3dvDViiVjlh9FsBZMwF180P1138L6QAkb2PyYPoYXX8RbtM5gkI0qAwa?=
 =?us-ascii?Q?g2Qj2ydni/vyoG7Xs+1BpNddcRlm/VO1VRAKrM7PINST252+Ukn+LtmDKZUS?=
 =?us-ascii?Q?PCiJRubByXqXuHk8q2SSxFTG8MyUlSGnG0BVSkIYATcltWnYtInLdyutFB9B?=
 =?us-ascii?Q?C6O0tcnHHYIgubZbj5li3qWTsmG8azd8rgH++uf7b8415T16ouEBgyCCrRpP?=
 =?us-ascii?Q?pgofSiwzDZoNG045vcyA1M+C1W3GCrUOWaetz+WQJ673yqIc8Wg5I2diwCjZ?=
 =?us-ascii?Q?2ADLHds5WoYRi1MW6hrosrKUG7iy/jPFgOITc31+2s1bq5p0zIYU6QI5Sod4?=
 =?us-ascii?Q?SYBfGR4nlqaeUB8WSC2eYp+oiKtzkpubxNM4o6y04DqTwaoNzR3ITTLFOHpG?=
 =?us-ascii?Q?2ohHd9oD1IrXdmOeg5Z83Hm+0fifk7BsB7kfK3T2wk2J0cdzNDSRADF86UBy?=
 =?us-ascii?Q?+/HbpbrP8LNuGTquaQsJofCcqeb5ueYl6I7l7DsVln1YqxhVzMpdyDeWaLib?=
 =?us-ascii?Q?qjuANF3KMg/GJV/iDWgZuEUtQxQw552XmEHeCPFuEsSl8vhOtr/BzpvpJYpD?=
 =?us-ascii?Q?SiJ5bT39BKjrvOcYFYbr1rFjEpbxXDu6XnA94ikCTG8=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:48:56.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a64c41-ac46-4939-a8dc-08d89ce86df4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 346Ix222MEhXO1QB1XFxH+Olg1lV9z/4PtHi7s7Hm/fSEqVveXFh1vmdF2lHOT3L9WH8WbP02IoTCgvZWYdOAv532xdd3Abnx721kYlNFgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5635
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

