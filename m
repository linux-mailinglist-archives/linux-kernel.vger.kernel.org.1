Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB3E26A93B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbgIOP7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 11:59:01 -0400
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:16193
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbgIOPRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLMccVQrhyUVptAgQxy5LUZ00s6JxHwSKX+o4v3IDYD+oku7SbpxwVTcdw0mouIjZOSimdc60Mfv0G1/ovAQ+vDqvaZGBgdaaewTo7tGoQnWPWnYiuJ1MwVL/b+zoiPrImKLOsrZgp+qyRLiERHKlmANzpKTQHD9CHRUt/08PXk3K0Ns5xMuWedwQsE/rtb0Qyvvv8zwhQAUctEqEo/yePtl3t3VuyfgQirPe8BCJNFusfyn6O60xXqU9nx7d6Gado4vwhxW99zGyoGLi6GLZGQUsVYLObbq3XUiUqhaAwoutGnFqQfWKPrtHAxxIlMZSm27aVg1eDBgHFtQJ+XHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glZJHV2RbPKeIVQWOsT8BukhGAYpaGfFnvb+SdgR1k0=;
 b=QdhwsINdPlV/muyZKjU9VfTWHAzLcf5/ncV8xhrMEEYC14uDpZlH7MgKjVxT1fnIN595SyXnUYBQxbPbTKpPiFp0NFvIqnuP/K9cyIaKGI30PuAw3Bnr1oWMWnpfskKj3oSSLuewetZmdrGcMC1RGvm4Ai5yfdZ7VzIrVNkTo/HsFrWAag6fuBZi8Yxu3QHyfqXovjPmDFzXUknlrZ1MCy5pr6xB64QDtyj108+V7/GlcT857Bm6NmgXxZnlSFW69OJK4lWNHhWPX/TKzFGTDkfmsomfkmbMESTXArlGzXStZF02FoqCJ4kRfVhPojzZEQOcG/WDIKJcOur6Qnj6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glZJHV2RbPKeIVQWOsT8BukhGAYpaGfFnvb+SdgR1k0=;
 b=FYfGDQ2zwqqH8m7+qtEOXACuntRruE1QKgPUHPjy8Pt74BeMreLGyXt61y0Wk+PVXXnVPsTFKZDqrmDZGBd9MZK3O4tcs3wq65YvfUZDiFPZ6rb0DFEyCntMMvYdCUzhdDkQ4pnjKCGZLc6mV8ucF9FbM0mb0U7nyfEHOqYaxmU=
Received: from DM6PR13MB3451.namprd13.prod.outlook.com (2603:10b6:5:1c3::10)
 by DM5PR13MB0939.namprd13.prod.outlook.com (2603:10b6:3:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5; Tue, 15 Sep
 2020 15:17:21 +0000
Received: from DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876]) by DM6PR13MB3451.namprd13.prod.outlook.com
 ([fe80::a48a:1f7c:267c:876%7]) with mapi id 15.20.3391.009; Tue, 15 Sep 2020
 15:17:21 +0000
From:   Sagar Kadam <sagar.kadam@openfive.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@openfive.com>
Subject: RE: [RESEND PATCH v2 1/1] dt-bindings: riscv: sifive-l2-cache:
 convert bindings to json-schema
Thread-Topic: [RESEND PATCH v2 1/1] dt-bindings: riscv: sifive-l2-cache:
 convert bindings to json-schema
Thread-Index: AQHWfVwv7/G+kdFYjkmHoBtHJ2osZKlohwEAgACr26A=
Date:   Tue, 15 Sep 2020 15:17:21 +0000
Message-ID: <DM6PR13MB3451786E8B73D50D36A89FD097200@DM6PR13MB3451.namprd13.prod.outlook.com>
References: <1598633743-1023-1-git-send-email-sagar.kadam@sifive.com>
 <1598633743-1023-2-git-send-email-sagar.kadam@sifive.com>
 <20200914180000.GA4136408@bogus>
