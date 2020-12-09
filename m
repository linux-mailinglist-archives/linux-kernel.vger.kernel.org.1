Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD02D3A16
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgLIFG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:06:56 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:58753
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbgLIFG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:06:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8USPr9UBs5zjGkKE2Mhp0U7XOfNaHAmLyfHGxM0S2YDX6Knf4EWwWoONebwC9iITJdmjQCfDld/0T4w+tVlobq/oBsfNwwKUdS9fZkuij3STQ0w6CuVqTZE1I2gh+ysDEloBMINeIGs3MzhlCJkef4/pQ6wCfKuZr147jIe76KSAP4AGo0nc+eB9H6qj8jSdaBcyO2Xl6OXtqehgvqAE8ar+7JpYttOnJ+BPMoEXDBPC3jnAFjSn/0ier1SafOoXzzgpbe/L9YDICT+vJvsJibpDa3lxV79iUk9EzO3o7JGjFhKDVFXON/Q1cTSZrgTPQZP9xq0fJUx9TJ74eglYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p805tCp2TUAnR3/njo4dwJs7iOJBYmBOaz98gOp0laU=;
 b=E5ZE5PqQytZzx6oNqeNn1xs4i4l1rDv9hDTh2ZhmwvQyM6ImPQmlTKr6s39BxJW9vRpCiiMgcpWTl1oT/stRM+ENRMFujegrXlMEZkmeGXGPbEclbn6Fbph06AaN02PYj8ta/11Fxu4xWr2SjxAm1XQt9Rp9J2/3hg/GjPRhqGhazXx3hnO+P7pdQgCY+aoOowc6UY5BwkBFR5jcKYLjAimkbOzb0mA6Qnb6q+oywEgs2EpLWfPoYtFN+3x+3J7hbYDZEcAkEtHKWRAYrFl4shS/xvZeJyUpMiHusRBkC8YgTbl/g6V68CCGRxe67f9fjPl1/0NUg8mpNV5mbjgliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=openfive.com; dmarc=pass action=none header.from=openfive.com;
 dkim=pass header.d=openfive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osportal.onmicrosoft.com; s=selector2-osportal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p805tCp2TUAnR3/njo4dwJs7iOJBYmBOaz98gOp0laU=;
 b=QRxvglH+HBxYKEDgoKiRqXN+eVSZ0RChL10w489zhLIhUiO45TsyzIyJeF9NWjSJK8UidzepBiPHm9z5rh5KNbSAYcZoXokfTCflyesmeQcggbAkhl06dc/gVL+CJg82/1p4T13BxxftwclqspbRj9MQoqzQVPbIOaAsm5I6zL8=
Received: from BY5PR13MB4453.namprd13.prod.outlook.com (2603:10b6:a03:1d1::19)
 by BY5PR13MB4471.namprd13.prod.outlook.com (2603:10b6:a03:1db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.9; Wed, 9 Dec
 2020 05:06:02 +0000
Received: from BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae]) by BY5PR13MB4453.namprd13.prod.outlook.com
 ([fe80::7c13:1ac6:9f2a:5eae%8]) with mapi id 15.20.3654.012; Wed, 9 Dec 2020
 05:06:01 +0000
From:   Yash Shah <yash.shah@openfive.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "wsa@kernel.org" <wsa@kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@openfive.com>,
        Sachin Ghadi <sachin.ghadi@openfive.com>
Subject: RE: [PATCH v2 1/2] RISC-V: Update l2 cache DT documentation to add
 support for SiFive FU740
Thread-Topic: [PATCH v2 1/2] RISC-V: Update l2 cache DT documentation to add
 support for SiFive FU740
Thread-Index: AQHWxtu9bQuNh+qvKEyj5EgsQbzkSant5A2AgABWksA=
Date:   Wed, 9 Dec 2020 05:06:01 +0000
Message-ID: <BY5PR13MB445346E7FA969CC485B2A8CA82CC0@BY5PR13MB4453.namprd13.prod.outlook.com>
References: <1606714984-16593-1-git-send-email-yash.shah@sifive.com>
 <20201208232141.GA3292265@robh.at.kernel.org>
