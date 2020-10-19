Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066E8292675
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgJSLhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:37:42 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48576 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727881AbgJSLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:37:39 -0400
X-UUID: b3b3baa3f08f48268656f28fb3156f1b-20201019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PgytRVtoOdd6B5kIyJtkERoueoWC2+wKUHTBlw26xos=;
        b=HXZ8cWTSqGFlS/i1RulNlId+JvaBEyIU0zdnd3yEQCYJEZfYZkKg0QLgg1U0e3d40vYzW+j4o2psu/8wIrS9KXAy54s6rB1B/WRXqZT8EhLqDbFUB4hefGNPQ+l3lQ/0VnApK4hKa/0Bc5V/CFpjyW2B50ATfZDSZEjeTnOhQD4=;
X-UUID: b3b3baa3f08f48268656f28fb3156f1b-20201019
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 145608279; Mon, 19 Oct 2020 19:37:36 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Oct 2020 19:37:35 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Oct 2020 19:37:34 +0800
From:   Chao Hao <chao.hao@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, FY Yang <fy.yang@mediatek.com>,
        Jun Wen <jun.wen@mediatek.com>,
        Mingyuan Ma <mingyuan.ma@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>
Subject: [PATCH 3/4] iommu/mediatek: Remove unnecessary tlb sync
Date:   Mon, 19 Oct 2020 19:30:59 +0800
Message-ID: <20201019113100.23661-4-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201019113100.23661-1-chao.hao@mediatek.com>
References: <20201019113100.23661-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXMgaXMgIltQQVRDSCAyLzRdIiBkZXNjcmliZWQsIHdlIHdpbGwgdXNlIGlvdGxiX3N5bmNfcmFu
Z2UoKSB0byByZXBsYWNlDQppb3RsYl9zeW5jKCksIHRsYl9hZGRfcmFuZ2UoKSBhbmQgdGxiX2Zs
dXNoX3dhbGsvbGVhZigpIHRvIGVuaGFuY2UNCnBlcmZvcm1hbmNlLiBTbyB3ZSB3aWxsIHJlbW92
ZSB0aGUgaW1wbGVtZW50YXRpb24gb2YgaW90bGJfc3luYygpLA0KdGxiX2FkZF9yYW5nZSgpIGFu
ZCB0bGJfZmx1c2hfd2Fsay9sZWFmKCkuDQoNClNpZ25lZC1vZmYtYnk6IENoYW8gSGFvIDxjaGFv
Lmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMjgg
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlv
bnMoKyksIDI0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCmluZGV4IGQzNDAwYzE1ZmY3Yi4u
YmNhMWY1M2MwYWI5IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KKysr
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KQEAgLTIyOSwyMSArMjI5LDE1IEBAIHN0YXRp
YyB2b2lkIF9fbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKHVuc2lnbmVkIGxvbmcgaW92
YSwgc2l6ZV90IHNpemUpDQogCW10a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYyhpb3ZhLCBz
aXplLCAwLCBOVUxMKQ0KIH0NCiANCi1zdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3Bh
Z2Vfbm9zeW5jKHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmdhdGhlciwNCi0JCQkJCSAgICB1
bnNpZ25lZCBsb25nIGlvdmEsIHNpemVfdCBncmFudWxlLA0KLQkJCQkJICAgIHZvaWQgKmNvb2tp
ZSkNCitzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3NraXAodW5zaWduZWQgbG9uZyBp
b3ZhLCBzaXplX3Qgc2l6ZSwNCisJCQkJICAgICBzaXplX3QgZ3JhbnVsZSwgdm9pZCAqY29va2ll
KQ0KIHsNCi0Jc3RydWN0IG10a19pb21tdV9kYXRhICpkYXRhID0gY29va2llOw0KLQlzdHJ1Y3Qg
aW9tbXVfZG9tYWluICpkb21haW4gPSAmZGF0YS0+bTR1X2RvbS0+ZG9tYWluOw0KLQ0KLQlpb21t
dV9pb3RsYl9nYXRoZXJfYWRkX3BhZ2UoZG9tYWluLCBnYXRoZXIsIGlvdmEsIGdyYW51bGUpOw0K
IH0NCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X2ZsdXNoX29wcyBtdGtfaW9tbXVfZmx1
c2hfb3BzID0gew0KIAkudGxiX2ZsdXNoX2FsbCA9IG10a19pb21tdV90bGJfZmx1c2hfYWxsLA0K
LQkudGxiX2ZsdXNoX3dhbGsgPSBtdGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmMsDQotCS50
bGJfZmx1c2hfbGVhZiA9IG10a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYywNCi0JLnRsYl9h
ZGRfcGFnZSA9IG10a19pb21tdV90bGJfZmx1c2hfcGFnZV9ub3N5bmMsDQorCS50bGJfZmx1c2hf
d2FsayA9IG10a19pb21tdV90bGJfZmx1c2hfc2tpcCwNCisJLnRsYl9mbHVzaF9sZWFmID0gbXRr
X2lvbW11X3RsYl9mbHVzaF9za2lwLA0KIH07DQogDQogc3RhdGljIGlycXJldHVybl90IG10a19p
b21tdV9pc3IoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KQEAgLTQ0MywxOSArNDM3LDYgQEAgc3Rh
dGljIHZvaWQgbXRrX2lvbW11X2ZsdXNoX2lvdGxiX2FsbChzdHJ1Y3QgaW9tbXVfZG9tYWluICpk
b21haW4pDQogCW10a19pb21tdV90bGJfZmx1c2hfYWxsKG10a19pb21tdV9nZXRfbTR1X2RhdGEo
KSk7DQogfQ0KIA0KLXN0YXRpYyB2b2lkIG10a19pb21tdV9pb3RsYl9zeW5jKHN0cnVjdCBpb21t
dV9kb21haW4gKmRvbWFpbiwNCi0JCQkJIHN0cnVjdCBpb21tdV9pb3RsYl9nYXRoZXIgKmdhdGhl
cikNCi17DQotCXN0cnVjdCBtdGtfaW9tbXVfZGF0YSAqZGF0YSA9IG10a19pb21tdV9nZXRfbTR1
X2RhdGEoKTsNCi0Jc2l6ZV90IGxlbmd0aCA9IGdhdGhlci0+ZW5kIC0gZ2F0aGVyLT5zdGFydDsN
Ci0NCi0JaWYgKGdhdGhlci0+c3RhcnQgPT0gVUxPTkdfTUFYKQ0KLQkJcmV0dXJuOw0KLQ0KLQlt
dGtfaW9tbXVfdGxiX2ZsdXNoX3JhbmdlX3N5bmMoZ2F0aGVyLT5zdGFydCwgbGVuZ3RoLCBnYXRo
ZXItPnBnc2l6ZSwNCi0JCQkJICAgICAgIGRhdGEpOw0KLX0NCi0NCiBzdGF0aWMgcGh5c19hZGRy
X3QgbXRrX2lvbW11X2lvdmFfdG9fcGh5cyhzdHJ1Y3QgaW9tbXVfZG9tYWluICpkb21haW4sDQog
CQkJCQkgIGRtYV9hZGRyX3QgaW92YSkNCiB7DQpAQCAtNTQyLDcgKzUyMyw2IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaW9tbXVfb3BzIG10a19pb21tdV9vcHMgPSB7DQogCS51bm1hcAkJPSBtdGtf
aW9tbXVfdW5tYXAsDQogCS5mbHVzaF9pb3RsYl9hbGwgPSBtdGtfaW9tbXVfZmx1c2hfaW90bGJf
YWxsLA0KIAkuaW90bGJfc3luY19yYW5nZSA9IF9fbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9z
eW5jLA0KLQkuaW90bGJfc3luYwk9IG10a19pb21tdV9pb3RsYl9zeW5jLA0KIAkuaW92YV90b19w
aHlzCT0gbXRrX2lvbW11X2lvdmFfdG9fcGh5cywNCiAJLnByb2JlX2RldmljZQk9IG10a19pb21t
dV9wcm9iZV9kZXZpY2UsDQogCS5yZWxlYXNlX2RldmljZQk9IG10a19pb21tdV9yZWxlYXNlX2Rl
dmljZSwNCi0tIA0KMi4xOC4wDQo=

