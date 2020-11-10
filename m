Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099D32AD23A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgKJJT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:19:27 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18916 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgKJJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604999964; x=1636535964;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bBaR7NAlTyl/Az+4Gyl8BJ99pH8zymICjMgGdnE65Iw=;
  b=TIcUywyI+u+mYcRnpAghEYnWzvc0FbYSXwvuijXj39m3fqUbQxX2J7bE
   CbYfiWaAsmzHfDWEYGv7aGhEF26oGnqIzrUgNGSgpXJxpnKIxseCPrnvm
   U/VAIB3weoOWkiGeNBo5jvJXJC6H8GlkMFYYOxmmec50uB4u6pznjHpJN
   0PbIkYmvq/FlbiahlW15BidE9kQgh39RzZZm/8ccEi/0nmu3MmKRrrodJ
   yWpTx61oETzcZZ7fM7Ie0OSSrXJhURYhu4Y8FdzXb3b4iAA9PoPZn7BZa
   S8KA/OkLHBuOXgNhYIu4d6dtC8+lzo4iLGeT/HBcWhtVUJ36VmmMRU66u
   g==;
IronPort-SDR: vQRZM3/8w/HikP0EBkieYXoGpt0+wsm+SFrX5zUaITiIuOGYBrvY+wMyYjlIyEwDCJmYxLX6vA
 pdWaCG7xchpYhvSUZMSQTsAs6dHKWenAwtLlOT/axB7lY43C45iCTjGbzJOKBdVa7S1WHWCFpn
 qNFms/o9MWSoh7FCWmuzVUnXk5eGiuq4eQ6uGy2DSWfJPymoAj3snAxN1vYeorZ0cwbNC8OzIT
 CQji5v+cjfWZpHn44RmU5W6P9chJS1DRnl0ikao9rv2ltAt5HFBkCw1zuHhAKaKR+ISJ/kufxs
 UBw=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="153466524"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 17:19:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUfZclHk+L/I38+ZjlmIjOXq0uaLym8kw+1IYuH7pKwu47DDNGTC37UyiasW/lwPdINUYLH2vGuJ0cvOYfqi6D6zjM1yjJywLxI64Tti/u6zuT6Zj1C7LU6iVm2szxSpH1o1yXmOiZ0T4D0Et9X14NjnD2YuzrlNGiEkEnDTaHhrYdIHJ3BMJYMwbXTTmRQFDbXfnaynlgaQq2E3t+sgxorEkKzTafUyPmhiiqlDlJ2rm2xFwcvMRdW1H2iihpiynBfta0hIyEhn1a8Tk6y4FCLD5KNMlXzlsvUbYW8hIXhUknoZo7TipdkqOrMzA6xLEfaDu0gSPUkC/mbFKSED7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXcT/BWMTCPqHmeM+qqo9cLbXRcM5piBSFWTut/CIT0=;
 b=jx+56FA0DRLutRAZEOuoRzqeSGRfgFBqBOtGzofms1hbEAwie5fnv5MDhpH6v7ikma/4QPECO4JU1Q4SXOr3Th7EIRp8v5+Is1EvTCeTfzKhzdW60XWAH3GSOElPyo3eW9PvyrvLhcJfGWKBySbt6q1gh/JSAdWA+w4aEQA3kNhVEa0bOfNBu569ZhGSqf/4Fi8gAuy4GTjmpAJnvYbLYBbm/ze8F815FDiyULvtlcLEp2XhucWssWscDsbp//xpl757oX2ZsPU84fXFtpbe8uNrbJVP7aMBGzUsDKyWXgFGmor3hOOZlLQysNrlsPUPkeJD+vHHnfZXiWcYr8R6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXcT/BWMTCPqHmeM+qqo9cLbXRcM5piBSFWTut/CIT0=;
 b=qqukm0pVeGMDkCex5uFh2rJSAcnV/DkRm9mlFFec16uFmC5JOgZP7K4rJrHvB5mXKJVOq+TNI+t1znStbuhQGD00B+g4D2FCJpIHyrEWLn5QY8oePZVfX8+lt3dcB44+XYxt4psq8E9NH6ADcePKM2MK2vNWO8sXc4XxI2BR8uU=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BY5PR04MB7057.namprd04.prod.outlook.com (2603:10b6:a03:227::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 09:19:21 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::5154:e14a:2e36:bc95%3]) with mapi id 15.20.3541.024; Tue, 10 Nov 2020
 09:19:21 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Thread-Topic: WARNING: can't access registers at asm_common_interrupt
Thread-Index: AQHWtAKoC1N6UC8gbUaAN5Wk5A+R6Km7ZxIAgAQhSICAATBZgIAAZGsA
Date:   Tue, 10 Nov 2020 09:19:21 +0000
Message-ID: <20201110091920.k4x3facrnjdpl5uy@shindev.dhcp.fujisawa.hgst.com>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201106180628.r4emdw3yoxfzryzu@treble>
 <20201109091037.6upb63tclk4nhvl7@shindev.dhcp.fujisawa.hgst.com>
 <20201110031955.flxf7iq5yoxjzmsg@treble>
