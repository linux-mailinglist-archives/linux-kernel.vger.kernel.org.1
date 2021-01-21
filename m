Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F82FE4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 09:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbhAUIQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 03:16:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:54538 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbhAUIAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 03:00:50 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10L7xdAgB025107, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10L7xdAgB025107
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 15:59:39 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 15:59:39 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee]) by
 RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee%5]) with mapi id
 15.01.2106.006; Thu, 21 Jan 2021 15:59:39 +0800
From:   =?big5?B?p2Sp/rzhIFJpY2t5?= <ricky_wu@realtek.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "ricky_wu@realtek.corp-partner.google.com" 
        <ricky_wu@realtek.corp-partner.google.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "levinale@google.com" <levinale@google.com>,
        "keitasuzuki.park@sslab.ics.keio.ac.jp" 
        <keitasuzuki.park@sslab.ics.keio.ac.jp>,
        "kdlnx@doth.eu" <kdlnx@doth.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yueherngl@chromium.org" <yueherngl@chromium.org>
Subject: RE: [PATCH] rtsx: pci: fix device aspm state bug
Thread-Topic: [PATCH] rtsx: pci: fix device aspm state bug
Thread-Index: AQHW78cZCdI+a5xevUmIEuTodtJmaKoxLSWAgACHf8A=
Date:   Thu, 21 Jan 2021 07:59:39 +0000
Message-ID: <5b54d74ea7324bf4b829772cdbc0a742@realtek.com>
References: <20210121072858.32028-1-ricky_wu@realtek.com>
 <YAkxIYvpGYQfd/bz@kroah.com>
In-Reply-To: <YAkxIYvpGYQfd/bz@kroah.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtIIDxncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgMjEsIDIwMjEgMzo0
NiBQTQ0KPiBUbzogp2Sp/rzhIFJpY2t5IDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gQ2M6IGFy
bmRAYXJuZGIuZGU7IHJpY2t5X3d1QHJlYWx0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb207DQo+
IHNhc2hhbEBrZXJuZWwub3JnOyBsZXZpbmFsZUBnb29nbGUuY29tOyBrZWl0YXN1enVraS5wYXJr
QHNzbGFiLmljcy5rZWlvLmFjLmpwOw0KPiBrZGxueEBkb3RoLmV1OyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHJ0c3g6IHBjaTogZml4IGRldmlj
ZSBhc3BtIHN0YXRlIGJ1Zw0KPiANCj4gT24gVGh1LCBKYW4gMjEsIDIwMjEgYXQgMDM6Mjg6NThQ
TSArMDgwMCwgcmlja3lfd3VAcmVhbHRlay5jb20gd3JvdGU6DQo+ID4gRnJvbTogUmlja3kgV3Ug
PHJpY2t5X3d1QHJlYWx0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+ID4NCj4gPiBjaGFu
Z2VkIHJ0c3hfcGNpX2Rpc2FibGVfYXNwbSgpIHRvIHJ0c3hfZGlzYWJsZV9hc3BtKCkgbWFrZSBz
dXJlDQo+ID4gcGNyLT5hc3BtX2VuYWJsZWQgdG8gc3luYyB3aXRoIGFzcG0gc3RhdGUNCj4gDQo+
IENhbiB5b3UgbWFrZSB0aGlzIGEgYml0IG1vcmUgZGVzY3JpcHRpdmU/DQo+IA0KQ2hhbmdlZCBy
dHN4X3BjaV9kaXNhYmxlX2FzcG0oKSB0byBydHN4X2Rpc2FibGVfYXNwbSgpIG1ha2Ugc3VyZQ0K
cGNyLT5hc3BtX2VuYWJsZWQgdG8gc3luYyB3aXRoIGFzcG0gc3RhdGUuDQpydHN4X3BjaV9kaXNh
YmxlX2FzcG0oKSB0aGlzIGZ1bmN0aW9uIGRpc2FibGUgYXNwbSBieSBzZXR0aW5nIGNvbmZpZyBz
cGFjZSBkaXJlY3RseQ0KZGlkIG5vdCBjaGFuZ2UgdmFsdWUgb2YgcGNyLT5hc3BtX2VuYWJsZWQg
c28gY2hhbmdlZCB0byB1c2UgcnRzeF9kaXNhYmxlX2FzcG0oKS4NCkdpdmUgaW5pdGlhbCB2YWx1
ZSB0byBwY3ItPmFzcG1fZW5hYmxlZCBieSByZWFkaW5nIGNvbmZpZyBzcGFjZSBzZXR0aW5nIGF0
IGluaXRfaHcoKS4gDQoNCj4gDQo+ID4NCj4gPiBCVUc9YjoxNzUzMzgxMDcNCj4gPiBURVNUPWNo
cm9tZW9zLWtlcm5lbC01XzQNCj4gDQo+IFdoYXQgYXJlIHRoZXNlIGxpbmVzIGZvcj8NCj4gDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNreSBXdSA8cmlja3lfd3VAcmVhbHRlay5jb3JwLXBh
cnRuZXIuZ29vZ2xlLmNvbT4NCj4gDQo+IFRoaXMgZW1haWwgZG9lcyBub3QgbWF0Y2ggeW91ciBG
cm9tOiBhZGRyZXNzIDooDQo+IA0KPiA+IENoYW5nZS1JZDogSTRiMTQ2ZGNkYWFmMmYyYTk2NTM4
MWMzMjc4MGIwYjExMGQ3NTEyNTgNCj4gDQo+IFBsZWFzZSB1c2UgY2hlY2twYXRjaC5wbCBiZWZv
cmUgc2VuZGluZyBwYXRjaGVzIHRvIHVzIDooDQo+IA0KPiBBbmQgd2h5IGRpZCB5b3Ugc2VuZCB0
aGlzIHR3aWNlPw0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCj4gDQo+IC0tLS0tLVBs
ZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWls
Lg0K
