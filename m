Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9561AB7D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 08:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407306AbgDPGQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 02:16:48 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:58759
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407530AbgDPGQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:16:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWzGuDAPd7zlSSICVvF0+2sR0v77L4i8p6SwLKiAB1tmK3Sk03T2n/mLiICTH5yvXvHkC9Su1YVVosB4DbY+BDqgIdQH5JBXiuOaoLh4pXKZThdWQYoNmcAY+rm1MihtkI3y4WzhbbOCCbzXXwpEZPzFAIehCUYpCwFQt4JK3JwLh+/l0So41HM7iOGSpXEdjwNPxh7xfT2Lnta9IaD+40kqp2jg30UaaKh4c6d6EyTDVak1fo4Hf0f7DG1ETC0tHpFJEDsuvqkHlJVQNmiMHTvUEoL3r2oq0/Mxpz3hi+qHHh0TWnk/K1kdzdFm/TWLm5PDGvDqarDv4Y7bMo13AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fjyfTPX276GIV6J5ZkAEiJKCdZuURyFXqVVKsKed3k=;
 b=V3hL9XMzISBVzF0CxNlDBdnYm+Dsje63dxBnLeBvO+BAmjcK0+DXytvcdsHmR/Rn73ljaeOjoK4rxM577qWdFqGN3OSVqq7Tt/WRaiJ7ngQM2SxrTssSPwEndz10D1Rq4n8ThvnqRPhY+o034rn0ug/oN2Wv8089k/11lIZlJU8/x5hGXOYMfsY3/L1pwlLSxyQuaMXu/mDYGuLYwVMQeaWEvQx7k6VBYEnE4dyne69r40e/H6Ltd67hTT1KH+yPQ16+v95DurwRVlFTvXRFkx6eNaBgurZLdFK6P1TE0tnSoobf8p64RhK0edtlRS0PIqQeY9O4TgodOEhxeAHqQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fjyfTPX276GIV6J5ZkAEiJKCdZuURyFXqVVKsKed3k=;
 b=DCwOWYHROx30qFL0XbPodF+2pGoK2JrLwc9+7EgLpQrY3zQpZ1jzDG9PH1v+1xCs0Zd6b5r7KDmBWwJ2/Vmp/qGl2pZPsp5Xeh8JrvK0mRIadZfNZlB2Pu9+G0jlFTlyJuihSZeGJVTby1J0XAA/KVKKgtacyCMuaWWR6vHrnXk=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB3PR0402MB3755.eurprd04.prod.outlook.com (2603:10a6:8:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Thu, 16 Apr
 2020 06:16:23 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3143:c46:62e4:8a8b%7]) with mapi id 15.20.2900.028; Thu, 16 Apr 2020
 06:16:23 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Thread-Topic: [PATCH 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Thread-Index: AQHWE6hQuNBNfLUpxU+eFy69TbX/iqh7NrqAgAAOwFA=
Date:   Thu, 16 Apr 2020 06:16:23 +0000
Message-ID: <DB3PR0402MB391654AB729CC8E27467E6C1F5D80@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1587011171-24532-1-git-send-email-Anson.Huang@nxp.com>
 <20200416052229.m6ur2coyfg6ef7vz@pengutronix.de>
In-Reply-To: <20200416052229.m6ur2coyfg6ef7vz@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [183.192.13.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9f9eed6e-d5b4-41f2-f091-08d7e1cdb005
x-ms-traffictypediagnostic: DB3PR0402MB3755:|DB3PR0402MB3755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0402MB37554AC1D21A81D0426E1695F5D80@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0375972289
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(66556008)(66446008)(66476007)(66946007)(33656002)(71200400001)(9686003)(76116006)(4326008)(86362001)(44832011)(55016002)(186003)(8676002)(81156014)(54906003)(2906002)(45080400002)(5660300002)(6916009)(6506007)(478600001)(8936002)(53546011)(83080400001)(316002)(26005)(52536014)(7416002)(64756008)(7696005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7RfxUid8/cGrNB1Qr1CeWULeviejqUttJTKj1ZWJ1v6q/ic1Qo2f2Utfz/MYoXrSYvOWJwgEEW4WXWDbxYD5su3bghi3P5MMqLjyu7YBHoHNzhUH9IpOsbSTVRgeW8jBsVs/5IPMfgGxgCxp7q0XG9O75i620NzTUbJSAqBUGm//OgJrexNW1Rnzd2Dcj5H8DOuHk0uK0QO73STgQYZUUNis9ekO/VQNqIrEqayXol0520RkeQxQBjbkMx7NikXRWI6BV6IdYC+xBx23SIyN8pkp4yIOJv7gzp+K0hkQZD6q1gp7+XeXxjExoNb6lXOjCO7g6Zzb9sc6ecU1dg/jTeeF4yKpr3UQoEp35DcLkc2zCeFf+1vmde7HfXcsmv3MARz5PbZYFCxe45X9EYarHZVea/n9IafTTLxk797D3JoRK8f0tNDwPe/yVClTMqCmApwaMWBOR0iMLW2aPQCaIOkimc+Wjss3Q8nzrXE0giy1eEqsTptJQdZve1MHSINlQXbPy6/5DNJacfpb0MXOg==
x-ms-exchange-antispam-messagedata: 7VHUPH0lV8QOX8qXqF0MZ6u9zmmGtyR5MaFT7Cs7DXJ29Kx0GTfG2T+tJznytZwDPle9TBSxQOFJaDpd/r9+kMkGjOhN2oaooF0KXJSIYgosaO0n2OLTEVT/hSaIJwv1VbRJoOxRhieVDeT3bLH/HQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9eed6e-d5b4-41f2-f091-08d7e1cdb005
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2020 06:16:23.2939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4G2jotaQQxGzrbdOKRxxYvU8xwVGEJAwPmAulFiPt6mgyIQa5ku8KnIfAhzXQVfOAMmPHOkXlQcJVYrpO6XivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Marco

> Subject: Re: [PATCH 1/5] dt-bindings: clock: Convert i.MX6Q clock to
> json-schema
>=20
> Hi Anson,
>=20
> thanks for the patch. I have two questions please see inline which applie=
s to all
> patches.
>=20
> On 20-04-16 12:26, Anson Huang wrote:
>=20
> ...
>=20
> > diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > new file mode 100644
> > index 0000000..084d4f0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fschemas%2Fclock%2Fimx6q-clock.yaml%23&amp;data=3D02%7C
> 01%7
> >
> +Canson.huang%40nxp.com%7Cf07db2c34e834628725208d7e1c63083%7C6
> 86ea1d3b
> >
> +c2b4c6fa92cd99c5c301635%7C0%7C0%7C637226113645218967&amp;sdat
> a=3DsBVaIF
> > +hEoFSfaot7P%2Bjcbu6gnAlaB%2BDeEUqn3sv3%2BA8%3D&amp;reserved=3D0
> > +$schema:
> > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> >
> +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D02%7C01%7Cans
> on.hua
> >
> +ng%40nxp.com%7Cf07db2c34e834628725208d7e1c63083%7C686ea1d3bc2
> b4c6fa92
> >
> +cd99c5c301635%7C0%7C0%7C637226113645218967&amp;sdata=3DKLIuh1sJ
> 2OQDp%2B
> > +zSncLn87ziXGb85rwJFu2NnLgvxGI%3D&amp;reserved=3D0
> > +
> > +title: Clock bindings for Freescale i.MX6 Quad
> > +
> > +maintainers:
> > +  - Anson Huang <Anson.Huang@nxp.com>
> > +
> > +properties:
> > +  compatible:
> > +    const: fsl,imx6q-ccm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
>=20
> Why 1 and not 2? The RM describes that the ccm has 2 interrupts.

This is a typo, since we all use 2 interrupts for ccm, I will change them t=
o ONLY 2;

>=20
> > +    maxItems: 2
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: 24m osc
> > +      - description: 32k osc
> > +      - description: ckih1 clock input
> > +      - description: anaclk1 clock input
> > +      - description: anaclk2 clock input
> > +
> > +  clock-names:
> > +    items:
> > +      - const: osc
> > +      - const: ckil
> > +      - const: ckih1
> > +      - const: anaclk1
> > +      - const: anaclk2
> > +
> > +  fsl,pmic-stby-poweroff:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: |
> > +      Use this property if the SoC should be powered off by external p=
ower
> > +      management IC (PMIC) triggered via PMIC_STBY_REQ signal.
> > +      Boards that are designed to initiate poweroff on PMIC_ON_REQ
> signal should
> > +      be using "syscon-poweroff" driver instead.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - '#clock-cells'
> > +
> > +examples:
> > +  # Clock Control Module node:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    clks: clock-controller@20c4000 {
> > +        compatible =3D "fsl,imx6q-ccm";
> > +        reg =3D <0x020c4000 0x4000>;
> > +        interrupts =3D <0 87 IRQ_TYPE_LEVEL_HIGH>,
> > +                     <0 88 IRQ_TYPE_LEVEL_HIGH>;
> > +        #clock-cells =3D <1>;
> > +    };
> > +
> > +...
>=20
> Why these '...' here?

I will remove it

Thanks,
Anson

>=20
> Regards,
>   Marco
>=20
> > --
> > 2.7.4
