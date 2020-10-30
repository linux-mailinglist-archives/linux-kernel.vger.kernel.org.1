Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80792A1197
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 00:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgJ3XYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 19:24:33 -0400
Received: from mail-am6eur05on2076.outbound.protection.outlook.com ([40.107.22.76]:63744
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbgJ3XYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 19:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nibAzUhQ15OEeoSztfHjQhOLhyt9myH3U3N0JdvTveA4GJ+jli71iNIuPwQrgMpuz9bJWE0C6DixavVFVSLJf9bDUAVnl5wKAXa6d7cGnta3UrnYNBuJh38PXezbAjL4i/AjLmycQuTRN+urOMoKyiAfMoJBznsnDDTgnghzYRKhQfr6Pze+ylTUdcCIM2Qytd5Gsx8nOelscrwjG4dP7VRt7TBAy7R1S8KNsVQ0tcFgoZaFfJzBzD2KQobSX5Vr7xdx+npjr8RM3YbSZWDnjdMe0bgk+IhsdRqUsAHG2n3VAy+rJHkQeXVgEZCDwpmdeKoeqGnmVV3XoV2efstKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7auLWgy602Y3k4UrnWGYUc9Vn3mpJAZN7mXV7ZKm0Q=;
 b=nb7y02CEbg+3+vb8MK1syDUoU7WdUJczTR9A8vmAoqDiph5EkQeP/ZTe2QQirk6QcX3affVTvP6hXzK2igMxJU1Ty+gcKRkRrXr/c+SYKBwzuFTCxYrDJC5w46XKcRCXKWyRgM4xZe2R/4aD1QPdsl5+ScXvqtlKatR1YKU/xuw9R9M41JeUQm9pCcbKhrwNQXDMhjiYg3ndRNRSwpQUQswwqykM3kUiLo3VOMwniX6Jds2dD5ixItHrnab3oflFGDeiE8ztmu8J01vvHZc3XuR1qF0m/HPmSxtDcRHEZfRclnxGpwqDXQ1XS6tfu7996u5ZUeQvr8QSVPoywHcxNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7auLWgy602Y3k4UrnWGYUc9Vn3mpJAZN7mXV7ZKm0Q=;
 b=JOTznAm1/hE/7Y7kXrZ/EmiqqdNFSQb/NZ73D2d+TzdZQbBfWQqIkmteDO/cN1szn+T11yR/Jft6zgK24kWAw8tSb74hi5Ir7wgf6G1m3tmpeu3PPShATnTYo9stP+kVWRlBOCrkyiyDSxRY7kyoulSo1/yKeEFjJHSUuswJMLc=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR0402MB3364.eurprd04.prod.outlook.com (2603:10a6:208:17::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 30 Oct
 2020 23:24:29 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2%4]) with mapi id 15.20.3499.029; Fri, 30 Oct 2020
 23:24:29 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Michael R Sweet <msweet@msweet.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix default q_len for usb_f_printer gadget driver
Thread-Topic: [PATCH] Fix default q_len for usb_f_printer gadget driver
Thread-Index: AQHWrwzV9jtaofMn3Uubju/AT/ynNamwyWQA
Date:   Fri, 30 Oct 2020 23:24:29 +0000
Message-ID: <20201030232400.GA3090@b29397-desktop>
References: <20201030223419.3780-1-msweet@msweet.org>
In-Reply-To: <20201030223419.3780-1-msweet@msweet.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: msweet.org; dkim=none (message not signed)
 header.d=none;msweet.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7fb4a2ca-0cb1-48ad-6554-08d87d2af301
