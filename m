Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0DC293318
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390628AbgJTCaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 22:30:21 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:41872 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390611AbgJTCaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 22:30:21 -0400
X-UUID: db9b1113f116439b854c52e598c87f49-20201020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Meq6SMM9NCGXd0ezAvIYe7RYnC+ZkZUEfKlU7K9AvO0=;
        b=Jk3PsQHlj1xArPyMeyfpnbKcv8E0Skq620YzqEKS9shjuBWWNJZWqErb2tm24GM+wS4C6G8/ukwDEe8ZVNSbxjmY5dFu9/aOllDD/Jt4gBV8GId/IksqGvsX39L3qbgzAxIKOxJf4PiuKEluxbRRrk3LDilcSIWnjKQ6af78HLc=;
X-UUID: db9b1113f116439b854c52e598c87f49-20201020
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1283119071; Tue, 20 Oct 2020 10:30:13 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Oct
 2020 10:30:10 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Oct 2020 10:30:10 +0800
Message-ID: <1603161010.29336.138.camel@mhfsdcap03>
Subject: Re: [PATCH v2 1/8] dt-bindings: phy: convert phy-mtk-xsphy.txt to
 YAML schema
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "CK Hu" <ck.hu@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Min Guo <min.guo@mediatek.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>
Date:   Tue, 20 Oct 2020 10:30:10 +0800
In-Reply-To: <20201016170003.GA1562276@bogus>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
         <20201016170003.GA1562276@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DBCCCD990EB25D087AF48EDB6BFB253E0AAAA7B568F8028A17DF86A16663C7DB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTE2IGF0IDEyOjAwIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBPY3QgMTMsIDIwMjAgYXQgMDQ6NTI6MDBQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IENvbnZlcnQgcGh5LW10ay14c3BoeS50eHQgdG8gWUFNTCBzY2hlbWEgbWVkaWF0
ZWsseHNwaHkueWFtbA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1biA8Y2h1
bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MjogbW9kaWZ5IGRlc2NyaXB0
aW9uIGFuZCBjb21wYXRpYmxlIGRlZmluaXRpb24gc3VnZ2VzdGVkIGJ5IFJvYg0KPiA+IC0tLQ0K
PiA+ICAuLi4vYmluZGluZ3MvcGh5L21lZGlhdGVrLHhzcGh5LnlhbWwgICAgICAgICAgfCAyMDAg
KysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHkt
bXRrLXhzcGh5LnR4dCB8IDEwOSAtLS0tLS0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjAw
IGluc2VydGlvbnMoKyksIDEwOSBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWsseHNwaHkueWFt
bA0KPiA+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BoeS9waHktbXRrLXhzcGh5LnR4dA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHhzcGh5LnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21lZGlhdGVrLHhzcGh5LnlhbWwNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uODY1MTFmMTky
NzdhDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9waHkvbWVkaWF0ZWsseHNwaHkueWFtbA0KPiA+IEBAIC0wLDAgKzEsMjAwIEBA
DQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKQ0KPiA+ICsjIENvcHlyaWdodCAoYykgMjAyMCBNZWRpYVRlaw0KPiA+ICslWUFNTCAx
LjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvcGh5
L21lZGlhdGVrLHhzcGh5LnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IE1lZGlhVGVrIFhT
LVBIWSBDb250cm9sbGVyIERldmljZSBUcmVlIEJpbmRpbmdzDQo+ID4gKw0KPiA+ICttYWludGFp
bmVyczoNCj4gPiArICAtIENodW5mZW5nIFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4N
Cj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4gKyAgVGhlIFhTLVBIWSBjb250cm9sbGVy
IHN1cHBvcnRzIHBoeXNpY2FsIGxheWVyIGZ1bmN0aW9uYWxpdHkgZm9yIFVTQjMuMQ0KPiA+ICsg
IEdFTjIgY29udHJvbGxlciBvbiBNZWRpYVRlayBTb0NzLg0KWy4uLl0NCj4gPiArDQo+ID4gKyAg
cmFuZ2VzOiB0cnVlDQo+ID4gKw0KPiA+ICsgIG1lZGlhdGVrLHNyYy1yZWYtY2xrLW1oejoNCj4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBGcmVxdWVuY3kgb2YgcmVmZXJlbmNlIGNs
b2NrIGZvciBzbGV3IHJhdGUgY2FsaWJyYXRlDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBl
cy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gDQo+IFByb3BlcnRpZXMgd2l0aCBhIHN0YW5k
YXJkIHVuaXQgc3VmZml4IGRvbid0IG5lZWQgYSB0eXBlLg0KT2ssIHdpbGwgcmVtb3ZlIGl0LCBh
bmQgYWxzbyBkbyBpdCBmb3Igb3RoZXIgcGF0Y2hlcywgdGhhbmtzDQoNCj4gPiAtLSANClsuLi5d
DQo+ID4gMi4xOC4wDQoNCg==

