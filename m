Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2387B27B29B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1Qyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 12:54:39 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:14161
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbgI1Qyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 12:54:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/aQzX6WJ265Ab8HehXp9SQo8Z34wDSZy2Pb7S330rpLXL8LG26um9asFzlgOva9fF9rq17NoeE/WgdA842ledqNBve39N+uXVXhLXbiOA96FWNI43r3LOvIGUEW3z4PhVa7vxw6B3Zc3m2O7kRFcWHUcSMX7a+0pZ8YDPbBiG1m7VoAjOWsFSS+05w+eX1fzgFazHAn6V7kN5/ieYUdc9E+5+vnrBbqepg/j1cDP5IrPgh1gYf7VhhP7XvQ8WYW4tPhdYtHtB3yoeaQu3LPEf+p987C9ZUnRKQ/yJT3eX48NzqeLM9qo5jVzjmWRzVsfu9PgK53gJWz8g6zTQDtvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj0qWj+Y79e6Iy+lFmgp2VWfCTWHpxyJWNQ7TSqHuik=;
 b=FSIQX0X6sNEMe5cPpFfdC25bGMlfQ4gBftcO/Hlu0E+olARNYYsBlLeeOyfVhHfEMaHvR1EV21M+LTpxKErVM7Oh2xUWeRlkwCNNEZTkQE/iCvSGF6qAHG3NM9RPwOeF6UXVX3+6nWskd40gMJl8fifeHef5pU3sD8G+/ZSgQXnS3YSFtrCKjaVWLNUKq8KirtX9iQlE0KTdJYWk40Y0ETe8MUcmxi2wbiCSuMgwsaDts4M1bjAdDKKKEMt7fubasSkNtxxPUowLKjmiCbUSxIBiHDWqBUDVn7qos6MrGQQFQvTUfZcOA+JZTeTkWjcn7N2f2ibqL5DW9znr6OM0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj0qWj+Y79e6Iy+lFmgp2VWfCTWHpxyJWNQ7TSqHuik=;
 b=cKubuqs+eq+8ipn78X0znGnt/GzIKV2YDbAcyBwXhqrAD1/UKgoVjbefaTrywMXUwJfyP+P1U9pxX2hBPhr7mNdmP6Eg5EnNe1Kvs5EBK70A4cCX5ujJuPydZylj5shq62KAgYXTBDzv7LMEjzGgWymVhzskEavccC0azZAD2r4=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VE1PR04MB7389.eurprd04.prod.outlook.com (2603:10a6:800:1b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Mon, 28 Sep
 2020 16:54:35 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::8db9:c62f:dac5:ee3d]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::8db9:c62f:dac5:ee3d%3]) with mapi id 15.20.3412.028; Mon, 28 Sep 2020
 16:54:35 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Ran Wang <ran.wang_1@nxp.com>, Shawn Guo <shawnguo@kernel.org>
