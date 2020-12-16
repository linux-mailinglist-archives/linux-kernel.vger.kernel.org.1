Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334812DC5AB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 18:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgLPRsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 12:48:03 -0500
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:25222
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728028AbgLPRsC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 12:48:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pr1gAh9mQmYfY1W6GreFLEyT8VN0Gx8b+wr63MkyiFPZwrcWohTca9AX9R5eaH5FMbTpWWYfguV0gDe8uYgc+XrRKSbSAiJZq6+Hwzriy8na7q2z+4b0GexSMBXnRFybRCWxULpg75uPLGW07QrjRdqovV09KG7n5ZXo91pvPp2MxRB5jPxXhqslVnrl9ga51x+c/rqpv98W8Op9EgXwnXy3DbyC2QfXi5MA9DlGGld3sHqEeKv5c4fjCdpo5rzWxmqlwklPGchmZyHyVWjKTsCeJ1g9WUaRB5y0dn/CCaOtlMdpWq0PSFn/mIhAWfcTdEpYV15wByt/wP3DDY/a/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpobdPyCtJCGM+LpdWaD7VXlnrCIR3Gro9hWOe9Mroc=;
 b=JWvsYfUvceI7DV08fYraNmPllNJWWOLcz3DxUzIJC0SuBOUzYgcyf9QFzR9JaS4p8kGSE89pHSntK/LE/SQQFxQPdsDBFqYDMYK1/EaUqd5Ohz63y1PITutjJENBcbAKq9eeWT2+0wQOPLXEfDbyn1a5ejNKRhi7F9GB3n0Tc6ndPGmPspTZXpLbQuDLsPtlWRTLkFD5AFMwkHMBU/BgSMI2DowoXHmKs+CirDf2n1aWmzAwxGLBPyLNPp4+s4r8LqpdJdwjmPa+JOTiCcGBFvsKmK+p8xtbE2K/gFe3L7A3PvoOq7KzOBZLiFu5saOBeM+5MekATyaiDqQfFAiYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fi.rohmeurope.com; dmarc=pass action=none
 header.from=fi.rohmeurope.com; dkim=pass header.d=fi.rohmeurope.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rohmsemiconductoreurope.onmicrosoft.com;
 s=selector1-rohmsemiconductoreurope-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TpobdPyCtJCGM+LpdWaD7VXlnrCIR3Gro9hWOe9Mroc=;
 b=Egn55fHxESU2iYqSeFH4UWId4U5aOk2L5R8zM4p9GUivMUP5mav7Rdq7LUo7yK7sylMDtqIWH6sVY+6iCjhpai9p8/x0xl1pTF3j2pD/cFv7cr8h3ngqp3bHK4H5tpLULQNYPPBtrwPvzu7TOYQGt9IOcQzdtoWE5ui9xdj37qE=
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com (2603:10a6:7:55::20) by
 HE1PR0301MB2283.eurprd03.prod.outlook.com (2603:10a6:3:23::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.21; Wed, 16 Dec 2020 17:47:11 +0000
Received: from HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87]) by HE1PR03MB3162.eurprd03.prod.outlook.com
 ([fe80::f1f1:eb1d:2bf5:eb87%7]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 17:47:11 +0000
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "guido.gunther@puri.sm" <guido.gunther@puri.sm>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        linux-power <linux-power@fi.rohmeurope.com>,
        "angus.ainslie@puri.sm" <angus.ainslie@puri.sm>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] regulators: bd718x7: Add enable times
Thread-Topic: [PATCH 1/1] regulators: bd718x7: Add enable times
Thread-Index: AQHW05tyoY0RX9paika1ZtaJVmaczqn5psMAgAADl4CAAAHeAIAAU4YA
Date:   Wed, 16 Dec 2020 17:47:11 +0000
Message-ID: <3f37c66f00878e8bc6a387d2969bde32cf2f5fbb.camel@fi.rohmeurope.com>
References: <cover.1608116704.git.agx@sigxcpu.org>
         <d2b3d053d28ea0f35e7526b523287358c8fe20c2.1608116704.git.agx@sigxcpu.org>
         <7d4903f67ff81a9a749e75f24af0aea903213c43.camel@fi.rohmeurope.com>
         <20201216124133.GA31109@bogon.m.sigxcpu.org>
         <20201216124814.GA4861@sirena.org.uk>
