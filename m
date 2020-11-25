Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7EE2C3901
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgKYGOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:14:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13160 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYGOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606285373; x=1637821373;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lEBuSKDz7A9I1573NJOWsVt5AfQ7DjKT9kZYIvRRgMY=;
  b=YqG/8grl6Q57T1VWoLxqnvtkJwv0SrtJnU2hC2XJEP8OV1be8sHeDSqp
   Y6n6yjYKlHF0Lzp1sm5Jfc5EcqyANhDbgD3J+gfJivIOHOsy31XKflv50
   gNbpxIMZf9yMqxVgBVMw6d3MdER2FrsFI+vHrEcKpz9GcVEbndIyqs+6D
   VXzO23KW1wU8e8uHlljeHUvpNYmmsuiKzHUiwjqnmJV97QMH85BfZpGGV
   meG5OlM8uzfKeOSb/ygHLnGvdA8vxNVVT6Pwl1/nhp8jiZ5vSMOyrwiVw
   b+qM79S485U/cMYoqXELSDOoTbgArUSmeZ4u/dl+e84TEER3r2iMfhgUY
   Q==;
IronPort-SDR: Gcx+TvSy0NXU+geL0ybbGY9dqa6N8jky5Ezc+0CyfeHuwxWW9auFQdTgjHbExi8+5hPtZvP7qN
 57YDpISE6hQT+lIPCsoZcXYzNpZKdUDj9JyE9wU6bjCgK+cvgpMhuGctLCPSDH6t1fO9wS9eqO
 QRFduv+afHa+lYUdq4Ai7DHirL7EpiPHm/UCdPCbyjywSj64QDHpoa/ns1ThFuJZnLbWxYkrSL
 lixtT26fQ3ikJ8+110/82770ayE15Z16/MAQsxeBivQd3Z87jK6Jg/8tZ+MoFTFyB4kM7SVSVG
 9/k=
X-IronPort-AV: E=Sophos;i="5.78,368,1599494400"; 
   d="scan'208";a="257062168"
