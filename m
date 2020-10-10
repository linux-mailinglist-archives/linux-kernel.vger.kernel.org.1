Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623D6289EDB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgJJHMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:12:46 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:10556 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728830AbgJJHKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:10:42 -0400
X-UUID: be51c0eb26c74c33b6c538643c42a687-20201010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3c+peDytuMhcMrnaVbpiJTnq5XNIuqy9R+l3Dgk+J4U=;
        b=Gm4zgfXxFhNizyNC4vVp6jwO8gG3A5K1yJGNZR74vDNZvfs8zJeBQRJNfQe+75TQfQXaM3G0r+gT4T5bsYjPEHkfZHedxuP3V4tcsYWLCCUEWDJBkT6UFuWcnD0ANFDyBnQD+4CH1KMfJH68y0NsaUu2ZfxNmLr9DLD/p4sYtMw=;
X-UUID: be51c0eb26c74c33b6c538643c42a687-20201010
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1838404442; Sat, 10 Oct 2020 15:09:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33DR.mediatek.inc
 (172.27.6.106) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 10 Oct
 2020 15:09:44 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 10 Oct 2020 15:09:43 +0800
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
Subject: [PATCH v4 2/2] drm/mediatek: dsi: fix scrolling of panel with small hfp or hbp
Date:   Sat, 10 Oct 2020 15:09:10 +0800
Message-ID: <20201010070910.11294-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20201010070910.11294-1-jitao.shi@mediatek.com>
References: <20201010070910.11294-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DC60833837F2BB69EF66A753E4BD999F68F802725005CBDCA72B1B764C29BB0F2000:8
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
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCA1NCArKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAzNSBk
ZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
ZHNpLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQppbmRleCAxNmZkOTlk
Y2RhY2YuLmRkZGRmNjllYmVhZiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHNpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCkBA
IC00NDUsNiArNDQ1LDcgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9jb25maWdfdmRvX3RpbWluZyhz
dHJ1Y3QgbXRrX2RzaSAqZHNpKQ0KIAl1MzIgaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZTsNCiAJ
dTMyIGhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlOw0KIAl1MzIgZHNpX3RtcF9idWZfYnBwLCBk
YXRhX3BoeV9jeWNsZXM7DQorCXUzMiBkZWx0YTsNCiAJc3RydWN0IG10a19waHlfdGltaW5nICp0
aW1pbmcgPSAmZHNpLT5waHlfdGltaW5nOw0KIA0KIAlzdHJ1Y3QgdmlkZW9tb2RlICp2bSA9ICZk
c2ktPnZtOw0KQEAgLTQ3NSw0MiArNDc2LDI1IEBAIHN0YXRpYyB2b2lkIG10a19kc2lfY29uZmln
X3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRzaSkNCiAJZGF0YV9waHlfY3ljbGVzID0gdGlt
aW5nLT5scHggKyB0aW1pbmctPmRhX2hzX3ByZXBhcmUgKw0KIAkJCSAgdGltaW5nLT5kYV9oc196
ZXJvICsgdGltaW5nLT5kYV9oc19leGl0ICsgMzsNCiANCi0JaWYgKGRzaS0+bW9kZV9mbGFncyAm
IE1JUElfRFNJX01PREVfVklERU9fQlVSU1QpIHsNCi0JCWlmICgodm0tPmhmcm9udF9wb3JjaCAr
IHZtLT5oYmFja19wb3JjaCkgKiBkc2lfdG1wX2J1Zl9icHAgPg0KLQkJICAgIGRhdGFfcGh5X2N5
Y2xlcyAqIGRzaS0+bGFuZXMgKyAxOCkgew0KLQkJCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRl
ID0NCi0JCQkJdm0tPmhmcm9udF9wb3JjaCAqIGRzaV90bXBfYnVmX2JwcCAtDQotCQkJCShkYXRh
X3BoeV9jeWNsZXMgKiBkc2ktPmxhbmVzICsgMTgpICoNCi0JCQkJdm0tPmhmcm9udF9wb3JjaCAv
DQotCQkJCSh2bS0+aGZyb250X3BvcmNoICsgdm0tPmhiYWNrX3BvcmNoKTsNCi0NCi0JCQlob3Jp
em9udGFsX2JhY2twb3JjaF9ieXRlID0NCi0JCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSAt
DQotCQkJCShkYXRhX3BoeV9jeWNsZXMgKiBkc2ktPmxhbmVzICsgMTgpICoNCi0JCQkJdm0tPmhi
YWNrX3BvcmNoIC8NCi0JCQkJKHZtLT5oZnJvbnRfcG9yY2ggKyB2bS0+aGJhY2tfcG9yY2gpOw0K
LQkJfSBlbHNlIHsNCi0JCQlEUk1fV0FSTigiSEZQIGxlc3MgdGhhbiBkLXBoeSwgRlBTIHdpbGwg
dW5kZXIgNjBIelxuIik7DQotCQkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPSB2bS0+aGZy
b250X3BvcmNoICoNCi0JCQkJCQkgICAgIGRzaV90bXBfYnVmX2JwcDsNCi0JCX0NCisJZGVsdGEg
PSAoZHNpLT5tb2RlX2ZsYWdzICYgTUlQSV9EU0lfTU9ERV9WSURFT19CVVJTVCkgPyAxOCA6IDEy
Ow0KKw0KKwlpZiAoKHZtLT5oZnJvbnRfcG9yY2ggKiBkc2lfdG1wX2J1Zl9icHAgKyBob3Jpem9u
dGFsX2JhY2twb3JjaF9ieXRlKSA+DQorCSAgICBkYXRhX3BoeV9jeWNsZXMgKiBkc2ktPmxhbmVz
ICsgZGVsdGEpIHsNCisJCWhvcml6b250YWxfZnJvbnRwb3JjaF9ieXRlID0NCisJCQl2bS0+aGZy
b250X3BvcmNoICogZHNpX3RtcF9idWZfYnBwIC0NCisJCQkoZGF0YV9waHlfY3ljbGVzICogZHNp
LT5sYW5lcyArIGRlbHRhKSAqDQorCQkJdm0tPmhmcm9udF9wb3JjaCAvDQorCQkJKHZtLT5oZnJv
bnRfcG9yY2ggKyB2bS0+aGJhY2tfcG9yY2gpOw0KKw0KKwkJaG9yaXpvbnRhbF9iYWNrcG9yY2hf
Ynl0ZSA9DQorCQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSAtDQorCQkJKGRhdGFfcGh5X2N5
Y2xlcyAqIGRzaS0+bGFuZXMgKyBkZWx0YSkgKg0KKwkJCXZtLT5oYmFja19wb3JjaCAvDQorCQkJ
KHZtLT5oZnJvbnRfcG9yY2ggKyB2bS0+aGJhY2tfcG9yY2gpOw0KIAl9IGVsc2Ugew0KLQkJaWYg
KCh2bS0+aGZyb250X3BvcmNoICsgdm0tPmhiYWNrX3BvcmNoKSAqIGRzaV90bXBfYnVmX2JwcCA+
DQotCQkgICAgZGF0YV9waHlfY3ljbGVzICogZHNpLT5sYW5lcyArIDEyKSB7DQotCQkJaG9yaXpv
bnRhbF9mcm9udHBvcmNoX2J5dGUgPQ0KLQkJCQl2bS0+aGZyb250X3BvcmNoICogZHNpX3RtcF9i
dWZfYnBwIC0NCi0JCQkJKGRhdGFfcGh5X2N5Y2xlcyAqIGRzaS0+bGFuZXMgKyAxMikgKg0KLQkJ
CQl2bS0+aGZyb250X3BvcmNoIC8NCi0JCQkJKHZtLT5oZnJvbnRfcG9yY2ggKyB2bS0+aGJhY2tf
cG9yY2gpOw0KLQkJCWhvcml6b250YWxfYmFja3BvcmNoX2J5dGUgPSBob3Jpem9udGFsX2JhY2tw
b3JjaF9ieXRlIC0NCi0JCQkJKGRhdGFfcGh5X2N5Y2xlcyAqIGRzaS0+bGFuZXMgKyAxMikgKg0K
LQkJCQl2bS0+aGJhY2tfcG9yY2ggLw0KLQkJCQkodm0tPmhmcm9udF9wb3JjaCArIHZtLT5oYmFj
a19wb3JjaCk7DQotCQl9IGVsc2Ugew0KLQkJCURSTV9XQVJOKCJIRlAgbGVzcyB0aGFuIGQtcGh5
LCBGUFMgd2lsbCB1bmRlciA2MEh6XG4iKTsNCi0JCQlob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0
ZSA9IHZtLT5oZnJvbnRfcG9yY2ggKg0KLQkJCQkJCSAgICAgZHNpX3RtcF9idWZfYnBwOw0KLQkJ
fQ0KKwkJRFJNX1dBUk4oIkhGUCArIEhCUCBsZXNzIHRoYW4gZC1waHksIEZQUyB3aWxsIHVuZGVy
IDYwSHpcbiIpOw0KKwkJaG9yaXpvbnRhbF9mcm9udHBvcmNoX2J5dGUgPSB2bS0+aGZyb250X3Bv
cmNoICoNCisJCQkJCSAgICAgZHNpX3RtcF9idWZfYnBwOw0KIAl9DQogDQogCXdyaXRlbChob3Jp
em9udGFsX3N5bmNfYWN0aXZlX2J5dGUsIGRzaS0+cmVncyArIERTSV9IU0FfV0MpOw0KLS0gDQoy
LjEyLjUNCg==

