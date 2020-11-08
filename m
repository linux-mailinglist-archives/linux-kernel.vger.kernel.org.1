Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE10E2AADAA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 22:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgKHVVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 16:21:47 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:65088
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727910AbgKHVVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 16:21:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlpG/hzmMvT0mnI//ZlZ2V4q7W88QH8az508aaPTF3Bxp8JmEyTPJ38iN5E+o0ObQFX5aWIIx2tpPpxaPBDsG9iJClPfdobGHhOOqzbiEj26EiCjhNkuq0r/K19MXstgb81JSOur8kfk9f1R+w9VaZS76B/XjbiTyOEOh0l3069rSo1yekBYsRpn6fo1p37ayKkA4IsZbIQ0p0Z09kT3dnYSFbzhz0UuN30CtG/UetfXc8359CJTGRfpKA5BeDoqLJPqs2vpOct2LcI+xq8+0mYm8YcbEGCcm8QblbQJhFDZFjIc94Az8+rDWaKFS4USePhyTe0oVUQNPT7WlOVIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9kDwjD4nJ6zI/8fcCB1CYCEIVBvXaQzXrHHJCAIxE0=;
 b=d7i16izuT8fH4lmV5oct7iymmec9ZM5HZHQcK6LH78ruRtKzvdslVmIBQ3IYOsc5wbg9otRju8hwyxQDxwyuUrYPrwWpr3fh1kHJ3bgevg8/On1Mstf08+fkxjmSN7PPo8BnTEz4AHYpNcDP8xF49bxwz5jjOQ09fUXWSMsJxpYS3zfWQQWiIU4Tfn99lhdJuTOYeoLxB6cBvGCvk+jGKN9XZRg8KhZaqzsR9WbZB1wgK8RrGhcBV+ss5eI22hqva6B8XpRhR2O7mxt0vqY5Xa7/YhMwNw1UVFaPA/EZ5h70wXWWVZZj4BBfFeCn07hdnEB/xwX8TELS0CJ0blEr7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9kDwjD4nJ6zI/8fcCB1CYCEIVBvXaQzXrHHJCAIxE0=;
 b=jEMHsT/t5rDV8dFyinBQr1z4nXmuk8ms9ANDReuu/EFQRvyxU1in0g39u4hF1SaLvk0+500j13uUa8tQpaOuoSgU5zQudSErtPTek8HYskyZb6302cmaAYVPJIl03vZoutDruFCP+DbEbFjhcOEdMEqCK2qkeN5FY7aUkdnHDJ8=
