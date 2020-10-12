Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3666928B47C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgJLMTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:19:03 -0400
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:21185
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388209AbgJLMTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:19:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cveKYzI6etJjVVlcjUBTniJ2RfgKvANaRjN83b7/Wl0pdGNh4WF4pyNL0SYiEhWI4V8Vi3E2I+rzlb8GLFS+/Eqk20niSRt+C8ccTEXhUPssVYxjvpMwkEw5qmv7mdpuA0xVtQ2IgKF5CvaDNsO/SNI4q2y8gDI+lVdqDvLBbeW0t3u9sENNH12kQ++yrG034fhDPDiF6C6dOJilcsRPYg03aRo1ZptLghsSB/RE/a5MQjQ8TDNtzMyGp21dU+ZgbTaInUdW6fNEgM0KNYaaVrjrk61Pf3vOKzP0Vzlj+lyVFoTd1tCcfaUVxIKgLJtHg9eeFP7WlDBqEUEvPSOQgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK9nT0VAkMgVHImm4RxVVZwLs4SjW1Q2woP1FLDHXXc=;
 b=iLs2p8o8Fi7XG9SoHZ9G7x/8f3JH8E14TWLE1pqyFFNXmsTK6WqMN47im8XJmLyrBeI/vsOq7dAur0+XzO7DcorASghfiTlO7Xu0csT4nGr9jh06VbIChQ0iPMEb6tIidd6XvvMe2egIoPQ9M7TwOTMOgCtE+uS4mkoLY4tfzHFp/N/HvLsTq0TDh1Q/6YAYxG9pUprN9NHJDfUSUkugLTxdExswS7oawejXFm1gKTdpkQKFKBHSs26NCYfEv1Wey7ppKm6xRDhxmVqOawN204EobdaYR9aQJKLdS4LGRpoCx8JN7xb1OdIilD0smVdwQfsulM0WP50lATnWiRuQrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK9nT0VAkMgVHImm4RxVVZwLs4SjW1Q2woP1FLDHXXc=;
 b=sSbHNQUI3JsRiENIAXTSOj1D5bw0YRKH8uBhCOLTZx8/+hZRmBdhiSIR8qHOmHxGpmOgVcoEj/FuxJaRJOyp8K6OKnv7IOWASAX0e20lEuwxuCp1c4pna83GQem2sPRqgBwxM4VUzjXVkIDfAn83/o6EiRy7yuj/iTOuRMfYERg=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM8PR04MB7859.eurprd04.prod.outlook.com (2603:10a6:20b:24c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.30; Mon, 12 Oct
 2020 12:18:59 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::ad01:9b1c:3b4b:3a77%7]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 12:18:59 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     Pawel Laszczak <pawell@cadence.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rahul Kumar <kurahul@cadence.com>
Subject: Re: [PATCH v2] usb: cdns3: Rids of duplicate error message
Thread-Topic: [PATCH v2] usb: cdns3: Rids of duplicate error message
Thread-Index: AQHWoGM50wbXYw0KR0uXLh7D+U1lm6mTnxYAgAAxQYCAAAc7AIAAC0EA
Date:   Mon, 12 Oct 2020 12:18:59 +0000
Message-ID: <20201012121831.GA17965@b29397-desktop>
References: <20201012064256.8344-1-pawell@cadence.com>
 <e5ab2110-6bb0-ce06-be4f-010a030e307f@ti.com>
 <DM6PR07MB5529E8B3EC059F7DA43EEC25DD070@DM6PR07MB5529.namprd07.prod.outlook.com>
 <ab93c402-f721-d780-654b-7b74bc5b2ab1@ti.com>
