Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4643D2BFF14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgKWEno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:43:44 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:57530 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgKWEno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:43:44 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 5BC29891B0;
        Mon, 23 Nov 2020 17:43:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1606106620;
        bh=M/Uwi7onUUoNNqtoojQbHwATAl6ILE/Fw68b2uS9Sic=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=nT2fHyRGg0I8n+BiG9zjCGv7R+ifI2PCMVMPSCsTr//8B11pjDGZofU0oGIraKwTx
         mb4ydNjsEyahLW/zIac/+Miyo9pbywrfTraaKFoA4O7E6m2/5AVyYzw5bsj3rdJBE5
         dwDjfL+Y4V2Awg9y3aRTgA527Q4o+v0u4Xnrxg37m3qIxMGbGHkjI3mokKf6I52TbU
         QBtbYG+mLpMf8UvgnkJoZ3G7e6s1CPV3Fe/kD7UQxtG/ZmNwYw64k/5N0MgjCkT0UX
         PSH1HMA/5h++uaPiHZp9shzuv2QwMUcAu/bfc/vy4jglvUAeeZuvfHsJUOHrRONiBd
         3QeoLW1SKnzRA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fbb3dfc0001>; Mon, 23 Nov 2020 17:43:40 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Nov 2020 17:43:40 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.008; Mon, 23 Nov 2020 17:43:40 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Aryan Srivastava <Aryan.Srivastava@alliedtelesis.co.nz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "Chris Packham" <Chris.Packham@alliedtelesis.co.nz>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: mvebu: Add device tree for RD-AC3X-48G4X2XL
 board
Thread-Topic: [PATCH] ARM: dts: mvebu: Add device tree for RD-AC3X-48G4X2XL
 board
