Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDF1296BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461292AbgJWJPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:15:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37059 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S461285AbgJWJPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:15:05 -0400
X-UUID: 1f3cc69f78ac4bf1aee8bdd73a26840c-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BR60j2F54p2pGcLrRVjIn/yPVbDNmaSCHOH23EULGII=;
        b=aWGzMDSnvY6a3HhH+Y3/wjSuQLfNTMZx/CLd7uersbcqTnJONkSdQ6VLGmBt1D0FVz2TSp/0q5hMvYNGr7uJPrGuHQrK1lRl2SnaAQaCZTNzuBFDgriAlc+FlZmydJoaldG6m7eUCbeG+fEpVUpMLXWw2FlEZAOKpVTrGYgwNNI=;
X-UUID: 1f3cc69f78ac4bf1aee8bdd73a26840c-20201023
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1876632747; Fri, 23 Oct 2020 17:14:57 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 17:14:54 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 17:14:54 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Minchan Kim <minchan@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 4/4] arm: replace vector mem type with read-only type
Date:   Fri, 23 Oct 2020 17:14:37 +0800
Message-ID: <20201023091437.8225-5-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201023091437.8225-1-miles.chen@mediatek.com>
References: <20201023091437.8225-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E8A464A3D2B693A78F39320912CA98801136E8EB1B1EEC0E5212E5D3E01CC5D02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U2luY2Uga2VybmVsIG5vIGxvbmdlciB3cml0ZXMgdG8gdGhlIHZlY3RvciwgdHJ5IHRvIHJlcGxh
Y2UNCnRoZSB2ZWN0b3IgbWVtIHR5cGUgd2l0aCByZWFkLW9ubHkgdHlwZSBhbmQgcmVtb3ZlIExf
UFRFX01UX1ZFQ1RPUlMuDQoNCmZyb20gQ2F0YWxpbiBpbiBbMV06DQoiDQo+IEkgZG9uJ3QgdGhp
bmsgdGhpcyBtYXR0ZXJzIHNpbmNlIHRoZSBrZXJuZWwgbm8gbG9uZ2VyIHdyaXRlcyB0byB0aGUN
Cj4gdmVjdG9ycyBwYWdlIGF0IHJ1bi10aW1lIGJ1dCBpdCBuZWVkcyBjbGVhbmluZyB1cCBhIGJp
dCAoYW5kIHRlc3RpbmcgaW4NCj4gY2FzZSBJIG1pc3NlZCBzb21ldGhpbmcpLiBJT1csIGRvIHdl
IHN0aWxsIG5lZWQgYSBkZWRpY2F0ZWQgbWFwcGluZyB0eXBlDQo+IGZvciB0aGUgdmVjdG9ycyBv
ciB3ZSBjYW4gc2ltcGx5IHVzZSB0aGUgcmVhZC1vbmx5IHVzZXIgcGFnZSBhdHRyaWJ1dGVzPw0K
Ig0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcGF0Y2h3b3JrL3BhdGNoLzk4NjU3NC8N
Cg0KQ2M6IFJ1c3NlbGwgS2luZyA8bGludXhAYXJtbGludXgub3JnLnVrPg0KQ2M6IENhdGFsaW4g
TWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQpDYzogTWluY2hhbiBLaW0gPG1pbmNo
YW5Aa2VybmVsLm9yZz4NCkNjOiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29t
Pg0KU2lnbmVkLW9mZi1ieTogTWlsZXMgQ2hlbiA8bWlsZXMuY2hlbkBtZWRpYXRlay5jb20+DQot
LS0NCiBhcmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oIHwgMSAtDQogYXJjaC9h
cm0vbW0vbW11LmMgICAgICAgICAgICAgICAgICAgICB8IDcgKysrLS0tLQ0KIGFyY2gvYXJtL21t
L3Byb2MtbWFjcm9zLlMgICAgICAgICAgICAgfCAyICstDQogMyBmaWxlcyBjaGFuZ2VkLCA0IGlu
c2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9pbmNs
dWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oIGIvYXJjaC9hcm0vaW5jbHVkZS9hc20vcGd0YWJsZS0y
bGV2ZWwuaA0KaW5kZXggMzg1ZTdhMzIzOTRlLi40MzgzNTlkMzY3NWYgMTAwNjQ0DQotLS0gYS9h
cmNoL2FybS9pbmNsdWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oDQorKysgYi9hcmNoL2FybS9pbmNs
dWRlL2FzbS9wZ3RhYmxlLTJsZXZlbC5oDQpAQCAtMTYzLDcgKzE2Myw2IEBADQogI2RlZmluZSBM
X1BURV9NVF9XUklURVRIUk9VR0gJKF9BVChwdGV2YWxfdCwgMHgwMikgPDwgMikJLyogMDAxMCAq
Lw0KICNkZWZpbmUgTF9QVEVfTVRfV1JJVEVCQUNLCShfQVQocHRldmFsX3QsIDB4MDMpIDw8IDIp
CS8qIDAwMTEgKi8NCiAjZGVmaW5lIExfUFRFX01UX0RFVl9TSEFSRUQJKF9BVChwdGV2YWxfdCwg
MHgwNCkgPDwgMikJLyogMDEwMCAqLw0KLSNkZWZpbmUgTF9QVEVfTVRfVkVDVE9SUwkoX0FUKHB0
ZXZhbF90LCAweDA1KSA8PCAyKQkvKiAwMTAxICovDQogI2RlZmluZSBMX1BURV9NVF9NSU5JQ0FD
SEUJKF9BVChwdGV2YWxfdCwgMHgwNikgPDwgMikJLyogMDExMCAoc2ExMTAwLCB4c2NhbGUpICov
DQogI2RlZmluZSBMX1BURV9NVF9XUklURUFMTE9DCShfQVQocHRldmFsX3QsIDB4MDcpIDw8IDIp
CS8qIDAxMTEgKi8NCiAjaWYgZGVmaW5lZChDT05GSUdfQ1BVX1Y3KSB8fCBkZWZpbmVkKENPTkZJ
R19DUFVfVjYpIHx8IGRlZmluZWQoQ09ORklHX0NQVV9WNkspDQpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbW0vbW11LmMgYi9hcmNoL2FybS9tbS9tbXUuYw0KaW5kZXggYWI2OTI1MGE4NmJjLi4wYjZi
Mzc3ZTJjY2UgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9tbS9tbXUuYw0KKysrIGIvYXJjaC9hcm0v
bW0vbW11LmMNCkBAIC01MzYsMTIgKzUzNiwxMSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgYnVpbGRf
bWVtX3R5cGVfdGFibGUodm9pZCkNCiANCiAjaWZuZGVmIENPTkZJR19BUk1fTFBBRQ0KIAkvKg0K
LQkgKiBXZSBkb24ndCB1c2UgZG9tYWlucyBvbiBBUk12NiAoc2luY2UgdGhpcyBjYXVzZXMgcHJv
YmxlbXMgd2l0aA0KLQkgKiB2Ni92NyBrZXJuZWxzKSwgc28gd2UgbXVzdCB1c2UgYSBzZXBhcmF0
ZSBtZW1vcnkgdHlwZSBmb3IgdXNlcg0KLQkgKiByL28sIGtlcm5lbCByL3cgdG8gbWFwIHRoZSB2
ZWN0b3JzIHBhZ2UuDQorCSAqIFdlIG5vIGxvbmdlciB3cml0ZSB0byB0aGUgdmVjdG9yIHBhZ2Vz
IGFyIHJ1bi10aW1lLCB0bw0KKwkgKiB1c2UgcmVhZC1vbmx5IHVzZXIgcGFnZSBhdHRyaWJ1dGUg
Zm9yIHZlY3Rvci4NCiAJICovDQogCWlmIChjcHVfYXJjaCA9PSBDUFVfQVJDSF9BUk12NikNCi0J
CXZlY3NfcGdwcm90IHw9IExfUFRFX01UX1ZFQ1RPUlM7DQorCQl2ZWNzX3BncHJvdCB8PSBMX1BU
RV9SRE9OTFk7DQogDQogCS8qDQogCSAqIENoZWNrIGlzIGl0IHdpdGggc3VwcG9ydCBmb3IgdGhl
IFBYTiBiaXQNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9tbS9wcm9jLW1hY3Jvcy5TIGIvYXJjaC9h
cm0vbW0vcHJvYy1tYWNyb3MuUw0KaW5kZXggZGRlMWQ2Mzc0MjUwLi5mM2U2NTUxYjRhN2UgMTAw
NjQ0DQotLS0gYS9hcmNoL2FybS9tbS9wcm9jLW1hY3Jvcy5TDQorKysgYi9hcmNoL2FybS9tbS9w
cm9jLW1hY3Jvcy5TDQpAQCAtMTM3LDcgKzEzNyw3IEBADQogCS5sb25nCVBURV9DQUNIRUFCTEUJ
CQkJCUAgTF9QVEVfTVRfV1JJVEVUSFJPVUdIDQogCS5sb25nCVBURV9DQUNIRUFCTEUgfCBQVEVf
QlVGRkVSQUJMRQkJCUAgTF9QVEVfTVRfV1JJVEVCQUNLDQogCS5sb25nCVBURV9CVUZGRVJBQkxF
CQkJCQlAIExfUFRFX01UX0RFVl9TSEFSRUQNCi0JLmxvbmcJUFRFX0NBQ0hFQUJMRSB8IFBURV9C
VUZGRVJBQkxFIHwgUFRFX0VYVF9BUFgJQCBMX1BURV9NVF9WRUNUT1JTDQorCS5sb25nCTB4MDAJ
CQkJCQlAIHVudXNlZA0KIAkubG9uZwkweDAwCQkJCQkJQCBMX1BURV9NVF9NSU5JQ0FDSEUgKG5v
dCBwcmVzZW50KQ0KIAkubG9uZwlQVEVfRVhUX1RFWCgxKSB8IFBURV9DQUNIRUFCTEUgfCBQVEVf
QlVGRkVSQUJMRQlAIExfUFRFX01UX1dSSVRFQUxMT0MNCiAJLmxvbmcJMHgwMAkJCQkJCUAgdW51
c2VkDQotLSANCjIuMTguMA0K

