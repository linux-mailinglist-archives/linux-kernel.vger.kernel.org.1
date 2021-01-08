Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE22A2EED5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 07:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAHGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 01:12:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:16237 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725791AbhAHGMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:12:44 -0500
X-UUID: a7d2ee42095b424f8da8284796bbd855-20210108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LDkX9dGv4KvdYnnhzQPG/2hc+NN7U1uTjI1C2TIOKEU=;
        b=e3oFH22iXVHk04QvgGDGtJing67Y3GCnTz7LpvDFRvhm2eM5b+nC2GCTP/9ZcEu1yOYhfJLWTV0fcnYYMQzjUVqF6AtuJVMxKj6jcvNW2RFTCOPesRCWe45JU7jARvPYfpwpmEoRGwAyYNX4q6ZVj9LXS9DSEgWwdIYd4turv8U=;
X-UUID: a7d2ee42095b424f8da8284796bbd855-20210108
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1049624716; Fri, 08 Jan 2021 14:11:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 Jan
 2021 14:11:49 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Jan 2021 14:11:48 +0800
Message-ID: <1610086308.24856.30.camel@mhfsdcap03>
Subject: Re: [PATCH v5] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
CC:     Ikjoon Jang <ikjn@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Fri, 8 Jan 2021 14:11:48 +0800
In-Reply-To: <2aea44f0-85e7-fd55-2c35-c1d994f20e03@linux.intel.com>
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
         <2aea44f0-85e7-fd55-2c35-c1d994f20e03@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 12678802E42F6808826D6958AF777C2230A087B39BF15A09308AD3209AE099362000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTA3IGF0IDEzOjA5ICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiBPbiAyOS4xMi4yMDIwIDguMjQsIElram9vbiBKYW5nIHdyb3RlOg0KPiA+IHhoY2ktbXRrIGhh
cyBob29rcyBvbiBhZGRfZW5kcG9pbnQoKSBhbmQgZHJvcF9lbmRwb2ludCgpIGZyb20geGhjaQ0K
PiA+IHRvIGhhbmRsZSBpdHMgb3duIHN3IGJhbmR3aWR0aCBtYW5hZ2VtZW50cyBhbmQgc3RvcmVz
IGJhbmR3aWR0aCBkYXRhDQo+ID4gaW50byBpbnRlcm5hbCB0YWJsZSBldmVyeSB0aW1lIGFkZF9l
bmRwb2ludCgpIGlzIGNhbGxlZCwNCj4gPiBzbyB3aGVuIGJhbmR3aWR0aCBhbGxvY2F0aW9uIGZh
aWxzIGF0IG9uZSBlbmRwb2ludCwgYWxsIGVhcmxpZXINCj4gPiBhbGxvY2F0aW9uIGZyb20gdGhl
IHNhbWUgaW50ZXJmYWNlIGNvdWxkIHN0aWxsIHJlbWFpbiBhdCB0aGUgdGFibGUuDQo+ID4gDQo+
ID4gVGhpcyBwYXRjaCBhZGRzIHR3byBtb3JlIGhvb2tzIGZyb20gY2hlY2tfYmFuZHdpZHRoKCkg
YW5kDQo+ID4gcmVzZXRfYmFuZHdpZHRoKCksIGFuZCBtYWtlIG10ay14aGNpIHRvIHJlbGVhc2Vz
IGFsbCBmYWlsZWQgZW5kcG9pbnRzDQo+ID4gZnJvbSByZXNldF9iYW5kd2lkdGgoKS4NCj4gPiAN
Cj4gPiBGaXhlczogMDhlNDY5ZGU4N2EyICgidXNiOiB4aGNpLW10azogc3VwcG9ydHMgYmFuZHdp
ZHRoIHNjaGVkdWxpbmcgd2l0aCBtdWx0aS1UVCIpDQo+ID4gU2lnbmVkLW9mZi1ieTogSWtqb29u
IEphbmcgPGlram5AY2hyb21pdW0ub3JnPg0KPiA+IA0KPiANCj4gLi4uDQo+IA0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYyBiL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS5jDQo+ID4gaW5kZXggZDRhOGQwZWZiYmM0Li5lMWZjZDNjZjcyM2YgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9ob3N0
L3hoY2kuYw0KPiA+IEBAIC0yODgyLDYgKzI4ODIsMTIgQEAgc3RhdGljIGludCB4aGNpX2NoZWNr
X2JhbmR3aWR0aChzdHJ1Y3QgdXNiX2hjZCAqaGNkLCBzdHJ1Y3QgdXNiX2RldmljZSAqdWRldikN
Cj4gPiAgCXhoY2lfZGJnKHhoY2ksICIlcyBjYWxsZWQgZm9yIHVkZXYgJXBcbiIsIF9fZnVuY19f
LCB1ZGV2KTsNCj4gPiAgCXZpcnRfZGV2ID0geGhjaS0+ZGV2c1t1ZGV2LT5zbG90X2lkXTsNCj4g
PiAgDQo+ID4gKwlpZiAoeGhjaS0+cXVpcmtzICYgWEhDSV9NVEtfSE9TVCkgew0KPiA+ICsJCXJl
dCA9IHhoY2lfbXRrX2NoZWNrX2JhbmR3aWR0aChoY2QsIHVkZXYpOw0KPiA+ICsJCWlmIChyZXQg
PCAwKQ0KPiA+ICsJCQlyZXR1cm4gcmV0Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gDQo+IEp1c3Qgbm90
aWNlZCB0aGF0IFhIQ0lfTVRLX0hPU1QgcXVpcmsgaXMgb25seSBzZXQgaW4geGhjaS1tdGsuYy4N
Cj4geGhjaS1tdGsuYyBjYWxscyB4aGNpX2luaXRfZHJpdmVyKC4uLiwgeGhjaV9tdGtfb3ZlcnJp
ZGVzKSB3aXRoIGEgLnJlc2V0IG92ZXJyaWRlIGZ1bmN0aW9uLg0KPiANCj4gd2h5IG5vdCBhZGQg
b3ZlcnJpZGUgZnVuY3Rpb25zIGZvciAuY2hlY2tfYmFuZHdpZHRoIGFuZCAucmVzZXRfYmFuZHdp
ZHRoIHRvIHhoY2lfbXRrX292ZXJyaWRlcyBpbnN0ZWFkPw0KPiANCj4gQW5vdGhlciBwYXRjaCB0
byBhZGQgc2ltaWxhciBvdmVycmlkZXMgZm9yIC5hZGRfZW5kcG9pbnQgYW5kIC5kcm9wX2VuZHBv
aW50IHNob3VsZCBwcm9iYWJseSBiZQ0KPiBkb25lIHNvIHRoYXQgd2UgY2FuIGdldCByaWQgb2Yg
dGhlIHhoY2lfbXRrX2FkZC9kcm9wX2VwX3F1aXJrKCkgY2FsbHMgaW4geGhjaS5jIGFzIHdlbGwN
CllvdSBtZWFuLCB3ZSBjYW4gZXhwb3J0IHhoY2lfYWRkL2Ryb3BfZW5kcG9pbnQoKT8NCg0KPiAN
Cj4gVGhhbmtzDQo+IC1NYXRoaWFzDQo+IA0KDQo=

