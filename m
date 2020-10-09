Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4052881E7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgJIGBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 02:01:12 -0400
Received: from mail-eopbgr1300131.outbound.protection.outlook.com ([40.107.130.131]:44960
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725917AbgJIGBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:01:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3mzXAMaIfwdM6Phpfpca9MTLAR/UHGvLLqWNSEwmz3P5fSW67uAXETiQhFAshdzwQYJv8vk6Tiw8qungDHxtiS17SpyJmD8HG52viv/vlKfkVhEMUJTip0sjJsw9JelbtYAgMFXQ/n2dL/G0g7Dc9M8nXV4t3p0UmGOj+MqmdrnjWE/1FVdWWOtbNLLgF7Abz1Pma58Mc0r5BqWNgEQnZdFSPoajntdW95rzOD/BDGsDmlMh0JnGi07qqS2Q0wZb4BbpMs/JgjCDTpeMoS3jmI3nCzd6ogHgiw9CUpTC5bFOY8SD5uHEg5F89qJg2VltRNE3rxNv+0lm6lODDn49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v9mG6FBr6/nnGTarC4IgIjxpXzibIuKaAbbVZaUsfc=;
 b=nQcBuFLTFPXjFiMMDPtYEUmQzwhO3O31lB595phowpWhVPGSa3ZDvm0zsi/UgbNM0N1365iM9Imx64/AltyeCEc+gVH76/3Fy1M6tJ9Pfn26jDnI2iSGYLbqChjJasS3Q466yJRojm2Zl/rS8P2Ic1jUqLyY6HZUkRUMHwRk5w/kvvoeA7mvIsdh/XpNiLYHDYodZNOdALKK+maUE5OvQPGQRqm7pNpQ5dNdcr/wW5tWXJJ8Q99xBrOQX9VZuW2vrIeRZ8++gWxZnAwnD0XIbFF+f+v6Ey9kwSgCHf8ivkwJ3HdN5VjTHgr52wcHy8Yq9NsYxHW2AehpUZwv2edm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com (2603:1096:203:82::18)
 by HK0PR06MB3220.apcprd06.prod.outlook.com (2603:1096:203:8c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Fri, 9 Oct
 2020 06:01:06 +0000
Received: from HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5]) by HK0PR06MB3380.apcprd06.prod.outlook.com
 ([fe80::6def:b61:3beb:f3d5%6]) with mapi id 15.20.3455.023; Fri, 9 Oct 2020
 06:01:06 +0000
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Greg KH <greg@kroah.com>
CC:     Andrew Jeffery <andrew@aj.id.au>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: RE: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
Thread-Topic: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
Thread-Index: AQHWnebaNuR8bEyOukOrd+cpU/jDTamOsjUAgAACw4CAABHlsA==
Date:   Fri, 9 Oct 2020 06:01:06 +0000
Message-ID: <HK0PR06MB33809BDA9FD8956CDBE78061F2080@HK0PR06MB3380.apcprd06.prod.outlook.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
 <20201009024937.11246-2-ryan_chen@aspeedtech.com>
 <20201009044526.GB111063@kroah.com>
 <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
