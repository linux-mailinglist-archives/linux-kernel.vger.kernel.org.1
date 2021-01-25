Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABDA302224
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbhAYG21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:28:27 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:6021 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726610AbhAYGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:22:37 -0500
X-UUID: a73e573b52af4bd3b8620a5507ebbc62-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=RkBjNee7qodbBjXWytdsq3tw/Ruzw7CJns/vlQiqKFU=;
        b=dGpOYdpYECfL8LZ64VOtCBZ+JPffM3Yau77hC7XAdz0QSDcg8G0M42c8dfj4z9ORACCfKdFQPvZmZXJULKeCzcQD2Vk3WYzUGhZBivSeL6oR6Rri6KRNf//gdVQKLXhwFWMLLKYfr4uQCQsrsujB7sCJFqLB1GLq9gdvBPzcJu8=;
X-UUID: a73e573b52af4bd3b8620a5507ebbc62-20210125
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 266813712; Mon, 25 Jan 2021 14:21:51 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 14:21:49 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 14:21:48 +0800
Message-ID: <1611555708.3905.5.camel@mhfsdcap03>
Subject: Re: [PATCH next v2 03/17] dt-bindings: phy: mediatek: dsi-phy:
 modify compatible dependence
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>
Date:   Mon, 25 Jan 2021 14:21:48 +0800
In-Reply-To: <CAAOTY_8X35EpvLiSOuNdj4dVu7KBocw9mhaKG4TJy24LizvHNg@mail.gmail.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
         <20210122120323.4337-3-chunfeng.yun@mediatek.com>
         <CAAOTY__O=z-AOo1RCRGfJYuSsXs1cUZgWFaTQz_3W_Tj=CeFBQ@mail.gmail.com>
         <CAAOTY_8X35EpvLiSOuNdj4dVu7KBocw9mhaKG4TJy24LizvHNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 33DF050E4937CAA986E03A517E71BC2F5B0404FC0D6422DC1121661C8FF5150C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDIxLTAxLTI0IGF0IDEyOjU2ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgQ2h1bmZlbmc6DQo+IA0KPiBDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVs
Lm9yZz4g5pa8IDIwMjHlubQx5pyIMjTml6Ug6YCx5pelIOS4i+WNiDEyOjQ35a+r6YGT77yaDQo+
ID4NCj4gPiBIaSwgQ2h1bmZlbmc6DQo+ID4NCj4gPiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1
bkBtZWRpYXRlay5jb20+IOaWvCAyMDIx5bm0MeaciDIy5pelIOmAseS6lCDkuIvljYg4OjA05a+r
6YGT77yaDQo+ID4gPg0KPiA+ID4gVGhlIGNvbXBhdGlsYmUgIm1lZGlhdGVrLG10NzYyMy1taXBp
LXR4IiBpcyBub3Qgc3VwcG9ydGVkIGluIGRyaXZlciwNCj4gPiA+IGFuZCBpbiBmYWN0IHVzZXMg
Im1lZGlhdGVrLG10MjcwMS1taXBpLXR4IiBpbnN0ZWFkIG9uIE1UNzYyMywgc28gY2hhbmdlcw0K
PiA+ID4gdGhlIGNvbXBhdGlibGUgaXRlbXMgdG8gbWFrZSBkZXBlbmRlbmNlIGNsZWFyLg0KPiA+
DQo+ID4gUmV2aWV3ZWQtYnk6IENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3Jn
Pg0KPiANCj4gU29ycnksIHBsZWFzZSByZW1vdmUgbXkgcmV2aWV3ZWQtYnkgdGFnLiBXZSBzaG91
bGQgbm90IGRlZmluZSB0aGUNCj4gYmluZGluZyBkb2N1bWVudCBhY2NvcmRpbmcgdG8gdGhlIGlt
cGxlbWVudGF0aW9uIG9mIGRyaXZlci4gV2UgZGVmaW5lDQo+IHRoZSBiaW5kaW5nIGRvY3VtZW50
IGFjY29yZGluZyB0byB0aGUgaGFyZHdhcmUuIFNvIHRoZSBkZXNjcmlwdGlvbg0KPiBzaG91bGQg
YmUgbGlrZSAibXQ3NjIzLW1pcGktdHggaXMgY29tcGF0aWJsZSB0byBtdDI3MDEtbWlwaS10eCIu
DQpPaywgd2lsbCBtYWtlIHRoZSBkZXNjcmlwdGlvbiBjbGVhcmVyDQoNCj4gDQo+IFJlZ2FyZHMs
DQo+IENodW4tS3VhbmcuDQo+IA0KPiA+DQo+ID4gPg0KPiA+ID4gQ2M6IENodW4tS3VhbmcgSHUg
PGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KPiA+ID4gQ2M6IFBoaWxpcHAgWmFiZWwgPHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNo
dW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IHYyOiBzZXBhcmF0ZSB0
d28gcGF0Y2hlcyBzdWdnZXN0ZWQgYnkgQ0sNCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5LnlhbWwgICB8IDEzICsrKysrKysrLS0t
LS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygt
KQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQo+ID4gPiBpbmRleCA3MWQ0YWNl
YTFmNjYuLjZlNGQ3OTVmOWIwMiAxMDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQo+ID4gPiArKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGRzaS1waHkueWFt
bA0KPiA+ID4gQEAgLTE5LDExICsxOSwxNCBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgICBwYXR0
ZXJuOiAiXmRzaS1waHlAWzAtOWEtZl0rJCINCj4gPiA+DQo+ID4gPiAgICBjb21wYXRpYmxlOg0K
PiA+ID4gLSAgICBlbnVtOg0KPiA+ID4gLSAgICAgIC0gbWVkaWF0ZWssbXQyNzAxLW1pcGktdHgN
Cj4gPiA+IC0gICAgICAtIG1lZGlhdGVrLG10NzYyMy1taXBpLXR4DQo+ID4gPiAtICAgICAgLSBt
ZWRpYXRlayxtdDgxNzMtbWlwaS10eA0KPiA+ID4gLSAgICAgIC0gbWVkaWF0ZWssbXQ4MTgzLW1p
cGktdHgNCj4gPiA+ICsgICAgb25lT2Y6DQo+ID4gPiArICAgICAgLSBpdGVtczoNCj4gPiA+ICsg
ICAgICAgICAgLSBlbnVtOg0KPiA+ID4gKyAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDc2MjMt
bWlwaS10eA0KPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDI3MDEtbWlwaS10
eA0KPiA+ID4gKyAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10MjcwMS1taXBpLXR4DQo+ID4gPiAr
ICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTczLW1pcGktdHgNCj4gPiA+ICsgICAgICAtIGNv
bnN0OiBtZWRpYXRlayxtdDgxODMtbWlwaS10eA0KPiA+ID4NCj4gPiA+ICAgIHJlZzoNCj4gPiA+
ICAgICAgbWF4SXRlbXM6IDENCj4gPiA+IC0tDQo+ID4gPiAyLjE4LjANCg0K

