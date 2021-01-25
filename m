Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F22630221E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbhAYGYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:24:41 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:56966 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727030AbhAYGUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:20:48 -0500
X-UUID: 476174a8f2af47edb003d7b346db0768-20210125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=BTFnfX9tvYF+UTisfH0CClcEuPKpZzWlTghgpfHyzAE=;
        b=WcJYyQ1C9QghVaMAGv3CgBsyHvJI8ysSc6dw/T/gx6d/RnT9gfFHMCDjpelP1apwY8Bwx+8YereNI1KjqMfQ3FpeuzUusAe5uJROyxahquX9g+g/YWoX0XaeUI6YzUKVPV8GaQdp+GzUPMrab9H0VWikNmXWFbdGpooGrE3G9Yo=;
X-UUID: 476174a8f2af47edb003d7b346db0768-20210125
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 938150992; Mon, 25 Jan 2021 14:19:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 25 Jan
 2021 14:19:19 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Jan 2021 14:19:18 +0800
Message-ID: <1611555559.3905.2.camel@mhfsdcap03>
Subject: Re: [PATCH next v2 04/17] dt-bindings: phy: mediatek: dsi-phy: add
 optional clock-names
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DTML <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Min Guo <min.guo@mediatek.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 25 Jan 2021 14:19:19 +0800
In-Reply-To: <CAAOTY_84OF71QK6M5JT1M5YAFKED_xWVpx8B8t859OsVxE0cfQ@mail.gmail.com>
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com>
         <20210122120323.4337-4-chunfeng.yun@mediatek.com>
         <CAAOTY_84OF71QK6M5JT1M5YAFKED_xWVpx8B8t859OsVxE0cfQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3A0FC78E41D0B8BD472C347915E9404CB40430474059A1083A147199EE7783B72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIxLTAxLTIzIGF0IDA4OjE4ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgQ2h1bmZlbmc6DQo+IA0KPiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+IOaWvCAyMDIx5bm0MeaciDIy5pelIOmAseS6lCDkuIvljYg4OjA05a+r6YGT77yaDQo+
ID4NCj4gPiBBZGQgYW4gb3B0aW9uYWwgImNsb2NrLW5hbWVzIiBwcm9wZXJ0eSwgaXQncyBub3Qg
dXNlZCB0byBnZXQgdGhlIGNsb2NrLA0KPiA+IGJ1dCBzb21lIERUUyBmaWxlcyAoZS5nLiBtdDgx
ODMpIHByb3ZpZGUgaXQuDQo+IA0KPiBJIHRoaW5rIHRoZSBsb2dpYyBpcyB0aGF0IHdlIGRlZmlu
ZSBwcm9wZXJ0eSBpbiBiaW5kaW5nIGRvY3VtZW50DQo+IGZpcnN0LCBhbmQgdGhlbiB3cml0ZSBp
dCBpbiBkZXZpY2UgdHJlZS4gSWYgYSBwcm9wZXJ0eSBkb2VzIG5vdCBleGlzdA0KPiBpbiBiaW5k
aW5nIGRvY3VtZW50LCB3ZSBzaG91bGQgbm90IHdyaXRlIGl0IGluIGRldmljZSB0cmVlLiBTbyBs
ZXQncw0KPiBkcm9wIHRoaXMgcGF0Y2ggYW5kIHJlbW92ZSBjbG9jay1uYW1lcyBpbiBtdDgxODMu
ZHRzaS4NCk9rLCBJdCdzIGJldHRlciB0byByZW1vdmUgdW5uZWNlc3NhcnkgcHJvcGVydHkuDQoN
Cj4gDQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KPiA+DQo+ID4gQ2M6IENodW4tS3Vh
bmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPg0KPiA+IENjOiBQaGlsaXBwIFphYmVsIDxw
LnphYmVsQHBlbmd1dHJvbml4LmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8
Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjogbmV3IHBhdGNoIHNl
cGFyYXRlZCBmcm9tIFszLzE1XSBzdWdnZXN0ZWQgYnkgQ0sNCj4gPiAtLS0NCj4gPiAgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRpYXRlayxkc2ktcGh5LnlhbWwgfCA0
ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWss
ZHNpLXBoeS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9tZWRp
YXRlayxkc2ktcGh5LnlhbWwNCj4gPiBpbmRleCA2ZTRkNzk1ZjliMDIuLmFmNmU1NTRjNWI2OSAx
MDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21l
ZGlhdGVrLGRzaS1waHkueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9waHkvbWVkaWF0ZWssZHNpLXBoeS55YW1sDQo+ID4gQEAgLTM1LDYgKzM1LDEwIEBA
IHByb3BlcnRpZXM6DQo+ID4gICAgICBpdGVtczoNCj4gPiAgICAgICAgLSBkZXNjcmlwdGlvbjog
UExMIHJlZmVyZW5jZSBjbG9jaw0KPiA+DQo+ID4gKyAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICBp
dGVtczoNCj4gPiArICAgICAgLSBjb25zdDogcmVmDQo+ID4gKw0KPiA+ICAgIGNsb2NrLW91dHB1
dC1uYW1lczoNCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTguMA0K
PiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4g
TGludXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+ID4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5m
cmFkZWFkLm9yZw0KPiA+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbWVkaWF0ZWsNCg0K

