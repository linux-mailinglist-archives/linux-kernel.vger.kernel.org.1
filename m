Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E29628CB67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 12:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgJMKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 06:06:44 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:19489 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727894AbgJMKGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 06:06:43 -0400
X-UUID: c6152e5b48e4459aa240ee66ed384361-20201013
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=IdZVCR93POltzpR5uqVn2DxtLqlhGyIYZmIkhZH+wys=;
        b=H1r5m/r/lLfBOOOXwYwTKx7JKRArPDoiyn6Qp+urvT08Q/7YoGxMVsbNVg0Mnv3raU6JjWQ0ccOzB94FDnxUd6X8lvSRXhXh8B49xmBPXpcble53CzRwZhUVt5D0ppon2eIPAxkK21TEaO37NrJl6J97iHaV/g7UoEpxo8grxbE=;
X-UUID: c6152e5b48e4459aa240ee66ed384361-20201013
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1930931102; Tue, 13 Oct 2020 18:06:31 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 13 Oct
 2020 18:06:29 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 13 Oct 2020 18:06:28 +0800
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
Subject: [PATCH v5 1/1] drm/mediatek: dsi: fix scrolling of panel with small hfp or hbp
Date:   Tue, 13 Oct 2020 18:06:25 +0800
Message-ID: <20201013100625.13056-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20201013100625.13056-1-jitao.shi@mediatek.com>
References: <20201013100625.13056-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 011E660719FE93D9230AC69411231753C59D8B81CDE7FE0ED9AB557A7C9E98D52000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVwbGFjZSBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlIHdpdGggdm0tPmhiYWNrX3BvcmNoICog
YnBwIHRvIGFvdmlkDQpmbG93aW5nIGp1ZGdlbWVudCBuZWdhdGl2ZSBudW1iZXIuDQoNCmlmICgo
dm0tPmhmcm9udF9wb3JjaCAqIGRzaV90bXBfYnVmX2JwcCArIGhvcml6b250YWxfYmFja3BvcmNo
X2J5dGUpID4NCglkYXRhX3BoeV9jeWNsZXMgKiBkc2ktPmxhbmVzICsgZGVsdGEpDQoNClNpZ25l
ZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCA2NSArKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCA0MCBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQppbmRleCA4MGI3YTA4
MmU4NzQuLmRkZGRmNjllYmVhZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHNpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCkBA
IC00NDUsNiArNDQ1LDcgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9jb25maWdfdmRvX3RpbWluZyhz
dHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KIAl1MzIgaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZTsNCiAJ
dTMyIGhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlOw0KIAl1MzIgZHNpX3RtcF9idWZfYnBwLCBk
YXRhX3BoeV9jeWNsZXM7DQorCXUzMiBkZWx0YTsNCiAJc3RydWN0IG10a19waHlfdGltaW5nICp0
aW1pbmcgPSAmZHNpLT5waHlfdGltaW5nOw0KIA0KIAlzdHJ1Y3QgdmlkZW9tb2RlICp2bSA9ICZk
c2ktPnZtOw0KQEAgLTQ2Niw1MCArNDY3LDM0IEBAIHN0YXRpYyB2b2lkIG10a19kc2lfY29uZmln
X3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRzaSkNCiAJaG9yaXpvbnRhbF9zeW5jX2FjdGl2
ZV9ieXRlID0gKHZtLT5oc3luY19sZW4gKiBkc2lfdG1wX2J1Zl9icHAgLSAxMCk7DQogDQogCWlm
IChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RFX1ZJREVPX1NZTkNfUFVMU0UpDQotCQlo
b3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0gdm0tPmhiYWNrX3BvcmNoICogZHNpX3RtcF9idWZf
YnBwOw0KKwkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9DQorCQkJKHZtLT5oYmFja19wb3Jj
aCAqIGRzaV90bXBfYnVmX2JwcCAtIDEwKTsNCiAJZWxzZQ0KLQkJaG9yaXpvbnRhbF9iYWNrcG9y
Y2hfYnl0ZSA9ICh2bS0+aGJhY2tfcG9yY2ggKyB2bS0+aHN5bmNfbGVuKSAqDQotCQkJCQkgICAg
ZHNpX3RtcF9idWZfYnBwOw0KKwkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9ICgodm0tPmhi
YWNrX3BvcmNoICsgdm0tPmhzeW5jX2xlbikgKg0KKwkJCWRzaV90bXBfYnVmX2JwcCAtIDEwKTsN
CiANCiAJZGF0YV9waHlfY3ljbGVzID0gdGltaW5nLT5scHggKyB0aW1pbmctPmRhX2hzX3ByZXBh
cmUgKw0KLQkJCSAgdGltaW5nLT5kYV9oc196ZXJvICsgdGltaW5nLT5kYV9oc19leGl0Ow0KLQ0K
LQlpZiAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9WSURFT19CVVJTVCkgew0KLQkJ
aWYgKCh2bS0+aGZyb250X3BvcmNoICsgdm0tPmhiYWNrX3BvcmNoKSAqIGRzaV90bXBfYnVmX2Jw
cCA+DQotCQkgICAgZGF0YV9waHlfY3ljbGVzICogZHNpLT5sYW5lcyArIDE4KSB7DQotCQkJaG9y
aXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPQ0KLQkJCQl2bS0+aGZyb250X3BvcmNoICogZHNpX3Rt
cF9idWZfYnBwIC0NCi0JCQkJKGRhdGFfcGh5X2N5Y2xlcyAqIGRzaS0+bGFuZXMgKyAxOCkgKg0K
LQkJCQl2bS0+aGZyb250X3BvcmNoIC8NCi0JCQkJKHZtLT5oZnJvbnRfcG9yY2ggKyB2bS0+aGJh
Y2tfcG9yY2gpOw0KLQ0KLQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgPQ0KLQkJCQlob3Jp
em9udGFsX2JhY2twb3JjaF9ieXRlIC0NCi0JCQkJKGRhdGFfcGh5X2N5Y2xlcyAqIGRzaS0+bGFu
ZXMgKyAxOCkgKg0KLQkJCQl2bS0+aGJhY2tfcG9yY2ggLw0KLQkJCQkodm0tPmhmcm9udF9wb3Jj
aCArIHZtLT5oYmFja19wb3JjaCk7DQotCQl9IGVsc2Ugew0KLQkJCURSTV9XQVJOKCJIRlAgbGVz
cyB0aGFuIGQtcGh5LCBGUFMgd2lsbCB1bmRlciA2MEh6XG4iKTsNCi0JCQlob3Jpem9udGFsX2Zy
b250cG9yY2hfYnl0ZSA9IHZtLT5oZnJvbnRfcG9yY2ggKg0KLQkJCQkJCSAgICAgZHNpX3RtcF9i
dWZfYnBwOw0KLQkJfQ0KKwkJCSAgdGltaW5nLT5kYV9oc196ZXJvICsgdGltaW5nLT5kYV9oc19l
eGl0ICsgMzsNCisNCisJZGVsdGEgPSAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9W
SURFT19CVVJTVCkgPyAxOCA6IDEyOw0KKw0KKwlpZiAoKHZtLT5oZnJvbnRfcG9yY2ggKiBkc2lf
dG1wX2J1Zl9icHAgKyBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlKSA+DQorCSAgICBkYXRhX3Bo
eV9jeWNsZXMgKiBkc2ktPmxhbmVzICsgZGVsdGEpIHsNCisJCWhvcml6b250YWxfZnJvbnRwb3Jj
aF9ieXRlID0NCisJCQl2bS0+aGZyb250X3BvcmNoICogZHNpX3RtcF9idWZfYnBwIC0NCisJCQko
ZGF0YV9waHlfY3ljbGVzICogZHNpLT5sYW5lcyArIGRlbHRhKSAqDQorCQkJdm0tPmhmcm9udF9w
b3JjaCAvDQorCQkJKHZtLT5oZnJvbnRfcG9yY2ggKyB2bS0+aGJhY2tfcG9yY2gpOw0KKw0KKwkJ
aG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9DQorCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0
ZSAtDQorCQkJKGRhdGFfcGh5X2N5Y2xlcyAqIGRzaS0+bGFuZXMgKyBkZWx0YSkgKg0KKwkJCXZt
LT5oYmFja19wb3JjaCAvDQorCQkJKHZtLT5oZnJvbnRfcG9yY2ggKyB2bS0+aGJhY2tfcG9yY2gp
Ow0KIAl9IGVsc2Ugew0KLQkJaWYgKCh2bS0+aGZyb250X3BvcmNoICsgdm0tPmhiYWNrX3BvcmNo
KSAqIGRzaV90bXBfYnVmX2JwcCA+DQotCQkgICAgZGF0YV9waHlfY3ljbGVzICogZHNpLT5sYW5l
cyArIDEyKSB7DQotCQkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPQ0KLQkJCQl2bS0+aGZy
b250X3BvcmNoICogZHNpX3RtcF9idWZfYnBwIC0NCi0JCQkJKGRhdGFfcGh5X2N5Y2xlcyAqIGRz
aS0+bGFuZXMgKyAxMikgKg0KLQkJCQl2bS0+aGZyb250X3BvcmNoIC8NCi0JCQkJKHZtLT5oZnJv
bnRfcG9yY2ggKyB2bS0+aGJhY2tfcG9yY2gpOw0KLQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5
dGUgPSBob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlIC0NCi0JCQkJKGRhdGFfcGh5X2N5Y2xlcyAq
IGRzaS0+bGFuZXMgKyAxMikgKg0KLQkJCQl2bS0+aGJhY2tfcG9yY2ggLw0KLQkJCQkodm0tPmhm
cm9udF9wb3JjaCArIHZtLT5oYmFja19wb3JjaCk7DQotCQl9IGVsc2Ugew0KLQkJCURSTV9XQVJO
KCJIRlAgbGVzcyB0aGFuIGQtcGh5LCBGUFMgd2lsbCB1bmRlciA2MEh6XG4iKTsNCi0JCQlob3Jp
em9udGFsX2Zyb250cG9yY2hfYnl0ZSA9IHZtLT5oZnJvbnRfcG9yY2ggKg0KLQkJCQkJCSAgICAg
ZHNpX3RtcF9idWZfYnBwOw0KLQkJfQ0KKwkJRFJNX1dBUk4oIkhGUCArIEhCUCBsZXNzIHRoYW4g
ZC1waHksIEZQUyB3aWxsIHVuZGVyIDYwSHpcbiIpOw0KKwkJaG9yaXpvbnRhbF9mcm9udHBvcmNo
X2J5dGUgPSB2bS0+aGZyb250X3BvcmNoICoNCisJCQkJCSAgICAgZHNpX3RtcF9idWZfYnBwOw0K
IAl9DQogDQogCXdyaXRlbChob3Jpem9udGFsX3N5bmNfYWN0aXZlX2J5dGUsIGRzaS0+cmVncyAr
IERTSV9IU0FfV0MpOw0KLS0gDQoyLjEyLjUNCg==

