Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11BF2B570E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgKQCr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:47:57 -0500
Received: from mail-am6eur05on2060.outbound.protection.outlook.com ([40.107.22.60]:27571
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgKQCr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:47:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSBXuYwsV1I4ptcvbZK6HmSt33Bdp6nF9yZukPdT/eYoUGzTPzJpYFsZaug/BRR2IbERZvQJnsrubtHubMPeEx6ZDevcxNdjxAfn+DeBdVkalvuCe3EZGMbx9I0awspIFBPqyUZGtM5Tgc2wf+m9dzXuawPh5P9YKRssaA6VZVhaaBq28HLBBwcTIYcu4H3glMpFNcQonubKC3LUfKus+F94+fsNKqffVESuk9fvWzcgzdZrkfII7DvktGgK8m8wPJL4Tb4gDeNsz6MZw/rUwFXZqQ9nOSO89XW9xcY+44sJ7HIkprlylsFmUj97Ovsg+gujwTpkF223dffL+I6ZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkvbaNwOHDfcil9VdvsKJSK2no7rLIYjjPRkPF2sV3w=;
 b=BGIqFDMFyXhm9p6t+hTNpEw5RtIArXBL4VMLWLxRDA8Rv/kIU9rmWDl4Dev2vRfF8I8ulV4/fd7EF8BpKxqSUw4TVzcyAxoG9YVeYHY/OY0XRKSyEEESvqWl9VpqlAcDNa247Zqqd2MqH18JuP+kb9M2DYhIMJzCLoLVQfbRhFfyOymPHzaQElHTcgPpZJfs4I20PDlJdLKJV4yycAsKcT/1OQMaLYrtMtSqcU6kekNRRX0rDSzXcPqmMYbSJ9iEzs34blws/HlNIW01bW8PrMWjdzLWcGVhwKFjagX2b7CuDN4C8ot9OpyRD5hrFp/GS60Oh3myh9438SBGn1OSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkvbaNwOHDfcil9VdvsKJSK2no7rLIYjjPRkPF2sV3w=;
 b=cfAl9Pveduq5cucMg3dJLnZIeJyI5dej97DLF+BBABcabPoEpSuXe8q8yhq2DCXhEt9i8IkJHlQVWe6T/PNjaracfsq2jumFc5ykXYvK/mEa1chcSctKHG5qsJFYJ8HluLijiTyzNtDMIaEMMnnkEBVFEU+Cr2hRW8qbUOEccSI=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 02:47:53 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 02:47:53 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: RE: [RFC 0/4] clk: imx: Register the dram_apb and dram_alt as
 read-only 
Thread-Topic: [RFC 0/4] clk: imx: Register the dram_apb and dram_alt as
 read-only 
Thread-Index: AQHWp9DHtYlAfQ1tB0iCCzMj1hVKEqnLyEvw
Date:   Tue, 17 Nov 2020 02:47:53 +0000
Message-ID: <DB6PR0402MB276070853555160D0AB5641C88E20@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1603301815-24670-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1603301815-24670-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a1a3dc0-d3d8-4104-763c-08d88aa32e53
x-ms-traffictypediagnostic: DBBPR04MB7817:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB7817D3D4802CF3DEC419E83788E20@DBBPR04MB7817.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaH7EZHSVtPjLnU1xLkCRcIRUekkIuuCfFCbmdBgYh+zI7XE6hJ7PKhIxHwEAZmhybGDAmk1JVQK71EPQzsPsOt+X85mzfAcatWo2wcreBUr2mpv1NYiQLqQ9QdMY7N72U/b+tS7Uw9IB068n60PEZlRxRWbRvhbSndpZyYxhVCkt0r1+d+L8r5qhKSf/4bRdB7ajN9ErxoEBRJao98iYwMjXtU9uqsP2i/ci59BIKwHUu5qvLoKviEeWa3d4HaD1lQ/NL1AP/ri3CeO2YBUK5qwZRGfSzuAnX5kV3zY5kTzItqlqUPlMocu1u+dpHRlY4cdiBsO67USqdg4XUwv5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(83380400001)(44832011)(52536014)(8676002)(8936002)(55016002)(6636002)(4326008)(9686003)(33656002)(110136005)(478600001)(186003)(6506007)(4743002)(64756008)(66556008)(66946007)(66446008)(66476007)(316002)(26005)(2906002)(54906003)(7696005)(5660300002)(86362001)(71200400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: CFV02B4yyRtZ+HRBJfRU4jVHceJYY8NTsxGB24QhayfYCLKPmhoHqhBDwFIpPTgOqOnPLPJnOVpvH8uj3ZlcU/w+vMGKFpUl4ujy7lKfLSBPfrBAn3O7mE7xSxWE78iyrjn3wpuqdi7O30DGNH1KOZb/VFIg5cM34pOvCj46Ncqm+lsFabzTWQ95Kus0+eb9MMYgBUOMSjLZFAJPxPYVo/IO0SJE3QDy1C2jz3MR50mX8g7/UnmXe2QxK0YsF9aKzomqRisS0NPm4j4vTQ9sBkcj37a3+11IDPP7qAs3LNmfJ+Q+j2kktUjn7xg+YB8QGIkfAK6jH+bMpmlt9/G5VK9UC2b41GaJVvwIg3/iOpN9a066nmkRQgZPmue3uoNxBkHIPorGB4rOc5bklT6dSY+D8qlgrCE6aaOYaCSPtai52xPt2TEfORF2QlgRfGHPtPPaXrUAF2IT2gvEqmfi3MC3E2ob+d5SxYtB4u4Zzvq5taVXD/tsqTTVvwfo8PmiL+y8/+80zQ4fWSzygKujzYxQimZWOXS8X1R5Ng2YXeL71kdU5EHjwQPkfWXHWZLgqf6Z1H9x3lC8KnprLM2HDSwQuBa/mHW9f16i5DtX/bHhqrbIkKRIXJq5G0Fr2hUkzKuxIjHDgtU8aPZqs8zjgw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1a3dc0-d3d8-4104-763c-08d88aa32e53
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 02:47:53.3029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQv8C4PdrdC5EZ1MHFoiOgJyyxgbWhdmk8fCzww/lN9f+lQsFb1FihD9NxpVIYVjaZPneNietRWJHS0ek5kv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [RFC 0/4] clk: imx: Register the dram_apb and dram_alt as read-o=
nly

Any follow up about this patchset?

Regards,
Peng.

>=20
> On i.MX8M platforms the dram_apb and dram_alt are controlled from EL3.
> So in order to keep track of the actual clock tree in kernel, we need to
> actually declare the clocks but never write to any of their registes.
> We do that by registering the clocks with only the ops that read but neve=
r
> write the registers.
>=20
> Abel Vesa (4):
>   clk: Add CLK_GET_PARENT_NOCACHE flag
>   clk: Add clk_gate_ro_ops for read-only gate clocks
>   clk: imx: composite-8m: Add DRAM clock registration variant
>   clk: imx8m: Use dram variant registration for dram clocks
>=20
>  drivers/clk/clk-gate.c             |  5 +++++
>  drivers/clk/clk.c                  | 31 +++++++++++++++++--------------
>  drivers/clk/imx/clk-composite-8m.c | 12 +++++++++++-
>  drivers/clk/imx/clk-imx8mm.c       |  4 ++--
>  drivers/clk/imx/clk-imx8mn.c       |  4 ++--
>  drivers/clk/imx/clk-imx8mp.c       |  4 ++--
>  drivers/clk/imx/clk-imx8mq.c       |  4 ++--
>  drivers/clk/imx/clk.h              |  7 +++++++
>  include/linux/clk-provider.h       |  2 ++
>  9 files changed, 50 insertions(+), 23 deletions(-)
>=20
> --
> 2.7.4

