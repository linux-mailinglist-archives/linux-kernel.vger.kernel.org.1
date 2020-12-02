Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057EF2CB6FF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgLBIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLBIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:24:02 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C5EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 00:23:21 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id BD28D806AC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 21:23:19 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1606897399;
        bh=beeQ02J/91Q8SvPWNaYFI5YtdQjeNTNUITrlsPlbV9g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=D0Ky2oWqR0PQtCq11rHRKj2GBAjnlAbIPwZtx/Ivs7OgxGlPMgPHWPgsOsVheTx03
         fpx8nvPaNhMt+UUj7pJMrmZNu2nUy17D3jKR4Z7d1HGGJlmRj4cbP0XpFnzJ+6kN5a
         6LBMEvWt5jgjNGOPtI0BJIZD70zj1ui5hLFlWHT7kgfFZhJQJiGWB8YTGKZTgh4Vk0
         /MsIc1MeePuRsxIxeLDzZv7g7QFgBK3slz57oFQ4QQk3KkVMC6Z9sNzXvFllZnOGcM
         wP4ZLatZkFkl1RdrXAsgIbsox+HF+s8DgxX47IuZbAvo0I1JzWz/Pi7+Fy9ZXbKcia
         fQBYse734mJMQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fc74ef70000>; Wed, 02 Dec 2020 21:23:19 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 2 Dec 2020 21:23:14 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.008; Wed, 2 Dec 2020 21:23:14 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>, Vignesh R <vigneshr@ti.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: orion-nand: uncorrectable ECC error on v5.10-rc6
Thread-Topic: orion-nand: uncorrectable ECC error on v5.10-rc6
Thread-Index: AQHWyH9kSvWxPQlVykS9VucKPTkBS6nil0gAgAAGi4A=
Date:   Wed, 2 Dec 2020 08:23:13 +0000
Message-ID: <79a69fe8-551b-6cfb-0505-37178ee5a0ec@alliedtelesis.co.nz>
References: <d88ccac1-801c-f30a-097a-331d49956a9c@alliedtelesis.co.nz>
 <20201202085948.038efb3e@xps13>
