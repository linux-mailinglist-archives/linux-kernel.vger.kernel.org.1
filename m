Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECCD2A0091
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgJ3I7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:59:21 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:47237
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbgJ3I7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:59:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8IGURgIvRKqscNKtA5vGS8Opd+ovmwNm7HbDDYyXpzbCT4eqyu2dfE2of5c/fff8WmoZlRa3NtiYour8umzpuu5OAi37BCphtxigTNszp4QYigSmgllLFInqptgCloiVxdnaRereI9EPmlk8XdGBWg6Xc6mn4DwxbcKaZhIgh9KvFRdmkOrO8qGBeTp6EdIuzJLQ3CYcEP9RdEJZXophRITdpIf/g6S/Umit9BwRvhuC/1EMb0gN17mRwwp9PFGjwDgUEZ9dxaE79EXy8/+CjyUeTF4zM3IBiddQ2ZNCqbrl3mrGHrE+d60dycxAbQaQlnyK/8wQzXBVFUlSGNnzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muZUuHlAMkEqmlIqUKILVMV+EHun4VdVAHffLOcr+rA=;
 b=S7j0P+eXymo3fcfr46OfDaVEb/Ns6BK5ATJwaxl3tk5E9lnvPEU5sQbi8IJKDxyvENlanQ57rctIuy9iXJ7HC5P9jNbyChAFtw63SvQLKu8Dw9kQpqJ+tZxBhl5UbfC3aGmACYnpKf3Fvd+EapsejblrMUZzfkIRjZu2kX38efgojOkdjUKdl6g4vIT/a335opIZ9ve9xHP1MIJ9gaobBKKNkhAdrV3E1oezQghYGkc1ZopMFZZ18UkZlbWuE9bodVylKd/lTR2Tqd+5sXCnQbRdTMrq3hLh/Z084xB9MmN10Lyt+bpm7A5dutsEpKioUaF8beh6ahVvCGFz1p5KTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muZUuHlAMkEqmlIqUKILVMV+EHun4VdVAHffLOcr+rA=;
 b=TztTipx3dU9nLRCbIcQFwHd+Nnp4si47ghoPJapd7tHH/1fEpq8eHS//r2igjVm8bsg3ZrFH/u1C+P9dtasgMqN05eUTvd1dk+GQJAtqpyvChmPf78a2el6ARECaUZX0hp3LRTCUI0rYOI8lrABilHwO6GvAJF+n3SIO3iiPEA0=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AS8PR04MB7606.eurprd04.prod.outlook.com (2603:10a6:20b:23e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 30 Oct
 2020 08:59:10 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 08:59:10 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
 lx2162aqds board
Thread-Topic: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
 lx2162aqds board
