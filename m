Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC726D167
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgIQDCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:02:31 -0400
Received: from mail-eopbgr140043.outbound.protection.outlook.com ([40.107.14.43]:25347
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbgIQDC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:02:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmvwmo9ovBcfxeZk7MoMkdQWnwJDpXK+pNxmhOzqSFfV9JMmNPbM9QwuZR7Bcrz3joDSyILVZJl48SUGgq3cHZVcAypLM1+ntWI7UpwFw660uscXWixI3DjJ0Jep9Mrb4hu4wu6ompTVI9V1qXSBcnevvdlhX2zaXzb5woyw/Gw0VpvGe/vaMq37V2p93RyEIl2HD61CdbInND1NAID+xAiQ+lbJODXYz8tep4e7otRCz01arlEXanVTiITqqBdtRhp/uAvsQ/M0KFz2tbJhsN8j22z9ZL2AZRLDhD0sMlb170ZkznMLJI1uHTCG7G11Fq4YdVvwXydXnIZO9REwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgRt4c14w7ms6KI6urwNSWB/WV9aPkzlVXZRbyYKPG4=;
 b=GpnK1plDUx6i6OJ47p4aUQHnjiHX1BbENiRkWIVP3lHwTOnUvqMjn5iXIKyGf2QGFC+/LQZvq/rAzI516vnM6bhdwLEG7S67kjV697xRI1Q/6tti4DohKkW1Jz36kH/GbM3BHGxEiHaY05Xg8/BYf+PKsz6xvCXL9HWJc+AOIrKSwMdnX6xwcLM5WZcZZJWO1avWJOJBTqyhYZ1QkQTcVcFJnyWbLqFG8pU+sUTdhbXcVFXg4nd5iH7lHWa9A1JcD7shyBjEsOv/j7dZU2ggZ3ABMDgSMef4R6tnQReHw4BmSKlXNaJtcq2dgPAeTe7p/G3tIpEnKvmNLNQurO21iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgRt4c14w7ms6KI6urwNSWB/WV9aPkzlVXZRbyYKPG4=;
 b=RLYEF+EeFXfmaFVhp8f29Bd94dGq+hsged/mezfR/LePZRwoQ5+ZDSibc3vnCF8Lbtv7EnwlblI+ePZC2K1rKdWT78ttr6u99ut89mHD5FgGABnP/Oanr09zdp+AWH0hU/noWPJdHMS3x/d3ZYDkEzl+JTQW53u6wUcP1iJIlQk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5509.eurprd04.prod.outlook.com (2603:10a6:20b:28::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 17 Sep
 2020 03:02:23 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::99b5:145d:16cc:78ca%3]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 03:02:23 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 2/4] ARM: dts: imx7ulp: add pmc node
Thread-Topic: [PATCH V2 2/4] ARM: dts: imx7ulp: add pmc node
Thread-Index: AQHWi9TfOswrHqDkPkax2b5ipm3T2alsJf+A
Date:   Thu, 17 Sep 2020 03:02:23 +0000
Message-ID: <AM6PR04MB49660CD04BD9758F83B0FDCF803E0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
 <1600224517-31465-3-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1600224517-31465-3-git-send-email-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4e908dd-5716-448e-84f2-08d85ab619fb
