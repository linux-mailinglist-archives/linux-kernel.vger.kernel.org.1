Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0452C1F26
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 08:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgKXHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 02:50:59 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:60055
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730064AbgKXHu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 02:50:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SljKN778Yixfd7szKlpX7t5FNAnmmK71aWS94fxpVujJEMg17HO4zq/cGJXviWutd/q8G67JJvujKryofKbtAjM5ILyK/osO45uV6aZvOc7Qq99meJMbAe/ZlH31X4RdwUahXP/HjWmUz+wAoAbfNKMF0El2fHF3SMNTbn4dK2HgtfwtGHmX5sTWnl8wFdt65DTGldDB4EkR6iK6SMqKphk1/RbObFa72BMiNXBjkfcFMI54F8siI97sEiC2Ehj545C+m0ueCPn1+oh8sY8P+vQodY0OYczdUBdfiAo1ra0NXMcbJ6iEHRTlA5ohdK6JY03jr0aYJbV583fpKu0e0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH2T4AVqqTdJhNy8mZSoFOIRkN4OAczHNRyBNVSqciM=;
 b=bpfD88irT5PsXNth4UnnlQ6x838kYoK7wjeGMankIiUvYCw7YP3dNowtxKDs1TW3RU4+C0E7F7RkeVZzwmdNz9SMm8eCCBQ9KJp+VA00oFSQ66dS5UV7uHFgOVMynsHVZ0n4sKz+bHLX/1VNM1tZ9uI4+rCPhRTU5ZDtvsHAvMSrDluyrgxoyhxSHpMkVbydOv12oUhbyheECkNf1rpdwnAvL6lLUZ8Ba1Bsw5e46qxGb7pR3tGGwsKuRC2MpQxwlBWClk0HbkSaFAv8jk61cThvrc7fHmv6ALGnsAVa0XGWfRq1CTZo7Qfnk0g9jzMhnnBRVZwAgmTQusYwWe8Vyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH2T4AVqqTdJhNy8mZSoFOIRkN4OAczHNRyBNVSqciM=;
 b=nLTXh07VloWT6gy/sA0mUZcwyi8ohcc9KbOICU0kibPxWQXbuIFiSiisFhc3pyD53fX2Wq2bww3KkqHC/d0dca+LL6wnRup7MNf0nhi/IoUN0pB7vvZ3xmv+jrr4XiWHshNeC42MGwYcZS6fessUPcBDvBWYqNsJXz+upOzHrao=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB4489.eurprd04.prod.outlook.com (2603:10a6:5:35::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 07:50:53 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 07:50:53 +0000
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
Subject: Re: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH v3 00/10] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWvn5dJMNE6+//dE+JAvEKZI/EXanW7/CA
Date:   Tue, 24 Nov 2020 07:50:53 +0000
Message-ID: <20201124075023.GC32310@b29397-desktop>
References: <20201119141307.8342-1-pawell@cadence.com>
In-Reply-To: <20201119141307.8342-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9a1ab22-b178-4360-e9d6-08d8904dab5e
x-ms-traffictypediagnostic: DB7PR04MB4489:
x-microsoft-antispam-prvs: <DB7PR04MB448910CF23F109D32BB029058BFB0@DB7PR04MB4489.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QsMS+620ihI6SfqyFsfVT1/56u0EeclkQRErANyFj39TwjK8WASHN1mm25A06Ljg89zY/rs7BCHR6XTfRUL1n4CYRzvEF6DxHb6DwUQCitRFlGLFVWuqLj0MoQmB1k6CH026YxPYb7CZXHa9b14M2dNiGTbcfyOmQDoY2o5XOyz6eGVgAufimnQLAms3BqnbY3D7OmFsJ95L6GDZLaDU9FnizjlPtYOCwm42kcmdf1YHEucaNlCZC1Alfyu09pL3iZG+XXNt3AD9rSHTw7j31Na+VEin8DUgZNXsiK9eDEL3X/sG2UKLU3GB8YmEI9ZleMcxvCPuJggJ6EiiGlUhtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(6506007)(76116006)(91956017)(33716001)(83380400001)(53546011)(6916009)(66446008)(64756008)(66556008)(66946007)(66476007)(5660300002)(1076003)(2906002)(8676002)(8936002)(4326008)(316002)(6512007)(9686003)(86362001)(54906003)(33656002)(44832011)(186003)(71200400001)(478600001)(26005)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XClAShS4Pm/JVVUjuB5H5XYRYN4X+/m9Tcq2BtiMxicttAg0pcLvDFrjIQ2bMVTH5SDWypSxc8VecRftHkf3npih4l0p2MG8JN1+7ufYYJC72ROf2dWOId3Io/Yp06sr6ZHtBZGvt7dweAudP7h4tGFJHCSQbz063B/EXgZNaTBC/ZfGXFu7J4mp5eQRX49KPCaYSws5WDL19i9WB3hckil3XYKZk78L358DM1qETihBnFuLMNQCKqFg1RiR66U5j658JfH+h0libPIXGJrW5NE7MH+nmcgN4wZ3DQuL6yD2kPXDWoH6iC7K4SBCdQoIMNEjlrXW9LZ2pB58Gb2NoE8u2ZHgof+oYu2Z/pgN5vCejI5g1LdWMSweap0VQBbaH/konaYqg2EWQRIsn84+cyXJ2k1jr+YfaPC3iRe1Y84KmB5ia9qtmA3LkKX6pstxSwanWe4dJHBVE4lQm0Bz7dPJZWUT6QQBhRdvuXlBpYhMu3+M1XX1efrM8Rhwmustf6bItsrs9dRDCg/zaeYf+o4stM+mhPlV+e08m7VqYzhau+ECCX4WWL+7CiVRYywRnfZ6/aCBMmPN3R4m4HYMWnMUGTqNIVmGobPWjl+VgQmL3useCR9+5GMY6QY3CJnpYPuVi/k7dnz1KcE54wJS2jFE59nNWIaE5aszzGwhakp8hymYmyME0ewNT6JZVAPuxJ16qjYjZFla58b7YbkOz7fU8ClBBSC4GBq1yQD9jIblUi+0hb5HzK+WhLwgy+m1xaXGVs11O3IvWPOhybRZLmPkm4V4V14pzm9YrzT/jrSGTghhHnmRvLPRDK46bQumXso29pIapNZNU6t7z8AJk5OuMySqhiFXS+YyjrotxXHx/dPJc649KKMa+qrW7DdF3iTxnKNMMePybIH0j22Bhg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1EE7AA613568BB47AAAA927E77A63764@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a1ab22-b178-4360-e9d6-08d8904dab5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 07:50:53.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpwTsQK6O96EcwmSxnk3ENf52zCam2T+5iK+ImWYMAxIT/1317U7gHfdAHlwsRLqOFKzgyzgm6xwPkmoSnflMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4489
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-19 15:12:57, Pawel Laszczak wrote:
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
>=20
> Changlog from v2:
> - removed not used pdev parameter from cdnsp_read/wite_64 functions
> - fixed incorrect value assigned to CDNSP_ENDPOINTS_NUM (32 -> 31)
> - replaced some constant value with CDNSP_ENDPOINTS_NUM macro
> - replaced 'true' with '1' in bits description in cdnsp-gadget.h file
> - fixed some typos
> - some other less important changes suggested by Peter Chen

Hi Pawel,

I have updated my -next tree as the latest usb-next tree which v5.10-rc4
is included, would you please rebase my tree and send again, I could apply =
your
patches and test, if test could pass, I will apply it to my -next tree.
You don't need to rebase again since it is a huge patch set, will take some
efforts for rebase.

Peter
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
>  MAINTAINERS                                   |    8 +
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
>  drivers/usb/cdns3/core.c                      |  454 +--
>  drivers/usb/cdns3/core.h                      |   54 +-
>  drivers/usb/cdns3/drd.c                       |  222 +-
>  drivers/usb/cdns3/drd.h                       |   94 +-
>  drivers/usb/cdns3/gadget-export.h             |   22 +-
>  drivers/usb/cdns3/host-export.h               |   13 +-
>  drivers/usb/cdns3/host.c                      |   22 +-
>  28 files changed, 10398 insertions(+), 507 deletions(-)
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
