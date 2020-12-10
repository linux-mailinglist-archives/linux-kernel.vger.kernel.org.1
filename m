Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D7F2D55A2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388172AbgLJItn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:49:43 -0500
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:48225
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726579AbgLJItm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:49:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5HrPJpLcUj+ddGqm3FkI0jFCAeY18iGkKmvImyGi0cF6qPzxsieqYvdsa8jUBmGNuPgOGd7hTQlcJfJEzgv7LmDvzkwhqoMJ3ADLE+rwVkj7FHZsn6P9vwcdCpRA7WzgbFJCSrRTDDyufZ2MjKblFfpnTxLrQ7ex9LRGlq+fYaG86jh9BPrErGTQUPXYIXWirrlCC4ZKwM0bs+iSbtGm9MKqsEWH1REEOiGJWsfmos6AImvBCf4zZK9mWd0vaV5ipYNezP4xJGBk2rMvjIgDESRXs7gyY4e1ZgM/5JZg1nVMkImyNnFvRhXns4WYTBi+5xiAs360YjDLecnDQ3uyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh6lKdaL+omggnsJMxkb7iA9DYMAMHU+pujDGaw2TwI=;
 b=DHyQYCo/kWg0C3BMo6JdSGe6bDPBF3ik+lLnot727A4TRh1f+do8hUutjLS//HsU62wGPW92oxMpeqEaBqJ497XCbCYdux/RStn3K3/d4nH5x9XrqXzo7VpKZ3ddHWuXlw/cmpLTHM9G49VkAFaoUsAeBe4FzrHP/KARQZ0eTdxAKSRJENhYTBckk3KcWFoRGmlHkCxEkoOAsGQa9ANIt+GxNXYoLNka1cGLk+DjYJ34QsRiHXAUuPCTKLFN30WciTRAgmmhosYaO0GtVhsldxvNXfFKSxB6GbUyyrGCWNTHeqfh4WZUZaaPGwysbHP7Zv0uDIogEu9E4lU+789Gaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qh6lKdaL+omggnsJMxkb7iA9DYMAMHU+pujDGaw2TwI=;
 b=Yr+/2BtMxGI0c8fkuTEFO2wR51j3HarvfdsV9ECPhVrFn8YPJqpGrudyS44NXVSL1G+o3bv8VhbNM0UeGTu7dXTBYQFD7lmA3iKml0CsoEjlanmHu11cgCle4qkiAfcMIDtvf/8VZbwADnSSSRTNHt9cjJVL5vnr+eyFMMmZ6SI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB6962.eurprd04.prod.outlook.com
 (2603:10a6:208:188::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 08:48:53 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6%8]) with mapi id 15.20.3654.013; Thu, 10 Dec 2020
 08:48:53 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v4 0/5] Add support of SECVIO from SNVS on iMX8q/x
