Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A3C2C4790
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbgKYS0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 13:26:23 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2315 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKYS0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 13:26:23 -0500
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Ch8TL3bT5z13Km3;
        Thu, 26 Nov 2020 02:25:42 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 26 Nov 2020 02:26:18 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 26 Nov 2020 02:26:18 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Thu, 26 Nov 2020 02:26:18 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dma-mapping: Fix sizeof() mismatch on tsk allocation
Thread-Topic: [PATCH] dma-mapping: Fix sizeof() mismatch on tsk allocation
Thread-Index: AQHWwzSKuP+v8ZWLE0uVaZXx9A8u4anZKOwQ
Date:   Wed, 25 Nov 2020 18:26:18 +0000
Message-ID: <a6c5e5ed9a66485da301c1e91b56ccc7@hisilicon.com>
References: <20201125140523.1880669-1-colin.king@canonical.com>
In-Reply-To: <20201125140523.1880669-1-colin.king@canonical.com>
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
IDI2LCAyMDIwIDM6MDUgQU0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcu
YmFvLmh1YUBoaXNpbGljb24uY29tPjsgQ2hyaXN0b3BoDQo+IEhlbGx3aWcgPGhjaEBsc3QuZGU+
OyBNYXJlayBTenlwcm93c2tpIDxtLnN6eXByb3dza2lAc2Ftc3VuZy5jb20+Ow0KPiBSb2JpbiBN
dXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPjsgaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcNCj4gQ2M6IGtlcm5lbC1qYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIXSBkbWEtbWFwcGluZzogRml4IHNp
emVvZigpIG1pc21hdGNoIG9uIHRzayBhbGxvY2F0aW9uDQo+IA0KPiBGcm9tOiBDb2xpbiBJYW4g
S2luZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KPiANCj4gQW4gaW5jb3JyZWN0IHNpemVv
ZigpIGlzIGJlaW5nIHVzZWQsIHNpemVvZih0c2spIGlzIG5vdCBjb3JyZWN0LCBpdCBzaG91bGQN
Cj4gYmUgc2l6ZW9mKCp0c2spLiBGaXggaXQuDQo+IA0KPiBBZGRyZXNzZXMtQ292ZXJpdHk6ICgi
U2l6ZW9mIG5vdCBwb3J0YWJsZSAoU0laRU9GX01JU01BVENIKSIpDQo+IEZpeGVzOiBiZmQyZGVm
ZWQ5NGQgKCJkbWEtbWFwcGluZzogYWRkIGJlbmNobWFyayBzdXBwb3J0IGZvciBzdHJlYW1pbmcN
Cj4gRE1BIEFQSXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29saW4ua2lu
Z0BjYW5vbmljYWwuY29tPg0KPiAtLS0NCj4gIGtlcm5lbC9kbWEvbWFwX2JlbmNobWFyay5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL2RtYS9tYXBfYmVuY2htYXJrLmMgYi9rZXJuZWwvZG1h
L21hcF9iZW5jaG1hcmsuYw0KPiBpbmRleCBlMWUzNzYwM2QwMWIuLmIxNDk2ZTc0NGM2OCAxMDA2
NDQNCj4gLS0tIGEva2VybmVsL2RtYS9tYXBfYmVuY2htYXJrLmMNCj4gKysrIGIva2VybmVsL2Rt
YS9tYXBfYmVuY2htYXJrLmMNCj4gQEAgLTEyMSw3ICsxMjEsNyBAQCBzdGF0aWMgaW50IGRvX21h
cF9iZW5jaG1hcmsoc3RydWN0DQo+IG1hcF9iZW5jaG1hcmtfZGF0YSAqbWFwKQ0KPiAgCWludCBy
ZXQgPSAwOw0KPiAgCWludCBpOw0KPiANCj4gLQl0c2sgPSBrbWFsbG9jX2FycmF5KHRocmVhZHMs
IHNpemVvZih0c2spLCBHRlBfS0VSTkVMKTsNCj4gKwl0c2sgPSBrbWFsbG9jX2FycmF5KHRocmVh
ZHMsIHNpemVvZigqdHNrKSwgR0ZQX0tFUk5FTCk7DQoNClRoZSBzaXplIGlzIHNhbWUuIEJ1dCB0
aGUgY2hhbmdlIGlzIGNvcnJlY3QuDQpBY2tlZC1ieTogQmFycnkgU29uZyA8c29uZy5iYW8uaHVh
QGhpc2lsaWNvbi5jb20+DQoNCj4gIAlpZiAoIXRzaykNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+
IA0KVGhhbmtzDQpCYXJyeQ0KDQoNCg==