CC:     "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>
Subject: RE: [PATCH] arm64: dts: fix endianness of rcpm
Thread-Topic: [PATCH] arm64: dts: fix endianness of rcpm
Thread-Index: AQHWlXeg5OEh8vaZ40O3/VsyacaGZal+RO5g
Date:   Mon, 28 Sep 2020 16:54:35 +0000
Message-ID: <VE1PR04MB6687E9A0F4E7E55E4ABFC1418F350@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20200928090455.34364-1-ran.wang_1@nxp.com>
In-Reply-To: <20200928090455.34364-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.234.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0cca13db-5f92-4cc9-7a53-08d863cf2e28
x-ms-traffictypediagnostic: VE1PR04MB7389:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VE1PR04MB7389F8B12B35394C795D2B8B8F350@VE1PR04MB7389.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U45ZUNqj9VKQ46ReGTEPaXqrchvr3Nz8oAhjpwjglt31brKKfz+AuF7T8Y8GNvIFuKY8Wws3MPF6k8zcrqZLfz4GWCyWqiicutV5XUEnKFZNoKgq/vRKkjIOBOcRWa/s1cbIEuY9e+PkcpucZgO8nfyiq+qxhXsz3Jf7h+YsOknbogN9PkZfYRvPX+xOIu3sTvIpJL/aXLtEaaAmD/OnLMVXcMSJ7HbF0Isulgqz1+TJQDAQJohKVsl+AUWBg88PNtR5SfWuBmHUyqbp3fIUE2tDkxOxvuuH3n//r2GlxBGcdCDMWtAppiCwL1SxS0+tUWElCGaM3zKLuBI2JgphPRy1n12RxFTqUOuum9qpZU4M+sHvkp7I8zNNq9uZn7/E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39850400004)(136003)(396003)(53546011)(6506007)(2906002)(478600001)(186003)(26005)(9686003)(55016002)(8936002)(8676002)(5660300002)(4326008)(7696005)(33656002)(83380400001)(66446008)(66556008)(66946007)(66476007)(64756008)(76116006)(71200400001)(52536014)(54906003)(86362001)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aDtD8OyMv64SeKQ7OmXeTv/al9A4PW+nNJJhDLLL57OpNXVzHgNEym6i9X3ZW4PxWfKrNj6VmDPxp7TJsUMnogr1gVH9XtlthWGjtXRDKkIL5Z1oZn9FAEYjLABDaDKHboNZpngGoU2A0sNJ/yPeDJUawxBxOcaxCNsIple+C5m7Eo14f9nJsmI6xy3iP4W8Xqg9A2KsMeNPLzkt3bBPw7xcTx/nS55ZQbq9G7dAR6X81Pr6BCoxqPfnkkxDko5qM3pkw3+Y1LRxsEtK5eWsbRh6bmC6TLDK+57EW/4OjR8uQDkREXzMARRGp25lRswDvnJN5gzeZwmYKtVJ9Kv3OeYHCxUo9Boq4mOjGVyI1XRi/zgQzsuufiCM7VL/0RS+dgsR6IM7lvTqp7eLMWbCqZZC3NxMMFXt2dS1mrd+h1xYKLMTus5CKM/fKfG5fikFKYRgvvsOLJjz2VpkXc/ma7pO1TvL/9og+RVIN/gYn3jlln5UtKBBkbOCLBnza5hLj7lXMbBg4JlCJZC4GcUqx6yFiK+XbUdz6nbnvjAdnGNulkkP87yy0BHAvemApuoc4obgmprSG8Lv1CWn+Ats7IU+1s5pAkui0K36uCn3N2cNWWUFxpdBZU2Uj37Yj2vUiZ1vUch5YqEGbIlmUATeJg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cca13db-5f92-4cc9-7a53-08d863cf2e28
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 16:54:35.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9RJ+Bgv5Ja/v03ja6yObhDluVzR0R0pTqC6HazIDxAKk2/sCrjMYGBR1FMk8hmY3iDnH1TQOClxY/LIw8azeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7389
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ran Wang <ran.wang_1@nxp.com>
> Sent: Monday, September 28, 2020 4:05 AM
> To: Shawn Guo <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>
> Cc: moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE <linux-
> arm-kernel@lists.infradead.org>; open list:OPEN FIRMWARE AND
> FLATTENED DEVICE TREE BINDINGS <devicetree@vger.kernel.org>; open list
> <linux-kernel@vger.kernel.org>; Biwen Li <biwen.li@nxp.com>
> Subject: [PATCH] arm64: dts: fix endianness of rcpm
>=20
> From: Biwen Li <biwen.li@nxp.com>
>=20
> Add little-endian property of rcpm for ls1028a,ls1088a,ls208xa
>=20
> Signed-off-by: Biwen Li <biwen.li@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
> arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
> arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 0efeb8f..651bfe1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -1012,6 +1012,7 @@
>  			compatible =3D "fsl,ls1028a-rcpm", "fsl,qoriq-rcpm-
> 2.1+";
>  			reg =3D <0x0 0x1e34040 0x0 0x1c>;
>  			#fsl,rcpm-wakeup-cells =3D <7>;
> +			little-endian;
>  		};
>=20
>  		ftm_alarm0: timer@2800000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 169f474..2ef812d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -787,6 +787,7 @@
>  			compatible =3D "fsl,ls1088a-rcpm", "fsl,qoriq-rcpm-
> 2.1+";
>  			reg =3D <0x0 0x1e34040 0x0 0x18>;
>  			#fsl,rcpm-wakeup-cells =3D <6>;
> +			little-endian;
>  		};
>=20
>  		ftm_alarm0: timer@2800000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index 41102da..141b3d2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -769,6 +769,7 @@
>  			compatible =3D "fsl,ls208xa-rcpm", "fsl,qoriq-rcpm-
> 2.1+";
>  			reg =3D <0x0 0x1e34040 0x0 0x18>;
>  			#fsl,rcpm-wakeup-cells =3D <6>;
> +			little-endian;
>  		};
>=20
>  		ftm_alarm0: timer@2800000 {
> --
> 2.7.4

