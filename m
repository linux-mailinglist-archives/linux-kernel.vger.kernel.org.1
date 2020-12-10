Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBD2D4F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 01:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgLJAj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 19:39:56 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:2690
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729354AbgLJAjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 19:39:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5yW846CTWjH0YehHh2WbX7ckGWT6kG939QEC797NpgfUMLXypRInDh2Yr3WTAD/GRk4j3rKMb7qLLtZeZ21jTrADTtDss1Hi+0StlZjN6PuG0KZCongDwdAa8LfJkrdnVCUs2zptYKYogKphAHu+ehUSLYdpkSLZPj0fv9ye51OqWtD4W2w1sqbFZI5YOu1hqxZsbXl2liKaA7fo4NXUHwZWwNlUIPyDAT6N0+AiHKwKXF+YRNVstXIqXbLCblQrizLdo7CwaEDjt5kb1d3t/zCquiXdQ0M6tnNu1G8pfH2tDwLGiEAk2mnle+AC7O/fdrjYsVNRxq/ckMq6QyMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uxyWHKSyCpVDZ2BWdpwhuf3DfKmFewk3sqr0aMHQhg=;
 b=TEJbh5ytfJV5x1AJhqzbC9eR4JNaGRH8FIGbDpwvwiOH5fIE0R1IDYZ7ndwg9i5stw67/8kc+sDs76CMxaJIOq3tO66qLT07Djw3m1LynHNgZuGg7BrYl1Q3TTThk8DhraWZnLfYrVRwecs0t7m0ju/ZIdw9qSm0eiebA2hpjssK6zSiz8caJLUAtjtm2qM9GP7Sm6ffjc0VVpexlKzt2h94Iuu6wB5Xb6e8l2KqDwXJrLhl5bvuawh5BuJ58OWr0bSkWTgcsjHHmQz9Fn/NX1F3d20fT9pJIoyb48BhFQutCRRuo8KSWQTYcwZLPWGU4nTUhQqqALnVfX7wgP9eGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9uxyWHKSyCpVDZ2BWdpwhuf3DfKmFewk3sqr0aMHQhg=;
 b=qPiH17sg1A4Mfr+5RUE1LVpGj5+ipaNvpPYTEzKGPperluezGgJHbAm2ZxzWh+eG+6HsQU7dxuqzB2y9Ls86zC991RIPOz9Pj8Ll5icy2j3TPEeBgd4Uq9B2Q48V1Fuh2tQvVzZKyvZGXcr5bxkqBz1NGppRin6ssDK+eBWFWjs=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7787.eurprd04.prod.outlook.com (2603:10a6:10:1e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Thu, 10 Dec
 2020 00:39:05 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3632.023; Thu, 10 Dec 2020
 00:39:05 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>
Subject: Re: [PATCH v5 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v5 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWzIV6F7b4cz4k60+SiLt/tGCHOKnvgIwA
Date:   Thu, 10 Dec 2020 00:39:05 +0000
Message-ID: <20201210003835.GA8047@b29397-desktop>
References: <20201207103227.606-1-pawell@cadence.com>
In-Reply-To: <20201207103227.606-1-pawell@cadence.com>
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
x-ms-office365-filtering-correlation-id: 768be27d-d06b-4149-6788-08d89ca3ff8e
x-ms-traffictypediagnostic: DBBPR04MB7787:
x-microsoft-antispam-prvs: <DBBPR04MB7787820407A8D0320AF7B55D8BCB0@DBBPR04MB7787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSkYuOJb/PSdaoy/HsQc1GFbTg9efS37BU6PjY5QsyJ0KQnu7yOse8rerFfkXYPOXBt5poB766NcoESj8vzVn+nka1nNMXR3LBSRkhWVMKVXDDr6nNEX8Jv7L6CxOCiELqjL77LO2WdT+E5XsoMDz+V9L/m4KQ56PD6ViTxT8AyHwfsqSRm3dIvaR+2iHhSelgMY04ccZjwZ65Sw/S6ZGRH6elhoe+qAFVP8AwQvUXbjOszTP1TxYPcOhR89B0YYKTgUbhDYJEa/qgO22uBxHsDX1CoNr9+qxg3afqV+H8NKHmus1KKGVfGjV3tLI7Cmd+cKkbjXARtQzRelGreVHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(366004)(346002)(136003)(66476007)(66556008)(83380400001)(8936002)(9686003)(33716001)(44832011)(6506007)(53546011)(7416002)(4326008)(66446008)(508600001)(6916009)(64756008)(2906002)(8676002)(5660300002)(66946007)(1076003)(76116006)(6512007)(186003)(91956017)(26005)(86362001)(6486002)(54906003)(71200400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IZ6UgRWc30ZPzmsFQDvcTasrfpGBpFsrWM5iRpCGIgczPaL51+mlYjxL/cp1?=
 =?us-ascii?Q?MuZyVCJuhlAJ/9IXIh38DN4CEHa/2hHoeE4BUhCSLr+OsMSb9wMaHPKXkbzm?=
 =?us-ascii?Q?msWuKIALjNnpH+PZ/UOPlY8nyg9gnfqqxPdbczp0K0NxBAZVOiUNSX4y85lq?=
 =?us-ascii?Q?Ru6soF6feb2KdNnq5wdcIfo87FsOjhPdgxM7uk2FcRYmh6diBClH2IqPCzrD?=
 =?us-ascii?Q?QV6cRKM/Jjk4oJZp7QWQpy2CYRhNz1SJQ6dJikesSypVWtO+WkTYySm0Vt/6?=
 =?us-ascii?Q?SdhBduE6DmOHpewAtO93DYvtDczXzDuwtHwdi+brOatAD+zS5A6k89RwptBz?=
 =?us-ascii?Q?Danm7P8QEvzTgB5TTLwU20sbUR75Gs9liv93Go3fOCMWSdlKD013whQuJthy?=
 =?us-ascii?Q?he9AG1izikBQnCVfDXi+er5vVelmBsSvFUhOvGtyNcaLKp9Av2iQmAT8YRMv?=
 =?us-ascii?Q?kFSPrvt8bg86/bhZnGnErQiLoejzWNUyo8YTj1eUjd3S7hqSOpdGI1N8z0vx?=
 =?us-ascii?Q?dFQo7H0qN3Lzkx1eFAscfsOFEDwTGf79D6Ao1gAQ/ywDob3KYRBtSxRRNy8I?=
 =?us-ascii?Q?BBt4GnEJTv4A4H4Jfx3855tEWqah05xABhYmjDHop5k7iSrmxvLrOR8BFx02?=
 =?us-ascii?Q?XUmtXyYx3Ij3Wngc7EeYldlwTsLAUKjHh9oPNTqWHYXHgexLlaKK+MYVkiF4?=
 =?us-ascii?Q?+652Y5LNJS8h0fHa/a1LNA8SMkik/1CNhn6VIzfKwV+he9luzRc1cq/Kc9wc?=
 =?us-ascii?Q?opOnUct7pxTVd0NMybE/b/FNVgf1PBG2vVT3GBYVn7JgWx0QtN+TcK4dnBDV?=
 =?us-ascii?Q?zx7aLJmjnXRgrKYJO/V64xTy+mqdFGQwJBk7jmJnRclNNqSTvSGav+aDTFUZ?=
 =?us-ascii?Q?JnBGu62YzN0w4Kw3TZ8z9XLx12zC+sNunDA/tQQWnzWx4wNA5ZOl5XMSSQLR?=
 =?us-ascii?Q?lfz/nTf8wijvLPWQQrH336YlJ+0cjwCT84BHz8okCY2O637wiyV9ZF1Bj8kb?=
 =?us-ascii?Q?aUZG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C920C79A2DF64246AD069541A3946B65@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768be27d-d06b-4149-6788-08d89ca3ff8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 00:39:05.2875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ATdQ0GRPxpxroQ+C3Vv/P1gFeX8iYM08yCiu9LIsgWzUR85OhTmzukFznvaxDHdPtGEI/ipEkKXSk1RkPWTCjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7787
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-07 11:32:17, Pawel Laszczak wrote:
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

Pawel, there are several issues are reported for this patch set after I add
it to my -next tree, and the merge windows is near. I drop this set for
v5.11-rc1, but keep it at my -next tree.

Peter
>=20
> Changlog from v4:
> - fixed bug in cdns3_plat_runtime_resume as suggested  by Peter Chen
> - fixed bug in cdns3_plat_suspend as suggested  by Peter Chen
> - some typos have been removed
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
> - moved cdnsp driver files to cdns3 as suggested  by Peter Chen
> - removed duplicate code from cdnsp_ep0_set_config function
> - added cdns3 prefixes to file related with USBSS driver
> - updated MAINTAINERS file
> - fixed issue with U1
> - fixed issue with L1
> - some less improtant changes suggested  by Chunfeng Yun
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
