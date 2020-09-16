Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8228326BF04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgIPITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 04:19:23 -0400
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:2624
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgIPITN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:19:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+8M1mOQBRclgiZwbI6pPHUXzRPYRb8rBFf9JszRJwb2eyE3uF30L0uf4PjWKVmX/h0zmxJz0VXSQPUJ26RoVJqzESjOF/wdm6m4sQnPKWAPQE1qzr/76SjTzN7bu+IU7OLvmJFhDlw90Y4SeFLsHtjweykZKrx4Ltyul0ZINmMjPh4qXYrxaD7JOw+47Ec8NQs50lehUM1BqbLgU2y+6a3bKHxo7HovzFdTv31ZZ8sJNzwxStCh9z8cvOzxXwyrvM1NvpLV/NLz4qjaWgUSsachRg8IZxj5wrbWbP+S/M4nMBDiN/ioGpzz508KDjLjuXe762wNhCqKJhqb/c+wDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dYslHcVOMXvWql/bThcgfeWvPo4pE93gRYbTLxdkBQ=;
 b=PIwUopPVC+oJXtv6D6wXaICEO7uTCRYTfoxENHze+2vBnVCvbUEOnZMGG/eGtWSRaIJ67lPaJstvskIX6K3NH47g58c2/HSRKXAMeAzSiBuWRtl34LLlTOAa65Y3AqgMc5uxyWoW/MO95nrszGDHueoZJ88at1XmFf2zVKsjVkL0hZQVxyaz6as3zVQxicjzw/t/R5p/RcEbms7V2joj4HhpL1hNTJBCrXfxRh0IX0Dq4bvkTQhk9sEo+CmfL3bsLPPFPcYOU2pUlTgfKezyNQ21jGk+HNDV+kXBApPoDSaSCrD+Xj+He5EfUmy4HBJpBcBlU3mQNHarOnH2iMWeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dYslHcVOMXvWql/bThcgfeWvPo4pE93gRYbTLxdkBQ=;
 b=MgzXIgRlRC36vPvqP+4NRnNYzT4z6m/D2VwXsdbtWG1uheSlMP+jC3ubqmgdseBZq2vIIv8Mj9VHJlyYogTGd8lrMx3ne8YkfgXbcpyci1FZxkDAIcMuKbKcjUL5pXYdv1K3ZbZujL2UBctKDoqfiNifJhV1TWpYO7gwv8L8IFA=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR0402MB3317.eurprd04.prod.outlook.com (2603:10a6:209:a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.18; Wed, 16 Sep
 2020 08:19:07 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3391.013; Wed, 16 Sep 2020
 08:19:07 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Topic: [PATCH 2/2] USB: misc: Add onboard_usb_hub driver
Thread-Index: AQHWisa8s1Sayn6UyUeJIx1ZNmduw6lpAX4AgAAjrICAAB3x4IABEESAgACa9IA=
Date:   Wed, 16 Sep 2020 08:19:07 +0000
Message-ID: <20200916081821.GA14376@b29397-desktop>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200915025426.GA17450@b29397-desktop> <20200915050207.GF2022397@google.com>
 <AM7PR04MB715735A8A102F3EC9041EA328B200@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <20200915230345.GF2771744@google.com>
In-Reply-To: <20200915230345.GF2771744@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f9cc4e1-dc61-4192-6764-08d85a192e88
x-ms-traffictypediagnostic: AM6PR0402MB3317:
x-microsoft-antispam-prvs: <AM6PR0402MB3317A8AB7D10535AD0714B508B210@AM6PR0402MB3317.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AjN2UmMOA4W/3YgxQSHgmoIlcydKdTuziIrE4wLyo3TicS44z7ArxUFxHRIEkyL7+TZS0jZ2QYm+xD5HbBWc4HS1j/veHZDpKOOrnORBs9YScK4n07eTkpcmLUmo8VmWZ+2HJ8FwjWfmpmYTnIH6ucC5lEICWDF52oxa54Ny9SSnOUcyPpQX5G0O27G8jbaR5RJjt0+mBeT/2Y8klGVW2Kxb5Mvzl0NBVOLwJEnVAG1ymcr040nFfLC4qQW1mprMOlCGSdwsC+RzePGgjRD8UfUBRMMPyFqIesOrESPAWNXnNadrkX7qJn+Uc2HE4ILMCOLhEP7qmZJmIBR/kG7Q2g0NgmPfzY+C33BHic+KOEJv5fDjllSA+RIHFihztBSgrIdqJnKKWFe/jQaoDpaj2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(71200400001)(33656002)(83380400001)(54906003)(966005)(86362001)(6512007)(6506007)(1076003)(53546011)(9686003)(6486002)(4326008)(44832011)(33716001)(6916009)(7416002)(5660300002)(498600001)(26005)(66476007)(66946007)(8936002)(8676002)(64756008)(66556008)(186003)(91956017)(66446008)(76116006)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ft7htlLK7MltqVLJPz5Cb4YmaLeqCpkiFEJ17L2Ru/2ogZ6DSzoXEUutuJMF5MmRCEIR2lisBbF/KRF3gB4tdRPmDfwwvhXx/46fWAsmcHlmNu8SC6Ib3rEAlXNQ+izOCGDaQvujBSXGvbZkHxCCQ9MFQxB2nOudHSKpjzdrjOBm/Y9S/2nTrDNkqihg2LEGCnbZVFd9CaH/LG4rT9IyYApaf6irFB4/2nwqIIMwk4qCHDfSyB0tzB2VFCv70B2EKf9oTTM4EQv0DwdH99/r49l4AHPH39KrlvjgxH4OTpkXMAnyZkhvHjPerwFnHBrvZKevemAoZRd7LlRYqVQQjsdexlfGETmqFuEIoxJNb9lHUDj5r3JjCNq2q5ZIz6x3857QM7vU4gwA6ndFPtLkzsdwbklixZOsg48zvuApQpRn7pA21gye5HB3PS73FH9gqPrDw3eoA1LdzkDuqGhX9BrhmeTpyeLjghJUXov/CW2+YB35ksXtgmK03wHqxDDkQVLL4G81gLrX4OSmXP9/zWjThacznLbhfybwOwAH50wOAigAY1yzkRXvorBCsdzhun43q7+5noG32JHOpsCUdlyDciiZykxy9ZGl5sP5TXfcRdRhLJgKlIyYwYktDjoLfNl/gdcwqo3JtUBJAYxHMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F4B17F36CA4FB94B9644E24C0D2A1275@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9cc4e1-dc61-4192-6764-08d85a192e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2020 08:19:07.3631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bCD8Aq0EZFbhs5Bn+CCSeDN60sLsayB27za8fUy9AHkkC1NjJbsse3EIuHJqxFioroAtHh0yrcbrKFAomi61mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-15 16:03:45, Matthias Kaehlcke wrote:
> Hi Peter,
>=20
> On Tue, Sep 15, 2020 at 07:05:38AM +0000, Peter Chen wrote:
> >  =20
> > > > > +	hub->cfg.power_off_in_suspend =3D
> > > of_property_read_bool(dev->of_node, "power-off-in-suspend");
> > > > > +	hub->cfg.wakeup_source =3D of_property_read_bool(dev->of_node,
> > > > > +"wakeup-source");
> > > >
> > > > Do you really need these two properties? If the device (and its
> > > > children if existed) has wakeup enabled, you keep power in suspend,
> > > > otherwise, you could close it, any exceptions?
> > >=20
> > > That would work for my use case, but I'm not sure it's a universally =
good
> > > configuration.
> > >=20
> > > I don't have a specific USB device in mind, but you could have a devi=
ce that
> > > shouldn't lose it's context during suspend or keep operating autonomo=
usly (e.g.
> > > a sensor with a large buffer collecting samples). Not sure if somethi=
ng like this
> > > exists in the real though.
> > >=20
> > > I'm not an expert, but it seems there are USB controllers with wakeup=
 support
> > > which is always enabled. A board with such a controller then couldn't=
 have a
> > > policy to power down the hub regardless of wakeup capable devices bei=
ng
> > > connected.
> > >=20
> >=20
> > Whether or not it is a wakeup_source, it could get through its or its c=
hildren's
> > /sys/../power/wakeup value, you have already used usb_wakeup_enabled_de=
scendants
> > to know it.
>=20
> I conceptually agree, but in practice there are some conflicting details:
>=20
> wakeup for the hubs on my system is by default disabled, yet USB wakeup w=
orks
> regardless, so the flag doesn't really provide useful information. I gues=
s we
> could still use it if there is no better way, but it doesn't seem ideal.
>=20
> Similar for udev->bus->controller, according to sysfs it doesn't even hav=
e wakeup
> support. Please let me know if there is a reliable way to check if wakeup=
 is
> enabled on the controller of a device.

Then, how could your code work, you use usb_wakeup_enabled_descendants
to get if HUB or the descendants under the HUB has wakeup enabled?

If you use dwc3, you need to enable xhci-plat.c's wakeup entry if your
system needs xHCI connect/disconnect wakeup event. I have one pending
patch to do it:

https://www.spinics.net/lists/linux-usb/msg199406.html

>=20
> > If the onboard HUB needs to reflect wakeup signal, it should not power =
off its regulator.
> >=20
> > For another property power-off-in-suspend, I think it is also a user op=
tion,
> > but not a hardware feature.
>=20
> Ok, I think you are suggesting a sysfs attribute instead of a DT property=
, that
> sounds good to me.

Yes.

--=20

Thanks,
Peter Chen=
