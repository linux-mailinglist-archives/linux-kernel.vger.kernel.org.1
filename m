Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE17F2ACF19
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 06:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731714AbgKJFZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 00:25:42 -0500
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:42062
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726006AbgKJFZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 00:25:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbQZi9/Df+aMA1bVF7nr9ShiS6qT4K/LtL65iN+mNGWd9GIXXITELNv4Fd1K9YDMFXnQ/qbsbScQNGzb5QqBMPAOisiFW3aTKisEXfAUtnxFxvqjZbXSnZQpeBrmy/1+A6mkte4SZEnGp9M7UgNKz5nHH3raAYrWpQL5yEYAgxi2ojoHt1Cr7DK1CGLSyPkrcJPupwtrkq3kZFs6OjJDdeFkT4zpaOa21A1eM5+zwFxjni+Sf7ordMdaaE/SaAKHabkt9a6gw+Ffjq32SFX9dyFLxesDlaB6d07czwdVfFN/S/g02xEWLBrXDV9I+F5Rm4w2gVzMCYk97Y+k9Fibfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s23rksbYToqExaMxax0IXkfBtWpCmVJD+rl/a2OLv0w=;
 b=Fq1u/6gToJ3ehZzrvwCIJGligrx7u5s+uN+QQALPxeK3xgYQKejsx+Cju/Qke6F9JvJKXr8HG7RydzOoWDCFG0JgcmRkgFaXG3h1GGSEq23f7JeG7djnsnVQtyc8ue3MVXe+crp6dMYz3og8mGPJT/7oDMVLkZwo8a+xm2/fxOd3b7HBIV/lZW8/5GP8QKaejd0ewc4bnGWdXWb++Xo7Cr1/xdNM050Y/tQrbQGVvo1QZDM1RkUjX8n25nEtksIAwfFV7SiFaSrHXJg+axAbMQVaCtqP/YnK7a0lPATNzrg9j3uKfOFwvqWm+bc44HJ3F9oHRQpgoc0+u49yUV5Azw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s23rksbYToqExaMxax0IXkfBtWpCmVJD+rl/a2OLv0w=;
 b=VGDd+6EMxMJuS68mGctrAlWhibRQkp3h/QiA8IDVENCPN0yRH0lSyo178jDLQdsMUNfLGOFpvVzV4eYgMQFue5087HpxiJ4b7Ga3g6xtp7i+fak9cOHHyj2ad8PZ8UzfultH78HMi5HpAg/OGh3xEE+pKfJh0q1VVIG/6adM5Yc=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB3PR0402MB3914.eurprd04.prod.outlook.com (2603:10a6:8:f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 05:25:36 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 05:25:36 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>, Alice Guo <alice.guo@nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "krzk@kernel.org" <krzk@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Topic: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Index: AQHWs0T5AYeWl/nLbkatOQvGj0W++KnAMZOAgACrTQA=
Date:   Tue, 10 Nov 2020 05:25:35 +0000
Message-ID: <DB6PR0402MB27604BD713C4A9EF197AB61788E90@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20201105072629.24175-1-alice.guo@nxp.com>
 <20201109191059.GA1599099@bogus>
In-Reply-To: <20201109191059.GA1599099@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ae3599ca-f4cf-45af-0289-08d885390d9b
x-ms-traffictypediagnostic: DB3PR0402MB3914:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB391410F62667BE7B7FC8599488E90@DB3PR0402MB3914.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wo6Tvp4oYV/f4dgluVEo09hyVIiKIw0uejaLVufZ5u35tAiWGakTebUldeJFruVdYNGZ5+AWqrj52tYG618GMFwMOlc/AOsbD++zSd25zk7v6H0y0GSdqcsNP4iID8IcJ0WZeeT/CLWClQIBK5sYjvMJX370t8qoHY7oO8KhpjLvqd0RKoKPElM+riqHonVQx6xfnqUS6O3Z8omaDI/HsIDikt/ittDX31rnGOhKvX+afZykWllXOuL9m5x+CfAGuIx4LzrDBeOHui9Gpx0SWbi8bNNDqtuGA801/ps30JPnbKNficx6niqSzVwn16iWMvCKI+SODS0js+VRFflyXSl/XAckahc2tiNLP9WkHA8lnD52CcWtufaHXPe/kWfd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(8936002)(9686003)(33656002)(6636002)(66446008)(64756008)(4326008)(316002)(26005)(186003)(54906003)(8676002)(5660300002)(478600001)(86362001)(6506007)(71200400001)(44832011)(52536014)(2906002)(55016002)(76116006)(66556008)(110136005)(66946007)(66476007)(7696005)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jR32VgjATtc4sSHQ9HgT12Ut1kzRcCP5xa57LbM7SKMl3PsKd8FbLYOcIJG3gwaERngc7zUR2bgq85m0a7iWJYdLphy/3IbXmEws3uXNe5DJ6HZ/XFhCvhC069DZIF/SJLl7jvLHKnHk55yfzObPLAAfua8ZAKPaNyJzrvhcwJTL+tlDtfaXLkMTtgWSDPXmU7pm+UkCr0ngR5UBe8wORNt9kW8+RZFD29TlwJNgr/xKbyeLtaOOz931IB43sHHj30BFcWVsAbmvcl+KN4+VX9KiAgTx4KLbQsDvnL/y+r5CxLD2kFVX/0qelg/Ww7ng5CyuMIKnWtVJ9tW3hl8uGpZVbrDmIn/WrMaPseXIdB2L57mnkdJGRRtxMYtus2ATOOm3s1BM+jy/9y/OrT9+ouO8Zc/lv1Y4UFrAK/jfbS2FdE7CzsgZ5Slrrc7WHmkHQ+BQ9kyhw8wZ0OdNok88UHx2MicbZb8xcr+4Uzpnq/+G2FTjjMKVrSmLuqM6vsJWurtjjpJmEBYXiWO7ZrxKd6bK+lYVZ78OgxcT3ZrrU+xYevvnmg0iTJ32N4lcTccLNjrXRCQwwXRENpAIPiukaKOd9+H1jQoZ60/6RWwfupIUD2aZIJ4TX3EQDQo+KTVNnq1RYeSki/uLfBzGwmGDcQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3599ca-f4cf-45af-0289-08d885390d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 05:25:35.9428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p4PgGWmXvN3kYgwQdCF1vwCJU9b7VdtLGIYi2oQRnOb3MfO3fiblpBO/GhWv7OV7sIiz3goaXB6f0HeChVaLOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3914
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding doc f=
or
> soc unique ID
>=20
> On Thu, Nov 05, 2020 at 03:26:26PM +0800, Alice Guo wrote:
> > Add DT Binding doc for the Unique ID of i.MX 8M series.
> >
> > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > ---
> >  .../devicetree/bindings/arm/fsl.yaml          | 33
> +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml
> b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index e4db0f9ed664..0419f078502b 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -901,6 +901,39 @@ properties:
> >                - fsl,s32v234-evb           # S32V234-EVB2
> Customer Evaluation Board
> >            - const: fsl,s32v234
> >
> > +  soc:
> > +    description:
> > +      i.MX8M Family SoC must provide a soc node in the root of the
> device tree,
> > +      representing the System-on-Chip since these test chips are rathe=
r
> complex.
> > +    type: object
> > +    properties:
> > +      compatible:
> > +        oneOf:
> > +          - items:
> > +              - const: fsl,imx8mm-soc
> > +              - const: simple-bus
> > +          - items:
> > +              - const: fsl,imx8mn-soc
> > +              - const: simple-bus
> > +          - items:
> > +              - const: fsl,imx8mp-soc
> > +              - const: simple-bus
> > +          - items:
> > +              - const: fsl,imx8mq-soc
> > +              - const: simple-bus
>=20
> items:
>   - enum:
>       - fsl,imx8mm-soc
>       - fsl,imx8mn-soc
>       - fsl,imx8mp-soc
>       - fsl,imx8mq-soc
>   - const: simple-bus
>=20
> > +
> > +      nvmem-cells:
> > +        maxItems: 1
> > +        description: Phandle to the SOC Unique ID provided by a nvmem
> node
> > +
> > +      nvmem-cells-names:
> > +        const: soc_unique_id
> > +
> > +    required:
> > +      - compatible
> > +      - nvmem-cells
> > +      - nvmem-cell-names
> > +
>=20
> 'soc' should be required?

The fsl,imx8m[m,n,p,q] already used by root node compatible.
So here could reuse the same compatible string? Or
We add an extra 'soc' here?

Thanks,
Peng.=20

>=20
> >  additionalProperties: true
> >
> >  ...
> > --
> > 2.17.1
> >
