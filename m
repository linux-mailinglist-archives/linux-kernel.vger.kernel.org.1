Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F69529D6A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731469AbgJ1WRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:06 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:52241
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731441AbgJ1WRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:00 -0400
Received: from DBBPR04MB7595.eurprd04.prod.outlook.com (20.182.199.82) by
 DBBPR04MB6026.eurprd04.prod.outlook.com (20.179.44.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Wed, 28 Oct 2020 22:16:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2HSWSVYJPrf4OfuoBn/WC/hgDmQipX2dBU49sRBMNqgPa0pm83nwNCzhSLaaAItkoscxh7FXBG3HJHnx/7MGqsHaXmVLKY4/B0jrQ00oRflXs1EyYnzgQJeCz0eAcl0UyDsjdw59bWtYHZ3DXEqlq6oaNtPK3d1BQN8549FAXz3FyKg43xcAS3fgSwDQAapzXqBlEEB9sUt4Dbnt2MqWd7Sq4HjEQt/mkgQ1y+Kd0cvZMQQ0Mr+0KdZ/S5XKg+ihnDI7HQuCMfyu9hd9o7v5p/ceQMZBl4AF5uoQX1e1E5agtp49SaUs+AHPZUd3puqpBqW8/iPdR9U+YvDWpkXgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NsxJo7IDr4VvBnCGyBnQBqgtPtkG0KG2oHhvo1+kgE=;
 b=Yv3+PUcnWa4V/nud7c2DWIfDDQvPqB32cF6+OcRZ5fDZ+Z/JgJT0NXr5GTcLDv67APfucNUw6gnXuBKM8TMVxkgEr+kitVaO6vUyb2kx2Xx01x1q24moSez6YJkqcW71GNtYpofCFJsQnNxjYjg2ZIL54uaXdwTy6sg1nweOvxXoNUo/vReN+eU7BJa8yXzi36W+kaC3CM9B1ibp5pzhojsDbL3xHIRq/voZckC/lvt0CuLUzBKjEpYMSo3eOskJiRuDWZhIbtafVLEdKd772dNvrmdpwKyRw7HNmMZU2Rs8kHsbpCK+srakgvfLImh/8V68aHnYI19E1S0D3Ptcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NsxJo7IDr4VvBnCGyBnQBqgtPtkG0KG2oHhvo1+kgE=;
 b=frBtnw2S3ArX5BG/kgqk4MLyu4Bvd2Yq1h8IrukAfcrZJeG41eDzmbvjQToo34rjW//WcLKmcrDbiZNf55siw2Sx9QT7rBFz4HQRTHn09V9DWpMmzIvbdRNRy6wZd82hsL5sDybc5WP/LxrsWQdcQKHGZPHa/GZXscNt94qd0bk=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBBPR04MB7595.eurprd04.prod.outlook.com (2603:10a6:10:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.18; Wed, 28 Oct
 2020 13:57:55 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::ec42:b6d0:7666:19ef%8]) with mapi id 15.20.3499.022; Wed, 28 Oct 2020
 13:57:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        =?utf-8?B?QW5kcsOpIERyYXN6aWs=?= <git@andred.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Enrico Weigelt <info@metux.net>,
        Chris Healy <cphealy@gmail.com>,
        Allison Randal <allison@lohutok.net>
Subject: RE: [PATCH V3 1/3] ARM: imx: use device_initcall for
 imx_soc_device_init
Thread-Topic: [PATCH V3 1/3] ARM: imx: use device_initcall for
 imx_soc_device_init
Thread-Index: AQHWLmwZdO9ywya6E0Ot4FxhX/YA96mt/32AgAAGXbA=
Date:   Wed, 28 Oct 2020 13:57:55 +0000
Message-ID: <DB6PR0402MB276015DA8A27FBA8D1D31DA488170@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1589953889-30955-1-git-send-email-peng.fan@nxp.com>
 <1589953889-30955-2-git-send-email-peng.fan@nxp.com>
 <CAL_Jsq+2X-7=MKA4U8SDDwXWEvfTaiSK-tBUi8hMZKpSR+B-=w@mail.gmail.com>
