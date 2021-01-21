Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5772FE40D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbhAUHfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:35:14 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51098 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbhAUHeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:34:04 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10L7X3wI4019351, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10L7X3wI4019351
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 15:33:03 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 15:33:03 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee]) by
 RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee%5]) with mapi id
 15.01.2106.006; Thu, 21 Jan 2021 15:33:03 +0800
From:   =?big5?B?p2Sp/rzhIFJpY2t5?= <ricky_wu@realtek.com>
To:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ricky_wu@realtek.corp-partner.google.com" 
        <ricky_wu@realtek.corp-partner.google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "levinale@google.com" <levinale@google.com>,
        "keitasuzuki.park@sslab.ics.keio.ac.jp" 
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "kdlnx@doth.eu" <kdlnx@doth.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtsx: pci: fix device aspm state bug
Thread-Topic: [PATCH] rtsx: pci: fix device aspm state bug
Thread-Index: AQHW78cZCdI+a5xevUmIEuTodtJmaKoxrtDQ
Date:   Thu, 21 Jan 2021 07:33:03 +0000
Message-ID: <8563fc3264ad4f46bfa05a3cbdb7d644@realtek.com>
References: <20210121072858.32028-1-ricky_wu@realtek.com>
In-Reply-To: <20210121072858.32028-1-ricky_wu@realtek.com>
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

SGkgR3JlZyBraCwNCg0KVGhpcyBwYXRjaCB0byBmaXggbWlzYzogcnRzeCBidWcgZm9yIGtlcm5l
bCA1LjQNCg0KUmlja3kNCg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogp2Sp/rzhIFJpY2t5IDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IEphbnVhcnkgMjEsIDIwMjEgMzoyOSBQTQ0KPiBUbzogYXJuZEBhcm5kYi5kZTsgZ3JlZ2toQGxp
bnV4Zm91bmRhdGlvbi5vcmc7DQo+IHJpY2t5X3d1QHJlYWx0ZWsuY29ycC1wYXJ0bmVyLmdvb2ds
ZS5jb207IHNhc2hhbEBrZXJuZWwub3JnOw0KPiBsZXZpbmFsZUBnb29nbGUuY29tOyBrZWl0YXN1
enVraS5wYXJrQHNzbGFiLmljcy5rZWlvLmFjLmpwOyBrZGxueEBkb3RoLmV1Ow0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyCnZKn+vOEgUmlja3kgPHJpY2t5X3d1QHJlYWx0ZWsuY29t
Pg0KPiBTdWJqZWN0OiBbUEFUQ0hdIHJ0c3g6IHBjaTogZml4IGRldmljZSBhc3BtIHN0YXRlIGJ1
Zw0KPiANCj4gRnJvbTogUmlja3kgV3UgPHJpY2t5X3d1QHJlYWx0ZWsuY29ycC1wYXJ0bmVyLmdv
b2dsZS5jb20+DQo+IA0KPiBjaGFuZ2VkIHJ0c3hfcGNpX2Rpc2FibGVfYXNwbSgpIHRvIHJ0c3hf
ZGlzYWJsZV9hc3BtKCkgbWFrZSBzdXJlDQo+IHBjci0+YXNwbV9lbmFibGVkIHRvIHN5bmMgd2l0
aCBhc3BtIHN0YXRlDQo+IA0KPiBCVUc9YjoxNzUzMzgxMDcNCj4gVEVTVD1jaHJvbWVvcy1rZXJu
ZWwtNV80DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNreSBXdSA8cmlja3lfd3VAcmVhbHRlay5j
b3JwLXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gQ2hhbmdlLUlkOiBJNGIxNDZkY2RhYWYyZjJhOTY1
MzgxYzMyNzgwYjBiMTEwZDc1MTI1OA0KPiAtLS0NCj4gIGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVy
L3J0c3hfcGNyLmMgfCA5ICsrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlzYy9jYXJk
cmVhZGVyL3J0c3hfcGNyLmMNCj4gYi9kcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3Bjci5j
DQo+IGluZGV4IGYwN2IwMTEyNWQxOS4uZjM2NDVlNzJlY2M0IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL21pc2MvY2FyZHJlYWRlci9ydHN4X3Bjci5jDQo+ICsrKyBiL2RyaXZlcnMvbWlzYy9jYXJk
cmVhZGVyL3J0c3hfcGNyLmMNCj4gQEAgLTEyODUsOCArMTI4NSwxNSBAQCBpbnQgcnRzeF9tc19w
b3dlcl9vZmZfY2FyZDN2MyhzdHJ1Y3QgcnRzeF9wY3INCj4gKnBjcikgIHN0YXRpYyBpbnQgcnRz
eF9wY2lfaW5pdF9odyhzdHJ1Y3QgcnRzeF9wY3IgKnBjcikgIHsNCj4gIAlpbnQgZXJyOw0KPiAr
CXU4IHZhbDsNCj4gDQo+ICAJcGNyLT5wY2llX2NhcCA9IHBjaV9maW5kX2NhcGFiaWxpdHkocGNy
LT5wY2ksIFBDSV9DQVBfSURfRVhQKTsNCj4gKwlydHN4X3BjaV9yZWFkX2NvbmZpZ19ieXRlKHBj
ciwgcGNyLT5wY2llX2NhcCArIFBDSV9FWFBfTE5LQ1RMLCAmdmFsKTsNCj4gKwlpZiAodmFsICYg
MHgwMikNCj4gKwkJcGNyLT5hc3BtX2VuYWJsZWQgPSB0cnVlOw0KPiArCWVsc2UNCj4gKwkJcGNy
LT5hc3BtX2VuYWJsZWQgPSBmYWxzZTsNCj4gKw0KPiAgCXJ0c3hfcGNpX3dyaXRlbChwY3IsIFJU
U1hfSENCQVIsIHBjci0+aG9zdF9jbWRzX2FkZHIpOw0KPiANCj4gIAlydHN4X3BjaV9lbmFibGVf
YnVzX2ludChwY3IpOw0KPiBAQCAtMTMwNyw3ICsxMzE0LDcgQEAgc3RhdGljIGludCBydHN4X3Bj
aV9pbml0X2h3KHN0cnVjdCBydHN4X3BjciAqcGNyKQ0KPiAgCS8qIFdhaXQgU1NDIHBvd2VyIHN0
YWJsZSAqLw0KPiAgCXVkZWxheSgyMDApOw0KPiANCj4gLQlydHN4X3BjaV9kaXNhYmxlX2FzcG0o
cGNyKTsNCj4gKwlydHN4X2Rpc2FibGVfYXNwbShwY3IpOw0KPiAgCWlmIChwY3ItPm9wcy0+b3B0
aW1pemVfcGh5KSB7DQo+ICAJCWVyciA9IHBjci0+b3BzLT5vcHRpbWl6ZV9waHkocGNyKTsNCj4g
IAkJaWYgKGVyciA8IDApDQo+IC0tDQo+IDIuMTcuMQ0KDQo=
