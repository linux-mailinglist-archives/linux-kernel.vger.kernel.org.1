Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA73A2ABE45
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgKIOLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:11:47 -0500
Received: from mail-eopbgr690100.outbound.protection.outlook.com ([40.107.69.100]:30622
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727826AbgKIOLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:11:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrnTpr0I/LRY/6d+g5iPM/cQF2FvgeICfrzDYfK+tUAbUlbssbt6Y2PIdA6nTRvZauMZmHW0M992fYs+lGQoP+VXz2DOytn8fOynlhgmIAJgOBx1YVcAXyLVmNZwN3kdKjMuSA098a4AanXMF/yBbN0VMtJZt1VHNyyG8EMl3g6OzY6Y4bEZn9xCwJ5hboxVpGftv0cgVdgDpvDXAorCFvgJjZ1qZ1M/f9Thrk+yuBJKx3UbW3nbKdx2lbNRFjTb/vM9MLbRoMo5ZaNRBHRkN4Zb2AhW85E9RLbJvN+noBxoIJO9ZIiuz04Q6Yi9b2xGes6D8ngjKc6A/oofYuUVfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMs5+c8mJJvvDYkQpY6nJZyo/SD39zpqNmu99So8Pi0=;
 b=JntzhjZhIiNJhPlhnlBPi3WexpKTBjGuexCnahwvd/A/j8Dd1cYukolMkfwyCBr9Kfxlq0u7jVBJOkDZRkw6vgcwEE5+JyBvHhCrRYApMC3RrQ44/4fOORG6zVIrh4tMlzucjsVDxbirJKYulbILNVD/bRo8BGSNUncu2Rnco/NDEGGpJKbMUFpmCwTpFvrbirIksBF2haBUG5Yl98xHzLc9Qfj7HQCXv6ExtgW079eNx/on/viRF/YQGd5KAPaNfANgVsVkIC2WGRg+kdf7EQOTROhXRa8lWRp052pRF6FIULe6MXrs+McX3XD1IwvTGHJ1ug7G6xqISxjnbav02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMs5+c8mJJvvDYkQpY6nJZyo/SD39zpqNmu99So8Pi0=;
 b=gPW1UTasARVKGmQFOZqqrlr/RYFvQGCGLo2NpJNAufRvfOOnei0kuOfUUEDwXUKC1F95aUr2ZaqvT++8pGS2MDMktbJhvGZRSDWBSNeCnZUYu81m/vYKVT0EtVvE6iiXmD1JVUzTCrnfKtoLroRiFujfHkOfAC4IN403jS6lykg=
Received: from MN2PR13MB3957.namprd13.prod.outlook.com (2603:10b6:208:263::11)
 by MN2PR13MB3104.namprd13.prod.outlook.com (2603:10b6:208:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13; Mon, 9 Nov
 2020 14:11:43 +0000
Received: from MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210]) by MN2PR13MB3957.namprd13.prod.outlook.com
 ([fe80::e989:f666:131a:e210%9]) with mapi id 15.20.3541.018; Mon, 9 Nov 2020
 14:11:43 +0000
From:   Trond Myklebust <trondmy@hammerspace.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "neilb@suse.de" <neilb@suse.de>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Thread-Topic: [PATCH rfc] workqueue: honour cond_resched() more effectively.
Thread-Index: AQHWtkPENGqm3GxOSkGvPzbAsELwtqm/cEoAgABhygCAAAMWgIAAAsyA
Date:   Mon, 9 Nov 2020 14:11:42 +0000
Message-ID: <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
         <20201109080038.GY2594@hirez.programming.kicks-ass.net>
         <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
         <20201109140141.GE7496@mtj.duckdns.org>
