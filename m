Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8878D2F0ECD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbhAKJOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:14:38 -0500
Received: from mail-eopbgr40086.outbound.protection.outlook.com ([40.107.4.86]:22244
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728323AbhAKJOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:14:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1qdw7WMr2rzgg8fXtebKDoqZM2wZ4U5G6BAcRV/KYAW4b4CGoUwbKQ/RA+O6PVfUq6qelpLH38ANnzmKYl2kxWUEIw9ckBnl8IXSBbqeWlfjt7XWih2PXqYueCZUiDPQcNXk9zwUhDVl4iVm8iG17DazFus0rLqvIGc+p8X8MqeTz+Vz1S8uDS8qSJTFfwTOV+j7aULe0gzKJ1zTTeTaeYhwt7uw6I7OAcnDm87DTOfxvJb/WflREPUeeludEGFoQlxA1CPFQNfEwrnKpWIdasxD3jwxVVRd7HNK1oJh8z5Tp6dx87ty3uyfXg8nZYZr+8jNLDW/r/kK2Uagc7sRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umvKFmCbrOfmpNYhvGNYmkiO6v9HBAesfLFnNE/URNw=;
 b=d4oyfTHJ5tRPN9meqnI0ITAC2KcLg8t3NPRpWfAOFixh66tuixEjZQcDRmWrURxL9Ro+I9yi81AMTFPtV38VEaJxE9wOh/hD35irYpMyPucrZSb71Myki0xqtxU0BrGnfNK3S2xpGOZer84FO2y6auwHFbh3eNDJ0GmZIGrDIrVomQL+eptfLNNQambPYsBaZWgtDGi7MNe1kGTkud0M8uZXHZ+fWQyOchxNhy+zpo6/qFikLfi1LBpKhY2LlS9vM4NCtg7au2uEPJ0LHpE4neVE16zZQhaljA1ZfMrHjIdZ76RdDLwE6pb6LF/UhnJ+LwuO4RMmd5YNld5O/y08IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umvKFmCbrOfmpNYhvGNYmkiO6v9HBAesfLFnNE/URNw=;
 b=RHoYvadwdJ7eraJvWZfhoIiAS5rlu70RF5ZAXOxkidIkfuBE50vZ7YWx+S2KZIEFs6UnapAy50MGekPzbZgZvoJLMh7BFq5VLaDAYkIW2TyLsA9ejYkcHXMsOvfwTjGO6gsIWgEsmGEVFrlm99IEoeegCIDiDEYSFFTY7o0RvbU=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2474.eurprd03.prod.outlook.com (2603:10a6:3:6a::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Mon, 11 Jan 2021 09:13:47 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::6558:57bb:5293:f3d3%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 09:13:47 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gene.chen.richtek@gmail.com" <gene.chen.richtek@gmail.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "shufan_lee@richtek.com" <shufan_lee@richtek.com>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "gene_chen@richtek.com" <gene_chen@richtek.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wilma.Wu@mediatek.com" <Wilma.Wu@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "benjamin.chao@mediatek.com" <benjamin.chao@mediatek.com>
Subject: Re: [PATCH resend] dt-bindings: mfd: mediatek: Add bindings for
 MT6360 PMIC
Thread-Topic: [PATCH resend] dt-bindings: mfd: mediatek: Add bindings for
 MT6360 PMIC
Thread-Index: AQHW5/mnXQCtdpz8fUCDkYCyd6JXlqoiJC0A
Date:   Mon, 11 Jan 2021 09:13:47 +0000
Message-ID: <04b06a6a4020212c4ae65bea9685afccc90c6dee.camel@fi.rohmeurope.com>
References: <1608779989-9641-1-git-send-email-gene.chen.richtek@gmail.com>
In-Reply-To: <1608779989-9641-1-git-send-email-gene.chen.richtek@gmail.com>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a82d813-c060-4b58-d1f8-08d8b61133fd
x-ms-traffictypediagnostic: HE1PR0301MB2474:
x-microsoft-antispam-prvs: <HE1PR0301MB24741507AF2E9F2FCF639D08ADAB0@HE1PR0301MB2474.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSSe42dumPQYuR1vtfAnG8Y+o4wtbvztg6CCcGJGCoAhRO6T0yl6OeGi4BZmlb2DciIpMNAIBD3hVpqtqI4Et5LjnTFXWjBTCWmRnoKZ31zb81MvXblLEihH6ck29FegS7Xod/HMomwAnMV5TrGdVdfGdw6r2GAHOxnTGEBVkeQaPQ+qCcGNuxMHMGfSH1SHZk+F74Ka5ryiBeQlYmvmb2TQr0L2SUwfSMoLo9c3FGbyd2CxI4LsSEGeLhQJB++dC5B5X83KR8SIt4uLxJboSKRsb0b22vinfXTrilWRskKBLUnpABaZSZtZsqtHytHNyIOJNIrlaC4dQsVyPqV1XSJmfsSNWikOfzcrlw+bT3xlG3mNes5TokHTkVB/mfWX8MbCQKao+IQ2kzfGTeOQsaOAgsRpuBtmcf7yJvi1h9PGlSzxzcFYlR/TSme980vwBXEjxKuc3qfUtK3E0GT+xQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39840400004)(396003)(366004)(64756008)(4326008)(2616005)(8676002)(8936002)(478600001)(3450700001)(7416002)(5660300002)(76116006)(66946007)(110136005)(66476007)(316002)(54906003)(66556008)(66446008)(6506007)(26005)(966005)(186003)(2906002)(86362001)(4001150100001)(71200400001)(6486002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Skx6Nk1sc1RNb3FXTjdDZkpzTjdHZ2ZrSkxZS1pKczVGck9lLzRMc3lzN1Vp?=
 =?utf-8?B?bW9QM09ZS3M2b3VwUDNhTE82MUVsUExkdXNUZWFkeDZnY0MrWU1CWUc4RXp5?=
 =?utf-8?B?VTk3dldOTTgwNkp4Z2txNm1iQytZd0hObk9tZ0ExaFhTT0RGd3l5RVRiR2tO?=
 =?utf-8?B?K1hjUTZVemFhOUYvRWZwQmphZWtkVW5QU01pRStQYW9uUjZWZFd2SkxHUnEy?=
 =?utf-8?B?MVJrU09UNEJ0dkp1Z2Ztci9SUjRDVm53UWpzQUo2bVRxRVBJSEd4TGtuQ0c0?=
 =?utf-8?B?ZG81cUhaRGdNZU44NTNRQWpUcUpIUXFqNk9abFlSay95eDlnMy81ZUF0VDdH?=
 =?utf-8?B?RVlxRkNLeGdiVzlCWEtnb2dUKzNuckYwd055QjRGRis4MnRCS1EwREhESFQv?=
 =?utf-8?B?STFvZ1JIT3pVdHFwV1JyczZzRXFWMEJhaVpOZUZPVUtJZUhZWGJJUitJUVFV?=
 =?utf-8?B?R3VLUTBiQk9WdmJtQkZGcUFNMGxOOWFqakM3bGxoaHlGcXJOWEI5dU9WVFps?=
 =?utf-8?B?Uk5EeExWNENzOFJpQ1k0QlhVaDIzQ1BobzNuemRwakcxcVBMNWwzaTRuKzRI?=
 =?utf-8?B?cUpoSFRlRUM3eDdCRXhvbVVsTUFXRXJ5dlJTY095cklSTk1pMVJJazZNOHlU?=
 =?utf-8?B?amlxRDAxUlZHREVLaG9iOXBKWnlkM0FrVnJ5Y2FHSlJvU0dOZEtGTXl5NFBV?=
 =?utf-8?B?SEF2a2xzOFJYMGxuMnIxd3NpU290L3JUVW9PYmNBUlZOMGpySVNKMkRHajVj?=
 =?utf-8?B?NkhqZEg1clRxMmQ1NC9DVVRHMFJDNy9KOCtuaEpqSkRiU1crWXFlUDdBSDZl?=
 =?utf-8?B?YnBoQkI0T2FKOFRQZ2IxSG5YWGpYTmNYMTBOL0Q0QnArY2JSdTJxMDRqemww?=
 =?utf-8?B?QTI0L2lTNEppd2ZWYnQ5TU5KWGNtcW9ia0JUT0hXbGprWHpLU1BwY2RsdVls?=
 =?utf-8?B?aGRvUUV1SEtaaFVKK1k2K0V2cUN4NEtZb2tGQUJCVmJackxWQUNTRWhNZzVX?=
 =?utf-8?B?T3F4NlZSU0pGcENNTEJ4RFk5TFdJTUNwUTc0WHNGNVY3SGJ4TFdxbUlKR2RP?=
 =?utf-8?B?UmxGb0NZdTQxZVJnRk1zY3dtN2dFNnpXR3VUOTc4QlhrSkR2RlZYREFZeHZ1?=
 =?utf-8?B?Y0o1SkRTQ3ZQNlkzdmhBZENtRFlNQWp4dmtmWEZZSFRQNWExMVRpbWNLUys2?=
 =?utf-8?B?NzMvY05xRG9NZHdNMFJnYWdmVW1rYmMzWGIxR3VuM2VDc1BnVEdwRWZZNkFO?=
 =?utf-8?B?ZmtwbXRGdnR0NzJ1MWN1YkdEVEs3V0ZCVnpiRjBkeEVydEdJbkRONGV0TlVF?=
 =?utf-8?Q?2a8vF8KBoRIdbwFS72LxxQhF5wf7XyS4rm?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <01FB73626D9D234D89D6316244374781@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a82d813-c060-4b58-d1f8-08d8b61133fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2021 09:13:47.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bF/9NhRdE7RBLAGvwDHHVh+v/+OJ9WsMdEtpADKRRtZZ4MVohA80gzNVRrlrXxjnzir79xiq+wNMLAuQdtZETC2LIToIb7jTGB39oIvnAj9s69GawH821xzY2ZrwTNn6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2474
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gUGVlcHMsDQoNCk9uIFRodSwgMjAyMC0xMi0yNCBhdCAxMToxOSArMDgwMCwgR2VuZSBD
aGVuIHdyb3RlOg0KPiBGcm9tOiBHZW5lIENoZW4gPGdlbmVfY2hlbkByaWNodGVrLmNvbT4NCj4g
DQo+IEFkZCBiaW5kaW5ncyBmb3IgTVQ2MzYwIFBNSUMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEdl
bmUgQ2hlbiA8Z2VuZV9jaGVuQHJpY2h0ZWsuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvbXQ2MzYwLnlhbWwgfCA2OQ0KPiArKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL210NjM2
MC55YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9tdDYzNjAueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tZmQvbXQ2MzYwLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MC4uMjc4MWMzMQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tZmQvbXQ2MzYwLnlhbWwNCj4gQEAgLTAsMCArMSw2OSBAQA0KPiArIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiArJVlB
TUwgMS4yDQo+ICstLS0NCj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWZk
L210NjM2MC55YW1sIw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwjDQo+ICsNCj4gK3RpdGxlOiBNVDYzNjAgUE1JQyBmcm9tIE1lZGlhVGVr
IEludGVncmF0ZWQNCj4gKw0KPiArbWFpbnRhaW5lcnM6DQo+ICsgIC0gR2VuZSBDaGVuIDxnZW5l
X2NoZW5AcmljaHRlay5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOiB8DQo+ICsgIE1UNjM2MCBp
cyBhIFBNSUMgZGV2aWNlIHdpdGggdGhlIGZvbGxvd2luZyBzdWIgbW9kdWxlcy4NCj4gKyAgSXQg
aXMgaW50ZXJmYWNlZCB0byBob3N0IGNvbnRyb2xsZXIgdXNpbmcgSTJDIGludGVyZmFjZS4NCj4g
Kw0KPiArICBUaGlzIGRvY3VtZW50IGRlc2NyaWJlcyB0aGUgYmluZGluZyBmb3IgUE1JQyBkZXZp
Y2UgYW5kIGl0cyBzdWINCj4gbW9kdWxlLg0KPiArDQo+ICtwcm9wZXJ0aWVzOg0KPiArICBjb21w
YXRpYmxlOg0KPiArICAgIGNvbnN0OiBtZWRpYXRlayxtdDYzNjANCj4gKw0KPiArICByZWc6DQo+
ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICBJMkMgZGV2aWNlIGFkZHJlc3MuDQo+ICsgICAg
bWF4SXRlbXM6IDENCj4gKw0KPiArICB3YWtldXAtc291cmNlOiB0cnVlDQo+ICsNCj4gKyAgaW50
ZXJydXB0czoNCj4gKyAgICBtYXhJdGVtczogMQ0KPiArDQo+ICsgIGludGVycnVwdC1uYW1lczoN
Cj4gKyAgICAgIGVudW06DQo+ICsgICAgICAgIC0gSVJRQg0KPiArDQo+ICsgIGludGVycnVwdC1j
b250cm9sbGVyOiB0cnVlDQo+ICsNCj4gKyAgIiNpbnRlcnJ1cHQtY2VsbHMiOg0KPiArICAgIGNv
bnN0OiAxDQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICBUaGUgZmlyc3QgY2VsbCBpcyB0
aGUgSVJRIG51bWJlci4NCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gY29tcGF0aWJsZQ0KPiAr
ICAtIHJlZw0KPiArICAtIGludGVycnVwdHMNCj4gKyAgLSBpbnRlcnJ1cHQtY29udHJvbGxlcg0K
PiArICAtICIjaW50ZXJydXB0LWNlbGxzIg0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczog
ZmFsc2UNCj4gKw0KPiArZXhhbXBsZXM6DQo+ICsgIC0gfA0KPiArICAgICNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gKyAgICAjaW5jbHVkZSA8ZHQt
YmluZGluZ3MvcmVndWxhdG9yL21lZGlhdGVrLG10NjM2MC1yZWd1bGF0b3IuaD4NCj4gKyAgICBp
MmMgew0KPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gKyAgICAgICAgI3NpemUt
Y2VsbHMgPSA8MD47DQo+ICsNCj4gKyAgICAgICAgbXQ2MzYwQDM0IHsNCj4gKyAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2MzYwIjsNCj4gKyAgICAgICAgICAgIHJlZyA9IDww
eDM0PjsNCj4gKyAgICAgICAgICAgIHdha2V1cC1zb3VyY2U7DQo+ICsgICAgICAgICAgICBpbnRl
cnJ1cHRzLWV4dGVuZGVkID0gPCZncGlvMjYgMCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiArICAg
ICAgICAgICAgaW50ZXJydXB0LW5hbWVzID0gIklSUUIiOw0KPiArICAgICAgICAgICAgaW50ZXJy
dXB0LWNvbnRyb2xsZXI7DQo+ICsgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxzID0gPDE+Ow0K
DQpPdXQgb2YgdGhlIGN1cmlvc2l0eSAtIGlzIHRoaXMgdGhlIGNvbXBsZXRlIG5vZGU/IEkgd291
bGQgYXNzdW1lIHNvbWUNCnN1Yi1kZXZpY2VzIGxpa2UgcmVndWxhdG9ycyBoZXJlPw0KDQo+ICsg
ICAgICAgIH07DQo+ICsgICAgfTsNCg0K
