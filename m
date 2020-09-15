Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1741326B142
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgIOW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:27:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:1502 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727645AbgIOQTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 12:19:55 -0400
X-UUID: 03bbaf6be4644b71a8c1b0ef064e73fc-20200916
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dyxC8WhaSmjgvfJJHFnp0NhjfIxeFwAQsy17LIoKHDE=;
        b=fNVjQh6Jy2IcLb33osXffQtyaVPRAMU/GHUxanbpNqmNQf5xU8TmRToBuu7h2ndTb+hOVoFIvw2SUn3aerfahBy1fIf+nu4uSohcUhaRknQLhB8gJoNTZD0doh5w+jMrijUnukPEePX0zIgvB5pUb2bZY9Hwq4TEeFM2J9jilDE=;
X-UUID: 03bbaf6be4644b71a8c1b0ef064e73fc-20200916
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1709786148; Wed, 16 Sep 2020 00:06:43 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Sep 2020 00:06:39 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Sep 2020 00:06:39 +0800
Message-ID: <1600186001.25944.3.camel@mtksdccf07>
Subject: Re: [PATCH v3 0/6] kasan: add workqueue and timer stack for generic
 KASAN
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
CC:     Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 16 Sep 2020 00:06:41 +0800
In-Reply-To: <CAAeHK+xONO0NDWvernDXH72E+oyMtJr8JpWfok9wGRDVZ518iQ@mail.gmail.com>
References: <20200825015654.27781-1-walter-zh.wu@mediatek.com>
         <CANpmjNOvj+=v7VDVDXpsUNZ9o0+KoJVJs0MjLhwr0XpYcYQZ5g@mail.gmail.com>
         <CAAeHK+yVShDPCxVKDsO_5SwoM2ZG7x7byUJ74PtB7ekY61L2YQ@mail.gmail.com>
         <CACT4Y+b1OimWNQCx-rGvSgC1RheLAv9mv2xzRnwkn98AsdTgXA@mail.gmail.com>
         <CAAeHK+xONO0NDWvernDXH72E+oyMtJr8JpWfok9wGRDVZ518iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AA21E673224F89C2DF2907E0064F3C128B0F5B7C7AFF54C00B058CC4AFE9D2992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA5LTE0IGF0IDE0OjI1ICswMjAwLCBBbmRyZXkgS29ub3ZhbG92IHdyb3Rl
