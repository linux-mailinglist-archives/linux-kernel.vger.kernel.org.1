Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E92C28F292
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgJOMpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:45:01 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:37147 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgJOMpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=6734; q=dns/txt; s=iport;
  t=1602765897; x=1603975497;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version;
  bh=Ap0eXDWc+Vj90ovkRAHd7sB2iUi8yu/pNQk2EcSaNNY=;
  b=hso9/IvW8gwhpK9VnuNHBxow6V3Lkp4Td+5f40rN8C59fzMwG9rO7Jnd
   H8q41J5LVCJQjbmvv0+cDZMyy8G738ZLE7r/kbUvMiPzjxTZVs9bk66Ad
   KpECsECspGhOw0FM9a6/G+YfqMqZBlpJCx1i9v9VIt+tRri7fyMvvHPLD
   0=;
X-Files: pEpkey.asc : 1813
IronPort-PHdr: =?us-ascii?q?9a23=3AeKl8fxUxc58fm1P3/GlIaStWvgrV8LGuZFwc94?=
 =?us-ascii?q?YnhrRSc6+q45XlOgnF6O5wiEPSBN6FufZFjffGvaf9X2AJ/ZeGtjYFapMfHx?=
 =?us-ascii?q?MGiMBDmQsmDYbFDEDgN/flYmQ8G9gKT15q+Xy3cC03UMbzblHfuDu+uDgVHB?=
 =?us-ascii?q?isMQtzO/T7HZPUg82r1ue0vZrJbFYAiD+0e7gnKhKwoE3YvdUXho03LKE3x3?=
 =?us-ascii?q?6r6ntFcuhb3yVmP1WWyh39/cy3upVk9ndd?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AvAgBsQ4hf/4gNJK1gGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAYIPgVJRB4FJLywKhDODRgONIi6Ye4JTA1UEBwEBAQo?=
 =?us-ascii?q?DAQEtAgQBAYRKAheBcQIlOBMCAwEBCwEBBQEBAQIBBgRthVwMhXIBAQEEEhE?=
 =?us-ascii?q?dAQE3AQ8CAQgVAyoCAgIwJQIEDQEFAgEBChSDBAGCSwMuAQOhKQKBOYhhdoE?=
 =?us-ascii?q?ygwEBAQWFGhiCCQcJgTiBU4Efg26GVhuBQT+BOIFrfj6EVIMAgmCTUIcPgUy?=
 =?us-ascii?q?bUQqCaoRNgl+TNgUHAx+DFooIlCwtsywCBAIEBQIOAQEFgWsjN4EgcBWDJFA?=
 =?us-ascii?q?XAg2OHzeDOopWdAI2AgYKAQEDCXyMOwGBEAEB?=
X-IronPort-AV: E=Sophos;i="5.77,379,1596499200"; 
   d="asc'?scan'208";a="583439692"
