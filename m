Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2682CE284
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 00:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgLCXRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 18:17:51 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10757 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgLCXRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 18:17:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fc971f60000>; Thu, 03 Dec 2020 15:17:10 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 3 Dec
 2020 23:17:08 +0000
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 3 Dec 2020 23:17:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ik6KdDn8YW9/0OlJXSB7hN8GKN4w60exY8OCT1Z5u5g5+UNwBnRNQIYOdoFhAF1fm0pOUXt/zIxeTFP8isqhEs6a406GVWbxP+GELHz3AGc5K3r61aqV6Q2+PrDz5ppV0TQa4dfSo5X5cYGxe7Y5kw7Ub4G1OUbqQNSjIBmF8/et6ldkm5vpxWYl3EyKbzS+83Cd0DTf71pCuKvwDf/XuuTiBux9bOFie+tvD1RACdGSXwp844e7VZLkk16NdJTy/3s7lp6e0JzBdKanoNjuFK4nyGQVhyYPOKhpAfdXnfaBRa+qmVqYrP1B0PY76tAB+bfD+KPhAH+bVfB0IY/ceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW9yuT+Q1cdqUVx35EXXs3sUuVIi2ZR7RcGAZCuDT5E=;
 b=Rj5A9AH5fiMXuC75olyx2kxoLyho8y9FmlrnHxrPEnpZo/7+XVoOr0EnctDYlclQ5HjTdp/eJJKnNA0fgJTBOxvAlJVQE3RuPzapetydAu1p7Xpc3ofkT+rj7CSYd150H7qbAnwxVYeazId8MAE9zxXfMo6nSD8BgTR3ozJid5/VRBzfpieF6z4LVRdYmXIkS0xdO2NRCHZ2jJa/wjRe6XEknV2ekh0bsdrjDeBNgqoyvlMkNgeghMWI2HD3nQfH+1ZoLK+SqHMj4yrNHZZh5t6SB25qaXs4zsS9fLLQ82HYhlzgiVaMOET0lPpORwG4ZQsrgmH42Yu9U07A0hFZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3898.namprd12.prod.outlook.com (2603:10b6:5:1c6::18)
 by DM6PR12MB2666.namprd12.prod.outlook.com (2603:10b6:5:4d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Thu, 3 Dec
 2020 23:17:07 +0000
Received: from DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::80c1:3479:15b6:a7a2]) by DM6PR12MB3898.namprd12.prod.outlook.com
 ([fe80::80c1:3479:15b6:a7a2%6]) with mapi id 15.20.3611.031; Thu, 3 Dec 2020
 23:17:07 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Mark Gross" <mgross@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Shych <michaelsh@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] platform/x86: mlx-platform: remove an unused variable
