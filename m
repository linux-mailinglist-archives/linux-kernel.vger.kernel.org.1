Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE742CEDAC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 13:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgLDMCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 07:02:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:41413 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728490AbgLDMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 07:02:20 -0500
X-UUID: 7f691940b8a84e01adf499202e90c387-20201204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dVCInG0+zFay29/zF5Qgk8PnqNpkCmMd63za3Ohahxo=;
        b=JJFDFWVMB/j6US1p7J4UwV6+Yi/wBiL5hUr7CpiliwP4fGf/saQJFUdt1jXvd8JrtIMajIP9+JpdvVEghDUCn5D1wDmQFdjVi9MdbuUklPDzr+6nQjG8BaALMsZuKxMUpzILhA8D4pmocBm7SvdZFPocA3m1O5kuxK15FSI5AZA=;
X-UUID: 7f691940b8a84e01adf499202e90c387-20201204
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 133938143; Fri, 04 Dec 2020 20:01:36 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Dec 2020 20:01:32 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Dec 2020 20:01:32 +0800
Message-ID: <1607083295.22062.15.camel@mtksdccf07>
Subject: Re: [PATCH] kasan: fix slab double free when cpu-hotplug
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "qcai@redhat.com" <qcai@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <walter-zh.wu@mediatek.com>
Date:   Fri, 4 Dec 2020 20:01:35 +0800
In-Reply-To: <20201204102206.20237-1-qiang.zhang@windriver.com>
References: <20201204102206.20237-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDE4OjIyICswODAwLCBxaWFuZy56aGFuZ0B3aW5kcml2ZXIu
Y29tIHdyb3RlOg0KPiBGcm9tOiBacWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQo+
IA0KPiBXaGVuIGEgQ1BVIG9mZmxpbmUsIHRoZSBwZXItY3B1IHF1YXJhbnRpbmUncyBvZmZsaW5l
IGJlIHNldCB0cnVlLA0KPiBhZnRlciB0aGlzLCBpZiB0aGUgcXVhcmFudGluZV9wdXQgYmUgY2Fs
bGVkIGluIHRoaXMgQ1BVLCB0aGUgb2JqZWN0cw0KPiB3aWxsIGJlIGZyZWUgYW5kIHJldHVybiBm
YWxzZSwgZnJlZSBvYmplY3RzIGRvZXNuJ3QgdG8gYmUgZG9uZSwgZHVlDQo+IHRvIHJldHVybiBm
YWxzZSwgdGhlIHNsYWIgbWVtb3J5IG1hbmFnZXIgd2lsbCBmcmVlIHRoaXMgb2JqZWN0cy4NCj4g
DQo+IEZpeGVzOiA0MWFiMWFhZTc4MWYgKCJrYXNhbjogZml4IG9iamVjdCByZW1haW5pbmcgaW4g
b2ZmbGluZSBwZXItY3B1IHF1YXJhbnRpbmUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBacWlhbmcgPHFp
YW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQo+IC0tLQ0KPiAgbW0va2FzYW4vcXVhcmFudGluZS5j
IHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL21tL2thc2FuL3F1YXJhbnRpbmUuYyBiL21tL2thc2FuL3F1YXJhbnRpbmUuYw0KPiBpbmRl
eCBkOThiNTE2ZjM3MmYuLjU1NzgzMTI1YTc2NyAxMDA2NDQNCj4gLS0tIGEvbW0va2FzYW4vcXVh
cmFudGluZS5jDQo+ICsrKyBiL21tL2thc2FuL3F1YXJhbnRpbmUuYw0KPiBAQCAtMTk0LDcgKzE5
NCw2IEBAIGJvb2wgcXVhcmFudGluZV9wdXQoc3RydWN0IGttZW1fY2FjaGUgKmNhY2hlLCB2b2lk
ICpvYmplY3QpDQo+ICANCj4gIAlxID0gdGhpc19jcHVfcHRyKCZjcHVfcXVhcmFudGluZSk7DQo+
ICAJaWYgKHEtPm9mZmxpbmUpIHsNCj4gLQkJcWxpbmtfZnJlZSgmbWV0YS0+cXVhcmFudGluZV9s
aW5rLCBjYWNoZSk7DQo+ICAJCWxvY2FsX2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gIAkJcmV0dXJu
IGZhbHNlOw0KPiAgCX0NCg0KSGkgUWlhbmcsDQoNClRoYW5rcyBmb3IgZml4aW5nIHRoaXMuDQpE
dWUgdG8gdGhhdCBpc3N1ZSwgbXkgY29tbWl0IGhhcyBiZWVuIHJlbW92ZWQgYnkgU3RlcGhlbiBm
cm9tDQpsaW51eC1uZXh0Lg0KDQoNCkhpIFN0ZXBoZW4sIEFuZHJldywNCg0KU2hvdWxkIEkgZGly
ZWN0bHkgdXBsb2FkIHRoZSB2NCBvciBTdGVwaGVuIGNhbiBwaWNrIHRoZSBjb21taXQgd2hpY2gg
DQpoYXMgYmVlbiByZW1vdmVkIGJhY2sgdG8gdGhlIGxpbnV4LW5leHQuDQoNCldoYXQgZG8geW91
IHRoaW5rPw0KDQpUaGFua3MgYSBsb3QuDQoNCkt1YW4tWWluZw0K

