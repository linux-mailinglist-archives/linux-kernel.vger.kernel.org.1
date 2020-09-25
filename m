Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138772781C2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 09:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgIYHh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 03:37:29 -0400
Received: from mail-dm6nam08on2079.outbound.protection.outlook.com ([40.107.102.79]:63200
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727044AbgIYHh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 03:37:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0ifLqVrQoMK1AXeEpso4B3FLhXWQtTz7Z1/WXbHGWMyPfMpGeXUe/adD2yVimxoJAXM9pjNEPamHlbEF4WBhK5kyy+/vm0tBuvH9iuWN+AKOnIgaykE5qAN76TGnAgIFMSVUcofx7Tw7P9ofEHy/2BHMfBWSmgB7agLnyla0XflNpdncy0HcyJUDf1p1EXKPutEikCt/p0oobXa+WtAiSkHnTiQhO+rs+5jHW8TTgVWZLUDBaiUrTHyall/b9fMfJUbTBc8jdKHt3BPzI5LGy4sIL5JW7OSqKD/aCIzOJdSE7paVKBXvxdF2mnEmLIb69+e6umEE39177HLS6xUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrlLWRJapt+hoDD+INRaLn1inRUzTkaQnswxmSbeQ0Q=;
 b=Sx+Nd7eNHChyThnDNE7v4YQgykyplJ0ag7dskG84V1Qo911yzP7ByO/jw6rPOid5NBj3D0Lv4WPAKzebtmWo9XTmc87am8Au9rU7AYa8jh0Lmq2FAQBmxVs5RcmX74cHsfBHHSqWer7AYQWyKxtC883cJsVlKVAGOrjH6PunBWV3vBp3k6Uo4fvYUivKRZjtXKwNZ6SNK+sneXEnJE8DwtwJY7o1E54zA9W4cBMWjGCp7ZtqlSf0+YV2viQ4NNSF9WBEQjGO1ZPBCrhWHWi3TtZzp8afXNe3kJjjLHVcDdUW0PhQ73HnE48giWyS3lUXrVQU3EEpjdiEy0jETK5gbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrlLWRJapt+hoDD+INRaLn1inRUzTkaQnswxmSbeQ0Q=;
 b=DzBgbYmR9EnNKmGlFo9NMY4U+OwwFqW0t6djcuLm9P7g/mS9mDymVRvqYCWeTgVhX2qEmKnbryLNnqWZuM6UrvH5a2A0QvAue0yHPV8GRYnNCbyc03WSLZy0bAPBsHAVbCOhq0yAlMTYB5QNABPT0/rMuYLmDSbw5gBtdcX+ZGs=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB5781.namprd02.prod.outlook.com (2603:10b6:a03:121::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Fri, 25 Sep
 2020 07:37:23 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::84b5:71be:1584:f314%7]) with mapi id 15.20.3391.024; Fri, 25 Sep 2020
 07:37:23 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Michal Simek <michals@xilinx.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
Thread-Topic: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
Thread-Index: AQHWhty7FzdXEfNw1kSmR8l21jgZnKl1JowAgAJRB4CAAXjVwIAAGC+AgAAB1dA=
Date:   Fri, 25 Sep 2020 07:37:23 +0000
Message-ID: <BYAPR02MB58965128B42C13113227A0E3C1360@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1599678185-119412-1-git-send-email-manish.narani@xilinx.com>
 <1599678185-119412-2-git-send-email-manish.narani@xilinx.com>
 <20200922195410.GA3122345@bogus> <87wo0jejae.fsf@kernel.org>
 <BYAPR02MB5896E374297AF46A63CDAD30C1360@BYAPR02MB5896.namprd02.prod.outlook.com>
 <87h7rmcou8.fsf@kernel.org>