In-Reply-To: <20201110031955.flxf7iq5yoxjzmsg@treble>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b25472b-b0d6-4943-ca97-08d88559b554
x-ms-traffictypediagnostic: BY5PR04MB7057:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB70574A6DB515DB1E7EA35E76EDE90@BY5PR04MB7057.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8xN6UtIw3HottdttCeVGA1T35dv+6LfRO1+GMZTkARgyKxdSZiz4CcLgvqXCAXo9Q4OH4scRi8k6QsEFR1fcl45UuksCw32+7rBSfYlvCKv66pmAotro/iuXv+SeD1y8G1ajl6h40dlybVCx/n+js60FtwQ69cXS2ph8eWZqn5SqZ0Z8m2FSzn829kkVmgMiokMjqFw7hYb5FfRsNsmj67qVMs3sSUxpIFM7bOim3ovmq+QKytBUxnD94j0yOFpBbzLO3NCpZpAsIUQujrK+tbPbRcPzsljSDZoZg9Ux8Vs4QbQJW0jDkqJqh/Bh4ca+Fu2WmAzHjHe38eBU23GHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(9686003)(2906002)(71200400001)(66946007)(76116006)(91956017)(6506007)(66476007)(64756008)(66446008)(66556008)(1076003)(4326008)(478600001)(6486002)(316002)(8936002)(6512007)(5660300002)(8676002)(54906003)(186003)(83380400001)(86362001)(44832011)(6916009)(26005)(30864003)(559001)(579004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Zxxd9GN2YlJ1+vnWxK9619W5/7ExEdwFw2aR6W9VBCcIwAp411SyWom/q8JpVRUG+z7uflcgKimx22sPa76BVf2n2xg6iDAHkuzjrJ8FdEimyPwR+uT3XZyWOltjlvQvOy+ZrOR2gjOdildXY2Z9JD1owwft1YYebSD847k63+OG1pxTqlfsBuLg6d+3iWV+8zspybRZpsb45GbJUmEPx09Z7mu0JYjQaAB4PGbrleurNrE9gzKhxcohWtLmzgIjSGPZBVWjKedAQeDm6+5U3ZynFL8MB50xOq5Q+VxZMJwVGEzuu7Wxxg4EE3olT0as4CIlkIYtb0Ak7N/Y/wGLAeMPbSwavo+rk1L2Orm89Jrf3Y5bAln2F9ZZv/6pm4UrsgWQLBEGf+rR9zIwUjwQHYzsx31h0C8rSDucOcs/yAG6giTb86FoR1E5OnsE2xsAnni3ZiPOqJSNGf9ZX5bFi5FQ7TIntVX/0TBMRapUZOWdDeUiPQOnljiFUJ8BZrtXd8d2NvxPCnbgCavGktwc6ZpDFAavbCPyvOkl9WecmZEune8aA2RR5IK3Au5sZJB+6igYxPtqk2GBUg4d9ZMojawVpUhh8mJ7uGI6w4x31Xz8yBPHiE228cYKa+nqL1VrpaAMgjdFp6DujWpzXg0IfV/OAfrJV/afgpKiKoVe2l0uGxjWetKdWK3eizXt5h8dlQQK/ygA9Y/TrPsEbeKGdiYV2jlfMVNsuy1ZoA+sT7nBII9dorh22C4iKIuMX0f2+7pHj64s0BY0NUlN2dUSrm1w1BxNsJ0Wf70F2cqRgTtcHVqBFD7BMTfZXi3J/RKgsF1lJY1XKvqhZdmvk7nBaPOwCulupZAOhwQkbZHL2jJilc4I3tTmfVMYqLvt/woLuAfdqPUjnxxZMusTYxwx2g==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0666ED5ADAC0EC488AFBA28B175BC91E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b25472b-b0d6-4943-ca97-08d88559b554
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 09:19:21.2672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7SW0G6pNBvvU7hyI/f01IeJqFfA+0++Qu+zhuzcUvAE4tiGLOKJdHlTOEjFM/8A3KIjAX5qM9lAB7TQp8w3ZT0RQPD89aJmTS+7ZI8u2ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7057
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 09, 2020 / 21:19, Josh Poimboeuf wrote:
> On Mon, Nov 09, 2020 at 09:10:38AM +0000, Shinichiro Kawasaki wrote:
> > On Nov 06, 2020 / 12:06, Josh Poimboeuf wrote:
> > > On Fri, Nov 06, 2020 at 06:04:15AM +0000, Shinichiro Kawasaki wrote:
> > > > Greetings,
> > > >=20
> > > > I observe "WARNING: can't access registers at asm_common_interrupt+=
0x1e/0x40"
> > > > in my kernel test system repeatedly, which is printed by unwind_nex=
t_frame() in
> > > > "arch/x86/kernel/unwind_orc.c". Syzbot already reported that [1]. S=
imilar
> > > > warning was reported and discussed [2], but I suppose the cause is =
not yet
> > > > clarified.
> > > >=20
> > > > The warning was observed with v5.10-rc2 and older tags. I bisected =
and found
> > > > that the commit 044d0d6de9f5 ("lockdep: Only trace IRQ edges") in v=
5.9-rc3
> > > > triggered the warning. Reverting that from 5.10-rc2, the warning di=
sappeared.
> > > > May I ask comment by expertise on CC how this commit can relate to =
the warning?
> > > >=20
> > > > The test condition to reproduce the warning is rather unique (blkte=
sts,
> > > > dm-linear and ZNS device emulation by QEMU). If any action is sugge=
sted for
> > > > further analysis, I'm willing to take it with my test system.
> > >=20
> > > Hi,
> > >=20
> > > Thanks for reporting this issue.  This might be a different issue fro=
m
> > > [2].
> > >=20
> > > Can you send me the arch/x86/entry/entry_64.o file from your build?
> >=20
> > Hi Josh, thank you for your response. As a separated e-mail, I have sen=
t the
> > entry_64.o only to your address, since I hesitate to send around the 76=
kb
> > attachment file to LKML. In case it does not reach to you, please let m=
e know.
>=20
> Got it, thanks.  Unfortunately I'm still confused.
>=20
> Can you test with the following patch, and boot with 'unwind_debug'?
> That should hopefully dump a lot of useful data along with the warning.

Thank you for the patch. With the patch and 'unwind_debug' kernel command l=
ine,
I recreated the warning. Here I quote the kernel messages printed (smpboot
related messages are usual message printed for blktests test case block/008=
).

...
[  113.022680] smpboot: CPU 1 is now offline
[  113.030546] WARNING: can't access registers at asm_common_interrupt+0x1e=
/0x40
[  113.030549] unwind stack type:0 next_sp:0000000000000000 mask:0x6 graph_=
idx:0
[  113.030554] ffff8881e87097b0: 1ffff1103d0e1302 (0x1ffff1103d0e1302)
[  113.030558] ffff8881e87097b8: ffffffff9712a434 (unwind_next_frame+0x15e4=
/0x1fc0)
[  113.030560] ffff8881e87097c0: ffffffff99200c5e (asm_common_interrupt+0x1=
e/0x40)
[  113.030562] ffff8881e87097c8: 0000000000000000 (0x0)
[  113.030563] ffff8881e87097d0: ffff8881e87098bd (0xffff8881e87098bd)
[  113.030564] ffff8881e87097d8: ffff8881e87098d8 (0xffff8881e87098d8)
[  113.030565] ffff8881e87097e0: ffff8881e87098c0 (0xffff8881e87098c0)
[  113.030570] ffff8881e87097e8: ffffffff9ac85575 (__start_orc_unwind+0x65f=
81/0x37a91c)
[  113.030572] ffff8881e87097f0: ffffffff9ac85575 (__start_orc_unwind+0x65f=
81/0x37a91c)
[  113.030573] ffff8881e87097f8: ffff8881e8709938 (0xffff8881e8709938)
[  113.030574] ffff8881e8709800: 0000000000000000 (0x0)
[  113.030597] ffff8881e8709808: ffff88810ebd31c0 (0xffff88810ebd31c0)
[  113.030598] ffff8881e8709810: 0000000041b58ab3 (0x41b58ab3)
[  113.030602] ffff8881e8709818: ffffffff99d7a850 (.LC2+0x3be/0x44d)
[  113.030604] ffff8881e8709820: ffffffff97128e50 (deref_stack_reg+0x160/0x=
160)
[  113.030605] ffff8881e8709828: 0000000000000000 (0x0)
[  113.030606] ffff8881e8709830: 0000000000000000 (0x0)
[  113.030610] ffff8881e8709838: ffffffff972343bf (kernel_text_address.part=
.0+0x1f/0xc0)
[  113.030624] ffff8881e8709840: ffffffffc046fd90 (nvme_irq+0x10/0x20 [nvme=
])
[  113.030625] ffff8881e8709848: ffff8881e87098d0 (0xffff8881e87098d0)
[  113.030628] ffff8881e8709850: ffffffff973994c0 (create_prof_cpu_mask+0x2=
0/0x20)
[  113.030629] ffff8881e8709858: ffff8881e8709908 (0xffff8881e8709908)
[  113.030630] ffff8881e8709860: ffff8881e8709938 (0xffff8881e8709938)
[  113.030631] ffff8881e8709868: 0000000000000000 (0x0)
[  113.030632] ffff8881e8709870: ffff88810ebd31c0 (0xffff88810ebd31c0)
[  113.030633] ffff8881e8709878: 0000000000000006 (0x6)
[  113.030636] ffff8881e8709880: ffffffff9709925c (arch_stack_walk+0x6c/0xb=
0)
[  113.030637] ffff8881e8709888: 0000000000000000 (0x0)
[  113.030638] ffff8881e8709890: ffff88814c428000 (0xffff88814c428000)
[  113.030640] ffff8881e8709898: ffff88814c430000 (0xffff88814c430000)
[  113.030641] ffff8881e87098a0: 0000000000000000 (0x0)
[  113.030642] ffff8881e87098a8: 0000000000000006 (0x6)
[  113.030643] ffff8881e87098b0: ffff88810ebd31c0 (0xffff88810ebd31c0)
[  113.030644] ffff8881e87098b8: 0000010000000000 (0x10000000000)
[  113.030645] ffff8881e87098c0: 0000000000000000 (0x0)
[  113.030646] ffff8881e87098c8: 0000000000000000 (0x0)
[  113.030648] ffff8881e87098d0: ffffffff99200c5e (asm_common_interrupt+0x1=
e/0x40)
[  113.030649] ffff8881e87098d8: ffff88814c42fed0 (0xffff88814c42fed0)
[  113.030650] ffff8881e87098e0: 0000000000000000 (0x0)
[  113.030651] ffff8881e87098e8: ffffed103d0e1323 (0xffffed103d0e1323)
[  113.030652] ffff8881e87098f0: 0000000000000800 (0x800)
[  113.030653] ffff8881e87098f8: ffff88810b48a780 (0xffff88810b48a780)
[  113.030654] ffff8881e8709900: ffff8881e8709c48 (0xffff8881e8709c48)
[  113.030658] ffff8881e8709908: ffffffff97862595 (kmem_cache_free+0xf5/0x5=
90)
[  113.030660] ffff8881e8709910: ffffffff973996a1 (stack_trace_save+0x81/0x=
a0)
[  113.030661] ffff8881e8709918: 0000000041b58ab3 (0x41b58ab3)
[  113.030663] ffff8881e8709920: ffffffff99d89ef4 (.LC4+0x20f/0x14aa1)
[  113.030665] ffff8881e8709928: ffffffff97399620 (stack_trace_consume_entr=
y+0x160/0x160)
[  113.030666] ffff8881e8709930: ffff8881098e9800 (0xffff8881098e9800)
[  113.030667] ffff8881e8709938: ffff8881e8709988 (0xffff8881e8709988)
[  113.030668] ffff8881e8709940: 0000000000000040 (0x40)
[  113.030669] ffff8881e8709948: 0000000000000015 (0x15)
[  113.030670] ffff8881e8709950: ffff88811858d348 (0xffff88811858d348)
[  113.030672] ffff8881e8709958: ffffffff97862595 (kmem_cache_free+0xf5/0x5=
90)
[  113.030673] ffff8881e8709960: 0000000000000800 (0x800)
[  113.030674] ffff8881e8709968: ffff88810b48a780 (0xffff88810b48a780)
[  113.030675] ffff8881e8709970: ffff8881e8709c48 (0xffff8881e8709c48)
[  113.030676] ffff8881e8709978: ffff88811858c008 (0xffff88811858c008)
[  113.030678] ffff8881e8709980: ffffffff978649db (kasan_save_stack+0x1b/0x=
40)
[  113.030680] ffff8881e8709988: ffffffff978649db (kasan_save_stack+0x1b/0x=
40)
[  113.030681] ffff8881e8709990: ffffffff97864a1c (kasan_set_track+0x1c/0x3=
0)
[  113.030684] ffff8881e8709998: ffffffff97866f5b (kasan_set_free_info+0x1b=
/0x30)
[  113.030685] ffff8881e87099a0: ffffffff97864980 (__kasan_slab_free+0x110/=
0x150)
[  113.030687] ffff8881e87099a8: ffffffff9785b4da (slab_free_freelist_hook+=
0x5a/0x170)
[  113.030689] ffff8881e87099b0: ffffffff97862595 (kmem_cache_free+0xf5/0x5=
90)
[  113.030692] ffff8881e87099b8: ffffffff988f4da0 (dec_pending+0x1f0/0x900)
[  113.030694] ffff8881e87099c0: ffffffff988fad15 (clone_endio+0x1e5/0x940)
[  113.030697] ffff8881e87099c8: ffffffff97eac8f6 (blk_update_request+0x716=
/0xe20)
[  113.030699] ffff8881e87099d0: ffffffff97ed523b (blk_mq_end_request+0x4b/=
0x480)
[  113.030701] ffff8881e87099d8: ffffffffc046e863 (nvme_process_cq+0x563/0x=
a40 [nvme])
[  113.030703] ffff8881e87099e0: ffffffffc046fd90 (nvme_irq+0x10/0x20 [nvme=
])
[  113.030706] ffff8881e87099e8: ffffffff9733ef52 (__handle_irq_event_percp=
u+0x252/0x620)
[  113.030707] ffff8881e87099f0: ffffffff9733f51f (handle_irq_event+0xef/0x=
240)
[  113.030709] ffff8881e87099f8: ffffffff9734bff6 (handle_edge_irq+0x1f6/0x=
b60)
[  113.030712] ffff8881e8709a00: ffffffff992010b2 (asm_call_irq_on_stack+0x=
12/0x20)
[  113.030714] ffff8881e8709a08: ffffffff9918f05b (common_interrupt+0xeb/0x=
190)
[  113.030716] ffff8881e8709a10: ffffffff99200c5e (asm_common_interrupt+0x1=
e/0x40)
[  113.030717] ffff8881e8709a18: ffffffff97395f70 (exit_to_user_mode_prepar=
e+0xc0/0x1d0)
[  113.030719] ffff8881e8709a20: ffffffff99200c48 (asm_common_interrupt+0x8=
/0x40)
[  113.030721] ffff8881e8709a28: ffffffff99200c5e (asm_common_interrupt+0x1=
e/0x40)
[  113.030723] ffff8881e8709a30: ffffffff991a91e0 (schedule+0xd0/0x270)
[  113.030724] ffff8881e8709a38: ffffffff97395fb7 (exit_to_user_mode_prepar=
e+0x107/0x1d0)
[  113.030725] ffff8881e8709a40: 1ffff1103d0e134e (0x1ffff1103d0e134e)
[  113.030727] ffff8881e8709a48: ffff8881e8733dc8 (0xffff8881e8733dc8)
[  113.030728] ffff8881e8709a50: ffff8881e8733d40 (0xffff8881e8733d40)
[  113.030729] ffff8881e8709a58: 00000019d79785f8 (0x19d79785f8)
[  113.030730] ffff8881e8709a60: 0000000000000005 (0x5)
[  113.030731] ffff8881e8709a68: 0000000000000000 (0x0)
[  113.030732] ffff8881e8709a70: ffff88810b579980 (0xffff88810b579980)
[  113.030733] ffff8881e8709a78: ffff88810b579800 (0xffff88810b579800)
[  113.030736] ffff8881e8709a80: ffffffff97286cda (update_load_avg+0x1fa/0x=
1ad0)
[  113.030737] ffff8881e8709a88: ffff88810b57a000 (0xffff88810b57a000)
[  113.030738] ffff8881e8709a90: ffff88810b579800 (0xffff88810b579800)
[  113.030739] ffff8881e8709a98: 0000000000000400 (0x400)
[  113.030741] ffff8881e8709aa0: ffffffff9729be38 (update_cfs_group+0x118/0=
x290)
[  113.030743] ffff8881e8709aa8: ffffffff973146a0 (lock_downgrade+0x6a0/0x6=
a0)
[  113.030744] ffff8881e8709ab0: 0000000000000000 (0x0)
[  113.030745] ffff8881e8709ab8: ffff88810b579850 (0xffff88810b579850)
[  113.030746] ffff8881e8709ac0: ffff8881e8733d68 (0xffff8881e8733d68)
[  113.030747] ffff8881e8709ac8: ffff8881e8733d40 (0xffff8881e8733d40)
[  113.030748] ffff8881e8709ad0: 0000000000000001 (0x1)
[  113.030749] ffff8881e8709ad8: ffff88810b579810 (0xffff88810b579810)
[  113.030751] ffff8881e8709ae0: ffffffff972a14b2 (enqueue_entity+0x402/0x2=
ba0)
[  113.030752] ffff8881e8709ae8: ffff8881e8733d50 (0xffff8881e8733d50)
[  113.030753] ffff8881e8709af0: ffff88810b579800 (0xffff88810b579800)
[  113.030754] ffff8881e8709af8: ffff8881e8733d80 (0xffff8881e8733d80)
[  113.030755] ffff8881e8709b00: ffff888116873268 (0xffff888116873268)
[  113.030757] ffff8881e8709b08: ffff8881e8734790 (0xffff8881e8734790)
[  113.030758] ffff8881e8709b10: ffff88810ebd3268 (0xffff88810ebd3268)
[  113.030759] ffff8881e8709b18: ffff8881e8720e80 (0xffff8881e8720e80)
[  113.030760] ffff8881e8709b20: ffff88810b579800 (0xffff88810b579800)
[  113.030761] ffff8881e8709b28: ffff88810b579950 (0xffff88810b579950)
[  113.030762] ffff8881e8709b30: 0000000000000009 (0x9)
[  113.030763] ffff8881e8709b38: ffff8881e8733c80 (0xffff8881e8733c80)
[  113.030764] ffff8881e8709b40: ffff88810ebd31c0 (0xffff88810ebd31c0)
[  113.030765] ffff8881e8709b48: 0000000000000002 (0x2)
[  113.030768] ffff8881e8709b50: ffffffff97263aef (resched_curr+0x17f/0x1e0=
)
[  113.030769] ffff8881e8709b58: ffff8881098e9000 (0xffff8881098e9000)
[  113.030770] ffff8881e8709b60: ffff8881098e9038 (0xffff8881098e9038)
[  113.030771] ffff8881e8709b68: 000000000056e125 (0x56e125)
[  113.030772] ffff8881e8709b70: 0000000000000002 (0x2)
[  113.030773] ffff8881e8709b78: 1ffff1103d0e1374 (0x1ffff1103d0e1374)
[  113.030774] ffff8881e8709b80: ffff888116873e20 (0xffff888116873e20)
[  113.030775] ffff8881e8709b88: ffff88811858c000 (0xffff88811858c000)
[  113.030777] ffff8881e8709b90: ffffffff97864a1c (kasan_set_track+0x1c/0x3=
0)
[  113.030778] ffff8881e8709b98: 1ffff110230b1800 (0x1ffff110230b1800)
[  113.030780] ffff8881e8709ba0: ffffffff97866f5b (kasan_set_free_info+0x1b=
/0x30)
[  113.030781] ffff8881e8709ba8: 0000000000000001 (0x1)
[  113.030782] ffff8881e8709bb0: ffffffff97864980 (__kasan_slab_free+0x110/=
0x150)
[  113.030783] ffff8881e8709bb8: ffff88810b48a780 (0xffff88810b48a780)
[  113.030785] ffff8881e8709bc0: ffff88811858c000 (0xffff88811858c000)
[  113.030786] ffff8881e8709bc8: 3b9c1e2c25148a56 (0x3b9c1e2c25148a56)
[  113.030787] ffff8881e8709bd0: ffff88811858c000 (0xffff88811858c000)
[  113.030788] ffff8881e8709bd8: ffffffff9785b4da (slab_free_freelist_hook+=
0x5a/0x170)
[  113.030789] ffff8881e8709be0: ffff8881e8709c50 (0xffff8881e8709c50)
[  113.030790] ffff8881e8709be8: ffff88819858c000 (0xffff88819858c000)
[  113.030792] ffff8881e8709bf0: ffff88810b48a780 (0xffff88810b48a780)
[  113.030793] ffff8881e8709bf8: ffffea0004616300 (0xffffea0004616300)
[  113.030794] ffff8881e8709c00: ffff88811858c000 (0xffff88811858c000)
[  113.030795] ffff8881e8709c08: 0000000000000000 (0x0)
[  113.030796] ffff8881e8709c10: ffff8881059402a0 (0xffff8881059402a0)
[  113.030797] ffff8881e8709c18: ffffffff97862595 (kmem_cache_free+0xf5/0x5=
90)
[  113.030799] ffff8881e8709c20: ffff888114d87038 (0xffff888114d87038)
[  113.030799] ffff8881e8709c28: 0000000000000000 (0x0)
[  113.030801] ffff8881e8709c30: ffffffff988f4da0 (dec_pending+0x1f0/0x900)
[  113.030802] ffff8881e8709c38: ffff8881059403b8 (0xffff8881059403b8)
[  113.030803] ffff8881e8709c40: ffff88811858c0a8 (0xffff88811858c0a8)
[  113.030804] ffff8881e8709c48: 0000000000000000 (0x0)
[  113.030805] ffff8881e8709c50: 0000000000000000 (0x0)
[  113.030806] ffff8881e8709c58: ffff88811858c000 (0xffff88811858c000)
[  113.030807] ffff8881e8709c60: ffff88814c427ab8 (0xffff88814c427ab8)
[  113.030808] ffff8881e8709c68: ffff888105940000 (0xffff888105940000)
[  113.030809] ffff8881e8709c70: 0000000000000000 (0x0)
[  113.030810] ffff8881e8709c78: ffff88814c427ac8 (0xffff88814c427ac8)
[  113.030811] ffff8881e8709c80: ffff8881059402a0 (0xffff8881059402a0)
[  113.030813] ffff8881e8709c88: ffffffff988f4da0 (dec_pending+0x1f0/0x900)
[  113.030814] ffff8881e8709c90: ffff888105940000 (0xffff888105940000)
[  113.030815] ffff8881e8709c98: 00000000fffd21a8 (0xfffd21a8)
[  113.030816] ffff8881e8709ca0: 0000000400000000 (0x400000000)
[  113.030817] ffff8881e8709ca8: ffff88814c427ac0 (0xffff88814c427ac0)
[  113.030818] ffff8881e8709cb0: 1ffff1103d0e139c (0x1ffff1103d0e139c)
[  113.030819] ffff8881e8709cb8: 1ffff1103d0e13a0 (0x1ffff1103d0e13a0)
[  113.030820] ffff8881e8709cc0: ffff88811858c0a8 (0xffff88811858c0a8)
[  113.030822] ffff8881e8709cc8: ffff88814c427ab8 (0xffff88814c427ab8)
[  113.030823] ffff8881e8709cd0: ffff88811858c000 (0xffff88811858c000)
[  113.030824] ffff8881e8709cd8: 0000000000000000 (0x0)
[  113.030825] ffff8881e8709ce0: ffff88811858c088 (0xffff88811858c088)
[  113.030826] ffff8881e8709ce8: ffffffff988fad15 (clone_endio+0x1e5/0x940)
[  113.030827] ffff8881e8709cf0: ffff888102a26c38 (0xffff888102a26c38)
[  113.030828] ffff8881e8709cf8: ffff88811858c0b0 (0xffff88811858c0b0)
[  113.030829] ffff8881e8709d00: 0000000041b58ab3 (0x41b58ab3)
[  113.030831] ffff8881e8709d08: ffffffff99e07e8f (.LC0+0x31f92/0x36703)
[  113.030833] ffff8881e8709d10: ffffffff988fab30 (disable_discard+0xd0/0xd=
0)
[  113.030834] ffff8881e8709d18: ffff88811858c0a8 (0xffff88811858c0a8)
[  113.030835] ffff8881e8709d20: ffff88811858c000 (0xffff88811858c000)
[  113.030836] ffff8881e8709d28: ffff88811858c0e0 (0xffff88811858c0e0)
[  113.030837] ffff8881e8709d30: ffff88811858c0b0 (0xffff88811858c0b0)
[  113.030838] ffff8881e8709d38: ffff88811a753300 (0xffff88811a753300)
[  113.030840] ffff8881e8709d40: dffffc0000000000 (0xdffffc0000000000)
[  113.030841] ffff8881e8709d48: ffff88811858c0a8 (0xffff88811858c0a8)
[  113.030842] ffff8881e8709d50: ffff88811a75331c (0xffff88811a75331c)
[  113.030843] ffff8881e8709d58: 0000000000001000 (0x1000)
[  113.030844] ffff8881e8709d60: 0000000000001000 (0x1000)
[  113.030845] ffff8881e8709d68: ffff88811a753300 (0xffff88811a753300)
[  113.030846] ffff8881e8709d70: ffffffff97eac8f6 (blk_update_request+0x716=
/0xe20)
[  113.030847] ffff8881e8709d78: ffffffff00000000 (0xffffffff00000000)
[  113.030848] ffff8881e8709d80: 0000000000000000 (0x0)
[  113.030849] ffff8881e8709d88: ffffed10234ea667 (0xffffed10234ea667)
[  113.030851] ffff8881e8709d90: ffff88811858c0d0 (0xffff88811858c0d0)
[  113.030852] ffff8881e8709d98: ffffed10234ea663 (0xffffed10234ea663)
[  113.030853] ffff8881e8709da0: ffff88811a753318 (0xffff88811a753318)
[  113.030854] ffff8881e8709da8: ffff88811a753338 (0xffff88811a753338)
[  113.030855] ffff8881e8709db0: ffff888111788800 (0xffff888111788800)
[  113.030856] ffff8881e8709db8: dffffc0000000000 (0xdffffc0000000000)
[  113.030857] ffff8881e8709dc0: ffff88811a753300 (0xffff88811a753300)
[  113.030858] ffff8881e8709dc8: 0000000000000000 (0x0)
[  113.030859] ffff8881e8709dd0: ffff88811a753300 (0xffff88811a753300)
[  113.030860] ffff8881e8709dd8: ffff888116c828c0 (0xffff888116c828c0)
[  113.030861] ffff8881e8709de0: ffffed1020316ea8 (0xffffed1020316ea8)
[  113.030863] ffff8881e8709de8: ffffffff97ed523b (blk_mq_end_request+0x4b/=
0x480)
[  113.030864] ffff8881e8709df0: dffffc0000000000 (0xdffffc0000000000)
[  113.030865] ffff8881e8709df8: dffffc0000000000 (0xdffffc0000000000)
[  113.030866] ffff8881e8709e00: ffff8881018b7480 (0xffff8881018b7480)
[  113.030867] ffff8881e8709e08: 0000000000000000 (0x0)
[  113.030868] ffff8881e8709e10: ffff88811a753300 (0xffff88811a753300)
[  113.030869] ffff8881e8709e18: ffff888116c828c0 (0xffff888116c828c0)
[  113.030871] ffff8881e8709e20: ffffffffc046e863 (nvme_process_cq+0x563/0x=
a40 [nvme])
[  113.030872] ffff8881e8709e28: ffffed1020316ead (0xffffed1020316ead)
[  113.030873] ffff8881e8709e30: ffff888116c828cc (0xffff888116c828cc)
[  113.030874] ffff8881e8709e38: 0000000197314fd1 (0x197314fd1)
[  113.030875] ffff8881e8709e40: ffff8881018b756c (0xffff8881018b756c)
[  113.030876] ffff8881e8709e48: ffff8881018b7560 (0xffff8881018b7560)
[  113.030878] ffff8881e8709e50: ffff8881018b756a (0xffff8881018b756a)
[  113.030879] ffff8881e8709e58: ffff88810e3c98c0 (0xffff88810e3c98c0)
[  113.030880] ffff8881e8709e60: ffff8881018b7540 (0xffff8881018b7540)
[  113.030881] ffff8881e8709e68: ffff8881018b7568 (0xffff8881018b7568)
[  113.030883] ffff8881e8709e70: ffffffff9733f50a (handle_irq_event+0xda/0x=
240)
[  113.030884] ffff8881e8709e78: dffffc0000000000 (0xdffffc0000000000)
[  113.030886] ffff8881e8709e80: ffffffffc046fd80 (nvme_suspend+0x330/0x330=
 [nvme])
[  113.030887] ffff8881e8709e88: ffff8881e8709f48 (0xffff8881e8709f48)
[  113.030888] ffff8881e8709e90: ffff88810e3c9800 (0xffff88810e3c9800)
[  113.030889] ffff8881e8709e98: ffff8881152e7f00 (0xffff8881152e7f00)
[  113.030890] ffff8881e8709ea0: 000000000000001c (0x1c)
[  113.030892] ffff8881e8709ea8: ffffffffc046fd90 (nvme_irq+0x10/0x20 [nvme=
])
[  113.030894] ffff8881e8709eb0: ffffffff9733ef52 (__handle_irq_event_percp=
u+0x252/0x620)
[  113.030895] ffff8881e8709eb8: 0000000000000002 (0x2)
[  113.030896] ffff8881e8709ec0: 0000000000000000 (0x0)
[  113.030897] ffff8881e8709ec8: ffffed1021c7930f (0xffffed1021c7930f)
[  113.030898] ffff8881e8709ed0: ffff88810ebd3eb8 (0xffff88810ebd3eb8)
[  113.030899] ffff8881e8709ed8: ffff88810ebd31c0 (0xffff88810ebd31c0)
[  113.030900] ffff8881e8709ee0: ffff88810e3c9878 (0xffff88810e3c9878)
[  113.030901] ffff8881e8709ee8: ffff88810e3c9800 (0xffff88810e3c9800)
[  113.030902] ffff8881e8709ef0: 1ffff1103d0e13e5 (0x1ffff1103d0e13e5)
[  113.030903] ffff8881e8709ef8: ffff88810e3c9800 (0xffff88810e3c9800)
[  113.030904] ffff8881e8709f00: ffff88810e3c9838 (0xffff88810e3c9838)
[  113.030906] ffff8881e8709f08: ffff88810e3c98a8 (0xffff88810e3c98a8)
[  113.030907] ffff8881e8709f10: ffff88810e3c9800 (0xffff88810e3c9800)
[  113.030908] ffff8881e8709f18: ffffffff9733f51f (handle_irq_event+0xef/0x=
240)
[  113.030909] ffff8881e8709f20: 0000000000000002 (0x2)
[  113.030910] ffff8881e8709f28: 0000000041b58ab3 (0x41b58ab3)
[  113.030912] ffff8881e8709f30: ffffffff99d88063 (.LC0+0x10d5/0x2d57)
[  113.030914] ffff8881e8709f38: ffffffff9733f430 (handle_irq_event_percpu+=
0x110/0x110)
[  113.030915] ffff8881e8709f40: 0000000000000000 (0x0)
[  113.030916] ffff8881e8709f48: 0000000000000000 (0x0)
[  113.030917] ffff8881e8709f50: ffff88810e3c98a8 (0xffff88810e3c98a8)
[  113.030918] ffff8881e8709f58: ffff88810e3c987c (0xffff88810e3c987c)
[  113.030919] ffff8881e8709f60: 0000000000000000 (0x0)
[  113.030920] ffff8881e8709f68: ffffed1021c7930e (0xffffed1021c7930e)
[  113.030921] ffff8881e8709f70: ffff88810e3c9838 (0xffff88810e3c9838)
[  113.030922] ffff8881e8709f78: ffff88810e3c987c (0xffff88810e3c987c)
[  113.030923] ffff8881e8709f80: ffffed1021c7930f (0xffffed1021c7930f)
[  113.030925] ffff8881e8709f88: dffffc0000000000 (0xdffffc0000000000)
[  113.030926] ffff8881e8709f90: ffffffff9734bff6 (handle_edge_irq+0x1f6/0x=
b60)
[  113.030927] ffff8881e8709f98: ffff88810e3c98a8 (0xffff88810e3c98a8)
[  113.030928] ffff8881e8709fa0: ffff88810e3c9870 (0xffff88810e3c9870)
[  113.030929] ffff8881e8709fa8: ffff88810e3c9840 (0xffff88810e3c9840)
[  113.030930] ffff8881e8709fb0: ffff88810e3c9828 (0xffff88810e3c9828)
[  113.030931] ffff8881e8709fb8: 0000000000000000 (0x0)
[  113.030932] ffff8881e8709fc0: 0000000000000023 (0x23)
[  113.030933] ffff8881e8709fc8: ffff88814c42fe30 (0xffff88814c42fe30)
[  113.030934] ffff8881e8709fd0: ffff88810e3c9800 (0xffff88810e3c9800)
[  113.030935] ffff8881e8709fd8: 0000000000000000 (0x0)
[  113.030936] ffff8881e8709fe0: 0000000000000000 (0x0)
[  113.030937] ffff8881e8709fe8: 0000000000000023 (0x23)
[  113.030939] ffff8881e8709ff0: ffffffff992010b2 (asm_call_irq_on_stack+0x=
12/0x20)
[  113.030940] ffff8881e8709ff8: ffff88814c42fe30 (0xffff88814c42fe30)
[  113.030942] ffff88814c42fe30: ffff88814c42fe78 (0xffff88814c42fe78)
[  113.030943] ffff88814c42fe38: ffffffff9918f05b (common_interrupt+0xeb/0x=
190)
[  113.030944] ffff88814c42fe40: 0000000000000000 (0x0)
[  113.030945] ffff88814c42fe48: 0000000000000000 (0x0)
[  113.030946] ffff88814c42fe50: 0000000000000000 (0x0)
[  113.030947] ffff88814c42fe58: 0000000000000000 (0x0)
[  113.030948] ffff88814c42fe60: 0000000000000000 (0x0)
[  113.030949] ffff88814c42fe68: 0000000000000000 (0x0)
[  113.030950] ffff88814c42fe70: ffffffff99200c5e (asm_common_interrupt+0x1=
e/0x40)
[  113.030951] ffff88814c42fe78: 0000000000000000 (0x0)
[  113.030952] ffff88814c42fe80: 0000000000000000 (0x0)
[  113.030953] ffff88814c42fe88: 0000000000000000 (0x0)
[  113.030954] ffff88814c42fe90: ffff88810ebd31c0 (0xffff88810ebd31c0)
[  113.030955] ffff88814c42fe98: ffff88814c42ff58 (0xffff88814c42ff58)
[  113.030956] ffff88814c42fea0: 0000000000000000 (0x0)
[  113.030957] ffff88814c42fea8: 0000000000000001 (0x1)
[  113.030958] ffff88814c42feb0: ffffed1021d7a638 (0xffffed1021d7a638)
[  113.030959] ffff88814c42feb8: ffff88810ebd31c7 (0xffff88810ebd31c7)
[  113.030960] ffff88814c42fec0: 0000000000000000 (0x0)
[  113.030961] ffff88814c42fec8: 0000000000400140 (0x400140)
[  113.030963] ffff88814c42fed0: ffffffff991a91f4 (schedule+0xe4/0x270)
[  113.030963] ffff88814c42fed8: 0000000000000000 (0x0)
[  113.030964] ffff88814c42fee0: 0000000000000008 (0x8)
[  113.030965] ffff88814c42fee8: ffff88810ebd31c0 (0xffff88810ebd31c0)
[  113.030967] ffff88814c42fef0: ffffffffffffffff (0xffffffffffffffff)
[  113.030968] ffff88814c42fef8: ffffffff97395f70 (exit_to_user_mode_prepar=
e+0xc0/0x1d0)
[  113.030969] ffff88814c42ff00: 0000000000000010 (0x10)
[  113.030970] ffff88814c42ff08: 0000000000000246 (0x246)
[  113.030971] ffff88814c42ff10: ffff88814c42ff28 (0xffff88814c42ff28)
[  113.030972] ffff88814c42ff18: 0000000000000018 (0x18)
[  113.030973] ffff88814c42ff20: 0000000000000000 (0x0)
[  113.030974] ffff88814c42ff28: 0000000000000246 (0x246)
[  113.030975] ffff88814c42ff30: 0000000000000000 (0x0)
[  113.030976] ffff88814c42ff38: 0000000000000000 (0x0)
[  113.030978] ffff88814c42ff40: ffffffff99200c48 (asm_common_interrupt+0x8=
/0x40)
[  113.030980] ffff88814c42ff48: ffffffff99191c95 (irqentry_exit_to_user_mo=
de+0x5/0x40)
[  113.030981] ffff88814c42ff50: ffffffff99200c5e (asm_common_interrupt+0x1=
e/0x40)
[  113.030982] ffff88814c42ff58: 0000000000aaa828 (0xaaa828)
[  113.030983] ffff88814c42ff60: 0000000000001000 (0x1000)
[  113.030984] ffff88814c42ff68: 0000000000000000 (0x0)
[  113.030985] ffff88814c42ff70: 00007f02266d1460 (0x7f02266d1460)
[  113.030986] ffff88814c42ff78: 0000000000aaa800 (0xaaa800)
[  113.030987] ffff88814c42ff80: 0000000000aaa800 (0xaaa800)
[  113.030988] ffff88814c42ff88: 0000000000000293 (0x293)
[  113.030989] ffff88814c42ff90: 0000000000b59000 (0xb59000)
[  113.030990] ffff88814c42ff98: 00007ffdf02c4090 (0x7ffdf02c4090)
[  113.030991] ffff88814c42ffa0: 0000000000000000 (0x0)
[  113.030992] ffff88814c42ffa8: 0000000000001000 (0x1000)
[  113.030994] ffff88814c42ffb0: 00007f028a34124f (0x7f028a34124f)
[  113.030995] ffff88814c42ffb8: 0000000000001000 (0x1000)
[  113.030995] ffff88814c42ffc0: 0000000000abd000 (0xabd000)
[  113.030996] ffff88814c42ffc8: 0000000000000007 (0x7)
[  113.030998] ffff88814c42ffd0: ffffffffffffffff (0xffffffffffffffff)
[  113.030999] ffff88814c42ffd8: 00007f028a34124f (0x7f028a34124f)
[  113.031000] ffff88814c42ffe0: 0000000000000033 (0x33)
[  113.031000] ffff88814c42ffe8: 0000000000000293 (0x293)
[  113.031002] ffff88814c42fff0: 00007ffdf01f96d0 (0x7ffdf01f96d0)
[  113.031002] ffff88814c42fff8: 000000000000002b (0x2b)
[  115.105359] smpboot: CPU 3 is now offline
[  115.359319] smpboot: CPU 2 is now offline
...

--=20
Best Regards,
Shin'ichiro Kawasaki=