Received: from alln-core-3.cisco.com ([173.36.13.136])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Oct 2020 12:44:56 +0000
Received: from XCH-RCD-005.cisco.com (xch-rcd-005.cisco.com [173.37.102.15])
        by alln-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 09FCiuuC011896
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 15 Oct 2020 12:44:56 GMT
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by XCH-RCD-005.cisco.com
 (173.37.102.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Oct
 2020 07:44:56 -0500
Received: from xhs-rcd-003.cisco.com (173.37.227.248) by xhs-rcd-003.cisco.com
 (173.37.227.248) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 15 Oct
 2020 07:44:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-003.cisco.com (173.37.227.248) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 15 Oct 2020 07:44:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfOMzg3X6DWItT5ocErtczI4OJRMOdLXMiVLRUOJG5TVPkkFE8VSp61W9gBzrxdgIRHL5SN/EjkuUTt0JIi3XvXooohg9xy6JTfbVrQTgN8pthWelqC1oy4FbREix84uiW2pJFNrKQLeyRdeoHvKpznWWf3axxWM5O0qd4EFvwSzbK+wDa43xf/MLIu3tpzfO207CCG9nDTirM1kuY/wSgl8h2v3YDfBtavjtfvjxlw4B/F3CLZBiy8XUJEz0WJPBByyyGqAlcvJjPKUyc04b1mM/4Qa6qKOgv5EyXuSvkU2i7ZoHlJGXEP9R3gX+WvMCrti8VTIV+Yai3DvpC1axw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v5d4Mm3Mj7wn34GaWiXGFqyR33w6MaODdMS8xXRQq4=;
 b=FVo1otSfqUSP2pq+D15YBObaXVtL3L7WOSd7jiOtToctbLmQudL1w64K8d3K60UDHgi3dUraFEhyOz3f/H3alUMZRMWiEM8JwcF7hoz8rq7czHsFno+AwFxGLpoJ5DrzToPo3PTPQKM+WL5gcFY3BTMvSTzlMEQ/GnZk1fGAv6zPDJ1zdUhUxiW1CXjHYxCH0YHeGia8It8drwR3yx+tXtGBSYEtbN7LeDs/BVTIulHWomPA1uxA0eEnUZjXP/diGjEb38RwKX06AnXCjKhuO2hUkYANmLgBcOrC6cPdEr7aAxc2JNoCDl2TPeNZDBBmXqBamQB+JdPyVRP9l6M7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3v5d4Mm3Mj7wn34GaWiXGFqyR33w6MaODdMS8xXRQq4=;
 b=f0per7miVFcAjH2yLeJfJQGZmmKKC5sNdep3t/VoW30CHx0Sz1vJi7qUq6p5IWHK2MFVCJSaNXMMpOZIeRjyArW6r6ascM0i7F07eatnOyybwljkalfHwYfKtkjS9obQjdVsgqkQwvA7eox02yrcJ2BAmiba+Ws0qM+eSMBuqpM=
Received: from DM6PR11MB3866.namprd11.prod.outlook.com (2603:10b6:5:199::33)
 by DM6PR11MB4612.namprd11.prod.outlook.com (2603:10b6:5:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Thu, 15 Oct
 2020 12:44:55 +0000
Received: from DM6PR11MB3866.namprd11.prod.outlook.com
 ([fe80::c943:b491:e40e:4f02]) by DM6PR11MB3866.namprd11.prod.outlook.com
 ([fe80::c943:b491:e40e:4f02%7]) with mapi id 15.20.3455.032; Thu, 15 Oct 2020
 12:44:54 +0000
From:   "Hans-Christian Egtvedt (hegtvedt)" <hegtvedt@cisco.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Luiz Augusto von Dentz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Thread-Topic: [PATCH v4.4/bluetooth 1/2] Bluetooth: Consolidate encryption
 handling in hci_encrypt_cfm
Thread-Index: AQHWotmplfjLfEEHCEydFw1RNBP3KKmYhCmAgAAMXQCAAAu7gA==
Date:   Thu, 15 Oct 2020 12:44:54 +0000
Message-ID: <23d41fa2-ed12-911e-42ef-09db96c95e0f@cisco.com>
References: <20201015074333.445510-1-hegtvedt@cisco.com>
 <20201015095750.GA3935178@kroah.com>
 <0804be81-ebbf-8132-a619-c0c740a71f51@cisco.com>
 <20201015120254.GA3958402@kroah.com>
In-Reply-To: <20201015120254.GA3958402@kroah.com>
Accept-Language: en-DK, en-US
Content-Language: aa
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=cisco.com;
x-originating-ip: [31.45.31.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 562bbf1c-5477-4608-ff5f-08d871081dcf
x-ms-traffictypediagnostic: DM6PR11MB4612:
x-microsoft-antispam-prvs: <DM6PR11MB4612BF7787F66D920DAECC02DD020@DM6PR11MB4612.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UxLNZAFnd5cSJZZkzsqIE/5OPkYJh6qQT2bb9EM6DKy10G6549HrUfOaN5ujGs7VPczQuHY3UkLoNbo9rRrhkX94ORZHT+RYwiDm89W9k1Kv27fn6Yde879KklG9oSRb/Nwx84pg5jNonTzU5kz6T2yOrGAXUyR/eb1VJHZdpZLXVEgWcp2TA72uEKZf0FiZ+CEzpDscBNx+UUV2ymDBuq1G/zju76s+56Nh5BnprtlpKT54F07g6efWl3nwm69zgmQ5zEetcBO5pFDkaVLUgKgI1vQ2hcbxyepjs1zzjlGyWZMIduApjuN8qdxJVuOjRzeYTb+T+WE3J0JBXGmezdczBD2BbBCHVsXNvCboF8e1tqmaIsuU5ohVa3mlxN3v
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3866.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(39860400002)(136003)(366004)(64756008)(91956017)(66446008)(66476007)(76116006)(66556008)(36756003)(99936003)(83380400001)(6506007)(66616009)(53546011)(8936002)(31686004)(71200400001)(66946007)(2906002)(5660300002)(54906003)(31696002)(316002)(8676002)(6486002)(86362001)(186003)(478600001)(26005)(4326008)(2616005)(6512007)(6916009)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gmrI+LED9H5q0UKctaP4RDr3mtCJjUXzYb8l9inPyLbigpcrfL3zOastw7wJ3gqmFSOuLjvlgV4YXeiqoDbm81nSAnwJdM+HpHxJv8dmBAB3eODOWaeFI5uk11ZeSkpyOoOq213cK9Vm3GcFL3G1OB47FAEdNepW1x/6hZO2uTLw2w/NhAJJ5zB5HWIi+s+P4go3QjLAv7TDh2PZRYkSuMTHGnxACFRSTWMGMAcYY2vmptD82FIuxrBxsNjEBAIudCDh4efAcf8ToMSiSPb4Ypgty1opmSM7OnSZSNJODpbIH1/SlP+c/LNFgzBEBxXnbIuoSF+Tdqpj087d9InYkZj4VuwsodCKM2yxIpklsLbDDe8Fl5GZ5e7L2rAk648Fa4tLVje+igU9YMfhzs0+bJHnff7Tm/HijRE9hg1Ld+Y5uSgd/Z/fEbVNeu2Ba3L970argBM3ow8umNPm8XLK2DRN8gQyjx6pks5ciodI9IYYcKu1t3/xx4tK6Ed+A8Soofcwrav8cqqol3TABj9WNIpJ7/v75OCmDWVlpgi0zjVgaCjHOGMs9kBiF26GFXpNHY/LGCXsMrBZZZVUJDw7h0bh6HMBi1szcNPus/9P32/5oCgweMQTB0Yb8KLINaXsCHW2YhJ2AXwkUVrd9sqisw==
x-ms-exchange-transport-forked: True
Content-Type: multipart/mixed;
        boundary="_002_23d41fa2ed12911e42ef09db96c95e0fciscocom_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3866.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 562bbf1c-5477-4608-ff5f-08d871081dcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 12:44:54.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xwYDkCy7Ht937nD6MgmO09CKymi5nIhFoCX7M6EwB6V019Ci0YCUGp4QZD6CIuONLMMjjVpdQPL7P8811eG6eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4612
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.15, xch-rcd-005.cisco.com
X-Outbound-Node: alln-core-3.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_23d41fa2ed12911e42ef09db96c95e0fciscocom_
Content-Type: text/plain; charset="utf-8"
Content-ID: <13CFD680DADC664EABA46CA8FE245379@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

T24gMTUvMTAvMjAyMCAxNDowMiwgR3JlZyBLSCB3cm90ZToNCj4gT24gVGh1LCBPY3QgMTUsIDIw
MjAgYXQgMTE6MTg6MzlBTSArMDAwMCwgSGFucy1DaHJpc3RpYW4gRWd0dmVkdCAoaGVndHZlZHQp
IHdyb3RlOg0KPj4gT24gMTUvMTAvMjAyMCAxMTo1NywgR3JlZyBLSCB3cm90ZToNCj4+PiBPbiBU
aHUsIE9jdCAxNSwgMjAyMCBhdCAwOTo0MzozMkFNICswMjAwLCBIYW5zLUNocmlzdGlhbiBOb3Jl
biBFZ3R2ZWR0IHdyb3RlOg0KPj4+PiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6
LnZvbi5kZW50ekBpbnRlbC5jb20+DQo+Pj4+DQo+Pj4+IFRoaXMgbWFrZXMgaGNpX2VuY3J5cHRf
Y2ZtIGNhbGxzIGhjaV9jb25uZWN0X2NmbSBpbiBjYXNlIHRoZSBjb25uZWN0aW9uDQo+Pj4+IHN0
YXRlIGlzIEJUX0NPTkZJRyBzbyBjYWxsZXJzIGRvbid0IGhhdmUgdG8gY2hlY2sgdGhlIHN0YXRl
Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6
LnZvbi5kZW50ekBpbnRlbC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IE1hcmNlbCBIb2x0bWFu
biA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4+Pj4gKGNoZXJyeSBwaWNrZWQgZnJvbSBjb21taXQg
M2NhNDRjMTZiMGRjYzc2NGI2NDFlZTRhYzIyNjkwOWY1YzQyMWFhMykNCj4+Pg0KPj4+IFRoaXMg
aXMgb25seSBpbiA1LjgsIHdoYXQgYWJvdXQgYWxsIHRoZSBvdGhlciBzdGFibGUga2VybmVscz8N
Cj4+Pg0KPj4+PiAoY2hlcnJ5IHBpY2tlZCBmcm9tIGNvbW1pdCAwYTYwOTk2YzdmYTcwMTBlYTAw
ZDliNjJmYjY5OTZkOTA4YTAxZWFkKQ0KPj4+DQo+Pj4gV2hlcmUgaXMgdGhpcyBjb21taXQgZnJv
bT8gIEkgZG9uJ3Qgc2VlIGl0IGluIExpbnVzJ3MgdHJlZS4NCj4+DQo+PiBPcHMsIG15IGJhZCwg
SSBoYXZlIGEgTGludXggNC45IGJyYW5jaCwgd2hpY2ggYWxzbyBpbmNsdWRlcyB0aGUgQW5kcm9p
ZA0KPj4gNC45IGtlcm5lbCBjaGFuZ2VzIGZyb20gR29vZ2xlLiBBbmQgc2luY2UgSSBub3RpY2Vk
IHRoZSBwYXRjaGVzIGluIG15DQo+PiAobWVyZ2VkIGZyb20gQW5kcm9pZCBsYXRlc3QpIGxpbnV4
LTQuOS55IGJyYW5jaCwgSSB0aG91Z2h0IHRoZSBwYXRjaGVzDQo+PiB3ZXJlIGFwcGxpZWQgdGhy
b3VnaCBhbGwgc3RhYmxlIHJlbGVhc2VzIDQuOSBhbmQgdXAuDQo+IA0KPiBJIGp1c3QgbG9va2Vk
IGF0IHRoZSBnb29nbGUgY29tbW9uIGFuZHJvaWQgdHJlZXMsIGFuZCBkbyBub3Qgc2VlIHRoaXMN
Cj4gY29tbWl0IGluIHRoZSBhbmRyb2lkLTQuOS1xIGJyYW5jaC4gIFdoYXQgYnJhbmNoIGFyZSB5
b3Ugc2VlaW5nIGl0IGluPw0KDQpXZWxsIHRoaXMgaXMgZW1iYXJyYXNzaW5nOg0KDQpjb21taXQg
MGE2MDk5NmM3ZmE3MDEwZWEwMGQ5YjYyZmI2OTk2ZDkwOGEwMWVhZA0KQXV0aG9yOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+DQpDb21taXQ6IEhhbnMt
Q2hyaXN0aWFuIE5vcmVuIEVndHZlZHQgPGhlZ3R2ZWR0QGNpc2NvLmNvbT4NCg0KPj4+PiAtLS0N
Cj4+Pj4gQUZBSUNULCBmaXhpbmcgQ1ZFIDIwMjAtMTAxMzUgQmx1ZXRvb3RoIGltcGVyc29uYXRp
b24gYXR0YWNrcyBoYXZlIGJlZW4NCj4+Pj4gbGVmdCBvdXQgZm9yIHRoZSA0LjQgc3RhYmxlIGtl
cm5lbC4gSSBjaGVycnkgcGlja2VkIHdoYXQgSSBhc3N1bWUgYXJlDQo+Pj4+IHRoZSBhcHByb3By
aWF0ZSB0d28gcGF0Y2hlcyBtaXNzaW5nIGZyb20gdGhlIDQuOSBzdGFibGUga2VybmVsLiBQbGVh
c2UNCj4+Pj4gYWRkIHRoZW0gdG8gdXBjb21pbmcgNC40IHN0YWJsZSByZWxlYXNlcy4NCj4+Pg0K
Pj4+IFdoeSBhcmUgeW91IG1lcmdpbmcgMiBjb21taXRzIHRvZ2V0aGVyPyAgUGxlYXNlIHByb3Zp
ZGUgYmFja3BvcnRzIGZvcg0KPj4+IGFsbCBzdGFibGUga2VybmVscywgaWYgeW91IHdhbnQgdG8g
c2VlIHRoaXMgaW4gdGhlIDQuNC55IHRyZWUuICBXZSBjYW4NCj4+PiBub3QgaGF2ZSBzb21lb25l
IG1vdmUgZnJvbSBhbiBvbGRlciB0cmVlIHRvIGEgbmV3ZXIgb25lIGFuZCBoYXZlIGENCj4+PiBy
ZWdyZXNzaW9uLg0KPj4NCj4+IEFncmVlZCwgSSBoYXZlIG1hbmFnZWQgdG8gdHJpY2sgbXlzZWxm
IGludG8gdGhpbmtpbmcgdGhlIDQuNC55IGJyYW5jaA0KPj4gd2FzIGxlZnQgb3V0LCBidXQgSSBh
c3N1bWUgdGhlc2UgcGF0Y2hlcyBhcmUgcmVxdWlyZWQgZm9yIGFsbCBMVFMgYnJhbmNoZXMuDQo+
IA0KPiBUaGV5IGFyZSwgYnV0IGlmIHlvdSBoYXZlIGNvcGllcyBvZiB0aGVtLCBwbGVhc2UgZmVl
bCBmcmVlIHRvIHNoYXJlDQo+IHRoZW0uDQoNCkkgd2lsbCByZXBlYXQgY2hlcnJ5LXBpY2tpbmcg
ZnJvbSBhIGNsZWFuIGxpbnV4LXN0YWJsZSBnaXQgdHJlZSBhbmQgc2VuZA0KcGF0Y2hlcywgc29y
cnkgZm9yIHRoaXMgbm9pc2UuDQoNCkkgc2VlIGxpbnV4LTUuOC55IGhhcyBwYXJ0aWFsIHBhdGNo
ZXMsIHdoaWxlIHRoZSBvbGRlciBicmFuY2hlcyBuZWVkIHRoZQ0KZnVsbCBzZXJpZXMgb2YgdGhy
ZWUgY29tbWl0cy4gSSBqdXN0IGRpc2NvdmVyZWQgYW4gYWRkaXRpb25hbCBmaXguDQoNCi0tIA0K
QmVzdCByZWdhcmRzLCBIYW5zLUNocmlzdGlhbiBOb3JlbiBFZ3R2ZWR0DQo=

--_002_23d41fa2ed12911e42ef09db96c95e0fciscocom_
Content-Type: application/pgp-keys; name="pEpkey.asc"
Content-Description: pEpkey.asc
Content-Disposition: attachment; filename="pEpkey.asc"; size=1813;
	creation-date="Thu, 15 Oct 2020 12:44:53 GMT";
	modification-date="Thu, 15 Oct 2020 12:44:53 GMT"
Content-ID: <299F1C84E04443429BF1E24EFF40140D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQoNCm1RRU5CRjkyUTYwQkNBRERq
dUxjNDlMSEQ2WmVsNW5xekxnclVWczRiSE94M3hlTkxRSVpGNXBIemxXa2VqMzYNCmtyRjltcFN1
TGdUamtsd2dkN2ZzNE44NHlEVllZbXZIR0l0NVpzZVRqTW53aFVodUNNY2FHNERVUEFsMk9CNHkN
CkxIUUFVY0QxdktKU2pEM21GWDYzR1hzajJTSzluTWthYmxCVDcxVXBCcUdSVVVyY2c3OVRreGg5
b3VjblU3UnQNCnUzWTZzTWhDancvU1gwWmVJb2VxU1NaZWlDS3l4OXlSZ3JiNkJGSXFWMm16QUZB
YWcyK1BZYVQ5dWs1NWlnUzgNCklhM2M0aVVxbllHeWNnQ2hYZ1NuVk91eGJwWC9LeEVsM3pmVTA3
RzZVSTRMejcwR3lDOXRKMU1kUE1tWnhwTUMNCldZYWMwQSt5SEcrTGIrQ1lNVDBvQS9yK3dZZXgz
RXBBODI1YkFCRUJBQUcwTVVoaGJuTXRRMmh5YVhOMGFXRnUNCklFNXZjbVZ1SUVWbmRIWmxaSFFn
UEdobFozUjJaV1IwUUdOcGMyTnZMbU52YlQ2SkFWUUVFd0VJQUQ0V0lRUTgNClJJdmZkUXpWN3FB
dmRvY3BqV0VUWUhyRE9RVUNYM1pEcmdJYkF3VUpBZUV6Z0FVTENRZ0hBZ1lWQ2drSUN3SUUNCkZn
SURBUUllQVFJWGdBQUtDUkFwaldFVFlIckRPWklIQ0FDQjdncXMvSVdwTkU2TlNsS2l1eSs3SkR1
ZEJaRkENCklMMVJFUlBsSU9uWkRTQm5TMkcyakkvQ25IL0NWYlAyaVdHSy9WdUx6ZUdVM2QrNy9R
VkN4U2xXd0NHUmw5SnENCnYyaXFlemxpeHNrUVJRSVdGL2t2MWxKNVJXUzRFMzRLVUxiak44WTF2
WGhwOExjRnA2WGtmMDEzSWZodHJRZlENCllLaW1zWjlvNzd6VDZJVHhiOTZsK0xabVZlWTdrNGd3
MExQbEdFZkh1N25hNFNWS05xSTd3cHMzWEZhWGVJN00NCnp6MVlvZ2oxL0l2d1ZpczM2dmtickNV
b2lVeWprSC9zRVhVdUI1amNXeXFaOGpYY2daZUN1dHlEQVNRVFJHSFgNClFPdkRoV3JFbUlZTzNl
OE9hYjg3R1ZmVXNwd1pRWnY0STdCQnVCbkZySFFFL2RTcHFzOWtFdXhxdVFFTkJGOTINClE2NEJD
QUMrd1JZZ1IxcEtuZDZWWGhRdWg1b3hqbXlLTkQ4Uy91SE9SOVVXeUZnUnBpSzhlWmFUMUdOc2ow
c1UNCnZ1ZytZcVZMekZHWG04djg4STBWVEgydU1USmw5VHUzeEo0THhuYjJsdnFiaE1wQ2UzOG1O
em1UOFh3cXJ4WjkNCms3cmx0a24vWjVBV1JoRHVoZFJORHVHWENmL0Zua1FFczIyVmpxN0JQTkZn
Z0RCakliU3VGOVRWbnMvL0FVSkUNCk9GOE1uWFhuSWdEK3dKc25maDcwcTVRbFFjRURzMkhCMEFD
R0g4NHovc3lWeGdpRGFlYklELy9SMXVzNDJyWEENCktETHZQZ2tmRDdRbUNlQ1JrRUt1SmorQWRM
U3ZFRE5jUXhZSE13eTRBTC9qd0hNM0RwYjI5WFFRdnVMcm5RckwNClpGQzE5WXVpSTFMY2RkWUFi
STM3UFV0cnhvZ0xBQkVCQUFHSkFUd0VHQUVJQUNZV0lRUThSSXZmZFF6VjdxQXYNCmRvY3BqV0VU
WUhyRE9RVUNYM1pEcmdJYkRBVUpBZUV6Z0FBS0NSQXBqV0VUWUhyRE9TbzBCLzl3RDVTYVYxQWIN
CnAvNVVuMHJvYy9nRGhteGsrT3dDcWpPKytMaEZNOVovK2grVVZYeEw1Y25MTE05NUZuQ0RWSngr
dTIyQ1dkTnQNCnNlVDFWejVHLzVlaXZ6SXA2cSt5a3pOUFpPVUxaRVNoSmpQYnRDa1FyRDFIY3NO
MTJNNXdKcm1TVFlOTXN1MC8NCkI4dDBxaVJ4WFpybi9uRlVaTXVsL2FLTmI4d0dDcVpUbWFEL1hQ
b3Z5d2c0QW5DcDRRR2JFQlJFTjJMcis3NWwNClJmSlJSMkU2MENHaUpxdEZOUjZwUG5GSmg4ajR2
dUVZS0MvY3QvRmxpRk1lTVVQWEl4YnYrUTdVUnI1all5SHUNCjVwVldrVWRvSU9ZcVc4THVsL2dZ
RUY0MTgrdGJ1Qk13TG5maDhraFBGVGhmYjlUditGY0llZmR6Uk9KTzJOTncNClJuUFNJTzBYWkll
Sw0KPU8vR1UNCi0tLS0tRU5EIFBHUCBQVUJMSUMgS0VZIEJMT0NLLS0tLS0NCg==

--_002_23d41fa2ed12911e42ef09db96c95e0fciscocom_--
