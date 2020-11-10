Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1139F2AD858
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgKJOMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:12:25 -0500
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:9985
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726721AbgKJOMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:12:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZEjhRucWmRijSMMWAGljYQAJiNRW5XQHs8Hl9o9IggVNBeRUXHL5W3A6kqT6oT1dxuIHGMKiB58tjk6vKbLJykudpxiyX1m/hLKOYP8Bxvcb+atEDtHfP1q9E5vm3xEXqmVuJxHQMGMtVVPLxf8RpYhgjVQ5uVBJnFTlUBcRe+298FYotkp+FFmvjHBYNrbTL+ue66BAIHjanchTIlSti3krbxS2GVowjXZfbTEDPbbao0XdYJ8gUNk5Jqe4rp+ti7Qfa4+Mt/bN46DKczhc3XRq5VmxRIRplvEhnstWZkC1odmmzEfndASA2wIBR9a5waOfzhh2VpmgT0BRyExcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsFfksRokxOS/Ncdke59svvVDm6EqgrLa90PSO1wz+c=;
 b=E4y0+G6cAC1/R3UmIVzCgVdiB1phySvfM4WpikBmLy8wa6+tqp1k0tasIHtowh/PwfAiC+wiwe+u3glRW33eqhC00sZ2OC6+WWHmIfK11kkSXdXvOS4VAE1f5rnmvFNcWQ4uALhJRKk4nIZ3SkiboxX7+ATFD+H5AywTtgaByIUEEZcBHYBHQM5FXpczwtRgc6izHSrVZBqsl/mCbC9wV05b0QCKSCbM2UCXZAVBphhwKpT8Bf0b4LfiVSOZkHL8aHXwMsHlwOe+mSaD2xxxRrfE2HaNho5zheeU92ch/kzGzFm7ccO0INAwoKUMo+63FLBCrn+P4HrGI2NOvrOd1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsFfksRokxOS/Ncdke59svvVDm6EqgrLa90PSO1wz+c=;
 b=AKX4ISgvb+VgaF51IAakWoY8NRiI91jIDd1aCTXgbxOn18xoRIowT5s2zwrzc8sH9sjdOXh4L3cBJhRJ4TGtkqu0rjeR1lc2E3uXs7rY51W2uPXwtW6iP3dcHoM7ILsaUY9mbAKqj2lD85BWynucd8QbDwoQLimeZv0nM4L2j10=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB4931.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 14:12:17 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 14:12:17 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v3 0/5] Add support of SECVIO from SNVS on iMX8q/x
Date:   Tue, 10 Nov 2020 15:12:09 +0100
Message-Id: <1605017534-87305-1-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [81.1.10.98]
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 14:12:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d818f3f8-439a-4393-566c-08d88582a11d
X-MS-TrafficTypeDiagnostic: AM0PR04MB4931:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB49315D6835C18A5124B92AF4D3E90@AM0PR04MB4931.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y8jqNfpFMEjZd7yn3ajKzF39uA+ve51J6WNEnkbmB/6s1jalxhShc4qj6HrvqQ1U6zMVFVCe6fkAx092iHhViWQBNO4OnJ7UZi0JeHghwVnFC0wizNLs3Kz1QwP7wihaPTj36hz+8jLQjUk5gpn5TnZe3GHhqirE55A/TBIr3dcfQm4I33j0BqZ6V4o5f84bBhmslNQ1XUoquhR2rfYpZKDS6T2vDnkIvqo83QffbhKES01JS3kCwQGhEBUm7qa4T0O0b8PVd1lr+gMli6pUf635Ybx1rH+RXc286oi2yUfbINsLvadmxV+tiUT21xk4BUgCCJDCabwa1vQ6izoxo73c5XcPtIqocFwBm0WkG02lbBTyG36OVgP9Z4DieA+G
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(2906002)(2616005)(16526019)(8676002)(9686003)(186003)(66556008)(66946007)(5660300002)(6486002)(6506007)(52116002)(26005)(956004)(6666004)(83380400001)(6512007)(86362001)(66476007)(4326008)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pNKdyJPzLoCOlO3uXKh8DACtSwiX84t5jv9RjI5E9Dvx+UgJEHbnq1GaxTHct3MmLC2Jnh9X6hNGJ37uYr9BMf1qo790B2o+CVrNmX7QUNvyahaPD9u3z3kJDgN0R7/HbpzR+SsOxZLAjQKsyxU8oRQxO1pL2zI1WpypKGmZLys/oJ/Cmu4BprIv99GTah7UyFV1hXH4bYS5jlVrUs7m1zYLmy5dd8S2c01V9+ZifmAY49gKFVRtHhSkYtH/StVPsbe1XWTRn/+wVEBJ70oT1oIAO2qEynlNt0kq4zHJ9qzw2F8iI+lb4aKcb4Oxt70vGyPfPd+V+Z5xnuhdXH7A8C/q/0oeza73XYdY7kz1RsmzG/bnHp8ElvFSTwsn30guOJMQsJ5Z8r1/gp3lNpCr/fQSGaXhPqplGtokl2z6rBOzPHB5VRMQYwfH9gYcqUB9hc9+ZhgOrNPmeEDgZju9JARJyoHxArA3avM4davEo83f2WCxiOSPb25qVI4M1MTCdHpCSGgDLkx5f2vwLBtfg7UpcHb0pERPHrNaFIY3cOeys8feCAkpQShN7coCNifF+740h/9j2o6ZRnCmBppYRSL42t6hSl2oVgrdrAAgTjrOcBsz6wSFTeKyQDR13lHp
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d818f3f8-439a-4393-566c-08d88582a11d
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:12:17.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROxkj67UO5IUI3Svw6fjhuxdma5vDN/rYVCplRXyjiwdyBKUj3vGBb6FtNqYop6qGKyNlROhNB9RMQfHIJHciEjC5mw05bHDDCEGyqWleLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4931
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@oss.nxp.com>

