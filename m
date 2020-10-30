Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8192A0172
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgJ3Jcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:32:54 -0400
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:36334
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbgJ3Jcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:32:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UpfkUjVVmpQARQQTuijOkKNbbG7QOmikvaEuxPsHPEYksGysx2ZR7OtyjhQgjN0yE7qbYouO4keSlS3kAgtco33a3QeWyDNsk3fJqS1S367mc4KupAxP8OqwfIbFPxStj7eAQ92cQ3qXJt2s8P1+fB4VHGscPzZ+7O0PpVkQGkIpW1Zz58HeryprsMIzxB1sRxALeWFGErFvK4VEAKsYwqdtdR8oQ4JY7wT5l5HgWhLeAbNZqUyfsvzYB6WAo0TXHZ/1WwbBOROd7CARpHfJMvkZGhknxIrINsKcIbGiLdkE0fdgb54daJk+KmBRYufyrk0EVLeRLuqCTKkOC8nNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EugcXWRaqTdQh6oDDf/9HkKnQtf3ffY8nqcXIgBHhg=;
 b=exRq3Gqh8gH/eRLlwUo/uANrJYds9uDQc3nXvQql9mGLuAwZyYK5rZ0AjXoqsANy5WPzoP0LlelZZueYaSkMYbXJ6uj6Nd77Uia5hIBS+HtR2YrC5kX70KExkRNMuVRqt8y67cL1lgBK7mfb9yZbnlmGet2hJftEr8VTGcc7DG17zyq3FE6t41hNAv0Y0JOZaKsQpJhaMn4ZXmJYp8LDSqccQTiw2TiXF32jNx5wGBcL+ilCCsknGV+owL/n+q6rS62Eeww7Kr64Yw/rTXbyKky53oeSD+e6MAcriJpOM3gCGZ8f5lw0cozW9MV8p6ophLh2VbdPgV6Eu8XI8rQmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EugcXWRaqTdQh6oDDf/9HkKnQtf3ffY8nqcXIgBHhg=;
 b=kjZCZ39jQxHCS7Z4Gi7rPK0wN5mpnWHU4gksDhjPdj6UZaQPVnw59ujn7ZlC+hhYvPOkOtB3Mpz/CGL23Ccb85FIj91h5jsfiktYCNAVyq9dnGisHwrcNmSx7a6GrNLwHC0Ihi36w8I7kDRqQ+38HONo1XtQUdHlV6V1d5HH+2U=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR04MB7199.eurprd04.prod.outlook.com
 (2603:10a6:800:11d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 30 Oct
 2020 09:32:29 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324%5]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 09:32:29 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/9] arm64: dts: ls1088ardb: add QSGMII PHY nodes
Thread-Topic: [PATCH 2/9] arm64: dts: ls1088ardb: add QSGMII PHY nodes
Thread-Index: AQHWkz9K9Yuz4h4Kq0Kl0DjjHE9FKamves0AgACd3gA=
Date:   Fri, 30 Oct 2020 09:32:29 +0000
Message-ID: <20201030093228.4b7tvsa2vnam5nj2@skbuf>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
 <20200925132503.30206-3-ioana.ciornei@nxp.com>
 <20201030000725.GT28755@dragon>
