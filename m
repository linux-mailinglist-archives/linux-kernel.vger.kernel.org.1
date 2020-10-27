Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9443129A9CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898486AbgJ0KgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:36:07 -0400
Received: from mail-eopbgr80085.outbound.protection.outlook.com ([40.107.8.85]:55712
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2898449AbgJ0KgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:36:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tvh3nzWqJktN2PiaA0fBnC5jMVMJJhzn/m3kBa5aWZkasnSsp/CtFdyIytM57BAG5jIDCfCwkhjcS3DGQeaUQjgvGIPG2xRXw4rzHHAhsB6xYkPQniX3jPT4HfC53oESnjSlzZ+fjfS+53pOM1rwzkj+Y6MP+RtmldMhrNfm1cGXZHEiSD5MHPXb1pOrcphLzkVVfNidg80ZR/yjlVCn8PCtfbhWXckrYuDM2j3f3PUEqsfDRgHFofozBzJuxEU13JlAdTCWAMGPof7I/horb58lYMsq0F+5aP2fGoIY4jK0ExaI/o4r1AZ86I8vL2Hg1qyaXsFDNyM2B0CK64qGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN5bdLi0+FL0ViYdZGssLKaqfR5ZvbJ9jT+ueiPN57A=;
 b=CEw1gLB4B8Dsc6HRYL6R7yNRwLuFusFT3qrjhHdYxJmaR9U5wtMGU1kIkpVIqs/FWxuEblpvRPeASqTCuKLy2yM9PSLYTq83AIQEOAsTNkeiSTbyNB4kTiaEFGR4KnZrtjTe8rgx+WeCVZIoIO4uaZtlsJ8lTFML6/vs/gNzwSQPrc7vLUtrHs20vprWit3wVqdjpmBEiEiDZdrrJkwrv0s/Vx2w9v2w+d9TVIMC4+UF38skb/M3LqU0vsXuQFRrTrRg1De4clOGfKczNA/nO50br+gHVmUrt31ewhk3nyFsiRKJFxHpdF2C7UQW5yRo3Wo9HUqS6/XC+Z0zj4QcBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN5bdLi0+FL0ViYdZGssLKaqfR5ZvbJ9jT+ueiPN57A=;
 b=NfTrT7H7rqGvXFK7OCaOqXiCwyOwkIEzMu7CeLlRjIXJ0BiLKi5DP2Xdke+Z9JHknIkoY5rqk+N3p7awMZZHLEF7VZ0eZK8prwf63oFc6FwyCQMjxIuQHHMs8qk1LMcgS+nYZiZW3Cm2as+LMlLf/BhU82i6c8mFbwsTWjVyQ/M=
Received: from HE1PR0401MB2444.eurprd04.prod.outlook.com (2603:10a6:3:83::15)
 by HE1PR0402MB2698.eurprd04.prod.outlook.com (2603:10a6:3:dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 10:35:56 +0000
Received: from HE1PR0401MB2444.eurprd04.prod.outlook.com
 ([fe80::2465:b69a:bcd7:75d9]) by HE1PR0401MB2444.eurprd04.prod.outlook.com
 ([fe80::2465:b69a:bcd7:75d9%5]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 10:35:56 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Marc Zyngier <maz@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>, "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Topic: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A external
 interrupt
Thread-Index: AQHWrEzzsEWsQcWWFESnNpVhpDbBsQ==
Date:   Tue, 27 Oct 2020 10:35:56 +0000
Message-ID: <HE1PR0401MB2444AA759104F4A34F91B61F8F160@HE1PR0401MB2444.eurprd04.prod.outlook.com>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <d5d6deb90b4b3d086024fcf01b737da9@kernel.org>
In-Reply-To: <d5d6deb90b4b3d086024fcf01b737da9@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 53cee19a-d5b9-4076-d1ce-08d87a64166b
x-ms-traffictypediagnostic: HE1PR0402MB2698:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB26987F4A23911B194F5CEA2ACE160@HE1PR0402MB2698.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 66/DZXm0D9HjxeHgrtMJewrPpZI0H+0J00uQtN2C4dRL+hiUUKotmjYYHoEGOAWuYlIiCp7Kg1AS99qTLwJTA1t/FKB9hervjNi/kUwGTLN10gqs21r1zmz+kVTZuwmznPCajnuxUnm94lQZTiHbn+hOIsUVs/h+7EnlZJQIwZ7JTqCuAuT6N0+OZ+XHwzKTUFANUSXUHxX+uFmi+A7bVEOBPzQPMeuPQjiULKP6+2tNXOfjZ34bgnYJE4Wb7Sx9Vj+Sg71B57iaYmQigS+f4kZOpylPd8KCEoLYxXqjhIWvtlzDvdXXx5aNnAXeMvFWrP4V8vzwTGDjLt+OIYdwPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0401MB2444.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(71200400001)(6506007)(76116006)(2906002)(52536014)(66946007)(66556008)(83380400001)(5660300002)(66476007)(64756008)(66446008)(9686003)(110136005)(86362001)(316002)(26005)(478600001)(8676002)(7416002)(7696005)(54906003)(4001150100001)(8936002)(53546011)(55016002)(186003)(33656002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: cLYMT0kdGS9M5XkzCAe3/pHY9A6Np/X5pMlnDgjhwd3PCsS2P8zSWvf5EdqhcE4XZ6ZFiSvwQd4YsFW3ZwlaM/WBzxnclUq4TeUc0IozBcpj2B3oiufQGugVVtUj1a3lhc/epA+14qk8zTEZS2kaC9gm77pMmzWhpNuBnR7ylxnHY8fd2jp9IBnbyWGonUdOupWpeD3+wH0PEniPAKAisYT+DbXYhrLh91GPSFzVOppGoP22b7GlBZM0nWdxV+kIWNy1TKN6HptgDZ1Tk18qXYI8+PioyznRmlztcWXNKdrLG5HFg3RRQcqVoG+50KdIpBp3VZPmRxNBHyNsd4zlbjhLtKWq4nokFbHGbgY44mAycsSnnYHewfDpWNxesCHiHxUbpIfYrkEyItB4/DWW+MASpFiWuPcM0dMb2Qs+GP1nFz2QT1rmCn1ASWwFHq0T1uANLR63VaxR1Xq36mj02OdKO821rWe834MMRTkyiGfPsR8MgA4xU9vCvudVNLBUcR2QGRA9In62idlHYPoNCCbRYtHL8KFDZj7JORZ58oO+iqg98YZ8IKaoBPKOVWf9eGxBYFTHOaeegkr8YTyT07Cdff+g5X6v5IjGHIdhB2AoWnBgrbWSXEjB0nV3Gk1zjnloOFL0kprskSa2cJIg2A==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0401MB2444.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cee19a-d5b9-4076-d1ce-08d87a64166b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 10:35:56.3088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oU+QNPoZ83eNlBOI72Oikpfp1RGOrsT+HYLRiX19QRiqWIYOiySroHSs3OhnJj9esu1vmaYm6UJLb3btgAOCew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> On 2020-10-27 04:46, Biwen Li wrote:
> > From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> >
> > Add an new IRQ chip declaration for LS1043A and LS1088A
> > - compatible "fsl,ls1043a-extirq" for LS1043A, LS1046A.
> > SCFG_INTPCR[31:0]
> >   of these SoCs is stored/read as SCFG_INTPCR[0:31] defaultly(bit
> >   reverse)
> > - compatible "fsl,ls1088a-extirq" for LS1088A, LS208xA, LX216xA
> >
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
>=20
> You clearly couldn't be bothered to read what I wrote in my earlier repli=
es. I'm
> thus ignoring this series...
Okay, got it.
>=20
> > ---
> > Change in v2:
> > 	- add despcription of bit reverse
> > 	- update copyright
> >
> >  drivers/irqchip/irq-ls-extirq.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/irqchip/irq-ls-extirq.c
> > b/drivers/irqchip/irq-ls-extirq.c index 4d1179fed77c..9587bc2607fc
> > 100644
> > --- a/drivers/irqchip/irq-ls-extirq.c
> > +++ b/drivers/irqchip/irq-ls-extirq.c
> > @@ -1,5 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -
> > +/*
> > + * Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > + * Copyright 2020 NXP
>=20
> ... specially when you keep attributing someone else's copyright to NXP.
Then I don't know how to add the copyright, any suggestions?
>=20
>          M.
> --
> Jazz is not dead. It just smells funny...
