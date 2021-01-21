Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C623D2FE77B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbhAUKYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:24:17 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45693 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbhAUKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:20:44 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10LAJof86027482, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10LAJof86027482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 18:19:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:19:50 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:19:50 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee]) by
 RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee%5]) with mapi id
 15.01.2106.006; Thu, 21 Jan 2021 18:19:50 +0800
From:   =?big5?B?p2Sp/rzhIFJpY2t5?= <ricky_wu@realtek.com>
To:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "vaibhavgupta40@gmail.com" <vaibhavgupta40@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: rtsx: init value of aspm_enabled
Thread-Topic: [PATCH] misc: rtsx: init value of aspm_enabled
Thread-Index: AQHW795wtn9K0pgyoEy259CUlBe0AKox3clA
Date:   Thu, 21 Jan 2021 10:19:50 +0000
Message-ID: <ddc599eac41b49ca92b1a0e1936c7dc6@realtek.com>
References: <20210121101604.2258-1-ricky_wu@realtek.com>
In-Reply-To: <20210121101604.2258-1-ricky_wu@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWJhbmRvbiB0aGlzIHBhdGNoDQpTb3JyeX4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiCnZKn+vOEgUmlja3kgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiBTZW50OiBU
aHVyc2RheSwgSmFudWFyeSAyMSwgMjAyMSA2OjE2IFBNDQo+IFRvOiBhcm5kQGFybmRiLmRlOyBn
cmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgp2QNCj4gqf68
4SBSaWNreSA8cmlja3lfd3VAcmVhbHRlay5jb20+OyB2YWliaGF2Z3VwdGE0MEBnbWFpbC5jb207
DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBtaXNj
OiBydHN4OiBpbml0IHZhbHVlIG9mIGFzcG1fZW5hYmxlZA0KPiANCj4gRnJvbTogUmlja3kgV3Ug
PHJpY2t5X3d1QHJlYWx0ZWsuY29tPg0KPiANCj4gbWFrZSBzdXJlIEFTUE0gc3RhdGUgc3luYyB3
aXRoIHBjci0+YXNwbV9lbmFibGVkIGluaXQgdmFsdWUNCj4gcGNyLT5hc3BtX2VuYWJsZWQNCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFJpY2t5IFd1IDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3Bjci5jIHwgNyArKysrKystDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzeF9wY3IuYw0KPiBiL2RyaXZlcnMv
bWlzYy9jYXJkcmVhZGVyL3J0c3hfcGNyLmMNCj4gaW5kZXggMmFhNjY0OGZhNDFmLi4wNmRmMDY4
N2MwYmIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0c3hfcGNyLmMN
Cj4gKysrIGIvZHJpdmVycy9taXNjL2NhcmRyZWFkZXIvcnRzeF9wY3IuYw0KPiBAQCAtMTUxMiw2
ICsxNTEyLDcgQEAgc3RhdGljIGludCBydHN4X3BjaV9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGNp
ZGV2LA0KPiAgCXN0cnVjdCBwY3JfaGFuZGxlICpoYW5kbGU7DQo+ICAJdTMyIGJhc2UsIGxlbjsN
Cj4gIAlpbnQgcmV0LCBpLCBiYXIgPSAwOw0KPiArCXU4IHZhbDsNCj4gDQo+ICAJZGV2X2RiZygm
KHBjaWRldi0+ZGV2KSwNCj4gIAkJIjogUmVhbHRlayBQQ0ktRSBDYXJkIFJlYWRlciBmb3VuZCBh
dCAlcyBbJTA0eDolMDR4XSAocmV2ICV4KVxuIiwNCj4gQEAgLTE1NzcsNyArMTU3OCwxMSBAQCBz
dGF0aWMgaW50IHJ0c3hfcGNpX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwY2lkZXYsDQo+ICAJcGNy
LT5ob3N0X2NtZHNfYWRkciA9IHBjci0+cnRzeF9yZXN2X2J1Zl9hZGRyOw0KPiAgCXBjci0+aG9z
dF9zZ190YmxfcHRyID0gcGNyLT5ydHN4X3Jlc3ZfYnVmICsgSE9TVF9DTURTX0JVRl9MRU47DQo+
ICAJcGNyLT5ob3N0X3NnX3RibF9hZGRyID0gcGNyLT5ydHN4X3Jlc3ZfYnVmX2FkZHIgKw0KPiBI
T1NUX0NNRFNfQlVGX0xFTjsNCj4gLQ0KPiArCXJ0c3hfcGNpX3JlYWRfcmVnaXN0ZXIocGNyLCBB
U1BNX0ZPUkNFX0NUTCwgJnZhbCk7DQo+ICsJaWYgKHZhbCAmIEZPUkNFX0FTUE1fQ1RMMCB8fCB2
YWwgJiBGT1JDRV9BU1BNX0NUTDEpDQo+ICsJCXBjci0+YXNwbV9lbmFibGVkID0gdHJ1ZTsNCj4g
KwllbHNlDQo+ICsJCXBjci0+YXNwbV9lbmFibGVkID0gZmFsc2U7DQo+ICAJcGNyLT5jYXJkX2lu
c2VydGVkID0gMDsNCj4gIAlwY3ItPmNhcmRfcmVtb3ZlZCA9IDA7DQo+ICAJSU5JVF9ERUxBWUVE
X1dPUksoJnBjci0+Y2FyZGRldF93b3JrLCBydHN4X3BjaV9jYXJkX2RldGVjdCk7DQo+IC0tDQo+
IDIuMTcuMQ0KDQo=
