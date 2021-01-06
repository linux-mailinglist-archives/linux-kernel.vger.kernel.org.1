Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A592EBCFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 12:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbhAFLH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 06:07:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40497 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbhAFLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 06:07:25 -0500
X-UUID: 4fb99a6a114c48d8b66be8a55556fefa-20210106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=n9cbyTnLxMK+R+ro/xTvxzqRxwAZT51mv8Otnd9uK/Y=;
        b=eHNCDuHT350CtdZlegNZKGBJhcGJ3xVUW2TfteeJKe+3MBZOS/AYr70qzKPaDtDmCvV3U0+l121ljhkKUM5Ggz4e5cLhJqGiSqEXXdyQMhNO1fjbelka/QMUiOGaMroEAkSblFTLxp0QpwwzvgTkrbeGoMTBsTIjF2g26sgzPoY=;
X-UUID: 4fb99a6a114c48d8b66be8a55556fefa-20210106
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1295500764; Wed, 06 Jan 2021 19:06:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 19:06:36 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Jan 2021 19:06:36 +0800
Message-ID: <1609931196.30620.3.camel@mtksdaap41>
Subject: Re: [PATCH v6 10/22] clk: mediatek: Add MT8192 basic clocks support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Rob Herring <robh@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-clk@vger.kernel.org>
Date:   Wed, 6 Jan 2021 19:06:36 +0800
In-Reply-To: <CAATdQgBJ7EVRJW7iJG63yW89fh5skpe9-UCd4pdZystV_JrvCg@mail.gmail.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
         <1608642587-15634-11-git-send-email-weiyi.lu@mediatek.com>
         <CAATdQgC_BnZywDxaZgmF72VRoAZ-1vFGrPD9GL4uEBhsKQTxnQ@mail.gmail.com>
         <1609929721.7491.3.camel@mtksdaap41>
         <CAATdQgBJ7EVRJW7iJG63yW89fh5skpe9-UCd4pdZystV_JrvCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTA2IGF0IDE4OjUyICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gV2VkLCBKYW4gNiwgMjAyMSBhdCA2OjQyIFBNIFdlaXlpIEx1IDx3ZWl5aS5sdUBtZWRpYXRl
