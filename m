Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5A2FCC25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbhATHzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:55:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:59374 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729643AbhATHxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611129202; x=1642665202;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wpOr5L2oJBlUNvc0YIovtNcLYjcggnDvfoakzroRwAs=;
  b=jDOe0pMbK7yQKNn6+R9h9f36A6dFduC+V0eivvaECEtUiQe4vPqrjN7t
   iSOTg/5xNb+vvOPQdGG6GpHEcLJZK3Cn5lOot8Zd8Nyy//VYihTGN+DST
   mIODxL4nS5JqOlxvXLWmQnXo0V8Lcha4FCs5Dvghq6qhcucWSz2BoykJ9
   BB4M3pDMCr2eRt0uDjn74PuT40byuSyy1sgDD3OLQ0Kwh20yeKdjzNVJa
   KB3ZJQnsH1/hP+oZq1sNyAe02Fxn9bCltwb2foPY24DfPWb39inFm3Y3L
   4lBudHYpKJrzCFnqtm37kkDi/edQk/RaXNxUckYAC9C+iKnuIimKAwQLs
   w==;
IronPort-SDR: ecHy0fvPohVhAdgBMMdqH70AReT0AMzs1aL3K3DXRIMrU+ro97hNmb1CEljzeBypyIDwax2qzA
 fVZYHgDrpFdYrQHkeaz1+fO/YS9hnCnqo3Zi5Z3MSKqNEFIOb6ceQgVXGhS+EbSbaI0VqJa5j5
 kyEIIwzTuLFew0WEusQiZRrWs9CbB8F6EGYrch2HQrUJLNsr2dF+Mc0RMJEJxt31fV7eFoSNYq
 Hh4cXB5fosqVVs/Rc0OZwnUYRUQLRKnj+JuREM0ErOHVXLY1bJe7eyVcDgl0JjwtSEH7Z1oQt/
 yc0=
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="100737770"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 00:51:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 00:51:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 20 Jan 2021 00:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmAmBQVm+EuPZ2XuiXTT6izHHULW8AJZChKO1z7g/APtxL+IQP++GbK0Ymp+xtfDGlCy5dEBCBmj+Y5D4OTQYCMBET0xkPPTN3U1x0A75ArwPE8+YuI49qBmQ6WwmQR61OFf0zcB1YyaiT4nl+DnUTqXpM5Y8QzkpaCRyxB/9lkknN5kLKkA684mOBUvE6Z077bJyDSBeinTLxYsXeMiQxEYvBvnhPIMlHUxy7slt9kcnHomAVEhlqh24hl5pwyxKWUS/rAc/ciANdnWXbyAc041kFt9pEO77u93xK8m2JGz4oMq3NLHitQkZRGwJHdbwY+q5IxZLF1OHwiQwiPA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpOr5L2oJBlUNvc0YIovtNcLYjcggnDvfoakzroRwAs=;
 b=ke7DxhSY8yaq7yxXNygaQkPp7D4KMtEOJdK2AqrGrEmm3jRzbZhFgvfkKemD58PzoMcbT6PKl4jFis7IehJ0olXlWYBb0TXj2ypkRA15TJ72amJhHziP2dgqJAuQDI9pTMc6gn2LR7tNsjQKkOFACdzu+/b7lzZlZE7NQT92NSAuvEqlIt1QZ9Rt1SIjTa7i5sSRFA9YM313KNlai46IFnIcZYHWwYhWZ8V+fMh8MedelcTt33oTHY5b7Djmq0vgtS8DoS5gDy8hJqrr7C+9mvr4xsV3FdVzjS+VkuXqUBvqAR/SN4dSKAvnD3Q32EaVesC0UF0rB9RonByK3/zqpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpOr5L2oJBlUNvc0YIovtNcLYjcggnDvfoakzroRwAs=;
 b=OPeeFMpSvjyCHwNq9NVIzoATPw+x2n4HX1XXmzvgpclenHzv55xP9/uA7X3J4DFvV9RO1coYD7vmqHb/cH/gcbtv9rR9dTXFbbhseM4ucCCX86A2hYehzLW7zEPxFdr77maZ8xCzysGkv/SXDArYEqEBv4uY0dWYwzXjpNCazFg=
