Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1930B2D2921
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgLHKms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:42:48 -0500
Received: from mail-eopbgr60044.outbound.protection.outlook.com ([40.107.6.44]:32737
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727754AbgLHKms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:42:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfX/MixtUoF1/EuaZOi70nF+aNFXJ2Wb/zW/UWxtySkerBt/27YfoUpfyL4BvXE444QXN+nndH4BZz1+JGjSzXXklopJ+kMU2CuqPTy8mZLaWyRHwEI2DZyKVUo8DQw/hD8cFKK2yHuoJIAnu/M/8K66ECHTN8ukF0/PShJBlus0/iGG4dK/4UPtG9gTq5E6nATzxuV9EYAkGOM0Xzi3a6e1GGa8N1BYJwDQLsMAB09s80WBa/cork69K8FPcFs09arq+LuviWERdRwRsuaORWyMtwj9U3RpTiTGP0Vl6GFuCXiFAMlNHXSRrNInwoAt0szb+/h7iTbNC2aT5TrkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snw2YEy+pwInDvkiBLQlduDOACkn2viXYFWAgunYsnM=;
 b=gIEwE6WC0wDWEt2g4osjpTfM6kEDXxEQtYBD5rFfwhT+9Rubp6jF5iQbt2nGgyuhJdL4N6On/VdGaPySvYMXWNaNZXVXKIzr/ROaH/VIl/1AUemghnWwnC55UEnb4v5LRj+x1qpHWMbOGEPcGk/5x54tuHsRZuZBBy1YJpfymeuVcU5MWIZWeWQChOcMtjje7rlyFvl41+fJPVURHk8oVWsIsxSDG6ka6n3w8VjrlIR+ricr61sVVIMg3RdD3vb/FojwsY4QpYmRjZxrdp1nhUjfgkdupBE1V5DpkNxzGaYdXSdsCT5JhxkPPjpsGh14dZ78KcK0Z/40XaJANftprw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Snw2YEy+pwInDvkiBLQlduDOACkn2viXYFWAgunYsnM=;
 b=VORCTIm9pP75iiUbKKR5OqMzmhKqyEMlqknPQFWPYP2wDrMUTgE9pdpSrufbz18FOXS5/vrUR93TnguWabrWuwcLjNFWC/ku4gOywj7Ao1TV+i9Ze+4iGbbeJ+1NWqYq/FUO6aGUiFiSGCFN1nY4r8mLygD673sMZZc8YeBm5zM=
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:aa::16)
 by AM7PR10MB3221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:109::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 8 Dec
 2020 10:41:57 +0000
Received: from AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c]) by AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5438:1932:b075:be6c%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 10:41:57 +0000
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
To:     Rob Herring <robh@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH V4 01/10] regulator: Update DA9121 dt-bindings
Thread-Topic: [PATCH V4 01/10] regulator: Update DA9121 dt-bindings
Thread-Index: AQHWx+k2nPrYkNpltUGZPYQaTY+Kt6nr9TiAgAEQJQA=
Date:   Tue, 8 Dec 2020 10:41:57 +0000
Message-ID: <AM6PR10MB280786E90152D183C8B52454ECCD0@AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1606830377.git.Adam.Ward.opensource@diasemi.com>
 <0606d3ded5fef4c38760246146f197db4ce3a374.1606830377.git.Adam.Ward.opensource@diasemi.com>
 <20201207175809.GA503826@robh.at.kernel.org>
