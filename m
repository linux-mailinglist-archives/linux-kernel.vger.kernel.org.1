Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B621C2AE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 08:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgGKGue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jul 2020 02:50:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54376 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgGKGud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 02:50:33 -0400
X-UUID: dadc81a768eb404dacf7362a53fb9cf9-20200711
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3FCHXsk0v/+mx639lcY+QeeKZChMx1+mN+luSHVlepA=;
        b=J+PRaUn6Y7xNMn9jaUTf8uImTnbMtVjn2ad4urjTyLAa2277MLJZWxaQHH6xZj/VAk20CRaCC8DvGEjzZ0rGEOz77A9PMZsJhbKg/0x/55trDQMc9L//ZQzs0hhiy4wN7XbajNdJKgLOCSAqOjCtAobhRoRlv1gCgXf/lvV/9y8=;
X-UUID: dadc81a768eb404dacf7362a53fb9cf9-20200711
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 801109024; Sat, 11 Jul 2020 14:50:30 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Jul 2020 14:50:27 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jul 2020 14:50:26 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will@kernel.org>, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <cui.zhang@mediatek.com>,
        <chao.hao@mediatek.com>, <ming-fan.chen@mediatek.com>
Subject: [PATCH 05/21] iommu/mediatek: Use the common mtk-smi-larb-port.h
Date:   Sat, 11 Jul 2020 14:48:30 +0800
Message-ID: <20200711064846.16007-6-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200711064846.16007-1-yong.wu@mediatek.com>
References: <20200711064846.16007-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHRoZSBjb21tb24gbGFyYi1wb3J0IGhlYWRlciBpbiB0aGUgc291cmNlIGNvZGUuDQoNClNp
Z25lZC1vZmYtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXUuYyAgfCA3IC0tLS0tLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21t
dS5oICB8IDEgKw0KIGRyaXZlcnMvbWVtb3J5L210ay1zbWkuYyAgIHwgMSArDQogaW5jbHVkZS9z
b2MvbWVkaWF0ZWsvc21pLmggfCAyIC0tDQogNCBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KaW5kZXggNTllNWE2MmEzNGRiLi5hOGQ4
YTg3NGEyMDkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdS5jDQpAQCAtMTAxLDEzICsxMDEsNiBAQA0KIA0KICNkZWZp
bmUgTVRLX1BST1RFQ1RfUEFfQUxJR04JCQkyNTYNCiANCi0vKg0KLSAqIEdldCB0aGUgbG9jYWwg
YXJiaXRlciBJRCBhbmQgdGhlIHBvcnRpZCB3aXRoaW4gdGhlIGxhcmIgYXJiaXRlcg0KLSAqIGZy
b20gbXRrX200dV9pZCB3aGljaCBpcyBkZWZpbmVkIGJ5IE1US19NNFVfSUQuDQotICovDQotI2Rl
ZmluZSBNVEtfTTRVX1RPX0xBUkIoaWQpCQkoKChpZCkgPj4gNSkgJiAweGYpDQotI2RlZmluZSBN
VEtfTTRVX1RPX1BPUlQoaWQpCQkoKGlkKSAmIDB4MWYpDQotDQogI2RlZmluZSBIQVNfNEdCX01P
REUJCQlCSVQoMCkNCiAvKiBIVyB3aWxsIHVzZSB0aGUgRU1JIGNsb2NrIGlmIHRoZXJlIGlzbid0
IHRoZSAiYmNsayIuICovDQogI2RlZmluZSBIQVNfQkNMSwkJCUJJVCgxKQ0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmggYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5oDQpp
bmRleCAyMTQ4OTg1NzgwMjYuLjFhMDg3YWY1MGE0ZSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCisrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCkBAIC0xNiw2
ICsxNiw3IEBADQogI2luY2x1ZGUgPGxpbnV4L2xpc3QuaD4NCiAjaW5jbHVkZSA8bGludXgvc3Bp
bmxvY2suaD4NCiAjaW5jbHVkZSA8c29jL21lZGlhdGVrL3NtaS5oPg0KKyNpbmNsdWRlIDxkdC1i
aW5kaW5ncy9tZW1vcnkvbXRrLXNtaS1sYXJiLXBvcnQuaD4NCiANCiAjZGVmaW5lIE1US19MQVJC
X0NPTV9NQVgJOA0KICNkZWZpbmUgTVRLX0xBUkJfU1VCQ09NX01BWAk0DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQppbmRl
eCBhMTEzZTgxMWZhYWIuLmY2NTE2OTIxMjg3ZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWVtb3J5
L210ay1zbWkuYw0KKysrIGIvZHJpdmVycy9tZW1vcnkvbXRrLXNtaS5jDQpAQCAtMTQsNiArMTQs
NyBAQA0KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGlu
dXgvcG1fcnVudGltZS5oPg0KICNpbmNsdWRlIDxzb2MvbWVkaWF0ZWsvc21pLmg+DQorI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL21lbW9yeS9tdGstc21pLWxhcmItcG9ydC5oPg0KICNpbmNsdWRlIDxk
dC1iaW5kaW5ncy9tZW1vcnkvbXQyNzAxLWxhcmItcG9ydC5oPg0KIA0KIC8qIG10ODE3MyAqLw0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvc29jL21lZGlhdGVrL3NtaS5oIGIvaW5jbHVkZS9zb2MvbWVk
aWF0ZWsvc21pLmgNCmluZGV4IDVhMzRiODdkODllMy4uOTM3MWJmNTcyYWI4IDEwMDY0NA0KLS0t
IGEvaW5jbHVkZS9zb2MvbWVkaWF0ZWsvc21pLmgNCisrKyBiL2luY2x1ZGUvc29jL21lZGlhdGVr
L3NtaS5oDQpAQCAtMTEsOCArMTEsNiBAQA0KIA0KICNpZmRlZiBDT05GSUdfTVRLX1NNSQ0KIA0K
LSNkZWZpbmUgTVRLX0xBUkJfTlJfTUFYCQkxNg0KLQ0KICNkZWZpbmUgTVRLX1NNSV9NTVVfRU4o
cG9ydCkJQklUKHBvcnQpDQogDQogc3RydWN0IG10a19zbWlfbGFyYl9pb21tdSB7DQotLSANCjIu
MTguMA0K

