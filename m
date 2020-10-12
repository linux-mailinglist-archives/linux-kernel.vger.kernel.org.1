Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98AC28AC01
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgJLCKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:10:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbgJLCKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:10:43 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 92781376A82C2DCCE846;
        Mon, 12 Oct 2020 10:10:41 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 12 Oct 2020 10:10:41 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 12 Oct 2020 10:10:41 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     David Hildenbrand <david@redhat.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "ziy@nvidia.com" <ziy@nvidia.com>,
        "alexander.h.duyck@linux.intel.com" 
        <alexander.h.duyck@linux.intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "yang.shi@linux.alibaba.com" <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] page-flags: Remove unused __[Set|Clear]PagePrivate
Thread-Topic: [PATCH] page-flags: Remove unused __[Set|Clear]PagePrivate
Thread-Index: AdagPFpN5kgdhoQYAEiMEx4wSjEs+w==
Date:   Mon, 12 Oct 2020 02:10:41 +0000
Message-ID: <05749e061aab4cd2967a385cc5beec92@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gQW0gMTAuMTAu
MjAyMCB1bSAwMzo1MyBzY2hyaWViIGxpbm1pYW9oZSA8bGlubWlhb2hlQGh1YXdlaS5jb20+Og0K
Pj4gDQo+PiDvu79EYXZpZCBIaWxkZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT4gd3JvdGU6DQo+
Pj4+IE9uIDA5LjEwLjIwIDE1OjU5LCBNaWFvaGUgTGluIHdyb3RlOg0KPj4+PiBUaGV5IGFyZSB1
bnVzZWQgYW55bW9yZS4NCj4+PiANCj4+PiAtRUlOVkFMLCBzZW50ZW5jZSBkb2VzIG5vdCBtYWtl
IHNlbnNlIDopDQo+Pj4gDQo+Pj4gIlRoZXkgYXJlIG5vdCB1c2VkIGFueW1vcmUuIg0KPj4+ICJU
aGV5IGFyZSB1bnVzZWQgLiINCj4+IA0KPj4gTXkgcG9vciBFbmdsaXNoLiA7KSBXaWxsIGNoYW5n
ZSBpdCBpbiB2MiBzb29uLiBNYW55IFRoYW5rcy4NCj4NCj5Zb3UgZ290IGl0IHJpZ2h0IGluIHRo
ZSBzdWJqZWN0IDopDQo+DQo+Tm8gbmVlZCB0byByZXNlbmQgLSBBbmRyZXcgY2FuIGZpeHVwIHdo
ZW4gYXBwbHlpbmchDQo+DQoNCk1hbnkgdGhhbmtzIGZvciB5b3VyIGtpbmRseSByZW1pbmQuIDop
DQoNCj5DaGVlcnMhDQo+DQo+PiANCj4+PiANCj4+PiBSZXZpZXdlZC1ieTogRGF2aWQgSGlsZGVu
YnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+DQo+Pj4gDQoNCg0K
