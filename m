Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5154E2C3773
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 04:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgKYDDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 22:03:51 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:33845
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728600AbgKYDDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 22:03:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWxTxXXzLyctPb4jZ9ysf4OWDNdkasD+S7QobKXF0yzBnxqZ6lHFTGNjWSYU3uEqqeAxidiDYy6JJMKpXOROPchjyG58SufpBFJ/lE/euWjeQgAUHz9B2iMBKqvjv3q99rfkgfFL7Sk96DkCtQWfIeNq9n1sCvJV25e9CbQa93rkMGh+xpyCPiyf4rWhOTdMTlcZsxcqt6uWIhGLfyhkC408wBJlwuTYJCZ7kIuUJ4TR6N+h2tDLmGZ4e5AH4LJp2d9qJVPJ5MNFiKbeKesQzA+tzdT55qtLRG1wUqXsfCcUhd7I/qFg9vsuSR4rhYsWSVA8FfrPwni1xOG1IEQ1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzXmXi74bk3yL92Hyw8aSqo1AVeT/LfvBUa+D0H5ZPU=;
 b=IDyrVhlPGKBZzpReh2EeSb2pOn1D88Z6y9tYpv3KleV1KUxSH0+fJp/hcyJQQTEmGptuWWd/ER+CVS3G+JENqXDxSakB9apOFil4Eu97oh+OkdJVJBQ6/ro6eMPtYHmncXwhx5AXmLnxtRo+cLNHOurwL/OrNZr6yNTPhdUsQpoZm/pGTHcbeyThJCFLFB+NueaQP9pI8vh/4IIOEgHCY/h6uW/W8IJyzkZxCl78K3z72hsNB9sqk4YwYv+ohkA5vCfPzJITBzVJAhsKKy0TFPVNRAF5ScaL/+1o9yXzb2D3luMEjx2sGqQByb6GUj54fpXLa2oJEU6PqDgd17nKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzXmXi74bk3yL92Hyw8aSqo1AVeT/LfvBUa+D0H5ZPU=;
 b=NZGWmKb98OpuaiXR9dg0ldS3EzXUleOo08gfEfBWBk+LrtAxSuFCY69xegaLJAaUj2OaMbZb/bzS8NRgxm9D6SvgBRUbYyEWur2R6fwx7GxwRQh3040Eeb94UMJddX85NM9aYpvWZNAw4w0jWzRLzFh4bAA5Jtf7BRawJJcznzo=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM5PR04MB2963.eurprd04.prod.outlook.com (2603:10a6:206:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 03:03:45 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3611.020; Wed, 25 Nov 2020
 03:03:45 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [PATCH] arm64: dts: freescale: sl28: correct MMC order
Thread-Topic: [PATCH] arm64: dts: freescale: sl28: correct MMC order
Thread-Index: AQHWwqfNwZd8Ms1zpUqxjekzopCYSqnYKOqA
Date:   Wed, 25 Nov 2020 03:03:45 +0000
Message-ID: <AM7PR04MB6885DC8A698471CCF3F8CD7FF8FA0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20201124212126.32218-1-michael@walle.cc>
In-Reply-To: <20201124212126.32218-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e8744eff-bf14-4a6e-f52f-08d890eeb949
x-ms-traffictypediagnostic: AM5PR04MB2963:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB29633756B42621DAD6F426C1F8FA0@AM5PR04MB2963.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEzi/wALZEEFX2DxXamsuvM3QC0iXsT4PPj2qGQeR397wmmLTxPEaoaUIetlMVzpr7Hj/5VvYzBkg5eATc0KhjXIJmNdU1x6DFocu4cWH84NxgxclgKpwnqRSOn7jB8vQbAvDnViPRqtnrXlj/4fkGoJNC3hZND5g+Q+UIEgjhwIsuAhKGsPgOwzPew88L51PRAw2gj7l8uc/OlQ96O/ASI+W+rHc5uQ4GGrxJtt1hJJqSepAprgVyn0dqA3xeJ1uWmREUmlcZOtxX0fZfO6Xmp6N9dz4RNsXlsnHmoqEYrhWJteNICFnX2RWHeeLYRO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(478600001)(55016002)(4326008)(8936002)(54906003)(71200400001)(9686003)(26005)(316002)(8676002)(2906002)(53546011)(7696005)(6506007)(110136005)(186003)(66446008)(33656002)(66946007)(52536014)(64756008)(5660300002)(66476007)(66556008)(83380400001)(86362001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jl4jPtw9xTjQ3iP8z5MGrFqlnulZhng4y8eSRGH23Zf1hvF2t6THR88RSiL98KVU8K9WAdBk1hDqz7XPTccG2Z6Y5yqO1xXrzp0lQIk43qBw7MciSSL3CTm8ZvdJDz0PUT3ZY6i707CXS3TzlNvSXXEMSj7MjAbFrsE+I9kd+0+jjyDFPZ7bSnj5bVd8clpaYK+MUOlLVlUoLhifKpkvUdKqqrcuFjXY3IyKG9dx0ag8dAgyimfMXQpcgnrCr1dxgaMElie0yKEyKUOyTwJ37EEIQ+Mj3egM4yPpXvSqhnC5Zq8eEtSO/2g+BI2QC7ijEq4yWX1uRcjpkC0oE30BlQc9sdYG7cpSDFe1255mbP4lqPWHWOYbj4D8iVbUd4UEe/p46FzGjd1T5q2Kzl43jMCnBBRc+p5SEXCIqRvUQlGeUntmoQeDFYuI0cDjrbGMCitCCYHV/xnN8WIEU9gkKuWFoBGNNtNTP4kG/ZI96Hs2i9KwBacifPqoKAIr4DYmUeWSSszfeYOrNi0KcYpQaieS2HtKeRi4TdHGO24spHmphT2YSB1auii+s/pFSY/79msovWw3Z7Pa4kNTsWlh/8QwUs7+yp0ZLRdxUgURcuxzVwxYXXuHpvb+M2Nc24BH0a9l203cHOcS7yiD3D9qYrgX7dy4tRcMoZSTAhfBA22VJvYzWmuA+mH0rahOGdpJNJ+BGi9fI11UUGsroXnJhnpmn7fLLsmBwLSrSMnBnMfpuNWIkXGpFOWSldMtuwcttyIB05TKl/iyvn2FoaQQlELpSFHWTlrHavgTp6T0sKjbbp4np3vsPyr1NO0RSeA4YjYRdKD17RkNQUPvxPPDFibt1GbHvjAwWoZDY+Ck7PmpY4zhB27KoGYCydlxgrtkuNrtHakD4KWwf0zI8V3OPg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8744eff-bf14-4a6e-f52f-08d890eeb949
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 03:03:45.6769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoMdFyNhT/U5fQkU6kSE7HZb5dmMRv8chNjf9kerjg/t+sdCDKZlUhms/igUUDw3OzqnosIQtBm0b4LQZEHmng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Wednesday, November 25, 2020 5:21 AM
> To: linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Rob
> Herring <robh+dt@kernel.org>; Y.b. Lu <yangbo.lu@nxp.com>; Vladimir
> Oltean <vladimir.oltean@nxp.com>; Michael Walle <michael@walle.cc>
> Subject: [PATCH] arm64: dts: freescale: sl28: correct MMC order
>=20
> Commit 342ab37ecaf8 ("arm64: dts: freescale: use fixed index mmcN for
> layerscape") hardcoded the order of the MMC devices. This doesn't fit
> the sl28 boards, which come with an onboard eMMC. Thus use the more
> natural order for the eMMC and SD card. Use /dev/mmcblk0 for the eMMC
> and /dev/mmcblk1 for the SD card which is removable by the user.
>=20
> Please note, that the images for this board already use root=3DUUID=3D,
> therefore the actual device number doesn't matter for booting.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>

It's ok for me to re-define mmc alias.
Reviewed-by: Yangbo Lu <yangbo.lu@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> index fbaecf285d05..6da4a28c4d19 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -18,6 +18,8 @@
>=20
>  	aliases {
>  		crypto =3D &crypto;
> +		mmc0 =3D &esdhc1;
> +		mmc1 =3D &esdhc;
>  		serial0 =3D &duart0;
>  		serial1 =3D &duart1;
>  		serial2 =3D &lpuart1;
> --
> 2.20.1

