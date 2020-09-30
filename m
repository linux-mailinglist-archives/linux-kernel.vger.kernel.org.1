Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E58C27E233
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgI3HKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:10:08 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41270 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:10:07 -0400
X-UUID: 71777b04e1034f118107bac2916b0cc4-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5cuaBwfVccDx8t6YaxBqxyKgg/cFncPpWk3C5+45/Dk=;
        b=k5z2wM2/SYVmS3M7s5242mIgNZB8bjX4Gg05ixoHxaQYYD9TSKkk9kWFjn3a/Oe6V9sma98DXWDlTw1hDSSGpOR2S7tnR8rp8AKuZQ2QOIt4hjHMOjELIfuLheATOAJqftFKSpozAB3QlOylXUUMqyjVcbrfigM9rRtoXMJz3dY=;
X-UUID: 71777b04e1034f118107bac2916b0cc4-20200930
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 946817937; Wed, 30 Sep 2020 15:10:03 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:10:00 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:10:01 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Will Deacon <will@kernel.org>
CC:     Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        <kernel-team@android.com>
Subject: [PATCH v3 15/24] iommu/mediatek: Add power-domain operation
Date:   Wed, 30 Sep 2020 15:06:38 +0800
Message-ID: <20200930070647.10188-16-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C77212E66262157FC1E61846B81DE56A08D456D9678A5E9C684DD4C76542F2D42000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gdGhlIHByZXZpb3VzIFNvQywgdGhlIE00VSBIVyBpcyBpbiB0aGUgRU1JIHBvd2VyIGRvbWFp
biB3aGljaCBpcw0KYWx3YXlzIG9uLiB0aGUgbGF0ZXN0IE00VSBpcyBpbiB0aGUgZGlzcGxheSBw
b3dlciBkb21haW4gd2hpY2ggbWF5IGJlDQp0dXJuZWQgb24vb2ZmLCB0aHVzIHdlIGhhdmUgdG8g
YWRkIHBtX3J1bnRpbWUgaW50ZXJmYWNlIGZvciBpdC4NCg0KV2hlbiB0aGUgZW5naW5lIHdvcmss
IHRoZSBlbmdpbmUgYWx3YXlzIGVuYWJsZSB0aGUgcG93ZXIgYW5kIGNsb2NrcyBmb3INCnNtaS1s
YXJiL3NtaS1jb21tb24sIHRoZW4gdGhlIE00VSdzIHBvd2VyIHdpbGwgYWx3YXlzIGJlIHBvd2Vy
ZWQgb24NCmF1dG9tYXRpY2FsbHkgdmlhIHRoZSBkZXZpY2UgbGluayB3aXRoIHNtaS1jb21tb24u
DQoNCk5vdGU6IHdlIGRvbid0IGVuYWJsZSB0aGUgTTRVIHBvd2VyIGluIGlvbW11X21hcC91bm1h
cCBmb3IgdGxiIGZsdXNoLg0KSWYgaXRzIHBvd2VyIGFscmVhZHkgaXMgb24sIG9mIGNvdXJzZSBp
dCBpcyBvay4gaWYgdGhlIHBvd2VyIGlzIG9mZiwNCnRoZSBtYWluIHRsYiB3aWxsIGJlIHJlc2V0
IHdoaWxlIE00VSBwb3dlciBvbiwgdGh1cyB0aGUgdGxiIGZsdXNoIHdoaWxlDQptNHUgcG93ZXIg
b2ZmIGlzIHVubmVjZXNzYXJ5LCBqdXN0IHNraXAgaXQuDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcg
V3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
YyB8IDI3ICsrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMiBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IDA1MmViNzJh
Y2Y2OS4uMWU2ZTZkM2ZhN2YxIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTE5Niw2ICsxOTYsMTAgQEAg
c3RhdGljIHZvaWQgbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVuc2lnbmVkIGxvbmcg
aW92YSwgc2l6ZV90IHNpemUsDQogCXUzMiB0bXA7DQogDQogCWZvcl9lYWNoX200dShkYXRhKSB7
DQorCQkvKiBza2lwIHRsYiBmbHVzaCB3aGVuIHBtIGlzIG5vdCBhY3RpdmUuICovDQorCQlpZiAo
IXBtX3J1bnRpbWVfYWN0aXZlKGRhdGEtPmRldikpDQorCQkJY29udGludWU7DQorDQogCQlzcGlu
X2xvY2tfaXJxc2F2ZSgmZGF0YS0+dGxiX2xvY2ssIGZsYWdzKTsNCiAJCXdyaXRlbF9yZWxheGVk
KEZfSU5WTERfRU4xIHwgRl9JTlZMRF9FTjAsDQogCQkJICAgICAgIGRhdGEtPmJhc2UgKyBkYXRh
LT5wbGF0X2RhdGEtPmludl9zZWxfcmVnKTsNCkBAIC0zODAsNiArMzg0LDcgQEAgc3RhdGljIGlu
dCBtdGtfaW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQog
ew0KIAlzdHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2
KTsNCiAJc3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9tYWlu
KTsNCisJc3RydWN0IGRldmljZSAqbTR1ZGV2ID0gZGF0YS0+ZGV2Ow0KIAlpbnQgcmV0Ow0KIA0K
IAlpZiAoIWRhdGEpDQpAQCAtMzg3LDEyICszOTIsMTggQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
YXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQogDQogCS8qIFVwZGF0
ZSB0aGUgcGd0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhlIE00VSBIVyAqLw0KIAlp
ZiAoIWRhdGEtPm00dV9kb20pIHsNCisJCXJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMobTR1ZGV2
KTsNCisJCWlmIChyZXQgPCAwKQ0KKwkJCXJldHVybiByZXQ7DQogCQlyZXQgPSBtdGtfaW9tbXVf
aHdfaW5pdChkYXRhKTsNCi0JCWlmIChyZXQpDQorCQlpZiAocmV0KSB7DQorCQkJcG1fcnVudGlt
ZV9wdXQobTR1ZGV2KTsNCiAJCQlyZXR1cm4gcmV0Ow0KKwkJfQ0KIAkJZGF0YS0+bTR1X2RvbSA9
IGRvbTsNCiAJCXdyaXRlbChkb20tPmNmZy5hcm1fdjdzX2NmZy50dGJyICYgTU1VX1BUX0FERFJf
TUFTSywNCiAJCSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9QVF9CQVNFX0FERFIpOw0KKwkJ
cG1fcnVudGltZV9wdXQobTR1ZGV2KTsNCiAJfQ0KIA0KIAltdGtfaW9tbXVfY29uZmlnKGRhdGEs
IGRldiwgdHJ1ZSk7DQpAQCAtNzQyLDEwICs3NTMsMTMgQEAgc3RhdGljIGludCBtdGtfaW9tbXVf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYgKGRldi0+cG1fZG9tYWlu
KSB7DQogCQlzdHJ1Y3QgZGV2aWNlX2xpbmsgKmxpbms7DQogDQorCQlwbV9ydW50aW1lX2VuYWJs
ZShkZXYpOw0KKw0KIAkJbGluayA9IGRldmljZV9saW5rX2FkZChkYXRhLT5zbWljb21tX2Rldiwg
ZGV2LA0KIAkJCQkgICAgICAgRExfRkxBR19TVEFURUxFU1MgfCBETF9GTEFHX1BNX1JVTlRJTUUp
Ow0KIAkJaWYgKCFsaW5rKSB7DQogCQkJZGV2X2VycihkZXYsICJVbmFibGUgbGluayAlcy5cbiIs
IGRldl9uYW1lKGRhdGEtPnNtaWNvbW1fZGV2KSk7DQorCQkJcG1fcnVudGltZV9kaXNhYmxlKGRl
dik7DQogCQkJcmV0dXJuIC1FSU5WQUw7DQogCQl9DQogCX0NCkBAIC03NjMsOCArNzc3LDEwIEBA
IHN0YXRpYyBpbnQgbXRrX2lvbW11X3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KIAkJYnVzX3NldF9pb21tdSgmcGxhdGZvcm1fYnVzX3R5cGUsIE5VTEwpOw0KIA0KIAljbGtf
ZGlzYWJsZV91bnByZXBhcmUoZGF0YS0+YmNsayk7DQotCWlmIChwZGV2LT5kZXYucG1fZG9tYWlu
KQ0KKwlpZiAocGRldi0+ZGV2LnBtX2RvbWFpbikgew0KIAkJZGV2aWNlX2xpbmtfcmVtb3ZlKGRh
dGEtPnNtaWNvbW1fZGV2LCAmcGRldi0+ZGV2KTsNCisJCXBtX3J1bnRpbWVfZGlzYWJsZSgmcGRl
di0+ZGV2KTsNCisJfQ0KIAlkZXZtX2ZyZWVfaXJxKCZwZGV2LT5kZXYsIGRhdGEtPmlycSwgZGF0
YSk7DQogCWNvbXBvbmVudF9tYXN0ZXJfZGVsKCZwZGV2LT5kZXYsICZtdGtfaW9tbXVfY29tX29w
cyk7DQogCXJldHVybiAwOw0KQEAgLTc5Niw2ICs4MTIsOSBAQCBzdGF0aWMgaW50IF9fbWF5YmVf
dW51c2VkIG10a19pb21tdV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogCXZv
aWQgX19pb21lbSAqYmFzZSA9IGRhdGEtPmJhc2U7DQogCWludCByZXQ7DQogDQorCS8qIEF2b2lk
IGZpcnN0IHJlc3VtZSB0byBhZmZlY3QgdGhlIGRlZmF1bHQgdmFsdWUgb2YgcmVnaXN0ZXJzIGJl
bG93LiAqLw0KKwlpZiAoIW00dV9kb20pDQorCQlyZXR1cm4gMDsNCiAJcmV0ID0gY2xrX3ByZXBh
cmVfZW5hYmxlKGRhdGEtPmJjbGspOw0KIAlpZiAocmV0KSB7DQogCQlkZXZfZXJyKGRhdGEtPmRl
diwgIkZhaWxlZCB0byBlbmFibGUgY2xrKCVkKSBpbiByZXN1bWVcbiIsIHJldCk7DQpAQCAtODA5
LDkgKzgyOCw3IEBAIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3J1bnRpbWVf
cmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJd3JpdGVsX3JlbGF4ZWQocmVnLT5pbnRfbWFp
bl9jb250cm9sLCBiYXNlICsgUkVHX01NVV9JTlRfTUFJTl9DT05UUk9MKTsNCiAJd3JpdGVsX3Jl
bGF4ZWQocmVnLT5pdnJwX3BhZGRyLCBiYXNlICsgUkVHX01NVV9JVlJQX1BBRERSKTsNCiAJd3Jp
dGVsX3JlbGF4ZWQocmVnLT52bGRfcGFfcm5nLCBiYXNlICsgUkVHX01NVV9WTERfUEFfUk5HKTsN
Ci0JaWYgKG00dV9kb20pDQotCQl3cml0ZWwobTR1X2RvbS0+Y2ZnLmFybV92N3NfY2ZnLnR0YnIg
JiBNTVVfUFRfQUREUl9NQVNLLA0KLQkJICAgICAgIGJhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQURE
Uik7DQorCXdyaXRlbChtNHVfZG9tLT5jZmcuYXJtX3Y3c19jZmcudHRiciAmIE1NVV9QVF9BRERS
X01BU0ssIGJhc2UgKyBSRUdfTU1VX1BUX0JBU0VfQUREUik7DQogCXJldHVybiAwOw0KIH0NCiAN
Ci0tIA0KMi4xOC4wDQo=

