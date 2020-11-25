Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7912C3EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgKYLEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:04:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55139 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgKYLEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606302243; x=1637838243;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=W82LwDquxfH8iB/lXVAGqyVlLx9MIoyJKrVAzJXi/rY=;
  b=aT9kC09bflUKjtgYRpyLqOw4JfguqsNT7kYQ0y8g3jfDho1HhmTGaxXx
   +6T6Tjg6wm56DTfnmprE+16k//bge/j826aWcYAE4s7tevezWObRxwDcX
   K8HxKBKLqnCUPT6gHqhBnysBb0MCxQo3CB8pUK45vhpJ/hhbF9Nsihzzr
   uBJ+XaNu4BuhvjvvBjJKd5NYyk83VIGD8K+aDQaKsssTsTutiFlkvvU1r
   FAR9Ev6zvqemSkndKFcSKbyLwbHHaeesNtuO5dUGeXNmc2cmp3J8kmrfn
   RJl9rx2SLvBKOi3fgos+D/NHn5+MzDz+J1BBDGF0NvKrffvCoCWcjKesR
   A==;
IronPort-SDR: B2kJH400YpOw5OM0aaU5+NtyhT8uUqFjs4HYIK/MNO4FdmAbgnpdN7Xxn9xRMVf8B05SXclOWJ
 y8NNgMoYpqGTCtm96mGWnfHDlXQDgf0VnZY3rLSwgAXX9Cw6f0qfXpCQIxuJac900ZM1Ecg+Tm
 g1AvdxKxYqrUAq3c2eSAzLorHWoXtosN4VX4BnPdHwEkg5dR/+A+GSeHxv6wNQiZo/eLGGn0zl
 Ut8R5ZxcJgoL+HYWQyA3om4GvpN20UOhp1WGCf716V7h/ab4L+RR/S6ECjQsDLQWifsANsM0w2
 C5I=
