Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD7284633
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgJFGjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 02:39:47 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3971 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgJFGjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:39:47 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 807F7E12B1E4C3F9D4FF;
        Tue,  6 Oct 2020 14:39:45 +0800 (CST)
Received: from dggemi712-chm.china.huawei.com (10.3.20.111) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 6 Oct 2020 14:39:45 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi712-chm.china.huawei.com (10.3.20.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 6 Oct 2020 14:39:44 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Tue, 6 Oct 2020 14:39:44 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Andi Kleen <ak@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: RE: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
Thread-Topic: [PATCH] perf evlist: fix memory corruption for Kernel PMU event
Thread-Index: AQHWl+qFe9svqgT9AUqxYD+FeGRiAamC2SiAgADF+DCABao2gIAA25Pg
Date:   Tue, 6 Oct 2020 06:39:44 +0000
Message-ID: <41a3e45d558242f79f9e10a8d9ca92f1@hisilicon.com>
References: <20201001115729.27116-1-song.bao.hua@hisilicon.com>
 <20201001230653.GM50079@tassilo.jf.intel.com>
 <dc9c24dcc58d477fa7e9c1a2ea246791@hisilicon.com>
 <CAM9d7cjM262j4ixjayz+M1BqYDuiqRmrd9ifx++XBxT830ymRQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjM262j4ixjayz+M1BqYDuiqRmrd9ifx++XBxT830ymRQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.32]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIFtt
