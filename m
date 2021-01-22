Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E572FFCCD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 07:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbhAVGaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 01:30:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59275 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726977AbhAVG3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:29:25 -0500
X-UUID: 9d6240ae4fc242a597856c57dd3fbfba-20210122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=a0rTMIFWNhk4fs2TtcDCGY9yzd82v4FlQ9IFV80sxHw=;
        b=rGS4MfrO6UxPnX9KpApF9R8LGFPhVVtwNTFRr3AZY6vuI7yaO0+K5c5qaojB5n68agLAlCMr3dP2U8LDuNT6flT/zJQ0jy+0IhsjYRtSmVsXjke98EKvCLga+/7Rs5xucozUBenT740KfjpGLAiF+N7rT9jn98S/eRd9drhrmug=;
X-UUID: 9d6240ae4fc242a597856c57dd3fbfba-20210122
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yz.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 580443827; Fri, 22 Jan 2021 14:28:33 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Jan 2021 14:28:31 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Jan 2021 14:28:31 +0800
Message-ID: <1611296911.30262.5.camel@mtksdccf07>
Subject: Re: [PATCH v3 1/2] dt-bindings: nvmem: mediatek: add support for
 MediaTek mt8192 SoC
From:   mtk23264 <Yz.Wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Seiya Wang <seiya.wang@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 22 Jan 2021 14:28:31 +0800
In-Reply-To: <20210103162540.GA3983563@robh.at.kernel.org>
References: <20201221061018.18503-1-Yz.Wu@mediatek.com>
         <20201221061018.18503-2-Yz.Wu@mediatek.com>
         <20210103162540.GA3983563@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTAzIGF0IDA5OjI1IC0wNzAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBEZWMgMjEsIDIwMjAgYXQgMDI6MTA6MTlQTSArMDgwMCwgWXouV3VAbWVkaWF0ZWsu
Y29tIHdyb3RlOg0KPiA+IEZyb206IFJ5YW4gV3UgPFl6Lld1QG1lZGlhdGVrLmNvbT4NCj4gPiAN
Cj4gPiBUaGlzIHVwZGF0ZXMgZHQtYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBNZWRpYVRlayBt
dDgxOTINCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSeWFuIFd1IDxZei5XdUBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gVGhpcyBwYXRjaCBpcyBiYXNlZCBvbiB2NS4xMC1yYzcuDQo+ID4g
LS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9tdGstZWZ1
c2UudHh0IHwgMSArDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZtZW0v
bXRrLWVmdXNlLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9udm1lbS9t
dGstZWZ1c2UudHh0DQo+ID4gaW5kZXggMDY2OGM0NWExNTZkLi5lMmYwYzBmMzRkMTAgMTAwNjQ0
DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL252bWVtL210ay1l
ZnVzZS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbnZt
ZW0vbXRrLWVmdXNlLnR4dA0KPiA+IEBAIC03LDYgKzcsNyBAQCBSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+ICAJICAgICAgIm1lZGlhdGVrLG10NzYyMi1lZnVzZSIsICJtZWRpYXRlayxlZnVzZSI6
IGZvciBNVDc2MjINCj4gPiAgCSAgICAgICJtZWRpYXRlayxtdDc2MjMtZWZ1c2UiLCAibWVkaWF0
ZWssZWZ1c2UiOiBmb3IgTVQ3NjIzDQo+ID4gIAkgICAgICAibWVkaWF0ZWssbXQ4MTczLWVmdXNl
IiBvciAibWVkaWF0ZWssZWZ1c2UiOiBmb3IgTVQ4MTczDQo+ID4gKwkgICAgICAibWVkaWF0ZWss
bXQ4MTkyLWVmdXNlIiBvciAibWVkaWF0ZWssZWZ1c2UiOiBmb3IgTVQ4MTkyDQo+IA0KPiBObywg
Im1lZGlhdGVrLGVmdXNlIiBieSBpdHNlbGYgaXMgb25seSBmb3IgTVQ4MTczLg0KSXMgaXQgc2hv
dWxkIGJlIG1vZGlmeSBmcm9tICJtZWRpYXRlayxtdDgxOTItZWZ1c2UiIG9yICJtZWRpYXRlayxl
ZnVzZSINCnRvICJtZWRpYXRlayxtdDgxOTItZWZ1c2UiLCAibWVkaWF0ZWssZWZ1c2UiID8NCg0K
UmVnYXJkcywNCll6DQo+IA0KPiA+ICAtIHJlZzogU2hvdWxkIGNvbnRhaW4gcmVnaXN0ZXJzIGxv
Y2F0aW9uIGFuZCBsZW5ndGgNCj4gPiAgDQo+ID4gID0gRGF0YSBjZWxscyA9DQo+ID4gLS0gDQo+
ID4gMi4xOC4wDQo+ID4gDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5nIGxpc3QNCj4gTGludXgtbWVk
aWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg==

