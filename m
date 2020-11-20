Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065D72BA3A0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKTHmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:42:14 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:1851 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbgKTHmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:42:14 -0500
X-UUID: bef345316d344226aa8e34e76254d695-20201120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QrtfONSRiU7ltWf5szNhXaV3PjN76TxvHHg+FHQl7P0=;
        b=cpad2A2Gdcm/mL9WzWoCLEvboAVrVP+UpfSSQs0aGuD9fKWyWylfTTr4/vPAZ1xzR6T+rySked9jSm2aZwX6en2zMUJ6whoCFDCjHTOn84vTSs3tSf0TgDyLBpeFAk0NZYNrP9SErjmcZ5B9metgO6tJmnwAJaZHndEJatR6TWw=;
X-UUID: bef345316d344226aa8e34e76254d695-20201120
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 924097747; Fri, 20 Nov 2020 15:42:09 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 20 Nov
 2020 15:42:07 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Nov 2020 15:42:06 +0800
Message-ID: <1605858126.3995.14.camel@mhfsdcap03>
Subject: Re: [PATCH] usb: musb: remove unused variable 'devctl'
From:   Min Guo <min.guo@mediatek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Bin Liu <b-liu@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>,
        <chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 20 Nov 2020 15:42:06 +0800
In-Reply-To: <X7doKlP1k824LGGN@kroah.com>
References: <20201117082125.7619-1-min.guo@mediatek.com>
         <X7UKJtWtE0UZgqAQ@kroah.com> <1605854930.3995.8.camel@mhfsdcap03>
         <X7doKlP1k824LGGN@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 16F7BFE9A68A3E3243F772D87E4DF57BA1D854B8FAD890BB6FF27A5D2E32CE022000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTExLTIwIGF0IDA3OjU0ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3Jv
