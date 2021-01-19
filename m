Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFD12FAEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:58:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbhASC50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:57:26 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:17490 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387973AbhASC5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:57:16 -0500
X-UUID: e165cddc991e4dd195f45c397e2129f0-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kxFyn1AZxhKqZ1SIYi6HYqKFC/zDiZFn6yPxE4yDwMk=;
        b=q8fdSLHWp7oxoB+hml8Rh7xLFU/ZoLq3mona/InyqrCAdfx2LO2ItCrWLUfKyM9olbqUvpb6jBR8B1SkhMlQNnDhtWkiW00BTrGj8Ly7X7r7bxTmvI79TbBq+Rz87eWRQ6FtXuKH/o11OnvGHmbgYFMOxJrRiUhQxPmOSFJDEgM=;
X-UUID: e165cddc991e4dd195f45c397e2129f0-20210119
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1267694352; Tue, 19 Jan 2021 10:56:32 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 10:56:29 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 10:56:22 +0800
Message-ID: <1611024980.11995.19.camel@mhfsdcap03>
Subject: Re: [PATCH next 03/15] dt-bindings: phy: mediatek: dsi-phy: modify
 compatible dependence
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>
Date:   Tue, 19 Jan 2021 10:56:20 +0800
In-Reply-To: <CAAOTY_8FV87MTSi_Mc2MA3uWzCUBcpCC5Sne2Wc6X1R57EiCkw@mail.gmail.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
         <20210116090656.11752-3-chunfeng.yun@mediatek.com>
         <CAAOTY_8FV87MTSi_Mc2MA3uWzCUBcpCC5Sne2Wc6X1R57EiCkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E96D8BDB3A35A03C4C66CD2581F0D687AFBC8D69C347B6286F3A25F273C2236E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTE4IGF0IDIyOjU2ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgQ2h1bmZlbmc6DQo+IA0KPiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+IOaWvCAyMDIx5bm0MeaciDE25pelIOmAseWFrSDkuIvljYg1OjA35a+r6YGT77yaDQo+
ID4NCj4gPiBUaGUgY29tcGF0aWxiZSAibWVkaWF0ZWssbXQ3NjIzLW1pcGktdHgiIGlzIG5vdCBz
dXBwb3J0ZWQgaW4gZHJpdmVyLA0KPiA+IGFuZCBpbiBmYWN0IHVzZXMgIm1lZGlhdGVrLG10Mjcw
MS1taXBpLXR4IiBpbnN0ZWFkIG9uIE1UNzYyMywgc28gY2hhbmdlcw0KPiA+IHRoZSBjb21wYXRp
YmxlIGl0ZW1zIHRvIG1ha2UgZGVwZW5kZW5jZSBjbGVhci4NCj4gPg0KPiA+IEFuZCBhZGQgYW4g
b3B0aW9uYWwgImNsb2NrLW5hbWVzIiBwcm9wZXJ0eSwgaXQncyBub3QgdXNlZCB0byBnZXQgdGhl
IGNsb2NrLA0KPiA+IGJ1dCBzb21lIERUUyBmaWxlcyBwcm92aWRlIGl0Lg0KPiANCj4gU2VwYXJh
dGUgdGhlIGNsb2NrIHBhcnQgdG8gYW5vdGhlciBwYXRjaC4NCk9rLCB3aWxsIGRvIGl0Lg0KDQo+
IA0KPiBSZWdhcmRzLA0KPiBDaHVuLUt1YW5nLg0KPiANCj4gPg0KPiA+IENjOiBDaHVuLUt1YW5n
IEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCj4gPiBDYzogUGhpbGlwcCBaYWJlbCA8cC56
YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9iaW5kaW5ncy9waHkv
bWVkaWF0ZWssZHNpLXBoeS55YW1sICAgICAgICAgIHwgMTcgKysrKysrKysrKysrLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9t
ZWRpYXRlayxkc2ktcGh5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGh5L21lZGlhdGVrLGRzaS1waHkueWFtbA0KPiA+IGluZGV4IDcxZDRhY2VhMWY2Ni4uYWY2ZTU1
NGM1YjY5IDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5LnlhbWwNCj4gPiBAQCAtMTksMTEg
KzE5LDE0IEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBwYXR0ZXJuOiAiXmRzaS1waHlAWzAtOWEt
Zl0rJCINCj4gPg0KPiA+ICAgIGNvbXBhdGlibGU6DQo+ID4gLSAgICBlbnVtOg0KPiA+IC0gICAg
ICAtIG1lZGlhdGVrLG10MjcwMS1taXBpLXR4DQo+ID4gLSAgICAgIC0gbWVkaWF0ZWssbXQ3NjIz
LW1pcGktdHgNCj4gPiAtICAgICAgLSBtZWRpYXRlayxtdDgxNzMtbWlwaS10eA0KPiA+IC0gICAg
ICAtIG1lZGlhdGVrLG10ODE4My1taXBpLXR4DQo+ID4gKyAgICBvbmVPZjoNCj4gPiArICAgICAg
LSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIG1l
ZGlhdGVrLG10NzYyMy1taXBpLXR4DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxt
dDI3MDEtbWlwaS10eA0KPiA+ICsgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDI3MDEtbWlwaS10
eA0KPiA+ICsgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxNzMtbWlwaS10eA0KPiA+ICsgICAg
ICAtIGNvbnN0OiBtZWRpYXRlayxtdDgxODMtbWlwaS10eA0KPiA+DQo+ID4gICAgcmVnOg0KPiA+
ICAgICAgbWF4SXRlbXM6IDENCj4gPiBAQCAtMzIsNiArMzUsMTAgQEAgcHJvcGVydGllczoNCj4g
PiAgICAgIGl0ZW1zOg0KPiA+ICAgICAgICAtIGRlc2NyaXB0aW9uOiBQTEwgcmVmZXJlbmNlIGNs
b2NrDQo+ID4NCj4gPiArICBjbG9jay1uYW1lczoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAg
ICAtIGNvbnN0OiByZWYNCj4gPiArDQo+ID4gICAgY2xvY2stb3V0cHV0LW5hbWVzOg0KPiA+ICAg
ICAgbWF4SXRlbXM6IDENCj4gPg0KPiA+IC0tDQo+ID4gMi4xOC4wDQoNCg==