In-Reply-To: <20201030000725.GT28755@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a928ba8-7529-4bf1-8680-08d87cb6b898
x-ms-traffictypediagnostic: VI1PR04MB7199:
x-microsoft-antispam-prvs: <VI1PR04MB7199C8D2B8308CDCE9FC6DA2E0150@VI1PR04MB7199.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtDA1fS93JltKbVEQLAu9s0DhLtzE43yLaHss/XoU8DclM4fNBXl3u8WTM1aJCaAYDw8aiP7ZAzlTF1LG3tKY/AsZPPqflyuGPPRWqW9w5ba8+w5TGCeyeXkaJuFONP7nObQqp64HzeLVDaPK96kuI6vfPd7Ci7JDqs6/YaICZFUyQkRPUYK/ZbvGZwBgHS1whlMddr704x1+b1ErEStxKQoRcUsRuKxBYfUyTcJyghs/Bs8uwNmxzOINIxozCOOP1zGvLZuiUyfbJnusvbVMGD1Ug6YKww0uAysz/66w48UyYQuddIsq1SX9tpSmhLP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(66476007)(33716001)(66446008)(64756008)(54906003)(66556008)(66946007)(6506007)(186003)(2906002)(9686003)(6486002)(6512007)(26005)(71200400001)(1076003)(91956017)(316002)(76116006)(86362001)(83380400001)(8936002)(5660300002)(8676002)(478600001)(6916009)(44832011)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rQ0XlusQ/WlD5rA4R0qDS1lzLZi4TvMgHwrATpWFGebE0KxoOEm1dyJiN/uvUf9YHgYL+fyYjk+5hO9TPXa2/heKs9bmGuJtOCaeKWJspysJUG/FSyfs4q0h9iUdUq5lQ6nIsb9AcQ73o7kj+GTBugJS7kIDVs7EzURaffc91ElNZuKnGlhNNBYyRTgj9gvpx6vc95acuhr4NUvej4gu+j0f4GLPYmbuMzkn1TSkIIG2RUWcTt5fRyJNOQB/VlLlOKM/K2T2JbP8aEVruCVx1GfZ6QIOwjcKj8ObTCQNysWxy17RXk+9GKfAyopfCwWyUJIDlvqxcYCjkfSQjhqkd9pLzOfoq9mzbndy5pxgnRcRiR5ly3lwagOo73JKxyZL33kBhrmR0xZbu02k9SKhGWn8EoLNVrGznmHuxpAVP4tiI0GTudoUb3/Xe73wGnmdJm4hjaSr1hIW51OGhRhhLsZdOxbuFFbiKj8dycGV1lXtjf6GqWPmnbgC+cE9rV4X8cDeshM8TcWEWdipXB8M/SbOfQFb/JFovRrLc2MzCXLIONnCp1cS8Lr/VJnpzWpdCRVZh0agWwA937Wshke7z6swf9PReyCSaFmqfXDl0mmkQWSlv0AZ2HiMRoidSpObsCRLG4MpwBkItxLIw8KScA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3435DA14E0A7D4AB02D16C720B8E99F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a928ba8-7529-4bf1-8680-08d87cb6b898
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 09:32:29.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eCdctMv6BKyZYIa04HrlaH5PyiSo481W1RpSFgPgVKU7xzWTGb20T6Y/JbgR7nkbiKu1ZklFKgixSO/anQQDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7199
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:07:26AM +0800, Shawn Guo wrote:
> On Fri, Sep 25, 2020 at 04:24:56PM +0300, Ioana Ciornei wrote:
> > Annotate the external MDIO1 node and describe the 8 QSGMII PHYs found o=
n
> > the LS1088ARDB board and add phy-handles for DPMACs 3-10 to its
> > associated PHY.  Also, add the internal PCS MDIO nodes for the internal
> > MDIO buses found on the LS1088A SoC along with their internal PCS PHY
> > and link the corresponding DPMAC to the PCS through the pcs-handle.
> >=20
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  .../boot/dts/freescale/fsl-ls1088a-rdb.dts    | 100 ++++++++++++++++++
> >  .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  50 +++++++++
> >  2 files changed, 150 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/a=
rm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> > index 5633e59febc3..d7886b084f7f 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> > @@ -17,6 +17,98 @@ / {
> >  	compatible =3D "fsl,ls1088a-rdb", "fsl,ls1088a";
> >  };

(...)

> > +&emdio1 {
> > +	status =3D "okay";
> > +
> > +	mdio1_phy1: emdio1_phy@1 {
>=20
> If this is an Ethernet PHY device, please use generic node name like
> 'ethernet-phy'.  Also the unit-address in node name should match 'reg'
> property.

Yes, it is. I'll rename them and use the reg as the unit-address.

(...)

> > +		pcs_mdio3: mdio@8c0f000 {
> > +			compatible =3D "fsl,fman-memac-mdio";
> > +			reg =3D <0x0 0x8c0f000 0x0 0x1000>;
> > +			little-endian;
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +			status =3D "disabled";
> > +
> > +			pcs3_0: pcs-phy@0 {
>=20
> ethernet-phy@0?
>=20

Will change.

Ioana=
