Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A882E043D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 03:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLVCIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 21:08:36 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2098 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLVCIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:08:36 -0500
Received: from dggeme712-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4D0KTH2splzVqvd;
        Tue, 22 Dec 2020 10:06:43 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme712-chm.china.huawei.com (10.1.199.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 22 Dec 2020 10:07:54 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Tue, 22 Dec 2020 10:07:54 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Vitaly Wool <vitaly.wool@konsulko.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Mike Galbraith" <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        NitinGupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "tiantao (H)" <tiantao6@hisilicon.com>
Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Topic: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Index: AQHW1mZAeBjE5clI7UKUuMSOCQsyuqoBSTyAgAAghwCAAAhXgIAAhndA//+NyICAAIW5IP//jYeAgACME8CAAA+J8P//k2OAABCudWAAAQz+8P//giUA//96TuA=
Date:   Tue, 22 Dec 2020 02:07:53 +0000
Message-ID: <cb7527b626904a909d6fdba67bd5235b@hisilicon.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
 <20201220002228.38697-1-vitaly.wool@konsulko.com>
 <X+DaMSJE22nUC0tl@google.com>
 <CAM4kBBKnW6K-mbPno4SpvhUBiykP4zeFm_CNzssDkReURbuU7w@mail.gmail.com>
 <CALvZod69OtXkdOJPzuY5XfXz_ro0V7OmqW4OY9B_emqwroxW4w@mail.gmail.com>
 <e5cd8a0a5df84081a11359ede6e746bc@hisilicon.com>
 <CALvZod7EZnEWb_65FjSNdx+-S_4pLHyS5rYiU-D3hFLRMXS6Lw@mail.gmail.com>
 <8cc0e01fd03245a4994f2e0f54b264fa@hisilicon.com>
 <CAM4kBB+xUa8zXSRSuB0z5FCdPNmUpDfcC4Vqu7wzAkf0b+RXqw@mail.gmail.com>
 <f0ca46a830e54f4482fb4f46df9675f5@hisilicon.com>
 <CAM4kBBKD6MAOaBvwC_Wedf_zmzmt-gm=TrAF1Lh7pVbNtcsFZg@mail.gmail.com>
 <4490cb6a7e2243fba374e40652979e46@hisilicon.com>
 <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
In-Reply-To: <CAM4kBBK=5eBdCjWc5VJXcdr=Z4PV1=ZQ2n8fZmJ6ahJbpUyv2A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.103]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IEknbSBzdGlsbCBub3QgY29udmluY2VkLiBXaWxsIGttYXAgd2hhdCwgc3JjPyBBdCB0aGlz
IHBvaW50IHNyYyBtaWdodCBiZWNvbWUganVzdCBhIGJvZ3VzIHBvaW50ZXIuIA0KDQpBcyBsb25n
IGFzIHRoZSBtZW1vcnkgaXMgc3RpbGwgdGhlcmUsIHdlIGNhbiBrbWFwIGl0IGJ5IGl0cyBwYWdl
IHN0cnVjdC4gQnV0IGlmDQppdCBpcyBub3QgdGhlcmUgYW55bW9yZSwgd2UgaGF2ZSBubyB3YXku
DQoNCj4gV2h5IGNvdWxkbid0IHRoZSBvYmplY3QgaGF2ZSBiZWVuIG1vdmVkIHNvbWV3aGVyZSBl
bHNlIChkdWUgdG8gdGhlIGNvbXBhY3Rpb24gbWVjaGFuaXNtIGZvciBpbnN0YW5jZSkNCj4gYXQg
dGhlIHRpbWUgRE1BIGtpY2tzIGluPw0KDQpTbyB6c19tYXBfb2JqZWN0KCkgd2lsbCBndWFyYW50
ZWUgdGhlIHNyYyB3b24ndCBiZSBtb3ZlZCBieSBob2xkaW5nIHRob3NlIHByZWVtcHRpb24tZGlz
YWJsZWQgbG9jaz8NCklmIHNvLCBpdCBzZWVtcyB3ZSBoYXZlIHRvIGRyb3AgdGhlIE1PVkFCTEUg
Z2ZwIGluIHpzd2FwIGZvciB6c21hbGxvYyBjYXNlPw0KDQo+IA0KPiA+DQo+ID4gflZpdGFseQ0K
PiANCg0KVGhhbmtzDQpCYXJyeQ0K
