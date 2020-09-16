Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABB26BD83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgIPGuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:50:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726128AbgIPGuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:50:12 -0400
Received: from dggeme753-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 4B41B7D513241AD3A8D0;
        Wed, 16 Sep 2020 14:50:10 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 16 Sep 2020 14:50:09 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 16 Sep 2020 14:50:09 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in unlink_file_vma
Thread-Topic: general protection fault in unlink_file_vma
Thread-Index: AdaL9WPWCHihR92YQfeHMgqL8TkOUA==
Date:   Wed, 16 Sep 2020 06:50:09 +0000
Message-ID: <d3a7e455690b4c629145c8c4936a55c7@huawei.com>
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

Pg0KPkhlbGxvLA0KPg0KPnN5emJvdCBoYXMgdGVzdGVkIHRoZSBwcm9wb3NlZCBwYXRjaCBidXQg
dGhlIHJlcHJvZHVjZXIgaXMgc3RpbGwgdHJpZ2dlcmluZyBhbiBpc3N1ZToNCj5rZXJuZWwgcGFu
aWM6IEZhdGFsIGV4Y2VwdGlvbg0KPg0KPlJCUDogMDAwMDAwMDAwMDAwMDAwMSBSMDg6IDAwMDAw
MDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAwDQo+UjEwOiAwMDAwN2ZmZDMwNjMwNzIw
IFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IDAwMDAwMDAwMDExOGQ5NDANCj5SMTM6IDAwMDAw
MDAwMDExOGQ5NDAgUjE0OiBmZmZmZmZmZmZmZmZmZmZmIFIxNTogMDAwMDAwMDAwMTE4Y2ZlYw0K
PkZTOiAgMDAwMDAwMDAwMWI0Nzk0MCgwMDAwKSBHUzpmZmZmODg4MGFlNzAwMDAwKDAwMDApIGtu
bEdTOjAwMDAwMDAwMDAwMDAwMDANCj5DUzogIDAwMzMgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAw
MDAwMDAwMDgwMDUwMDMzDQo+Q1IyOiAwMDAwMDAwMDAxNTkwMDA0IENSMzogMDAwMDAwMDAyMTA5
NzAwMCBDUjQ6IDAwMDAwMDAwMDAxNTA2ZTANCj5EUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAw
MDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMA0KPkRSMzogMDAwMDAwMDAwMDAw
MDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3OiAwMDAwMDAwMDAwMDAwNDAwIEtlcm5lbCBw
YW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gS2VybmVsIE9mZnNldDogZGlzYWJs
ZWQNCj4NCj4NCj5UZXN0ZWQgb246DQo+DQo+Y29tbWl0OiAgICAgICAgIDhmNzk0MDBiIGZpeCB2
bWFfbWVyZ2UgZ3BmDQo+Z2l0IHRyZWU6ICAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9MaW5taWFv
aGUvbGludXggdm1hX21lcmdlX2ZpeA0KPmNvbnNvbGUgb3V0cHV0OiBodHRwczovL3N5emthbGxl
ci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xNTNiMWQ0MzkwMDAwMA0KPmtlcm5lbCBjb25maWc6
ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD0zYzVmNmNlOGQ1YjY4
Mjk5DQo+ZGFzaGJvYXJkIGxpbms6IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9l
eHRpZD1jNWQ1YTUxZGNiYjU1OGNhMGNiNQ0KPmNvbXBpbGVyOiAgICAgICBnY2MgKEdDQykgMTAu
MS4wLXN5eiAyMDIwMDUwNw0KPg0KDQojc3l6IHRlc3Q6IGh0dHBzOi8vZ2l0aHViLmNvbS9MaW5t
aWFvaGUvbGludXggdm1hX21lcmdlX2ZpeA0KDQo=