In-Reply-To: <20201207175809.GA503826@robh.at.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c00d89e8-9b9c-4052-f199-08d89b65e325
x-ms-traffictypediagnostic: AM7PR10MB3221:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR10MB3221E5D66D02A45AB8878D2ECBCD0@AM7PR10MB3221.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZgoOoNF1IR0Lo6l13yKtOdpD0HtR3mmYD23T1fVQatTi1teZe4jjWSZe/tRxL500II85VkA1T5SCU9C8BXobSRzqipdK238CZzY+pqd//auUqGbGVZQrmgqe65FKANxY174FQLjOoxJR8kFs+Xa6UJH5vsRrOqdIH99UapvQz3Hp996Msglj+P6+lkWUTA3I6F+3P6XQGl+WJ/9BQaTkjezMLmlV8i3XlRbiSk1UiP4xYTznflYDt1pmLc8N7p86VO2/MpW36gy7bqJOD+h4IYcHCcmDe4UgxjUbAK1LeFa98L3qVw7lVuEX0m1sHsfvaFH614X/ylqrIid6QJlVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(71200400001)(186003)(7696005)(55016002)(66946007)(33656002)(66476007)(66556008)(66446008)(2906002)(9686003)(4326008)(26005)(64756008)(8936002)(86362001)(8676002)(54906003)(107886003)(55236004)(76116006)(498600001)(52536014)(6506007)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CRWetWOYiqaxCbtL+QrsgrKxK9yPPZg5aCp9bxr8LC7aH4nUwo1joSZVlp1B?=
 =?us-ascii?Q?/1sPrQQZeveOnNul3mRWUNzrUhDQTvg5gTidDXnK5ZXqQ+u1bplBfDH8WTqu?=
 =?us-ascii?Q?KaILpeAS9hyjO/xOjP7m0lYJ732lcsf9DcHvp75xBI2kxSLAX7X1g0EAbf6b?=
 =?us-ascii?Q?HHnqKMq87aO2pW/R8YnqSk8cKNV3rNp92a2get2y6I9HRpx71zjVjAfwW9CN?=
 =?us-ascii?Q?tLISauxNmKzr7gWHTximw3be/fkmDhB1MyGlnrs0BZFQyGLMR3rI1tLGydej?=
 =?us-ascii?Q?c5u6dVxMDptXkCu2/InMBcxHm6wA6whYd134muAUcs5fTr2iewC/87bsSJME?=
 =?us-ascii?Q?DoHlO2nFJkMNz1/r8QvhbazW9apq7GwyRSsw24B5mWBmES6sVHqwRMGBBOde?=
 =?us-ascii?Q?AwDeD/jQfPMOwEq1WsACGAHF/O2imNjncEU3oIbrSct/jqZ9GLW+zm2MkK8U?=
 =?us-ascii?Q?/WV+4QlIFCS8eGmCkt4ZudWMsja0rmhSoTjG4NbIy8piVImFI5TWbmf+dhIk?=
 =?us-ascii?Q?3/KMs+hYJbHQLsma4W/zfD1YXc+4ilgKy5PpN7Pc9uW67ue/echuzVeZRlAX?=
 =?us-ascii?Q?Qh7Jdn+XlVpdbJL6zsRrYAjR60mjw9lp14gCoYT1Fg6Zuf2JYWWw/lZO7PLr?=
 =?us-ascii?Q?mtu1+2rmdsT7HMgk6Xgt3it/xGF2ZCqTYJb0NOcIiesrkkxy2XFrly/ITBgL?=
 =?us-ascii?Q?s6Sp/EqMKfytvzPK+11fOvYMnRWXUvMzsUIgcZki+IjGXTovXLy4PnduAguq?=
 =?us-ascii?Q?QCvZvckdQDvWgDD5tEvqsMQqizGppsp0EON1LPHlVlxUppXDCbz89SAmMf3y?=
 =?us-ascii?Q?bVv9tK3P2sdnk8Uk3mvi59dS9X6pLgqa8DxH/1bcVuT40oQHySe4HhL3zdRe?=
 =?us-ascii?Q?Z8Hu9fTsOE6Xju2Hp86IgR7M7Gyo0d1cNHWB+zSAvahgYr8HJs0JD3Hl8jI2?=
 =?us-ascii?Q?iJNcud8L5jMpLqMyTfC0rCihwxmk2JbEwclrX69LEGg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB2807.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c00d89e8-9b9c-4052-f199-08d89b65e325
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 10:41:57.6882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qwrhhnQyEsO/li+X5xX0d/WUURndXjs0Htae2vg27exKAxV+T7Z9V5h5fKOUJGuG1QmfOb4y63EcESx9i+oe/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3221
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 17:58PM, Rob Herring wrote:
> > +        properties:
> > +          regulator-mode:
> > +            maxItems: 1
> > +            description: Defined in include/dt-bindings/regulator/dlg,=
da9121-
> regulator.h
>=20
> 'regulator-mode' is defined as a property of a
> 'regulator-state-(standby|mem|disk)' child node. I don't see how you
> would use this with 'regulator-initial-mode' either.
>=20
> > +
> > +          regulator-initial-mode:
> > +            maxItems: 1
>=20
> 'maxItems' applies to arrays and this is not an array. What you should
> have is constraints on the values:
>=20
> enum: [ 0, 1, 2, 3 ]

OK, I see better now - would this be the valid way to scope them both?

        properties:
          regulator-state-(standby|mem|disk):
          type: object

            properties:
              regulator-mode:
              enum: [ 0, 1, 2, 3 ]
              description: Defined in include/dt-bindings/regulator/dlg,da9=
121-regulator.h

          regulator-initial-mode:
            enum: [ 0, 1, 2, 3 ]
            description: Defined in include/dt-bindings/regulator/dlg,da912=
1-regulator.h

I couldn't find a precedent in regulator yaml, and it's far removed enough =
from what
I see in the abstract JSON-schema documentation to make relating them trick=
y, even
if I had sufficient familiarity with the terminology to believe I'd properl=
y understood that!

Perhaps I'd be better off abandoning this attempt, and just having the regu=
lator
description mention these properties/file, like the texts for act8865 and m=
ax77802 do?

