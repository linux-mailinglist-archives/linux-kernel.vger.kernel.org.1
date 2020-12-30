Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAB2E75B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 03:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgL3Ce4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 21:34:56 -0500
Received: from mail-eopbgr40044.outbound.protection.outlook.com ([40.107.4.44]:7902
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgL3Cez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 21:34:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqbz+xx1FNcq3jVisbmKxdwyd+RS6sOWDbHIDB3S4H7CeZ/+VSiZQN4WQrz3zKEG7qyvSGA99WL02TZVdqgcg8i+VEXawUy/363EwjTFoAvlhpTKtfC5faye2dtpwet8AKjl8A5w09hux0rEInBkT3KH6J/hNdZm9/KyiXqRjP3FPZaSVrMpfuWXYmHYh7suU6LnPO91q7thPEAXfF+HoI7mq0DeLpLGcLo3Favlhf1z4rtjqrAr52J4vmIH+GOI8cYGcUrFZu6qqfJ1kVdcVkCIzgPvYuu71fsZgKgdi71npteIL+7+LFh63kH9JwPgliUqnsLy6LyH+o7yCXjL7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPpDSjl9JNJpbrJqNN1Gc9H1Uw8DEIokwybePGBdk8s=;
 b=C3VbkwKMxFjZGAEL5ChTJocxEUujujOeRuH15/yr0KmKrCqMbnhjTnfRYhY80qiNhc0S8GPZizq8gUO6EQCPOc5IF8ahI68/GeiSkYntqLSDpLEEYSvVR+mZGYdk9WUIPBnGKpp9FXTv0h9lV4KMmcEn0NstbvFBNjWj4dvFnFpSi0vnHHDd7J0RXWksFC9u/vXLjk9OKkW+tOMH86in2DmqzMmlsXuVu5zPfdCaWP9LG3CeHzEGNUdPZfAjevc0cK/drn9gYhJqAsDq91gR9n/WkSeipICD5wZIEq9tAueYFXCqPxFWozZoR5rqGJabezLI5UNdBf6r1IvuwzQEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPpDSjl9JNJpbrJqNN1Gc9H1Uw8DEIokwybePGBdk8s=;
 b=imXye3o8yesqbX1nsSxaZUg7lWfmomjlki4+b+8O1GIqGHmMMUWrGLf0tbXxT+eQfFMPYlYxXSsybxZVAa68NyJyGPwszZk6B/DNGTQyYfDwG0phzgtMGVjdkRohVo8XoZD2tqoCCe02h4OMnaeZfYkcujkMI+GSGRHR+qx7JGs=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5996.eurprd04.prod.outlook.com (2603:10a6:10:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 30 Dec
 2020 02:34:06 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 02:34:06 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Adam Ford <aford173@gmail.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
Thread-Topic: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
Thread-Index: AQHW3duJvPuYDUtWdEOkXpLhy092Y6oOAAGAgAA/DACAAK1T8A==
Date:   Wed, 30 Dec 2020 02:34:06 +0000
Message-ID: <DB6PR0402MB2760BBFAAA6C5CE0373EDEFE88D70@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
 <1609243245-9671-3-git-send-email-peng.fan@nxp.com>
 <CAHCN7x+=ebLn8vrrT=fyByQDydDNfkESFZHjdUrw=OHBz_E0hw@mail.gmail.com>
 <20201229161220.GA17229@kozik-lap>
In-Reply-To: <20201229161220.GA17229@kozik-lap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba403243-b72a-4323-e352-08d8ac6b612e
x-ms-traffictypediagnostic: DB7PR04MB5996:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB59961A12848038BB2E2FC6CB88D70@DB7PR04MB5996.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /pYSjcCgKduteeI5UFsj9W7FD2OIVimGYPb2DXyjlUIpzMXLMW2VFEU9hVYnBxXFjg2loY2ZXWq+NSZaMbXvFCA6Rzl+aKJRqzFHnB1gVT50SQp1qIK156XU+/j4Dwex89jL1D/jcx8X3yk7/5YEe9ywpNBma8HdsxcWzAENzfVc/F+9bblxEF6R4LJ7eWSBSGCsJfwP34AQboHYsHt6eJLxV0LwQK75jPY1Yy8IValKu57xPpfCrygwEriLP1HuYG+OBHoV++sPYOm38CvRT6tKdi0P8AensYSnDjnHC+lRZycX9sUBiwVjwGjLXQOauBi8UBpt8oxPQti8DdL9/76fa7EKEI01/uBd4WE25DJnYk7B2cA05Hnpm0q7MRfWMc8kskQN31Okmf3UvqI2LGIDAB2Qi416oCXbaRmJtbMys51IxDHp3JhwO7evq+sa8rAAK5X3Zm5DatjVFnjqts2aJ5LXgJvUA9x2eNNkmfON5jzVxv+pi8tO6X9or9cNVN2tmZB66t2PzLyvM+rToQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(53546011)(6506007)(33656002)(71200400001)(86362001)(110136005)(186003)(54906003)(26005)(7416002)(316002)(7696005)(8936002)(8676002)(6636002)(2906002)(44832011)(52536014)(4326008)(55016002)(478600001)(45080400002)(66446008)(76116006)(66946007)(83380400001)(66556008)(64756008)(66476007)(966005)(9686003)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hC5NHQy9vgyMtUoKwZWPQSn1ZKejHRrgux3Xi5dEtEHkx+cGxK2hKEoyOF86?=
 =?us-ascii?Q?6OO36/n+C6Q4CsDJRqn7wDeg1ecm3Wsizlp7dqstIyRKzmzYGkodCGN9OUWH?=
 =?us-ascii?Q?jFsEzYXWyKnF6Ff+wr+17EmmX6OrvH2weo25e5qubXsjP1Ji/iEtvkL3TjPo?=
 =?us-ascii?Q?cJkctFN6I/M1GQyPvenpZIjFbwP3wNGWe/h1unH4yG816j1jfweeFjAYihQf?=
 =?us-ascii?Q?of9oyiYkIvEG8XjpWV26VHTniJO9Hjd6l5e3Ss98SgAry3p/fhrQkIiHMeej?=
 =?us-ascii?Q?P2IG3S4wHXw0ZkP9QoXPBtaMXxl4gM14LtK2M6VOZsGew0n6g89KQMJ4RAV3?=
 =?us-ascii?Q?BsGMPZJhLGyUB683An4Z6etUtfyYJEtw7wbwYj6JtZlJxD2BP3Km6EDWl0aO?=
 =?us-ascii?Q?I+7MDKRu38CcUcbJWHvijAq5vJfGs+iEOKW3FeBXrfSQAG4VD5FslnVL4D4Q?=
 =?us-ascii?Q?FSy32/ImNujoM0/wavJuHnDGMXwdmak+Nu+kFGjHURHStq18URyfcvTwAn8D?=
 =?us-ascii?Q?Z0kTKk+ASLgNJYtQ44tGkLLxsP5XRycaQJS02CAJMJItiUwRzgAmLJ2sp3RC?=
 =?us-ascii?Q?k5dDZ6DjgDe0poqo8oKGnQS4lT1m/WQN1orDJ4Tgm3LfF3IQdlvs0y85S60p?=
 =?us-ascii?Q?Ajn6Gd2iIpMsHu9m/0DLjsyULkc2qdnT+fTxAGG29AhpCHxThX1wpBqtmVHL?=
 =?us-ascii?Q?wxBVg4hwa4crC5alSHTLhvxkQRkuJ1oDargyUV54rmlorOYJvE+B0roLcF9Z?=
 =?us-ascii?Q?OCpmkBbRqcfO1sE5SHeA73yJ7l4UPyHIHIJ11VXa4MI3uCCQjASZkVYnzIl9?=
 =?us-ascii?Q?LlS9jV604Sd2nuKpdAoPAamq4a0iRUnm10J8IK6y7AWF5n3WjB3M5XWf/GAQ?=
 =?us-ascii?Q?CzRHsMChcdbDW5OHFglxZVcECLfJZnJi9Aiu9j8LSQbNSrs2C9ATIZo8TAGu?=
 =?us-ascii?Q?bB/yRqVQj321NdKincHuPcJJcaBQdn8N//s1I/XSz0Y=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba403243-b72a-4323-e352-08d8ac6b612e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 02:34:06.3416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WiYJ++iV5jtcGOfvG0Zcq6uYS666yOg2RzN2hzgZ6E9lanc8SzXUElZUip3KgP1k1D7vMIpCkjbtvmf5TcmsDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5996
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/4] arm64: dts: imx8mn: add spba bus node
>=20
> On Tue, Dec 29, 2020 at 06:26:41AM -0600, Adam Ford wrote:
> > On Tue, Dec 29, 2020 at 6:15 AM <peng.fan@nxp.com> wrote:
> > >
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > According to RM, there is a spba bus inside aips3 and aips1, add it.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 362
> > > +++++++++++-----------
> > >  1 file changed, 189 insertions(+), 173 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > index c824f2615fe8..91f85b8cee9a 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> > > @@ -269,117 +269,125 @@ aips1: bus@30000000 {
> > >                         #size-cells =3D <1>;
> > >                         ranges =3D <0x30000000 0x30000000
> 0x400000>;
> > >
> > > -                       sai1: sai@30010000 {
> > > -                               #sound-dai-cells =3D <0>;
> > > -                               compatible =3D "fsl,imx8mm-sai",
> "fsl,imx8mq-sai";
> > > -                               reg =3D <0x30010000 0x10000>;
> > > -                               interrupts =3D <GIC_SPI 95
> IRQ_TYPE_LEVEL_HIGH>;
> > > -                               clocks =3D <&clk
> IMX8MM_CLK_SAI1_IPG>,
> > > -                                        <&clk
> IMX8MM_CLK_SAI1_ROOT>,
> > > -                                        <&clk
> IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
> > > -                               clock-names =3D "bus", "mclk1",
> "mclk2", "mclk3";
> > > -                               dmas =3D <&sdma2 0 2 0>, <&sdma2
> 1 2 0>;
> > > -                               dma-names =3D "rx", "tx";
> > > -                               status =3D "disabled";
> > > -                       };
> > > +                       bus@30000000 {
> >
> > There is already a bus@30000000 (aips1), and I think the system
> > doesn't like it when there are multiple busses with the same name.
> >
> > There was some discussion on fixing the 8mn [1], but it doesn't look
> > like it went anywhere.
> >
> > I am guessing the Mini will need something similar to the nano.
> >
> > [1] -
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
c
> >
> hwork.kernel.org%2Fproject%2Flinux-arm-kernel%2Fpatch%2F1607324004-1
> 29
> >
> 60-1-git-send-email-shengjiu.wang%40nxp.com%2F&amp;data=3D04%7C01%7
> Cpeng
> > .fan%40nxp.com%7C970d320f3ef7413296ed08d8ac1486f9%7C686ea1d3bc
> 2b4c6fa9
> >
> 2cd99c5c301635%7C0%7C0%7C637448551481206715%7CUnknown%7CTW
> FpbGZsb3d8ey
> >
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D
> %7C200
> >
> 0&amp;sdata=3DxKgYHCDyitbUyTPKVuwQV%2FCoJvepCbdBJ1MD9vP%2B6MY
> %3D&amp;res
> > erved=3D0
>=20
> Several replies from S.j. Wang are missing from LKML (and maybe
> patchwork?) but we reached a conclusion:

Thanks for the pointing, I'll give a look. If S.J take it, I'll leave it to=
 S.J.

Thanks,
Peng.=20

> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
ke
> rnel.org%2Flinux-arm-kernel%2F20201208090601.GA8347%40kozik-lap%2F&
> amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C970d320f3ef7413296ed08
> d8ac1486f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63744
> 8551481206715%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3Dnk
> t0J5RtzA%2B29nK4aPnd434FNQV8MUZ%2F8Aq64o6hl6I%3D&amp;reserved
> =3D0
>=20
> Either you do some remapping of address space or just rename the "bus"
> nodes (e.g. generic bus-1 or a specific spba-bus).
>=20
> Best regards,
> Krzysztof