Date:   Thu, 10 Dec 2020 09:48:45 +0100
Message-Id: <1607590130-11065-1-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [81.1.10.98]
X-ClientProxiedBy: AM0PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:208:be::45) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR04CA0104.eurprd04.prod.outlook.com (2603:10a6:208:be::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 08:48:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 728fc8fa-5bde-4804-946e-08d89ce86bf3
X-MS-TrafficTypeDiagnostic: AM0PR04MB6962:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB69625A75BE1F09A5D5F53179D3CB0@AM0PR04MB6962.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w5JKW9CF4DakXRPdBq9xrodyCom8e+pjNVccXiKMsm2EBf/y/0o8W1LWg/trpZkQhj27V7Ns/VeBJ+qg3LNWgXEtL8hrIAUVHykad2FdZSOwexa1Rkw3IdcsqU7Vk3c2cyIGaS1c37SjaLvPhP0tkKzsIr/Qc4grmXozL0M1keEwXk2gXYQsezqdLsgOdMO1DkOyzX70UXam6DDJSpnx1jeR5x5D4Tyct++f4Tc62q6iDjihNWNGhYq+/VJWMKSzf1Da0hdbOEapzW7dKvI3w4kvJoSkKTliJGVj29ZeVzkJOxtqc9yGfS5vMxvDv5vpPLsmOU0TavMRvzCwapU0wLmu9wxf8pUhXB9uFijgwHkBm9ZY8qSM3niT0Fw7zeJp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(39850400004)(136003)(376002)(366004)(26005)(478600001)(956004)(2616005)(9686003)(6666004)(6486002)(83380400001)(8936002)(2906002)(6512007)(8676002)(86362001)(186003)(66476007)(6506007)(66556008)(5660300002)(66946007)(316002)(4326008)(52116002)(16526019)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3+LJnDQMXavAQux4FLlVm0iXgxIciy3jvAxQN7NxPhFAwJ/kkMqewafqm7rg?=
 =?us-ascii?Q?khz+PsBPsaxsQqzv31Pwd6CxhU9duuVEQuykfteHQlnJwH1k+xPN6rk8MYEB?=
 =?us-ascii?Q?QZww1UsaNQnGa9w0bfzH12HtlXijoPyZkHmx9Rf2VMaw7VB7YC4XUy1I3t2k?=
 =?us-ascii?Q?4i12G8Adiap2P0KgbkiLJUxUaaQ40TiFslU0KEAO2VD5zr8otctOPicm/PQ3?=
 =?us-ascii?Q?vWOOPhp051+4YpcP7U3vh/XBAtKwh6t2o4ZOX+e8YTc28j2z5IM2BEp4m4lc?=
 =?us-ascii?Q?u1/D1MWD7TiU7Ns97I0KiYwJ6s7qOhpXhwOtxhqdJYomydoHOtMQkiRAEkED?=
 =?us-ascii?Q?oBh7//GWQMeZABEbCiHZxwrVCvgjHOhu3AKuIBnv4OAaFXE+/o+mfRqmCWSv?=
 =?us-ascii?Q?DTP3V4gK2EFrabXWefW5L+8juYj51YzWDb8Vr2vSM2plUyW14kuz1n8F5SlN?=
 =?us-ascii?Q?dndK8gNZmlgz9HedD0VbncMYxosSccyCVEwFFaWWcKsRVB44a6oIK1NhE6PW?=
 =?us-ascii?Q?UuGIK7wiAe2NG0sKnAZqY0WObGn/A1pgn4adizECSJvMOGcKEQqvdaXJSLcP?=
 =?us-ascii?Q?Cpgkll+HlJICszuaA5fhcM0oOXZurhHoNGSpZBX23cMxKQNYkqIqygala1s+?=
 =?us-ascii?Q?apYZXlzFSkre6i1MgSceM2WrpAl+MwH0wVXpf82uIvDN47CbkaCTFQpRLYZE?=
 =?us-ascii?Q?5+vHbHcGjiH2++QM6ZHttIjp0RXzPUzs3nr6+SZ+Ud1NnWEeA4DBFcpCtvxV?=
 =?us-ascii?Q?swIB2j8TKOo7HJ2onDiD0Sn9l8qRN/EpSuUPrpYNJwilXxU20Xz3SYVWlLst?=
 =?us-ascii?Q?1QNtO9k7PSt/scDUwktcpQZvsn88rfdXK63ijtdP9saTwyK23NPabOSElVpO?=
 =?us-ascii?Q?vJAy38FHzpEdAGEW0wQydIKBksANKt/b+TqwQxNO0H6JlL2yViExUEaaXbca?=
 =?us-ascii?Q?UH7gmjjqycLMUB9gD3Lu4axS7LCC2c+AQwgA04p1jPg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:48:52.9326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 728fc8fa-5bde-4804-946e-08d89ce86bf3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/+cBgwAqoRpd6cZNRZrMpfkKtSByAg63FYHUCFY8ZIXAGo0tZGbkifjNL3kPcey1UMVvn+Zc1Hwtwajf4tLx/QqY4ju6bgomr5CZCKrBx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962
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

v4: Fix build warning raised by kernel test robot
 - (soc: imx8: Add the SC SECVIO driver)
   - Remove unused variable "data" in int_imx_secvio_sc_disable_irq()
   - Place "static" keyword before const
   - Add include of internal header to imx-secvio-audit.c for proper definition
     of report_to_audit_notify

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
 drivers/soc/imx/secvio/imx-secvio-audit.c          |  40 +
 drivers/soc/imx/secvio/imx-secvio-debugfs.c        | 379 +++++++++
 drivers/soc/imx/secvio/imx-secvio-sc-int.h         |  84 ++
 drivers/soc/imx/secvio/imx-secvio-sc.c             | 855 +++++++++++++++++++++
 include/dt-bindings/firmware/imx/rsrc.h            |   3 +-
 include/linux/firmware/imx/ipc.h                   |   1 +
 include/linux/firmware/imx/sci.h                   |   5 +
 include/linux/firmware/imx/svc/seco.h              |  73 ++
 include/soc/imx/imx-secvio-sc.h                    | 177 +++++
 18 files changed, 1968 insertions(+), 18 deletions(-)
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

