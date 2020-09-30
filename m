Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762A227E22F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgI3HJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:09:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50696 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:09:55 -0400
X-UUID: 5b2a7115b4464f6aaf4a0f2605758e6f-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MFAon3GhNDukKivbaCYhme9yuORluMflbyHTCeqY9+E=;
        b=kgmFvkEPNz0rb9jCSnONjuy0houoewZ5TwPWrVjQsp3Wy7dbErJZFEr/dmdYNvZCKzpvG2tWW/s7ElP9rjDe4soKlP3dOv3YxvifdB9ey5Kb3Pn4fmVoDbOxW/KZ55R5w6Mf+vaNT4cFxB2zPyDe554aYJl/WXr57E26Lrb61MU=;
X-UUID: 5b2a7115b4464f6aaf4a0f2605758e6f-20200930
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1759492625; Wed, 30 Sep 2020 15:09:52 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:09:50 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:09:50 +0800
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
Subject: [PATCH v3 14/24] iommu/mediatek: Add pm runtime callback
Date:   Wed, 30 Sep 2020 15:06:37 +0800
Message-ID: <20200930070647.10188-15-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIHBtIHJ1bnRpbWUgY2FsbGJhY2suDQoNCkluIHBtIHJ1bnRpbWUgY2Fz
ZSwgYWxsIHRoZSByZWdpc3RlcnMgYmFja3VwL3Jlc3RvcmUgYW5kIGJjbGsgYXJlDQpjb250cm9s
bGVkIGluIHRoZSBwbV9ydW50aW1lIGNhbGxiYWNrLCB0aGVuIHBtX3N1c3BlbmQgaXMgbm90IG5l
ZWRlZCBpbg0KdGhpcyBjYXNlLg0KDQpydW50aW1lIFBNIGlzIGRpc2FibGVkIHdoZW4gc3VzcGVu
ZCwgdGh1cyB3ZSBjYWxsDQpwbV9ydW50aW1lX3N0YXR1c19zdXNwZW5kZWQgaW5zdGVhZCBvZiBw
bV9ydW50aW1lX3N1c3BlbmRlZC4NCg0KQW5kLCBtNHUgZG9lc24ndCBoYXZlIGl0cyBzcGVjaWFs
IHBtIHJ1bnRpbWUgZG9tYWluIGluIHByZXZpb3VzIFNvQywgaW4NCnRoaXMgY2FzZSBkZXYtPnBv
d2VyLnJ1bnRpbWVfc3RhdHVzIGlzIFJQTV9TVVNQRU5ERUQgZGVmYXVsdGx5LCB0aHVzIGFkZA0K
YSAiZGV2LT5wbV9kb21haW4iIGNoZWNraW5nIGZvciB0aGUgU29DIHRoYXQgaGFzIHBtIHJ1bnRp
bWUgZG9tYWluLg0KDQpTaWduZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgfCAyMiArKysrKysrKysrKysrKysr
KysrKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuYw0KaW5kZXggNTYyNTQ1OGIyMWJhLi4wNTJlYjcyYWNmNjkgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQpAQCAtNzcwLDcgKzc3MCw3IEBAIHN0YXRpYyBpbnQgbXRrX2lvbW11X3JlbW92ZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlyZXR1cm4gMDsNCiB9DQogDQotc3RhdGlj
IGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYp
DQorc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcnVudGltZV9zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldikNCiB7DQogCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOw0KIAlzdHJ1Y3QgbXRrX2lvbW11X3N1c3BlbmRfcmVnICpyZWcg
PSAmZGF0YS0+cmVnOw0KQEAgLTc4OCw3ICs3ODgsNyBAQCBzdGF0aWMgaW50IF9fbWF5YmVfdW51
c2VkIG10a19pb21tdV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCiAJcmV0dXJuIDA7DQog
fQ0KIA0KLXN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgbXRrX2lvbW11X3Jlc3VtZShzdHJ1Y3Qg
ZGV2aWNlICpkZXYpDQorc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfcnVudGlt
ZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KIHsNCiAJc3RydWN0IG10a19pb21tdV9kYXRh
ICpkYXRhID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQogCXN0cnVjdCBtdGtfaW9tbXVfc3VzcGVu
ZF9yZWcgKnJlZyA9ICZkYXRhLT5yZWc7DQpAQCAtODE1LDcgKzgxNSwyNSBAQCBzdGF0aWMgaW50
IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KIAly
ZXR1cm4gMDsNCiB9DQogDQorc3RhdGljIGludCBfX21heWJlX3VudXNlZCBtdGtfaW9tbXVfc3Vz
cGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQorew0KKwkvKiBydW50aW1lIFBNIGlzIGRpc2FibGVk
IHdoZW4gc3VzcGVuZCBpbiBwbV9ydW50aW1lIGNhc2UuICovDQorCWlmIChkZXYtPnBtX2RvbWFp
biAmJiBwbV9ydW50aW1lX3N0YXR1c19zdXNwZW5kZWQoZGV2KSkNCisJCXJldHVybiAwOw0KKw0K
KwlyZXR1cm4gbXRrX2lvbW11X3J1bnRpbWVfc3VzcGVuZChkZXYpOw0KK30NCisNCitzdGF0aWMg
aW50IF9fbWF5YmVfdW51c2VkIG10a19pb21tdV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0K
K3sNCisJaWYgKGRldi0+cG1fZG9tYWluICYmIHBtX3J1bnRpbWVfc3RhdHVzX3N1c3BlbmRlZChk
ZXYpKQ0KKwkJcmV0dXJuIDA7DQorDQorCXJldHVybiBtdGtfaW9tbXVfcnVudGltZV9yZXN1bWUo
ZGV2KTsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIG10a19pb21tdV9w
bV9vcHMgPSB7DQorCVNFVF9SVU5USU1FX1BNX09QUyhtdGtfaW9tbXVfcnVudGltZV9zdXNwZW5k
LCBtdGtfaW9tbXVfcnVudGltZV9yZXN1bWUsIE5VTEwpDQogCVNFVF9OT0lSUV9TWVNURU1fU0xF
RVBfUE1fT1BTKG10a19pb21tdV9zdXNwZW5kLCBtdGtfaW9tbXVfcmVzdW1lKQ0KIH07DQogDQot
LSANCjIuMTguMA0K

