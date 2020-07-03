Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19BFE213808
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 11:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgGCJvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 05:51:23 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:53308 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbgGCJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:51:23 -0400
X-UUID: 3f2ac1dc8754475295786640908615f3-20200703
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jsMFJtcW/JnItlp79G6hD6yY/tk89ErR3jd+rCAsl/A=;
        b=qS4t1aGREGKIYkBDX7FYsJa5N5tHKwJP1kvJjAZGhbGePXUKI/gMI4WBWsPjzyVlpAJmS8Mcf/fSh2Q70PQ9JnqgBXRty4TaPUbwPCO+2tUPyrj+SBsl7LE5CNt0Vh/cSjugXdpw2/3T2VRiSvKsubTdWGfYfBD0CntbCEKTJcc=;
X-UUID: 3f2ac1dc8754475295786640908615f3-20200703
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1627870794; Fri, 03 Jul 2020 17:51:18 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 3 Jul
 2020 17:51:15 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 3 Jul 2020 17:51:14 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH] drm/panel: auo,b116xw03: fix flash backlight when power on
Date:   Fri, 3 Jul 2020 17:51:13 +0800
Message-ID: <20200703095113.55712-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 5574DF20B4595058467B711402DB5E47F26C70718F5EC942B9184F35BC2AFF532000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVsYXkgdGhlIGJhY2tsaWdodCBvbiB0byBtYWtlIHN1cmUgdGhlIHZpZGVvIHN0YWJsZS4NCg0K
U2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxqaXRhby5zaGlAbWVkaWF0ZWsuY29tPg0KLS0tDQog
ZHJpdmVycy9ncHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBsZS5jIHwgMyArKysNCiAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vcGFu
ZWwvcGFuZWwtc2ltcGxlLmMgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtc2ltcGxlLmMN
CmluZGV4IDNhZDgyOGVhZWZlMS4uMThmMzRmMjg2ZDNkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL3BhbmVsL3BhbmVsLXNpbXBsZS5jDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwv
cGFuZWwtc2ltcGxlLmMNCkBAIC03MzQsNiArNzM0LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBw
YW5lbF9kZXNjIGF1b19iMTE2eHcwMyA9IHsNCiAJCS53aWR0aCA9IDI1NiwNCiAJCS5oZWlnaHQg
PSAxNDQsDQogCX0sDQorCS5kZWxheSA9IHsNCisJCS5lbmFibGUgPSA0MDAsDQorCX0sDQogfTsN
CiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9kaXNwbGF5X21vZGUgYXVvX2IxMzN4dG4wMV9t
b2RlID0gew0KLS0gDQoyLjI1LjENCg==

