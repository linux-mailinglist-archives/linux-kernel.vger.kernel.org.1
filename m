Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9252B3CD4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgKPGMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:12:03 -0500
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121]:40777 "EHLO
        esa11.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgKPGMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:12:02 -0500
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 01:11:59 EST
IronPort-SDR: OOzNOU/h7lhSFGyv97/yc8uabVZmFj2FaxuZT4notx268lTZDgG5KHbEclx6P1CRyxX728BEeF
 nQjSp5jEMwgyCHhIKDVkU/3Hz7l8zzgBCrsC9kVTLc/odjupK1FDPIZv9LNvBpo50WwQx/v3GN
 Y2HE5aM+w1astBc+29+2Z3N0aN+8PDmTHuCTasX3ach1nsx48S4u81RSjE1kvIok+sSsDI6H4j
 hLsPNl9CPMOyfpVqNzndNtqp//eE26HZ7k2ZBMO8i6pSoio+kSTpeZqA5A7x/BFb9GJ9yV68qm
 0tk=
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="21395593"
X-IronPort-AV: E=Sophos;i="5.77,481,1596466800"; 
   d="scan'208";a="21395593"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 15:04:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htDfeL7VAaQtJzgJdv11bfeSR6GKSeCurHGSLHrLI6VrOut/s8ECb5wEZsa8JzMvz1phnWGPdMGsiCcKBNEceXr2HkRA6FkWk2OFOQBssgNiXOi6OScxBsxkJn/giKoDzZzFzNaIOQVk0NXHhLKgQ/c/6HtAP5Piwk95pX5nScK+ZtrS0nL1fiLsMb5v4iJAllOvVv8XrqXQyBPAnygy1U3/BEODo4tLMLlHzBVedU4vNIkpmyPYFbGaopiRq/LcWO0FuM9sDyoQcT0fZ8SsJX1rboq7zCse8rVtxAPAcUFtM8HAlwBIMEoUTEKWkyMEV7kaH9Ez0tZhT2g+v5dkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jROBMjERtcn7uUgPnM19V876Ro2GRMIWOqw9dIJkcsc=;
 b=ZfJITVOFz/lK3HMn2r7clD5JhtR/qP+eE9KSjx8F4xdgARk9O77xmmFmGAw+qI/wnWxmAHam0cTA4Dwn26I6vLNj1h8by1IKdtMxyQK9qGG+Bbuts+1S7rjUhh0EW7AtksuVP6BLadh8i23OKkYPnSZePpIVKsEMZLRmL/1KcB5tv91NpxlEBYPDOgsEnAZdxb7Eu7FqzrRX+y8ohzYqqZc3tzC+kkswrkCLYDKxnym29h9xUBf+68lu7h4X9co09mXOpbw+zdmanXgczQsd2fshdXiz7lLwWmc57TiBy5q+O/nxIWC1yJmXmHCUr/W3UdxdVuEaT+VZtMsQk82FaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jROBMjERtcn7uUgPnM19V876Ro2GRMIWOqw9dIJkcsc=;
 b=q/TKlJi++uBdPnfonr/y27vUHAEK8gPgVCKzTABDP/mBA9JTIwMg3Tpa7f7QEmVdy6RZ71ZLgRsnMBaZs+tzqrv03PsPcqkT4CRmCozc6aOoKgScE4C0jPETK7jRnsuDUzpkl94gwJrYVF9a4zaJbwXUROre4xXx3aCxnud9Jvc=
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com (2603:1096:604:58::11)
 by OSBPR01MB2102.jpnprd01.prod.outlook.com (2603:1096:603:22::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 06:04:47 +0000
Received: from OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::d122:64be:9d6c:c04b]) by OSAPR01MB4227.jpnprd01.prod.outlook.com
 ([fe80::d122:64be:9d6c:c04b%6]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 06:04:47 +0000
From:   "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>
To:     "ito-yuichi@fujitsu.com" <ito-yuichi@fujitsu.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] Enable support IPI_CPU_CRASH_STOP to be pseudo-NMI
Thread-Topic: [PATCH v2 0/3] Enable support IPI_CPU_CRASH_STOP to be
 pseudo-NMI
