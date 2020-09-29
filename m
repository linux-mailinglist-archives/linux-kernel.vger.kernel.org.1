Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D0927BB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 05:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgI2DYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 23:24:08 -0400
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:22497
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbgI2DYH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 23:24:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4LUkW1owbP4bJQtRFwnwlhRpb9xr0gQGvQzF1BwAvbkMXIcnooqJ5GiuQTW4mMlm6o1xCSWmJUNVvwpVVe2AWncWOy//L99pfFW+rIu4AGL8JvuohgyQHWiSVB41wb4rO+eUIBMBBTeePilq5odLpgklniCdnecRq5aDofJ5QlMUSrH4ALGs4rqT4Hn93Zd3z/q36mH5Tyb1HAzZid0zGG0PEvBNMB1rdNDBQRopHdOGg0TiDPXd6vpLvZsyhmnKMhpMCNr5jINmx35Upoj2DRgVQB7Nz39AL+iQD4Sf/fi47OsCQ4go8znZb3oO1bmXAxT80MXfpplGsko/NQBgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7i80600fXk5XGkDevaZha+JPHgPUuOTjKUWJ9ta7QM=;
 b=Nq5r/zWsnppKa5uXyVCSfJZGEHG4zm6SHPdNnWP0H4LS0AfbwHb9LNAPR7KbjhMGlreKghe2HFuntKFLo5URmE3lnaof6FZ9nnOiLMGQKw5oHkCpsXiQ/v38QXJj4GBXDRwICmiKM6wezMZYeYlP4XdmBYeTlD2yDhFreUZ/L/X/7sZyxXHLHoSI73WFzZ5QxCIerPHddBrR2hy1rbgC34K1wQDzqZUPQOUdDxwu5OWQnU/igqH+lqMt09f1eTA/CxsmrdQM8xJqx6bXkKEHMM759JT/mL2PgYvtvuwhFwqvJCnfVJaXMp+wydhKtb43N5Bb5TeiG2LtdUoA+3bzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7i80600fXk5XGkDevaZha+JPHgPUuOTjKUWJ9ta7QM=;
 b=I0df4GSveJtUPQcZ4Wmk0xVvJBQEzzwGeRPcrOUHU+gbkKhQZOf/qUnBkx3Y96Pl8vygP6wl0uQIEqbLX9yFyIomvhzaAm0fIYoFDNo5+SRM4kDNlkFUkEXn5hDTpR9hvhDF/eon30ixMQBRt4ghe60sko1BITd0ZQ36JuczrcM=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB6372.eurprd04.prod.outlook.com (2603:10a6:208:16b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Tue, 29 Sep
 2020 03:24:03 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77%7]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 03:24:03 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "chunfeng.yun@mediatek.com" <chunfeng.yun@mediatek.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>
Subject: Re: [PATCH 0/8] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH 0/8] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWlZOgx8QuRR8gQ06qRBCVZ4Wqcal+9IAA
Date:   Tue, 29 Sep 2020 03:24:03 +0000
Message-ID: <20200929032258.GA9076@b29397-desktop>
References: <20200928122741.17884-1-pawell@cadence.com>
In-Reply-To: <20200928122741.17884-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 569573c7-1c67-448e-aa52-08d864271d6e
x-ms-traffictypediagnostic: AM0PR04MB6372:
x-microsoft-antispam-prvs: <AM0PR04MB6372A2D28DC300C57BB8C8ED8B320@AM0PR04MB6372.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cdRN+iXGz1TclE9IzUAXZza002sVAL0USdmPZ5YCXyA4l9YrEyQf5Eaisalt2X8CPx0dumXPaM5SBESqgPrOuYbJdb/bCVEoGBfsJhqL0hff1OHmHEnGw7NHTAP5YjuG4QEbNcyWahtpbxGZlNdwQx6mH0zmw16AnlsTfZM5IaUu+F2zMhkopaCavnq5UgWQaTHShsCh4cvAoPjZVzCT5ur7PA/nVibHIzqkZvXSixFGDAJZdGmuavp1FYVN7DraqJtVW/WyjXO3maf8Pg8CK2EmkynK04ylIXzIScHZ2AZ8fVJ0KcSpaCvcvu9+QfDffkhy8SjUVwj5ELp8uc9mNpCPR290rp5NqX9Or2Ia2wlG8O5f/rRlWZtIl2xQybJd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(2906002)(86362001)(6916009)(44832011)(316002)(478600001)(6486002)(4326008)(9686003)(6506007)(53546011)(6512007)(83380400001)(33716001)(5660300002)(33656002)(8676002)(1076003)(7416002)(66556008)(76116006)(91956017)(8936002)(64756008)(66476007)(66446008)(66946007)(26005)(54906003)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Nn8kyRT3Zt+pKvzZXL/VF/hSTUOfJOH1imUFZdj+pcdc8hTDx3Pyje8rNtU8PkKMYo2IlZWrlUbF5JGvBVI5uAO56qHWQRyfcjKN+HFTAriNhQcB/FKRZqRe7o+bS1WNKLGGRFdJKAQx9UEL3oV5QVMbK9OHIhMpbk/FE+MSPw9o4y3AxEoOrgTxguUAQ80t82R5UIheWtB6QDBI3h1/y3X/zQ/mP2cFZv+UjzDxeO287BlN6rNbRqjvxJsJZKJkub+8dlPAlGUm2q/OWaOuTMHVcFEEQ1YZp4UDJ+tix8qpeAN1nDTdbqGjurvjqqPwmV/FCPRi9U7J/wyTsyaw0BG7MEszRTQIMndgZ+6G9et8p+Eaj+KDvAC17Rgo+z8q5KncTVPyLhj5tInKYKjlZG0pIGCko0t7nOgHkLUXzxguo5ytw6RHAQZEKS8QYjry4Fqj2d2sMrvxg2Yq2gcsWXESuUKjVKMJ0OYqVHRtxDozrBzVIpRkqykv/vanSiBNtJndLcr7tRMpgO+Pm1lF0LHoVKVNCJmt3664GzIvRW2OlVf+OmuLaMNvFvFzFFgedxEpw5che1VGQwpVsOuXASPCozG2D/Y0k8zkVuCsApiZI37rr85zh65BCkkr7GDOmF2aDcQovMufv55kzszBTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <40B5B350F1D5C04DB0B5F303587A7397@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 569573c7-1c67-448e-aa52-08d864271d6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2020 03:24:03.1646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ca+1IUl0X/v2Hx9mz5J+GzFN2srx1eu3j4VS7Q69qA0XW0EW7XjAqMwtE3oPFkiIAPn/aZocfrDoQfohvmCQ7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-28 14:27:33, Pawel Laszczak wrote:
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
> The host side of USBSS DRD controller is compliant with XHCI.

