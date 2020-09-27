Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561AA279F76
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 10:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgI0IDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 04:03:22 -0400
Received: from mail-am6eur05on2077.outbound.protection.outlook.com ([40.107.22.77]:3200
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726382AbgI0IDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 04:03:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO8v6JZf8ZV0rsfcmpsvrJWO+Bggyz5Yqv5p3g2evKjk1KhjCf4AUcX/DC9Ty3KHn4iOTN78RNSG+QoG6+f3n9zkwQoD62mAaDecwDbu3NL8R4oA5XrY2J5fU+lo8jcRfUzbQCpS5L1rNFS7PoXwdQwowsUaI8hurmO5EHE4pBBBtIcuMYZYq16xB1ys1bMGelLkTB3dNlY4EbViXE9qZzjZ0+vTb8Dk9B48zDlPTWuoBCQIu86XSHQVlzmrGKRdH8fVH6WWguWZu4gmgOLtdHmgZr979NwM8yL1fWbu12hUCl4YDkgVw8Giex1xt2UlmSmyN4AdvX0NPJ3n1oc2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsN76v1Cg/UlLC7gDrikpIY9+5W7OmegUVw+uqPskI0=;
 b=iIssr3lrwZynPdNJhMz9vLn1BWDXokzCDiknHpm9E5jx5vFiKhU+4pt5CozexYIOsmgPWRFpz5aVQm812iyCIyevFYS4WNtwaEJufii9V6xEOt55tS/I+55zSDSYnaMS+tBfJ9Cu56I3kOqWYqjpS7xIIfBUQPTPRiKRZcfSVQxAdVi8slbwlk44btKrzsb7RBFx0ceWc8qAZLM1SF+bZVw3pVoiodLIMwmfTIEFSVvcIbgUxW8isMNZaNrluBXHQR4S2+Lo18mkCb3j/2+4mktfFAqQRPGc9xfbGquyGrHSR51MEYuyFFnjmL9x8RGie8v171XrT5Jy4Uu6Ksmc9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsN76v1Cg/UlLC7gDrikpIY9+5W7OmegUVw+uqPskI0=;
 b=ZeRG7cNgRQhVY+OaFDsnagYzXrq5pgkh6St58LtXZ5UJ0qUD9QU4g9dVHhLnj8ykFcPoKuUiqg5QBsfXCp5iwq0wm9VtkURq3OVJ5cvj7AptCTMlMYFQActTxkTVJB9j0kqZTZGLI+gUOkkX0VFq639ZsAcyA+ApI/xH8knGuVY=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB4939.eurprd04.prod.outlook.com (2603:10a6:10:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Sun, 27 Sep
 2020 08:03:18 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.028; Sun, 27 Sep
 2020 08:03:18 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] ARM: imx: Add revision support for i.MX7ULP revision 2.2
Thread-Topic: [PATCH] ARM: imx: Add revision support for i.MX7ULP revision 2.2
Thread-Index: AQHWlJzTQ5h+Rst+Y0+1eZAW5tROvql8H/Ow
Date:   Sun, 27 Sep 2020 08:03:18 +0000
Message-ID: <DB6PR0402MB276099D878A3B082AE914A2388340@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1601190193-29074-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1601190193-29074-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ad342009-c7a9-4fa8-5fad-08d862bbcb6e
x-ms-traffictypediagnostic: DB7PR04MB4939:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB4939BCD15A040BDE0DC1CDCA88340@DB7PR04MB4939.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KzH3o6ZZMi10SKsVYT7or+/ABuZBOXDXRvCJyVXeenb7153HKs4W8R4zAz8MDnJBgB0mzH7co7Jsttbyg1ZO8gnqzHjB7MTyqBrr2pjCmTsqPClGmVKrL+ANtUjD2IxhlLYP1ANsAq2ZL0luRIy5Vu4GcCkSV7mASd+/x+e2VZIPH/6cjXzwOZMLAy7SJkQWH4jF6qHsqTvXvgIYP3Ymu0AYUBu1eIR1jhzh6FAZSC93YSg28cuqUTqQGl/zIqdcpg5yA7Vjx1ieXz00lXVzGtEsGWi02NyJhmJ0shLtLRxMNLH0sCwy0Krx6zv5piX0od55Mi+U2KGiW1xMBk7JxjRg22QN+4SRCxxuUuIbKPkmp6Qwz+5HJNjwnVWBebdL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(7696005)(8936002)(478600001)(9686003)(76116006)(316002)(186003)(33656002)(86362001)(64756008)(6506007)(26005)(66556008)(66476007)(4326008)(5660300002)(4744005)(66446008)(44832011)(66946007)(110136005)(71200400001)(8676002)(2906002)(52536014)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GWA0V08DItiY4gxej4gxj3q0xcX3aL6rO7ERfUCdxQCOa+WNoJ2jvYl9Z23UNEbhfsx6XJMmDdZmr3nhixz2OHgxkP4gZ4smpBvtRUQAhZXbYM2b593R92/ukHOcVBjp2XzeTA+ibDI3howuN1mT9VpWMFHcNNnaUBfdgzud63yUP2KMpXqreJ/+bjR/XtyhXBR7QWtL74dMYN5JxMuiHopLUU3srbkRFfr761P2ia2CnGQN7KjwUKY16nd5QdBsLJyDmJKx40PGNpjHXTvh6nnrMBkc7neSKbvOg+3Ha6GE3AOs7f2fjgioWU4B7MCxfiMnpMnJ5wV8rAXYhz7krt0II2GTyA2y9Vi8O5RsfXMdzWJyElo1wYLXaxOBAWTZSeEmj3g9/YY6bWVf71FSLpVyb75Lhnwwtag4/rSNm1PQf1ayEKeVruxnGRERXS1gm9uF7p1RVjb0BbRBV7GoXLvRworoWTlQvc1pSOIaIPpvuAjthJ2c4Ctc+LjXnI7KQS5Z6I8xCvFBnISBhzWwO2x/OXrW1VQs4YUGhjeVl0irV24YEHi2ug53Sv0/fDxkIKf3t1uAkwniLPmThEEivYCNw7BNsTyPnvezg+cmrFkHFujTsARpS68RdD/DCtpLgmMIhWnwJJtnqkQsw3xrjA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad342009-c7a9-4fa8-5fad-08d862bbcb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 08:03:18.2230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5ir2t9ajna8uzz+tG2s4AH1gBI+osQWqB4FdnVLIWVYljPBWpId5YOXAirieP8LbOVYhtGYAm3qbFoEGyz0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4939
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] ARM: imx: Add revision support for i.MX7ULP revision 2.2
>=20
> On i.MX7ULP revision 2.2, the value is 3, so add support for this revisio=
n,
> otherwise, it will use default revision of 1.0 which is incorrect.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/mach-imx7ulp.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/mach-imx/mach-imx7ulp.c
> b/arch/arm/mach-imx/mach-imx7ulp.c
> index 445256e..f6032ea 100644
> --- a/arch/arm/mach-imx/mach-imx7ulp.c
> +++ b/arch/arm/mach-imx/mach-imx7ulp.c
> @@ -45,6 +45,9 @@ static void __init imx7ulp_set_revision(void)
>  	case 2:
>  		imx_set_soc_revision(IMX_CHIP_REVISION_2_1);
>  		break;
> +	case 3:
> +		imx_set_soc_revision(IMX_CHIP_REVISION_2_2);
> +		break;
>  	default:
>  		imx_set_soc_revision(IMX_CHIP_REVISION_1_0);
>  		break;

Reviewed-by: Peng Fan <peng.fan@nxp.com>

> --
> 2.7.4