In-Reply-To: <CAL_Jsq+2X-7=MKA4U8SDDwXWEvfTaiSK-tBUi8hMZKpSR+B-=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 074f8468-8f51-483f-4083-08d87b49786c
x-ms-traffictypediagnostic: DBBPR04MB7595:|DBBPR04MB6026:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBBPR04MB75953D2624C39C74F3B8707D88170@DBBPR04MB7595.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOBuQia0iz/LmuLfarBN1zJJDdHCCotnpIiOxJYatdy+4Ydw5xWdb1/g1sliF0dm0ac9tF6/uQVMCzzUPfsrJ75Db7DbJWbNViXTZjamzyL1e0FltQ6iSD0A1nsNCVZ+Kes1VTp627A36tUVnWSSJ8PPZ8BByEsj+aHjxV9P7PsVOeFHzbSKJ0b3xvyRxzujVSQIZ0AYe7ffyGM7CyI8dKH2qcb7OzhTCpbfRcYUahB5zKLnbRe8k7Vlz6lt7/fOtSITS3z+UdTqAySBZE8jqSX0IXzk/SdnlK6gqCxx+AE5OlxdMfxyhGcbMK9RlHct8oY7dHZEGOwyiRnTEd3EzKLChokkOAep1w2opx64S9MimVPVvuJHamG0w3Mus2jOgvI5Unp9IgS+zDc5n6P8rw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(7696005)(52536014)(54906003)(86362001)(2906002)(76116006)(44832011)(55016002)(4326008)(7416002)(186003)(9686003)(5660300002)(83380400001)(26005)(6506007)(8676002)(53546011)(33656002)(6916009)(71200400001)(8936002)(316002)(66446008)(66556008)(64756008)(478600001)(966005)(66946007)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 66dZoBz4xik5zrzJhMeJJjWncPEth5qQtcQ8SrtaLZOS54QSqag4fXuE1Aey5gCGtxMY33TGeyMIgvns3N3fGQxwZAOxRACOZDlEIR3gli4j5qkWLg6VPyOF8jAPTbDFo7uu/0pWcZ4wgP5b5JTFFY56DCanLB8NjQCrMth1XNmtRkb6e3ZcYf8Sm+gEZDkXdyseIkWYy1KvWedXbVOW2doo9Uq0RD3993o6BKBBQgqliWYlAyXrm/H6EVG9qhkxXuihcYFAYT/obgNMQaCOZ/fkjrCB3/nrAkCY5J3bxZWtOWA62dxpLM4KF9FS9FciSRUtHsjq50XXnjklfaZxQveDULxDPmJHz1VUqsJx0QfpE2jDlyFREovVUYT3mI9RvfNRllRRTy++eB7ZmDAq0Xfqk417W5Oj4x/d6GU+oHzh7wg9+ppBx4GzTcyX8ndLoDAS0ZRdvmRSCckk/BJSMzn7LqWXdzdvl9dk8xucIDLAGs1EgxkfnpQBowI0C5/E8BKsugmuO98IUkTIZ0NT6zIthpL972PeNQMFAYg60a/3oCvDKlsyN503+lAJ8hGkzRBLWtaW4pL24eMEh4LhG0f4a4ihByjioER9uj4KDEHmUaexhON9TDKnWKigDV9nC2c7Yg0za1eJe3l/AkHKuA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074f8468-8f51-483f-4083-08d87b49786c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2020 13:57:55.5164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YWBZKWELj2rJI7a/S7pk5x6J14Bs3HFAy79eBqjqcEdkF9SevZrRolKCP8oeQ3TPgc2gqUw+aFi6JUMeylGPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7595
X-OriginatorOrg: nxp.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS8zXSBBUk06IGlteDogdXNlIGRl
dmljZV9pbml0Y2FsbCBmb3INCj4gaW14X3NvY19kZXZpY2VfaW5pdA0KPiANCj4gT24gV2VkLCBN
YXkgMjAsIDIwMjAgYXQgMTowMSBBTSA8cGVuZy5mYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IFRoaXMgaXMgcHJl
cGFyYXRpb24gdG8gbW92ZSBpbXhfc29jX2RldmljZV9pbml0IHRvIGRyaXZlcnMvc29jL2lteC8N
Cj4gPg0KPiA+IFRoZXJlIGlzIG5vIHJlYXNvbiB0byBtdXN0IHB1dCBkdCBkZXZpY2VzIHVuZGVy
IC9zeXMvZGV2aWNlcy9zb2MwLA0KPiA+IHRoZXkgY291bGQgYWxzbyBiZSB1bmRlciAvc3lzL2Rl
dmljZXMvcGxhdGZvcm0sIHNvIHdlIGNvdWxkIHBhc3MgTlVMTA0KPiA+IGFzIHBhcmVudCB3aGVu
IGNhbGxpbmcgb2ZfcGxhdGZvcm1fZGVmYXVsdF9wb3B1bGF0ZS4NCj4gPg0KPiA+IEZvbGxvd2lu
ZyBzb2MtaW14OC5jIHNvYy1pbXgtc2N1LmMgdXNpbmcgZGV2aWNlX2luaXRjYWxsLCBuZWVkIHRv
DQo+ID4gY2hhbmdlIHJldHVybiB0eXBlIHRvIGludCB0eXBlIGZvciBpbXhfc29jX2RldmljZV9p
bml0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+
DQo+ID4gLS0tDQo+IA0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLWlteC9tYWNoLWlt
eDZxLmMNCj4gPiBiL2FyY2gvYXJtL21hY2gtaW14L21hY2gtaW14NnEuYyBpbmRleCAyODRiY2Ux
MTEyZDIuLjg1YzA4NGE3MTZhYg0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL21hY2gt
aW14L21hY2gtaW14NnEuYw0KPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gtaW14L21hY2gtaW14NnEu
Yw0KPiA+IEBAIC0yNDUsMjEgKzI0NSwxNSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaW14NnFfYXhp
X2luaXQodm9pZCkNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCBfX2luaXQgaW14NnFfaW5pdF9tYWNo
aW5lKHZvaWQpICB7DQo+ID4gLSAgICAgICBzdHJ1Y3QgZGV2aWNlICpwYXJlbnQ7DQo+ID4gLQ0K
PiA+ICAgICAgICAgaWYgKGNwdV9pc19pbXg2cSgpICYmIGlteF9nZXRfc29jX3JldmlzaW9uKCkg
PT0NCj4gSU1YX0NISVBfUkVWSVNJT05fMl8wKQ0KPiA+ICAgICAgICAgICAgICAgICBpbXhfcHJp
bnRfc2lsaWNvbl9yZXYoImkuTVg2UVAiLA0KPiBJTVhfQ0hJUF9SRVZJU0lPTl8xXzApOw0KPiA+
ICAgICAgICAgZWxzZQ0KPiA+ICAgICAgICAgICAgICAgICBpbXhfcHJpbnRfc2lsaWNvbl9yZXYo
Y3B1X2lzX2lteDZkbCgpID8gImkuTVg2REwiIDoNCj4gImkuTVg2USIsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBpbXhfZ2V0X3NvY19yZXZpc2lvbigpKTsNCj4gPg0KPiA+
IC0gICAgICAgcGFyZW50ID0gaW14X3NvY19kZXZpY2VfaW5pdCgpOw0KPiA+IC0gICAgICAgaWYg
KHBhcmVudCA9PSBOVUxMKQ0KPiA+IC0gICAgICAgICAgICAgICBwcl93YXJuKCJmYWlsZWQgdG8g
aW5pdGlhbGl6ZSBzb2MgZGV2aWNlXG4iKTsNCj4gPiAtDQo+ID4gICAgICAgICBpbXg2cV9lbmV0
X3BoeV9pbml0KCk7DQo+ID4NCj4gPiAtICAgICAgIG9mX3BsYXRmb3JtX2RlZmF1bHRfcG9wdWxh
dGUoTlVMTCwgTlVMTCwgcGFyZW50KTsNCj4gPiArICAgICAgIG9mX3BsYXRmb3JtX2RlZmF1bHRf
cG9wdWxhdGUoTlVMTCwgTlVMTCwgTlVMTCk7DQo+IA0KPiBJIGtub3cgdGhpcyBpcyBhbHJlYWR5
IGFwcGxpZWQsIGJ1dCByZWFsbHkgd2Ugd2FudCB0byBnZXQgcmlkIG9mDQo+IG9mX3BsYXRmb3Jt
X2RlZmF1bHRfcG9wdWxhdGUgY2FsbHMgYW5kIGxldCB0aGUgY29yZSBjb2RlIGNhbGwgaXQuIGku
TVggaXMgb25lIG9mDQo+IHRoZSBsYXN0IHJlbWFpbmluZyBwbGF0Zm9ybXMgdG8gZml4Lg0KDQpV
bmRlcnN0YW5kLg0KDQogVGhpcyBvbmUgcmVtYWluZWQgbWFpbmx5IGJlY2F1c2Ugb2YNCj4gJ3Bh
cmVudCcuIExvb2tzIGxpa2UgdGhlcmUncyBzb21lIGluaXRjYWxsIG9yZGVyaW5nIGlzc3VlcyB0
byBmaXggdGhvdWdoLiBNYXliZQ0KPiBtb3ZpbmcgdGhpbmdzIHRvIGluaXRfbGF0ZSB3b3Jrcz8g
SWYgbm90LCBtb3ZpbmcgdGhlIHNldHVwIHRvIGRyaXZlcnMgd291bGQgYmUNCj4gYmV0dGVyIGlm
IHRoZXJlJ3MgYW55IG9yZGVyaW5nIGlzc3VlcyBhcyB3aXRoIGRlZmVycmVkIHByb2JlLCBpbml0
Y2FsbHMgYWxvbmUNCj4gZG9uJ3QgZ3VhcmFudGVlIHRoZSBvcmRlci4NCg0KSSBkaWQgb25lIHBh
dGNoIGJlZm9yZSwgYnV0IGJyZWFrcyBpLk1YNlEgcG0gY29kZSwNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lm96bGFicy5vcmcvcHJvamVjdC9saW51eC1pbXgvcGF0Y2gvDQoyMDE5MDMxMzA5MTc1Ny4xNjQx
MC0xLXBlbmcuZmFuQG54cC5jb20vDQoNCkluZGVlZCB0aGVyZSBhcmUgc29tZSBvcmRlciBpc3N1
ZSwgSSB3aWxsIHRyeSBhZ2FpbiB0byBjbGVhbiB1cCB0aGUgc3R1ZmYuDQoNClRoYW5rcywNClBl
bmcuDQoNCj4gDQo+IFJvYg0K
