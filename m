Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4324C283D2F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgJERRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:17:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59698 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725973AbgJERRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:17:24 -0400
X-UUID: 2a504c1d045b4dc1aa5c26d057c2e21c-20201006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VecbbSPzO8pFOpEeHf5BylriZHlXVPRwNmcW3hbUEHQ=;
        b=UDrCpQnBHIMHt/K8P2JbIBXFU+4q8tg1pf2wnNPxgqRGDFl4DnYl44eY9ZB3dNyfc7AV2G0TRZs7OhBsNdlsPreWvQT4xi8a3/rliO1Tq710+65cPnUOXCECXNMTKJQXSm7VlJsvtXel0dO/++wNLI+nyLLtX0XkQv4Arg2R9gQ=;
X-UUID: 2a504c1d045b4dc1aa5c26d057c2e21c-20201006
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 328509663; Tue, 06 Oct 2020 01:17:19 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 6 Oct 2020 01:17:17 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 6 Oct 2020 01:17:15 +0800
Message-ID: <1601918237.17256.3.camel@mtksdccf07>
Subject: Re: [PATCH] [PATCH] of_reserved_mem: Increase the number of
 reserved regions
From:   Phil Chang <phil.chang@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Alix Wu <alix.wu@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Liu <joe.liu@mediatek.com>,
        Frank Rowand <frowand.list@gmail.com>
Date:   Tue, 6 Oct 2020 01:17:17 +0800
In-Reply-To: <CAAOTY_8vCb-adkbpdmbTWLeOFt-+dHjr4HVonHX7XPkLkzy1yA@mail.gmail.com>
References: <20201004055024.23542-1-phil.chang@mediatek.com>
         <CAAOTY_8vCb-adkbpdmbTWLeOFt-+dHjr4HVonHX7XPkLkzy1yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 1971EF7FADA804FD4DEB0317AF4ED35E219F726F439E90C354A0E8A7BE6052DD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bi1LdWFuZw0KDQpTb3JyeSBmb3IgdHlwby4gSW4gZmFjdCwgdGhlIGR0cyBvZiBuZXcg
U29DIGlzIG5vdCB1cHN0cmVhbSB5ZXQuIEknbSBzbw0Kc29ycnkgZm9yIGNvdWxkbid0IHNob3cg
dGhlIGRldGFpbCBub3cuDQoNCkhvdyBhYm91dCB0aGUgY29uZmlndXJhYmxlIE1BWF9SRVNFUlZF
RF9SRUdJT05TIHNpemUgbGlrZSB0aGlzIHBhdGNoPw0KaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wYXRjaC8xMDY5MjEwMS8NCg0KIA0KT24gU3VuLCAyMDIwLTEwLTA0IGF0IDIxOjA1ICsw
ODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0KPiBIaSwgUGhpbDoNCj4gDQo+IFBoaWwgQ2hhbmcg
PHBoaWwuY2hhbmdAbWVkaWF0ZWsuY29tPiDmlrwgMjAyMOW5tDEw5pyINOaXpSDpgLHml6Ug5LiL
5Y2IMTo1MeWvq+mBk++8mg0KPiA+DQo+ID4gQ2VydGFpbiBTb0NzIG5lZWQgdG8gc3VwcG9ydCBs
YXJnZSBhbW91bnQgb2YgcmVzZXJ2ZWQgbWVtb3J5DQo+ID4gcmVnaW9ucywgZXNwZWNpYWxseSB0
byBmb2xsb3cgdGhlIEdLSSBydWxlcyBmcm9tIEdvb2dsZS4NCj4gPiBJbiBNVEsgbmV3IFNvQyBy
ZXF1aXJlcyBtb3JlIHRoYW4gNjggcmVnaW9ucyBvZiByZXNlcnZlZCBtZW1vcnkNCj4gPiBmb3Ig
ZWFjaCBJUCdzIHVzYWdlLCBzdWNoIGFzIGxvYWQgZmlybXdhcmUgdG8gc3BlY2lmaWMgc2FwY2Us
DQo+IA0KPiBzcGFjZQ0KPiANCj4gPiBzbyB0aGF0IG5lZWQgdG8gcmVzZXJ2ZSBtb3JlIHJlZ2lz
aW9ucw0KPiANCj4gcmVnaW9ucy4NCj4gDQo+IEkgZ3Vlc3MgdGhpcyByZXF1aXJlbWVudCBpcyBm
cm9tIE1lZGlhdGVrIFNvQywgYnV0IEkgZmluZCBiZWxvdyBkZXZpY2UNCj4gdHJlZSBhbmQganVz
dCBmaW5kIG9uZSByZXNlcnZlZCBtZW1vcnkgcmVnaW9uLA0KPiANCj4gYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaQ0KPiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE3My5kdHNpDQo+IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4NTE2LmR0c2kN
Cj4gDQo+IENvdWxkIHlvdSBzaG93IG1lIHRoZSA2OCByZWdpb25zPw0KPiANCj4gUmVnYXJkcywN
Cj4gQ2h1bi1LdWFuZy4NCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2UgTGl1IDxqb2Uu
bGl1QG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBZSiBDaGlhbmcgPHlqLmNoaWFu
Z0BtZWRpYXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWxpeCBXdSA8YWxpeC53dUBtZWRp
YXRlay5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGhpbCBDaGFuZyA8cGhpbC5jaGFuZ0BtZWRp
YXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvb2Yvb2ZfcmVzZXJ2ZWRfbWVtLmMgfCAy
ICstDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvb2Yvb2ZfcmVzZXJ2ZWRfbWVtLmMgYi9kcml2
ZXJzL29mL29mX3Jlc2VydmVkX21lbS5jDQo+ID4gaW5kZXggNDZiOTM3MWM4YTMzLi41OTVmMDc0
MWRjZWYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9vZi9vZl9yZXNlcnZlZF9tZW0uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvb2Yvb2ZfcmVzZXJ2ZWRfbWVtLmMNCj4gPiBAQCAtMjIsNyArMjIsNyBA
QA0KPiA+ICAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvbWVt
YmxvY2suaD4NCj4gPg0KPiA+IC0jZGVmaW5lIE1BWF9SRVNFUlZFRF9SRUdJT05TICAgNjQNCj4g
PiArI2RlZmluZSBNQVhfUkVTRVJWRURfUkVHSU9OUyAgIDEyOA0KPiA+ICBzdGF0aWMgc3RydWN0
IHJlc2VydmVkX21lbSByZXNlcnZlZF9tZW1bTUFYX1JFU0VSVkVEX1JFR0lPTlNdOw0KPiA+ICBz
dGF0aWMgaW50IHJlc2VydmVkX21lbV9jb3VudDsNCj4gPg0KPiA+IC0tDQo+ID4gMi4xOC4wDQo+
ID4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBM
aW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZy
YWRlYWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1tZWRpYXRlaw0KDQo=

