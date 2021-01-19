Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98DC2FAEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 03:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394756AbhASC6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 21:58:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:5392 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728406AbhASC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 21:58:26 -0500
X-UUID: 4aa5831c37c94efc9917aa7cfb334fbd-20210119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=y0UZs5dA/PPpNGMkAHG+Gh9GacqKAGQOXUeOBfQ5b04=;
        b=loSxy2IcmD66TQ9ppfty/Nerq5zYx78/xOPX6hsCcpVYoXOzx4EGEGufiV7FW04P/Fy+7ndNwEe9B4yygUG0eBV6cFRWVzC0ZYYNv0rGfjnLQQSwBwaQ/Tk3lo6k3S3MMULhmTmw4IisitOfbqytCYZSgynbzsVkoWinlCe09J0=;
X-UUID: 4aa5831c37c94efc9917aa7cfb334fbd-20210119
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1526855402; Tue, 19 Jan 2021 10:57:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 Jan
 2021 10:57:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Jan 2021 10:57:23 +0800
Message-ID: <1611025043.11995.20.camel@mhfsdcap03>
Subject: Re: [PATCH next 04/15] dt-bindings: phy: mediatek: hdmi-phy: modify
 compatible items
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
Date:   Tue, 19 Jan 2021 10:57:23 +0800
In-Reply-To: <CAAOTY__DtGc85JNyxWcebof5h3_Os2ugyy1P0jZsOs0Yzj2miw@mail.gmail.com>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
         <20210116090656.11752-4-chunfeng.yun@mediatek.com>
         <CAAOTY__DtGc85JNyxWcebof5h3_Os2ugyy1P0jZsOs0Yzj2miw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 37AC6E5033AF9021B31736C14DAFE0ED9E6A0ACFA4071DDEED4904F8820B42AC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAxLTE4IGF0IDIzOjA1ICswODAwLCBDaHVuLUt1YW5nIEh1IHdyb3RlOg0K
PiBIaSwgQ2h1bmZlbmc6DQo+IA0KPiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRl
ay5jb20+IOaWvCAyMDIx5bm0MeaciDE25pelIOmAseWFrSDkuIvljYg1OjA35a+r6YGT77yaDQo+
ID4NCj4gPiBUaGUgY29tcGF0aWxiZSAibWVkaWF0ZWssbXQ3NjIzLWhkbWktdHgiIGlzIG5vdCBz
dXBwb3J0ZWQgaW4gZHJpdmVyLA0KPiA+IGFuZCBpbiBmYWN0IHVzZXMgIm1lZGlhdGVrLG10Mjcw
MS1oZG1pLXR4IiBpbnN0ZWFkIG9uIE1UNzYyMywgc28gY2hhbmdlcw0KPiA+IHRoZSBjb21wYXRp
YmxlIGl0ZW1zIHRvIG1ha2UgZGVwZW5kZW5jZSBjbGVhci4NCj4gPg0KPiA+IENjOiBDaHVuLUt1
YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4NCj4gPiBDYzogUGhpbGlwcCBaYWJlbCA8
cC56YWJlbEBwZW5ndXRyb25peC5kZT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4g
PGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3BoeS9tZWRpYXRlayxoZG1pLXBoeS55YW1sICAgIHwgMTEgKysrKysrKy0tLS0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5
L21lZGlhdGVrLGhkbWktcGh5LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwNCj4gPiBpbmRleCA0NzUyNTE3YTE0NDYuLjBk
OTQ5NTBiODRjYSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLGhkbWktcGh5LnlhbWwNCj4gPiBAQCAt
MjEsMTAgKzIxLDEzIEBAIHByb3BlcnRpZXM6DQo+ID4gICAgICBwYXR0ZXJuOiAiXmhkbWktcGh5
QFswLTlhLWZdKyQiDQo+ID4NCj4gPiAgICBjb21wYXRpYmxlOg0KPiA+IC0gICAgZW51bToNCj4g
PiAtICAgICAgLSBtZWRpYXRlayxtdDI3MDEtaGRtaS1waHkNCj4gPiAtICAgICAgLSBtZWRpYXRl
ayxtdDc2MjMtaGRtaS1waHkNCj4gPiAtICAgICAgLSBtZWRpYXRlayxtdDgxNzMtaGRtaS1waHkN
Cj4gPiArICAgIG9uZU9mOg0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBl
bnVtOg0KPiA+ICsgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ3NjIzLWhkbWktcGh5DQo+ID4g
KyAgICAgICAgICAtIGNvbnN0OiBtZWRpYXRlayxtdDI3MDEtaGRtaS1waHkNCj4gPiArICAgICAg
LSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLWhkbWktcGh5DQo+ID4gKyAgICAgIC0gY29uc3Q6IG1l
ZGlhdGVrLG10ODE3My1oZG1pLXBoeQ0KPiA+DQo+IA0KPiBJIGxpa2UgbW92ZSAnaXRlbXMnIHRv
IHRoZSBib3R0b20uDQpJIGZvbGxvdyB0aGUgc2FtZSBzdHlsZSBhcyBvdGhlciBiaW5kaW5ncw0K
DQo+IA0KPiAtIGNvbnN0OiBtZWRpYXRlayxtdDI3MDEtaGRtaS1waHkNCj4gLSBjb25zdDogbWVk
aWF0ZWssbXQ4MTczLWhkbWktcGh5DQo+IA0KPiAtIGl0ZW1zOg0KPiAgIC0gZW51bToNCj4gICAg
ICAgLSBtZWRpYXRlayxtdDc2MjMtaGRtaS1waHkNCj4gICAtIGNvbnN0OiBtZWRpYXRlayxtdDI3
MDEtaGRtaS1waHkNCj4gDQo+IFJlZ2FyZHMsDQo+IENodW4tS3VhbmcuDQo+IA0KPiA+ICAgIHJl
ZzoNCj4gPiAgICAgIG1heEl0ZW1zOiAxDQo+ID4gLS0NCj4gPiAyLjE4LjANCg0K

