Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD3C29333B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 04:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbgJTCeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 22:34:25 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:42075 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730254AbgJTCeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 22:34:25 -0400
X-UUID: 680b7d3e367349aab9d080b2064a0d36-20201020
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GUA1hbpU/msavICMu4ZyZUeoilqfTnK1HnnKU2S01BA=;
        b=lNdYo+NogUdsjYDTXcmU71GYt71aAd2j9xbMzUWIWwFdi/cuzBZeAwa7+sHFjzhf55Q9zQUI4dmBrE9HTEjxCYZ8Dq2J8FpXnbAhJVQaApmXag8S+JOmX2aaPjlxHqsn/Qz/likmejM72/SFsqGH/JhQ0+sR9QgV4BnqVOAlGvw=;
X-UUID: 680b7d3e367349aab9d080b2064a0d36-20201020
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1918381547; Tue, 20 Oct 2020 10:34:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Oct
 2020 10:34:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Oct 2020 10:34:04 +0800
Message-ID: <1603161244.29336.142.camel@mhfsdcap03>
Subject: Re: [PATCH v2 2/8] dt-bindings: phy: convert phy-mtk-tphy.txt to
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
Date:   Tue, 20 Oct 2020 10:34:04 +0800
In-Reply-To: <20201016170552.GA1580710@bogus>
References: <20201013085207.17749-1-chunfeng.yun@mediatek.com>
         <20201013085207.17749-2-chunfeng.yun@mediatek.com>
         <20201016170552.GA1580710@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 204DA36F181E521CDF8CC1E6221ACDE0FAA6F121DEDB71CF4B5AED7B259FEB042000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTE2IGF0IDEyOjA1IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBPY3QgMTMsIDIwMjAgYXQgMDQ6NTI6MDFQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdy
b3RlOg0KPiA+IENvbnZlcnQgcGh5LW10ay10cGh5LnR4dCB0byBZQU1MIHNjaGVtYSBtZWRpYXRl
ayx0cGh5LnlhbWwNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5m
ZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gdjI6IG1vZGlmeSBkZXNjcmlwdGlv
biBhbmQgY29tcGF0aWJsZQ0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcGh5L21lZGlhdGVr
LHRwaHkueWFtbCAgICAgICAgICAgfCAyNjMgKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9waHktbXRrLXRwaHkudHh0ICB8IDE2MiAtLS0tLS0tLS0t
LQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDI2MyBpbnNlcnRpb25zKCspLCAxNjIgZGVsZXRpb25z
KC0pDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDc1NSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcGh5L21lZGlhdGVrLHRwaHkueWFtbA0KPiANCj4gQWxzbywgbmVlZCB0byBmaXggdGhl
IG1vZGUuDQpPaywgdGhhbmtzDQoNCj4gDQo+ID4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L3BoeS1tdGstdHBoeS50eHQNCg0K

