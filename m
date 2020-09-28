Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4810A27AC53
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1K7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:59:03 -0400
Received: from mail-db8eur05on2083.outbound.protection.outlook.com ([40.107.20.83]:21249
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726328AbgI1K7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:59:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIZPp+CKeUDlvZe1snhN4EOvGHFWFU6MulnRn7QuKgMVPvhAcBv67ibWWvosEbQDl3TlfWYILW26ZID/GqKQ9BLpWUPB8mOIQla78CnkHu6FIGj0f9N61/okiVx9k67hevnetnbgJoXnOMo8R4ts9EoRCvn2MJ720qcbh2+/bvbdu3y9ggKMFpOtMDwklk3sCX8Eq2SZLsRBVS00Q4uji3Kv1sbwi2uOMSn5f92G2H63gTqBQLykaKX2JvizvQDh8l7Bq4gk6RX6Fzn/PxAJP6RHXG80olZWudIIyjxJnsHFAPP2GNdUGKTjJ9OWUZZnK+imggbKeLbtXWFFNQql+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiWdeihi3R84Jn4httsY4Z/nDxw+AJCGGiqkkkCjBbg=;
 b=CNIWSrCd19INxH6wrj2Mv/tXY8TxmuSCnYrxabdi4BZwnSiZasToXxMmzvZsScuPQ8neJ4axj2seB6pP9/vVieVZSFeMSG1i49CiJOhlYCzfpjBXthwpaP1UKAmL7iAWZoH1fHjQ1bIrbt89lSWeQD++Bp851HDH46GIK8E/iuwxke4JLV0uRFK0wHkIPsj5BPVFNrIbtepPVFTavo3K4pLS/GFGXluiDUR/MU8YNztjQCkJ8w8pD3IPt97sxZgj8UfFUsVy0HGB4IB1nA7Qa3dC+g2m1a+fnXK9EaiSMl5ESJh5hX6Gf3Ipqe67E6ivTIraikwBDZBkYVM5Mjnovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WiWdeihi3R84Jn4httsY4Z/nDxw+AJCGGiqkkkCjBbg=;
 b=i+m17klSNUAcURZU9l2/niFEh5D3HLHXXTzAG+Kbe/b6uUFsHJi7U2D4T95tyqfW4f7eoD3PadPQTw73p/jMtJyVwfqyaeV5DA8czYMCvjZhn4iXb2EU6CTxnNLAiSuoRZ2wWZ3hwVlAV30fYa5K7e/fG7AnZ/7t5LS9K+2+IWU=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB6PR04MB3093.eurprd04.prod.outlook.com (2603:10a6:6:b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.24; Mon, 28 Sep 2020 10:58:52 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::c8a:a759:d4ba:181e%7]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:58:52 +0000
From:   Biwen Li <biwen.li@nxp.com>
To:     "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Reinhard Pfau <pfau@gdsys.de>
Subject: RE: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Thread-Topic: [PATCH] hwmon: add support for SMSC EMC2305/03/02/01 fan
 controller
Thread-Index: AQHWlYVprUbsc3ezq0mPfUMuZdBD06l94C+Q
Date:   Mon, 28 Sep 2020 10:58:52 +0000
Message-ID: <DB6PR0401MB24384EAA8516A0FA303A680E8F350@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20200928104326.40386-1-biwen.li@oss.nxp.com>
In-Reply-To: <20200928104326.40386-1-biwen.li@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ce1135e-421d-47bd-1b2f-08d8639d7cb2
x-ms-traffictypediagnostic: DB6PR04MB3093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB309309C9F7B90149A0FCB1B68F350@DB6PR04MB3093.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aY1LL5y28nV13rSiVSVLw84lSUFgV2ZVmpmgiLZIqUc65ywiTocqxx+H2ZeAiMkzk0xBH9QVjXcpGxtLbqfKZEofiWM4H+uMKhojoJ5OmSJQkLa37LBsS4nAMJEqUB3CCgTjfKF2kwhqMoM7qKVwSSeppJIijsXPE4K0LFd8bxa5YJs52oJpn0nsXL9RVh02+P2uz6oG+kqgOmj1YndrzELBzb3ucE9qjD1lPQr/RRQvUD7JrtY5Tm7BFri7OGi/4zluAJ9Sg3BhEjp+Zpio1wHSsdOwjUEZl/Hi9ZCKd6NVm6/ckRs+GBLR6L/4lNaAa2dHDyOnjCgQW+FwC6e/RqwmuA+MyzGd5lki2cNKhub5IAgBhnPsVbVk4fdkLzsR24LVXBksuw4sbjUclXTkUBMtrKlQT0QQLD3KrLzqHQ4u4U6qZmCOcii4hUtFj8UwtDz/aGtYHFE+ed+V+qARd8e79R29GZ6veWUtz87MIIQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(55016002)(83380400001)(9686003)(44832011)(26005)(52536014)(2906002)(7696005)(8676002)(83080400001)(6506007)(186003)(66446008)(4326008)(64756008)(66556008)(66476007)(86362001)(8936002)(45080400002)(478600001)(76116006)(66946007)(5660300002)(54906003)(110136005)(33656002)(316002)(30864003)(71200400001)(2004002)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: L72tkA3M+84xmkSCz8InSU4cEjgtbYUZQYbsLhGwQPC0tHLy/xV6VEf56XaAiz4z5RhCWzY7wXSIGxhtspp5Ych0T3CMggYshUpmGnukQA3HK+hNOLmXzPR3fwiN58aAGj9Y1T6j0NDrsOu8x4hLES4PK4WMs27Y1W6VUlHej0kLuElt3cUaq0KsezkXFp/t8jq96wbEPP40e1UVrvVjd4SB131MkIeK9+QfTG+PPOCQzsUI8f/4Xk9nxShjvYrvsS9SpJlsTw2pYsVlfzKndMw3ibaY4ujyq4nxWGvRDnXgFe9stk/ueQnXBqDKG3NGSZfsbYRipNiicIRxIFGIYc5Dwn7r71Vnqa7XiA4g+YOLeYfTo835k15Ms5WuS6MlA3Ad0BYtCT+kl+FbCwv7o9q85swKO8vOZnLFSLvilTd71TliaJWHqJ4Am+il5JuxLoBm4xewyeezZKAHR8B5waQ3pL85YMmoXMOxbcM6TrC8WMG7qXjBAdN/B7c8WOqLSEiLp5BnXjF5BrMOg7Oa3Pm/LldwyQ/HFBxLXECl2+eYH3wSAptZd6IQY5SM/DPRVPPV88Zv39hFJwRQSIZ7ZOeDRpk4++vveorUyHVq1S17/Uyiqgos+Q1tOxnh3RFJJZhjXEL/LvWQSjrboRPV3w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce1135e-421d-47bd-1b2f-08d8639d7cb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:58:52.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V7kI9+ysyAubPnV6UuZPV4BUJFagGO2B5L2NFXHQq3EwnnQP1X1AKhf06y0nEWJrEQwtjJjSJG+8s7zxz9vWcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The patch has a problem as follows,=20
root@localhost:~# cat /sys/class/hwmon/hwmon0/pwm1
[  103.150689] Unable to handle kernel paging request at virtual address 00=
329c10ffff0026
[  103.158651] Mem abort info:
[  103.161443]   ESR =3D 0x96000004
[  103.164486]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[  103.169789]   SET =3D 0, FnV =3D 0
[  103.172835]   EA =3D 0, S1PTW =3D 0
[  103.175963] Data abort info:
[  103.178841]   ISV =3D 0, ISS =3D 0x00000004
[  103.182672]   CM =3D 0, WnR =3D 0
[  103.185640] [00329c10ffff0026] address between user and kernel address r=
anges
[  103.192778] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[  103.198337] Modules linked in: emc2305
[  103.202076] CPU: 3 PID: 940 Comm: cat Not tainted 5.4.3-00011-gd80981868=
cef-dirty #7
[  103.209805] Hardware name: NXP Layerscape LX2160ABLUEBOX3 (DT)
[  103.215625] pstate: 60000005 (nZCv daif -PAN -UAO)
[  103.220409] pc : i2c_smbus_xfer+0x50/0x110
[  103.220409] pc : i2c_smbus_xfer+0x50/0x110
[  103.224494] lr : i2c_smbus_read_byte_data+0x40/0x70
[  103.229357] sp : ffff800010abbb50
[  103.232659] x29: ffff800010abbb50 x28: ffff0026d7fb6480
[  103.237958] x27: ffff0026d7fb6480 x26: ffff0026d5329be8
[  103.243256] x25: ffff800010abbbc6 x24: 0000000000000002
[  103.248555] x23: 0000000000000032 x22: 0000000000000001
[  103.253854] x21: 0000000000000000 x20: 0000000000000000
[  103.259152] x19: ffff0026d8011404 x18: 0000000000000000
[  103.264451] x17: 0000000000000000 x16: ffffaea1e5532f08
[  103.269749] x15: 0000000000000000 x14: 0000000000000000
[  103.275047] x13: 0000000000000000 x12: 0000000000000000
[  103.280346] x11: 0000000000000000 x10: 0000000000000000
[  103.285645] x9 : 0000000000000000 x8 : ffff0026d3f1d000
[  103.290943] x7 : ffffaea1e6919000 x6 : ffff800010abbbc6
[  103.296241] x5 : 0000000000000002 x4 : 0000000000000032
[  103.301540] x3 : 0000000000000001 x2 : d5329c10ffff0026
[  103.306839] x1 : 0000000000000002 x0 : ffff0026d8011404
[  103.312137] Call trace:
[  103.314572]  i2c_smbus_xfer+0x50/0x110
[  103.318308]  i2c_smbus_read_byte_data+0x40/0x70
[  103.322829]  read_u8_from_i2c+0x24/0x60 [emc2305]
[  103.327520]  emc2305_update_fan+0x9c/0x158 [emc2305]
[  103.332472]  pwm_enable_show+0x1c/0x50 [emc2305]
[  103.337078]  dev_attr_show+0x20/0x60
[  103.340643]  sysfs_kf_seq_show+0xbc/0x148
[  103.344640]  kernfs_seq_show+0x28/0x30
[  103.348377]  seq_read+0xcc/0x4c8
[  103.351592]  kernfs_fop_read+0x140/0x200
[  103.355503]  __vfs_read+0x18/0x38
[  103.358804]  vfs_read+0x98/0x188
[  103.362020]  ksys_read+0x68/0xf8
[  103.365235]  __arm64_sys_read+0x18/0x20
[  103.369059]  el0_svc_common.constprop.2+0x64/0x160
[  103.373837]  el0_svc_handler+0x20/0x80
[  103.377573]  el0_svc+0x8/0xc
[  103.380442] Code: 54000368 f9401262 52800041 aa1303e0 (f9400042)
[  103.386523] ---[ end trace 0f9e87c54e49a984 ]---

Any comments about this? Welcome for your comments.
>=20
> From: Reinhard Pfau <pfau@gdsys.de>
>=20
> Add support for SMSC EMC2305, EMC2303, EMC2302, EMC2301 fan
> controller chips.
> The driver primary supports the EMC2305 chip which provides RPM-based
> PWM control and monitoring for up to 5 fans.
>=20
> According to the SMSC data sheets the EMC2303, EMC2302 and EMC2301
> chips have basically the same functionality and register layout, but supp=
ort less
> fans and (in case of EMC2302 and EMC2301) less possible I2C addresses.
> The driver supports them, too.
>=20
> The driver supports configuration via devicetree. This can also be used t=
o
> restrict the fans exposed via sysfs (see doc for details).
>=20
> Signed-off-by: Reinhard Pfau <pfau@gdsys.de>
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> ---
>  .../devicetree/bindings/hwmon/emc2305.txt     |  33 +
>  Documentation/hwmon/emc2305.rst               |  34 +
>  MAINTAINERS                                   |   8 +
>  drivers/hwmon/Kconfig                         |  10 +
>  drivers/hwmon/Makefile                        |   1 +
>  drivers/hwmon/emc2305.c                       | 689
> ++++++++++++++++++
>  6 files changed, 775 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/hwmon/emc2305.txt
>  create mode 100644 Documentation/hwmon/emc2305.rst  create mode
> 100644 drivers/hwmon/emc2305.c
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/emc2305.txt
> b/Documentation/devicetree/bindings/hwmon/emc2305.txt
> new file mode 100644
> index 000000000000..73165120b88a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/hwmon/emc2305.txt
> @@ -0,0 +1,33 @@
> +EMC2305 (I2C)
> +
> +This device is a RPM-based PWM Fan Speed Controller for up to 5 fans.
> +Each fan can beconfigured individually:
> +
> + - The PWM mode:
> +    0: PWM is disabled
> +    3: RPM based PWM
> +
> + - The fan divisor (for RPM mesaurement)
> +   1, 2 ,4 or 8
> +
> + - The target RPM speed (for RPM based PWM mode)
> +   max 16000 (according to data sheet)
> +
> +
> + - The /emc2305 node
> +
> +   Required properties:
> +
> +   - compatible : must be "smsc,emc2305"
> +   - reg : I2C bus address of the device
> +   - #address-cells : must be <1>
> +   - #size-cells : must be <0>
> +
> +   Example EMC2305 node:
> +
> +       emc2305@2C {
> +	    compatible =3D "smsc,emc2305";
> +	    reg =3D <0x2C>;
> +	    #address-cells =3D <1>;
> +	    #size-cells =3D <0>;
> +       }
> diff --git a/Documentation/hwmon/emc2305.rst
> b/Documentation/hwmon/emc2305.rst new file mode 100644 index
> 000000000000..d0cebae09ffd
> --- /dev/null
> +++ b/Documentation/hwmon/emc2305.rst
> @@ -0,0 +1,34 @@
> +Kernel driver emc2305
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Supported chips:
> +  * SMSC EMC2305, EMC2303, EMC2302, EMC2301
> +    Adresses scanned: I2C 0x2c, 0x2d, 0x2e, 0x2f, 0x4c, 0x4d
> +    Prefixes: 'emc2305', 'emc2303', 'emc2302', 'emc2301'
> +    Datasheet: Publicly available at the MICROCHIP website :
> +
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww1.m
> i
> +crochip.com%2Fdownloads%2Fen%2FDeviceDoc%2F2305.pdf&amp;data=3D02
> %7C01%7C
> +biwen.li%40nxp.com%7Cef95cc6d971c433d699808d8639c8b20%7C686ea1
> d3bc2b4c6
> +fa92cd99c5c301635%7C0%7C1%7C637368871279812461&amp;sdata=3D1SaL
> 9ZOOTdEpMY
> +yXLQ%2F3KjbsHTgJ5UzK7o5ltsiBU5Y%3D&amp;reserved=3D0
> +
> +Authors:
> +        Reinhard Pfau, Guntermann & Drunck GmbH <pfau@gdsys.de>
> +        Biwen Li <biwen.li@nxp.com>
> +
> +Description
> +-----------
> +
> +The SMSC EMC2305 is a fan controller for up to 5 fans.
> +The EMC2303 has the same functionality but supports only up to 3 fans.
> +
> +The EMC2302 supports 2 fans and the EMC2301 1 fan. These chips support
> +less possible I2C addresses.
> +
> +Fan rotation speeds are reported in RPM.
> +The driver supports the RPM based PWM control to keep a fan at a desired
> speed.
> +To enable this function for a fan, write 3 to pwm<num>_enable and the
> +desired fan speed to fan<num>_target.
> +
> +
> +Devicetree
> +----------
> +
> +Configuration is also possible via devicetree:
> +Documentation/devicetree/bindings/hwmon/emc2305.txt
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b526b8a66f8a..a506e8071259 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15013,6 +15013,14 @@ S:	Maintained
>  F:	Documentation/hwmon/emc2103.rst
>  F:	drivers/hwmon/emc2103.c
>=20
> +SMSC EMC2305 HARDWARE MONITOR DRIVER
> +M:	Biwen Li <biwen.li@nxp.com>
> +L:	lm-sensors@lm-sensors.org
> +S:	Maintained
> +F:	Documentation/hwmon/emc2305
> +F:	Documentation/devicetree/bindings/hwmon/emc2305.txt
> +F:	drivers/hwmon/emc2305.c
> +
>  SMSC SCH5627 HARDWARE MONITOR DRIVER
>  M:	Hans de Goede <hdegoede@redhat.com>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig index
> 2fa4666d5b07..5ab3e975517a 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1457,6 +1457,16 @@ config SENSORS_EMC2103
>  	  This driver can also be built as a module. If so, the module
>  	  will be called emc2103.
>=20
> +config SENSORS_EMC2305
> +	tristate "SMSC EMC2305"
> +	depends on I2C
> +	help
> +	  If you say yes here you get support for the SMSC EMC2305
> +	  fan controller chips.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called emc2305.
> +
>  config SENSORS_EMC6W201
>  	tristate "SMSC EMC6W201"
>  	depends on I2C
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile index
> b033e6733b56..b6377d32a2c9 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -60,6 +60,7 @@ obj-$(CONFIG_SENSORS_DS620)	+=3D ds620.o
>  obj-$(CONFIG_SENSORS_DS1621)	+=3D ds1621.o
>  obj-$(CONFIG_SENSORS_EMC1403)	+=3D emc1403.o
>  obj-$(CONFIG_SENSORS_EMC2103)	+=3D emc2103.o
> +obj-$(CONFIG_SENSORS_EMC2305)	+=3D emc2305.o
>  obj-$(CONFIG_SENSORS_EMC6W201)	+=3D emc6w201.o
>  obj-$(CONFIG_SENSORS_F71805F)	+=3D f71805f.o
>  obj-$(CONFIG_SENSORS_F71882FG)	+=3D f71882fg.o
> diff --git a/drivers/hwmon/emc2305.c b/drivers/hwmon/emc2305.c new file
> mode 100644 index 000000000000..d0c99f9b7434
> --- /dev/null
> +++ b/drivers/hwmon/emc2305.c
> @@ -0,0 +1,689 @@
> +/*
> + * emc2305.c - hwmon driver for SMSC EMC2305 fan controller
> + * (C) Copyright 2013
> + * Copyright 2020 NXP
> + * Reinhard Pfau, Guntermann & Drunck GmbH <pfau@gdsys.de>
> + * Biwen Li <biwen.li@nxp.com>
> + *
> + * Based on emc2103 driver by SMSC.
> + *
> + * Datasheet available at:
> + *
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fww1.m
> i
> +crochip.com%2Fdownloads%2Fen%2FDeviceDoc%2F2305.pdf&amp;data=3D02
> %7C01%7C
> +biwen.li%40nxp.com%7Cef95cc6d971c433d699808d8639c8b20%7C686ea1
> d3bc2b4c6
> +fa92cd99c5c301635%7C0%7C1%7C637368871279812461&amp;sdata=3D1SaL
> 9ZOOTdEpMY
> +yXLQ%2F3KjbsHTgJ5UzK7o5ltsiBU5Y%3D&amp;reserved=3D0
> + *
> + * Also supports the EMC2303 fan controller which has the same
> +functionality
> + * and register layout as EMC2305, but supports only up to 3 fans instea=
d of
> 5.
> + *
> + * Also supports EMC2302 (up to 2 fans) and EMC2301 (1 fan) fan controll=
er.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +/*
> + * TODO / IDEAS:
> + * - expose more of the configuration and features  */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/jiffies.h>
> +#include <linux/i2c.h>
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/err.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +
> +/*
> + * Addresses scanned.
> + * Listed in the same order as they appear in the EMC2305, EMC2303 data
> sheets.
> + *
> + * Note: these are the I2C adresses which are possible for EMC2305 and
> +EMC2303
> + * chips.
> + * The EMC2302 supports only 0x2e (EMC2302-1) and 0x2f (EMC2302-2).
> + * The EMC2301 supports only 0x2f.
> + */
> +static const unsigned short i2c_addresses[] =3D {
> +	0x2E,
> +	0x2F,
> +	0x2C,
> +	0x2D,
> +	0x4C,
> +	0x4D,
> +	I2C_CLIENT_END
> +};
> +
> +/*
> + * global registers
> + */
> +enum {
> +	REG_CONFIGURATION =3D 0x20,
> +	REG_FAN_STATUS =3D 0x24,
> +	REG_FAN_STALL_STATUS =3D 0x25,
> +	REG_FAN_SPIN_STATUS =3D 0x26,
> +	REG_DRIVE_FAIL_STATUS =3D 0x27,
> +	REG_FAN_INTERRUPT_ENABLE =3D 0x29,
> +	REG_PWM_POLARITY_CONFIG =3D 0x2a,
> +	REG_PWM_OUTPUT_CONFIG =3D 0x2b,
> +	REG_PWM_BASE_FREQ_1 =3D 0x2c,
> +	REG_PWM_BASE_FREQ_2 =3D 0x2d,
> +	REG_SOFTWARE_LOCK =3D 0xef,
> +	REG_PRODUCT_FEATURES =3D 0xfc,
> +	REG_PRODUCT_ID =3D 0xfd,
> +	REG_MANUFACTURER_ID =3D 0xfe,
> +	REG_REVISION =3D 0xff
> +};
> +
> +/*
> + * fan specific registers
> + */
> +enum {
> +	REG_FAN_SETTING =3D 0x30,
> +	REG_PWM_DIVIDE =3D 0x31,
> +	REG_FAN_CONFIGURATION_1 =3D 0x32,
> +	REG_FAN_CONFIGURATION_2 =3D 0x33,
> +	REG_GAIN =3D 0x35,
> +	REG_FAN_SPIN_UP_CONFIG =3D 0x36,
> +	REG_FAN_MAX_STEP =3D 0x37,
> +	REG_FAN_MINIMUM_DRIVE =3D 0x38,
> +	REG_FAN_VALID_TACH_COUNT =3D 0x39,
> +	REG_FAN_DRIVE_FAIL_BAND_LOW =3D 0x3a,
> +	REG_FAN_DRIVE_FAIL_BAND_HIGH =3D 0x3b,
> +	REG_TACH_TARGET_LOW =3D 0x3c,
> +	REG_TACH_TARGET_HIGH =3D 0x3d,
> +	REG_TACH_READ_HIGH =3D 0x3e,
> +	REG_TACH_READ_LOW =3D 0x3f,
> +};
> +
> +#define SEL_FAN(fan, reg) (reg + fan * 0x10)
> +
> +/*
> + * Factor by equations [2] and [3] from data sheet; valid for fans
> +where the
> + * number of edges equals (poles * 2 + 1).
> + */
> +#define FAN_RPM_FACTOR 3932160
> +
> +struct emc2305_fan_data {
> +	bool		enabled;
> +	bool		rpm_control;
> +	bool		valid;		/* registers are valid */
> +	u8		poles;
> +	u8		multiplier;
> +	u16		tach;
> +	u16		target;
> +	unsigned long		last_updated;	/* in jiffies */
> +};
> +
> +struct emc2305_data {
> +	struct i2c_client	*client;
> +	const struct		attribute_group *groups[6];
> +	struct mutex		update_lock;
> +	int			fan_count; /* num of fan */
> +	struct emc2305_fan_data fan[5];
> +};
> +
> +static int read_u8_from_i2c(struct i2c_client *client, u8 i2c_reg, u8
> +*output) {
> +	int status =3D i2c_smbus_read_byte_data(client, i2c_reg);
> +	if (status < 0) {
> +		dev_warn(&client->dev, "reg 0x%02x, err %d\n",
> +			i2c_reg, status);
> +	} else {
> +		*output =3D status;
> +	}
> +	return status;
> +}
> +
> +static void read_fan_from_i2c(struct i2c_client *client, u16 *output,
> +			      u8 hi_addr, u8 lo_addr)
> +{
> +	u8 high_byte, lo_byte;
> +
> +	if (read_u8_from_i2c(client, hi_addr, &high_byte) < 0)
> +		return;
> +
> +	if (read_u8_from_i2c(client, lo_addr, &lo_byte) < 0)
> +		return;
> +
> +	*output =3D ((u16)high_byte << 5) | (lo_byte >> 3); }
> +
> +static void write_fan_target_to_i2c(struct i2c_client *client, int fan,
> +				    u16 new_target)
> +{
> +	const u8 lo_reg =3D SEL_FAN(fan, REG_TACH_TARGET_LOW);
> +	const u8 hi_reg =3D SEL_FAN(fan, REG_TACH_TARGET_HIGH);
> +	u8 high_byte =3D (new_target & 0x1fe0) >> 5;
> +	u8 low_byte =3D (new_target & 0x001f) << 3;
> +
> +	i2c_smbus_write_byte_data(client, lo_reg, low_byte);
> +	i2c_smbus_write_byte_data(client, hi_reg, high_byte); }
> +
> +static void read_fan_config_from_i2c(struct i2c_client *client, int
> +fan_idx)
> +
> +{
> +	struct emc2305_data *data =3D i2c_get_clientdata(client);
> +	u8 conf1;
> +
> +	if (read_u8_from_i2c(client, SEL_FAN(fan_idx,
> REG_FAN_CONFIGURATION_1),
> +			     &conf1) < 0)
> +		return;
> +
> +	data->fan[fan_idx].rpm_control =3D (conf1 & 0x80) !=3D 0;
> +	data->fan[fan_idx].multiplier =3D 1 << ((conf1 & 0x60) >> 5);
> +	data->fan[fan_idx].poles =3D ((conf1 & 0x18) >> 3) + 1; }
> +
> +static void read_fan_data(struct i2c_client *client, int fan_idx) {
> +	struct emc2305_data *data =3D i2c_get_clientdata(client);
> +
> +	read_fan_from_i2c(client, &data->fan[fan_idx].target,
> +			  SEL_FAN(fan_idx, REG_TACH_TARGET_HIGH),
> +			  SEL_FAN(fan_idx, REG_TACH_TARGET_LOW));
> +	read_fan_from_i2c(client, &data->fan[fan_idx].tach,
> +			  SEL_FAN(fan_idx, REG_TACH_READ_HIGH),
> +			  SEL_FAN(fan_idx, REG_TACH_READ_LOW)); }
> +
> +static struct emc2305_fan_data *
> +emc2305_update_fan(struct i2c_client *client, int fan_idx) {
> +	struct emc2305_data *data =3D i2c_get_clientdata(client);
> +	struct emc2305_fan_data *fan_data =3D &data->fan[fan_idx];
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (time_after(jiffies, fan_data->last_updated + HZ + HZ / 2)
> +	    || !fan_data->valid) {
> +		read_fan_config_from_i2c(client, fan_idx);
> +		read_fan_data(client, fan_idx);
> +		fan_data->valid =3D true;
> +		fan_data->last_updated =3D jiffies;
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return fan_data;
> +}
> +
> +static struct emc2305_fan_data *
> +emc2305_update_device_fan(struct device *dev, struct device_attribute
> +*da) {
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	int fan_idx =3D to_sensor_dev_attr(da)->index;
> +
> +	return emc2305_update_fan(client, fan_idx); }
> +
> +/*
> + * set/ config functions
> + */
> +
> +/*
> + * Note: we also update the fan target here, because its value is
> + * determined in part by the fan clock divider.  This follows the
> +principle
> + * of least surprise; the user doesn't expect the fan target to change
> +just
> + * because the divider changed.
> + */
> +static int
> +emc2305_set_fan_div(struct i2c_client *client, int fan_idx, long
> +new_div) {
> +	struct emc2305_data *data =3D i2c_get_clientdata(client);
> +	struct emc2305_fan_data *fan =3D emc2305_update_fan(client, fan_idx);
> +	const u8 reg_conf1 =3D SEL_FAN(fan_idx, REG_FAN_CONFIGURATION_1);
> +	int new_range_bits, old_div =3D 8 / fan->multiplier;
> +	int status =3D 0;
> +
> +	if (new_div =3D=3D old_div) /* No change */
> +		return 0;
> +
> +	switch (new_div) {
> +	case 1:
> +		new_range_bits =3D 3;
> +		break;
> +	case 2:
> +		new_range_bits =3D 2;
> +		break;
> +	case 4:
> +		new_range_bits =3D 1;
> +		break;
> +	case 8:
> +		new_range_bits =3D 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&data->update_lock);
> +
> +	status =3D i2c_smbus_read_byte_data(client, reg_conf1);
> +	if (status < 0) {
> +		dev_dbg(&client->dev, "reg 0x%02x, err %d\n",
> +			reg_conf1, status);
> +		goto exit_unlock;
> +	}
> +	status &=3D 0x9F;
> +	status |=3D (new_range_bits << 5);
> +	status =3D i2c_smbus_write_byte_data(client, reg_conf1, status);
> +	if (status < 0) {
> +		goto exit_invalidate;
> +	}
> +
> +	fan->multiplier =3D 8 / new_div;
> +
> +	/* update fan target if high byte is not disabled */
> +	if ((fan->target & 0x1fe0) !=3D 0x1fe0) {
> +		u16 new_target =3D (fan->target * old_div) / new_div;
> +		fan->target =3D min_t(u16, new_target, 0x1fff);
> +		write_fan_target_to_i2c(client, fan_idx, fan->target);
> +	}
> +
> +exit_invalidate:
> +	/* invalidate fan data to force re-read from hardware */
> +	fan->valid =3D false;
> +exit_unlock:
> +	mutex_unlock(&data->update_lock);
> +	return status;
> +}
> +
> +static int
> +emc2305_set_fan_target(struct i2c_client *client, int fan_idx, long
> +rpm_target) {
> +	struct emc2305_data *data =3D i2c_get_clientdata(client);
> +	struct emc2305_fan_data *fan =3D emc2305_update_fan(client, fan_idx);
> +
> +	/*
> +	 * Datasheet states 16000 as maximum RPM target
> +	 * (table 2.2 and section 4.3)
> +	 */
> +	if ((rpm_target < 0) || (rpm_target > 16000))
> +		return -EINVAL;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (rpm_target =3D=3D 0)
> +		fan->target =3D 0x1fff;
> +	else
> +		fan->target =3D clamp_val(
> +			FAN_RPM_FACTOR * fan->multiplier / rpm_target,
> +			0, 0x1fff);
> +
> +	write_fan_target_to_i2c(client, fan_idx, fan->target);
> +
> +	mutex_unlock(&data->update_lock);
> +	return 0;
> +}
> +
> +static int
> +emc2305_set_pwm_enable(struct i2c_client *client, int fan_idx, long
> +enable) {
> +	struct emc2305_data *data =3D i2c_get_clientdata(client);
> +	struct emc2305_fan_data *fan =3D emc2305_update_fan(client, fan_idx);
> +	const u8 reg_fan_conf1 =3D SEL_FAN(fan_idx,
> REG_FAN_CONFIGURATION_1);
> +	int status =3D 0;
> +	u8 conf_reg;
> +
> +	mutex_lock(&data->update_lock);
> +	switch (enable) {
> +	case 0:
> +		fan->rpm_control =3D false;
> +		break;
> +	case 3:
> +		fan->rpm_control =3D true;
> +		break;
> +	default:
> +		status =3D -EINVAL;
> +		goto exit_unlock;
> +	}
> +
> +	status =3D read_u8_from_i2c(client, reg_fan_conf1, &conf_reg);
> +	if (status < 0)
> +		goto exit_unlock;
> +
> +	if (fan->rpm_control)
> +		conf_reg |=3D 0x80;
> +	else
> +		conf_reg &=3D ~0x80;
> +
> +	status =3D i2c_smbus_write_byte_data(client, reg_fan_conf1, conf_reg);
> +
> +exit_unlock:
> +	mutex_unlock(&data->update_lock);
> +	return status;
> +}
> +
> +static ssize_t
> +fan_input_show(struct device *dev, struct device_attribute *da, char
> +*buf) {
> +	struct emc2305_fan_data *fan =3D emc2305_update_device_fan(dev, da);
> +	int rpm =3D 0;
> +
> +	if (fan->tach !=3D 0)
> +		rpm =3D (FAN_RPM_FACTOR * fan->multiplier) / fan->tach;
> +	return sprintf(buf, "%d\n", rpm);
> +}
> +
> +static ssize_t
> +fan_fault_show(struct device *dev, struct device_attribute *da, char
> +*buf) {
> +	struct emc2305_fan_data *fan =3D emc2305_update_device_fan(dev, da);
> +
> +	return sprintf(buf, "%d\n", (fan->tach & 0x1fe0) =3D=3D 0x1fe0); }
> +
> +static ssize_t
> +fan_div_show(struct device *dev, struct device_attribute *da, char
> +*buf) {
> +	struct emc2305_fan_data *fan =3D emc2305_update_device_fan(dev, da);
> +
> +	return sprintf(buf, "%d\n", 8 / fan->multiplier); }
> +
> +static ssize_t
> +fan_div_store(struct device *dev, struct device_attribute *da,
> +	    const char *buf, size_t count)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	int fan_idx =3D to_sensor_dev_attr(da)->index;
> +	long new_div;
> +	int status;
> +
> +	status =3D kstrtol(buf, 10, &new_div);
> +	if (status < 0)
> +		return status;
> +
> +	status =3D emc2305_set_fan_div(client, fan_idx, new_div);
> +	if (status < 0)
> +		return status;
> +
> +	return count;
> +}
> +
> +static ssize_t
> +fan_target_show(struct device *dev, struct device_attribute *da, char
> +*buf) {
> +	struct emc2305_fan_data *fan =3D emc2305_update_device_fan(dev, da);
> +	int rpm =3D 0;
> +
> +	/* high byte of 0xff indicates disabled so return 0 */
> +	if ((fan->target !=3D 0) && ((fan->target & 0x1fe0) !=3D 0x1fe0))
> +		rpm =3D FAN_RPM_FACTOR * fan->multiplier
> +			/ fan->target;
> +
> +	return sprintf(buf, "%d\n", rpm);
> +}
> +
> +static ssize_t fan_target_store(struct device *dev, struct device_attrib=
ute *da,
> +			      const char *buf, size_t count) {
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	int fan_idx =3D to_sensor_dev_attr(da)->index;
> +	long rpm_target;
> +	int status;
> +
> +	status =3D kstrtol(buf, 10, &rpm_target);
> +	if (status < 0)
> +		return status;
> +
> +	status =3D emc2305_set_fan_target(client, fan_idx, rpm_target);
> +	if (status < 0)
> +		return status;
> +
> +	return count;
> +}
> +
> +static ssize_t
> +pwm_enable_show(struct device *dev, struct device_attribute *da, char
> +*buf) {
> +	struct emc2305_fan_data *fan =3D emc2305_update_device_fan(dev, da);
> +	return sprintf(buf, "%d\n", fan->rpm_control ? 3 : 0); }
> +
> +static ssize_t pwm_enable_store(struct device *dev, struct device_attrib=
ute
> *da,
> +			      const char *buf, size_t count) {
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	int fan_idx =3D to_sensor_dev_attr(da)->index;
> +	long new_value;
> +	int status;
> +
> +	status =3D kstrtol(buf, 10, &new_value);
> +	if (status < 0)
> +		return -EINVAL;
> +	status =3D emc2305_set_pwm_enable(client, fan_idx, new_value);
> +	return count;
> +}
> +
> +static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_input, 0); static
> +SENSOR_DEVICE_ATTR_RW(fan1_div, fan_div, 0); static
> +SENSOR_DEVICE_ATTR_RW(fan1_target, fan_target, 0); static
> +SENSOR_DEVICE_ATTR_RO(fan1_fault, fan_fault, 0); static
> +SENSOR_DEVICE_ATTR_RO(fan2_input, fan_input, 1); static
> +SENSOR_DEVICE_ATTR_RW(fan2_div, fan_div, 1); static
> +SENSOR_DEVICE_ATTR_RW(fan2_target, fan_target, 1); static
> +SENSOR_DEVICE_ATTR_RO(fan2_fault, fan_fault, 1); static
> +SENSOR_DEVICE_ATTR_RO(fan3_input, fan_input, 2); static
> +SENSOR_DEVICE_ATTR_RW(fan3_div, fan_div, 2); static
> +SENSOR_DEVICE_ATTR_RW(fan3_target, fan_target, 2); static
> +SENSOR_DEVICE_ATTR_RO(fan3_fault, fan_fault, 2); static
> +SENSOR_DEVICE_ATTR_RO(fan4_input, fan_input, 3); static
> +SENSOR_DEVICE_ATTR_RW(fan4_div, fan_div, 3); static
> +SENSOR_DEVICE_ATTR_RW(fan4_target, fan_target, 3); static
> +SENSOR_DEVICE_ATTR_RO(fan4_fault, fan_fault, 3); static
> +SENSOR_DEVICE_ATTR_RO(fan5_input, fan_input, 4); static
> +SENSOR_DEVICE_ATTR_RW(fan5_div, fan_div, 4); static
> +SENSOR_DEVICE_ATTR_RW(fan5_target, fan_target, 4); static
> +SENSOR_DEVICE_ATTR_RO(fan5_fault, fan_fault, 4); static
> +SENSOR_DEVICE_ATTR_RW(pwm1, pwm_enable, 0); static
> +SENSOR_DEVICE_ATTR_RW(pwm2, pwm_enable, 1); static
> +SENSOR_DEVICE_ATTR_RW(pwm3, pwm_enable, 2); static
> +SENSOR_DEVICE_ATTR_RW(pwm4, pwm_enable, 3); static
> +SENSOR_DEVICE_ATTR_RW(pwm5, pwm_enable, 4);
> +
> +static struct attribute *emc2305_attributes_fan1[] =3D {
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
> +	&sensor_dev_attr_fan1_div.dev_attr.attr,
> +	&sensor_dev_attr_fan1_target.dev_attr.attr,
> +	&sensor_dev_attr_fan1_fault.dev_attr.attr,
> +	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *emc2305_attributes_fan2[] =3D {
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,
> +	&sensor_dev_attr_fan2_div.dev_attr.attr,
> +	&sensor_dev_attr_fan2_target.dev_attr.attr,
> +	&sensor_dev_attr_fan2_fault.dev_attr.attr,
> +	&sensor_dev_attr_pwm2.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *emc2305_attributes_fan3[] =3D {
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,
> +	&sensor_dev_attr_fan3_div.dev_attr.attr,
> +	&sensor_dev_attr_fan3_target.dev_attr.attr,
> +	&sensor_dev_attr_fan3_fault.dev_attr.attr,
> +	&sensor_dev_attr_pwm3.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *emc2305_attributes_fan4[] =3D {
> +	&sensor_dev_attr_fan4_input.dev_attr.attr,
> +	&sensor_dev_attr_fan4_div.dev_attr.attr,
> +	&sensor_dev_attr_fan4_target.dev_attr.attr,
> +	&sensor_dev_attr_fan4_fault.dev_attr.attr,
> +	&sensor_dev_attr_pwm4.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *emc2305_attributes_fan5[] =3D {
> +	&sensor_dev_attr_fan5_input.dev_attr.attr,
> +	&sensor_dev_attr_fan5_div.dev_attr.attr,
> +	&sensor_dev_attr_fan5_target.dev_attr.attr,
> +	&sensor_dev_attr_fan5_fault.dev_attr.attr,
> +	&sensor_dev_attr_pwm5.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group emc2305_fan1_group =3D {
> +	.attrs =3D emc2305_attributes_fan1,
> +};
> +
> +static const struct attribute_group emc2305_fan2_group =3D {
> +	.attrs =3D emc2305_attributes_fan2,
> +};
> +
> +static const struct attribute_group emc2305_fan3_group =3D {
> +	.attrs =3D emc2305_attributes_fan3,
> +};
> +
> +static const struct attribute_group emc2305_fan4_group =3D {
> +	.attrs =3D emc2305_attributes_fan4,
> +};
> +
> +static const struct attribute_group emc2305_fan5_group =3D {
> +	.attrs =3D emc2305_attributes_fan5,
> +};
> +
> +/*
> + * driver interface
> + */
> +static int
> +emc2305_probe(struct i2c_client *client, const struct i2c_device_id
> +*id) {
> +	struct emc2305_data *data;
> +	struct device *hwmon_dev;
> +	int status, idx =3D 0;
> +
> +	if (!i2c_check_functionality(client->adapter,
> I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -EIO;
> +
> +	data =3D devm_kzalloc(&client->dev, sizeof(struct emc2305_data),
> GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, data);
> +	data->client =3D client;
> +	mutex_init(&data->update_lock);
> +
> +	status =3D i2c_smbus_read_byte_data(client, REG_PRODUCT_ID);
> +	switch (status) {
> +	case 0x34: /* EMC2305 */
> +		data->fan_count =3D 5;
> +		break;
> +	case 0x35: /* EMC2303 */
> +		data->fan_count =3D 3;
> +		break;
> +	case 0x36: /* EMC2302 */
> +		data->fan_count =3D 2;
> +		break;
> +	case 0x37: /* EMC2301 */
> +		data->fan_count =3D 1;
> +		break;
> +	default:
> +		if (status < 0)
> +			dev_err(&client->dev, "Failed to read reg REG_PRODUCT_ID,
> status =3D %d\n", status);
> +		else
> +			dev_err(&client->dev, "Unknown device, status =3D %d\n", status);
> +		return status;
> +	}
> +
> +	/* sysfs hooks */
> +	data->groups[idx++] =3D &emc2305_fan1_group;
> +	if (data->fan_count >=3D 2)
> +		data->groups[idx++] =3D &emc2305_fan2_group;
> +	if (data->fan_count >=3D 3) {
> +		data->groups[idx++] =3D &emc2305_fan3_group;
> +	}
> +	if (data->fan_count =3D=3D 5) {
> +		data->groups[idx++] =3D &emc2305_fan4_group;
> +		data->groups[idx++] =3D &emc2305_fan5_group;
> +	}
> +
> +	hwmon_dev =3D devm_hwmon_device_register_with_groups(&client->dev,
> +							   client->name, data,
> +							   data->groups);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
> +
> +	dev_info(&client->dev, "pwm fan controller: '%s'\n",
> +		 client->name);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id emc2305_ids[] =3D {
> +	{ "emc2301", 0 },
> +	{ "emc2302", 0 },
> +	{ "emc2303", 0 },
> +	{ "emc2305", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, emc2305_ids);
> +
> +/* Return 0 if detection is successful, -ENODEV otherwise */ static int
> +emc2305_detect(struct i2c_client *new_client, struct i2c_board_info
> +*info) {
> +	struct i2c_adapter *adapter =3D new_client->adapter;
> +	int manufacturer, product;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> +		return -ENODEV;
> +
> +	manufacturer =3D
> +		i2c_smbus_read_byte_data(new_client, REG_MANUFACTURER_ID);
> +	if (manufacturer !=3D 0x5D)
> +		return -ENODEV;
> +
> +	product =3D i2c_smbus_read_byte_data(new_client, REG_PRODUCT_ID);
> +
> +	switch (product) {
> +	case 0x34:
> +		strlcpy(info->type, "emc2305", I2C_NAME_SIZE);
> +		break;
> +	case 0x35:
> +		strlcpy(info->type, "emc2303", I2C_NAME_SIZE);
> +		break;
> +	case 0x36:
> +		strlcpy(info->type, "emc2302", I2C_NAME_SIZE);
> +		break;
> +	case 0x37:
> +		strlcpy(info->type, "emc2301", I2C_NAME_SIZE);
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct i2c_driver emc2305_driver =3D {
> +	.class		=3D I2C_CLASS_HWMON,
> +	.driver =3D {
> +		.name	=3D "emc2305",
> +	},
> +	.probe		=3D emc2305_probe,
> +	.id_table	=3D emc2305_ids,
> +	.detect		=3D emc2305_detect,
> +	.address_list	=3D i2c_addresses,
> +};
> +
> +module_i2c_driver(emc2305_driver);
> +
> +MODULE_AUTHOR("Reinhard Pfau <pfau@gdsys>, Biwen Li
> +<biwen.li@nxp.com>\n"); MODULE_DESCRIPTION("SMSC EMC2305 hwmon
> +driver"); MODULE_LICENSE("GPL");
> --
> 2.17.1

