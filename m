Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB553289D66
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 04:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgJJCK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 22:10:56 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:30894
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbgJJB5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:57:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMrmQJDSBaExhQmud0gxBcxw6zp/ieyJ5RFn63nPd/GbS0ftNL7RGJzHriSPU627as2h9zZbeJsYm9tyenfjnMk/qOmtiL/XzCiuR2KIVcgxGZRHMVZXNk/xaT1FngTJA/OREWlYGvISzOILjtA3WPVdxAE1E29S124lBT4anU8e/K3tTc/3OMxu1E1Xui/GhsPsvEGzHOHixjdv3LTVnp6Gz1lilFb/G0Ln2arMkWfq2CiPUao7y7TIgxrZwbft4UhTog1M8yy/OCLw+zMUDDlVkQI2amYHx5onx7+B48jSzpkxavVna17AeaisJkzNCrhc2mzankiN0jX6S9AeJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9ZZKBAjLSgLCGu6nSzJAehkzb2h9tX98IkBiB4lvR0=;
 b=Dk1R6FdkqKXiT2kF5epP0No1nqE4NUl5+wLiyS0hGJW0WyA76USJU1pZpwYyN9sxIOSddkCfDNZ0zC0CYCgKNYUQsJGZTRjX47HE0LK6Som8bezA4F7SS0CXjNJ1kCVKblPlG6Mp2G5EZkX4cz2qOnJcE/PBhw8mIho+L14sz3ky4fCuXTb+8UfUyp49/BJF6la9L/s87kCzu5EQx8uMbkWlRIvlRp2MIe+Drp0tcDTTp8w82vftNRYwisvdv9KA4YmpVWhKleAVn2obTmrMBEViRyCJzmKd3mYQv4OHaFWbvtZEDNnP4DDxPuiXzGSsE1nbLn+Z68ODRWB+PZJU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9ZZKBAjLSgLCGu6nSzJAehkzb2h9tX98IkBiB4lvR0=;
 b=ErMqVof9VC/NoW459tM6wAaOfOIanvt9cmE4XW8kLqzDaeDE4mU39pwUXeHkabO5kesqiS+iXWGFugQMimT5Pr7wBK9MGWFBF+x7DKlf+xU35sJF8oGGSN9I22L6AfDBZBOVb/i8jFqSqZBBUQyKwAYGR6dvK5tNzom7qcNoQ3s=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB4965.eurprd04.prod.outlook.com (2603:10a6:20b:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Sat, 10 Oct
 2020 01:57:00 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::1953:c81a:cca2:60ec]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::1953:c81a:cca2:60ec%7]) with mapi id 15.20.3455.024; Sat, 10 Oct 2020
 01:57:00 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biwen Li <biwen.li@nxp.com>, Ran Wang <ran.wang_1@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH v3 1/5] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr1-alt-reg' property
Thread-Topic: [PATCH v3 1/5] Documentation: dt: binding: fsl: Add
 'fsl,ippdexpcr1-alt-reg' property