YWlsdG86bmFtaHl1bmdAa2VybmVsLm9yZ10NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciA2LCAy
MDIwIDI6MjYgUE0NCj4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcuYmFvLmh1
YUBoaXNpbGljb24uY29tPg0KPiBDYzogQW5kaSBLbGVlbiA8YWtAbGludXguaW50ZWwuY29tPjsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGludXhhcm0NCj4gPGxpbnV4YXJtQGh1YXdl
aS5jb20+OyBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBJbmdvIE1vbG5h
cg0KPiA8bWluZ29AcmVkaGF0LmNvbT47IEFybmFsZG8gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBr
ZXJuZWwub3JnPjsgTWFyaw0KPiBSdXRsYW5kIDxtYXJrLnJ1dGxhbmRAYXJtLmNvbT47IEFsZXhh
bmRlciBTaGlzaGtpbg0KPiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEpp
cmkgT2xzYSA8am9sc2FAcmVkaGF0LmNvbT47IEFkcmlhbg0KPiBIdW50ZXIgPGFkcmlhbi5odW50
ZXJAaW50ZWwuY29tPjsgQWxleGV5IEJ1ZGFua292DQo+IDxhbGV4ZXkuYnVkYW5rb3ZAbGludXgu
aW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwZXJmIGV2bGlzdDogZml4IG1lbW9y
eSBjb3JydXB0aW9uIGZvciBLZXJuZWwgUE1VIGV2ZW50DQo+IA0KPiBIZWxsbywNCj4gDQo+IE9u
IEZyaSwgT2N0IDIsIDIwMjAgYXQgMTI6MDIgUE0gU29uZyBCYW8gSHVhIChCYXJyeSBTb25nKQ0K
PiA8c29uZy5iYW8uaHVhQGhpc2lsaWNvbi5jb20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEFuZGkgS2xlZW4gW21h
aWx0bzpha0BsaW51eC5pbnRlbC5jb21dDQo+ID4gPiBTZW50OiBGcmlkYXksIE9jdG9iZXIgMiwg
MjAyMCAxMjowNyBQTQ0KPiA+ID4gVG86IFNvbmcgQmFvIEh1YSAoQmFycnkgU29uZykgPHNvbmcu
YmFvLmh1YUBoaXNpbGljb24uY29tPg0KPiA+ID4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IExpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgUGV0ZXINCj4gPiA+IFppamxz
dHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEluZ28gTW9sbmFyIDxtaW5nb0ByZWRoYXQuY29t
PjsNCj4gQXJuYWxkbw0KPiA+ID4gQ2FydmFsaG8gZGUgTWVsbyA8YWNtZUBrZXJuZWwub3JnPjsg
TWFyayBSdXRsYW5kDQo+ID4gPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBBbGV4YW5kZXIgU2hp
c2hraW4NCj4gPiA+IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBP
bHNhIDxqb2xzYUByZWRoYXQuY29tPjsNCj4gPiA+IE5hbWh5dW5nIEtpbSA8bmFtaHl1bmdAa2Vy
bmVsLm9yZz47IEFkcmlhbiBIdW50ZXINCj4gPiA+IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IEFsZXhleSBCdWRhbmtvdg0KPiA+ID4gPGFsZXhleS5idWRhbmtvdkBsaW51eC5pbnRlbC5jb20+
DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwZXJmIGV2bGlzdDogZml4IG1lbW9yeSBjb3Jy
dXB0aW9uIGZvciBLZXJuZWwgUE1VDQo+IGV2ZW50DQo+ID4gPg0KPiA+ID4gT24gRnJpLCBPY3Qg
MDIsIDIwMjAgYXQgMTI6NTc6MjlBTSArMTMwMCwgQmFycnkgU29uZyB3cm90ZToNCj4gPiA+ID4g
Q29tbWl0IDc3MzY2MjdiODY1ZCAoInBlcmYgc3RhdDogVXNlIGFmZmluaXR5IGZvciBjbG9zaW5n
IGZpbGUNCj4gPiA+ID4gZGVzY3JpcHRvcnMiKSB3aWxsIHVzZSBGRChldnNlbCwgY3B1LCB0aHJl
YWQpIHRvIHJlYWQgYW5kIHdyaXRlIGZpbGUNCj4gPiA+ID4gZGVzY3JpcHRvcnMgeHlhcnJheS4g
Rm9yIGEga2VybmVsIFBNVSBldmVudCwgdGhpcyBsZWFkcyB0byBzZXJpb3VzDQo+ID4gPiA+IG1l
bW9yeSBjb3JydXB0aW9uIGFuZCBwZXJmIGNyYXNoLg0KPiA+ID4gPiBJIGhhdmUgc2VlbiBldmxp
c3QtPmNvcmUuY3B1cy0+bnIgaXMgMSB3aGlsZSBldnNlbCBoYXMgY3B1cy0+bnIgd2l0aA0KPiA+
ID4gPiB0aGUgdG90YWwgbnVtYmVyIG9mIENQVXMuIHNvIHh5YXJyYXkgd2hpY2ggaXMgYWxsb2Nh
dGVkIGJ5DQo+ID4gPiA+IGV2bGlzdC0+Y29yZS5jcHVzLT5uciB3aWxsIGdldCBvdmVyZmxvdy4g
VGhpcyBsZWFkcyB0byB2YXJpb3VzDQo+ID4gPiA+IHNlZ21lbnRhdGlvbiBmYXVsdHMgaW4gcGVy
ZiB0b29sIGZvciBrZXJuZWwgUE1VIGV2ZW50cywgZWc6DQo+ID4gPiA+IC4vcGVyZiBzdGF0IC1l
IGJ1c19jeWNsZXMgIHNsZWVwIDENCj4gPiA+ID4gKioqIEVycm9yIGluIGAuL3BlcmYnOiBmcmVl
KCk6IGludmFsaWQgbmV4dCBzaXplIChmYXN0KToNCj4gPiA+ID4gMHgwMDAwMDAwMDQwMWU2Mzcw
ICoqKiBBYm9ydGVkIChjb3JlIGR1bXBlZCkNCj4gPiA+DQo+ID4gPiBUaGFua3MuDQo+ID4gPg0K
PiA+ID4gSSBiZWxpZXZlIHRoZXJlIGlzIGFscmVhZHkgYSBwYXRjaCBxdWV1ZWQgZm9yIHRoaXMu
DQo+ID4NCj4gPiBBbmRpLCB0aGFua3MhIENvdWxkIHlvdSBzaGFyZSB0aGUgbGluayBvciB0aGUg
Y29tbWl0IElEPyBJJ2QgbGlrZSB0byB0YWtlIGENCj4gbG9vayBhdCB0aGUgZml4Lg0KPiA+IEkg
Y291bGQgc3RpbGwgcmVwcm9kdWNlIHRoaXMgaXNzdWUgaW4gdGhlIGxhdGVzdCBsaW51cycgdHJl
ZSBhbmQgSSBkaWRuJ3QgZmluZCBhbnkNCj4gY29tbWl0DQo+ID4gcmVsYXRlZCB0byB0aGlzIGlz
c3VlIGluIGxpbnV4LW5leHQgYW5kIHRpcC9wZXJmL2NvcmUuDQo+IA0KPiBJIHRoaW5rIEFuZGkg
d2FzIHJlZmVycmluZyB0byB0aGlzIGRpc2N1c3Npb24gd2hpY2ggaXMgbm90IG1lcmdlZCB5ZXQ6
DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAwOTIyMDMxMzQ2LjE1MDUx
LTItbGl3ZWkzOTFAaHVhd2VpLmNvDQo+IG0vDQo+IA0KPiBJIHN1Z2dlc3RlZCBhIHBhdGNoIGF0
IHRoZSBlbmQuICBDYW4geW91IHBsZWFzZSB0cnkgaXQ/DQoNCkkgdHJpZWQgdGhlIHBhdGNoIHlv
dSBzdWdnZXN0ZWQuDQoNCmRpZmYgLS1naXQgYS90b29scy9saWIvcGVyZi9ldmxpc3QuYyBiL3Rv
b2xzL2xpYi9wZXJmL2V2bGlzdC5jDQppbmRleCAyMjA4NDQ0ZWNiNDQuLmNmY2RiZDdiZTA2NiAx
MDA2NDQNCi0tLSBhL3Rvb2xzL2xpYi9wZXJmL2V2bGlzdC5jDQorKysgYi90b29scy9saWIvcGVy
Zi9ldmxpc3QuYw0KQEAgLTQ1LDYgKzQ1LDkgQEAgc3RhdGljIHZvaWQgX19wZXJmX2V2bGlzdF9f
cHJvcGFnYXRlX21hcHMoc3RydWN0IHBlcmZfZXZsaXN0ICpldmxpc3QsDQogICAgICAgICBpZiAo
IWV2c2VsLT5vd25fY3B1cyB8fCBldmxpc3QtPmhhc191c2VyX2NwdXMpIHsNCiAgICAgICAgICAg
ICAgICAgcGVyZl9jcHVfbWFwX19wdXQoZXZzZWwtPmNwdXMpOw0KICAgICAgICAgICAgICAgIGV2
c2VsLT5jcHVzID0gcGVyZl9jcHVfbWFwX19nZXQoZXZsaXN0LT5jcHVzKTsNCisgICAgICAgfSBl
bHNlIGlmICghZXZzZWwtPnN5c3RlbV93aWRlICYmIHBlcmZfY3B1X21hcF9fZW1wdHkoZXZsaXN0
LT5jcHVzKSkgew0KKyAgICAgICAgICAgICAgIHBlcmZfY3B1X21hcF9fcHV0KGV2c2VsLT5jcHVz
KTsNCisgICAgICAgICAgICAgICBldnNlbC0+Y3B1cyA9IHBlcmZfY3B1X21hcF9fZ2V0KGV2bGlz
dC0+Y3B1cyk7DQogICAgICAgIH0gZWxzZSBpZiAoZXZzZWwtPmNwdXMgIT0gZXZzZWwtPm93bl9j
cHVzKSB7DQogICAgICAgICAgICAgICAgcGVyZl9jcHVfbWFwX19wdXQoZXZzZWwtPmNwdXMpOw0K
ICAgICAgICAgICAgICAgIGV2c2VsLT5jcHVzID0gcGVyZl9jcHVfbWFwX19nZXQoZXZzZWwtPm93
bl9jcHVzKTsNCg0KaXQgZGlkIGZpeCB0aGUgY3Jhc2ggSSBoYXZlIHNlZW4gb24gYXJtNjQuIEkn
ZCBwcmVmZXIgeW91IHB1dCB0aGUgYmVsb3cgZml4ZXMgdGFnIGluIHRoZSBjb21taXQgbG9nLiAN
CkZpeGVzOiA3NzM2NjI3Yjg2NWQgKCJwZXJmIHN0YXQ6IFVzZSBhZmZpbml0eSBmb3IgY2xvc2lu
ZyBmaWxlIGRlc2NyaXB0b3JzIikNClBlcmYgc3RhdCBiZWdhbiB0byBjcmFzaCBmcm9tIHY1LjQg
a2VybmVsLCBzbyB0aGUgZml4IHNob3VsZCBiZSBiYWNrcG9ydGVkIHRvIHN0YWJsZSB0cmVlcy4N
Cg0KVGhhbmtzDQpCYXJyeQ0K
