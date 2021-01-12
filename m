Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8C2F25E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbhALB4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:56:49 -0500
Received: from mail-eopbgr60052.outbound.protection.outlook.com ([40.107.6.52]:5349
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbhALB4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:56:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5qtNaarGV6cmYuvY5FehIkQ8NQhOlYYHpe2UiaIvI+9V0uNsp7shH8CXHD7TxiZ9ZJNo7Da4GTil0EUoz/TygwZ2vXg4usk0qggpUIPRoPonrb3J8mNsU7pF1osZG7LEoDtLHeSusGn5/9WmZkSFOOEY2UDGPcGXP1vXWQGa826v4i64oE9lbZ4hNb2IzLQLADdIZJ7qPRA4u7EgVhMNcjk2mwc4a7+RMSyAIrTXcHp4VjbIiW+IVDQmmO+UoK0Yax9uornbVv5sj5rSId+4xuR/IzQDrUx99m3PSlQH9xNVYvTLOUHTbpy003F+xbQelwz9EOWW9fWoPeBkGgA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO7JwPZwb3qtp6m6412q4nZrGKJ6pZcl2qmLR7WLgDI=;
 b=EiDBGJDR88hViXLSkeqR6Ovm2kWwyraKID5o/XDrW7g6z7k2WgPj246RuctZs1+EmApn+R/V0VdlVrHJ6paj+bFPEesxuYT0Qv4bTI4i7QD9A50I8arj4J5HRn2jFM0zDwsz9wGZL7/PYLOyAHWsHChJzUBxybH8OZVnXlBTN0514J4gU1hfgtW726h+tZbdSyyNFu5V859ndeCob4TsG8KmqbhwCh6XQxA1KY6OYY2VJ9axYqIYct6ipWqCjI1xNoKT4aHgt2JXuMcnm9DLU5yHpvstk48r74IKQfLFYXeFiqV3kvZP6eWWgMlTPVMT0L1p0t18DXj64qw8GhDNOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO7JwPZwb3qtp6m6412q4nZrGKJ6pZcl2qmLR7WLgDI=;
 b=iwgkx+3kQSrf+QQoNKQzpHycIag4ao0S+01uIDKJZSgBlHDaT1Y5m11zmXXWf6hT9mpxxX9whftzCr0/CXYCbCP7vfn4O4hy8rmcIXSo+juamvZRKbKKOekGCNW4mO9pkIlVO0FHGwJQHqVhhfUK3LWBc8jmvNTVfNKLwMzzBIc=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 01:55:59 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::89de:bd7c:7245:f139]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::89de:bd7c:7245:f139%5]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 01:55:58 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Pawel Laszczak <pawell@cadence.com>
CC:     "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: RE: [PATCH] usb: cdnsp: fixes undefined reference to cdns_remove
Thread-Topic: [PATCH] usb: cdnsp: fixes undefined reference to cdns_remove
Thread-Index: AQHW6CgYOzAgQuDU7EWnKmXFFwquDaoiqsWAgACQuXA=
Date:   Tue, 12 Jan 2021 01:55:58 +0000
Message-ID: <DBBPR04MB7979C0CEB3B0E8A73EB4D6048BAA0@DBBPR04MB7979.eurprd04.prod.outlook.com>
References: <20210111144226.16372-1-pawell@cadence.com>
 <7aa22b3c-f56f-b215-2f84-348e24a48044@infradead.org>
