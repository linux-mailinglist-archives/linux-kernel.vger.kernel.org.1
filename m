Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE562881FB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgJIGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:12:47 -0400
Received: from mail-eopbgr70083.outbound.protection.outlook.com ([40.107.7.83]:53998
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgJIGMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:12:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVZnduXmSp+BrWYqbir29Wh6wiDLqcuXS6jV0ghWqrj3tO8N0KgwfHQNBLlKYLYAk5dUcUJzbZdikc1oKCiG8gy9UVQ2dORAbboC2lYfVCBFAC9QUWT9DmgQZtWK/WypCXCJHQqHvJwsjMfzJAeVhzRKgXuUBpGsyiKsJwGDWBu9Ky47khb0/KfXBqONLFYHjcxICOBXN0XGIkL3TXPJD7AiUQkcSOQSz5VCFC7zM7jRwQJthlK/tVmMtFvCvKLlMc1ul7r5JkXAUCCr+bBGftDo/bSx9EJ6XJppVTxgiA0lynahMf5HmiWe+re9bo/GROJIFrv2BO0RXxVj1LDYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm4n1tKtwbmpKDqa2/d4DFJVtPZ2ObrTDW69yRG6cEc=;
 b=jB/Ljlw8EJGaGxJ8m7jlyHXnlPwyAWWMKQKusChweLmNrWBRtSXyGvaIromQsRkbZmmkMgom/FaauZKVphgQDdh2ojS2gSS/mqWhXFphY7LBVdtLlxhh6yDsdhOlvLFyvwVeqNweihRKTJW8ltWai4OF8/vBDyX6cg+wknCqKyf+vBES0pBHy79c9ohhxZJfkks02FYjcwCH47OvBTlVxgnq5QSwtgzr5jZR/2itjgYT1JFSjq+t85MW3ubmsdhjh4H09AuLrIYHkYoXfN10GltGXa0N/qAkw9KdgLl40fzdvWKVcG9r/Rng3pWAM0olnVOt8KbOr/p/2mVfFBaViA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lm4n1tKtwbmpKDqa2/d4DFJVtPZ2ObrTDW69yRG6cEc=;
 b=kbzoniYfdKGUkoBCVgeVaXDBEPCAnkoZIGfbTrJTKutbPaDllhmNQqd1iPsxORdSuigoJ7NF3vc42HBVeW+Qr/8vIFbJq0RxXJzWJ5UCGWy+ypidso/4lpzM/eHBBefrbeUEKGF1BlIJngAQcbtyY/tmTn6v9dzp+suPCAKJBgk=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VI1PR04MB3104.eurprd04.prod.outlook.com (2603:10a6:802:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.43; Fri, 9 Oct
 2020 06:12:40 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::acd3:d354:3f34:3af7]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::acd3:d354:3f34:3af7%4]) with mapi id 15.20.3455.023; Fri, 9 Oct 2020
 06:12:40 +0000
From:   Jun Li <jun.li@nxp.com>
To:     ChiYuan Huang <u0084500@gmail.com>, Jun Li <lijun.kernel@gmail.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        cy_huang <cy_huang@richtek.com>
Subject: RE: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
Thread-Topic: [PATCH] usb: typec: tcpm: Fix if vbus before cc,
 hard_reset_count not reset issue
Thread-Index: AQHWnAEP61hqDMcgWUCo9++n9QPVoamK1ygAgAEVuICAAt0qsA==
Date:   Fri, 9 Oct 2020 06:12:40 +0000
Message-ID: <VE1PR04MB6528CF55BE68A8DCF4B7904689080@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net>
 <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net>
 <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
 <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
 <CADiBU3_c5O-yUac-ytp5WoQQ12edkU+4wn+WNBOVGRGM15NBJA@mail.gmail.com>
 <20201002133145.GA3384841@kroah.com>
 <c2d689eb-5538-6af2-614f-766521100273@roeck-us.net>
 <20201005110808.GA298743@kroah.com>
 <88586992-650f-a4a1-2fa0-8cef313380fb@roeck-us.net>
 <CADiBU38wk825SqtFRAiYqqV47Wwi43AuWKut19qeTbGBZFqPow@mail.gmail.com>
 <CAKgpwJWwyvUyVj+jQ0y2i_eK1XEN2g3NvR0zgrRLfcmtgn8DDg@mail.gmail.com>
 <CADiBU3_TADpGmV7-BXJd3YaPNiv8Eg8zmKUD_OoB9CG1MT12mg@mail.gmail.com>
 <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com>
