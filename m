Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D4304712
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbhAZROk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:14:40 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:20753 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729503AbhAZGDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:03:04 -0500
X-UUID: 2d7ec4f07c9e4302a984a65ee1b9eef6-20210126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dKXUzd4QfWfdXhez2qIYlgB4VKFnh57HVcDONeqjh1g=;
        b=rQLDoUatx8DSmy0gZgxgKWUTTeNxviTVNMYOtDM7g9bP/Zj3nq1UQTczzNNMfNC8SYv3eT5DgZqRkAsFoa2hjj/3zlhcAuPjOtXJ8yGA/qro8bH/MJebXbrRhnq0gqaAw96l5USixpec8JSdWaeQLTXmLDF7h7+pmZTBbQeHgt8=;
X-UUID: 2d7ec4f07c9e4302a984a65ee1b9eef6-20210126
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 266509547; Tue, 26 Jan 2021 14:02:09 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 26 Jan
 2021 14:02:00 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 14:02:00 +0800
Message-ID: <1611640920.3905.13.camel@mhfsdcap03>
Subject: Re: [PATCH v6] usb: xhci-mtk: fix unreleased bandwidth data
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        "Zhanyong Wang" <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jan 2021 14:02:00 +0800
In-Reply-To: <20210113180444.v6.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
References: <20210113180444.v6.1.Id0d31b5f3ddf5e734d2ab11161ac5821921b1e1e@changeid>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5D3DE7CE5C32552355CF39D9DCA8F35668EC69EFD0B94DE935E059906A1B7EA92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSWtqb29uLA0KDQpDYW4gSSBwdXQgdGhpcyBwYXRjaCBpbnRvIG15IHBhdGNoIHNlcmllcyBh
Ym91dCBiYW5kd2lkdGggc2NoZWR1bGVyPw0KdGhlIHNlcmllcyBhbHNvIGluY2x1ZGUgIltSRkMg
UEFUQ0ggdjMgMS81XSB1c2I6IHhoY2ktbXRrOiBpbXByb3ZlDQpiYW5kd2lkdGggc2NoZWR1bGlu
ZyB3aXRoIG11bHRpLVRUIiwgcHV0IHRoZW0gdG9nZXRoZXIgd2lsbCBoZWxwIHRvIGZpeA0KZGVw
ZW5kZW5jZSBpc3N1ZSwgbWVhbndoaWxlIEkgdHJ5IHRvIGJ1aWxkIHhoY2ktbXRrLXNjaC5jIGlu
dG8NCnhoY2ktbXRrLmtvIGluc3RlYWQgb2YgeGhjaS1oY2Qua28uDQoNClRoYW5rcyBhIGxvdA0K
DQoNCk9uIFdlZCwgMjAyMS0wMS0xMyBhdCAxODowNSArMDgwMCwgSWtqb29uIEphbmcgd3JvdGU6
DQo+IHhoY2ktbXRrIG5lZWRzIFhIQ0lfTVRLX0hPU1QgcXVpcmsgZnVuY3Rpb25zIGluIGFkZF9l
bmRwb2ludCgpIGFuZA0KPiBkcm9wX2VuZHBvaW50KCkgdG8gaGFuZGxlIGl0cyBvd24gc3cgYmFu
ZHdpZHRoIG1hbmFnZW1lbnQuDQo+IA0KPiBJdCBzdG9yZXMgYmFuZHdpZHRoIGRhdGEgaW50byBh
biBpbnRlcm5hbCB0YWJsZSBldmVyeSB0aW1lDQo+IGFkZF9lbmRwb2ludCgpIGlzIGNhbGxlZCwg
YW5kIGRyb3BzIHRob3NlIGluIGRyb3BfZW5kcG9pbnQoKS4NCj4gQnV0IHdoZW4gYmFuZHdpZHRo
IGFsbG9jYXRpb24gZmFpbHMgYXQgb25lIGVuZHBvaW50LCBhbGwgZWFybGllcg0KPiBhbGxvY2F0
aW9uIGZyb20gdGhlIHNhbWUgaW50ZXJmYWNlIGNvdWxkIHN0aWxsIHJlbWFpbiBhdCB0aGUgdGFi
bGUuDQo+IA0KPiBUaGlzIHBhdGNoIG1vdmVzIGJhbmR3aWR0aCBtYW5hZ2VtZW50IGNvZGVzIHRv
IGNoZWNrX2JhbmR3aWR0aCgpIGFuZA0KPiByZXNldF9iYW5kd2lkdGgoKSBwYXRoLiBUbyBkbyBz
bywgdGhpcyBwYXRjaCBhbHNvIGFkZHMgdGhvc2UgZnVuY3Rpb25zDQo+IHRvIHhoY2lfZHJpdmVy
X292ZXJyaWRlcyBhbmQgbGV0cyBtdGsteGhjaSB0byByZWxlYXNlIGFsbCBmYWlsZWQNCj4gZW5k
cG9pbnRzIGluIHJlc2V0X2JhbmR3aWR0aCgpIHBhdGguDQo+IA0KPiBGaXhlczogMDhlNDY5ZGU4
N2EyICgidXNiOiB4aGNpLW10azogc3VwcG9ydHMgYmFuZHdpZHRoIHNjaGVkdWxpbmcgd2l0aCBt
dWx0aS1UVCIpDQo+IFNpZ25lZC1vZmYtYnk6IElram9vbiBKYW5nIDxpa2puQGNocm9taXVtLm9y
Zz4NCj4gDQo+IC0tLQ0KPiANCj4gQ2hhbmdlcyBpbiB2NjoNCj4gLSB1c2UgeGhjaSBvdmVycmlk
ZXMgaW5zdGVhZCBvZiBxdWlyayBmdW5jdGlvbnMgZm9yDQo+ICAge2NoZWNrfHJlc2V0fV9iYW5k
d2lkdGgoKS4NCj4gDQo+IENoYW5nZXMgaW4gdjU6DQo+IC0gRml4IGEgd3JvbmcgY29tbWl0IGlk
IGluIEZpeGVzIHRhZw0KPiANCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBidWdmaXggaW4gdjMsIGNo
ZWNrX2JhbmR3aWR0aCgpIHJldHVybiB1bmluaXRpYWxpemVkIHZhbHVlDQo+ICAgd2hlbiBubyBu
ZXcgZW5kcG9pbnRzIHdlcmUgYWRkZWQuDQo+IC0gY2hhbmdlIEZpeGVzIHRhZyB0byBrZWVwIGRl
cGVuZGVuY3kNCj4gDQo+IENoYW5nZXMgaW4gdjM6DQo+IC0gZHJvcCB1bnJlbGF0ZWQgY29kZSBj
bGVhbnVwcw0KPiAtIGNoYW5nZSBGaXhlcyB0YWcgdG8ga2VlcCBkZXBlbmRlbmN5DQo+IA0KPiBD
aGFuZ2VzIGluIHYyOg0KPiAtIGZpeCBhIDAtZGF5IHdhcm5pbmcgZnJvbSB1bnVzZWQgdmFyaWFi
bGUNCj4gLSBzcGxpdCBvbmUgYmlnIHBhdGNoIGludG8gdGhyZWUgcGF0Y2hlcw0KPiAtIGZpeCB3
cm9uZyBvZmZzZXQgaW4gbWVkaWF0ZWsgaHcgZmxhZ3MNCj4gDQo+ICBkcml2ZXJzL3VzYi9ob3N0
L3hoY2ktbXRrLXNjaC5jIHwgMTIzICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+
ICBkcml2ZXJzL3VzYi9ob3N0L3hoY2ktbXRrLmMgICAgIHwgICAyICsNCj4gIGRyaXZlcnMvdXNi
L2hvc3QveGhjaS1tdGsuaCAgICAgfCAgMTMgKysrKw0KPiAgZHJpdmVycy91c2IvaG9zdC94aGNp
LmMgICAgICAgICB8ICAgOCArKy0NCj4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS5oICAgICAgICAg
fCAgIDQgKysNCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTExIGluc2VydGlvbnMoKyksIDM5IGRlbGV0
aW9ucygtKQ0KDQoNCg==

