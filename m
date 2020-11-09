Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763C02AB6D7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgKILcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:32:33 -0500
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:53711
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727077AbgKILcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMZZ11hmyFJtFwuEm8KlGNUMceJgVOGNznWGYGH1KR/jNTyuvDH0elhThAQRodNZajsasVxSS4svNnSJtln5/trBlkL+ufN38bbeGPfVwd0fxZAngBgkKMrV1+Mr4mjFRSH6a+37Qd9ord0wJSz3HbUJHGIYa7cBOadaY/oR+uKYCmb0H4y+s/njPGGbOAb3R4j0X+TfM0HI/Ca8u7+eRfVE/B5VhmGyHo62/2b/wEsUGa68kzkzKP4oJ3632uTLkmWsZInmOczynE7e+6bgscKR8xh0alnE9Xm5KFTd/sfy1q8EfoLV+M1do1dcYSIMv3ygTHC9r5PIl3ejTKdMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDsAJJQvZ26+DBsBkHLda1Tba7AKA3Xp2tTsDJ+I/3s=;
 b=eZUle3joPJ+GFmr1h50VFCnO0nzLWsAdMeTWtVH1e3DVa+TiSklkVUI3+LobVUof1/ujuRiM25ApkJ25GNAP0kXeN5SZaHZw1zm4pu5Th7UcecHfhTOBvaMpxKgwL6mlj3lilalf4KB623oUcL1XAOLxnDK0CbYqSBeEmc6m6kHqyPKZx2v3K3a0vYH6tR9gecZMZzvIMeaIWZGu4haRNPVaXAliHnWBMzRFREIHisA4qSL2fHZprz+26ROagFo+rb5aDB85ctL825WBtdwsbuuUsSOnjBXiGeCHVQhwDzew+LCN1kuBcq2VpmeS2ErNKvXp0COy0zMmiTlRh2zj3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDsAJJQvZ26+DBsBkHLda1Tba7AKA3Xp2tTsDJ+I/3s=;
 b=rowYZsfmCHkpWjsq+BaBsar2DDyEhphTSJQseRGt0T9Hf4cg8Ynz89iy45/yp9LIrwujxUPMWl0ynHrjcB5SD/SLsXpvuR4jgAVASKaiPeXAxNQ10i98TMIUv64LyRc/eT9HGu2TnaLuZqw272CtdYzc3qNbpxXXb7QRKcV4AYA=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3784.eurprd04.prod.outlook.com (2603:10a6:209:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Mon, 9 Nov
 2020 11:32:29 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::546f:92f0:f3c5:a148%7]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 11:32:29 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH RESEND] driver core: export device_is_bound() to fix build
 failure
Thread-Topic: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Thread-Index: AQHWtVhC0iFw3JVhoky1GSU0i1GD9am95iCAgAGxewCAAAY6gIAAATqAgAAKegCAAAL0AA==
Date:   Mon, 9 Nov 2020 11:32:28 +0000
Message-ID: <AM6PR04MB49663B614F94AC6E46996DD980EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
 <20201108082317.GA40741@kroah.com>
 <CADVatmN8SbZWVGf_xe_K1g7M9ArHXF8TUhYyBgQcydBF4_zp9g@mail.gmail.com>
 <20201109103703.GA1310551@kroah.com>
 <AM6PR04MB4966B90C0DEC71A6C86067AA80EA0@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CADVatmNmoBFipoELoyuJ4EUB=KjjO+_9ahm830+04Xi3T77jqQ@mail.gmail.com>
