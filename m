Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E728269E14
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbgIOFv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:51:56 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:47051 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgIOFvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:51:52 -0400
X-UUID: 75f0df4815ca46939aaf5de83bc32b9c-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=nJ8djf+4aZ5rpE1RVUZAt4X6QQ07QZXLCPjNDV2nP0c=;
        b=RL4wcFJAGI/WWOo/h8kNFBRG4OXSQtq6TSLfmEjJhIIgtJWFU74DjUxhdwd7CZ6Bk4G5EvSNItOTJeEsX2/yr0p0BWnKLUFh0fBobRm6vrjZe8ii/03TiHC7bKEWvYvxSP+m4RZ/T1qhC2LoY56T5RafSglFN3hp3UgyZPQZCQs=;
X-UUID: 75f0df4815ca46939aaf5de83bc32b9c-20200915
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1538148269; Tue, 15 Sep 2020 13:51:46 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Sep
 2020 13:51:45 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 13:51:45 +0800
Message-ID: <1600148980.25043.11.camel@mhfsdcap03>
Subject: Re: [PATCH v2 01/23] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
From:   Yong Wu <yong.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <ming-fan.chen@mediatek.com>
Date:   Tue, 15 Sep 2020 13:49:40 +0800
In-Reply-To: <20200914232204.GA457962@bogus>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
         <20200905080920.13396-2-yong.wu@mediatek.com>
         <20200914232204.GA457962@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 111B958147B5710F8EC8EE31D6C3E1F8F83B044953526CC951ED6485D3399B752000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTE0IGF0IDE3OjIyIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU2F0LCBTZXAgMDUsIDIwMjAgYXQgMDQ6MDg6NThQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBDb252ZXJ0IE1lZGlhVGVrIElPTU1VIHRvIERUIHNjaGVtYS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCg0KWy4u
Ll0NCg0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVt
Og0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10MjcwMS1tNHUgI210MjcwMSBnZW5lcmF0aW9uIG9u
ZSBIVw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10MjcxMi1tNHUgI210MjcxMiBnZW5lcmF0aW9u
IHR3byBIVw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10Njc3OS1tNHUgI210Njc3OSBnZW5lcmF0
aW9uIHR3byBIVw0KPiA+ICsgICAgICAtIG1lZGlhdGVrLG10NzYyMy1tNHUsIG1lZGlhdGVrLG10
MjcwMS1tNHUgI210NzYyMyBnZW5lcmF0aW9uIG9uZSBIVw0KPiANCj4gVGhpcyBpcyBub3Qgcmln
aHQuDQo+IA0KPiBpdGVtczoNCj4gICAtIGNvbnN0OiBtZWRpYXRlayxtdDc2MjMtbTR1DQo+ICAg
LSBjb25zdDogbWVkaWF0ZWssbXQyNzAxLW00dQ0KPiANCj4gQW5kIHRoYXQgaGFzIHRvIGJlIHVu
ZGVyIGEgJ29uZU9mJyB3aXRoIHRoZSByZXN0IG9mIHRoaXMuDQoNClRoYW5rcyBmb3IgdGhlIHJl
dmlldy4gSXMgdGhpcyBPSz8NCg0KICBjb21wYXRpYmxlOg0KICAgIG9uZU9mOg0KICAgICAgLSBj
b25zdDogbWVkaWF0ZWssbXQyNzAxLW00dSAjIG10MjcwMSBnZW5lcmF0aW9uIG9uZSBIVw0KICAg
ICAgLSBjb25zdDogbWVkaWF0ZWssbXQyNzEyLW00dSAjIG10MjcxMiBnZW5lcmF0aW9uIHR3byBI
Vw0KICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ2Nzc5LW00dSAjIG10Njc3OSBnZW5lcmF0aW9u
IHR3byBIVw0KICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTczLW00dSAjIG10ODE3MyBnZW5l
cmF0aW9uIHR3byBIVw0KICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTgzLW00dSAjIG10ODE4
MyBnZW5lcmF0aW9uIHR3byBIVw0KICAgICAgLSBjb25zdDogbWVkaWF0ZWssbXQ4MTkyLW00dSAj
IG10ODE5MiBnZW5lcmF0aW9uIHR3byBIVw0KICAgICAgICAgICAgDQogICAgICAtIGRlc2NyaXB0
aW9uOiBtdDc2MjMgZ2VuZXJhdGlvbiBvbmUgSFcNCiAgICAgICAgaXRlbXM6DQogICAgICAgICAg
LSBjb25zdDogbWVkaWF0ZWssbXQ3NjIzLW00dQ0KICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVr
LG10MjcwMS1tNHUNCg0KPiANCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxNzMtbTR1ICNtdDgx
NzMgZ2VuZXJhdGlvbiB0d28gSFcNCj4gPiArICAgICAgLSBtZWRpYXRlayxtdDgxODMtbTR1ICNt
dDgxODMgZ2VuZXJhdGlvbiB0d28gSFcNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWF4
SXRlbXM6IDENCg0KW3NuaXBdDQo=

