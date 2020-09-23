Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC96F274F50
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgIWC4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:56:39 -0400
Received: from mail-eopbgr00086.outbound.protection.outlook.com ([40.107.0.86]:10683
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726775AbgIWC4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUHBiXPzCEhIyD9T193LEGZSZqbXWyLryHvDl9dxYQYRKfI5+5vg7+xyrcnJUhq3vMF09vh4Wtp+FftGdcpVTdd5+DaGLh4MkCX9HcjbEf+AIbkRdZpe2r4rTJjhs/Ex2Vddo7DPdB1owqiIfIhCSWvzabRQI7vhgMlmM12wI0VWlXSaq4xT09tmkQs7KUA7kdonk3gKxoZgEi21UB+WjgLEmCSlLZ8f9qwR14Q0i+5qQG6ay4HnZdCQoUuIi3MRvjy8TDnWn2VeEQwLkIQnW175QU3Aj8x8HmY/2jiVb4vtkhaLBbxv08oYMNGtMdQSzPofXiS9/QDTXf4Lg8MEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sso8cTDvBasOaXJyx/1pHI1ofNRMUs4B78JD3JJPxIE=;
 b=i1KyuUpKzZ8VC2vxmlyLik3yikp8Ms7mt2hQIai2YhD+dpO1j9r/nwM+sHzLeEp37dmz/fJfDT+QNsOuIVaZm3z1YXiHi7WelVJEKbtgQJqGPwLJOYqSDBD4OsEMtNC/Eng2TL1Gri3o3ysSDh8TvKCL8umQ6CI1wZlheJeAGwQtatP/Sv8zomZfcYlDJzkASzTf3zmBokaPwiHSu8vQF+XckvjYpYFpDCfpsQZ31NPSei/jO6FLQgWIjbYt7NBjBKRf+54q0fY5TLsW+6vnWe2s9LcooKcIe7N4SLU9ufTjG/2YRceSm83L5pkowrfQGeqvMPoZMv10nmhlcG9DzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sso8cTDvBasOaXJyx/1pHI1ofNRMUs4B78JD3JJPxIE=;
 b=Ghb59muwVPCkz3f2y8UluyQ5c9Gal+Vv/C0HcIQo6vIASv1qu86ObLMtK0HkoRjUT0SfKQFyojuU/b9kg+sxEkzvZXL22qepHFEVDzV/rzV7Dd1fhjB/c8t3cQUaFQOWGFAUB4C9w+z8fRgjqqIGwHQ5rT+CPbQOkTSggj/+Cs8=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5319.eurprd04.prod.outlook.com (2603:10a6:20b:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 02:56:34 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%4]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 02:56:34 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: Re: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Topic: [PATCH RFC 0/5] Introduced new Cadence USBSSP DRD Driver.
Thread-Index: AQHWS3Ylp2LS5pecmkenOlfLMCntJajqdbIAgAAHxACABHoqgIAADdgAgIYl9gCAAOewAA==
Date:   Wed, 23 Sep 2020 02:56:34 +0000
Message-ID: <20200923025540.GA31183@b29397-desktop>
References: <20200626045450.10205-1-pawell@cadence.com>
 <878sga5nfr.fsf@kernel.org>
 <BL0PR07MB5522A8796EE7BFB5062A8E76DD930@BL0PR07MB5522.namprd07.prod.outlook.com>
 <20200629034213.GB30684@b29397-desktop> <20200629043146.GA323164@kroah.com>
 <DM6PR07MB5529B75D3CF135D540749C1DDD3B0@DM6PR07MB5529.namprd07.prod.outlook.com>
In-Reply-To: <DM6PR07MB5529B75D3CF135D540749C1DDD3B0@DM6PR07MB5529.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 029c0b63-b57f-4fbc-056a-08d85f6c485c
x-ms-traffictypediagnostic: AM6PR04MB5319:
x-microsoft-antispam-prvs: <AM6PR04MB5319EB133C4FB602B896B7138B380@AM6PR04MB5319.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVgJ8twsLR6BqhJgFreENEigKoQJymtB3aI/nX/iuCQ7jzx5t/kqzNaiinOMTZgcfv/qbyZhcb31lOQFxtYZkmrrGGNsfkhiVnZeajMclxWRPysf9SH+UK1yWHpO3tD3JTn8uof+fbQ+ZidWChija80M9LcjqqhFGZEZayEPittvfZoPN39WBaMCIGLhb77td037opZ7KJ27WBKB1JBXHb9oPjErgPmnFjbD1LtTmDkxiArl3RhaBWrNjjXnUwqMaV5d/7XtppAAH7WMYQga3xzrfoYyQG1mosUM44joUH7cxu2DvdiPuE3kVQpxTcWvmDjUT4BsoVi1DfS6fuwsK02FnwkJUMWF8DAFhmusDNUalTDr39gO8rUlRpL0Rvvl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(9686003)(6916009)(186003)(2906002)(54906003)(33656002)(5660300002)(71200400001)(86362001)(26005)(8676002)(6512007)(8936002)(4326008)(66946007)(33716001)(7416002)(66556008)(66446008)(66476007)(478600001)(316002)(44832011)(6506007)(1076003)(83380400001)(64756008)(6486002)(76116006)(91956017)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nYYcWAWjb+gtY/xpROt7iWPlKNiETHQLWZXi1eJV8LhatkVQtFa1pQyqX8fKG9BqSvN5AJ8mUfy2BMAqo6uY+6aoXUfg/E0e6MjK13EU6ggx2Icz4XSg4DMgrWBr4wVTb+6zYH+paqShDdr+XbzvQzSWI8thnjpf+EUqamJ0tk6xPVMWVqOtd6bwwEjfUQXoTNHyzwha00x6yrwykDli0xvdAUMkrHAOZ6Tgd9H0Y7MgSRuBlUk5CHhAhgMfGeBa/ouHcs+hlKMmVTs9LB5vgKsCEismebqDirm5WxZ9pDVfcCET4X4TgTCVjyj15apsYdeHXIMcJSWsfYJm1eo9I+edvKHDmidRhBM8TPSkFwbYHOX03FuX40yIkdQve27AhBVL18oU9YGNJz903pSj4NQHsGQDCGCMa9NaAh+8yd/YIlgClIXj+WZZDmwtNToD1/+PaV2ag8BVg+rB83q/BVgFelRFvRXZTE9//MxbOkULFu7QTxijTTbbmag0cQypejmL7Q1vQaSRd5tUEqawLhW7Qu8KP49MCbXFG/Yx9ABZARgUikxfZZdg5DQxVGOG6w2uT07EbG/drJG1XXYW8W9PVt9qcjDim/vMUkUcxeCOowAENuD6orb3yd8G9qsUQw7p0zUdCqHmVVh6oPGR9A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FD159AEAB00067429DC2FA12700F5029@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029c0b63-b57f-4fbc-056a-08d85f6c485c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 02:56:34.6568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHMtJ1eXrBnlfNu5ELtll0BM80aBeyug+bJFMdALuZzEJYooLiY1BIP+CKCEDO616u9QUH1ppHM8pIc6QrTzSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5319
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-09-22 13:06:26, Pawel Laszczak wrote:
> Hi,
>=20
> >
> >On Mon, Jun 29, 2020 at 03:41:49AM +0000, Peter Chen wrote:
> >> On 20-06-26 07:19:56, Pawel Laszczak wrote:
> >> > Hi Felipe,
> >> >
> >> > >
> >> > >Hi,
> >> > >
> >> > >Pawel Laszczak <pawell@cadence.com> writes:
> >> > >> This patch introduce new Cadence USBSS DRD driver to linux kernel=
.
> >> > >>
> >> > >> The Cadence USBSS DRD Controller is a highly configurable IP Core=
 which
> >> > >> can be instantiated as Dual-Role Device (DRD), Peripheral Only an=
d
> >> > >> Host Only (XHCI)configurations.
> >> > >>
> >> > >> The current driver has been validated with FPGA burned. We have s=
upport
> >> > >> for PCIe bus, which is used on FPGA prototyping.
> >> > >>
> >> > >> The host side of USBSS-DRD controller is compliance with XHCI
> >> > >> specification, so it works with standard XHCI Linux driver.
> >> > >>
> >> > >> The host side of USBSS DRD controller is compliant with XHCI.
> >> > >> The architecture for device side is almost the same as for host s=
ide,
> >> > >> and most of the XHCI specification can be used to understand how
> >> > >> this controller operates.
> >> > >>
> >> > >> This controller and driver support Full Speed, Hight Speed, Suppe=
r Speed
> >> > >> and Supper Speed Plus USB protocol.
> >> > >>
> >> > >> The prefix cdnsp used in driver has chosen by analogy to cdn3 dri=
ver.
> >> > >> The last letter of this acronym means PLUS. The formal name of co=
ntroller
> >> > >> is USBSSP but it's to generic so I've decided to use CDNSP.
> >> > >>
> >> > >> The patch 1: adds DT binding.
> >> > >> The patch 2: adds PCI to platform wrapper used on Cadnece testing
> >> > >>              platform. It is FPGA based on platform.
> >> > >> The patches 3-5: add the main part of driver and has been intenti=
onally
> >> > >>              split into 3 part. In my opinion such division shoul=
d not
> >> > >>              affect understanding and reviewing the driver, and c=
ause that
> >> > >>              main patch (4/5) is little smaller. Patch 3 introduc=
es main
> >> > >>              header file for driver, 4 is the main part that impl=
ements all
> >> > >>              functionality of driver and 5 introduces tracepoints=
.
> >> > >
> >> > >I'm more interested in how is this different from CDNS3. Aren't the=
y SW compatible?
> >> >
> >> > In general, the controller can be split into 2 part- DRD part and th=
e rest UDC.
> >> >
> >> > The second part UDC which consist gadget.c, ring.c and mem.c file is=
 completely different.
> >> >
> >> > The DRD part contains drd.c and core.c.
> >> > cdnsp drd.c is similar to cdns3 drd.c but it's little different. CDN=
SP has similar, but has different register space.
> >> > Some register was moved, some was removed and some was added.
> >> >
> >> > core.c is very similar and eventually could be common for both drive=
rs.  I thought about this but
> >> > I wanted to avoid interfering with cdns3 driver at this point CDNSP =
is still under testing and
> >> > CDNS3 is used by some products on the market.
> >>
> >> Pawel, I suggest adding CDNSP at driver/staging first since it is stil=
l
> >> under testing. When you are thinking the driver (as well as hardware) =
are
> >> mature, you could try to add gadget part (eg, gadget-v2) and make
> >> necessary changes for core.c.
> >
> >I only take code for drivers/staging/ that for some reason is not
> >meeting the normal coding style/rules/whatever.  For stuff that is an
> >obvious duplicate of existing code like this, and needs to be
> >rearchitected.  It is much more work to try to convert code once it is
> >in the tree than to just do it out of the tree on your own and resubmit
> >it, as you don't have to follow the in-kernel rules of "one patch does
> >one thing" that you would if it was in staging.
> >
> >So don't think that staging is the right place for this, just spend a
> >few weeks to get it right and then resubmit it.
> >
>=20
> I had idea to reuse indirect the core.c and drd.c in cdnsp driver. Of cou=
rse, I've made
> the necessary changes to make possible reuse this code.
> My approach was to add this file in Makefile in cdnsp but this concept fa=
iled.=20
> It even worked until I started testing cdns3 and cdnsp as build in kernel=
 :)
>=20
> With this approach I have issue with " multiple definition of .. "
>=20
> How should it look like such reusable code ?
>=20
> After my experience with above concept I think that only way is to move c=
ommon code
> to separate module,  similar as it is in drivers/usb/common directory or =
libcomposite.ko module.
>=20

Could you use compatible string or IP revision number to dynamic judge
which part of code you should use? That is to say there is only one
Cadence 3 USB driver folder -- cdns3, you only add one gadget file for
cdnsp revision?

--=20

Thanks,
Peter Chen=