In-Reply-To: <CADVatmNmoBFipoELoyuJ4EUB=KjjO+_9ahm830+04Xi3T77jqQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d53c6679-95ca-4bbd-95e7-08d884a323f7
x-ms-traffictypediagnostic: AM6PR0402MB3784:
x-microsoft-antispam-prvs: <AM6PR0402MB37843F35505A4227894D8E4180EA0@AM6PR0402MB3784.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uNfvcGPuomnldWZVCHpSZlVDdTpbHMhgNDRgmi3sfxKAtR2lTN24Rsso7pyvibdkicgfVAGVzOg3rz2hCYlYI44ylibNTsIAqMtZJrTQMYvnepV+oY9cU28oTEqaMyu5zcGzWyyVzZYAdzhdgIsf7qtkPNkiCy1jyvX+gZHUcxChsFMFJsx6INW2ENKJzdOwmyLFCJko3OdEPTxhF+A7IMKl8FYV6j3pGLiuGPdz9H3EV64xSF/SX7xpmNC4MiipRq/UJn2ePlJ63soP4/KiS2bdt0teFvEg0oQ5VAoa1GcYRqAOF9sAQDTwoNDCzHdg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(66946007)(5660300002)(66556008)(9686003)(6916009)(33656002)(4326008)(186003)(86362001)(44832011)(71200400001)(76116006)(64756008)(66446008)(55016002)(52536014)(316002)(478600001)(7696005)(8936002)(2906002)(54906003)(53546011)(26005)(6506007)(83380400001)(66476007)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Y/OijU0yvDYDFWK4fnzkx3Ho/9rjB8oNsL4+HNEzbTQDZKvQcRZlbEU7hlDsZ0XtPGl5qEcNjGeFvavdofNSk/0Flu2LUaUv1/lad9ht6B5VMIk9b9qTe+uO6gzbc/Qrpk8hnstdr+q+zLKy7cDmiy3iCpOW7XNh4dCPdxJSf3NlnJ9dCaV1TDfJMwOA4NRvNofopkLX+i4KXlEapTCen3c1fu5DEE78MKnP45jeeqexCfT30go2bIM6vVhClLULGgB2i1uayIvb6/dG4kmekbt8xvmR/RSwHRhIQyujX+rQE0P9j2cvRhHEoN8XIa0Mx4FcO0+gwsrF0DGGbQcNAU1GAlueGQc1YKuZaJABcaVAORmzAIEx7WiTc5BSwvhf/v7GtxQKEp887ipV3wETtE10dSaeEXF6nrOB9KqJmXKJUOgT5wX+kLmW3qqwNpOaZ8MZIZaC6G9DnoXl9YUKc2kpPieUlNj57Wf08xke3bAnMFcRMLA6/I5U5NwhyH1BlHunRisqVhXu/n+lxIeeZjpiNBnWuqGztaPGU2/2qCL9MOp5rJ7kxT176AAJDORXMPtxxXgbcUsvz07ZfHZvW1G4JPZTcHaLTOCSQwJBfQtSM2dXxRQW3PBEaolM44lXNf6k4BD9cV66XTDyFCTiNw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d53c6679-95ca-4bbd-95e7-08d884a323f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 11:32:28.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ygyQLm4qIg+yaW8GZ0204mhxWxDBQxI6yXuyUIN5+vIkbuSHdtMSB8hag8x1NYad9QZPFc5MTyksdsXtEgT06Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBTdWRpcCBNdWtoZXJqZWUgPHN1ZGlwbS5tdWtoZXJqZWVAZ21haWwuY29tPg0KPiBT
ZW50OiBNb25kYXksIE5vdmVtYmVyIDksIDIwMjAgNzoxOSBQTQ0KPiANCj4gSGkgQWlzaGVuZywN
Cj4gDQo+IE9uIE1vbiwgTm92IDksIDIwMjAgYXQgMTA6NTcgQU0gQWlzaGVuZyBEb25nIDxhaXNo
ZW5nLmRvbmdAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaSBHcmVnLA0KPiA+DQo+ID4g
PiBGcm9tOiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0K
PiA+ID4gU2VudDogTW9uZGF5LCBOb3ZlbWJlciA5LCAyMDIwIDY6MzcgUE0NCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggUkVTRU5EXSBkcml2ZXIgY29yZTogZXhwb3J0IGRldmljZV9pc19ib3Vu
ZCgpIHRvDQo+ID4gPiBmaXggYnVpbGQgZmFpbHVyZQ0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgTm92
IDA5LCAyMDIwIGF0IDEwOjE0OjQ2QU0gKzAwMDAsIFN1ZGlwIE11a2hlcmplZSB3cm90ZToNCj4g
PiA+ID4gSGkgR3JlZywNCj4gPiA+ID4NCj4gPiA+ID4gT24gU3VuLCBOb3YgOCwgMjAyMCBhdCA4
OjIzIEFNIEdyZWcgS3JvYWgtSGFydG1hbg0KPiA+ID4gPiA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlv
bi5vcmc+IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gU2F0LCBOb3YgMDcsIDIwMjAg
YXQgMTA6NDc6MjdQTSArMDAwMCwgU3VkaXAgTXVraGVyamVlIHdyb3RlOg0KPiA+ID4gPiA+ID4g
V2hlbiBDT05GSUdfTVhDX0NMS19TQ1UgaXMgY29uZmlndXJlZCBhcyAnbScgdGhlIGJ1aWxkIGZh
aWxzDQo+ID4gPiA+ID4gPiBhcyBpdCBpcyB1bmFibGUgdG8gZmluZCBkZXZpY2VfaXNfYm91bmQo
KS4gVGhlIGVycm9yIGJlaW5nOg0KPiA+ID4gPiA+ID4gRVJST1I6IG1vZHBvc3Q6ICJkZXZpY2Vf
aXNfYm91bmQiIFtkcml2ZXJzL2Nsay9pbXgvY2xrLWlteC1zY3Uua29dDQo+ID4gPiA+ID4gPiAg
ICAgICB1bmRlZmluZWQhDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gRXhwb3J0IHRoZSBzeW1i
b2wgc28gdGhhdCB0aGUgbW9kdWxlIGZpbmRzIGl0Lg0KPiA+ID4gPiA+ID4NCj4gDQo+IDxzbmlw
Pg0KPiANCj4gPiA+DQo+ID4gPiBwcm9iZSgpIHNob3VsZCBuZXZlciBjYWxsIHRoaXMgZnVuY3Rp
b24gYXMgaXQgbWFrZXMgbm8gc2Vuc2UgYXQgYWxsDQo+ID4gPiBhdCB0aGF0IHBvaW50IGluIHRp
bWUuICBUaGUgZHJpdmVyIHNob3VsZCBiZSBmaXhlZC4NCj4gPg0KPiA+IFdvdWxkIHlvdSBzdWdn
ZXN0IGlmIGFueSBvdGhlciBBUEkgd2UgY2FuIHVzZSB0byBhbGxvdyB0aGUgZHJpdmVyIHRvDQo+
ID4ga25vdyB3aGV0aGVyIGFub3RoZXIgZGV2aWNlIGhhcyBiZWVuIHByb2JlZD8NCj4gPg0KPiA+
IEZvciBpbXggc2N1IGRyaXZlciBpbiBxdWVzdGlvbiwgaXQgaGFzIGEgc3BlY2lhbCByZXF1aXJl
bWVudCB0aGF0IGl0DQo+ID4gZGVwZW5kcyBvbiBzY3UgcG93ZXIgZG9tYWluIGRyaXZlci4gSG93
ZXZlciwgdGhlcmUncmUgYSBodWdlIG51bWJlcg0KPiA+ICgyMDArKSBvZiBwb3dlciBkb21haW5z
IGZvciBlYWNoIGRldmljZSBjbG9jaywgd2UgY2FuJ3QgZGVmaW5lIHRoZW0gYWxsIGluIERUDQo+
IGZvciBhIHNpbmdsZSBjbG9jayBjb250cm9sbGVyIG5vZGUuDQo+ID4NCj4gPiBUaGF0J3Mgd2h5
IHdlIHdhbnRlZCB0byB1c2UgZGV2aWNlX2lzX2JvdW5kKCkgYmVmb3JlIHRvIGNoZWNrIGlmIHNj
dQ0KPiA+IHBvd2VyIGRvbWFpbiBpcyByZWFkeSBvciBub3QgdG8gc3VwcG9ydCBkZWZlciBwcm9i
ZS4NCj4gDQo+IGlpdWMsIHlvdSBhcmUgd2FpdGluZyBmb3IgImZzbCxzY3UtcGQiIHRvIGJlIHJl
Z2lzdGVyZWQuDQo+IEkgdGhpbmsgeW91IG1pZ2h0IGJlIGFibGUgdG8gdXNlIGJ1c19mb3JfZWFj
aF9kZXYoKSB0byBjaGVjayBpZiB0aGUgZGV2aWNlIGhhcw0KPiByZWdpc3RlcmVkIHdpdGggdGhl
IGJ1cyBvciBub3QuIEl0IHdpbGwgYmUgb24gdGhlIGJ1cyBvbmx5IGFmdGVyIGJpbmQgd2FzDQo+
IHN1Y2Nlc3NmdWwuIFRoZSBidXMgd2lsbCBiZSAicGxhdGZvcm1fYnVzX3R5cGUiLg0KPiBCdXQg
SSBhbSBzdXJlIEdyZWcgY2FuIGdpdmUgeW91IGJldHRlciBzdWdnZXN0aW9uIHRoYW4gdGhpcy4g
OikNCj4gDQoNClRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24uIFNlZW1zIGxpa2UgYSB3b3JraW5n
IHRyaWNreSBtZXRob2QuIDotKQ0KRm9yIGEgcG9zc2libGUgZWFzaWVyIHdheSwgSSB3b25kZXIg
aWYgd2UgY2FuIHVzZSBkZXZfZHJpdmVyX3N0cmluZygpIHdoaWNoIGlzIGFscmVhZHkNCmV4cG9y
dGVkIGluIGtlcm5lbC4NCldhaXRpbmcgZm9yIEdyZWcncyBzdWdnZXN0aW9ucyBvbiB3aGljaCB3
YXkgdG8gZ28uDQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiANCj4gLS0NCj4gUmVnYXJkcw0KPiBT
dWRpcA0K