Received: from DM6PR11MB3417.namprd11.prod.outlook.com (2603:10b6:5:68::33) by
 DM6PR11MB4580.namprd11.prod.outlook.com (2603:10b6:5:2af::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.12; Wed, 20 Jan 2021 07:51:28 +0000
Received: from DM6PR11MB3417.namprd11.prod.outlook.com
 ([fe80::358e:e100:29:4694]) by DM6PR11MB3417.namprd11.prod.outlook.com
 ([fe80::358e:e100:29:4694%3]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 07:51:28 +0000
From:   <Steen.Hegelund@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <p.zabel@pengutronix.de>,
        <UNGLinuxDriver@microchip.com>, <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: microchip sparx5 reset driver
 bindings
Thread-Topic: [PATCH v3 1/3] dt-bindings: reset: microchip sparx5 reset driver
 bindings
Thread-Index: AQHW6pHVcacR7L7skEmgM90OM379Eqovb/kAgAC9AIA=
Date:   Wed, 20 Jan 2021 07:51:28 +0000
Message-ID: <f6f39f9de3e6f74e8f1706705d31f53bcbeb504c.camel@microchip.com>
References: <20210114162432.3039657-1-steen.hegelund@microchip.com>
         <20210114162432.3039657-2-steen.hegelund@microchip.com>
         <20210119203500.GO3666@piout.net>
In-Reply-To: <20210119203500.GO3666@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3 
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2.111.84.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07891379-e896-43f2-4e82-08d8bd1831ef
x-ms-traffictypediagnostic: DM6PR11MB4580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB45801CCD87C3E4AF529C0CD886A20@DM6PR11MB4580.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /9Xp6ZHuc+Y7XV6H9AJ9OZ8oq0TooKrti1wrkX1kothQzQ68c5EQJ9fNFnc40Ma835sLr/tFa/UKLfUhcEhBHGmkYqRtnaxKSigIIlCKHQ/nIsYDHwRjmIwHU/EM0oqDD6f/RoQG0nsp/zhq/GjzpfkCDBYdBmBRf4BIv0TzOTusOQwmF6xbK5bRKx90cTSzGIzz0UWWeMgKdaYFBnv5TMnlR4i2l0Ia/f6GHnDP+ONwzFb+1ZMfR0htfo+x01La7m29WW7l8PPKTrzwisoFNizK0ASdQcplsoTT+uyvG0Ti3AjJ5Sn90BQbnkW1TBWH9rGTIXA2Dy8MRzpLG7i3vDZAmJrYf/eLgSmhEGlVQQK885u1HQdFNYv/L6bmlr4f2EdCM1KCo4x1HuNGha8nbd4SoCcAqgMdjmqe/sxwr9hq+hjvfi5s9wckv7v+br9eBncF8gPnsHtEhvMrizoauQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3417.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(136003)(39860400002)(64756008)(316002)(91956017)(76116006)(66446008)(83380400001)(71200400001)(66556008)(66476007)(54906003)(6486002)(8936002)(5660300002)(66946007)(478600001)(8676002)(186003)(4326008)(966005)(36756003)(2906002)(6512007)(26005)(6506007)(2616005)(86362001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NDdTNWlrNjBXa0phWk4yck1QSXZsZHJ5UGF2eTF6dHc4Nlp6MDhCMGYyUFc1?=
 =?utf-8?B?ekczVWh2dnZUYmVYSDZwQjRENkxudnVRblVxdU8xKzRsSDFNT1BYNlJDQmhH?=
 =?utf-8?B?VDRMMnZ0TnIrUktvdlJRbzAzcVhlSHdyZTVIcUY0MCt4dGdERCtrZzZJWGxy?=
 =?utf-8?B?R2RzZE55OGpMdzlOKy9aZWQ4QnNHZzhNR3dEOFZiY1VEUmh5cXFMTzdDditx?=
 =?utf-8?B?alp3WlNKcTUzdnFYMUhZVnM2RWRGRUl1cVdnMUlSQnYrQjh3Rlo0TitTa2hh?=
 =?utf-8?B?ZHliczg1NEQyQUxGVlpRWEw1bHczWC8ySlAyVHNKNkhjWUFwUkhaeXBqQlZT?=
 =?utf-8?B?NUtJbHd6cDh1RXllQmt5ZGR6aUN5dXlERDJUdWllYU8rT09BT1ByaEd4L0Nq?=
 =?utf-8?B?aE5GenZma2M3S1ZsajFuM3ZQVDViaXdQS2ZIbDF4ZEllRXppdVRuN2poellv?=
 =?utf-8?B?eVhtTFFUdjNOMEN1TS9RdER5TXRab2NoRU5qTEFjQVYvR2FkY3hGc1RhT2Zy?=
 =?utf-8?B?bk9ucG56dnBEVndMWHErMTJaTnQxK3NNckZTbXRKcTE1cDBDeElCcHpYbVNi?=
 =?utf-8?B?T2lBLzU4UHhrbGFQMG4vOWFqMzQ5RzlvYzVITGpxSnNCT1VwN1J1MWlNdXdR?=
 =?utf-8?B?VkNUZW4xcVRsRmZnOWo0dXZsWWN4UHhqT25IT0p3dzNDNldoRjJzY2FCVVpK?=
 =?utf-8?B?UUVnVi9lYnYwbm1xRXZCTVZMeWpXTmpOVHJNNks1SWZ2SzZ0YnZrSUZDQzRr?=
 =?utf-8?B?ejcvaFFTczFiMXNGWUdseXdySmxxTUhnY2p5U3g1V3YyblhCbm9VYkVrTE16?=
 =?utf-8?B?bVJJNlUwbkdTdGIvem4zSS80NzNGcWx1d3hOcklwbHd0RFl4VkVMTmVKMjNF?=
 =?utf-8?B?a1d2ck5jSkFSYmU4eGQ5NTJWQUl6OVlPRWlpanJLbE1NYXNYMkI1b05UeXJk?=
 =?utf-8?B?Uk1Da3NkaCtsNmJ6UG5vb0Nha2p1bXZTMlErdHNzNnhGVzlLU3hMWC9ubHJM?=
 =?utf-8?B?b3YwSHo1UlRRMm5zSEFiYmVRQ3NKZFYvSVF0dm13T0I5V2NzWlNCd2tzQUVR?=
 =?utf-8?B?ZHhGaGZwa3M5YnZlZDUrYVVENW0xVURZeWxuWXhsY1RaQkVLWHBBY081M0ZH?=
 =?utf-8?B?aUllazQ4dFlML1pheE01UEZydGlXMzl6R0dlbkxKNjVZZVhtZVFNcVZrWmRq?=
 =?utf-8?B?dEY0QkwzSXcrRm4rRzl5eDFpMUhnWWN5d2N2ZWZMTGZHbzZoYm5MTDMxOUp6?=
 =?utf-8?B?Uys0aUFBTnpNMHJBa0NNY1RRNHZSVC9EYytnUzFzQk4zNGdjRjJnUFBneldT?=
 =?utf-8?Q?20vCIonUzJWo0CPZIrQgxsmv1AyXp3s7Iy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <116E1520E5A6E042A8B9356D110FCF6D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3417.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07891379-e896-43f2-4e82-08d8bd1831ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 07:51:28.6727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUZotslDMuywAOwFJhO1FJNA+ZyZ7eNPHPdma8aV2ms+1cNCX1EspNHa21zZCDJchjIJ4Zy45CVoswFrKSkVx2iZrHrTAlmXrTdAEVBOhAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4580
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleCwNCg0KT24gVHVlLCAyMDIxLTAxLTE5IGF0IDIxOjM1ICswMTAwLCBBbGV4YW5kcmUg
QmVsbG9uaSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBIaSwNCj4gDQo+IEV2ZXJ5IHBhdGNoZXMgbmVlZCBhIGNvbW1pdCBtZXNzYWdlLCBldmVu
IGlmIGluIHRoaXMgY2FzZSBpdCB3aWxsIGJlDQo+IHZlcnkgc21hbGwuDQoNClllcyB0aGF0IGlz
IGEgbWlzdGFrZS4gIEkgd2lsbCB1cGRhdGUgdGhlIHNlcmllcy4NCg0KPiANCj4gT24gMTQvMDEv
MjAyMSAxNzoyNDozMCswMTAwLCBTdGVlbiBIZWdlbHVuZCB3cm90ZToNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBTdGVlbiBIZWdlbHVuZCA8c3RlZW4uaGVnZWx1bmRAbWljcm9jaGlwLmNvbT4NCj4gPiAt
LS0NCj4gPiDCoC4uLi9iaW5kaW5ncy9yZXNldC9taWNyb2NoaXAscnN0LnlhbWzCoMKgwqDCoMKg
wqDCoMKgIHwgNTkNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gwqAxIGZpbGUgY2hhbmdl
ZCwgNTkgaW5zZXJ0aW9ucygrKQ0KPiA+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Jlc2V0L21pY3JvY2hpcCxyc3QueWFtbA0KPiA+
IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9yZXNldC9taWNyb2NoaXAscnN0LnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9yZXNldC9taWNyb2NoaXAscnN0LnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uYWYwMTAxNmUyNDZmDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9t
aWNyb2NoaXAscnN0LnlhbWwNCj4gPiBAQCAtMCwwICsxLDU5IEBADQo+ID4gKyMgU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFN
TCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogImh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFz
L3Jlc2V0L21pY3JvY2hpcCxyc3QueWFtbCMiDQo+ID4gKyRzY2hlbWE6ICJodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMiDQo+ID4gKw0KPiA+ICt0aXRsZTogTWlj
cm9jaGlwIFNwYXJ4NSBTd2l0Y2ggUmVzZXQgQ29udHJvbGxlcg0KPiA+ICsNCj4gPiArbWFpbnRh
aW5lcnM6DQo+ID4gK8KgIC0gU3RlZW4gSGVnZWx1bmQgPHN0ZWVuLmhlZ2VsdW5kQG1pY3JvY2hp
cC5jb20+DQo+ID4gK8KgIC0gTGFycyBQb3Zsc2VuIDxsYXJzLnBvdmxzZW5AbWljcm9jaGlwLmNv
bT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gK8KgIFRoZSBNaWNyb2NoaXAgU3Bh
cng1IFN3aXRjaCBwcm92aWRlcyByZXNldCBjb250cm9sIGFuZA0KPiA+IGltcGxlbWVudHMgdGhl
IGZvbGxvd2luZw0KPiA+ICvCoCBmdW5jdGlvbnMNCj4gPiArwqDCoMKgIC0gT25lIFRpbWUgU3dp
dGNoIENvcmUgUmVzZXQgKFNvZnQgUmVzZXQpDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+
ICvCoCAkbm9kZW5hbWU6DQo+ID4gK8KgwqDCoCBwYXR0ZXJuOiAiXnJlc2V0LWNvbnRyb2xsZXJA
WzAtOWEtZl0rJCINCj4gPiArDQo+ID4gK8KgIGNvbXBhdGlibGU6DQo+ID4gK8KgwqDCoCBjb25z
dDogbWljcm9jaGlwLHNwYXJ4NS1zd2l0Y2gtcmVzZXQNCj4gPiArDQo+ID4gK8KgIHJlZzoNCj4g
PiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICvCoCAiI3Jlc2V0LWNlbGxzIjoNCj4g
PiArwqDCoMKgIGNvbnN0OiAxDQo+ID4gKw0KPiA+ICvCoCBjcHUtc3lzY29uOg0KPiA+ICvCoMKg
wqAgJHJlZjogIi9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUiDQo+ID4g
K8KgwqDCoCBkZXNjcmlwdGlvbjogc3lzY29uIHVzZWQgdG8gYWNjZXNzIENQVSByZXNldA0KPiA+
ICvCoMKgwqAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK8KgIGdjYi1zeXNjb246DQo+ID4gK8Kg
wqDCoCAkcmVmOiAiL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZSINCj4g
PiArwqDCoMKgIGRlc2NyaXB0aW9uOiBzeXNjb24gdXNlZCB0byBhY2Nlc3MgR2xvYmFsIENvbnRy
b2wgQmxvY2sNCj4gPiArwqDCoMKgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoN
Cj4gPiArwqAgLSBjb21wYXRpYmxlDQo+ID4gK8KgIC0gcmVnDQo+ID4gK8KgIC0gIiNyZXNldC1j
ZWxscyINCj4gPiArwqAgLSBjcHUtc3lzY29uDQo+ID4gK8KgIC0gZ2NiLXN5c2Nvbg0KPiA+ICsN
Cj4gPiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoN
Cj4gPiArwqAgLSB8DQo+ID4gK8KgwqDCoCByZXNldDogcmVzZXQtY29udHJvbGxlckAwIHsNCj4g
PiArwqDCoMKgwqDCoMKgwqAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc3Bhcng1LXN3aXRjaC1y
ZXNldCI7DQo+ID4gK8KgwqDCoMKgwqDCoMKgIHJlZyA9IDwweDAgMHgwPjsNCj4gPiArwqDCoMKg
wqDCoMKgwqAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoCBjcHUtc3lz
Y29uID0gPCZjcHVfY3RybD47DQo+ID4gK8KgwqDCoMKgwqDCoMKgIGdjYi1zeXNjb24gPSA8Jmdj
Yl9jdHJsPjsNCj4gPiArwqDCoMKgIH07DQo+ID4gKw0KPiA+IC0tDQo+ID4gMi4yOS4yDQo+ID4g
DQo+IA0KPiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwgQm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51
eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBzOi8vYm9vdGxpbi5jb20NCg0KDQpUaGFu
a3MgZm9yIHlvdXIgY29tbWVudHMNCkJSDQpTdGVlbg0KLS0gDQpCUg0KU3RlZW4NCg0KLT0tPS09
LT0tPS09LT0tPS09LT0tPS09LT0tPQ0Kc3RlZW4uaGVnZWx1bmRAbWljcm9jaGlwLmNvbQ0K