Received: from AM6PR04MB5685.eurprd04.prod.outlook.com (2603:10a6:20b:a4::30)
 by AM6PR0402MB3944.eurprd04.prod.outlook.com (2603:10a6:209:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Sun, 8 Nov
 2020 21:21:40 +0000
Received: from AM6PR04MB5685.eurprd04.prod.outlook.com
 ([fe80::c62:742e:bcca:e226]) by AM6PR04MB5685.eurprd04.prod.outlook.com
 ([fe80::c62:742e:bcca:e226%4]) with mapi id 15.20.3499.032; Sun, 8 Nov 2020
 21:21:40 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>
Subject: Re: [RFC PATCH v3 9/9] arm64: dts: lx2160a: fix FlexSPI clock
Thread-Topic: [RFC PATCH v3 9/9] arm64: dts: lx2160a: fix FlexSPI clock
Thread-Index: AQHWtgAtKyW9G4asMEKhHnQyvrTE46m+vkqA
Date:   Sun, 8 Nov 2020 21:21:40 +0000
Message-ID: <20201108212139.ht22zdk27pyxv6wc@skbuf>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-10-michael@walle.cc>
In-Reply-To: <20201108185113.31377-10-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d417aa5-7061-4d27-d5b2-08d8842c48b9
x-ms-traffictypediagnostic: AM6PR0402MB3944:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3944C33A20355D5B01D3100FE0EB0@AM6PR0402MB3944.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: snMcSu8VojHihkLWOrl5KqN6udvri8DaRTx9OCTh2YDfbmRgZojr8LgoRmACdXTm2SPEuvrTiJ4RdoWTFH4XrqPotB8H3e+mHYPx+OPD1VPLfaU+n+LAYAVdeTcl5QkRoDWhJEK41bsY6kxX7fWvU5SkYuJtHOO8uzCrga5mH3Gkoa3lCy4dExuj09VRpfKL+hhHN8NdfH3KGG8J0PmnUVpu+GbZz6TXcvE+tM5Vw3M4yfw0pbJOUWVyrgHVpawdE9mk4lw9gJp9IvMi8vtlJDOOqb6BUTkJ/8eDH6AJVCvKLOXgwVpi1qsDM1Qy+9TxkQrhLDzeIO8TNA3B0lCrFg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5685.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(5660300002)(6512007)(9686003)(6506007)(1076003)(6916009)(44832011)(91956017)(4744005)(66946007)(86362001)(66446008)(8936002)(186003)(76116006)(4326008)(8676002)(478600001)(71200400001)(83380400001)(64756008)(66556008)(316002)(2906002)(6486002)(54906003)(66476007)(33716001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NQjvvAarKM1rcLGC2ov8h5K22WmVjd4smR97Di0RakqKHXAnn6beV6Oh83iFS0qE/CTrar7BtF/b6Fkkw+NFVRIZOrJV8G2vAigyWDC1jzIu4w+1065JcLhXbxX8zjWx88C1t9kjbngguE1agJDe5TFNg8wjUu9iGYAHL1Qnyvn4VOq5EyrdPO6gBg5eCv1ymizp0Nr1phYSyyYsktheQHlnJrKhIWW1aBg/mme16lahKpbiEWrnKqJGvUlz1LqhWCgpTmy49sWz/afrNiqCiZs3hCbq1VhQLIQiUaiiTQ81uDksTPu26SIqY/AVkJrnGpVOqkKC3svLr4Rgqo8MRZDvpQX/jurvR/6vtSlB7/NJiTyv7Lq+M0O0CMO982h7htmEn5pJbTsgVeJlpUL6t9cmmm374+hFR4KcrIlKvXoqtXORc/puwYL4tTQSiwjtRfpK+2KP0J0lXY7kAmhkxQJzB0XoOZS6T2eQbupBAdyULeDu1PU/PRv1DfPo7yS9iMwaiQLv2ckjWVcjzBcC8O47JBNCBm7HFMQ0WxjirQY9DeOp2sTfEmaoRHKfFotY/rB9knIpHMmrLCy5jgNdox/He7hL+REzChw4DIeTBVVk3zQ6M6qt/npNFF7gZuCTu60OW0l88PQ+s8cOTxed0A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <082F56944ED14142BB953CD58602C62A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5685.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d417aa5-7061-4d27-d5b2-08d8842c48b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2020 21:21:40.5351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPsJVh2C/OmF59iwor23jfrKMNzSPDfVpA24ZuIpwZepRlVRLmx84DukoyTbnOwL1WmCdWeOSEd6ZeuEaT0tQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3944
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 08, 2020 at 07:51:13PM +0100, Michael Walle wrote:
> Now that we have a proper driver for the FlexSPI interface use it. This
> will fix SCK frequency switching on Layerscape SoCs.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Thanks to Vladimir Oltean, this was partially tested on a LX2160A RDB. Bu=
t
> this patch is marked as RFC nonetheless, because there is too much
> difference in the clock tree between LS1028A and LX2160A. It would be nic=
e
> if someone could test it and add a Tested-by.

You want someone to probe the SCK frequency? I expect that if frequency
switching works on LS1028A, and the lx2160a_flexspi_divs table is
correct (which, based on the documentation for FlexSPICR1[FlexSPI_CLK_DIV],
it is), then it would work on LX2160A too?
Is there a simple test that can be made in order to trivially determine
whether the frequencies are correct?=
