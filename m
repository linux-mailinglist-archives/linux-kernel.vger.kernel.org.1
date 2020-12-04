Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51D2CE527
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgLDBdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:33:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36104 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725960AbgLDBdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:33:20 -0500
X-UUID: d80cba357d9f4d2fb81a75de8ef28301-20201204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KWikmV/wDlXuDUVsDyFD6GjELptOAMlHj8HVv2I+cPU=;
        b=ZRa98cbvF1HYbZ2/bYY5lqWwPLrMu3JbnmYTRJM5q8//V79QvySGpdptghl8/lokH2P7YgYm+ceoP6+iGxlyKi4YTG59v8SBcfHGCATJ2ngSAkJj2Z+0hXxhgklPVV0BKQfn+I7Lv3J50YgR+YU76Yv5j8fdEd1JHvDlyOW6W3g=;
X-UUID: d80cba357d9f4d2fb81a75de8ef28301-20201204
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 633230048; Fri, 04 Dec 2020 09:32:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 09:32:34 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 09:32:36 +0800
Message-ID: <1607045555.4722.7.camel@mtksdccf07>
Subject: Re: [PATCH v5 3/4] lib/test_kasan.c: add workqueue test case
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Marco Elver <elver@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Fri, 4 Dec 2020 09:32:35 +0800
In-Reply-To: <CANpmjNNdaiN=J0TU_AjAoH=ECNC8dJWS8HTvJs9nxBkJce9AmQ@mail.gmail.com>
References: <20201203022748.30681-1-walter-zh.wu@mediatek.com>
         <CANpmjNNdaiN=J0TU_AjAoH=ECNC8dJWS8HTvJs9nxBkJce9AmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDExOjI5ICswMTAwLCBNYXJjbyBFbHZlciB3cm90ZToNCj4g
