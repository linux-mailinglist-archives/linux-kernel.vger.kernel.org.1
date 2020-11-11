Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261C22AE70F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKKD3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:29:18 -0500
Received: from mail-eopbgr60051.outbound.protection.outlook.com ([40.107.6.51]:20197
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbgKKD3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:29:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpAlbOpFpH4N432hGsgmcjyD/xbhOpZTVff8Mhkse6mowZsigo/CiwBIpmblzTMitcKh0eVEzD1NTv3IVnprW6FkrjO8TGf3YmF18dND8pf682Q49r8t8vH2g5IwjWE2YdFqlXaHGONJZHYLIlUZ549TJavKZAIwooMfAKqD5mrska8P1Cyb19jJNjdxk/7KlMSWIbS1h3fBj2srbZPlIYDUjRlDRhTyG/f8ow58WuHIxo8AaO3IUwCAmrp/CWeaN2zt8fSASbbGBW/LYcNwtKdX2a1xXwBJqShb+pCc6tZEVFes90i0RPdPgklQQslprPu448pl/M/WoLXXyYrt4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq2zQXKT8LjrFKKfQpNX+9OC388sEuhEzPSYPA5fC6c=;
 b=Y+httvwU9A2FedkA0TJKmEx+Y/CLyM17qwqBqPtVSdfIHpp1K2nb2LPvhSS7c6Kg3DaWHWbO65i/qk04mHeYN/KXcIXBJ2ObIjvcb5eKz2KWCn//j/V+lHUyZksRHmnhKVasM/u+end4utvEjYH2xL/Q51rAbkcvjp5MfkhQdUelFdpIazRHVCFy1G1nnrkklZfM/lRaEqMblUtDvG+4T/1YiUXmmXkpLoMmaXmu1158CAQOKH1sgpjckB69QsIbPBPEPzFbGcTeS8nmZjrKnyr0OGOyqeQQNDYgkSyJyt1oLboofismi+HQhW7dKniasC3V4a2JMo7CEqw0cHShMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uq2zQXKT8LjrFKKfQpNX+9OC388sEuhEzPSYPA5fC6c=;
 b=R9AUrHRJMl8ob2BKjF+OjOrO3YvIRw1KUjjYZKWdLYJVfxDm0h0FPRivANbbh6IGUQHcyBBZiJGb41dRAzWJs/JjMCIJ8H4U7FteHhojDxwEAubk+HDENRAY8LSEEdo9MRny7TQC70weFrEknThTVqcfx++DYYye19siv22cT/U=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7657.eurprd04.prod.outlook.com (2603:10a6:10:1f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 03:28:41 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:28:41 +0000
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
Subject: Re: [PATCH v2 09/10] usb: cdns3: Change file names for cdns3 driver.
Thread-Topic: [PATCH v2 09/10] usb: cdns3: Change file names for cdns3 driver.
Thread-Index: AQHWtDI0vcPcH4LtkkOKjYNCALHfPKnCTPkA
Date:   Wed, 11 Nov 2020 03:28:41 +0000
Message-ID: <20201111032812.GE14896@b29397-desktop>
References: <20201106114300.1245-1-pawell@cadence.com>
 <20201106114300.1245-10-pawell@cadence.com>
In-Reply-To: <20201106114300.1245-10-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 631f44a5-47bb-49ac-4ae5-08d885f1e334
x-ms-traffictypediagnostic: DBBPR04MB7657:
x-microsoft-antispam-prvs: <DBBPR04MB7657FBAED34C49383DE46F8B8BE80@DBBPR04MB7657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:202;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UVkQpQ7V+fQYmLysbdgtLNCbHu4NKlYAzlQYUlexkViNsB6lx+qWy6VJQXAvUyE0FNEx5CZd9degQJ1G9dYm40w7cwkD74UTNZYhRep6xda91akkUVk6cH38Lhzu6U5qNeG6rxKMSPfAVCWPcU3bimD6g32MNYG4QBiuBapKfnvPV7G2K9MAs5fi41pvy7dh5wHkazESX7L0atlbJBM0JxD70owlMvqq0PXSNCA1ZfGAFsjj31lYP9RydmZP7Jpi7metJNJC3l/aZxzCkka0+HM/8Daby3rIm3DwKSwwwzAn63gPj8WsRV+RAyC7u38AWOU/z1XgfgLaiikiKreiTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(76116006)(66476007)(9686003)(6916009)(91956017)(6512007)(64756008)(53546011)(8676002)(33656002)(5660300002)(478600001)(66946007)(66556008)(186003)(66446008)(26005)(71200400001)(83380400001)(44832011)(6506007)(2906002)(33716001)(1076003)(86362001)(8936002)(316002)(54906003)(6486002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MaI1Qhv8ipHEYxR9jnSL3AjKjkN6Ke1ZJ0QrYuzpz8vvc5X+SX1YG1DzbRLQcuNTP7KHQFEzypg/t19uIGSpHpClz0oGUCGl+dinYY5Tv7NZxWUwoQv2lWBpndU67D1Z0RaSSkuOysmEkGTLMBTSfwjFayhjCSxm6daF4axlXAHac0MLcCfNwilW5xOLpXOdilXj8RD8baTnLEZLUtnrJSQBumgHsrEpagh2msoeTgl5Y3jYpSBiTglu9NvrwueWNwqSInVlQahbRLVb27nxYAZjuV98RoRrRd5LR14FN1AJfxZgwM5XrpPfLOzdAT9+DA2284PmBwUsRcA9AnTZdwrPMXPmL4wM31pDLJM9+hJ2o4aq1Gp+bsf4+vTPYJ507EpN0mazAWEiNqo+EtWJMBXbaQPXwLU6SSxWa4B02PoSSNgp2GaC3GV3FKqp1qe+L3aXDmXOXpO5873Hy8oxHjdgVEzrdX8sOkFRnMQr5ItXOInIs6dnehoJ/NxAlD6rvVc2R0s/5vmnKms9rnWRVxKDPMK0cqVzO/EylImJgkIX5qNF/ei80RLkvrWULjeuAFbqckUf/T70oxyaOQAzoWKXEUE07KKmfPikbMM7efIQ0X0dYzejLMJd4ytAGGm3OJAwB6mvdOVo4thXvvZpHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <946AF244701E0F4F85EA0F93667ABB4F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631f44a5-47bb-49ac-4ae5-08d885f1e334
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 03:28:41.7227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RGVzP9YWlJyQpvZB7IDb9a3HIic0OTCAskPafwWEh5ifNeY7fbxW+D+I7s+FWxdaCNcpHw3D0x1yWcMCgEMzkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-06 12:42:59, Pawel Laszczak wrote:
> Patch adds prefix cdns3- to all file names related only to
> cdsn3 driver.

%s/cdsn3/cdns3

Peter

>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/Makefile                     | 6 +++---
>  drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h}   | 0
>  drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c}       | 4 ++--
>  drivers/usb/cdns3/{gadget.c =3D> cdns3-gadget.c} | 4 ++--
>  drivers/usb/cdns3/{gadget.h =3D> cdns3-gadget.h} | 0
>  drivers/usb/cdns3/{trace.c =3D> cdns3-trace.c}   | 2 +-
>  drivers/usb/cdns3/{trace.h =3D> cdns3-trace.h}   | 6 +++---
>  7 files changed, 11 insertions(+), 11 deletions(-)
>  rename drivers/usb/cdns3/{debug.h =3D> cdns3-debug.h} (100%)
>  rename drivers/usb/cdns3/{ep0.c =3D> cdns3-ep0.c} (99%)
>  rename drivers/usb/cdns3/{gadget.c =3D> cdns3-gadget.c} (99%)
>  rename drivers/usb/cdns3/{gadget.h =3D> cdns3-gadget.h} (100%)
>  rename drivers/usb/cdns3/{trace.c =3D> cdns3-trace.c} (89%)
>  rename drivers/usb/cdns3/{trace.h =3D> cdns3-trace.h} (99%)
>=20
> diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
> index a4fdaabdbe18..01a9a9620044 100644
> --- a/drivers/usb/cdns3/Makefile
> +++ b/drivers/usb/cdns3/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # define_trace.h needs to know how to find our header
> -CFLAGS_trace.o					:=3D -I$(src)
> +CFLAGS_cdns3-trace.o				:=3D -I$(src)
>  CFLAGS_cdnsp-trace.o				:=3D -I$(src)
> =20
>  cdns-usb-common-y				:=3D core.o drd.o
> @@ -10,10 +10,10 @@ obj-$(CONFIG_USB_CDNS3)				+=3D cdns3.o
>  obj-$(CONFIG_USB_CDNS_SUPPORT)			+=3D cdns-usb-common.o
> =20
>  cdns-usb-common-$(CONFIG_USB_CDNS_HOST) 	+=3D host.o
> -cdns3-$(CONFIG_USB_CDNS3_GADGET)		+=3D gadget.o ep0.o
> +cdns3-$(CONFIG_USB_CDNS3_GADGET)		+=3D cdns3-gadget.o cdns3-ep0.o
> =20
>  ifneq ($(CONFIG_USB_CDNS3_GADGET),)
> -cdns3-$(CONFIG_TRACING)				+=3D trace.o
> +cdns3-$(CONFIG_TRACING)				+=3D cdns3-trace.o
>  endif
> =20
>  obj-$(CONFIG_USB_CDNS3_PCI_WRAP)		+=3D cdns3-pci-wrap.o
> diff --git a/drivers/usb/cdns3/debug.h b/drivers/usb/cdns3/cdns3-debug.h
> similarity index 100%
> rename from drivers/usb/cdns3/debug.h
> rename to drivers/usb/cdns3/cdns3-debug.h
> diff --git a/drivers/usb/cdns3/ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
> similarity index 99%
> rename from drivers/usb/cdns3/ep0.c
> rename to drivers/usb/cdns3/cdns3-ep0.c
> index d3121a32cc68..b0390fe9a396 100644
> --- a/drivers/usb/cdns3/ep0.c
> +++ b/drivers/usb/cdns3/cdns3-ep0.c
> @@ -13,8 +13,8 @@
>  #include <linux/usb/composite.h>
>  #include <linux/iopoll.h>
> =20
> -#include "gadget.h"
> -#include "trace.h"
> +#include "cdns3-gadget.h"
> +#include "cdns3-trace.h"
> =20
>  static struct usb_endpoint_descriptor cdns3_gadget_ep0_desc =3D {
>  	.bLength =3D USB_DT_ENDPOINT_SIZE,
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/cdns3-gadget.=
c
> similarity index 99%
> rename from drivers/usb/cdns3/gadget.c
> rename to drivers/usb/cdns3/cdns3-gadget.c
> index 9e0a82063873..d507a23c7047 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/cdns3-gadget.c
> @@ -63,8 +63,8 @@
> =20
>  #include "core.h"
>  #include "gadget-export.h"
> -#include "gadget.h"
> -#include "trace.h"
> +#include "cdns3-gadget.h"
> +#include "cdns3-trace.h"
>  #include "drd.h"
> =20
>  static int __cdns3_gadget_ep_queue(struct usb_ep *ep,
> diff --git a/drivers/usb/cdns3/gadget.h b/drivers/usb/cdns3/cdns3-gadget.=
h
> similarity index 100%
> rename from drivers/usb/cdns3/gadget.h
> rename to drivers/usb/cdns3/cdns3-gadget.h
> diff --git a/drivers/usb/cdns3/trace.c b/drivers/usb/cdns3/cdns3-trace.c
> similarity index 89%
> rename from drivers/usb/cdns3/trace.c
> rename to drivers/usb/cdns3/cdns3-trace.c
> index 459fa72d9c74..b9858acaef02 100644
> --- a/drivers/usb/cdns3/trace.c
> +++ b/drivers/usb/cdns3/cdns3-trace.c
> @@ -8,4 +8,4 @@
>   */
> =20
>  #define CREATE_TRACE_POINTS
> -#include "trace.h"
> +#include "cdns3-trace.h"
> diff --git a/drivers/usb/cdns3/trace.h b/drivers/usb/cdns3/cdns3-trace.h
> similarity index 99%
> rename from drivers/usb/cdns3/trace.h
> rename to drivers/usb/cdns3/cdns3-trace.h
> index 0a2a3269bfac..8648c7a7a9dd 100644
> --- a/drivers/usb/cdns3/trace.h
> +++ b/drivers/usb/cdns3/cdns3-trace.h
> @@ -19,8 +19,8 @@
>  #include <asm/byteorder.h>
>  #include <linux/usb/ch9.h>
>  #include "core.h"
> -#include "gadget.h"
> -#include "debug.h"
> +#include "cdns3-gadget.h"
> +#include "cdns3-debug.h"
> =20
>  #define CDNS3_MSG_MAX	500
> =20
> @@ -565,6 +565,6 @@ DEFINE_EVENT(cdns3_log_request_handled, cdns3_request=
_handled,
>  #define TRACE_INCLUDE_PATH .
> =20
>  #undef TRACE_INCLUDE_FILE
> -#define TRACE_INCLUDE_FILE trace
> +#define TRACE_INCLUDE_FILE cdns3-trace
> =20
>  #include <trace/define_trace.h>
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
