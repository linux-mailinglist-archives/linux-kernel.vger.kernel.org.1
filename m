Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F78289D5C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgJJCG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 22:06:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3976 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729994AbgJJBxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:53:37 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 6AD04EA7C68F19C08B60;
        Sat, 10 Oct 2020 09:53:14 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sat, 10 Oct 2020 09:53:14 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Sat, 10 Oct 2020 09:53:14 +0800
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
Thread-Index: AdaeqBvI5kgdhoQYAEiMEx4wSjEs+w==
Date:   Sat, 10 Oct 2020 01:53:13 +0000
Message-ID: <e8b85ab4a7ff4a84b4081ba05ce76061@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGF2aWQgSGlsZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+IHdyb3RlOg0KPiBPbiAwOS4xMC4y
MCAxNTo1OSwgTWlhb2hlIExpbiB3cm90ZToNCj4+IFRoZXkgYXJlIHVudXNlZCBhbnltb3JlLg0K
Pg0KPi1FSU5WQUwsIHNlbnRlbmNlIGRvZXMgbm90IG1ha2Ugc2Vuc2UgOikNCj4NCj4iVGhleSBh
cmUgbm90IHVzZWQgYW55bW9yZS4iDQo+IlRoZXkgYXJlIHVudXNlZCAuIg0KDQpNeSBwb29yIEVu
Z2xpc2guIDspIFdpbGwgY2hhbmdlIGl0IGluIHYyIHNvb24uIE1hbnkgVGhhbmtzLg0KDQo+DQo+
UmV2aWV3ZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPg0K