dGU6DQo+IE9uIEZyaSwgTm92IDIwLCAyMDIwIGF0IDAyOjQ4OjUwUE0gKzA4MDAsIE1pbiBHdW8g
d3JvdGU6DQo+ID4gSGkgZ3JlZyBrLWg6DQo+ID4gT24gV2VkLCAyMDIwLTExLTE4IGF0IDEyOjQ4
ICswMTAwLCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE5vdiAxNywg
MjAyMCBhdCAwNDoyMToyNVBNICswODAwLCBtaW4uZ3VvQG1lZGlhdGVrLmNvbSB3cm90ZToNCj4g
PiA+ID4gRnJvbTogTWluIEd1byA8bWluLmd1b0BtZWRpYXRlay5jb20+DQo+ID4gPiA+IA0KPiA+
ID4gPiBSZW1vdmUgdW51c2VkICdkZXZjdGwnIHZhcmlhYmxlIHRvIGZpeCBjb21waWxlIHdhcm5p
bmdzOg0KPiA+ID4gPiANCj4gPiA+ID4gICAgIGRyaXZlcnMvdXNiL211c2IvbXVzYmhzZG1hLmM6
IEluIGZ1bmN0aW9uICdkbWFfY29udHJvbGxlcl9pcnEnOg0KPiA+ID4gPiAgICAgZHJpdmVycy91
c2IvbXVzYi9tdXNiaHNkbWEuYzozMjQ6ODogd2FybmluZzogdmFyaWFibGUgJ2RldmN0bCcgc2V0
DQo+ID4gPiA+ICAgICBidXQgbm90IHVzZWQgWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+
ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNaW4gR3VvIDxtaW4uZ3VvQG1lZGlhdGVr
LmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3VzYi9tdXNiL211c2Joc2RtYS5j
IHwgNCAtLS0tDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gPiA+
ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9tdXNiL211c2Joc2RtYS5jIGIv
ZHJpdmVycy91c2IvbXVzYi9tdXNiaHNkbWEuYw0KPiA+ID4gPiBpbmRleCAwYWFjZmM4YmU1YTEu
LjdhY2QxNjM1ODUwZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy91c2IvbXVzYi9tdXNi
aHNkbWEuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3VzYi9tdXNiL211c2Joc2RtYS5jDQo+ID4g
PiA+IEBAIC0zMjEsOCArMzIxLDYgQEAgaXJxcmV0dXJuX3QgZG1hX2NvbnRyb2xsZXJfaXJxKGlu
dCBpcnEsIHZvaWQgKnByaXZhdGVfZGF0YSkNCj4gPiA+ID4gIAkJCQltdXNiX2NoYW5uZWwtPmNo
YW5uZWwuc3RhdHVzID0NCj4gPiA+ID4gIAkJCQkJTVVTQl9ETUFfU1RBVFVTX0JVU19BQk9SVDsN
Cj4gPiA+ID4gIAkJCX0gZWxzZSB7DQo+ID4gPiA+IC0JCQkJdTggZGV2Y3RsOw0KPiA+ID4gPiAt
DQo+ID4gPiA+ICAJCQkJYWRkciA9IG11c2JfcmVhZF9oc2RtYV9hZGRyKG1iYXNlLA0KPiA+ID4g
PiAgCQkJCQkJYmNoYW5uZWwpOw0KPiA+ID4gPiAgCQkJCWNoYW5uZWwtPmFjdHVhbF9sZW4gPSBh
ZGRyDQo+ID4gPiA+IEBAIC0zMzYsOCArMzM0LDYgQEAgaXJxcmV0dXJuX3QgZG1hX2NvbnRyb2xs
ZXJfaXJxKGludCBpcnEsIHZvaWQgKnByaXZhdGVfZGF0YSkNCj4gPiA+ID4gIAkJCQkJCTwgbXVz
Yl9jaGFubmVsLT5sZW4pID8NCj4gPiA+ID4gIAkJCQkJIj0+IHJlY29uZmlnIDAiIDogIj0+IGNv
bXBsZXRlIik7DQo+ID4gPiA+ICANCj4gPiA+ID4gLQkJCQlkZXZjdGwgPSBtdXNiX3JlYWRiKG1i
YXNlLCBNVVNCX0RFVkNUTCk7DQo+ID4gPiANCj4gPiA+IEFyZSB5b3Ugc3VyZSB0aGF0IHRoZSBo
YXJkd2FyZSBkb2VzIG5vdCByZXF1aXJlIHRoaXMgcmVhZCB0byBjb21wbGV0ZQ0KPiA+ID4gdGhl
IGNvbW1hbmQ/ICBMb3RzIG9mIGhhcmR3YXJlIGlzIHRoYXQgd2F5LCBzbyBiZSB2ZXJ5IGNhcmVm
dWwgYWJvdXQNCj4gPiA+IHRoaXMuICBEaWQgeW91IHRlc3QgaXQ/DQo+ID4gDQo+ID4gSSBoYXZl
IHRlc3RlZCB0aGlzIHBhdGNoIG9uIE1lZGlhdGVrJ3MgcGxhdGZvcm0sIGFuZCBub3Qgc3VyZSBp
ZiBpdA0KPiA+IHdpbGwgYWZmZWN0IG90aGVyIHZlbmRvcnMnIHBsYXRmb3Jtcy4NCj4gPiANCj4g
PiBEZWFyIEJpbjoNCj4gPiANCj4gPiBEb2VzIHRoaXMgcGF0Y2ggd2lsbCBhZmZlY3Qgb3RoZXIg
dmVuZG9ycycgcGxhdGZvcm1zPw0KPiANCj4gVGhlIGhhcmR3YXJlIHNwZWNzIHdpbGwgYW5zd2Vy
IHRoaXMgcXVlc3Rpb24sIHdoYXQgZG8gdGhleSBzYXkgYWJvdXQNCj4gdGhpcyByZWFkPw0KDQpT
b3JyeSwgSSBkaWRuJ3Qgc2VlbiB0aGUgY29tbWVudCBvbiB0aGUgaGFyZHdhcmUgc3BlY3MgaW5k
aWNhdGUgdGhhdA0KZGV2Y3RsIHJlZ2lzdGVyIG5lZWRzIHRvIHJlYWQgb25jZSB0byB0YWtlIGVm
ZmVjdC4NCg0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=

