Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01C7E2915FB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 07:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgJRFDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 01:03:10 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:28422
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgJRFDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 01:03:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPtypLJq1pwMxYdMsMyUij2ia1XChsY55/xjD7FYOwnATrtRrqFyMEfE23VK8xI7aKCng+mpLZVptmERP0TkG2HT9xcY2+rJafIiYoZzwi9NVoluRIePZ0Z5Fo2aohyjcxEzClHB6EabVwCelZeylmxGEzYTaYeGw5aGD6cBpe6TTejtbfb9SYwajhxX6ISf6F3U4DTQpe3swNH3uEvwfJRB86iUGJ8R4R2EFhakDxBNeUmQO7LAKX2PiOnhxDEicj3ixeBSWTGruBrxpVsc6nF28gbg3KEaRJBsLY7HyPoxRqcC/uq7MYmKCJdqPwkre0/NnDnSsL8xD6uspLlpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZBUO7oWW5ouoM1ePMl9REQWnu1YvEql0Dr3nzKCkWE=;
 b=QbtFCd58WFISgQvPKYk3Q13+M/d1vY52g1qwPDFup6AvChbRFkbgzpfkFTdSKpiUect+GluU5ei3gubd1qtyVmFWtpnqSmMjf1vuESqQ74EDtHRC7dITp5zu8DZj31E+eLlOmGUqa3Nrw2KH7Cgo5uB9O9IJQSgm54gkKH5Dmtt2dgBZmGlH+53/3HCX8ZgyUnnq/+asjub9NG/o2cQaZQPYzkjabzUOHHWijyD4nYCCZEIEIF7ZZFXJvKY6+0TlWahWdhQa3rP9ykOuq+nQRLnYZiuIHjw51wrRm7oI5roKmFikGf+HD9eE02Y4ocpbvfRvie1JyS0UafTW/Egi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZBUO7oWW5ouoM1ePMl9REQWnu1YvEql0Dr3nzKCkWE=;
 b=nZzUqUCTIHZIeVkU/+h4xFC5q1Dk1JZOjiS6Q8wJAW8yH/SRTDX3gV365DHq5Kb+FGojFtSkfBNRdvUvM37/Rz2irmNx/aX4cR6AdYoAp/WwlRNzDF7e3kd0aOEvvBc3boU7IMnTuunN/Lndkq8i9XDYrAODxtqnP2UY0h+qEgo=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3672.eurprd04.prod.outlook.com (2603:10a6:209:1c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Sun, 18 Oct
 2020 05:03:05 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3477.028; Sun, 18 Oct 2020
 05:03:05 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v2 4/5] dt-bindings: arm: imx: Documentation of the SC
 secvio driver
Thread-Topic: [PATCH v2 4/5] dt-bindings: arm: imx: Documentation of the SC
 secvio driver
