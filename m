Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDFC26B90B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgIPAzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:55:53 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:40998 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726315AbgIOLaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:30:25 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 196914EC1020076C53C8;
        Tue, 15 Sep 2020 19:13:21 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 15 Sep 2020 19:13:20 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 15 Sep 2020 19:13:20 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in unlink_file_vma
Thread-Topic: general protection fault in unlink_file_vma
Thread-Index: AdaLUCs+MLS2jE7zQmqovK8cDsLrmg==
Date:   Tue, 15 Sep 2020 11:13:20 +0000
Message-ID: <e3b337ff2fcc4b2c955be20aed74477c@huawei.com>
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

c3l6Ym90IDxzeXpib3QrYzVkNWE1MWRjYmI1NThjYTBjYjVAc3l6a2FsbGVyLmFwcHNwb3RtYWls
LmNvbT4gd3JvdGU6DQo+IEhlbGxvLA0KPg0KPnN5emJvdCBoYXMgdGVzdGVkIHRoZSBwcm9wb3Nl
ZCBwYXRjaCBidXQgdGhlIHJlcHJvZHVjZXIgaXMgc3RpbGwgdHJpZ2dlcmluZyBhbiBpc3N1ZToN
Cj5rZXJuZWwgcGFuaWM6IGNvcnJ1cHRlZCBzdGFjayBlbmQgaW4gc3lzX25hbm9zbGVlcA0KPg0K
Pktlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBjb3JydXB0ZWQgc3RhY2sgZW5kIGRldGVjdGVk
IGluc2lkZSBzY2hlZHVsZXINCj5DUFU6IDAgUElEOiAxMzc5MSBDb21tOiBzeXotZXhlY3V0b3Iu
NCBOb3QgdGFpbnRlZCA1LjkuMC1yYzUtc3l6a2FsbGVyICMwIEhhcmR3YXJlIG5hbWU6IEdvb2ds
ZSBHb29nbGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2ds
ZSAwMS8wMS8yMDExIENhbGwgVHJhY2U6DQo+IF9fZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5j
Ojc3IFtpbmxpbmVdICBkdW1wX3N0YWNrKzB4MTk4LzB4MWZkIGxpYi9kdW1wX3N0YWNrLmM6MTE4
DQo+IHBhbmljKzB4MzQ3LzB4N2MwIGtlcm5lbC9wYW5pYy5jOjIzMQ0KPiBzY2hlZHVsZV9kZWJ1
ZyBrZXJuZWwvc2NoZWQvY29yZS5jOjQyNzggW2lubGluZV0NCj4gX19zY2hlZHVsZSsweDIyMWUv
MHgyMjMwIGtlcm5lbC9zY2hlZC9jb3JlLmM6NDQyMg0KPiBzY2hlZHVsZSsweGQwLzB4MmEwIGtl
cm5lbC9zY2hlZC9jb3JlLmM6NDYwMiAgZnJlZXphYmxlX3NjaGVkdWxlIGluY2x1ZGUvbGludXgv
ZnJlZXplci5oOjE3MiBbaW5saW5lXQ0KPiBkb19uYW5vc2xlZXArMHgyMjIvMHg2NTAga2VybmVs
L3RpbWUvaHJ0aW1lci5jOjE4ODMNCj4gaHJ0aW1lcl9uYW5vc2xlZXArMHgxZjkvMHg0MzAga2Vy
bmVsL3RpbWUvaHJ0aW1lci5jOjE5MzYgIF9fZG9fc3lzX25hbm9zbGVlcCBrZXJuZWwvdGltZS9o
cnRpbWVyLmM6MTk3MCBbaW5saW5lXSAgX19zZV9zeXNfbmFub3NsZWVwIGtlcm5lbC90aW1lL2hy
dGltZXIuYzoxOTU3IFtpbmxpbmVdDQo+IF9feDY0X3N5c19uYW5vc2xlZXArMHgxZGMvMHgyNjAg
a2VybmVsL3RpbWUvaHJ0aW1lci5jOjE5NTcNCj4gZG9fc3lzY2FsbF82NCsweDJkLzB4NzAgYXJj
aC94ODYvZW50cnkvY29tbW9uLmM6NDYNCj4gZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1l
KzB4NDQvMHhhOQ0KPlJJUDogMDAzMzoweDQ1YmE4MQ0KPkNvZGU6IDc1IDE0IGI4IDIzIDAwIDAw
IDAwIDBmIDA1IDQ4IDNkIDAxIGYwIGZmIGZmIDBmIDgzIDg0IGNmIGZiIGZmIGMzIDQ4IDgzIGVj
IDA4IGU4IGVhIDQ2IDAwIDAwIDQ4IDg5IDA0IDI0IGI4IDIzIDAwIDAwIDAwIDBmIDA1IDw0OD4g
OGIgM2MgMjQgNDggODkgYzIgZTggMzMgNDcgMDAgMDAgNDggODkgZDAgNDggODMgYzQgMDggNDgg
M2QgMDENCj5SU1A6IDAwMmI6MDAwMDdmZmNhNmNiNmQ3MCBFRkxBR1M6IDAwMDAwMjkzIE9SSUdf
UkFYOiAwMDAwMDAwMDAwMDAwMDIzDQo+UkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAw
MDAwMDAyZjIyNiBSQ1g6IDAwMDAwMDAwMDA0NWJhODENCj5SRFg6IDAwMDAwMDAwMDAwMDAwMDAg
UlNJOiAwMDAwMDAwMDAwMDAwMDAwIFJESTogMDAwMDdmZmNhNmNiNmQ4MA0KPlJCUDogMDAwMDAw
MDAwMDAwMDAwMSBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+
UjEwOiAwMDAwN2ZmY2E2Y2I2ZTgwIFIxMTogMDAwMDAwMDAwMDAwMDI5MyBSMTI6IDAwMDAwMDAw
MDExOGNmNDANCj5SMTM6IDAwMDAwMDAwMDExOGQ5NDAgUjE0OiBmZmZmZmZmZmZmZmZmZmZmIFIx
NTogMDAwMDAwMDAwMTE4Y2ZlYyBLZXJuZWwgT2Zmc2V0OiBkaXNhYmxlZCBSZWJvb3RpbmcgaW4g
ODY0MDAgc2Vjb25kcy4uDQo+DQo+DQo+VGVzdGVkIG9uOg0KPg0KPmNvbW1pdDogICAgICAgICA3
OTZjZDhmNCBmaXggZ3BmDQo+Z2l0IHRyZWU6ICAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9MaW5t
aWFvaGUvbGludXgvDQo+Y29uc29sZSBvdXRwdXQ6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3Qu
Y29tL3gvbG9nLnR4dD94PTEyYjVkNTAxOTAwMDAwDQo+a2VybmVsIGNvbmZpZzogIGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvLmNvbmZpZz94PWY4MmU1OGE2NjYxYTVhYzQNCj5kYXNo
Ym9hcmQgbGluazogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWM1ZDVh
NTFkY2JiNTU4Y2EwY2I1DQo+Y29tcGlsZXI6ICAgICAgIGdjYyAoR0NDKSAxMC4xLjAtc3l6IDIw
MjAwNTA3DQoNClRoaXMgaXNzdWUgbG9va3MgbGlrZSBpcnJlbGV2YW50IHdpdGggbXkgcHJldmlv
dXMgY29tbWl0LCBtYXliZSBpdCdzIGJlY2F1c2UgSSBmaXggdGhpcyBvbiB3cm9uZyBjb21taXQu
DQpJIHdvdWxkIHJlYmFzZSB0aGlzIG9uIGNvbW1pdCA1OTEyNjkwMSAoIk1lcmdlIHRhZyAncGVy
Zi10b29scy1maXhlcy1mb3ItdjUuOS0yMDIwLTA5LTAzJyAuLiIpLg0KVGhhbmtzLg0KDQo=
