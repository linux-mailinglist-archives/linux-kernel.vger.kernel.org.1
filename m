Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AD42E2984
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 03:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgLYCk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 21:40:28 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:51370 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726760AbgLYCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 21:40:28 -0500
X-UUID: 62c898a3c4354700b99f3fdc31bef351-20201225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=w7Kq6z7M/4vEr5amD6OGAHxikHzwv5FfbNXNsef5hpU=;
        b=FqQe2vlZb3JVfEoFq9j6FVbRwa/Qgy2WSM4NXr3SerLi446Olsqbvnxfft1o3ioVCyBzMrpQa+QofeBDOFyDB2sNt5+L3Mq3BBu49NWhHg4xbypBeNYsege9qW/WBStthSF7BX52NlnGKzvLgw64DaakGZHg+/rbJFlJXx4laSo=;
X-UUID: 62c898a3c4354700b99f3fdc31bef351-20201225
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1580110998; Fri, 25 Dec 2020 10:39:43 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 25 Dec
 2020 10:39:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Dec 2020 10:39:40 +0800
Message-ID: <1608863980.18252.15.camel@mhfsdcap03>
Subject: Re: [PATCH v2, 3/3] mailbox: cmdq: add mt8192 support
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
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 25 Dec 2020 10:39:40 +0800
In-Reply-To: <CAAOTY_9e9qadeO9k7zQnvSLZAAJFxjWwYSBz-XXEUUh16jsptA@mail.gmail.com>
References: <1608770889-9403-1-git-send-email-yongqiang.niu@mediatek.com>
         <1608770889-9403-4-git-send-email-yongqiang.niu@mediatek.com>
         <CAAOTY_9e9qadeO9k7zQnvSLZAAJFxjWwYSBz-XXEUUh16jsptA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTI0IGF0IDIyOjI4ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgWW9uZ3FpYW5nOg0KPiANCj4gWW9uZ3FpYW5nIE5pdSA8eW9uZ3FpYW5nLm5pdUBtZWRp
YXRlay5jb20+IOaWvCAyMDIw5bm0MTLmnIgyNOaXpSDpgLHlm5sg5LiK5Y2IODo1NeWvq+mBk++8
mg0KPiA+DQo+ID4gYWRkIG10ODE5MiBzdXBwb3J0DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZ
b25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyB8IDEgKw0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21haWxi
b3gvbXRrLWNtZHEtbWFpbGJveC5jIGIvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3gu
Yw0KPiA+IGluZGV4IDc1Mzc4ZTMuLjdmMjQzZTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9t
YWlsYm94L210ay1jbWRxLW1haWxib3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGst
Y21kcS1tYWlsYm94LmMNCj4gPiBAQCAtNjA3LDYgKzYwNyw3IEBAIHN0YXRpYyBpbnQgY21kcV9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAgICAgICAgey5jb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE3My1nY2UiLCAuZGF0YSA9ICh2b2lkICopJmdjZV9wbGF0X3Yy
fSwNCj4gPiAgICAgICAgIHsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZ2NlIiwgLmRh
dGEgPSAodm9pZCAqKSZnY2VfcGxhdF92M30sDQo+ID4gICAgICAgICB7LmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ2Nzc5LWdjZSIsIC5kYXRhID0gKHZvaWQgKikmZ2NlX3BsYXRfdjR9LA0KPiA+
ICsgICAgICAgey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5Mi1nY2UiLCAuZGF0YSA9ICh2
b2lkICopJmdjZV9wbGF0X3Y0fSwNCj4gDQo+IEluIHRoZSB2aWV3IG9mIGhhcmR3YXJlIGZ1bmN0
aW9uLCBpcyBtdDgxOTItZ2NlIGlkZW50aWNhbCB0bw0KPiBtdDY3NzktZ2NlPyBJZiB0aGVzZSB0
d28gYXJlIGlkZW50aWNhbCwgeW91IG5lZWQgbm90IHRvIG1vZGlmeSBkcml2ZXIsDQo+IGFuZCB0
aGUgY29tcGF0aWJsZSBzaG91bGQgYmUNCj4gDQo+IGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTkyLWdjZSIsICJtZWRpYXRlayxtdDY3NzktZ2NlIjsNCj4gDQo+IElmIHRoZXkgYXJlIG5vdCBp
ZGVudGljYWwsIHdoYXQncyB0aGUgZGlmZmVyZW50Pw0KPiANCj4gUmVnYXJkcywNCj4gQ2h1bi1L
dWFuZy4NCg0KaXJxIGlkIGlzIGRpZmZlcmVudCANCm10ODE5MiBkdHMNCmh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8xNjA4NzcwODg5LTk0
MDMtMy1naXQtc2VuZC1lbWFpbC15b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbS8NCg0KbXQ2Nzc5
IGR0cw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVr
L3BhdGNoLzE1NzQzMjc1NTItMTE4MDYtNi1naXQtc2VuZC1lbWFpbC1kZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tLw0KDQphbmQgZ2NlIGV2ZW50IGlkIGFsc28gZGlmZmVyZW50DQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMTYwODc3
MDg4OS05NDAzLTItZ2l0LXNlbmQtZW1haWwteW9uZ3FpYW5nLm5pdUBtZWRpYXRlay5jb20vDQoN
Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRj
aC8xNTc0MzI3NTUyLTExODA2LTItZ2l0LXNlbmQtZW1haWwtZGVubmlzLXljLmhzaWVoQG1lZGlh
dGVrLmNvbS8NCg0KDQo+IA0KPiA+ICAgICAgICAge30NCj4gPiAgfTsNCj4gPg0KPiA+IC0tDQo+
ID4gMS44LjEuMS5kaXJ0eQ0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+ID4gTGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gTGludXgt
bWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbWVkaWF0ZWsNCg0K

