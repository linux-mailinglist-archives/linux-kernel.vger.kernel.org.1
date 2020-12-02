Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2560D2CB5E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387618AbgLBHsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387554AbgLBHsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:48:23 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03174C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:47:42 -0800 (PST)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1B762806AC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 20:47:37 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1606895257;
        bh=AuXGsOMtCh7j+a36U+iI+JeKbjX9dvb0tKRkNVEYSPA=;
        h=From:To:CC:Subject:Date;
        b=UwUfgcdOZQjBOEyD/ENgxd6u5Fb82x8lMzT8Ha7tYZnAHFUe+yZe5eL1gvLXmSonk
         1UxK80ZXT1XEbQc8uQQ6moO/L3hc+fs4hoYbRu/4RotmFMJ9kCtwav+YtzXenlmXUm
         tca7zy6pMJtACYIDGKdyeDszqCi73peoJP8irvFbNZLBTiQBtYWAxj2LduuUcle4Ih
         sFUAXhkq5LLm+toBsWm0tQERifFwwudszq4ok57l1itthCiYvRlCWAMtFx9CUaE0/6
         TCwLeVejF3o8AiCR0Wv6kCfag8OGgWP89Ixvu+ZfZv40I1Z0u0ESgMH+kOHEpbO+j6
         ihmAgm84G9QaA==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5fc7469a0000>; Wed, 02 Dec 2020 20:47:38 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 2 Dec 2020 20:47:32 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.008; Wed, 2 Dec 2020 20:47:32 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>, Vignesh R <vigneshr@ti.com>,
        "boris.brezillon@collabora.com" <boris.brezillon@collabora.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: orion-nand: uncorrectable ECC error on v5.10-rc6