In-Reply-To: <CADiBU392ZL6AHf6Dns61KXFVuvwh6grfnJjXmcFE4Ma2gjK6EA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8e9d8ebb-40d3-44e9-c761-08d86c1a53bd
x-ms-traffictypediagnostic: VI1PR04MB3104:
x-microsoft-antispam-prvs: <VI1PR04MB310470008E6F82F11BA187FD89080@VI1PR04MB3104.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IT2+sO32VdYbFfzC38obHIUqvdVGm+M60uJ7882WyhdGt5HcAZ3QUreFxecKdXeIzE7FWVw1sYL97dS7YoWXC7CTTy8xp9S1eqkcXS+HYouIrMw5T3ooMy8mnSC4lXXOtYdhVt2QTbRQUP2a1eFMENIaI3DxhdjEiO1R80dV6Nn4ZTkTQhj5Wp3BvVRPDFHgHHFL5TF85JqHd2tiwwFslP36BCAvP9ObX3BrjuZaNmGCTnOk/CDNIONOHGASUjTAGMPmcZiMVVsg4WE3kIX4LgqD+/4E4GiIw9rfOwhLF6D+2MNjkjrCt7YxUHIaVEZz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(54906003)(76116006)(64756008)(66556008)(66946007)(110136005)(186003)(55016002)(66476007)(83380400001)(4326008)(44832011)(26005)(66446008)(316002)(8676002)(2906002)(7696005)(8936002)(52536014)(71200400001)(86362001)(5660300002)(9686003)(33656002)(53546011)(478600001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KGg+2hSzrMQW6wbZIs89cRWIPiUHcEM7RjY3V6dN3IyUeEDORugX9vhhyZTwzVlO+WV/tnPvWmyfHByTIqoSKA8jpFNqvwvdN422g9cUBbdgt3sctt6FCalrz5kL4E2/Wbc6kdXlrhHqVcQRAKo6lYUN5LP8ILbb0sVFVL5ZMaxGAbunqOFXZzCBjcQLpebHuhbAJ1lhzaxGidWNWjuLCr+cF/KUk6hyEVmRXXwYLxlv33CC/upoa1V/J8fU7PxjViqoDydwJGH/dg3btCdeAVF08HGmk5ajb4bLp4dXVPx7uJE6BsZhfxm7rlakDN+Cl+8VUAEmzx4/xGyHjWjCayj2mcYDa4d/+aSBZ5cP2eEh6XJj4aIg8Qxyjx1Zjl779//OWZzIV0jA9VegrtvRNRLIViODhkQCYQik2cbXnUp4t0I3sWsl6ysZxx8uIDQWjkDr+dczPoG/U2sW92BAMGq/3DYpyFIJXo2f4mPlmtP76fC5GF0hEsHw7+vHqL5CO395ttkIG2uAubCKDnu2opOvrjAgNKLUAGTCBPdq1hvaJ/4PZFvS0vj+gHUhx7DvGva7kuZ5OAq8RJ7jUAfZegmZGOlF/ulCtQtG+1aNwc8DstXwQOspe/K9o6tSCF1lCkAhWj0uKa53yCVBAV8ajA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6528.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9d8ebb-40d3-44e9-c761-08d86c1a53bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 06:12:40.1971
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8AmkgbIPhHuEiruBaVksen0bhiAXyAJ9UFZTwAuw3mRq9H9JWSLw0g562tgX3Wj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hpWXVhbiBIdWFuZyA8
dTAwODQ1MDBAZ21haWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIE9jdG9iZXIgNywgMjAyMCA2
OjEzIFBNDQo+IFRvOiBKdW4gTGkgPGxpanVuLmtlcm5lbEBnbWFpbC5jb20+DQo+IENjOiBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+OyBHcmVnIEtIDQo+IDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz47IEhlaWtraSBLcm9nZXJ1cw0KPiA8aGVpa2tpLmtyb2dlcnVzQGxpbnV4
LmludGVsLmNvbT47IExpbnV4IFVTQiBMaXN0DQo+IDxsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
PjsgbGttbCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGN5X2h1YW5nIDxjeV9o
dWFuZ0ByaWNodGVrLmNvbT47IEp1biBMaSA8anVuLmxpQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0hdIHVzYjogdHlwZWM6IHRjcG06IEZpeCBpZiB2YnVzIGJlZm9yZSBjYywgaGFyZF9y
ZXNldF9jb3VudA0KPiBub3QgcmVzZXQgaXNzdWUNCj4gDQo+IENoaVl1YW4gSHVhbmcgPHUwMDg0
NTAwQGdtYWlsLmNvbT4g5pa8IDIwMjDlubQxMOaciDfml6Ug6YCx5LiJIOS4iuWNiDE6Mznlr6vp
gZPvvJoNCj4gPg0KPiA+IEp1biBMaSA8bGlqdW4ua2VybmVsQGdtYWlsLmNvbT4g5pa8IDIwMjDl
ubQxMOaciDfml6Ug6YCx5LiJIOS4iuWNiDEyOjUy5a+r6YGT77yaDQo+ID4gPg0KPiA+ID4gQ2hp
WXVhbiBIdWFuZyA8dTAwODQ1MDBAZ21haWwuY29tPiDkuo4yMDIw5bm0MTDmnIg25pel5ZGo5LqM
IOS4i+WNiDEyOjM45YaZDQo+IOmBk++8mg0KPiA+ID4gPg0KPiA+ID4gPiBHdWVudGVyIFJvZWNr
IDxsaW51eEByb2Vjay11cy5uZXQ+IOaWvCAyMDIw5bm0MTDmnIg15pelIOmAseS4gCDkuIvljYgx
MTozMA0KPiDlr6vpgZPvvJoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IE9uIDEwLzUvMjAgNDowOCBB
TSwgR3JlZyBLSCB3cm90ZToNCj4gPiA+ID4gPiBbIC4uLiBdDQo+ID4gPiA+ID4gPj4+IFdoYXQg
ZXZlciBoYXBwZW5lZCB3aXRoIHRoaXMgcGF0Y2gsIGlzIHRoZXJlIHN0aWxsIGRpc2FncmVlbWVu
dD8NCj4gPiA+ID4gPiA+Pj4NCj4gPiA+ID4gPiA+Pg0KPiA+ID4gPiA+ID4+IFllcywgdGhlcmUg
aXMuIEkgd291bGRuJ3QgaGF2ZSBhZGRlZCB0aGUgY29uZGl0aW9uYWwgd2l0aG91dA0KPiA+ID4g
PiA+ID4+IHJlYXNvbiwgYW5kIEkgYW0gY29uY2VybmVkIHRoYXQgcmVtb3ZpbmcgaXQgZW50aXJl
bHkgd2lsbCBvcGVuDQo+IGFub3RoZXIgcHJvYmxlbS4NCj4gPiA+ID4gPiA+PiBGZWVsIGZyZWUg
dG8gYXBwbHksIHRob3VnaCAtIEkgY2FuJ3QgcHJvdmUgdGhhdCBteSBjb25jZXJuIGlzDQo+ID4g
PiA+ID4gPj4gdmFsaWQsIGFuZCBhZnRlciBhbGwgd2UnbGwgZ2V0IHJlcG9ydHMgZnJvbSB0aGUg
ZmllbGQgbGF0ZXIgaWYNCj4gaXQgaXMuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gT2ssIGNh
biBJIGdldCBhbiBhY2sgc28gSSBrbm93IHdobyB0byBjb21lIGJhY2sgdG8gaW4gdGhlDQo+ID4g
PiA+ID4gPiBmdXR1cmUgaWYgdGhlcmUgYXJlIGlzc3Vlcz8gIDopDQo+ID4gPiA+ID4gPg0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gTm90IGZyb20gbWUsIGZvciB0aGUgcmVhc29ucyBJIHN0YXRlZC4g
SSB3b3VsZCBiZSBvayB3aXRoIHNvbWV0aGluZw0KPiBsaWtlOg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gLSAgICAgICBpZiAodGNwbV9wb3J0X2lzX2Rpc2Nvbm5lY3RlZChwb3J0KSkNCj4gPiA+ID4g
PiArICAgICAgIGlmICh0Y3BtX3BvcnRfaXNfZGlzY29ubmVjdGVkKHBvcnQpIHx8DQo+ID4gPiA+
ID4gKyAgICAgICAgICAgKHRjcG1fY2NfaXNfb3Blbihwb3J0LT5jYzEpICYmDQo+ID4gPiA+ID4g
KyB0Y3BtX2NjX2lzX29wZW4ocG9ydC0+Y2MyKSkpDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiB0byBu
YXJyb3cgZG93biB0aGUgY29uZGl0aW9uLg0KPiA+ID4gPg0KPiA+ID4gPiBJIGhhdmUgdHJpZWQg
dGhlIGFib3ZlIGNvbW1lbnQgYW5kIEl0IGRvZXNuJ3Qgd29yay4NCj4gPiA+ID4gSG93IGFib3V0
IHRvIGNoYW5nZSB0aGUganVkZ2VtZW50IGxpa2UgYXMgYmVsb3cNCj4gPiA+ID4NCj4gPiA+ID4g
LSAgICAgICBpZiAodGNwbV9wb3J0X2lzX2Rpc2Nvbm5lY3RlZChwb3J0KSkNCj4gPiA+ID4gKyAg
ICAgICBpZiAodGNwbV9wb3J0X2lzX2Rpc2Nvbm5lY3RlZChwb3J0KSB8fA0KPiA+ID4gPiArICFw
b3J0LT52YnVzX3ByZXNlbnQpDQo+ID4gPiA+DQo+ID4gPiA+IFRoZSBoYXJkX3Jlc2V0X2NvdW50
IG5vdCByZXNldCBpc3N1ZSBpcyBmb2xsb3dpbmcgYnkgdGhlIGJlbG93DQo+ID4gPiA+IG9yZGVy
IDEuIFZCVVMgb2ZmICggYXQgdGhlIHNhbWUgdGltZSwgY2MgaXMgc3RpbGwgZGV0ZWN0ZWQgYXMN
Cj4gPiA+ID4gYXR0YWNoZWQpDQo+ID4gPiA+IHBvcnQtPmF0dGFjaGVkIGJlY29tZSBmYWxzZSBh
bmQgY2MgaXMgbm90IG9wZW4NCj4gPiA+ID4gMi4gQWZ0ZXIgdGhhdCwgY2MgZGV0YWNoZWQuDQo+
ID4gPiA+IGR1ZSB0byBwb3J0LT5hdHRhY2hlZCBpcyBmYWxzZSwgdGNwbV9kZXRhY2goKSBkaXJl
Y3RseSByZXR1cm4uDQo+ID4gPg0KPiA+ID4gSWYgdGNwbV9kZXRhY2goKSByZXR1cm4gZGlyZWN0
bHksIHRoZW4gaG93IHlvdXIgcGF0Y2ggY2FuIHJlc2V0DQo+ID4gPiBoYXJkX3Jlc2V0X2NvdW50
Pw0KPiA+ID4NCj4gPiBZZXMsIGl0IGNhbi4gV2Uga25vdyB2YnVzX3ByZXNlbnQgY2hhbmdlIGZy
b20gdHJ1ZSB0byBmYWxzZSBhbmQgY2MNCj4gPiBkZXRhY2ggYm90aCB0cmlnZ2VyIHRjcG1fZGV0
YWNoLg0KPiA+IE15IGNoYW5nZSBpcyB3aGVuZXZlciB0Y3BtX2RldGFjaCB0byBiZSBjYWxsZWQs
IGhhcmRfcmVzZXRfY291bnQgd2lsbA0KPiA+IGJlIHJlc2V0IHRvIHplcm8uDQo+ID4NCj4gPiA+
IEkgYW0gc2VlaW5nIHRoZSBzYW1lIGlzc3VlIG9uIG15IHBsYXRmb3JtLCB0aGUgcHJvcG9zZWQg
Y2hhbmdlOg0KPiA+ID4gLSAgICAgICBpZiAodGNwbV9wb3J0X2lzX2Rpc2Nvbm5lY3RlZChwb3J0
KSkNCj4gPiA+IC0gICAgICAgICAgICAgICBwb3J0LT5oYXJkX3Jlc2V0X2NvdW50ID0gMDsNCj4g
PiA+ICsgICAgICAgcG9ydC0+aGFyZF9yZXNldF9jb3VudCA9IDA7DQo+ID4gPiBjYW4ndCByZXNv
bHZlIGl0IG9uIG15IHBsYXRmb3JtLg0KPiA+ID4NCj4gPiBJJ20gbm90IHN1cmUgd2hhdCdzIHlv
dXIgY29uZGl0aW9uLiBDb3VsZCB5b3UgZGlyZWN0bHkgcGFzdGUgdGhlIHRjcG0NCj4gPiBsb2cg
Zm9yIHRoZSBjaGVjaz8NCj4gPiA+IEhvdyBhYm91dCByZXNldCBoYXJkX3Jlc2V0X2NvdW50IGlu
IFNOS19SRUFEWT8NCj4gPiA+IEBAIC0zMzI1LDYgKzMzMjksNyBAQCBzdGF0aWMgdm9pZCBydW5f
c3RhdGVfbWFjaGluZShzdHJ1Y3QgdGNwbV9wb3J0DQo+ICpwb3J0KQ0KPiA+ID4gICAgICAgICBj
YXNlIFNOS19SRUFEWToNCj4gPiA+ICAgICAgICAgICAgICAgICBwb3J0LT50cnlfc25rX2NvdW50
ID0gMDsNCj4gPiA+ICAgICAgICAgICAgICAgICBwb3J0LT51cGRhdGVfc2lua19jYXBzID0gZmFs
c2U7DQo+ID4gPiArICAgICAgICAgICAgICAgcG9ydC0+aGFyZF9yZXNldF9jb3VudCA9IDA7DQo+
ID4gPiAgICAgICAgICAgICAgICAgaWYgKHBvcnQtPmV4cGxpY2l0X2NvbnRyYWN0KSB7DQo+ID4g
PiAgICAgICAgICAgICAgICAgICAgICAgICB0eXBlY19zZXRfcHdyX29wbW9kZShwb3J0LT50eXBl
Y19wb3J0LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgVFlQRUNfUFdSX01PREVfUEQpOw0KPiA+ID4NCj4gPiA+IGNhbiB0aGlzIHJlc29sdmUgeW91
ciBwcm9ibGVtPw0KPiA+IEknbSBub3Qgc3VyZS4gSXQgbmVlZCB0byBoYXZlIGEgdHJ5LCB0aGVu
IEkgY2FuIGFuc3dlciB5b3UuDQo+ID4gQnV0IGZyb20gVVNCUEQgc3BlYywgdGhlIGhhcmRfcmVz
ZXRfY291bnQgbmVlZCB0byByZXNldCB6ZXJvIG9ubHkgd2hlbg0KPiA+IDEuIEF0IHNyYyBzdGF0
ZSwgcGVfc3JjX3NlbmRfY2FwIGFuZCByZWNlaXZlIEdvb2RDUkMgMi4gQXQgc25rIHN0YXRlLA0K
PiA+IHBlX3Nua19ldmFsdWF0ZV9jYXAgbmVlZCB0byByZXNldCBoYXJkX3Jlc2V0X2NvdW50DQoN
CjMuIA0KOC4zLjMuMy44IFBFX1NOS19IYXJkX1Jlc2V0IHN0YXRlDQoiTm90ZTogVGhlIEhhcmRS
ZXNldENvdW50ZXIgaXMgcmVzZXQgb24gYSBwb3dlciBjeWNsZSBvciBEZXRhY2guIg0KDQo+ID4g
Pg0KPiA+ID4gTGkgSnVuDQo+ID4gPiA+DQo+ID4gPiA+IEFuZCB0aGF0J3Mgd2h5IGhhcmRfcmVz
ZXRfY291bnQgaXMgbm90IHJlc2V0IHRvIDAuDQo+IA0KPiBJIHRyaWVkIGluIHNua19yZWFkeSB0
byByZXNldCBoYXJkX3Jlc2V0X2NvdW50Lg0KPiBBdCBub3JtYWwgY2FzZSwgaXQgd29ya3MuDQo+
IEJ1dCBpdCBzZWVtcyBzdGlsbCB0aGUgcG9zc2libGUgZmFpbCBjYXNlIGxpa2UgYXMgYmVsb3cu
DQo+IDIwMG1zIC0+IGNjIGRlYm91bmNlIG1heCB0aW1lDQo+IDI0MG1zIC0+IHNua193YWl0Y2Fw
IG1heCB0aW1lDQo+IElmIHRoZSBwbHVnaW4vb3V0IHBlcmlvZCBpcyBiZXR3ZWVuICgyMDArMjQw
KSBhbmQgKDIwMCsgMiogMjQwKW1zICwgYW5kIHRoZQ0KPiBzcmMgc2lkZSBwbHVnIG91dCBsaWtl
IGFzIHRoZSBkZXNjcmliZWQgc2NlbmFyaW8uDQo+IEZyb20gdGhpcyBjYXNlLCBoYXJkX3Jlc2V0
X2NvdW50IG1heSBzdGlsbCAxLg0KPiBBbmQgd2UgZXhwZWN0IHRoZSBuZXh0IHBsdWdpbiBoYXJk
X3Jlc2V0X2NvdW50IGlzIDAuIEJ1dCBub3QsIGFjdHVhbGx5IGl0DQo+IG5ldmVyIHJlc2V0Lg0K
PiBTbyBhdCBuZXh0IHBsdWdpbiwgb25seSBvbmUgaGFyZF9yZXNldCB3aWxsIGJlIHNlbnQgYW5k
IHJlYWNoIGhhcmRfcmVzZXRfY291bnQNCj4gbWF4ICgyKS4NCj4gDQo+IFRoaXMgY2FzZSBpcyBo
YXJkIHRvIHJlcHJvZHVjZS4gQnV0IGFjdHVhbGx5IGl0J3MgcG9zc2libGUuDQoNCk1ha2Ugc2Vu
c2UuDQoNClRoZW4gSSBwcm9wb3NlIGRvaW5nIHRoaXMgYXQgU05LX1VOQVRUQUNIRUQNCkBAIC0z
MTU2LDYgKzMxNTYsNyBAQCBzdGF0aWMgdm9pZCBydW5fc3RhdGVfbWFjaGluZShzdHJ1Y3QgdGNw
bV9wb3J0ICpwb3J0KQ0KICAgICAgICAgICAgICAgIGlmICghcG9ydC0+bm9uX3BkX3JvbGVfc3dh
cCkNCiAgICAgICAgICAgICAgICAgICAgICAgIHRjcG1fc3dhcF9jb21wbGV0ZShwb3J0LCAtRU5P
VENPTk4pOw0KICAgICAgICAgICAgICAgIHRjcG1fcHBzX2NvbXBsZXRlKHBvcnQsIC1FTk9UQ09O
Tik7DQorICAgICAgICAgICAgICAgcG9ydC0+aGFyZF9yZXNldF9jb3VudCA9IDA7DQogICAgICAg
ICAgICAgICAgdGNwbV9zbmtfZGV0YWNoKHBvcnQpOw0KICAgICAgICAgICAgICAgIGlmICh0Y3Bt
X3N0YXJ0X3RvZ2dsaW5nKHBvcnQsIFRZUEVDX0NDX1JEKSkgew0KICAgICAgICAgICAgICAgICAg
ICAgICAgdGNwbV9zZXRfc3RhdGUocG9ydCwgVE9HR0xJTkcsIDApOw0KTGkgSnVuDQoNCj4gDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBHdWVudGVyDQo=
