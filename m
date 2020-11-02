Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8A2A2586
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgKBHqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:46:22 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2054 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgKBHqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:46:21 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CPlN63SSXzVkDj;
        Mon,  2 Nov 2020 15:46:14 +0800 (CST)
Received: from dggema707-chm.china.huawei.com (10.3.20.71) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Mon, 2 Nov 2020 15:46:19 +0800
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggema707-chm.china.huawei.com (10.3.20.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 2 Nov 2020 15:46:18 +0800
Received: from dggema755-chm.china.huawei.com ([10.1.198.197]) by
 dggema755-chm.china.huawei.com ([10.1.198.197]) with mapi id 15.01.1913.007;
 Mon, 2 Nov 2020 15:46:18 +0800
From:   kechengsong <kechengsong@huawei.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "wangfangpeng (A)" <wangfangpeng1@huawei.com>
Subject: Re: [PATCH v2] ubifs: Fix the printing type of c->big_lpt
Thread-Topic: [PATCH v2] ubifs: Fix the printing type of c->big_lpt
Thread-Index: Adaw65ghGw6k01UFTsCEUCDswEUIxw==
Date:   Mon, 2 Nov 2020 07:46:18 +0000
Message-ID: <c5dc46a06f784380a7c3f8186059fc1a@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.101.108]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCBPY3QgMzEsIDIwMjAgYXQgOTo1NiBBTSBDaGVuZ3NvbmcgS2UgPGtlY2hlbmdzb25n
QGh1YXdlaS5jb20+IHdyb3RlOg0KPg0KPiBVYmlmcyB1c2VzICVkIHRvIHByaW50IGMtPmJpZ19s
cHQsIGJ1dCBjLT5iaWdfbHB0IGlzIGEgdmFyaWFibGUgb2YgDQo+IHR5cGUgdW5zaWduZWQgaW50
IGFuZCBzaG91bGQgYmUgcHJpbnRlZCB3aXRoICV1Lg0KPg0KPiBXZWxsLCBpdCBpczoNCj4gdW5z
aWduZWQgaW50IGJpZ19scHQ6MTsNCj4gU28sIGVpdGhlciAwIG9yIDEuDQo+IA0KPiBEb2VzIGNo
YW5naW5nIGl0IHRvICV1IHNpbGVuY2Ugc29tZSBzdGF0aWMgY2hlY2tlciBvciBpcyB0aGVyZSBz
b21lIG90aGVyIHByb2JsZW0gSSBkb24ndCBzZWUgcmlnaHQgbm93PyA6LSkNCj4gDQo+IFRoYW5r
cywNCj4gLy9SaWNoYXJkDQoNClRoaXMgaXMganVzdCBhIGNvZGluZyBzdHlsZSBpc3N1ZSwgSSBm
b3VuZCBpbiB0aGUgdWJpZnMgY29kZS4gOi0pDQpUaGFua3MsDQovL0NoZW5nc29uZyBLZQ0K
