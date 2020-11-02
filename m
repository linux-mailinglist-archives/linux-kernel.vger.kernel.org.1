Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56282A35EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 22:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKBVWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 16:22:36 -0500
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:56828
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbgKBVWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 16:22:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQQ+Lcl9B4qiVvdsiQvAwm5hIj0nAo7phvK8l6qMCnzLfTx0zc0SWS+nuShhFeDPAo6quWl6Z0qe4lXOUr445CUF7jTpH4YdqPsQtvN5kGfuHZ9p/f3eokru8qwB86+WQgfPtpiM9DXhVtUW2Q2nGGmDiRcUicfKSTUsu46URT9li6iR6t5tGt6Bu7gPAqIjj1iwp0f5U8tMtpc7xwEpMmB0XQ/JlsFWErIViISfNMW05mNw6kKr7oUoEe/0Ir3yY/WU/P9hGqiHadTkkYGX3Os4wyvYwsB/BX5zgtzJm3z4oF5h+et9kRf3xK1M2EwIBrQdxc1EKxlj54SMhXTKqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtujdME18y3D/U9hmU8PbqZuX2Uk2QL8ocY+OSAT/34=;
 b=IsR6gjfpl65XzsmRiU4FgvP+6tEFJy5dsHujwIl6GjcPw5rTMjkhLjIQIJspEv2Z8KJ/cBM+Or8yreAthsGlzJ0hXCy36kqiewSXG9zj+0kjK2WD67uQCMO+/A1xC+vohJTVFZk6lIWPBPtPnpX/XvcdQhAGnAfAX5tS2w+rOYlAXLfS2bYOOHIY0gc2BfAtu8iKabQp2HuAo1e7qwXoFzM1XilKngDNWoyyX5aYIEaqtx58PKA+TAqY+OqrpqyWpQbTpduQRWHcqnTTBGTJ/GIeVkWnfavhGf7620moFlP9rIuQFjGsJfZyr6v2xAtZ9E5Comw97C3gLcsyKHgb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtujdME18y3D/U9hmU8PbqZuX2Uk2QL8ocY+OSAT/34=;
 b=Rv/hwf+c6bEaFwYIeLo/O5iduxSju294VjhBRE9hKNRn3zZ03NBVzrT/N7AVkR5ICsi0M+XV+a15X265Qq/LyHs2BEF2OTczYKHrGwIiptnLrgIov0ro7Uke3icfl0bDNoYFEZPuiNGF+2YQ3NsqrD88LgJvVLCKD50AMzCaet8=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR04MB5950.eurprd04.prod.outlook.com (2603:10a6:803:cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Mon, 2 Nov
 2020 21:22:30 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 21:22:30 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Topic: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
Thread-Index: AQHWrB1r8C3YTVD4gUGfvnOjzP6Q2amrEJ2AgAACOICAANrToIAIeRcAgAD4mMA=
Date:   Mon, 2 Nov 2020 21:22:30 +0000
Message-ID: <VE1PR04MB6687738526B56F3F0E6812C58F100@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
 <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB6PR0401MB2438DCABBF4892ECF599D4528F100@DB6PR0401MB2438.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0401MB2438DCABBF4892ECF599D4528F100@DB6PR0401MB2438.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 350cfef9-609a-462a-dc42-08d87f75680e
x-ms-traffictypediagnostic: VI1PR04MB5950:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB595092EED65EECE52E09FD908F100@VI1PR04MB5950.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /czYB39G8wUSSFfIuCYhx6Miy5M2p3FRYXm0yhUmfe79tzpYRNZWStpI09hkjmid+5HocPLEzjwcQY2s1urXDl7Y9yzZTKBcXRgYDOPv745xa/CMTMG7hBYBvpwKWIIXVVKz9T1ycXbeTwSqCeBaZ06BKkKFntBv1o8m0YMIrpJ8kBPcl1prIayE03RMU8QpHNmzUXyG8Yu7JDexkLQKg8zNAXn5XejRFVaOMR/W7iHSLiPLUvsD0D/bT7323AsUJMOwdXDfBes1PEiPYJz4Wc99bSooC9JubgQR3IawyH6sa91+WwrbQd1m+vtlTjGTlvGUwy2MkrJfqIWOCgaSvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(346002)(396003)(39850400004)(8676002)(55016002)(71200400001)(316002)(9686003)(6506007)(76116006)(64756008)(66946007)(66476007)(2906002)(66556008)(83380400001)(53546011)(5660300002)(8936002)(4326008)(66446008)(7696005)(54906003)(110136005)(52536014)(186003)(86362001)(478600001)(7416002)(26005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BcNK0c85s0Qjl8ilkehbOeIabZz6yDTpJXLs2WdjpNLr+ZnjrokbB/2ze0SI08Ehbc0qHbwlOltxVmUzS+9llN1Yicz+jHM9TPcfMYVyRF3duKkvOwmJuG/T0In0T5cTeUKHdJZ8xUIaWKQxEpNdJuRJP23+X0bK5y8Ixmj7EVwhhG39qygiU2th9hvUCjDHcN9mz4dzifO283oedtfSBI63KdecXqTFlO5IFuPHr+ELu4cxLoprKqGIHmxeydYyAfyqEHNiYl4ISzXmULfaTU6Dsb1N5DYc+oJTrvl/g1VKjEpeXiJy1BLLDiOdYP4zEEipJWMeL+bkXaBXT+ie/uzFNIdoGUJHLnp/tnwOqGcZ56Y+XCO8F6QIQD9dA4QIKpTeyCtXHkaJ2MrrRkevii3VacTvN/laqVghi4tcP9Jw/Uvt7uS+rm8buwQ350FaUISzHXlOe0k6foggANH52CqEYAFKvNG6EBcpbOCKWNCsoS1QK4tpkLN42+9ksnUUJKieCVoGqcKMWAim9/uKl7D4FtImWt+7cGHDEd4OQKid5P9bnbAetifi1B9uPp2QpDxWu0oRwmo/uymOx3faRF/TLZ5lTQ28Z1LxFMYvDhikIobp7xmva0v7p7y4i09dRLRM0X0Biz+cAuGvzQstqA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350cfef9-609a-462a-dc42-08d87f75680e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 21:22:30.4641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x4xcuG22UhMJBM07QpC0UMlP32r0Crm/B3nSu1TiibvzdCriimyZa3SUcEJ+/V5Wv2Qw1oXV1Ay//PRxDnVBuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5950
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Biwen Li (OSS) <biwen.li@oss.nxp.com>
> Sent: Monday, November 2, 2020 12:15 AM
> To: Leo Li <leoyang.li@nxp.com>; Rasmus Villemoes
> <linux@rasmusvillemoes.dk>; Biwen Li (OSS) <biwen.li@oss.nxp.com>;
> shawnguo@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Z.q.
> Hou <zhiqiang.hou@nxp.com>; tglx@linutronix.de; jason@lakedaemon.net;
> maz@kernel.org
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Jiafei Pan
> <jiafei.pan@nxp.com>; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088=
A
> external interrupt
>=20
> > > >
> > > > Caution: EXT Email
> > > >
> > > > On 27/10/2020 05.46, Biwen Li wrote:
> > > > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > >
> > > > > Add an new IRQ chip declaration for LS1043A and LS1088A
> > > > > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
> > SCFG_INTPCR[31:0]
> > > > >   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
> > > > >   reverse)
> > > >
> > > > s/defaultly/by default/ I suppose. But what does that mean? Is it
> > > > still configurable, just now through some undocumented register?
> > > > If that register still exists, does it now have a reset value of
> > > > all-ones as opposed to the ls1021 case? If it's not configurable,
> > > > then describing the situation as "by default" is confusing and
> > > > wrong, it should just say "On LS1043A, LS1046A, SCFG_INTPCR is
> > > > stored/read bit-
> > > reversed."
> > > Okay, got it. Will update it in v3. Thanks.
> >
> > Hi Biwen,
> >
> > Where did you get this information that the register on LS1043 and
> > LS1046 is bit reversed?  I cannot find such information in the RM.
> > And does this mean all other SCFG registers are also bit reversed?  If
> > this is some information that is not covered by the RM, we probably
> > should clarify it in the code and the commit message.
> Hi Leo,
>=20
> I directly use the same logic to write the bit(field IRQ0~11INTP) of the
> register SCFG_INTPCR in LS1043A and LS1046A.
> Such as,
> if I want to control the polarity of IRQ0(field IRQ0INTP, IRQ0 is active =
low) of
> LS1043A/LS1046A, then I just need write a value 1 << (31 - 0) to it.
> The logic depends on register's definition in LS1043A/LS1046A's RM.

Ok.  The SCFG_SCFGREVCR seems to be a one-off fixup only existed on LS1021.=
  And it is mandatory to be bit_reversed according to the RM which is alrea=
dy taken care of in the RCW.  So the bit reversed case should be the only c=
ase supported otherwise a lot of other places for SCFG access should be fai=
led.

I think we should remove the bit_reverse thing all together from the driver=
 for good.  This will prevent future confusion.  Rasmus, what do you think?

Regards,
Leo

>=20
> Regards,
> Biwen
>=20
> >
> > Regards,
> > Leo
> >
> > > >
> > > >
> > > > > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> > > > >
> > > > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > > > ---
> > > > > Change in v2:
> > > > >       - add despcription of bit reverse
> > > > >       - update copyright
> > > > >
> > > > >  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
> > > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/irqchip/irq-ls-extirq.c
> > > > > b/drivers/irqchip/irq-ls-extirq.c index
> > > > > 4d1179fed77c..9587bc2607fc
> > > > > 100644
> > > > > --- a/drivers/irqchip/irq-ls-extirq.c
> > > > > +++ b/drivers/irqchip/irq-ls-extirq.c
> > > > > @@ -1,5 +1,8 @@
> > > > >  // SPDX-License-Identifier: GPL-2.0
> > > > > -
> > > > > +/*
> > > > > + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > >
> > > > If I wanted my name splattered all over the files I touch or add,
> > > > I'd add it myself, TYVM. The git history is plenty fine for
> > > > recording authorship as far as I'm concerned, and I absolutely
> > > > abhor having to skip over any kind of legalese boilerplate when ope=
ning
> a file.
> > > Okay, got it. Will drop it in v3. Thanks.
> > > >
> > > > Rasmus
