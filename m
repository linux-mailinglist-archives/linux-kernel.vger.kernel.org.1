Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC08B287170
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgJHJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:28:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:52890 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgJHJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:28:23 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0989R0Ee025883;
        Thu, 8 Oct 2020 05:28:07 -0400
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00128a01.pphosted.com with ESMTP id 33xp74x9hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Oct 2020 05:28:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWjcxf7g+E7+IPp6gzwVLKqa1Cfh/5dN5EdJY36ulnVNwMshR+8IaLAVgP+37kMMoGB61dCt+E6obFdgxdS4XbDccSetRLMWm7K5x0sK7sf0s8uEAElYmoOyRAO18vxbnqpmfnKG8ixgu/OnPrvKZoUqiB3DylLyB7+3Q5gOCAGXyMhw30sBr0xp+tUA/Fv93CUZQmC2KL1CvlfZVTMO8O5wO7kZi4VRPHKcX/YMsrJWyyyPr53reVQbm0U9n6uPxt3whnc4z6lifE1YSlX1qu7G3NRNWagLTnqSSdAUXg/VPexwzcDNyqZGrHFgOEFXoqY0rR1zvYMCo4LwiijUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n7gAasOMOw1shsFCjB2MDlqEa6T/O4df+aiVBdu/3A=;
 b=EVhznFG4Yp4e8S4CerCNLcy5Ldz+WOhl0E0PlBLHUYp3/MmpTJFWY7//8YO2yVSZ3FrNh7O3cM7bjxwtt2VrxaMsUCYzwEW/Iei293QuA4a+mvzZQBc5uDFJ1X16PUJ933haBqrvKvC4/HfTbPHCAoHYguCXY2HzFB5qcVXM2LAxl7vQbSORm7hYef/JWTB3hMQhqxRdF15/JT+1Wn+kpv6kTQO+LYjrTSqQH6/6SY2dV7FF7sU5EuW/QIgvUnPm4ptTo/IECitEoDwtJFI37nPM9NR0BDPA0lRgVjXA4KIk0fU7I3AYDknP1d4/T68Mn9wpVsATVaG1aT5iGZeJMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n7gAasOMOw1shsFCjB2MDlqEa6T/O4df+aiVBdu/3A=;
 b=AnTQA9nnFfwPE4LLsDZxe/s1ZxU3lheUn+nkIeL6Z/n9ORRI8VASVK1gKHwjBf0jsHOCWJ8jcfcFumV8O9wskM4l1HMYD7M9K7kqu1rRpSurVyIAktp+PIWnr6ekgCjaKnAsvruG5uDczJVs2qZSUlEtrP3/5Tq3INaSrcijk24=
Received: from DM6PR03MB4411.namprd03.prod.outlook.com (2603:10b6:5:10f::14)
 by DM6PR03MB5130.namprd03.prod.outlook.com (2603:10b6:5:1e3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Thu, 8 Oct
 2020 09:28:04 +0000
Received: from DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f457:143e:f83b:26cf]) by DM6PR03MB4411.namprd03.prod.outlook.com
 ([fe80::f457:143e:f83b:26cf%4]) with mapi id 15.20.3433.046; Thu, 8 Oct 2020
 09:28:04 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "ardeleanalex@gmail.com" <ardeleanalex@gmail.com>
Subject: RE: [PATCH] dt-bindings: clock: adi,axi-clkgen: convert old binding
 to yaml format
Thread-Topic: [PATCH] dt-bindings: clock: adi,axi-clkgen: convert old binding
 to yaml format
Thread-Index: AQHWl89UuvXdY5bmPEyPgI4kiypprqmLDduAgAJro8A=
Date:   Thu, 8 Oct 2020 09:28:03 +0000
Message-ID: <DM6PR03MB441199FB58D492BE288D3E6CF90B0@DM6PR03MB4411.namprd03.prod.outlook.com>
References: <20201001085035.82938-1-alexandru.ardelean@analog.com>
 <20201006202449.GA2769322@bogus>
In-Reply-To: <20201006202449.GA2769322@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWFyZGVsZWFc?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy04ODE4MGY3NS0wOTQ4LTExZWItYTU5OC00MTU2?=
 =?us-ascii?Q?NDUwMDAwMzBcYW1lLXRlc3RcODgxODBmNzctMDk0OC0xMWViLWE1OTgtNDE1?=
 =?us-ascii?Q?NjQ1MDAwMDMwYm9keS50eHQiIHN6PSI1NjAxIiB0PSIxMzI0NjYyMjg3MDA2?=
 =?us-ascii?Q?NjE4MTUiIGg9ImRPWFlydDIycDMwVzVUT0p5K1B1MWF3S1NjVT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUVvQ0FB?=
 =?us-ascii?Q?QTNTSEJLVlozV0FYZi92ODd0MHFEYWQvKy96dTNTb05vREFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBS1ZJV2JnQUFBQUFBQUFBQUFBQUFBSjRBQUFCaEFHUUFh?=
 =?us-ascii?Q?UUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QUc4QWFnQmxBR01BZEFCekFG?=
 =?us-ascii?Q?OEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFhUUIwQUdrQWRnQmxBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR0VBWkFCcEFGOEFjd0JsQUdNQWRR?=
 =?us-ascii?Q?QnlBR1VBWHdCd0FISUFid0JxQUdVQVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURF?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVlRQmtBR2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dC?=
 =?us-ascii?Q?dkFHb0FaUUJqQUhRQWN3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21l?=
 =?us-ascii?Q?dGE+?=
