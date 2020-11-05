Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721712A7E72
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgKEMTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:19:50 -0500
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:26880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728371AbgKEMTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:19:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2STEtRI05wzdShFZ8yGuPBKTIsVgNbUTcb4YzxP7cjyNlYd0rxn6wKDoRu0lwOL15hunALiXoRnDt+fvrw7pJKf5envk3WOoES5Eci+UQ1ezGhWjAYoGmLIlv57Rbf9RWiP0kFbwilJJWMwZtqNuBm9yi9lyHxjKPtB2WkeJ2mAchCZf+QTTGo+mSkOgMHZ7y5vAPvrBFwwQgADVcFDJGEgnDMrqEcgG0Pipm0LWSBZLmJbh3g7JD0P/EWX6w4aVsI+cjR+cRUfbc6ypfhfuVJa8HwbUiFUDpVQWQGkOt9+ZJcjdat5mDE8S5UI+JaDCZgM+uAa5UdslxcYqDrAlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfmfHNlVqXlrfI58QYAW348TVPZHpHwzMKam3L9SVW0=;
 b=JhreztLyIkgUjXRv14aX1OqlQmsITsROEGd7TX9xhZghyi1YbjXRmgY4Z0srFUxNDgUBJlM9p5O9fX7MFh4ddNniu7eI0xJQMvq8kX9bsNp/ZCOfc4HWZYYPM+HX71v78oOJHcESK+BkDFXR+r8xIOxY1x127v5amVXxlXgp50wKIvbbAB0tCK78LYuTcgCbSaEaPnxWopgHfi6XZPluWmGWdPT9yLVzxSGZlFJq4HrrwkWuAxTfZZfzHrga/YeY9qwSN3zaJ786prVtNlAVm7dW/fx7yChwvO+7B367wyBHsLnJmboyXEP1MRmGO0RKnq7d753Qth20lTZFWa+Fvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfmfHNlVqXlrfI58QYAW348TVPZHpHwzMKam3L9SVW0=;
 b=OmW1y7RjVpDt8O9cxnpvLyqhiP7tX/nljHT8ChTc6in5CFGJue3a4NwEU7RopfLpFrhNfVfcz0+aoI0DTKaKhFYsRnEXASQ+loqEHtnPSuopS1Oveb7fg1edcmu07e9G2aSdr6D6s0k3JQG7RGMIqXoQ5OU1L06WT5NJr9h8tDY=
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8)
 by VI1PR04MB4256.eurprd04.prod.outlook.com (2603:10a6:803:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Thu, 5 Nov
 2020 12:19:46 +0000
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944]) by VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944%7]) with mapi id 15.20.3541.021; Thu, 5 Nov 2020
 12:19:46 +0000
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
Subject: RE: [EXT] Re: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Thread-Topic: [EXT] Re: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding
 doc for soc unique ID
Thread-Index: AQHWs0T4Hxw5cEEm+0a41i6AANocvqm5M/eAgABACcA=
Date:   Thu, 5 Nov 2020 12:19:45 +0000
Message-ID: <VI1PR04MB707134F5D01274A91E1CC878E2EE0@VI1PR04MB7071.eurprd04.prod.outlook.com>
References: <20201105072629.24175-1-alice.guo@nxp.com>
 <20201105082543.GA17569@kozik-lap>
