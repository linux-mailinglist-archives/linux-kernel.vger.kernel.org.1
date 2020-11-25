Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6B2C3EA3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKYLAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:00:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55812 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgKYLAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606302738; x=1637838738;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zMi+4yc8xiLrmBf6dBpSEwsGdWhW1f+7S3U8WqCpCYE=;
  b=VqmhpwY7VHVlPhQCyGUAPRxdeb4LAq3GHJIbIEK+QQdzi4IUqEDH6EZr
   ZPT4Fq7BOZSRN9JRBI4P+BLkF/fb40JVxIpyNzPQ8klHwZmQhLolLszHV
   rKFiJPfmKb2C/07xhwdd234IV93X1nF+uzKpxoiksPBf6IRagvU1/W7Sy
   CEIfrr17zSICz+Vzy7hHeSVHt4Nwt1mF1WlDWbThbPakMQerSZW7XtKY8
   7nJDoxB9ZEdILscPM65iRRdxNsiVA0KgkXH4900SpNehwA70Cntyrou/0
   Di/dhXfEYxz67URYcKUrNyxeg5gZrz5JsckYNEbQo6tUydyQzsncxRS+e
   A==;
IronPort-SDR: 5uQf+FDbOAgfDfADJfmkDRophf+zqe6OUr2RODLCp4fxi1g4gKrQKN8nUgh2d6+E7t79s3biHi
 KkfOXLVJtRDkzGKwRYOBPE33QSzUFvCOagDWfUrMICRfkUfZr5c3xpe5cIXVuEbwOS3fTF73UP
 uRN4hMf/3RrdqQ2Xujz2mKHLKJEbGJkwQ2UUAfMKXv0yUB8sDtlgVZi99zQMuKOzdxmSX40DCi
 BnVwaVcMvDyMwva5zB48ZuZGDGT9eUoZCyiE+FJ0v3DtEJw/WhIqGSXmA8VKoHVHHUzt5Gg/+O
 afs=
