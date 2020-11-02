Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72D32A23B7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgKBD7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:59:20 -0500
Received: from mail-eopbgr10051.outbound.protection.outlook.com ([40.107.1.51]:56963
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727555AbgKBD7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:59:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2I4+a1n3ordDp4jZZtCjIdKp/R8/OhmngpE2vZN5zcF69LW355nKEUBxROy4utighce/0A2iiEjFdRLPaPz3QPM4cas8mM45S+3WkMkrTkQPDykSzSu8F4roD1PP7d+mTe+i/generJBAw7Pv1mBDKNlB6bTg6CNFnChgJHfxY4j6drUqlTcRUqyPBPQU3vWUApgLDqPHw8pEN6a+ZyNA0pFpWwXimfHDChU7c+ZHrNEpw0ckADJW0WaThfTI9/b9kcdLKsTjzVYuEuujOU3jjwM8IKtIKgzRb6DVM20q1zkFhdaUdCorQN1o+yrCw/RssZnny/IY1/C/6v0KctFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VFyv5Oyx4wqT+7CUrqYpUlgJnM5Rf9A5IL1RMcr4ww=;
 b=Kq0k9TS3VJRevSwIkAk9r5oZ1wSiHaTvtU1uIY7Dbe/HdKfuiOkTeuLEpk/hxvDtMEepl4qdDdcJHUKac+YP6G8skd+sHrb/y/1SANeNpPGWAzKhViTrAT9PxkHw3RAsWV3td+d4+Bcvfcv1bzJrXcLeqFndeK/RlRnhgCnZ+9c00XQTnHW1V3Nxbg5xLgdPgqIx/sGI3/p6GhD0k3f3L7AfPBql1AVhxX3pOkSet9upoe5wdi20sDDoqzYpMziNu/ZwP6FX++9A67mmktjQWOjFDycmou1iR2osVLuRsFXXMZIKCkBinYvUuC9o4MpJWl/KZKqpJChEwgObb3EOIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VFyv5Oyx4wqT+7CUrqYpUlgJnM5Rf9A5IL1RMcr4ww=;
 b=grlOmMq7netWliK+tUbCZAzUOQI8BmA/7WI++PgB9p46V7FC2QgQ5zVgGud6hZt7uK026qAwlUTMP8ze0rqievlF9t5fjabxft51qh6yk8XmprSS8qrx5YtZ2dCx2Jlzg1qI24UZfAWUki2m1FjC03qfB8JkXP5/p9dAut7oZzY=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3370.eurprd04.prod.outlook.com (2603:10a6:7:7e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 2 Nov
 2020 03:59:13 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 03:59:13 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv9] arm64: dts: layerscape: Add PCIe EP node for ls1088a
Thread-Topic: [PATCHv9] arm64: dts: layerscape: Add PCIe EP node for ls1088a
Thread-Index: AQHWq1GyzjbqCgl9N0+iHw3dt1gkr6mzAqmAgAE/csA=
Date:   Mon, 2 Nov 2020 03:59:13 +0000
Message-ID: <HE1PR0402MB33710DBE0413AFA9AD33DFE184100@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20201026042759.15155-1-Zhiqiang.Hou@nxp.com>
 <20201101085447.GJ31601@dragon>
In-Reply-To: <20201101085447.GJ31601@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1beb6a95-286b-422a-4984-08d87ee3a931
x-ms-traffictypediagnostic: HE1PR0402MB3370:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0402MB3370D29EF6123D06E1A5961D84100@HE1PR0402MB3370.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9N+O7NEzwKHrTx4ieywTIgkYX6/JA0FdStosGEjoJFnTtBHER39YW4wW315J+BFVZFF/4cxwnCyWRUcPU+bBaqKR2ryspX9ASMjrXxvtEP85HlnH99MlqiV0VePOQj5NJxJEdWpXY3BJuQXFjFRdWaIXSp8LHvNuwGXr/zRYaWGvtE/3gMR3vZ54YD9EyNZFwYWZVOY1Yg84KTJfX6ke+GEi9u3mP81twwdtRP4M/Zr4JdTSdaDlruLIiGSEUpMrll4xu0fYGVGCyOGu6FBFpuqDj2zD+fSKgzypViNXD1/tUiibWS+O6TsaCxAhlcJTL5xYOp8HHcYpYko86wLU+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(5660300002)(186003)(83380400001)(9686003)(55016002)(4326008)(7696005)(52536014)(86362001)(6916009)(2906002)(66556008)(66476007)(6506007)(64756008)(53546011)(66946007)(76116006)(478600001)(66446008)(71200400001)(33656002)(8936002)(54906003)(8676002)(26005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +4JLuMc6l89+sIK9xa/PTS4OeRNjbJdL4Gs+9aOJGv0eawVEz+vZJD9+2EjIWRGO8AqDpHxAJmpNsiwl89JNEsR87qlpQ84+6Ni7+0+0oapQXVPzTEXAazBtdRnLi47g5H5nw9dlS8tF7xCJfrOQgXV4luxsjNKvc9u0vMTr5wBs/9age9RT+MjyKMdT9WNUN+GfUP67m6hA0zbXE1tD2tPPY5SdX+oLgURfKMAE0YcjKPavXzJZiYmbWaY7PmCAMOM74R46Ch+YaeNOM+D4VltDcXOFvFcv9kn9gVwPq++1byDNle9Dbp9yC64D/ur8ib1NEGaqfW7IQ6Cxrg9PAdhurGw/sI9shFePoLMP0WF9xhvRUJ+8g2QdSvmaPVGxKLPkflpLGm/mTAcjBj0CaQSr99fb9bmxs780d1NqJ9vYPLPAMqgLdjwraJMItQXVbeRnH70sL7mYZY34qukBfCbUUMdXNk82PvZT/AnqGzfSYcj96l71zlH8RgljgvlObEaTM2zTs9mMGVAXJkbj30tFuhg/lJ6omqIC1nFaKxF0UDUwN9OpMd+fTrAthhxRNv1//fI4cLpkQNtaU1SWD/FGrPCe7aEUjR6Zcl5vmrLN7z+poDXu7Wy0iraH9uHtwDCCUiTznht4uAkKHkSfGQ==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1beb6a95-286b-422a-4984-08d87ee3a931
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 03:59:13.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D65Te6hNKQb9GbWFwz7xg6xUs3baoN7sKfXckj8I/qw+NmjEOThdLAxJC3i7BNJty4ApUuN5XtrCGiz+cPUV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3370
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2hhd24sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+DQo+IFNlbnQ6IDIwMjDE6jEx1MIxyNUgMTY6NTUNCj4gVG86IFoucS4gSG91IDx6aGlxaWFu
Zy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+
OyBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SHY5XSBhcm02NDogZHRzOiBsYXllcnNjYXBlOiBBZGQgUENJZSBFUCBub2RlIGZvciBsczEwODhh
DQo+IA0KPiBPbiBNb24sIE9jdCAyNiwgMjAyMCBhdCAxMjoyNzo1OVBNICswODAwLCBaaGlxaWFu
ZyBIb3Ugd3JvdGU6DQo+ID4gRnJvbTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+
DQo+ID4NCj4gPiBBZGQgUENJZSBFUCBub2RlIGZvciBsczEwODhhIHRvIHN1cHBvcnQgRVAgbW9k
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5j
b20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZHJldyBNdXJyYXkgPGFuZHJldy5tdXJyYXlAYXJtLmNv
bT4NCj4gPiAtLS0NCj4gPiBWOToNCj4gPiAgLSBSZWJhc2UgdGhlIHBhdGNoIHNpbmNlIFY4IHBh
dGNoIHdhcyBub3QgYWNjZXB0ZWQgZHVlIHRvIGNvbmZsaWN0Lg0KPiA+ICAtIENvcnJlY3QgdGhl
IG51bWJlciBvZiBvdXRib3VuZCB3aW5kb3dzLg0KPiA+ICAtIEFkZCBsYWJsZXMgZm9yIEVQIG5v
ZGVzLg0KPiA+DQo+ID4gIC4uLi9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA4OGEu
ZHRzaSB8IDMxDQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDMx
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHMxMDg4YS5kdHNpDQo+IGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTA4OGEuZHRzaQ0KPiA+IGluZGV4IGZmNTgwNTIwNmEyOC4uOGQ4ZTYxMGFj
YmE2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
czEwODhhLmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wt
bHMxMDg4YS5kdHNpDQo+ID4gQEAgLTUxNyw2ICs1MTcsMTcgQEANCj4gPiAgCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gPiAgCQl9Ow0KPiA+DQo+ID4gKwkJcGNpZV9lcDE6IHBjaWUtZXBAMzQw
MDAwMCB7DQo+ID4gKwkJCWNvbXBhdGlibGUgPSAiZnNsLGxzMTA4OGEtcGNpZS1lcCIsImZzbCxs
cy1wY2llLWVwIjsNCj4gDQo+IE1pc3Npbmcgc3BhY2UgaW4gYmV0d2VlbiBjb21wYXRpYmxlcy4N
CiANCldpbGwgZml4IGluIHYxMC4NCg0KUmVnYXJkcywNClpoaXFpYW5nDQoNCj4gDQo+IFNoYXdu
DQo+IA0KPiA+ICsJCQlyZWcgPSA8MHgwMCAweDAzNDAwMDAwIDB4MCAweDAwMTAwMDAwDQo+ID4g
KwkJCSAgICAgICAweDIwIDB4MDAwMDAwMDAgMHg4IDB4MDAwMDAwMDA+Ow0KPiA+ICsJCQlyZWct
bmFtZXMgPSAicmVncyIsICJhZGRyX3NwYWNlIjsNCj4gPiArCQkJbnVtLWliLXdpbmRvd3MgPSA8
MjQ+Ow0KPiA+ICsJCQludW0tb2Itd2luZG93cyA9IDwyNTY+Ow0KPiA+ICsJCQltYXgtZnVuY3Rp
b25zID0gL2JpdHMvIDggPDI+Ow0KPiA+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJ
CX07DQo+ID4gKw0KPiA+ICAJCXBjaWUyOiBwY2llQDM1MDAwMDAgew0KPiA+ICAJCQljb21wYXRp
YmxlID0gImZzbCxsczEwODhhLXBjaWUiOw0KPiA+ICAJCQlyZWcgPSA8MHgwMCAweDAzNTAwMDAw
IDB4MCAweDAwMTAwMDAwICAgLyogY29udHJvbGxlcg0KPiByZWdpc3RlcnMgKi8NCj4gPiBAQCAt
NTQzLDYgKzU1NCwxNiBAQA0KPiA+ICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAJCX07
DQo+ID4NCj4gPiArCQlwY2llX2VwMjogcGNpZS1lcEAzNTAwMDAwIHsNCj4gPiArCQkJY29tcGF0
aWJsZSA9ICJmc2wsbHMxMDg4YS1wY2llLWVwIiwiZnNsLGxzLXBjaWUtZXAiOw0KPiA+ICsJCQly
ZWcgPSA8MHgwMCAweDAzNTAwMDAwIDB4MCAweDAwMTAwMDAwDQo+ID4gKwkJCSAgICAgICAweDI4
IDB4MDAwMDAwMDAgMHg4IDB4MDAwMDAwMDA+Ow0KPiA+ICsJCQlyZWctbmFtZXMgPSAicmVncyIs
ICJhZGRyX3NwYWNlIjsNCj4gPiArCQkJbnVtLWliLXdpbmRvd3MgPSA8Nj47DQo+ID4gKwkJCW51
bS1vYi13aW5kb3dzID0gPDY+Ow0KPiA+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJ
CX07DQo+ID4gKw0KPiA+ICAJCXBjaWUzOiBwY2llQDM2MDAwMDAgew0KPiA+ICAJCQljb21wYXRp
YmxlID0gImZzbCxsczEwODhhLXBjaWUiOw0KPiA+ICAJCQlyZWcgPSA8MHgwMCAweDAzNjAwMDAw
IDB4MCAweDAwMTAwMDAwICAgLyogY29udHJvbGxlcg0KPiByZWdpc3RlcnMgKi8NCj4gPiBAQCAt
NTY5LDYgKzU5MCwxNiBAQA0KPiA+ICAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAJCX07
DQo+ID4NCj4gPiArCQlwY2llX2VwMzogcGNpZS1lcEAzNjAwMDAwIHsNCj4gPiArCQkJY29tcGF0
aWJsZSA9ICJmc2wsbHMxMDg4YS1wY2llLWVwIiwiZnNsLGxzLXBjaWUtZXAiOw0KPiA+ICsJCQly
ZWcgPSA8MHgwMCAweDAzNjAwMDAwIDB4MCAweDAwMTAwMDAwDQo+ID4gKwkJCSAgICAgICAweDMw
IDB4MDAwMDAwMDAgMHg4IDB4MDAwMDAwMDA+Ow0KPiA+ICsJCQlyZWctbmFtZXMgPSAicmVncyIs
ICJhZGRyX3NwYWNlIjsNCj4gPiArCQkJbnVtLWliLXdpbmRvd3MgPSA8Nj47DQo+ID4gKwkJCW51
bS1vYi13aW5kb3dzID0gPDY+Ow0KPiA+ICsJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICsJ
CX07DQo+ID4gKw0KPiA+ICAJCXNtbXU6IGlvbW11QDUwMDAwMDAgew0KPiA+ICAJCQljb21wYXRp
YmxlID0gImFybSxtbXUtNTAwIjsNCj4gPiAgCQkJcmVnID0gPDAgMHg1MDAwMDAwIDAgMHg4MDAw
MDA+Ow0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