In-Reply-To: <20201216124814.GA4861@sirena.org.uk>
Reply-To: "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=fi.rohmeurope.com;
x-originating-ip: [62.78.225.252]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7bd67fe-9606-4ad5-07f0-08d8a1ea9db8
x-ms-traffictypediagnostic: HE1PR0301MB2283:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0301MB2283C9C43273C9D5DC70534FADC50@HE1PR0301MB2283.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pe7ICJiBo5hlgpjQXEtyZTgz857NajwuQHeWlNa3E+4X+cA0pfXM5PAiloYqZQEl7T91g1vnuWtm2k/PkaoUFuDyJ5fTigIQpsnePJRf9QBB3XI0sPeM0RB0iQk+blgdidGwAl0TdYDnrWY05EcejoMGpso+zhBSS4sVYIDKSbxx98fAHqtp0zAekVj8yKqh3dsBueep0t/JtVa0q22dLqUsNXygXMTzxlaW+AQoS3JMaAkWD/jRmzKYpXqL1rzhHkzfoM/gRjbxT2ocfSv/AA93MDUaitVjy9Ffz7B1hA66kpFMz2p4qvKK+stmQacLdh5Mz2DE+QtcMZhmdNWR2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR03MB3162.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(346002)(396003)(376002)(366004)(66574015)(66946007)(64756008)(8936002)(86362001)(6506007)(76116006)(4001150100001)(66446008)(186003)(66476007)(5660300002)(2616005)(478600001)(8676002)(6486002)(71200400001)(316002)(66556008)(4326008)(54906003)(26005)(6512007)(110136005)(3450700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c0Z2YU9TTmRBbHBBaWVkdzdrbjVJKzVLNGQ2TndJVkxScmcwdTkyRjN1d0Jw?=
 =?utf-8?B?UkxERHpSL3RoaXNSdVlzbTZMc0t2ZzBrazU4ejkwSGZXM3BmRDduZWVrT1dL?=
 =?utf-8?B?cWRqU21uWHNVZHBsSnREK3dEMGovR1BtYXpXampyeVlNU2hJZUk0eW1HNGY1?=
 =?utf-8?B?eG1UMk5UTzFNTTQwQXZXZ3JoclQ3VUxWQVhxcUNvNG1YQlpITUZ4SnBwbTJt?=
 =?utf-8?B?d3JWRkR5VU03VUJJaTB2TFRwdVBCY1MvK2toRTZNTXZ5Q2J4U1lZK3R5UXI3?=
 =?utf-8?B?eGVYdlVJeFYvYkFQM3ZIeVp4SUdyM0lRcyt5em94SVU0OGdmdnZkaVJZVzJN?=
 =?utf-8?B?aDZHRDRUcW5CWituZWlsUlU3R1ZVWitweUpQWWtWUkxBeFdnOUdYamhNZW9z?=
 =?utf-8?B?aWlKb3ZOTDRydVhyckF3b2tCeW1XNXVQNW00Q09KWks2bDFkcFZMSlFjRmRm?=
 =?utf-8?B?OVpONTdXMVBxREFpTzh0VDBBa1k5ZjlrQW9OT2R1c20zY1RDWlVCUVY0QURu?=
 =?utf-8?B?b09BcnRib3IzUHk1QkpzS1NJNVp0aU5QS09tMU11NWtac0Z1QjNXdlFyMkE5?=
 =?utf-8?B?L0NOZlVCb2NkNGx6K25IU2hwUSs0ZGsvbSsyeWFRbTJWdkxsOXJQVllxZ0JF?=
 =?utf-8?B?b2V3ejM2SmpJYzBVbEgzcDJrbXArMWF4dUtmd1gzMGt4WnBVN2h2TzhyMHlQ?=
 =?utf-8?B?RGd2WUp0bXBhaTZnZnkwb1dWQk1WK2gyUE53eW1UYVhvRFdjRmxFUUF4bW9U?=
 =?utf-8?B?UFhqdWpUTjVDWEFWcFVwdUpyWGVGUm9JanhsekpHb1NUaTloVjhMTW5rVFZV?=
 =?utf-8?B?MnVBSTVuQ1ZpcndWSEJPRGM1Szh0bWp4MGx4Qnd2V1cvQ01qd1FFSW9WUGVK?=
 =?utf-8?B?TitURkoxeTQ5UHU4aHd3RGdrbEpPVUw2N0Vqb2xJK1pIVk04SVpocTZ6N3Qv?=
 =?utf-8?B?UHg2b0FNYk03dlV2OEF1Z05iMUdjVVZwQ0RNcmNGKzdWY2VIYVZVelZzZ1Vh?=
 =?utf-8?B?M0o5VGtPdmdWSEROQ0p2N1Job005TWdOVkNtTTFyZjhwQ3l4U2kxRndjT1pD?=
 =?utf-8?B?a3hlaWRhLzlLQlhUSnM0Yms1Z1Nnc2IvYVpaNmoyVzhSTlB4eGt3VVNYam5D?=
 =?utf-8?B?Nnlzdk9lWmtJSWJQRUhOVHZJVUxReGprMmVwVW5xVy9MNW5zb1BsdTVhSG40?=
 =?utf-8?B?Vy9IOW9EemkxR2xyL2lFNDltUFRvelB4VEdvS0lVNVVmaEJZSHhMaWVKSlpU?=
 =?utf-8?B?eVYzWVN2N1NTb2JRUTd0QlQ5WURKb050ZkxJVmdiUDZ1SENNZ0xlY09WRHpV?=
 =?utf-8?Q?LTtqFlIryiMW+iLAQOFmk9YNz/x2vJ2x5L?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BFE37D905ED61449445D2225F72736E@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fi.rohmeurope.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR03MB3162.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7bd67fe-9606-4ad5-07f0-08d8a1ea9db8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2020 17:47:11.2168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 94f2c475-a538-4112-b5dd-63f17273d67a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/pUg0YvDmd2l2lfY1KURnlV+6kOTwsbrHJ8PBJ4zqXqY11XHkJuggtJgquBObL9ZMjX8Giz87JAbPsKbscQUi+BDi0lv5URusnunzTDMUKNxBmanWvLv6qwNRI8Txgy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB2283
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMTItMTYgYXQgMTI6NDggKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIFdlZCwgRGVjIDE2LCAyMDIwIGF0IDAxOjQxOjMzUE0gKzAxMDAsIEd1aWRvIEfDvG50aGVy
IHdyb3RlOg0KPiA+IE9uIFdlZCwgRGVjIDE2LCAyMDIwIGF0IDEyOjI5OjIwUE0gKzAwMDAsIFZh
aXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gPiA+ICsJCQkuZW5hYmxlX3RpbWUgPSAxNDQsDQo+
ID4gPiBXaGVyZSBhcmUgdGhlc2UgdmFsdWVzIG9idGFpbmVkIGZyb20/IEkgaGF2ZSBhIGZlZWxp
bmcgdGhleSBtaWdodA0KPiA+ID4gYmUNCj4gPiA+IGJvYXJkIC8gbG9hZCBzcGVjaWZpYy4gSWYg
dGhpcyBpcyB0aGUgY2FzZSAtIGNhbiB0aGUgInJlZ3VsYXRvci0NCj4gPiA+IGVuYWJsZS0NCj4g
PiA+IHJhbXAtZGVsYXkiIGZyb20gZGV2aWNlLXRyZWUgYmUgdXNlZCBpbnN0ZWFkIHRvIGF2b2lk
IGhhcmQtY29kaW5nIA0KPiA+ID4gYm9hcmQNCj4gPiA+IHNwZWNpZmljIHZhbHVlcyBpbiB0aGUg
ZHJpdmVyPyBBbHRob3VnaCwgc2FuZSBkZWZhdWx0cyB3b3VsZA0KPiA+ID4gcHJvYmFibHkNCj4g
PiA+IG5vdCBiZSBhIGJhZCBpZGVhIC0gaWYgSSByZWFkIGNvZGUgY29ycmVjdGx5IHRoZW4gdGhl
IGNvbnN0cmFpbnMNCj4gPiA+IGZyb20NCj4gPiA+IERUIGNhbiBiZSB1c2VkIHRvIG92ZXJyaWRl
IHRoZXNlIHZhbHVlcy4NCj4gPiBUaGV5J3JlIHRoZSAndHlwaWNhbCB2YWx1ZXMnIGZyb20gdGhl
IGRhdGEgc2hlZXQgYW5kIGl0J3MgYmFzaWNhbGx5DQo+ID4gYWxsDQo+ID4gYWJvdXQgc2V0dGlu
ZyBhIGRlZmF1bHQgZm9yICJyZWd1bGF0b3ItZW5hYmxlLXJhbXAtZGVsYXkiIHRvIGF2b2lkDQo+
ID4gaGF2aW5nIGV2ZXJ5IGJvYXJkIGRvIHRoZSBzYW1lLiBJZiB0aGF0J3Mgbm90IHRoZSByaWdo
dCB0aGluZyB0b2RvDQo+ID4gbGV0DQo+ID4gbWUga25vdyBhbmQgaSBhZGQgdGhlc2UgdG8gZWFj
aCBvZiBvdXIgYm9hcmRzICh3aGljaCBpcyB3aGVyZSBpDQo+ID4gYmFzaWNhbGx5IHN0YXJ0ZWQg
ZnJvbSBidXQgdGhlbiBmaWd1cmVkIHRoYXQgdGhpcyB3b3VsZCBiZSBidXN5d29yaw0KPiA+IGFu
ZCBldmVyeSBib2FyZCB3b3VsZCBoaXQgdGhhdCBwcm9ibGVtKS4NCj4gDQo+IElmIGl0J3MgYSBE
Q0RDIHRoZXkncmUgKnByb2JhYmx5KiBnZW5lcmljIHZhbHVlcyByYXRoZXIgdGhhbiBib2FyZA0K
PiBzcGVjaWZpYywgdGhleSB0ZW5kIHRvIGJlIG1vcmUgcHJlZGljdGFibGUgYXMgdGhleSdyZSBy
ZWd1bGF0aW5nIG11Y2gNCj4gbW9yZSBhY3RpdmVseSB0aGFuIExET3MuDQoNClRoYW5rIHlvdSBm
b3IgZXhwbGFuYXRpb24gTWFyayAmIEd1aWRvLg0KVGhlbiBJJ2Qgc2F5IHRoZSAnZGVmYXVsdCcg
ZW5hYmxlIHRpbWVzIGRvIG1ha2Ugc2Vuc2UuIFRoYW5rcyBmb3INCmltcHJvdmluZyB0aGUgZHJp
dmVyIQ0KDQpCZXN0IFJlZ2FyZHMNCglNYXR0aSBWYWl0dGluZW4NCg==