x-dg-rorf: true
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=analog.com;
x-originating-ip: [188.27.128.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8f9c9a9d-1e62-49ab-63e9-08d86b6c7538
x-ms-traffictypediagnostic: DM6PR03MB5130:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR03MB51304189370520EE8CAA8A3FF90B0@DM6PR03MB5130.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TmMf1PXksnVbIjwlH/QwYYEB9h1UlSza4K9MWVSa4Ex7mfS4ar5Wq3FV6T7NJw0/9+MrZ4pFb6r0cV2FD6jVx9B5A05CKYknHRqUSJfYzBJHO/fzZdfkeqmFdsjW231tQoX1zH+WR/9TfH70dTrnA8TKkW1FSpuc6jOcPp158iBwcijf4rkO3X1/ZqKVz5MLO8YgklIW28Z52SncbzypDjETFlsNKxiDeHE6vy744MnSHT1rn+vYgKJmqrviXqG86S91nV5BTp8C/+hbFqD0P0P1/XcvYX/39xKvoTB5pKPL1jrsWZcnF1FDnBtha2ltPLPYmSn5kXgOpD0Bh0xe/lwjA4tNv/efqv7LqXXn82wn3JSkyIK2bv4SBx+i2A3higoZqfzD82a7bF+MQSKGPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4411.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(186003)(66446008)(76116006)(4326008)(71200400001)(64756008)(66556008)(7696005)(66946007)(5660300002)(316002)(66476007)(9686003)(53546011)(26005)(6916009)(83080400001)(54906003)(2906002)(52536014)(8936002)(55016002)(6506007)(86362001)(83380400001)(966005)(8676002)(478600001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VIvFdx+OkcLzZZhzPl3/SeBAmMmyjA7o4yS8Aon0yW+LbevE1g/CWaxmVqVTb6oTCtLhsUAuj6wLgc3HEtXrKkGUGL6iJWHwabaUaGaFgWmtnNndS9n+OsRpVLljrzvGHMzDwRR5pX0aBotHD4AV8nudgWkO7dkz8Jrmkas9In8UxGMRg9dB2vSJNYgtWJ/Ipgklv2nFpLQsv6fHjw1e5lkpPIXKcpAhO0Qor1TVXJrs1DhGRNEN6oA6kkruqK9SgaJCfXjVDu5raOsX4/SUhMBBkzNw6n8zVOl2+bMpP8JoO9HjH5Qd9j3v5t3LzdRzdD0UEr8HyfOh4tXF47smEaqqi3IJ9IfvIbFvzLb65xau4iMEVMNRy2Wl72PBIw4H2nGyBGKJA1HgatFs9/6h5JtLXB54aN1t5z9FQz7bnQf4PEx42Ox4y8LE9rHY7hg3U07OMZkhCuhog1AimX7tnigRVEkcQyRRx5E9+5I1pnSD71MZ9IsMoNiAcxhvQxUrR3ojhZFN/j5BRC0qFcZD5eXwhB2shGcrFGOwtavcBG5fGSglsrkDSnk1eY8T4Ee7EKVSjUItLz2Sxcj2qXVQOaYqq26N/sSudskiVn09RSxa+2lMx1z4GvNxKC1Agb5Y59mZBNBqrbmdNeFIFf1zfg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4411.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f9c9a9d-1e62-49ab-63e9-08d86b6c7538
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 09:28:03.8146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 10a4BTyDl61taO3ykA4xnxDV0wXeiVMq+5JKWrRJOoQLkOlRyLmrXzjP2E0KISJ7YyuW6F+Hq0Err+9dYEGeQ0dQ7YnqH8EDZFtX3O+xbKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5130
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-08_04:2020-10-08,2020-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, October 6, 2020 11:25 PM
> To: Ardelean, Alexandru <alexandru.Ardelean@analog.com>
> Cc: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; Hennerich, Michael
> <Michael.Hennerich@analog.com>; lars@metafoo.de; sboyd@kernel.org;
> mturquette@baylibre.com; mdf@kernel.org
> Subject: Re: [PATCH] dt-bindings: clock: adi,axi-clkgen: convert old bind=
ing to
> yaml format
>=20
> On Thu, Oct 01, 2020 at 11:50:35AM +0300, Alexandru Ardelean wrote:
> > This change converts the old binding for the AXI clkgen driver to a
> > yaml format.
> >
> > As maintainers, added:
> >  - Lars-Peter Clausen <lars@metafoo.de> - as original author of driver =
&
> >    binding
>=20
> Do you have permission for relicensing? The default was GPL-2.0.

I talked to Michael Hennerich [he's cc-ed], and we have permission from his=
 side.
I think Lars would need to provide permission as well, as the author.
If we won't have a reply from him [after by some time-frame] I'll leave it =
as GPL-2.0.
I'm a bit clumsy about licensing in general; and I don't care about it all =
that much.

>=20
> >  - Michael Hennerich <michael.hennerich@analog.com> - as supporter of
> >    Analog Devices drivers
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  .../bindings/clock/adi,axi-clkgen.yaml        | 52 +++++++++++++++++++
> >  .../devicetree/bindings/clock/axi-clkgen.txt  | 25 ---------
> >  2 files changed, 52 insertions(+), 25 deletions(-)  create mode
> > 100644 Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> >  delete mode 100644
> > Documentation/devicetree/bindings/clock/axi-clkgen.txt
> >
> > diff --git
> > a/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> > b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> > new file mode 100644
> > index 000000000000..45497f370cb3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/adi,axi-clkgen.yaml
> > @@ -0,0 +1,52 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://urldefense.com/v3/__http://devicetree.org/schemas/clock/adi,a
> > +xi-
> clkgen.yaml*__;Iw!!A3Ni8CS0y2Y!s_aQs5F13Tud7X5wmDjgyOhkPGGpnQgdtN7
> > +apmY8mrX_fgQOlQvZTtRGBSIpmJtDghVa8A$
> > +$schema:
> > +https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.y
> >
> +aml*__;Iw!!A3Ni8CS0y2Y!s_aQs5F13Tud7X5wmDjgyOhkPGGpnQgdtN7apmY8
> mrX_fg
> > +QOlQvZTtRGBSIpmJuCLAwQnQ$
> > +
> > +title: Binding for Analog Devices AXI clkgen pcore clock generator
> > +
> > +maintainers:
> > +  - Lars-Peter Clausen <lars@metafoo.de>
> > +  - Michael Hennerich <michael.hennerich@analog.com>
> > +
> > +description: |
> > +  The axi_clkgen IP core is a software programmable clock generator,
> > +  that can be synthesized on various FPGA platforms.
> > +
> > +  Link: https://wiki.analog.com/resources/fpga/docs/axi_clkgen
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,axi-clkgen-2.00.a
> > +
> > +  clocks:
> > +    description:
> > +      Phandle and clock specifier for the parent clock(s).
>=20
> Drop, that's every 'clocks'.
>=20
> > This must either
> > +      reference one clock if only the first clock input is connected o=
r two
> > +      if both clock inputs are connected. For the later case the clock
> > +      connected to the first input must be specified first.
>=20
> That doesn't really say what the 2 clocks are.
>=20
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  '#clock-cells':
> > +    const: 0
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - '#clock-cells'
>=20
> additionalProperties: false
>=20
> > +
> > +examples:
> > +  - |
> > +    clock@ff000000 {
>=20
> clock-controller@...
>=20
> > +      compatible =3D "adi,axi-clkgen-2.00.a";
> > +      #clock-cells =3D <0>;
> > +      reg =3D <0xff000000 0x1000>;
> > +      clocks =3D <&osc 1>;
> > +    };
> > diff --git a/Documentation/devicetree/bindings/clock/axi-clkgen.txt
> > b/Documentation/devicetree/bindings/clock/axi-clkgen.txt
> > deleted file mode 100644
> > index aca94fe9416f..000000000000
> > --- a/Documentation/devicetree/bindings/clock/axi-clkgen.txt
> > +++ /dev/null
> > @@ -1,25 +0,0 @@
> > -Binding for the axi-clkgen clock generator
> > -
> > -This binding uses the common clock binding[1].
> > -
> > -[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> > -
> > -Required properties:
> > -- compatible : shall be "adi,axi-clkgen-1.00.a" or "adi,axi-clkgen-2.0=
0.a".
> > -- #clock-cells : from common clock binding; Should always be set to 0.
> > -- reg : Address and length of the axi-clkgen register set.
> > -- clocks : Phandle and clock specifier for the parent clock(s). This m=
ust
> > -	either reference one clock if only the first clock input is connected=
 or
> two
> > -	if both clock inputs are connected. For the later case the clock
> connected
> > -	to the first input must be specified first.
> > -
> > -Optional properties:
> > -- clock-output-names : From common clock binding.
> > -
> > -Example:
> > -	clock@ff000000 {
> > -		compatible =3D "adi,axi-clkgen";
> > -		#clock-cells =3D <0>;
> > -		reg =3D <0xff000000 0x1000>;
> > -		clocks =3D <&osc 1>;
> > -	};
> > --
> > 2.17.1
> >
