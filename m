Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97922A3DF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 08:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgKCHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 02:46:48 -0500
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:56897
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725982AbgKCHqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:46:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kfk693fkImoPkrIvg9eolqU1kEFBxj13kVBpTbpXYmorQ3WOPbGGTeCOU50fbTe9J2hlA5rKf+l9qhK97PS/d0nDTZhhnVzE5ONALyn8yy1+OY3bZD767MXTGu88/hMI3u43ZSNxm6AkPzfebpDsbYgxfNQuMH+o3WKE1zpcDhEKvRDZS5Hao1qgAwV/2LXjEa/VGtdAHVEjZgE1nf8RB4Vg4WGOIf79BZZRmdXJOIk9spBa28Av3LVGGUWfD22Q7ILfbEMHK+dcQrvdwZslyMECuOapv4FTbiKvk/RaX0bptICmYoGoYlCoZo++CoAG0eDuipVH4yuVVpavpM0vGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppwgQYoyFRh9+gx1v2LxYSyETLoL2d7LlE8DgPxUAA8=;
 b=IVgnlcJyyf7atYx2chcUn9a3T7UjOduz2SEMv6HxjUFeef4zvw1k8y3ARhHek+jNpYKV++EyHLrXvi7g5CKyjmWxJioA6d2lvxMZ7HQmA9yYTbNx6g3HdPit9ko0lRM4yu1M4R85DYrw99+pvW2Zxn9T8iCnFA9sqRhEOn1C9Av0143Yyuqheimh/1mtH5ol/MTQSK4e8uIP6lJ8XIGJuTWChLm6YrqyhhQwdbcOZemx49Ik8E6/sNx1TrcIOde13tLqnTeXvUcRdaimqeopnbNKax+arv2b9qMI/xKmBPD7rOJIVu8cRADLOwzFp06Eejn3bIowrmNFiuPLYuKEHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppwgQYoyFRh9+gx1v2LxYSyETLoL2d7LlE8DgPxUAA8=;
 b=k+rARh9FPyxwW73dMxA7l6lxnLNQwqUNQ+wLVcrdOAsF61iQlSALQMYVp/Dhjt+e9Gk83yhBrxqXk758nMMfBWexYMiFpI72H5sk2YEy067Qw0VSWxTGzIT9C6k1P+vRNlc9jrPYMF20gfxkb3f9FgwHwn3rLILeSF0rhtl8bZE=
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15)
 by DB6PR04MB2968.eurprd04.prod.outlook.com (2603:10a6:6:b::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.27; Tue, 3 Nov 2020 07:46:42 +0000
Received: from DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc]) by DB8PR04MB6795.eurprd04.prod.outlook.com
 ([fe80::3c3a:58b9:a1cc:cbcc%8]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 07:46:42 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>
Subject: RE: [PATCH V2] arm64: dts: imx8mp-evk: add CAN support
Thread-Topic: [PATCH V2] arm64: dts: imx8mp-evk: add CAN support
Thread-Index: AQHWsL4hWUKXiNLKlkmYtbnOBP3w26m0guiAgAEZvKCAAGqqgIAAASpg
Date:   Tue, 3 Nov 2020 07:46:42 +0000
Message-ID: <DB8PR04MB67953476E69F68BA5DEEB77AE6110@DB8PR04MB6795.eurprd04.prod.outlook.com>
References: <20201102021634.6480-1-qiangqing.zhang@nxp.com>
 <20201102082853.GB6152@kozik-lap>
 <DB8PR04MB6795A0C0D6F33721311945DCE6110@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <20201103073901.GA3599@kozik-lap>
In-Reply-To: <20201103073901.GA3599@kozik-lap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39939234-4316-4f52-46ca-08d87fcc9b5f
x-ms-traffictypediagnostic: DB6PR04MB2968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR04MB2968011EFA818905D946EFCFE6110@DB6PR04MB2968.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:425;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I6dRB9quxrYQ9pG8G4cSAIHMEYqQ2iLq9fN2usOrxwECfa0+EPBXCUFp8iJDtx6D2TKSpaSx/0NQLd2VO7lrqSB7nV+b4JbOKTAElrMpx4B020mVx86M6RV6Jem0erYBvfX1LNLdW9KcOG3guj2FR0u4uJ6umvgY6MSRHtSAY71NJZ3voRmsloXILTP9pu2/6TnN/1/KhjkZWY3cw6vy33qZudzuSHepWE9k9oCvMmQa39crWlqGBEbqA7jQJZJ04I7A+9t/Jx5eLhjEVcJSEsc/+dWLXrzWb0Or/kNirWHWTslTrdFBWMIfXF/S035dbrOD82gWwcc/4eLke4zPEYzed0ZbzkdJItqOFgfW/QSZx27Jcy0PM5C504FvMpBQAQ+cScCs+1mtWYgTHmymXyzdn3r/hq+4UDTCUE6X+yxrNVWxXxMy2gWL7d8gfPk8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB6795.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(52536014)(26005)(33656002)(110136005)(54906003)(966005)(6506007)(186003)(53546011)(2906002)(83380400001)(478600001)(55016002)(8676002)(64756008)(66446008)(45080400002)(4326008)(5660300002)(316002)(66946007)(71200400001)(86362001)(8936002)(66476007)(66556008)(76116006)(7696005)(9686003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: n9/fSZmvzOVrTG4uWdxc90N/xHqwOoA6xbK1ZelhM9jSJ3vj8TzTvrmq7VpkP5MkonDWsRQ1kx1aswLPaQl6YSnJAhc9wbvuiaH5BjNe63tDdi0dSWRRoQ7nS9XEawYcdiiZbIzqeIPN/xSOPH7CIV5T4y0xpv5Dxc42npPS3pPTUOE8ehjchMclEJWBAd9g3hLIWQVzLjzEzr4drnMifMUJOYk4r62vmzER+auQU3Q+1HhyqvYQzAOXrmDwGUd5DtoKPqVH6JasGjoBNkSjB5SiOgp5H5xfwe6+zue7TJA160+h6oKOulGV7pOb0xS1VwQ/IcfiluwJZzFpygtXpwZ0dkeYOf/BF22lHzEaYDQDWEM4YDJMfXvSuMG7U2sSv9Z8bwqmMdiUKmLWsqT25lL/t8i+px8/HT5UT+x4MLtVhf0x0INi5xwR9rQ7lExCvkOuBdPeF/3tHFY1zULSMIhe+OYBSPWkWK0mMRDcf3NCzTvZ7KK64YsUAS5uPlhiR54tUzG2V7Hn1sL587tD2iI0jHc1Ei/iqXWWPULAVg+G2rgxk8fr+TS8JFjROuYzRlASfKYTmbaFBZCPH0HTOcjv87T43s8Io/hfsA2D3ARm2ZmJJOf2rVXJGMOyLYBeNwdIJPLfW6hGk++pakCWFw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB6795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39939234-4316-4f52-46ca-08d87fcc9b5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 07:46:42.8777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dzdnWaJJZFBbmwI9cVzwcQzseB/8HyrTpldUJ23HlUej8+G5RwTaxbRkSVzeUbQuvAMThQJKvGxcoxa1E7m6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB2968
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyemtAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyMOW5tDEx5pyIM+aXpSAxNTozOQ0KPiBU
bzogSm9ha2ltIFpoYW5nIDxxaWFuZ3FpbmcuemhhbmdAbnhwLmNvbT4NCj4gQ2M6IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsN
Cj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IGRldmljZXRyZWVAdmdlci5rZXJu
ZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG1rbEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIFYyXSBhcm02NDogZHRzOiBpbXg4bXAtZXZrOiBhZGQgQ0FOIHN1cHBvcnQNCj4g
DQo+IE9uIFR1ZSwgTm92IDAzLCAyMDIwIGF0IDAxOjIzOjEyQU0gKzAwMDAsIEpvYWtpbSBaaGFu
ZyB3cm90ZToNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZy
b206IEtyenlzenRvZiBLb3psb3dza2kgPGtyemtAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IDIw
MjDlubQxMeaciDLml6UgMTY6MjkNCj4gPiA+IFRvOiBKb2FraW0gWmhhbmcgPHFpYW5ncWluZy56
aGFuZ0BueHAuY29tPg0KPiA+ID4gQ2M6IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGRsLWxpbnV4LWlteCA8
bGludXgtaW14QG54cC5jb20+OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gPiA+IG1rbEBwZW5ndXRyb25peC5kZQ0KPiA+ID4gU3ViamVjdDogUmU6IFtQ
QVRDSCBWMl0gYXJtNjQ6IGR0czogaW14OG1wLWV2azogYWRkIENBTiBzdXBwb3J0DQo+ID4gPg0K
PiA+ID4gT24gTW9uLCBOb3YgMDIsIDIwMjAgYXQgMTA6MTY6MzRBTSArMDgwMCwgSm9ha2ltIFpo
YW5nIHdyb3RlOg0KPiA+ID4gPiBBZGQgQ0FOIGRldmljZSBub2RlIGFuZCBwaW5jdHJsIG9uIGku
TVg4TVAgZXZrIGJvYXJkLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb2FraW0g
WmhhbmcgPHFpYW5ncWluZy56aGFuZ0BueHAuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gQ2hh
bmdlTG9nczoNCj4gPiA+ID4gVjEtPlYyOg0KPiA+ID4gPiAJKiBhZGQgbWlzc2luZyBzcGFjZSBi
ZWZvcmUgJz0nLA0KPiA+ID4gPiAJZnNsLGNsay1zb3VyY2U9IC9iaXRzLyA4IDwwPiAtPiBmc2ws
Y2xrLXNvdXJjZSA9IC9iaXRzLyA4IDwwPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC1ldmsuZHRzIHwgNjINCj4gPiA+ICsrKysrKysr
KysrKysrKysrKysrDQo+ID4gPiA+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bXAuZHRzaSAgICB8IDMwICsrKysrKysrKysNCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOTIg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMNCj4gPiA+ID4gYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAtZXZrLmR0cw0KPiA+ID4gPiBpbmRleCA5MDhiOTJiYjRk
Y2QuLmIxMGRjZTg3NjdhNCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMNCj4gPiA+ID4gKysrIGIvYXJjaC9hcm02NC9ib290
L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMNCj4gPiA+ID4gQEAgLTMzLDYgKzMzLDI4IEBA
DQo+ID4gPiA+ICAJCSAgICAgIDwweDEgMHgwMDAwMDAwMCAwIDB4YzAwMDAwMDA+Ow0KPiA+ID4g
PiAgCX07DQo+ID4gPiA+DQo+ID4gPiA+ICsJcmVnX2NhbjFfc3RieTogcmVndWxhdG9yLWNhbjEt
c3RieSB7DQo+ID4gPiA+ICsJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gPiA+
ID4gKwkJcmVndWxhdG9yLW5hbWUgPSAiY2FuMS1zdGJ5IjsNCj4gPiA+ID4gKwkJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCj4gPiA+ID4gKwkJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZsZXhj
YW4xX3JlZz47DQo+ID4gPiA+ICsJCXJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+
Ow0KPiA+ID4gPiArCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gPiA+
ID4gKwkJZ3BpbyA9IDwmZ3BpbzUgNSBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiA+ID4gKwkJZW5h
YmxlLWFjdGl2ZS1oaWdoOw0KPiA+ID4gPiArCX07DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlyZWdf
Y2FuMl9zdGJ5OiByZWd1bGF0b3ItY2FuMi1zdGJ5IHsNCj4gPiA+ID4gKwkJY29tcGF0aWJsZSA9
ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiA+ID4gPiArCQlyZWd1bGF0b3ItbmFtZSA9ICJjYW4yLXN0
YnkiOw0KPiA+ID4gPiArCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ID4gPiArCQlw
aW5jdHJsLTAgPSA8JnBpbmN0cmxfZmxleGNhbjJfcmVnPjsNCj4gPiA+ID4gKwkJcmVndWxhdG9y
LW1pbi1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+ID4gPiA+ICsJCXJlZ3VsYXRvci1tYXgtbWlj
cm92b2x0ID0gPDMzMDAwMDA+Ow0KPiA+ID4gPiArCQlncGlvID0gPCZncGlvNCAyNyBHUElPX0FD
VElWRV9ISUdIPjsNCj4gPiA+ID4gKwkJZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPiA+ID4gPiArCX07
DQo+ID4gPiA+ICsNCj4gPiA+ID4gIAlyZWdfdXNkaGMyX3ZtbWM6IHJlZ3VsYXRvci11c2RoYzIg
ew0KPiA+ID4gPiAgCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQo+ID4gPiA+ICAJ
CXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gPiA+IEBAIC00NSw2ICs2NywyMCBAQA0K
PiA+ID4gPiAgCX07DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPg0KPiA+ID4gPiArJmZsZXhjYW4xIHsN
Cj4gPiA+ID4gKwlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ID4gPiArCXBpbmN0cmwt
MCA9IDwmcGluY3RybF9mbGV4Y2FuMT47DQo+ID4gPiA+ICsJeGNlaXZlci1zdXBwbHkgPSA8JnJl
Z19jYW4xX3N0Ynk+Ow0KPiA+ID4gPiArCXN0YXR1cyA9ICJva2F5IjsNCj4gPiA+ID4gK307DQo+
ID4gPiA+ICsNCj4gPiA+ID4gKyZmbGV4Y2FuMiB7DQo+ID4gPiA+ICsJcGluY3RybC1uYW1lcyA9
ICJkZWZhdWx0IjsNCj4gPiA+ID4gKwlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmxleGNhbjI+Ow0K
PiA+ID4gPiArCXhjZWl2ZXItc3VwcGx5ID0gPCZyZWdfY2FuMl9zdGJ5PjsNCj4gPiA+ID4gKwlz
dGF0dXMgPSAiZGlzYWJsZWQiOy8qIGNhbjIgcGluIGNvbmZsaWN0IHdpdGggcGRtICovIH07DQo+
ID4gPiA+ICsNCj4gPiA+ID4gICZmZWMgew0KPiA+ID4gPiAgCXBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7DQo+ID4gPiA+ICAJcGluY3RybC0wID0gPCZwaW5jdHJsX2ZlYz47DQo+ID4gPiA+IEBA
IC0xNDQsNiArMTgwLDMyIEBADQo+ID4gPiA+ICAJCT47DQo+ID4gPiA+ICAJfTsNCj4gPiA+ID4N
Cj4gPiA+ID4gKwlwaW5jdHJsX2ZsZXhjYW4xOiBmbGV4Y2FuMWdycCB7DQo+ID4gPiA+ICsJCWZz
bCxwaW5zID0gPA0KPiA+ID4gPiArCQkJTVg4TVBfSU9NVVhDX1NQRElGX1JYX19DQU4xX1JYICAg
ICAgICAgIDB4MTU0DQo+ID4gPiA+ICsJCQlNWDhNUF9JT01VWENfU1BESUZfVFhfX0NBTjFfVFgg
ICAgICAgICAgMHgxNTQNCj4gPiA+ID4gKwkJPjsNCj4gPiA+ID4gKwl9Ow0KPiA+ID4gPiArDQo+
ID4gPiA+ICsJcGluY3RybF9mbGV4Y2FuMjogZmxleGNhbjJncnAgew0KPiA+ID4gPiArCQlmc2ws
cGlucyA9IDwNCj4gPiA+ID4gKwkJCU1YOE1QX0lPTVVYQ19TQUk1X01DTEtfX0NBTjJfUlgNCj4g
MHgxNTQNCj4gPiA+ID4gKwkJCU1YOE1QX0lPTVVYQ19TQUk1X1JYRDNfX0NBTjJfVFggICAgICAg
ICAweDE1NA0KPiA+ID4gPiArCQk+Ow0KPiA+ID4gPiArCX07DQo+ID4gPiA+ICsNCj4gPiA+ID4g
KwlwaW5jdHJsX2ZsZXhjYW4xX3JlZzogZmxleGNhbjFyZWdncnAgew0KPiA+ID4gPiArCQlmc2ws
cGlucyA9IDwNCj4gPiA+ID4gKwkJCU1YOE1QX0lPTVVYQ19TUERJRl9FWFRfQ0xLX19HUElPNV9J
TzA1ICAweDE1NA0KPiAvKg0KPiA+ID4gQ0FOMV9TVEJZICovDQo+ID4gPiA+ICsJCT47DQo+ID4g
PiA+ICsJfTsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCXBpbmN0cmxfZmxleGNhbjJfcmVnOiBmbGV4
Y2FuMnJlZ2dycCB7DQo+ID4gPiA+ICsJCWZzbCxwaW5zID0gPA0KPiA+ID4gPiArCQkJTVg4TVBf
SU9NVVhDX1NBSTJfTUNMS19fR1BJTzRfSU8yNyAgICAgIDB4MTU0DQo+ID4gPiAvKiBDQU4yX1NU
QlkgKi8NCj4gPiA+ID4gKwkJPjsNCj4gPiA+ID4gKwl9Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICAJ
cGluY3RybF9ncGlvX2xlZDogZ3Bpb2xlZGdycCB7DQo+ID4gPiA+ICAJCWZzbCxwaW5zID0gPA0K
PiA+ID4gPiAgCQkJTVg4TVBfSU9NVVhDX05BTkRfUkVBRFlfQl9fR1BJTzNfSU8xNgkweDE5DQo+
ID4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAu
ZHRzaQ0KPiA+ID4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcC5kdHNp
DQo+ID4gPiA+IGluZGV4IDQ3OTMxMjI5MzAzNi4uZWNjY2ZiYjRmNWFkIDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+ID4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXAuZHRzaQ0KPiA+ID4g
PiBAQCAtNTUyLDYgKzU1MiwzNiBAQA0KPiA+ID4gPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
DQo+ID4gPiA+ICAJCQl9Ow0KPiA+ID4gPg0KPiA+ID4gPiArCQkJZmxleGNhbjE6IGNhbkAzMDhj
MDAwMCB7DQo+ID4gPiA+ICsJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1wLWZsZXhjYW4iLA0K
PiAiZnNsLGlteDZxLWZsZXhjYW4iOw0KPiA+ID4NCj4gPiA+IFVuZG9jdW1lbnRlZCBjb21wYXRp
YmxlIGluDQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Nhbi9m
c2wtZmxleGNhbi50eHQNCj4gPg0KPiA+IEhpIEtyenN6dG9mLA0KPiA+DQo+ID4gWWVzLCBJIHdp
bGwgcmVzZW5kIHRoZSBwYXRjaCBhZnRlciBiZWxvdyBwYXRjaCBnb2VzIGludG8gbWFpbmxpbmUu
IFRoYW5rcy4NCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2su
Y29tLz91cmw9aHR0cHMlM0ElMkYlMkZ3d3cuDQo+ID4NCj4gc3Bpbmljcy5uZXQlMkZsaXN0cyUy
RmxpbnV4LWNhbiUyRm1zZzA0ODk2Lmh0bWwmYW1wO2RhdGE9MDQlN0MwMSU3Q3ENCj4gaWENCj4g
Pg0KPiBuZ3FpbmcuemhhbmclNDBueHAuY29tJTdDMmY5YjJkZjA0ODBmNGRlNjNhNmYwOGQ4N2Zj
YjhhZDglN0M2ODZlYTENCj4gZDNiYw0KPiA+DQo+IDJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0Mw
JTdDMCU3QzYzNzM5OTg1OTQ3MDM1ODEyMyU3Q1Vua25vd24NCj4gJTdDVFdGcGJHDQo+ID4NCj4g
WnNiM2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3
aUxDSlhWQ0k2TQ0KPiBuMCUNCj4gPg0KPiAzRCU3QzEwMDAmYW1wO3NkYXRhPTBEaHhhM3RPWFZz
SHlTVjh3YmxZb09ScHdjdXBHc1p6VGhTZGF1Skg4VA0KPiBNJTNEJmFtcA0KPiA+IDtyZXNlcnZl
ZD0wDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBsaW5rLiBJdCdzIGFsbCBnb29kIGFuZCB0aGVyZSBp
cyBubyBuZWVkIHRvIHJlc2VuZCBiZWNhdXNlIHlvdXINCj4gY29tcGF0aWJsZSBpcyBtZW50aW9u
ZWQgdGhlcmUuDQoNCg0KWWVzLCAiZnNsLGlteDhtcC1mbGV4Y2FuIiBjb21wYXRpYmxlIHN0cmlu
ZyBpcyBtZW50aW9uZWQgdGhlcmUsIHRoZW4gY291bGQgYW55b25lIGFwcGx5IHRoaXMgcGF0Y2g/
IFNoYXduPw0KDQpCZXN0IFJlZ2FyZHMsDQpKb2FraW0gWmhhbmcNCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg==
