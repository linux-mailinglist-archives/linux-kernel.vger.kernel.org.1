Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D313E2F5C71
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbhANIas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:30:48 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27050 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbhANIar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:30:47 -0500
X-UUID: 6eaf607c35ee487890ac4a2f17d8cba0-20210114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3vfvY7ZKwRB4qS/zo2PCJVSCObWf38oxlkKwvoQoKvE=;
        b=e+g3JUNLC2GDGrGTmoZw7wUbqwdbajdsDTsYGPji9D0TJ082n73ZqIjmnuvYwjDDs1G0VJEuv+yMKvydtIVtfPxm2G2mGQpWBM7wwNRsITV3PA/w6WYPMuEQqY3F+YnijrfWrl/JZdvNyxqBXatbXU7iZOu7SW/Bl4tsuCSq1e4=;
X-UUID: 6eaf607c35ee487890ac4a2f17d8cba0-20210114
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 469205974; Thu, 14 Jan 2021 16:29:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 16:29:54 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Jan 2021 16:29:52 +0800
Message-ID: <1610612988.30053.15.camel@mhfsdcap03>
Subject: Re: [PATCH v5] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 14 Jan 2021 16:29:48 +0800
In-Reply-To: <CAATdQgD2OAmf7_NWSVwzyJE7mF0vngzE=QeE79PS7MJsgPhbtA@mail.gmail.com>
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
         <2aea44f0-85e7-fd55-2c35-c1d994f20e03@linux.intel.com>
         <1610086308.24856.30.camel@mhfsdcap03>
         <e43632e2-08b3-7a1a-8272-1d493e25fc67@linux.intel.com>
         <CAATdQgD2OAmf7_NWSVwzyJE7mF0vngzE=QeE79PS7MJsgPhbtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 77ED6FFC0E264159D06B048F03B8B8C65875304C49FE305525CD3102406645DB2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWtqb29uLA0KDQpPbiBUdWUsIDIwMjEtMDEtMTIgYXQgMTM6NDggKzA4MDAsIElram9vbiBK
