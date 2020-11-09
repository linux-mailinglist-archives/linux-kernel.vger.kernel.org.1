Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEE2AB82F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgKIM1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:27:00 -0500
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:41206
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729045AbgKIM1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:27:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEuOxST8Rj/v2PTJLEjrd0Ws4mxgXA698q3iKnh5VirC6/YUqXolf5GaVdaf6mp8unwJAfK7y0TAQmAF9w6+S5FeOO52Be81IP3jIfgv3gyMcQGUTVAj498e86lBFb5jubyo3rpau0fnS48cKBp7Gjgxb7Dr9q5otC2PCQgBlufNMB396JmWpjyWt87SZDl8mdvqXRyUItXBXJTIaqYQwUNLDSV1IAjf6oedjHCJP68Y1z2JtE19R1ymlxZDo0Jb4S1NBPHcNhschgPJOhrB5xomSjPgEy3Ksg0EefuRt1D6bSUAGU0/kzXu5oVb43aCaBf5xsJD4Yu102X4insazQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlpWIAJ1a/wYwqX7X0qyHhu8O0QJ31XQRYGpe4LAqB8=;
 b=EUxl2u5YvkyErXSQSY+sdbgcmPbNHdQNJL5GxlI/se6KYp3rYL9cn8QThZbpW+/5LHoersDlksGnhnB4r6LdBfTuL+cpDG3A0tAy34wTQBIy9CCbmmh5mlc8tu/0f2/M1Qh5v4QsK6wF6Y3+eSXQPgR+7IPGct1xbkZNkKsyO4/XXPOnVqWrIgS787pHD7YaoKXaO5pu74hBrbvBVSciC7ro4VbgwAV9vG675wI18JyzN1hvD902xuTbUmEej1FDdZyP/IOwihzkEKyuQs2gz7sAW/sGvCnCgEo0nislJ5jA4gnRDqzC+MFS8U5PMVFmlJyxzACRU0RDn0Y38ddLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlpWIAJ1a/wYwqX7X0qyHhu8O0QJ31XQRYGpe4LAqB8=;
 b=NO8B9pLzMOZKo0FOgMQiDpQtCdMamH0i8TNKHvEkjYBR/MswiLAE/CVtdAh/twBELylEuGyTZGqfa7npH/22TJUYFUDD6kpqYRiyy3bS1eP9LqK0g9dThu0FAczH3sHtkXd1zwK4UxqOLPIefy5wV1gVsZ3izmjTnjZ28qTdB60=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3671.eurprd04.prod.outlook.com (2603:10a6:209:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Mon, 9 Nov
 2020 12:26:56 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 12:26:56 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH RESEND] driver core: export device_is_bound() to fix build
 failure
Thread-Topic: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Thread-Index: AQHWtVhC0iFw3JVhoky1GSU0i1GD9am95iCAgAGxewCAAAY6gIAAATqAgAAQwoCAAAN9YIAAAygAgAAB+uA=
Date:   Mon, 9 Nov 2020 12:26:55 +0000
Message-ID: <AM6PR04MB49668F60F74B73931C2ABBFD80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
 <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109114125.GC1769924@kroah.com>
 <AM6PR04MB4966F12B67C4104247E0E6A180EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201109120512.GB1832201@kroah.com>