In-Reply-To: <ab93c402-f721-d780-654b-7b74bc5b2ab1@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 950a87fc-d40c-4b53-eb31-08d86ea8ff87
x-ms-traffictypediagnostic: AM8PR04MB7859:
x-microsoft-antispam-prvs: <AM8PR04MB785953AE0219F9C14DF3E82E8B070@AM8PR04MB7859.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JHlxOydqnqTEvRB9RerXA13s26qtgxDS5AmFIQEHhMw+iUa8aKvWPjCKZvCfGIpo+HRsOc/cI/qVfiTrsHyTjagWJfzNYwI6gDium8vzMgi/PxYIilJuq9m5Wv2k1iw6gdyic3c9kw1HK5szjb5YKqmHy6Fc/uG3tkTs3YbJPQDmb0VJSWT02Uf2CcNDfUvlImhB2L4dC3ZGZYf8aSJvppYMA/E0yHw04pFigjLKI0Iy4R3jp0HDCENJR+Vx1pGgCvZaISzv1+wlGZzGoxsJLatLIbmDdEZe4i7tqLKry/PHq+Wn33Xni0m5vr6GrSfzGBj6K1ankf5Q8UqcVxWmeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(33656002)(316002)(83380400001)(8676002)(54906003)(33716001)(86362001)(8936002)(44832011)(66476007)(478600001)(66446008)(5660300002)(66946007)(6916009)(66556008)(186003)(64756008)(76116006)(15650500001)(91956017)(71200400001)(26005)(6512007)(9686003)(53546011)(6486002)(4326008)(6506007)(1076003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Cb/gTV19vYoIe22prA0OakL5iBjsuFrkReZtgcmi/zvuAgtXZVL0uuiVtnh29zzTBFjOPpcHELaRkPi/ivdt/d2y0xnG5++w5kHla/Nj9tIm14DqBiVOBo0c3KkTlnWflf+DZpDVKqBTMbawDz93qDhqOC4J5CzyzntEv7IiOK5OGtVb4qiIK6cCs0p057SbPTUgZR4KEMCwdMtcHU/kPQ2OCTxMv4vyYX0fcvsHiC9N1iBocB2e6f7s8uZQh+yBtLcL4UTdhnYIZpxae6yIcLwZNkddtqsbqN1wAxwPfgFCNfnZMf3M46r+gmHNt0VTmtfy3nB92LzkjDxBFFyZk8MB830Tp7JarwZK43T+T7SMJGT/95bWXSJn/XvhpdKOQ7dhY/qQtp8BZPB8NYFouw3kGQcFIAsXEuaWYR4VF3xeYRMZxkOnzaHaImcuEVytTqNwtN425YF88WK+MZ9AyVkIrafCiCa4AXlHIV37j1OVzo59xK/Y2jBbWkXYhKDKgam4sQ7kGP1x0Te+ptoAmgX1ytp0Cb4Z6SjfQDhQ3mBm3WWFUaJL3TQ1hOsJYt9n/fBkiW0Yo8ezlFYTA0+34q77X/s0Ko1+GNJGnb1TIL4XfkvU7LO+XozqTOd+opjJkOgV5M6/qj3iEeeA4iSbzQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <712824E1DD877042ADA5EA66AD44925E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950a87fc-d40c-4b53-eb31-08d86ea8ff87
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 12:18:59.2498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WzCJ01IVWzjtxPr7CYcx/Lsdi8yAVFJzlnN09q17axOA+qqugXpUtvbv7MF3NQAx4AU+i2YRqC61pDwBcwp7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7859
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-12 14:38:16, Roger Quadros wrote:
> Pawel,
>=20
> On 12/10/2020 14:12, Pawel Laszczak wrote:
> > Hi Roger,
> >=20
> > On 12/10/2020 09:42, Pawel Laszczak wrote:
> > > On failure, the platform_get_irq_byname prints an error message
> > > so, patch removes error message related to this function from
> > > core.c file.
> > >=20
> > > A change was suggested during reviewing CDNSP driver by Chunfeng Yun.
> > >=20
> > > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > > ---
> > > Changelog:
> > > v2
> > > - simplified code as sugested by Roger Quadros.
> > >=20
> > >    drivers/usb/cdns3/core.c | 10 +---------
> > >    1 file changed, 1 insertion(+), 9 deletions(-)
> > >=20
> > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > > index a0f73d4711ae..85ef3025b293 100644
> > > --- a/drivers/usb/cdns3/core.c
> > > +++ b/drivers/usb/cdns3/core.c
> > > @@ -469,22 +469,14 @@ static int cdns3_probe(struct platform_device *=
pdev)
> > >    	if (cdns->dev_irq =3D=3D -EPROBE_DEFER)
> >=20
> > Shouldn't this be
> > 	if (cdns->dev_irq < 0)
> > ?
> >=20
> > No, such line will change the original behavior of driver.
> >=20
> > Current patch allows to run driver when we support only host.
> > In such case the dev_irq can be < 0 and we still can use host  side.
>=20
> In that case should we check if we need dev_irq and if so then error out.
> i.e. if mode is "peripheral" or "otg"
>=20
> Also DT binding document says all 3 IRQs are mandatory. Do we need to upd=
ate that?
>=20

I agree with Roger, or you change the driver behaviour that return error
if the dev_irq is < 0.

Peter
>=20
> >=20
> > Regards,
> > Pawel Laszczak
> >=20
> > >    		return cdns->dev_irq;
> > > -	if (cdns->dev_irq < 0)
> > > -		dev_err(dev, "couldn't get peripheral irq\n");
> > > -
> > >    	regs =3D devm_platform_ioremap_resource_byname(pdev, "dev");
> > >    	if (IS_ERR(regs))
> > >    		return PTR_ERR(regs);
> > >    	cdns->dev_regs	=3D regs;
> > >    	cdns->otg_irq =3D platform_get_irq_byname(pdev, "otg");
> > > -	if (cdns->otg_irq =3D=3D -EPROBE_DEFER)
> > > -		return cdns->otg_irq;
> > > -
> > > -	if (cdns->otg_irq < 0) {
> > > -		dev_err(dev, "couldn't get otg irq\n");
> > > +	if (cdns->otg_irq < 0)
> > >    		return cdns->otg_irq;
> > > -	}
> > >    	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg")=
;
> > >    	if (!res) {
> > >=20
> >=20
>=20
> --=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

--=20

Thanks,
Peter Chen=
