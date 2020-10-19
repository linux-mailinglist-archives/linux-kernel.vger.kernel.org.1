Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0136229241E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbgJSJAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:00:38 -0400
Received: from mail-vi1eur05on2051.outbound.protection.outlook.com ([40.107.21.51]:43329
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbgJSJAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:00:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1OeRg3hTYvIifY2TXfKOjfS/Cs3nZY8bdk/eG0djNey1EX9i+OomWkd2vf04tjK4DV7snywd6r1dfoYqS+mzTjHODjlYe/OyfFjpmnBdOgpAT9mkLEtXx9hwbldl4mS3LyQCOT+D0G0kd1AMjBnOqx3WZnXELGm+DqUkUxUiCek4Dp7A/inX2+KpOqlNjTbKbWzTbYcOUAxdekwsL59BNupf2kzRv79j/mEXpmyAHrmSItacp9LEefLHhICBKZJtP0p5soSPsc+isBDgi2+lw5fTTLHQeT2VnP8vqDlOM5e3Q3vwAlcSE7Za4zvEfkREQ/zKwTyh2hC2WT55rVPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN4bhehC0ZQCjP92+gec1RqegxFs9cmdOMPqF8PTCzQ=;
 b=jEazsR9ppsfv2TFmGF0bvmLssNQ5GJXvWKCT5U/N++Dwfne0DtXiBU/qxUEefILDpQWR4Ih+hBlh2ec6fqvTqBBYTJaPPP6/DwfL8/ie1YVgBNa9sqyveeA5nUoD2fP6lW3XWzpzVLVqfcmOY0GgUInxfr2aIWZEdHNQtRsf/TP+DiA4/mTeF1+Unt13tm3o9dc46bbis7F1H23OR2CKAFnZFga5agQWLVuO+3KqE1n50UbuvWObt4VJbglkgASRpxy0wDXwfosynoH5rrFqMC/f1EpBYOTHzv1FiBmmIPEL18XaHw4KiM7UlBVx0hSmzuCA9pts3rK/h38CMO9r3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN4bhehC0ZQCjP92+gec1RqegxFs9cmdOMPqF8PTCzQ=;
 b=pUpCOVZeE81g2oB/CloLjhc0x907TlNGbwi56S+5mSvJ6C+vpv5lkQt83kEtjsNoBrnmIHYhpHmUjeLJWECxKD7Jil1db1PDDhg5h2IdBTyTlwdpornJnivnNS81//nNwIK6pfTo8KEJUSszU33igxZtphEtOF2c4oOKIvc7Prk=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (2603:10a6:20b:10d::24)
 by AM7PR04MB6967.eurprd04.prod.outlook.com (2603:10a6:20b:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 19 Oct
 2020 09:00:33 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::a90d:1d14:7235:b56f%4]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 09:00:33 +0000
From:   Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Varun Sethi <V.Sethi@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ioana Ciornei <ioana.ciornei@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: RE: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
 lx2162aqds board
Thread-Topic: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for
 lx2162aqds board
Thread-Index: AQHWlkeuodA6cP2CUE+mv343XFniRamev/Qw
Date:   Mon, 19 Oct 2020 09:00:33 +0000
Message-ID: <AM7PR04MB6885980FC5B035B955D009BA8E1E0@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <1599059610-7570-2-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-1-git-send-email-meenakshi.aggarwal@nxp.com>
 <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
In-Reply-To: <1601373718-13218-3-git-send-email-meenakshi.aggarwal@nxp.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [110.235.228.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 139b333c-be8b-44f0-f71a-08d8740d7001
x-ms-traffictypediagnostic: AM7PR04MB6967:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB69670AF5461B30C48781F52D8E1E0@AM7PR04MB6967.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I785qC/vquXPjPT2wTicGBQqugDCX5kfRMTNhES/UneFiepcPgCIcNfSWHJRG73yhOtcX1gIS4rhItljTmtswijzOMhziSiv5nHN5UO/P7v3QyzLu3CHSAlw/Q89I0d9vAKcn1kZKYnaOWHtokeVtIZ77M/AiNbg3dQ9qIXm+Q/IwGrJWFLwD+L23g2RKPj0wItg/gsghHhItCXylaKPY9VmjtZ7cCaIpaVyXxYQIB2HRtXG4ANiSInIKdbwaCtVsNwugCqvDlkImJXguBQa/COczXTCLzk/32KPIXNAOJ9gal9XMRR+SbA4DSXGYfqk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6885.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(366004)(136003)(110136005)(8936002)(76116006)(66556008)(6506007)(53546011)(66476007)(66446008)(64756008)(44832011)(55016002)(8676002)(54906003)(66946007)(4326008)(9686003)(71200400001)(86362001)(26005)(186003)(316002)(478600001)(83380400001)(7696005)(52536014)(5660300002)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Xpf0JcuSV3CdTf9VVvHkrTwrl4U4Mfbxt4mpg1mAbICpDWbaewhkOnhBME+gzImu6vJhJyaWnDroMkYhYOQsjBVkzU5v7wSg1j/RN4VoufXMEBvz2ZZl8qMxF0mSwB0milPP/f3AaUBrZYhJocmW3MMXeYZDW3H7SL13H6ZXEjmOhFy6PP1MLyH0TfpYz+l0NHCThAgS2Xdl3RMbnBa7q9teHSJbxiS+Ir8I5oqkOMkfruLauCJ5JTOIHVM5o1GqsrreCF184nJtqpmjZ5P4rhhsqDMQOTgcxKcLCI9LoZiaIexGai59a2NGmV8HzoywDlKO7n5+ztbv0RzT4wqTXrdjvAwsX3uYY9iqXKGnemDKpS1yn8fGdgAcbvixyswXHmMkG3apaI0AVC1Uck9hGUVITw8iMmpXdXoQe9pkiONJt5QxnaI8xP0QlBlwoHnUb6Dct8VjQbijfX9aFWO9VDhp7oY2nqHU2l69J0XDoXivZyooNCnyDuvClyrGQenaLuSM7EfMapBPv7pjotiNFbQARcHGJYZt9ohQczUN9GbL0jKy4PWkXK04XfUzxWHjKKznFYODkRj39+6JhM6QNjYMh1PLpReUTzqnRJvd99nvcDXYnYiJ1jtFW/pjfaIGSvD6Gv8vM67roJLoSmcYFA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6885.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139b333c-be8b-44f0-f71a-08d8740d7001
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 09:00:33.4583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XhLxE0HWd0Cnp+0N4kUlh9UDGc+oKMly2wKoWpGzaxmVN0tyn5xzmaZA1Zlgvs+uOTpPEnN5jqz15JEtprQtz6jBxOK8f5Ech8mqVIVxb4Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6967
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any further comments?

Thanks,
Meenakshi

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Tuesday, September 29, 2020 3:33 PM
> To: shawnguo@kernel.org; robh+dt@kernel.org; Varun Sethi
> <V.Sethi@nxp.com>; Leo Li <leoyang.li@nxp.com>; linux-arm-
> kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>; Ioana Ciornei
> <ioana.ciornei@nxp.com>; Kuldeep Singh <kuldeep.singh@nxp.com>
> Subject: [PATCH v3 2/2] arm64: dts: lx2160a: add device tree for lx2162aq=
ds
> board
>=20
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
>=20
> Add device tree support for LX2162AQDS board.
> LX2162A has same die as of LX2160A with different packaging.
>=20
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts | 334
> ++++++++++++++++++++++
>  2 files changed, 335 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile
> b/arch/arm64/boot/dts/freescale/Makefile
> index 903c0eb..0edc8ab 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -27,6 +27,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-
> clearfog-cx.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-honeycomb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2162a-qds.dtb
>=20
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-beacon-kit.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-evk.dtb diff --git
> a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> new file mode 100644
> index 0000000..b29174e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT) // // Device Tree file for
> +LX2162AQDS // // Copyright 2020 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +	model =3D "NXP Layerscape LX2162AQDS";
> +	compatible =3D "nxp,lx2162a-qds", "fsl,lx2160a";
> +
> +	aliases {
> +		crypto =3D &crypto;
> +		serial0 =3D &uart0;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	sb_3v3: regulator-sb3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "LTM4619-3.3VSB";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +	};
> +
> +	mdio-mux-1 {
> +		compatible =3D "mdio-mux-multiplexer";
> +		mux-controls =3D <&mux 0>;
> +		mdio-parent-bus =3D <&emdio1>;
> +		#address-cells=3D<1>;
> +		#size-cells =3D <0>;
> +
> +		mdio@0 { /* On-board RTL8211F PHY #1 RGMII1 */
> +			reg =3D <0x00>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			rgmii_phy1: ethernet-phy@1 {
> +				compatible =3D "ethernet-phy-id001c.c916";
> +				reg =3D <0x1>;
> +				eee-broken-1000t;
> +			};
> +		};
> +
> +		mdio@8 { /* On-board RTL8211F PHY #2 RGMII2 */
> +			reg =3D <0x8>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			rgmii_phy2: ethernet-phy@2 {
> +				compatible =3D "ethernet-phy-id001c.c916";
> +				reg =3D <0x2>;
> +				eee-broken-1000t;
> +			};
> +		};
> +
> +		mdio@18 { /* Slot #1 */
> +			reg =3D <0x18>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@19 { /* Slot #2 */
> +			reg =3D <0x19>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@1a { /* Slot #3 */
> +			reg =3D <0x1a>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@1b { /* Slot #4 */
> +			reg =3D <0x1b>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@1c { /* Slot #5 */
> +			reg =3D <0x1c>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@1d { /* Slot #6 */
> +			reg =3D <0x1d>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@1e { /* Slot #7 */
> +			reg =3D <0x1e>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@1f { /* Slot #8 */
> +			reg =3D <0x1f>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +	};
> +
> +	mdio-mux-2 {
> +		compatible =3D "mdio-mux-multiplexer";
> +		mux-controls =3D <&mux 1>;
> +		mdio-parent-bus =3D <&emdio2>;
> +		#address-cells=3D<1>;
> +		#size-cells =3D <0>;
> +
> +		mdio@0 { /* Slot #1 (secondary EMI) */
> +			reg =3D <0x00>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@1 { /* Slot #2 (secondary EMI) */
> +			reg =3D <0x01>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@2 { /* Slot #3 (secondary EMI) */
> +			reg =3D <0x02>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@3 { /* Slot #4 (secondary EMI) */
> +			reg =3D <0x03>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@4 { /* Slot #5 (secondary EMI) */
> +			reg =3D <0x04>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@5 { /* Slot #6 (secondary EMI) */
> +			reg =3D <0x05>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@6 { /* Slot #7 (secondary EMI) */
> +			reg =3D <0x06>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +
> +		mdio@7 { /* Slot #8 (secondary EMI) */
> +			reg =3D <0x07>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +		};
> +	};
> +};
> +
> +&crypto {
> +	status =3D "okay";
> +};
> +
> +&dpmac17 {
> +	phy-handle =3D <&rgmii_phy1>;
> +	phy-connection-type =3D "rgmii-id";
> +};
> +
> +&dpmac18 {
> +	phy-handle =3D <&rgmii_phy2>;
> +	phy-connection-type =3D "rgmii-id";
> +};
> +
> +&dspi0 {
> +	status =3D "okay";
> +
> +	dflash0: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +	};
> +};
> +
> +&dspi1 {
> +	status =3D "okay";
> +
> +	dflash1: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +	};
> +};
> +
> +&dspi2 {
> +	status =3D "okay";
> +
> +	dflash2: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <1000000>;
> +	};
> +};
> +
> +&emdio1 {
> +	status =3D "okay";
> +};
> +
> +&emdio2 {
> +	status =3D "okay";
> +};
> +
> +&esdhc0 {
> +	status =3D "okay";
> +};
> +
> +&esdhc1 {
> +	status =3D "okay";
> +};
> +
> +&fspi {
> +	status =3D "okay";
> +
> +	mt35xu512aba0: flash@0 {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		compatible =3D "jedec,spi-nor";
> +		m25p,fast-read;
> +		spi-max-frequency =3D <50000000>;
> +		reg =3D <0>;
> +		spi-rx-bus-width =3D <8>;
> +		spi-tx-bus-width =3D <8>;
> +	};
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	fpga@66 {
> +		compatible =3D "fsl,lx2160aqds-fpga", "fsl,fpga-qixis-i2c",
> +			     "simple-mfd";
> +		reg =3D <0x66>;
> +
> +		mux: mux-controller {
> +			compatible =3D "reg-mux";
> +			#mux-control-cells =3D <1>;
> +			mux-reg-masks =3D <0x54 0xf8>, /* 0: reg 0x54, bits 7:3
> */
> +					<0x54 0x07>; /* 1: reg 0x54, bit 2:0 */
> +		};
> +	};
> +
> +	i2c-mux@77 {
> +		compatible =3D "nxp,pca9547";
> +		reg =3D <0x77>;
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		i2c@2 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x2>;
> +
> +			power-monitor@40 {
> +				compatible =3D "ti,ina220";
> +				reg =3D <0x40>;
> +				shunt-resistor =3D <500>;
> +			};
> +
> +			power-monitor@41 {
> +				compatible =3D "ti,ina220";
> +				reg =3D <0x41>;
> +				shunt-resistor =3D <1000>;
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +			reg =3D <0x3>;
> +
> +			temperature-sensor@4c {
> +				compatible =3D "nxp,sa56004";
> +				reg =3D <0x4c>;
> +				vcc-supply =3D <&sb_3v3>;
> +			};
> +
> +			rtc@51 {
> +				compatible =3D "nxp,pcf2129";
> +				reg =3D <0x51>;
> +			};
> +		};
> +	};
> +};
> +
> +&sata0 {
> +	status =3D "okay";
> +};
> +
> +&sata1 {
> +	status =3D "okay";
> +};
> +
> +&sata2 {
> +	status =3D "okay";
> +};
> +
> +&sata3 {
> +	status =3D "okay";
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	status =3D "okay";
> +};
> +
> +&usb0 {
> +	status =3D "okay";
> +};
> --
> 2.7.4

