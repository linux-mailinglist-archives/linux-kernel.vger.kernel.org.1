Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26B227E228
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgI3HJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:09:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50449 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:09:31 -0400
X-UUID: 34d97fd2802e471f822ea5a8b28916c9-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=myVFj1U3iRi7Gh4AobiqyuhDtViW2dsfHPIq8FoB+qY=;
        b=s1ND6fHPuUAHBNJ7TWWWTgcC/uNG4z++f9eEclCuW3AnN17OZ4OdiNZW2hgrZlPwToCfsvqvc61kS9R5kkDuBwJcst9vqtXEoZLHiDxj85vKLjNnIYW/ImKADsKWS/qrMuGknqoflWzIXuFBbxVjcx4MUOGZYzlq8Hd16UrGWMI=;
X-UUID: 34d97fd2802e471f822ea5a8b28916c9-20200930
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 988168212; Wed, 30 Sep 2020 15:09:29 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:09:26 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:09:27 +0800
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
Subject: [PATCH v3 12/24] iommu/mediatek: Move hw_init into attach_device
Date:   Wed, 30 Sep 2020 15:06:35 +0800
Message-ID: <20200930070647.10188-13-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200930070647.10188-1-yong.wu@mediatek.com>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 657CBC01952634197C224649266BAA9905E3116E1A847803D6F3E2687991134B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gYXR0YWNoIGRldmljZSwgaXQgd2lsbCB1cGRhdGUgdGhlIHBhZ2V0YWJsZSBiYXNlIGFkZHJl
c3MgcmVnaXN0ZXIuDQpNb3ZlIHRoZSBod19pbml0IGZ1bmN0aW9uIGFsc28gaGVyZS4gVGhlbiBp
dCBvbmx5IG5lZWQgY2FsbA0KcG1fcnVudGltZV9nZXQvcHV0IG9uZSB0aW1lIGhlcmUgaWYgbTR1
IGhhcyBwb3dlciBkb21haW4uDQoNClNpZ25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVk
aWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8IDEwICsrKysrKy0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCmluZGV4IDZlODVjOTk3NmEzMy4uOTQwYjdhOTE5MWIyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysrIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUu
Yw0KQEAgLTEyMiw2ICsxMjIsOCBAQCBzdHJ1Y3QgbXRrX2lvbW11X2RvbWFpbiB7DQogDQogc3Rh
dGljIGNvbnN0IHN0cnVjdCBpb21tdV9vcHMgbXRrX2lvbW11X29wczsNCiANCitzdGF0aWMgaW50
IG10a19pb21tdV9od19pbml0KGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSk7DQor
DQogLyoNCiAgKiBJbiBNNFUgNEdCIG1vZGUsIHRoZSBwaHlzaWNhbCBhZGRyZXNzIGlzIHJlbWFw
cGVkIGFzIGJlbG93Og0KICAqDQpAQCAtMzc3LDEyICszNzksMTYgQEAgc3RhdGljIGludCBtdGtf
aW9tbXVfYXR0YWNoX2RldmljZShzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQogew0KIAlz
dHJ1Y3QgbXRrX2lvbW11X2RhdGEgKmRhdGEgPSBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsNCiAJ
c3RydWN0IG10a19pb21tdV9kb21haW4gKmRvbSA9IHRvX210a19kb21haW4oZG9tYWluKTsNCisJ
aW50IHJldDsNCiANCiAJaWYgKCFkYXRhKQ0KIAkJcmV0dXJuIC1FTk9ERVY7DQogDQogCS8qIFVw
ZGF0ZSB0aGUgcGd0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIgb2YgdGhlIE00VSBIVyAqLw0K
IAlpZiAoIWRhdGEtPm00dV9kb20pIHsNCisJCXJldCA9IG10a19pb21tdV9od19pbml0KGRhdGEp
Ow0KKwkJaWYgKHJldCkNCisJCQlyZXR1cm4gcmV0Ow0KIAkJZGF0YS0+bTR1X2RvbSA9IGRvbTsN
CiAJCXdyaXRlbChkb20tPmNmZy5hcm1fdjdzX2NmZy50dGJyICYgTU1VX1BUX0FERFJfTUFTSywN
CiAJCSAgICAgICBkYXRhLT5iYXNlICsgUkVHX01NVV9QVF9CQVNFX0FERFIpOw0KQEAgLTcwNSwx
MCArNzExLDYgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZGF0YSk7DQogDQot
CXJldCA9IG10a19pb21tdV9od19pbml0KGRhdGEpOw0KLQlpZiAocmV0KQ0KLQkJcmV0dXJuIHJl
dDsNCi0NCiAJcmV0ID0gaW9tbXVfZGV2aWNlX3N5c2ZzX2FkZCgmZGF0YS0+aW9tbXUsIGRldiwg
TlVMTCwNCiAJCQkJICAgICAibXRrLWlvbW11LiVwYSIsICZpb2FkZHIpOw0KIAlpZiAocmV0KQ0K
LS0gDQoyLjE4LjANCg==

