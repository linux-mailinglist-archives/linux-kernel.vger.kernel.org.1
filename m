Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD82926B974
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIPBkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:40:04 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3101 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbgIPBkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:40:03 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 3C33AF7914ACF9FF1D5E;
        Wed, 16 Sep 2020 09:39:56 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 16 Sep 2020 09:39:55 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 16 Sep 2020 09:39:55 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "christian@kellner.me" <christian@kellner.me>,
        "surenb@google.com" <surenb@google.com>,
        "areber@redhat.com" <areber@redhat.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fork: Use helper function mapping_allow_writable() in
 dup_mmap()
Thread-Topic: [PATCH] fork: Use helper function mapping_allow_writable() in
 dup_mmap()
Thread-Index: AdaLyeXS7QxoEIqgoESUKoVD51FRKg==
Date:   Wed, 16 Sep 2020 01:39:55 +0000
Message-ID: <3eaffcde4b28478483cd24154fc04836@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hyaXN0aWFuIEJyYXVuZXIgPGNocmlzdGlhbi5icmF1bmVyQHVidW50dS5jb20+IHdyb3RlOg0K
PiBPbiBTdW4sIFNlcCAxMywgMjAyMCBhdCAwNToyNDoxNUFNIC0wNDAwLCBNaWFvaGUgTGluIHdy
b3RlOg0KPj4gVXNlIGhlbHBlciBmdW5jdGlvbiBtYXBwaW5nX2FsbG93X3dyaXRhYmxlKCkgdG8g
YXRvbWljX2luYyBpX21tYXBfd3JpdGFibGUuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE1pYW9o
ZSBMaW4gPGxpbm1pYW9oZUBodWF3ZWkuY29tPg0KPj4gLS0tDQo+DQo+SGV5IE1pYW9oZSwNCj4N
Cj5UaGFua3MgZm9yIHRoZSBwYXRjaCENCj5QZXIgc2UgdGhlcmUncyBub3RoaW5nIGFnYWluc3Qg
dXNpbmcgYSBwcm9wZXIgaGVscGVyIHdoZW4gaXQgZXhpc3RzLg0KPkJ1dCBpdCBoYXMgYWxyZWFk
eSBiZWVuIHBvaW50ZWQgb3V0IHRoYXQgdGhpcyBuZWVkcyBhIHByb3BlciBjb21taXQgbWVzc2Fn
ZSB3aXRoIG1vcmUgcmF0aW9uYWxlLiBCdXQgSSdtIG90aGVyd2lzZSBoYXBweSB0byB0YWtlIHRo
aXMuDQo+DQoNCk1hbnkgdGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KRXJpYyBoYXZlIGtpbmRseSBw
b2ludGVkIHRoaXMgb3V0LiBJIHRoaW5rIEkgc2hvdWxkIHByb3ZpZGUgYSBwcm9wZXIgY29tbWl0
IG1lc3NhZ2Ugd2l0aCBtb3JlIHJhdGlvbmFsZSBpbiB2Mi4NClRoYW5rcyBhZ2Fpbi4NCg0KPlRo
YW5rcyENCj5DaHJpc3RpYW4NCg==
