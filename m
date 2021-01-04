Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCC2E9044
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbhADF6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 00:58:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43720 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727939AbhADF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 00:58:16 -0500
X-UUID: 95011aea59774b22a6e9bf7e135df9d1-20210104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=QCHz3/xaCDIL21iydEhVWPDFe6T2A74wm/k7ncOkQ2s=;
        b=tI9gLUCbvthOatbvvw4qJyzGRXi2r/wjliPxikRn3ktx5mB2tdkwTpr0JBpThrVkMdmqK1OPUGcB9mJsHbfhLBjm7tQMLFuL2fEEkhckSHS5EP6YVuifugIE8LQdNpQCnwHedX1GQP59hc9Ni3Mk/IpkK7ntLEwQs4mMr82MP1w=;
X-UUID: 95011aea59774b22a6e9bf7e135df9d1-20210104
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1804244745; Mon, 04 Jan 2021 13:57:26 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 4 Jan
 2021 13:57:25 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 13:57:23 +0800
Message-ID: <1609739844.1574.2.camel@mhfsdcap03>
Subject: Re: [PATCH v3, 1/8] soc: mediatek: mmsys: create mmsys folder
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 4 Jan 2021 13:57:24 +0800
In-Reply-To: <CANMq1KCRBz-rY6y3nHp8yh_QSohkmaYS=DqNDSPzvwmq-a09DQ@mail.gmail.com>
References: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com>
         <1609144630-14721-2-git-send-email-yongqiang.niu@mediatek.com>
         <CANMq1KCRBz-rY6y3nHp8yh_QSohkmaYS=DqNDSPzvwmq-a09DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTMxIGF0IDA5OjIxICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIE1vbiwgRGVjIDI4LCAyMDIwIGF0IDQ6MzggUE0gWW9uZ3FpYW5nIE5pdQ0KPiA8eW9u
Z3FpYW5nLm5pdUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gdGhlIG1tc3lzIHdpbGwg
bW9yZSBhbmQgbW9yZSBjb21wbGljYXRlZCBhZnRlciBzdXBwb3J0DQo+ID4gbW9yZSBhbmQgbW9y
ZSBTb0NzLCBhZGQgYW4gaW5kZXBlbmRlbnQgZm9sZGVyIHdpbGwgYmUNCj4gPiBtb3JlIGNsZWFy
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1l
ZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICAgfCAgIDIgKy0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvTWFrZWZp
bGUgICAgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9tdGstbW1zeXMu
YyB8IDM4MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9z
b2MvbWVkaWF0ZWsvbXRrLW1tc3lzLmMgICAgICAgfCAzODAgLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+IA0KPiBJIHdvbmRlciB3aHkgdGhpcyBkb2Vzbid0IGdldCBkZXRlY3Rl
ZCBhcyBhIHJlbmFtZT8NCj4gDQoNCmdpdCBjb21taXQgLS1hbWVuZA0KW2RldGFjaGVkIEhFQUQg
MWYxMGMwNV0gc29jOiBtZWRpYXRlazogbW1zeXM6IGNyZWF0ZSBtbXN5cyBmb2xkZXINCiAzIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9NYWtlZmlsZQ0KIHJlbmFtZSBkcml2
ZXJzL3NvYy9tZWRpYXRlay97ID0+IG1tc3lzfS9tdGstbW1zeXMuYyAoMTAwJSkNCg0KDQo+ID4g
IDQgZmlsZXMgY2hhbmdlZCwgMzgzIGluc2VydGlvbnMoKyksIDM4MSBkZWxldGlvbnMoLSkNCj4g
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL01ha2VmaWxl
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9tdGst
bW1zeXMuYw0KPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRr
LW1tc3lzLmMNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtl
ZmlsZSBiL2RyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gaW5kZXggMDFmOWY4Ny4u
YjU5ODdjYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZQ0K
PiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL01ha2VmaWxlDQo+ID4gQEAgLTMsNCArMyw0
IEBAIG9iai0kKENPTkZJR19NVEtfQ01EUSkgKz0gbXRrLWNtZHEtaGVscGVyLm8NCj4gPiAgb2Jq
LSQoQ09ORklHX01US19JTkZSQUNGRykgKz0gbXRrLWluZnJhY2ZnLm8NCj4gPiAgb2JqLSQoQ09O
RklHX01US19QTUlDX1dSQVApICs9IG10ay1wbWljLXdyYXAubw0KPiA+ICBvYmotJChDT05GSUdf
TVRLX1NDUFNZUykgKz0gbXRrLXNjcHN5cy5vDQo+ID4gLW9iai0kKENPTkZJR19NVEtfTU1TWVMp
ICs9IG10ay1tbXN5cy5vDQo+ID4gK29iai0kKENPTkZJR19NVEtfTU1TWVMpICs9IG1tc3lzLw0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9NYWtlZmlsZSBiL2Ry
aXZlcnMvc29jL21lZGlhdGVrL21tc3lzL01ha2VmaWxlDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCj4gPiBpbmRleCAwMDAwMDAwLi41ZDk3NmQ3DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsr
KyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL21tc3lzL01ha2VmaWxlDQo+ID4gQEAgLTAsMCArMSwy
IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiA+ICtv
YmotJChDT05GSUdfTVRLX01NU1lTKSArPSBtdGstbW1zeXMubw0KPiA+IFwgTm8gbmV3bGluZSBh
dCBlbmQgb2YgZmlsZQ0KPiANCj4gTml0OiBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlIHBsZWFzZS4N
Cg0K