Thread-Index: AQHWljrqSTvZaBY98UGNWSX3I/ZV+KmQJBKA
Date:   Sat, 10 Oct 2020 01:57:00 +0000
Message-ID: <AM6PR04MB54130FE1CC9B6A4C8DF2D538F1090@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20200929082234.36619-1-ran.wang_1@nxp.com>
In-Reply-To: <20200929082234.36619-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ffc9f5f-7d72-4258-fb8d-08d86cbfc705
x-ms-traffictypediagnostic: AM6PR04MB4965:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4965ABC209C31B861089608CF1090@AM6PR04MB4965.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMTlQjG5DLlj/Z0op+fNPbkiz08/Ky/Yq32mvILQcCHwzN6iWHdpnUuFPXa3Lt0OWtsRB2swc+H9eAK6Kj4JqDV3SV2AryFdHDv/taLJyWIkDX7oKutV9NmcxzaMm198SIryXlWbHjPIbZg9TxyOpNCap6WU1d6TpHaZrEQRl3Vu/iKNR6uYV4mKIz9LZUwZcivH3OPT05t+CgiU3Jdoth6K8q5iPDR0QsfGhFRXoIEso6t4bWGS3kdzGLFQEx9qHh5UC+zSqk1udjVNKcbmtsAYji513e08Wtip+A2rSwOb1e3iAobUIBSrZe7gRqtthx/F85EJ2xmIAwx9fOs9NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(396003)(136003)(8936002)(66946007)(6506007)(64756008)(53546011)(76116006)(186003)(54906003)(4326008)(66556008)(316002)(66476007)(71200400001)(86362001)(55016002)(478600001)(26005)(66446008)(7696005)(33656002)(5660300002)(52536014)(83380400001)(2906002)(8676002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vkveVCP1PSVYbKvOFOeEfb+folAydrkLkOEGEhGBO7gdrwT/2kyw3WTzEB49aamjvWlSlmZdywmYr94AbWzyKyVEeMnUHIa/G6hpGLETKeq2hvxEN4MTvZggEjmFiRMczbJHkK7/uyD/9FSuFpql2I5Cn7P+HXnwl9PiU3pWQiVGVqDeqvCWvej/JHrTs/nZe4yyO4UDuzAp7NYRgQz01qbtTXZW+FP+tsyHXFEhJ5hI0XhU0K+FpRARpanRXvXeBr1Z6/d6fRk5NOUNYXPf9mi7fwMuRjf38LeKNONXqcbK/CW4gAb644LDYtHcE6xCCNn9lyGKbTl9/V14Az9j0jVQ+Phie6ILpzNGqCl3CIt+w+mO5QEy1eYfajL3STSg/t3wfNU9R8Y+20RR5r7QyKU7viWk9yrUmGaY45Vsapp+2p88FgOKvHoRJepENc+sK46I/oedSjhKounp7VUHEQEkluUwXAKYXorA+KWGeD/B0IlFJgnc2apAOjtW9tix0Pv6DeypJQX6KRLIS6oM+/6cM+bzAxlG9e5xikF3bHdtCKsBqZKgcHViPZUZv84D0LTfvnqmFIzbmq2kx+HQ0dr0iafSt+PjqDgQf5b0Xu4c2BLlmuRajaGiG9ea3T4oHAmmUSHnpXZ5TGmRL4fyKA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffc9f5f-7d72-4258-fb8d-08d86cbfc705
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2020 01:57:00.5717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0UnVgVCXoVdaJe+62QQYjbklA8r57LwLb2tKvpsxcW981SjHZg50IyaPYmSjMo+o7tOKyyF96lN/jR5zIwf6Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4965
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tuesday, September 29, 2020 4:23 PM, Ran Wang wrote:
>=20
> From: Biwen Li <biwen.li@nxp.com>
>=20
> The 'fsl,ippdexpcr1-alt-reg' property is used to handle an errata A-00864=
6 on
> LS1021A.
>=20
> Signed-off-by: Biwen Li <biwen.li@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Change in v3:
>  - Simplize related proterty definition and rename it.

Could you please comment for this version? Thanks in advance.

Regards,
Ran

> Change in v2:
>  - None
>=20
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> index 5a33619..62a22fc 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/rcpm.txt
> @@ -34,6 +34,9 @@ Chassis Version		Example Chips
>  Optional properties:
>   - little-endian : RCPM register block is Little Endian. Without it RCPM
>     will be Big Endian (default case).
> + - fsl,ippdexpcr1-alt-reg : The property is trying to workaround a
> +   hardware issue (found on SoC LS1021A only), if pressent, RCPM driver
> +   will use SCFG_SPARECR8 as a shadow register for RCPM_IPPDEXPCR1.
>=20
>  Example:
>  The RCPM node for T4240:
> @@ -43,6 +46,15 @@ The RCPM node for T4240:
>  		#fsl,rcpm-wakeup-cells =3D <2>;
>  	};
>=20
> +The RCPM node for LS1021A:
> +	rcpm: rcpm@1ee2140 {
> +		compatible =3D "fsl,ls1021a-rcpm", "fsl,qoriq-rcpm-2.1+";
> +		reg =3D <0x0 0x1ee2140 0x0 0x8>;
> +		#fsl,rcpm-wakeup-cells =3D <2>;
> +		fsl,ippdexpcr1-alt-reg;
> +	};
> +
> +
>  * Freescale RCPM Wakeup Source Device Tree Bindings
>  -------------------------------------------
>  Required fsl,rcpm-wakeup property should be added to a device node if th=
e
> device
> --
> 2.7.4

