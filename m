Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4632CFB2A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 12:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgLELe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 06:34:57 -0500
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:41218
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbgLELcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 06:32:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxnreWs9w6wDJQ4Au8SBQ/B5RQAp+vzB8wHskOXHsj7vt7mlN5aBnwAMPbiW/LOC0yU9uuZN23lWTbCnHh+5hn8vTqgQ9SYllfEhC24DlwYk2vtkx1zYLMh6+QWxw3Ttw79HaNu98EzgjuTRaLSFEfkvwwNJZPmg0kAqMWJjwzYXiZ/vg7ArgWBMdSKL5qot2iW+DVTXyUsZOng57h8jlUcnv6I5IIHT1eqFAtpCLDGR7esXMcNiLQiVmlAKs1ksnAEw8HieSh1cnA4jMGWwWzwO5DiMI9H20yG7JiyJhF8EsgFQ4HJDvlfLcqA6Udongciyqgd/4FqFpadQs4WdlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIoG7lyQwsiCXVTef2Uz5jco2l8GmSedw4VQk/7+eN8=;
 b=ZNC1PpkqwDxU1onJ9k+NgZYjGo0rLJ4Hh7/cUUdx/74ED1vJfF+bwVD56kZBbAwPMAI6JrM1X2rymTphULgwEqmMb6UaxQZkms3/xvcKAlIp5AwMtPz6ZBDvI8T0Y46CrApnY8zd7rtuXCY1NpCdJUTd95K2FX7KTaYXTNOUC8o0SCypiJ7Ytn+ApIDCSDkavxatNOxOFEPvbloIyDb7DbHzCSJVNIEKo1iXAgCAU4RnkvY4+JmM2wW4ZAXOsxitNjPOKWyX+KFluM7304hBiuFqRfCP9ekAoI/M69oHuu3ffpc7auevw+6/yUCIq280PzyGaE25cnltzfxhHvVLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIoG7lyQwsiCXVTef2Uz5jco2l8GmSedw4VQk/7+eN8=;
 b=sZ7lkXN29Ngr2Vl2xXU4vuR3sglO6/6vKn7auErecPAhaILPOw5YgETB4NUTj7XgCd/l2Q6PhhTRCKMdM5W8qNJvnFJBWYGYzwg0X5DFQc9FO1GcVD1z0+ncNKI/2krpyHa5DfFiX8sbqs2Jch5NZzWw6MX2Py8aWktURQsCYGs=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Sat, 5 Dec
 2020 11:13:39 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3632.021; Sat, 5 Dec 2020
 11:13:38 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "rogerq@ti.com" <rogerq@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v4 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWyK65Tl7g7x3iwk2r5HT7rmrh36nmJI0wgAHc/QCAAFxSgA==
Date:   Sat, 5 Dec 2020 11:13:38 +0000
Message-ID: <20201205111309.GA27585@b29397-desktop>
References: <20201202132548.10736-1-pawell@cadence.com>
 <DBBPR04MB7979860970F8C89C648209EB8BF10@DBBPR04MB7979.eurprd04.prod.outlook.com>
 <f65eb2d5-7afb-788f-3ada-8fb529a0cfba@ti.com>
