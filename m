Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9C929FC28
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgJ3D1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:27:14 -0400
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:21226
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbgJ3D1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:27:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X39q0QBuxW9tztC8oxS7AyDnuA1W7FiEcCKOY10dr67D45hhlZPopYRPjrFxZNGA6YFUPI9ov0er0EG1QGGKqx9DdKA0elwEb0xt5U3WGfHniBOFBjpiyM5ue8Uo9xZQsHbS/cySID0nKPi0/gmoQLGVjtr8Pj3P9SMmadG0TEio4NCT0dFPsTSUwJlW4Zb7lcrrAX8f+D6C38kQunOARl/fnvL+Hnmk0bl8v2Se60f881IgDjkdrtayTGHVNt2yM5KevJRVsJSHbKZxDuk4pewQPQb5KLZTirkNxZqgx8vpGHT85csDtrOYnM7MC334KS/+lFN1tuvZAtHdOBD/+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDfWcCKf1l+AxPFSWFsU++9GbNuCyfaePB6JAWeTBp8=;
 b=euqYj0Nw3R9nwXwg8hQ/TkXWtvV56ZnT26MCIxGt3rBdP0W+CRIWSKjdI9sDW9tn2omApFoDuS+xzV6W4qw44zSiU6RKqUksXfU3M1QXYkMuZHcaGLVP3KGcUmSlr5W2nu+W0Zl3BzYUgKhPMvz0XNnz8LTLQjzIynkViUDijIaPq4PhS5ghQozN7UdVFlpHudELfTVdyA/ZFAcavj+M/7HF6YvAXlIPzXdLNdZHts6n/KjlQ435vJbw4rfAop5dFDMBblnG50y9xcmae84FV+GhnwJPpi/c6cDHI5uJKfRg4Z+J9qFHYk7A4uEZvYgqpBs1kdU3etL3W+/OJTA7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDfWcCKf1l+AxPFSWFsU++9GbNuCyfaePB6JAWeTBp8=;
 b=r0NCp4BEjcosrEuSdquyBP8prQXOu0To6/IuWRD2RzF8bm6uZqN4a+6SkSgjV9vah4xkDJvxkBbNNX5MOhJmd/57BAfkLU5480omQTU/2/j2q72pMlKV89wj58ePfVSqe65z1xh1iujci6Ksk7oqKC3f7bXl1R8lMF4GyrJ6y2U=
