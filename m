Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613092C361A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 02:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgKYBK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 20:10:26 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:32641
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726299AbgKYBKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 20:10:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHbSsa7Gt3lM4r2Jm/9G9023ZQ0bh5xclD5C2kG9RDpruczwtuHHgkY62KoNuXSUP877eBU4L3r7r39yNR5o+Ixb0stOwmKzme9ptfpMh7/2V+Tfo+9Eq6Dr/3nrh+G+tIp5BzGzp1YoZNRQbRFKiOx9+fvMgGrcXivlDnBcDEEzrEzpDhvAAkzthtn0yEjbAoqW0vPtuKyqrOyezFAT2BwUpv2gc841hyec7g/jWuyPdU+NIVo8ZdsRD270TCpzZ2jecH0acvC+YHPPM3e+0cHJh8zYeFHl07K8+LKrBL+u5M18IIHz9XLruqC8BpLbjVGmjTQpEblEATknaDVgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/A0yiZQu/solJsi1HfnAfgKpB7itYnl+sh1WAFMrh8=;
 b=nCzoCaAHkyJI/IHJd8pBInI3a0BR//rZ4Wsyn5n2MErDYz1BKxgBn7CRaCUVfCqRkgNj773IoTxdXiqtxpUaJMHqk4W0pXit8CBxGxdex9EOpWDpi/AhA3WXWqggCLaw+sXFzyb1jo0HH4I3CwgUkK4qKZObtKZziXdxe6WoJXbgpOhypSF4M+f4D8XlGmOIPiu+2uDsNN9/tdLk3zWekzwwr8IwI3ogkKvxRa7VCSBz3/KvsS2w8Ovbjf82Lx1gFrIGr8JmG1aDtC4nE04y6kvFp4xnPytPs8JSVV01GHZyogDwd+K3onPrtGqrOY/SmiyWo6wzwNXYEZg+8bNeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/A0yiZQu/solJsi1HfnAfgKpB7itYnl+sh1WAFMrh8=;
 b=isOr1ysR8EYric7wjqJQtY+1Rt5XD8yeimqFaOSsp/VKxTWCAesPSxLz4oJrDtPnXDW44UCHXajg0zWva4luaLmmF+JixWFW5p7ehBzWVM9zPDRKfsq8b68Pa8MmFw8G2GMX4OObfMya+FfxRfoohljN/4OG8qrbNBl3qIh2ogM=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Wed, 25 Nov
 2020 01:10:21 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3589.030; Wed, 25 Nov 2020
 01:10:20 +0000
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
Subject: Re: [PATCH v3 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver
 entry
Thread-Topic: [PATCH v3 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver
 entry
Thread-Index: AQHWvn5Vt5pGPfmZZEuhELc9+xqF56nYEl2A
Date:   Wed, 25 Nov 2020 01:10:20 +0000
Message-ID: <20201125010951.GC9929@b29397-desktop>
References: <20201119141307.8342-1-pawell@cadence.com>
 <20201119141307.8342-11-pawell@cadence.com>
In-Reply-To: <20201119141307.8342-11-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acdf2aa3-d743-4d65-1786-08d890dee14c
x-ms-traffictypediagnostic: DB8PR04MB7179:
x-microsoft-antispam-prvs: <DB8PR04MB71795910488A45D06625751F8BFA0@DB8PR04MB7179.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qG906w6Y+BJnCBLo2HirgnOUeSN3wh80T2MDObhgICYWQq9CmSTv3P5gdwWELkNhS2hd+8Azl/9qCOAXQ2X3FCCwHz/Dg/fNSM0ph5hM+GPO36not+aZ4kyW9P2phgcPfokehDDLvakHBuPebG2Ub4sQQ4I6glGtMu0KyZ++/UG0vWXF4/MXsnoJ1INZ14X4cU3ICQEo2dJwBIJl2zCyV6JdtFRXIWHleF26PCDB0aKz1vsGZNsaX0diAlkV011k0G73rvoPDO0XM7fhrmmWf6iCe1TjJUIBDpoXTmJWZYmBvI6KXEGxNciHig4FTehhcTtx82g8itfsZOL/eQ93g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(396003)(346002)(136003)(39850400004)(376002)(71200400001)(1076003)(316002)(6512007)(5660300002)(4326008)(9686003)(54906003)(4744005)(86362001)(8936002)(2906002)(8676002)(186003)(26005)(53546011)(33716001)(91956017)(6486002)(6506007)(66476007)(66556008)(66446008)(66946007)(76116006)(64756008)(33656002)(478600001)(6916009)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Z0W2o3HadPOG6am35nLtpqw8R2ppB12lSAVKVRPjGOkkIXmLzrUhRSD4aGzHKb26IXLMC3oAHLXZ+G17X/Q3l8Mm8S/umzOKBw2awBbE9Ec6vdrAWFovM/yy3U9a4sBeM6Y+Y4z5Evw0vuwIsE8jEiYrGBiGAO0+6AhH8apOqqTBWu7aJEcKjoJBy6eb85fhee9V71RZtcmu8QfOhOKABKw+6fD7MopPKZ8uT45psx5eo/tH6WC8A9Mf0lfIeqQuW5iFyyfTh4bx6MO8DX8KxaU4hZ3WoWscZsxy7AqcvZfsVYUyMGtrCVU9uEO1Nnx7uJpnoaNueMSRxsULRuHea4OY6kum2rhLZhNEMo0WzeKOvgVR1Fxvc/1a7aVSK6cRmlpyTPC0QKUoB6Ghw9oMPRwy+pRjZibQ5odsXaRv+n5tTEH2nEWRsIc3akuCXskFQq+IBJ1Y/O48JFQGUhuk2QF0X0CQCVd0TNbrh59cziruS4UYzERxnsr1c6k6bAG5a3tc3IqMGLZL0ONSE8OwrR/wStaI/zDHFVlzlVAH64TpFmTh8GFIetEy9WmLWMXe/ZCOwq/UQsGSRB7Dcxu6I4v6Pb99B0vzFuTE8bvwEbyIQKegDsSsChjjUxGPakv/VSZTRMBhUHlhYBxganOBWn/XwH9fKHQczkHnEo/vkRE/N0daOHF6/XJN7p1eL/Roghorn4I6ush6+YExQn7iEtmp0XGPKHdZU3Whr4SdXKc2l4YJYY6lBBw7Y0UePgJ3yKTG/pwy6iHqByVR0X3ZO1LLifZPijpvHWGrng14riGLetFRk7BsLTDFGODy7AEXVwTT3pvaP834+syGsyBHUycUqF18PdoHRrXaEq37hxnC75/nt4ItDx5XBsV+EGD5rdr+yxOChuIw9A1z04ZUyg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B017BB350754224DB03D7907AF7B1EB3@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdf2aa3-d743-4d65-1786-08d890dee14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 01:10:20.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qJK9ta5uU+8nTgmWNa6sTkwVT/rqJXYPk8B39GsmQs5i/TYIcasX4bI1xqUSOLkg8dEdkATx51n89pv0yo3a2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-19 15:13:07, Pawel Laszczak wrote:
> Patch adds entry for USBSSP (CDNSP) driver into MAINTARNERS file.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 842fef329119..70c31fd2cd61 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3867,6 +3867,14 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
>  F:	Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>  F:	drivers/usb/cdns3/
> +X:	drivers/usb/cdns3/cdnsp*
> +
> +CADENCE USBSSP DRD IP DRIVER
> +M:	Pawel Laszczak <pawell@cadence.com>
> +L:	linux-usb@vger.kernel.org
> +S:	Maintained
> +F:	drivers/usb/cdns3/
> +X:	drivers/usb/cdns3/cdns3*
> =20

Hi Pawel,

You may add "T" for which tree for cdns3 ssp driver.

--=20

Thanks,
Peter Chen=
