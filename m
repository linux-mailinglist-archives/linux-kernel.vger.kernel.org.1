Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1443A2AB33C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgKIJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:10:41 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29949 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgKIJKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604913039; x=1636449039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qN+OQ8yJfR+lmzzKfpC/WW8oC1U24K/nWUtAkKj+YkY=;
  b=rFdoT0uWh8sMtFSOOtHS14clP8e1NOfSL1mZF3QuNRug9u/bWcJPkjkK
   PAmOa6f8muS9ZiOgCe6Jio1J6rdrzEoNsoRaDYEVuVVnBN5IgijnPhUTP
   qnNBvlWuyKHKxKlueQKHVHV6QjzOdEEWEyrGEaMhkyCcMXe/0yRzaYQ+v
   tAiX5s6ocn9365H1eADgYT5prdoVzWh5s/rCb8eJ/3vy76SUNpoCVXDB3
   saYBHrbY7Gd6e8QQfprQYjXwdpIt2t/0QZ0ni+HXSW0Qi0u44f+dLNuB+
   deKW5rTjV9ZxnsaayIeoB/DuT95g0KoZX8DZov2w8EkL+kpg4lhSu+r4i
   Q==;
IronPort-SDR: FpfyxtR6CIN2xWfsCV8hQ8GTBuRTxHygc/IcmUvvY7+Is1gLH8C7UFsFbpqISNJs65mjQmU0RB
 qQwRHHWEvMpUBWQLCE8dcXGuBzltN5qLg3Rbbo9q3R1Ieke4p6YjPD3faWez+hGyGhucDHFIrm
 AyxbkFSyZJcwGsvjOWfADvpa3DSCvWDgJzOmKI6+wBQgHfEtivGF2tibC9eOOBdESTSsaTf8/L
 Hu4aeNNdE39d4YAVSCECNVGIJL3eSOTzr2rAT2eL++9WkIwJ3gcFJnBOJLgnzoJD2Ky+hQws7A
 Ijw=
X-IronPort-AV: E=Sophos;i="5.77,463,1596470400"; 
   d="scan'208";a="152278351"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2020 17:10:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNMMk6F1naBcMIS6ERYcXgy54TfjftgiQo18sui+FdQtO3g2X/QbMFUxQZWt5SatamwRg+wQViK2e/ZK+q4IUjQ0nvX3q4L8s88fv0sBl38VF/KQk71+1mXxCeVPuP41FciTvmAbhhAj5z+ZpQB5f3I6FwTjuyoqvb2o672l0ChZIXjUymKIH52Zq5mNNdmfWNA42uzqagaWBqD4t5iFkdngx7j4p/sR+jNRM3gm24cDussFjqeldC6ewpe5ZhjX5yGMX2/e4HfbLBa8z1ZCP4m51zTGvzZ9E8QViO9F71cUwWvXr0m7EqkZmwC8Vjn/7+qSBrkonCjvikqu9XHoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3pitUe3n59iDURA52UZDuYjJdzypx0MoZtg++Iol3A=;
 b=e5/1GtGC88rsgDdx8I4x0eJfRhJ/GAMOM0CCkiVMW+73fRKHccdZbYBXoHTUPYwxKbTJNmTTjgdAxXPbC7jHEYkcBjpzlLpOJXUoqGmZuH4HrpZD/2X3PswNbQBkAjFaOZ87Bhm2/fUjLEmjINgPacLqIgbwbcjb8XWKcHfqy9aTXS8wbrzgK3NS5MXqjpiGeIyaYmFLrMeb9fYK8EsgK4AAO6IBdFE5alxbAft6YgrNXWB+ubv6AK6OmNI0Qi5jXDSequBGSLEo+/JBMGRQwotUXkZdQOZLGT8c6t5YoMKfw/Bz3piSYHCUacAYlskN9auGtUH7y48ERB6J6KBbxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3pitUe3n59iDURA52UZDuYjJdzypx0MoZtg++Iol3A=;
 b=YnYr0RT6grS8ECyMQEHwZZZlAV50oFnJszpLx1xxVKdgPq+30xbuo0BJyj9nUOXyleruy3vyHUTOvEUNjAO4tUz5t2g5emAEzm0WTX2i65+C5F48+CMuXhSsVbEI82CxNC+ojBVnrJTAX+OhNeDrA9ft8BGXfq6FFjZu1uYCiQw=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BY5PR04MB6676.namprd04.prod.outlook.com (2603:10b6:a03:22d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 09:10:38 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95%3]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:10:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Thread-Topic: WARNING: can't access registers at asm_common_interrupt
