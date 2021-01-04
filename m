Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EC12E9F83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 22:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbhADV11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 16:27:27 -0500
Received: from mail-dm6nam08on2055.outbound.protection.outlook.com ([40.107.102.55]:59745
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726463AbhADV11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 16:27:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOPTBYz21kCmf3beDGSFwj2sLhbpAEmxLId4qPsSGjnhfsM91nsRTyHGmyLEowfkjyeCdtkifonpjG0HILGaFKumEr+nXFYze0dicn53qGV5QJB5W12pW7OHoACkxT4q22c1+UloV2gqRTHKJZuQtgjtTXCC4n+Lgqr6TqqgsxW4DTbooqFbcUXE5G6J5WTi6Fb/2eb6Frq5OLPhMEBKeiceiVskDQULEPP6jEGUKvKbLLK35Y46MUTqoqe7di6RTibrFMEGLICEzpYk4wRpZSvbg1CTMPhFJJ1U5xTizCuCrPWDB39T/hZh8GZLU3rjunCCeLBpaVGNGcfAo+WfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPoBjlrPvvycdC5hNFgndy96uE459hrRWJ3Vai8+xCE=;
 b=DOaxH+T4F1yAFSUdFGoCuHRpQYOospMVebdN7ziIlYecm5XKZ9/Mu9Gx6hYSM7tVZGFht/Zh0a1iqcGjiqvwpPqE9thUtGLbCPusnsjAwiVgEM7FaqjYU+aSKy0p/jLSAa1kklTB3t8jeC66BLv1kDsWCTlKq/qIFwFSf2fX6nW6vw2piAwXGL1zEAJRowcCTSbHx8ULj2xm+0gbQ31HOSEyTdiSTnqRM8MtmZRvbOE5MCKfnZhCH/gqFMq3Boe1Tr9LkmFXf3O3EHyXO6rVIKlY37IjpaDNbZLjXswa30oVW55ggk6sBj85I9BpHrK14wCIIbr1BEwqlgPo0hnI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPoBjlrPvvycdC5hNFgndy96uE459hrRWJ3Vai8+xCE=;
 b=NaG2Xtt7nYW04NvCG3nRpIpG5OUUJNuT8mbtQgxs/1sENM5EJBeOT0FrCy+FwikfRyYdfIggXX+LMYbTb5Y5W9c4UMAToM9z6AcixCqILX3cqZ8Bth/5zcs4Ee9iOGtrVWoy9J8CGjkq2bCoPJAK9Im3mMErhg0DoxlnH2ivXuI=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BY3PR05MB7924.namprd05.prod.outlook.com (2603:10b6:a03:36a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.3; Mon, 4 Jan
 2021 21:26:34 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::d421:f99:8921:1ee7%6]) with mapi id 15.20.3742.006; Mon, 4 Jan 2021
 21:26:33 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>, Mel Gorman <mgorman@suse.de>
Subject: Re: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Topic: [RFC PATCH v2 1/2] mm/userfaultfd: fix memory corruption due to
 writeprotect
Thread-Index: AQHW4pRwZnSKvT4iE02cPjpfTbkFJKoX2VMAgAAC64CAAAyGAIAABYKAgAAGJYCAAAb4gA==
Date:   Mon, 4 Jan 2021 21:26:33 +0000
Message-ID: <2844ACC1-8908-494C-B411-3C69B27A1730@vmware.com>
References: <20201225092529.3228466-1-namit@vmware.com>
 <20201225092529.3228466-2-namit@vmware.com>
 <20210104122227.GL3021@hirez.programming.kicks-ass.net>
 <X/NrdnoDHgFd0Ku1@redhat.com>
 <A7AC77D2-6901-4225-911B-EDBF013DCA42@vmware.com>
 <X/N4aqRgyxffhMSs@redhat.com>
 <73EE9007-65AF-4416-9930-D992C74447A9@vmware.com>
 <X/OCMalFYnDdGnch@redhat.com>