In-Reply-To: <CACPK8Xd0h_2yGeyOjrpqV2_X8f4stZA_ur72b4Y4Nx91GrbXag@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: jms.id.au; dkim=none (message not signed)
 header.d=none;jms.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [1.171.23.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78d73a5f-c909-4ca3-bbfd-08d86c18b67d
x-ms-traffictypediagnostic: HK0PR06MB3220:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB322066A2A07B208E9059628DF2080@HK0PR06MB3220.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNq7785OZjgFaFX5OGD70c0wtrzNvJWXoNo02bQmviGtspTiwZ1hwUAlAXdNtvv0izno74tWHdkXfc5lilJK0ldleAuOb329NzwxoHcKJYliAjx08Y3Ct3B1HnhaFBgOHU919t1SYFX63qE7TXCI2DoiQezhO2BW2T3mmEjXTpGbABuvjBUD3QmH0rA9GMGsb5LyZjRpfG/FNhhmRPwxIttTAsoTvd/NYZddj1yGqy6AM0VM6UDWsDVkDhsCYerjiYf9BA7JZhtgFPz0vOa6MPBnt4hdG8HFZYFUMj4mZsTzj9wCAiiHFK8J8D3YgN6KKC6xhXepatiQC1g3J2t0NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3380.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39830400003)(346002)(376002)(136003)(366004)(71200400001)(8676002)(53546011)(9686003)(6506007)(26005)(186003)(86362001)(2906002)(33656002)(83380400001)(64756008)(66556008)(66446008)(66476007)(52536014)(66946007)(5660300002)(76116006)(7696005)(8936002)(316002)(54906003)(478600001)(4326008)(55016002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7BSxB+HJ39zFQ3Q+TC3LYaBt2ChiclqG1Fzt1+CE+X8QFPugL01bB73CTOeg6DBfkJPC1RAiLMYmezST0nbtknG4TTaimYdufoEqJAGtlg4my6l4+hWXFjngg/6f4LVkVJsJO2OmnM36q1m2YaaphI5iGrQdWva0sYVkmHK34i51MhclVM1BRVoOIY9+WsW/YbQSqBXlmhqkE7Ru59pTK0AgzWn50ezkxY4xHFHx17yn3AefZr1u0Tgl5JZvR+tluCOzmaocWDkHH0P3yg7I+HeHSMGVSlz9jwXvtiwELckx8vMMyB8P4+v6RpdWS9pLCLMSyOwEo//ZdN2dA8RMb1W0AGsKcMInhKt8Oyy25FVu5LBH4vyv3KnfvwKLuPRlQf1UHM10EzJFBGBOYpShM4poqoP9EHJfczZz+SYH6jDrTzui42OGqboq50DQkFegKrlKO02YLOd4zdiGXgGKYKIIc1+044FtwpfSIbJuB0u14hwzQkrG31LV7pNa4D/7WI2Fz85Ij4Lc/4EX1PWaENU4g7dYwUxojMuzhwJU62N2FTYqCfVoLr7FwxkzNoALKlxLM8Go9pTHF5Psp5DKyY4vf+pr8tju/S1HMjZ+YwHrNbz2nazLMJ5q4U+aeSUwghL1s8fbVvNkC6M1DqfLUw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3380.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d73a5f-c909-4ca3-bbfd-08d86c18b67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2020 06:01:06.8464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E/Ce5o0r7/InzLChCRQP8U3cPwYxz74mhTG6TtYk/nEcmCxCckUu0DoWFuWYjouOdrvTbrS1vfwwNUBgO6PQo4MMf4IbM2kU9dAUzD9mxQw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb2VsIFN0YW5sZXkgPGpvZWxA
am1zLmlkLmF1Pg0KPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgOSwgMjAyMCAxMjo1NSBQTQ0KPiBU
bzogR3JlZyBLSCA8Z3JlZ0Brcm9haC5jb20+DQo+IENjOiBSeWFuIENoZW4gPHJ5YW5fY2hlbkBh
c3BlZWR0ZWNoLmNvbT47IEFuZHJldyBKZWZmZXJ5DQo+IDxhbmRyZXdAYWouaWQuYXU+OyBMaW51
eCBBUk0gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47DQo+IGxpbnV4LWFz
cGVlZCA8bGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGlu
ZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtdXNiQHZnZXIu
a2VybmVsLm9yZzsgQk1DLVNXDQo+IDxCTUMtU1dAYXNwZWVkdGVjaC5jb20+OyBBbGFuIFN0ZXJu
IDxzdGVybkByb3dsYW5kLmhhcnZhcmQuZWR1Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEv
M10gY29uZmlnczogYXNwZWVkOiBlbmFibGUgVUhDSSBkcml2ZXIgaW4gZGVmY29uZmlnDQo+IA0K
PiBPbiBGcmksIDkgT2N0IDIwMjAgYXQgMDQ6NDUsIEdyZWcgS0ggPGdyZWdAa3JvYWguY29tPiB3
cm90ZToNCj4gPg0KPiA+IE9uIEZyaSwgT2N0IDA5LCAyMDIwIGF0IDEwOjQ5OjM1QU0gKzA4MDAs
IFJ5YW4gQ2hlbiB3cm90ZToNCj4gPiA+IHYyOg0KPiA+ID4gIC1DaGFuZ2VkIDogQWRkIFNDU0ks
IEJMS19ERVZfU0QsIFVTQl9TVE9SQUdFIHN1cHBvcnQuDQo+ID4gPiB2MToNCj4gPiA+ICAtRW5h
YmxlIFVIQ0kgZHJpdmVyIGluIGFzcGVlZF9nNV9kZWZjb25maWcuDQo+ID4gPg0KPiA+ID4gU2ln
bmVkLW9mZi1ieTogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+DQo+ID4NCj4g
PiBXaHkgZG8geW91IG5lZWQgdGhpcyBpbiBhIGRlZmNvbmZpZz8NCj4gDQo+IEkgd291bGQgcHJl
ZmVyIGNvbmZpZ3VyYXRpb25zIHRoYXQgYXJlIGJlaW5nIHVzZWQgdG8gYmUgcHJlc2VudCBpbiB0
aGUgZGVmY29uZmlnDQo+IHNvIHdlIGNhbiB0ZXN0IGl0LiBJIHRoaW5rIHRoaXMgaXMgYSBzZW5z
aWJsZSBjaGFuZ2UuDQo+IA0KPiBSeWFuLCBJIGdhdmUgeW91IG15IFJldmlld2VkLWJ5IGZvciB0
aGUgbGFzdCB2ZXJzaW9uIG9mIHRoZSBwYXRjaC4gQXMgeW91IGRpZA0KPiBub3QgY2hhbmdlIHRo
ZSBjb250ZW50cyBvZiB0aGlzIHBhdGNoIGl0IGlzIGZpbmUgZm9yIHlvdSB0byBsZWF2ZSBteSBS
ZXZpZXdlZC1ieQ0KPiBvbiBpdC4NCg0KSm9lbCwgdGhhbmtzIHRoZSByZXZpZXcsIHNvIEkgbmVl
ZCBhZGQgUmV2aWV3ZWQtYnkgYXQgZWFjaCBwYXRjaCBpZiBzb21lb25lIGhhdmUgcmV2aWV3ZWQg
dGhlIHByZXZpb3VzIHBhdGNoLA0KYW0gSSByaWdodD8gDQo=