T24gVGh1LCAzIERlYyAyMDIwIGF0IDAzOjI3LCBXYWx0ZXIgV3UgPHdhbHRlci16aC53dUBtZWRp
YXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQWRkcyBhIHRlc3QgdG8gdmVyaWZ5IHdvcmtxdWV1
ZSBzdGFjayByZWNvcmRpbmcgYW5kIHByaW50IGl0IGluDQo+ID4gS0FTQU4gcmVwb3J0Lg0KPiA+
DQo+ID4gVGhlIEtBU0FOIHJlcG9ydCB3YXMgYXMgZm9sbG93cyhjbGVhbmVkIHVwIHNsaWdodGx5
KToNCj4gPg0KPiA+ICBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBrYXNhbl93b3JrcXVl
dWVfdWFmDQo+ID4NCj4gPiAgRnJlZWQgYnkgdGFzayA1NDoNCj4gPiAgIGthc2FuX3NhdmVfc3Rh
Y2srMHgyNC8weDUwDQo+ID4gICBrYXNhbl9zZXRfdHJhY2srMHgyNC8weDM4DQo+ID4gICBrYXNh
bl9zZXRfZnJlZV9pbmZvKzB4MjAvMHg0MA0KPiA+ICAgX19rYXNhbl9zbGFiX2ZyZWUrMHgxMGMv
MHgxNzANCj4gPiAgIGthc2FuX3NsYWJfZnJlZSsweDEwLzB4MTgNCj4gPiAgIGtmcmVlKzB4OTgv
MHgyNzANCj4gPiAgIGthc2FuX3dvcmtxdWV1ZV93b3JrKzB4Yy8weDE4DQo+ID4NCj4gPiAgTGFz
dCBwb3RlbnRpYWxseSByZWxhdGVkIHdvcmsgY3JlYXRpb246DQo+ID4gICBrYXNhbl9zYXZlX3N0
YWNrKzB4MjQvMHg1MA0KPiA+ICAga2FzYW5fcmVjb3JkX3dxX3N0YWNrKzB4YTgvMHhiOA0KPiA+
ICAgaW5zZXJ0X3dvcmsrMHg0OC8weDI4OA0KPiA+ICAgX19xdWV1ZV93b3JrKzB4M2U4LzB4YzQw
DQo+ID4gICBxdWV1ZV93b3JrX29uKzB4ZjQvMHgxMTgNCj4gPiAgIGthc2FuX3dvcmtxdWV1ZV91
YWYrMHhmYy8weDE5MA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2FsdGVyIFd1IDx3YWx0ZXIt
emgud3VAbWVkaWF0ZWsuY29tPg0KPiA+IEFja2VkLWJ5OiBNYXJjbyBFbHZlciA8ZWx2ZXJAZ29v
Z2xlLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogRG1pdHJ5IFZ5dWtvdiA8ZHZ5dWtvdkBnb29nbGUu
Y29tPg0KPiA+IFJldmlld2VkLWJ5OiBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdvb2ds
ZS5jb20+DQo+ID4gQ2M6IEFuZHJleSBSeWFiaW5pbiA8YXJ5YWJpbmluQHZpcnR1b3p6by5jb20+
DQo+ID4gQ2M6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0KPiA+IENj
OiBNYXR0aGlhcyBCcnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+
DQo+ID4gdjQ6DQo+ID4gLSB0ZXN0Y2FzZSBoYXMgbWVyZ2UgY29uZmxpY3QsIHNvIHRoYXQgcmVi
YXNlIG9udG8gdGhlIEtBU0FOLUtVTklUDQo+ID4NCj4gPiAtLS0NCj4gPiAgbGliL3Rlc3Rfa2Fz
YW5fbW9kdWxlLmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2xpYi90
ZXN0X2thc2FuX21vZHVsZS5jIGIvbGliL3Rlc3Rfa2FzYW5fbW9kdWxlLmMNCj4gPiBpbmRleCAy
ZDY4ZGI2YWU2N2IuLjYyYTg3ODU0YjEyMCAxMDA2NDQNCj4gPiAtLS0gYS9saWIvdGVzdF9rYXNh
bl9tb2R1bGUuYw0KPiA+ICsrKyBiL2xpYi90ZXN0X2thc2FuX21vZHVsZS5jDQo+ID4gQEAgLTkx
LDYgKzkxLDM0IEBAIHN0YXRpYyBub2lubGluZSB2b2lkIF9faW5pdCBrYXNhbl9yY3VfdWFmKHZv
aWQpDQo+ID4gICAgICAgICBjYWxsX3JjdSgmZ2xvYmFsX3JjdV9wdHItPnJjdSwga2FzYW5fcmN1
X3JlY2xhaW0pOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIG5vaW5saW5lIHZvaWQgX19pbml0
IGthc2FuX3dvcmtxdWV1ZV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykNCj4gPiArew0K
PiA+ICsgICAgICAga2ZyZWUod29yayk7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBub2lu
bGluZSB2b2lkIF9faW5pdCBrYXNhbl93b3JrcXVldWVfdWFmKHZvaWQpDQo+ID4gK3sNCj4gPiAr
ICAgICAgIHN0cnVjdCB3b3JrcXVldWVfc3RydWN0ICp3b3JrcXVldWU7DQo+ID4gKyAgICAgICBz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcms7DQo+ID4gKw0KPiA+ICsgICAgICAgd29ya3F1ZXVlID0g
Y3JlYXRlX3dvcmtxdWV1ZSgia2FzYW5fd3FfdGVzdCIpOw0KPiA+ICsgICAgICAgaWYgKCF3b3Jr
cXVldWUpIHsNCj4gPiArICAgICAgICAgICAgICAgcHJfZXJyKCJBbGxvY2F0aW9uIGZhaWxlZFxu
Iik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgIH0NCj4gPiArICAg
ICAgIHdvcmsgPSBrbWFsbG9jKHNpemVvZihzdHJ1Y3Qgd29ya19zdHJ1Y3QpLCBHRlBfS0VSTkVM
KTsNCj4gPiArICAgICAgIGlmICghd29yaykgew0KPiA+ICsgICAgICAgICAgICAgICBwcl9lcnIo
IkFsbG9jYXRpb24gZmFpbGVkXG4iKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiA+
ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIElOSVRfV09SSyh3b3JrLCBrYXNhbl93b3Jr
cXVldWVfd29yayk7DQo+ID4gKyAgICAgICBxdWV1ZV93b3JrKHdvcmtxdWV1ZSwgd29yayk7DQo+
ID4gKyAgICAgICBkZXN0cm95X3dvcmtxdWV1ZSh3b3JrcXVldWUpOw0KPiA+ICsNCj4gPiArICAg
ICAgIHByX2luZm8oInVzZS1hZnRlci1mcmVlIG9uIHdvcmtxdWV1ZVxuIik7DQo+ID4gKyAgICAg
ICAoKHZvbGF0aWxlIHN0cnVjdCB3b3JrX3N0cnVjdCAqKXdvcmspLT5kYXRhOw0KPiA+ICt9DQo+
ID4NCj4gPiAgc3RhdGljIGludCBfX2luaXQgdGVzdF9rYXNhbl9tb2R1bGVfaW5pdCh2b2lkKQ0K
PiA+ICB7DQo+ID4gQEAgLTEwMiw2ICsxMzAsNyBAQCBzdGF0aWMgaW50IF9faW5pdCB0ZXN0X2th
c2FuX21vZHVsZV9pbml0KHZvaWQpDQo+ID4NCj4gPiAgICAgICAgIGNvcHlfdXNlcl90ZXN0KCk7
DQo+ID4gICAgICAgICBrYXNhbl9yY3VfdWFmKCk7DQo+ID4gKyAgICAgICBrYXNhbl93b3JrcXVl
dWVfdWFmKCk7DQo+IA0KPiANCj4gV2h5IGNhbid0IHRoaXMgZ28gaW50byB0aGUgS1VuaXQgYmFz
ZWQgS0FTQU4gdGVzdD8NCg0KVGhpcyB0ZXN0IGNhc2UgaGFzIG5vdCBiZWVuIHBvcnRlZCB0byBL
VW5pdCwgYmVjYXVzZSBLVW5pdCdzIGV4cGVjdA0KZmFpbHVyZSB3aWxsIG5vdCBjaGVjayB3aGV0
aGVyIHRoZSB3b3JrIHN0YWNrIGlzIGV4aXN0LiBTbyBpdCByZW1haW5zIGluDQp0ZXN0X2thc2Fu
X21vZHVsZSwgaXQgaXMgdGhlIHNhbWUgd2l0aCBrYXNhbl9yY3VfdWFmKClbMV0uDQoNClsxXWh0
dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzgvMS80NQ0KDQpUaGFua3MuDQpXYWx0ZXINCg0KDQoN
Cg==