YW5nIHdyb3RlOg0KPiBPbiBGcmksIEphbiA4LCAyMDIxIGF0IDEwOjQ0IFBNIE1hdGhpYXMgTnlt
YW4NCj4gPG1hdGhpYXMubnltYW5AbGludXguaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IE9u
IDguMS4yMDIxIDguMTEsIENodW5mZW5nIFl1biB3cm90ZToNCj4gPiA+IE9uIFRodSwgMjAyMS0w
MS0wNyBhdCAxMzowOSArMDIwMCwgTWF0aGlhcyBOeW1hbiB3cm90ZToNCj4gPiA+PiBPbiAyOS4x
Mi4yMDIwIDguMjQsIElram9vbiBKYW5nIHdyb3RlOg0KPiA+ID4+PiB4aGNpLW10ayBoYXMgaG9v
a3Mgb24gYWRkX2VuZHBvaW50KCkgYW5kIGRyb3BfZW5kcG9pbnQoKSBmcm9tIHhoY2kNCj4gPiA+
Pj4gdG8gaGFuZGxlIGl0cyBvd24gc3cgYmFuZHdpZHRoIG1hbmFnZW1lbnRzIGFuZCBzdG9yZXMg
YmFuZHdpZHRoIGRhdGENCj4gPiA+Pj4gaW50byBpbnRlcm5hbCB0YWJsZSBldmVyeSB0aW1lIGFk
ZF9lbmRwb2ludCgpIGlzIGNhbGxlZCwNCj4gPiA+Pj4gc28gd2hlbiBiYW5kd2lkdGggYWxsb2Nh
dGlvbiBmYWlscyBhdCBvbmUgZW5kcG9pbnQsIGFsbCBlYXJsaWVyDQo+ID4gPj4+IGFsbG9jYXRp
b24gZnJvbSB0aGUgc2FtZSBpbnRlcmZhY2UgY291bGQgc3RpbGwgcmVtYWluIGF0IHRoZSB0YWJs
ZS4NCj4gPiA+Pj4NCj4gPiA+Pj4gVGhpcyBwYXRjaCBhZGRzIHR3byBtb3JlIGhvb2tzIGZyb20g
Y2hlY2tfYmFuZHdpZHRoKCkgYW5kDQo+ID4gPj4+IHJlc2V0X2JhbmR3aWR0aCgpLCBhbmQgbWFr
ZSBtdGsteGhjaSB0byByZWxlYXNlcyBhbGwgZmFpbGVkIGVuZHBvaW50cw0KPiA+ID4+PiBmcm9t
IHJlc2V0X2JhbmR3aWR0aCgpLg0KPiA+ID4+Pg0KPiA+ID4+PiBGaXhlczogMDhlNDY5ZGU4N2Ey
ICgidXNiOiB4aGNpLW10azogc3VwcG9ydHMgYmFuZHdpZHRoIHNjaGVkdWxpbmcgd2l0aCBtdWx0
aS1UVCIpDQo+ID4gPj4+IFNpZ25lZC1vZmYtYnk6IElram9vbiBKYW5nIDxpa2puQGNocm9taXVt
Lm9yZz4NCj4gPiA+Pj4NCj4gPiA+Pg0KPiA+ID4+IC4uLg0KPiA+ID4+DQo+ID4gPj4+DQo+ID4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYyBiL2RyaXZlcnMvdXNiL2hv
c3QveGhjaS5jDQo+ID4gPj4+IGluZGV4IGQ0YThkMGVmYmJjNC4uZTFmY2QzY2Y3MjNmIDEwMDY0
NA0KPiA+ID4+PiAtLS0gYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPiA+ID4+PiArKysgYi9k
cml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPiA+ID4+PiBAQCAtMjg4Miw2ICsyODgyLDEyIEBAIHN0
YXRpYyBpbnQgeGhjaV9jaGVja19iYW5kd2lkdGgoc3RydWN0IHVzYl9oY2QgKmhjZCwgc3RydWN0
IHVzYl9kZXZpY2UgKnVkZXYpDQo+ID4gPj4+ICAgICB4aGNpX2RiZyh4aGNpLCAiJXMgY2FsbGVk
IGZvciB1ZGV2ICVwXG4iLCBfX2Z1bmNfXywgdWRldik7DQo+ID4gPj4+ICAgICB2aXJ0X2RldiA9
IHhoY2ktPmRldnNbdWRldi0+c2xvdF9pZF07DQo+ID4gPj4+DQo+ID4gPj4+ICsgICBpZiAoeGhj
aS0+cXVpcmtzICYgWEhDSV9NVEtfSE9TVCkgew0KPiA+ID4+PiArICAgICAgICAgICByZXQgPSB4
aGNpX210a19jaGVja19iYW5kd2lkdGgoaGNkLCB1ZGV2KTsNCj4gPiA+Pj4gKyAgICAgICAgICAg
aWYgKHJldCA8IDApDQo+ID4gPj4+ICsgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4g
PiA+Pj4gKyAgIH0NCj4gPiA+Pj4gKw0KPiA+ID4+DQo+ID4gPj4gSnVzdCBub3RpY2VkIHRoYXQg
WEhDSV9NVEtfSE9TVCBxdWlyayBpcyBvbmx5IHNldCBpbiB4aGNpLW10ay5jLg0KPiA+ID4+IHho
Y2ktbXRrLmMgY2FsbHMgeGhjaV9pbml0X2RyaXZlciguLi4sIHhoY2lfbXRrX292ZXJyaWRlcykg
d2l0aCBhIC5yZXNldCBvdmVycmlkZSBmdW5jdGlvbi4NCj4gPiA+Pg0KPiA+ID4+IHdoeSBub3Qg
YWRkIG92ZXJyaWRlIGZ1bmN0aW9ucyBmb3IgLmNoZWNrX2JhbmR3aWR0aCBhbmQgLnJlc2V0X2Jh
bmR3aWR0aCB0byB4aGNpX210a19vdmVycmlkZXMgaW5zdGVhZD8NCj4gPiA+Pg0KPiA+ID4+IEFu
b3RoZXIgcGF0Y2ggdG8gYWRkIHNpbWlsYXIgb3ZlcnJpZGVzIGZvciAuYWRkX2VuZHBvaW50IGFu
ZCAuZHJvcF9lbmRwb2ludCBzaG91bGQgcHJvYmFibHkgYmUNCj4gPiA+PiBkb25lIHNvIHRoYXQg
d2UgY2FuIGdldCByaWQgb2YgdGhlIHhoY2lfbXRrX2FkZC9kcm9wX2VwX3F1aXJrKCkgY2FsbHMg
aW4geGhjaS5jIGFzIHdlbGwNCj4gPiA+IFlvdSBtZWFuLCB3ZSBjYW4gZXhwb3J0IHhoY2lfYWRk
L2Ryb3BfZW5kcG9pbnQoKT8NCj4gPg0KPiA+IEkgdGhpbmsgc28sIHVubGVzcyB5b3UgaGF2ZSBh
IGJldHRlciBpZGVhLg0KPiA+IEkgcHJlZmVyIGV4cG9ydGluZyB0aGUgZ2VuZXJpYyBhZGQvZHJv
cF9lbmRwb2ludCBmdW5jdGlvbnMgcmF0aGVyIHRoYW4gdGhlIHZlbmRvciBzcGVjaWZpYyBxdWly
ayBmdW5jdGlvbnMuDQo+ID4NCj4gDQo+IFdoZW4gbW92aW5nIG91dCBhbGwgTVRLX0hPU1QgcXVp
cmtzIGFuZCB1bmxpbmsgeGhjaS1tdGstc2NoIGZyb20geGhjaSwNCj4geGhjaS1tdGstc2NoIHN0
aWxsIG5lZWRzIHRvIHRvdWNoIHRoZSB4aGNpIGludGVybmFscywgYXQgbGVhc3Qgc3RydWN0DQo+
IHhoY2lfZXBfY3R4Lg0KPiANCj4gTXkgbmFpdmUgaWRlYSBpcyBqdXN0IGxldCB4aGNpIGV4cG9y
dCBvbmUgbW9yZSBmdW5jdGlvbiB0byBleHBvc2UgeGhjaV9lcF9jdHguDQo+IEJ1dCBJJ20gbm90
IHN1cmUgd2hldGhlciB0aGlzIGlzIGFjY2VwdGFibGU6DQpJIGZpbmQgdGhhdCB4aGNpX2FkZF9l
bmRwb2ludCgpIGlnbm9yZXMgc29tZSBlcnJvcnMgd2l0aCByZXR1cm4gMCwgZm9yDQp0aGVzZSBj
YXNlcyB3ZSBuZWVkbid0IGNhbGwgeGhjaV9tdGtfYWRkX2VwLXF1aXJrKCksIHNvIG1heSBiZSBu
b3QgYQ0KZ29vZCB3YXkgdG8ganVzdCBleHBvcnQgeGhjaV9hZGRfZW5kcG9pbnQoKS4NCg0KPiAN
Cj4gK3N0cnVjdCB4aGNpX2VwX2N0eCogeGhjaV9nZXRfZXBfY29udGV4KHN0cnVjdCB4aGNpX2hj
ZCAqeGhjaSwgc3RydWN0DQo+IHVzYl9ob3N0X2VuZHBvaW50ICplcCkNCj4gK3sgLi4uIH0NCj4g
K0VYUE9SVF9TWU1CT0woeGhjaV9nZXRfZXBfY29udGV4dCk7DQo+IA0KPiBCdXQgZm9yIHY2LCBJ
J20gZ29pbmcgdG8gc3VibWl0IGEgcGF0Y2ggd2l0aCB7Y2hlY2t8cmVzZXR9X2JhbmR3aWR0aCgp
DQo+IHF1aXJrIGZ1bmN0aW9uDQo+ICBzd2l0Y2hlZCBpbnRvIHhoY2lfZHJpdmVyX292ZXJyaWRl
cyBmaXJzdC4gKGFuZCBwcmVzZXJ2ZSBleGlzdGluZw0KPiBNVEtfSE9TVCBxdWlyayBmdW5jdGlv
bnMpLg0KPiANCj4gVGhhbmtzIQ0KPiANCj4gPiAtTWF0aGlhcw0KPiA+DQoNCg==

