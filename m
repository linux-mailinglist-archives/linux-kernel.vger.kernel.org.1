Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1552C8309
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 12:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgK3LRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 06:17:12 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54234 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbgK3LRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:17:12 -0500
X-UUID: d5c8693e50fb438ea367ad8f500c4bad-20201130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6tEmMPZ7/XbTZ9lNAUZkSE9umAvR1dsbc9GFoMNQrl8=;
        b=rl+/u4Qz5/L1LJt5CaNcX0PYZ0BlodLcSXgAJ61XZ7hVgikuv4N9SaNXkfaaZpJq0pTNWGMbe6e7o+AtWfpbdu3sKDhf0zE6cR4HIeeLw4ylQWL0WeZTTsGpG6yw3mum/ioGxWFPqUfdA26wE8dzp5wrFdiwV0K6ZWm3GtmuU4w=;
X-UUID: d5c8693e50fb438ea367ad8f500c4bad-20201130
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <weiyi.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1118916592; Mon, 30 Nov 2020 19:16:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 30 Nov 2020 19:16:22 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Nov 2020 19:16:21 +0800
Message-ID: <1606734983.24689.1.camel@mtksdaap41>
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add mt8192 power domains
 controller
From:   Weiyi Lu <weiyi.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Mon, 30 Nov 2020 19:16:23 +0800
In-Reply-To: <1f25cc3f-324a-0020-7bf2-e5a915291522@gmail.com>
References: <1605782884-19741-1-git-send-email-weiyi.lu@mediatek.com>
         <CAFqH_522NuGY9c-_XWhHxoa3QkrdoM92qTOLxgM8PpOU=-ttbw@mail.gmail.com>
         <1605791419.19819.4.camel@mtksdaap41>
         <CAFqH_51m5Pg9ny4HWt1iwf8wtsGSdShpDCVaGwac=v9BBDj2vg@mail.gmail.com>
         <1f25cc3f-324a-0020-7bf2-e5a915291522@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMTEtMjcgYXQgMTM6NDIgKzAxMDAsIE1hdHRoaWFzIEJydWdnZXIgd3Jv
