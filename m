Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C7D2D920A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 04:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438299AbgLNDZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 22:25:42 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:46949 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726250AbgLNDZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 22:25:41 -0500
X-UUID: d4d0fec30fa24fbea20613282609cbc8-20201214
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=uqUvCWtf27nxQjiM4iTofVBTFdxaqp7ppKL1RHS9HJg=;
        b=sZ7luNVi9AgApQz6VeKP+6QIA1mlhCnjI77dPESKaJyF4hfM2XWC+qed864iIfD3JP1UPW1CJa0092Q8otamFsCzr4FuvOqZ3onJvsIOyW9ygfNnh0gjKiFOFiE9kOM+6tnddlW17EOnm0LigjGIaZy12UH3iFDPqoFL518VVwM=;
X-UUID: d4d0fec30fa24fbea20613282609cbc8-20201214
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 614733171; Mon, 14 Dec 2020 11:24:55 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 14 Dec
 2020 11:24:49 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Dec 2020 11:24:49 +0800
Message-ID: <1607916289.23328.21.camel@mhfsdcap03>
Subject: Re: [PATCH v2 0/3] Release allocated periodic bandwidth data from
 reset_bandwidth()
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        "Zhanyong Wang" <zhanyong.wang@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Mon, 14 Dec 2020 11:24:49 +0800
In-Reply-To: <CAATdQgBZn3oehw_20D3yMmDA8G61oMHVax8LqJ-hPQv+9kJGLQ@mail.gmail.com>
References: <20201210104747.3416781-1-ikjn@chromium.org>
         <1607651584.23328.20.camel@mhfsdcap03>
         <CAATdQgBZn3oehw_20D3yMmDA8G61oMHVax8LqJ-hPQv+9kJGLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5F4A39B486DF1B1350015DA44A42F81388C6B305FFFE3CD87B6116D59E3937AD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTExIGF0IDE0OjM2ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4g
T24gRnJpLCBEZWMgMTEsIDIwMjAgYXQgOTo1MyBBTSBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1
bkBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCAyMDIwLTEyLTEwIGF0IDE4
OjQ3ICswODAwLCBJa2pvb24gSmFuZyB3cm90ZToNCj4gPiA+IHhoY2ktbXRrIHJlbGVhc2VzIGFs
bG9jYXRlZCBUVCBiYW5kd2lkdGggZGF0YSBvbmx5IHdoZW4gd2hvbGUNCj4gPiA+IGVuZHBvaW50
cyBvZiBhIGRldmljZSBhcmUgZHJvcHBlZCBhcyB0aGVyZSdyZSBvbmx5IHthZGR8ZHJvcH1fZW5k
cG9pbnQoKQ0KPiA+ID4gaG9va3MgYXJlIGRlZmluZWQuIFRoaXMgcGF0Y2hzZXQgYWRkcyBtb3Jl
IGhvb2tzIGFuZCByZWxlYXNlcyBhbGwNCj4gPiA+IGJhbmR3aWR0aCBkYXRhIGZyb20gcmVzZXRf
YmFuZHdpZHRoKCkgcGF0aCwgbm90IGRyb3BfZW5kcG9pbnQoKS4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4gQ2hhbmdlcyBpbiB2MjoNCj4gPiA+IC0gZml4IGEgMC1kYXkgd2FybmluZyBmcm9tIHVudXNl
ZCB2YXJpYWJsZQ0KPiA+ID4gLSBzcGxpdCBvbmUgYmlnIHBhdGNoIGludG8gdGhyZWUgcGF0Y2hl
cw0KPiA+ID4gLSBidWdmaXggaW4gaHcgZmxhZ3MNCj4gPiA+DQo+ID4gPiBJa2pvb24gSmFuZyAo
Myk6DQo+ID4gPiAgIHVzYjogeGhjaS1tdGs6IGNvZGUgY2xlYW51cHMgaW4gZ2V0dGluZyBiYW5k
d2lkdGggdGFibGUNCj4gPiA+ICAgdXNiOiB4aGNpLW10azogZGVsYXkgYXNzb2NpYXRpb24gb2Yg
dHQgYW5kIGVwDQo+ID4gPiAgIHVzYjogeGhjaS1tdGs6IGZpeCB1bnJlbGVhc2VkIGJhbmR3aWR0
aCBkYXRhDQo+ID4gPg0KPiA+ID4gIGRyaXZlcnMvdXNiL2hvc3QveGhjaS1tdGstc2NoLmMgfCAx
ODAgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0NCj4gPiA+ICBkcml2ZXJzL3VzYi9o
b3N0L3hoY2ktbXRrLmggICAgIHwgIDEzICsrKw0KPiA+ID4gIGRyaXZlcnMvdXNiL2hvc3QveGhj
aS5jICAgICAgICAgfCAgIDkgKysNCj4gPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEzMyBpbnNlcnRp
b25zKCspLCA2OSBkZWxldGlvbnMoLSkNCj4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gsIEknbGwg
dGVzdCBpdCBhbmQgY2hlY2sgaXQgd2l0aCBvdXIgREUNCj4gDQo+IFRoYW5rcywgSSB3aWxsIHVw
bG9hZCB2My4NCj4gQnV0IEkgZG9uJ3QgZXhwZWN0IGFueSBsb2dpYyBjaGFuZ2VzIGZyb20gdjIu
DQo+IENhbiB5b3UgcGxlYXNlIGdpdmUgbWUgZmVlZGJhY2sgb24gdjIgaWYgeW91IGZpbmQgYW55
dGhpbmc/DQpPaw0KDQo+IA0KPiA+DQo+ID4gPg0KPiA+DQoNCg==

