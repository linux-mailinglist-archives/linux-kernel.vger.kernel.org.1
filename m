Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59DF32FE72A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbhAUKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:09:55 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:43847 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbhAUKJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:09:02 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 10LA7mdI6024004, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs02.realtek.com.tw[172.21.6.95])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 10LA7mdI6024004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 18:07:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.29) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:07:48 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 18:07:47 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee]) by
 RTEXMBS01.realtek.com.tw ([fe80::5d07:e256:a2a2:81ee%5]) with mapi id
 15.01.2106.006; Thu, 21 Jan 2021 18:07:47 +0800
From:   =?utf-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
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
Thread-Index: AQHW78cZCdI+a5xevUmIEuTodtJmaKoxrtDQ//+EZACAAIZHwP//f2eAgAChITA=
Date:   Thu, 21 Jan 2021 10:07:47 +0000
Message-ID: <d5ae119edc574e3283c68639067fc5e4@realtek.com>
References: <20210121072858.32028-1-ricky_wu@realtek.com>
 <8563fc3264ad4f46bfa05a3cbdb7d644@realtek.com> <YAk2NtOqIohpBJIt@kroah.com>
 <46473ff62a284bf1bdb703e13884beac@realtek.com> <YAk6+ZgNPQy3snB1@kroah.com>
In-Reply-To: <YAk6+ZgNPQy3snB1@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBncmVna2hAbGludXhmb3VuZGF0
aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBK
YW51YXJ5IDIxLCAyMDIxIDQ6MjggUE0NCj4gVG86IOWQs+aYiua+hCBSaWNreSA8cmlja3lfd3VA
cmVhbHRlay5jb20+DQo+IENjOiBhcm5kQGFybmRiLmRlOyByaWNreV93dUByZWFsdGVrLmNvcnAt
cGFydG5lci5nb29nbGUuY29tOw0KPiBzYXNoYWxAa2VybmVsLm9yZzsgbGV2aW5hbGVAZ29vZ2xl
LmNvbTsga2VpdGFzdXp1a2kucGFya0Bzc2xhYi5pY3Mua2Vpby5hYy5qcDsNCj4ga2RsbnhAZG90
aC5ldTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBydHN4OiBwY2k6IGZpeCBkZXZpY2UgYXNwbSBzdGF0ZSBidWcNCj4gDQo+IE9uIFRodSwgSmFu
IDIxLCAyMDIxIGF0IDA4OjE1OjQ2QU0gKzAwMDAsIOWQs+aYiua+hCBSaWNreSB3cm90ZToNCj4g
PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZyA8Z3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc+DQo+ID4gPiBTZW50OiBU
aHVyc2RheSwgSmFudWFyeSAyMSwgMjAyMSA0OjA3IFBNDQo+ID4gPiBUbzog5ZCz5piK5r6EIFJp
Y2t5IDxyaWNreV93dUByZWFsdGVrLmNvbT4NCj4gPiA+IENjOiBhcm5kQGFybmRiLmRlOyByaWNr
eV93dUByZWFsdGVrLmNvcnAtcGFydG5lci5nb29nbGUuY29tOw0KPiA+ID4gc2FzaGFsQGtlcm5l
bC5vcmc7IGxldmluYWxlQGdvb2dsZS5jb207DQo+ID4gPiBrZWl0YXN1enVraS5wYXJrQHNzbGFi
Lmljcy5rZWlvLmFjLmpwOw0KPiA+ID4ga2RsbnhAZG90aC5ldTsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gcnRzeDogcGNpOiBmaXggZGV2
aWNlIGFzcG0gc3RhdGUgYnVnDQo+ID4gPg0KPiA+ID4gT24gVGh1LCBKYW4gMjEsIDIwMjEgYXQg
MDc6MzM6MDNBTSArMDAwMCwg5ZCz5piK5r6EIFJpY2t5IHdyb3RlOg0KPiA+ID4gPiBIaSBHcmVn
IGtoLA0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIHBhdGNoIHRvIGZpeCBtaXNjOiBydHN4IGJ1ZyBm
b3Iga2VybmVsIDUuNA0KPiA+ID4NCj4gPiA+IEkgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB0aGlz
IG1lYW5zLCBzb3JyeS4gIENhbiB5b3UgcGxlYXNlIGV4cGxhaW4gaXQ/DQo+ID4gPg0KPiA+IE9u
IHRoZSBuZXdlc3QgdXBzdHJlYW0gd2UgZG9u4oCZdCBzZXQgY29uZmlnIHNwYWNlIGZvciBlbi9k
aXNhYmxlIGFzcG0sDQo+ID4gc28gaXQgd2lsbCBub3QgaGFwcGVuIHRoaXMgaXNzdWUgYnV0IG9u
IGtlcm5lbCA1LjQgbG9uZ3Rlcm0gdmVyc2lvbiB3ZQ0KPiA+IG5lZWQgdG8gZml4IGl0DQo+IA0K
PiBQbGVhc2UgcmVhZA0KPiAgICAgaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRl
c3QvcHJvY2Vzcy9zdGFibGUta2VybmVsLXJ1bGVzLmh0bWwNCj4gZm9yIGhvdyB0byBzdWJtaXQg
cGF0Y2hlcyB0byB0aGUgc3RhYmxlIHRyZWUgcHJvcGVybHkuDQo+IA0KPiBBbmQgaWYgdGhpcyBp
cyBub3QgYW4gaXNzdWUgaW4gTGludXMncyB0cmVlLCB3aHkgbm90IGp1c3QgYmFja3BvcnQgdGhl
IGNvbW1pdHMNCj4gdGhhdCBmaXhlZCB0aGlzIGlzc3VlPyAgVGhhdCdzIHRoZSBiZXN0IHdheSB0
byBkbyB0aGlzLg0KPiANClRoYW5rcyB5b3VyIGFkdmljZQ0KV2UgZGlzY3VzcyBpdCBpbnRlcm5h
bGx5DQoNCiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUg
cHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
