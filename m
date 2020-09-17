Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FC726CFEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 02:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIQA1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 20:27:35 -0400
Received: from mail-eopbgr60042.outbound.protection.outlook.com ([40.107.6.42]:42756
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbgIQA1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 20:27:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9G/8Vib7bkAhDu4uDkwtber1Ot1vHPQSBnJXSegJBxvtltHecr8E+iNSuNHweL186aGJyH9IxMbcrTclgnfgLWKPyBg0QFc+XjR23fKhdZBYwLs0pLNJZZyHdEY3kC7YwMEutnMO61Qj8IW+L5OnX3LXXaAphTDHH4awtxMjNIYN5CzaU6RgLDoPmKyJIGAZcXzkhrd1wH3RhtkRKPAW8RObfGQQWIiP+iLftfCFtik4gqJfDzdSXA+IFN9V/39nxAjlokVSDm3pllCZcoQoi/O7PTyjOtn2C1tmdj3sitd5dPfkd7RVuXojhIapozO28rE4fIQVbplrHDvgvW4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5lr/TF3tauC2NJd7lgu6KC6xq3slCvo4qvz/Gr8Rmw=;
 b=GBQBR/SQaD3w38o4sAPk04ARi2Bs3tYSzjINF4V5e2NCydlnjRwPSwZhFzNyDnLIpF/3LT2MzENzcfsRgdFBCs3+viOyd8EzQeQ9rVtfuj1DHUm24V26/bWsZChTj3idkC3xjG6qYAyWfBujF+tBj722hIJl4IXZAdzxHVr0sv0VihwBMV4M5uj3ZomRH4Mqr8gZBbaLRd4PeNgWOeqElXOt+6WU4yCTvb3j9brgauU5xSPnrF6m0PfJzXqa20hTq25e7bqexHnzbP6tu8S+JmQ/rW6TMwklBn2vTYLJDNcnjOZSGghhMhkx/LfUCk4xsyxoZTJ+L2Lnbx/UaTsPZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5lr/TF3tauC2NJd7lgu6KC6xq3slCvo4qvz/Gr8Rmw=;
 b=DdNz2dfhG19z6BtiU0iWvFjxXKoLx1AG0l80Pyvb2/TJ96l4v1gWMGl9r4UPae/mOXzDNWiXP+M2oxw81Xsq5FOyB98SNqMzYS8ggPvBqSzlBwdr0z3fCtE7xms5H3IabKDrOj+gTsO2sI/LKdJXqKmdNOhq89PeQPKrxcP9zQ0=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB4165.eurprd04.prod.outlook.com (2603:10a6:209:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 00:27:29 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%3]) with mapi id 15.20.3391.013; Thu, 17 Sep 2020
 00:27:29 +0000
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
Thread-Index: AQHWisa8s1Sayn6UyUeJIx1ZNmduw6lpAX4AgAAjrICAAB3x4IABEESAgACa9ICAALfHgIAAVssA
Date:   Thu, 17 Sep 2020 00:27:29 +0000
Message-ID: <20200917002646.GA23310@b29397-desktop>
References: <20200914112716.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200914112716.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200915025426.GA17450@b29397-desktop> <20200915050207.GF2022397@google.com>
 <AM7PR04MB715735A8A102F3EC9041EA328B200@AM7PR04MB7157.eurprd04.prod.outlook.com>
 <20200915230345.GF2771744@google.com> <20200916081821.GA14376@b29397-desktop>
 <20200916191607.GB3560556@google.com>