Thread-Topic: [PATCH] platform/x86: mlx-platform: remove an unused variable
Thread-Index: AQHWycQJ+tzIskPouEih6zwvYYhQc6nmAPMg
Date:   Thu, 3 Dec 2020 23:17:07 +0000
Message-ID: <DM6PR12MB38987FFE8C575364D7FE3AF0AFF20@DM6PR12MB3898.namprd12.prod.outlook.com>
References: <20201203223105.1195709-1-arnd@kernel.org>
In-Reply-To: <20201203223105.1195709-1-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [46.117.169.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4dcc74f-6565-4120-98a2-08d897e18da0
x-ms-traffictypediagnostic: DM6PR12MB2666:
x-microsoft-antispam-prvs: <DM6PR12MB266618A43FAF466677B79B0BAFF20@DM6PR12MB2666.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KbA3LK3LIUbGYG2xk7SlOy1Gb7UvI1dkGCFe1hR1wanWwMSp2wHs/eP7nPVbFtBV4UU1sRWqnXv4/4uDOu+h0FhqxTWroAwV+0YMF4/3Ve7Ww5tXh4tz/jSto7KwdAL0/ESE/JmoOmAnO46C6SgZdyCsxi8rVLu/Xt20bVmSAza61n9meJIfFp3TJf872J/DUuC4V4Ta7kz+uGO0/l1tbTpiAdv0DXZiBjgvQtVXPIG6eJRKett4cH9RlVp3jVT8yafec+k0G6AOPX571N7ggru42IepL8HodS+Zxhc708w/Myw7FlM46O61excPaWr9Ib2qPmAr3u4DJtJ8avzjQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3898.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(186003)(9686003)(5660300002)(55016002)(4326008)(52536014)(7416002)(76116006)(86362001)(110136005)(66446008)(66476007)(66556008)(64756008)(66946007)(316002)(8676002)(33656002)(8936002)(2906002)(54906003)(7696005)(71200400001)(6506007)(53546011)(26005)(83380400001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?M2VOTzY90QlrVl+q80+nd9rosmB2fgyjCLMSR6jpn42GtP8zmRo2RsOrTdhw?=
 =?us-ascii?Q?Gkzo3d1OyIiuwSd7GbCFvtfCs+1NqsLiOj/YUFXOMuvkonahqas2aiutyiej?=
 =?us-ascii?Q?0LBjXY90/eJabuoppPJWUgaSRcdyl1ujvzdWs5HRNoieCPvBj+Ozw34+aQx2?=
 =?us-ascii?Q?lB6rZ0FIg/ZsXTVjw4UktGTv9yy/UWB612ktX8o97FQeFe2DSbwbSbKlFV0L?=
 =?us-ascii?Q?2MLSeuNnlSsmddF4BQE6akoMeTJ1vW5EPMgwiY4EjARuAVDs1K8xl2lp0Gd3?=
 =?us-ascii?Q?cppzKbwX355lCC86frgH4it9QwuuMHrCGWUNo+KRZ6q804NfbfZo7KiWgCDN?=
 =?us-ascii?Q?SdPiQKLKVuB+P5IDu39l/ehCyON30EXgZ4RuLbLsBybvtsO2lUf20NJ3l6gY?=
 =?us-ascii?Q?e/2s8zbFoQ+VJ7L6Bkd7LPBEUnSYhcCKbMgeLaHbQTBapI5Aj4zYkoqNCfMa?=
 =?us-ascii?Q?qNMvYi9UqdaPTHpxZZHT6xlUGbXIHZXflrr5gX6Iy49OAGIIuD+K8UPPxLW6?=
 =?us-ascii?Q?kv7ltcDvHqiH2K364EgwwpNXithQ4NuqFTyTxxPXTTP4RRoccjsRVOdgdrlA?=
 =?us-ascii?Q?WvvgjNWWYHxV+ZvUAtm5r0LlgerDSMFvlTz3OIMJ9ngqgHWjoPL8HMk/QuYU?=
 =?us-ascii?Q?VCQQENg0PVz+f3KSpUaH3G5sATceyeI1nDoai6zhK21JU0tZOLr04BlDRWqr?=
 =?us-ascii?Q?Zk2aF0vB3y9VvLauZ9MBNYfAyrN7hcJae8DRiziGL8okguRZX9G0OanSrUIr?=
 =?us-ascii?Q?5kmlxFgLjCqmv5eEMJhBpgY1k4D5mLxSRL+HZWSuxjdCOE/p4qdGRiAui/72?=
 =?us-ascii?Q?jw+1gB9Acf2Hsz8pf6ifyJCwELyHpSF89IJzw00xbPDeSKLe5ByRgeqnGcC8?=
 =?us-ascii?Q?/IrYgblVc+HbNU4uatWJ0Xp8jCU9JRdIxRPt2wAxF6xlg8qBoDZ8FrUfalme?=
 =?us-ascii?Q?fyl1NGaWuNyeEWixQRqPJZMUC10N0RGAtiWzB8HDWkM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dcc74f-6565-4120-98a2-08d897e18da0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 23:17:07.1443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEwdWZKXCAaVJ0dWSdO25mqM3w1JbfTYJ4TMB79HuwFA2J740N5yGtDcFysl5J68BpVmv2jlvoYIW5ogba7YEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2666
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607037430; bh=ZW9yuT+Q1cdqUVx35EXXs3sUuVIi2ZR7RcGAZCuDT5E=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
         In-Reply-To:Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-transport-forked:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=AUPLKY/0Cf8pVBIfUHIJ7cPJ/B/+NtyQ+Cbu/03SV6KYJm5Pjo+mpGVOfHxovPTfu
         VQyXiqrIwCdM2uni+1ut1SvkDwQ4zCnX3x0Yi8gwWYTP+h5zU7YVgHiTFD0PLQS6LR
         GmIJiu7GdF4nVZbt3k22ugmARoK1qrekbCxDTAMuX9FxcDSKfvdquLbeTqVNhJTgEJ
         cBrvuskLGI5vSTVnHQpUjj19hpWcQbUQTp3fDhu6kI8PLrTbByP6jXGDELArsr2ur+
         J1+ttvygcG0eNpj2TwRK0DwCDTSEiZjsU1RXr9tbCgkuvF5wWWyYDfNw2tCX7XQIAQ
         ntahGuCKj8+JA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Friday, December 04, 2020 12:31 AM
> To: Vadim Pasternak <vadimp@nvidia.com>; Hans de Goede
> <hdegoede@redhat.com>; Mark Gross <mgross@linux.intel.com>; Nathan
> Chancellor <natechancellor@gmail.com>; Nick Desaulniers
> <ndesaulniers@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; Michael Shych
> <michaelsh@mellanox.com>; platform-driver-x86@vger.kernel.org; linux-
> kernel@vger.kernel.org; clang-built-linux@googlegroups.com
> Subject: [PATCH] platform/x86: mlx-platform: remove an unused variable
>=20
> From: Arnd Bergmann <arnd@arndb.de>

Acked-by: Vadim Pasternak <vadimp@nvidia.com>

>=20
> The only reference to the mlxplat_mlxcpld_psu[] array got removed, so the=
re is
> now a warning from clang:
>=20
> drivers/platform/x86/mlx-platform.c:322:30: error: variable
> 'mlxplat_mlxcpld_psu' is not needed and will not be emitted [-Werror,-
> Wunneeded-internal-declaration]
> static struct i2c_board_info mlxplat_mlxcpld_psu[] =3D {
>=20
> Remove the array as well and adapt the ARRAY_SIZE() call accordingly.
>=20
> Fixes: 912b341585e3 ("platform/x86: mlx-platform: Remove PSU EEPROM from
> MSN274x platform configuration")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/x86/mlx-platform.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/platform/x86/mlx-platform.c b/drivers/platform/x86/m=
lx-
> platform.c
> index 598f44558764..6a634b72bfc2 100644
> --- a/drivers/platform/x86/mlx-platform.c
> +++ b/drivers/platform/x86/mlx-platform.c
> @@ -319,15 +319,6 @@ static struct i2c_mux_reg_platform_data
> mlxplat_extended_mux_data[] =3D {  };
>=20
>  /* Platform hotplug devices */
> -static struct i2c_board_info mlxplat_mlxcpld_psu[] =3D {
> -	{
> -		I2C_BOARD_INFO("24c02", 0x51),
> -	},
> -	{
> -		I2C_BOARD_INFO("24c02", 0x50),
> -	},
> -};
> -
>  static struct i2c_board_info mlxplat_mlxcpld_pwr[] =3D {
>  	{
>  		I2C_BOARD_INFO("dps460", 0x59),
> @@ -456,7 +447,7 @@ static struct mlxreg_core_item
> mlxplat_mlxcpld_default_items[] =3D {
>  		.aggr_mask =3D MLXPLAT_CPLD_AGGR_PSU_MASK_DEF,
>  		.reg =3D MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
>  		.mask =3D MLXPLAT_CPLD_PSU_MASK,
> -		.count =3D ARRAY_SIZE(mlxplat_mlxcpld_psu),
> +		.count =3D
> ARRAY_SIZE(mlxplat_mlxcpld_default_psu_items_data),
>  		.inversed =3D 1,
>  		.health =3D false,
>  	},
> @@ -495,7 +486,7 @@ static struct mlxreg_core_item
> mlxplat_mlxcpld_comex_items[] =3D {
>  		.aggr_mask =3D MLXPLAT_CPLD_AGGR_MASK_CARRIER,
>  		.reg =3D MLXPLAT_CPLD_LPC_REG_PSU_OFFSET,
>  		.mask =3D MLXPLAT_CPLD_PSU_MASK,
> -		.count =3D ARRAY_SIZE(mlxplat_mlxcpld_psu),
> +		.count =3D
> ARRAY_SIZE(mlxplat_mlxcpld_default_psu_items_data),
>  		.inversed =3D 1,
>  		.health =3D false,
>  	},
> --
> 2.27.0