This patchset aims to add support for the SECurity VIOlation (SECVIO) of the
SNVS. A secvio is a signal emitted by the SNVS when a hardware attack
is detected. On imx8x and imx8q SoC, the SNVS is controlled by the
SECO and it is possible to interact with it using the SCU using the SC APIs.

For the driver to communicate with the SNVS via the SCU and the SECO, I had to:
 - Add support for exchange of big message with the SCU (needed for
imx_scu_irq_get_status)
 - Add API to check linux can control the SECVIO (imx_sc_rm_is_resource_owned)
 - Add APIs for the driver to read the state of the SECVIO registers of the
SNVS and DGO (imx_sc_seco_secvio_enable and imx_sc_seco_secvio_enable).

To check the state of the SECVIO IRQ in the SCU, I added the
imx_scu_irq_get_status API.

The secvio driver is designed to receive the IRQ produced by the
SNVS in case of hardware attack and notify the status to the
audit framework which can be used by the user.

The goal of the driver is to be self suficient but can be extended by the
user to perform custom operations on values read (imx_sc_seco_secvio_enable)

v2:
 - Removed (firmware: imx: scu-rm: Add Resource Management APIs)
	-> Code required is already present
 - Removed (firmware: imx: scu: Support reception of messages of any size)
	-> The imx-scu is already working in fast-ipc mode
 - (soc: imx8: Add the SC SECVIO driver):
	- Fixed the warnings reported by kernel test robot

v3: Apply review from Aisheng
 - Fixed the "SECurity VIOlation" to "security violation"
 - (firmware: imx: scu-seco: Add Secure Controller APIS):
   - Rewrite doc of return error code
   - Rework request and response structure into one
 - (firmware: imx: scu-irq: Add API to retrieve status of IRQ):
   - Rewrite doc of return error code
   - Rework imx_scu_irq_work_handler to use added imx_scu_irq_get_status
 - (dt-bindings: arm: imx: Documentation of the SC secvio driver):
   - Use reference of nvmem

Franck LENORMAND (5):
  firmware: imx: scu-seco: Add Secure Controller APIS
  firmware: imx: scu-irq: Add API to retrieve status of IRQ
  dt-bindings: firmware: imx-scu: Add SECVIO resource
  dt-bindings: arm: imx: Documentation of the SC secvio driver
  soc: imx8: Add the SC SECVIO driver

 .../bindings/arm/freescale/fsl,imx-sc-secvio.yaml  |  34 +
 drivers/firmware/imx/Makefile                      |   2 +-
 drivers/firmware/imx/imx-scu-irq.c                 |  48 +-
 drivers/firmware/imx/imx-scu.c                     |   8 +-
 drivers/firmware/imx/seco.c                        | 253 ++++++
 drivers/soc/imx/Kconfig                            |  10 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/secvio/Kconfig                     |  10 +
 drivers/soc/imx/secvio/Makefile                    |   3 +
 drivers/soc/imx/secvio/imx-secvio-audit.c          |  39 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c        | 379 +++++++++
 drivers/soc/imx/secvio/imx-secvio-sc-int.h         |  84 ++
 drivers/soc/imx/secvio/imx-secvio-sc.c             | 858 +++++++++++++++++++++
 include/dt-bindings/firmware/imx/rsrc.h            |   3 +-
 include/linux/firmware/imx/ipc.h                   |   1 +
 include/linux/firmware/imx/sci.h                   |   5 +
 include/linux/firmware/imx/svc/seco.h              |  73 ++
 include/soc/imx/imx-secvio-sc.h                    | 177 +++++
 18 files changed, 1970 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml
 create mode 100644 drivers/firmware/imx/seco.c
 create mode 100644 drivers/soc/imx/secvio/Kconfig
 create mode 100644 drivers/soc/imx/secvio/Makefile
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-audit.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc-int.h
 create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
 create mode 100644 include/linux/firmware/imx/svc/seco.h
 create mode 100644 include/soc/imx/imx-secvio-sc.h

-- 
2.7.4

