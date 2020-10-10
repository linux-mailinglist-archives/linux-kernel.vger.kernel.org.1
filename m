Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6613D289ED9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgJJHK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:10:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:21642 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728774AbgJJHJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:09:38 -0400
X-UUID: 9160f69c0f684fdba5d4d3874d373313-20201010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=C40D6kRIOspyGH+GAWZ9vtsBg6ZMKOSD3x901/6t9jo=;
        b=TgSGsnWlmLqe0iE2C6nOdongJJnb9lFTNJ/KJcDQzRctsYDayJwthbeQ2GjmKixX4wyGplgyHV1loLqLJNNwMF2hrlNb7PMkcBL9fcJku5ekbcE7t74skiRigKB9wdFtR3u8hFQzUBxxGZUax+Qojtil+jHnp3sL5HZixXN2Prc=;
X-UUID: 9160f69c0f684fdba5d4d3874d373313-20201010
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 705913086; Sat, 10 Oct 2020 15:09:26 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 10 Oct
 2020 15:09:24 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 10 Oct 2020 15:09:23 +0800
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
Subject: [PATCH v4 1/2] Revert "drm/mediatek: dsi: Fix scrolling of panel with small hfp or hbp"
Date:   Sat, 10 Oct 2020 15:09:09 +0800
Message-ID: <20201010070910.11294-2-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20201010070910.11294-1-jitao.shi@mediatek.com>
References: <20201010070910.11294-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D3BCC83A951E0A6A156273699799267B9A5C30B1482818190BB8C88026108A0A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyByZXZlcnRzIGNvbW1pdCAzNWJmOTQ4ZjFlZGJmNTA3ZjZlNTdlMDg3OWZhNmVhMzZkMmQy
OTMwLg0KDQpTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+
DQotLS0NCiBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIHwgOSArKysrKy0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCmluZGV4IDgwYjdhMDgyZTg3NC4uMTZmZDk5ZGNkYWNm
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KKysrIGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYw0KQEAgLTQ2NiwxMyArNDY2LDE0IEBA
IHN0YXRpYyB2b2lkIG10a19kc2lfY29uZmlnX3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRz
aSkNCiAJaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlID0gKHZtLT5oc3luY19sZW4gKiBkc2lf
dG1wX2J1Zl9icHAgLSAxMCk7DQogDQogCWlmIChkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9N
T0RFX1ZJREVPX1NZTkNfUFVMU0UpDQotCQlob3Jpem9udGFsX2JhY2twb3JjaF9ieXRlID0gdm0t
PmhiYWNrX3BvcmNoICogZHNpX3RtcF9idWZfYnBwOw0KKwkJaG9yaXpvbnRhbF9iYWNrcG9yY2hf
Ynl0ZSA9DQorCQkJKHZtLT5oYmFja19wb3JjaCAqIGRzaV90bXBfYnVmX2JwcCAtIDEwKTsNCiAJ
ZWxzZQ0KLQkJaG9yaXpvbnRhbF9iYWNrcG9yY2hfYnl0ZSA9ICh2bS0+aGJhY2tfcG9yY2ggKyB2
bS0+aHN5bmNfbGVuKSAqDQotCQkJCQkgICAgZHNpX3RtcF9idWZfYnBwOw0KKwkJaG9yaXpvbnRh
bF9iYWNrcG9yY2hfYnl0ZSA9ICgodm0tPmhiYWNrX3BvcmNoICsgdm0tPmhzeW5jX2xlbikgKg0K
KwkJCWRzaV90bXBfYnVmX2JwcCAtIDEwKTsNCiANCiAJZGF0YV9waHlfY3ljbGVzID0gdGltaW5n
LT5scHggKyB0aW1pbmctPmRhX2hzX3ByZXBhcmUgKw0KLQkJCSAgdGltaW5nLT5kYV9oc196ZXJv
ICsgdGltaW5nLT5kYV9oc19leGl0Ow0KKwkJCSAgdGltaW5nLT5kYV9oc196ZXJvICsgdGltaW5n
LT5kYV9oc19leGl0ICsgMzsNCiANCiAJaWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX01P
REVfVklERU9fQlVSU1QpIHsNCiAJCWlmICgodm0tPmhmcm9udF9wb3JjaCArIHZtLT5oYmFja19w
b3JjaCkgKiBkc2lfdG1wX2J1Zl9icHAgPg0KLS0gDQoyLjEyLjUNCg==

