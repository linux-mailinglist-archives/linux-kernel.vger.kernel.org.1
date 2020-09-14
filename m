Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B322686D1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgINIHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:07:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:30398 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726122AbgINIFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:05:36 -0400
X-UUID: bebf9c19301442118425eecf8e76361d-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=o4+81MO/aJXsuzsrMQotH3ExSOvHSioLCD4f6dFJz2w=;
        b=l6FCLiA7CJi3pAqSW4Cxm/8GBgjW4L6Ft2+GXzUAVTo5Y51qYZWyjZPjj+vUJqg7T/QEgu2STC017M8xWY2DUtZLSqt6psW2BkyPoq7AK/pReqqWCYd5BgAEl3EiVl7uzo/4tXOEiWnCvy13/3lk3DmBtYZU3midJqY7LytMqpc=;
X-UUID: bebf9c19301442118425eecf8e76361d-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 49461636; Mon, 14 Sep 2020 16:05:26 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Sep
 2020 16:05:24 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 16:05:21 +0800
Message-ID: <1600070601.27773.14.camel@mhfsdcap03>
Subject: Re: [PATCH v4 3/3] iommu/mediatek: add support for MT8167
From:   Yong Wu <yong.wu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>
Date:   Mon, 14 Sep 2020 16:03:21 +0800
In-Reply-To: <20200907101649.1573134-3-fparent@baylibre.com>
References: <20200907101649.1573134-1-fparent@baylibre.com>
         <20200907101649.1573134-3-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2B396821207B0DA67FA40430B531D336757789FCC3ACCCB9E04E67630009AD4F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTA3IGF0IDEyOjE2ICswMjAwLCBGYWJpZW4gUGFyZW50IHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgdGhlIElPTU1VIG9uIE1UODE2Nw0KPiANCj4gU2lnbmVkLW9mZi1i
eTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJyZS5jb20+DQoNClJldmlld2VkLWJ5OiBZ
b25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg0KPiAtLS0NCj4gDQo+IFY0Ow0KPiAJKiBS
ZW1vdmVkIEhBU180R0JfTU9ERSBmbGFnIHNpbmNlIHRoaXMgU29DIGRvZXMgbm90IHNlZW0gdG8g
c3VwcG9ydCBpdA0KPiBWMzoNCj4gCSogdXNlIExFR0FDWV9JVlJQX1BBRERSIGZsYWcgaW5zdGVh
ZCBvZiB1c2luZyBhIHBsYXRmb3JtIGRhdGEgbWVtYmVyDQo+IFYyOg0KPiAJKiByZW1vdmVkIGlm
IGJhc2VkIG9uIG00dV9wbGF0LCBhbmQgdXNpbmcgaW5zdGVhZCB0aGUgbmV3DQo+IAkgIGhhc19s
ZWdhY3lfaXZycF9wYWRkciBtZW1iZXIgdGhhdCB3YXMgaW50cm9kdWNlZCBpbiBwYXRjaCAyLg0K
PiANCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgOCArKysrKysrKw0KPiAg
ZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCB8IDEgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
IGIvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiBpbmRleCBiMWY4NWE3ZTkzNDYuLjRmZjA3
MWViNTI3OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYw0KPiArKysg
Yi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IEBAIC04MTcsNiArODE3LDEzIEBAIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDY3NzlfZGF0YSA9IHsNCj4gIAku
bGFyYmlkX3JlbWFwICA9IHt7MH0sIHsxfSwgezJ9LCB7M30sIHs1fSwgezcsIDh9LCB7MTB9LCB7
OX19LA0KPiAgfTsNCj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9k
YXRhIG10ODE2N19kYXRhID0gew0KPiArCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTY3LA0KPiAr
CS5mbGFncyAgICAgICAgPSBSRVNFVF9BWEkgfCBIQVNfTEVHQUNZX0lWUlBfUEFERFIsDQo+ICsJ
Lmludl9zZWxfcmVnICA9IFJFR19NTVVfSU5WX1NFTF9HRU4xLA0KPiArCS5sYXJiaWRfcmVtYXAg
PSB7ezB9LCB7MX0sIHsyfX0sIC8qIExpbmVhciBtYXBwaW5nLiAqLw0KPiArfTsNCj4gKw0KPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE3M19kYXRhID0gew0K
PiAgCS5tNHVfcGxhdCAgICAgPSBNNFVfTVQ4MTczLA0KPiAgCS5mbGFncwkgICAgICA9IEhBU180
R0JfTU9ERSB8IEhBU19CQ0xLIHwgUkVTRVRfQVhJIHwNCj4gQEAgLTgzNSw2ICs4NDIsNyBAQCBz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTgzX2RhdGEgPSB7DQo+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfaW9tbXVfb2ZfaWRzW10gPSB7
DQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItbTR1IiwgLmRhdGEgPSAmbXQy
NzEyX2RhdGF9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LW00dSIsIC5k
YXRhID0gJm10Njc3OV9kYXRhfSwNCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE2
Ny1tNHUiLCAuZGF0YSA9ICZtdDgxNjdfZGF0YX0sDQo+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxNzMtbTR1IiwgLmRhdGEgPSAmbXQ4MTczX2RhdGF9LA0KPiAgCXsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTgzLW00dSIsIC5kYXRhID0gJm10ODE4M19kYXRhfSwNCj4gIAl7
fQ0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuaCBiL2RyaXZlcnMvaW9t
bXUvbXRrX2lvbW11LmgNCj4gaW5kZXggMTIyOTI1ZGJlNTQ3Li5kZjMyYjNlMzQwOGIgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmgNCj4gKysrIGIvZHJpdmVycy9pb21t
dS9tdGtfaW9tbXUuaA0KPiBAQCAtMzksNiArMzksNyBAQCBlbnVtIG10a19pb21tdV9wbGF0IHsN
Cj4gIAlNNFVfTVQyNzAxLA0KPiAgCU00VV9NVDI3MTIsDQo+ICAJTTRVX01UNjc3OSwNCj4gKwlN
NFVfTVQ4MTY3LA0KPiAgCU00VV9NVDgxNzMsDQo+ICAJTTRVX01UODE4MywNCj4gIH07DQoNCg==