Thread-Index: AQHWsoIIRWU6HVRtVU65gwbayxBrc6nKVdeg
Date:   Mon, 16 Nov 2020 06:04:47 +0000
Message-ID: <OSAPR01MB4227E8E24A0B282889D21A0D8FE30@OSAPR01MB4227.jpnprd01.prod.outlook.com>
References: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
In-Reply-To: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fujitsu.com; dkim=none (message not signed)
 header.d=none;fujitsu.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e95d8af-4a04-4f43-d9f7-08d889f585b7
x-ms-traffictypediagnostic: OSBPR01MB2102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2102D722633475C7CC9A91DF8FE30@OSBPR01MB2102.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KhUv52hxQQI4vQQGyazW8D51jbPAwFRhKKvSDyR5OktyHw2QRacJo5qVTnA72lb4fjIHox0Rn9nrbV4W3dbDuM97ZZDnc6EnZ03IAQJUtHXh4tFVEE9mlirzzicUwJRptKbvLf+J6JecDKKT+aR6RDkWJOXqGMF3+7SnnTAvcoxot+xWwSQstpiAoK/sSGUs0oO4xDBAaTSxUF2cU+m33oIuvRlHIPZwVt7qHJ0QrJmFCIdsY5Uy6nUxQ1xT/35qPCvgaCV14+UC1k9prBQQylT4TnEVbZxgSP9z/ZEvq0T5SmEGBVGwxAgMJ37M3Rs+zh09/gqMJwCWHWKQggankNqjb9G/a0mspUVFrYW6vglCIIilu6tENgEONt/zbcOWZN7wMkVimiPy1KmseVuu4tbjK/m+3ediagKWjBU/WpRuKyApOpq6gk8ahTwzyXc1MFSRMZVx3rd563kRyxDMQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4227.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(478600001)(76116006)(55016002)(4326008)(66946007)(66556008)(64756008)(66446008)(66476007)(85182001)(186003)(6506007)(5660300002)(83380400001)(2906002)(8676002)(71200400001)(26005)(54906003)(53546011)(86362001)(110136005)(966005)(316002)(8936002)(7696005)(52536014)(9686003)(33656002)(777600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TVLBq+0nOTLMWjvXHi1Uh42f+brU7Zmz4sGlAoajEwjJKHwk9P68QLnzh5/4kKaKLviW/PrRRKB2tnLnk3GdTH9aPB31NdAmbfBFx2KS9hECosf0+MTbtL08XT4XSq8/21npNKZxdtbt6ieB6XZZmlWaLHR43scJw9LQSkcRCrC9xesniR+XsmfcsMDIVB9nFlxIG9BNL+HRI2G5EDZDeyhtxdCLpWCrk+tAelCxGl0ZsXhkpsBQOVOyYy09c0ct1YRxtmpg5ljWTcNt6AnkFguUvE36aThrsHgqdVFsjliUIopZTN704gyFj7TnRXPtZMNvspQwNRClVuRl3n0EJ0TofJP5SpbOsKxa2+0lZybdjyHhgmgBXwwiC7KyOZQ5R0cnlNqdjy9N1VH3R8ttNmXT+QmEkNzAyKlR56M1IJ3uXOeejz8/fcOLm7YBQjHCTPd8mnzTeSFhWIQ1/YwVH/wsoxu9WrCrCx2Z3iRjhsG7gkA7m95YDfhaIeQbgRvOdztqnkInYf63cRAx6KlKtcm+T59p+NMh6Yuh8nTw+1t/v83y8RN6+268zwOIKDaaXeJfolHj1pzvs2i8Q3xU5fz65vWbBxQEryS/FVgAkXIw06wUFlhGAyrxt1naavZil09aB/tnMbzVNvCYfjxyV3hGWeXvK7930xFefexW//Yzk1lzV7IYMJwbTfS+7KsdyafiIWzG2rftzox5w09/RCz+gnu8jhRGf/5OCX1MfMHc/omu3W5ZfC9IJsxJvNKN+VSPgNhpFEG34VUdZW8kz1IeSX3/vssKM+taEhhIH+Ca7HVDwjSKqWUGHUUJrUn/TlnwduRNI4BqApZDvH/AIkj0/gEEvzVk1XId2pF97Bz8BIVTE4LVTlUWfr9fPGWy9R2oogUOD8qKGTMpEU5B8Q==
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4227.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e95d8af-4a04-4f43-d9f7-08d889f585b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 06:04:47.5736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fCzLM/a6uianSbcHg3PnglQmtLd2XRmTHkHk0PpisPmnHVjjleWyjVUJXNm0AfmMr3OHSLGVEy5T8AgeGAqePaHi0keHxgubrD28WujJ4D4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Sumit

What should I do to merge this patch.
I would appreciate if you have any advice.

I have not tested it with ThunderX2 yet.

Best regards,

Yuichi Ito

> -----Original Message-----
> From: Yuichi Ito <ito-yuichi@fujitsu.com>
> Sent: Wednesday, November 4, 2020 5:06 PM
> To: maz@kernel.org; sumit.garg@linaro.org; tglx@linutronix.de;
> jason@lakedaemon.net; catalin.marinas@arm.com; will@kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; I=
to,
> Yuichi/=1B$B0KF#=1B(B =1B$BM-0l=1B(B <ito-yuichi@fujitsu.com>
> Subject: [PATCH v2 0/3] Enable support IPI_CPU_CRASH_STOP to be
> pseudo-NMI
>=20
> This patchset enables IPI_CPU_CRASH_STOP IPI to be pseudo-NMI.
> This allows kdump to collect system information even when the CPU is in a
> HARDLOCKUP state.
>=20
> Only IPI_CPU_CRASH_STOP uses NMI and the other IPIs remain normal
> IRQs.
>=20
> The patch has been tested on FX1000.
>=20
> It also uses some of Sumit's IPI patch set for NMI.[1]
>=20
> [1]
> https://lore.kernel.org/lkml/1603983387-8738-3-git-send-email-sumit.garg@=
l
> inaro.org/
>=20
> $ echo 1 > /proc/sys/kernel/panic_on_rcu_stal
> $ echo HARDLOCKUP > /sys/kernel/debug/provoke-crash/DIRECT
>    : kernel panics and crash kernel boot
>    : makedumpfile saves the system state at HARDLOCKUP in vmcore.
>=20
> crash utility:
>  #7 [fffffe00290afd30] lkdtm_HARDLOCKUP at fffffe0010857ee8
>  #8 [fffffe00290afd40] direct_entry at fffffe0010857c94
>  #9 [fffffe00290afd90] full_proxy_write at fffffe001055dea0
> #10 [fffffe00290afdd0] vfs_write at fffffe001047533c
> #11 [fffffe00290afe10] ksys_write at fffffe001047563c
> #12 [fffffe00290afe60] __arm64_sys_write at fffffe00104756e8
> #13 [fffffe00290afe70] do_el0_svc at fffffe00101590cc
> #14 [fffffe00290afea0] el0_svc at fffffe0010147a30
> #15 [fffffe00290afeb0] el0_sync_handler at fffffe001014835c
> #16 [fffffe00290afff0] el0_sync at fffffe0010142c14
>=20
> Changes in v1:
> - Rebased to head of upstream master.
> - Rebased to Sumit's latest IPIs patch-set [1].
>=20
> [1]
> https://lore.kernel.org/lkml/1603983387-8738-3-git-send-email-sumit.garg@=
l
> inaro.org/
>=20
> - Add conditional branch of local_irq_disable().
>=20
> Sumit Garg (1):
>   irqchip/gic-v3: Enable support for SGIs to act as NMIs
>=20
> Yuichi Ito (2):
>   arch64: smp: Register IPI_CPU_CRASH_STOP IPI as pseudo-NMI
>   arch64: smp: Disable priority masking when received NMI on PSR.I sectio=
n
>=20
>  arch/arm64/kernel/smp.c      | 44
> +++++++++++++++++++++++++++++++++++---------
>  drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
>  2 files changed, 56 insertions(+), 17 deletions(-)
>=20
> --
> 1.8.3.1

