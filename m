Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2939D2DBE11
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgLPJ41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:56:27 -0500
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:12801
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbgLPJ41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:56:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7oNo4KXTpCbU4RTd/bmKE429+OEYK5PoxjJ0Dy9/JSLV7mZMbs2PRxyROUBwIzWmlaVe7Z4qlNdVMQffsGuxgEaFZzduYWlfpntZEEUlovAPN+R4ntRRXzrxP5xqjV1gVYIhwt0w85EihOfjBee2gGUf27Rpa6uX/NJTo5O9kL2dezakiAVmymKxIFNAM5wYluL7hFiTViQSvT+qEVrwixEPD/0Kpg53f4de1yaGJt21jJk//Th07APBj90Tn4xxaOqCYJk8fomDbqcpn7UUM1XYUp7t+SQG5AXZclyXreH06cEUBLAsDyNmwSpjU+Gt3VOlxN9tColt8UfUzdRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HMquhw8b5PmFByzqLuRsF7L39OQOcF3rc4/lL2ZRKY=;
 b=HMKMAZ8Zr1lRK5AQwWcIsdNVHH0pZp8xfwiUmM3+6Q78EPaScvGW9ymkW8UoBVPm/l2ZO6uZfvhspUeocTmPAMrmdD2cg519BWa+wsqOfiW3/yDTj4RTeTaX4Xxp6P4vUH04vGhXXKpe7UKuSgQURZ2aKOaERf/K474qlIgDd+3YjTDI5Ad0vAtw/IjzYvuJCnkMM0BycN4oLvzYIfldZPpQ/5TzrJ8SLU5AKN7bhigWY+McO8CujLHNxmsMS139cuU3quWQ0l5vlrP8yIaV80fm/Sy/+9ym4wFj5TFMixngeGvGjhkqUTaj/vDvmqZKNWeKwzla0qA15p8ORHJXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HMquhw8b5PmFByzqLuRsF7L39OQOcF3rc4/lL2ZRKY=;
 b=jvU/79291BSHv27xSSsPlrWS257j62Jt+Tw7oMUf09mo9vwjlJCkSO+2brSqxuqOyq/a+C5WRTvytOFNNkxIKtgm7GCWNbHha7C5kLFWE7Cfgxlx9OPiaAcO31QdYMWyGzRb/yhLHfDcBjgdi+KB3BZJ4W2caF1JetCTfbqqv/M=
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM5PR04MB3201.eurprd04.prod.outlook.com (2603:10a6:206:e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.20; Wed, 16 Dec
 2020 09:55:34 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 09:55:34 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Topic: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for
 soc unique ID
Thread-Index: AQHW0r2T16pUmRKNaE+vcoTiMv9Y1qn33wMAgAGYjSA=
Date:   Wed, 16 Dec 2020 09:55:34 +0000
Message-ID: <AM6PR04MB6053AE68690ADF805D5A0809E2C50@AM6PR04MB6053.eurprd04.prod.outlook.com>
References: <20201215083551.6067-1-alice.guo@oss.nxp.com>
 <20201215091118.GB9386@kozik-lap>
In-Reply-To: <20201215091118.GB9386@kozik-lap>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fc62710-c867-4833-be50-08d8a1a8bb82
x-ms-traffictypediagnostic: AM5PR04MB3201:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB32013CC81F7E3B3498C2FF14A3C50@AM5PR04MB3201.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kCtOchORJL8RxvT/gNdZuNWFr+h0IFsKI5bONJi6PGfjmoUTh3U/1Eds/l4SeVVplZjWcI6NWRZB/Js4Zfavkc3/ARCJ+WxGc3luuPDgKkyeFUX21mVpoGhrZQAx/TncDbWZoDln2cVyTD5tKfzRwmrt6/PQXZp/yffXt1mHHZHMCUhStshqiRhMGGr4gGxrhmFECYJaKNor+3P3gQfDWiz2KU2fZ8n6hCoQF6G7cKsaq9oiGkmwF7T013oI5xp6Sc+r+pas6WWBfgoej175unEBxocoona0ZlTp0xqEzKPzPGYdSWr9OHZrpDY7v229nyiq4D4dBUewY81glFWA5X5otxmlJN10QEtAJNzB3xGwXcvI625EvenZeWABj51fOKBYFHyqmFJiFoftC67R2145ixQVp9OZFhshRRmZg9RmBScd8HwFQXvCiuIJYFJwq7lP8aALgjYcFjknmDyx1g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(7696005)(83380400001)(76116006)(110136005)(53546011)(316002)(26005)(86362001)(52536014)(71200400001)(186003)(2906002)(8936002)(55016002)(9686003)(5660300002)(54906003)(966005)(66946007)(66476007)(66556008)(8676002)(64756008)(478600001)(4326008)(66446008)(33656002)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RzZnNXRyb254UmxiZENzSGdlMkxXSzhJMHRyS0RLNHppRi8vdW5ZdkVaSmNt?=
 =?utf-8?B?U2VzR2J5TGNyYnNjR3Q3ZkJOVkZ5NkpPMWtwckZUandCTUVCMk13WUZQUE9T?=
 =?utf-8?B?SVJES0p3Z1owcGRjdk43QWtkSVJYUGNaemt3aForQWpMb0JlY3pVbEpyUXBB?=
 =?utf-8?B?VGVjUVgxaHh4ZGcyUUQ4bEMyL3Q4ajdEUXMzVnd4S1EyaEdTUXlRTG5NTUJk?=
 =?utf-8?B?ZFdZWjNmYzBEZ1NUKys4RHBZM25KMUVqZThEaHFrWVV1ZXFmeGVOVU16dmpy?=
 =?utf-8?B?ZlZsekdPTDZNb2JrSFZzblJBZU0zdC92djhrcFBqZW05TjM2MytDK2FseE5D?=
 =?utf-8?B?Sk1pVENRYktGRkR2aUtFZGNHQ2lpRzhQWmM0c0N4dW81bmxYbXN5YlpERWxx?=
 =?utf-8?B?SmlXdVQ3TUNQMmlVSTVVelVpcXhiQm1rbTBoLzhwYWhxdFBWakJ3TTNINHJL?=
 =?utf-8?B?NEg2dFJQZ3pMYWxTc01CQVVUOUZGaUdxRVhOZzhpajNLQ3pWTVFhakM0U2FZ?=
 =?utf-8?B?TUV6MUJVUTU0RElaK1FNMHpONXN2MU9MT2crU1lHYzF1b3lFYUV3ellKbm9l?=
 =?utf-8?B?OFZSUVVlcEd5N2dSTThaWEtHbnhDVnRwLzdVa0ZCMFdxTk9DV2laOGYzNnRD?=
 =?utf-8?B?eURTRUZjQ3drVUMra2dQaHR0VnNwcE5aU2dlYWkvTXdHMldYa1psaHU2OXVN?=
 =?utf-8?B?T0lOQ1l6bThLZXBQbGE5VWpMa0RVU1Z5WEJBWE1nWEFRUTQyOEdsWW9QZkwv?=
 =?utf-8?B?TXN5SldQUldrOXVydC8yRnczUXBkK0JtcmpNOXJ1RmFUamtkNTlLQW9MWVJp?=
 =?utf-8?B?MERTRktGSE81MzZUenZnOHVnc2t4RnErSHhxbDFDU0c3TWZ6Z0hjVXhITWt4?=
 =?utf-8?B?amI5d0NRM3Q1YTNRUmV1NGhrNVJBY3VuNDJXbStMYnNkWS9SdlVWNnRKczM2?=
 =?utf-8?B?eEFTK2xNVkR5OVJqWklydXgrYUtwUDB5RlZLN0JpTjlJenJiNW14Nlo5L1dL?=
 =?utf-8?B?UlJyMGF0Rjh6RzB6WWh0a25YZkVtTGtpU2MrTFZMTXpKbzc3eFBWWHZtNUpZ?=
 =?utf-8?B?cTJRblR5dXNYcUozTjNacEZYUzBKemNTU2tjVGtMYlA1MDdBdlJTKzBzT2xj?=
 =?utf-8?B?UXY4d2l5YS9uN0diN1hxaDVobmF0ZDBaSHNuOFJnaFV3N0VQK0hLK0d5VmVS?=
 =?utf-8?B?WWoxaGNPM2ZxV21sQkVnRStBTmpYdms2cWdoZTNjSS9qTmQ5a09kNHVJZXVI?=
 =?utf-8?B?R2xDU1JXMDNzSDNBdGU0dkkrVGZWbWZwZWJ1OXh0YUFGcldRaEhjYVBoK3F1?=
 =?utf-8?Q?6L/6eQEGCPoYM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc62710-c867-4833-be50-08d8a1a8bb82
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 09:55:34.4291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ySGqZQexFMns3iGW2e9qxyCwpkx3sfMzX85sfDZ9KRZcyPJ2deq+T4aOfc1Z5F7eGIFXSRj6RykmQ2ThL4bb1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3201
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0MTLmnIgxNeaXpSAxNzoxMQ0K
PiBUbzogQWxpY2UgR3VvIChPU1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+DQo+IENjOiByb2Jo
K2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4gPGxpbnV4
LWlteEBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY3IDEvNF0gZHQtYmluZGluZ3M6
IHNvYzogaW14OG06IGFkZCBEVCBCaW5kaW5nIGRvYyBmb3Igc29jDQo+IHVuaXF1ZSBJRA0KPiAN
Cj4gT24gVHVlLCBEZWMgMTUsIDIwMjAgYXQgMDQ6MzU6NDhQTSArMDgwMCwgQWxpY2UgR3VvIChP
U1MpIHdyb3RlOg0KPiA+IEZyb206IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+ID4N
Cj4gPiBBZGQgRFQgQmluZGluZyBkb2MgZm9yIHRoZSBVbmlxdWUgSUQgb2YgaS5NWCA4TSBzZXJp
ZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbGljZSBHdW8gPGFsaWNlLmd1b0BueHAuY29t
Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gQ2hhbmdlcyBmb3Igdjc6DQo+ID4gIC0gY2hhbmdlIHRvIGEg
c2VwYXJhdGUgc2NoZW1hIGZpbGUNCj4gPiBDaGFuZ2VzIGZvciB2NjoNCj4gPiAgLSBub25lDQo+
ID4gQ2hhbmdlcyBmb3IgdjU6DQo+ID4gIC0gY29ycmVjdCB0aGUgZXJyb3Igb2YgdXNpbmcgYWxs
T2YNCj4gPiBDaGFuZ2VzIGZvciB2NDoNCj4gPiAgLSB1c2UgYWxsT2YgdG8gbGltaXQgbmV3IHZl
cnNpb24gRFRTIGZpbGVzIGZvciBpLk1YOE0gdG8gaW5jbHVkZQ0KPiA+ICAgICJmc2wsaW14OG0q
LXNvYyIsIG52bWVtLWNlbGxzIGFuZCBudm1lbS1jZWxscy1uYW1lcyBDaGFuZ2VzIGZvciB2MzoN
Cj4gPiAgLSBwdXQgaXQgaW50byBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJt
L2ZzbC55YW1sDQo+ID4gIC0gbW9kaWZ5IHRoZSBkZXNjcmlwdGlvbiBvZiBudm1lbS1jZWxscw0K
PiA+ICAtIHVzZSAibWFrZSBBUkNIPWFybTY0IGR0YnNfY2hlY2siIHRvIG1ha2Ugc3VyZSBpdCBp
cyByaWdodCBDaGFuZ2VzDQo+ID4gZm9yIHYyOg0KPiA+ICAtIHJlbW92ZSB0aGUgc3ViamVjdCBw
cmVmaXggIkxGLTI1NzEtMSINCj4gPg0KPiA+ICAuLi4vYmluZGluZ3Mvc29jL2lteC9pbXg4bS1z
b2MueWFtbCAgICAgICAgICAgfCA1NA0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXNvYy55YW1s
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NvYy9pbXgvaW14OG0tc29jLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvaW14L2lteDhtLXNvYy55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmEyZjdkYzBjOWIzNQ0KPiA+IC0tLSAvZGV2L251bGwN
Cj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9pbXg4
bS1zb2MueWFtbA0KPiA+IEBAIC0wLDAgKzEsNTQgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gPiArLS0tDQo+
ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvc29jL2lteC9pbXg4bS1zb2Mu
eWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9j
b3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTlhQIGkuTVg4TSBTZXJpZXMgU29DDQo+ID4g
Kw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5j
b20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIE5YUCBpLk1YOE0gc2VyaWVz
IFNvQ3MgY29udGFpbiBmdXNlIGVudHJpZXMgZnJvbSB3aGljaCBTb0MgVW5pcXVlDQo+ID4gK0lE
IGNhbiBiZQ0KPiA+ICsgIG9idGFpbmVkLg0KPiA+ICsNCj4gPiArc2VsZWN0Og0KPiANCj4gTWht
LCB0aGVyZSBhcmUgb3RoZXIgY29tcGF0aWJsZXMgaGVyZSBzbyBpbmRlZWQsIHNlbGVjdCBpcyBu
ZWVkZWQuDQo+IA0KPiA+ICsgIHByb3BlcnRpZXM6DQo+ID4gKyAgICBjb21wYXRpYmxlOg0KPiA+
ICsgICAgICBjb250YWluczoNCj4gPiArICAgICAgICBlbnVtOg0KPiA+ICsgICAgICAgICAgLSBm
c2wsaW14OG1tDQo+ID4gKyAgICAgICAgICAtIGZzbCxpbXg4bW4NCj4gPiArICAgICAgICAgIC0g
ZnNsLGlteDhtcA0KPiA+ICsgICAgICAgICAgLSBmc2wsaW14OG1xDQo+ID4gKyAgcmVxdWlyZWQ6
DQo+ID4gKyAgICAtIGNvbXBhdGlibGUNCj4gDQo+IFRoaXMgZG9lcyBub3Qgd29yayAtIGRvZXMg
bm90IG1hdGNoIGFueXRoaW5nLiBJdCBzZWVtcyB5b3UgbWlzc2VkIHByb3Blcg0KPiAicmVxdWly
ZWQiIGZvciB0aGUgbWF0Y2hlZCBub2RlLg0KPiANCj4gUHJvdmlkZSBhbHNvIGFuIGV4YW1wbGUu
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KPiANCg0KSGksIEtyenlzenRvZg0K
VGhhbmsgeW91IGZvciB5b3VyIGFkdmljZS4gTXkgb3BpbmlvbiBpcyBkaWZmZXJlbnQgZnJvbSB5
b3Vycy4NCg0KSSBkaWQgdGhlIGZvd2xsb3dpbmcgdGVzdDoNCi0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvaW14L2lteDhtLXNvYy55YW1sDQorKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9pbXg4bS1zb2MueWFtbA0KQEAgLTIy
LDYgKzIyLDcgQEAgc2VsZWN0Og0KICAgICAgICAgICAtIGZzbCxpbXg4bW4NCiAgICAgICAgICAg
LSBmc2wsaW14OG1wDQogICAgICAgICAgIC0gZnNsLGlteDhtcQ0KKyAgICAgICAgICAtIGZzbCxs
eDIxNjBhDQogICByZXF1aXJlZDoNCiAgICAgLSBjb21wYXRpYmxlDQoNCuKenCAgbGludXgtbmV4
dCBnaXQ6KG1hc3Rlcikg4pyXIG1ha2UgQVJDSD1hcm02NCBkdGJzX2NoZWNrIERUX1NDSEVNQV9G
SUxFUz1Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL2lteC9pbXg4bS1zb2Mu
eWFtbA0KLi4uDQovaG9tZS9ueGY1NTEwNC92aXJ0dWFsaXphdGlvbi91cHN0cmVhbS9saW51eC1u
ZXh0L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLWNsZWFyZm9nLWN4
LmR0LnlhbWw6IC86IHNvYzpjb21wYXRpYmxlOjA6ICdzaW1wbGUtYnVzJyBpcyBub3Qgb25lIG9m
IFsnZnNsLGlteDhtbS1zb2MnLCAnZnNsLGlteDhtbi1zb2MnLCAnZnNsLGlteDhtcC1zb2MnLCAn
ZnNsLGlteDhtcS1zb2MnXQ0KICAgICAgICBGcm9tIHNjaGVtYTogL2hvbWUvbnhmNTUxMDQvdmly
dHVhbGl6YXRpb24vdXBzdHJlYW0vbGludXgtbmV4dC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc29jL2lteC9pbXg4bS1zb2MueWFtbA0KLi4uDQoNClNvLCBJIHRoaW5rIGl0IHdv
cmtzIGFuZCBjYW4gbWF0Y2ggc3R1ZmYuIEkgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCBwcm9wZXIg
IiByZXF1aXJlZCIgSSBtaXNzZWQuIFBsZWFzZSBnaXZlIG1lIHNvbWUgdGlwcy4gVGhhbmsgeW91
Lg0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZQ0KDQo+IA0KPiA+ICsNCj4gPiArcHJvcGVydGllczoN
Cj4gPiArICBzb2M6DQo+ID4gKyAgICB0eXBlOiBvYmplY3QNCj4gPiArICAgIHByb3BlcnRpZXM6
DQo+ID4gKyAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgaXRlbXM6DQo+ID4gKyAgICAg
ICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OG1tLXNvYw0KPiA+ICsg
ICAgICAgICAgICAgIC0gZnNsLGlteDhtbi1zb2MNCj4gPiArICAgICAgICAgICAgICAtIGZzbCxp
bXg4bXAtc29jDQo+ID4gKyAgICAgICAgICAgICAgLSBmc2wsaW14OG1xLXNvYw0KPiA+ICsgICAg
ICAgICAgLSBjb25zdDogc2ltcGxlLWJ1cw0KPiA+ICsNCj4gPiArICAgICAgbnZtZW0tY2VsbHM6
DQo+ID4gKyAgICAgICAgbWF4SXRlbXM6IDENCj4gPiArICAgICAgICBkZXNjcmlwdGlvbjogUGhh
bmRsZSB0byB0aGUgU09DIFVuaXF1ZSBJRCBwcm92aWRlZCBieSBhIG52bWVtDQo+ID4gKyBub2Rl
DQo+ID4gKw0KPiA+ICsgICAgICBudm1lbS1jZWxscy1uYW1lczoNCj4gPiArICAgICAgICBjb25z
dDogc29jX3VuaXF1ZV9pZA0KPiA+ICsNCj4gPiArICAgIHJlcXVpcmVkOg0KPiA+ICsgICAgICAt
IGNvbXBhdGlibGUNCj4gPiArICAgICAgLSBudm1lbS1jZWxscw0KPiA+ICsgICAgICAtIG52bWVt
LWNlbGwtbmFtZXMNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQo+ID4g
Ky4uLg0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