x-ms-traffictypediagnostic: AM6PR04MB5509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5509E740BA84597EFBADCC71803E0@AM6PR04MB5509.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:67;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BliyGF6Nj0f8I/m1DJk/leNLG0Dc/kJh7j/1/aMCyQxkNmEfS2yy4F2L/+TeYhMWiCeF1gZIlybktPIps58hESshUVg5rwjjeasv3VAnnG4J/1qto6sFDjkAqNTzcvRwEWURwKsUgsoekOuciqYm6AhZy+/TxPYCxxf/ddp+r3Q+Ce1RUebfOyAO1GzJgjvXiZABewyTmGSQJHSDV6M7cD8Xi8+579gTvnzZZx+6Zc2RaJjiifVPBS5ArZuI0AM4YLyfDLDmeWCX26dCdMr1BL5FUmJap2TsZMMMcAMiD3nf5Hc9YFagL79mRi0NjCRJrwAEhMElAVrpxvuVoL97EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(366004)(136003)(33656002)(83380400001)(66946007)(66446008)(64756008)(66556008)(66476007)(44832011)(316002)(6506007)(8676002)(4326008)(7696005)(71200400001)(26005)(5660300002)(186003)(110136005)(54906003)(55016002)(86362001)(76116006)(2906002)(478600001)(9686003)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: taGMombPjK1fxIuvM2UQ+2T9aOgy33FbYd5FZ27F6mHWYLjsLW7S8f/334d32lLHNElU1y1TbBOC27DMXchTjUJ9BGjpPAZeemZ2USgcPJHxlD/hD+3QL480SK67/mPeHaa+BvxU7hPJ8UGyktF5to+z8n0hPBzJrnzKW1Do7CThyq7eJyYSm+67oLaDdNThn1pA31tmfpFk4sB2d/qmDKdRvRoHiSfPd67VibIXWXDGEWUc/pWYLeKDup5CIVGeBs6LU56dYqiNLajBX3WSQ+LWdchveOR8C327721OSUmyX6syRfjcsWfy2TH7cRyB4cy2Y5Mnqi1YgHWQNBIiuGjRCOkOcf3qHuq+Aiim9uUL6jUBSND8x1VkC0tuh344HX952ZiIkMFNzI7qmOsCJUUolzHkofPDLbhdFNok5L1OC7J2EiIF4YapQCUg1fGzAPV6hjbPEjv9WaVBywlEmYVg19CjM7tC2W0CH15os5fTYPf6S3Nh16oa1WHkWdJ2QetbskyqU/pQWg5bnBXRRNCvNBiPOlXZo1IxzQp7gMsbMdmNMV56xIprpSjC3d1E1MQ7272aiKotBV5rcdRPP4Enw4IhuGUp8Xq8R9Fytq1Lc41grepOhkEs5DpbgCcHkJHuOeEPeFcs9Ay3vfaRng==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e908dd-5716-448e-84f2-08d85ab619fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2020 03:02:23.7607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sPuzmFkUlEoWQFyH9nQ5RpnSm09nQ9t1rwLPs7XrTMzv6LoR79np1Lslj4CW5oG+jaMAfeCQh5DwUnNR+nYFUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMTYsIDIwMjAgMTA6NDkgQU0NCj4gDQo+IEFkZCBpLk1YN1VMUCBwbWMgbm9kZSBm
b3IgbTQgYW5kIGE3Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC5kdHNpIHwgMTAgKysr
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLmR0c2kgYi9hcmNoL2FybS9ib290L2R0
cy9pbXg3dWxwLmR0c2kNCj4gaW5kZXggYjdlYTM3YWQ0ZTU1Li5iMDJkYzRjOTdmYjggMTAwNjQ0
DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDd1bHAuZHRzaQ0KPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9pbXg3dWxwLmR0c2kNCj4gQEAgLTI4Niw2ICsyODYsMTEgQEAgcGNjMjogY2xv
Y2stY29udHJvbGxlckA0MDNmMDAwMCB7DQo+ICAJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0g
PCZzY2cxDQo+IElNWDdVTFBfQ0xLX1NPU0NfQlVTX0NMSz47DQo+ICAJCX07DQo+IA0KPiArCQlw
bWMxOiBwbWMxQDQwNDAwMDAwIHsNCg0Kcy9wbWMxL3BtYw0KDQo+ICsJCQljb21wYXRpYmxlID0g
ImZzbCxpbXg3dWxwLXBtYzEiOw0KPiArCQkJcmVnID0gPDB4NDA0MDAwMDAgMHgxMDAwPjsNCj4g
KwkJfTsNCj4gKw0KPiAgCQlzbWMxOiBjbG9jay1jb250cm9sbGVyQDQwNDEwMDAwIHsNCj4gIAkJ
CWNvbXBhdGlibGUgPSAiZnNsLGlteDd1bHAtc21jMSI7DQo+ICAJCQlyZWcgPSA8MHg0MDQxMDAw
MCAweDEwMDA+Ow0KPiBAQCAtNDQ3LDYgKzQ1MiwxMSBAQCBtNGFpcHMxOiBidXNANDEwODAwMDAg
ew0KPiAgCQlyZWcgPSA8MHg0MTA4MDAwMCAweDgwMDAwPjsNCj4gIAkJcmFuZ2VzOw0KPiANCj4g
KwkJcG1jMDogcG1jMEA0MTBhMTAwMCB7DQoNCnMvcG1jMC9wbWMNCg0KPiArCQkJY29tcGF0aWJs
ZSA9ICJmc2wsaW14N3VscC1wbWMwIjsNCj4gKwkJCXJlZyA9IDwweDQxMGExMDAwIDB4MTAwMD47
DQo+ICsJCX07DQo+ICsNCj4gIAkJc2ltOiBzaW1ANDEwYTMwMDAgew0KPiAgCQkJY29tcGF0aWJs
ZSA9ICJmc2wsaW14N3VscC1zaW0iLCAic3lzY29uIjsNCj4gIAkJCXJlZyA9IDwweDQxMGEzMDAw
IDB4MTAwMD47DQo+IC0tDQo+IDIuMjguMA0KDQo=
