Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4995E29CB55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 22:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374193AbgJ0VfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 17:35:18 -0400
Received: from mail-eopbgr40076.outbound.protection.outlook.com ([40.107.4.76]:4814
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S373866AbgJ0VfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 17:35:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFyvdAQJtrs9XcIXNzeM1Ct6TgQn3xad48TiC0Z3SqcLp3DxAOtc2y3dhU27MOQtwNVIxDuKH1nO5btpRSnqkdR27TvazFEYO8v0+7BSUrmsBwjmw3YSxqdo90LrcbDC7hv2oIcLS9gkCc7rFRLhDJz4/ea1iPkcBfr36NecNHLe6ebByrO0CEunTIewQt7BvQXq86hFjuuV+BrO4E1FcCuJ3cGVTRV9b9y1pNEV3ATsJfhtd2BbGnSya3+UH2BG22NWc+JR4M9uqQy4vArKcx6j7yAW67fMuNcdVUuDjFzjalMlLfucZCnQF5BJmanftA6PKw2rL45QxexrZNLbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krB780gpfvkxIA0nQHBgUdUVp2AeGiWVq+YmHtUtJWU=;
 b=VXXnxRD4HLK9vMw/cOF0HMpdqT+4EeDBKDSf8fSLLdUN1y2Lq2J9Z8DauCgNuhNUPxJCvMTQqk2ROGrM5Qbj28qKYjZfEHlF4awgWAqNcB5FL1W4XYy+Y68/pj9Fa6NU+W12g/Uv/QRF/gwkgkVZII7C4B/s3trFmGMQuIk9U2EqywS0q759hsh9tLEBy79axH0n67EDCVmIdXO2EG1g+LemVWxn2XKIIlwbWCXYJHtWrD/vtpfLfpGk5GNThVY4K//yxZQ+hCKRkiblqnJh5oyGRZz14VesIBjJaN+4dOqvPgm5RlccSVOjHhoCHpB5estcWnTYGcDpwEG0RaaBqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krB780gpfvkxIA0nQHBgUdUVp2AeGiWVq+YmHtUtJWU=;
 b=CqYFQFLUBhum0GUagHocz1D6H2uStBH8MVhG0xO1jiiaPgG6kWEaIDEoQOi+oBvUy9u/YTLu+u5FDWQNQ8qjgrGGsAPpSJ8osNYC4REsUGFnrE8kMsKAT1iP0hXkGnrQRmcdIR/5bmFJlkPLUL/i1hLyAYbPqQADIXodz7VXZPE=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR0401MB2496.eurprd04.prod.outlook.com (2603:10a6:800:56::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 27 Oct
 2020 21:30:44 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 21:30:44 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Biwen Li <biwen.li@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
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
Thread-Index: AQHWrB1r8C3YTVD4gUGfvnOjzP6Q2amrEJ2AgAACOICAANrToA==
Date:   Tue, 27 Oct 2020 21:30:44 +0000
Message-ID: <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
 <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3d6839b-4dcb-405d-aa18-08d87abf8ff8
x-ms-traffictypediagnostic: VI1PR0401MB2496:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB24964BC860BE9A960D7033BA8F160@VI1PR0401MB2496.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CnwmsvWIc8AyNIhpMRApeCZQ0pxKhBRuaCB2gsl8jFFB9bRQ/mSqF3p4DFAvFt86f6l1EiEjqDlSRWpjLDGH1AVlj+tPUbrxRFOGbDXqN0rGcmhEoWh7wdCA7+cvnrU9XH6jjALMLkJTEJkQwoqiNBi8F69BHbjhNHvgdjs9l5J1zvoNobnhGpyB9QtswMB9dPNyTeCnZ4bNqdFQrnM1Sln3ZLoa+rACCJi7gEZkiDRQhe5Ad4RuONUd9D8QIalIAsDLAdBC48xiQtPQ0a8seXjKnQza+aVuTFC0wE816CjtE8JXQZUk49f5fZcLzF++a9JvRAkjEAPA5gRrzuOKH+Xc6r4nBtyL5XhJoL4ipSva/BAegB4Co92Fs5ZFCR1F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(52536014)(55016002)(54906003)(316002)(7696005)(7416002)(64756008)(66446008)(66556008)(76116006)(71200400001)(66946007)(5660300002)(66476007)(33656002)(110136005)(6506007)(86362001)(53546011)(186003)(9686003)(478600001)(26005)(83380400001)(8936002)(4326008)(2906002)(8676002)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Ov8IYeiyXnMsGHA+Zfap/0f84yFy61YCfWk+BAUKYcSI5qCW/fbp6AnHLz3I1uhkyYUOuYgXK2wpG+D9Xl0x/lv3MPEau3TDpGGHa5gBhw82XG5vZ7MJS7dtuQ0vwpxQSjNDPpHNtsQwiKMeWgzoHLxWXNWyhWmHccVigbJweemFwo96oCxBclPGwSbHONSzGXaRt9QXqL0t3uAaTieRBn2Nux3rz20AI2pErT96rarCrxVWSS/QqMOvtKHpSKH3OagKuJRnXYMVaDR023+OKFGNHtuqm6H2qJxIBuyMcP679eisM6VpEDWHe46FpR19T2tmemILzVqSlh5aKxMJmK2m0ruimJFUKiwO0NFgy82mxcIfjSC3hDChTNL2x58Bjx/JHvjNTjmCUCP0NkUXUWk9+naNQSPMkd6HJ2xFbekJ1pmVPRWqH8+x2DLI9SwzOJQ3TkgP3uUpPsfKtjAFR4Ni0wBM9mYTmtcWP2+lGQYEvctqG/dXso9MK5MfnGTDIYiV27y1nPF21o5DRX6qJ6/mlowZ4NtZn9CjNNiXnwffDyMQgENC+F9pJk1DlrhDxVyG0VZj+HJG0wCBtYnYuGf+7ZuzvNUANVvFx6Epp2BF5voO/x7E0s4mFAvriQQMzxPDKWHHpuvIYlanmYrlrw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d6839b-4dcb-405d-aa18-08d87abf8ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 21:30:44.3726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fPqCEBDzFaI50gZBFPkllmUPr94bpfneQuBmef8uDXrO4m/thi2BUOQn9vlPYFr0amhB+Y9FN471F616j4Oluw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2496
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Biwen Li <biwen.li@nxp.com>
> Sent: Tuesday, October 27, 2020 2:48 AM
> To: Rasmus Villemoes <linux@rasmusvillemoes.dk>; Biwen Li (OSS)
> <biwen.li@oss.nxp.com>; shawnguo@kernel.org; robh+dt@kernel.org;
> mark.rutland@arm.com; Leo Li <leoyang.li@nxp.com>; Z.q. Hou
> <zhiqiang.hou@nxp.com>; tglx@linutronix.de; jason@lakedaemon.net;
> maz@kernel.org
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Jiafei Pan
> <jiafei.pan@nxp.com>; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088=
A
> external interrupt
>=20
> >
> > Caution: EXT Email
> >
> > On 27/10/2020 05.46, Biwen Li wrote:
> > > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > >
> > > Add an new IRQ chip declaration for LS1043A and LS1088A
> > > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A. SCFG_INTPCR[3=
1:0]
> > >   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
> > >   reverse)
> >
> > s/defaultly/by default/ I suppose. But what does that mean? Is it
> > still configurable, just now through some undocumented register? If
> > that register still exists, does it now have a reset value of all-ones
> > as opposed to the ls1021 case? If it's not configurable, then
> > describing the situation as "by default" is confusing and wrong, it
> > should just say "On LS1043A, LS1046A, SCFG_INTPCR is stored/read bit-
> reversed."
> Okay, got it. Will update it in v3. Thanks.

Hi Biwen,

Where did you get this information that the register on LS1043 and LS1046 i=
s bit reversed?  I cannot find such information in the RM.  And does this m=
ean all other SCFG registers are also bit reversed?  If this is some inform=
ation that is not covered by the RM, we probably should clarify it in the c=
ode and the commit message.

Regards,
Leo

> >
> >
> > > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> > >
> > > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > > ---
> > > Change in v2:
> > >       - add despcription of bit reverse
> > >       - update copyright
> > >
> > >  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/irqchip/irq-ls-extirq.c
> > > b/drivers/irqchip/irq-ls-extirq.c index 4d1179fed77c..9587bc2607fc
> > > 100644
> > > --- a/drivers/irqchip/irq-ls-extirq.c
> > > +++ b/drivers/irqchip/irq-ls-extirq.c
> > > @@ -1,5 +1,8 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > > -
> > > +/*
> > > + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >
> > If I wanted my name splattered all over the files I touch or add, I'd
> > add it myself, TYVM. The git history is plenty fine for recording
> > authorship as far as I'm concerned, and I absolutely abhor having to
> > skip over any kind of legalese boilerplate when opening a file.
> Okay, got it. Will drop it in v3. Thanks.
> >
> > Rasmus