dGU6DQo+IA0KPiBPbiAxOS8xMS8yMDIwIDE1OjEzLCBFbnJpYyBCYWxsZXRibyBTZXJyYSB3cm90
ZToNCj4gPiBIaSBXZWl5aSwNCj4gPiANCj4gPiBNaXNzYXRnZSBkZSBXZWl5aSBMdSA8d2VpeWku
bHVAbWVkaWF0ZWsuY29tPiBkZWwgZGlhIGRqLiwgMTkgZGUgbm92Lg0KPiA+IDIwMjAgYSBsZXMg
MTQ6MTA6DQo+ID4+DQo+ID4+IE9uIFRodSwgMjAyMC0xMS0xOSBhdCAxMzoxMyArMDEwMCwgRW5y
aWMgQmFsbGV0Ym8gU2VycmEgd3JvdGU6DQo+ID4+PiBIaSBXZWl5aSwNCj4gPj4+DQo+ID4+PiBU
aGFuayB5b3UgZm9yIHRoZSBwYXRjaA0KPiA+Pj4NCj4gPj4+IE1pc3NhdGdlIGRlIFdlaXlpIEx1
IDx3ZWl5aS5sdUBtZWRpYXRlay5jb20+IGRlbCBkaWEgZGouLCAxOSBkZSBub3YuDQo+ID4+PiAy
MDIwIGEgbGVzIDExOjQ4Og0KPiA+Pj4+DQo+ID4+Pj4gQWRkIHBvd2VyIGRvbWFpbnMgY29udHJv
bGxlciBub2RlIGZvciBTb0MgbXQ4MTkyDQo+ID4+Pj4NCj4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBX
ZWl5aSBMdSA8d2VpeWkubHVAbWVkaWF0ZWsuY29tPg0KPiA+Pj4+IC0tLQ0KPiBbLi4uXQ0KPiA+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIC8qIFN5c3RlbSBQb3dlciBNYW5hZ2VyICovDQo+
ID4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3BtOiBwb3dlci1jb250cm9sbGVyIHsNCj4g
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTkyLXBvd2VyLWNvbnRyb2xsZXIiOw0KPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPj4+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICNwb3dlci1kb21haW4tY2VsbHMgPSA8MT47DQo+ID4+Pj4gKw0K
PiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogcG93ZXIgZG9tYWluIG9m
IHRoZSBTb0MgKi8NCj4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF1ZGlv
QE1UODE5Ml9QT1dFUl9ET01BSU5fQVVESU8gew0KPiA+Pj4NCj4gPj4+IElmIHlvdSBydW4gdGhl
IGR0X2JpbmRpbmdzX2NoZWNrIGl0IHNob3VsZCByZXR1cm4gc29tZSBlcnJvcnMsIGFzIGFsbA0K
PiA+Pj4gdGhlc2Ugbm9kZSBuYW1lcyBzaG91bGQgYmUgJ3Bvd2VyLWRvbWFpbkAnLiBXaGljaCBp
cyBhIGJpdCBhbm5veWluZw0KPiA+Pj4gYmVjYXVzZSB0aGVuIHlvdSB3aWxsIGdldCBhIGJ1bmNo
IG9mIGVycm9ycyBsaWtlIHRoaXM6DQo+ID4+Pg0KPiA+Pj4gWyAgICAxLjk2OTExMF0gZGVidWdm
czogRGlyZWN0b3J5ICdwb3dlci1kb21haW4nIHdpdGggcGFyZW50DQo+ID4+PiAncG1fZ2VucGQn
IGFscmVhZHkgcHJlc2VudCENCj4gPj4+IFsgICAgMS45NzY5OTddIGRlYnVnZnM6IERpcmVjdG9y
eSAncG93ZXItZG9tYWluJyB3aXRoIHBhcmVudA0KPiA+Pj4gJ3BtX2dlbnBkJyBhbHJlYWR5IHBy
ZXNlbnQhDQo+ID4+PiBbICAgIDEuOTg0ODI4XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3Bvd2VyLWRv
bWFpbicgd2l0aCBwYXJlbnQNCj4gPj4+ICdwbV9nZW5wZCcgYWxyZWFkeSBwcmVzZW50IQ0KPiA+
Pj4gWyAgICAxLjk5MjY1N10gZGVidWdmczogRGlyZWN0b3J5ICdwb3dlci1kb21haW4nIHdpdGgg
cGFyZW50DQo+ID4+PiAncG1fZ2VucGQnIGFscmVhZHkgcHJlc2VudCENCj4gPj4+IFsgICAgMi4w
MDA2ODVdIGRlYnVnZnM6IERpcmVjdG9yeSAncG93ZXItZG9tYWluJyB3aXRoIHBhcmVudA0KPiA+
Pj4gJ3BtX2dlbnBkJyBhbHJlYWR5IHByZXNlbnQhDQo+ID4+PiBbICAgIDIuMDA4NTY2XSBkZWJ1
Z2ZzOiBEaXJlY3RvcnkgJ3Bvd2VyLWRvbWFpbicgd2l0aCBwYXJlbnQNCj4gPj4+ICdwbV9nZW5w
ZCcgYWxyZWFkeSBwcmVzZW50IQ0KPiA+Pj4gWyAgICAyLjAxNjM5NV0gZGVidWdmczogRGlyZWN0
b3J5ICdwb3dlci1kb21haW4nIHdpdGggcGFyZW50DQo+ID4+PiAncG1fZ2VucGQnIGFscmVhZHkg
cHJlc2VudCENCj4gPj4+IFsgICAgMi4wMjQyMjFdIGRlYnVnZnM6IERpcmVjdG9yeSAncG93ZXIt
ZG9tYWluJyB3aXRoIHBhcmVudA0KPiA+Pj4gJ3BtX2dlbnBkJyBhbHJlYWR5IHByZXNlbnQhDQo+
ID4+PiBbICAgIDIuMDMyMDQ5XSBkZWJ1Z2ZzOiBEaXJlY3RvcnkgJ3Bvd2VyLWRvbWFpbicgd2l0
aCBwYXJlbnQNCj4gPj4+ICdwbV9nZW5wZCcgYWxyZWFkeSBwcmVzZW50IQ0KPiA+Pj4gWyAgICAy
LjAzOTg3NF0gZGVidWdmczogRGlyZWN0b3J5ICdwb3dlci1kb21haW4nIHdpdGggcGFyZW50DQo+
ID4+PiAncG1fZ2VucGQnIGFscmVhZHkgcHJlc2VudCENCj4gPj4+IFsgICAgMi4wNDc2OTldIGRl
YnVnZnM6IERpcmVjdG9yeSAncG93ZXItZG9tYWluJyB3aXRoIHBhcmVudA0KPiA+Pj4gJ3BtX2dl
bnBkJyBhbHJlYWR5IHByZXNlbnQhDQo+ID4+PiBbICAgIDIuMDU1NTI0XSBkZWJ1Z2ZzOiBEaXJl
Y3RvcnkgJ3Bvd2VyLWRvbWFpbicgd2l0aCBwYXJlbnQNCj4gPj4+ICdwbV9nZW5wZCcgYWxyZWFk
eSBwcmVzZW50IQ0KPiA+Pj4gWyAgICAyLjA2MzM1Ml0gZGVidWdmczogRGlyZWN0b3J5ICdwb3dl
ci1kb21haW4nIHdpdGggcGFyZW50DQo+ID4+PiAncG1fZ2VucGQnIGFscmVhZHkgcHJlc2VudCEN
Cj4gPj4+IFsgICAgMi4wNzExNzZdIGRlYnVnZnM6IERpcmVjdG9yeSAncG93ZXItZG9tYWluJyB3
aXRoIHBhcmVudA0KPiA+Pj4gJ3BtX2dlbnBkJyBhbHJlYWR5IHByZXNlbnQhDQo+ID4+Pg0KPiA+
Pj4gQnV0IHRoYXQncyBhbm90aGVyIHByb2JsZW0gdGhhdCBzaG91bGQgYmUgaGFuZGxlZCBpbiBk
ZWJ1Z2ZzIHN5c3RlbS4NCj4gPj4+DQo+ID4+DQo+ID4+IEluZGVlZC4uLnNvIEkgY2hvc2UgdG8g
dXNlIGRpZmZlcmVudCBuYW1lIGluIGR0cyB0byBhdm9pZCBwcm9ibGVtcyBpbg0KPiA+PiBkZWJ1
Z2ZzLiBJdCBkb2VzIHZpb2xhdGUgdGhlIG5hbWluZyBydWxlcy4NCj4gPj4NCj4gPiANCj4gPiBC
dXQgeW91ciBiaW5kaW5nIHdpbGwgbm90IHBhc3MgKG9yIHRyaWdnZXIgd2FybmluZ3MpIHRoZSBk
dGIgY2hlY2sNCj4gPiB0aGVuLiBSb2Igd2FzIGNsZWFyIHRoYXQgbmFtZXMgc2hvdWxkIGJlIGdl
bmVyaWMuIFByb3BlciBmaXggaXMgZml4DQo+ID4gZGVidWdmcyBub3QgdGhlIGJpbmRpbmcuDQo+
ID4gDQo+IA0KPiBCeSB0aGUgd2F5LCBpcyBhbnlib2R5IHdvcmtpbmcgb24gdGhpcyBkZWJ1Z2Zz
IGlzc3VlPw0KPiANCg0KSSB0aGluayB3ZSBjYW4gc29sdmUgdGhpcyBwcm9ibGVtIGJ5IGFkZGlu
ZyAibmFtZSIgdG8gdGhlIHN0cnVjdA0Kc2Nwc3lzX2RvbWFpbl9kYXRhIGFuZCB1c2UgdGhpcyBk
b21haW5fZGF0YS0+bmFtZSBhcyB0aGUgZ2VucGQubmFtZS4NClRoaXMgaXMgdmVyeSBzaW1wbGUu
IEJ1dCBJIHdhbnQgdG8ga25vdyBpZiB5b3UgYm90aCBsaWtlIGl0Pw0KDQo+IFJlZ2FyZHMsDQo+
IE1hdHRoaWFzDQoNCg0K

