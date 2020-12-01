Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8402CA10D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgLALNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:13:06 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2387 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgLALNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:13:05 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ClfYy1SmDz4yTZ;
        Tue,  1 Dec 2020 19:11:50 +0800 (CST)
Received: from dggemi759-chm.china.huawei.com (10.1.198.145) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 1 Dec 2020 19:12:22 +0800
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 dggemi759-chm.china.huawei.com (10.1.198.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 1 Dec 2020 19:12:22 +0800
Received: from dggemi762-chm.china.huawei.com ([10.1.198.148]) by
 dggemi762-chm.china.huawei.com ([10.1.198.148]) with mapi id 15.01.1913.007;
 Tue, 1 Dec 2020 19:12:22 +0800
From:   "Zouwei (Samuel)" <zou_wei@huawei.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "justin.ernst@hpe.com" <justin.ernst@hpe.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>
CC:     "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggLW5leHRdIHg4Ni9wbGF0Zm9ybS91djogTWFyayBz?=
 =?utf-8?Q?ome_symbols_with_static_keyword?=
Thread-Topic: [PATCH -next] x86/platform/uv: Mark some symbols with static
 keyword
Thread-Index: AQHWxwgCON4EmLnq+Euon0db5ls+uKngJdEAgAHxKRA=
Date:   Tue, 1 Dec 2020 11:12:22 +0000
Message-ID: <1bdf4b73d97f4671a69183d1028a0aae@huawei.com>
References: <1606734713-43919-1-git-send-email-zou_wei@huawei.com>
 <55abc980-2493-5c29-da80-4bb1446fa37d@redhat.com>
In-Reply-To: <55abc980-2493-5c29-da80-4bb1446fa37d@redhat.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.100]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClBsZWFzZSBoZWxwIHRvIHBpY2sgaXQgdXAgYWZ0ZXIgNS4xMS1yYzEsIHRoYW5rcyBh
IGxvdC4NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBIYW5zIGRlIEdvZWRl
IFttYWlsdG86aGRlZ29lZGVAcmVkaGF0LmNvbV0gDQrlj5HpgIHml7bpl7Q6IDIwMjDlubQxMeac
iDMw5pelIDIxOjMxDQrmlLbku7bkuro6IFpvdXdlaSAoU2FtdWVsKSA8em91X3dlaUBodWF3ZWku
Y29tPjsganVzdGluLmVybnN0QGhwZS5jb207IG1ncm9zc0BsaW51eC5pbnRlbC5jb20NCuaKhOmA
gTogcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IHg4NkBrZXJuZWwub3JnDQrkuLvpopg6IFJlOiBbUEFUQ0ggLW5leHRdIHg4
Ni9wbGF0Zm9ybS91djogTWFyayBzb21lIHN5bWJvbHMgd2l0aCBzdGF0aWMga2V5d29yZA0KDQpI
aSwNCg0KK0NjIHg4NiBmb2xrcw0KDQpPbiAxMS8zMC8yMCAxMjoxMSBQTSwgWm91IFdlaSB3cm90
ZToNCj4gRml4IHRoZSBmb2xsb3dpbmcgc3BhcnNlIHdhcm5pbmdzOg0KPiANCj4gZHJpdmVycy9w
bGF0Zm9ybS94ODYvdXZfc3lzZnMuYzoyMjoxMzogd2FybmluZzogc3ltYm9sICd1dl9wY2lidXNf
a3NldCcgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gZHJpdmVycy9w
bGF0Zm9ybS94ODYvdXZfc3lzZnMuYzoyMzoxMzogd2FybmluZzogc3ltYm9sICd1dl9odWJzX2tz
ZXQnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBab3UgV2VpIDx6b3Vfd2VpQGh1YXdlaS5jb20+DQoNClNpbmNlIHRoaXMgaXMgYSBm
aXggdG8gYSBzZXJpZXMgbWVyZ2VkIHRocm91Z2ggdGhlIHg4Ni90aXAgdHJlZSwgdGhpcyBzaG91
bGQgYmUgbWVyZ2VkIHRvIHRoZSB4ODYvdGlwIHRyZWUgdG9vIChvciBJIGNhbiBwaWNrIGl0IHVw
IGFmdGVyIDUuMTEtcmMxKS4NCg0KSGVyZSBpcyBteSBhY2sgZm9yIG1lcmdpbmcgdGhpcyB0aHJv
dWdoIHRoZSB4ODYvdGlwIHRyZWU6DQoNCkFja2VkLWJ5OiBIYW5zIGRlIEdvZWRlIDxoZGVnb2Vk
ZUByZWRoYXQuY29tPg0KDQpSZWdhcmRzLA0KDQpIYW5zDQoNCg0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9wbGF0Zm9ybS94ODYvdXZfc3lzZnMuYyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3BsYXRmb3JtL3g4Ni91dl9zeXNmcy5jIA0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L3V2X3N5
c2ZzLmMgaW5kZXggNTRjMzQyNS4uYzc4MGE0YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wbGF0
Zm9ybS94ODYvdXZfc3lzZnMuYw0KPiArKysgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni91dl9zeXNm
cy5jDQo+IEBAIC0xOSw4ICsxOSw4IEBADQo+ICAjZGVmaW5lIElOVkFMSURfQ05PREUgLTENCj4g
IA0KPiAgc3RydWN0IGtvYmplY3QgKnNnaV91dl9rb2JqOw0KPiAtc3RydWN0IGtzZXQgKnV2X3Bj
aWJ1c19rc2V0Ow0KPiAtc3RydWN0IGtzZXQgKnV2X2h1YnNfa3NldDsNCj4gK3N0YXRpYyBzdHJ1
Y3Qga3NldCAqdXZfcGNpYnVzX2tzZXQ7DQo+ICtzdGF0aWMgc3RydWN0IGtzZXQgKnV2X2h1YnNf
a3NldDsNCj4gIHN0YXRpYyBzdHJ1Y3QgdXZfYmlvc19odWJfaW5mbyAqaHViX2J1ZjsgIHN0YXRp
YyBzdHJ1Y3QgDQo+IHV2X2Jpb3NfcG9ydF9pbmZvICoqcG9ydF9idWY7ICBzdGF0aWMgc3RydWN0
IHV2X2h1YiAqKnV2X2h1YnM7DQo+IA0KDQo=