In-Reply-To: <f65eb2d5-7afb-788f-3ada-8fb529a0cfba@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7473c0d8-644d-443b-4809-08d8990ed119
x-ms-traffictypediagnostic: DB8PR04MB7179:
x-microsoft-antispam-prvs: <DB8PR04MB71793895F668737A8AEA20D58BF00@DB8PR04MB7179.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8YAyklVgwWczyHlaVTHNgdJg7HJxFMiclM89Sko/AaYjhsBhbwWTdDy5pcsERE2FC45ywZT3s5QZGIYxGlWAA+iBPPegDTxTzgFD4OCMqomYSasoJfmRBwDPCTK201cMDd4j5UxN1XrMs1qUkhWvR9f0BQp02+N785ou3yzN/NLN7TF4ywSGTWPwcJZGBNCMVjkRJZ5y+Fzsum5EGoiTuP6fdi6MlXQsapAlv93cwL/o84HkROE2iyDh3nJXVH/xqUUsoHklrsygaBttYW2yyFCU8uUiBo3inIPEQrBGvCOkiS1lEcLmeaC+bTBK8lfVNFlXQttWu8Uc1MLRk6HHHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(316002)(1076003)(53546011)(54906003)(5660300002)(8676002)(110136005)(86362001)(33716001)(83380400001)(7416002)(66946007)(26005)(2906002)(91956017)(76116006)(66556008)(66476007)(66446008)(4326008)(186003)(6486002)(71200400001)(44832011)(8936002)(6512007)(64756008)(6506007)(9686003)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SVrk9UoKwi69BxC6u/T3WjhPjp2gDz5cM0cJSPJ/xoUSWsIvpUOfNd0F4ks/?=
 =?us-ascii?Q?HN+fmXxnTsiwRXYmJ+GulHHl3vcWOh/tujbJj8XRaYnRBzEw/aQHFFsJ7/ZN?=
 =?us-ascii?Q?oVbns1/slSi/P1tTqFv151ug9up+8mcRElN+OgvkfRp3zgsTsWb+lyk0/GKX?=
 =?us-ascii?Q?FJ2O79iU59/BsXD0Wdeg9yDEDTdQ7s2gsYrPh/daIihX9YUKb3zUMroks6PI?=
 =?us-ascii?Q?ny4qvB3EmCLT1idnfuvH5JJDP776IrSW9sPUzH7A3b9KuvSq0jepsRSkuzg3?=
 =?us-ascii?Q?PixQZ2LdpgrJDt1W7wEBEKu4mtlXnaQF4ShgGi79cRdS0oelbypcrErgrdfQ?=
 =?us-ascii?Q?nmtvXOsUj+OZPT8mYrO35FJ7J+g6EqNj+vk4HkDPVTnWTd2JLSphPcruj7AW?=
 =?us-ascii?Q?osHcFYxh7YmrC2ejL+cZx6HoulR2ri8q6b3XYafiirRfm5Qeu9ZaftIi+FiZ?=
 =?us-ascii?Q?Kq5JqXM83yWJSE6riXYz3t63msAtICl4Up4VcjaXhZhNW2zaR3wc7Jqvht7o?=
 =?us-ascii?Q?tQTOS8741sfIrvX2y14YMvfdsHqYakFfbV8G22mnxnspvsq3jdQ5d7BKfMkt?=
 =?us-ascii?Q?XF/L6GRJJUeM0Tm2t9mUY2RksgNzZ1D9RfWTJq722tHEXHDj3xKPtPU5FvBs?=
 =?us-ascii?Q?bhIojNc968pKcHlB7C7v6ZiBfQLdcJIIeRdpp8dl1bHV244AxDRy7i7NldvQ?=
 =?us-ascii?Q?x4Fk0yPRRE1nHoDcN7JZ1Kk2vQxTAms8qzC11lHMGAfO2uzajASL/SlrF/Fo?=
 =?us-ascii?Q?0brRffpvBkejhJefzAq+SqoVqNP89LQLLgkSQ5YUaT68Qs1pj3sVpxJP2iNn?=
 =?us-ascii?Q?MCHdWMLlLy6wPH0vUjQsuidLzTBEpPr04OjT9Yhk0NFpDf2dhuqTpH5hYHQY?=
 =?us-ascii?Q?GO1tys+aiX04cEVmJZWtSEI0y1FYcHEjAE/onRiBuFVzrL1IVDcAjbEs9jtX?=
 =?us-ascii?Q?84ll0CVr9f3KF6zdRECQQVvPWwd7KRHBVtuVcSvP/as3UXjQQjcVPoBYVjpL?=
 =?us-ascii?Q?ilsL?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <613D09570AE08C49B028DE50400EFDBE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7473c0d8-644d-443b-4809-08d8990ed119
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2020 11:13:38.8895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PDiuK0+9ZBHZW+ffz0xNhxUlGoevzkNphzb5sYhmYZ7pqk3GKNN8hod2eEHR59DJ4YqdlSRFdrXhMGETEOeUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-05 11:12:44, Aswath Govindraju wrote:
> Hi,
> On 04/12/20 6:49 am, Peter Chen wrote:
> > =20
> >> This patch introduce new Cadence USBSS DRD driver to linux kernel.
> >>
> >> The Cadence USBSS DRD Controller is a highly configurable IP Core whic=
h can
> >> be instantiated as Dual-Role Device (DRD), Peripheral Only and Host On=
ly
> >> (XHCI)configurations.
> >>
> >> The current driver has been validated with FPGA burned. We have suppor=
t for
> >> PCIe bus, which is used on FPGA prototyping.
> >>
> >> The host side of USBSS-DRD controller is compliance with XHCI specific=
ation, so
> >> it works with standard XHCI Linux driver.
> >>
> >> The device side of USBSS DRD controller is compliant with XHCI.
> >> The architecture for device side is almost the same as for host side, =
and most
> >> of the XHCI specification can be used to understand how this controlle=
r
> >> operates.
> >>
> >> This controller and driver support Full Speed, Hight Speed, Supper Spe=
ed and
> >> Supper Speed Plus USB protocol.
> >>
> >> The prefix cdnsp used in driver has chosen by analogy to cdn3 driver.
> >> The last letter of this acronym means PLUS. The formal name of control=
ler is
> >> USBSSP but it's to generic so I've decided to use CDNSP.
> >>
> >> The patch 1: adds support for DRD CDNSP.
> >> The patch 2: separates common code that can be reusable by cdnsp drive=
r.
> >> The patch 3: moves reusable code to separate module.
> >> The patch 4: changes prefixes in reusable code from cdns3 to common cd=
ns.
> >> The patch 5: adopts gadget_dev pointer in cdns structure to make possi=
ble
> >>              use it in both drivers.
> >> The patches 6-8: add the main part of driver and has been intentionall=
y
> >>              split into 3 part. In my opinion such division should not
> >>              affect understanding and reviewing the driver, and cause =
that
> >>              main patch (7/8) is little smaller. Patch 6 introduces ma=
in
> >>              header file for driver, 7 is the main part that implement=
s all
> >>              functionality of driver and 8 introduces tracepoints.
> >> The patch 9: Adds cdns3 prefixes to files related with USBSS driver.
> >> the patch 10: Adds USBSSP DRD IP driver entry to MAINTAINERS file.
> >>
> >=20
> > Hi Roger & Sekhar,
> >=20
> > Would you please test this patch set and see if it works well at TI pla=
tforms?
> >=20
>=20
> Tested this patch series on TI SOC J7200. All given below tests were
> performed and they passed,
>=20
> Host mode:
>  - Connected a mass storage device (USB flash stick) and performed read
>        and write tests
>  - Connected mouse and keyboard to check enumeration
>=20
> Device mode:
>  - Tested g_mass_storage module by performing read and write
>  - Tested g_ether module by the pinging host and device from either sides
>=20
> OTG:
>  - Switching between host and device mode based on the device connected.
>=20
>=20
> Tested-by: Aswath Govindraju <a-govindraju@ti.com>

