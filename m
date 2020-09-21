Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046C0271C31
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgIUHlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:41:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47396 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIUHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:41:46 -0400
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 03:41:45 EDT
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 08L7YrVdA020630, This message is accepted by code: ctloc85258
Received: from RSEXMBS02.realsil.com.cn ([172.29.17.196])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 08L7YrVdA020630
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Sep 2020 15:34:53 +0800
Received: from RSEXMBS02.realsil.com.cn (172.29.17.196) by
 RSEXMBS02.realsil.com.cn (172.29.17.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 21 Sep 2020 15:34:52 +0800
Received: from RSEXMBS02.realsil.com.cn ([fe80::7c48:1e22:fa36:f292]) by
 RSEXMBS02.realsil.com.cn ([fe80::7c48:1e22:fa36:f292%7]) with mapi id
 15.01.2044.004; Mon, 21 Sep 2020 15:34:52 +0800
From:   =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Questions about drivers/mfd/mfd-core.c
Thread-Topic: Questions about drivers/mfd/mfd-core.c
Thread-Index: AdaP5SaG58tyf6GzRYmfdxMxh8jYxw==
Date:   Mon, 21 Sep 2020 07:34:52 +0000
Message-ID: <989ff36ebc5746d69528ce05b660c777@realsil.com.cn>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.29.40.150]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSm9uZXMsDQoNCkkgaGF2ZSBhIHF1ZXN0aW9uIGFib3V0IGRyaXZlcnMvbWZkL21mZC1jb3Jl
LmMgYW5kIG5lZWQgeW91ciBoZWxwLg0KVGhlIGRyaXZlciBpbiBkcml2ZXJzL21pc2MvY2FyZHJl
YWRlci9ydHN4X3Bjci5jIGNhbGwgJ21mZF9hZGRfZGV2aWNlcycgYW5kICdtZmRfcmVtb3ZlX2Rl
dmljZXMnIGluIHByb2JlIGFuZCByZW1vdmUgZnVuY3Rpb25zDQpCZWZvcmUgTGludXMgNS45LXJj
MSwgdGhlIHR3byBmdW5jdGlvbnMgY2FuIHJ1biBwcm9wZXJseSwgYnV0IGluIExpbnVzIDUuOS1y
YzEgd2hlbiBJIHVucGx1ZyB0aGUgY2FyZHJlYWRlciAnbWZkX3JlbW92ZV9kZXZpY2VzJyB3aWxs
IGxlYWQgdG8gYSBrZXJuZWwgYnVnIGxpa2UgYmVsb3c6DQoNCi0tLS0tLS0tLS0tLVsgY3V0IGhl
cmUgXS0tLS0tLS0tLS0tLQ0Ka2VybmVsIEJVRyBhdCBtbS9zbHViLmM6MzA0IQ0KaW52YWxpZCBv
cGNvZGU6IDAwMDAgWyMxXSBTTVAgUFRJDQpDUFU6IDAgUElEOiA3IENvbW06IGt3b3JrZXIvdTg6
MCBOb3QgdGFpbnRlZCA1LjguMCsgIzExDQpIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gTGF0aXR1
ZGUgRTU0NDAvMFJUMzZZLCBCSU9TIEEwNCAwMS8yMi8yMDE0DQpXb3JrcXVldWU6IGthY3BpX2hv
dHBsdWcgYWNwaV9ob3RwbHVnX3dvcmtfZm4NClJJUDogMDAxMDpfX3NsYWJfZnJlZSsweDFhYS8w
eDM1MA0KQ29kZTogMGYgMWYgNDQgMDAgMDAgZWIgYTUgNDEgZjcgNDYgMDggMDAgMGQgMjEgMDAg
MGYgODUgMTYgZmYgZmYgZmYgNGQgODUgZWQgMGYgODUgMGQgZmYgZmYgZmYgODAgNGQgYmIgODAg
NDUgMzEgYzAgZTkgNjAgZmYgZmYgZmYgPDBmPiAwYiA0OSAzYiA1YyAyNCAyOCA3NSBjNSA0OCA4
YiA0NSA4OCA0OSA4OSA0YyAyNCAyOCA0OSA4OSA0NCAyNA0KUlNQOiAwMDE4OmZmZmZiNjU4YzAw
NTdhMjAgRUZMQUdTOiAwMDAxMDI0Ng0KUkFYOiBmZmZmOTg4YTU0NmJmNWEwIFJCWDogMDAwMDAw
MDA4MDE1MDAxMSBSQ1g6IGZmZmY5ODhhNTQ2YmY1NDANClJEWDogZmZmZjk4OGE1NDZiZjU0MCBS
U0k6IGZmZmZlMzI3NDQ1MWFmYzAgUkRJOiBmZmZmOTg4YTZhMDQyODAwDQpSQlA6IGZmZmZiNjU4
YzAwNTdhYzAgUjA4OiAwMDAwMDAwMDAwMDAwMDAxIFIwOTogZmZmZmZmZmZhOTEzNmE1Mg0KUjEw
OiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAwMDAwMDAwMDAwMDAwMCBSMTI6IGZmZmZlMzI3NDQ1
MWFmYzANClIxMzogZmZmZjk4OGE1NDZiZjU0MCBSMTQ6IGZmZmY5ODhhNmEwNDI4MDAgUjE1OiBm
ZmZmOTg4YTU0NmJmNTQwDQpGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjk4OGE2
YWEwMDAwMCgwMDAwKSBrbmxHUzowMDAwMDAwMDAwMDAwMDAwDQpDUzogIDAwMTAgRFM6IDAwMDAg
RVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzDQpDUjI6IDAwMDA3ZjAzYmMwMDNkMDQgQ1Iz
OiAwMDAwMDAwMDk4NDBhMDAxIENSNDogMDAwMDAwMDAwMDE3MDZmMA0KQ2FsbCBUcmFjZToNCiA/
IF9fa2VybmZzX3JlbW92ZS5wYXJ0LjE4KzB4MTAxLzB4MWYwDQogPyBwbGF0Zm9ybV9kZXZpY2Vf
cmVsZWFzZSsweDIyLzB4NTANCiBrZnJlZSsweDM0Zi8weDM5MA0KID8ga2ZyZWUrMHgzNGYvMHgz
OTANCiBwbGF0Zm9ybV9kZXZpY2VfcmVsZWFzZSsweDIyLzB4NTANCiBkZXZpY2VfcmVsZWFzZSsw
eDJjLzB4ODANCiBrb2JqZWN0X3B1dCsweGFkLzB4MWMwDQogPyBkZXZpY2VfbGlua3NfZmx1c2hf
c3luY19saXN0KzB4ZTAvMHhlMA0KIGtsaXN0X2NoaWxkcmVuX3B1dCsweDFhLzB4MjANCiBrbGlz
dF9wcmV2KzB4YTYvMHgxMzANCiA/IG1mZF9jZWxsX2Rpc2FibGUrMHg1MC8weDUwDQogZGV2aWNl
X2Zvcl9lYWNoX2NoaWxkX3JldmVyc2UrMHg2MC8weDkwDQogbWZkX3JlbW92ZV9kZXZpY2VzKzB4
MzMvMHg1MA0KIHJ0c3hfcGNpX3JlbW92ZSsweDg1LzB4MTgwIFtydHN4X3BjaV0NCiBwY2lfZGV2
aWNlX3JlbW92ZSsweDNlLzB4YzANCiBkZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHhm
Yi8weDFjMA0KIGRldmljZV9yZWxlYXNlX2RyaXZlcisweDEyLzB4MjANCiBwY2lfc3RvcF9idXNf
ZGV2aWNlKzB4NjgvMHg5MA0KIHBjaV9zdG9wX2FuZF9yZW1vdmVfYnVzX2RldmljZSsweDEyLzB4
MjANCiB0cmltX3N0YWxlX2RldmljZXMrMHgxNjcvMHgxOTANCiB0cmltX3N0YWxlX2RldmljZXMr
MHhhOS8weDE5MA0KIGFjcGlwaHBfY2hlY2tfYnJpZGdlLnBhcnQuMTUrMHgxMDAvMHgxNDANCiBh
Y3BpcGhwX2NoZWNrX2hvc3RfYnJpZGdlKzB4OTgvMHhjMA0KIGFjcGlfcGNpX3Jvb3Rfc2Nhbl9k
ZXBlbmRlbnQrMHhlLzB4MjANCiBhY3BpX3NjYW5fYnVzX2NoZWNrKzB4M2YvMHhjMA0KIGFjcGlf
ZGV2aWNlX2hvdHBsdWcrMHgyYWYvMHg0YjANCiBhY3BpX2hvdHBsdWdfd29ya19mbisweDFlLzB4
MzANCiBwcm9jZXNzX29uZV93b3JrKzB4MjBjLzB4NDAwDQogd29ya2VyX3RocmVhZCsweDM0LzB4
NDAwDQogPyBwcm9jZXNzX29uZV93b3JrKzB4NDAwLzB4NDAwDQoga3RocmVhZCsweDEyNi8weDE0
MA0KID8ga3RocmVhZF9wYXJrKzB4OTAvMHg5MA0KIHJldF9mcm9tX2ZvcmsrMHgyMi8weDMwDQoN
CkFmdGVyIEkgcmV2ZXJ0IHRoZSBjb21taXQgNDY2YTYyZDc2NDJmMDJmMzZkMzdkOWIzMGMxOWE3
MjU1MzhhMDFjYShodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTI1NTEw
NiksICdtZmRfcmVtb3ZlX2RldmljZXMnIHdpbGwgcnVuIHdpdGhvdXQgYnVnLA0KRG8gSSB1c2Ug
J21mZF9hZGRfZGV2aWNlcycgYW5kICdtZmRfcmVtb3ZlX2RldmljZXMnIGluY29ycmVjdGx5IG9y
IHBvc3NpYmxlIGJ1ZyBpbiBkcml2ZXJzL21mZC9tZmQtY29yZS5jPyBJIGRvbid0IGtub3cgd2hh
dCdzIHdyb25nLCBzbyBJIG5lZWQgeW91ciBoZWxwLg0KSWYgeW91IG5lZWQgbW9yZSBpbmZvcm1h
dGlvbiBwbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoYW5rcw0KDQpSdWkgRmVuZw0K