Thread-Topic: orion-nand: uncorrectable ECC error on v5.10-rc6
Thread-Index: AQHWyH9kSvWxPQlVykS9VucKPTkBSw==
Date:   Wed, 2 Dec 2020 07:47:32 +0000
Message-ID: <d88ccac1-801c-f30a-097a-331d49956a9c@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <64D775DB3CF2C04D850568D8EFEA254C@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkkndmUganVzdCBib290ZWQgdjUuMTAtcmM2IG9uIGEga2lya3dvb2QgYmFzZWQgYm9h
cmQgKHdoaWNoIHVzZXMgdGhlIA0Kb3Jpb24tbmFuZCBkcml2ZXIpIGFuZCBJIGdldCB0aGUgZm9s
bG93aW5nIGVycm9ycyByZXBvcnRlZC4gSSBoYXZlbid0IA0Kc3RhcnRlZCBiaXNlY3RpbmcgeWV0
IGJ1dCB2NS43LjE5IG1vdW50cyB0aGUgbmFuZCBmbGFzaCB3aXRob3V0IGFueSBpc3N1ZS4NCg0K
dWJpMDogYXR0YWNoaW5nIG10ZDANCl9fbmFuZF9jb3JyZWN0X2RhdGE6IHVuY29ycmVjdGFibGUg
RUNDIGVycm9yDQp1YmkwIHdhcm5pbmc6IHViaV9pb19yZWFkOiBlcnJvciAtNzQgKEVDQyBlcnJv
cikgd2hpbGUgcmVhZGluZyA2NCBieXRlcyANCmZyb20gUEVCIDA6MCwgcmVhZCBvbmx5IDY0IGJ5
dGVzLCByZXRyeQ0KX19uYW5kX2NvcnJlY3RfZGF0YTogdW5jb3JyZWN0YWJsZSBFQ0MgZXJyb3IN
CnViaTAgd2FybmluZzogdWJpX2lvX3JlYWQ6IGVycm9yIC03NCAoRUNDIGVycm9yKSB3aGlsZSBy
ZWFkaW5nIDY0IGJ5dGVzIA0KZnJvbSBQRUIgMDowLCByZWFkIG9ubHkgNjQgYnl0ZXMsIHJldHJ5
DQpfX25hbmRfY29ycmVjdF9kYXRhOiB1bmNvcnJlY3RhYmxlIEVDQyBlcnJvcg0KdWJpMCB3YXJu
aW5nOiB1YmlfaW9fcmVhZDogZXJyb3IgLTc0IChFQ0MgZXJyb3IpIHdoaWxlIHJlYWRpbmcgNjQg
Ynl0ZXMgDQpmcm9tIFBFQiAwOjAsIHJlYWQgb25seSA2NCBieXRlcywgcmV0cnkNCl9fbmFuZF9j
b3JyZWN0X2RhdGE6IHVuY29ycmVjdGFibGUgRUNDIGVycm9yDQp1YmkwIGVycm9yOiB1YmlfaW9f
cmVhZDogZXJyb3IgLTc0IChFQ0MgZXJyb3IpIHdoaWxlIHJlYWRpbmcgNjQgYnl0ZXMgDQpmcm9t
IFBFQiAwOjAsIHJlYWQgNjQgYnl0ZXMNCkNQVTogMCBQSUQ6IDEwMSBDb21tOiB1YmlhdHRhY2gg
Tm90IHRhaW50ZWQgNS4xMC4wLXJjNisgIzENCkhhcmR3YXJlIG5hbWU6IE1hcnZlbGwgS2lya3dv
b2QgKEZsYXR0ZW5lZCBEZXZpY2UgVHJlZSkNCls8ODAxMGNhNjQ+XSAodW53aW5kX2JhY2t0cmFj
ZSkgZnJvbSBbPDgwMTA5YmQwPl0gKHNob3dfc3RhY2srMHgxMC8weDE0KQ0KWzw4MDEwOWJkMD5d
IChzaG93X3N0YWNrKSBmcm9tIFs8ODA0NWYxMGM+XSAodWJpX2lvX3JlYWQrMHgxODQvMHgzMDQp
DQpbPDgwNDVmMTBjPl0gKHViaV9pb19yZWFkKSBmcm9tIFs8ODA0NWY0YWM+XSAodWJpX2lvX3Jl
YWRfZWNfaGRyKzB4NDQvMHgyNDApDQpbPDgwNDVmNGFjPl0gKHViaV9pb19yZWFkX2VjX2hkcikg
ZnJvbSBbPDgwNDY0ZGIwPl0gDQoodWJpX2F0dGFjaCsweDE3OC8weDE1ZmMpDQpbPDgwNDY0ZGIw
Pl0gKHViaV9hdHRhY2gpIGZyb20gWzw4MDQ1OGQ4Yz5dICh1YmlfYXR0YWNoX210ZF9kZXYrMHg1
MzgvMHhiNDgpDQpbPDgwNDU4ZDhjPl0gKHViaV9hdHRhY2hfbXRkX2RldikgZnJvbSBbPDgwNDVh
MTE0Pl0gDQooY3RybF9jZGV2X2lvY3RsKzB4MTcwLzB4MWUwKQ0KWzw4MDQ1YTExND5dIChjdHJs
X2NkZXZfaW9jdGwpIGZyb20gWzw4MDIwMzA5ND5dIChzeXNfaW9jdGwrMHgxZjgvMHg5OTApDQpb
PDgwMjAzMDk0Pl0gKHN5c19pb2N0bCkgZnJvbSBbPDgwMTAwMDYwPl0gKHJldF9mYXN0X3N5c2Nh
bGwrMHgwLzB4NTApDQpFeGNlcHRpb24gc3RhY2soMHg4NzYzM2ZhOCB0byAweDg3NjMzZmYwKQ0K
M2ZhMDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMDAwMDAwMDMgN2U5YjBj
MzAgMDAwMDAwMDMgNDAxODZmNDAgN2U5YjBjMzAgDQowMDAwMDAwMA0KM2ZjMDogMDAwMDAwMDMg
N2U5YjBjMzAgMDAwMTQ4ZjggMDAwMDAwMzYgMDAwMTQ3NzAgMDAwMTNmOTAgNzZmM2RmYTQgDQow
MDAwMDAwMA0KM2ZlMDogNzZlOTM2ZjAgN2U5YjBjMWMgMDAwMTFmNjggNzZlOTM2ZmMNCg==