In-Reply-To: <20201208232141.GA3292265@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=openfive.com;
x-originating-ip: [103.109.13.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c33ca181-1a07-4f6e-066a-08d89c001fc1
x-ms-traffictypediagnostic: BY5PR13MB4471:
x-ld-processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR13MB4471020AF79C488D8B8AED5882CC0@BY5PR13MB4471.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oibhql9I/NzFlxrui5afJHwvuezfPmPguFg6IvEwAbJksknDpitFZ8bDVHpweksf4a+ai5Iq+AI3S5MVxX8xXlpx4uPluKfFrYVf47mR2H7u67FkYSEcHgTvmWUCQqfdOpzPVBNLUdtLkZlgg9u5C9sbCnqJHJD3Y2LJjjmQL0fQGLaf8Z4HPc02Z0uZx/nL77vmq74EJt0EXv2CW6FEnkqfoX0Tu9grXkHyPLvjmQMiLtY75bBZw6Y2VVtluhyEYIjWb+NPy9jMwxsUQO17fOxZwroH/5VfoXqAdS8kZ54S1JakCOMtC+XHg3PyGZ3g9rjYtYRICkqrFn6enE2EfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR13MB4453.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(366004)(346002)(376002)(136003)(52536014)(55016002)(66446008)(107886003)(15650500001)(2906002)(508600001)(8676002)(7416002)(53546011)(83380400001)(86362001)(26005)(33656002)(76116006)(6506007)(4326008)(66946007)(54906003)(6916009)(5660300002)(9686003)(186003)(66556008)(8936002)(71200400001)(44832011)(64756008)(66476007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ypD3urPrEIOUSr1lVsyCuXwXBkYYKVOxy4I00+AnWCLBpygOZHUTnGxGkWQx?=
 =?us-ascii?Q?9k1rsQiHuoged1wTmIS/mU4xEg9pJCPj0bJO4DGxsLV3nlzejWtUasnJwxoe?=
 =?us-ascii?Q?H67Pdfej0GsFvoIqBQSCZB93eudSzz0U9VVl6OTwEQEs+ztqslJk+/ixVdSr?=
 =?us-ascii?Q?IXKlq6riPWqPK8MH8Cl3VsuseqOdyHFTHjLKNx7BxCnwXpivcIz5zODCpBlz?=
 =?us-ascii?Q?xFNkop1eeAyU3JPmO5FPP2hHMzq+b6Gtf29EnMC6ZplW0uwei98tPKnHOfM+?=
 =?us-ascii?Q?iyULiUbYb2wuhnAyTl0zu3E6l+X/kvhRWoTr0NAORXw9juGZ0p/zJpnUzk3F?=
 =?us-ascii?Q?XQa5T4MUXPbSGcgm+6tUrO0snpzbuZXi6t30+VYZPab2JMOvXu4Dtxlvn2F/?=
 =?us-ascii?Q?dRDbwItYqAJ0yTSBSzuiZ6NFhk3oY+bw+XS4mtY264hwgqWMEvwpc+um4eZ5?=
 =?us-ascii?Q?0PtUkv3vJv8XBT0nEcZvJQkIqCI/dllaCSeSOLWqkWVbZwFY5UwpRnSEujKT?=
 =?us-ascii?Q?gC88H/woyGfWFLPj0al/qlSFrGsldCtzCcvfKV5aCm1vYfxpqmi75xPUssmS?=
 =?us-ascii?Q?ThZIUM9gC/9zcRdZr6pqtN76ZzpueTq7Eg1Ba1fx5srZn/Svz9JoVumxQcxj?=
 =?us-ascii?Q?WuEwmJdNlSe1DHpZSt0VOblpFUtCvm6KUUFxNJsyWrjhkA7fk9jUiGg9FCvY?=
 =?us-ascii?Q?DqWHR5bJ9VTD+YCuA5yaJBJV3mhnXCWnz6tzYAciY1jW/ejcIFo4TEYKz69r?=
 =?us-ascii?Q?FRxEavYftcXHZGe4Hyn0Ual3q/03KdnnGHmXqQ3gXmj2e2iGcH/XTdL5fD7P?=
 =?us-ascii?Q?7Bj2dU349zUW2FHmHdnAoEwcLT+FezFkNP9bvioWP0gdG7eKRn1bJy71hLbu?=
 =?us-ascii?Q?0J7jJbzDV9GTWBzgOdwz1CdIfE/KKylgesZhktWr1uoHKl6rWYCP5enH0gG4?=
 =?us-ascii?Q?HRJzmJSpg7V3AMTVzU5tXYoGDGDXPk04GdC6662srOc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: openfive.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR13MB4453.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33ca181-1a07-4f6e-066a-08d89c001fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2020 05:06:01.7929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lHWwA7HvbZc030riZxta7xexmVkPmozMUKV8G0F8jT3RN/AGJMM+Vlqi6yrbk8nzhF4pOso/YRq0HRAo5yjiOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR13MB4471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: 09 December 2020 04:52
> To: Yash Shah <yash.shah@openfive.com>
> Cc: linux-kernel@vger.kernel.org; linux-riscv@lists.infradead.org;
> devicetree@vger.kernel.org; bp@suse.de; anup@brainfault.org;
> Jonathan.Cameron@huawei.com; wsa@kernel.org; sam@ravnborg.org;
> aou@eecs.berkeley.edu; palmer@dabbelt.com; Paul Walmsley ( Sifive)
> <paul.walmsley@sifive.com>; Sagar Kadam <sagar.kadam@openfive.com>;
> Sachin Ghadi <sachin.ghadi@openfive.com>
> Subject: Re: [PATCH v2 1/2] RISC-V: Update l2 cache DT documentation to
> add support for SiFive FU740
>=20
> [External Email] Do not click links or attachments unless you recognize t=
he
> sender and know the content is safe
>=20
> On Mon, Nov 30, 2020 at 11:13:03AM +0530, Yash Shah wrote:
> > The L2 cache controller in SiFive FU740 has 4 ECC interrupt sources as
> > compared to 3 in FU540. Update the DT documentation accordingly with
> > "compatible" and "interrupt" property changes.
>=20
> 'dt-bindings: riscv: ...' for the subject.
>=20
> >
> > Signed-off-by: Yash Shah <yash.shah@sifive.com>
> > ---
> > Changes in v2:
> > - Changes as per Rob Herring's request on v1
> > ---
> >  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 35
> > ++++++++++++++++++++--
> >  1 file changed, 32 insertions(+), 3 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > index efc0198..749265c 100644
> > --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > @@ -27,6 +27,7 @@ select:
> >        items:
> >          - enum:
> >              - sifive,fu540-c000-ccache
> > +            - sifive,fu740-c000-ccache
> >
> >    required:
> >      - compatible
> > @@ -34,7 +35,9 @@ select:
> >  properties:
> >    compatible:
> >      items:
> > -      - const: sifive,fu540-c000-ccache
> > +      - enum:
> > +          - sifive,fu540-c000-ccache
> > +          - sifive,fu740-c000-ccache
> >        - const: cache
> >
> >    cache-block-size:
> > @@ -53,9 +56,15 @@ properties:
> >
> >    interrupts:
> >      description: |
> > -      Must contain entries for DirError, DataError and DataFail signal=
s.
> > +      Must contain 3 entries for FU540 (DirError, DataError and DataFa=
il) or
> 4
> > +      entries for other chips (DirError, DirFail, DataError, DataFail
> > + signals)
>=20
> While below is wrong, don't give descriptions that just repeat what the
> schema says.

Ok will remove the above description.

>=20
> >      minItems: 3
> > -    maxItems: 3
> > +    maxItems: 4
> > +    items:
> > +      - description: DirError interrupt
> > +      - description: DirFail interrupt
> > +      - description: DataError interrupt
> > +      - description: DataFail interrupt
>=20
> This says DataFail is optional.

I will move back to your initial suggestion to add the new entry "DirFail" =
as the last index to keep the order same.
Will make the corresponding changes in the driver and send a v3 patch.

Thanks for your review.

- Yash