In-Reply-To: <20200916191607.GB3560556@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f9d28b8-68a9-4fe4-6f98-08d85aa0760b
x-ms-traffictypediagnostic: AM6PR04MB4165:
x-microsoft-antispam-prvs: <AM6PR04MB4165B855B2633B74F8929F218B3E0@AM6PR04MB4165.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aEG/oqPMXBhQ7DX+QLc8RsCDy6zDk2/YgLM433l6mh2vMV6ChjgaXiNtaHWQ1/+fD9stcQs3Zb6QDcn/EtsUCiqTm6A5/TaAKp/wTPRvfxZ14YiQfqeo8Hod7MB4uFIf+l8GSa8uv6CaVl5oRuF42xZC79q49anJ+GyG07p+SqPu3im2k4zJKRVH8Ee0Jh3c6lCxSH11FF2oNw99F/SCDqpPUXFnigFYtCl7eT7msF/xdevjj2RFr4h9g7QjI2eun8jaXU3KOOy1NL1xByPlOve2NWRm/xVJZUESyG9351kDV4fWUK928Bo9b6WO8O9sptCaHTsxpL9RYRYbSFXA3Ts6Wm4dPc68sjIQbcwyWYxQXGWvxoY4+017lVMOr1E8bY5fJQVhlhkjCbYgNq5sNzXe3akTBOHL/CG3r96iQmmGC82obG1+8HjOBb+k/usqlCl2hwSKz1KntJuVJPG6IQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(39860400002)(346002)(376002)(396003)(136003)(71200400001)(6916009)(2906002)(66446008)(64756008)(9686003)(44832011)(66476007)(8676002)(66556008)(54906003)(86362001)(66946007)(6512007)(8936002)(966005)(186003)(6506007)(76116006)(53546011)(83380400001)(4326008)(33656002)(91956017)(6486002)(26005)(7416002)(1076003)(478600001)(33716001)(316002)(45080400002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Sqf+hWZKP+K3De6+xVZZzbfU3cZycUUzEdcTdARAuGfL+b8kPYYwUjVLheYN7+Y6+sZumjfl/44ghFmi4YIEpLjlijIcs/BWVZ+Ny72Z54BDb6NRPx1KFSPNaHuuE6SzbT7nsC/Qh0CvHuaed0Ypfg39eqdkp+kJSWSfLIdKAjoHtGY442l+HMQDCVL1x3+6OGAZsGkSFrAtYwF5yAF0SMwwSX6wv5LepIJxgMGqCbKiLetHtPn4kn0o8pL66kzNg/lFfFUbQNS+AcRlZF8RPpE62QV0kXtVYWkUmIq8P6YxBZf59OGXex0Vt4yaJVwEtbCQ+JELlvMhFR8WzqUNVQEVv2eLA70xzmjHIrcwIDhnitH0i4G6Clbl59BUOOIv7dOVWp/9ZhWn+mNIQkPKqYLi9OuCOiDANcAxvSsBoIuK1yrE60Y5fJZLBF8D5PHg7hVKi2/4qaH+fJmCfwNkF/qgNxOiZZV5aSFnZoM+cHvBp4UTPD7SQ4I8iR9XZAFPOvDAujj+c1pU4O3hM0cZqpHqXJcX//4v5gSA1O9r9uiLx/gtVlfmNOpcIKFqdiZ21a1GSAa0GJzIStL2CK2FhXj6pZflroew/VlClG23zSBFcUY/a8H6BJSktotKP/X2I6Umb+rjKTDK95UcK/Ctew==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C9AD10F3DEC2B428EEDD4E9B175C5A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9d28b8-68a9-4fe4-6f98-08d85aa0760b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 00:27:29.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5uBfpIwERrnq+c8gZs9psmirFldapD4Um+kOl632oywXqEkYd/YdVjunEK+bJ7Im7AM6g+aivndLBAd0ihfhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-16 12:16:07, Matthias Kaehlcke wrote:
> Hi Peter,
>=20
> On Wed, Sep 16, 2020 at 08:19:07AM +0000, Peter Chen wrote:
> > On 20-09-15 16:03:45, Matthias Kaehlcke wrote:
> > > Hi Peter,
> > >=20
> > > On Tue, Sep 15, 2020 at 07:05:38AM +0000, Peter Chen wrote:
> > > >  =20
> > > > > > > +	hub->cfg.power_off_in_suspend =3D
> > > > > of_property_read_bool(dev->of_node, "power-off-in-suspend");
> > > > > > > +	hub->cfg.wakeup_source =3D of_property_read_bool(dev->of_no=
de,
> > > > > > > +"wakeup-source");
> > > > > >
> > > > > > Do you really need these two properties? If the device (and its
> > > > > > children if existed) has wakeup enabled, you keep power in susp=
end,
> > > > > > otherwise, you could close it, any exceptions?
> > > > >=20
> > > > > That would work for my use case, but I'm not sure it's a universa=
lly good
> > > > > configuration.
> > > > >=20
> > > > > I don't have a specific USB device in mind, but you could have a =
device that
> > > > > shouldn't lose it's context during suspend or keep operating auto=
nomously (e.g.
> > > > > a sensor with a large buffer collecting samples). Not sure if som=
ething like this
> > > > > exists in the real though.
> > > > >=20
> > > > > I'm not an expert, but it seems there are USB controllers with wa=
keup support
> > > > > which is always enabled. A board with such a controller then coul=
dn't have a
> > > > > policy to power down the hub regardless of wakeup capable devices=
 being
> > > > > connected.
> > > > >=20
> > > >=20
> > > > Whether or not it is a wakeup_source, it could get through its or i=
ts children's
> > > > /sys/../power/wakeup value, you have already used usb_wakeup_enable=
d_descendants
> > > > to know it.
> > >=20
> > > I conceptually agree, but in practice there are some conflicting deta=
ils:
> > >=20
> > > wakeup for the hubs on my system is by default disabled, yet USB wake=
up works
> > > regardless, so the flag doesn't really provide useful information. I =
guess we
> > > could still use it if there is no better way, but it doesn't seem ide=
al.
> > >=20
> > > Similar for udev->bus->controller, according to sysfs it doesn't even=
 have wakeup
> > > support. Please let me know if there is a reliable way to check if wa=
keup is
> > > enabled on the controller of a device.
> >=20
> > Then, how could your code work, you use usb_wakeup_enabled_descendants
> > to get if HUB or the descendants under the HUB has wakeup enabled?
>=20
> Doing just that would not allow to switch the hub off when wakeup enabled
> descendants are connected, which might be desirable in some configuration=
s.
>=20
> > If you use dwc3, you need to enable xhci-plat.c's wakeup entry if your
> > system needs xHCI connect/disconnect wakeup event. I have one pending
> > patch to do it:
> >=20
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.spinics.net%2Flists%2Flinux-usb%2Fmsg199406.html&amp;data=3D02%7C01%7Cpete=
r.chen%40nxp.com%7C02c4cc75e26a47d0224d08d85a74f945%7C686ea1d3bc2b4c6fa92cd=
99c5c301635%7C0%7C0%7C637358805725394858&amp;sdata=3DcjZhSmQiXVJoLsN5PjFACs=
LwsikH%2BeRTztPhsckJFNs%3D&amp;reserved=3D0
>=20
> Thanks, my system has indeed a dwc3(-qcom) controller, your patch adds
> the missing wakeup entry to sysfs. So it seems your patch should solve
> my problem (sharp timing!), however you mention specifically the 'xHCI
> connect/disconnect wakeup event', so I wonder if the xHCI wakeup flag
> isn't applicable to other wakeup events. I know the dwc3-qcom platform
> device has its own wakeup flag. The driver currently enables wakeup
> interrupts unconditionally, I sent a patch to change that
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore=
.kernel.org%2Fpatchwork%2Fpatch%2F1305894%2F&amp;data=3D02%7C01%7Cpeter.che=
n%40nxp.com%7C02c4cc75e26a47d0224d08d85a74f945%7C686ea1d3bc2b4c6fa92cd99c5c=
301635%7C0%7C0%7C637358805725394858&amp;sdata=3D6IjiiHJql%2FW4vzDla9q3qdfii=
OzOQy1Vk7ryUhKOOTc%3D&amp;reserved=3D0), however I now wonder
> if it should evaluate the xHCI wakeup flag instead of its own.
>=20

You may need both (glue & xhci), it depends on system design, and
usually, these two kinds of wakeup setting isn't conflict.

--=20

Thanks,
Peter Chen=