Thread-Index: AQHWX3J/azUu+I2/EE6KnTWyj34EzqmdVX2Q
Date:   Sun, 18 Oct 2020 05:03:05 +0000
Message-ID: <AM6PR04MB49666A87566154AF128DC47C80010@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595344835-67746-5-git-send-email-franck.lenormand@oss.nxp.com>
In-Reply-To: <1595344835-67746-5-git-send-email-franck.lenormand@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: db3e42ee-8b2b-4d43-6571-08d8732318fa
x-ms-traffictypediagnostic: AM6PR0402MB3672:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB367219023C2C878B9AD2822080010@AM6PR0402MB3672.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZkKgLsCFrh0P3a/LqS40+glipcKwfio6i3BF4vCforN6SAEj3bLgdlcutQgFvLfQQvgA0QF+KwKcwCyPNYEnGrZowdj/GU7z+Z13PbuYQK9XeVIUgIR0zvMK1uVkeAwVFpvk1AYTBO2JKsbpc8nuKjbhBNmEGH8Zsc/Pxd+nNjTSj5VrJEZMIw8YEnSCPLTMhik73XYwZb5V7i2vPMqGIqztTMtDcbuFwgRnaA0Sxynv3sdo0GmA46p9odXwkfNf9P0U1ZFUPWp+cM+clCIeUyVPQSbHacJWcPoP+3O/XVJnP8sySkGfzMh0KpVnPmgG1QemzkS/LRDdDlagThJ/omuACD7J6xE5qG8eNh/lk77eYBUNU+gROJ4y0eCIMEO4gBrj7YKpwMLeXaY+Bzvmkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39850400004)(366004)(54906003)(966005)(110136005)(478600001)(26005)(55016002)(33656002)(186003)(316002)(52536014)(5660300002)(44832011)(83380400001)(86362001)(9686003)(6506007)(2906002)(66476007)(7696005)(64756008)(71200400001)(66946007)(76116006)(66446008)(8676002)(4326008)(8936002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nfiO6FNitoMxLc6mJJJ/rYkVQcMns84OCSJ6iEpSyzo1zGFH/1igm8DnWapBVnlAbGAAN4pSEaBKhA180xMhCefTNzHteu1SFs/MDIodWHVjccPSeIlmd6NMdyzQj4h8WQ7/TG64+Go6P2hhD1AvO2MEMc2Wfiu7dmzDrLrnIUgeZ0sro3L7fdJPu788w3grk0aPHiI5OImesaSs5RRw0QL/Tt3rPT6SKSxlDQvt2PUHgr1z/id9HgcvUbnsWLVh7GRkSvp7Ru6azp0PnsMpC3Fj+Q9vO7kNldCi1L3aaW+QOSU4kvwqstuxKyJGkBQ14DO1TBcoKJyHoVhrCwj0VCEkmSuBLVo7mvYkftj9gdNZm3uj8unhMiOT+1CXRRj2UceYxqDIlnzd2jJ5//wD3FpIacYbdeOi4tWHW0aOVJkImt/tHjjzYtVZsyxvwtiodfT7JoPxLoCryCuv2XIrFY79/a+YVJK3pYneOuS49NNmoFVEhXTbzwsxiLLWtFJHviCQSqlsQ77Q5jbkH/1ycmgSXC+KiRRjJ+ZtNUZpllIy8FBukJLNySqYczFmRvPJc9ElS4D1Hs+FhLuxqnj3iurn5fzoALu/YNiaAVNxbJ1pTMvopkdeNOAz4e2m+MxiibB9LfbNUmt4Kyt7sOenEA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3e42ee-8b2b-4d43-6571-08d8732318fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2020 05:03:05.0799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XKsKUghZhFKUTpdQpHgFCOk+ozEpjNLfJoQRocCWOktEEfTTA91YmxZku0+5T07NAgVGiRf6GDy3RrJ1TljdlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3672
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBGcmFuY2sgTGVub3JtYW5kIChPU1MpIDxmcmFuY2subGVub3JtYW5kQG9zcy5ueHAu
Y29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDIxLCAyMDIwIDExOjIxIFBNDQo+IA0KPiBUaGlz
IHBhdGNoIGFkZHMgdGhlIGRvY3VtZW50YXRpb24gZm9yIHRoZSBTRUN1cml0eSBWSU9sYXRpb24g
ZHJpdmVyIHVzaW5nIHRoZQ0KPiBTQ1Ugb24gaW14OHggYW5kIGlteDhxLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRnJhbmNrIExFTk9STUFORCA8ZnJhbmNrLmxlbm9ybWFuZEBvc3MubnhwLmNvbT4N
Cj4gLS0tDQo+ICAuLi4vYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsaW14LXNjLXNlY3Zpby55
YW1sICB8IDM0DQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
NCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLGlteC1zYy1zZWN2aW8ueWFtbA0K
PiANCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9h
cm0vZnJlZXNjYWxlL2ZzbCxpbXgtc2Mtc2VjdmlvLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsaW14LXNjLXNlY3Zpby55YW1sDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAuLjU5YjlhODYNCj4gLS0tIC9k
ZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2Zy
ZWVzY2FsZS9mc2wsaW14LXNjLXNlY3Zpby4NCj4gKysrIHlhbWwNCj4gQEAgLTAsMCArMSwzNCBA
QA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNl
KSAlWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOg0KPiAraHR0cDovL2RldmljZXRyZWUub3JnL3Nj
aGVtYXMvYXJtL2ZyZWVzY2FsZS9mc2wsaW14LXNjLXNlY3Zpby55YW1sIw0KPiArJHNjaGVtYTog
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3Rp
dGxlOiBOWFAgaS5NWCBTZWN1cml0eSBWaW9sYXRpb24gZHJpdmVyDQo+ICsNCj4gK21haW50YWlu
ZXJzOg0KPiArICAtIEZyYW5jayBMRU5PUk1BTkQgPGZyYW5jay5sZW5vcm1hbmRAbnhwLmNvbT4N
Cj4gKw0KPiArZGVzY3JpcHRpb246IHwNCj4gKyAgUmVjZWl2ZSBzZWN1cml0eSB2aW9sYXRpb24g
ZnJvbSB0aGUgU05WUyB2aWEgdGhlIFNDVSBmaXJtd2FyZS4gQWxsb3cNCj4gK3RvDQo+ICsgIHJl
Z2lzdGVyIG5vdGlmaWVyIGZvciBhZGRpdGlvbmFsIHByb2Nlc3NpbmcNCj4gKw0KPiArcHJvcGVy
dGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBlbnVtOg0KPiArICAgICAgLSBmc2wsaW14
LXNjLXNlY3Zpbw0KPiArICBudm1lbToNCg0KQ2FuIHdlIHVzZSBzdGFuZGFyZCBudm1lbS1jZWxs
cz8NCkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9udm1lbS1jb25zdW1l
ci55YW1sDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAgICAg
IFBoYW5kbGUgdG8gdGhlIG52bWVtIHByb3ZpZGVyLg0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAg
LSBjb21wYXRpYmxlDQo+ICsgIC0gbnZtZW0NCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0K
PiArICAgIHNjX3NlY3Zpbzogc2Mtc2VjdmlvDQo+ICsgICAgICAgIGNvbXBhdGlibGUgPSAiZnNs
LGlteC1zYy1zZWN2aW8iOw0KPiArICAgICAgICBudm1lbSA9IDwmb2NvdHA+DQo+ICsgICAgfTsN
Cj4gLS0NCj4gMi43LjQNCg0K
