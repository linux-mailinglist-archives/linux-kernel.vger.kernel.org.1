Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4464C2E8F84
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 04:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbhADDJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 22:09:32 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:43764 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726610AbhADDJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 22:09:32 -0500
X-UUID: 77c606a8b6504466ad3539b8f42d1d85-20210104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=FPK9ETN/EBdUIpqEXkfjhWCeHs6PHnTTo754Tn/L8j8=;
        b=lPLmCKpnnNTHryJBkOdTMntgUW3zQec55YYxMIW/moUHzOxYOWyPqjEHTG4tX3i5V0FM9+Ui/2s/Fl0MaBbwXKz0TZJ+CEfFCok/X/aRp41WZBjsmsOBwRW3KPJFiGYDNQFByR84xX67ZrFjA3+zaSOGdmI/acVbLTAEiid2Geg=;
X-UUID: 77c606a8b6504466ad3539b8f42d1d85-20210104
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 823065018; Mon, 04 Jan 2021 11:08:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 4 Jan
 2021 11:08:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 11:08:43 +0800
Message-ID: <1609729722.1574.1.camel@mhfsdcap03>
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
Date:   Mon, 4 Jan 2021 11:08:42 +0800
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
ZCBhcyBhIHJlbmFtZT8NCg0KdGhlIHJlbmFtZSBtZXNzYWdlIGRpc3BsYXllZCB3aGVuIGdpdCBj
b21taXQgLXMNCmdpdCBzaG93IHdpbGwgbm90IHNob3cgdGhlIHJlbmFtZSBpbmZvcm1hdGlvbg0K
DQo+IA0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDM4MyBpbnNlcnRpb25zKCspLCAzODEgZGVsZXRp
b25zKC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5
cy9NYWtlZmlsZQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bW1zeXMvbXRrLW1tc3lzLmMNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc29jL21l
ZGlhdGVrL210ay1tbXN5cy5jDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvTWFrZWZpbGUgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+IGluZGV4
IDAxZjlmODcuLmI1OTg3Y2EgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsv
TWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9NYWtlZmlsZQ0KPiA+IEBA
IC0zLDQgKzMsNCBAQCBvYmotJChDT05GSUdfTVRLX0NNRFEpICs9IG10ay1jbWRxLWhlbHBlci5v
DQo+ID4gIG9iai0kKENPTkZJR19NVEtfSU5GUkFDRkcpICs9IG10ay1pbmZyYWNmZy5vDQo+ID4g
IG9iai0kKENPTkZJR19NVEtfUE1JQ19XUkFQKSArPSBtdGstcG1pYy13cmFwLm8NCj4gPiAgb2Jq
LSQoQ09ORklHX01US19TQ1BTWVMpICs9IG10ay1zY3BzeXMubw0KPiA+IC1vYmotJChDT05GSUdf
TVRLX01NU1lTKSArPSBtdGstbW1zeXMubw0KPiA+ICtvYmotJChDT05GSUdfTVRLX01NU1lTKSAr
PSBtbXN5cy8NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbW1zeXMvTWFr
ZWZpbGUgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9NYWtlZmlsZQ0KPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uNWQ5NzZkNw0KPiA+IC0tLSAvZGV2L251
bGwNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tbXN5cy9NYWtlZmlsZQ0KPiA+IEBA
IC0wLDAgKzEsMiBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9u
bHkNCj4gPiArb2JqLSQoQ09ORklHX01US19NTVNZUykgKz0gbXRrLW1tc3lzLm8NCj4gPiBcIE5v
IG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUNCj4gDQo+IE5pdDogbmV3bGluZSBhdCBlbmQgb2YgZmls
ZSBwbGVhc2UuDQoNCml0IHdpbGwgYmUgZml4ZWQgaW4gbmV4dCB2ZXJzaW9uDQoNCg==

