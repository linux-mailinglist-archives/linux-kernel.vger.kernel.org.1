Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22D027DF0D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 05:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgI3Dh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 23:37:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42652 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725320AbgI3Dh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 23:37:26 -0400
X-UUID: fcb3a0e8fcff4d4ea64a39c99de5a5b7-20200930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nFjY+65HkqTIZS8cgP/4xc/0uFaZraXhLQV67OqTdbo=;
        b=jLzGBIU/L7LxLBmXWaLGR2ayRZugR9e0ab3xyA5D9N2DlC+m38PdbbP2GCwMlN/Fb4ubVyrgmX3c8dAybi3aHg2Tp670nrUo+Pmx2uu90Bq3pWxRJ7XnUde3TLrDgb5w/smviMP3LgAyjaKvmZf3VFZB29AO8LJAfbE6UIwHpOQ=;
X-UUID: fcb3a0e8fcff4d4ea64a39c99de5a5b7-20200930
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1300487384; Wed, 30 Sep 2020 11:37:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 30 Sep 2020 11:37:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 30 Sep 2020 11:37:19 +0800
Message-ID: <1601437039.28469.3.camel@mtksdaap41>
Subject: Re: [PATCH v17 06/12] soc: mediatek: Add support for hierarchical
 scpsys device node
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 30 Sep 2020 11:37:19 +0800
In-Reply-To: <CANMq1KByYjeD0D81sPzDxx5SzrPvpGxPgm+xvLWcFsmfUJDWBQ@mail.gmail.com>
References: <1596705715-15320-1-git-send-email-weiyi.lu@mediatek.com>
         <1596705715-15320-7-git-send-email-weiyi.lu@mediatek.com>
         <CANMq1KByYjeD0D81sPzDxx5SzrPvpGxPgm+xvLWcFsmfUJDWBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTI4IGF0IDE1OjE0ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFRodSwgQXVnIDYsIDIwMjAgYXQgNToyMiBQTSBXZWl5aSBMdSA8d2VpeWkubHVAbWVk
aWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IFRyeSB0byBsaXN0IGFsbCB0aGUgcG93ZXIgZG9t
YWlucyBvZiB1bmRlciBwb3dlciBjb250cm9sbGVyDQo+ID4gbm9kZSB0byBzaG93IHRoZSBkZXBl
bmRlbmN5IGJldHdlZW4gZWFjaCBwb3dlciBkb21haW4gZGlyZWN0bHkNCj4gPiBpbnN0ZWFkIG9m
IGZpbGxpbmcgdGhlIGRlcGVuZGVuY3kgaW4gc2NwX3NvY19kYXRhLg0KPiA+IEFuZCBjb3VsZCBi
ZSBtb3JlIGNsZWFybHkgdG8gZ3JvdXAgc3Vic3lzIGNsb2NrcyBpbnRvIHBvd2VyIGRvbWFpbg0K
PiA+IHN1YiBub2RlIHRvIGludHJvZHVjZSBzdWJzeXMgY2xvY2tzIG9mIGJ1cyBwcm90ZWN0aW9u
IGluIG5leHQgcGF0Y2guDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWl5aSBMdSA8d2VpeWku
bHVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiBbc25pcF0NCj4gPiArc3RhdGljIGludCB0cmF2
ZXJzZV9zY3Aoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IHNjcCAqc2NwLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBzY3BfZG9tYWluX2RhdGEg
KnNjcF9kb21haW5fZGF0YSkNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IGRldmljZSAqZGV2
ID0gJnBkZXYtPmRldjsNCj4gPiArICAgICAgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYt
Pm9mX25vZGU7DQo+ID4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlX25vZGUgKnN1YjsNCj4gPiArICAg
ICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgSU5JVF9MSVNUX0hFQUQoJnNjcC0+ZGVw
X2xpbmtzKTsNCj4gPiArDQo+ID4gKyAgICAgICBmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zf
bm9kZShucCwgc3ViKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IHNjcHN5c19nZXRfZG9t
YWluKHBkZXYsIHNjcCwgc3ViLCBzY3BfZG9tYWluX2RhdGEpOw0KPiA+ICsgICAgICAgICAgICAg
ICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZGV2X2VycigmcGRldi0+
ZGV2LCAiZmFpbGVkIHRvIGhhbmRsZSBub2RlICVwT0ZuOiAlZFxuIiwgc3ViLCByZXQpOw0KPiAN
Cj4gbWlub3IgY29tbWVudDogdGhpcyBlcnJvciBzaG91bGQgbm90IGJlIHByaW50ZWQgaWYgcmV0
ID09DQo+IC1FUFJPQkVfREVGRVIgKHVzZSB0aGUgbmV3IGRldl9lcnJfcHJvYmU/KQ0KPiANCg0K
WW91J3JlIHJpZ2h0ISBJJ2xsIHVzZSBkZXZfZXJyX3Byb2JlKCkgaW5zdGVhZCBpZiBhbnlvbmUg
aXMgaW50ZXJlc3RlZA0KaW4gdGhpcyBzZXJpZXMuIFRoYW5rIHlvdSENCg0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gKyAg
ICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICtlcnI6DQo+
ID4gKyAgICAgICBvZl9ub2RlX3B1dChzdWIpOw0KPiA+ICsgICAgICAgcmV0dXJuIHJldDsNCj4g
PiArfQ0KPiBbc25pcF0NCg0K

