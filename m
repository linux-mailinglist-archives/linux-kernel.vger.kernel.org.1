Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360072722FB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIULsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:48:47 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39015 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726444AbgIULsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:48:46 -0400
X-UUID: 238137fea42444918c2952e68b66505d-20200921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=JgfN+uAckCRaEuIqR1tqCtgEvsazIbO9KtNfTtCzZFw=;
        b=XR5N3ch7e/BiXfNwZ7xjRWBF0fmBSoOWyGmigZpClKxEO/ZxB/9v0IwX7akniWUwYtNrvHSQq5adHit3Hmaik6PGnH2/9ru9IdNuux2In+mZzDdWI/PRu1ISrlwTo+dTSWGf5ql6Bs33uhPIUmkkR0mID8CP0+Xw4yTt9KXVhSI=;
X-UUID: 238137fea42444918c2952e68b66505d-20200921
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 728983720; Mon, 21 Sep 2020 19:48:40 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 21 Sep 2020 19:48:37 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Sep 2020 19:48:38 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v2 0/8] Add Support for MediaTek PMIC MT6359
Date:   Mon, 21 Sep 2020 19:48:07 +0800
Message-ID: <1600688895-9238-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbmNsdWRlcyByZWZhY3RvcmluZyBpbnRlcnJ1cHQgYW5kIGFkZGluZyBz
dXBwb3J0IHRvIE1UNjM1OSBQTUlDLg0KTVQ2MzU5IGlzIHRoZSBwcmltYXJ5IFBNSUMgZm9yIE1U
Njc3OSBhbmQgcHJvYmFibHkgb3RoZXIgU09Dcy4NClRoZSBzZXJpZXNbMV0gc2VudCBieSBXZW4g
d2lsbCBjb250aW51ZSB0byB1cHN0cmVhbSBpbiB0aGlzIHBhdGNoc2V0IGFmdGVyd2FyZHMuDQoN
ClsxXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsv
bGlzdC8/c2VyaWVzPTMwNjU3OQ0KDQpjaGFuZ2VzIHNpbmNlIHYxOg0KLSByZXBsYWNlIHN0cnVj
dCByZWd1bGF0b3JfbGluZWFyX3JhbmdlIHdpdGggc3RydWN0IGxpbmVhcl9yYW5nZSBmb3IgcmVn
dWxhdG9yIGRyaXZlcnMuDQoNCkhzaW4tSHNpdW5nIFdhbmcgKDUpOg0KICBtZmQ6IG10NjM1ODog
cmVmaW5lIGludGVycnVwdCBjb2RlDQogIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBjb21wYXRpYmxl
IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU5IFBNSUMNCiAgbWZkOiBBZGQgc3VwcG9ydCBmb3IgdGhl
IE1lZGlhVGVrIE1UNjM1OSBQTUlDDQogIHJlZ3VsYXRvcjogbXQ2MzU5OiBTZXQgdGhlIGVuYWJs
ZSB0aW1lIGZvciBMRE9zDQogIHJlZ3VsYXRvcjogbXQ2MzU5OiBBZGQgc3VwcG9ydCBmb3IgTVQ2
MzU5UCByZWd1bGF0b3INCg0KV2VuIFN1ICgzKToNCiAgZHQtYmluZGluZ3M6IHJlZ3VsYXRvcjog
QWRkIGRvY3VtZW50IGZvciBNVDYzNTkgcmVndWxhdG9yDQogIHJlZ3VsYXRvcjogbXQ2MzU5OiBB
ZGQgc3VwcG9ydCBmb3IgTVQ2MzU5IHJlZ3VsYXRvcg0KICBhcm02NDogZHRzOiBtdDYzNTk6IGFk
ZCBQTUlDIE1UNjM1OSByZWxhdGVkIG5vZGVzDQoNCiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWZkL210NjM5Ny50eHQgICB8ICAgIDggKy0NCiAuLi4vYmluZGluZ3MvcmVndWxh
dG9yL210NjM1OS1yZWd1bGF0b3IudHh0ICAgICAgICB8ICAgNTggKw0KIGFyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ2MzU5LmR0c2kgICAgICAgICAgIHwgIDI5NiArKysrKw0KIGRyaXZl
cnMvbWZkL210NjM1OC1pcnEuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA4OSArLQ0K
IGRyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAy
MyArDQogZHJpdmVycy9yZWd1bGF0b3IvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICA5ICsNCiBkcml2ZXJzL3JlZ3VsYXRvci9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvcmVndWxhdG9yL210NjM1OS1yZWd1bGF0b3IuYyAgICAg
ICAgICAgICAgIHwgMTEzNiArKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWZk
L210NjM1OC9jb3JlLmggICAgICAgICAgICAgICAgICAgIHwgICAgOCArLQ0KIGluY2x1ZGUvbGlu
dXgvbWZkL210NjM1OS9jb3JlLmggICAgICAgICAgICAgICAgICAgIHwgIDEzMyArKysNCiBpbmNs
dWRlL2xpbnV4L21mZC9tdDYzNTkvcmVnaXN0ZXJzLmggICAgICAgICAgICAgICB8ICA1MjkgKysr
KysrKysrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU5cC9yZWdpc3RlcnMuaCAgICAgICAgICAg
ICAgfCAgMjQ2ICsrKysrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L2NvcmUuaCAgICAgICAg
ICAgICAgICAgICAgfCAgICAxICsNCiBpbmNsdWRlL2xpbnV4L3JlZ3VsYXRvci9tdDYzNTktcmVn
dWxhdG9yLmggICAgICAgICB8ICAgNTkgKw0KIDE0IGZpbGVzIGNoYW5nZWQsIDI1NjMgaW5zZXJ0
aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3IvbXQ2MzU5LXJlZ3VsYXRvci50eHQNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTkuZHRz
aQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3JlZ3VsYXRvci9tdDYzNTktcmVndWxhdG9y
LmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU5L2NvcmUuaA0K
IGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTkvcmVnaXN0ZXJzLmgN
CiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU5cC9yZWdpc3RlcnMu
aA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4L3JlZ3VsYXRvci9tdDYzNTktcmVn
dWxhdG9yLmgNCg0KLS0gDQoyLjYuNA0K

