Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A729C1E5F1C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbgE1L7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 07:59:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40750 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388567AbgE1L7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:59:18 -0400
X-UUID: cf8f6e1b6f9248f7888a8db12e1c2f58-20200528
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yhOEVU3OR0lZaZurEspqANd7eY+KkUT5sYWGMaX8JUQ=;
        b=aYxS9JJ9gsT9F6Vb73SdwydkmdAKHPBVEQblcWh3hNn7FJkxjwnXoiM/0X63XrQx1PrzBjLC8q+u0pS8V18Xcm8rhW1fA+gTju9RSF8DEFPTOj4qw0rwf6jzCojQweTvjLaZOQdqNMZE6k6GAVJikBFAdM1Rm65tDIe4tJvTpro=;
X-UUID: cf8f6e1b6f9248f7888a8db12e1c2f58-20200528
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 629072632; Thu, 28 May 2020 19:59:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 May 2020 19:59:03 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 May 2020 19:59:03 +0800
Message-ID: <1590667145.4266.6.camel@mtkswgap22>
Subject: Re: [PATCH v5 2/6] pinctrl: mediatek: update pinmux definitions for
 mt6779
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Sean Wang <sean.wang@kernel.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Teng <andy.teng@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Mars Cheng <mars.cheng@mediatek.com>
Date:   Thu, 28 May 2020 19:59:05 +0800
In-Reply-To: <CAGp9LzoULALLvO+x2TnO=K=pSD05bJFowB-usAcrpz0ddEN+Ug@mail.gmail.com>
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com>
         <1585128694-13881-3-git-send-email-hanks.chen@mediatek.com>
         <CAGp9LzoULALLvO+x2TnO=K=pSD05bJFowB-usAcrpz0ddEN+Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTAyIGF0IDE0OjU0IC0wNzAwLCBTZWFuIFdhbmcgd3JvdGU6DQo+IEhp
LCBIYW5rcw0KPiANCj4gSnVzdCBhIGZldyBuaXRwaWNrcyBhbmQgdGhlbiBBY2tlZC1ieTogU2Vh
biBXYW5nIDxzZWFuLndhbmdAa2VybmVsLm9yZz4NCj4gDQo+IE9uIFdlZCwgTWFyIDI1LCAyMDIw
IGF0IDI6MzEgQU0gSGFua3MgQ2hlbiA8aGFua3MuY2hlbkBtZWRpYXRlay5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gQWRkIGRldmljZXRyZWUgYmluZGluZ3MgZm9yIE1lZGlhdGVrIG10Njc3OSBTb0Mg
UGluIENvbnRyb2xsZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYW5rcyBDaGVuIDxoYW5r
cy5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXJzIENoZW5nIDxtYXJz
LmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFRlbmcgPGFuZHku
dGVuZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcGlu
Y3RybC9tdDY3NzktcGluZnVuYy5oIHwgMTI0MiArKysrKysrKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTI0MiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL3BpbmN0cmwvbXQ2Nzc5LXBpbmZ1bmMuaA0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcGluY3RybC9tdDY3NzktcGlu
ZnVuYy5oIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL210Njc3OS1waW5mdW5jLmgNCj4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjQ2OThkMmYNCj4gPiAt
LS0gL2Rldi9udWxsDQo+ID4gKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9waW5jdHJsL210Njc3
OS1waW5mdW5jLmgNCj4gPiBAQCAtMCwwICsxLDEyNDIgQEANCj4gPiArLyogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAy
MDE5IE1lZGlhVGVrIEluYy4NCj4gPiArICogQXV0aG9yOiBBbmR5IFRlbmcgPGFuZHkudGVuZ0Bt
ZWRpYXRlay5jb20+DQo+ID4gKyAqDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBfX01U
Njc3OV9QSU5GVU5DX0gNCj4gPiArI2RlZmluZSBfX01UNjc3OV9QSU5GVU5DX0gNCj4gPiArDQo+
ID4gKyNpbmNsdWRlICJtdDY1eHguaCINCj4gDQo+IFVzZSB0aGUgc3RhbmRhcmQgaW5jbHVkZSBw
YXRoIGluc3RlYWQ6ICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcGluY3RybC9tdDY1eHguaD4NCj4g
DQpHb3QgaXQsIEknbGwgcmV2aXNlIGl0IGluIG5leHQgdmVyc2lvbg0KVGhhbmtzIGZvciB5b3Vy
IGNvbW1lbnQuDQoNCj4gPiArDQo+IDxzbmlwPg0KPiA+ICsNCj4gPiArI2RlZmluZSBQSU5NVVhf
R1BJTzIwOV9fRlVOQ19HUElPMjA5IChNVEtfUElOX05PKDIwOSkgfCAwKQ0KPiA+ICsNCj4gPiAr
I2VuZGlmIC8qIF9fTVQ2Nzc5LVBJTkZVTkNfSCAqLw0KPiAgICAgICAgICAgICAgICAgICAgX19N
VDY3NzlfUElORlVOQ19IDQo+ID4gLS0NCj4gPiAxLjcuOS41DQoNCg==

