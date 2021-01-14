Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7452F586D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhANCYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:24:33 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:24819 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725997AbhANCYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:24:30 -0500
X-UUID: 2241d1b2e2e647a9b8dcef62b71b080d-20210114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=0f8PN7MZ8lryr7shQx6RispXN42qI03UFJy1nYTtVSY=;
        b=RjfS9u9i0ZbvSUQHh+FUybKa9AEmf+r8uudOotuRlcQY9eMqyFfvV+6HPfzCmpHvjigiQKNgKiXd9CXld90Pq3iT8zeZc6c4H/N070k4aDxfpnIcPDz2Ujc0GMsbBtPG8ffDkFJK884R5hvsrQOY/TdkHjBD/rb4CQSESyPcHrY=;
X-UUID: 2241d1b2e2e647a9b8dcef62b71b080d-20210114
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1670023909; Thu, 14 Jan 2021 10:23:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 14 Jan
 2021 10:23:38 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Jan 2021 10:23:37 +0800
Message-ID: <1610591018.30053.9.camel@mhfsdcap03>
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
Date:   Thu, 14 Jan 2021 10:23:38 +0800
In-Reply-To: <CAATdQgD2OAmf7_NWSVwzyJE7mF0vngzE=QeE79PS7MJsgPhbtA@mail.gmail.com>
References: <20201229142406.v5.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
         <2aea44f0-85e7-fd55-2c35-c1d994f20e03@linux.intel.com>
         <1610086308.24856.30.camel@mhfsdcap03>
         <e43632e2-08b3-7a1a-8272-1d493e25fc67@linux.intel.com>
         <CAATdQgD2OAmf7_NWSVwzyJE7mF0vngzE=QeE79PS7MJsgPhbtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: D96C631E47A1733E1479224AE790FF99A3F6127D3291F12C857B76F92C1FF2022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTAxLTEyIGF0IDEzOjQ4ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gRnJpLCBKYW4gOCwgMjAyMSBhdCAxMDo0NCBQTSBNYXRoaWFzIE55bWFuDQo+IDxtYXRoaWFz
