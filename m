Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53B52AC9EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 01:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731388AbgKJA5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 19:57:35 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:51370 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729451AbgKJA5e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 19:57:34 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 19:57:33 EST
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 0AA0nlM1095899;
        Tue, 10 Nov 2020 02:52:14 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 34qdcc03ua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 02:52:14 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Nov 2020 02:52:13 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Tue, 10 Nov 2020 02:52:13 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] fs/ntfs: remove unused varible attr_len
Thread-Topic: [PATCH] fs/ntfs: remove unused varible attr_len
Thread-Index: AQHWtaRhOGzDA6D7SEWtBoZryd8qhqm9v20AgAKrNgA=
Date:   Tue, 10 Nov 2020 00:52:13 +0000
Message-ID: <5814AA20-1544-4563-9244-BD40C37AB1D9@tuxera.com>
References: <1604822056-65430-1-git-send-email-alex.shi@linux.alibaba.com>
 <4194376f-898b-b602-81c3-210567712092@linux.alibaba.com>
In-Reply-To: <4194376f-898b-b602-81c3-210567712092@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.154.241.250]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4CD3B9CC6E8F9D4795C250A39DD84FA3@ex13.tuxera.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_15:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpDYW4geW91IGFsc28gcGxlYXNlIG1lcmdlIHRoaXMgb25lPyAgVGhhbmtz
IGEgbG90IGluIGFkdmFuY2UhDQoNCkFsZXgsIGFnYWluLCB0aGFuayB5b3UgZm9yIHRoZSBwYXRj
aCENCg0KQmVzdCByZWdhcmRzLA0KDQoJQW50b24NCg0KPiBPbiA4IE5vdiAyMDIwLCBhdCAwODow
NiwgQWxleCBTaGkgPGFsZXguc2hpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gRnJvbTog
QWxleCBTaGkgPGFsZXguc2hpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBEYXRlOiBTdW4sIDggTm92
IDIwMjAgMTU6NTI6MzIgKzA4MDANCj4gU3ViamVjdDogW1BBVENIXSBmcy9udGZzOiByZW1vdmUg
dW51c2VkIHZhcmlibGUgYXR0cl9sZW4NCj4gDQo+IFRoaXMgdmFyaWJsZSBpc24ndCB1c2VkIGFu
eW1vcmUsIHJlbW92ZSBpdCB0byBza2lwIFc9MSB3YXJuaW5nOg0KPiBmcy9udGZzL2lub2RlLmM6
MjM1MDo2OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhhdHRyX2xlbuKAmSBzZXQgYnV0IG5vdCB1c2Vk
DQo+IFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxl
eCBTaGkgPGFsZXguc2hpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBBY2tlZC1ieTogQW50b24gQWx0
YXBhcm1ha292IDxhbnRvbkB0dXhlcmEuY29tPg0KPiAtLS0NCj4gZnMvbnRmcy9pbm9kZS5jIHwg
MiAtLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9mcy9udGZzL2lub2RlLmMgYi9mcy9udGZzL2lub2RlLmMNCj4gaW5kZXggY2FmNTYzOTgxNTMy
Li5mN2U0Y2JjMjZlYWYgMTAwNjQ0DQo+IC0tLSBhL2ZzL250ZnMvaW5vZGUuYw0KPiArKysgYi9m
cy9udGZzL2lub2RlLmMNCj4gQEAgLTIzNDcsNyArMjM0Nyw2IEBAIGludCBudGZzX3RydW5jYXRl
KHN0cnVjdCBpbm9kZSAqdmkpDQo+IAlBVFRSX1JFQ09SRCAqYTsNCj4gCWNvbnN0IGNoYXIgKnRl
ID0gIiAgTGVhdmluZyBmaWxlIGxlbmd0aCBvdXQgb2Ygc3luYyB3aXRoIGlfc2l6ZS4iOw0KPiAJ
aW50IGVyciwgbXBfc2l6ZSwgc2l6ZV9jaGFuZ2UsIGFsbG9jX2NoYW5nZTsNCj4gLQl1MzIgYXR0
cl9sZW47DQo+IA0KPiAJbnRmc19kZWJ1ZygiRW50ZXJpbmcgZm9yIGlub2RlIDB4JWx4LiIsIHZp
LT5pX2lubyk7DQo+IAlCVUdfT04oTklub0F0dHIobmkpKTsNCj4gQEAgLTI3MjEsNyArMjcyMCw2
IEBAIGludCBudGZzX3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqdmkpDQo+IAkgKiB0aGlzIGNhbm5v
dCBmYWlsIHNpbmNlIHdlIGFyZSBtYWtpbmcgdGhlIGF0dHJpYnV0ZSBzbWFsbGVyIHRodXMgYnkN
Cj4gCSAqIGRlZmluaXRpb24gdGhlcmUgaXMgZW5vdWdoIHNwYWNlIHRvIGRvIHNvLg0KPiAJICov
DQo+IC0JYXR0cl9sZW4gPSBsZTMyX3RvX2NwdShhLT5sZW5ndGgpOw0KPiAJZXJyID0gbnRmc19h
dHRyX3JlY29yZF9yZXNpemUobSwgYSwgbXBfc2l6ZSArDQo+IAkJCWxlMTZfdG9fY3B1KGEtPmRh
dGEubm9uX3Jlc2lkZW50Lm1hcHBpbmdfcGFpcnNfb2Zmc2V0KSk7DQo+IAlCVUdfT04oZXJyKTsN
Cj4gLS0gDQo+IDEuOC4zLjENCj4gDQoNCg0KLS0gDQpBbnRvbiBBbHRhcGFybWFrb3YgPGFudG9u
IGF0IHR1eGVyYS5jb20+IChyZXBsYWNlIGF0IHdpdGggQCkNCkxlYWQgaW4gRmlsZSBTeXN0ZW0g
RGV2ZWxvcG1lbnQsIFR1eGVyYSBJbmMuLCBodHRwOi8vd3d3LnR1eGVyYS5jb20vDQpMaW51eCBO
VEZTIG1haW50YWluZXINCg0K