In-Reply-To: <20201105082543.GA17569@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e00d9870-5c57-4143-32eb-08d88185154a
x-ms-traffictypediagnostic: VI1PR04MB4256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB42566F64BA72DEA86AC7650AE2EE0@VI1PR04MB4256.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gm2uB9YGnUWXOGN+fLKVLzU/Eqi7lJ2GubGg3k8ZEo5vu4twiw6pmHsHh4+lwF28lFAKXqWXE3dp7vJwz7qpnD1Nx1SFQ7ePTiOfoTNjXBIQNN3nsvDIY9Zm/eU/zejspk7l5+5mgKrFAPCAKOYl8R/VZ6a2zwHleaumjlYIqF+zN16dvoU2qUY+DoSu8DhxpjW/wKmcuRx2qItTN0lpX2vtVJnXPnGaZABPSbLkd/xmO+5ZksPAkTOJ8/x9QnEl5sOlr9xnd7CEtvhamGqHNu9P6Y2fw6HlhD0sbV0yRfYdCLTLhA5wk7k3ITP8pRpxdjpD0mcwpPJ+pWhnxRnUFB1YGSFqCsY+6tdotTiLCWehwwFk1SGU7H3SwvvMsBwk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(76116006)(66476007)(64756008)(66446008)(55016002)(66556008)(83380400001)(66946007)(86362001)(2906002)(9686003)(52536014)(26005)(186003)(54906003)(478600001)(44832011)(71200400001)(8676002)(8936002)(316002)(6506007)(6916009)(53546011)(4326008)(33656002)(7696005)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: HMQog8P7yWUATQpp1CleVYNOFqOxgFUe13FTOFVMZR3CKtASyY60FTiK2K20JF9iUTx0YvegRAT+OPqUgyW1mlHjomKD0iJaJH39iUDQ99z/1NzuCwQGw6tKfe14Yp8QGY0BMxPn+/DaA8u6lb99xNI4dww88o/+5paVgXh31fWBtTN49inth0Sa2c3yXiEvE3TJTiNDQavstnYsjJQWw4PVKiCF6vZHqsO26vpw0WakCeES66gR16S6P68E9qcN76rIdIAFXsvc1Rbw0RYDGGvXuAcIl5drQtWzp1fBF69iWlidr8OUxjPpaiOGcDKLdyA8o8X1ZUx+amTsAtS3j2ID57te9l4rxLs9JYfP/cQV5YFIgkMU0yw0iSAoI7zivY3ZG1QiPXg9cTIA0l+s7EYnpfmOQ7572DuvHoG2K57rbs5Waqarru+3ETXKEtV3/kNBH4HJvJRnZAmDLvTnjJ7513EuosL/xaD7T2EhlXJw7ikzfYyiZtOwp2679Qq96vk6PgG9Ch+M8iO2sNJjDILuKVFmBUA3/GMPa/W9jAad2UMzgfeDDnxTnw0MtW7Tj9SSf+Erve2RUk0KP6TiBE1Gj740YozfnaM8oHR2BzwWZZ09i3LTMG5NVNz+pa8D+T7AdnNSug7TQP5bVMRZ/w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e00d9870-5c57-4143-32eb-08d88185154a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 12:19:45.9488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cp3hvydrEYuQBTXz6Cj30Bfg/slCX/503XLBeeDe/9kh6HFAOWH2JsZ0qkDZUQbmgCygWZs3H2ebWaZpPXXt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTHmnIg15pelIDE2OjI2DQo+
IFRvOiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiBDYzogcm9iaCtkdEBrZXJuZWwu
b3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBkbC1s
aW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IFN1YmplY3Q6
IFtFWFRdIFJlOiBbUEFUQ0ggdjIgMS80XSBkdC1iaW5kaW5nczogc29jOiBpbXg4bTogYWRkIERU
IEJpbmRpbmcgZG9jDQo+IGZvciBzb2MgdW5pcXVlIElEDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1h
aWwNCj4gDQo+IE9uIFRodSwgTm92IDA1LCAyMDIwIGF0IDAzOjI2OjI2UE0gKzA4MDAsIEFsaWNl
IEd1byB3cm90ZToNCj4gPiBBZGQgRFQgQmluZGluZyBkb2MgZm9yIHRoZSBVbmlxdWUgSUQgb2Yg
aS5NWCA4TSBzZXJpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNl
Lmd1b0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
ZnNsLnlhbWwgICAgICAgICAgfCAzMw0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnNsLnlhbWwNCj4gPiBpbmRleCBlNGRiMGY5ZWQ2
NjQuLjA0MTlmMDc4NTAyYiAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvYXJtL2ZzbC55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbA0KPiA+IEBAIC05MDEsNiArOTAxLDM5IEBAIHByb3Bl
cnRpZXM6DQo+ID4gICAgICAgICAgICAgICAgLSBmc2wsczMydjIzNC1ldmIgICAgICAgICAgICMg
UzMyVjIzNC1FVkIyIEN1c3RvbWVyDQo+IEV2YWx1YXRpb24gQm9hcmQNCj4gPiAgICAgICAgICAg
IC0gY29uc3Q6IGZzbCxzMzJ2MjM0DQo+ID4NCj4gPiArICBzb2M6DQo+ID4gKyAgICBkZXNjcmlw
dGlvbjoNCj4gPiArICAgICAgaS5NWDhNIEZhbWlseSBTb0MgbXVzdCBwcm92aWRlIGEgc29jIG5v
ZGUgaW4gdGhlIHJvb3Qgb2YgdGhlIGRldmljZQ0KPiB0cmVlLA0KPiA+ICsgICAgICByZXByZXNl
bnRpbmcgdGhlIFN5c3RlbS1vbi1DaGlwIHNpbmNlIHRoZXNlIHRlc3QgY2hpcHMgYXJlIHJhdGhl
cg0KPiBjb21wbGV4Lg0KPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4gKyAgICBwcm9wZXJ0aWVz
Og0KPiA+ICsgICAgICBjb21wYXRpYmxlOg0KPiA+ICsgICAgICAgIG9uZU9mOg0KPiA+ICsgICAg
ICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14OG1tLXNv
Yw0KPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCj4gPiArICAgICAgICAg
IC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAgICAgLSBjb25zdDogZnNsLGlteDhtbi1zb2MNCj4g
PiArICAgICAgICAgICAgICAtIGNvbnN0OiBzaW1wbGUtYnVzDQo+ID4gKyAgICAgICAgICAtIGl0
ZW1zOg0KPiA+ICsgICAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXg4bXAtc29jDQo+ID4gKyAg
ICAgICAgICAgICAgLSBjb25zdDogc2ltcGxlLWJ1cw0KPiA+ICsgICAgICAgICAgLSBpdGVtczoN
Cj4gPiArICAgICAgICAgICAgICAtIGNvbnN0OiBmc2wsaW14OG1xLXNvYw0KPiA+ICsgICAgICAg
ICAgICAgIC0gY29uc3Q6IHNpbXBsZS1idXMNCj4gPiArDQo+ID4gKyAgICAgIG52bWVtLWNlbGxz
Og0KPiA+ICsgICAgICAgIG1heEl0ZW1zOiAxDQo+ID4gKyAgICAgICAgZGVzY3JpcHRpb246IFBo
YW5kbGUgdG8gdGhlIFNPQyBVbmlxdWUgSUQgcHJvdmlkZWQgYnkgYSBudm1lbQ0KPiBub2RlDQo+
ID4gKw0KPiA+ICsgICAgICBudm1lbS1jZWxscy1uYW1lczoNCj4gPiArICAgICAgICBjb25zdDog
c29jX3VuaXF1ZV9pZA0KPiA+ICsNCj4gPiArICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAtIGNv
bXBhdGlibGUNCj4gPiArICAgICAgLSBudm1lbS1jZWxscw0KPiA+ICsgICAgICAtIG52bWVtLWNl
bGwtbmFtZXMNCj4gPiArDQo+IA0KPiBEaWQgeW91IGFjdHVhbGx5IHRlc3QgaXQ/IEkgc2VlIG11
bHRpcGxlIGVycm9ycyB3aXRoIHRoaXMgcGF0Y2guDQo+IGZzbC1sczEwMTJhLWZyZG0uZHQueWFt
bDogLzogc29jOmNvbXBhdGlibGU6IFsnc2ltcGxlLWJ1cyddIGlzIG5vdCB2YWxpZCB1bmRlciBh
bnkNCj4gb2YgdGhlIGdpdmVuIHNjaGVtYXMNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6
dG9mDQoNCg0KW0FsaWNlIEd1b10gU29ycnkuIEkgZGlkIG5vdCBzZWUgZXJyb3JzIHdoYXQgeW91
IHNhaWQuIENhbiB5b3UgdGVsbCBtZSBob3cgZGlkIHlvdSB0ZXN0IGl0Pw0KDQpCZXN0IHJlZ2Fy
ZHMsDQpBbGljZSBHdW8NCg0K
