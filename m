Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D542A0167
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgJ3J0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:26:32 -0400
Received: from mail-eopbgr40068.outbound.protection.outlook.com ([40.107.4.68]:25238
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbgJ3J0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:26:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h44SXV3SsxX7bfqO3jiC3x1XYLTQ3ikqx/Ey0h5aguVyeW/k1q1a14Lhn6+AkDckG8VWBieLLEQj+WYFTaJ8Jp8dLdDy53l8Ij23bdzJST2ku8ce6k478zy3YfgpZiSI0EYcrpfKu+D6SqnX0xmYoKWznWuouxSTAN1JDioaVJTm5SdlDYsIXZAY+45SALYneYzccVfRbCAIlSjyJrQW4N8+bbiczUPsM2vjVwZETC/gfPz8qRh2Mbjc/cwGKY1Ikl5Y7WJiIUWtzqYDfPfZ5POGcZMrkPe/t8wdWlUnK+Ab04KnvUHdqkgRfJ5HQXESfy1XnnFVdPhsKfUB3EnLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsHBA6sV9b0ONLLlASrA1xaMYrfc1mq8gyVf30LRw5g=;
 b=Itr8m/pfcuun34GFtj7HIDANinUFtVVz1NDp5grtdt79gtO0YhnbC5oxZgzk723hcHgzxr+lkTWtskU+apRLKEbI8C9xcDbFTNSO+QuR4SXRR5oybMbDri2fdaXNvwMj1fmBYvdK01ifI06znDEWgezpsO+kyWXHnQE2k3M8jVSdRNi8o7+lmZ5uIj71bKOlHy861Xj5wzqkYG1f4RpHNxGnOHz/HSuazTb8GihiQhRrmjHQ04IErdWW3gmsbozLkwL/3y7l7wmTQSoDSsvD/xni6cFvoc+8wvKT0EHqE6SSZmNXGN14GCPTGmxfp5WZJC4xf48Xhc1T7Z+nRsQ2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsHBA6sV9b0ONLLlASrA1xaMYrfc1mq8gyVf30LRw5g=;
 b=jt1KXrNGCxo9qCswiPDWBBKAfLzAn8U46ol+SFv0ZpTuTRnUiOLYMnMirH2M/FDzPTsGayZFchz7YHelAEiczti6n0E25Hkd11RHacE2L+gJcu3gktLBGK0hRVJSMmrnCI2qZ/TsCTqEJrhFv5D9jdKcgtxpRUar3quX4vmwgkY=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VE1PR04MB6447.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 30 Oct
 2020 09:26:27 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::607d:cbc4:9191:b324%5]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 09:26:27 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] arm64: dts: ls1088a: add external MDIO device nodes
Thread-Topic: [PATCH 1/9] arm64: dts: ls1088a: add external MDIO device nodes
Thread-Index: AQHWkz9JCgjY4zWR2EGQ+R0J0xYmKKmveUCAgACdvAA=
Date:   Fri, 30 Oct 2020 09:26:27 +0000
Message-ID: <20201030092626.mqtjwcfphl23pvny@skbuf>
References: <20200925132503.30206-1-ioana.ciornei@nxp.com>
 <20200925132503.30206-2-ioana.ciornei@nxp.com>
 <20201030000151.GS28755@dragon>
In-Reply-To: <20201030000151.GS28755@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b37108d3-fcda-4978-125f-08d87cb5e0a1
x-ms-traffictypediagnostic: VE1PR04MB6447:
x-microsoft-antispam-prvs: <VE1PR04MB6447E3F7696FBCAA0A788234E0150@VE1PR04MB6447.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P1P13kvkiq/4cNvFQYjlxMkHfuo2qEKlcpf1qQvqGEtY7UQeDMxa2paR19DvuauVyQqTxsmleU6gSWsm/WsQA1t+vr9cOnpkncSagKzAWH1pN8hk4asEyh2ro/Hb8Vg3A0SqcAWXkpHcQIByIhHxKI9OkW1GpOGkOHga6TEy8ZU5cqOhzfo9OWVYJAm5mqfGcM9fEFeyooGcOH00B+ul7bdyre1QEiUOceYvCLFbehjiU6c/rPObAyDBfmegP/hUnvSCnDgvFyzSRrWFKwqbxZPe27NjnvR6Za/D7jMtCROVz2iRJbxsRO5vAq4k5TpM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(396003)(39850400004)(136003)(346002)(376002)(6486002)(6916009)(9686003)(478600001)(6512007)(76116006)(5660300002)(4326008)(2906002)(8676002)(66946007)(91956017)(33716001)(6506007)(44832011)(186003)(71200400001)(66556008)(316002)(66476007)(64756008)(66446008)(1076003)(4744005)(26005)(54906003)(86362001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1wnQCURNqkDN2bmn03yH1JcvlUvtTw9IXwIknHARCFsYHm7CNCLv3FeBJB4W8DD9ncdKchMVAVifnznAUVgXBtKtZDlm5jyw2lb2ffR8PlYoBYb25Febz+EC5ksI/kpwdToiSlfHegpPLQ9V/cMHa76JX8NvYaaeOpuA+fy4GUtNkNsskN1uqyQwlHNbI5y50dd3KwMYyqa31hgJ+dZD9Te+mRoPLeJIPaqEa51Hq4BEQIxRA6w3t8rbF14uTS59wopxvGq73SyRsLMrEqipLN0kgGWAh3/y0TUDkxabRvqqUFZuAzZoDsl/DCKTlM4gjQ1xHZou6kDrYkkQwcdIcrcPOp+4zEXWNBhgpFpZLQOzHs0qydtNwAXBk8F/8Y41r0bX785HCeDuv9tDPVSwtxXn5rWkmqm63pGr2IrJiTuo3L+sji67aUZT1E9qQkffNecaDIc9jd6xaXwKrzUxMUJSWjVozk/E9y5vEyCeZkRPFJ+zsd4pngc/O54CqpBWAhHhEg+xNTXYBTRgHDgY4+7TAcSgZVG5Z6vCvH47QRQuBzR/CcRlc8g2SSX6cT3Yhq6LPZ3BesW72djqy5gNgrE7sNF7g9RjZ9rO1HpwaVVHoSAvXzO/5dkxCrdzOxIncXfTDREDxn0B/MzMMCf+ag==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B3321487AFA9864990C65087E7D4D0FA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3871.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b37108d3-fcda-4978-125f-08d87cb5e0a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 09:26:27.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pStExypFWyWMk92Ka9uSMKf3y054KMecOInTB/dtQWiK+78gylG4hDsFzXFqYDD5k64zcpq89u7+wYc9e1Of+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6447
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 08:01:53AM +0800, Shawn Guo wrote:
> On Fri, Sep 25, 2020 at 04:24:55PM +0300, Ioana Ciornei wrote:
> > Add the external MDIO device nodes found in the WRIOP global memory
> > region. This is needed for management of external PHYs.
> >=20
> > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm6=
4/boot/dts/freescale/fsl-ls1088a.dtsi
> > index 169f4742ae3b..22544e3b7737 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> > @@ -654,6 +654,24 @@ ptp-timer@8b95000 {
> >  			fsl,extts-fifo;
> >  		};
> > =20
> > +		emdio1: mdio@0x8B96000 {
>=20
> Drop leading '0x' and use lowercase in unit-address.
>=20

The leading 0x is already fixed in v4. I just have to change to lowercase.

Thanks=