Thanks Aswath.

Basic functions at NXP also work. Pawel, you could post your v5 with my las=
t comments.

Peter
>=20
> Thanks,
> Aswath
>=20
> > Peter
> >=20
> >> Changlog from v3:
> >> - added 'T' to MAINTAINERS file for CDNSP entry
> >> - updated common code with latest cdns3 fixes
> >>
> >> Changlog from v2:
> >> - removed not used pdev parameter from cdnsp_read/wite_64 functions
> >> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
> >> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
> >> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
> >> - fixed some typos
> >> - some other less important changes suggested by Peter Chen
> >>
> >> Changlog from v1:
> >> - updated common code to latest cdns3 driver
> >> - moved cdnsp driver files to cdns3 as sugested by Peter Chan
> >> - removed duplicate code from cdnsp_ep0_set_config function
> >> - added cdns3 prefixes to file related with USBSS driver
> >> - updated MAINTAINERS file
> >> - fixed issue with U1
> >> - fixed issue with L1
> >> - some less improtant changes sugested by Chunfeng Yun
> >> ---
> >>
> >> Pawel Laszczak (10):
> >>   usb: cdns3: Add support for DRD CDNSP
> >>   usb: cdns3: Split core.c into cdns3-plat and core.c file
> >>   usb: cdns3: Moves reusable code to separate module
> >>   usb: cdns3: Refactoring names in reusable code
> >>   usb: cdns3: Changed type of gadget_dev in cdns structure
> >>   usb: cdnsp: Device side header file for CDNSP driver
> >>   usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
> >>   usb: cdnsp: Add tracepoints for CDNSP driver
> >>   usb: cdns3: Change file names for cdns3 driver.
> >>   MAINTAINERS: add Cadence USBSSP DRD IP driver entry
> >>
> >>  MAINTAINERS                                   |    9 +
> >>  drivers/usb/Makefile                          |    2 +
> >>  drivers/usb/cdns3/Kconfig                     |   61 +-
> >>  drivers/usb/cdns3/Makefile                    |   30 +-
> >>  drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h}  |    0
> >>  drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c}      |    4 +-
> >>  .../usb/cdns3/{gadget.c =3D> cdns3-gadget.c}    |   28 +-
> >>  .../usb/cdns3/{gadget.h =3D> cdns3-gadget.h}    |    0
> >>  drivers/usb/cdns3/cdns3-imx.c                 |    2 +-
> >>  drivers/usb/cdns3/cdns3-plat.c                |  315 +++
> >>  drivers/usb/cdns3/{trace.c =3D> cdns3-trace.c}  |    2 +-
> >>  drivers/usb/cdns3/{trace.h =3D> cdns3-trace.h}  |    6 +-
> >>  drivers/usb/cdns3/cdnsp-debug.h               |  583 ++++
> >>  drivers/usb/cdns3/cdnsp-ep0.c                 |  495 ++++
> >>  drivers/usb/cdns3/cdnsp-gadget.c              | 2017 ++++++++++++++
> >>  drivers/usb/cdns3/cdnsp-gadget.h              | 1600 +++++++++++
> >>  drivers/usb/cdns3/cdnsp-mem.c                 | 1325 +++++++++
> >>  drivers/usb/cdns3/cdnsp-pci.c                 |  255 ++
> >>  drivers/usb/cdns3/cdnsp-ring.c                | 2439
> >> +++++++++++++++++
> >>  drivers/usb/cdns3/cdnsp-trace.c               |   12 +
> >>  drivers/usb/cdns3/cdnsp-trace.h               |  840 ++++++
> >>  drivers/usb/cdns3/core.c                      |  455 +--
> >>  drivers/usb/cdns3/core.h                      |   54 +-
> >>  drivers/usb/cdns3/drd.c                       |  222 +-
> >>  drivers/usb/cdns3/drd.h                       |   94 +-
> >>  drivers/usb/cdns3/gadget-export.h             |   22 +-
> >>  drivers/usb/cdns3/host-export.h               |   13 +-
> >>  drivers/usb/cdns3/host.c                      |   22 +-
> >>  28 files changed, 10400 insertions(+), 507 deletions(-)  rename
> >> drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h} (100%)  rename
> >> drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c} (99%)  rename
> >> drivers/usb/cdns3/{gadget.c =3D> cdns3-gadget.c} (99%)  rename
> >> drivers/usb/cdns3/{gadget.h =3D> cdns3-gadget.h} (100%)  create mode 1=
00644
> >> drivers/usb/cdns3/cdns3-plat.c  rename drivers/usb/cdns3/{trace.c =3D>
> >> cdns3-trace.c} (89%)  rename drivers/usb/cdns3/{trace.h =3D> cdns3-tra=
ce.h}
> >> (99%)  create mode 100644 drivers/usb/cdns3/cdnsp-debug.h  create mode
> >> 100644 drivers/usb/cdns3/cdnsp-ep0.c  create mode 100644
> >> drivers/usb/cdns3/cdnsp-gadget.c  create mode 100644
> >> drivers/usb/cdns3/cdnsp-gadget.h  create mode 100644
> >> drivers/usb/cdns3/cdnsp-mem.c  create mode 100644
> >> drivers/usb/cdns3/cdnsp-pci.c  create mode 100644
> >> drivers/usb/cdns3/cdnsp-ring.c  create mode 100644
> >> drivers/usb/cdns3/cdnsp-trace.c  create mode 100644
> >> drivers/usb/cdns3/cdnsp-trace.h
> >>
> >> --
> >> 2.17.1
> >=20
>=20

--=20

Thanks,
Peter Chen=