ay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gV2VkLCAyMDIxLTAxLTA2IGF0IDE4OjI1ICswODAw
LCBJa2pvb24gSmFuZyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgRGVjIDIyLCAyMDIwIGF0IDk6MTQg
UE0gV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gPiA+DQo+ID4g
PiA+IEFkZCBNVDgxOTIgYmFzaWMgY2xvY2sgcHJvdmlkZXJzLCBpbmNsdWRlIHRvcGNrZ2VuLCBh
cG1peGVkc3lzLA0KPiA+ID4gPiBpbmZyYWNmZyBhbmQgcGVyaWNmZy4NCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNvbT4NCj4gPiA+
ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9LY29uZmlnICAgICAgfCAgICA4
ICsNCj4gPiA+ID4gIGRyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlICAgICB8ICAgIDEgKw0K
PiA+ID4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5Mi5jIHwgMTMyNiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBkcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstbXV4LmggICAgfCAgIDE1ICsNCj4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTM1
MCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10ODE5Mi5jDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gPHNuaXA+DQo+ID4g
Pg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW11eC5oIGIv
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW11eC5oDQo+ID4gPiA+IGluZGV4IGY1NjI1ZjQuLmFm
YmM3ZGYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdXgu
aA0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXV4LmgNCj4gPiA+ID4g
QEAgLTc3LDYgKzc3LDIxIEBAIHN0cnVjdCBtdGtfbXV4IHsNCj4gPiA+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgX3dpZHRoLCBfZ2F0ZSwgX3VwZF9vZnMsIF91cGQsICAgICAgICAgICAgICAg
ICAgXA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICBDTEtfU0VUX1JBVEVfUEFSRU5U
KQ0KPiA+ID4gPg0KPiA+ID4gPiArI2RlZmluZSBNVVhfQ0xSX1NFVF9VUERfRkxBR1MoX2lkLCBf
bmFtZSwgX3BhcmVudHMsIF9tdXhfb2ZzLCAgICAgICAgICBcDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIF9tdXhfc2V0X29mcywgX211eF9jbHJfb2ZzLCBfc2hpZnQsIF93aWR0aCwg
ICAgIFwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX3VwZF9vZnMsIF91cGQsIF9m
bGFncykgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ID4gPiArICAgICAgICAgICAgICAg
R0FURV9DTFJfU0VUX1VQRF9GTEFHUyhfaWQsIF9uYW1lLCBfcGFyZW50cywgX211eF9vZnMsICBc
DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIF9tdXhfc2V0X29mcywgX211eF9jbHJf
b2ZzLCBfc2hpZnQsIF93aWR0aCwgICAgIFwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgMCwgX3VwZF9vZnMsIF91cGQsIF9mbGFncywgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+
ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBtdGtfbXV4X2Nscl9zZXRfdXBkX29wcykNCj4g
PiA+ID4gKw0KPiA+ID4gPiArI2RlZmluZSBNVVhfQ0xSX1NFVF9VUEQoX2lkLCBfbmFtZSwgX3Bh
cmVudHMsIF9tdXhfb2ZzLCAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgX211eF9zZXRfb2ZzLCBfbXV4X2Nscl9vZnMsIF9zaGlmdCwgX3dp
ZHRoLCAgICAgXA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBfdXBkX29mcywgX3Vw
ZCkgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gPiA+ICsgICAgICAgICAg
ICAgICBNVVhfQ0xSX1NFVF9VUERfRkxBR1MoX2lkLCBfbmFtZSwgX3BhcmVudHMsICAgICAgICAg
ICAgIFwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX211eF9vZnMsIF9tdXhfc2V0
X29mcywgX211eF9jbHJfb2ZzLCBfc2hpZnQsICAgXA0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICBfd2lkdGgsIF91cGRfb2ZzLCBfdXBkLCBDTEtfU0VUX1JBVEVfUEFSRU5UKQ0KPiA+
ID4gPiArDQo+ID4gPg0KPiA+ID4gY29uZmxpY3RzLCB0aGVzZSBtYWNyb3MgYXJlIGFscmVhZHkg
ZXhpc3RlZCBpbiB1cHN0cmVhbS4NCj4gPg0KPiA+IHJlYWxseT8gVGhlc2UgdHdvIG1hY3JvcyBk
b24ndCBzaG93IHVwIGluIDUuMTEtcmMxIHlldC4NCj4gDQo+IHllcCwgbWF5YmUgdGhpcyBvbmU6
IGEzYWU1NDk5MTdmMSAiY2xrOiBtZWRpYXRlazogQWRkIG5ldyBjbGttdXggcmVnaXN0ZXIgQVBJ
Ig0KPiANCg0KVGhlIG5ldyBtYWNyb3MgaW4gdGhpcyBwYXRjaCBhcmUgZm9yIHRoZSBjbG9jayBN
VVggd2l0aG91dCBnYXRlIGNvbnRyb2wuDQpJdCdzIGEgbGl0dGxlIGRpZmZlcmVudCBmcm9tIHRo
b3NlIG11eCBtYWNyb3Mgd2l0aCBnYXRlIGNvbnRyb2wgaW4NCmEzYWU1NDk5MTdmMSAiY2xrOiBt
ZWRpYXRlazogQWRkIG5ldyBjbGttdXggcmVnaXN0ZXIgQVBJIg0KDQo+ID4NCj4gPiA+ID4gIHN0
cnVjdCBjbGsgKm10a19jbGtfcmVnaXN0ZXJfbXV4KGNvbnN0IHN0cnVjdCBtdGtfbXV4ICptdXgs
DQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCByZWdtYXAg
KnJlZ21hcCwNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Bpbmxv
Y2tfdCAqbG9jayk7DQo+ID4gPiA+IC0tDQo+ID4gPiA+IDEuOC4xLjEuZGlydHkNCj4gPiA+ID4g
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiA+ID4g
TGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gPiA+IExpbnV4LW1lZGlhdGVrQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gPiA+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0KPiA+DQo+ID4gX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxp
c3QNCj4gPiBMaW51eC1tZWRpYXRla0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRpYXRlaw0KDQo=

