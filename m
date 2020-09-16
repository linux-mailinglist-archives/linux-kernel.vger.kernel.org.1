Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6F826B97D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgIPBsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:48:12 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3603 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726023AbgIPBsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:48:12 -0400
Received: from dggeme702-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id A39656185BC785536EC8;
        Wed, 16 Sep 2020 09:48:09 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme702-chm.china.huawei.com (10.1.199.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 16 Sep 2020 09:48:09 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 16 Sep 2020 09:48:09 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in unlink_file_vma
Thread-Topic: general protection fault in unlink_file_vma
Thread-Index: AdaLyqUwCHihR92YQfeHMgqL8TkOUA==
Date:   Wed, 16 Sep 2020 01:48:09 +0000
Message-ID: <b542932c58eb464992529069cf58beaf@huawei.com>
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

PiBIZWxsbywNCj4NCj4gc3l6Ym90IGhhcyB0ZXN0ZWQgdGhlIHByb3Bvc2VkIHBhdGNoIGJ1dCB0
aGUgcmVwcm9kdWNlciBpcyBzdGlsbCB0cmlnZ2VyaW5nIGFuIGlzc3VlOg0KPiBrZXJuZWwgcGFu
aWM6IGNvcnJ1cHRlZCBzdGFjayBlbmQgaW4gc3lzX25hbm9zbGVlcA0KPg0KPiBLZXJuZWwgcGFu
aWMgLSBub3Qgc3luY2luZzogY29ycnVwdGVkIHN0YWNrIGVuZCBkZXRlY3RlZCBpbnNpZGUgc2No
ZWR1bGVyDQo+IENQVTogMCBQSUQ6IDEzNzkxIENvbW06IHN5ei1leGVjdXRvci40IE5vdCB0YWlu
dGVkIDUuOS4wLXJjNS1zeXprYWxsZXIgIzAgSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2dsZSBD
b21wdXRlIEVuZ2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgR29vZ2xlIDAxLzAxLzIw
MTEgQ2FsbCBUcmFjZToNCj4gIF9fZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5jOjc3IFtpbmxp
bmVdICBkdW1wX3N0YWNrKzB4MTk4LzB4MWZkIGxpYi9kdW1wX3N0YWNrLmM6MTE4DQo+ICBwYW5p
YysweDM0Ny8weDdjMCBrZXJuZWwvcGFuaWMuYzoyMzENCj4gIHNjaGVkdWxlX2RlYnVnIGtlcm5l
bC9zY2hlZC9jb3JlLmM6NDI3OCBbaW5saW5lXQ0KPiAgX19zY2hlZHVsZSsweDIyMWUvMHgyMjMw
IGtlcm5lbC9zY2hlZC9jb3JlLmM6NDQyMg0KPiAgc2NoZWR1bGUrMHhkMC8weDJhMCBrZXJuZWwv
c2NoZWQvY29yZS5jOjQ2MDIgIGZyZWV6YWJsZV9zY2hlZHVsZSBpbmNsdWRlL2xpbnV4L2ZyZWV6
ZXIuaDoxNzIgW2lubGluZV0NCj4gIGRvX25hbm9zbGVlcCsweDIyMi8weDY1MCBrZXJuZWwvdGlt
ZS9ocnRpbWVyLmM6MTg4Mw0KPiAgaHJ0aW1lcl9uYW5vc2xlZXArMHgxZjkvMHg0MzAga2VybmVs
L3RpbWUvaHJ0aW1lci5jOjE5MzYgIF9fZG9fc3lzX25hbm9zbGVlcCBrZXJuZWwvdGltZS9ocnRp
bWVyLmM6MTk3MCBbaW5saW5lXSAgX19zZV9zeXNfbmFub3NsZWVwIGtlcm5lbC90aW1lL2hydGlt
ZXIuYzoxOTU3IFtpbmxpbmVdDQo+ICBfX3g2NF9zeXNfbmFub3NsZWVwKzB4MWRjLzB4MjYwIGtl
cm5lbC90aW1lL2hydGltZXIuYzoxOTU3DQo+ICBkb19zeXNjYWxsXzY0KzB4MmQvMHg3MCBhcmNo
L3g4Ni9lbnRyeS9jb21tb24uYzo0Ng0KPiAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NDQvMHhhOQ0KPiBSSVA6IDAwMzM6MHg0NWJhODENCj4gQ29kZTogNzUgMTQgYjggMjMgMDAg
MDAgMDAgMGYgMDUgNDggM2QgMDEgZjAgZmYgZmYgMGYgODMgODQgY2YgZmIgZmYgYzMgNDggODMg
ZWMgMDggZTggZWEgNDYgMDAgMDAgNDggODkgMDQgMjQgYjggMjMgMDAgMDAgMDAgMGYgMDUgPDQ4
PiA4YiAzYyAyNCA0OCA4OSBjMiBlOCAzMyA0NyAwMCAwMCA0OCA4OSBkMCA0OCA4MyBjNCAwOCA0
OCAzZCAwMQ0KPiBSU1A6IDAwMmI6MDAwMDdmZmNhNmNiNmQ3MCBFRkxBR1M6IDAwMDAwMjkzIE9S
SUdfUkFYOiAwMDAwMDAwMDAwMDAwMDIzDQo+IFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAw
MDAwMDAwMDAwMmYyMjYgUkNYOiAwMDAwMDAwMDAwNDViYTgxDQo+IFJEWDogMDAwMDAwMDAwMDAw
MDAwMCBSU0k6IDAwMDAwMDAwMDAwMDAwMDAgUkRJOiAwMDAwN2ZmY2E2Y2I2ZDgwDQo+IFJCUDog
MDAwMDAwMDAwMDAwMDAwMSBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAw
MDAwDQo+IFIxMDogMDAwMDdmZmNhNmNiNmU4MCBSMTE6IDAwMDAwMDAwMDAwMDAyOTMgUjEyOiAw
MDAwMDAwMDAxMThjZjQwDQo+IFIxMzogMDAwMDAwMDAwMTE4ZDk0MCBSMTQ6IGZmZmZmZmZmZmZm
ZmZmZmYgUjE1OiAwMDAwMDAwMDAxMThjZmVjIEtlcm5lbCBPZmZzZXQ6IGRpc2FibGVkIFJlYm9v
dGluZyBpbiA4NjQwMCBzZWNvbmRzLi4NCj4NCj4NCj4gVGVzdGVkIG9uOg0KPg0KPiBjb21taXQ6
ICAgICAgICAgNzk2Y2Q4ZjQgZml4IGdwZg0KPiBnaXQgdHJlZTogICAgICAgaHR0cHM6Ly9naXRo
dWIuY29tL0xpbm1pYW9oZS9saW51eC8NCj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2Fs
bGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTEyYjVkNTAxOTAwMDAwDQo+IGtlcm5lbCBjb25m
aWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD1mODJlNThhNjY2
MWE1YWM0DQo+IGRhc2hib2FyZCBsaW5rOiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9i
dWc/ZXh0aWQ9YzVkNWE1MWRjYmI1NThjYTBjYjUNCj4gY29tcGlsZXI6ICAgICAgIGdjYyAoR0ND
KSAxMC4xLjAtc3l6IDIwMjAwNTA3DQo+DQoNCiNzeXogdGVzdDogaHR0cHM6Ly9naXRodWIuY29t
L0xpbm1pYW9oZS9saW51eCB2bWFfbWVyZ2VfZml4DQoNCg==
