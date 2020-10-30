Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EAFA2A01A2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgJ3Jkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:40:32 -0400
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:46944
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgJ3Jkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:40:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvv+7UgjOjh+H5siGf82g03Fguc4bLaB4Efi+6+T8ea23/WkM0iQkW2RiJlz0mrpsBshXSVS9sQRpNmjfKpbdcHlelGf5g9z26mW3wRdxInknCtXw6oWsS0dPi6sViMsiaWb4jmsnUSp71IhR0mpwgaDBucGzVjh8r/eqKukEr0xGIqZOfqP1ANV2+UHBq5y5WNdPB66yewTYn1xcWsb/T2a7sq8UUxnVEQK0GwwtXqKbJpOwKPSzvLrEKzjsU1Q8aoOnnLG6UXOgDX47RE/vWklrw43h50JKtpiL81U2xuXJ3Cg19PvMFGyopClUdZ3McxCVCgE7aGkluo4WJndjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAtAdVmH41r9WGYrD0CLU0kREfZemQC8qAXuSjzA/s8=;
 b=Qu5y2vtZ2kfRwey/HvVxL4ZKUHqoUrTSpkk2nwPVKi7omClXtUb7ZBZu7BRPDmJAEMlrvfc1RuRidtFuU64ImezUvlnDad/+FEyvLJEB9tnqgFlzhCvWeEppnO7rBxGAzfDVEWh5OOWu3GVbFENsA+ybCB6IJLi56ZcG4lpho4Lf/zjQg+IrCJ7dYNcne0JCUuFenPQbeTwLO2Am1Ev59JC8uqU9rPjSsOv5LPhSJjQATSXQiC4cFh/tgHsIhkC6A8BW1XGL4GWssAhcOFXWnbLrESf7VW+kFlUnn/nxZHN+2knFUeIAp5MUHGsolT2PKQCLA825XHdIH4oiPoMC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAtAdVmH41r9WGYrD0CLU0kREfZemQC8qAXuSjzA/s8=;
 b=HYfVgQgqrKPTTK1ErERrw6p3p66MZwYiWIp6d0BD59tdrTqYp+4xvcuJGITp2KAdGuVwRP+cH2LAs8I7MpSBurVTRuEVMgT7Qhi3Sg75guHEwlFWR6nEvgXTWLpDWPqBIjG+NVP/xqCARVByUVND8rztFrt/+A+PYPvespm/evI=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB5565.eurprd04.prod.outlook.com
 (2603:10a6:803:cd::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Fri, 30 Oct
 2020 09:40:27 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324%5]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 09:40:27 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/9] arm64: dts: ls2088ardb: add PHY nodes for the CS4340
 PHYs
Thread-Topic: [PATCH 5/9] arm64: dts: ls2088ardb: add PHY nodes for the CS4340
 PHYs
Thread-Index: AQHWkz9KW9hXanXbvUq7vxANMoo+Vqmve7IAgACfMoA=
Date:   Fri, 30 Oct 2020 09:40:27 +0000
Message-ID: <20201030094025.cudb2ezjaqxledt4@skbuf>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
 <20200925132503.30206-6-ioana.ciornei@nxp.com>
 <20201030001038.GU28755@dragon>