In-Reply-To: <X/OCMalFYnDdGnch@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=vmware.com;
x-originating-ip: [24.6.216.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e684665-e9fc-470e-2854-08d8b0f7691c
x-ms-traffictypediagnostic: BY3PR05MB7924:
x-microsoft-antispam-prvs: <BY3PR05MB79243B68382B52252F63921DD0D20@BY3PR05MB7924.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nFn5e5moqp0lAwPyqN+zsamrjtBv/T0JW//CUFnKPzocFyok0dR68Fto3UoOz5nCJvYtjOyxo5fm4+ohraH3KYzdUZjYwHLR8gNqno3w8n+CTt98NC4x02JxD4jKZCyvJvx+xDIJPcUA3LTJIw0BPkUulodfLRT6o1JRJuOvMcr1vKu49edbU0V//rfctwe/BXAEN72vWgnEBvChOowRhlcI/5EN+TyBjucz6QYv1NYoscV+P1bpoakE/YrMtBPuML87KbBBIdFaRCQGDxAbBxiTOiV6GAxzqGzuzDXHRSc06kmbh3mVEbWX06M2Jy0yAVqpi+jnkNAs810EaPzhcaitkAKql3LSgAVJzoSQ/h0vN3Z9ha+z50kC3D46hcsly+EaQ9M3jLE463wf7y5Mp0H/HgyctwM5AlesioYCSBJtxr6/FITvdk9fj+LSKQVv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(66946007)(76116006)(54906003)(6486002)(8936002)(66446008)(66556008)(64756008)(66476007)(86362001)(33656002)(316002)(5660300002)(36756003)(4326008)(8676002)(71200400001)(2616005)(26005)(478600001)(7416002)(53546011)(2906002)(6512007)(6916009)(186003)(6506007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SW9XOG5NNGhsYTdSNHpubk00azljbEo5R1FTWGxRVUVVeHp4S21VbGIzdUFF?=
 =?utf-8?B?c1ZRam4xbVpwK0pUbnNzTVJLWXpTTXIra0ExbStmSmFOTUR5Wi9YYUR5Y0w0?=
 =?utf-8?B?Q1lhYkU3emVwVmVxdmdNMjlMZU12SDRzOXpoZ3ZQK2hsNDhENVpid1JJNDBk?=
 =?utf-8?B?cVd0NzdURlZCaEFiM1d3L3FpM3pBekxPcUhReUtBai9QZVZOZXpjNkV3VE1L?=
 =?utf-8?B?ZGxNcVBWN01pZ3pCWXJmOVpRSW15UFphWE5WeStzQzJjUGVDT05leFhsbXQy?=
 =?utf-8?B?ckJPNHBaNXFuK2M5RVVUZ04xcEdjNHlpV2RiNm9CaFRLRDFwZjB0SkdBeWNp?=
 =?utf-8?B?Ynp2djdjREl0V0JBSWR1WVRBRHk2WENwVTh2cE5DK1lKK2pZRmExZWFmY1po?=
 =?utf-8?B?THl0YnVsd3JzT3FKOW90aUl4Y3QvUFZhdVlSbGdGWWpRNlBaVTI2Zk9SQU5O?=
 =?utf-8?B?SVFwNXZZdTNVUC8ycGhTd2puaU1YVHc0UTB0OGE4eE9ZU2VFZ3pUeFhpekVT?=
 =?utf-8?B?MElOTXVIc0pyK210NUs5cFZnNUlqK29Bdm5qY3d5L3BIVWRHMVVQc0xjQTdj?=
 =?utf-8?B?NUw0dllWRFJRRmd0TkxTMWR3b2hIUWZ5V2N0bDV4R1ZpR1Y2emcvbWtWRDN5?=
 =?utf-8?B?MkcvbXBNeDAwaWI2TEwzdU1hZDdQTUM2SmFPOStOeU9MZTVmQWtCTStVWVp5?=
 =?utf-8?B?cy9IMlBTQkJ3d292cDdHTTVIMmNUTW1OMmJmN3ZkZ1FUelIzZEtGQ3dwNXhy?=
 =?utf-8?B?eXFDWmNhMDdxNzNhalR3dFZ5Sk81M2hvZm5XVEN0K1oveGIvZ2R6LytEOCtR?=
 =?utf-8?B?Z1ZQV0xnWWdYejJ0cWFLWW9WRnh4T3EzOVQzYmdQcm1EK0gycnJyUVJ1ZTRl?=
 =?utf-8?B?TThKRy81V3ltaUVWQUJTbjF5eTJlblJsRG1VVkgxWjloQjhCS1NFcHZCWHZC?=
 =?utf-8?B?MXBTVzVHU0c0VjFHWUJWbGNxUkhaWkxqSWd0Q2pYQ2JOSWU5YVA3T1VKem92?=
 =?utf-8?B?L3h3UjJUd3JaQmdtT0szakYzOUNqNGx5NGpTNm5oWFhxc1QydnFVUFFKekoz?=
 =?utf-8?B?N01mdm9UWXd4VzRKMXcwNitJWGsvbkpvYkRTcUljR1ROcExpTlJCbXJiZEhn?=
 =?utf-8?B?MG5XTVlhWUdoVDUzd0JibU05cTRlTUhtdEZFcGFTZkNHS3lrdENNaDNzUHN0?=
 =?utf-8?B?TE43a2VSeHFRZ09uRkJYZFF0OE4zOHRRM1pMMFNRL2U4VTJIc3lRei9YYy9D?=
 =?utf-8?B?YzF2cGxwY3Y4eGd5alJtUzV2RDhiZU1uandJVUd2a2MwMHhHZGlLKzJEc2I2?=
 =?utf-8?Q?0ffF7KT2sPUFShua4GZSTJokQ/56UDIzh0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <06AC1DDE73D55149A4EA4663635D852F@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4776.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e684665-e9fc-470e-2854-08d8b0f7691c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 21:26:33.8809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHaUPWu1k6HfO3k/eU8flIXAPIpTBtQA0EBmRYU5NLzBr7zsQXv8EJt1t09OidAA1OELYstGQTF+68xXVVy2QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR05MB7924
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBKYW4gNCwgMjAyMSwgYXQgMTowMSBQTSwgQW5kcmVhIEFyY2FuZ2VsaSA8YWFyY2FuZ2VA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBNb24sIEphbiAwNCwgMjAyMSBhdCAwODozOToz
N1BNICswMDAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+IE9uIEphbiA0LCAyMDIxLCBhdCAxMjox
OSBQTSwgQW5kcmVhIEFyY2FuZ2VsaSA8YWFyY2FuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4g
DQo+Pj4gT24gTW9uLCBKYW4gMDQsIDIwMjEgYXQgMDc6MzU6MDZQTSArMDAwMCwgTmFkYXYgQW1p
dCB3cm90ZToNCj4+Pj4+IE9uIEphbiA0LCAyMDIxLCBhdCAxMToyNCBBTSwgQW5kcmVhIEFyY2Fu
Z2VsaSA8YWFyY2FuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IEhlbGxvLA0K
Pj4+Pj4gDQo+Pj4+PiBPbiBNb24sIEphbiAwNCwgMjAyMSBhdCAwMToyMjoyN1BNICswMTAwLCBQ
ZXRlciBaaWpsc3RyYSB3cm90ZToNCj4+Pj4+PiBPbiBGcmksIERlYyAyNSwgMjAyMCBhdCAwMToy
NToyOEFNIC0wODAwLCBOYWRhdiBBbWl0IHdyb3RlOg0KPj4+Pj4+IA0KPj4+Pj4+PiBUaGUgc2Nl
bmFyaW8gdGhhdCBoYXBwZW5zIGluIHNlbGZ0ZXN0cy92bS91c2VyZmF1bHRmZCBpcyBhcyBmb2xs
b3dzOg0KPj4+Pj4+PiANCj4+Pj4+Pj4gY3B1MAkJCQljcHUxCQkJY3B1Mg0KPj4+Pj4+PiAtLS0t
CQkJCS0tLS0JCQktLS0tDQo+Pj4+Pj4+IAkJCQkJCQlbIFdyaXRhYmxlIFBURQ0KPj4+Pj4+PiAJ
CQkJCQkJICBjYWNoZWQgaW4gVExCIF0NCj4+Pj4+Pj4gdXNlcmZhdWx0ZmRfd3JpdGVwcm90ZWN0
KCkNCj4+Pj4+Pj4gWyB3cml0ZS0qdW5wcm90ZWN0KiBdDQo+Pj4+Pj4+IG13cml0ZXByb3RlY3Rf
cmFuZ2UoKQ0KPj4+Pj4+PiBtbWFwX3JlYWRfbG9jaygpDQo+Pj4+Pj4+IGNoYW5nZV9wcm90ZWN0
aW9uKCkNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IGNoYW5nZV9wcm90ZWN0aW9uX3JhbmdlKCkNCj4+Pj4+
Pj4gLi4uDQo+Pj4+Pj4+IGNoYW5nZV9wdGVfcmFuZ2UoKQ0KPj4+Pj4+PiBbICpjbGVhciog4oCc
d3JpdGXigJ0tYml0IF0NCj4+Pj4+Pj4gWyBkZWZlciBUTEIgZmx1c2hlcyBdDQo+Pj4+Pj4+IAkJ
CQlbIHBhZ2UtZmF1bHQgXQ0KPj4+Pj4+PiAJCQkJLi4uDQo+Pj4+Pj4+IAkJCQl3cF9wYWdlX2Nv
cHkoKQ0KPj4+Pj4+PiAJCQkJIGNvd191c2VyX3BhZ2UoKQ0KPj4+Pj4+PiAJCQkJICBbIGNvcHkg
cGFnZSBdDQo+Pj4+Pj4+IAkJCQkJCQlbIHdyaXRlIHRvIG9sZA0KPj4+Pj4+PiAJCQkJCQkJICBw
YWdlIF0NCj4+Pj4+Pj4gCQkJCS4uLg0KPj4+Pj4+PiAJCQkJIHNldF9wdGVfYXRfbm90aWZ5KCkN
Cj4+Pj4+PiANCj4+Pj4+PiBZdWNrIQ0KPj4+Pj4gDQo+Pj4+PiBOb3RlLCB0aGUgYWJvdmUgd2Fz
IHBvc3RlZCBiZWZvcmUgd2UgZmlndXJlZCBvdXQgdGhlIGRldGFpbHMgc28gaXQNCj4+Pj4+IHdh
c24ndCBzaG93aW5nIHRoZSByZWFsIGRlZmVycmVkIHRsYiBmbHVzaCB0aGF0IGNhdXNlZCBwcm9i
bGVtcyAodGhlDQo+Pj4+PiBvbmUgc2hvd2VkIG9uIHRoZSBsZWZ0IGNhdXNlcyB6ZXJvIGlzc3Vl
cykuDQo+Pj4+IA0KPj4+PiBBY3R1YWxseSBpdCB3YXMgcG9zdGVkIGFmdGVyIChub3RlIHRoYXQg
dGhpcyBpcyB2MikuIFRoZSBhZm9yZW1lbnRpb25lZA0KPj4+PiBzY2VuYXJpbyB0aGF0IFBldGVy
IHJlZ2FyZHMgdG8gaXMgdGhlIG9uZSB0aGF0IEkgYWN0dWFsbHkgZW5jb3VudGVyZWQgKG5vdA0K
Pj4+PiB0aGUgc2Vjb25kIHNjZW5hcmlvIHRoYXQgaXMg4oCcdGhlb3JldGljYWzigJ0pLiBUaGlz
IHNjZW5hcmlvIHRoYXQgUGV0ZXIgcmVnYXJkcw0KPj4+PiBpcyBpbmRlZWQgbW9yZSDigJxzdHVw
aWTigJ0gaW4gdGhlIHNlbnNlIHRoYXQgd2Ugc2hvdWxkIGp1c3Qgbm90IHdyaXRlLXByb3RlY3QN
Cj4+Pj4gdGhlIFBURSBvbiB1c2VyZmF1bHRmZCB3cml0ZS11bnByb3RlY3QuDQo+Pj4+IA0KPj4+
PiBMZXQgbWUga25vdyBpZiBJIG1hZGUgYW55IG1pc3Rha2UgaW4gdGhlIGRlc2NyaXB0aW9uLg0K
Pj4+IA0KPj4+IEkgZGlkbid0IHNheSB0aGVyZSBpcyBhIG1pc3Rha2UuIEkgc2FpZCBpdCBpcyBu
b3Qgc2hvd2luZyB0aGUgcmVhbA0KPj4+IGRlZmVycmVkIHRsYiBmbHVzaCB0aGF0IGNhdXNlIHBy
b2JsZW1zLg0KPj4+IA0KPj4+IFRoZSBpc3N1ZSBoZXJlIGlzIHRoYXQgd2UgaGF2ZSBhICJkZWZl
ciB0bGIgZmx1c2giIHRoYXQgcnVucyBhZnRlcg0KPj4+ICJ3cml0ZSB0byBvbGQgcGFnZSIuDQo+
Pj4gDQo+Pj4gSWYgeW91IGxvb2sgYXQgdGhlIGFib3ZlLCB5b3UncmUgaW5kdWNlZCB0byB0aGlu
ayB0aGUgImRlZmVyIHRsYg0KPj4+IGZsdXNoIiB0aGF0IGNhdXNlcyBpc3N1ZXMgaXMgdGhlIG9u
ZSBpbiBjcHUwLiBJdCdzIG5vdC4gVGhhdCBpcw0KPj4+IHRvdGFsbHkgaGFybWxlc3MuDQo+PiAN
Cj4+IEkgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCB5b3Ugc2F5LiBUaGUgZGVmZXJyZWQgVExCIGZs
dXNoIG9uIGNwdTAgKmlzKiB0aGUNCj4+IHRoZSBvbmUgdGhhdCBjYXVzZXMgdGhlIHByb2JsZW0u
IFRoZSBQVEUgaXMgd3JpdGUtcHJvdGVjdGVkIChhbHRob3VnaCBpdCBpcw0KPj4gYSB1c2VyZmF1
bHRmZCB1bnByb3RlY3Qgb3BlcmF0aW9uKSwgY2F1c2luZyBjcHUxIHRvIGVuY291bnRlciBhICNQ
RiwgaGFuZGxlDQo+PiB0aGUgcGFnZS1mYXVsdCAoYW5kIGNvcHkpLCB3aGlsZSBjcHUyIGtlZXBz
IHdyaXRpbmcgdG8gdGhlIHNvdXJjZSBwYWdlLiBJZg0KPj4gY3B1MCBkaWQgbm90IGRlZmVyIHRo
ZSBUTEIgZmx1c2gsIHRoaXMgcHJvYmxlbSB3b3VsZCBub3QgaGFwcGVuLg0KPiANCj4gWW91ciBh
cmd1bWVudCAiSWYgY3B1MCBkaWQgbm90IGRlZmVyIHRoZSBUTEIgZmx1c2gsIHRoaXMgcHJvYmxl
bSB3b3VsZA0KPiBub3QgaGFwcGVuIiBpcyBpZGVudGljYWwgdG8gImlmIHRoZSBjcHUwIGhhcyBh
IHNtYWxsIFRMQiBzaXplIGFuZCB0aGUNCj4gdGxiIGVudHJ5IGlzIHJlY3ljbGVkLCB0aGUgcHJv
YmxlbSB3b3VsZCBub3QgaGFwcGVuIi4NCj4gDQo+IFRoZXJlIGFyZSBhIG11bHRpdHVkZSBvZiBm
YWN0b3JzIHRoYXQgYXJlIHVucmVsYXRlZCB0byB0aGUgcmVhbA0KPiBwcm9ibGVtYXRpYyBkZWZl
cnJlZCB0bGIgZmx1c2ggdGhhdCBtYXkgaGFwcGVuIGFuZCBzdGlsbCB3b24ndCBjYXVzZQ0KPiB0
aGUgaXNzdWUsIGluY2x1ZGluZyBhIHBhcmFsbGVsIElQSS4NCj4gDQo+IFRoZSBwb2ludCBpcyB0
aGF0IHdlIGRvbid0IG5lZWQgdG8gd29ycnkgYWJvdXQgdGhlICJkZWZlciBUTEIgZmx1c2hlcyIN
Cj4gb2YgdGhlIHVuLXdycHJvdGVjdCwgYmVjYXVzZSB5b3Ugc2FpZCBlYXJsaWVyIHRoYXQgZGVm
ZXJyaW5nIHRsYg0KPiBmbHVzaGVzIHdoZW4geW91J3JlIGRvaW5nICJwZXJtaXNzaW9uIHByb21v
dGlvbnMiIGRvZXMgbm90IGNhdXNlDQo+IHByb2JsZW1zLg0KPiANCj4gVGhlIG9ubHkgImRlZmVy
cmVkIHRsYiBmbHVzaCIgd2UgbmVlZCB0byB3b3JyeSBhYm91dCwgbm90IGluIHRoZQ0KPiBwaWN0
dXJlLCBpcyB0aGUgb25lIGZvbGxvd2luZyB0aGUgYWN0dWFsIHBlcm1pc3Npb24gcmVtb3ZhbCAo
dGhlDQo+IHdycHJvdGVjdGlvbikuDQoNCkkgdGhpbmsgeW91IGFyZSBtaXNzaW5nIHRoZSBwb2lu
dCBvZiB0aGlzIHNjZW5hcmlvLCB3aGljaCBpcyBkaWZmZXJlbnQgdGhhbg0KdGhlIHNlY29uZCBz
Y2VuYXJpby4NCg0KSW4gdGhpcyBzY2VuYXJpbywgY2hhbmdlX3B0ZV9yYW5nZSgpLCB3aGVuIGNh
bGxlZCB0byBkbyB1c2VyZmF1bHRmZOKAmXMNCip1bnByb3RlY3QqIG9wZXJhdGlvbiwgZGlkIG5v
dCBwcmVzZXJ2ZSB0aGUgd3JpdGUtYml0IGlmIGl0IHdhcyBhbHJlYWR5IHNldC4NCkluc3RlYWQg
Y2hhbmdlX3B0ZV9yYW5nZSgpICpjbGVhcmVkKiB0aGUgd3JpdGUtYml0LiBTbyB1cG9uIGEgbG9n
aWNhbA0KcGVybWlzc2lvbiBwcm9tb3Rpb24gb3BlcmF0aW9uIC0gdXNlcmZhdWx0ZmQgKnVucHJv
dGVjdCogLSB5b3UgZ290IGENCnBoeXNpY2FsIHBlcm1pc3Npb24gZGVtb3Rpb24sIHR1cm5pbmcg
UlcgUFRFcyBpbnRvIFJPLg0KDQpUaGlzIHByb2JsZW0gaXMgZnVsbHkgcmVzb2x2ZWQgYnkgdGhp
cyBwYXJ0IG9mIHRoZSBwYXRjaDoNCg0KLS0tIGEvbW0vbXByb3RlY3QuYw0KKysrIGIvbW0vbXBy
b3RlY3QuYw0KQEAgLTc1LDcgKzc1LDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY2hhbmdlX3B0
ZV9yYW5nZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwgcG1kX3QgKnBtZCwNCgkJb2xkcHRl
ID0gKnB0ZTsNCgkJaWYgKHB0ZV9wcmVzZW50KG9sZHB0ZSkpIHsNCgkJCXB0ZV90IHB0ZW50Ow0K
LQkJCWJvb2wgcHJlc2VydmVfd3JpdGUgPSBwcm90X251bWEgJiYgcHRlX3dyaXRlKG9sZHB0ZSk7
DQorCQkJYm9vbCBwcmVzZXJ2ZV93cml0ZSA9IChwcm90X251bWEgfHwgdWZmZF93cF9yZXNvbHZl
KSAmJg0KKwkJCQkJICAgICAgcHRlX3dyaXRlKG9sZHB0ZSk7DQoNCllvdSBjYW4gYXJndWUgdGhh
dCB0aGlzIG5vdCBkaXJlY3RseSByZWxhdGVkIHRvIHRoZSBkZWZlcnJlZCBUTEIgZmx1c2gsIGFz
DQpvbmNlIHRoaXMgY2h1bmsgaXMgYWRkZWQsIGEgVExCIGZsdXNoIHdvdWxkIG5vdCBiZSBuZWVk
ZWQgYXQgYWxsIGZvcg0KdXNlcmZhdWx0ZmQtdW5wcm90ZWN0LiBCdXQgSSBjb25zaWRlciBpdCBh
IHBhcnQgb2YgdGhlIHByb2JsZW0sIGVzcGVjaWFsbHkNCnNpbmNlIHRoaXMgaXMgd2hhdCB0cmln
Z2VyZWQgdGhlIHVzZXJmYXVsdGZkIHNlbGYtdGVzdHMgdG8gZmFpbC4NCg0KPj4gaXQgc2hvd3Mg
dGhlIHdyaXRlIHRoYXQgdHJpZ2dlcnMgdGhlIGNvcnJ1cHRpb24gaW5zdGVhZCBvZiBkaXNjdXNz
aW5nDQo+PiDigJx3aW5kb3dz4oCdLCB3aGljaCBtaWdodCBiZSBsZXNzIGNsZWFyLiBSdW5uaW5n
IGNvcHlfdXNlcl9wYWdlKCkgd2l0aCBzdGFsZQ0KPiANCj4gSSB0aGluayBzaG93aW5nIGV4YWN0
bHkgd2hlcmUgdGhlIHJhY2Ugd2luZG93IG9wZW5zIGlzIGtleSB0bw0KPiB1bmRlcnN0YW5kIHRo
ZSBpc3N1ZSwgYnV0IHRoZW4gdGhhdCdzIHRoZSB3YXkgSSB3b3JrIGFuZCBmZWVsIGZyZWUgdG8N
Cj4gdGhpbmsgaXQgaW4gYW55IG90aGVyIHdheSB0aGF0IG1heSBzb3VuZCBzaW1wbGVyLg0KPiAN
Cj4gSSBqdXN0IHdvcnJpZWQgcGVvcGxlIHRoaW5rcyB0aGUgZGVmZXJyZWQgdGxiIGZsdXNoIGlu
IHlvdXIgdjIgdHJhY2UNCj4gaXMgdGhlIG9uZSB0aGF0IGNhdXNlcyBwcm9ibGVtIHdoZW4gb2J2
aW91c2x5IGl0J3Mgbm90IHNpbmNlIGl0DQo+IGZvbGxvd3MgYSBwZXJtaXNzaW9uIHByb21vdGlv
bi4gT25jZSB0aGF0IGlzIGNsZWFyLCBmZWVsIGZyZWUgdG8NCj4gcmVqZWN0IG15IHRyYWNlLg0K
PiANCj4gQWxsIEkgY2FyZSBhYm91dCBpcyB0aGF0IHBlcmZvcm1hbmNlIGRvbid0IHJlZ3Jlc3Mg
ZnJvbSBDUFUtc3BlZWQgdG8NCj4gZGlzayBJL08gc3BpbmRsZSBzcGVlZCwgZm9yIHNvZnQgZGly
dHkgYW5kIHVmZmQtd3AuDQoNCkkgd291bGQgZmVlbCBtb3JlIGNvbWZvcnRhYmxlIGlmIHlvdSBw
cm92aWRlIHBhdGNoZXMgZm9yIHVmZmQtd3AuIElmIHlvdQ0Kd2FudCwgSSB3aWxsIGRvIGl0LCBi
dXQgSSByZXN0YXRlIHRoYXQgSSBkbyBub3QgZmVlbCBjb21mb3J0YWJsZSB3aXRoIHRoaXMNCnNv
bHV0aW9uICh3b3JyaWVkIGFzIGl0IHNlZW1zIGEgYml0IGFkLWhvYyBhbmQgbWlnaHQgbGVhdmUg
b3V0IGEgc2NlbmFyaW8NCndlIGFsbCBtaXNzZWQgb3IgY2F1c2UgYSBUTEIgc2hvb3Rkb3duIHN0
b3JtKS4NCg0KQXMgZm9yIHNvZnQtZGlydHksIEkgdGhvdWdodCB0aGF0IHlvdSBzYWlkIHRoYXQg
eW91IGRvIG5vdCBzZWUgYSBiZXR0ZXINCihiYWNrcG9ydGFibGUpIHNvbHV0aW9uIGZvciBzb2Z0
LWRpcnR5LiBDb3JyZWN0IG1lIGlmIEkgYW0gd3JvbmcuDQoNCkFueWhvdywgSSB3aWxsIGFkZCB5
b3VyIGNvbW1lbnRzIHJlZ2FyZGluZyB0aGUgc3RhbGUgVExCIHdpbmRvdyB0byBtYWtlIHRoZQ0K
ZGVzY3JpcHRpb24gY2xlYXJlci4NCg0K