Thread-Index: AQHWwUwN/y284R0WTUajWTO1XRuGZ6nUSeUA
Date:   Mon, 23 Nov 2020 04:43:39 +0000
Message-ID: <95016967-257b-e715-c907-0ac396e125ee@alliedtelesis.co.nz>
References: <20201123035215.2239-1-aryan.srivastava@alliedtelesis.co.nz>
In-Reply-To: <20201123035215.2239-1-aryan.srivastava@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <515CDB209C4BD34895B6896D9869CA7F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXJ5YW4sDQoNCk9uIDIzLzExLzIwIDQ6NTIgcG0sIEFyeWFuIFNyaXZhc3RhdmEgd3JvdGU6
DQo+IEFkZCBkZXZpY2UgdHJlZSBmb3IgUkQtQUMzWC00OEc0WDJYTCBib2FyZC4gVGhpcyBoYXMg
YSBBcm1hZGEgMzgyIFNvQyBvbg0KPiBhIGludGVycG9zZXIgYm9hcmQgY29ubmVjdGVkIHRvIGEg
YmFzZWJvYXJkIHdpdGggYSBQcmVzdGVyYSBBQzNYIEFTSUMNCj4gY29ubmVjdGVkIHZpYSBQQ0ku
DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEFyeWFuIFNyaXZhc3RhdmEgPGFyeWFuLnNyaXZhc3RhdmFA
YWxsaWVkdGVsZXNpcy5jby5uej4NClJldmlld2VkLWJ5OiBDaHJpcyBQYWNraGFtIDxjaHJpcy5w
YWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+DQo+IC0tLQ0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRz
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ICAgLi4uL2Jvb3QvZHRzL2Fy
bWFkYS0zODItcmQtYWMzeC00OGc0eDJ4bC5kdHMgIHwgMTE0ICsrKysrKysrKysrKysrKysrKw0K
PiAgIDIgZmlsZXMgY2hhbmdlZCwgMTE1IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4Mi1yZC1hYzN4LTQ4ZzR4MnhsLmR0cw0K
Pg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUgYi9hcmNoL2FybS9i
b290L2R0cy9NYWtlZmlsZQ0KPiBpbmRleCBjZTY2ZmZkNWExYmIuLmE2MDQwN2FkNzM0NyAxMDA2
NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvTWFrZWZpbGUNCj4gQEAgLTEzMTksNiArMTMxOSw3IEBAIGR0Yi0kKENPTkZJR19N
QUNIX0FSTUFEQV8zNzApICs9IFwNCj4gICBkdGItJChDT05GSUdfTUFDSF9BUk1BREFfMzc1KSAr
PSBcDQo+ICAgCWFybWFkYS0zNzUtZGIuZHRiDQo+ICAgZHRiLSQoQ09ORklHX01BQ0hfQVJNQURB
XzM4WCkgKz0gXA0KPiArCWFybWFkYS0zODItcmQtYWMzeC00OGc0eDJ4bC5kdGIgXA0KPiAgIAlh
cm1hZGEtMzg1LWNsZWFyZm9nLWd0ci1zNC5kdGIgXA0KPiAgIAlhcm1hZGEtMzg1LWNsZWFyZm9n
LWd0ci1sOC5kdGIgXA0KPiAgIAlhcm1hZGEtMzg1LWRiLTg4ZjY4MjAtYW1jLmR0YiBcDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9hcm1hZGEtMzgyLXJkLWFjM3gtNDhnNHgyeGwu
ZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXJtYWRhLTM4Mi1yZC1hYzN4LTQ4ZzR4MnhsLmR0cw0K
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLmIwOGQ2NjJhODUx
OQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2FybWFkYS0zODIt
cmQtYWMzeC00OGc0eDJ4bC5kdHMNCj4gQEAgLTAsMCArMSwxMTQgQEANCj4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBNSVQpDQo+ICsvKg0KPiArICogRGV2aWNlIFRy
ZWUgZmlsZSBmb3IgTWFydmVsbCBBcm1hZGEgMzgyIHJlZmVyZW5jZSBib2FyZA0KPiArICogKFJE
LUFDM1gtNDhHNFgyWEwpDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDIwIEFsbGllZCBU
ZWxlc2lzIExhYnMNCj4gKyAqLw0KPiArDQo+ICsvZHRzLXYxLzsNCj4gKyNpbmNsdWRlICJhcm1h
ZGEtMzg1LmR0c2kiDQo+ICsNCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4N
Cj4gKw0KPiArLyB7DQo+ICsJbW9kZWwgPSAiTWFydmVsbCBBcm1hZGEgMzgyIFJELUFDM1giOw0K
PiArCWNvbXBhdGlibGUgPSAibWFydmVsbCxyZC1hYzN4LTQ4ZzR4MnhsIiwgIm1hcnZlbGwscmQt
YWMzeCIsDQo+ICsJCQkgIm1hcnZlbGwsYXJtYWRhMzg1IiwgIm1hcnZlbGwsYXJtYWRhMzgwIjsN
Cj4gKw0KPiArCWNob3NlbiB7DQo+ICsJCXN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgi
Ow0KPiArCX07DQo+ICsNCj4gKwlhbGlhc2VzIHsNCj4gKwkJZXRoZXJuZXQwID0gJmV0aDE7DQo+
ICsJfTsNCj4gKw0KPiArCW1lbW9yeSB7DQo+ICsJCWRldmljZV90eXBlID0gIm1lbW9yeSI7DQo+
ICsJCXJlZyA9IDwweDAwMDAwMDAwIDB4MjAwMDAwMDA+OyAvKiA1MTJNQiAqLw0KPiArCX07DQo+
ICsNCj4gKwlzb2Mgew0KPiArCQlyYW5nZXMgPSA8TUJVU19JRCgweGYwLCAweDAxKSAwIDB4ZjEw
MDAwMDAgMHgxMDAwMDANCj4gKwkJCSAgTUJVU19JRCgweDAxLCAweDFkKSAwIDB4ZmZmMDAwMDAg
MHgxMDAwMDA+Ow0KPiArCX07DQo+ICt9Ow0KPiArDQo+ICsmaTJjMCB7DQo+ICsJcGluY3RybC1u
YW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLTAgPSA8JmkyYzBfcGlucz47DQo+ICsJc3Rh
dHVzID0gIm9rYXkiOw0KPiArDQo+ICsJZWVwcm9tQDUzew0KPiArCQljb21wYXRpYmxlID0gImF0
bWVsLDI0YzY0IjsNCj4gKwkJcmVnID0gPDB4NTM+Ow0KPiArCX07DQo+ICsvLwljcGxkQDNjew0K
PiArLy8JCWNvbXBhdGlibGUgPSAibWFydmVsbCxhYzN4LWNwbGQiOw0KPiArLy8JCXJlZyA9IDww
eDNjPjsNCj4gKy8vCX07DQo+ICt9Ow0KDQpRdWVzdGlvbiBmb3IgdGhlIG12ZWJ1IG1haW50YWlu
ZXJzOiBXZSBrbm93IHRoZXJlIGlzIGEgY3BsZCB3aXRoIHRoYXQgDQpjYW4gYmUgaW50ZXJmYWNl
ZCB3aXRoIG92ZXIgaTJjLiBPdGhlciB0aGFuIGRldGVjdGluZyB0aGF0IGl0IHNob3dzIHVwIA0K
b24gdGhlIGkyYyBidXMgd2UgaGF2ZW4ndCBkb25lIGFueXRoaW5nIHdpdGggaXQuIFdlIGJlbGll
dmUgaXQgDQppbnRlcmZhY2VzIHdpdGggc29tZSBkaXNjcmV0ZSBJTyBhbmQgbWlnaHQgbXV4IHRo
ZSBpMmMgaW50ZXJmYWNlIHRvd2FyZHMgDQp0aGUgU0ZQL1FTRlAgY2FnZXMuDQoNCk9idmlvdXNs
eSB0aGVyZSBpc24ndCBhICJtYXJ2ZWxsLGFjM3gtY3BsZCIgZHJpdmVyICh5ZXQpIHNvIEkgc3Vn
Z2VzdGVkIA0KdG8gQXJ5YW4gdGhhdCB3ZSBwdXQgaXQgaW4gdGhlIGR0cyB0byBkb2N1bWVudCBp
dHMgZXhpc3RlbmNlIGJ1dCBsZWF2ZSANCml0IGNvbW1lbnRlZCBvdXQgZm9yIG5vdy4gSXMgdGhp
cyBPSz8NCg0KPiArDQo+ICsmdWFydDAgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7
DQo+ICsJcGluY3RybC0wID0gPCZ1YXJ0MF9waW5zPjsNCj4gKwlzdGF0dXMgPSAib2theSI7DQo+
ICt9Ow0KPiArDQo+ICsmZXRoMSB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0KPiArCXBoeSA9IDwm
cGh5MD47DQo+ICsJcGh5LW1vZGUgPSAicmdtaWktaWQiOw0KPiArfTsNCj4gKw0KPiArJm1kaW8g
ew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZtZGlv
X3BpbnM+Ow0KPiArDQo+ICsJcGh5MDogZXRoZXJuZXQtcGh5QDAgew0KPiArCQlyZWcgPSA8MD47
DQo+ICsJfTsNCj4gK307DQo+ICsNCj4gKyZwY2llYyB7DQo+ICsJc3RhdHVzID0gIm9rYXkiOw0K
PiArfTsNCj4gKw0KPiArJnBjaWUxIHsNCj4gKwkvKiBQb3J0IDAsIExhbmUgMCAqLw0KPiArCXN0
YXR1cyA9ICJva2F5IjsNCj4gK307DQo+ICsNCj4gKyZuYW5kX2NvbnRyb2xsZXIgew0KPiArCXN0
YXR1cyA9ICJva2F5IjsNCj4gKw0KPiArCW5hbmRAMCB7DQo+ICsJCXJlZyA9IDwwPjsNCj4gKwkJ
bGFiZWwgPSAicHhhM3h4X25hbmQtMCI7DQo+ICsJCW5hbmQtcmIgPSA8MD47DQo+ICsJCW5hbmQt
b24tZmxhc2gtYmJ0Ow0KPiArDQo+ICsJCXBhcnRpdGlvbnMgew0KPiArCQkJY29tcGF0aWJsZSA9
ICJmaXhlZC1wYXJ0aXRpb25zIjsNCj4gKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkJ
I3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCQlwYXJ0aXRpb25AMCB7DQo+ICsJCQkJcmVnID0gPDB4
MDAwMDAwMDAgMHgwMDUwMDAwMD47DQo+ICsJCQkJbGFiZWwgPSAidS1ib290IjsNCj4gKwkJCX07
DQo+ICsJCQlwYXJ0aXRpb25ANTAwMDAwew0KPiArCQkJCXJlZyA9IDwweDAwNTAwMDAwIDB4MDA0
MDAwMDA+Ow0KPiArCQkJCWxhYmVsID0gInUtYm9vdCBlbnYiOw0KPiArCQkJfTsNCj4gKwkJCXBh
cnRpdGlvbkA5MDAwMDB7DQo+ICsJCQkJcmVnID0gPDB4MDA5MDAwMDAgMHgzRjcwMDAwMD47DQo+
ICsJCQkJbGFiZWwgPSAidXNlciI7DQo+ICsJCQl9Ow0KPiArCQl9Ow0KPiArCX07DQo+ICt9Ow0K
PiArDQo+ICsmcmVmY2xrIHsNCj4gKwljbG9jay1mcmVxdWVuY3kgPSA8MjAwMDAwMDAwPjsNCj4g
K307
