Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6E92CFC46
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgLERPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 12:15:02 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:32770 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbgLEQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 11:46:26 -0500
X-UUID: 5f6209dbe169426d85d5d6b02d7217d0-20201206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2SS+2+k+v8xJevNbkcJdxXG2ZEYYRgqzhniLu7CSbLM=;
        b=Mawf3w2wciITGOOlW6aWXBL7UQWCcy/JL+jc9IYHIMBnlUyKJ65MVCpj2EiAnu1cUcVnnroCLxCmU91bfJ8LsyFBYA3muWwuu/jQtX6vS7N/nsPXk56eSqaV21+Al9k6YIw2XwghPLigyhVGQ60pbXWuhpUpAlRGe9qOojOvHyw=;
X-UUID: 5f6209dbe169426d85d5d6b02d7217d0-20201206
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2002314005; Sun, 06 Dec 2020 00:17:22 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 6 Dec 2020 00:17:12 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 6 Dec 2020 00:17:12 +0800
Message-ID: <1607185035.22062.42.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix slab double free when cpu-hotplug
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "qcai@redhat.com" <qcai@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <walter-zh.wu@mediatek.com>
Date:   Sun, 6 Dec 2020 00:17:15 +0800
In-Reply-To: <20201204172521.ed9f77164ff9f9fc91f35ee0@linux-foundation.org>
References: <20201204102206.20237-1-qiang.zhang@windriver.com>
         <1607083295.22062.15.camel@mtksdccf07>
         <20201204172521.ed9f77164ff9f9fc91f35ee0@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDE3OjI1IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBGcmksIDQgRGVjIDIwMjAgMjA6MDE6MzUgKzA4MDAgS3Vhbi1ZaW5nIExlZSA8S3Vhbi1Z
aW5nLkxlZUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPiA+IGRpZmYgLS1naXQgYS9tbS9r
YXNhbi9xdWFyYW50aW5lLmMgYi9tbS9rYXNhbi9xdWFyYW50aW5lLmMNCj4gPiA+IGluZGV4IGQ5
OGI1MTZmMzcyZi4uNTU3ODMxMjVhNzY3IDEwMDY0NA0KPiA+ID4gLS0tIGEvbW0va2FzYW4vcXVh
cmFudGluZS5jDQo+ID4gPiArKysgYi9tbS9rYXNhbi9xdWFyYW50aW5lLmMNCj4gPiA+IEBAIC0x
OTQsNyArMTk0LDYgQEAgYm9vbCBxdWFyYW50aW5lX3B1dChzdHJ1Y3Qga21lbV9jYWNoZSAqY2Fj
aGUsIHZvaWQgKm9iamVjdCkNCj4gPiA+ICANCj4gPiA+ICAJcSA9IHRoaXNfY3B1X3B0cigmY3B1
X3F1YXJhbnRpbmUpOw0KPiA+ID4gIAlpZiAocS0+b2ZmbGluZSkgew0KPiA+ID4gLQkJcWxpbmtf
ZnJlZSgmbWV0YS0+cXVhcmFudGluZV9saW5rLCBjYWNoZSk7DQo+ID4gPiAgCQlsb2NhbF9pcnFf
cmVzdG9yZShmbGFncyk7DQo+ID4gPiAgCQlyZXR1cm4gZmFsc2U7DQoNCkhpIEFuZHJldywNCg0K
UmV0dXJuIGZhbHNlIHdpbGwgY2F1c2Ugc2xhYiBhbGxvY2F0b3IgdG8gZnJlZSB0aGUgb2JqZWN0
Lg0KVGh1cywgd2UgZG8gbm90IG5lZWQgdG8gcWxpbmtfZnJlZSBoZXJlIHRvIGZyZWUgb2JqZWN0
IHR3aWNlLg0KDQpUaGUgcmV0dXJuIHZhbHVlIGlzIGludHJvZHVjZWQgZnJvbSBBbmRyZXkncyBw
YXRjaC4NCiJrYXNhbjogc2FuaXRpemUgb2JqZWN0cyB3aGVuIG1ldGFkYXRhIGRvZXNuJ3QgZml0
Ig0KDQoNCj4gPiA+ICAJfQ0KPiA+IA0KPiA+IEhpIFFpYW5nLA0KPiA+IA0KPiA+IFRoYW5rcyBm
b3IgZml4aW5nIHRoaXMuDQo+ID4gRHVlIHRvIHRoYXQgaXNzdWUsIG15IGNvbW1pdCBoYXMgYmVl
biByZW1vdmVkIGJ5IFN0ZXBoZW4gZnJvbQ0KPiA+IGxpbnV4LW5leHQuDQo+ID4gDQo+ID4gDQo+
ID4gSGkgU3RlcGhlbiwgQW5kcmV3LA0KPiA+IA0KPiA+IFNob3VsZCBJIGRpcmVjdGx5IHVwbG9h
ZCB0aGUgdjQgb3IgU3RlcGhlbiBjYW4gcGljayB0aGUgY29tbWl0IHdoaWNoIA0KPiA+IGhhcyBi
ZWVuIHJlbW92ZWQgYmFjayB0byB0aGUgbGludXgtbmV4dC4NCj4gDQo+IEkgdG9vayBjYXJlIG9m
IGl0LiAgUmVzdG9yZWQgdGhlIG9yaWdpbmFsIHBhdGNoIGFuZCBhZGRlZCB0aGlzIG9uZSBhcyBh
DQo+IC1maXguDQoNClRoYW5rcyBmb3IgdGFraW5nIGNhcmUgb2YgaXQuDQoNCkkgdGhpbmsgdGhl
cmUgYXJlIHNvbWUgcHJvYmxlbSBpbiB0aGUgcGF0Y2ggeW91IGp1c3QgcmVzdG9yZWQuDQpJIHNh
dyB0aGUgcmVzdG9yZWQgcGF0Y2ggaXMgbm90IGJhc2VkIG9uIEFuZHJleSdzIHBhdGNoIGFuZCBT
dGVwaGVuJ3MNCmZpeCBjb25mbGljdCBwYXRjaC4NCg0KQnV0IHRoZSBpc3N1ZSBRaWFuZyBmaXhl
ZCBuZWVkIHRvIGJlIGJhc2VkIG9uIHRoZSBBbmRyZXkncyBwYXRjaCBhbmQNClN0ZXBoZW4ncyBm
aXggY29uZmxpY3QgcGF0Y2guDQoia2FzYW46IHNhbml0aXplIG9iamVjdHMgd2hlbiBtZXRhZGF0
YSBkb2Vzbid0IGZpdCINCiJrYXNhbi1yZW5hbWUtZ2V0X2FsbG9jLWZyZWVfaW5mby1maXgiDQoN
CklmIHRoZSByZXN0b3JlZCBwYXRjaCBpcyBub3QgYmFzZWQgb24gdGhhdCwgaXQgbWF5IGNhdXNl
IHNvbWUgcHJvYmxlbXMNCmFuZCBjb25mbGljdHMuDQoNCkkgdGhpbmsgSSBjYW4gcHJlcGFyZSBh
IHBhdGNoIHY0IGJhc2VkIG9uIEFuZHJleSdzIHBhdGNoLCBmaXggdGhlDQpjb25mbGljdCBhbmQg
aW5jbHVkZSB0aGUgUWlhbmcncyBtb2RpZmljYXRpb24uDQoNClRoYW5rcywNCkt1YW4tWWluZw0K
DQoNCg==

