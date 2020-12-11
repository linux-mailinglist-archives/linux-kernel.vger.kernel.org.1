Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFFA2D6CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394616AbgLKArj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:47:39 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57027 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394581AbgLKAqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:46:13 -0500
X-UUID: 175a4b11f04544e58299932473eb56e9-20201211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=E2phvecjpcnxYh432R82AH09qnOeU+p1vhvA2VIcfOk=;
        b=Lc+/4lEAQOL1HpqARe930c1IK92/SL8H7pu9bz1/3Jk1oSvOibwK/lEQNF1SIpXo1s7u6bd1riKsNcEndxrI4np3LYQzK5v23/l9mJiyXCkOAVMKa0ZSoB5+mt3LZXu1eqTrWjWpurR8S+YCsIs8g62+0Jdqh9P8NrKPtutevzQ=;
X-UUID: 175a4b11f04544e58299932473eb56e9-20201211
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 886675065; Fri, 11 Dec 2020 08:45:16 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 11 Dec
 2020 08:45:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Dec 2020 08:45:13 +0800
Message-ID: <1607647514.12750.5.camel@mhfsdcap03>
Subject: Re: [PATCH v8, 5/6] drm/mediatek: add RDMA fifo size error handle
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 11 Dec 2020 08:45:14 +0800
In-Reply-To: <CAAOTY_-aYFz1Xg6r2ur+BF_k_35F3qNLLb16_2c0MaMsYre-+w@mail.gmail.com>
References: <1607591262-21736-1-git-send-email-yongqiang.niu@mediatek.com>
         <1607591262-21736-6-git-send-email-yongqiang.niu@mediatek.com>
         <CAAOTY_-aYFz1Xg6r2ur+BF_k_35F3qNLLb16_2c0MaMsYre-+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTEwIGF0IDIzOjUwICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgWW9uZ3FpYW5nOg0KPiANCj4gWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRp
YXRlay5jb20+IOaWvCAyMDIw5bm0MTLmnIgxMOaXpSDpgLHlm5sg5LiL5Y2INTowOOWvq+mBk++8
mg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBhZGQgUkRNQSBmaWZvIHNpemUgZXJyb3IgaGFuZGxlDQo+
ID4gcmRtYSBmaWZvIHNpemUgd2lsbCBub3QgYWx3YXlzIGJpZ2dlciB0aGFuIHRoZSBjYWxjdWxh
dGVkIHRocmVzaG9sZA0KPiA+IGlmIHRoYXQgY2FzZSBoYXBwZW5lZCwgd2UgbmVlZCBzZXQgZmlm
byBzaXplIGFzIHRoZSB0aHJlc2hvbGQNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFlvbmdxaWFu
ZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIHwgNCArKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX3JkbWEuYw0KPiA+IGluZGV4IDc5NGFjYzUuLjA1MDgzOTIgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KPiA+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gPiBAQCAtMTUxLDYg
KzE1MSwxMCBAQCBzdGF0aWMgdm9pZCBtdGtfcmRtYV9jb25maWcoc3RydWN0IG10a19kZHBfY29t
cCAqY29tcCwgdW5zaWduZWQgaW50IHdpZHRoLA0KPiA+ICAgICAgICAgICogYWNjb3VudCBmb3Ig
YmxhbmtpbmcsIGFuZCB3aXRoIGEgcGl4ZWwgZGVwdGggb2YgNCBieXRlczoNCj4gPiAgICAgICAg
ICAqLw0KPiA+ICAgICAgICAgdGhyZXNob2xkID0gd2lkdGggKiBoZWlnaHQgKiB2cmVmcmVzaCAq
IDQgKiA3IC8gMTAwMDAwMDsNCj4gPiArDQo+ID4gKyAgICAgICBpZiAodGhyZXNob2xkID4gcmRt
YV9maWZvX3NpemUpDQo+ID4gKyAgICAgICAgICAgICAgIHRocmVzaG9sZCA9IHJkbWFfZmlmb19z
aXplOw0KPiANCj4gSWYgdGhlIGZvcm11bGEgaXMgbm90IGNvcnJlY3QsIHlvdSBzaG91bGQgZml4
IHRoZSBmb3JtdWxhIG5vdCB3b3JrIGFyb3VuZC4NCj4gDQo+IFJlZ2FyZHMsDQo+IENodW4tS3Vh
bmcuDQoNCmhvdyBhYm91dCB0aGlzOg0KdGhyZXNob2xkID0gbWF4KHdpZHRoICogaGVpZ2h0ICog
dnJlZnJlc2ggKiA0ICogNyAvIDEwMDAwMDAsDQpyZG1hX2ZpZm9fc2l6ZSk7DQo+IA0KPiA+ICsN
Cj4gPiAgICAgICAgIHJlZyA9IFJETUFfRklGT19VTkRFUkZMT1dfRU4gfA0KPiA+ICAgICAgICAg
ICAgICAgUkRNQV9GSUZPX1BTRVVET19TSVpFKHJkbWFfZmlmb19zaXplKSB8DQo+ID4gICAgICAg
ICAgICAgICBSRE1BX09VVFBVVF9WQUxJRF9GSUZPX1RIUkVTSE9MRCh0aHJlc2hvbGQpOw0KPiA+
IC0tDQo+ID4gMS44LjEuMS5kaXJ0eQ0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4g
TGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0K