X-IronPort-AV: E=Sophos;i="5.78,368,1599494400"; 
   d="scan'208";a="257082384"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 19:12:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYh0QsWWrfa/RqCgC9ndPvmB5baRlRF44czQIDellzSuPL6DGR6IB9UUfO4mChiQJK3SiwlbnLRK0gFnKb3dkLVm4sGq7rdUzdTXckDj8teLqxmXeUglfZ2moIbOyCQQymYVUpHDBJOjOLb2n5w0YBZuQLIe5Zvu3obGlKHgh2X/Y+HWsDjqUfSM1zJkhiuCKm6stePP5vtfjxDpTloKb9bPmtkNv4zhiTr2anLu0opslz1rkP47skR9tMY6TKXsTKf4MWqMve91OnkZt0/9s9Lu2TG+O0PsddO5HW0TlhY1oXb9Ifh1Vzc1dXN10W8NvMvzFly9IwOWqRms57cp/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGMFFBpf5UUGQGEKLbo39dxlnFBYwRFykQasq4Vq3Ic=;
 b=lGS2qUm0mhR4/lJ7nEwvjGkrUR9mLcMuuPoJIKlNMjHptOtL/yZ8fCai3HiCSMJOI5JdzH6vYBC2Y9wAD/w5qBPArtdd16VB0t5KCzxVonlL0qtoIq9NeB19uOYB25//A5uOZ+iFdtOFqhgdQE7Q71+VuKSmrXdbppVk+nzWKQISGpqMaHrUyexdMbHUcKAqyPuFuC50GBs0or29iqQi7JGtW0oWKQsLUbOPgV7Xcm6ZceZGvSfms0tQkNEhEHmqTl4tNVbEH/nND2tBD9b5zy/v00+ePu8XpLdbWeZ5lX04h0VgDwaurNH1mDoFgWx5uc+UQchDofTsmA3EzFwynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGMFFBpf5UUGQGEKLbo39dxlnFBYwRFykQasq4Vq3Ic=;
 b=Us7u+ZkrYkRieQMnbU5EYXFRbhNxfft0zblc8OHs6crR89ghfJg8pvBTmTSqQazKPWzUTcagLZHbo1i2ggf3a0SB6fJDzTwELQjEyzMEqH+RH1z364eukYkDjBRWAIGZTvEjO+JeT5bEI5laXw+y8UcKQUL8Aoxsbo9iOuAJt4k=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6505.namprd04.prod.outlook.com (2603:10b6:610:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 25 Nov
 2020 11:00:08 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 11:00:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
Thread-Topic: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
Thread-Index: AQHWwpO1HQiFqsmnr0WJzbSNTitMeQ==
Date:   Wed, 25 Nov 2020 11:00:08 +0000
Message-ID: <CH2PR04MB6522E6443C6E12CD28FD1A30E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201124185738.3541314-1-geert@linux-m68k.org>
 <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CAMuHMdW9dySq3y_Uixv8_7e+Pe2VKw4iGV36mx-DbX6-yzk-Gw@mail.gmail.com>
 <CH2PR04MB652268FD0FB44AA5DF36ACFBE7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CAMuHMdXEzo4EOw_=MgskNXPrbkP4Ui+dHKZ5iyJ04h453BUAhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a795c403-98d3-41cd-f563-08d8913145f9
x-ms-traffictypediagnostic: CH2PR04MB6505:
x-microsoft-antispam-prvs: <CH2PR04MB650535B1FC29FA5C52983DE1E7FA0@CH2PR04MB6505.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JDhmRdA5gXqKlNFI378dWmkgIWhERFZI1Nho8HqeVAgvU2jmqhrNWkuSOSi3/80GZVFYDd0OvMjc27zQipxB3CZ2VKeJ7J6W/dV1DDb3GX10DofPKNZnSV8WEtYS5LsZTHE1vhKCJC64sxuG+arm8wIQlAwu0faolgUDpe1JtlIZJm9to7JIdqrCixzlKpbe/v6cNmw4g23kunNUSEtY5OklSRAQtsRURFp0JStuRuzja8+PlcEoFbj7r8a2mh8r0X3XhnL0U3gy+QRyTmcq4XCDxySxWhNN0Aco1oME1mVJSJmLR6dLkME4U1xaxCUrMQHaV70SU6aDbhU5vik16+ZWVZS4Ax/iwcDbJuyqlYFp81mtIXCRs0XaryejVZefRPxkxgRFJUozZVjuU4zbyA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(7696005)(316002)(966005)(6916009)(52536014)(2906002)(478600001)(71200400001)(66556008)(66476007)(6506007)(8936002)(5660300002)(53546011)(83380400001)(64756008)(4326008)(186003)(54906003)(86362001)(66946007)(55016002)(91956017)(33656002)(76116006)(9686003)(66446008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DHh6Ty7cq4Hu3PZoD2oJbz0Dzfw7eg7bSxL8UgEVQOA0b3En7eMQmLBNloc3?=
 =?us-ascii?Q?Sa8EajGUd6nC6E3YwtL7A3AA+IQ3WQ7uG0gONTXlYgQEpxdLXKns57DiqGjh?=
 =?us-ascii?Q?L1mAP/D3aBt7B1Cm0NEMMGsC5a9vVoXFPCzXYHLpNNrThkSH9kdHu7LDoLhX?=
 =?us-ascii?Q?TNf/m/7wdYwTOhz+d9D+nvLNQzzCjf7u6yObd+QcLsxxKUxGy+sLBnK8+/Uu?=
 =?us-ascii?Q?iWAZh6XHtheLblrVPiOYTzd8ZY93TYsIWf2ifH86U6lKVIusgueVOtf1jEC+?=
 =?us-ascii?Q?2zms4U9mnuejGHygdXY7gCJ7waGPSMfKIXeGja0QF2554sLkzPeSPzed4pDE?=
 =?us-ascii?Q?UNqLk1XpVeUVmZ3kVNPlnmBYkg5UNH9vdiI94F4mq5cbuP0c2Kl8Opi8D40p?=
 =?us-ascii?Q?4tjAHjN63Z77Sker7iOyvGsuaXcKwS6T2zcfWqXELCTGKNqPRFnwWloGwaSQ?=
 =?us-ascii?Q?5/bxVRJziLpnUehNdDFsEkgscdfipY3WAESd/fJHOebZ7U8fzVMDLm6qLZYU?=
 =?us-ascii?Q?RWAhsVIvb+wVvPKC4unQUb8bpIasMNQ+scjj0mqerT6DClT5b32+IUNIrdzF?=
 =?us-ascii?Q?Yoi/zaMl0pGipXHa9OkXzTQZ9jYnaZ0UHFhhuqQ7wCRz7DDkkEuDubVooOWg?=
 =?us-ascii?Q?yZ+plsUhmsHsx7aYlWOmHTEib1deIKxy7O3Uh89lKPBC+87X6Y81eya4Yocf?=
 =?us-ascii?Q?IpUWO9JOaKwRzsPOEPlXAU7iY91mUrVbMWjsLB+GSq3kKM7JuoqGwa8xhffQ?=
 =?us-ascii?Q?kPhcjM+uGO1UXnVw2mo1hLG9OgsyMwzJw8HsPcFXp+d35Q2o/8TPt0jiNPWL?=
 =?us-ascii?Q?dFGrCxjaLPp43m0OAnBCPZj0t4rkjEQ5V8ukh2JSFMrvgRyWrCqmpqUBYgPK?=
 =?us-ascii?Q?Y+nlRwduFMo+bZyRwq8MmnvnlaIeRSVl1WnZz/aEVfiHRH1bxGvvfzGxeLbZ?=
 =?us-ascii?Q?OPCCWeaA/dY4MhZRucVcx1Nx4DM+5CWbu0O/mLwPWSc8IrZu2h9B1X8iyMw2?=
 =?us-ascii?Q?EAykF4Jx4f8DRsOAsxBQ4es+OU23yf87cdPP6qkiDDoTAE64s4JWAIP0AX3b?=
 =?us-ascii?Q?cWCopULY?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a795c403-98d3-41cd-f563-08d8913145f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 11:00:08.5084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fJEykoBO519AbtSfy0VssepKGyRWJru/lzc1CerW5odIwgY8DyL/mo+6EW2RJu2MYU5MmIeX5K5oFd9b6v16Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6505
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/25 18:26, Geert Uytterhoeven wrote:=0A=
> Hi Damien,=0A=
> =0A=
> On Wed, Nov 25, 2020 at 10:02 AM Damien Le Moal <Damien.LeMoal@wdc.com> w=
rote:=0A=
>> On 2020/11/25 17:51, Geert Uytterhoeven wrote:=0A=
>>> On Wed, Nov 25, 2020 at 7:14 AM Damien Le Moal <Damien.LeMoal@wdc.com> =
wrote:=0A=
>>>> On 2020/11/25 3:57, Geert Uytterhoeven wrote:=0A=
>>>>> There is no need to enable Virtual Terminal support in the Canaan=0A=
>>>>> Kendryte K210 defconfigs, as no terminal devices are supported and=0A=
>>>>> enabled.  Hence disable CONFIG_VT, and remove the no longer needed=0A=
>>>>> override for CONFIG_VGA_CONSOLE.=0A=
>>>>>=0A=
>>>>> This reduces kernel size by ca. 65 KiB.=0A=
>>>>=0A=
>>>> Indeed, nice saving. Just tested, and all is good.=0A=
>>>=0A=
>>> I used my old script[1] to check the impact of disabling config options=
.=0A=
> =0A=
>>> I haven't done enough riscv kernel development yet to assess if I need=
=0A=
>>> CONFIG_FRAME_POINTER or not.=0A=
>>=0A=
>> Disabling it significantly reduced code size for me. Since the series is=
 more=0A=
>> stable now, it is not really needed, so I disabled it in the defconfig.=
=0A=
>>=0A=
>> I was just fiddling with CONFIG_UNIX98_PTYS. Disabling it is OK with the=
 simple=0A=
>> busybox userspace (no telnet/xterm like app running). But it saves only =
about=0A=
>> 1KB with my toolchain (gcc 9.3). So I left that one enabled. I am surpri=
sed that=0A=
>> you see 16K size impact... How big is your image ?=0A=
>>=0A=
>> For me, it is 1.768 MB right now for the sdcard defconfig, with CONFIG_V=
T=0A=
>> disabled and ext2 enabled.=0A=
> =0A=
> It might depend on how you measure.  "size" says 15 KiB impact for UNIX98=
=0A=
> ptys, while bloat-o-meter reported less than 7 (my script uses "size").=
=0A=
=0A=
I look at the size of the arch/riscv/boot/loader.bin file since that is wha=
t=0A=
gets loaded in RAM and booted. It is significantly smaller than vmlinux fil=
e=0A=
size. E.g. for the sd card defconfig, I have:=0A=
=0A=
vmlinux: 2369920 B=0A=
loader.bin: 1751250 B=0A=
=0A=
> I'm at 1.88 MiB, with ext4 and without frame pointers.=0A=
> I also got rid of the EFI partition support, and a few I/O schedulers:=0A=
> =0A=
> +CONFIG_PARTITION_ADVANCED=3Dy=0A=
> +# CONFIG_EFI_PARTITION is not set=0A=
> +# CONFIG_MQ_IOSCHED_DEADLINE is not set=0A=
> +# CONFIG_MQ_IOSCHED_KYBER is not set=0A=
=0A=
I have all of these disabled. The schedulers are forced disabled in the sdc=
ard=0A=
defconfig.=0A=
=0A=
I also noticed that it hugely depend on the compiler. Using the buildroot=
=0A=
generated rv64 gcc 10, the kernel image goes up to almost 2 MB. So for the=
=0A=
kernel, I keep using the bootlin precompiled gcc 9.3:=0A=
=0A=
https://toolchains.bootlin.com/=0A=
=0A=
Just noticed that they now have a 10.2 version available. Will try it out.=
=0A=
=0A=
> =0A=
> Gr{oetje,eeting}s,=0A=
> =0A=
>                         Geert=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