X-IronPort-AV: E=Sophos;i="5.78,368,1599494400"; 
   d="scan'208";a="153377713"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 19:04:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cORGYl0wFOtCnndiy9Ob4cCHPgVUtbDASqoes779nj/Xgavxbbhj7liWI+4AbDLIQbqtE0gy0Rm1bQ1W1Jp/lwiUgOj2EyBgKxxF9eMjqP3HfoPN90PDnFep/a/4/OUYXReTlA6igrHEle9GvulWYMRV02qQAIFSGCIqcR2O1c1/jFcwkL+lJXGo4AmFMVLsB7VVnPXvG7/Tl7DBVB0ZYThM0Vm+bAuGjg2mxeqCBp6OdhTVt8+Pm9nLVcRd0RwA4GrTlGFHfE9SU/lFq+YGUORz2Ymn7eb4mJWk+IV4Kj7Fl24MooYA0edxX6WWIqhcmejlg8roEQGzWNt1As6Gcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is4ObZmaghzYf1QcIxdJjQVJ/cdAfMa4mXpF300q2gg=;
 b=Xh3oYsKBjUSpto0QdgQa3p+sp/faEBQ1zUdG4M26WYz2YWN4zso4G5ruBYcHqT1YUK00+U4BY1TpmPhaobzb9B/EkYCJRyD+XPh6tenBdcLY0IQLq95sd4naEcJFdyLFdzUAnOF7AKZZ6BqFXDm1+sgGzY4qx5ddn31DfI0jDeiI+OtuclahPAkX9CU9Kkstdutq6hoKmRRXKtIQnSaIev294pNxnFNEQHN6EjkhSWY44isu+ScwZ6bnePNtl0beI/VcZj1/7gU4mRTuDI/km3XXNRdq/bGe8MD+s4riCTt9X88c5yG9q9z/RiO1TGPTMczuBipIiu2ti3F9XtsKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Is4ObZmaghzYf1QcIxdJjQVJ/cdAfMa4mXpF300q2gg=;
 b=fmbnxcLuL0QQt+EqIhB2TfGgeKpUxCRYu+iAS8fPwI+/8wZIngCujdDWeFekOhK28G858SRQNbA2pcvVeNIiKkd6D3TTnpn3zH3IYbN/zAtM0aEzw0xUOd6XZJbNRGvXT69faKobpyLn9fyUlS+BWKfvPofur7MZEVm64VvOuVY=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6855.namprd04.prod.outlook.com (2603:10b6:610:a2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Wed, 25 Nov
 2020 11:04:01 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 11:04:01 +0000
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
Date:   Wed, 25 Nov 2020 11:04:01 +0000
Message-ID: <CH2PR04MB65224683CD7E6C63D60D05BFE7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201124185738.3541314-1-geert@linux-m68k.org>
 <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CAMuHMdW9dySq3y_Uixv8_7e+Pe2VKw4iGV36mx-DbX6-yzk-Gw@mail.gmail.com>
 <CH2PR04MB652268FD0FB44AA5DF36ACFBE7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CAMuHMdXEzo4EOw_=MgskNXPrbkP4Ui+dHKZ5iyJ04h453BUAhQ@mail.gmail.com>
 <CH2PR04MB6522E6443C6E12CD28FD1A30E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bedcff4-abca-49da-961e-08d89131d097
x-ms-traffictypediagnostic: CH2PR04MB6855:
x-microsoft-antispam-prvs: <CH2PR04MB6855227F077FEBCC12EBEC6EE7FA0@CH2PR04MB6855.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 672VHF+LZXwE68mjf1MzPizJa+4p2kbWzJhJfC3jgrZ2jikcWKqOoPnMv2se09g+KAsIYcsxxyhuaVuolywJMcLntEd6q+jBQKZUVicCS+kn7xevxeIrW7SZw2pUaUN/vqChK0AcQXvlhqy5oCbyMOy8USF6zIEdqs6WuTa/GoTeNntNOyKPsHqalXKCQ/Ss+fy0UUFEmAZtNvhvXxqRphbnSgSyA9GF+Wy1T8qTTGQyZgXTMNEaH00h9g4xAXc3JNFCp2IrpQpRgPec//oGW4Gvo5VI/5gq0ZbO5aNhzfJVQvW74XJm11yBLCxVm7jMIZ4naMcEkYxCIdBLFrxdJR82ONFPhZsU8YRQTl+SEh00nVjwkbbiVScFP/EWFgixBt84mM9cTUCF1m5d1hgoWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(6916009)(9686003)(66946007)(76116006)(64756008)(478600001)(66446008)(53546011)(966005)(66476007)(316002)(91956017)(71200400001)(5660300002)(66556008)(54906003)(4326008)(52536014)(83380400001)(8676002)(2906002)(8936002)(186003)(6506007)(55016002)(33656002)(7696005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DrnTPnqWUy7LgeoqgX9l80MP8JimP2VVqvUYU02sgQWROqu765DCxCZcHYVk?=
 =?us-ascii?Q?fVqLY2mjO7rvrYPYM5SHHUCmCLSay1nQMZM20Gybml3cUmSreN+VEzZj/822?=
 =?us-ascii?Q?1vhGghLqJjs+9jHku6bedBRM6f+O2Sph4hB3TQHY0NEDs0xE8515or8XC6zo?=
 =?us-ascii?Q?h8p4nh3ciYGnq2CwTrP0g/8YqYtgJaxuYZv04kdLKogyPHqYThsDf8PA8zhs?=
 =?us-ascii?Q?HruzvBQUAqqnCCRoRnfbvLyYg46EGS/bXRYDLsgIRs/o5NzbNCPxutX7L5mN?=
 =?us-ascii?Q?8VXmvj9sn1Ti983PVLEZ/ntYQ0wpffhse0ax17pf1BawRxqA+RBR8u/d5qo3?=
 =?us-ascii?Q?paCg80TNpZDF4k0zWnbE5ZQgA7Q/AKp9XlffJM0m1UwHbi9/ywrt0Y1Mh2n5?=
 =?us-ascii?Q?4AlUXxe1tl3qNbdg+x/wUlxOELndNtdzCR/DGxDjkD1SBI6yA6LbC0GVBh63?=
 =?us-ascii?Q?5EiyFAPYjN3EQ+m1ZbOCPtx5otlwTeCVBSdc28juFXPppFfsAq+XoOVkBMW8?=
 =?us-ascii?Q?p35uUiJZO0d5CKN5hJP76RKINfulSQ5Ntq0rMmbZLXRuyM85lwVJf2L7SePO?=
 =?us-ascii?Q?3IarAY79clmPFK26m+uOXIw8YOGF5f0Lhyw1yijVadlFCoEFrogQSQ2yvQ10?=
 =?us-ascii?Q?YZso6A8eGFvWqL/8HDqTjBTxpssqY3UMonkI7EVwbJkka5cHZYKzcrAX1SFR?=
 =?us-ascii?Q?ykOQH9tx7YFsyoNjJT0/lxO6JxIjnnHFgl347CwJiD0BHr/49BicCnTp5R9P?=
 =?us-ascii?Q?fAo1ln2Qw5n7HYyT0IyDsHbSfDJsWCcGpJOBIu2xutiNPAPFtqmr87gtHDhh?=
 =?us-ascii?Q?c8H5jToGucyVcPjiKY/yZ+g1I/4S4+KiSX3eTlMGbCgLnmCsZfGDrreNS+KF?=
 =?us-ascii?Q?26Z29imn9zugR/B1BPEgaxYt8JjecR7pIfi0JOorOJMmkZ/Jdn3EkX0IUORq?=
 =?us-ascii?Q?52TT+ocGCIblnVjFlWN4ZDcuqhzKMo22CixdL4eH8UDXQ1hfOrsBcxQRTJmz?=
 =?us-ascii?Q?q01Hd+4xDut8jFXcrBbOHCClkb2frh2znQh6k+BiYCzRYkurqAfinf8t15xK?=
 =?us-ascii?Q?UXxxujpp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bedcff4-abca-49da-961e-08d89131d097
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 11:04:01.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FQotpbhK7wCP5Di27EoSeO13EJnVKfkeXuLEpYWEuVU+5J7FQIJbiNBYtQ3IHLqvUIMl2gjsR8KE3iVMdD2MOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6855
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/25 20:00, Damien Le Moal wrote:=0A=
> On 2020/11/25 18:26, Geert Uytterhoeven wrote:=0A=
>> Hi Damien,=0A=
>>=0A=
>> On Wed, Nov 25, 2020 at 10:02 AM Damien Le Moal <Damien.LeMoal@wdc.com> =
wrote:=0A=
>>> On 2020/11/25 17:51, Geert Uytterhoeven wrote:=0A=
>>>> On Wed, Nov 25, 2020 at 7:14 AM Damien Le Moal <Damien.LeMoal@wdc.com>=
 wrote:=0A=
>>>>> On 2020/11/25 3:57, Geert Uytterhoeven wrote:=0A=
>>>>>> There is no need to enable Virtual Terminal support in the Canaan=0A=
>>>>>> Kendryte K210 defconfigs, as no terminal devices are supported and=
=0A=
>>>>>> enabled.  Hence disable CONFIG_VT, and remove the no longer needed=
=0A=
>>>>>> override for CONFIG_VGA_CONSOLE.=0A=
>>>>>>=0A=
>>>>>> This reduces kernel size by ca. 65 KiB.=0A=
>>>>>=0A=
>>>>> Indeed, nice saving. Just tested, and all is good.=0A=
>>>>=0A=
>>>> I used my old script[1] to check the impact of disabling config option=
s.=0A=
>>=0A=
>>>> I haven't done enough riscv kernel development yet to assess if I need=
=0A=
>>>> CONFIG_FRAME_POINTER or not.=0A=
>>>=0A=
>>> Disabling it significantly reduced code size for me. Since the series i=
s more=0A=
>>> stable now, it is not really needed, so I disabled it in the defconfig.=
=0A=
>>>=0A=
>>> I was just fiddling with CONFIG_UNIX98_PTYS. Disabling it is OK with th=
e simple=0A=
>>> busybox userspace (no telnet/xterm like app running). But it saves only=
 about=0A=
>>> 1KB with my toolchain (gcc 9.3). So I left that one enabled. I am surpr=
ised that=0A=
>>> you see 16K size impact... How big is your image ?=0A=
>>>=0A=
>>> For me, it is 1.768 MB right now for the sdcard defconfig, with CONFIG_=
VT=0A=
>>> disabled and ext2 enabled.=0A=
>>=0A=
>> It might depend on how you measure.  "size" says 15 KiB impact for UNIX9=
8=0A=
>> ptys, while bloat-o-meter reported less than 7 (my script uses "size").=
=0A=
> =0A=
> I look at the size of the arch/riscv/boot/loader.bin file since that is w=
hat=0A=
> gets loaded in RAM and booted. It is significantly smaller than vmlinux f=
ile=0A=
> size. E.g. for the sd card defconfig, I have:=0A=
> =0A=
> vmlinux: 2369920 B=0A=
> loader.bin: 1751250 B=0A=
> =0A=
>> I'm at 1.88 MiB, with ext4 and without frame pointers.=0A=
>> I also got rid of the EFI partition support, and a few I/O schedulers:=
=0A=
>>=0A=
>> +CONFIG_PARTITION_ADVANCED=3Dy=0A=
>> +# CONFIG_EFI_PARTITION is not set=0A=
>> +# CONFIG_MQ_IOSCHED_DEADLINE is not set=0A=
>> +# CONFIG_MQ_IOSCHED_KYBER is not set=0A=
> =0A=
> I have all of these disabled. The schedulers are forced disabled in the s=
dcard=0A=
> defconfig.=0A=
> =0A=
> I also noticed that it hugely depend on the compiler. Using the buildroot=
=0A=
> generated rv64 gcc 10, the kernel image goes up to almost 2 MB. So for th=
e=0A=
> kernel, I keep using the bootlin precompiled gcc 9.3:=0A=
> =0A=
> https://toolchains.bootlin.com/=0A=
> =0A=
> Just noticed that they now have a 10.2 version available. Will try it out=
.=0A=
=0A=
Correction: my PATH was actually pointing to the Fedora riscv64 gcc from th=
e=0A=
distro rpm package which is version 10.2, not 9.3.=0A=
=0A=
> =0A=
>>=0A=
>> Gr{oetje,eeting}s,=0A=
>>=0A=
>>                         Geert=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
