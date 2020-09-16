Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D23C26BDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIPHWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:22:16 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:29791 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbgIPHWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:22:14 -0400
X-UUID: fea3a34fe0f34ebfaa90116f6a91b4b9-20200916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vdwmOxjXadac1jyLHZrPCTrO5x1Edd+RZbD6GV3fJf8=;
        b=QefXceX3i4jv/DdyqDskT86AqK5aXSRzqHyHgRZbkPN0/8T1KgaKw73W1fMgmEuUXJD5WXr5/tmA/R9yON3UBesSdxdGTuFt4yySoaISr85k6TDgxU0LJu+QrD1fS8blZcCGmvItnAjjkudWPNjDA2R/aMJwaqo4uag9lt50J8A=;
X-UUID: fea3a34fe0f34ebfaa90116f6a91b4b9-20200916
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 672357538; Wed, 16 Sep 2020 15:22:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Sep 2020 15:22:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Sep 2020 15:22:07 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Phil Chang <phil.chang@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>,
        Mike Rapoport <rppt@kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] [PATCH] ARM64: Setup DMA32 zone size by bootargs
Date:   Wed, 16 Sep 2020 15:22:06 +0800
Message-ID: <20200916072206.27499-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200915150855.24825-1-phil.chang@mediatek.com>
References: <20200915150855.24825-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhpcyBwYXRjaCBhbGxvd2luZyB0aGUgRE1BMzIgem9uZSBiZSBjb25maWd1cmFibGUgaW4gQVJN
NjQuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXggV3UgPGFsaXgud3VAbWVkaWF0ZWsuY29tPg0KU2ln
bmVkLW9mZi1ieTogWUogQ2hpYW5nIDx5ai5jaGlhbmdAbWVkaWF0ZWsuY29tPg0KU2lnbmVkLW9m
Zi1ieTogUGhpbCBDaGFuZyA8cGhpbC5jaGFuZ0BtZWRpYXRlay5jb20+DQotLS0NCkZvciBzb21l
IGRldmljZXMsIHRoZSBtYWluIG1lbW9yeSBzcGxpdCBpbnRvIDIgcGFydCBkdWUgdG8gdGhlIG1l
bW9yeQ0KYXJjaGl0ZWN0dXJlLCB0aGUgZWZmaWNpZW50IGFuZCBsZXNzIGluZWZmaWNpZW50IHBh
cnQuDQpPbmUgb2YgdGhlIHVzZSBjYXNlIGlzIGZpbmUtdHVuZSB0aGUgZG1hMzIgc2l6ZSB0byBj
b250YWluIGFsbCB0aGUNCmVmZmljaWVudCBwYXJ0IG9mIG1lbW9yeSBibG9jayBvbiB0aGlzIGtp
bmQgb2YgYXJjaGl0ZWN0dXJlDQoNCiAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMu
dHh0ICAgICAgICAgfCAgMyArKysNCiBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL21lbW9yeS5oICAg
ICAgICAgICAgICAgfCAgMiArKw0KIGFyY2gvYXJtNjQvbW0vaW5pdC5jICAgICAgICAgICAgICAg
ICAgICAgICAgICB8IDI2ICsrKysrKysrKysrKysrKysrKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDMw
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0IGIvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCmluZGV4IGJkYzFmMzNmZDNkMS4uZWYzYmMz
ZDQ5MzFhIDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFy
YW1ldGVycy50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFt
ZXRlcnMudHh0DQpAQCAtOTgwLDYgKzk4MCw5IEBADQogCQkJVGhlIGZpbHRlciBjYW4gYmUgZGlz
YWJsZWQgb3IgY2hhbmdlZCB0byBhbm90aGVyDQogCQkJZHJpdmVyIGxhdGVyIHVzaW5nIHN5c2Zz
Lg0KIA0KKwlkbWEzMl9zaXplPW5uW0tNR10gIFtLTkwsQk9PVCxBUk02NF0NCisJCQlGb3JjZXMg
dGhlIERNQTMyIHpvbmUgc2l6ZSBvZiA8bm4+IGluIE1CLg0KKw0KIAlkcml2ZXJfYXN5bmNfcHJv
YmU9ICBbS05MXQ0KIAkJCUxpc3Qgb2YgZHJpdmVyIG5hbWVzIHRvIGJlIHByb2JlZCBhc3luY2hy
b25vdXNseS4NCiAJCQlGb3JtYXQ6IDxkcml2ZXJfbmFtZTE+LDxkcml2ZXJfbmFtZTI+Li4uDQpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tZW1vcnkuaCBiL2FyY2gvYXJtNjQv
aW5jbHVkZS9hc20vbWVtb3J5LmgNCmluZGV4IGFmYTcyMjUwNGJmZC4uNzEwZGUwOGFlOGFlIDEw
MDY0NA0KLS0tIGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tZW1vcnkuaA0KKysrIGIvYXJjaC9h
cm02NC9pbmNsdWRlL2FzbS9tZW1vcnkuaA0KQEAgLTE3NSw2ICsxNzUsOCBAQCBleHRlcm4gdTY0
CQkJa2ltYWdlX3ZhZGRyOw0KIC8qIHRoZSBvZmZzZXQgYmV0d2VlbiB0aGUga2VybmVsIHZpcnR1
YWwgYW5kIHBoeXNpY2FsIG1hcHBpbmdzICovDQogZXh0ZXJuIHU2NAkJCWtpbWFnZV92b2Zmc2V0
Ow0KIA0KK2V4dGVybiBwaHlzX2FkZHJfdAkJZG1hMzJfem9uZV9zaXplOw0KKw0KIHN0YXRpYyBp
bmxpbmUgdW5zaWduZWQgbG9uZyBrYXNscl9vZmZzZXQodm9pZCkNCiB7DQogCXJldHVybiBraW1h
Z2VfdmFkZHIgLSBLSU1BR0VfVkFERFI7DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9tbS9pbml0
LmMgYi9hcmNoL2FybTY0L21tL2luaXQuYw0KaW5kZXggNDgxZDIyYzMyYTJlLi5mZDFiODVlMTMx
Y2MgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L21tL2luaXQuYw0KKysrIGIvYXJjaC9hcm02NC9t
bS9pbml0LmMNCkBAIC02MCw2ICs2MCw5IEBAIEVYUE9SVF9TWU1CT0wocGh5c3ZpcnRfb2Zmc2V0
KTsNCiBzdHJ1Y3QgcGFnZSAqdm1lbW1hcCBfX3JvX2FmdGVyX2luaXQ7DQogRVhQT1JUX1NZTUJP
TCh2bWVtbWFwKTsNCiANCitwaHlzX2FkZHJfdCBkbWEzMl96b25lX3NpemUgX19yb19hZnRlcl9p
bml0Ow0KK0VYUE9SVF9TWU1CT0woZG1hMzJfem9uZV9zaXplKTsNCisNCiAvKg0KICAqIFdlIGNy
ZWF0ZSBib3RoIFpPTkVfRE1BIGFuZCBaT05FX0RNQTMyLiBaT05FX0RNQSBjb3ZlcnMgdGhlIGZp
cnN0IDFHIG9mDQogICogbWVtb3J5IGFzIHNvbWUgZGV2aWNlcywgbmFtZWx5IHRoZSBSYXNwYmVy
cnkgUGkgNCwgaGF2ZSBwZXJpcGhlcmFscyB3aXRoDQpAQCAtMTg5LDcgKzE5MiwxMiBAQCBzdGF0
aWMgdm9pZCBfX2luaXQgcmVzZXJ2ZV9lbGZjb3JlaGRyKHZvaWQpDQogc3RhdGljIHBoeXNfYWRk
cl90IF9faW5pdCBtYXhfem9uZV9waHlzKHVuc2lnbmVkIGludCB6b25lX2JpdHMpDQogew0KIAlw
aHlzX2FkZHJfdCBvZmZzZXQgPSBtZW1ibG9ja19zdGFydF9vZl9EUkFNKCkgJiBHRU5NQVNLX1VM
TCg2Mywgem9uZV9iaXRzKTsNCi0JcmV0dXJuIG1pbihvZmZzZXQgKyAoMVVMTCA8PCB6b25lX2Jp
dHMpLCBtZW1ibG9ja19lbmRfb2ZfRFJBTSgpKTsNCisJcGh5c19hZGRyX3Qgem9uZV9zaXplID0g
KDFVTEwgPDwgem9uZV9iaXRzKTsNCisNCisJaWYgKElTX0VOQUJMRUQoQ09ORklHX1pPTkVfRE1B
MzIpICYmIHpvbmVfYml0cyA9PSAzMiAmJiBkbWEzMl96b25lX3NpemUpDQorCQl6b25lX3NpemUg
PSBtaW4oem9uZV9zaXplLCBkbWEzMl96b25lX3NpemUpOw0KKw0KKwlyZXR1cm4gbWluKG9mZnNl
dCArIHpvbmVfc2l6ZSwgbWVtYmxvY2tfZW5kX29mX0RSQU0oKSk7DQogfQ0KIA0KIHN0YXRpYyB2
b2lkIF9faW5pdCB6b25lX3NpemVzX2luaXQodW5zaWduZWQgbG9uZyBtaW4sIHVuc2lnbmVkIGxv
bmcgbWF4KQ0KQEAgLTI0Miw2ICsyNTAsMjIgQEAgc3RhdGljIGludCBfX2luaXQgZWFybHlfbWVt
KGNoYXIgKnApDQogfQ0KIGVhcmx5X3BhcmFtKCJtZW0iLCBlYXJseV9tZW0pOw0KIA0KK3N0YXRp
YyBpbnQgX19pbml0IHNldHVwX2RtYTMyX3pvbmUoY2hhciAqcCkNCit7DQorCXVuc2lnbmVkIGxv
bmcgbG9uZyBzaXplID0gbWVtcGFyc2UocCwgTlVMTCk7DQorDQorCS8qIERNQTMyIHpvbmUgc2l6
ZSBzaG91bGQgbmV2ZXIgZ3JhdGVyIHRoYW4gNEcgKi8NCisJaWYgKHNpemUgPiBTWl80RykNCisJ
CXJldHVybiAtRUlOVkFMOw0KKw0KKwlwcl9ub3RpY2UoIlNldHVwIGRtYTMyIHpvbmUgc2l6ZSB0
byAlbGx1IE1iXG4iLCBzaXplID4+IDIwKTsNCisJZG1hMzJfem9uZV9zaXplID0gc2l6ZTsNCisN
CisJcmV0dXJuIDA7DQorfQ0KKw0KK2Vhcmx5X3BhcmFtKCJkbWEzMl9zaXplIiwgc2V0dXBfZG1h
MzJfem9uZSk7DQorDQogc3RhdGljIGludCBfX2luaXQgZWFybHlfaW5pdF9kdF9zY2FuX3VzYWJs
ZW1lbSh1bnNpZ25lZCBsb25nIG5vZGUsDQogCQljb25zdCBjaGFyICp1bmFtZSwgaW50IGRlcHRo
LCB2b2lkICpkYXRhKQ0KIHsNCi0tIA0KMi4xOC4wDQo=