In-Reply-To: <20201202085948.038efb3e@xps13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <164A6945469AC742879146C14A57726E@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQpPbiAyLzEyLzIwIDg6NTkgcG0sIE1pcXVlbCBSYXluYWwgd3JvdGU6DQo+
IEhpIENocmlzLA0KPg0KPiBDaHJpcyBQYWNraGFtIDxDaHJpcy5QYWNraGFtQGFsbGllZHRlbGVz
aXMuY28ubno+IHdyb3RlIG9uIFdlZCwgMiBEZWMNCj4gMjAyMCAwNzo0NzozMiArMDAwMDoNCj4N
Cj4+IEhpLA0KPj4NCj4+IEkndmUganVzdCBib290ZWQgdjUuMTAtcmM2IG9uIGEga2lya3dvb2Qg
YmFzZWQgYm9hcmQgKHdoaWNoIHVzZXMgdGhlDQo+PiBvcmlvbi1uYW5kIGRyaXZlcikgYW5kIEkg
Z2V0IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkLiBJIGhhdmVuJ3QNCj4+IHN0YXJ0ZWQg
YmlzZWN0aW5nIHlldCBidXQgdjUuNy4xOSBtb3VudHMgdGhlIG5hbmQgZmxhc2ggd2l0aG91dCBh
bnkgaXNzdWUuDQo+Pg0KPj4gdWJpMDogYXR0YWNoaW5nIG10ZDANCj4+IF9fbmFuZF9jb3JyZWN0
X2RhdGE6IHVuY29ycmVjdGFibGUgRUNDIGVycm9yDQo+PiB1YmkwIHdhcm5pbmc6IHViaV9pb19y
ZWFkOiBlcnJvciAtNzQgKEVDQyBlcnJvcikgd2hpbGUgcmVhZGluZyA2NCBieXRlcw0KPj4gZnJv
bSBQRUIgMDowLCByZWFkIG9ubHkgNjQgYnl0ZXMsIHJldHJ5DQo+PiBfX25hbmRfY29ycmVjdF9k
YXRhOiB1bmNvcnJlY3RhYmxlIEVDQyBlcnJvcg0KPj4gdWJpMCB3YXJuaW5nOiB1YmlfaW9fcmVh
ZDogZXJyb3IgLTc0IChFQ0MgZXJyb3IpIHdoaWxlIHJlYWRpbmcgNjQgYnl0ZXMNCj4+IGZyb20g
UEVCIDA6MCwgcmVhZCBvbmx5IDY0IGJ5dGVzLCByZXRyeQ0KPj4gX19uYW5kX2NvcnJlY3RfZGF0
YTogdW5jb3JyZWN0YWJsZSBFQ0MgZXJyb3INCj4+IHViaTAgd2FybmluZzogdWJpX2lvX3JlYWQ6
IGVycm9yIC03NCAoRUNDIGVycm9yKSB3aGlsZSByZWFkaW5nIDY0IGJ5dGVzDQo+PiBmcm9tIFBF
QiAwOjAsIHJlYWQgb25seSA2NCBieXRlcywgcmV0cnkNCj4+IF9fbmFuZF9jb3JyZWN0X2RhdGE6
IHVuY29ycmVjdGFibGUgRUNDIGVycm9yDQo+PiB1YmkwIGVycm9yOiB1YmlfaW9fcmVhZDogZXJy
b3IgLTc0IChFQ0MgZXJyb3IpIHdoaWxlIHJlYWRpbmcgNjQgYnl0ZXMNCj4+IGZyb20gUEVCIDA6
MCwgcmVhZCA2NCBieXRlcw0KPj4gQ1BVOiAwIFBJRDogMTAxIENvbW06IHViaWF0dGFjaCBOb3Qg
dGFpbnRlZCA1LjEwLjAtcmM2KyAjMQ0KPj4gSGFyZHdhcmUgbmFtZTogTWFydmVsbCBLaXJrd29v
ZCAoRmxhdHRlbmVkIERldmljZSBUcmVlKQ0KPj4gWzw4MDEwY2E2ND5dICh1bndpbmRfYmFja3Ry
YWNlKSBmcm9tIFs8ODAxMDliZDA+XSAoc2hvd19zdGFjaysweDEwLzB4MTQpDQo+PiBbPDgwMTA5
YmQwPl0gKHNob3dfc3RhY2spIGZyb20gWzw4MDQ1ZjEwYz5dICh1YmlfaW9fcmVhZCsweDE4NC8w
eDMwNCkNCj4+IFs8ODA0NWYxMGM+XSAodWJpX2lvX3JlYWQpIGZyb20gWzw4MDQ1ZjRhYz5dICh1
YmlfaW9fcmVhZF9lY19oZHIrMHg0NC8weDI0MCkNCj4+IFs8ODA0NWY0YWM+XSAodWJpX2lvX3Jl
YWRfZWNfaGRyKSBmcm9tIFs8ODA0NjRkYjA+XQ0KPj4gKHViaV9hdHRhY2grMHgxNzgvMHgxNWZj
KQ0KPj4gWzw4MDQ2NGRiMD5dICh1YmlfYXR0YWNoKSBmcm9tIFs8ODA0NThkOGM+XSAodWJpX2F0
dGFjaF9tdGRfZGV2KzB4NTM4LzB4YjQ4KQ0KPj4gWzw4MDQ1OGQ4Yz5dICh1YmlfYXR0YWNoX210
ZF9kZXYpIGZyb20gWzw4MDQ1YTExND5dDQo+PiAoY3RybF9jZGV2X2lvY3RsKzB4MTcwLzB4MWUw
KQ0KPj4gWzw4MDQ1YTExND5dIChjdHJsX2NkZXZfaW9jdGwpIGZyb20gWzw4MDIwMzA5ND5dIChz
eXNfaW9jdGwrMHgxZjgvMHg5OTApDQo+PiBbPDgwMjAzMDk0Pl0gKHN5c19pb2N0bCkgZnJvbSBb
PDgwMTAwMDYwPl0gKHJldF9mYXN0X3N5c2NhbGwrMHgwLzB4NTApDQo+PiBFeGNlcHRpb24gc3Rh
Y2soMHg4NzYzM2ZhOCB0byAweDg3NjMzZmYwKQ0KPj4gM2ZhMDrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMDAwMDAwMDMgN2U5YjBjMzAgMDAwMDAwMDMgNDAxODZmNDAgN2U5
YjBjMzANCj4+IDAwMDAwMDAwDQo+PiAzZmMwOiAwMDAwMDAwMyA3ZTliMGMzMCAwMDAxNDhmOCAw
MDAwMDAzNiAwMDAxNDc3MCAwMDAxM2Y5MCA3NmYzZGZhNA0KPj4gMDAwMDAwMDANCj4+IDNmZTA6
IDc2ZTkzNmYwIDdlOWIwYzFjIDAwMDExZjY4IDc2ZTkzNmZjDQo+IEkgcmVjZW50bHkgY29udHJp
YnV0ZWQgYSBwaWxlIG9mIGZpeGVzIHRvIGVuc3VyZSBEVCBwYXJzaW5nIHdhcyBub3QNCj4gYnJv
a2VuIGFuZCB0aGlzIGFwcGxpZXMgdG8gT3Jpb24uIENhbiB5b3UgcGxlYXNlIGNoZWNrDQo+DQo+
IG10ZDogcmF3bmFuZDogb3Jpb246IE1vdmUgdGhlIEVDQyBpbml0aWFsaXphdGlvbiB0byAtPmF0
dGFjaF9jaGlwKCkNClRoYXQgbG9va3MgdG8gYmUgaXQuIEluIExpbnVzJ3MgdHJlZSBjb21taXQg
NzZkYzJiZmMyZTFiICgiTWVyZ2UgdGFnIA0KJ210ZC9maXhlcy1mb3ItNS4xMC1yYzYnIG9mIA0K
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L210ZC9saW51eCIp
IHNlZW1zIHRvIGJlIA0KdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiB3b3JraW5nIGFuZCBub3Qgd29y
a2luZy4NCj4gQW5kIHRlbGwgbWUgaWYgeW91IHNlZSBzb21ldGhpbmcgd3JvbmcgdGhlcmU/IEkg
YXNzdW1lZCB0aGlzIGRyaXZlciB3YXMNCj4gbm90IHN1cHBvcnRpbmcgb24gaG9zdCBFQ0MgZW5n
aW5lcyBhbmQgb25seSBzb2Z0IEhhbW1pbmcgd2FzIHVzZWQsIGlzDQo+IHRoaXMgYXNzdW1wdGlv
biB3cm9uZz8NCg0KT3VyIGR0cyBoYXMNCg0KIMKgwqDCoMKgwqDCoMKgIG5hbmQtZWNjLW1vZGUg
PSAic29mdCI7DQogwqDCoMKgwqDCoMKgwqAgbmFuZC1lY2MtYWxnbyA9ICJiY2giOw0KIMKgwqDC
oMKgwqDCoMKgIG5hbmQtb24tZmxhc2gtYmJ0Ow0KDQo=
