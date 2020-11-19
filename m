Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4662B96A9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgKSPol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:44:41 -0500
Received: from mail-vi1eur05on2042.outbound.protection.outlook.com ([40.107.21.42]:56864
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728563AbgKSPok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:44:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7AR7o3C8tM24/cfoKt1VCguq+jXvCMvhRGAldp7rmhRFTzivBbgiCV9oI6KFE54a+6/FFYe/+zWeM8RcjXyNiFCraJ8Mmry9CuBJQPzWRwOWYO2iJ/aUEobmpaOny6zl953Yb9yn30zs06pwqcu9K67kRgITF/2S9I9zF2gMWzi8I1V/4iS4FTDRzAhFH4Q+V61hxPqz0wO989ID9eVUWV42jjzXtAxNtoER0xJn8YsTzhulrcOdpq16gT2h4hU6ek7Qf/CcsuNXNHPnGh8f+upAGgT5gRBsHZDpOvg3CNbIuiW4cNPFgFbpKGrJvj4cd5TSZ81TzMkB+UnH+Urrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORCrc5eWwkNL6J86j4Rpqclxa/kZ4EVKtXcBkAcBjyI=;
 b=IIQK6yf8Rp13DoL5HYnxzHgIni5SI6SIIqP7VqSJVF1SiiQp1eemgRBpzKhNU/j0EAZmGRvTayesAwoZxOHFk8ZNESrrCWAKOpSsddVvROx8l9vUzxfWYWkVbHTrdH8AV1+beoMOpPmE8aALsBdIH8n9x/kH+NKfCcBNUl+h6uajm6vU2WJtifqnNVu6SIYD6BdV22Goq60g9rlGKa0ebLbihTxacvCYNsdl+4+Y8zg9XAlj4iWmQ9emCjtmB7nlb9hOf05Knwc7ohQahDOzddP3yKGT9NEHgkhT3S3XVKuPcLDXhBRzMX6HhiL7AZKJedueP0ItlQUyxSVy8EJgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORCrc5eWwkNL6J86j4Rpqclxa/kZ4EVKtXcBkAcBjyI=;
 b=WxCUW1FauGxzOJZdtW5LsdvUY/WrxzCqIHyoHVGKkOn4jOj2/b4FEf/jw7jMxsmhXtxNL0j/AQcSoaeaDQ++d2v6gqg/CyNMIkSaUnDPOFZvLeP6N+bSDl1/1EJtuViGlI+hekHyFX9aX5mwuVjZb7IXV7AUlTlo3seP2yJ+BTI=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3784.eurprd04.prod.outlook.com (2603:10a6:209:23::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Thu, 19 Nov
 2020 15:44:21 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Thu, 19 Nov 2020
 15:44:21 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Subject: RE: [PATCH 1/3] driver core: simply go out if the same device_link is
 added again
Thread-Topic: [PATCH 1/3] driver core: simply go out if the same device_link
 is added again
Thread-Index: AQHWvmWhoYjkqQJMfkOW9p9/afOoyKnPXXgAgAA6bhA=
Date:   Thu, 19 Nov 2020 15:44:20 +0000
Message-ID: <AM6PR04MB49667282278422829AF98D3080E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201119110036.19959-1-aisheng.dong@nxp.com>
 <CAJZ5v0gRmmkxG7aLRHXw1Gx7GGd1PyZ6LNqChuQCVKPV9X_8zg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gRmmkxG7aLRHXw1Gx7GGd1PyZ6LNqChuQCVKPV9X_8zg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.171.84.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b1115c1-305e-47d7-75ac-08d88ca1fb83
x-ms-traffictypediagnostic: AM6PR0402MB3784:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB37841B1F8E14A6A498BFA0B680E00@AM6PR0402MB3784.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hM2EVZsQhDf8GJe4xEyezoQlFARf/4kkheftjD99hyeHVuoUhb3UDUKDXiXxPfaYbgHsFwFyW7IX1jmIYHiwxCUVhppkNPD+xfry8v+KkdCfKQVTuK3orpdA2vEM1AyCWw81P/MNN69BiiHSkaucquC1kOTkWeh5EO5b4HYnmNkAXUMUCDkGy3KN4PAs0iqIqzNS8eG75TjmiUkTwM8ImJbNvfYpCjIxDeeH2oNCvJ1OVa4r0mVkkLM+FTX6IqV+UUtsA2ZWVXnodOi8/gXnXXlXDx9FreV8qBniTYjV2KnDSz4L8DVL63UjFO8UfeBx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(54906003)(83380400001)(76116006)(6506007)(53546011)(186003)(66946007)(5660300002)(316002)(478600001)(6916009)(66446008)(8676002)(64756008)(66556008)(33656002)(66476007)(52536014)(71200400001)(7696005)(55016002)(44832011)(86362001)(4326008)(9686003)(8936002)(26005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +KCfXY5S7X9WCNNKqxTYPvL7uk8a2jdpZ3A7k/XMwPqyRJD/2ydzOf4/IOSJ6C0wkcDzcl2q9CGBfFWO+0/Su1ExPMXPh38tfdqSS56eOOx6ebG+8QqltM3kVOX/uPDSCl23RcA0jL2Upla+TLZC3Nzi1kT1cySTCsnUigco58y5ECE93boKifsO5M5cGsowo4fCQFoUsYf6cfxQ0QLwMYclqu95aGBR6MTBCVIvBT/UBUMULeqJ/ZDiI74NOm55P3i3ADO7I7Pg3/ZsY7LQ37XwUPi+5E8MuJGJVWoJ4cN1eoqClnrSSnlfFnjwnFAuS0B7PV552mRYmpAn3gQxBlES7Y3b2p9EZBjw6eQKtwjfL0DZ3HYCq3TiCJFsDAUMzqWczfwvuTAMDBgblR9B3yzVH4dJXTAQTqCiMnN9Ceu2dJFvpuItP99lxlVcu7V3dluzHbTWs6d6I/eXFIBjSAJM3KlIb9+ZXYV4bPKPKWo7EI4GeF12RnW3D2li+miqihg+BDvG2ieK+82YOSn5tzD6xxWkUkLM4S7bjty/BhVcg7MGrrydpaalJWAB0DXdW944Yn/Py9hvBVScNKW3Yn8/mpYxa31GEJg8oUR/ezTO0fk0aRZFm5/zVj2sap3y1zuXK6N6oAo3gj0qSZ49AQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1115c1-305e-47d7-75ac-08d88ca1fb83
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2020 15:44:20.8865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0RCqYCtvGTQz9Bt2pWV+EDUQVS6QiQJh8/RvoBbeJheArKMrHF1GgLbaEII4QJWqAEHE0NGvEgoyyBjDKs+0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3784
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBSYWZhZWwgSi4gV3lzb2NraSA8cmFmYWVsQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBOb3ZlbWJlciAxOSwgMjAyMCA4OjEyIFBNDQo+IA0KPiBPbiBUaHUsIE5vdiAxOSwg
MjAyMCBhdCAxMjoxOCBQTSBEb25nIEFpc2hlbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiB3
cm90ZToNCj4gPg0KPiA+IEl0J3MgcG9zc2libGUgdGhhdCB0aGUgc2FtZSBkZXZpY2UgbGluayBt
YXkgYmUgYWRkZWQgYnkgcGFyc2luZyB0aGUNCj4gPiBmdW5jdGlvbiBkZXBlbmRlY3kgaW4gRFQu
IGUuZy4gY2xvY2svZ3Bpby9yZWd1bGF0b3JzLg0KPiA+IFNpbXBseSBnbyBvdXQgZm9yIHRoaXMg
Y2FzZS4NCj4gDQo+IFdoeT8NCj4gDQo+ID4gQ2M6IEdyZWcgS3JvYWgtSGFydG1hbiA8Z3JlZ2to
QGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gQ2M6ICJSYWZhZWwgSi4gV3lzb2NraSIgPHJhZmFl
bEBrZXJuZWwub3JnPg0KPiA+IENjOiBTYXJhdmFuYSBLYW5uYW4gPHNhcmF2YW5ha0Bnb29nbGUu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYmFzZS9jb3JlLmMgfCAzICsrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9iYXNlL2NvcmUuYyBiL2RyaXZlcnMvYmFzZS9jb3JlLmMgaW5kZXgNCj4gPiA0YzAzYmRkM2Ey
NjguLjdkOTFkNDA3NDEzNiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvY29yZS5jDQo+
ID4gKysrIGIvZHJpdmVycy9iYXNlL2NvcmUuYw0KPiA+IEBAIC01NjcsNiArNTY3LDkgQEAgc3Ry
dWN0IGRldmljZV9saW5rICpkZXZpY2VfbGlua19hZGQoc3RydWN0IGRldmljZQ0KPiAqY29uc3Vt
ZXIsDQo+ID4gICAgICAgICAgICAgICAgIGlmIChsaW5rLT5jb25zdW1lciAhPSBjb25zdW1lcikN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4gPg0KPiA+ICsgICAgICAg
ICAgICAgICBpZiAoZmxhZ3MgPT0gbGluay0+ZmxhZ3MpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7DQo+IA0KPiBCdXQgdGhpcyBwcmV2ZW50cyBycG1fY291bnQgZnJvbSBi
ZWluZyBpbmNyZW1lbnRlZCBpZiBETF9GTEFHX1JQTV9BQ1RJVkUNCj4gaXMgc2V0IGluIGZsYWdz
LCB3aGljaCBpcyBuZWNlc3NhcnksIGJlY2F1c2UgdGhlIHN1cHBsaWVyJ3MgUE0tcnVudGltZSB1
c2FnZQ0KPiBjb3VudGVyIGhhcyBiZWVuIGluY3JlbWVudGVkIGFscmVhZHkuDQo+IA0KPiBNb3Jl
b3ZlciwgZXZlcnkgYXR0ZW1wdCB0byBjcmVhdGUgYSBzdGF0ZWxlc3MgbGluayBtdXN0IGNhdXNl
IGEgbmV3IHJlZmVyZW5jZQ0KPiBvbiB0aGUgZXhpc3RpbmcgbGluayB0byBiZSBhY3F1aXJlZCwg
b3IgdGhlIHJlbW92YWwgd2lsbCBub3Qgd29yayBjb3JyZWN0bHkuDQoNClllcywgSSBzZWUuIFRo
YW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uLg0KDQpSZWdhcmRzDQpBaXNoZW5nDQoNCj4gDQo+ID4g
Kw0KPiA+ICAgICAgICAgICAgICAgICBpZiAoZmxhZ3MgJiBETF9GTEFHX1BNX1JVTlRJTUUpIHsN
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIShsaW5rLT5mbGFncyAmIERMX0ZMQUdf
UE1fUlVOVElNRSkpIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBtX3J1
bnRpbWVfbmV3X2xpbmsoY29uc3VtZXIpOw0KPiA+IC0tDQo=