In-Reply-To: <20201109120512.GB1832201@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7919af21-fefb-4567-856e-08d884aabf40
x-ms-traffictypediagnostic: AM6PR0402MB3671:
x-microsoft-antispam-prvs: <AM6PR0402MB36711FE74A5B15F6E0F6DAA780EA0@AM6PR0402MB3671.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PWL8pS6d0iL/MbHVPhHVeqZkNtLlN1drcP3N8VQiOK76d5ULSnxresjxPnfiFp4RSGdobxVTB1rKRqZQ4cd2OMLH3NaCN83V9tsA7klbozfmP8py7w9Cnb/rrdCkos6Jc1ljR/1gcUrTcGaMfz15Igi/GGbR89W/C0ZR/8NRnEAQ23KaynpSUG00NEYsuCvMgYE2WA4ymU01JG4QIJHfGQw9EsZNdxeLVCGnFY6AKwr+fAwuqTbvkQB3uY+dRgWg9JTKw+IOsZTSfgGKxc4MN73aKCW9XnXAUBv9sNbx21b1D/BhuSoFkNta7ToECvV7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(8676002)(26005)(4326008)(316002)(86362001)(9686003)(2906002)(83380400001)(66946007)(66476007)(53546011)(71200400001)(6916009)(8936002)(52536014)(76116006)(5660300002)(64756008)(66446008)(478600001)(186003)(54906003)(55016002)(44832011)(6506007)(7696005)(33656002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tMeKTC462a6RKRlWRK9geYutu+tZz9qjce1jPSRmt4uWKNbZuc+UMIDx8efEostZ/6f59v1KaKJQKEG8kHGxzP7tAHvVa6tMilNOC5FDNK/WnYBAOr6yYnx2M9n+0uVit6DxRuOKCPN9gRZ7wSGj7l+NidPX0oJU0MjoMlyXPYpqBWsgz+TmHyXbs1foaHJGjCf8xiAKlVOFE6/ZnzpVNRTMftT/zo0bKAn+t681PtjGpdg9Rqw+CscqeLJQ0ir2R784bGcuTRKyVje68kKLYoYgGOKX9sE6RukyFFZrlHGzI0ZNwOnOP/aaOwysSOeVYf0ChnBviw9fPEeuvRpSw7oeZo7cmFVAmKIw66R0T+Ejw1bjyrXA8aULjKEown6UZM4RxEHulsGKzAFOHbs7ZNAmxyX0hkM8PSFaAnljS5To2u2qHwuS6fWmUyt6h29+2oXO9FbIckkJwhfmEMVJaGXKkSP9nGCsP98ZAu8BayI4cKFaqODxd1vOSiYqDFE2lo7OcaVztEWTuOROD1EZnpFEv3Y+SkM0CeTW7Hsm9QXKZTxgr/4FGcmfA9cBuupSUghTAViZvLj2vi5Co2hk48cLYLk/YjUnsACy9ZahYBjexiFpfXC+y5lin92dAQFPuDmidjzU0IABhgFAlE2pig==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7919af21-fefb-4567-856e-08d884aabf40
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 12:26:55.9929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U20MziIxVGabXFmi4FhfHcaC7tYR2av98RRT0LbvVjRGnrH8iFxFYGCp5OVs7jWgWKuJuXkmMXG0CBTbzbeUXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3671
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiBTZW50OiBNb25kYXksIE5vdmVtYmVyIDksIDIwMjAgODowNSBQTQ0KPiANCj4gT24gTW9uLCBO
b3YgMDksIDIwMjAgYXQgMTE6NTU6NDZBTSArMDAwMCwgQWlzaGVuZyBEb25nIHdyb3RlOg0KPiA+
ID4gRnJvbTogR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4N
Cj4gPiA+IFNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgOSwgMjAyMCA3OjQxIFBNDQo+ID4gPg0KPiA+
ID4gT24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMTA6NTc6MDVBTSArMDAwMCwgQWlzaGVuZyBEb25n
IHdyb3RlOg0KPiA+ID4gPiBIaSBHcmVnLA0KPiA+ID4gPg0KPiA+ID4gPiA+IEZyb206IEdyZWcg
S3JvYWgtSGFydG1hbiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiA+ID4gU2Vu
dDogTW9uZGF5LCBOb3ZlbWJlciA5LCAyMDIwIDY6MzcgUE0NCj4gPiA+ID4gPiBTdWJqZWN0OiBS
ZTogW1BBVENIIFJFU0VORF0gZHJpdmVyIGNvcmU6IGV4cG9ydA0KPiA+ID4gPiA+IGRldmljZV9p
c19ib3VuZCgpIHRvIGZpeCBidWlsZCBmYWlsdXJlDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBN
b24sIE5vdiAwOSwgMjAyMCBhdCAxMDoxNDo0NkFNICswMDAwLCBTdWRpcCBNdWtoZXJqZWUgd3Jv
dGU6DQo+ID4gPiA+ID4gPiBIaSBHcmVnLA0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uIFN1
biwgTm92IDgsIDIwMjAgYXQgODoyMyBBTSBHcmVnIEtyb2FoLUhhcnRtYW4NCj4gPiA+ID4gPiA+
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+DQo+ID4g
PiA+ID4gPiA+IE9uIFNhdCwgTm92IDA3LCAyMDIwIGF0IDEwOjQ3OjI3UE0gKzAwMDAsIFN1ZGlw
IE11a2hlcmplZSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBXaGVuIENPTkZJR19NWENfQ0xLX1ND
VSBpcyBjb25maWd1cmVkIGFzICdtJyB0aGUgYnVpbGQNCj4gPiA+ID4gPiA+ID4gPiBmYWlscyBh
cyBpdCBpcyB1bmFibGUgdG8gZmluZCBkZXZpY2VfaXNfYm91bmQoKS4gVGhlIGVycm9yIGJlaW5n
Og0KPiA+ID4gPiA+ID4gPiA+IEVSUk9SOiBtb2Rwb3N0OiAiZGV2aWNlX2lzX2JvdW5kIg0KPiBb
ZHJpdmVycy9jbGsvaW14L2Nsay1pbXgtc2N1LmtvXQ0KPiA+ID4gPiA+ID4gPiA+ICAgICAgIHVu
ZGVmaW5lZCENCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IEV4cG9ydCB0aGUgc3lt
Ym9sIHNvIHRoYXQgdGhlIG1vZHVsZSBmaW5kcyBpdC4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gPiA+IEZpeGVzOiA3N2Q4ZjMwNjhjNjMgKCJjbGs6IGlteDogc2N1OiBhZGQgdHdvIGNl
bGxzIGJpbmRpbmcNCj4gPiA+ID4gPiA+ID4gPiBzdXBwb3J0IikNCj4gPiA+ID4gPiA+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBTdWRpcCBNdWtoZXJqZWUNCj4gPiA+ID4gPiA+ID4gPiA8c3VkaXBtLm11
a2hlcmplZUBnbWFpbC5jb20+DQo+ID4gPiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+ID4gPiByZXNlbmRpbmcgd2l0aCB0aGUgRml4ZXM6IHRhZy4NCj4gPiA+ID4g
PiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ICBkcml2ZXJzL2Jhc2UvZGQuYyB8IDEgKw0KPiA+ID4g
PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGQuYyBiL2RyaXZl
cnMvYmFzZS9kZC5jIGluZGV4DQo+ID4gPiA+ID4gPiA+ID4gMTQ4ZTgxOTY5ZTA0Li5hNzk2YTU3
ZTVlZmIgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9iYXNlL2RkLmMNCj4g
PiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL2Jhc2UvZGQuYw0KPiA+ID4gPiA+ID4gPiA+IEBA
IC0zNTMsNiArMzUzLDcgQEAgYm9vbCBkZXZpY2VfaXNfYm91bmQoc3RydWN0IGRldmljZSAqZGV2
KQ0KPiB7DQo+ID4gPiA+ID4gPiA+ID4gICAgICAgcmV0dXJuIGRldi0+cCAmJg0KPiA+ID4gPiA+
ID4gPiA+IGtsaXN0X25vZGVfYXR0YWNoZWQoJmRldi0+cC0+a25vZGVfZHJpdmVyKTsNCj4gPiA+
ID4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ID4gPiA+ICtFWFBPUlRfU1lNQk9MKGRldmljZV9pc19i
b3VuZCk7DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEVYUE9SVF9TWU1CT0xfR1BMKCkg
cGxlYXNlLCBsaWtlIGFsbCB0aGUgb3RoZXIgZXhwb3J0cyBpbiB0aGlzIGZpbGUuDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IEFsc28sIHdhaXQsIG5vLCBkb24ndCBjYWxsIHRoaXMsIGFy
ZSB5b3Ugc3VyZSB5b3UgYXJlDQo+ID4gPiA+ID4gPiA+IGNhbGxpbmcgaXQgaW4gYSByYWNlLWZy
ZWUgd2F5PyAgQW5kIHdoYXQgYnJhbmNoL3RyZWUgaXMgdGhlIGFib3ZlDQo+IGNvbW1pdCBpbj8N
Cj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBJIGhhdmUgbm90IGNoZWNrZWQgZnVsbHkgYnV0IHNp
bmNlIGl0IGlzIGJlaW5nIGNhbGxlZCBmcm9tDQo+ID4gPiA+ID4gPiBwcm9iZSgpIEkgYXNzdW1l
IHRoZSBsb2NrIHdpbGwgYmUgaGVsZCBhdCB0aGF0IHRpbWUuDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBwcm9iZSgpIHNob3VsZCBuZXZlciBjYWxsIHRoaXMgZnVuY3Rpb24gYXMgaXQgbWFrZXMgbm8g
c2Vuc2UgYXQNCj4gPiA+ID4gPiBhbGwgYXQgdGhhdCBwb2ludCBpbiB0aW1lLiAgVGhlIGRyaXZl
ciBzaG91bGQgYmUgZml4ZWQuDQo+ID4gPiA+DQo+ID4gPiA+IFdvdWxkIHlvdSBzdWdnZXN0IGlm
IGFueSBvdGhlciBBUEkgd2UgY2FuIHVzZSB0byBhbGxvdyB0aGUgZHJpdmVyDQo+ID4gPiA+IHRv
IGtub3cgd2hldGhlciBhbm90aGVyIGRldmljZSBoYXMgYmVlbiBwcm9iZWQ/DQo+ID4gPg0KPiA+
ID4gVGhlcmUgaXMgbm9uZSwgc29ycnksIGFzIHRoYXQganVzdCBvcGVucyB1cCB3YXkgdG9vIG1h
bnkgcHJvYmxlbXMuDQo+ID4gPg0KPiA+ID4gPiBGb3IgaW14IHNjdSBkcml2ZXIgaW4gcXVlc3Rp
b24sIGl0IGhhcyBhIHNwZWNpYWwgcmVxdWlyZW1lbnQgdGhhdA0KPiA+ID4gPiBpdCBkZXBlbmRz
IG9uIHNjdSBwb3dlciBkb21haW4gZHJpdmVyLiBIb3dldmVyLCB0aGVyZSdyZSBhIGh1Z2UNCj4g
PiA+ID4gbnVtYmVyDQo+ID4gPiA+ICgyMDArKSBvZiBwb3dlciBkb21haW5zIGZvciBlYWNoIGRl
dmljZSBjbG9jaywgd2UgY2FuJ3QgZGVmaW5lDQo+ID4gPiA+IHRoZW0gYWxsIGluIERUDQo+ID4g
PiBmb3IgYSBzaW5nbGUgY2xvY2sgY29udHJvbGxlciBub2RlLg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGF0J3Mgd2h5IHdlIHdhbnRlZCB0byB1c2UgZGV2aWNlX2lzX2JvdW5kKCkgYmVmb3JlIHRvIGNo
ZWNrIGlmDQo+ID4gPiA+IHNjdSBwb3dlciBkb21haW4gaXMgcmVhZHkgb3Igbm90IHRvIHN1cHBv
cnQgZGVmZXIgcHJvYmUuDQo+ID4gPg0KPiA+ID4gVXNlIHRoZSBkZXZpY2UgbGluayBmdW5jdGlv
bmFsaXR5IGZvciB0aGlzIHR5cGUgb2YgdGhpbmcsIHRoYXQgaXMNCj4gPiA+IHdoYXQgaXQgd2Fz
IGNyZWF0ZWQgZm9yLg0KPiA+ID4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24u
IEkgd2lsbCBjaGVjayBpdCBob3cgdG8gdXNlLg0KPiA+IEJUVywgSSB3b25kZXIgaWYgZGV2X2Ry
aXZlcl9zdHJpbmcoKSBjb3VsZCBiZSBhbiBvcHRpb25hbCBzb2x1dGlvbg0KPiA+IHdoaWNoIHNl
ZW1zIGEgbW9yZSBzaW1wbGUgd2F5Pw0KPiANCj4gQWxzbywgaG93IGRvIHlvdSByZWFsbHkga25v
dyB5b3UgZXZlbiBoYXZlIGEgdmFsaWQgcG9pbnRlciB0byB0aGF0IG90aGVyIGRldmljZQ0KPiBz
dHJ1Y3R1cmU/ICBIb3cgYXJlIHlvdSBnZXR0aW5nIGFjY2VzcyB0byB0aGF0Pw0KPiANCg0KVGhl
IHJvdWdoIGlkZWEgaXMgYXMgZm9sbG93cy4gTm90IHN1cmUgaWYgdGhvc2UgQVBJcyBhcmUgc2Fm
ZSBlbm91Z2ggYXMgdGhlcmUncmUNCm1hbnkgdXNlcnMgSW4ga2VybmVsLg0KDQpwZF9ucCA9IG9m
X2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wsc2N1LXBkIik7DQpwZF9kZXYg
PSBvZl9maW5kX2RldmljZV9ieV9ub2RlKHBkX25wKTsNCmlmICghcGRfZGV2IHx8ICFkZXZfZHJp
dmVyX3N0cmluZygmcGRfZGV2LT5kZXYpIHx8DQogICBzdHJjbXAoZGV2X2RyaXZlcl9zdHJpbmco
JnBkX2Rldi0+ZGV2KSwgImlteC1zY3UtcGQiKSkgew0KICAgICAgICBvZl9ub2RlX3B1dChwZF9u
cCk7DQogICAgICAgIHJldHVybiAtRVBST0JFX0RFRkVSOw0KfQ0KDQpjb25zdCBjaGFyICpkZXZf
ZHJpdmVyX3N0cmluZyhjb25zdCBzdHJ1Y3QgZGV2aWNlICpkZXYpDQp7DQogICAgICAgIHN0cnVj
dCBkZXZpY2VfZHJpdmVyICpkcnY7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KICAgICAgICAvKiBkZXYtPmRyaXZlciBjYW4gY2hhbmdlIHRvIE5VTEwgdW5kZXJu
ZWF0aCB1cyBiZWNhdXNlIG9mIHVuYmluZGluZywNCiAgICAgICAgICogc28gYmUgY2FyZWZ1bCBh
Ym91dCBhY2Nlc3NpbmcgaXQuICBkZXYtPmJ1cyBhbmQgZGV2LT5jbGFzcyBzaG91bGQNCiAgICAg
ICAgICogbmV2ZXIgY2hhbmdlIG9uY2UgdGhleSBhcmUgc2V0LCBzbyB0aGV5IGRvbid0IG5lZWQg
c3BlY2lhbCBjYXJlLg0KICAgICAgICAgKi8NCiAgICAgICAgZHJ2ID0gUkVBRF9PTkNFKGRldi0+
ZHJpdmVyKTsNCiAgICAgICAgcmV0dXJuIGRydiA/IGRydi0+bmFtZSA6DQogICAgICAgICAgICAg
ICAgICAgICAgICAoZGV2LT5idXMgPyBkZXYtPmJ1cy0+bmFtZSA6DQogICAgICAgICAgICAgICAg
ICAgICAgICAoZGV2LT5jbGFzcyA/IGRldi0+Y2xhc3MtPm5hbWUgOiAiIikpOw0KfSAgICAgICAN
CkVYUE9SVF9TWU1CT0woZGV2X2RyaXZlcl9zdHJpbmcpOw0KDQpBbnl3YXksIEkgd2lsbCBjb250
aW51ZSB0byBpbnZlc3RpZ2F0ZSBkZXZpY2VfbGluayBhY2NvcmRpbmcgdG8geW91ciBzdWdnZXN0
aW9ucy4NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+IHRoYW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
