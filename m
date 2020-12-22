Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982562E0440
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 03:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgLVCL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 21:11:26 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2406 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgLVCLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:11:25 -0500
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4D0KXr6vD9z57k6;
        Tue, 22 Dec 2020 10:09:48 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 22 Dec 2020 10:10:42 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Tue, 22 Dec 2020 10:10:42 +0800
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
Thread-Index: AQHW1mZAeBjE5clI7UKUuMSOCQsyuqoBSTyAgAAghwCAAAhXgIAAhndA//+NyICAAIW5IP//jYeAgACME8CAAA+J8P//k2OAABCudWAAAQz+8P//giUA//96TuD//vIJMA==
Date:   Tue, 22 Dec 2020 02:10:42 +0000
Message-ID: <08cbef1e43634c4099709be8e99e5d27@hisilicon.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU29uZyBCYW8gSHVhIChC
YXJyeSBTb25nKQ0KPiBTZW50OiBUdWVzZGF5LCBEZWNlbWJlciAyMiwgMjAyMCAzOjAzIFBNDQo+
IFRvOiAnVml0YWx5IFdvb2wnIDx2aXRhbHkud29vbEBrb25zdWxrby5jb20+DQo+IENjOiBTaGFr
ZWVsIEJ1dHQgPHNoYWtlZWxiQGdvb2dsZS5jb20+OyBNaW5jaGFuIEtpbSA8bWluY2hhbkBrZXJu
ZWwub3JnPjsgTWlrZQ0KPiBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+OyBMS01MIDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgbGludXgtbW0NCj4gPGxpbnV4LW1tQGt2YWNrLm9yZz47
IFNlYmFzdGlhbiBBbmRyemVqIFNpZXdpb3IgPGJpZ2Vhc3lAbGludXRyb25peC5kZT47DQo+IE5p
dGluR3VwdGEgPG5ndXB0YUB2ZmxhcmUub3JnPjsgU2VyZ2V5IFNlbm96aGF0c2t5DQo+IDxzZXJn
ZXkuc2Vub3poYXRza3kud29ya0BnbWFpbC5jb20+OyBBbmRyZXcgTW9ydG9uDQo+IDxha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnPjsgdGlhbnRhbyAoSCkgPHRpYW50YW82QGhpc2lsaWNvbi5jb20+
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHpzbWFsbG9jOiBkbyBub3QgdXNlIGJpdF9zcGluX2xv
Y2sNCj4gDQo+IA0KPiA+IEknbSBzdGlsbCBub3QgY29udmluY2VkLiBXaWxsIGttYXAgd2hhdCwg
c3JjPyBBdCB0aGlzIHBvaW50IHNyYyBtaWdodCBiZWNvbWUNCj4ganVzdCBhIGJvZ3VzIHBvaW50
ZXIuDQo+IA0KPiBBcyBsb25nIGFzIHRoZSBtZW1vcnkgaXMgc3RpbGwgdGhlcmUsIHdlIGNhbiBr
bWFwIGl0IGJ5IGl0cyBwYWdlIHN0cnVjdC4gQnV0DQo+IGlmDQo+IGl0IGlzIG5vdCB0aGVyZSBh
bnltb3JlLCB3ZSBoYXZlIG5vIHdheS4NCj4gDQo+ID4gV2h5IGNvdWxkbid0IHRoZSBvYmplY3Qg
aGF2ZSBiZWVuIG1vdmVkIHNvbWV3aGVyZSBlbHNlIChkdWUgdG8gdGhlIGNvbXBhY3Rpb24NCj4g
bWVjaGFuaXNtIGZvciBpbnN0YW5jZSkNCj4gPiBhdCB0aGUgdGltZSBETUEga2lja3MgaW4/DQo+
IA0KPiBTbyB6c19tYXBfb2JqZWN0KCkgd2lsbCBndWFyYW50ZWUgdGhlIHNyYyB3b24ndCBiZSBt
b3ZlZCBieSBob2xkaW5nIHRob3NlDQo+IHByZWVtcHRpb24tZGlzYWJsZWQgbG9jaz8NCj4gSWYg
c28sIGl0IHNlZW1zIHdlIGhhdmUgdG8gZHJvcCB0aGUgTU9WQUJMRSBnZnAgaW4genN3YXAgZm9y
IHpzbWFsbG9jIGNhc2U/DQo+IA0KDQpPciB3ZSBjYW4gZG8gZ2V0X3BhZ2UoKSB0byBhdm9pZCB0
aGUgbW92ZW1lbnQgb2YgdGhlIHBhZ2UuDQoNCj4gPg0KPiA+ID4NCj4gPiA+IH5WaXRhbHkNCj4g
Pg0KPiANCj4gVGhhbmtzDQo+IEJhcnJ5DQoNCg0K
