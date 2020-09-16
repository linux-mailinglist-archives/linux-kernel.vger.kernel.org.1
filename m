Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9894526C4DA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 18:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgIPQFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 12:05:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46719 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726371AbgIPP4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 11:56:25 -0400
X-UUID: d2110814cbb24b79a459f60e98f4e196-20200916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BkNbMfMCtHSTLPIRTXVMYgSBeI9NJYXxpzZromyW7mk=;
        b=rqDzMdvMvW33ALb+nABu0BKwEwQeTu7aWk4hXvWnRpZCs2ikdCQ5C1YNjrZmAFy9DoOyOaJdGUNPhGMATbPtuZQDYiSYCgXGBvHHX3HYJt3QgQHtVHP6Y036wbsALfnoJgiSiiiRvZxwD2OqMY2b/sL/VPEdtL5sq4bDHf2UY7A=;
X-UUID: d2110814cbb24b79a459f60e98f4e196-20200916
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1687154270; Wed, 16 Sep 2020 21:33:30 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Sep 2020 21:33:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Sep 2020 21:33:24 +0800
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
Date:   Wed, 16 Sep 2020 21:33:24 +0800
Message-ID: <20200916133324.6280-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200916083703.GA26411@infradead.org>
References: <20200916083703.GA26411@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGhpcyBwYXRjaCBhbGxvd2luZyB0aGUgRE1BMzIgem9uZSBiZSBjb25maWd1cmFibGUgaW4gQVJN
NjQuDQpGb3Igc29tZSBkZXZpY2VzLCB0aGUgbWFpbiBtZW1vcnkgc3BsaXQgaW50byAyIHBhcnQg
ZHVlIHRvIHRoZSBtZW1vcnkNCmFyY2hpdGVjdHVyZSwgdGhlIGVmZmljaWVudCBhbmQgbGVzcyBp
bmVmZmljaWVudCBwYXJ0Lg0KT25lIG9mIHRoZSB1c2UgY2FzZSBpcyBmaW5lLXR1bmUgdGhlIGRt
YTMyIHNpemUgdG8gY29udGFpbiBhbGwgdGhlDQplZmZpY2llbnQgcGFydCBvZiBtZW1vcnkgYmxv
Y2sgb24gdGhpcyBraW5kIG9mIGFyY2hpdGVjdHVyZQ0KDQpTaWduZWQtb2ZmLWJ5OiBBbGl4IFd1
IDxhbGl4Lnd1QG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFlKIENoaWFuZyA8eWouY2hp
YW5nQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IFBoaWwgQ2hhbmcgPHBoaWwuY2hhbmdA
bWVkaWF0ZWsuY29tPg0KLS0tDQpIaQ0KDQpzdXBwbGVtZW50IHRoZSByZWFzb24gb2YgdGhpcyB1
c2FnZS4NCg0KVGhhbmtzLg0KDQogLi4uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4
dCAgICAgICAgIHwgIDMgKysrDQogYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9tZW1vcnkuaCAgICAg
ICAgICAgICAgIHwgIDIgKysNCiBhcmNoL2FybTY0L21tL2luaXQuYyAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKystDQogMyBmaWxlcyBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vYWRtaW4t
Z3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQppbmRleCBiZGMxZjMzZmQzZDEuLmVmM2JjM2Q0
OTMxYSAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFt
ZXRlcnMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0
ZXJzLnR4dA0KQEAgLTk4MCw2ICs5ODAsOSBAQA0KIAkJCVRoZSBmaWx0ZXIgY2FuIGJlIGRpc2Fi
bGVkIG9yIGNoYW5nZWQgdG8gYW5vdGhlcg0KIAkJCWRyaXZlciBsYXRlciB1c2luZyBzeXNmcy4N
CiANCisJZG1hMzJfc2l6ZT1ubltLTUddICBbS05MLEJPT1QsQVJNNjRdDQorCQkJRm9yY2VzIHRo
ZSBETUEzMiB6b25lIHNpemUgb2YgPG5uPiBpbiBNQi4NCisNCiAJZHJpdmVyX2FzeW5jX3Byb2Jl
PSAgW0tOTF0NCiAJCQlMaXN0IG9mIGRyaXZlciBuYW1lcyB0byBiZSBwcm9iZWQgYXN5bmNocm9u
b3VzbHkuDQogCQkJRm9ybWF0OiA8ZHJpdmVyX25hbWUxPiw8ZHJpdmVyX25hbWUyPi4uLg0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbWVtb3J5LmggYi9hcmNoL2FybTY0L2lu
Y2x1ZGUvYXNtL21lbW9yeS5oDQppbmRleCBhZmE3MjI1MDRiZmQuLjcxMGRlMDhhZThhZSAxMDA2
NDQNCi0tLSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vbWVtb3J5LmgNCisrKyBiL2FyY2gvYXJt
NjQvaW5jbHVkZS9hc20vbWVtb3J5LmgNCkBAIC0xNzUsNiArMTc1LDggQEAgZXh0ZXJuIHU2NAkJ
CWtpbWFnZV92YWRkcjsNCiAvKiB0aGUgb2Zmc2V0IGJldHdlZW4gdGhlIGtlcm5lbCB2aXJ0dWFs
IGFuZCBwaHlzaWNhbCBtYXBwaW5ncyAqLw0KIGV4dGVybiB1NjQJCQlraW1hZ2Vfdm9mZnNldDsN
CiANCitleHRlcm4gcGh5c19hZGRyX3QJCWRtYTMyX3pvbmVfc2l6ZTsNCisNCiBzdGF0aWMgaW5s
aW5lIHVuc2lnbmVkIGxvbmcga2FzbHJfb2Zmc2V0KHZvaWQpDQogew0KIAlyZXR1cm4ga2ltYWdl
X3ZhZGRyIC0gS0lNQUdFX1ZBRERSOw0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvbW0vaW5pdC5j
IGIvYXJjaC9hcm02NC9tbS9pbml0LmMNCmluZGV4IDQ4MWQyMmMzMmEyZS4uZmQxYjg1ZTEzMWNj
IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9tbS9pbml0LmMNCisrKyBiL2FyY2gvYXJtNjQvbW0v
aW5pdC5jDQpAQCAtNjAsNiArNjAsOSBAQCBFWFBPUlRfU1lNQk9MKHBoeXN2aXJ0X29mZnNldCk7
DQogc3RydWN0IHBhZ2UgKnZtZW1tYXAgX19yb19hZnRlcl9pbml0Ow0KIEVYUE9SVF9TWU1CT0wo
dm1lbW1hcCk7DQogDQorcGh5c19hZGRyX3QgZG1hMzJfem9uZV9zaXplIF9fcm9fYWZ0ZXJfaW5p
dDsNCitFWFBPUlRfU1lNQk9MKGRtYTMyX3pvbmVfc2l6ZSk7DQorDQogLyoNCiAgKiBXZSBjcmVh
dGUgYm90aCBaT05FX0RNQSBhbmQgWk9ORV9ETUEzMi4gWk9ORV9ETUEgY292ZXJzIHRoZSBmaXJz
dCAxRyBvZg0KICAqIG1lbW9yeSBhcyBzb21lIGRldmljZXMsIG5hbWVseSB0aGUgUmFzcGJlcnJ5
IFBpIDQsIGhhdmUgcGVyaXBoZXJhbHMgd2l0aA0KQEAgLTE4OSw3ICsxOTIsMTIgQEAgc3RhdGlj
IHZvaWQgX19pbml0IHJlc2VydmVfZWxmY29yZWhkcih2b2lkKQ0KIHN0YXRpYyBwaHlzX2FkZHJf
dCBfX2luaXQgbWF4X3pvbmVfcGh5cyh1bnNpZ25lZCBpbnQgem9uZV9iaXRzKQ0KIHsNCiAJcGh5
c19hZGRyX3Qgb2Zmc2V0ID0gbWVtYmxvY2tfc3RhcnRfb2ZfRFJBTSgpICYgR0VOTUFTS19VTEwo
NjMsIHpvbmVfYml0cyk7DQotCXJldHVybiBtaW4ob2Zmc2V0ICsgKDFVTEwgPDwgem9uZV9iaXRz
KSwgbWVtYmxvY2tfZW5kX29mX0RSQU0oKSk7DQorCXBoeXNfYWRkcl90IHpvbmVfc2l6ZSA9ICgx
VUxMIDw8IHpvbmVfYml0cyk7DQorDQorCWlmIChJU19FTkFCTEVEKENPTkZJR19aT05FX0RNQTMy
KSAmJiB6b25lX2JpdHMgPT0gMzIgJiYgZG1hMzJfem9uZV9zaXplKQ0KKwkJem9uZV9zaXplID0g
bWluKHpvbmVfc2l6ZSwgZG1hMzJfem9uZV9zaXplKTsNCisNCisJcmV0dXJuIG1pbihvZmZzZXQg
KyB6b25lX3NpemUsIG1lbWJsb2NrX2VuZF9vZl9EUkFNKCkpOw0KIH0NCiANCiBzdGF0aWMgdm9p
ZCBfX2luaXQgem9uZV9zaXplc19pbml0KHVuc2lnbmVkIGxvbmcgbWluLCB1bnNpZ25lZCBsb25n
IG1heCkNCkBAIC0yNDIsNiArMjUwLDIyIEBAIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5X21lbShj
aGFyICpwKQ0KIH0NCiBlYXJseV9wYXJhbSgibWVtIiwgZWFybHlfbWVtKTsNCiANCitzdGF0aWMg
aW50IF9faW5pdCBzZXR1cF9kbWEzMl96b25lKGNoYXIgKnApDQorew0KKwl1bnNpZ25lZCBsb25n
IGxvbmcgc2l6ZSA9IG1lbXBhcnNlKHAsIE5VTEwpOw0KKw0KKwkvKiBETUEzMiB6b25lIHNpemUg
c2hvdWxkIG5ldmVyIGdyYXRlciB0aGFuIDRHICovDQorCWlmIChzaXplID4gU1pfNEcpDQorCQly
ZXR1cm4gLUVJTlZBTDsNCisNCisJcHJfbm90aWNlKCJTZXR1cCBkbWEzMiB6b25lIHNpemUgdG8g
JWxsdSBNYlxuIiwgc2l6ZSA+PiAyMCk7DQorCWRtYTMyX3pvbmVfc2l6ZSA9IHNpemU7DQorDQor
CXJldHVybiAwOw0KK30NCisNCitlYXJseV9wYXJhbSgiZG1hMzJfc2l6ZSIsIHNldHVwX2RtYTMy
X3pvbmUpOw0KKw0KIHN0YXRpYyBpbnQgX19pbml0IGVhcmx5X2luaXRfZHRfc2Nhbl91c2FibGVt
ZW0odW5zaWduZWQgbG9uZyBub2RlLA0KIAkJY29uc3QgY2hhciAqdW5hbWUsIGludCBkZXB0aCwg
dm9pZCAqZGF0YSkNCiB7DQotLSANCjIuMTguMA0K

