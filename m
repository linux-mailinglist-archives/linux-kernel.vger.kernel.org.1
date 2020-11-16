Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96F02B3D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgKPHMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:12:30 -0500
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:27171
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbgKPHM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:12:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad3UMPlSodeTW6Nx84yxAURCly2NmFqqWAubCpkcVFNLvh46gRkXjIop4YC6xCTg/ZRJuFzmUKia+PPAXQo2Vijso8TLGwHGzsEx6wNb9m3JeOfGNiMH2ywtzQ2TMzBigNk4EewaJ4cnixUR1mTA4tgAcSZljp9pFFcYsmRh3PJO0S+AzP++GG0r722Sn2ncOe3gjxba/8/A0ptO/Uv9W2agL6pB+EFP70WgsQ9J4OFwONE3UkKPMqdmpWUqp+OPtLuU+/IVR16z/en/5qfbFGPGQoJyyLT9X6r0/0dmTFbcaf6hsrc+sE1O+asDWnACzAe9egBfGF5nyw4G9q4cBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VDCiqfCGzJuitnUWF2+5Cjcowon0WCns3XytJt5GCo=;
 b=LKyt8+ouijdb18fuAb44QSh2ouOAKk7s/YSeWcIOkCch5Zvyq1cuT2j4EDmiqEGZnn0CvgtazmXuxkrHY8rYUAUL7nEFXRH0puviuVhITX9M79+jwXsMu5fnmdAVFQV+Ev5T1eOQ1se8uRu7/hDUE886jhF3XwnXPXr+lF8/cim/flZtqHrHsHk2lAoNQyKR4Z+rTfyiN/xyy+4hJ6FLAjNjJ2R8omvzjuaLUjFHjZ950Zbwq72MA64Jk8CqYFR7LDr0r54nIwCb0qVpabMaw8TDzp3+mdcMgiWgEAhxQz3a9p5VPc1vIoToJ1iSvHzv/gOl1nRq1bRcKgitOJU+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VDCiqfCGzJuitnUWF2+5Cjcowon0WCns3XytJt5GCo=;
 b=F2fF4v+BtM6rfDiUzG/2U01L4S0I1qo3HcHb2vLzxwWLdq+W9enjZ8V5GDiZ6epsLMt2dlEY7j+mkBG2AFh41RtKmFr+4lDEp0ohh/0MG58FosmqY48PQnv469HSk+qRHTUNCQK8iT6PZsfDnOndpVaDcgrKmP+L0AAB/83z9AM=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR0402MB3414.eurprd04.prod.outlook.com (2603:10a6:209:3::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 16 Nov
 2020 07:12:25 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.026; Mon, 16 Nov 2020
 07:12:25 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 2/4] arm64: dts: imx8m: add compatible string
 to .dtsi file
Thread-Topic: [EXT] Re: [PATCH v3 2/4] arm64: dts: imx8m: add compatible
 string to .dtsi file