Lm55bWFuQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiA4LjEuMjAyMSA4LjEx
LCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDIwMjEtMDEtMDcgYXQgMTM6MDkg
KzAyMDAsIE1hdGhpYXMgTnltYW4gd3JvdGU6DQo+ID4gPj4gT24gMjkuMTIuMjAyMCA4LjI0LCBJ
a2pvb24gSmFuZyB3cm90ZToNCj4gPiA+Pj4geGhjaS1tdGsgaGFzIGhvb2tzIG9uIGFkZF9lbmRw
b2ludCgpIGFuZCBkcm9wX2VuZHBvaW50KCkgZnJvbSB4aGNpDQo+ID4gPj4+IHRvIGhhbmRsZSBp
dHMgb3duIHN3IGJhbmR3aWR0aCBtYW5hZ2VtZW50cyBhbmQgc3RvcmVzIGJhbmR3aWR0aCBkYXRh
DQo+ID4gPj4+IGludG8gaW50ZXJuYWwgdGFibGUgZXZlcnkgdGltZSBhZGRfZW5kcG9pbnQoKSBp
cyBjYWxsZWQsDQo+ID4gPj4+IHNvIHdoZW4gYmFuZHdpZHRoIGFsbG9jYXRpb24gZmFpbHMgYXQg
b25lIGVuZHBvaW50LCBhbGwgZWFybGllcg0KPiA+ID4+PiBhbGxvY2F0aW9uIGZyb20gdGhlIHNh
bWUgaW50ZXJmYWNlIGNvdWxkIHN0aWxsIHJlbWFpbiBhdCB0aGUgdGFibGUuDQo+ID4gPj4+DQo+
ID4gPj4+IFRoaXMgcGF0Y2ggYWRkcyB0d28gbW9yZSBob29rcyBmcm9tIGNoZWNrX2JhbmR3aWR0
aCgpIGFuZA0KPiA+ID4+PiByZXNldF9iYW5kd2lkdGgoKSwgYW5kIG1ha2UgbXRrLXhoY2kgdG8g
cmVsZWFzZXMgYWxsIGZhaWxlZCBlbmRwb2ludHMNCj4gPiA+Pj4gZnJvbSByZXNldF9iYW5kd2lk
dGgoKS4NCj4gPiA+Pj4NCj4gPiA+Pj4gRml4ZXM6IDA4ZTQ2OWRlODdhMiAoInVzYjogeGhjaS1t
dGs6IHN1cHBvcnRzIGJhbmR3aWR0aCBzY2hlZHVsaW5nIHdpdGggbXVsdGktVFQiKQ0KPiA+ID4+
PiBTaWduZWQtb2ZmLWJ5OiBJa2pvb24gSmFuZyA8aWtqbkBjaHJvbWl1bS5vcmc+DQo+ID4gPj4+
DQo+ID4gPj4NCj4gPiA+PiAuLi4NCj4gPiA+Pg0KPiA+ID4+Pg0KPiA+ID4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMgYi9kcml2ZXJzL3VzYi9ob3N0L3hoY2kuYw0KPiA+
ID4+PiBpbmRleCBkNGE4ZDBlZmJiYzQuLmUxZmNkM2NmNzIzZiAxMDA2NDQNCj4gPiA+Pj4gLS0t
IGEvZHJpdmVycy91c2IvaG9zdC94aGNpLmMNCj4gPiA+Pj4gKysrIGIvZHJpdmVycy91c2IvaG9z
dC94aGNpLmMNCj4gPiA+Pj4gQEAgLTI4ODIsNiArMjg4MiwxMiBAQCBzdGF0aWMgaW50IHhoY2lf
Y2hlY2tfYmFuZHdpZHRoKHN0cnVjdCB1c2JfaGNkICpoY2QsIHN0cnVjdCB1c2JfZGV2aWNlICp1
ZGV2KQ0KPiA+ID4+PiAgICAgeGhjaV9kYmcoeGhjaSwgIiVzIGNhbGxlZCBmb3IgdWRldiAlcFxu
IiwgX19mdW5jX18sIHVkZXYpOw0KPiA+ID4+PiAgICAgdmlydF9kZXYgPSB4aGNpLT5kZXZzW3Vk
ZXYtPnNsb3RfaWRdOw0KPiA+ID4+Pg0KPiA+ID4+PiArICAgaWYgKHhoY2ktPnF1aXJrcyAmIFhI
Q0lfTVRLX0hPU1QpIHsNCj4gPiA+Pj4gKyAgICAgICAgICAgcmV0ID0geGhjaV9tdGtfY2hlY2tf
YmFuZHdpZHRoKGhjZCwgdWRldik7DQo+ID4gPj4+ICsgICAgICAgICAgIGlmIChyZXQgPCAwKQ0K
PiA+ID4+PiArICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gPj4+ICsgICB9DQo+
ID4gPj4+ICsNCj4gPiA+Pg0KPiA+ID4+IEp1c3Qgbm90aWNlZCB0aGF0IFhIQ0lfTVRLX0hPU1Qg
cXVpcmsgaXMgb25seSBzZXQgaW4geGhjaS1tdGsuYy4NCj4gPiA+PiB4aGNpLW10ay5jIGNhbGxz
IHhoY2lfaW5pdF9kcml2ZXIoLi4uLCB4aGNpX210a19vdmVycmlkZXMpIHdpdGggYSAucmVzZXQg
b3ZlcnJpZGUgZnVuY3Rpb24uDQo+ID4gPj4NCj4gPiA+PiB3aHkgbm90IGFkZCBvdmVycmlkZSBm
dW5jdGlvbnMgZm9yIC5jaGVja19iYW5kd2lkdGggYW5kIC5yZXNldF9iYW5kd2lkdGggdG8geGhj
aV9tdGtfb3ZlcnJpZGVzIGluc3RlYWQ/DQo+ID4gPj4NCj4gPiA+PiBBbm90aGVyIHBhdGNoIHRv
IGFkZCBzaW1pbGFyIG92ZXJyaWRlcyBmb3IgLmFkZF9lbmRwb2ludCBhbmQgLmRyb3BfZW5kcG9p
bnQgc2hvdWxkIHByb2JhYmx5IGJlDQo+ID4gPj4gZG9uZSBzbyB0aGF0IHdlIGNhbiBnZXQgcmlk
IG9mIHRoZSB4aGNpX210a19hZGQvZHJvcF9lcF9xdWlyaygpIGNhbGxzIGluIHhoY2kuYyBhcyB3
ZWxsDQo+ID4gPiBZb3UgbWVhbiwgd2UgY2FuIGV4cG9ydCB4aGNpX2FkZC9kcm9wX2VuZHBvaW50
KCk/DQo+ID4NCj4gPiBJIHRoaW5rIHNvLCB1bmxlc3MgeW91IGhhdmUgYSBiZXR0ZXIgaWRlYS4N
Cj4gPiBJIHByZWZlciBleHBvcnRpbmcgdGhlIGdlbmVyaWMgYWRkL2Ryb3BfZW5kcG9pbnQgZnVu
Y3Rpb25zIHJhdGhlciB0aGFuIHRoZSB2ZW5kb3Igc3BlY2lmaWMgcXVpcmsgZnVuY3Rpb25zLg0K
PiA+DQo+IA0KPiBXaGVuIG1vdmluZyBvdXQgYWxsIE1US19IT1NUIHF1aXJrcyBhbmQgdW5saW5r
IHhoY2ktbXRrLXNjaCBmcm9tIHhoY2ksDQo+IHhoY2ktbXRrLXNjaCBzdGlsbCBuZWVkcyB0byB0
b3VjaCB0aGUgeGhjaSBpbnRlcm5hbHMsIGF0IGxlYXN0IHN0cnVjdA0KPiB4aGNpX2VwX2N0eC4N
Cj4gDQo+IE15IG5haXZlIGlkZWEgaXMganVzdCBsZXQgeGhjaSBleHBvcnQgb25lIG1vcmUgZnVu
Y3Rpb24gdG8gZXhwb3NlIHhoY2lfZXBfY3R4Lg0KPiBCdXQgSSdtIG5vdCBzdXJlIHdoZXRoZXIg
dGhpcyBpcyBhY2NlcHRhYmxlOg0KTWF0aGlhcyBzdWdnZXN0IGV4cG9ydCB4aGNpX2FkZC9kcm9w
X2VuZHBvaW50KCksIHRoZW4gd2UgY2FuIGFkZCB0d28gbmV3DQpmdW5jdGlvbnMgYXMgZm9sbG93
aW5nIGluIHhoY2ktbXRrLmM6DQoNCnhoY2lfbXRrX2FkZF9lbmRwb2ludCgpDQp7DQogICAgeGhj
aV9hZGRfZW5kcG9pbnQoKTsNCiAgICB4aGNpX210a19hZGRfZXBfcXVpcmsoKTsNCn0NCg0KeGhj
aV9tdGtfZHJvcF9lbmRwb2ludCgpDQp7DQogICAgeGhjaV9tdGtfZHJvcF9lcF9xdWlyaygpOw0K
ICAgIHhoY2lfZHJvcF9lbmRwb2ludCgpOw0KfQ0KDQpJJ2xsIHRyeSB0byB0ZXN0IGl0DQoNClRo
YW5rcw0KDQo+IA0KPiArc3RydWN0IHhoY2lfZXBfY3R4KiB4aGNpX2dldF9lcF9jb250ZXgoc3Ry
dWN0IHhoY2lfaGNkICp4aGNpLCBzdHJ1Y3QNCj4gdXNiX2hvc3RfZW5kcG9pbnQgKmVwKQ0KPiAr
eyAuLi4gfQ0KPiArRVhQT1JUX1NZTUJPTCh4aGNpX2dldF9lcF9jb250ZXh0KTsNCj4gDQo+IEJ1
dCBmb3IgdjYsIEknbSBnb2luZyB0byBzdWJtaXQgYSBwYXRjaCB3aXRoIHtjaGVja3xyZXNldH1f
YmFuZHdpZHRoKCkNCj4gcXVpcmsgZnVuY3Rpb24NCj4gIHN3aXRjaGVkIGludG8geGhjaV9kcml2
ZXJfb3ZlcnJpZGVzIGZpcnN0LiAoYW5kIHByZXNlcnZlIGV4aXN0aW5nDQo+IE1US19IT1NUIHF1
aXJrIGZ1bmN0aW9ucykuDQo+IA0KPiBUaGFua3MhDQo+IA0KPiA+IC1NYXRoaWFzDQo+ID4NCg0K

