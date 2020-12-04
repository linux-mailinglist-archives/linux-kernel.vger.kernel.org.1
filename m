Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B352CE648
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgLDDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:11:43 -0500
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:45015
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726158AbgLDDLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:11:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d87Zn+RLeniGzE9iAm/owcuKigLmrH1U89gSss5SUOM1hlXPGW4pqwvyXRcrVotE2fvauZFAh7UqjRCM4BcdM4WYonNCDcCWPuEsuEfH8T1LJhKTxQthSwOUWSpOmrVFBh+kVwE0aYvQ0rGauVZgQRKuXyQMNr+se0MVExVYle0oPFS2PcEIilGlX1hgFwW6jzsY5SS588IAwy8qcqroyk812XjWVYDQ9v6OwVIK4h8yIKtfJdwwN8horpid2LKhQ8FkVsAsQzdwuWp/AjOhO0TN4HA9EvcWzon2R3JUSVBzYAkehuMNg4PvQ8EDvHbILJk2JhFkAkMo8paBF1Scbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkRJvVS1dMRkC1M6JQBCcDdjISwAAXObikRb4h2Q4K8=;
 b=L6pPdgt0DMdf+WT+FgtmCWRj65y7DO/ra/EZqHUl9whQu/Ydp7vPzwJ4e2NZeDMPc6+BQJ3dtFPLIjGvnbmBb/ePp4P3Ww2TzjGcv0ocyUUtUKjXotGksmBN1f6YRZccCB+hKcMm4wTNdp8sFCGD5vPnY8Wms7F5P+K6sWz5I28flzoSLUspcRuDxzkOgjpfFtlKYcRftX8/zzIAetD66rjDUsH4Oekjp3zl/QUPL6WiZMLjBjnvaqeutWmw5i/i8DZIiyKfeNGMMmaM8AE8FpXTXfPfE6dm0LcIavsv8YvsawtlTRmFfnf5v7gJbmZ0DcqGBdKEAQajNhJvsUSnIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GkRJvVS1dMRkC1M6JQBCcDdjISwAAXObikRb4h2Q4K8=;
 b=aZh9NxnambugqLYke9TWDueJgsGI5DqU6XlYy0S+1PdVFZeh4yILg2HIz2G82KkioVs2Bgf6iepb0WQ8Xki5BDye+GHRbAU/rmh/BI2olfepn0RvZIS9iq2AdY4Ay71QQMi9X2O6IoXMXKuXYn4oLv9bEYKAD21I4ya7P4tSt6w=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBAPR04MB7222.eurprd04.prod.outlook.com (2603:10a6:10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 03:10:54 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 03:10:54 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: Re: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWyK65Tl7g7x3iwk2r5HT7rmrh36nmRKWA
Date:   Fri, 4 Dec 2020 03:10:54 +0000
Message-ID: <20201204031022.GA13031@b29397-desktop>
References: <20201202132548.10736-1-pawell@cadence.com>
In-Reply-To: <20201202132548.10736-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fb431613-1d23-43cb-0dac-08d8980236bb
x-ms-traffictypediagnostic: DBAPR04MB7222:
x-microsoft-antispam-prvs: <DBAPR04MB7222317FA055C5934F7379768BF10@DBAPR04MB7222.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IJRJ9K5/jiImEcCY8LK/DGTT1Mrl0/JW5wV4g0JNX7+LJBmQcCwxDxJwse52OnP3pg9DowsZJhwgSewBorfr5cMw7EScoB05Ljhw2yLz2XfD+YusaF4YKkyouYRlRt0FIi+BqIWHP6NmKa4e4waVJwVPOvs7FKHzNfh13mAdUnhcs+Y4KizXbMllzU27eU3eOi+pWM4htUZ0ovhGnI6dGuLRvxkovVEmZlsk7X5kPNgBUP1+fQnh7PNB+HSI+NvvpIbF4sfkFOKFuDfOesDRm40k1xEOFtJxtaMdnITlkRcRHAtO70GuLFAfd/FU7cIhQaYU4mKDRWXjkJoQ9AQWPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(44832011)(33716001)(8936002)(5660300002)(66446008)(6486002)(54906003)(83380400001)(9686003)(186003)(26005)(6512007)(2906002)(4326008)(53546011)(478600001)(1076003)(6506007)(66946007)(33656002)(66476007)(316002)(91956017)(76116006)(6916009)(86362001)(64756008)(71200400001)(66556008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HXazvG7zVhnPqUm1E0TTLv6+gxia9brd0u++DgivrLOvAHmXGFXftKZEFkfL?=
 =?us-ascii?Q?gF450s992ND1qO9E8+osiTqn/24jWs9boMfAfUtaqPy/RUVnR/hzq7Yi1Sxp?=
 =?us-ascii?Q?EDCE5XRlJt0UaLoMufvYJgl+iP1E/bWExRvEM/pludxnbYaMyBe5JurLO770?=
 =?us-ascii?Q?pF5HCpBv6QQysBhNULIyCvbOOf7ADRskEzpqBlJzPs2KmHvcJmjHzgCY/LiA?=
 =?us-ascii?Q?Q4lsK28kVSg+GKY9tNRQOOhWhB6r/yIzPlQZBBscTFUu7NSyU7U2wVnnCWJ4?=
 =?us-ascii?Q?zdZcXCe2eHk0vCA/RmlpAnc/ESH58AWiIamgt1RNvMx/GzOxSME+mdDo4nCM?=
 =?us-ascii?Q?NZQmGtRJVAQLmBODVTabprIwUeaoCXQIJduTevGL9kiOseyL0KrDMznm6Zm6?=
 =?us-ascii?Q?KgoatthxZRlpK7mJ/ex8GDj2FTPSXJqkTW2dTbPujI38fFmLOvJZMNnCo7X5?=
 =?us-ascii?Q?HqKrWh9VLgDWU3og62hKbR8WZ7pv/s7YW73E4TDW5z8IQak0RJsmEb0JBMbM?=
 =?us-ascii?Q?095W4co442CkXhKEkqZF22icUnfKAPqTVW/ihi1ia1+3bZ4unsn8v4lsaeQn?=
 =?us-ascii?Q?hF9TipWmn6JRnkbBJ4hpmuxBNyHW5E8egXrHqsub/Sy6MPcFh97d4l5LKOer?=
 =?us-ascii?Q?yKIU6cnPszmJXeWKWLQzJ8SUf23J6xCvlf2g3mQ3fPZ1zTntWbvtDyHzf5x3?=
 =?us-ascii?Q?uWjuf0iZluLnTZA8VGNFLwMbqDTXXgVhmRBy5Rr/CqqjTdWa1iOpODUKW3HS?=
 =?us-ascii?Q?wVq4EQHy44DMN8EicXkoXJ+7DqIOsnMbiI3wnL9BrHgls5uxgOaLJGVulk3o?=
 =?us-ascii?Q?04qDPd5v91jV9ukSh7QQkv6CxU6FOxazNArXqidPgRBOnMHwm5bsYUS8dVdW?=
 =?us-ascii?Q?6Ia3nXOb/knKZFfKsuUELV/Vn6/dSVpPcXkgAi0lRcn3EfX9q1r0fFIU/Tzi?=
 =?us-ascii?Q?f46N0rg0tI/oQgWY618KwTn7e1RFOTz3urksQhoavSrS2bEqCRWuj0sBARqb?=
 =?us-ascii?Q?PDiI?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7C0AF38558E244095E43694A689CF72@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb431613-1d23-43cb-0dac-08d8980236bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2020 03:10:54.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWHSPyTcdnb9Dl4UJbuuv4/pt50qrwwelqKtO7Q/Z68LGpW0uCyJsTNnjlukmAGD+G1qquUkf6N8UXcoGOdz0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7222
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-02 14:25:38, Pawel Laszczak wrote:
> This patch introduce new Cadence USBSS DRD driver to linux kernel.
>=20
> The Cadence USBSS DRD Controller is a highly configurable IP Core which
> can be instantiated as Dual-Role Device (DRD), Peripheral Only and
> Host Only (XHCI)configurations.
>=20
> The current driver has been validated with FPGA burned. We have support
> for PCIe bus, which is used on FPGA prototyping.
>=20
> The host side of USBSS-DRD controller is compliance with XHCI
> specification, so it works with standard XHCI Linux driver.
>=20
> The device side of USBSS DRD controller is compliant with XHCI.
> The architecture for device side is almost the same as for host side,
> and most of the XHCI specification can be used to understand how
> this controller operates.
>=20
> This controller and driver support Full Speed, Hight Speed, Supper Speed
> and Supper Speed Plus USB protocol.
>=20
> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
> The last letter of this acronym means PLUS. The formal name of controller
> is USBSSP but it's to generic so I've decided to use CDNSP.
>=20
> The patch 1: adds support for DRD CDNSP.
> The patch 2: separates common code that can be reusable by cdnsp driver.
> The patch 3: moves reusable code to separate module.
> The patch 4: changes prefixes in reusable code from cdns3 to common cdns.
> The patch 5: adopts gadget_dev pointer in cdns structure to make possible=
=20
>              use it in both drivers.
> The patches 6-8: add the main part of driver and has been intentionally
>              split into 3 part. In my opinion such division should not
>              affect understanding and reviewing the driver, and cause tha=
t
>              main patch (7/8) is little smaller. Patch 6 introduces main
>              header file for driver, 7 is the main part that implements a=
ll
>              functionality of driver and 8 introduces tracepoints.
> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.

Hi Pawel,

You may need to fix below:


diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.=
c
index 04bccf6daaba..30d69b639492 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -4,7 +4,7 @@
  *
  * Copyright (C) 2018-2020 Cadence.
  * Copyright (C) 2017-2018 NXP
- * Copyright (C) 2019 Texas Instrumentsq
+ * Copyright (C) 2019 Texas Instruments
  *
  *
  * Author: Peter Chen <peter.chen@nxp.com>

 static int cdns3_plat_runtime_resume(struct device *dev)
 {
-	return cdns3_controller_resume(dev, PMSG_SUSPEND);
+	return cdns3_controller_resume(dev, PMSG_AUTO_RESUME);
 }
@@ -273,7 +273,14 @@ static int cdns3_plat_suspend(struct device *dev)
=20
 	cdns_suspend(cdns);
=20
-	return cdns3_controller_suspend(dev, PMSG_AUTO_SUSPEND);
+	return cdns3_controller_suspend(dev, PMSG_SUSPEND);

I am porting and testing your patches at NXP platforms.

Peter

>=20
> Changlog from v3:
> - added 'T' to MAINTAINERS file for CDNSP entry
> - updated common code with latest cdns3 fixes
>=20
> Changlog from v2:
> - removed not used pdev parameter from cdnsp_read/wite_64 functions
> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
> - fixed some typos
> - some other less important changes suggested by Peter Chen
>=20
> Changlog from v1:
> - updated common code to latest cdns3 driver
> - moved cdnsp driver files to cdns3 as sugested by Peter Chan
> - removed duplicate code from cdnsp_ep0_set_config function
> - added cdns3 prefixes to file related with USBSS driver
> - updated MAINTAINERS file
> - fixed issue with U1
> - fixed issue with L1
> - some less improtant changes sugested by Chunfeng Yun
> ---
>=20
> Pawel Laszczak (10):
>   usb: cdns3: Add support for DRD CDNSP
>   usb: cdns3: Split core.c into cdns3-plat and core.c file
>   usb: cdns3: Moves reusable code to separate module
>   usb: cdns3: Refactoring names in reusable code
>   usb: cdns3: Changed type of gadget_dev in cdns structure
>   usb: cdnsp: Device side header file for CDNSP driver
>   usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
>   usb: cdnsp: Add tracepoints for CDNSP driver
>   usb: cdns3: Change file names for cdns3 driver.
>   MAINTAINERS: add Cadence USBSSP DRD IP driver entry
>=20
>  MAINTAINERS                                   |    9 +
>  drivers/usb/Makefile                          |    2 +
>  drivers/usb/cdns3/Kconfig                     |   61 +-
>  drivers/usb/cdns3/Makefile                    |   30 +-
>  drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h}  |    0
>  drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c}      |    4 +-
>  .../usb/cdns3/{gadget.c =3D> cdns3-gadget.c}    |   28 +-
>  .../usb/cdns3/{gadget.h =3D> cdns3-gadget.h}    |    0
>  drivers/usb/cdns3/cdns3-imx.c                 |    2 +-
>  drivers/usb/cdns3/cdns3-plat.c                |  315 +++
>  drivers/usb/cdns3/{trace.c =3D> cdns3-trace.c}  |    2 +-
>  drivers/usb/cdns3/{trace.h =3D> cdns3-trace.h}  |    6 +-
>  drivers/usb/cdns3/cdnsp-debug.h               |  583 ++++
>  drivers/usb/cdns3/cdnsp-ep0.c                 |  495 ++++
>  drivers/usb/cdns3/cdnsp-gadget.c              | 2017 ++++++++++++++
>  drivers/usb/cdns3/cdnsp-gadget.h              | 1600 +++++++++++
>  drivers/usb/cdns3/cdnsp-mem.c                 | 1325 +++++++++
>  drivers/usb/cdns3/cdnsp-pci.c                 |  255 ++
>  drivers/usb/cdns3/cdnsp-ring.c                | 2439 +++++++++++++++++
>  drivers/usb/cdns3/cdnsp-trace.c               |   12 +
>  drivers/usb/cdns3/cdnsp-trace.h               |  840 ++++++
>  drivers/usb/cdns3/core.c                      |  455 +--
>  drivers/usb/cdns3/core.h                      |   54 +-
>  drivers/usb/cdns3/drd.c                       |  222 +-
>  drivers/usb/cdns3/drd.h                       |   94 +-
>  drivers/usb/cdns3/gadget-export.h             |   22 +-
>  drivers/usb/cdns3/host-export.h               |   13 +-
>  drivers/usb/cdns3/host.c                      |   22 +-
>  28 files changed, 10400 insertions(+), 507 deletions(-)
>  rename drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h} (100%)
>  rename drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c} (99%)
>  rename drivers/usb/cdns3/{gadget.c =3D> cdns3-gadget.c} (99%)
>  rename drivers/usb/cdns3/{gadget.h =3D> cdns3-gadget.h} (100%)
>  create mode 100644 drivers/usb/cdns3/cdns3-plat.c
>  rename drivers/usb/cdns3/{trace.c =3D> cdns3-trace.c} (89%)
>  rename drivers/usb/cdns3/{trace.h =3D> cdns3-trace.h} (99%)
>  create mode 100644 drivers/usb/cdns3/cdnsp-debug.h
>  create mode 100644 drivers/usb/cdns3/cdnsp-ep0.c
>  create mode 100644 drivers/usb/cdns3/cdnsp-gadget.c
>  create mode 100644 drivers/usb/cdns3/cdnsp-gadget.h
>  create mode 100644 drivers/usb/cdns3/cdnsp-mem.c
>  create mode 100644 drivers/usb/cdns3/cdnsp-pci.c
>  create mode 100644 drivers/usb/cdns3/cdnsp-ring.c
>  create mode 100644 drivers/usb/cdns3/cdnsp-trace.c
>  create mode 100644 drivers/usb/cdns3/cdnsp-trace.h
>=20
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
