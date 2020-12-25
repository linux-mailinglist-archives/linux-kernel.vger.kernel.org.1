Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46E12E294A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 01:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgLYARk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 19:17:40 -0500
Received: from mail-vi1eur05on2087.outbound.protection.outlook.com ([40.107.21.87]:37152
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728914AbgLYARk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 19:17:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJIzCg6/xVyb4SONpmZ2ywEpTh4ZLRYjaZUg1CNyIt9URlThhUfXV9mkKrI9cpL3cAzfEusFb7+f0GCwMLlj4v2f1+K7321jADB5+9QHBlNZUgbSMuvq3EHu8J12CeDKdee5+l7puS2+aeUqQSXP3o75NxJQwnccal75B4O8ZwhukU5Zyz9PCxm1oRvZ3VNSt7l3q9pSTPbRd++nZeBg25wWADanEb1RK0qt7veox0QvGugrZwYGb1qgAakYXgvREMMVHVFPnwUfyyrYpbdvBPi7+icQkDP8/loUGu3cK+Zdlk4iUlMaIi+jgqZdWNo6fqk2RqsSIuOWHixL1UvGSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBK48Y1+nqbGEEaSHj6pJCiFEtCwZKKpmjYyGn/ZAlg=;
 b=NcE6q6IDuwqUFUHIUtydesBYvG0OPjvCjpuFTjIvM8rZY5N2Dd4izDK5GFi1XwoS6Y9eBs9gpAkCTriZVK+BtCJwTGmwhswgjnbnzDuif5MRmWL3Dn4jCxOxgE6PEem6BLnINdikSI7JzI3h5/bedW9TIuxhWqmvnppwXUuSghOFiTwBpXEmtb4g7b9qIL2/km/acwr4YD+80l7r74f9/mheQAyWZd9/z+8XZo2Ie3UXZjrO/xYs+TVzBGTQz0TQTDIUcqt6Xij7H/+yL+orowHptZ70wO6xV16eZn+bRePwn8CGs/GlIIDOClYasM6tMRLPeKNSUFiUaqIMiHVmcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBK48Y1+nqbGEEaSHj6pJCiFEtCwZKKpmjYyGn/ZAlg=;
 b=cqMQ/WUmYhtxvwq80qzl2hxZjd3Dx/Luvf7MN8nVUVFoocSJXTLM/RxJkPe6qZx40yHsv+Cvg1/0V3RahgXKBdeNAkKGvUpZqLUg5zCZoXwxgDLp6g1KtVX8dR+/MOHEUHHlnElJC7OIYt81lHUsHBcFVQjqkxODuXGXYHmCr0E=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB6619.eurprd04.prod.outlook.com (2603:10a6:10:108::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 25 Dec
 2020 00:16:48 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3676.033; Fri, 25 Dec 2020
 00:16:48 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Topic: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Index: AQHW2UgQyk5+oV5VRE2UEkoGEW5gpKoFv+eAgAB1K4CAAAV7IIAAAviAgAABmQCAALSi0A==
Date:   Fri, 25 Dec 2020 00:16:48 +0000
Message-ID: <DBBPR04MB7979925F193F7D5AE4454C328BDC0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20201223162403.10897-1-pali@kernel.org>
 <20201224055425.GA27629@b29397-desktop>
 <20201224125347.z2ka7itpxuvboghq@pali>
 <DBBPR04MB797907A4C3D7666B867AE2F08BDD0@DBBPR04MB7979.eurprd04.prod.outlook.com>
 <20201224132401.7inh5ae7aaqvooxe@pali> <20201224132944.5odphwxtnzhvkeg7@pali>
In-Reply-To: <20201224132944.5odphwxtnzhvkeg7@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9001fd6e-cbea-4bd6-8fb8-08d8a86a5ed1
x-ms-traffictypediagnostic: DB8PR04MB6619:
x-microsoft-antispam-prvs: <DB8PR04MB6619D421E148697765DB19E68BDC0@DB8PR04MB6619.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ygGIqT+f/4esJHzJjVUYAaW5NEuqBXU8ScdHpSVT8XXqWjM/MXEd+GF1qwH8bK6nyD/kDSGjcB6bTk8wzEHaAYzDyfC3kKKSXGII5HsBBf+UVs3mtPygaDzZlx2gFIL30SiHrv5d14hbcQYhrJG5Fb1Fm4Ndk750W50KrYwL+0oWQ8/R2BwDP2bWFR4CTsoweLdyN/noh1In3zP4XMOuxEWpG3su7bMbFyaWigprINb4nmRlvrRIZhthP8axLYxW2sBOHq98xspI5SNK7Y+qYmutfVyAvvmruNXozzYJRJfg7OcgnbnUieYT8O/P+O3TirmHSBssKTg/vjxd4EZxCi4Rbp+2D/RWYsTpfcfYYW5R2A8XYWiSLPdt+8QFMsDir7spWdC6kdOeoLikzTdT3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(346002)(136003)(396003)(54906003)(55016002)(66446008)(9686003)(44832011)(6916009)(64756008)(7696005)(186003)(66476007)(6506007)(33656002)(66946007)(478600001)(8936002)(76116006)(86362001)(71200400001)(316002)(5660300002)(4326008)(8676002)(52536014)(2906002)(66556008)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MEZIM3J4aTlVYWh0NlBsNDQ2ekFoc3czWGF0bVJ1TlRGS3U2SmtlMVlCbjg4?=
 =?utf-8?B?ZE9BeXF3bjd1cHFhZFE0eHVFVndybk5rMkhwZXlpZy8vOUlQaityR3B4WVM5?=
 =?utf-8?B?TGUzS01lcmZSeGdQOWNKVXBBd1huQmxTMGtXZ2RkS3g2ZFYzK3ZBS1ZVTkRU?=
 =?utf-8?B?aWk3RFdSZkEwaVp4WWpZK0FPblB0dTZKczNqVVNlVG5rTlVUMmZXOTUrOEww?=
 =?utf-8?B?WDY0ZFJnd01YdlRIbEp6WjlSOFhSUjkxSWMxR1dwbUZzQmZ4NXFHSkk5YVZw?=
 =?utf-8?B?QWd4R0crdU5xR09OSmtkbitYWjNzY2tMRVRBR0p1QmRFZ0ZsN0phMzd0VnpY?=
 =?utf-8?B?bUJNV3RvOUpyR3cyTDZCR3hwNkhQZTBvMHNLbG1SM3RlYW50cHBNL0l1bDdK?=
 =?utf-8?B?V2xQL2s1YVBxY3I4RmE2WWdrZHJ1MC9DZTQ2MFpyUkVQejAzT3l1S3NmbGd4?=
 =?utf-8?B?RUNlNTZhSWNFVFFlcCtrb0c1Q3BKL0Y0ZXQ0NHdTNjV3dTRQWER0d0hQTjRj?=
 =?utf-8?B?T05TcWt1bjZ3dkVpRGtDS05WWmxqcDViMmtZU1FhdEl5NWNFT3UxcXVXV09a?=
 =?utf-8?B?YkI3ZG1TQTIrdUhrellhdmJUQU40NnREcGJNWjhzUVo4U1hOaks2MkNkb1lr?=
 =?utf-8?B?UGtvMzgwUzJYWmxCOG1oeUs2b3NyMS9qUkkzbU1yQXBoTHdHMERyUm80Z2hs?=
 =?utf-8?B?NFV2WHJFdngrVlhkL0ZqdjNKdmlXVjlLeityZU1mWGlsaXB1Q2ZpaXBkYmcw?=
 =?utf-8?B?cjlzT01MbHUrNTQ2YWs4Z05QZ1h2OHBaRVZ1RDJ1TzZRcmt1a3dGRno2WE1R?=
 =?utf-8?B?dnFtU2orRXAzMmVvTG9KZ2x3bmtoaldNWUVwQnNsTmpkTHB4cElyTjcwVS9o?=
 =?utf-8?B?Z2lXSWp2bSs0ZWNlUmxLQ2tML1ZJTmhrZXMvTG93cEhsRytZNFBUaXhmYjVV?=
 =?utf-8?B?MDA5WXVTOVBlalJNTG9LUm1CWkIvT2d1dFk1L3pmemFHZktaRjllVHJsU3dV?=
 =?utf-8?B?czJ6Wk9WaHNoMEg5WWpCYlVZZ0k2bmpqUG5QTWZJYkFSWkZXb0FrNGdsYjlq?=
 =?utf-8?B?RVRScWhPNkV0QjhhZVdmVkpoMVphQUh0YzdzZGpnbHVZWGM3ZThDcUtYOEg2?=
 =?utf-8?B?c1ZqZTVhVHBUVUNYVUFmdDVPZTZTRGFpd1ZUVERmVGJxOGJjeXV2dmxSZTly?=
 =?utf-8?B?NngyU2paSTVmaXJmb1RocmdnUGx3QVZvSE9sSkw3MUVzSklHSWE4Z1NLRnZ5?=
 =?utf-8?B?a2o1QXIwTnpxWmFjb1M4Z05mUVkyTnNxK2JzaXlsNVAxSFk0eTdJQ1EyWHdV?=
 =?utf-8?Q?wI9W1verkXbyQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9001fd6e-cbea-4bd6-8fb8-08d8a86a5ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2020 00:16:48.2900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P44quayXHVpZ7dgKZmaym16NDplcwN/vVUeWY6Jj4bxama9cuzkOJT92s//YKUl50eNFWN5iO3xY9L6UIKCQQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6619
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiA+ID4NCj4gPiA+IElmIG5vdCBzdXBwb3J0ZWQgYnkgQVRGLCB0aGVuIHdoZXJlIHRvIHBv
d2VyIG9uIGFuZCBvZmYgUEhZIHNpbmNlIG5vIG90aGVyDQo+IHBsYWNlIGNhbGxzIFBIWSBBUElz
PyBJcyBpdCBhbHdheXMgb24/DQo+ID4NCj4gPiBZZXMsIGluIHRoaXMgY2FzZSAod2hlbiAtRU9Q
Tk9UU1VQUCBpcyByZXR1cm5lZCkgU01DIEFQSSBpcyBub3QNCj4gPiBzdXBwb3J0ZWQgYnkgQVRG
LCBhbmQgUEhZIGlzIGFsd2F5cyBvbi4NCj4gDQo+IFRvIG1ha2UgaXQgY2xlYXIsIGNvcmUvaGNk
LmMgZnVuY3Rpb24gdXNiX2FkZF9oY2QoKSB3aGVuDQo+IGhjZC0+c2tpcF9waHlfaW5pdGlhbGl6
YXRpb24gaXMgZmFsc2UgaXMgY2FsbGluZw0KPiB1c2JfcGh5X3Jvb3RodWJfcG93ZXJfb24oKSB3
aGljaCBjYWxscyBwaHlfcG93ZXJfb24oKS4gSWYgdGhpcyBjYWxsIGZhaWxzIHRoZW4NCj4gZXJy
b3IgaXMgcHJvcGFnYXRlZCBiYWNrIHRvIHRoZSB1c2JfYWRkX2hjZCgpIGFuZCB0aGlzIGZ1bmN0
aW9uIGZhaWxzIHRvby4NCj4gDQo+IEJ1dCBvbiBib2FyZHMgd2l0aCBvbGRlciBBVEYgKHdoaWNo
IGRvIG5vdCBzdXBwb3J0IFBIWSBwb3dlciBvbiBTTUMgQVBJKSBpcw0KPiBwaHlfcG93ZXJfb24o
KSByZXR1cm5pbmcgZXJyb3IgLUVPUE5PVFNVUFAgYW5kIHRoZXJlZm9yZSB3aG9sZSBVU0INCj4g
My4wIGluaXRpYWxpemF0aW9uIGZhaWxzLg0KPiANCj4gVGhpcyBwYXRjaCBpcyBhZGRpbmcgaW5p
dCBob29rIHRvIGRldGVjdCBpZiBBVEYgc3VwcG9ydHMgUEhZIHBvd2VyIG9uL29mZg0KPiBmdW5j
dGlvbnMgYW5kIGluIGNhc2UgaXQgZG9lcyBub3Qgc3VwcG9ydCBpdCwgY29kZSBzZXRzIFhIQ0lf
U0tJUF9QSFlfSU5JVCBmbGFnDQo+IHRvIGluc3RydWN0IHhoY2ktcGxhdCBjb2RlIHRvIHNldA0K
PiBoY2QtPnNraXBfcGh5X2luaXRpYWxpemF0aW9uIGZsYWcgdG8gaW5zdHJ1Y3QgY29yZS9oY2Qu
YyB0byBza2lwIGNhbGxpbmcNCj4gdXNiX3BoeV9yb290aHViX3Bvd2VyX29uKCkgZnVuY3Rpb24g
YXMgaXQgaXMga25vdyB0aGF0IGl0IHdvdWxkIGZhaWwuDQoNClRoYW5rcyBmb3IgY2xhcml0eSwg
Y2xlYXIgbm93Lg0KDQpQZXRlcg0K
