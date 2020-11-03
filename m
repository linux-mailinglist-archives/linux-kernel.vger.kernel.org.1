Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53262A3820
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 02:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgKCBDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 20:03:48 -0500
Received: from mail-db8eur05on2045.outbound.protection.outlook.com ([40.107.20.45]:39649
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbgKCBDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 20:03:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdITAwEr9Vsvypm/Rk/VSlRsYvCR6h2PbVxbWFnn2oF/nlJGfl0omSAbLS2aFrCS0McDJNnNQW4RlzN2vFw9tyAPn3+q2lYV5csueAp4nj7mKoE7jfWA3FDxH4ebdehLW1nnertAklEjQPnXlg43ZwQ5/0N+O/wZOBPxveY6gEAVQheh+MwnmG33NNYbQ2OVkcs7y/rWqSJ7H/UcUqeM+xiUHbMhw9k57lSAeKOLP+mPbZivoTqQNz2PuAUMUXRvNxqEnlemGgO308uLwRhOGk3lnUp7JumvSthf9jV6khvKgLJYGkBy9fbzhmaX1Qoi8D7NJME0gug7ACIEyOcw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeLzhONcDob/FeFy5YAYk55HvUNFyNaueFeSkbvndF0=;
 b=YmsHUtumKHyPc42NODnQYNl0R3FO+XsroWLcBUP52VN4nd5zotuSlBdDfqRxiLJYnSfwq3Ajz7SlV+431nPc/m+wn5a8FOa9MTlPrZGk9H/NglL6o5SZ/mK/Ndc0UzWPGUjWTPCcAqcYVFR32GlR1PciwR2TWmiMIiKQO4eMN/kAUxWhbyIcdmhYd+U2PwAbh9+HUWIZhf9k9iGejPyS8+wvB+HF2BI4qpBtKflnAREt4jsraGJHtJMPKhBGGFWgZxxHIhZZDqcP4zmVbxI8okyGS5CT4eUqW4zZyXTO3hgDJne9Dp1dxuaVNGELlcJeFKQc5znZe0wswT8wNx9OPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeLzhONcDob/FeFy5YAYk55HvUNFyNaueFeSkbvndF0=;
 b=BxVhddddfdu/H8uL5QmW/KS3pPkLneFxwmLKhavYwdmqGegmw7Lv1oGiwUP17sSgU33WIGOSvJXW5xN6wuGqnrtcy0W7VdrjEd+3VGIbZVAXvS0cC/bFVQJ4XP5oO9ivCtYvvGcLn9WsFrB0Oqk31Lwb+Tj0J9TqolxXkzy5C6o=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR04MB3125.eurprd04.prod.outlook.com (2603:10a6:6:11::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 3 Nov
 2020 01:03:44 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 01:03:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V3] clk: imx8m: fix bus critical clk registration
Thread-Topic: [PATCH V3] clk: imx8m: fix bus critical clk registration
Thread-Index: AQHWsEJPSa9ZZa+Apk613nP3qyZAk6m1ifiAgAAPrCA=
Date:   Tue, 3 Nov 2020 01:03:44 +0000
Message-ID: <DB6PR0402MB2760920568B1FC6A9F993EFB88110@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1604229834-25594-1-git-send-email-peng.fan@nxp.com>
 <20201103000657.GA31601@dragon>
In-Reply-To: <20201103000657.GA31601@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c53d453f-db70-482f-b398-08d87f944fbb
x-ms-traffictypediagnostic: DB6PR04MB3125:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB312544E8F662C8765AA1226F88110@DB6PR04MB3125.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YXHHFHiTs937blgJtqzLUvb8O1l6zY9YWGPhMtT4kZCq+Rji6p8q2AiXenSzT22ERzINvUubGXmYw5WvEAioMPCagtnixUtlja5LXbDCfFeIKBQ+df12wZeUbYvZBjzop2+EceOed8/I+oWO4rXCR8sJJyUgNTpbLU2AJCphEtVbVI1cW7ZySYfRaMgZQMf5/hxp8yvdBdb/3RviaP/NQLv1bHUITCyzGbTx5ly/2Xj8Y3ztWbHRGFB/JM1rlxFnASb8siQew8JU84zxj7vNdWCol/rrZQXBwnOH5xEeLoKGwcVLXEGT32wUElyfDMzBwOxcUffa8ix3sqTw4SIhCpODkDcmmaf6lHJDMavOQPyBgP+M02FvKaJu0PtzGlH6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(4744005)(52536014)(7696005)(26005)(478600001)(6916009)(9686003)(316002)(8936002)(83380400001)(6506007)(54906003)(71200400001)(66556008)(5660300002)(86362001)(66476007)(55016002)(64756008)(76116006)(66446008)(8676002)(186003)(66946007)(44832011)(4326008)(2906002)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MG4bIJiaUJzQ9OTJmFMAIptxzjCYLjGcO29zCTwLXagX+nwphbpM4I0FhxKEONsS2v57pqXRVDVfKiPTgVYn7wGQZyDQOMr2lcss8FMUp/Dz+om9Yeyz4xlng8GQk/g3xLgADn+gKfvZ0aHAXcP1eh+i77XbBoVECW2u/5VsSIEij4bu3Q/+zZL+hxJrEJaMJXi8p6PshKPv8MrTeIafL0seLHhXbnDVvub5XwoE2IovCB2tGPrpu43HK7BNqVAPVkfEjgLg1S6I+SZy9f8MKyH7uMaQXTxmHgY/hdScuqA43xHMgan10P+HuXbvxQzv7pu1W/APulwgjVQ5L8S2wPj4fYBXXc3LBkBNyrWodqVSu6S5iLjAM9AIpwMO/UhzzwNWZ1dxsBBQZLYPG7U2zS8cecez6WMapZ78GwpWCnLdvXIXFcDMKk3yOkLqf0+0FAZVx4z5NQ2gadLtobBo1STElANOAdDDbGnoBqvZRk/bs38KAGq/HhxdemNEqTgCLtZuUa1LwXOQ7mtGp9Qf9D3olIN28cLbzcAyyZwCAJgO55/MmCNzwf0BHeMPsdET7CHD9mpw7pMAjoFEzaDAET3W0xt7uJZdrKbFkArTUdaHhsBMKSfnEippBdB8OypmBfFuBU9VWbYfO73XFbhPAw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c53d453f-db70-482f-b398-08d87f944fbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 01:03:44.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flwLUlnCRzol1/y46O2RgasJEdM88QJAZIO+einoBrB8tsUIINT77vA5FxafEMI+TQkupV9XvgYLJ2FYdQvk1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3125
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shawn,

> Subject: Re: [PATCH V3] clk: imx8m: fix bus critical clk registration
>=20
> On Sun, Nov 01, 2020 at 07:23:54PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > noc/axi/ahb are bus clk, not peripheral clk.
> > Since peripheral clk has a limitation that for peripheral clock slice,
> > IP clock slices must be stopped to change the clock source.
> >
> > However if the bus clk is marked as critical clk peripheral, the
> > assigned clock parent operation will fail.
> >
> > So we added CLK_SET_PARENT_GATE flag to avoid glitch.
> >
> > And add imx8m_clk_hw_composite_bus_critical for bus critical clock
> > usage
> >
> > Fixes: 936c383673b9e ("clk: imx: fix composite peripheral flags")
> > Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> > Reported-by: Abel Vesa <abel.vesa@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
>=20
> Do you want this be picked up as a fix for 5.10-rc or non-critical stuff =
for
> -next?

Please take this as a fix for 5.10-rc.

Thanks,
Peng.

>=20
> Shawn
