Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9CB27E216
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgI3HIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:08:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40323 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgI3HIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:08:39 -0400
X-UUID: 9a46722c16154dc7aabc9bccced87120-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RXxpydUhOiDH5psuccLuJjNdd894eEQ6qDkPc6eppHU=;
        b=TJnaMpUJpyHVQ4mN5eQMRtdTgoPRJBhmjgEFSTBGlJ3My9Ll9myz0GuvIi1EFbLwcSRRmKcloX2mSIfb3fnyzkoqwUcmd2rN5ozWwYwO8yvNTGsr48iI72b6CZmWXLCP+bf13coGhoKipmPfBPW2i+CpgKsiTuGZAopRU9b3qcY=;
X-UUID: 9a46722c16154dc7aabc9bccced87120-20200930
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 859056950; Wed, 30 Sep 2020 15:08:32 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 15:08:30 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 15:08:31 +0800
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
Subject: [PATCH v3 07/24] iommu/mediatek: Use the common mtk-smi-larb-port.h
Date:   Wed, 30 Sep 2020 15:06:30 +0800
Message-ID: <20200930070647.10188-8-yong.wu@mediatek.com>
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

VXNlIHRoZSBjb21tb24gbGFyYi1wb3J0IGhlYWRlciBpbiB0aGUgc291cmNlIGNvZGUuDQoNClNp
Z25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYyAgfCA3IC0tLS0tLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21t
dS5oICB8IDEgKw0KIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyAgIHwgMSArDQogaW5jbHVkZS9z
b2MvbWVkaWF0ZWsvc21pLmggfCAyIC0tDQogNCBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggNzg1YjIyOGQzOWE2Li5mZDgz
MjJlZTQ5ODAgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtMTAxLDEzICsxMDEsNiBAQA0KIA0KICNkZWZp
bmUgTVRLX1BST1RFQ1RfUEFfQUxJR04JCQkyNTYNCiANCi0vKg0KLSAqIEdldCB0aGUgbG9jYWwg
YXJiaXRlciBJRCBhbmQgdGhlIHBvcnRpZCB3aXRoaW4gdGhlIGxhcmIgYXJiaXRlcg0KLSAqIGZy
b20gbXRrX200dV9pZCB3aGljaCBpcyBkZWZpbmVkIGJ5IE1US19NNFVfSUQuDQotICovDQotI2Rl
ZmluZSBNVEtfTTRVX1RPX0xBUkIoaWQpCQkoKChpZCkgPj4gNSkgJiAweGYpDQotI2RlZmluZSBN
VEtfTTRVX1RPX1BPUlQoaWQpCQkoKGlkKSAmIDB4MWYpDQotDQogI2RlZmluZSBIQVNfNEdCX01P
REUJCQlCSVQoMCkNCiAvKiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0
IHRoZSAiYmNsayIuICovDQogI2RlZmluZSBIQVNfQkNMSwkJCUJJVCgxKQ0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpp
bmRleCAxMjI5MjVkYmU1NDcuLmEyZTJjODQ0Yjk2ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0xNyw2
ICsxNyw3IEBADQogI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+DQogI2luY2x1ZGUgPGxpbnV4
L2RtYS1tYXBwaW5nLmg+DQogI2luY2x1ZGUgPHNvYy9tZWRpYXRlay9zbWkuaD4NCisjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvbWVtb3J5L210ay1zbWktbGFyYi1wb3J0Lmg+DQogDQogI2RlZmluZSBN
VEtfTEFSQl9DT01fTUFYCTgNCiAjZGVmaW5lIE1US19MQVJCX1NVQkNPTV9NQVgJNA0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWku
Yw0KaW5kZXggYzIxMjYyNTAyNTgxLi5lYzgzZjFhYzQ4YjEgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21lbW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVtb3J5L210ay1zbWkuYw0KQEAgLTE0
LDYgKzE0LDcgQEANCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQogI2luY2x1
ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCiAjaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0K
KyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaD4NCiAjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvbWVtb3J5L210MjcwMS1sYXJiLXBvcnQuaD4NCiANCiAvKiBtdDgx
NzMgKi8NCmRpZmYgLS1naXQgYS9pbmNsdWRlL3NvYy9tZWRpYXRlay9zbWkuaCBiL2luY2x1ZGUv
c29jL21lZGlhdGVrL3NtaS5oDQppbmRleCA1YTM0Yjg3ZDg5ZTMuLjkzNzFiZjU3MmFiOCAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oDQorKysgYi9pbmNsdWRlL3NvYy9t
ZWRpYXRlay9zbWkuaA0KQEAgLTExLDggKzExLDYgQEANCiANCiAjaWZkZWYgQ09ORklHX01US19T
TUkNCiANCi0jZGVmaW5lIE1US19MQVJCX05SX01BWAkJMTYNCi0NCiAjZGVmaW5lIE1US19TTUlf
TU1VX0VOKHBvcnQpCUJJVChwb3J0KQ0KIA0KIHN0cnVjdCBtdGtfc21pX2xhcmJfaW9tbXUgew0K
LS0gDQoyLjE4LjANCg==

