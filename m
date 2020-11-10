Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CE12ACA09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 02:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731019AbgKJBHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 20:07:50 -0500
Received: from mgw-01.mpynet.fi ([82.197.21.90]:52812 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJBHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:07:49 -0500
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.42/8.16.0.42) with SMTP id 0AA0nlLx095899;
        Tue, 10 Nov 2020 02:49:47 +0200
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 34qdcc03t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 02:49:46 +0200
Received: from tuxera-exch.ad.tuxera.com (10.20.48.11) by
 tuxera-exch.ad.tuxera.com (10.20.48.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 10 Nov 2020 02:49:46 +0200
Received: from tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789]) by
 tuxera-exch.ad.tuxera.com ([fe80::552a:f9f0:68c3:d789%12]) with mapi id
 15.00.1497.006; Tue, 10 Nov 2020 02:49:46 +0200
From:   Anton Altaparmakov <anton@tuxera.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Alex Shi <alex.shi@linux.alibaba.com>
Subject: Re: [PATCH] fs/ntfs: remove unused varibles
Thread-Topic: [PATCH] fs/ntfs: remove unused varibles
Thread-Index: AQHWtaIm1teE4V4Bh0iArr/N5UYoyqnAafiA
Date:   Tue, 10 Nov 2020 00:49:45 +0000
Message-ID: <D70B90D4-F07D-4B20-ABBF-10A8F9833E9C@tuxera.com>
References: <1604821092-54631-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1604821092-54631-1-git-send-email-alex.shi@linux.alibaba.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [109.154.241.250]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E71A9607C268FC43A7DF0DA176E08E81@ex13.tuxera.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-09_15:2020-11-05,2020-11-09 signatures=0
X-Proofpoint-Spam-Details: rule=mpy_notspam policy=mpy score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=916 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100004
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkFuZHJldywgcGxlYXNlIGNhbiB5b3UgbWVyZ2UgdGhpcz8gIFRoYW5rcyBhIGxvdCBp
biBhZHZhbmNlIQ0KDQpBbGV4LCB0aGFuayB5b3UgZm9yIHRoZSBwYXRjaCENCg0KQmVzdCByZWdh
cmRzLA0KDQoJQW50b24NCg0KPiBPbiA4IE5vdiAyMDIwLCBhdCAwNzozOCwgQWxleCBTaGkgPGFs
ZXguc2hpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToNCj4gDQo+IFdlIGFjdHVhbGx5IGRvbid0
IHVzZSB0aGVzZSB2YXJpYmxlcywgc28gcmVtb3ZlIHRoZW0gdG8gYXZvaWQgZ2NjIHdhcm5pbmc6
DQo+IGZzL250ZnMvZmlsZS5jOjMyNjoxNDogd2FybmluZzogdmFyaWFibGUg4oCYYmFzZV9uaeKA
mSBzZXQgYnV0IG5vdCB1c2VkDQo+IFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPiBmcy9u
dGZzL2xvZ2ZpbGUuYzo0ODE6MjE6IHdhcm5pbmc6IHZhcmlhYmxlIOKAmGxvZ19wYWdlX21hc2vi
gJkgc2V0IGJ1dCBub3QNCj4gdXNlZCBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IEFsZXggU2hpIDxhbGV4LnNoaUBsaW51eC5hbGliYWJhLmNvbT4NCj4g
QWNrZWQtYnk6IEFudG9uIEFsdGFwYXJtYWtvdiA8YW50b25AdHV4ZXJhLmNvbT4gDQo+IENjOiBs
aW51eC1udGZzLWRldkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQgDQo+IENjOiBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnIA0KPiAtLS0NCj4gZnMvbnRmcy9maWxlLmMgICAgfCA1ICstLS0tDQo+
IGZzL250ZnMvbG9nZmlsZS5jIHwgMyArLS0NCj4gMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvbnRmcy9maWxlLmMg
Yi9mcy9udGZzL2ZpbGUuYw0KPiBpbmRleCBmNDI5NjdiNzM4ZWIuLmU1YWFiMjY1ZGZmMSAxMDA2
NDQNCj4gLS0tIGEvZnMvbnRmcy9maWxlLmMNCj4gKysrIGIvZnMvbnRmcy9maWxlLmMNCj4gQEAg
LTMyMyw3ICszMjMsNyBAQCBzdGF0aWMgc3NpemVfdCBudGZzX3ByZXBhcmVfZmlsZV9mb3Jfd3Jp
dGUoc3RydWN0IGtpb2NiICppb2NiLA0KPiAJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gCXN0cnVj
dCBmaWxlICpmaWxlID0gaW9jYi0+a2lfZmlscDsNCj4gCXN0cnVjdCBpbm9kZSAqdmkgPSBmaWxl
X2lub2RlKGZpbGUpOw0KPiAtCW50ZnNfaW5vZGUgKmJhc2VfbmksICpuaSA9IE5URlNfSSh2aSk7
DQo+ICsJbnRmc19pbm9kZSAqbmkgPSBOVEZTX0kodmkpOw0KPiAJbnRmc192b2x1bWUgKnZvbCA9
IG5pLT52b2w7DQo+IA0KPiAJbnRmc19kZWJ1ZygiRW50ZXJpbmcgZm9yIGlfaW5vIDB4JWx4LCBh
dHRyaWJ1dGUgdHlwZSAweCV4LCBwb3MgIg0KPiBAQCAtMzY1LDkgKzM2NSw2IEBAIHN0YXRpYyBz
c2l6ZV90IG50ZnNfcHJlcGFyZV9maWxlX2Zvcl93cml0ZShzdHJ1Y3Qga2lvY2IgKmlvY2IsDQo+
IAkJZXJyID0gLUVPUE5PVFNVUFA7DQo+IAkJZ290byBvdXQ7DQo+IAl9DQo+IC0JYmFzZV9uaSA9
IG5pOw0KPiAtCWlmIChOSW5vQXR0cihuaSkpDQo+IC0JCWJhc2VfbmkgPSBuaS0+ZXh0LmJhc2Vf
bnRmc19pbm87DQo+IAllcnIgPSBmaWxlX3JlbW92ZV9wcml2cyhmaWxlKTsNCj4gCWlmICh1bmxp
a2VseShlcnIpKQ0KPiAJCWdvdG8gb3V0Ow0KPiBkaWZmIC0tZ2l0IGEvZnMvbnRmcy9sb2dmaWxl
LmMgYi9mcy9udGZzL2xvZ2ZpbGUuYw0KPiBpbmRleCBhMGM0MGYxYmU3YWMuLmJjMWJmMjE3YjM4
ZSAxMDA2NDQNCj4gLS0tIGEvZnMvbnRmcy9sb2dmaWxlLmMNCj4gKysrIGIvZnMvbnRmcy9sb2dm
aWxlLmMNCj4gQEAgLTQ3OCw3ICs0NzgsNyBAQCBib29sIG50ZnNfY2hlY2tfbG9nZmlsZShzdHJ1
Y3QgaW5vZGUgKmxvZ192aSwgUkVTVEFSVF9QQUdFX0hFQURFUiAqKnJwKQ0KPiAJdTggKmthZGRy
ID0gTlVMTDsNCj4gCVJFU1RBUlRfUEFHRV9IRUFERVIgKnJzdHIxX3BoID0gTlVMTDsNCj4gCVJF
U1RBUlRfUEFHRV9IRUFERVIgKnJzdHIyX3BoID0gTlVMTDsNCj4gLQlpbnQgbG9nX3BhZ2Vfc2l6
ZSwgbG9nX3BhZ2VfbWFzaywgZXJyOw0KPiArCWludCBsb2dfcGFnZV9zaXplLCBlcnI7DQo+IAli
b29sIGxvZ2ZpbGVfaXNfZW1wdHkgPSB0cnVlOw0KPiAJdTggbG9nX3BhZ2VfYml0czsNCj4gDQo+
IEBAIC01MDEsNyArNTAxLDYgQEAgYm9vbCBudGZzX2NoZWNrX2xvZ2ZpbGUoc3RydWN0IGlub2Rl
ICpsb2dfdmksIFJFU1RBUlRfUEFHRV9IRUFERVIgKipycCkNCj4gCQlsb2dfcGFnZV9zaXplID0g
RGVmYXVsdExvZ1BhZ2VTaXplOw0KPiAJZWxzZQ0KPiAJCWxvZ19wYWdlX3NpemUgPSBQQUdFX1NJ
WkU7DQo+IC0JbG9nX3BhZ2VfbWFzayA9IGxvZ19wYWdlX3NpemUgLSAxOw0KPiAJLyoNCj4gCSAq
IFVzZSBudGZzX2ZmcygpIGluc3RlYWQgb2YgZmZzKCkgdG8gZW5hYmxlIHRoZSBjb21waWxlciB0
bw0KPiAJICogb3B0aW1pemUgbG9nX3BhZ2Vfc2l6ZSBhbmQgbG9nX3BhZ2VfYml0cyBpbnRvIGNv
bnN0YW50cy4NCj4gLS0gDQo+IDEuOC4zLjENCj4gDQoNCg0KLS0gDQpBbnRvbiBBbHRhcGFybWFr
b3YgPGFudG9uIGF0IHR1eGVyYS5jb20+IChyZXBsYWNlIGF0IHdpdGggQCkNCkxlYWQgaW4gRmls
ZSBTeXN0ZW0gRGV2ZWxvcG1lbnQsIFR1eGVyYSBJbmMuLCBodHRwOi8vd3d3LnR1eGVyYS5jb20v
DQpMaW51eCBOVEZTIG1haW50YWluZXINCg0K
