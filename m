Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1C924AEE8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 08:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHTGF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 02:05:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:63717 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726817AbgHTGFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:05:49 -0400
X-UUID: a8052746c9f44f5b8956f2941184edf5-20200820
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YCz3zZyXfl57yZ7Jb72oKKAg7mHFeI1tE7IbuhR9blU=;
        b=I1ZLg+n7QNDqurc+o8aBE9et0hOtzwLB2ZWKKRo7cXAoyFWjbTPgvF8qnbeB8d84XYKM3nuy+qoEDWGIzFzyytp/fy/wpBN34dOJWS+IAQpui2liD4vLBtNEDRAhLxHwzKEYjX58Q8YdxAt3uUGwyMJHDH9JLaCReeBnMaa6AK0=;
X-UUID: a8052746c9f44f5b8956f2941184edf5-20200820
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1454521780; Thu, 20 Aug 2020 14:05:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 20 Aug 2020 14:05:43 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 20 Aug 2020 14:05:42 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v1 12/21] drm/mediatek: fix ccorr size config
Date:   Thu, 20 Aug 2020 14:04:09 +0800
Message-ID: <1597903458-8055-13-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1597903458-8055-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zml4IGNjb3JyIHNpemUgY29uZmlnDQoNClNpZ25lZC1vZmYtYnk6IFlvbmdxaWFuZyBOaXUgPHlv
bmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZGRwX2NvbXAuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRl
ay9tdGtfZHJtX2RkcF9jb21wLmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jDQppbmRleCAxZDhkYzZhLi4wYzgxMjUzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KQEAgLTIwOCw3ICsyMDgsNyBAQCBzdGF0aWMg
dm9pZCBtdGtfY2NvcnJfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVk
IGludCB3LA0KIAkJCSAgICAgdW5zaWduZWQgaW50IGgsIHVuc2lnbmVkIGludCB2cmVmcmVzaCwN
CiAJCQkgICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21kcV9wa3QpDQog
ew0KLQltdGtfZGRwX3dyaXRlKGNtZHFfcGt0LCBoIDw8IDE2IHwgdywgY29tcCwgRElTUF9DQ09S
Ul9TSVpFKTsNCisJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgdyA8PCAxNiB8IGgsIGNvbXAsIERJ
U1BfQ0NPUlJfU0laRSk7DQogCW10a19kZHBfd3JpdGUoY21kcV9wa3QsIENDT1JSX0VOR0lORV9F
TiwgY29tcCwgRElTUF9DQ09SUl9DRkcpOw0KIH0NCiANCi0tIA0KMS44LjEuMS5kaXJ0eQ0K

