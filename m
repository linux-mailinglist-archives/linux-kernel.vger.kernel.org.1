Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160B528AB42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 02:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgJLAnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 20:43:18 -0400
Received: from mail-eopbgr1300098.outbound.protection.outlook.com ([40.107.130.98]:45915
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgJLAnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 20:43:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogd0+jxjh6OZ8HHCOPNiLm+XvTYy0Vm+ZU5GuksMY6JCiT4cnGa00K2B47QAFuleD1AtgG6JdheYP6rPuf9ZJz/8dm4dh27x9wn5Ewf2L/J3dGr0h/eDBSUDXynKbI/nGwhMTJzxXfbM17lyRumPa3ZnzakoKq6/SHRgrUh93SIJfU8sneEJHtojyiw/PZ9+/LezrJJ+r6W7jcMXch6hR5i+vVMlcUth3+bqYGsmjKz7F01tHii3aMRYsmfOHa2x5ELP35b5BsvXKLTbIWC9Bh8grDnoCQCcCfUtuLae6KTHcDVOGfoNhmM9YVoTOoo09CS5cKJIEXSQOOZio19vGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ma9wBT3/tnT1HM6IZdPIhzTPGazG/RTkUHdWfIJYmZ4=;
 b=lGVH3+SxnmZ7TtM9eKnSmmT/zfU8qu7Fks3e8L1xWXkLATmLr5fOrFiglu+Si5q/rm0VSw9inJerZFprBE8CSvoy1DiEfcfpqVcsboP+KrA6qzRGOHr5eMMlQuVlNRfpEhM2OQpLdMtwRQuSixCcpZ4PM8s4/PqOvHyZEV/B9vzNGztZA+6S83pqYfIuw2M7tt3IEQxKUf807weyqIL8WCO9cYL9isyaL+pRq8vlohS0ohidLjnLUYEMsqk5BcDgJ++DQmApfNIQVGv6C/TuQVvkuxxqRfkBjaOOjXwWB3YAqmaVVBN40hYlTz9HyTRJvVP98qVj2pKsWpFuZ4Vovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB2836.apcprd06.prod.outlook.com (2603:1096:203:5d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Mon, 12 Oct
 2020 00:43:13 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5%6]) with mapi id 15.20.3455.027; Mon, 12 Oct 2020
 00:43:13 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH v2 3/3] ARM: dts: add ehci uhci enable in evb dts
Thread-Topic: [PATCH v2 3/3] ARM: dts: add ehci uhci enable in evb dts
Thread-Index: AQHWnebb86S5YSDou02D04yeRF7kFKmO7uQAgAQ2c5A=
Date:   Mon, 12 Oct 2020 00:43:13 +0000
Message-ID: <HK0PR06MB3380D499BCF164951167FCE2F2070@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-4-ryan_chen@aspeedtech.com>
 <4efff4e7-27e0-35be-c112-5377f222a478@gmail.com>