Thread-Index: AQHWlkeuodA6cP2CUE+mv343XFniRamev/QwgArj8QCAAHohgIAF5pBw
Date:   Fri, 30 Oct 2020 08:59:10 +0000
Message-ID: <AM7PR04MB6885349E64FD6DF77C1A8F938E150@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
 <AM7PR04MB6885980FC5B035B955D009BA8E1E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <20201026071839.GE9880@dragon>
 <VE1PR04MB66876F05E9988139C03294498F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB66876F05E9988139C03294498F190@VE1PR04MB6687.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [103.108.4.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01ff6662-a4d7-4c0c-6abb-08d87cb21102
x-ms-traffictypediagnostic: AS8PR04MB7606:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB7606092C1A7D50F61FC072AF8E150@AS8PR04MB7606.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Za2IqAb2bg23PXqTJe+mUMo8dp+YWQDEtZilTsUbhn8WP5a6D7uCQOEQKIibT355J9+LkyL0BXXAXQmaIpw5HZWJRIv9Wen4YJZyPuVitMKbXigT6Ue4xLQ492u95gst/URi+PDhBXXKjMhISsEXyjIkBfHtHuQFN/mWpstSnVWKqSrGkqV5426NSW5pfyc+zTcnwBRduIW0kXQRMuf3Rth5KaQwzUbD4wieLwUwiFKk2aFCKKZcPURN4rKwMfJ2wXrSkWLSmm9OxqpTZqCqgGmRh4alvIsJRPfuXajEegu4a0czc1fe30a+3uXWDJBB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(110136005)(44832011)(26005)(66946007)(83380400001)(2906002)(66446008)(54906003)(66476007)(52536014)(7696005)(66556008)(186003)(71200400001)(9686003)(55016002)(64756008)(6506007)(53546011)(316002)(478600001)(33656002)(5660300002)(76116006)(8676002)(8936002)(4326008)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: kFGNiJ+wA1lkSLBuXYOvmIbqtNju3f4hGRSydjN15rY1EYKjJDciwjrHcme7XZjc4D11XyDKQUAWrNy1TsT5k5lAoGbJgIuqmhBSCn4XGPbrHWmw2dKGftl4FrVSkaNLokOqSg03VJ7l8sRQjKBsiObfpHFTJL2sqIWI7Y/TXzYRKGYyFAE9+ubwOOtLuUq4jxrAOAUN2gqKDd/D+9Z3c5E8fPKb3EcKg3t2FWvpqgfWp54Ze2WUp9J4IZ8PxjWn4Pai1N/9vagK6Uu5TR7OOA1DKCkLx25jBdmGFk3NcI8eD6dR80qv8yFHWqBuEiev+CKp6eHLQqj9JMIGI/G3kb6ocDPwWNuBBvmbM7WOPWymWD+oONxkS3yGbB7fKuyLItU4lMp7Twoa/7VbBKimRdDLbbwVFwrsr25TP8WTX5nDpfd3d4Nse2fRNQeJYGnx9rEyvGUXzVGFF86tJ5fmmVYwm4wvidyHn09VM98u4IC4hSIHLNFH30ggC7PJoC19qhkf3WqK7Xz6iemJ9pC2I8XktlkN4SAIj00VtwsByQQCgCI9PauPZNDGMr6S005UIAEdLpfsZX47fn6B8IoCZXYQkyX+7yZ0pRghdbTVvC8OYsLiDDISha/mjIXLmkVTh2uygEwPW7CDZ0WSMOfnVw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ff6662-a4d7-4c0c-6abb-08d87cb21102
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 08:59:10.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6KVBaAhcmB1EgKVHOzwHyuaYAbOGSr1XfFG6tPrJhX00/hKOIePwewdmWpbLiZafANU4EwOK2T8g8uj5uyDXINw/OcCTh6dThhEs6x8Tyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7606
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

I will document "nxp,lx2162a-qds".
For ethernet string, documentation seems correct.

Thanks,
Meenakshi
> -----Original Message-----
> From: Leo Li <leoyang.li@nxp.com>
> Sent: Monday, October 26, 2020 8:06 PM
> To: Shawn Guo <shawnguo@kernel.org>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>
> Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Ioana Ciornei <ioana.ciornei@nxp.com>; Kuldeep Si=
ngh
> <kuldeep.singh@nxp.com>
> Subject: RE: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for lx21=
62aqds
> board
>=20
>=20
>=20
> > -----Original Message-----
> > From: Shawn Guo <shawnguo@kernel.org>
> > Sent: Monday, October 26, 2020 2:19 AM
> > To: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> > Cc: robh+dt@kernel.org; Varun Sethi <V.Sethi@nxp.com>; Leo Li
> > <leoyang.li@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Ioana
> > Ciornei <ioana.ciornei@nxp.com>; Kuldeep Singh <kuldeep.singh@nxp.com>
> > Subject: Re: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
> > lx2162aqds board
> >
> > On Mon, Oct 19, 2020 at 09:00:33AM +0000, Meenakshi Aggarwal wrote:
> > > Hi,
> > >
> > > Any further comments?
> >
> > Please address the following checkpatch warnings.
> >
> > WARNING: DT compatible string "nxp,lx2162a-qds" appears un-documented
> > -- check ./Documentation/devicetree/bindings/
> > #49: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:13:
> > +	compatible =3D "nxp,lx2162a-qds", "fsl,lx2160a";
> >
> > WARNING: DT compatible string "ethernet-phy-id001c.c916" appears un-
> > documented -- check ./Documentation/devicetree/bindings/
> > #80: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:44:
> > +				compatible =3D "ethernet-phy-id001c.c916";
>=20
> Interesting that it doesn't match the following in
> Documentation/devicetree/bindings/net/ethernet-phy.yaml
>=20
>       - pattern: "^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$"
>         description:
>           If the PHY reports an incorrect ID (or none at all) then the
>           compatible list may contain an entry with the correct PHY ID
>           in the above form.
>           The first group of digits is the 16 bit Phy Identifier 1
>           register, this is the chip vendor OUI bits 3:18. The
>           second group of digits is the Phy Identifier 2 register,
>           this is the chip vendor OUI bits 19:24, followed by 10
>           bits of a vendor specific ID.
>=20
> >
> > WARNING: DT compatible string "ethernet-phy-id001c.c916" appears un-
> > documented -- check ./Documentation/devicetree/bindings/
> > #92: FILE: arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts:56:
> > +				compatible =3D "ethernet-phy-id001c.c916";
> >
> >
> > Shawn
