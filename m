Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8401B277117
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgIXMdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:33:52 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38261 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727570AbgIXMdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:33:51 -0400
X-UUID: c6d82b8a50b644eab02e850af9bf1686-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=3xhvL/jxHoFM4lCpaJFVgA5szl9rK3NZUTpqOY0oS0A=;
        b=YgF878XPHogI4aTUl5UXQky6mdiiEW+RWb6ulCfUOWiPS5hWL6B3fqUN5C0ngx5Nlx2pbx55PDn1qNdeFUCuublJ5JySfEtLL3ftvy2zXc/0j/oI4H5haOX1q70dbsv9rbe6xcB6I2GLmW6hC8qVP6sB5tms4ariWW/MlE6q86A=;
X-UUID: c6d82b8a50b644eab02e850af9bf1686-20200924
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <walter-zh.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1621613781; Thu, 24 Sep 2020 20:33:47 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 20:33:42 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 20:33:43 +0800
Message-ID: <1600950825.19591.2.camel@mtksdccf07>
Subject: Re: [PATCH v4 0/6] kasan: add workqueue and timer stack for generic
 KASAN
From:   Walter Wu <walter-zh.wu@mediatek.com>
To:     Alexander Potapenko <glider@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Andrey Konovalov" <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 24 Sep 2020 20:33:45 +0800
In-Reply-To: <CAG_fn=U_dshqBB8HBhGyYnn_vScTOcLJX=mfU+8Wi5wjZL2oYA@mail.gmail.com>
References: <20200924040152.30851-1-walter-zh.wu@mediatek.com>
         <CAG_fn=U_dshqBB8HBhGyYnn_vScTOcLJX=mfU+8Wi5wjZL2oYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 06AAE36FCA1A35D7BBA6DD440E2BA708F1295AAE573EAC13CD5AE6AAD26BA90B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTI0IGF0IDEzOjUxICswMjAwLCAnQWxleGFuZGVyIFBvdGFwZW5rbycg
dmlhIGthc2FuLWRldg0Kd3JvdGU6DQo+ID4gLS0tDQo+ID4gRG9jdW1lbnRhdGlvbi9kZXYtdG9v
bHMva2FzYW4ucnN0IHwgIDUgKysrLS0NCj4gPiBrZXJuZWwvdGltZS90aW1lci5jICAgICAgICAg
ICAgICAgfCAgMyArKysNCj4gPiBrZXJuZWwvd29ya3F1ZXVlLmMgICAgICAgICAgICAgICAgfCAg
MyArKysNCj4gPiBsaWIvdGVzdF9rYXNhbl9tb2R1bGUuYyAgICAgICAgICAgfCA1NSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gbW0v
a2FzYW4vcmVwb3J0LmMgICAgICAgICAgICAgICAgIHwgIDQgKystLQ0KPiA+IDUgZmlsZXMgY2hh
bmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IFdoaWxlIGF0IGl0
LCBjYW4geW91IHJlbW92ZSBhIG1lbnRpb24gb2YgY2FsbF9yY3UoKSBmcm9tIHRoZQ0KPiBrYXNh
bl9yZWNvcmRfYXV4X3N0YWNrKCkgaW1wbGVtZW50YXRpb24sIGFzIGl0IGlzIG5vIG1vcmUNCj4g
UkNVLXNwZWNpZmljPw0KPiANCg0KVGhhbmsgeW91IGZvciB5b3VyIHJlbWluZGVyLiB2NSB3aWxs
IGRvIGl0LiANCg0KV2FsdGVyDQo=