In-Reply-To: <20201109140141.GE7496@mtj.duckdns.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=hammerspace.com;
x-originating-ip: [68.36.133.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fb2490a-88be-46a2-0962-08d884b962a7
x-ms-traffictypediagnostic: MN2PR13MB3104:
x-microsoft-antispam-prvs: <MN2PR13MB3104CF67BE88860C1C1FE770B8EA0@MN2PR13MB3104.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A/nUV+eJfx+mUtoz9iZHU4VKsN7MYFrWPw8KHFQrUJjtpWJaRjiR6otplqYwK4cowQCrTY0WP7RiND3sYPLomXEHF794WwDvX9+wbprV2x5jCQGj7yllub34AQZFQPFbtqD7FBQXwepC/6woJTNRCLQtdWsbOh3ekx8cnZ9zyzCOa+fdlIK4rr4SCcSw1mkASvc63DdUEi7PgxNRGAuv+0g/Zr8gBYIQSHkLtOF3e5a5beUmUf1A63wmQZcCyAKYAaCyYER3w/u34AHgziaSmNKIuqKT0XeWk52896Q3CuKwduVBBYfcvcBNB26jVxF60LARG5f1Yn7+6kRQsbFZvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR13MB3957.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39830400003)(376002)(396003)(346002)(66556008)(6486002)(66476007)(66446008)(64756008)(66946007)(36756003)(2616005)(186003)(6916009)(54906003)(4326008)(478600001)(316002)(76116006)(91956017)(8676002)(2906002)(86362001)(8936002)(71200400001)(5660300002)(6512007)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2ot6iqe9bZj2+7i2VaPoEQjX/n1UC6bj4vFFPpy9WjbTxxId5bTq3rM7vSpkUNWoDXekdimTFmDmrpf31sryfTRpvmxlGbt/pKBho7o+eYG3/djE7F7Y8i3j0XqGSYHwnZyYhaQcOyoUDf9+mwOGa7JYuYdJZ+cAHMpkhXL8m2TlJgqYUDXzHhel60GIjbGIehI5BoZ2aGY5THSZ551+O+itle/IGE6bz4lp0syUaw/1DlZlQJ9LRueL57F994ja7mpa4uY2UE2QQGsYGznRtQEHpPSQQF+1JzR7KcZrmOJdw+Hv3xWBWnxF5ymiqTA70eCTvl7cQz9lmlcoLDjGIxtvErwvKWWrmwmUL7YhY/UCuqEEnhRYhSpT1NJXTE5mjQOKON25M1+lUA29zwJoJilkYLu+0Tivtt2duJvjWMexw80aqawK/UAs/bUVWnF7YGoKUyAIuIsG+oSRn67kfALtnsjyuBfTQSPA7naM53w9n6kQyp1SveNUJg7b6XqO6U62LGBj4DoFBPlWw5BG8SiKTPMLcSTRNEEBm202Yx7J/ZPWtTJeGw7meOJkzviq1zNAvyyXbdOHvpiGaBIwUoPdz15IOaus8cyorjrd0HFcuxQBCMeNDikoNGC0mZQ/X3J8LiF9KWl8k83vZIgHxA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE130F796232DD4998AF4CF4AA8A70BB@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR13MB3957.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb2490a-88be-46a2-0962-08d884b962a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 14:11:43.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ax+DnEnTklwW3RfRjLhANl2tNEgUXBFSYxptBjtKsmXzW8mGaB/+/6CHWCwfsJOrH7zidvHp9+i3QPR+OH/Msg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTA5IGF0IDA5OjAxIC0wNTAwLCB0akBrZXJuZWwub3JnIHdyb3RlOg0K
PiBIZWxsbywNCj4gDQo+IE9uIE1vbiwgTm92IDA5LCAyMDIwIGF0IDAxOjUwOjQwUE0gKzAwMDAs
IFRyb25kIE15a2xlYnVzdCB3cm90ZToNCj4gPiA+IEknbSB0aGlua2luZyB0aGUgcmVhbCBwcm9i
bGVtIGlzIHRoYXQgeW91J3JlIGFidXNpbmcgd29ya3F1ZXVlcy4NCj4gPiA+IEp1c3QNCj4gPiA+
IGRvbid0IHN0dWZmIHNvIG11Y2ggd29yayBpbnRvIGl0IHRoYXQgdGhpcyBiZWNvbWVzIGEgcHJv
YmxlbS4gT3INCj4gPiA+IHJhdGhlciwNCj4gPiA+IGlmIHlvdSBkbywgZG9uJ3QgbGllIHRvIGl0
IGFib3V0IGl0Lg0KPiA+IA0KPiA+IElmIHdlIGNhbid0IHVzZSB3b3JrcXVldWVzIHRvIGNhbGwg
aXB1dF9maW5hbCgpIG9uIGFuIGlub2RlLCB0aGVuDQo+ID4gd2hhdA0KPiA+IGlzIHRoZSBwb2lu
dCBvZiBoYXZpbmcgdGhlbSBhdCBhbGw/DQo+ID4gDQo+ID4gTmVpbCdzIHVzZSBjYXNlIGlzIHNp
bXBseSBhIGZpbGUgdGhhdCBoYXMgbWFuYWdlZCB0byBhY2N1bXVsYXRlIGENCj4gPiBzZXJpb3Vz
bHkgbGFyZ2UgcGFnZSBjYWNoZSwgYW5kIGlzIHRoZXJlZm9yZSB0YWtpbmcgYSBsb25nIHRpbWUg
dG8NCj4gPiBjb21wbGV0ZSB0aGUgY2FsbCB0byB0cnVuY2F0ZV9pbm9kZV9wYWdlc19maW5hbCgp
LiBBcmUgeW91IHNheWluZw0KPiA+IHdlDQo+ID4gaGF2ZSB0byBhbGxvY2F0ZSBhIGRlZGljYXRl
ZCB0aHJlYWQgZm9yIGV2ZXJ5IGNhc2Ugd2hlcmUgdGhpcw0KPiA+IGhhcHBlbnM/DQo+IA0KPiBJ
IHRoaW5rIHRoZSByaWdodCB0aGluZyB0byBkbyBoZXJlIGlzIHNldHRpbmcgQ1BVX0lOVEVOU0lW
RSBvciB1c2luZw0KPiBhbg0KPiB1bmJvdW5kIHdvcmtxdWV1ZS4gQ29uY3VycmVuY3kgY29udHJv
bGxlZCBwZXItY3B1IHdvcmtxdWV1ZSBpcw0KPiB1bmxpa2VseSB0bw0KPiBiZSBhIGdvb2QgZml0
IGlmIHRoZSB3b3JrIGNhbiBydW4gbG9uZyBlbm91Z2ggdG8gbmVlZCBjb25kX3Jlc2NoZWQoKS4N
Cj4gQmV0dGVyDQo+IHRvIGxldCB0aGUgc2NoZWR1bGVyIGhhbmRsZSBpdC4gTWFraW5nIHdvcmtx
dWV1ZSB3YXJuIGFnYWluc3QgbG9uZy0NCj4gcnVubmluZw0KPiBjb25jdXJyZW5jeSBtYW5hZ2Vk
IHBlci1jcHUgd29yayBpdGVtcyB3b3VsZCBiZSBncmVhdC4gSSdsbCBwdXQgdGhhdA0KPiBvbiBt
eQ0KPiB0b2RvIGxpc3QgYnV0IGlmIGFueW9uZSBpcyBpbnRlcmVzdGVkIHBsZWFzZSBiZSBteSBn
dWVzdC4NCj4gDQoNClRoYXQgbWVhbnMgY2hhbmdpbmcgYWxsIGZpbGVzeXN0ZW0gY29kZSB0byB1
c2UgY3B1LWludGVuc2l2ZSBxdWV1ZXMuIEFzDQpmYXIgYXMgSSBjYW4gdGVsbCwgdGhleSBhbGwg
dXNlIHdvcmtxdWV1ZXMgKG1vc3Qgb2YgdGhlbSB1c2luZyB0aGUNCnN0YW5kYXJkIHN5c3RlbSBx
dWV1ZSkgZm9yIGZwdXQoKSwgZHB1dCgpIGFuZC9vciBpcHV0KCkgY2FsbHMuDQoNCi0tIA0KVHJv
bmQgTXlrbGVidXN0DQpMaW51eCBORlMgY2xpZW50IG1haW50YWluZXIsIEhhbW1lcnNwYWNlDQp0
cm9uZC5teWtsZWJ1c3RAaGFtbWVyc3BhY2UuY29tDQoNCg0K
