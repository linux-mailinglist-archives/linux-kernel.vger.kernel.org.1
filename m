Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05122DBE10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgLPJzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:55:49 -0500
Received: from mail4.tencent.com ([183.57.53.109]:47686 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgLPJzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:55:48 -0500
X-Greylist: delayed 629 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 04:55:46 EST
Received: from EX-SZ019.tencent.com (unknown [10.28.6.74])
        by mail4.tencent.com (Postfix) with ESMTP id 0C03A72324;
        Wed, 16 Dec 2020 17:44:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1608111873;
        bh=8VCOFwKk8MVuvCcgjXFt5QOF+JdjMyNF+wFpMk5zMX4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=i7X+Mm40ZyEqupl4VvfpHjtyYwGARQ2xwVQdFTJrJvZtLl8pq9xPAidl2EMl3DZ4N
         OuXDa8aK6Cz7rGCgGtLU2qvQUzw9TFyTVB/mR2F2r74RrbAeOgnim7gk20+Jf8U+Tv
         3M1KSOoofPn9HyCH6AoJ1JHGtOqBMpfKYivN2kx8=
Received: from EX-SZ003.tencent.com (10.28.6.15) by EX-SZ019.tencent.com
 (10.28.6.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 16 Dec
 2020 17:44:32 +0800
Received: from EX-SZ004.tencent.com (10.28.6.25) by EX-SZ003.tencent.com
 (10.28.6.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 16 Dec
 2020 17:44:32 +0800
Received: from EX-SZ004.tencent.com ([fe80::31b3:8aa5:7748:d7c2]) by
 EX-SZ004.tencent.com ([fe80::31b3:8aa5:7748:d7c2%8]) with mapi id
 15.01.2106.002; Wed, 16 Dec 2020 17:44:32 +0800
From:   =?gb2312?B?eGlhb2dnY2hlbiizwtChueIp?= <xiaoggchen@tencent.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "chenxg1x@gmail.com" <chenxg1x@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        =?gb2312?B?aGVkZGNoZW4os8K62Ck=?= <heddchen@tencent.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIXSBzY2hlZDogZG9uJ3QgY2hlY2sgcnEgYWZ0ZXIgbmV3?=
 =?gb2312?Q?idle=5Fbalance_return_positive(Internet_mail)?=
Thread-Topic: [PATCH] sched: don't check rq after newidle_balance return
 positive(Internet mail)
Thread-Index: AQHW0q5qXyxy1Zj2BUevAJM9uKMZMan3TjcAgAIqT0A=
Date:   Wed, 16 Dec 2020 09:44:32 +0000
Message-ID: <879d8f70061645ffbba73ef6741efc15@tencent.com>
References: <1608014930-5144-1-git-send-email-xiaoggchen@tencent.com>
 <20201215083238.GB3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20201215083238.GB3040@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.16.9]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGlu
ZnJhZGVhZC5vcmc+IA0Kt6LLzcqxvOQ6IDIwMjDE6jEy1MIxNcjVIDE2OjMzDQrK1bz+yMs6IGNo
ZW54ZzF4QGdtYWlsLmNvbQ0Ks63LzTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWlu
Z29AcmVkaGF0LmNvbTsganVyaS5sZWxsaUByZWRoYXQuY29tOyB2aW5jZW50Lmd1aXR0b3RAbGlu
YXJvLm9yZzsgZGlldG1hci5lZ2dlbWFubkBhcm0uY29tOyByb3N0ZWR0QGdvb2RtaXMub3JnOyBi
c2VnYWxsQGdvb2dsZS5jb207IG1nb3JtYW5Ac3VzZS5kZTsgYnJpc3RvdEByZWRoYXQuY29tOyBo
ZWRkY2hlbiizwrrYKSA8aGVkZGNoZW5AdGVuY2VudC5jb20+OyB4aWFvZ2djaGVuKLPC0KG54ikg
PHhpYW9nZ2NoZW5AdGVuY2VudC5jb20+DQrW98ziOiBSZTogW1BBVENIXSBzY2hlZDogZG9uJ3Qg
Y2hlY2sgcnEgYWZ0ZXIgbmV3aWRsZV9iYWxhbmNlIHJldHVybiBwb3NpdGl2ZShJbnRlcm5ldCBt
YWlsKQ0KDQpPbiBUdWUsIERlYyAxNSwgMjAyMCBhdCAwMjo0ODo1MFBNICswODAwLCBjaGVueGcx
eEBnbWFpbC5jb20gd3JvdGU6DQo+PiBGcm9tOiBDaGVuIFhpYW9ndWFuZyA8eGlhb2dnY2hlbkB0
ZW5jZW50LmNvbT4NCj4+IA0KPj4gSW4gcGlja19uZXh0X3Rhc2tfZmFpciwgaWYgQ1BVIGlzIGdv
aW5nIHRvIGlkbGUgbmV3aWRsZV9iYWxhbmNlIGlzIA0KPj4gY2FsbGVkIGZpcnN0IHRyeWluZyB0
byBwdWxsIHNvbWUgdGFza3MuDQo+PiBXaGVuIG5ld2lkbGVfYmFsYW5jZSByZXR1cm5zIHBvc2l0
aXZlIHdoaWNoIG1lYW5zIGl0IGRvZXMgcHVsbHMgdGFza3MgDQo+PiBvciBzb21lIHRhc2tzIGVu
cXVldWVkIHRoZW4gdGhlcmUgaXMgbm8gbmVlZCB0byBjaGVjayANCj4+IHNjaGVkX2ZhaXJfcnVu
bmFibGUgYWdhaW4uDQoNCj4gTm8sIEkgdGhpbmsgaXQgYWN0dWFsbHkgZG9lcyBuZWVkIHRvLCBi
ZWNhdXNlIHdoaWxlIGl0IGNvdW50cyB0aGUgbnVtYmVyIG9mIHRhc2tzIGl0IHB1bGxlZCwgaXQg
ZG9lc24ndCB2ZXJpZnkgaXQgc3RpbGwgaGFzIHRoZW0gYWZ0ZXIgaXQgcmUtYWNxdWlyZXMgcnEt
PmxvY2suIFRoYXQgaXMsIHNvbWVvbmUgY291bGQndmUgY29tZSBhbG9uZyBhbmQgc3RvbGVuIHRo
ZW0gDQo+IHJpZ2h0IGZyb20gdW5kZXIgb3VyIG5vc2VzLg0KQWgsIHllcywgb3VyIGNoYW5nZSBv
bmx5IG1ha2Ugc2Vuc2Ugd2hlbiBwdWxsaW5nIG5vdGhpbmcgaW4gbG9hZF9iYWxhbmNlIGJ1dCBz
b21lIHRhc2tzIGVucXVldWVkIHRoaXMgcnEgZHVyaW5nIHRoZSBsb2NrIG9mIHRoaXMgcnEgaXMg
cmVsZWFzZWQuDQogDQpUaGFua3MuDQoNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogSGUgQ2hlbiA8
aGVkZGNoZW5AdGVuY2VudC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBYaWFvZ3VhbmcgQ2hlbiA8
eGlhb2dnY2hlbkB0ZW5jZW50LmNvbT4NCg0KPiBUaGlzIFNvQiBjaGFpbiBpcyBicm9rZW4uIFRo
ZSBmaXJzdCBTb0Igc2hvdWxkIGJlIHRoZSBhdXRob3IsIGJ1dCBGcm9tIGRvZXMgbm90IG1hdGNo
Lg0KV2Ugd2lsbCBmaXggdGhpcyBuZXh0IHRpbWUuDQoNCg==
