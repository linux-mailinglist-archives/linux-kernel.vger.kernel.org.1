Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A46303A24
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbhAZKTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:19:35 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:22675 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387443AbhAZBXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:23:45 -0500
X-UUID: 78394797b94e4b118d482194589676ee-20210126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yRCDj7Ki4f7u6nHaz8oXxjBPh/IyJGa/yKG/w/pE0Bo=;
        b=UKBjrQiqN/HtLr0oVj3b44Gtt/WftNlVeklZOBrrV2CcbAlU+ishsOf7uLbEv3+2sdaMYLTXvfndBTcDULSOlCbdirmPQT96pq5dWOYgze+DzVXHAqiYDfOw15X+/JKo+3ssDzD9E/kDCnLtd0sIfhPoAKifa3qJGRPmeVLHdAg=;
X-UUID: 78394797b94e4b118d482194589676ee-20210126
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <hailong.fan@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 623148404; Tue, 26 Jan 2021 09:22:42 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Jan
 2021 09:22:36 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 09:22:35 +0800
Message-ID: <1611624155.1248.14.camel@mhfsdcap03>
Subject: Re: [PATCH V3] pinctrl: mediatek: Fix trigger type setting follow
 for unexpected interrupt
From:   mtk15103 <hailong.fan@mediatek.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>, <chentsung@chromium.org>,
        <gtk_pangao@mediatek.com>, Hanks Chen <hanks.chen@mediatek.com>,
        <yong.wu@mediatek.com>
Date:   Tue, 26 Jan 2021 09:22:35 +0800
In-Reply-To: <CACRpkdadvp9t5xdpK+=35jwfbrR0AXM0bRSWBfWH9jJFBbEyeA@mail.gmail.com>
References: <20210125041753.2214-1-hailong.fan@mediatek.com>
         <CACRpkdadvp9t5xdpK+=35jwfbrR0AXM0bRSWBfWH9jJFBbEyeA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 06939045A34D2093C774407FFD1BBF08876E518C2D0090AB711ED6A9C3205B272000:8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTI1IGF0IDE0OjExICswMTAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
PiBPbiBNb24sIEphbiAyNSwgMjAyMSBhdCA1OjE4IEFNIEhhaWxvbmcgRmFuIDxoYWlsb25nLmZh
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPiBXaGVuIGZsaXBwaW5nIHRoZSBwb2xhcml0
eSB3aWxsIGJlIGdlbmVyYXRlZCBpbnRlcnJ1cHQgdW5kZXIgY2VydGFpbg0KPiA+IGNpcmN1bXN0
YW5jZXMsIGJ1dCBHUElPIGV4dGVybmFsIHNpZ25hbCBoYXMgbm90IGNoYW5nZWQuDQo+ID4gVGhl
biwgbWFzayB0aGUgaW50ZXJydXB0IGJlZm9yZSBwb2xhcml0eSBzZXR0aW5nLCBhbmQgY2xlYXIg
dGhlDQo+ID4gdW5leHBlY3RlZCBpbnRlcnJ1cHQgYWZ0ZXIgdHJpZ2dlciB0eXBlIHNldHRpbmcg
Y29tcGxldGVkLg0KPiA+DQo+ID4gUmVtb3ZlIG10a19laW50X2ZsaXBfZWRnZTogYmVjYXVzZSBt
dGtfZWludF91bm1hc2sgYWxyZWFkeSBjYWxscyBpdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhhaWxvbmcgRmFuIDxoYWlsb25nLmZhbkBtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6
IE5pY29sYXMgQm9pY2hhdCA8ZHJpbmtjYXRAY2hyb21pdW0ub3JnPg0KPiANCj4gVG9vayBvdXQg
djIgYW5kIGFwcGxpZWQgdGhpcyB2MyBpbnN0ZWFkLg0KPiAoTm8gaWRlYSB3aGF0IHRoZSBkaWZm
ZXJlbmNlIGlzLCB5b3UgZG9uJ3Qgc2F5LikNClYzIG9ubHkgYWRkIGNvbW1pdCBtZXNzYWdlICJS
ZW1vdmUgbXRrX2VpbnRfZmxpcF9lZGdlOiBiZWNhdXNlIG10a19laW50X3VubWFzayBhbHJlYWR5
IGNhbGxzIGl0LiINCkNvbXBhcmVkIHRvIFYyLCB0aGUgcGF0Y2ggaGFzIG5vdCBjaGFuZ2VkLg0K
VGhhbmtzLg0KDQo+IFlvdXJzLA0KPiBMaW51cyBXYWxsZWlqDQoNCg==

