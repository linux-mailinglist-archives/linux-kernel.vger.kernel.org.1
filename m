Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327682EB34F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbhAETGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:06:18 -0500
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:58592
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730718AbhAETGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:06:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVNUmUxLEtcQo1KItGlDbwu9WAPPDZ6+7LQKM1sr4skPX7RNfcIwUMfgrlJf58sfnEGMyVOsH8kZHKyqtIxoQIrdFqSKAl+J9llMHcqO/5Ug0lt9+jWS2jVQXw15lQI2P455ZLqMQyECFGG33S7Xc7upW1kjBcg3FfbegYR4DcTc5H4Oc5wj1WD1WDuit9BJPkTxdCSw/j07U28rHQflGYX1Y5E/Cw7b1EIAc/sgR2QGZCD39CejGafSMhcKVOTqoroKiujOTXynBevOX/ASQBGzqbvUxaPX5kXYDuV2NcuLYDNRyCMMGWvdzdJigZ3PcubUfpoQ+kig/PcJ4OgKqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvWu8nqRHZ7jZ5zNQQdD1xduH68d7/tx7XboVt2d53g=;
 b=oIkc0XdT0U+orhVVdfE+AX/5Kcqb/8YQ76z24GUTZ+ixmuQG8InsfbvAr4eVIW/dCGFyMgWWMBIbYnLxB5yWzKUJ6mFYENGydTQvHjvBnJkH0qUVzQdpDBs4Nzdq+EfGwWInX0WG/y1Ma6JLRDJYrEWTOcBKtACDlJns0+wi/trT05Krg3/aYcmEYdbcrOQgnzoXxaHqPKykmRwOvWmsQ9p/VUtNo92AirK0O/PA+dsbr08DpbGKA8LAL/SXnppg2pxk8abKhkFnBwN3ave2CpAlB4rf6P6SrhpUtSlX8nz37CQTmPQUd5ToRNX7AguYHoC/Eth8Unn0Wkcj7wkfbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvWu8nqRHZ7jZ5zNQQdD1xduH68d7/tx7XboVt2d53g=;
 b=BPcIjKlEs8hpgmsnkwCEpr7vwsb22PsX9cwX8/S+Tt21vj7n/k7//c6K8l0h5UwKJAhWl0/t6y1NDtmjlhWGSdDg0qRiDPPck0auX/Fx+coZRjVdeCobaGLL9oodAyqHifDhyojAFO5O8n1oiWzf7TgLupZiZVMghpAY6yfru84=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4246.namprd05.prod.outlook.com (2603:10b6:a02:f0::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4; Tue, 5 Jan
 2021 19:05:22 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 19:05:22 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Topic: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Index: AQHW4pRwZnSKvT4iE02cPjpfTbkFJKoX2VMAgAAC64CAAAyGAIAABYKAgAAGJYCAAAb4gIABZVoAgAAFh4A=
Date:   Tue, 5 Jan 2021 19:05:22 +0000
Message-ID: <BABCB1DE-C41E-4C3E-90D1-5893585FB68A@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
 <X/OCMalFYnDdGnch@redhat.com>
 <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
 <X/SzzjREaoR9u7Ua@redhat.com>