Received: from mail-dm6nam11lp2171.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.171])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 14:22:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOvLQbboz4p3Vr9jHOD7ao1l9LBrIrRtTW8Mo264nh4b2E3qG5QDbY4ubqiuNLAHPFwSi/59bN2YTONL8LEFqyIMXI6XdMAfWumaRK4oeq9xiq9ilymEE4nELDc+BruOz5le3jugw4IbFc7Pilfrdk98tGTQsgI6loAnpkLgpV821Sarhpz0r3E0SR2uyHoSeIXX+mTt/uROweNFCVKgg/YXfxlRHz0WVAv3k+UPaqSBWEalPrt2HtrJYXZroC1UqEdEpBfdzExZJfocNcTOb2aU2k7OVxMKWQYb9vtXWSD2iv7WamRjPm/pTY7xUZLqK0N7tYEF6kDNfE6bK9froQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUy+IuRwKwEINnPViVgyD8SJ7lOCv5zw013XMzPCDPU=;
 b=lbg6OJr4h2zQp8K4vdagAJ+ndc0koYZpAnvCJoZDHtin/vV8B99V+GjH54NSVQ3He32VbYVZKRSNrb9ujurPvlaWQatYlu1inBSeunDjofClKXz3cpJVKDiHoOPaiR6WTbM8M228X2Mzi4dNWfBIpbuSj21KBUSTujqHfOaYk0f85KMsSzxV9ygS02uJtQp8Kw2uh9hIkHVSoGZ3rsWX8WOU2D5VfY6BkfMTQSEV03swOAZsUJFAnFPkbRz+pH35DHISxZGDrAofX3q85jN3psAsV7tRYSuy+K7MNFO3nvWCpWSeufQ8inok0ErhwTTyVgWKQx9vVVfZ3cuZfzRwPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUy+IuRwKwEINnPViVgyD8SJ7lOCv5zw013XMzPCDPU=;
 b=icAPg7WQDFdQnqQOMzqSInGhKOH9GnmoU+7mg/hx2uGpvbMUYKS7JCNLQjgMBRzkc3n0skCqDhz9MHDXbo8UI/W2CHh8GUIxWTRodXU3x0MSbxZSu399eyRewYpoJ7YZ+pMsx8b5J37ru/sTCCQYKRUu4FCwStr3hcPFIheftl0=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6538.namprd04.prod.outlook.com (2603:10b6:610:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Wed, 25 Nov
 2020 06:14:38 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 06:14:38 +0000
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
Date:   Wed, 25 Nov 2020 06:14:37 +0000
Message-ID: <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201124185738.3541314-1-geert@linux-m68k.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0c68056-809c-438e-eca2-08d891096362
x-ms-traffictypediagnostic: CH2PR04MB6538:
x-microsoft-antispam-prvs: <CH2PR04MB653843957CF7A4BFA4280BD8E7FA0@CH2PR04MB6538.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4x4bgqKvGW6v530qpF2GQ07J3smFFhF/LjLwNBS5zCFgxOrFGGRUZrDrB5dYNNsff0kFlknFpwGZ0XWsdWpE8ci2zDsQEbQh0uPcMnt10s08DS+Pn3mp6AjRSkpLrWXxdZn26tadbz77uod6p5wXeAkThHdtves0kpXXZTdRf11vb58oOxbY6YSdCkXsicG7/ZPf0qVJhnCjxgOAkl+a+dYYLhG15U4DKDflI1Lidp9IBgACOC4WG0izb+j55AcR+xG/3yuyBy2+hgQEGYXZKDWnpEdXXAMFATbpgfaMLNedPo9fyd3WLFloJUlc+7y8bcbqNDmWmOJb0SNss7LYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(478600001)(83380400001)(71200400001)(7696005)(91956017)(66476007)(53546011)(6506007)(76116006)(66946007)(52536014)(54906003)(4326008)(64756008)(5660300002)(66446008)(186003)(9686003)(6916009)(66556008)(86362001)(8936002)(8676002)(33656002)(316002)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8YqnsJviO1yxQ8LJePpJ7pYxHegvwm8qO/IlHsAujIGW0bzzUHGF/RIJWTo2?=
 =?us-ascii?Q?Lvu0LVBmunWttEv7VmsumPjVGgM9pPSz2sTWl0MKziZPZNgcX0cwPsVNt5B2?=
 =?us-ascii?Q?MP/J0ikLN44jNlrTqNxgmjfrg3KNgc4WJQYupEG153csXE1ZMZeA5q5odfuO?=
 =?us-ascii?Q?M6XtEMPuuNuNLfK1lgXLnJr05h5cGrAeJ0OaFS3Q+BzYTibqlgxmzfpncDoy?=
 =?us-ascii?Q?CBxWtKs2O4s0bm3UINpy7+/I+kyYfQzyBMNBvyBV0RRULVO10/85VZHhK96G?=
 =?us-ascii?Q?uogeZxowD6eXLKO74fs1792Lj5sVeDGa6eoCwV+BhGms6/U6j4t/teXENWhc?=
 =?us-ascii?Q?EtZFePB2nB3LstFTzZXBbjbSDzX+5FD5VEQD1qZcc4h+a/B1lOJjmmedkztX?=
 =?us-ascii?Q?w+NizvTeckAvWEdyAuzInznWQqWrRVMJU46x+Ynst0nWH9aHH7EX3f/8d810?=
 =?us-ascii?Q?/KBLLjuNcpBiUFTCpgaBV1MsgUQbpwU+CtQV9sZ/AhqzMFVZpPenkTbxHPiV?=
 =?us-ascii?Q?C4EEU8s8+SFkWtvX7YEMiA4sqAYV2ZJe/XOB7NgCg/boWC3F1xCA9Y5plROp?=
 =?us-ascii?Q?97BOh/ftgd9tQPXgI6vFI6CZFqRExGLxDDWlgNexG57FEhP5hE39C1t59ljZ?=
 =?us-ascii?Q?Gxc0FmBBz9Loj2iB9rRQJd/OHHCLvm/FKY3TBQH8R1mzGTaqXQkw71MKyGRK?=
 =?us-ascii?Q?eRAWK2kGDSV8CPjmPVYYCRzJkHLmAtViJo41Sg4hVnHyyBK5ubGaeddG/MXk?=
 =?us-ascii?Q?oepdvt5AifqQ62bsPWJSB85SK324+4fclVq+fmY+l22zQ/T9cnD5QxETOfkQ?=
 =?us-ascii?Q?x8oO74PJ5SiBUSjG/ZqADG0biZSKfmkcVO6YWKtXdJcxQYzwX717nyEKcQxO?=
 =?us-ascii?Q?dCBAYoML8g61JcqfhQ+9zw/AuBFbd2dNV0BxzhnbXTOUf6GvTzmVwDbMm/vY?=
 =?us-ascii?Q?zbFmBj+qtTa33U0pgX48A2HjAYbs8UCPElKUGBLOxZiZzkYRvjhf3DpYEvb2?=
 =?us-ascii?Q?QhAfUqjGUMnKA//b1VheJxfLwGaXCMH2IJfiPvdlnnVp0mVeL4++fPDAXagK?=
 =?us-ascii?Q?Rz7i49Bu?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c68056-809c-438e-eca2-08d891096362
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 06:14:37.9721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0VzY5KycZc0FOzttIzRr777ywO+D7HNsX/rTKdI5eWpyfpu9Tax2JxIuHjEpaaRtkhzflO/ajT+t2tr6E+y0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6538
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/11/25 3:57, Geert Uytterhoeven wrote:=0A=
> There is no need to enable Virtual Terminal support in the Canaan=0A=
> Kendryte K210 defconfigs, as no terminal devices are supported and=0A=
> enabled.  Hence disable CONFIG_VT, and remove the no longer needed=0A=
> override for CONFIG_VGA_CONSOLE.=0A=
> =0A=
> This reduces kernel size by ca. 65 KiB.=0A=
=0A=
Indeed, nice saving. Just tested, and all is good.=0A=
=0A=
Can I squash this patch into the 2 defconfig update patches of the series,=
=0A=
adding your signed-off-by ? Or would you prefer that I keep it as a separat=
e patch ?=0A=
=0A=
> =0A=
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>=0A=
> ---=0A=
> Against k210-sysctl-v15=0A=
> ---=0A=
>  arch/riscv/configs/nommu_k210_defconfig        | 2 +-=0A=
>  arch/riscv/configs/nommu_k210_sdcard_defconfig | 2 +-=0A=
>  2 files changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs=
/nommu_k210_defconfig=0A=
> index df89d53bd125679b..9262223037e43479 100644=0A=
> --- a/arch/riscv/configs/nommu_k210_defconfig=0A=
> +++ b/arch/riscv/configs/nommu_k210_defconfig=0A=
> @@ -48,6 +48,7 @@ CONFIG_DEVTMPFS_MOUNT=3Dy=0A=
>  # CONFIG_INPUT_KEYBOARD is not set=0A=
>  # CONFIG_INPUT_MOUSE is not set=0A=
>  # CONFIG_SERIO is not set=0A=
> +# CONFIG_VT is not set=0A=
>  # CONFIG_LEGACY_PTYS is not set=0A=
>  # CONFIG_LDISC_AUTOLOAD is not set=0A=
>  # CONFIG_HW_RANDOM is not set=0A=
> @@ -67,7 +68,6 @@ CONFIG_GPIO_SIFIVE=3Dy=0A=
>  CONFIG_POWER_RESET=3Dy=0A=
>  CONFIG_POWER_RESET_SYSCON=3Dy=0A=
>  # CONFIG_HWMON is not set=0A=
> -# CONFIG_VGA_CONSOLE is not set=0A=
>  # CONFIG_HID is not set=0A=
>  # CONFIG_USB_SUPPORT is not set=0A=
>  CONFIG_NEW_LEDS=3Dy=0A=
> diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/=
configs/nommu_k210_sdcard_defconfig=0A=
> index 3d2cb4747e7f85b7..4cd1715dd0cf3747 100644=0A=
> --- a/arch/riscv/configs/nommu_k210_sdcard_defconfig=0A=
> +++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig=0A=
> @@ -41,6 +41,7 @@ CONFIG_DEVTMPFS_MOUNT=3Dy=0A=
>  # CONFIG_INPUT_KEYBOARD is not set=0A=
>  # CONFIG_INPUT_MOUSE is not set=0A=
>  # CONFIG_SERIO is not set=0A=
> +# CONFIG_VT is not set=0A=
>  # CONFIG_LEGACY_PTYS is not set=0A=
>  # CONFIG_LDISC_AUTOLOAD is not set=0A=
>  # CONFIG_HW_RANDOM is not set=0A=
> @@ -60,7 +61,6 @@ CONFIG_GPIO_SIFIVE=3Dy=0A=
>  CONFIG_POWER_RESET=3Dy=0A=
>  CONFIG_POWER_RESET_SYSCON=3Dy=0A=
>  # CONFIG_HWMON is not set=0A=
> -# CONFIG_VGA_CONSOLE is not set=0A=
>  # CONFIG_HID is not set=0A=
>  # CONFIG_USB_SUPPORT is not set=0A=
>  CONFIG_MMC=3Dy=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