In-Reply-To: <20200914180000.GA4136408@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [116.74.150.204]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7ff2e1d-c6e8-4890-fb9a-08d8598a716a
x-ms-traffictypediagnostic: DM5PR13MB0939:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR13MB09391A6203559147B7DD724597200@DM5PR13MB0939.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RaJXK/njbgqsiHop3oNfamTXlNuHGFFrCV+LXYQVUlQoW6/I2/rCkqFd15tbIFN82zNqwFiW23JDOUom4ZawTTF7/K2OxkZ6zz4MT8UdusGz3BfYPoHYd3dRMp5E1fdsTsjuXoFCJRaYug0I0q/AlW3zNy55HQjPvebSEKQYDNxyeCXLhrjMhNBTZ9buJzTZKndjdlMbmbsROwAaThLwLqyQUYrXnOOFQ0jo4NcAUOGybB+XYue5Kig2gyYLbr445EU+goW5d8dp2NnFh1b+QfXsblSThptKhJBemphoLQ1AnK9V3QSoxzP1xLwZadhTmVV8iKR/Kx/HJAhczi3m/jzSaDJOCLlCBUsqEDMxcCAZ1Hg78NPNsVE47fVW5rQCykFWsg7SeT9UopLQGUURn3MOn278YD480fWQNxMxd8It2x6d4W88mp+PwnjGLM7r
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB3451.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(396003)(346002)(366004)(376002)(53546011)(26005)(6506007)(71200400001)(86362001)(55236004)(33656002)(5660300002)(107886003)(52536014)(478600001)(316002)(66946007)(66476007)(54906003)(76116006)(66556008)(55016002)(8936002)(8676002)(64756008)(186003)(9686003)(7696005)(66446008)(2906002)(44832011)(966005)(6916009)(4326008)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wlbCzCkPj29vR095K40sSQWpSVkE+VHW4KAO5rz/5LJWNVnkL/S+ad2SEaZtRNmsWO8Qoiz680MkvRHWOuZkCtjGVYEFJggXUNnl1ik5kjxMmQAPVU1zcmKqdwj3CgRkDfUCl73Y3huW+mmkYvletS3ovNz/EzaUl0Gbw7khCmixeibf75dl9tTWi5gmvJO3/dm/Bf7Y8Selh4yb9YVVtmUZYrq7b7f/agxUgZvrs2acXO5XuimShAFSC1y/rAFai7QmOTxpGg4hSYJJ0FQaA6F3ECnI0NbDu1xyOFOwQyixW6kCrR0G5n8lpTnltsNf+2CqzphSzyddHuPSCW4PzlYw5Bp5beLVEoqqs3l6ln3+YWhf0Zzs2CoCn4D0KprZThNx1wO1i+lw6iDCBTzN0YbBRmwrSgKfsicqhhqnUuh61wskECHxE81yp2vMsafMag+5wQWJ7aYkKpHjI6dPyI8BLwTqX7+H9xqovAdUAWEwAHoRcs0FBzkJ9tKGP9A9+EMtSzJbr/bY9GBej6y0hOxgWXtaB80DHG3G3yzI/E9r1SrUhNz4HXFsn+dMp22xM+BSe0ZLLTC7N2nLhjunfqqT76EX3qrxgR/9/Rs/mQRz5jWaT+mBgrrdzIOgsrkTePSjRF1v8EfDSfyLBCXK/w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR13MB3451.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ff2e1d-c6e8-4890-fb9a-08d8598a716a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2020 15:17:21.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XZP9k5ElRvAQq71eTL8YMJNUdEmqcT8KaNMQxOFYPawtV+KrYw1ZOTLGxuBcEyvmFyiiGfA+wROVuHRRynAVzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR13MB0939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Monday, September 14, 2020 11:30 PM
> To: Sagar Kadam <sagar.kadam@openfive.com>
> Cc: linux-kernel@vger.kernel.org; linux-riscv@lists.infradead.org;
> devicetree@vger.kernel.org; Paul Walmsley ( Sifive)
> <paul.walmsley@sifive.com>; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; Yash Shah <yash.shah@openfive.com>
> Subject: Re: [RESEND PATCH v2 1/1] dt-bindings: riscv: sifive-l2-cache:
> convert bindings to json-schema
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Fri, Aug 28, 2020 at 10:25:43PM +0530, Sagar Kadam wrote:
> > Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2
> Cache
> > controller to YAML format.
> >
> > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> > ---
> >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
> >  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 92
> ++++++++++++++++++++++
> >  2 files changed, 92 insertions(+), 51 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-
> cache.txt
> >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-
> cache.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.tx=
t
> b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > deleted file mode 100644
> > index 73d8f19..0000000
> > --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > +++ /dev/null
> > @@ -1,51 +0,0 @@
> > -SiFive L2 Cache Controller
> > ---------------------------
> > -The SiFive Level 2 Cache Controller is used to provide access to fast
> copies
> > -of memory for masters in a Core Complex. The Level 2 Cache Controller
> also
> > -acts as directory-based coherency manager.
> > -All the properties in ePAPR/DeviceTree specification applies for this
> platform
> > -
> > -Required Properties:
> > ---------------------
> > -- compatible: Should be "sifive,fu540-c000-ccache" and "cache"
> > -
> > -- cache-block-size: Specifies the block size in bytes of the cache.
> > -  Should be 64
> > -
> > -- cache-level: Should be set to 2 for a level 2 cache
> > -
> > -- cache-sets: Specifies the number of associativity sets of the cache.
> > -  Should be 1024
> > -
> > -- cache-size: Specifies the size in bytes of the cache. Should be 2097=
152
> > -
> > -- cache-unified: Specifies the cache is a unified cache
> > -
> > -- interrupts: Must contain 3 entries (DirError, DataError and DataFail
> signals)
> > -
> > -- reg: Physical base address and size of L2 cache controller registers=
 map
