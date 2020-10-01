Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F88A2802B1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgJAPZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:25:54 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:64128 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgJAPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601565953; x=1633101953;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JbzeJroKsbVLt9CaB0KGJ6HSxY6DWwiW1wGAsuPyCm8=;
  b=Mpf4JaPpjOMdAuqdghtTD5clOVPlnz4UrcrLyFBihB4dcm2yESZyD9z5
   UdQFM1Cdm4ryzoNV2fLW95W2A2meSyEb2RLf+k7aP/X1/PZUNqr0PeFjq
   Eqq3XkrPPh2k6R71+8m6P63ks21IdJ84ZOfvT7AaYQ3mkiqz5MdtZoLHi
   KLKv0vRtS2Fc0aOWgtRVCQJaNUxPbCoGYdXykDl/XS9Wm6ol5pNsS5L2w
   vVZVQX+Cm8jpaqS7imnbWLZ3UjGUUSsbWW2jB3Cba/whAEgoq16LYreDJ
   aEV8P1Uj52aUNUV2zb5AEuSaVBF3wPliFgBb74c+sGV6scA+MzF/bBhNo
   Q==;
IronPort-SDR: RRWcdwyS33VYAkElv8BbU/xFWJGXmkjxrceIsfYhsWJYY+cb/+Y6CuBnHzVQA+M74vGc5WRSqQ
 TLpG70Y/Lv3Ais0+Y9e6ibTVg9AmdBVUe2+bKf9qUf7uEfD1WhGBej7boUqnsDnB1+JKsrpLyM
 OSgjaqbwhtMAcYRl6aC0MdoPzH2zMrZcf9UeI9V1N5G0kv0g07CMLRoCTpXfHiUcdFf2f0WLEH
 DbbuyCvc2PvkEywQTWJv8nI9C+BnJ3t2AzwE4dDoaSMO6dG1SN7127+NGvADpL3ra6tJZPz4RP
 WKs=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="91111053"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 08:25:52 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 08:25:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 08:25:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJZjhjuUUjPCq2Z6Ok9CrlWjqP+YZoCr3/WXnHbm4uK4Cd//vkjHXDoKw7NQ5Fd7B7FHdE9/4ay+g9/bESb+ZhlKxXIDoATiOtyTR+MaLiYfzfpzyr8PB4HtllQJBa5xvgcFwDU8nzJg9gJsflXoB5/wSKmeb3qXUZ8+gkeiGRvkvFWQJtVr/Pbg+PTg9JgWWo/ZmwsRCehdlk50Tnf+nqGl10ryCUEkXdrJld8OqNTHvOz3/03cEw/+/z7jPAM26h723obc81myuA9AdhReW7ixNUF6q+1u/Y/mRVYPuytXcfytIbUsm2HjTYWFW1Y9QxqiczT/SVeAc2aKUg+zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbzeJroKsbVLt9CaB0KGJ6HSxY6DWwiW1wGAsuPyCm8=;
 b=YXNRS52Q1jcIhcSpyxzFCpJhhCCBD687Mq/L4DX3xYMwP62GlcUAJ3LgcNVnz1W7gK5YQDH61pjYLSUK8tI2C9ojQtSqZrf4+3kFpwDP6niFfPhrMiiaGJDlszE9PW0ynsjv0aFRMJams0DGx0FSjD+cdxaW2xgI2ii6kaCirFYdSvVUZjpIFQeAD+Tfh4SCc8FFtPHaIaK/hixDkrUhjyWmO61WYIY2yB28j+T5Vf3D7hJvlAHh3Goia8J4COmRHyWXBK2sZFdkeFQjuoZ6R2AFtkf0w9YBf4gjexwsFc1xN2RPlrxNDSJoBNx0kqrxWb8ZKpfF23r3YyzV11S+gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbzeJroKsbVLt9CaB0KGJ6HSxY6DWwiW1wGAsuPyCm8=;
 b=IBfVTUgHyhxqZxfb1/b0xFfhJWo7DCWQdR/hCsM6Hg00t1E7dQbcCPCCYZsnbBS6226X9osecWC+adogwT+5+Lo8rgbAY1SgmyLPfqFmiCcVJZ1ZYY24yItsdWfCQ3KZxyRiOtF7cFt+Z8pEumb/SAlLwP1blSA8eszQICMZub0=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB2778.namprd11.prod.outlook.com (2603:10b6:5:c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 15:25:41 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 15:25:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Topic: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Index: AQHWl/wfolQmpEhmZUmGKx8TlQY45g==
Date:   Thu, 1 Oct 2020 15:25:41 +0000
Message-ID: <9e521c50-dddf-618d-1472-8d7bf86ecd3e@microchip.com>
References: <20201001122828.23186-1-michael@walle.cc>
 <5eb8f95c-e9d5-6043-fb7d-bffcda044262@microchip.com>
 <871da0d058ba89320615098ee26150b3@walle.cc>
 <137692b0-ab6d-b9be-17c2-68e3b3146076@microchip.com>
 <279cea35b94647031b6593a45f8f2608@walle.cc>
In-Reply-To: <279cea35b94647031b6593a45f8f2608@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35cfbf09-1702-4127-2394-08d8661e4214
x-ms-traffictypediagnostic: DM6PR11MB2778:
x-microsoft-antispam-prvs: <DM6PR11MB2778DDBFA1ADFA2E6BC6D070F0300@DM6PR11MB2778.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vHtKNCvZkC3eu+UmpJ37Cz00K4W7vZZfmaQ74N3LF64MvXoCwaV4X5Qb37nLlOTNEn1O518GEL5WoX76svwHh+DhIHSjQSzgWtA5xuLRdmwuuz/HCf9vmaBZHFBH45954NIayP1J7S5KF+ze15NY3UllSNr0DVXsMBrxTRiSKaL6bQ/MEhxBKgsEq9Z+li1UJCUBfR5IAPmccDNDRpt7PePYoNrRj5DIkmJOG+o7p5T+je7jO+nEkUuWwJvjFbGQEoTqZiUanWvoRLSynOxELwhp1JpxzAPBmfuc4b8wC4is6Aux8MEBztRXnwL7HCKitYkLCI3fIl1JVXlCJQR/Q+f129uMN+yoYrFVkODsGeQs7e0h+sZJJLOKjNmVKYyTNc/Vipep82zrb5wnVM6rWbmqq6eduwum14/jt82b+pkfVyDCJn5pXOih1yq41XSug+NIa574D+bSxW2rsHqlIVbZPdum9KzdLcEL8VloSBBclswIq/rSohzokFXeUTvB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(366004)(376002)(6506007)(83380400001)(53546011)(36756003)(2616005)(966005)(6916009)(5660300002)(71200400001)(26005)(6486002)(83080400001)(478600001)(31686004)(66446008)(316002)(186003)(31696002)(6512007)(8676002)(91956017)(66476007)(66946007)(64756008)(66556008)(76116006)(8936002)(4326008)(2906002)(54906003)(86362001)(43740500002)(15398625002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZY1HNOEey64iMtwl9WTmlnQYvh0ZHKJPnfTdWCew9umnDH3Nsf2c0ii6Db21T//oZYSH8AJK76qYEKweoF2sR5olzv3jIK/XhtZHlyCiV5uUElFBV8cTXC7xK64ELACZ8KkZwoQBFKyubEKkjHwRoNmbw5OS55VnkhyDzpI8uB4dzhh5AQ0OO2jlPKTry/bot8T06w+H+H/RJdidLzXU+xzD7ET6tpoefY6uOVK+FUDDkmG/3W4tq/E4MgAkiPyksxeveXfbxMghVOL5PpehN6bxfI558cNHssHG6SkH9Ea3198chTQSz64a0kB46FRZGbqrqI0VmjVM5F5Tqt32R86CIqC7k9zFp4HJD6z3BPbAWho3qNZJegVgDPDyVQJWov79R/sdA1dtfeQfx6FMBI8TGiiGEIiY96kwud21qo/qIPdTLUG5w0Y97GiYYo9YBVZs2GyFgQbUv5/Et+VcM/PQPZVPGEXmvDRo+HY0XYSxAdojZMHsGHgCzw4j3qZ8LDM6YGjOaz9Hgu55Zho58lAA6rq0eGb7X90nh3cqHsKUPi61Q2OUG0pXG9f8SgKCc8kLgSCQwvrhhCyWBd3Xzo3Vcay3A8n91t0ZHBme2cC5UIXvCMYK4kj2nCRsOy3RLIMSE7b3XWAfAHnxc18gvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C31BCF60D8290640920BF81EB10A1C9F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35cfbf09-1702-4127-2394-08d8661e4214
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 15:25:41.5173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IYFSJ8mAxSULiVwP82un4MVDZrSt4LMOkIg/iqk3ny23TopBt4trJQtN2trnbvaKL7cHRVsdNvR8Vf6z9GORaLst/iPzKTLUAOPvktUILhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2778
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCA1OjM3IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFtIDIwMjAtMTAtMDEgMTY6MjUsIHNjaHJpZWIg
VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4gT24gMTAvMS8yMCA1OjEyIFBNLCBNaWNo
YWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pj4NCj4+PiBBbSAyMDIwLTEwLTAxIDE2OjA2LCBzY2hyaWViIFR1ZG9yLkFtYmFydXNA
bWljcm9jaGlwLmNvbToNCj4+Pj4gT24gMTAvMS8yMCAzOjI4IFBNLCBNaWNoYWVsIFdhbGxlIHdy
b3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cNCj4+Pj4+IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4+Pj4+DQo+Pj4+PiBUaGlzIGlzIGNvbnNpZGVyZWQgYmFkIGZvciB0aGUgZm9sbG93aW5n
IHJlYXNvbnM6DQo+Pj4+PiDCoCgxKSBXZSBvbmx5IHN1cHBvcnQgdGhlIGJsb2NrIHByb3RlY3Rp
b24gd2l0aCBCUG4gYml0cyBmb3Igd3JpdGUNCj4+Pj4+IMKgwqDCoMKgIHByb3RlY3Rpb24uIE5v
dCBhbGwgQXRtZWwgcGFydHMgc3VwcG9ydCB0aGlzLg0KPj4+Pj4gwqAoMikgTmV3bHkgYWRkZWQg
Zmxhc2ggY2hpcCB3aWxsIGF1dG9tYXRpY2FsbHkgaW5oZXJpdCB0aGUgImhhcw0KPj4+Pj4gwqDC
oMKgwqAgbG9ja2luZyIgc3VwcG9ydCBhbmQgdGh1cyBuZWVkcyB0byBleHBsaWNpdGx5IHRlc3Rl
ZC4gQmV0dGVyDQo+Pj4+PiDCoMKgwqDCoCBiZSBvcHQtaW4gaW5zdGVhZCBvZiBvcHQtb3V0Lg0K
Pj4+Pj4gwqAoMykgVGhlcmUgYXJlIGFscmVhZHkgc3VwcG9ydGVkIGZsYXNoZXMgd2hpY2ggZG9u
J3Qgc3VwcG9ydCB0aGUNCj4+Pj4+IGxvY2tpbmcNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgc2No
ZW1lLiBTbyBJIGFzc3VtZSB0aGlzIHdhc24ndCBwcm9wZXJseSB0ZXN0ZWQgYmVmb3JlDQo+Pj4+
PiBhZGRpbmcNCj4+Pj4+IHRoYXQNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgY2hpcDsgd2hpY2gg
ZW5mb3JjZXMgbXkgcHJldmlvdXMgYXJndW1lbnQgdGhhdCBsb2NraW5nDQo+Pj4+PiBzdXBwb3J0
IHNob3VsZA0KPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoCBiZSBhbiBvcHQtaW4uDQo+Pj4+Pg0KPj4+
Pj4gUmVtb3ZlIHRoZSBnbG9iYWwgZmxhZyBhbmQgYWRkIGluZGl2aWR1YWwgZmxhZ3MgdG8gYWxs
IGZsYXNoZXMNCj4+Pj4+IHdoaWNoIHN1cHBvcnRzIEJQIGxvY2tpbmcuIEluIHBhcnRpY3VsYXIg
dGhlIGZvbGxvd2luZyBmbGFzaGVzDQo+Pj4+PiBkb24ndCBzdXBwb3J0IHRoZSBCUCBzY2hlbWU6
DQo+Pj4+PiDCoC0gQVQyNkYwMDQNCj4+Pj4+IMKgLSBBVDI1U0wzMjENCj4+Pj4+IMKgLSBBVDQ1
REIwODFEDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFl
bEB3YWxsZS5jYz4NCj4+Pj4+IC0tLQ0KPj4+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL2F0bWVs
LmMgfCAyOCArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+PiDCoDEgZmlsZSBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+Pj4+IGIvZHJpdmVycy9tdGQv
c3BpLW5vci9hdG1lbC5jDQo+Pj4+PiBpbmRleCAzZjVmMjFhNDczYTYuLjQ5ZDM5MmM2YzhiYyAx
MDA2NDQNCj4+Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvYXRtZWwuYw0KPj4+Pj4gKysr
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9hdG1lbC5jDQo+Pj4+PiBAQCAtMTAsMzcgKzEwLDI3IEBA
DQo+Pj4+Pg0KPj4+Pj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gYXRtZWxfcGFy
dHNbXSA9IHsNCj4+Pj4+IMKgwqDCoMKgwqDCoMKgIC8qIEF0bWVsIC0tIHNvbWUgYXJlIChjb25m
dXNpbmdseSkgbWFya2V0ZWQgYXMgIkRhdGFGbGFzaCINCj4+Pj4+ICovDQo+Pj4+PiAtwqDCoMKg
wqDCoMKgIHsgImF0MjVmczAxMCIswqAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LMKgwqAg
NCwgU0VDVF80SykNCj4+Pj4+IH0sDQo+Pj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVmczA0MCIs
wqAgSU5GTygweDFmNjYwNCwgMCwgNjQgKiAxMDI0LMKgwqAgOCwgU0VDVF80SykNCj4+Pj4+IH0s
DQo+Pj4+PiArwqDCoMKgwqDCoMKgIHsgImF0MjVmczAxMCIswqAgSU5GTygweDFmNjYwMSwgMCwg
MzIgKiAxMDI0LMKgwqAgNCwgU0VDVF80SyB8DQo+Pj4+PiBTUElfTk9SX0hBU19MT0NLKSB9LA0K
Pj4+Pj4gK8KgwqDCoMKgwqDCoCB7ICJhdDI1ZnMwNDAiLMKgIElORk8oMHgxZjY2MDQsIDAsIDY0
ICogMTAyNCzCoMKgIDgsIFNFQ1RfNEsgfA0KPj4+Pj4gU1BJX05PUl9IQVNfTE9DSykgfSwNCj4+
Pj4NCj4+Pj4gYWZ0ZXIgYSBxdWljayBsb29rIGluIHRoZSBkYXRhc2hlZXRzIG9mIHRoZXNlIGZs
YXNoZXMsIEkgc3VzcGVjdCB0aGF0DQo+Pj4+IHdoYXQgd2UgaGF2ZSBub3cgaW4gdGhlIFNQSSBO
T1IgY29yZSBmb3IgU1IgbG9ja2luZyBkb2VzIG5vdCB3b3JrIGZvcg0KPj4+PiB0aGVtLiBUaGV5
IHByb2JhYmx5IHN1cHBvcnRlZCBqdXN0ICJ1bmxvY2sgYWxsIiwgY2xlYXJpbmcgYWxsIHRoZQ0K
Pj4+PiBCUCBiaXRzLiBBbnl3YXksIGRpZmZlcmVudCBwcm9ibGVtLg0KPj4+Pj4NCj4+Pj4+IC3C
oMKgwqDCoMKgwqAgeyAiYXQyNWRmMDQxYSIsIElORk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCzC
oMKgIDgsIFNFQ1RfNEspDQo+Pj4+PiB9LA0KPj4+Pj4gLcKgwqDCoMKgwqDCoCB7ICJhdDI1ZGYz
MjEiLMKgIElORk8oMHgxZjQ3MDAsIDAsIDY0ICogMTAyNCzCoCA2NCwgU0VDVF80SykNCj4+Pj4+
IH0sDQo+Pj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjMyMWEiLCBJTkZPKDB4MWY0NzAxLCAw
LCA2NCAqIDEwMjQswqAgNjQsIFNFQ1RfNEspDQo+Pj4+PiB9LA0KPj4+Pj4gLcKgwqDCoMKgwqDC
oCB7ICJhdDI1ZGY2NDEiLMKgIElORk8oMHgxZjQ4MDAsIDAsIDY0ICogMTAyNCwgMTI4LCBTRUNU
XzRLKQ0KPj4+Pj4gfSwNCj4+Pj4+ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWRmMDQxYSIsIElORk8o
MHgxZjQ0MDEsIDAsIDY0ICogMTAyNCzCoMKgIDgsIFNFQ1RfNEsgfA0KPj4+Pj4gU1BJX05PUl9I
QVNfTE9DSykgfSwNCj4+Pj4NCj4+Pj4gdGhpcyBvbmUgZG9lcyBub3Qgc3VwcG9ydCBCUCBsb2Nr
aW5nOg0KPj4+PiBodHRwczovL3d3dy5hZGVzdG90ZWNoLmNvbS93cC1jb250ZW50L3VwbG9hZHMv
ZG9jMzY2OC5wZGYNCj4+Pj4NCj4+Pj4+ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWRmMzIxIizCoCBJ
TkZPKDB4MWY0NzAwLCAwLCA2NCAqIDEwMjQswqAgNjQsIFNFQ1RfNEsgfA0KPj4+Pj4gU1BJX05P
Ul9IQVNfTE9DSykgfSwNCj4+Pj4NCj4+Pj4gbmVpdGhlciB0aGlzIG9uZToNCj4+Pj4gaHR0cHM6
Ly9kYXRhc2hlZXQub2N0b3BhcnQuY29tL0FUMjVERjMyMS1TM1UtQXRtZWwtZGF0YXNoZWV0LTg3
MDA4OTYucGRmDQo+Pj4+DQo+Pj4+PiArwqDCoMKgwqDCoMKgIHsgImF0MjVkZjMyMWEiLCBJTkZP
KDB4MWY0NzAxLCAwLCA2NCAqIDEwMjQswqAgNjQsIFNFQ1RfNEsgfA0KPj4+Pj4gU1BJX05PUl9I
QVNfTE9DSykgfSwNCj4+Pj4NCj4+Pj4gbm9yIHRoaXMgb25lOg0KPj4+PiBodHRwczovL3d3dy5h
ZGVzdG90ZWNoLmNvbS93cC1jb250ZW50L3VwbG9hZHMvZG9jMzY4Ni5wZGYNCj4+Pj4NCj4+Pj4+
ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWRmNjQxIizCoCBJTkZPKDB4MWY0ODAwLCAwLCA2NCAqIDEw
MjQsIDEyOCwgU0VDVF80SyB8DQo+Pj4+PiBTUElfTk9SX0hBU19MT0NLKSB9LA0KPj4+Pg0KPj4+
PiBub3IgdGhpcyBvbmU6DQo+Pj4+IGh0dHBzOi8vd3d3LmFkZXN0b3RlY2guY29tL3dwLWNvbnRl
bnQvdXBsb2Fkcy9kb2MzNjgwLnBkZg0KPj4+Pg0KPj4+PiBJIHN0b3AgaGVyZS4NCj4+Pg0KPj4+
IFRoZXNlIGFyZSBhbGwgdGhlIG9uZXMgd2hpY2ggdXNlIHRoZSBnbG9iYWwgdW5sb2NrLiBJIGNh
bm5vdCBqdXN0IHNraXANCj4+PiB0aGUgSEFTX0xPQ0sgYml0IGhlcmUsIGJlY2F1c2Ugb3RoZXJ3
aXNlIHRoaXMgcGF0Y2ggd291bGRuJ3QgYmUNCj4+PiBiYWNrd2FyZHMNCj4+PiBjb21wYXRpYmUu
IFllcyBJIG1pc3NlZCB0aGF0IGluIHRoZSBjb21taXQgbG9nLCBteSBiYWQuDQo+Pj4NCj4+DQo+
PiBObyB3b3JyaWVzLg0KPj4NCj4+ICJ1bmxvY2sgYWxsIGF0IGJvb3QiIGp1c3QgY2xlYXJlZCB0
aGUgU1IgYml0cy4gQ2xlYXJpbmcgdGhlIFNSIGJpdHMNCj4+IHVubG9ja3MNCj4+IHRoZXNlIGZs
YXNoZXM/DQo+IA0KPiBDbGVhcmluZyBiaXRzIDUsNCwzLDIsIHllcyAod2l0aCBTUFJMPTApDQoN
Cm9oLCB0aGUgaG9ycm9yLiBUaG9zZSBiaXRzIGFyZSBkZXNjcmliZWQgYXMgUmVhZCBPbmx5IHdo
ZW4gZGVzY3JpYmluZw0KU3RhdHVzIFJlZ2lzdGVyLiBJJ2xsIHJlLXJlYWQgdGhlIGRhdGFzaGVl
dHMuDQoNCj4gDQo+IMKgIENvbnZlcnNlbHksIHRvIHBlcmZvcm0gYSBHbG9iYWwgVW5wcm90ZWN0
LCB0aGUgc2FtZSBXUCBhbmQgU1BSTA0KPiBjb25kaXRpb25zDQo+IMKgIG11c3QgYmUgbWV0IGJ1
dCB0aGUgc3lzdGVtIG11c3Qgd3JpdGUgYSBMb2dpY2FsIDAgdG8gYml0cyA1LCA0LCAzLCBhbmQN
Cj4gMg0KPiDCoCBvZiB0aGUgZmlyc3QgYnl0ZSBvZiB0aGUgU3RhdHVzIFJlZ2lzdGVyLg0KDQpP
Sy4gSSBzZWUgdGhpcyB1bmRlciAiR2xvYmFsIHVucHJvdGVjdCIgc2VjdGlvbi4gU3RyYW5nZS4g
V2lsbCBnZXQgYmFjayB0byB5b3UuDQoNCkNoZWVycywNCnRhDQo+IA0KPiBUaGlzIHdpbGwgaG9w
ZWZ1bGx5IGJlIGNsZWFuZWQgdXAgYnkgbXkgIm10ZDogc3BpLW5vcjoga2VlcCBsb2NrIGJpdHMg
aWYNCj4gdGhleQ0KPiBhcmUgbm9uLXZvbGF0aWxlIiBwYXRjaC4NCj4gDQo+IC1taWNoYWVsDQoN
Cg==
