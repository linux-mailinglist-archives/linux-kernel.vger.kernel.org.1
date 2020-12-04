Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D592CE5B2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 03:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgLDC1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 21:27:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:55688 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726057AbgLDC1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 21:27:05 -0500
X-UUID: 5475effd1b334f3181e2e48d1848a4ad-20201204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=poyb6ODY1nzdJu4VuolCu6hZIv/6rIbs3USR4sHKncU=;
        b=TPJiHHmFZaxj6lXDUpKySe857ZODQ6sjk45PUBIPCtmbvFdVeeLj56tq7aXUaVCIAjgMWhFNxog9VAD0EX1gJ8bnXzdwjwCc6VrSU1BJwY2UweuDGmn0gTtxeJDGinLqNc9jsA1aqqOHU3jYX7SnXmIjWKEMrM9cKsS4fif10Mc=;
X-UUID: 5475effd1b334f3181e2e48d1848a4ad-20201204
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1902959308; Fri, 04 Dec 2020 10:26:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 10:26:17 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 10:26:18 +0800
Message-ID: <1607048778.15817.2.camel@mtksdccf07>
Subject: Re: [PATCH v3 1/1] kasan: fix object remain in offline per-cpu
 quarantine
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicholas Tang <nicholas.tang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Date:   Fri, 4 Dec 2020 10:26:18 +0800
In-Reply-To: <20201203122854.c8d5ed270ec9cfc7c17569d9@linux-foundation.org>
References: <1606895585-17382-1-git-send-email-Kuan-Ying.Lee@mediatek.com>
         <1606895585-17382-2-git-send-email-Kuan-Ying.Lee@mediatek.com>
         <CAAeHK+z+DPNysrUwfeu27h6sKdn5DDE=BL4t96KiF0mRBNPs+Q@mail.gmail.com>
         <20201203122854.c8d5ed270ec9cfc7c17569d9@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTEyLTAzIGF0IDEyOjI4IC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBUaHUsIDMgRGVjIDIwMjAgMTM6NDY6NTkgKzAxMDAgQW5kcmV5IEtvbm92YWxvdiA8YW5k
cmV5a252bEBnb29nbGUuY29tPiB3cm90ZToNCj4gDQo+ID4gPiAgI2RlZmluZSBRTElTVF9JTklU
IHsgTlVMTCwgTlVMTCwgMCB9DQo+ID4gPiBAQCAtMTg4LDYgKzE5MCwxMSBAQCB2b2lkIHF1YXJh
bnRpbmVfcHV0KHN0cnVjdCBrYXNhbl9mcmVlX21ldGEgKmluZm8sIHN0cnVjdCBrbWVtX2NhY2hl
ICpjYWNoZSkNCj4gPiA+ICAgICAgICAgbG9jYWxfaXJxX3NhdmUoZmxhZ3MpOw0KPiA+ID4NCj4g
PiA+ICAgICAgICAgcSA9IHRoaXNfY3B1X3B0cigmY3B1X3F1YXJhbnRpbmUpOw0KPiA+ID4gKyAg
ICAgICBpZiAocS0+b2ZmbGluZSkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIHFsaW5rX2ZyZWUo
JmluZm8tPnF1YXJhbnRpbmVfbGluaywgY2FjaGUpOw0KPiA+IA0KPiA+IEhpIEt1YW4tWWluZywN
Cj4gPiANCj4gPiBUaGlzIG5lZWRzIHRvIGJlIHJlYmFzZWQgb250byB0aGUgbW0gdHJlZTogaXQg
aGFzIHNvbWUgS0FTQU4gcGF0Y2hlcw0KPiA+IHRoYXQgdG91Y2ggdGhpcyBjb2RlIGFuZCByZW5h
bWUgdGhlIGluZm8gdmFyaWFibGUgdG8gbWV0YS4NCj4gDQo+IFl1cC4gIEknbSB0YWtpbmcgY2Fy
ZSBvZiB0aGF0Lg0KDQpIaSBBbmRyZXcsDQoNClNvcnJ5IGFib3V0IHRoYXQuDQpJIHdpbGwgZml4
IHRoYXQgY29uZmxpY3QuDQoNClRoYW5rcy4NCg0K