In-Reply-To: <7aa22b3c-f56f-b215-2f84-348e24a48044@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [222.65.210.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8677628e-1e21-4dde-9ce1-08d8b69d34df
x-ms-traffictypediagnostic: DB8PR04MB7180:
x-microsoft-antispam-prvs: <DB8PR04MB71806D967B5DC9F2CF2820EB8BAA0@DB8PR04MB7180.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSxqyLRInLA+WZrVhAvG5C0QuImoNyg45FkWpnEk6Uier6M9IVsxbMDELlh5ydtHA8uIA6Gy/K3SxKsKr5VR97BZQoGq2aPCObycwHEYbTS6h9+fVB5hFSvYJuDKnHly4ef/9ZgoiIvznxKmaY4k9AhFDOxLCcRoNzPba0k4XU25/tHCnA4iBEPLWAT89L7luQHyDkQGuMAq5KvsZ+wvAxi9hR4hr2aE1zhvNoziNRZnwrWux7YxLMN7a7yQZ9gpGyRs+KU0Ko+pR7bSjKfjBpgb4O6/6dtEN3SKRdvX+NpyGGX1uCr5pC8qQ8GGy7BwgZBYNufHpvKk5Nnou+Al/9n8GY7kDwWFhBMPZ6VnQT4zmzarfOjMXwdbzdV8WmU/KQldoy5ng59DcnQw6jcveQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(9686003)(54906003)(55016002)(4326008)(110136005)(71200400001)(52536014)(316002)(76116006)(5660300002)(478600001)(64756008)(66946007)(26005)(6506007)(8676002)(66476007)(53546011)(186003)(2906002)(7696005)(44832011)(33656002)(66446008)(86362001)(8936002)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?czg4RDljNmlpZXRiT2Fhcm5EbVRNVTJhU2JBWndyQ0FFRmVkSW16K2ZtUUE4?=
 =?utf-8?B?U3VJYTZVeDlyU1R1YmlLeVZKOWJjWUpKRlNrOFU1M3k2eWphNWwzeHNmTVh2?=
 =?utf-8?B?Y2g1QmdBVjgxRkQ1S2ZLdVR2dURrWXFXaGJoa1NJamk4L2piK0xXakllOVhr?=
 =?utf-8?B?LzNwL0hoZnFRUzJiaU9ucjVwcDQ1QjFnNEtWcnFuV1hJZGRGRmFpWDRLRzQw?=
 =?utf-8?B?Uk4rcDB3WlNYV0hXbzN6blJzZnQycDV1QThpZWpQR0ZlSlZpOXJjdVhTRktz?=
 =?utf-8?B?U2x2THhsdUlUM3EyRGhCeGRYVlNCZ2lDdWMxd09MbGJod3poNnBkYk9QVito?=
 =?utf-8?B?allNTitRVXZXZnZ4TGY4dnJ2bHpwdldQNDZJVzFzenpsWW1VZjhQaWcra1Bz?=
 =?utf-8?B?a25TV0FvbmFtUU9mWWdqaGQ2RTBpTENqYTBjQUVTZlQxRVMrOTZNaWl4bzA1?=
 =?utf-8?B?UGNXZzUrd0cwL25IdUpIeEFDZ1V2eHN3UUN3VFg4emhsSUFrSS9WMG1GS0hK?=
 =?utf-8?B?NHBZWkxYZnNIdUtqLzZTanhNc29qOTFneEdsUFUzZzZ1Wk4zejM4WWl4Y0cy?=
 =?utf-8?B?L1NFWUNnNzVWZ3l3TW5zRE4zM3FjTEw3bjdIRVZ5S1A4SnpGMy9rYVo4N21v?=
 =?utf-8?B?QUdZaTVnTVV4Q0gyNm9zMGdtZ09jTTQxT1liYXRPdG0xN09TT0lVMlorM3B5?=
 =?utf-8?B?UFpXbWgrdmNrQncrdHRBTXZIVjFybGNoZkt2YzRHUVNmSE5jeW1EeGV1UWto?=
 =?utf-8?B?MDhiaGx4amxhLzdSY3lEVW5VdnRDa2s1K0dEaGpLekY2dEliaDRGS3hxWjMw?=
 =?utf-8?B?ZnAybUoxMmlkVkpUd3p4ZU43RjBMM1ZISU51dE4rR3pMem1INGFoKzVrdE5N?=
 =?utf-8?B?ZWpaZ1RkaXZMakc5dWJXc3V4T2l2aXYwNWl2aHU1eDJhbklTWUc1TElTdjhw?=
 =?utf-8?B?VWZXam16cTlBdG1zM0ZHR1NERUF0QjYrUEFyUDlCUWs1ejNaM2dYbitlUTYr?=
 =?utf-8?B?UzdUa1E2VVc1by94NXlpVVIxYzAxYWk5YkFBSHp6SjFSWGN2aC9QcTdiek1o?=
 =?utf-8?B?c2QzQmIva2x1NjZJUUE0Sm9qd1MzNHRXZHZjWElrV0pTaURkdGw5YXhhSTM2?=
 =?utf-8?B?SFdYZVNiUzFRQTVESm9MWGpMYTNqdGUrejhxbzZSRjhIR1UxR0FiMlRNOURP?=
 =?utf-8?B?Sy9BbzFXd2E0czd6TS9xTXJoelNkb0JzelNQeXZxZlhyd0hUMDVJUml2U21H?=
 =?utf-8?B?Tit1ajFWbGFNb2ZSQm1NQTQvdDBWd2FJT1RLTEVpNTROeTFXK1VWSjlrakFo?=
 =?utf-8?Q?Jdjc3FJUAClzI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8677628e-1e21-4dde-9ce1-08d8b69d34df
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 01:55:58.5000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H+Jbd6DBYh8vrWQaEaRdbht9vuQezStL+kDoqxT3CHNKKJCZY/s9niEx8Vy//7PKHtnzOA+CChbeU9WDHbvK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IA0KPiANCj4gT24gMS8xMS8yMSA2OjQyIEFNLCBQYXdlbCBMYXN6Y3phayB3cm90ZToNCj4gPiBQ
YXRjaCBmaXhlcyB0aGUgZm9sbG93aW5nIGVycm9yczoNCj4gPiBsZDogZHJpdmVycy91c2IvY2Ru
czMvY2Ruc3AtcGNpLm86IGluIGZ1bmN0aW9uIGBjZG5zcF9wY2lfcmVtb3ZlJzoNCj4gPiBjZG5z
cC1wY2kuYzooLnRleHQrMHg4MCk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGNkbnNfcmVtb3Zl
Jw0KPiA+IGxkOiBkcml2ZXJzL3VzYi9jZG5zMy9jZG5zcC1wY2kubzogaW4gZnVuY3Rpb24gYGNk
bnNwX3BjaV9wcm9iZSc6DQo+ID4gY2Ruc3AtcGNpLmM6KC50ZXh0KzB4MzRjKTogdW5kZWZpbmVk
IHJlZmVyZW5jZSB0byBgY2Ruc19pbml0Jw0KPiA+DQo+ID4gSXNzdWUgb2NjdXJzIGZvciBVU0Iv
Q0ROUzMvQ0ROU1Aga2VybmVsIGNvbmZpZ3VyYXRpb246DQo+ID4gQ09ORklHX1VTQj1tDQo+ID4g
Q09ORklHX1VTQl9DRE5TX1NVUFBPUlQ9eQ0KPiA+IENPTkZJR19VU0JfQ0ROUzM9bQ0KPiA+IENP
TkZJR19VU0JfQ0ROUzNfUENJX1dSQVA9bQ0KPiA+IENPTkZJR19VU0JfQ0ROU1BfUENJPXkNCj4g
Pg0KPiA+IFJlcG9ydGVkLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQYXdlbCBMYXN6Y3phayA8cGF3ZWxsQGNhZGVuY2UuY29tPg0K
PiANCj4gWWVwLCB0aGF0IHdvcmtzLiBUaGFua3MuDQo+IA0KPiBBY2tlZC1ieTogUmFuZHkgRHVu
bGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+ICMgYnVpbGQtdGVzdGVkDQo+IA0KDQpBcHBsaWVk
IGl0LCB0aGFua3MuDQoNClBldGVyDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3VzYi9jZG5z
My9NYWtlZmlsZSB8IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2RuczMvTWFrZWZpbGUgYi9kcml2
ZXJzL3VzYi9jZG5zMy9NYWtlZmlsZQ0KPiA+IGluZGV4IDNmOWI3ZmE4YTU5NC4uYmU5MDY5MTBm
OThiIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2NkbnMzL01ha2VmaWxlDQo+ID4gKysr
IGIvZHJpdmVycy91c2IvY2RuczMvTWFrZWZpbGUNCj4gPiBAQCAtMjYsNyArMjYsMTEgQEAgb2Jq
LSQoQ09ORklHX1VTQl9DRE5TM19USSkJCQkrPQ0KPiBjZG5zMy10aS5vDQo+ID4gIG9iai0kKENP
TkZJR19VU0JfQ0ROUzNfSU1YKQkJCSs9IGNkbnMzLWlteC5vDQo+ID4NCj4gPiAgY2Ruc3AtdWRj
LXBjaS15CQkJCQk6PSBjZG5zcC1wY2kubw0KPiA+ICtpZmVxICgkKENPTkZJR19VU0IpLG0pDQo+
ID4gK29iai1tCQkJCQkJKz0gY2Ruc3AtdWRjLXBjaS5vDQo+ID4gK2Vsc2UNCj4gPiAgb2JqLSQo
Q09ORklHX1VTQl9DRE5TUF9QQ0kpIAkJCSs9IGNkbnNwLXVkYy1wY2kubw0KPiA+ICtlbmRpZg0K
PiA+ICBjZG5zcC11ZGMtcGNpLSQoQ09ORklHX1VTQl9DRE5TUF9HQURHRVQpCSs9IGNkbnNwLXJp
bmcubw0KPiBjZG5zcC1nYWRnZXQubyBcDQo+ID4gIAkJCQkJCSAgIGNkbnNwLW1lbS5vIGNkbnNw
LWVwMC5vDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IH5SYW5keQ0KDQo=