In-Reply-To: <X/SzzjREaoR9u7Ua@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8019dfb7-63a4-43f9-8115-08d8b1acd9ff
x-ms-traffictypediagnostic: BYAPR05MB4246:
x-microsoft-antispam-prvs: <BYAPR05MB42467A7A05E044C12C96AB7CD0D10@BYAPR05MB4246.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtuyyZu0/GSKNLb00UcdO/am8PLr5qtkgqRnZNMNyA+QlWI0ohG9gkFEHWc5bUyivbFBkBJk35gNUShtkATVgkGlKuAV3aJQ589fnZi5rrvWTndiBsAS8B4ZbyNqNwataNt/6yGQvYXRc6MdrNsf+i6yinUMSK1JGdN68tp7bEZWwxFR1B5le8BQFV0NqhLaxf1c14PuhDn5z3hd3P6Nuueh4xxuxwrGB5907MFnTWfStCaalkCyIW5RZJxmPNKfQfj8vigdBZLj4dcqQEIxUs/fgDT7mnWRXsoVdU4VqqdYAPJ5f17yfpubMQHSfcImE//Te/k9oZFI7Aeptd6LaJUo7PrK4eROPZjlsK7dXF2zmKQ6qi43MzvjsGMp0EmlPPw0NZzZu/LvD5xJc2hkiHwi5mzjhA2dn1Bd92TzpyfCpy6qFQqiSIyEE9MY63rC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(76116006)(66946007)(66556008)(64756008)(478600001)(8936002)(2906002)(66446008)(8676002)(66476007)(5660300002)(83380400001)(26005)(2616005)(7416002)(36756003)(6486002)(86362001)(53546011)(186003)(6506007)(71200400001)(6512007)(4326008)(316002)(33656002)(110136005)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aUxUWUlNOTBTUTRqNk11S1lEQ2JHa3laS0pZV3REemtVc2UrZjMzQ2pIOXFj?=
 =?utf-8?B?cGpxeUJDN1ZJV3ZDUE9tVmljVW85R2pmWTZjRXlUcHltWU5YNGdYZnI5d0Ji?=
 =?utf-8?B?aUtFRjl2dmwwYkhISzFRN1F3STg1amtrVjlzZkZjYmRUNWI1YU5RclF4cnM2?=
 =?utf-8?B?aWUwaldDQS9lNEt0NFFpZ01KOW1kUVdBS3BvOTNEUXBaSHlVZGxSVWRiODVh?=
 =?utf-8?B?cG5naVRDc3I0YWxnU0NqOTZ6ZW9YU3dqcVU1d1llS3ozZHZLZTl4TG5MOU9z?=
 =?utf-8?B?K2VoM2dsS2lkc1k1NlFvZVcvTTQ3TEU3Mm9lNmJ0NVNrZWFzSFJiTUxBWmRt?=
 =?utf-8?B?Z1EvZjJIVXY2dit4bldHYjlxelZRamxraGNIZjI2RWhzUTZNOUVTUFRuano2?=
 =?utf-8?B?amRiQndTNnFnbjdLZi9Vem9TcWdsWVNRVHFlVVdTUWFlTHdxVlNJSGwrUmJJ?=
 =?utf-8?B?TWdUZlpWQzZnbEZOY3ZiM0Q3WVhtY2NuOFJpVnFBRHdyaFRSS2g1bEt1SnZ6?=
 =?utf-8?B?MEMyajhrK0FCNXg1Q2c0a3YrMjVWSHMvaWJ3NW45RU94ajVHMm1tOTZ5bG9R?=
 =?utf-8?B?TjhzaGpCZm41dEsxNVNLR3NKWm5kZWRESWZEVW5zTGpNMkh2bTExckFqdnli?=
 =?utf-8?B?K3kwV1M3TFg1MzZHREZhZXNoRVZERnpGS1R2KzBWTHFReldSRzlHd1VYWWdq?=
 =?utf-8?B?dERvYXNlOFVWT2YyUGI3R2U3MWpxQy9NUzlCVUgwY3BzQlAvNnduWmlENWNv?=
 =?utf-8?B?SXNSeVJBaVQ3ZWtZdTBVK084RkRpYjZhSmR3UWFGTXJJUG9YYlVJMDdNeDM5?=
 =?utf-8?B?bnExQy8yd3ZIOE80eEF3eFV1WlU0Y0hpYVNFa1ZhcDVXTGR4WUFxajJMY0lR?=
 =?utf-8?B?MjJKRFFWcE1ObkVwZGM1OCtERDRpOEJIKzlhTEF6U2V0K2pqNHkzZHFGZ1M3?=
 =?utf-8?B?WUlCWUk3M1drY05TSUg5OTZkeGh5TFVkbXdjRm5rYldnMGdSY3ZSc0ZzUDF6?=
 =?utf-8?B?MUhsUWhLbDBRQ2llaEwrRDRyd1JhUW1PZUVkeld4SlEydHNFR09mU1ZkeVNV?=
 =?utf-8?B?NHN6WS9sQ3dLckJyY0JlVVd4My91QXltcU1BUWptWG8xSGc0dERtczgrSi82?=
 =?utf-8?B?WlVSNzFaUklFRTFMYnhBZkF4MkFFaGlRbjljSmpVTVhtOTNYVjRFWE9hKzFh?=
 =?utf-8?B?OG96bUlKOEFETGQxdW13aURCenJxZ1dla1dGdk53aWRLZXMyV2JNeFp5TUN5?=
 =?utf-8?B?TDBFMEhVRWYxVFVhTm9jRVJ5Z1FQSVlMbWtpSUhzS0RlMXhzdk0xZklSc0U3?=
 =?utf-8?Q?l1UWk8pfFKM4UHU3bYd8icDwW6RzYkrXVs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C7BA3A016FBC4428C19F114E683898D@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8019dfb7-63a4-43f9-8115-08d8b1acd9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 19:05:22.1697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j5R7fOvyEI93B331Kxosb6Zi/VKTXIzhZpYk2Vrjjc2v+mjmkq/rYpx+6gHQISN15R1VGgIpYxLYtHRDVl24FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4246
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNSwgMjAyMSwgYXQgMTA6NDUgQU0sIEFuZHJlYSBBcmNhbmdlbGkgPGFhcmNhbmdl
QHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBKYW4gMDQsIDIwMjEgYXQgMDk6MjY6
MzNQTSArMDAwMCwgTmFkYXYgQW1pdCB3cm90ZToNCj4+IEkgd291bGQgZmVlbCBtb3JlIGNvbWZv
cnRhYmxlIGlmIHlvdSBwcm92aWRlIHBhdGNoZXMgZm9yIHVmZmQtd3AuIElmIHlvdQ0KPj4gd2Fu
dCwgSSB3aWxsIGRvIGl0LCBidXQgSSByZXN0YXRlIHRoYXQgSSBkbyBub3QgZmVlbCBjb21mb3J0
YWJsZSB3aXRoIHRoaXMNCj4+IHNvbHV0aW9uICh3b3JyaWVkIGFzIGl0IHNlZW1zIGEgYml0IGFk
LWhvYyBhbmQgbWlnaHQgbGVhdmUgb3V0IGEgc2NlbmFyaW8NCj4+IHdlIGFsbCBtaXNzZWQgb3Ig
Y2F1c2UgYSBUTEIgc2hvb3Rkb3duIHN0b3JtKS4NCj4+IA0KPj4gQXMgZm9yIHNvZnQtZGlydHks
IEkgdGhvdWdodCB0aGF0IHlvdSBzYWlkIHRoYXQgeW91IGRvIG5vdCBzZWUgYSBiZXR0ZXINCj4+
IChiYWNrcG9ydGFibGUpIHNvbHV0aW9uIGZvciBzb2Z0LWRpcnR5LiBDb3JyZWN0IG1lIGlmIEkg
YW0gd3JvbmcuDQo+IA0KPiBJIHRoaW5rIHRoZXkgc2hvdWxkIHVzZSB0aGUgc2FtZSB0ZWNobmlx
dWUsIHNpbmNlIHRoZXkgZGVhbCB3aXRoIHRoZQ0KPiBleGFjdCBzYW1lIGNoYWxsZW5nZS4gSSB3
aWxsIHRyeSB0byBjbGVhbnVwIHRoZSBwYXRjaCBpbiB0aGUgbWVhbnRpbWUuDQo+IA0KPiBJIGNh
biBhbHNvIHRyeSB0byBkbyB0aGUgYWRkaXRpb25hbCBjbGVhbnVwcyB0byBjbGVhcl9yZWZzIHRv
DQo+IGVsaW1pbmF0ZSB0aGUgdGxiX2dhdGhlciBjb21wbGV0ZWx5IHNpbmNlIGl0IGRvZXNuJ3Qg
Z2F0aGVyIGFueSBwYWdlDQo+IGFuZCBpdCBoYXMgbm8gcG9pbnQgaW4gdXNpbmcgaXQuDQo+IA0K
Pj4gQW55aG93LCBJIHdpbGwgYWRkIHlvdXIgY29tbWVudHMgcmVnYXJkaW5nIHRoZSBzdGFsZSBU
TEIgd2luZG93IHRvIG1ha2UgdGhlDQo+PiBkZXNjcmlwdGlvbiBjbGVhcmVyLg0KPiANCj4gSGF2
aW5nIHRoZSBtbWFwX3dyaXRlX2xvY2sgc29sdXRpb24gYXMgYmFja3VwIHdvbid0IGh1cnQsIGJ1
dCBJIHRoaW5rDQo+IGl0J3Mgb25seSBmb3IgcGxhbkIgaWYgcGxhbkEgZG9lc24ndCB3b3JrIGFu
ZCB0aGUgb25seSBzdGFibGUgdHJlZQ0KPiB0aGF0IHdpbGwgaGF2ZSB0byBhcHBseSB0aGlzIGlz
IHY1LjkueC4gQWxsIHByZXZpb3VzIGRvbid0IG5lZWQgYW55DQo+IGNoYW5nZSBpbiB0aGlzIHJl
c3BlY3QuIFNvIHRoZXJlJ3Mgbm8gd29ycnkgb2YgcmVqZWN0cy4NCj4gDQo+IEl0IHdvcmtlZCBi
eSBsdWNrIHVudGlsIEF1ZyAyMDIwLCBidXQgaXQgZGlkIHNvIHJlbGlhYmx5IG9yIHNvbWVib2R5
DQo+IHdvdWxkIGhhdmUgbm90aWNlZCBhbHJlYWR5LiBBbmQgaXQncyBub3QgZXhwbG9pdGFibGUg
ZWl0aGVyLCBpdCBqdXN0DQo+IHdvcmtzIHN0YWJsZSwgYnV0IGl0IHdhcyBwcm9uZSB0byBicmVh
ayBpZiB0aGUga2VybmVsIGNoYW5nZWQgaW4gc29tZQ0KPiBvdGhlciB3YXksIGFuZCBpdCBldmVu
dHVhbGx5IGNoYW5nZWQgaW4gQXVnIDIwMjAgd2hlbiBhbiB1bnJlbGF0ZWQNCj4gcGF0Y2ggaGFw
cGVuZWQgdG8gdGhlIHJldXNlIGxvZ2ljLg0KPiANCj4gSWYgeW91IHdhbnQgdG8gbWFpbnRhaW4g
dGhlIG1tYXBfd3JpdGVfbG9jayBwYXRjaCBpZiB5b3UgY291bGQgZHJvcA0KPiB0aGUgcHJlc2Vy
dmVkX3dyaXRlIGFuZCBhZGp1c3QgdGhlIEZpeGVzIHRvIHRhcmdldCBBdWcgMjAyMCBpdCdkIGJl
DQo+IGlkZWFsLiBUaGUgdWZmZC13cCBuZWVkcyBhIGRpZmZlcmVudCBvcHRpbWl6YXRpb24gdGhh
dCBtYXliZSBQZXRlciBpcw0KPiBhbHJlYWR5IHdvcmtpbmcgb24gb3IgSSBjYW4gaW5jbHVkZSBp
biB0aGUgcGF0Y2hzZXQgZm9yIHRoaXMsIGJ1dA0KPiBkZWZpbml0ZWx5IGluIGEgc2VwYXJhdGUg
Y29tbWl0IGJlY2F1c2UgaXQncyBvcnRob2dvbmFsLg0KPiANCj4gSXQncyBncmVhdCB5b3Ugbm90
aWNlZCB0aGUgVy0+Uk8gdHJhbnNpdGlvbiBvZiB1bi13cHJvdGVjdCBzbyB3ZSBjYW4NCj4gb3B0
aW1pemUgdGhhdCB0b28gKGl0IHdpbGwgaGF2ZSBhIHBvc2l0aXZlIHJ1bnRpbWUgZWZmZWN0LCBp
dCdzIG5vdA0KPiBqdXN0IHRoZW9yZXRpY2FsIHNpbmNlIGl0J3Mgbm9ybWFsIHRvIHVud3Jwcm90
ZWN0IGEgaHVnZSByYW5nZSBvbmNlDQo+IHRoZSBwb3N0Y29weSBzbmFwc2hvdHRpbmcgb2YgdGhl
IHZpcnR1YWwgbWFjaGluZSBpcyBjb21wbGV0ZSksIEkgd2FzDQo+IHRoaW5raW5nIGF0IHRoZSBw
cmV2aW91cyBjYXNlIGRpc2N1c3NlZCBpbiB0aGUgb3RoZXIgdGhyZWFkLg0KDQpVbmRlcnN0b29k
LiBJIHdpbGwgc2VwYXJhdGUgaXQgdG8gYSBkaWZmZXJlbnQgcGF0Y2ggYW5kIHVzZSB5b3VyIHZl
cnNpb24uDQpJIGFtIHNvcnJ5IHRoYXQgSSBtaXNzZWQgUGV0ZXIgWHUgZmVlZGJhY2sgZm9yIHRo
YXQuIEFzIEkgdW5kZXJzdGFuZCB0aGF0DQp0aGlzIHdpbGwgbm90IGJlIGJhY2twb3J0ZWQsIEkg
d2lsbCBzZWUgaWYgSSBjYW4gZ2V0IHJpZCBvZiB0aGUgVExCIGZsdXNoDQphbmQgdGhlIGluY190
bGJfZmx1c2hfcGVuZGluZygpIGZvciB3cml0ZS11bnByb3RlY3QgY2FzZSBhcyB3ZWxsICh3aGlj
aA0KSSB0aGluayBJIG1lbnRpb25lZCBiZWZvcmUpLg0KDQo+IA0KPiBJIGp1c3QgZG9uJ3QgbGlr
ZSB0byBzbG93IGRvd24gYSBmZWF0dXJlIHJlcXVpcmVkIGluIHRoZSBmdXR1cmUgZm9yDQo+IGlt
cGxlbWVudGluZyBwb3N0Y29weSBsaXZlIHNuYXBzaG90dGluZyBvciBvdGhlciBzbmFwc2hvdHMg
dG8gdXNlcmxhbmQNCj4gcHJvY2Vzc2VzIChmb3IgdGhlIG5vbi1LVk0gY2FzZSwgYWxzbyB1bnBy
aXZpbGVnZWQgYnkgZGVmYXVsdCBpZiB1c2luZw0KPiBib3VuY2UgYnVmZmVycyB0byBmZWVkIHRo
ZSBzeXNjYWxscykgdGhhdCBjYW4gYmUgdXNlZCBieSBvcGVuIHNvdXJjZQ0KPiBoeXBlcnZpc29y
cyB0byBiZWF0IHByb3ByaWV0YXJ5IGh5cGVydmlzb3JzIGxpa2Ugdm13YXJlLg0KDQpPdWNoLCB0
aGF04oCZcyB1bmNhbGxlZCBmb3IuIEkgYW0gc3VyZSB0aGF0IHlvdSB1bmRlcnN0YW5kIHRoYXQg
SSBoYXZlIG5vDQpoaWRkZW4gYWdlbmRhIGFuZCB3ZSBhbGwgaGF2ZSB0aGUgc2FtZSBnb2FsLg0K
DQpSZWdhcmRzLA0KTmFkYXY=
