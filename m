Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C42EEB1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbhAHBs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:48:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37108 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729812AbhAHBs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:48:56 -0500
X-UUID: 729c725f5e6242db9551a4ee653bd7bd-20210108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=NPP5jpMnteAgsJpkoNqsMUTLM/8AlhOp/XPWd4WayzM=;
        b=aupKRcA3tCWLDs1A4m1gsP2wep+Lkr9qQ7DtVqvjgrg+uMwDFXNFg+0K28SyvrMW5FgFJXfFsi2Aiw04lRp13IxGKiPTbyvTQRKDuZp7kJf9jtCoJSF6OKJc71au9cChr/0wMNUZRkaeJuJuoO65wq68p5JE9MXTisQoLz6H2OA=;
X-UUID: 729c725f5e6242db9551a4ee653bd7bd-20210108
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 488800082; Fri, 08 Jan 2021 09:48:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Jan
 2021 09:48:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 09:48:05 +0800
Message-ID: <1610070485.1574.10.camel@mhfsdcap03>
Subject: Re: [PATCH v2] soc: mediatek: cmdq: add address shift in jump
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        <damon.chu@mediatek.com>, <dennis-yc.hsieh@mediatek.com>
Date:   Fri, 8 Jan 2021 09:48:05 +0800
In-Reply-To: <1608712499-24956-2-git-send-email-yongqiang.niu@mediatek.com>
References: <1608712499-24956-1-git-send-email-yongqiang.niu@mediatek.com>
         <1608712499-24956-2-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 68847612D0C798759DAC2DE39BDF7DDFAD4EDA6D3284292B08F310D98A8DC2A62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTEyLTIzIGF0IDE2OjM0ICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0K
PiBBZGQgYWRkcmVzcyBzaGlmdCB3aGVuIGNvbXBvc2UganVtcCBpbnN0cnVjdGlvbg0KPiB0byBj
b21wYXRpYmxlIHdpdGggMzViaXQgZm9ybWF0Lg0KPiANCj4gRml4ZXM6IDA4NThmZGU0OTZmOCAo
Im1haWxib3g6IGNtZHE6IHZhcmlhYmxpemUgYWRkcmVzcyBzaGlmdCBpbiBwbGF0Zm9ybSIpDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVr
LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IE5pY29sYXMgQm9pY2hhdCA8ZHJpbmtjYXRAY2hyb21pdW0u
b3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgfCAzICsr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMgYi9kcml2
ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGluZGV4IDU2NjViNmUuLjc1Mzc4ZTMg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4gKysr
IGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiBAQCAtMTY4LDcgKzE2OCw4
IEBAIHN0YXRpYyB2b2lkIGNtZHFfdGFza19pbnNlcnRfaW50b190aHJlYWQoc3RydWN0IGNtZHFf
dGFzayAqdGFzaykNCj4gIAlkbWFfc3luY19zaW5nbGVfZm9yX2NwdShkZXYsIHByZXZfdGFzay0+
cGFfYmFzZSwNCj4gIAkJCQlwcmV2X3Rhc2stPnBrdC0+Y21kX2J1Zl9zaXplLCBETUFfVE9fREVW
SUNFKTsNCj4gIAlwcmV2X3Rhc2tfYmFzZVtDTURRX05VTV9DTUQocHJldl90YXNrLT5wa3QpIC0g
MV0gPQ0KPiAtCQkodTY0KUNNRFFfSlVNUF9CWV9QQSA8PCAzMiB8IHRhc2stPnBhX2Jhc2U7DQo+
ICsJCSh1NjQpQ01EUV9KVU1QX0JZX1BBIDw8IDMyIHwNCj4gKwkJKHRhc2stPnBhX2Jhc2UgPj4g
dGFzay0+Y21kcS0+c2hpZnRfcGEpOw0KPiAgCWRtYV9zeW5jX3NpbmdsZV9mb3JfZGV2aWNlKGRl
diwgcHJldl90YXNrLT5wYV9iYXNlLA0KPiAgCQkJCSAgIHByZXZfdGFzay0+cGt0LT5jbWRfYnVm
X3NpemUsIERNQV9UT19ERVZJQ0UpOw0KPiAgDQoNCmhpIGphc3NpDQoNCnBsZWFzZSBjb25maXJt
IGlzIHRoZXJlIGFueSBxdWVzdGlvbiBhYm91dCB0aGlzIHBhdGNoLg0KaWYgbm90LCBwbGVhc2Ug
YXBwbHkgdGhpcyBpbnRvIG5leHQgdmVyc2lvbiwgdGtzDQo=