Og0KPiBPbiBTdW4sIFNlcCAxMywgMjAyMCBhdCAxMjoxNyBQTSBEbWl0cnkgVnl1a292IDxkdnl1
a292QGdvb2dsZS5jb20+DQo+IHdyb3RlOg0KPiANCj4gICAgICAgICBPbiBXZWQsIEF1ZyAyNiwg
MjAyMCBhdCAyOjMwIFBNICdBbmRyZXkgS29ub3ZhbG92JyB2aWENCj4gICAgICAgICBrYXNhbi1k
ZXYNCj4gICAgICAgICA8a2FzYW4tZGV2QGdvb2dsZWdyb3Vwcy5jb20+IHdyb3RlOg0KPiAgICAg
ICAgID4NCj4gICAgICAgICA+IE9uIFR1ZSwgQXVnIDI1LCAyMDIwIGF0IDEwOjI2IEFNICdNYXJj
byBFbHZlcicgdmlhIGthc2FuLWRldg0KPiAgICAgICAgID4gPGthc2FuLWRldkBnb29nbGVncm91
cHMuY29tPiB3cm90ZToNCj4gICAgICAgICA+ID4NCj4gICAgICAgICA+ID4gT24gVHVlLCAyNSBB
dWcgMjAyMCBhdCAwMzo1NywgV2FsdGVyIFd1DQo+ICAgICAgICAgPHdhbHRlci16aC53dUBtZWRp
YXRlay5jb20+IHdyb3RlOg0KPiAgICAgICAgID4gPiA+DQo+ICAgICAgICAgPiA+ID4gU3l6Ym90
IHJlcG9ydHMgbWFueSBVQUYgaXNzdWVzIGZvciB3b3JrcXVldWUgb3IgdGltZXIsDQo+ICAgICAg
ICAgc2VlIFsxXSBhbmQgWzJdLg0KPiAgICAgICAgID4gPiA+IEluIHNvbWUgb2YgdGhlc2UgYWNj
ZXNzL2FsbG9jYXRpb24gaGFwcGVuZWQgaW4NCj4gICAgICAgICBwcm9jZXNzX29uZV93b3JrKCks
DQo+ICAgICAgICAgPiA+ID4gd2Ugc2VlIHRoZSBmcmVlIHN0YWNrIGlzIHVzZWxlc3MgaW4gS0FT
QU4gcmVwb3J0LCBpdA0KPiAgICAgICAgIGRvZXNuJ3QgaGVscA0KPiAgICAgICAgID4gPiA+IHBy
b2dyYW1tZXJzIHRvIHNvbHZlIFVBRiBvbiB3b3JrcXVldWUuIFRoZSBzYW1lIG1heQ0KPiAgICAg
ICAgIHN0YW5kIGZvciB0aW1lcy4NCj4gICAgICAgICA+ID4gPg0KPiAgICAgICAgID4gPiA+IFRo
aXMgcGF0Y2hzZXQgaW1wcm92ZXMgS0FTQU4gcmVwb3J0cyBieSBtYWtpbmcgdGhlbSB0bw0KPiAg
ICAgICAgIGhhdmUgd29ya3F1ZXVlDQo+ICAgICAgICAgPiA+ID4gcXVldWVpbmcgc3RhY2sgYW5k
IHRpbWVyIHN0YWNrIGluZm9ybWF0aW9uLiBJdCBpcyB1c2VmdWwNCj4gICAgICAgICBmb3IgcHJv
Z3JhbW1lcnMNCj4gICAgICAgICA+ID4gPiB0byBzb2x2ZSB1c2UtYWZ0ZXItZnJlZSBvciBkb3Vi
bGUtZnJlZSBtZW1vcnkgaXNzdWUuDQo+ICAgICAgICAgPiA+ID4NCj4gICAgICAgICA+ID4gPiBH
ZW5lcmljIEtBU0FOIGFsc28gcmVjb3JkcyB0aGUgbGFzdCB0d28gd29ya3F1ZXVlIGFuZA0KPiAg
ICAgICAgIHRpbWVyIHN0YWNrcyBhbmQNCj4gICAgICAgICA+ID4gPiBwcmludHMgdGhlbSBpbiBL
QVNBTiByZXBvcnQuIEl0IGlzIG9ubHkgc3VpdGFibGUgZm9yDQo+ICAgICAgICAgZ2VuZXJpYyBL
QVNBTi4NCj4gICAgICAgICA+ID4gPg0KPiAgICAgICAgID4gPiA+IFsxXWh0dHBzOi8vZ3JvdXBz
Lmdvb2dsZS5jb20vZy9zeXprYWxsZXItYnVncy9zZWFyY2g/cT0lDQo+ICAgICAgICAgMjJ1c2Ut
YWZ0ZXItZnJlZSUyMitwcm9jZXNzX29uZV93b3JrDQo+ICAgICAgICAgPiA+ID4gWzJdaHR0cHM6
Ly9ncm91cHMuZ29vZ2xlLmNvbS9nL3N5emthbGxlci1idWdzL3NlYXJjaD9xPSUNCj4gICAgICAg
ICAyMnVzZS1hZnRlci1mcmVlJTIyJTIwZXhwaXJlX3RpbWVycw0KPiAgICAgICAgID4gPiA+IFsz
XWh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTk4NDM3DQo+ICAg
ICAgICAgPiA+ID4NCj4gICAgICAgICA+ID4gPiBXYWx0ZXIgV3UgKDYpOg0KPiAgICAgICAgID4g
PiA+IHRpbWVyOiBrYXNhbjogcmVjb3JkIHRpbWVyIHN0YWNrDQo+ICAgICAgICAgPiA+ID4gd29y
a3F1ZXVlOiBrYXNhbjogcmVjb3JkIHdvcmtxdWV1ZSBzdGFjaw0KPiAgICAgICAgID4gPiA+IGth
c2FuOiBwcmludCB0aW1lciBhbmQgd29ya3F1ZXVlIHN0YWNrDQo+ICAgICAgICAgPiA+ID4gbGli
L3Rlc3Rfa2FzYW4uYzogYWRkIHRpbWVyIHRlc3QgY2FzZQ0KPiAgICAgICAgID4gPiA+IGxpYi90
ZXN0X2thc2FuLmM6IGFkZCB3b3JrcXVldWUgdGVzdCBjYXNlDQo+ICAgICAgICAgPiA+ID4ga2Fz
YW46IHVwZGF0ZSBkb2N1bWVudGF0aW9uIGZvciBnZW5lcmljIGthc2FuDQo+ICAgICAgICAgPiA+
DQo+ICAgICAgICAgPiA+IEFja2VkLWJ5OiBNYXJjbyBFbHZlciA8ZWx2ZXJAZ29vZ2xlLmNvbT4N
Cj4gICAgICAgICA+DQo+ICAgICAgICAgPiBSZXZpZXdlZC1ieTogQW5kcmV5IEtvbm92YWxvdiA8
YW5kcmV5a252bEBnb29nbGUuY29tPg0KPiAgICAgICAgIA0KPiAgICAgICAgIFJldmlld2VkLWJ5
OiBEbWl0cnkgVnl1a292IDxkdnl1a292QGdvb2dsZS5jb20+DQo+ICAgICAgICAgDQo+ICAgICAg
ICAgVGhhbmtzISBUaGUgVUFGIHJlcG9ydHMgd2l0aCBSQ1Ugc3RhY2tzIHRoYXQgSSBzZWUgbm93
IGFyZQ0KPiAgICAgICAgIGp1c3Qg8J+UpfCflKXwn5SlDQo+IA0KPiANCj4gSGkgV2FsdGVyLA0K
PiANCj4gDQo+IFRoaXMgcGF0Y2hzZXQgbmVlZHMgdG8gYmUgcmViYXNlZCBvbnRvIHRoZSBLQVNB
Ti1LVU5JVCBwYXRjaGVzLCB3aGljaA0KPiBqdXN0IHJlY2VudGx5IHdlbnQgaW50byB0aGUgbW0g
dHJlZS4NCj4gDQo+IA0KPiBUaGFua3MhDQoNCkhpIERtaXRyeSwgQW5kcmV5LA0KDQpHb3QgaXQu
IA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGFuZCByZW1pbmRlci4NCg0KV2FsdGVyDQo=