Thread-Index: AQHWtAKoC1N6UC8gbUaAN5Wk5A+R6Km7ZxIAgAQhSIA=
Date:   Mon, 9 Nov 2020 09:10:38 +0000
Message-ID: <20201109091037.6upb63tclk4nhvl7@shindev.dhcp.fujisawa.hgst.com>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201106180628.r4emdw3yoxfzryzu@treble>
In-Reply-To: <20201106180628.r4emdw3yoxfzryzu@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b190031-6b6b-4d75-a69c-08d8848f5345
x-ms-traffictypediagnostic: BY5PR04MB6676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6676697077623D83A79148E5EDEA0@BY5PR04MB6676.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:510;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: da03ZHxvs5HoqKgnITtmWeaW7/lPhWien1HN3rmRJpdwYwuumRus/OsO2oA79bF/kVkGEXe/sAylNeZCi4eLy8NcmXFD0zA6yNr1US4Ds1+EdZgnpSlrjs1XP4CEQZ4hcl7Apz3BUz/dtPo4RXZXbPOkMhj4AhDy5Yj12A1/avQx54ekNBgBJ4xClnnOmewXfRYucwfiA3ItVfVAH7AyjSK9p6NEdr5GKkWJv8xoyC4AnNmlIPsVE+QTiOtLlRlv5ZGuJy89E7y7yGr35xRqm9lPXMlxUZzCXJEqN6SqejCLZYPHE7dbXKZ48xXJ1za7cSdwjvMuB/Xq4mGeIvHyKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(4326008)(1076003)(6486002)(8676002)(66446008)(64756008)(66476007)(66556008)(478600001)(66946007)(54906003)(86362001)(9686003)(6916009)(6512007)(316002)(186003)(76116006)(91956017)(71200400001)(2906002)(5660300002)(26005)(44832011)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ipw1FMWAkZM8ZMSPjdzsBPtIbHU78WhfKtqlLJAsurKHqtXJENlTLJlg/ZldKLU4/Vkiheegj/x++qLM/2Pb/89XnYW0ZjBUJ62PCZjA5sjmqosuzP5POjLNIgbl8WqYj4ft+VKPIVIUQBz9dp+VWJFj+Sj4UCkODD83rc9sucC1THGxjhZlrAqQvkFu3yLgGjIQdKzqWf/rZeE4jx/chJzcX2mPIW92R3NsLSiI5HIMm2qoDGRF+xeiqkg6YUIKV+ZkTPVbDPF1aIoQfGBAcAwaNKliY4utnwj9s4xQf91tQ33bRxD9EAkDDOgzdijVkOdfiyNnPk1ECJJa2qyUB2GgyHtGnBFeDJcgWUG0Fwshkw3ylhANDaBeO8LEKtN8JIHGveTuDw1z+33PYuy2Z5KPShiLujT4IgOdVy5exkbbWm5mN+0ZHDkLmoQTVNPgxQ8DjNLPxEHOLJgXNNg0I1k+YfyavS5LAa5y3EX2kIeijhC0uOQyiAClV8ovduWlXqmmuBOeFOaXILFCoNq7RpYDD+VJKl+1a0xrR3aIkxCSOB+OfvUtrk5sZ5q6XRuQCpMmkhPUfabTauFvibKRcuRkwiUirttq0lNEymHaE8wxrpu9X+DgEocUX7IUwBFriLmOaFHNL51yt4Qhivvj4w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CA5EEE69E9A74F49BE048420201CE101@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b190031-6b6b-4d75-a69c-08d8848f5345
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 09:10:38.4309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBsh1ZN9ogSWX6aI/j1ZXuMzXLSZusorBkFpbayhV30IMCA8eUnjUv/QyJLz4nYE/PMfsdxHr65Zrn18fT73yL6YU4weFR55mv4ehbE0EOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6676
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 06, 2020 / 12:06, Josh Poimboeuf wrote:
> On Fri, Nov 06, 2020 at 06:04:15AM +0000, Shinichiro Kawasaki wrote:
> > Greetings,
> >=20
> > I observe "WARNING: can't access registers at asm_common_interrupt+0x1e=
/0x40"
> > in my kernel test system repeatedly, which is printed by unwind_next_fr=
ame() in
> > "arch/x86/kernel/unwind_orc.c". Syzbot already reported that [1]. Simil=
ar
> > warning was reported and discussed [2], but I suppose the cause is not =
yet
> > clarified.
> >=20
> > The warning was observed with v5.10-rc2 and older tags. I bisected and =
found
> > that the commit 044d0d6de9f5 ("lockdep: Only trace IRQ edges") in v5.9-=
rc3
> > triggered the warning. Reverting that from 5.10-rc2, the warning disapp=
eared.
> > May I ask comment by expertise on CC how this commit can relate to the =
warning?
> >=20
> > The test condition to reproduce the warning is rather unique (blktests,
> > dm-linear and ZNS device emulation by QEMU). If any action is suggested=
 for
> > further analysis, I'm willing to take it with my test system.
>=20
> Hi,
>=20
> Thanks for reporting this issue.  This might be a different issue from
> [2].
>=20
> Can you send me the arch/x86/entry/entry_64.o file from your build?

Hi Josh, thank you for your response. As a separated e-mail, I have sent th=
e
entry_64.o only to your address, since I hesitate to send around the 76kb
attachment file to LKML. In case it does not reach to you, please let me kn=
ow.

--=20
Best Regards,
Shin'ichiro Kawasaki=
