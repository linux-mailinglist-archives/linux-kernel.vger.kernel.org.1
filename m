Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6906E2BA2A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKTGtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:49:10 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63095 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727113AbgKTGtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:49:09 -0500
X-UUID: a11ffd10b6954e028d92ab998d2fbca8-20201120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=4lVDMuVkFUdI9VsgXnEVZ+MC7jCYkAiO9icTqnOC4OY=;
        b=QljlJLdXZjHscn/1qlc9JmciuZGo5xweDKIVxMClw/KFIAqkerIxtC7svTsyN53KsjuBYaBKMpLcl8RiBepqxkJkKvJ7kDqKZ3NlIBgTuJ47zG1lv5TJDt6bN+yHhZwiycHJLdUEw3/ch+8wk3Or8NlsL6XPdSZbFIcnklbq2/Q=;
X-UUID: a11ffd10b6954e028d92ab998d2fbca8-20201120
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1286874099; Fri, 20 Nov 2020 14:48:53 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 20 Nov
 2020 14:48:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Nov 2020 14:48:50 +0800
Message-ID: <1605854930.3995.8.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: musb: remove unused variable 'devctl'
From:   Min Guo <min.guo@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bin Liu <b-liu@ti.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 20 Nov 2020 14:48:50 +0800
In-Reply-To: <X7UKJtWtE0UZgqAQ@kroah.com>
References: <20201117082125.7619-1-min.guo@mediatek.com>
         <X7UKJtWtE0UZgqAQ@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3E62456714BCD4CF737C2489202A3C930B0AFD70CFB2E3D40B0BFC2915D08B002000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZ3JlZyBrLWg6DQpPbiBXZWQsIDIwMjAtMTEtMTggYXQgMTI6NDggKzAxMDAsIEdyZWcgS3Jv
YWgtSGFydG1hbiB3cm90ZToNCj4gT24gVHVlLCBOb3YgMTcsIDIwMjAgYXQgMDQ6MjE6MjVQTSAr
MDgwMCwgbWluLmd1b0BtZWRpYXRlay5jb20gd3JvdGU6DQo+ID4gRnJvbTogTWluIEd1byA8bWlu
Lmd1b0BtZWRpYXRlay5jb20+DQo+ID4gDQo+ID4gUmVtb3ZlIHVudXNlZCAnZGV2Y3RsJyB2YXJp
YWJsZSB0byBmaXggY29tcGlsZSB3YXJuaW5nczoNCj4gPiANCj4gPiAgICAgZHJpdmVycy91c2Iv
bXVzYi9tdXNiaHNkbWEuYzogSW4gZnVuY3Rpb24gJ2RtYV9jb250cm9sbGVyX2lycSc6DQo+ID4g
ICAgIGRyaXZlcnMvdXNiL211c2IvbXVzYmhzZG1hLmM6MzI0Ojg6IHdhcm5pbmc6IHZhcmlhYmxl
ICdkZXZjdGwnIHNldA0KPiA+ICAgICBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFy
aWFibGVdDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWluIEd1byA8bWluLmd1b0BtZWRpYXRl
ay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL211c2IvbXVzYmhzZG1hLmMgfCA0IC0t
LS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgZGVsZXRpb25zKC0pDQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdXNiL211c2IvbXVzYmhzZG1hLmMgYi9kcml2ZXJzL3VzYi9tdXNiL211
c2Joc2RtYS5jDQo+ID4gaW5kZXggMGFhY2ZjOGJlNWExLi43YWNkMTYzNTg1MGQgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy91c2IvbXVzYi9tdXNiaHNkbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMv
dXNiL211c2IvbXVzYmhzZG1hLmMNCj4gPiBAQCAtMzIxLDggKzMyMSw2IEBAIGlycXJldHVybl90
IGRtYV9jb250cm9sbGVyX2lycShpbnQgaXJxLCB2b2lkICpwcml2YXRlX2RhdGEpDQo+ID4gIAkJ
CQltdXNiX2NoYW5uZWwtPmNoYW5uZWwuc3RhdHVzID0NCj4gPiAgCQkJCQlNVVNCX0RNQV9TVEFU
VVNfQlVTX0FCT1JUOw0KPiA+ICAJCQl9IGVsc2Ugew0KPiA+IC0JCQkJdTggZGV2Y3RsOw0KPiA+
IC0NCj4gPiAgCQkJCWFkZHIgPSBtdXNiX3JlYWRfaHNkbWFfYWRkcihtYmFzZSwNCj4gPiAgCQkJ
CQkJYmNoYW5uZWwpOw0KPiA+ICAJCQkJY2hhbm5lbC0+YWN0dWFsX2xlbiA9IGFkZHINCj4gPiBA
QCAtMzM2LDggKzMzNCw2IEBAIGlycXJldHVybl90IGRtYV9jb250cm9sbGVyX2lycShpbnQgaXJx
LCB2b2lkICpwcml2YXRlX2RhdGEpDQo+ID4gIAkJCQkJCTwgbXVzYl9jaGFubmVsLT5sZW4pID8N
Cj4gPiAgCQkJCQkiPT4gcmVjb25maWcgMCIgOiAiPT4gY29tcGxldGUiKTsNCj4gPiAgDQo+ID4g
LQkJCQlkZXZjdGwgPSBtdXNiX3JlYWRiKG1iYXNlLCBNVVNCX0RFVkNUTCk7DQo+IA0KPiBBcmUg
eW91IHN1cmUgdGhhdCB0aGUgaGFyZHdhcmUgZG9lcyBub3QgcmVxdWlyZSB0aGlzIHJlYWQgdG8g
Y29tcGxldGUNCj4gdGhlIGNvbW1hbmQ/ICBMb3RzIG9mIGhhcmR3YXJlIGlzIHRoYXQgd2F5LCBz
byBiZSB2ZXJ5IGNhcmVmdWwgYWJvdXQNCj4gdGhpcy4gIERpZCB5b3UgdGVzdCBpdD8NCg0KSSBo
YXZlIHRlc3RlZCB0aGlzIHBhdGNoIG9uIE1lZGlhdGVrJ3MgcGxhdGZvcm0sIGFuZCBub3Qgc3Vy
ZSBpZiBpdA0Kd2lsbCBhZmZlY3Qgb3RoZXIgdmVuZG9ycycgcGxhdGZvcm1zLg0KDQpEZWFyIEJp
bjoNCg0KRG9lcyB0aGlzIHBhdGNoIHdpbGwgYWZmZWN0IG90aGVyIHZlbmRvcnMnIHBsYXRmb3Jt
cz8NCg0KQmVzdCBSZWdhcmRzLA0KTWluDQoNCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

