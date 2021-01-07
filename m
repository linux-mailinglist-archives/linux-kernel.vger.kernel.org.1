Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A90C2ED2E9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbhAGOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:40:15 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:19472 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728471AbhAGOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:40:14 -0500
X-UUID: a23034cb734a4bfdb76265a66aa04d02-20210107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3yme2n6hj99TgRI5yAnQj8gNXTYS1bdd9oJBVcgH2/E=;
        b=fjIQfgMu01NdzkfT99zAdbrEbwGBBSDGhiN5HMadNQOZsJmG08JL9KlQUbj6JQqtMFvuTMvkpUdg8D6obZfzRCVC9yBaemCixqn3jP2APusUFSFUB3MMFCrTWIBNL2HVmSbTW3Hkt/PJeKVdIqhtRE8a7uNedIs+nNqS8SqssaE=;
X-UUID: a23034cb734a4bfdb76265a66aa04d02-20210107
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1817510195; Thu, 07 Jan 2021 22:33:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 Jan
 2021 22:33:56 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 7 Jan 2021 22:33:55 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH] drm/mediatek: dsi: Fix EoTp flag
Date:   Thu, 7 Jan 2021 22:33:52 +0800
Message-ID: <20210107143352.50090-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A377759D8A87949403261110186934E8B2642D92B1452A4748E1BCD43F073B582000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29DIHdpbGwgdHJhbnNtaXQgdGhlIEVvVHAgKEVuZCBvZiBUcmFuc21pc3Npb24gcGFja2V0KSB3
aGVuDQpNSVBJX0RTSV9NT0RFX0VPVF9QQUNLRVQgZmxhZyBpcyBzZXQuDQoNCkVuYWJsaW5nIEVv
VHAgd2lsbCBtYWtlIHRoZSBsaW5lIHRpbWUgbGFyZ2VyLCBzbyB0aGUgaGZwIGFuZA0KaGJwIHNo
b3VsZCBiZSByZWR1Y2VkIHRvIGtlZXAgbGluZSB0aW1lLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RzaS5jIHwgOCArKysrKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RzaS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KaW5k
ZXggNjVmZDk5YzUyOGFmLi44YzcwZWMzOWJmZTEgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RzaS5jDQpAQCAtNDAxLDggKzQwMSwxMSBAQCBzdGF0aWMgdm9pZCBtdGtfZHNpX3J4dHhfY29u
dHJvbChzdHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KIAkJYnJlYWs7DQogCX0NCiANCi0JdG1wX3JlZyB8
PSAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfQ0xPQ0tfTk9OX0NPTlRJTlVPVVMpIDw8IDY7
DQotCXRtcF9yZWcgfD0gKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX01PREVfRU9UX1BBQ0tF
VCkgPj4gMzsNCisJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX0NMT0NLX05PTl9DT05U
SU5VT1VTKQ0KKwkJdG1wX3JlZyB8PSBIU1RYX0NLTFBfRU47DQorDQorCWlmICghKGRzaS0+bW9k
ZV9mbGFncyAmIE1JUElfRFNJX01PREVfRU9UX1BBQ0tFVCkpDQorCQl0bXBfcmVnIHw9IERJU19F
T1Q7DQogDQogCXdyaXRlbCh0bXBfcmVnLCBkc2ktPnJlZ3MgKyBEU0lfVFhSWF9DVFJMKTsNCiB9
DQpAQCAtNDc4LDYgKzQ4MSw3IEBAIHN0YXRpYyB2b2lkIG10a19kc2lfY29uZmlnX3Zkb190aW1p
bmcoc3RydWN0IG10a19kc2kgKmRzaSkNCiAJCQkgIHRpbWluZy0+ZGFfaHNfemVybyArIHRpbWlu
Zy0+ZGFfaHNfZXhpdCArIDM7DQogDQogCWRlbHRhID0gZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9E
U0lfTU9ERV9WSURFT19CVVJTVCA/IDE4IDogMTI7DQorCWRlbHRhICs9IGRzaS0+bW9kZV9mbGFn
cyAmIE1JUElfRFNJX01PREVfRU9UX1BBQ0tFVCA/IDIgOiAwOw0KIA0KIAlob3Jpem9udGFsX2Zy
b250cG9yY2hfYnl0ZSA9IHZtLT5oZnJvbnRfcG9yY2ggKiBkc2lfdG1wX2J1Zl9icHA7DQogCWhv
cml6b250YWxfZnJvbnRfYmFja19ieXRlID0gaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgKyBo
b3Jpem9udGFsX2JhY2twb3JjaF9ieXRlOw0KLS0gDQoyLjI1LjENCg==

