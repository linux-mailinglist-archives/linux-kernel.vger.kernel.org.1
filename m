Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC87269E1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgIOF5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:57:18 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:55361 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726046AbgIOF5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:57:15 -0400
X-UUID: f93b882ba17d4d34b5c81542cc40b4fb-20200915
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7TyzYnNnuHx6SNq8ViyS5YlncO0DkL6/ccYuDYtvhdI=;
        b=UJ1XsXF8Ynu+qsosV0rMO09oCcSY3xfeeO2NBBj4NecLn6viicLZLP9KTZl5L6FvI4/9AwDmGV7bYbJq5qvNOi46FeuCahvqz3pzdcJRUvQGA51xNKE9zyCfsHI2q7lBrMgUf5CjpgEim4ZUCHXYsidXkQqqQ7adBQnmIAaua38=;
X-UUID: f93b882ba17d4d34b5c81542cc40b4fb-20200915
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 829302080; Tue, 15 Sep 2020 13:57:07 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Sep
 2020 13:57:06 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 15 Sep 2020 13:57:06 +0800
Message-ID: <1600149301.25043.17.camel@mhfsdcap03>
Subject: Re: [PATCH v2 02/23] dt-bindings: memory: mediatek: Convert SMI to
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
        <ming-fan.chen@mediatek.com>, Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 15 Sep 2020 13:55:01 +0800
In-Reply-To: <20200914232345.GA465583@bogus>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
         <20200905080920.13396-3-yong.wu@mediatek.com>
         <20200914232345.GA465583@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: F0B44B45969F81D8D7A3A71A4A0A1C136FDDE0730FA3C551C17876F4581648A22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTE0IGF0IDE3OjIzIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU2F0LCBTZXAgMDUsIDIwMjAgYXQgMDQ6MDg6NTlQTSArMDgwMCwgWW9uZyBXdSB3cm90ZToN
Cj4gPiBDb252ZXJ0IE1lZGlhVGVrIFNNSSB0byBEVCBzY2hlbWEuDQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIC4u
Li9tZWRpYXRlayxzbWktY29tbW9uLnR4dCAgICAgICAgICAgICAgICAgICB8IDQ5IC0tLS0tLS0t
LS0NCj4gPiAgLi4uL21lZGlhdGVrLHNtaS1jb21tb24ueWFtbCAgICAgICAgICAgICAgICAgIHwg
OTYgKysrKysrKysrKysrKysrKysrKw0KPiA+ICAuLi4vbWVtb3J5LWNvbnRyb2xsZXJzL21lZGlh
dGVrLHNtaS1sYXJiLnR4dCAgfCA0OSAtLS0tLS0tLS0tDQo+ID4gIC4uLi9tZW1vcnktY29udHJv
bGxlcnMvbWVkaWF0ZWssc21pLWxhcmIueWFtbCB8IDg1ICsrKysrKysrKysrKysrKysNCg0KWy4u
Ll0NCg0KPiA+ICsgIG1lZGlhdGVrLHNtaToNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVz
LnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUtYXJyYXkNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBh
IHBoYW5kbGUgdG8gdGhlIHNtaV9jb21tb24gbm9kZS4NCj4gPiArDQo+ID4gKyAgbWVkaWF0ZWss
bGFyYi1pZDoNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25z
L3VpbnQzMg0KPiA+ICsgICAgZGVzY3JpcHRpb246IHRoZSBoYXJkd2FyZSBpZCBvZiB0aGlzIGxh
cmIuDQo+ID4gKyAgICAgIFJlcXVpcmVkIHByb3BlcnR5IGZvciBtdDI3MDEsIG10MjcxMiwgbXQ2
Nzc5IGFuZCBtdDc2MjMuDQo+IA0KPiBJcyB0aGVyZSBhIHNldCBvZiB2YWxpZCB2YWx1ZXM/DQoN
CkluIHRoZSBwYXRjaFs0LzIzXSwgSSBjaGFuZ2UgdGhlIGxhcmJfbnIgdG8gMzIuIG5vcm1hbGx5
IHRoaXMgaWQgaXMgZnJvbQ0KMCB0byAzMS4gSSB3aWxsIGFkZCB0aGlzIGluIG5leHQgdmVyc2lv
bjoNCg0KICAgIG1pbmltdW06IDANCiAgICBtYXhpbXVtOiAzMQ0KDQo+IA0KPiA+ICsNCj4gPiAr
cmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGNs
b2Nrcw0KPiA+ICsgIC0gY2xvY2stbmFtZXMNCj4gPiArICAtIHBvd2VyLWRvbWFpbnMNCj4gPiAr
DQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6
DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbXQ4MTcz
LWNsay5oPg0KPiA+ICsgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210ODE3My1wb3dl
ci5oPg0KPiA+ICsNCj4gPiArICAgIGxhcmIxOiBsYXJiQDE2MDEwMDAwIHsNCj4gPiArICAgICAg
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxNzMtc21pLWxhcmIiOw0KPiA+ICsgICAgICByZWcg
PSA8MHgxNjAxMDAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICBtZWRpYXRlayxzbWkgPSA8JnNtaV9j
b21tb24+Ow0KPiA+ICsgICAgICBwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTczX1BPV0VS
X0RPTUFJTl9WREVDPjsNCj4gPiArICAgICAgY2xvY2tzID0gPCZ2ZGVjc3lzIENMS19WREVDX0NL
RU4+LA0KPiA+ICsgICAgICAgICAgICAgICA8JnZkZWNzeXMgQ0xLX1ZERUNfTEFSQl9DS0VOPjsN
Cj4gPiArICAgICAgY2xvY2stbmFtZXMgPSAiYXBiIiwgInNtaSI7DQo+ID4gKyAgICB9Ow0KPiA+
ICsNCj4gPiAtLSANCj4gPiAyLjE4LjANCg0K