> > -
> > -Optional Properties:
> > ---------------------
> > -- next-level-cache: phandle to the next level cache if present.
> > -
> > -- memory-region: reference to the reserved-memory for the L2 Loosely
> Integrated
> > -  Memory region. The reserved memory node should be defined as per
> the bindings
> > -  in reserved-memory.txt
> > -
> > -
> > -Example:
> > -
> > -     cache-controller@2010000 {
> > -             compatible =3D "sifive,fu540-c000-ccache", "cache";
> > -             cache-block-size =3D <64>;
> > -             cache-level =3D <2>;
> > -             cache-sets =3D <1024>;
> > -             cache-size =3D <2097152>;
> > -             cache-unified;
> > -             interrupt-parent =3D <&plic0>;
> > -             interrupts =3D <1 2 3>;
> > -             reg =3D <0x0 0x2010000 0x0 0x1000>;
> > -             next-level-cache =3D <&L25 &L40 &L36>;
> > -             memory-region =3D <&l2_lim>;
> > -     };
> > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.ya=
ml
> b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > new file mode 100644
> > index 0000000..e14c8c6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > @@ -0,0 +1,92 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2020 SiFive, Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: SiFive L2 Cache Controller
> > +
> > +maintainers:
> > +  - Sagar Kadam <sagar.kadam@sifive.com>
> > +  - Yash Shah <yash.shah@sifive.com>
> > +  - Paul Walmsley  <paul.walmsley@sifive.com>
> > +
> > +description:
> > +  The SiFive Level 2 Cache Controller is used to provide access to fas=
t
> copies
> > +  of memory for masters in a Core Complex. The Level 2 Cache Controlle=
r
> also
> > +  acts as directory-based coherency manager.
> > +  All the properties in ePAPR/DeviceTree specification applies for thi=
s
> platform.
> > +
> > +allOf:
> > +  - $ref: /schemas/cache-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +     - enum:
> > +        - sifive,fu540-c000-ccache
> > +    description: |
> > +      Should have "sifive,<soc>-cache" and "cache".
>=20
> That's not what the schema describes or the example has (the 'cache'
> fallback).
>=20
Thanks for your suggestions.=20
I see that if we include the standard 'cache' property here, it injects  er=
ror's in other yaml's as reported here [1]
In plain txt format of this binding the standard "cache" property is mentio=
ned to be also included along with soc specific compatible string.

Please correct me if I am wrong here:
So in order to retain the earlier description as Should have "sifive,<soc>-=
cache" and "cache",  I excluded "cache" property from example
as I assumed it is implied for cacheinfo infrastructure to work properly.
I will retain the earlier description (from.txt) which was "sifive,fu540-c0=
00-ccache" and "cache"
[1] https://patchwork.ozlabs.org/patch/1350111

> > +
> > +  cache-block-size:
> > +    const: 64
> > +
> > +  cache-level:
> > +    const: 2
> > +
> > +  cache-sets:
> > +    const: 1024
> > +
> > +  cache-size:
> > +    const: 2097152
> > +
> > +  cache-unified: true
> > +
> > +  interrupts:
> > +    description: |
> > +      Must contain entries for DirError, DataError and DataFail signal=
s.
> > +    minItems: 1
>=20
> The old doc said must have 3 entries.
Will rectify.
>=20
> > +    maxItems: 3
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: address of cache controller's registers.
>=20
> Drop this.
>=20
Will drop the reg description in next version.
> > +
> > +
>=20
> One blank line please.
>=20
Will address this as well.

> > +  next-level-cache:
> > +    description: |
> > +      Phandle to the next level cache if present.
>=20
> No need to re-describe common properties unless you have something
> unique to this device to say. Just:
>=20
> 'next-level-cache: true'
>=20

Ok. I will remove un-necessary description.

Thanks & BR,
Sagar

> > +
> > +  memory-region:
> > +    description: |
> > +      The reference to the reserved-memory for the L2 Loosely Integrat=
ed
> memory region.
> > +      The reserved memory node should be defined as per the bindings i=
n
> reserved-memory.txt.
> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - cache-block-size
> > +  - cache-level
> > +  - cache-sets
> > +  - cache-size
> > +  - cache-unified
> > +  - interrupts
> > +  - reg
> > +
> > +examples:
> > +  - |
> > +    cache-controller@2010000 {
> > +        compatible =3D "sifive,fu540-c000-ccache";
> > +        cache-block-size =3D <64>;
> > +        cache-level =3D <2>;
> > +        cache-sets =3D <1024>;
> > +        cache-size =3D <2097152>;
> > +        cache-unified;
> > +        reg =3D <0x2010000 0x1000>;
> > +        interrupt-parent =3D <&plic0>;
> > +        interrupts =3D <1 2 3>;
> > +        next-level-cache =3D <&L25>;
> > +        memory-region =3D <&l2_lim>;
> > +    };
> > --
> > 2.7.4
> >
