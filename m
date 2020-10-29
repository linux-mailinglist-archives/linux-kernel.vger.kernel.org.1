Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBBE29E2E5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgJ2Cn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:43:59 -0400
Received: from mail-eopbgr130043.outbound.protection.outlook.com ([40.107.13.43]:12920
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729636AbgJ2Cml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 22:42:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGC1ahVRpE7C7FRN4UqUK2U/juJlTMNN8brS4U8fvQUnuHONrGUWl4XhYpcvqRcwO8OJkXXKvM59u3irgpvrbWo25NeXoei1yKLqXmoYnruKiWFXbfmJl1q45u1IROLbo+HUpHfmceDzuV0IhCspGtEQa3LcBRmq/4iD3kRdy3F82U6xgGirzPsPqPvCBWLFPtSFTkHynYbj0owXNkJJMvVCtAkB89ocHJaV7LSNsbw6rsJWagL+K5uH8XlGyf6bOmGrnXnWo1D6dASEYdD3+nqx6MnYF6RFUJpY+1xJyS0lvbSDf7AZ0FG8cNOfhnDUSdPenbWYA7fuE6eHM0HTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSIKZeWZLCwfAP8UQ29bBRotw74iEgaJjX176Xx/BH8=;
 b=QF2AzMLhkZ59GaFplfkNHx2nPRK2Xxuuu8EWL8w43tBmXVOdTFMzLr4rIqB38X4O1tHQMuDq7PMbf0w5mMzhNTisUWvdq2PMwlf62YqMUpcCcoKh7jgMPfeixV4HYDOfc2M7DCImXhuZ5zTboqwUZ0H/i7ohkDlABVHFlbsmNWqx6J7ZYPy2tSlpaOdb+GPuKoznhw0XbIK0cBmailvvy5FuUnJRyDF/2xDR/qlsiJSoXxoLgfmtoP7tHrGdwZbBM13i+8v/QfXSDMw/dVJKAOn31e4n7E13l7a995W7nbvLTBV4PmH7obnIVkEK9zdgU6lJEnmZjgYsVnoWiTXNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSIKZeWZLCwfAP8UQ29bBRotw74iEgaJjX176Xx/BH8=;
 b=E319XG2DIDfOuNI0Hd0Iq0KWIGHLEng46PQb4XPF7yS4TTqhvPhXu5hRnHzUrHOEHUYXqLHvS8e3BW4vA3HGW1tibNGOAbW6avomtuY6UROanjc62rXp6kzrqzVbgbfuWDKhcRsgzCp9Ji0BG6DjsHb5sMgROKtprpWAaJe+SBY=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB5055.eurprd04.prod.outlook.com (2603:10a6:803:53::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Thu, 29 Oct
 2020 02:42:35 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3499.024; Thu, 29 Oct 2020
 02:42:35 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Arnd Bergmann <arnd@kernel.org>
CC:     "Dutt, Sudeep" <sudeep.dutt@intel.com>,
        "vincent.whitchurch@axis.com" <vincent.whitchurch@axis.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
Subject: RE: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Topic: [PATCH V3 2/4] misc: vop: do not allocate and reassign the used
 ring
Thread-Index: AQHWqDFSEBaTQE/ZZ0S8iz1mc9AwNqmk7OMAgARJc3CAAc3rAIAABx/AgACLBgCAAK8V0IAAHQyAgAAuEfCAAKNG1YAAr87Q
Date:   Thu, 29 Oct 2020 02:42:35 +0000
Message-ID: <VI1PR04MB4960F02E95A908D3D1DBE0FE92140@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20201022050638.29641-1-sherry.sun@nxp.com>
 <20201022050638.29641-3-sherry.sun@nxp.com>
 <20201023092650.GB29066@infradead.org>
 <VI1PR04MB4960E9ECD7310B8CA1E053DC92190@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027062802.GC207971@kroah.com>
 <VI1PR04MB4960C0E76374B2775D99A82192160@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <20201027151106.e4skr6dsbwvo4al6@axis.com>
 <VI1PR04MB49603783EF3FD3F3635FCDAF92170@VI1PR04MB4960.eurprd04.prod.outlook.com>
 <93bd1c60ea4d910489a7592200856eaf8022ced0.camel@intel.com>
 <AM0PR04MB4947F01860DE953B8496FA8892170@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAK8P3a1JRx32VfFcwFpK0i6F5MQMCK-yCKw8=d_R08Y3iQ7wLQ@mail.gmail.com>
 <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
In-Reply-To: <CAK8P3a3u06ZHdAb_n3byTqfxAvy_wi48X1g0N4ODuH2uEM0xLA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: be1c59ad-c051-4938-b9fd-08d87bb44b35
x-ms-traffictypediagnostic: VI1PR04MB5055:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB50559E6A6E7E356214F1C01E92140@VI1PR04MB5055.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtMBtkd8hLvdKjWakue5u6ri4UAzEJvF/3h/OVhNnKmsFRJK9BY42DPc9V81EgE4/FGxJ3l+izOfLrY4sXkZ7V5j6CKUUSpNqrpjSi/dc/EIrfMuhnz+b/4Pg5OXJcATigkNbc4nZEuA7az6UnpVT8W/tMkdIvcMMcTsT+/xXkeQ8fSUWzYJY9ETPe+rr+DPJdHVxIoJT3qL/7fbdimIcdOUDMqFp90FPiYMf5F9TmqmdxPW5NfO7aqQs5e5c6G7/3g/pdiSAj3Ab6R09h0pcZsUAaztsjOE5y7q2D36RjLZ29cOk9eFt96igar6Uf1FQ72+wymyYrBPvUuRA6+jfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(9686003)(4326008)(53546011)(44832011)(6506007)(26005)(66946007)(76116006)(55016002)(186003)(52536014)(66556008)(64756008)(66446008)(66476007)(6916009)(8676002)(83380400001)(8936002)(33656002)(54906003)(86362001)(2906002)(71200400001)(5660300002)(316002)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 27GCDtxU8yIZfLsyxkKHA0tFIYw8Y70m8gutKMUfQSOshGWNc8CQ+yfy3KRWVvs177EahQCHLzxbtm5pf6WsF/c9+u0Vg+91IGFKIZnS39pCZR5D6YA6Pae59iq5qPIolPTIEX6RdeA1hETtYT1SJALj43QYeUPzKWSUilNrmUzo/xxT9MRnvkDbENnRKZAaAIEodG4FvVQOZa4M5gJy3MGqPmktDRfzrFHFhEOcp80cxv8VrluzWGwG3ZbVkjMrA8Ap36Gqozo9D3kWR+XWvlzMfIrSNZOxwLsw5EDi3hQUcJMN2oAm6ahb9fBaIowffpzv1yebSjLT3kifD03srV/wSMtYIiOtGyh3IAslOCkkN07AEYZsbctUNfWEwXZk+JsXgdpZpS6+HiEPRXKoMsW3eJ4WEUM3C3ose3fdxTktNZBfzrT7OxviVYOqOMi7xNYYSXCuxHO1Vx08NVVKDmJqxkVBeb+gEC1wIjSojRbr4ew0VqoTb7q0CzMpvv2lka++VGjAxygGUjl+g7oQJGXBq5TTlqrdqmk7N7DG5Px7o+LN2MoaJhoPmkNQpJkGIyfjy1D3hCfrckZRSwzityFTOh+ei3wuwT9m1ql4AAPkHE0YckkTWzmIwogoaykI4QNeBWDr5zhiAaQTB0u7+w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1c59ad-c051-4938-b9fd-08d87bb44b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 02:42:35.8047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TtVAzqSHQ/0wqUrZiMzRk1XoPOLW/1co2mfBtDRDlzS8+MH0zzMy9yAUtB1MpPoWCq/S/NSkPufCzotl8KTTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJuZCwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDIvNF0gbWlzYzogdm9wOiBkbyBu
b3QgYWxsb2NhdGUgYW5kIHJlYXNzaWduIHRoZSB1c2VkDQo+IHJpbmcNCj4gDQo+IChyZXNlbmRp
bmcgZnJvbSB0aGUga2VybmVsLm9yZyBhZGRyZXNzIGFmdGVyIGdldHRpbmcgYm91bmNlcyBhZ2Fp
bikNCj4gDQo+IE9uIFdlZCwgT2N0IDI4LCAyMDIwIGF0IDc6MjkgQU0gU2hlcnJ5IFN1biA8c2hl
cnJ5LnN1bkBueHAuY29tPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMi80
XSBtaXNjOiB2b3A6IGRvIG5vdCBhbGxvY2F0ZSBhbmQgcmVhc3NpZ24NCj4gPiA+IHRoZSB1c2Vk
DQo+ID4gPg0KPiA+ID4gQm90aCBBc2h1dG9zaCBhbmQgSSBoYXZlIG1vdmVkIG9uIHRvIG90aGVy
IHByb2plY3RzLiBUaGUgTUlDIGRldmljZXMNCj4gPiA+IGhhdmUgYmVlbiBkaXNjb250aW51ZWQu
IEkgaGF2ZSBqdXN0IHNlbnQgYWNyb3NzIGEgcGF0Y2ggdG8gcmVtb3ZlDQo+ID4gPiB0aGUgTUlD
IGRyaXZlcnMgZnJvbSB0aGUga2VybmVsIHRyZWUuDQo+ID4gPg0KPiA+ID4gV2UgYXJlIHZlcnkg
Z2xhZCB0byBzZWUgdGhhdCBTaGVycnkgaXMgYWJsZSB0byByZXVzZSBzb21lIG9mIHRoZSBWT1AN
Cj4gPiA+IGxvZ2ljIGFuZCBpdCBpcyB3b3JraW5nIHdlbGwuIEl0IGlzIGJlc3QgaWYgdGhlIE1J
QyBkcml2ZXJzIGFyZQ0KPiA+ID4gcmVtb3ZlZCBzbyBTaGVycnkgY2FuIGFkZCB0aGUgc3BlY2lm
aWMgVk9QIGxvZ2ljIHJlcXVpcmVkIGZvciBpbXg4cW0NCj4gPiA+IHN1YnNlcXVlbnRseSB3aXRo
b3V0IGhhdmluZyB0byB3b3JyeSBhYm91dCBvdGhlciBkcml2ZXIgZGVwZW5kZW5jaWVzLg0KPiA+
ID4gSG9waW5nIHRoaXMgcmVzdWx0cyBpbiBhIGNsZWFuZXIgaW14OHFtIGRyaXZlciBtb3Zpbmcg
Zm9yd2FyZC4NCj4gPg0KPiA+IEknbSBvayB3aXRoIHlvdXIgcGF0Y2guDQo+ID4gU2luY2UgeW91
IGhhdmUgZGVwcmVjYXRlZCB0aGUgTUlDIHJlbGF0ZWQgY29kZSwgbWF5IEkgYXNrIGRvIHlvdSBo
YXZlDQo+ID4gYSBiZXR0ZXIgc29sdXRpb24gaW5zdGVhZCBvZiB2b3Avc2NpZj8NCj4gDQo+IEkg
dGhpbmsgd2Ugc2hvdWxkIHRyeSB0byBkbyBzb21ldGhpbmcgb24gdG9wIG9mIHRoZSBQQ0llIGVu
ZHBvaW50IHN1YnN5c3RlbQ0KPiB0byBtYWtlIGl0IHdvcmsgYWNyb3NzIGFyYml0cmFyeSBjb21i
aW5hdGlvbnMgb2YgaG9zdCBhbmQgZGV2aWNlDQo+IGltcGxlbWVudGF0aW9ucywgYW5kIHByb3Zp
ZGUgYSBzdXBlcnNldCBvZiB3aGF0IHRoZSBNSUMgZHJpdmVyLCAob3V0LW9mLQ0KPiB0cmVlKSBC
bHVlZmllbGQgZW5kcG9pbnQgZHJpdmVyLCBhbmQgdGhlIE5UQiBzdWJzeXN0ZW0gYXMgd2VsbCBh
cyBhIGNvdXBsZSBvZg0KPiBvdGhlcnMgdXNlZCB0byBkbywgZWFjaCBvZiB0aGVtIHR1bm5lbGlu
ZyBibG9jay9uZXR3b3JrL3NlcmlhbC8uLi4gb3ZlciBhDQo+IFBDSWUgbGluayBvZiBzb21lIHNv
cnQsIHVzdWFsbHkgd2l0aCB2aXJ0aW8uDQo+IA0KPiBBdCB0aGUgbW9tZW50LCB0aGVyZSBpcyBv
bmx5IG9uZSBkcml2ZXIgZm9yIHRoZSBlbmRwb2ludCBmcmFtZXdvcmsgaW4gdGhlDQo+IGtlcm5l
bCwgaW4gZHJpdmVycy9wY2kvZW5kcG9pbnQvZnVuY3Rpb25zL3BjaS1lcGYtdGVzdC5jLCBidXQg
SSB0aGluayB0aGlzIGNhbg0KPiBzZXJ2ZSBhcyBhIHN0YXJ0aW5nIHBvaW50Lg0KPiANCg0KVGhh
bmtzIGZvciB5b3VyIGRldGFpbGVkIHJlcGx5Lg0KWWVzLCB0aGUgUENJZSBlbmRwb2ludCBzdWJz
eXN0ZW0gaXMgdGhlIGJhc2UgY29kZSwgYWN0dWFsbHkgd2UgaGF2ZSBpbXBsZW1lbnRlZCBhIHNl
dCBvZiBwY2kgZW5kcG9pbnQgY29kZSBzaW1pbGFyIHRvIHBjaS1lcGYtdGVzdC5jLCBjb21iaW5l
IHdpdGggdm9wIChWaXJ0aW8gT3ZlciBQQ0llKS4NCg0KQnV0IG5vdyB0aGUgdm9wIGNvZGUgaXMg
Z29pbmcgdG8gYmUgcmVtb3ZlZCwgd2UgcGxhbm5lZCB0byBjaGFuZ2UgdG8gTlRCIGZyYW1ld29y
aywgSSBzYXcgS2lzaG9uIGhhcyBkb25lIHNvbWUgam9icyBiYXNlZCBvbiBOVEIgYW5kIFBDSWUg
ZW5kcG9pbnQgc3Vic3lzdGVtLCB3aWxsIGdldCBhIGRlZXAgbG9vay4gTWF5YmUgaXQgaXMgYSBn
b29kIHNvbHV0aW9uLg0KDQpCZXN0IHJlZ2FyZHMNClNoZXJyeQ0KDQo+IFRoZSBQQ0kgZW5kcG9p
bnQgc3Vic3lzdGVtIGFscmVhZHkgdXNlcyBjb25maWdmcyBmb3IgY29uZmlndXJpbmcgdGhlDQo+
IGF2YWlsYWJsZSBkZXZpY2VzLCBhbmQgdGhpcyBzZWVtcyBsaWtlIGEgZ29vZCBmaXQgZm9yIG1h
a2luZyBpdCB3b3JrIGluIGdlbmVyYWwuDQo+IEhvd2V2ZXIsIHRoZXJlIGFyZSBhIG51bWJlciBv
ZiB1c2UgY2FzZXMgdGhhdCBoYXZlIHNvbWV3aGF0IGNvbmZsaWN0aW5nDQo+IHJlcXVpcmVtZW50
cywgc28gdGhlIGZpcnN0IHN0ZXAgd291bGQgYmUgdG8gZmlndXJlIG91dCB3aGF0IGV2ZXJ5b25l
IGFjdHVhbGx5DQo+IG5lZWRzIGZvciB2aXJ0aW8gY29tbXVuaWNhdGlvbi4NCj4gDQo+IFRoZXNl
IGFyZSBzb21lIG9mIHRoZSBtYWluIGRpZmZlcmVuY2VzIHRoYXQgSSBoYXZlIG5vdGljZWQgaW4g
dGhlDQo+IHBhc3Q6DQo+IA0KPiAtIFRoZSBzaW1wbGUgY2FzZSB3b3VsZCBiZSB0byB1c2Ugb25l
IFBDSWUgZW5kcG9pbnQgZGV2aWNlDQo+ICAgZm9yIGVhY2ggdmlydGlvIGRldmljZSwgYnV0IEkg
dGhpbmsgdGhpcyBuZWVkcyB0byBiZSBtdWx0aXBsZXhlZA0KPiAgIHNvIHRoYXQgaGFyZHdhcmUg
dGhhdCBvbmx5IHN1cHBvcnRzIGEgc2luZ2xlIFBDSWUgZW5kcG9pbnQNCj4gICBjYW4gc3RpbGwg
aGF2ZSBtdWx0aXBsZSB2aXJ0aW8gZGV2aWNlcyB0dW5uZWxlZCB0aHJvdWdoIGl0Lg0KPiANCj4g
LSBXaGlsZSBzb21ldGltZXMgdGhlIGNvbmZpZ3VyYXRpb24gaXMgaGFyZGNvZGVkIGluIHRoZSBk
cml2ZXIsIGlkZWFsbHkNCj4gICB0aGUgdHlwZSBvZiB2aXJ0aW8gZGV2aWNlKHMpIHRoYXQgaXMg
dHVubmVsZWQgb3ZlciB0aGUgUENJZSBsaW5rIHNob3VsZA0KPiAgIGJlIGNvbmZpZ3VyYWJsZS4g
VGhlIGNvbmZpZ3VyYXRpb24gb2YgdGhlIGVuZHBvaW50IGRldmljZSBpdHNlbGYgaXMNCj4gICBk
b25lIG9uIHRoZSBtYWNoaW5lIHJ1bm5pbmcgb24gdGhlIGVuZHBvaW50IHNpZGUsIGJ1dCBmb3Ig
dGhlDQo+ICAgdmlydGlvIGRldmljZXMsIHRoaXMgbWlnaHQgYmUgZWl0aGVyIG9uIHRoZSBob3N0
IG9yIHRoZSBlbmRwb2ludC4NCj4gICBOb3Qgc3VyZSBpZiBvbmUgb2YgdGhlIHR3byB3YXlzIGlz
IGNvbW1vbiBlbm91Z2gsIG9yIHdlIGhhdmUgdG8NCj4gICBhbGxvdyBib3RoLg0KPiANCj4gLSBX
aGVuIHRoZSBsaW5rIGlzIGNvbmZpZ3VyZWQsIHlvdSBzdGlsbCBuZWVkIG9uZSBzaWRlIHRvIHBy
b3ZpZGUgYQ0KPiAgIHZpcnRpbyBkZXZpY2UgaG9zdCBpbXBsZW1lbnRhdGlvbiwgd2hpbGUgdGhl
IG90aGVyIHNpZGUgd291bGQNCj4gICBydW4gdGhlIG5vcm1hbCB2aXJ0aW8gZGV2aWNlIGRyaXZl
ci4gQWdhaW4sIHRoZXNlIGNvdWxkIGJlIGRvbmUNCj4gICBlaXRoZXIgd2F5LCBhbmQgaXQgaXMg
aW5kZXBlbmRlbnQgb2Ygd2hpY2ggc2lkZSBoYXMgY29uZmlndXJlZA0KPiAgIHRoZSBsaW5rLCBh
bmQgd2UgbWlnaHQgd2FudCB0byBvbmx5IGFsbG93IG9uZSBvZiB0aGUgdHdvIG9wdGlvbnMsDQo+
ICAgb3IgZG8gYm90aCwgb3IgdGllIGl0IHRvIHdobyBjb25maWd1cmVzIGl0IChlLmcuIHRoZSBz
aWRlIHRoYXQgY3JlYXRlcw0KPiAgIHRoZSBkZXZpY2UgbXVzdCBiZSB0aGUgdmlydGlvIGRldmlj
ZSBob3N0LCB3aGlsZSB0aGUgb3RoZXIgc2lkZQ0KPiAgIGp1c3Qgc2VlcyB0aGUgZGV2aWNlIHBv
cCB1cCBhbmQgdXNlcyBhIHZpcnRpbyBkcml2ZXIpLg0KPiANCj4gICAgICAgIEFybmQNCg==