The device side?

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
> The patch 1: adds support for DRD CDNSP.=20
> The patch 2: separates common code that can be reusable by cdnsp driver.
> The patch 3: moves reusable code to separate module.
> The patch 4: changes prefixes in reusable code frome cdns3 to common cdns=
.
> The patch 5: adopts gadget_dev pointer in cdns structure to make possible=
=20
> 	     use it in both drivers.
> The patches 6-8: add the main part of driver and has been intentionally
>              split into 3 part. In my opinion such division should not
>              affect understanding and reviewing the driver, and cause tha=
t
>              main patch (7/8) is little smaller. Patch 6 introduces main
>              header file for driver, 7 is the main part that implements a=
ll
>              functionality of driver and 8 introduces tracepoints.
>=20
> ---
>=20
> Pawel Laszczak (7):
>   usb: cdns3: Add support for DRD CDNSP
>   usb: cdns3: Split core.c into cdns3-plat and core.c file
>   usb: cdns3: Moves reusable code to separate module
>   usb: cdns3: Refactoring names in reusable code
>   usb: cdns3: Changed type of gadget_dev in cdns structure
>   usb: cdnsp: Device side header file for CDNSP driver
>   usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver
>   usb: cdnsp: Add tracepoints for CDNSP driver
>=20
>  drivers/usb/Kconfig               |    1 +
>  drivers/usb/Makefile              |    1 +
>  drivers/usb/cdns3/Kconfig         |    8 +
>  drivers/usb/cdns3/Makefile        |    8 +-
>  drivers/usb/cdns3/cdns3-plat.c    |  209 +++
>  drivers/usb/cdns3/core.c          |  336 ++--
>  drivers/usb/cdns3/core.h          |   51 +-
>  drivers/usb/cdns3/drd.c           |  219 ++-
>  drivers/usb/cdns3/drd.h           |   93 +-
>  drivers/usb/cdns3/gadget-export.h |   26 +-
>  drivers/usb/cdns3/gadget.c        |   29 +-
>  drivers/usb/cdns3/host-export.h   |   10 +-
>  drivers/usb/cdns3/host.c          |   23 +-
>  drivers/usb/cdnsp/Kconfig         |   40 +
>  drivers/usb/cdnsp/Makefile        |   12 +
>  drivers/usb/cdnsp/cdnsp-pci.c     |  247 +++
>  drivers/usb/cdnsp/debug.h         |  583 +++++++
>  drivers/usb/cdnsp/ep0.c           |  500 ++++++
>  drivers/usb/cdnsp/gadget.c        | 2009 ++++++++++++++++++++++++
>  drivers/usb/cdnsp/gadget.h        | 1598 +++++++++++++++++++
>  drivers/usb/cdnsp/mem.c           | 1326 ++++++++++++++++
>  drivers/usb/cdnsp/ring.c          | 2426 +++++++++++++++++++++++++++++
>  drivers/usb/cdnsp/trace.c         |   12 +
>  drivers/usb/cdnsp/trace.h         |  840 ++++++++++
>  24 files changed, 10228 insertions(+), 379 deletions(-)
>  create mode 100644 drivers/usb/cdns3/cdns3-plat.c
>  create mode 100644 drivers/usb/cdnsp/Kconfig
>  create mode 100644 drivers/usb/cdnsp/Makefile
>  create mode 100644 drivers/usb/cdnsp/cdnsp-pci.c
>  create mode 100644 drivers/usb/cdnsp/debug.h
>  create mode 100644 drivers/usb/cdnsp/ep0.c
>  create mode 100644 drivers/usb/cdnsp/gadget.c
>  create mode 100644 drivers/usb/cdnsp/gadget.h
>  create mode 100644 drivers/usb/cdnsp/mem.c
>  create mode 100644 drivers/usb/cdnsp/ring.c
>  create mode 100644 drivers/usb/cdnsp/trace.c
>  create mode 100644 drivers/usb/cdnsp/trace.h
>=20
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
