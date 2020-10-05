Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3AF0282EE7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 04:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJECk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 22:40:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725891AbgJECkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 22:40:55 -0400
X-UUID: 8edc94a3deff432897a72c530d90ee78-20201005
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=qKVKEW5yKCrYo9cZixFWjhvNVCK6HhWdz53vb9XF6gs=;
        b=tc+mYSo0tX+KgHcbH9zbEM1Bqa2lXXpGTFVqupsgOTe9VGPeI8Kc77LiMpESRd3nkvfT/rGmz/mg4w/z5a7XhVVEAco6bgjBhu/WueIHSyyCxXusfL8YBaSFK40K+6opqON5qjdcXB+NLv4qx8iP7bGV0vVSO3kl3claldhyTzU=;
X-UUID: 8edc94a3deff432897a72c530d90ee78-20201005
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 728767042; Mon, 05 Oct 2020 10:40:50 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 5 Oct 2020 10:40:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Oct 2020 10:40:42 +0800
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Michel Lespinasse <walken@google.com>
Subject: [RESEND, PATCH v4 2/3] mm: smaps*: extend smap_gather_stats to support specified beginning
Date:   Mon, 5 Oct 2020 10:40:13 +0800
Message-ID: <1601865614-4918-3-git-send-email-chinwen.chang@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601865614-4918-1-git-send-email-chinwen.chang@mediatek.com>
References: <1601865614-4918-1-git-send-email-chinwen.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RXh0ZW5kIHNtYXBfZ2F0aGVyX3N0YXRzIHRvIHN1cHBvcnQgaW5kaWNhdGVkIGJlZ2lubmluZyBh
ZGRyZXNzIGF0DQp3aGljaCBpdCBzaG91bGQgc3RhcnQgZ2F0aGVyaW5nLiBUbyBhY2hpZXZlIHRo
ZSBnb2FsLCB3ZSBhZGQgYSBuZXcNCnBhcmFtZXRlciBAc3RhcnQgYXNzaWduZWQgYnkgdGhlIGNh
bGxlciBhbmQgdHJ5IHRvIHJlZmFjdG9yIGl0IGZvcg0Kc2ltcGxpY2l0eS4NCg0KSWYgQHN0YXJ0
IGlzIDAsIGl0IHdpbGwgdXNlIHRoZSByYW5nZSBvZiBAdm1hIGZvciBnYXRoZXJpbmcuDQoNCkNo
YW5nZSBzaW5jZSB2MjoNCi0gVGhpcyBpcyBhIG5ldyBjaGFuZ2UgdG8gbWFrZSB0aGUgcmV0cnkg
YmVoYXZpb3Igb2Ygc21hcHNfcm9sbHVwDQotIG1vcmUgY29tcGxldGUgYXMgc3VnZ2VzdGVkIGJ5
IE1pY2hlbCBbMV0NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvQ0FOTjY4OUZ0
Q3NDNzFjakFqczBHUHNwT2hnb19IUmorZGlXc29VMXdyOThZUGt0Z1dnQG1haWwuZ21haWwuY29t
Lw0KDQpDaGFuZ2UtSWQ6IEk4NjUyZTBlZTZjNWU5M2ZiNTYzNzZhNjhkNzFlZDZjZGQ4YWMxMGU4
DQpTaWduZWQtb2ZmLWJ5OiBDaGlud2VuIENoYW5nIDxjaGlud2VuLmNoYW5nQG1lZGlhdGVrLmNv
bT4NCkNDOiBNaWNoZWwgTGVzcGluYXNzZSA8d2Fsa2VuQGdvb2dsZS5jb20+DQpSZXZpZXdlZC1i
eTogU3RldmVuIFByaWNlIDxzdGV2ZW4ucHJpY2VAYXJtLmNvbT4NCi0tLQ0KIGZzL3Byb2MvdGFz
a19tbXUuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAyMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMv
cHJvYy90YXNrX21tdS5jIGIvZnMvcHJvYy90YXNrX21tdS5jDQppbmRleCBkYmRhNDQ5Li43NmU2
MjNhIDEwMDY0NA0KLS0tIGEvZnMvcHJvYy90YXNrX21tdS5jDQorKysgYi9mcy9wcm9jL3Rhc2tf
bW11LmMNCkBAIC03MjMsOSArNzIzLDIxIEBAIHN0YXRpYyBpbnQgc21hcHNfaHVnZXRsYl9yYW5n
ZShwdGVfdCAqcHRlLCB1bnNpZ25lZCBsb25nIGhtYXNrLA0KIAkucHRlX2hvbGUJCT0gc21hcHNf
cHRlX2hvbGUsDQogfTsNCiANCisvKg0KKyAqIEdhdGhlciBtZW0gc3RhdHMgZnJvbSBAdm1hIHdp
dGggdGhlIGluZGljYXRlZCBiZWdpbm5pbmcNCisgKiBhZGRyZXNzIEBzdGFydCwgYW5kIGtlZXAg
dGhlbSBpbiBAbXNzLg0KKyAqDQorICogVXNlIHZtX3N0YXJ0IG9mIEB2bWEgYXMgdGhlIGJlZ2lu
bmluZyBhZGRyZXNzIGlmIEBzdGFydCBpcyAwLg0KKyAqLw0KIHN0YXRpYyB2b2lkIHNtYXBfZ2F0
aGVyX3N0YXRzKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hLA0KLQkJCSAgICAgc3RydWN0IG1l
bV9zaXplX3N0YXRzICptc3MpDQorCQlzdHJ1Y3QgbWVtX3NpemVfc3RhdHMgKm1zcywgdW5zaWdu
ZWQgbG9uZyBzdGFydCkNCiB7DQorCWNvbnN0IHN0cnVjdCBtbV93YWxrX29wcyAqb3BzID0gJnNt
YXBzX3dhbGtfb3BzOw0KKw0KKwkvKiBJbnZhbGlkIHN0YXJ0ICovDQorCWlmIChzdGFydCA+PSB2
bWEtPnZtX2VuZCkNCisJCXJldHVybjsNCisNCiAjaWZkZWYgQ09ORklHX1NITUVNDQogCS8qIElu
IGNhc2Ugb2Ygc21hcHNfcm9sbHVwLCByZXNldCB0aGUgdmFsdWUgZnJvbSBwcmV2aW91cyB2bWEg
Ki8NCiAJbXNzLT5jaGVja19zaG1lbV9zd2FwID0gZmFsc2U7DQpAQCAtNzQyLDE4ICs3NTQsMjAg
QEAgc3RhdGljIHZvaWQgc21hcF9nYXRoZXJfc3RhdHMoc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2
bWEsDQogCQkgKi8NCiAJCXVuc2lnbmVkIGxvbmcgc2htZW1fc3dhcHBlZCA9IHNobWVtX3N3YXBf
dXNhZ2Uodm1hKTsNCiANCi0JCWlmICghc2htZW1fc3dhcHBlZCB8fCAodm1hLT52bV9mbGFncyAm
IFZNX1NIQVJFRCkgfHwNCi0JCQkJCSEodm1hLT52bV9mbGFncyAmIFZNX1dSSVRFKSkgew0KKwkJ
aWYgKCFzdGFydCAmJiAoIXNobWVtX3N3YXBwZWQgfHwgKHZtYS0+dm1fZmxhZ3MgJiBWTV9TSEFS
RUQpIHx8DQorCQkJCQkhKHZtYS0+dm1fZmxhZ3MgJiBWTV9XUklURSkpKSB7DQogCQkJbXNzLT5z
d2FwICs9IHNobWVtX3N3YXBwZWQ7DQogCQl9IGVsc2Ugew0KIAkJCW1zcy0+Y2hlY2tfc2htZW1f
c3dhcCA9IHRydWU7DQotCQkJd2Fsa19wYWdlX3ZtYSh2bWEsICZzbWFwc19zaG1lbV93YWxrX29w
cywgbXNzKTsNCi0JCQlyZXR1cm47DQorCQkJb3BzID0gJnNtYXBzX3NobWVtX3dhbGtfb3BzOw0K
IAkJfQ0KIAl9DQogI2VuZGlmDQogCS8qIG1tYXBfbG9jayBpcyBoZWxkIGluIG1fc3RhcnQgKi8N
Ci0Jd2Fsa19wYWdlX3ZtYSh2bWEsICZzbWFwc193YWxrX29wcywgbXNzKTsNCisJaWYgKCFzdGFy
dCkNCisJCXdhbGtfcGFnZV92bWEodm1hLCBvcHMsIG1zcyk7DQorCWVsc2UNCisJCXdhbGtfcGFn
ZV9yYW5nZSh2bWEtPnZtX21tLCBzdGFydCwgdm1hLT52bV9lbmQsIG9wcywgbXNzKTsNCiB9DQog
DQogI2RlZmluZSBTRVFfUFVUX0RFQyhzdHIsIHZhbCkgXA0KQEAgLTgwNSw3ICs4MTksNyBAQCBz
dGF0aWMgaW50IHNob3dfc21hcChzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpDQogDQogCW1l
bXNldCgmbXNzLCAwLCBzaXplb2YobXNzKSk7DQogDQotCXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwg
Jm1zcyk7DQorCXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcywgMCk7DQogDQogCXNob3dfbWFw
X3ZtYShtLCB2bWEpOw0KIA0KQEAgLTg1NCw3ICs4NjgsNyBAQCBzdGF0aWMgaW50IHNob3dfc21h
cHNfcm9sbHVwKHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikNCiAJaG9sZF90YXNrX21lbXBv
bGljeShwcml2KTsNCiANCiAJZm9yICh2bWEgPSBwcml2LT5tbS0+bW1hcDsgdm1hOyB2bWEgPSB2
bWEtPnZtX25leHQpIHsNCi0JCXNtYXBfZ2F0aGVyX3N0YXRzKHZtYSwgJm1zcyk7DQorCQlzbWFw
X2dhdGhlcl9zdGF0cyh2bWEsICZtc3MsIDApOw0KIAkJbGFzdF92bWFfZW5kID0gdm1hLT52bV9l
bmQ7DQogCX0NCiANCi0tIA0KMS45LjENCg==