In-Reply-To: <87h7rmcou8.fsf@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [183.83.139.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bab7de08-56d1-4413-59dd-08d86125d7e4
x-ms-traffictypediagnostic: BYAPR02MB5781:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB57811CDD4B53E54FB87B4BDCC1360@BYAPR02MB5781.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4pemEyQYE30sYivXoaF8x8rUr+cPVYZ6D2byP3Dgc7RlBus+5uP9JpNpbSQKSMAUu4JERJ5sTuLVyunOmM8aAK0lRN8zH6yvSk0S5KTkh9ogZUFFOya8rw6ESkqaYLQ0jjQHO5oQe2hY5wX3yxm6xdN/KoA4xcuuPu5pPPGDKbBtCrwD1Rb9wmuK/1FVIUTqCd3lPYJLqRWyZQAfdaF7CZpBQ+NDdZ9cZmbsjZ9u9ZqpH4CMjMeO+Yqz8gdOHglrjDJXpJ5m1z+dxBrsT2B0z3O9bUf1hwRZOEGDVnAuQKYO/4qnqpKvRZ6TcsDFNq17B8EbBgwATkMRVmIX5Xyag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(71200400001)(6506007)(110136005)(316002)(5660300002)(66946007)(4326008)(66446008)(52536014)(33656002)(44832011)(8936002)(107886003)(55016002)(66556008)(8676002)(2906002)(7416002)(66476007)(64756008)(186003)(7696005)(76116006)(9686003)(54906003)(83380400001)(26005)(53546011)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: C+IRdNw4OwTSdQ4bn40VavBIP0uXl9j5n0dtEX95iz7LjUSKqjBOZoqH9dxMMa0Q3Cigu3NweZvVNaccCE1i5pDq/lNJ6w19di8littzrXgRknN0Vj5dXQNbifxYfzIxMEPELimIsLbnFm7i+7xDFR3mCyMqxHUNEHIPdTeVy6t0Y+CdoGwDgIGTA2DDgOHd23sr6ay/Mdg/PGZB0ly9xj8h68CX+RLSqi5mlDlqquA7Q69VT1JnpV5Z2VlQOs8ZP2T2ZeLlATJoqf6YrFGNPiSPhD8SoI6Jcbl+W5Cyg6zC2Ut2LFNaWKTLYYLu79YLsE/CgJcmMoUG+hejHTRa+/UjlVJpK75mwhIYZxocCNwsZeLsRwJrRQX2DLF5BfTgRUOLUig1D0ZvjSt+UEz+lc/45KFDdXim11umTcaoKA0mGtPUMbCUK5lzPSHjxhXwvjHjCGYhEY1ucQ36kxGIpzybUpkNdEDoDQTbJpfyeWCm/q75uSE7nDstAKfXLlZvrGsy874WRRQIpvZCqu+xdtCMFQelseL9CLk5HW6VO9D8xF8w5jHWk7P3+rOQerpGw1NZsr32Q+P6141Y9hbHoNP611tZ0yjgxq9fNvipddMwAkgJMpmCEJhIv9ebMLIkcz+NlMiBFbY/4DmJYkNGiA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab7de08-56d1-4413-59dd-08d86125d7e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2020 07:37:23.5166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +VxrYTTzby9iO7MJQU4e3Hf4Ac6En/J53sFSLE7yV2uMB6y1qzapHUt62HP1ZGBkwGkr3I1588QVgqo9p9CxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5781
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

> -----Original Message-----
> From: Felipe Balbi <balbi@kernel.org>
> Sent: Friday, September 25, 2020 12:42 PM
> To: Manish Narani <MNARANI@xilinx.com>; Rob Herring <robh@kernel.org>
> Cc: gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>;
> p.zabel@pengutronix.de; linux-usb@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; git <git@xilinx.com>
> Subject: RE: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add
> documentation for Versal DWC3 Controller
>=20
>=20
> Hi,
>=20
> Manish Narani <MNARANI@xilinx.com> writes:
> > Hi Rob/Felipe,
> >
> > Thanks for the review.
> >
> >> -----Original Message-----
> >> From: Felipe Balbi <balbi@kernel.org>
> >> Sent: Thursday, September 24, 2020 12:47 PM
> >> To: Rob Herring <robh@kernel.org>; Manish Narani
> <MNARANI@xilinx.com>
> >> Cc: gregkh@linuxfoundation.org; Michal Simek <michals@xilinx.com>;
> >> p.zabel@pengutronix.de; linux-usb@vger.kernel.org;
> >> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linu=
x-
> >> kernel@vger.kernel.org; git <git@xilinx.com>
> >> Subject: Re: [PATCH v2 1/2] dt-bindings: usb: dwc3-xilinx: Add
> >> documentation for Versal DWC3 Controller
> >>
> >> Rob Herring <robh@kernel.org> writes:
> >>
> >> > On Thu, Sep 10, 2020 at 12:33:04AM +0530, Manish Narani wrote:
> >> >> Add documentation for Versal DWC3 controller. Add required property
> >> >> 'reg' for the same. Also add optional properties for snps,dwc3.
> >> >>
> >> >> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> >> >> ---
> >> >>  .../devicetree/bindings/usb/dwc3-xilinx.txt   | 20 +++++++++++++++=
++-
> -
> >> >>  1 file changed, 18 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >> b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >> >> index 4aae5b2cef56..219b5780dbee 100644
> >> >> --- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >> >> +++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.txt
> >> >> @@ -1,7 +1,8 @@
> >> >>  Xilinx SuperSpeed DWC3 USB SoC controller
> >> >>
> >> >>  Required properties:
> >> >> -- compatible:	Should contain "xlnx,zynqmp-dwc3"
> >> >> +- compatible:	May contain "xlnx,zynqmp-dwc3" or "xlnx,versal-
> >> dwc3"
> >> >> +- reg:		Base address and length of the register control block
> >> >>  - clocks:	A list of phandles for the clocks listed in clock-names
> >> >>  - clock-names:	Should contain the following:
> >> >>    "bus_clk"	 Master/Core clock, have to be >=3D 125 MHz for SS
> >> >> @@ -13,12 +14,24 @@ Required child node:
> >> >>  A child node must exist to represent the core DWC3 IP block. The
> name of
> >> >>  the node is not important. The content of the node is defined in
> dwc3.txt.
> >> >>
> >> >> +Optional properties for snps,dwc3:
> >> >> +- dma-coherent:	Enable this flag if CCI is enabled in design. Addi=
ng this
> >> >> +		flag configures Global SoC bus Configuration Register and
> >> >> +		Xilinx USB 3.0 IP - USB coherency register to enable CCI.
> >> >> +- snps,enable-hibernation: Add this flag to enable hibernation sup=
port
> >> for
> >> >> +		peripheral mode.
> >> >
> >> > This belongs in the DWC3 binding. It also implies that hibernation i=
s
> >> > not supported by any other DWC3 based platform. Can't this be implie=
d
> by
> >> > the compatible string (in the parent)?
> >
> > Rob, We can move this to dwc3 bindings. If Felipe is okay with below
> response.
> >
> >>
> >> hibernation support is detectable in runtime, and we've been using tha=
t.
> >
> > Felipe, Yes, this flag is to control the enable/disable hibernation.
> > I did not see has_hibernation flag being set anywhere in the driver.
> > Can we control the hibernation enable/disable through DT entry? See
> below:
> > -----
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 2eb34c8b4065..1baf44d8d566 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -769,8 +769,15 @@ static void dwc3_core_setup_global_control(struct
> dwc3 *dwc)
> >                         reg &=3D ~DWC3_GCTL_DSBLCLKGTNG;
> >                 break;
> >         case DWC3_GHWPARAMS1_EN_PWROPT_HIB:
> > -               /* enable hibernation here */
> > -               dwc->nr_scratch =3D
> DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparams4);
> > +               if (!device_property_read_bool(dwc->dev,
> > +                                              "snps,enable-hibernation=
")) {
> > +                       dev_dbg(dwc->dev, "Hibernation not enabled\n");
> > +               } else {
> > +                       /* enable hibernation here */
> > +                       dwc->nr_scratch =3D
> > +
> DWC3_GHWPARAMS4_HIBER_SCRATCHBUFS(hwparams4);
> > +                       dwc->has_hibernation =3D 1;
> > +               }
>=20
> I left it off because I didn't have HW to validate. Don't add a new
> binding for this. Set has_hibernation to true and make sure it
> works. Then send me a patch that sets has_hibernation to true whenever
> DWC3_GHWPARAMS1_EN_PWROPT_HIB is valid.

OK Felipe. I will remove this property from binding. We have validated
Device-mode hibernation on Xilinx ZynqMP and Versal platform. I am
planning to send a separate patch series for hibernation after this.

Thanks,
Manish