Received: from VI1PR04MB4975.eurprd04.prod.outlook.com (2603:10a6:803:5f::14)
 by VI1PR0401MB2495.eurprd04.prod.outlook.com (2603:10a6:800:52::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Fri, 30 Oct
 2020 03:27:09 +0000
Received: from VI1PR04MB4975.eurprd04.prod.outlook.com
 ([fe80::19b7:8e74:4d3:3acf]) by VI1PR04MB4975.eurprd04.prod.outlook.com
 ([fe80::19b7:8e74:4d3:3acf%6]) with mapi id 15.20.3499.028; Fri, 30 Oct 2020
 03:27:09 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Colin King <colin.king@canonical.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: remove redundant assignment to pointer np
Thread-Topic: [PATCH] clk: imx: remove redundant assignment to pointer np
Thread-Index: AQHWrkR3SMV2FfQRYkit5Jb+GXEuNKmve+OA
Date:   Fri, 30 Oct 2020 03:27:09 +0000
Message-ID: <VI1PR04MB497592A661D76BFE9F04606180150@VI1PR04MB4975.eurprd04.prod.outlook.com>
References: <20201029224007.390762-1-colin.king@canonical.com>
In-Reply-To: <20201029224007.390762-1-colin.king@canonical.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 09144941-6d2e-4479-7d57-08d87c83af49
x-ms-traffictypediagnostic: VI1PR0401MB2495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB249558EE6B73D8D32DB3B2B480150@VI1PR0401MB2495.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:298;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MIxkYjTEDhT8gRGOfDgVtU6d79pj/YNCOY8dyduqWvu8f6kJf+363SlivrecNFbmxX23bDCXvtMsIMKxcqTds2Oaxz+o88rLJqy9UMlWNT11GUkZVOZBCCwYjAW/I70KyFy8RbEiOAsTj8MP9GqThRcdsydTeP/i/AeyD4Q/625emZjeaD2OdaMbRQSk5u9UPhjr2WsUuYvufMHGqwMS0u5phEDgdctwn43e5djyqQjhQ25a7gnBiG1YYA7lzaMlZ0PQF9AXROsiC/8VVIS8N2lpWq1R0veZ9PfaAeEN2rSzEwKGfc0YPrsKGDoq4nEz45WkCXxN91kxDT1S4GIeqHh8ncGwLsSGhhAbbvMy8NC8O6CakBY1BpTGnMCY5Ezb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4975.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(186003)(26005)(33656002)(44832011)(7416002)(478600001)(9686003)(83380400001)(71200400001)(66556008)(4326008)(55016002)(110136005)(64756008)(8676002)(66476007)(5660300002)(52536014)(54906003)(316002)(86362001)(7696005)(76116006)(8936002)(2906002)(66946007)(66446008)(4744005)(6506007)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mCFnpFYRuLgocVUwToZmrvrf5fdeEZUV5qw2DEoT4nG+PUMbXFNuWmsdvxQC9hdQN02tnEizKO94vsRtaP1euzr2cvTh+463xcOD9Qjy4YtG6X3mZsn7VQiu+zTS/5HapWO/f/93Zttq3szVKAQ4AbVAT6D4xROwj/ejlWKgj6R0b8hHz7o77ZYjHPKKJQbx8x3VZ0Ckvpk9/pCy9WWMuTk/zCJH2H6tMlq3T5DJEmiNl5agTz2Igxs5VkzgsLmGdDCAXHAeWg6w2eGQSorB9v2J70TE6IFvn9zbHjpKkshBbVLNyktTvzET1T6ocb4oygud6O0KL2FyouaCxxwJNmUIvEp7WgkC1k/mSJP6UoEguSlBAh0PGOBNaiouIxrW3hyYxEzgN4f8mv+nsctTnf9VQAN451ofnfGf1KZIKSE+Lk009nEzxMlhrXCr6+VI0EROk0mfiaZiAwuHLTJaMTa83ChlAcRCgZrvH3aUeFMO9nmyg4GpYJaoxEmCyTsuF1+NbbACjOjeoyUZ4ck+1kgZf8CVKR/QrdyonoF1sk+yFKIAplCOquwKFttCxFbV6DzrXgFMseQ/JORBWYPriZDTfjdT/iG/NoixUol9zDGgmo9Mw0io0I31yarXFqTpAOT1U8756YjBobIsmJ8jag==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4975.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09144941-6d2e-4479-7d57-08d87c83af49
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2020 03:27:09.4954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OV6XthTdVZVyWhnBNs8SO+Pr5Tikxvldh5D2PKQ95Bed8lFSfjfN79sNrDF33pCGgC6YRCE1RBwgJ64U6I/gWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2495
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBDb2xpbiBLaW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IEZy
aWRheSwgT2N0b2JlciAzMCwgMjAyMCA2OjQwIEFNDQo+IA0KPiBQb2ludGVyIG5wIGlzIGJlaW5n
IGluaXRpYWxpemVkIHdpdGggYSB2YWx1ZSB0aGF0IGlzIG5ldmVyIHJlYWQgYW5kIGl0IGlzIGJl
aW5nDQo+IHVwZGF0ZWQgd2l0aCBhIHZhbHVlIGxhdGVyIG9uLiBUaGUgaW5pdGlhbGl6YXRpb24g
aXMgcmVkdW5kYW50IGFuZCBjYW4gYmUNCj4gcmVtb3ZlZC4NCj4gDQo+IEFkZHJlc3Nlcy1Db3Zl
cml0eTogKCJVbnVzZWQgdmFsdWUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8
Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KDQpSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT4NCg0KUmVnYXJkcw0KQWlzaGVuZw0K
