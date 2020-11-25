Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2E2C477D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbgKYSWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:22:32 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2072 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbgKYSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:22:31 -0500
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ch8Nr1jqjzVfv2;
        Thu, 26 Nov 2020 02:21:48 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 26 Nov 2020 02:22:24 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 26 Nov 2020 02:22:24 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 26 Nov 2020 02:22:24 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: fix an uninitialized pointer read due to
 typo in argp assignment
Thread-Topic: [PATCH] dma-mapping: fix an uninitialized pointer read due to
 typo in argp assignment
Thread-Index: AQHWwzK8QvyQYoZZJ0ueAMVQnzAXH6nZJ9kw
Date:   Wed, 25 Nov 2020 18:22:24 +0000
Message-ID: <1b430a80dec14cb9aa612ff7e5dddac4@hisilicon.com>
References: <20201125135535.1880307-1-colin.king@canonical.com>
In-Reply-To: <20201125135535.1880307-1-colin.king@canonical.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.201]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29saW4gS2luZyBbbWFp
bHRvOmNvbGluLmtpbmdAY2Fub25pY2FsLmNvbV0NCj4gU2VudDogVGh1cnNkYXksIE5vdmVtYmVy
IDI2LCAyMDIwIDI6NTYgQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcu
YmFvLmh1YUBoaXNpbGljb24uY29tPjsgQ2hyaXN0b3BoDQo+IEhlbGx3aWcgPGhjaEBsc3QuZGU+
OyBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Ow0KPiBSb2JpbiBN
dXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBkbWEtbWFwcGluZzogZml4IGFu
IHVuaW5pdGlhbGl6ZWQgcG9pbnRlciByZWFkIGR1ZSB0byB0eXBvIGluDQo+IGFyZ3AgYXNzaWdu
bWVudA0KPiANCj4gRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNv
bT4NCj4gDQo+IFRoZSBhc3NpZ25tZW50IG9mIGFyZ3AgaXMgY3VycmVudGx5IHVzaW5nIGFyZ3Ag
YXMgdGhlIHNvdXJjZSBiZWNhdXNlIG9mDQo+IGEgdHlwby4gRml4IHRoaXMgYnkgYXNzaWduaW5n
IGl0IHRoZSB2YWx1ZSBwYXNzZWQgaW4gYXJnIGluc3RlYWQuDQo+IA0KPiBBZGRyZXNzZXMtQ292
ZXJpdHk6ICgiVW5pbml0aWFsaXplZCBwb2ludGVyIHJlYWQiKQ0KPiBGaXhlczogYmZkMmRlZmVk
OTRkICgiZG1hLW1hcHBpbmc6IGFkZCBiZW5jaG1hcmsgc3VwcG9ydCBmb3Igc3RyZWFtaW5nDQo+
IERNQSBBUElzIikNCj4gU2lnbmVkLW9mZi1ieTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdA
Y2Fub25pY2FsLmNvbT4NCg0KQWNrZWQtYnk6IEJhcnJ5IFNvbmcgPHNvbmcuYmFvLmh1YUBoaXNp
bGljb24uY29tPg0KDQo+IC0tLQ0KPiAga2VybmVsL2RtYS9tYXBfYmVuY2htYXJrLmMgfCAyICst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9rZXJuZWwvZG1hL21hcF9iZW5jaG1hcmsuYyBiL2tlcm5lbC9kbWEvbWFw
X2JlbmNobWFyay5jDQo+IGluZGV4IGNhNjE2YjY2NGY3Mi4uZTFlMzc2MDNkMDFiIDEwMDY0NA0K
PiAtLS0gYS9rZXJuZWwvZG1hL21hcF9iZW5jaG1hcmsuYw0KPiArKysgYi9rZXJuZWwvZG1hL21h
cF9iZW5jaG1hcmsuYw0KPiBAQCAtMTkyLDcgKzE5Miw3IEBAIHN0YXRpYyBsb25nIG1hcF9iZW5j
aG1hcmtfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsDQo+IHVuc2lnbmVkIGludCBjbWQsDQo+ICAJ
CXVuc2lnbmVkIGxvbmcgYXJnKQ0KPiAgew0KPiAgCXN0cnVjdCBtYXBfYmVuY2htYXJrX2RhdGEg
Km1hcCA9IGZpbGUtPnByaXZhdGVfZGF0YTsNCj4gLQl2b2lkIF9fdXNlciAqYXJncCA9ICh2b2lk
IF9fdXNlciAqKWFyZ3A7DQo+ICsJdm9pZCBfX3VzZXIgKmFyZ3AgPSAodm9pZCBfX3VzZXIgKilh
cmc7DQo+ICAJdTY0IG9sZF9kbWFfbWFzazsNCj4gDQo+ICAJaW50IHJldDsNCj4gLS0NCj4gMi4y
OS4yDQoNClRoYW5rcw0KQmFycnkNCg0K