In-Reply-To: <4efff4e7-27e0-35be-c112-5377f222a478@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d7c87532-6818-430b-6f6d-08d86e47ccec
x-ms-traffictypediagnostic: HK0PR06MB2836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB2836218AF628A2F751920AABF2070@HK0PR06MB2836.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TuqnMkEAhVvXrVHgMiZGD0HjBQzH6R1FpYX+FUMdVSD3myIBfIFKxaSmuCuXo0zXoYBqQGPCClhfV2bdgCBMQhxaVckc2oIaoEnODE4iBkGpUH5GJG8ywejj0QAs9DYwVhoFsDfstsLCfKDYHuRt3EeAaY8MoSkeep3g4VoHshZsAX8ZXZKMv3gQfCnsFWpw9/oGJogYSiAJDnYY8wntBNaAEzoasY682PbYZQNW6MPAsb7HilnLnlADwJya/Z9baG6uuLsdz8I4GhZrdwe9SA/BBqJBiv/JBGg8ALD2s300y14yNS5GLxPYd0y+6wj9iSzOqXdzdtJhkxPyecZdtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39830400003)(366004)(376002)(396003)(83380400001)(186003)(66476007)(66946007)(66446008)(8676002)(7696005)(5660300002)(76116006)(52536014)(55236004)(64756008)(66556008)(2906002)(71200400001)(53546011)(33656002)(55016002)(478600001)(6506007)(86362001)(316002)(8936002)(4744005)(26005)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: blyFVfQMheYH/EBsZ7d3QTxByDP6SwCCFHlRVBmJpliJzVCJDOs6AQnqFK2DZIVVNJYAM4etNNYMpkwihEt+CBguOPx4uR6lB0/M8GR5cChctWwzuiPUj9tX4qnfXUXBcfvEoC2jFwFyMTC9FZZSjBTkkodzKv4WKEAfVMR+gTlQ7k/KARMhv/QWNSDqnSF5fyTEJEFffOiJNNmYMajlcWGpvB+0h6qaROHYzdpI4GRNOI905EAbIiHV0KQLeaxCkYjCymsPH2hiGeSm6XF+3jHCoDDpMKOm+naUQS1QFK68+MDsKSzWASY32nl3fXRDk9OELM3haO+ieMT0a3KNKu29YH7F3Eiww3shPksFaGS/a3U1jNGMgFOnyGtuYNM9WJXrDHqjSVwxkgrniOHTLEkL3olvvbl08bcdutaiWpYCJ+nDUMsn0VWq2mi6r/fAP7l1g8sua1cRz3p+yTjU16Jp/Ghf9lLkRg9MvvrbMbXscopLovbQ/SdeZmJyHRFp1BccRuJprevWNWAKS6YuxhI+4dznzoO3i4cjh26FBmNsFpIh/OIao1YdU/W0aVL7qCMzrWSMZvmhCc04oLO+4eklpqVh8pjmwY4rIcX7hA97e1RU/6W+ay1UdzTLQ+mBJ3C6+4xq3flcAvBhgkG77w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c87532-6818-430b-6f6d-08d86e47ccec
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 00:43:13.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YvIrRXXwFVwYwhpqHQX6iEcNIYIlc0TrbCcmdsjJknPb9O55s5A2gveRr+AeGRQfFJBy6991+H9X3IhfwfTpygvNqgyfoQwMNYVn/ZuVmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2836
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU2VnZWksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2Vy
Z2VpIFNodHlseW92IDxzZXJnZWkuc2h0eWx5b3ZAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXks
IE9jdG9iZXIgOSwgMjAyMCA0OjIzIFBNDQo+IFRvOiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBhc3Bl
ZWR0ZWNoLmNvbT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+Ow0KPiBBbmRyZXcgSmVm
ZmVyeSA8YW5kcmV3QGFqLmlkLmF1PjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgQk1DLVNXIDxCTUMtU1dA
YXNwZWVkdGVjaC5jb20+OyBBbGFuIFN0ZXJuDQo+IDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gQVJNOiBkdHM6IGFkZCBlaGNpIHVoY2kg
ZW5hYmxlIGluIGV2YiBkdHMNCj4gDQo+IEhFbGxvIQ0KPiANCj4gT24gMDkuMTAuMjAyMCA1OjQ5
LCBSeWFuIENoZW4gd3JvdGU6DQo+IA0KPiA+IEFkZCBFSENJIFVIQ0kgZW5hYmxlIGJ1aWxkIGlu
IGFzcGVlZC1hc3QyNjAwLWV2Yi5kdHMNCj4gDQo+ICAgICBFbmFibGUgRUNISS9VSENJIGZvciB0
aGUgIEFzcGVlZCBBU1QyNjAwIEVWQiwgcGVyaGFwcz8NCj4gDQoNClllcywgaXQgaXMgZW5hYmxl
IGZvciBBU1QyNjAwIEVWQi4gDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIENoZW4gPHJ5YW5f
Y2hlbkBhc3BlZWR0ZWNoLmNvbT4NCj4gWy4uLl0NCj4gDQo+IE1CUiwgU2VyZ2VpDQo=