Thread-Index: AQHWuay8zKCPgv/11E6xooEpWU9zyqnHylSAgAKRkVA=
Date:   Mon, 16 Nov 2020 07:12:25 +0000
Message-ID: <AM6PR04MB6053C4B217108356215600BAE2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-2-alice.guo@nxp.com> <20201114155723.GB14989@kozik-lap>
In-Reply-To: <20201114155723.GB14989@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaf75534-f3a8-4dc4-38dc-08d889fef87d
x-ms-traffictypediagnostic: AM6PR0402MB3414:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB3414AEEA67752D193C5842A3E2E30@AM6PR0402MB3414.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lApdUp3sLb4yzHNOr2ek+5yVwVBM/sPYZZApNbpdh+ZFtdxPAY631VeyaQ9TeO6xtUS8hRo8cDEW+ul72exmPBRPIrprlUOXWtRlhwkjT5M6kSBYgLyPTlMGI6WnafsPUAmK2ySGZ8Ngoquud8dl6dIWKi9HFSh5idF4uxMkOlQoPY/5w6p8w4RMRoUS5vx/mvhjnj6yffNn1Tk9GSahHN4egvR5yMkwdOnouRhi2/ARKIuQA5YN65IVfW1UmOEEVwim8uePlgx9CRWrOkjw/XkOZhY7JDyacmDBGgsGdBTLqrKCRe8zH8QMdpzIwtSjGBzyjjbQ9iLSVcDVBctrV8BD84rM60IKXz17DcNIraEaoO9/H6M9TyFi+Bmx0OzFTcBi9jAe5fnmCOB8GTGR9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(55016002)(86362001)(8936002)(7696005)(6916009)(316002)(54906003)(6506007)(53546011)(71200400001)(4744005)(9686003)(66446008)(66476007)(66946007)(66556008)(478600001)(186003)(44832011)(5660300002)(83380400001)(26005)(76116006)(33656002)(8676002)(4326008)(52536014)(64756008)(2906002)(142923001)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NxaSxwmFcCrCNN+ChWWaCwPx8QjXJQcwUVbgLSwHOQc+qWfPrZkM8s0l+2MKpa7oOgZ/JAMsAlcp/bk8zlLsqTDGYTuy7UwCxnOEzW2TbFm9HAm/VlgLJi7yAGTqGupUia5mgVIeCxaFhKbZ3OHnh41gMxJv/0bLJZPoIDEo87j95ImPh5N+k0Fpkaq+UuNA1wKdIbNR6N3EQx/gF043lFeH6oaLdV92Ul8uAH0jgn6LcBRtnB72qi7NuhaoajPfSN+ji1woowCGikt66IRzZHL4RkF1faPM4c10KkeL5qbUl02YTvY2E6PG8HQ2O2GGGdweVXBTTTe7QpY+k1gZAPvdl+EjHrg78RF0KMM9mxWE81YOeJUXNAMZn1tGl2NshJ8jM3i9BnkiTvr3ejy3uY7d22Hz2d9enZZAka2WF5kezkpGpa5FQlNP0q9VdJmMpyd/FjABnRgFRPZlM6Dq9zJUeHptIDuKlkhk3QM3sqUHXV2zMvwOKwN5rTM7Yr7YDQZbZVsDkDMGMwQ7gO55FFRiz37NFCbSJ4eCvAWfeIa/kEHbmrP9fwLCyzPHOF414Q7MXVXbs39hyeJvjCPGMDxKbv0qxF2SXj1RdbrloZQKr0An/7jRI9sexZBiI2LOvOsiK1lS+445TRgk88ay4k+srJKmI0YILtbfbRLJ7c0rMZIte1/ptE07UkYYmPTTbvTaFoGG5jdkZbl/Yt33kqFwgM71w/aBdMgPAP/TVeDLc3C55qQm0aj88ER+HGz9ydcv7QAYfX+nTfHogA+OgOgT7VlymDVNE7aYJ3MwAl9tlyS7zwFKRaUKGHTF7M8yp38uW+7PMpARiHth95RRMhulpk/brehNgRnXbR+0PG1psBn0VCHK28U2F5MOz/yTXO2VLNITc3k7+7OiiQQ3mw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf75534-f3a8-4dc4-38dc-08d889fef87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 07:12:25.4940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +7qaiQwGS5wiPsTG7I4JgB1hqQHMR3bqG4IK6x1UppQiW6Hhvc8O9Y+FtZsSXbuKOWFQ4BFylLHtnq8CkChyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3414
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTHmnIgxNOaXpSAyMzo1Nw0K
PiBUbzogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIHYzIDIvNF0gYXJtNjQ6IGR0czogaW14OG06IGFkZCBjb21wYXRp
YmxlIHN0cmluZw0KPiB0byAuZHRzaSBmaWxlDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4g
DQo+IE9uIEZyaSwgTm92IDEzLCAyMDIwIGF0IDA3OjA0OjA3UE0gKzA4MDAsIEFsaWNlIEd1byB3
cm90ZToNCj4gDQo+IFdoZXJlIGlzIHRoZSBjaGFuZ2Vsb2cgYWdhaW5zdCB2Mj8NCj4gDQo+IENo
YW5nZSB0aGUgc3ViamVjdCB0bzogImFybTY0OiBkdHM6IGlteDhtOiBhZGQgU29DIElEIGNvbXBh
dGlibGUiLiBJdCBpcyBraW5kDQo+IG9mIG9idmlvdXMgdGhhdCB5b3UgYWRkIGl0IHRvIERUU0kg
ZmlsZXMsIHNvIG5vIG5lZWQgdG8gcHV0IGl0IGludG8gdGhlIHN1YmplY3QuDQo+IA0KPiA+IEFk
ZCBjb21wYXRpYmxlIHN0cmluZyB0byAuZHRzaSBmaWxlIGZvciBiaW5kaW5nIG9mDQo+ID4gaW14
OF9zb2NfaW5pdF9kcml2ZXIgYW5kIGRldmljZS4NCj4gDQo+IHMvZmlsZS9maWxlcy8NCj4gDQo+
IFdpdGggYWJvdmUgY2hhbmdlczoNCj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kg
PGtyemtAa2VybmVsLm9yZz4NCg0KW0FsaWNlIEd1b10gSGksDQpJIHdpbGwgbW9kaWZ5IGFjY29y
ZGluZyB0byB5b3VyIGNvbW1lbnQuDQoNCkJlc3QgcmVnYXJkcywNCkFsaWNlDQoNCj4gQmVzdCBy
ZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg==