In-Reply-To: <20201030001038.GU28755@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c76ebc1e-c9d4-4696-1fb2-08d87cb7d5a3
x-ms-traffictypediagnostic: VI1PR04MB5565:
x-microsoft-antispam-prvs: <VI1PR04MB556580525BA8B9A34FB09885E0150@VI1PR04MB5565.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8CiojKFpzJCVT9U8Tz3TNz5iof6HADkyW0vJR3AXMlD0niyTCZgpWqXhw4CjTGemp/Af1vIibOK78nIVnV/wXbVJGSxyg2eHpLw+PT9Dq14earNQjRrVoT38L9897LJufbGwtTRQ5Txsv1o0wSLS6FElM5Pgo+0T0/Hs5UQIZSlDbbuFw+jztjRQma0CBUcHgOWrzeAwHzMOrM2K9I+6Gckq4RYPyPM+scZPPOXnvHDuXyn84rXQmnSxc6h+uJev10e3CJbg68OdY+NlWWajmITk8EUn6aNeAPX+VQuooxbrCCSh7KsnjOv9JraYIDjMyLO1vLoHSzCxf2xCLOqEUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(376002)(39850400004)(396003)(366004)(136003)(54906003)(8936002)(86362001)(66476007)(6916009)(6512007)(9686003)(6506007)(6486002)(1076003)(44832011)(66556008)(316002)(4326008)(66946007)(76116006)(64756008)(66446008)(186003)(26005)(5660300002)(71200400001)(91956017)(2906002)(478600001)(8676002)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7G9Par82EfxRMlGnyaUAF/ZkGwXW5sg/mXLoEfi43TYcduY0I33TbXf88XiOYNw2G6BtarbUpzsM/NNSRugM2y6aQDgNEU9jg8uKCKAAXuCSs6+6feDDfd74BI0/nWW+knZ1xMDvccXnRSb5cTWoqtLwEnn5FWrpUnDCu/djgZ1OKIH6FBMV3fZnkezEEyj9Axfafxk3vra9lUNOxGPQblktX2IiW/xDPu+rnulK6Aoa8vYFH9yPn0OoXzyMTdnvM/ldIi24hAdpTjd7ahamkUVUkq6ir+8RVKGo5FyYnkWkgtG3nLcwtjC7Db8A4hH4RJTzhGhKh+D7teQHHtCahr3HhzSDgeYCPghUq4KXvUnkq3wMkpYYjSSv6LsNFiZkJ8nDqbxVscuyJ2YZNZaQKR7AB4TYk4m2fXJp7nSAONVkin0F1LVgdG35F5M9eq9Xjezs5GOqPK0dhpxR8nyP/220hl6oaoNjUvBW4HsFGEjRD3GXQB3etbU1dA56rs1sIdLEAoB/6GgPBepONYFMW+Zbb2asbLm8oA3FWQDew1p7EXgQX4z/WrKlLw1rUnDAw92JZUSMD8fEgs04IZIWXVqlO0bMCfY8FdnvlUpZkSNkOVrHnKZlh4e3dppX4oFten5tEb/aIGs9aeGOCf0KZg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16C171C018D98D489F3EED2EF96AB6DA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76ebc1e-c9d4-4696-1fb2-08d87cb7d5a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 09:40:27.7522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IDrqfqLsIn240fM84eMtPBjMrwNLth4GKygWO8DXuf/5ht+O7iI2Ml7madbnuJF3YjRrZEWNuYzNmcloVJdLEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5565
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:10:38AM +0800, Shawn Guo wrote:
> On Fri, Sep 25, 2020 at 04:24:59PM +0300, Ioana Ciornei wrote:
> > Annotate the EMDIO1 node and describe the 4 10GBASER PHYs found on the
> > LS2088ARDB board. Also, add phy-handles for DPMACs 1-4 to their
> > associated PHY.
> >=20
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  .../boot/dts/freescale/fsl-ls2088a-rdb.dts    | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts b/arch/a=
rm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> > index f6b4d75a258b..0d1935fcd201 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls2088a-rdb.dts
> > @@ -22,3 +22,44 @@ chosen {
> >  		stdout-path =3D "serial1:115200n8";
> >  	};
> >  };
> > +
> > +&dpmac1 {
> > +	phy-handle =3D <&mdio1_phy1>;
> > +};
> > +
> > +&dpmac2 {
> > +	phy-handle =3D <&mdio1_phy2>;
> > +};
> > +
> > +&dpmac3 {
> > +	phy-handle =3D <&mdio1_phy3>;
> > +};
> > +
> > +&dpmac4 {
> > +	phy-handle =3D <&mdio1_phy4>;
> > +};
> > +
> > +&emdio1 {
> > +	status =3D "okay";
> > +
> > +	mdio1_phy1: emdio1_phy@1 {
> > +		compatible =3D "ethernet-phy-id13e5.1002";
> > +		reg =3D <0x10>;
> > +		phy-connection-type =3D "10gbase-r";
> > +	};
>=20
> Please have a newline between nodes.
>=20

Sure.=
