Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74ED1292676
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgJSLhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:37:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54078 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbgJSLhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:37:39 -0400
X-UUID: 0b0649bb0e4e4b019d8a9564f7c74225-20201019
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nq1q5ymd+yj5qa0zLYvxc1ugCnh17/vad98CZb1TrEs=;
        b=Sxh+t9zhgrLe/2IeSnM1bdinFoHRY0gXh3q45pkD1EkuEwNfS7hO0BoCsdm43crnIY/AfmfiUBnFx2ekeaUC+QCfCgTBM+GYXWPJAL1eIP/tqzlQqzSU9tB43/BAOeT2HjNbHTpgsQWf7xhzCJj8+ypyfe9qk5UUZ6Er4E1ZrUc=;
X-UUID: 0b0649bb0e4e4b019d8a9564f7c74225-20201019
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chao.hao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 11951798; Mon, 19 Oct 2020 19:37:35 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Oct 2020 19:37:32 +0800
Received: from localhost.localdomain (10.15.20.246) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Oct 2020 19:37:32 +0800
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
Subject: [PATCH 2/4] iommu/mediatek: Add iotlb_sync_range() support
Date:   Mon, 19 Oct 2020 19:30:58 +0800
Message-ID: <20201019113100.23661-3-chao.hao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201019113100.23661-1-chao.hao@mediatek.com>
References: <20201019113100.23661-1-chao.hao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 717F35B2F2DF99D09382480E4E971BD9E3C50ED567C833254E6EB0A43D02A93A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TVRLX0lPTU1VIGRyaXZlciB3cml0ZXMgb25lIHBhZ2UgZW50cnkgYW5kIGRvZXMgdGxiIGZsdXNo
IGF0IGEgdGltZQ0KY3VycmVudGx5LiBNb3JlIG9wdGltYWwgd291bGQgYmUgdG8gYWdncmVnYXRl
IHRoZSB3cml0ZXMgYW5kIGZsdXNoDQpCVVMgYnVmZmVyIGluIHRoZSBlbmQuDQpGb3IgNTBNQiBi
dWZmZXIgbWFwcGluZywgaWYgbXRrX2lvbW11IGRyaXZlciB1c2UgaW90bGJfc3luY19yYW5nZSgp
DQppbnN0ZWFkIG9mIHRsYl9hZGRfcmFuZ2UoKSBhbmQgdGxiX2ZsdXNoX3dhbGsvbGVhZigpLCBp
dCBjYW4gaW5jcmVhc2UNCjUwJSBwZXJmb3JtYW5jZSBvciBtb3JlKGRlcGVuZGluZyBvbiBzaXpl
IG9mIGV2ZXJ5IHBhZ2Ugc2l6ZSkgaW4NCmNvbXBhcmlzb24gdG8gZmx1c2hpbmcgYWZ0ZXIgZWFj
aCBwYWdlIGVudHJ5IHVwZGF0ZS4gU28gd2UgcHJlZmVyIHRvDQp1c2UgaW90bGJfc3luY19yYW5n
ZSgpIHRvIHJlcGxhY2UgaW90bGJfc3luYygpLCB0bGJfYWRkX3JhbmdlKCkgYW5kDQp0bGJfZmx1
c2hfd2Fsay9sZWFmKCkgZm9yIE1USyBwbGF0Zm9ybXMuDQoNClNpZ25lZC1vZmYtYnk6IENoYW8g
SGFvIDxjaGFvLmhhb0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL2lvbW11L210a19pb21t
dS5jIHwgNiArKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYw0KaW5kZXggNzg1YjIyOGQzOWE2Li5kMzQwMGMxNWZmN2IgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL2lvbW11L210a19pb21tdS5jDQorKysgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQpA
QCAtMjI0LDYgKzIyNCwxMSBAQCBzdGF0aWMgdm9pZCBtdGtfaW9tbXVfdGxiX2ZsdXNoX3Jhbmdl
X3N5bmModW5zaWduZWQgbG9uZyBpb3ZhLCBzaXplX3Qgc2l6ZSwNCiAJfQ0KIH0NCiANCitzdGF0
aWMgdm9pZCBfX210a19pb21tdV90bGJfZmx1c2hfcmFuZ2Vfc3luYyh1bnNpZ25lZCBsb25nIGlv
dmEsIHNpemVfdCBzaXplKQ0KK3sNCisJbXRrX2lvbW11X3RsYl9mbHVzaF9yYW5nZV9zeW5jKGlv
dmEsIHNpemUsIDAsIE5VTEwpDQorfQ0KKw0KIHN0YXRpYyB2b2lkIG10a19pb21tdV90bGJfZmx1
c2hfcGFnZV9ub3N5bmMoc3RydWN0IGlvbW11X2lvdGxiX2dhdGhlciAqZ2F0aGVyLA0KIAkJCQkJ
ICAgIHVuc2lnbmVkIGxvbmcgaW92YSwgc2l6ZV90IGdyYW51bGUsDQogCQkJCQkgICAgdm9pZCAq
Y29va2llKQ0KQEAgLTUzNiw2ICs1NDEsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGlvbW11X29w
cyBtdGtfaW9tbXVfb3BzID0gew0KIAkubWFwCQk9IG10a19pb21tdV9tYXAsDQogCS51bm1hcAkJ
PSBtdGtfaW9tbXVfdW5tYXAsDQogCS5mbHVzaF9pb3RsYl9hbGwgPSBtdGtfaW9tbXVfZmx1c2hf
aW90bGJfYWxsLA0KKwkuaW90bGJfc3luY19yYW5nZSA9IF9fbXRrX2lvbW11X3RsYl9mbHVzaF9y
YW5nZV9zeW5jLA0KIAkuaW90bGJfc3luYwk9IG10a19pb21tdV9pb3RsYl9zeW5jLA0KIAkuaW92
YV90b19waHlzCT0gbXRrX2lvbW11X2lvdmFfdG9fcGh5cywNCiAJLnByb2JlX2RldmljZQk9IG10
a19pb21tdV9wcm9iZV9kZXZpY2UsDQotLSANCjIuMTguMA0K