x-ms-traffictypediagnostic: AM0PR0402MB3364:
x-microsoft-antispam-prvs: <AM0PR0402MB3364702DB9672932F1B981868B150@AM0PR0402MB3364.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4sQCsGFnHYC3g5JppYORg2oQJGHs2px1zOh0BYgBNcWNh2J+x6kNCX8FKUG6ddfcyc/LKmnul6jW4EBsLk03wjngmedObfrrqB1I/LLe2mT1zfcVZVPdvScBmLJv3VOGFVWE24Z3p8ASyl1rLb65SBdrmwMz0Jkn51N+pSG0vsWnqHSx15UdC8L7M0Fcpk6V3M5uXru/cZ3y6D6ZUtX1gac4suw5ggBs1Sgk/dQ1Y97EhoaH105IJHN6nWPGDTINXE+x4XFKfcURLjjSRULUpwm9VkvcFhfg3Q1qykTFp56SvrkjakaIG9TbBBuz1PppI6bVMMgkpqF0qF0oxhscuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(346002)(366004)(396003)(39850400004)(66446008)(64756008)(66556008)(66476007)(66946007)(8676002)(8936002)(26005)(76116006)(91956017)(33656002)(6512007)(83380400001)(9686003)(2906002)(6506007)(86362001)(6916009)(53546011)(71200400001)(33716001)(478600001)(1076003)(44832011)(316002)(4326008)(6486002)(54906003)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HBTn7ADHi3huFBI936NvNEo+2Xe/Lx3e/y3JJf+O+1D6Px+IEw8N4ty2Rj8DTTpAti+xbv/ISRT7PIu69KnU2ueYyYX/NzJW/vXv4+VI57g08brz+jlV/V7FWXjuxWVRecwmvmqyks0Uo+O7Oi/e876SQdY8o5JxZnsrFsWsej8C0mGYM2Qfm/mdtDRyAzksdSejSMwMz9kk8GBnQGTLHnIKnZWm4WPvdxG5p2dMIipmclGozW1lPS5nlqq1Ifu9aJev2n/LFgQTf5wmWEZfjTxPVJgqU5XRuQI7Eu/aydXEURSoMyl+0CfUOakLfkVuaFZQ0EmTEYt1FF/MlBdaKfRcygFeOvOJHsIkfZMtEet9zojsZXMo2wyZuBkbnHgCY+ZRVHHYXIx7wjMaSIV1iPEYA1rMmSlrDoTe7gE0CNOGNBxhIKkMsM0xheDtSh/Lu1rzi1dEsgWVtIuNHQvK4JL5o3kleydVFkXw5UOkaE13Rb5cFFx3dmn8DcUoaUhfetIIP4Vv+1C9CHOf+ldQfmU74NUFE+TRQoO3G20O3DRRadlvmMO6QvGdLF5e18GJvS8sMdZa2v+5jDR4luEydVQrq5Eyiy9Fih3wtVOMDRXNEQ4r9TmkbqGJyjfCYcRpWv/BX7C2zDMqaqBCmhbdsw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DC06C8EB9927A6488542216163F23286@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb4a2ca-0cb1-48ad-6554-08d87d2af301
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 23:24:29.1550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4//N+mOzyATmhTCE6xAZI9SWnWLv2jIrxXAsJf8krfZbL0Cc5DaL9C2QMxmOdm2uOFlZ0wS6WPXwE65k2cRxbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3364
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-30 18:34:19, Michael R Sweet wrote:
> The usb_f_printer gadget driver uses a default q_len value of *0* which p=
revents
> any IO from occurring.  Moreover, once the driver is instantiated it is
> impossible to change the q_len value.
>=20
> The following patch uses a default q_len value of 10 which matches the le=
gacy
> g_printer gadget driver.  This minimizes the possibility that you end up =
with a
> non-working printer gadget.  It is still possible to set the q_len to a
> different value using the configfs path of the same name.
>=20
> Signed-off-by: Michael R Sweet <msweet@msweet.org>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
> ---
>  drivers/usb/gadget/function/f_printer.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget=
/function/f_printer.c
> index 9c7ed2539ff7..4f3161005e4f 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -50,6 +50,8 @@
>  #define GET_PORT_STATUS		1
>  #define SOFT_RESET		2
> =20
> +#define DEFAULT_Q_LEN		10 /* same as legacy g_printer gadget */
> +
>  static int major, minors;
>  static struct class *usb_gadget_class;
>  static DEFINE_IDA(printer_ida);
> @@ -1317,6 +1319,9 @@ static struct usb_function_instance *gprinter_alloc=
_inst(void)
>  	opts->func_inst.free_func_inst =3D gprinter_free_inst;
>  	ret =3D &opts->func_inst;
> =20
> +	/* Make sure q_len is initialized, otherwise the bound device can't sup=
port read/write! */
> +	opts->q_len =3D DEFAULT_Q_LEN;
> +
>  	mutex_lock(&printer_ida_lock);
> =20
>  	if (ida_is_empty(&printer_ida)) {
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
