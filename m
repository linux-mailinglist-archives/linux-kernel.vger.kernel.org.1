Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CD22BFF19
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgKWEpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:45:20 -0500
Received: from mail-eopbgr80042.outbound.protection.outlook.com ([40.107.8.42]:3260
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726963AbgKWEpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:45:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fB0lnK8ExlUVCNjH4W4eU1U6orQ2Uvks7sOwAbsrDyCYJ+FVUrGsT9yzMFbqirpGM1+WtIjcm7I8N/1Nei+9t2+0z9PomYln2YZr7oVYBWKOduXa5sbMU1/j1RGW7Cl0f0PfE4r28YUzRLbJn3FkBhWRcRMUERq653pzYwZOchyPKid4XlEUFzkyEWO2oAeJFSecfpYSnEE0iw85yESgsaB4shFjoEvOOMD5YBU2HPnXURUI1h2NlZaHGGGII0tzoRtxOvCesf6JKnLorufV2636mzfP0Nfx+/MznXJ8ISVj52gwvSfa1VXcXXH5bVSDdprfcxSj10SvwGzDkadYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4kGkvBZNPOjrdamRjfk24SZmXueBdeuHsbvf0tjWwc=;
 b=jXAeHpA9Ous9m1LxLhkt3FLmS0nYVU04RObxVnu6rWJkGa1I44lpElzLxojVJVhKLSSjZwC2YvLQxVNTSwZETEGokjr2pJYeEkLQ3TYgkoEGUa24cNej/DK3Y7YPCBkWgUmHJtgD3aZyuaRnebL/KJWc3rWHRvBm0FgSJWu5sZTpu6mQ6S9/lSlsijB5L8dxUYVtsxNqWPIgYYXBbtHCQsV6XD/76A19muK9Z/44DfdReilY58uKCLfasMRq5RtGGQ2Zfv3nc0SkxTSzr2WNmOd5fF7zAspBxU4l92Q1d/1/TKl1VFd8Ul4JfqZQz7AHOotjCSKhpZjW7SNQrOOO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4kGkvBZNPOjrdamRjfk24SZmXueBdeuHsbvf0tjWwc=;
 b=lBn/pNy+/+P8hEPu5FoVaF2IRc3rF22zeibOrvLLvk3vsk/fZKAvuTXYTc2MkUqqVqsoxO8V+BdI2YOFeCVPB4xFHyJx7qcSYEKHYazoFB7OGiK6lRBK9XM6l4+eRvVHijdggtdoEsO0/4ROd1cHo2PzJJFqqH9nAZ48AD7iqLk=
Received: from DBBPR04MB6060.eurprd04.prod.outlook.com (2603:10a6:10:c4::14)
 by DB6PR0401MB2582.eurprd04.prod.outlook.com (2603:10a6:4:36::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 04:45:14 +0000
Received: from DBBPR04MB6060.eurprd04.prod.outlook.com
 ([fe80::fc36:c54c:cf0:277f]) by DBBPR04MB6060.eurprd04.prod.outlook.com
 ([fe80::fc36:c54c:cf0:277f%7]) with mapi id 15.20.3564.036; Mon, 23 Nov 2020
 04:45:14 +0000
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
Subject: RE: [EXT] Re: [PATCH v4 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Thread-Topic: [EXT] Re: [PATCH v4 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Thread-Index: AQHWvyVzd7f/3lJfqkukjrmFkfZdlanQ17SAgAROU+A=
Date:   Mon, 23 Nov 2020 04:45:13 +0000
Message-ID: <DBBPR04MB606015EDBC99EF83B434D71AE2FC0@DBBPR04MB6060.eurprd04.prod.outlook.com>
References: <20201120101112.31819-1-alice.guo@nxp.com>
 <20201120105045.GA18581@kozik-lap>
In-Reply-To: <20201120105045.GA18581@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 226bde7b-d387-4f18-1e3c-08d88f6a9175
x-ms-traffictypediagnostic: DB6PR0401MB2582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB2582F8D8ABD2D11954263BB1E2FC0@DB6PR0401MB2582.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RoG7RZsNPKceAHV52ZVZhNmUM8T4BN6kv8eYswD+c2q1h24FMcuQKgP+TmdJGUlIEyMd4zqww6mlP50KYCM4A29XumtI9hjOpwSbMEA0feEhf4TkiTZIUGDX2NLhC+8GM8fcd//lI4gV+5+YdHZynqZ9GXAWin0H++b01yAzvaOxA1+O8mPcquB6e9AALUArJO1Md1PBlr3JG9/IGIsPK8ex0nkVCpXyorzppWYryQ6nunQFF6Kz2BiquwX6jAmA0YRNe30jXBBMnQtYqxsihWY1/CoAt7qqPluRQ5MSdM0uuWgg4WkK+hHy0A67LX5SbqgeoVVmmGbVZjZ+BGGLHcW02czjNoUe2wWr9rol+u81xdeWXpyigt7PQTc82/VT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6060.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(9686003)(86362001)(26005)(7696005)(55016002)(71200400001)(83380400001)(5660300002)(54906003)(6916009)(316002)(66446008)(64756008)(66946007)(66476007)(6506007)(66556008)(53546011)(186003)(8676002)(44832011)(33656002)(4326008)(76116006)(478600001)(2906002)(8936002)(52536014)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NMkvatUStPyaTt99015VYT2xj7bO82x0MJa+mU6A0yG41kVIZvCZo06yYYjCDMsrtSoMDHLpXcmA6VUFnUXKTb9nhi5yznLAxorYdkoxhPvzDv49BM7ZP7Q+FYpdNFobHnynDElVl7tL+TAauIH1y0BwLst5KNCrMArOqLfYRlfdDNKyffKe894CIvobQGd0ARORJehVIfh9KnKzXEyadssQNA15GmrUsPjvSr/2ejxmmyNTqccfc6yAsI7Lb7Pbu2l8QGO0EYCwDWWmz44/qanjNJn4T8a3EiN2WBYoB25y8kXXTqYwM23LXsHvNn9Z8hdGwP+/vUmsbVKrZmOsKBm4qlzjQVSMjTtWjbb0Z6UIJ2oAAOqt2vR8nzDSU9FVZ5BWqKLmeOeBUdpgeIj573xc9FeWOTyFWkjVcstYiU1MurPRHF0bcv7TsXW8PLJVZ7KJDLu3ikx048VA7+O/nGggKEtqFDZY0Tgh6qexC8kG67HCrXNrYkqvC1Io+RTeUydkLQxOjoxNpIhr7ew+tfSh9oyYKG11XZeeD7oESuwDqZxCopiWiGAZCX8zsIMmb2EqIG5VDLRlJHoTunNyYHGTnVO7RQn16XoFbO7UGRIA1W/vTid5O1Lf7d7eCF8qWBY0cRy3jW+8kA5/vGYz/n5Y16afny/OqyZy6qW0TXw17VU5zdZ9bXp/eu40hISFIrntHoXtYpza1t3MFGbLH4Cirthnu0YQW1Dp8ON9G1GTeSNCZNnVWqEN0lLY4tvDtJOgMsPk1stWuoh+Fgrihtr61LN+79jUjSiTPi96BUpblF+LtmO4m5l08DIz4tbjsTXGRcFJL+Ma2foKeHv48ncIu3liTa4OBftbn6RbPFy5+Ku86+SWakXMNYTBOHVP10SZp860TJubbady/yc0dg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6060.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 226bde7b-d387-4f18-1e3c-08d88f6a9175
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 04:45:14.0133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ISsiV6j/Gm0Y4MhlFilgLT8UedO7kBTzFp+gi3FOEjBytOGU5SskS0dfuKLtBavE07eBm4srggQSIDr09DcuMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2582
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTHmnIgyMOaXpSAxODo1MQ0K
PiBUbzogQWxpY2UgR3VvIDxhbGljZS5ndW9AbnhwLmNvbT4NCj4gQ2M6IHJvYmgrZHRAa2VybmVs
Lm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4gZGwt
bGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29t
PjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIIHY0IDEvNF0gZHQtYmluZGluZ3M6IHNvYzogaW14OG06IGFkZCBE
VCBCaW5kaW5nIGRvYw0KPiBmb3Igc29jIHVuaXF1ZSBJRA0KPiANCj4gQ2F1dGlvbjogRVhUIEVt
YWlsDQo+IA0KPiBPbiBGcmksIE5vdiAyMCwgMjAyMCBhdCAwNjoxMTowOVBNICswODAwLCBBbGlj
ZSBHdW8gd3JvdGU6DQo+ID4gQWRkIERUIEJpbmRpbmcgZG9jIGZvciB0aGUgVW5pcXVlIElEIG9m
IGkuTVggOE0gc2VyaWVzLg0KPiA+DQo+ID4gdjI6IHJlbW92ZSB0aGUgc3ViamVjdCBwcmVmaXgg
IkxGLTI1NzEtMSINCj4gPiB2MzogcHV0IGl0IGludG8gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+ICAgICBtb2RpZnkgdGhlIGRlc2NyaXB0aW9uIG9m
IG52bWVtLWNlbGxzDQo+ID4gICAgIHVzZSAibWFrZSBBUkNIPWFybTY0IGR0YnNfY2hlY2siIHRv
IHRlc3QgaXQgYW5kIGZpeCBlcnJvcnMNCj4gPiB2NDogdXNlIGFsbE9mIHRvIGxpbWl0IG5ldyB2
ZXJzaW9uIERUUyBmaWxlcyBmb3IgaS5NWDhNIHRvIGluY2x1ZGUNCj4gPiAgICAgImZzbCxpbXg4
bW0vbi9wL3Etc29jIiwgbnZtZW0tY2VsbHMgYW5kIG52bWVtLWNlbGxzLW5hbWVzDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiA+IC0tLQ0K
PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwgICAgICAgICAgfCA1MQ0K
PiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MSBpbnNlcnRpb25z
KCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL2FybS9mc2wueWFtbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2FybS9mc2wueWFtbA0KPiA+IGluZGV4IDY3OTgwZGNlZjY2ZC4uZDgwNDgzMjNhMjkwIDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlh
bWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2ZzbC55
YW1sDQo+ID4gQEAgLTkxOCw2ICs5MTgsNTcgQEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgICAg
ICAgICAtIGZzbCxzMzJ2MjM0LWV2YiAgICAgICAgICAgIyBTMzJWMjM0LUVWQjIgQ3VzdG9tZXIN
Cj4gRXZhbHVhdGlvbiBCb2FyZA0KPiA+ICAgICAgICAgICAgLSBjb25zdDogZnNsLHMzMnYyMzQN
Cj4gPg0KPiA+ICsgIHNvYzoNCj4gPiArICAgIHR5cGU6IG9iamVjdA0KPiA+ICsgICAgcHJvcGVy
dGllczoNCj4gPiArICAgICAgY29tcGF0aWJsZToNCj4gPiArICAgICAgICBvbmVPZjoNCj4gPiAr
ICAgICAgICAgIC0gZGVzY3JpcHRpb246IG5ldyB2ZXJzaW9uIGNvbXBhdGlibGUgZm9yIGkuTVg4
TSBTb0NzDQo+ID4gKyAgICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAgIC0gZW51
bToNCj4gPiArICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1tLXNvYw0KPiA+ICsgICAgICAg
ICAgICAgICAgICAtIGZzbCxpbXg4bW4tc29jDQo+ID4gKyAgICAgICAgICAgICAgICAgIC0gZnNs
LGlteDhtcC1zb2MNCj4gPiArICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1xLXNvYw0KPiA+
ICsgICAgICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCj4gPiArDQo+ID4gKyAgICAgICAg
ICAtIGRlc2NyaXB0aW9uOiBvbGQgdmVyc2lvbiBjb21wYXRpYmxlIGZvciBpLk1YOE0gU29Dcw0K
PiA+ICsgICAgICAgICAgICBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiBzaW1w
bGUtYnVzDQo+ID4gKw0KPiA+ICsgICAgICBudm1lbS1jZWxsczoNCj4gPiArICAgICAgICBtYXhJ
dGVtczogMQ0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBQaGFuZGxlIHRvIHRoZSBTT0MgVW5p
cXVlIElEIHByb3ZpZGVkIGJ5IGEgbnZtZW0NCj4gPiArIG5vZGUNCj4gPiArDQo+ID4gKyAgICAg
IG52bWVtLWNlbGxzLW5hbWVzOg0KPiA+ICsgICAgICAgIGNvbnN0OiBzb2NfdW5pcXVlX2lkDQo+
ID4gKw0KPiA+ICsgICAgYWxsT2Y6DQo+IA0KPiBOb3RoaW5nIGNoYW5nZWQgaGVyZSBjb21wYXJp
bmcgdG8gcHJldmlvdXMgdmVyc2lvbi4gU3RpbGwgZG9lcyBub3Qgd29yay4NCj4gDQo+IFRoZSBh
bGxPZiBzaG91bGQgbm90IGJlIHBhcnQgb2Ygc29jIG5vZGUgYmVjYXVzZSB0aGUgImlmIiBiZWxv
dyB3b24ndCBtYXRjaC4NCj4gSW5zdGVhZCwgaXQgc2hvdWxkIGJlIGFnYWluc3Qgcm9vdCBub2Rl
Lg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KSSdtIHNvcnJ5IHRvIGRpc3R1
cmIgeW91LiBJIGRvbid0IHZlcnkgY2xlYXIgYWJvdXQgdGhlIGdyYW1tYXIgcnVsZXMgb2YgeWFt
bCwgc28gZG9uJ3Qga25vdyBob3cgdG8gbWFrZSBhbGxPZiBiZSBwYXJ0IG9mIHJvb3Qgbm9kZS4N
CklmIGFsbG9mIGlzIHBhcnQgb2Ygcm9vdCBub2RlLCBob3cgZG9lcyBpdCBzcGVjaWZ5IHRoZSBz
b2Mgbm9kZT8gVGhlIGZvbGxvd2luZyBpcyBteSBjaGFuZ2Ugd2hpY2ggaXMgZGVmaW5pdGVseSB3
cm9uZy4NCiAgc29jOg0KICAgIHByb3BlcnRpZXM6DQogICAgICBjb21wYXRpYmxlOg0KICAgICAg
ICAtIGRlc2NyaXB0aW9uOiBuZXcgdmVyc2lvbiBjb21wYXRpYmxlIGZvciBpLk1YOE0gU29Dcw0K
ICAgICAgICAgIGl0ZW1zOg0KICAgICAgICAgICAgLSBlbnVtOg0KICAgICAgICAgICAgICAgIC0g
ZnNsLGlteDhtbS1zb2MNCiAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bW4tc29jDQogICAgICAg
ICAgICAgICAgLSBmc2wsaW14OG1wLXNvYw0KICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtcS1z
b2MNCiAgICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCg0KICAgICAgbnZtZW0tY2VsbHM6
DQogICAgICAgIG1heEl0ZW1zOiAxDQogICAgICAgIGRlc2NyaXB0aW9uOiBQaGFuZGxlIHRvIHRo
ZSBTT0MgVW5pcXVlIElEIHByb3ZpZGVkIGJ5IGEgbnZtZW0gbm9kZQ0KDQogICAgICBudm1lbS1j
ZWxscy1uYW1lczoNCiAgICAgICAgY29uc3Q6IHNvY191bmlxdWVfaWQNCg0KYWxsT2Y6DQogIC0g
aWY6DQogICAgICBwcm9wZXJ0aWVzOg0KICAgICAgICBjb21wYXRpYmxlOg0KICAgICAgICAgIGNv
bnRhaW5zOg0KICAgICAgICAgICAgZW51bToNCiAgICAgICAgICAgICAgLSBmc2wsaW14OG1tDQog
ICAgICAgICAgICAgIC0gZnNsLGlteDhtbg0KICAgICAgICAgICAgICAtIGZzbCxpbXg4bXANCiAg
ICAgICAgICAgICAgLSBmc2wsaW14OG1xDQoNCiAgICAgIHRoZW46DQogICAgICAgIHJlcXVpcmVk
Og0KICAgICAgICAgIC0gc29jDQoNClBsZWFzZSBnaXZlIG1lIHN1Z2dlc3Rpb24uIFRoYW5rIHlv
dS4NCkJlc3QgcmVnYXJkcywNCkFsaWNlIEd1bw0KDQo+ID4gKyAgICAgIC0gaWY6DQo+ID4gKyAg
ICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlOg0KPiA+ICsg
ICAgICAgICAgICAgIGNvbnRhaW5zOg0KPiA+ICsgICAgICAgICAgICAgICAgZW51bToNCj4gPiAr
ICAgICAgICAgICAgICAgICAgLSBmc2wsaW14OG1tDQo+ID4gKyAgICAgICAgICAgICAgICAgIC0g
ZnNsLGlteDhtbg0KPiA+ICsgICAgICAgICAgICAgICAgICAtIGZzbCxpbXg4bXANCj4gPiArICAg
ICAgICAgICAgICAgICAgLSBmc2wsaW14OG1xDQo+ID4gKw0KPiA+ICsgICAgICAgIHRoZW46DQo+
ID4gKyAgICAgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlOg0K
PiA+ICsgICAgICAgICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAgICAgLSBlbnVtOg0K
PiA+ICsgICAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtbS1zb2MNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAtIGZzbCxpbXg4bW4tc29jDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgLSBm
c2wsaW14OG1wLXNvYw0KPiA+ICsgICAgICAgICAgICAgICAgICAgIC0gZnNsLGlteDhtcS1zb2MN
Cj4gPiArICAgICAgICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCj4gPiArDQo+ID4gKyAg
ICAgICAgICByZXF1aXJlZDoNCj4gPiArICAgICAgICAgICAgLSBudm1lbS1jZWxscw0KPiA+ICsg
ICAgICAgICAgICAtIG52bWVtLWNlbGxzLW5hbWVzDQo+ID4gKw0KPiA+ICBhZGRpdGlvbmFsUHJv
cGVydGllczogdHJ1ZQ0KPiA+DQo+ID4gIC4uLg0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
