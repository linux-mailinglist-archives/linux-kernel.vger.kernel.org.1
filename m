Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377B72EBCA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbhAFKrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:47:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57087 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbhAFKrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:47:55 -0500
X-UUID: 9a90d2619b884c56b03611e7c5395bd2-20210106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=obJsRp4li4LM696iejTA2k4GIuIA3Rb79c+L7Cz67Y0=;
        b=D8Z+nW+tq0yXPx8TKmPHvZQuSD1lOEBcELE43bxvUmsCglzZVcySgsV1+Uhz0Ovf9NFYNcyNg4cQG+Cfw4mo1sR21cZT5ZnSlqeufA1Vw0CCEskbbB1ORtzfrDh9i6hi40hl7uAHI5FgcPV6haG9JWUTrTOiNM5cbDkDCGXawNM=;
X-UUID: 9a90d2619b884c56b03611e7c5395bd2-20210106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1690019796; Wed, 06 Jan 2021 18:42:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 6 Jan 2021 18:42:01 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 6 Jan 2021 18:42:01 +0800
Message-ID: <1609929721.7491.3.camel@mtksdaap41>
Subject: Re: [PATCH v6 10/22] clk: mediatek: Add MT8192 basic clocks support
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 6 Jan 2021 18:42:01 +0800
In-Reply-To: <CAATdQgC_BnZywDxaZgmF72VRoAZ-1vFGrPD9GL4uEBhsKQTxnQ@mail.gmail.com>
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
         <1608642587-15634-11-git-send-email-weiyi.lu@mediatek.com>
         <CAATdQgC_BnZywDxaZgmF72VRoAZ-1vFGrPD9GL4uEBhsKQTxnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIxLTAxLTA2IGF0IDE4OjI1ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gVHVlLCBEZWMgMjIsIDIwMjAgYXQgOToxNCBQTSBXZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0
ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBNVDgxOTIgYmFzaWMgY2xvY2sgcHJvdmlkZXJz
LCBpbmNsdWRlIHRvcGNrZ2VuLCBhcG1peGVkc3lzLA0KPiA+IGluZnJhY2ZnIGFuZCBwZXJpY2Zn
Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpeWkgTHUgPHdlaXlpLmx1QG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvS2NvbmZpZyAgICAgIHwgICAg
OCArDQo+ID4gIGRyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlICAgICB8ICAgIDEgKw0KPiA+
ICBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTkyLmMgfCAxMzI2ICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW11
eC5oICAgIHwgICAxNSArDQo+ID4gIDQgZmlsZXMgY2hhbmdlZCwgMTM1MCBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTky
LmMNCj4gPg0KPiANCj4gPHNuaXA+DQo+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9t
ZWRpYXRlay9jbGstbXV4LmggYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXV4LmgNCj4gPiBp
bmRleCBmNTYyNWY0Li5hZmJjN2RmIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlh
dGVrL2Nsay1tdXguaA0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdXguaA0K
PiA+IEBAIC03Nyw2ICs3NywyMSBAQCBzdHJ1Y3QgbXRrX211eCB7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgX3dpZHRoLCBfZ2F0ZSwgX3VwZF9vZnMsIF91cGQsICAgICAgICAgICAgICAg
ICAgXA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIENMS19TRVRfUkFURV9QQVJFTlQpDQo+
ID4NCj4gPiArI2RlZmluZSBNVVhfQ0xSX1NFVF9VUERfRkxBR1MoX2lkLCBfbmFtZSwgX3BhcmVu
dHMsIF9tdXhfb2ZzLCAgICAgICAgICBcDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX211
eF9zZXRfb2ZzLCBfbXV4X2Nscl9vZnMsIF9zaGlmdCwgX3dpZHRoLCAgICAgXA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgIF91cGRfb2ZzLCBfdXBkLCBfZmxhZ3MpICAgICAgICAgICAgICAg
ICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgR0FURV9DTFJfU0VUX1VQRF9GTEFHUyhf
aWQsIF9uYW1lLCBfcGFyZW50cywgX211eF9vZnMsICBcDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgX211eF9zZXRfb2ZzLCBfbXV4X2Nscl9vZnMsIF9zaGlmdCwgX3dpZHRoLCAgICAgXA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgIDAsIF91cGRfb2ZzLCBfdXBkLCBfZmxhZ3MsICAg
ICAgICAgICAgICAgICAgICAgIFwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBtdGtfbXV4
X2Nscl9zZXRfdXBkX29wcykNCj4gPiArDQo+ID4gKyNkZWZpbmUgTVVYX0NMUl9TRVRfVVBEKF9p
ZCwgX25hbWUsIF9wYXJlbnRzLCBfbXV4X29mcywgICAgICAgICAgICAgICAgICAgICAgICBcDQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX211eF9zZXRfb2ZzLCBfbXV4X2Nscl9vZnMsIF9z
aGlmdCwgX3dpZHRoLCAgICAgXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIF91cGRfb2Zz
LCBfdXBkKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiArICAgICAgICAg
ICAgICAgTVVYX0NMUl9TRVRfVVBEX0ZMQUdTKF9pZCwgX25hbWUsIF9wYXJlbnRzLCAgICAgICAg
ICAgICBcDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgX211eF9vZnMsIF9tdXhfc2V0X29m
cywgX211eF9jbHJfb2ZzLCBfc2hpZnQsICAgXA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IF93aWR0aCwgX3VwZF9vZnMsIF91cGQsIENMS19TRVRfUkFURV9QQVJFTlQpDQo+ID4gKw0KPiAN
Cj4gY29uZmxpY3RzLCB0aGVzZSBtYWNyb3MgYXJlIGFscmVhZHkgZXhpc3RlZCBpbiB1cHN0cmVh
bS4NCg0KcmVhbGx5PyBUaGVzZSB0d28gbWFjcm9zIGRvbid0IHNob3cgdXAgaW4gNS4xMS1yYzEg
eWV0Lg0KDQo+ID4gIHN0cnVjdCBjbGsgKm10a19jbGtfcmVnaXN0ZXJfbXV4KGNvbnN0IHN0cnVj
dCBtdGtfbXV4ICptdXgsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHJlZ21hcCAqcmVnbWFwLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNwaW5sb2NrX3QgKmxvY2spOw0KPiA+IC0tDQo+ID4gMS44LjEuMS5kaXJ0eQ0KPiA+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4gTGludXgtbWVk
aWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
bWVkaWF0ZWsNCg0K

