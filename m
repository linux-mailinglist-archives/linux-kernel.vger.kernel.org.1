Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0202FD304
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbhATOOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:14:35 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:64590 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388272AbhATNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611147842; x=1642683842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rAsgC8XDcV/RPuv5CcyY5SdKzJSf7D6s9PwFs6llirU=;
  b=tJQn0nd/pXjCsK3/KnMOCaQ/Oq6Po3bOD9LT0qOOBdX4Hyk1v2SYiWA4
   2qN4uy7crQucWnf5umBb68dfqPEBFCDovR7M7aN7XE1lhhmTPQ/lz0LBQ
   h1X6pXx7sn6yAZVj3Z3hRi/3sUxQEAdedDSsbNsrhlwuuk5/NdYqDYr+y
   B4j6Ut7bAnM//gabZvL6cPUhW9WVOWrqwY200U1N/d9baNKWjCOWMh7IQ
   2b7eL/7YjXGtgqGZZg1ss4RzVR1KiqaLzkg+WMivIWf/KwvTBNBvR94Pk
   q6Wtcz4I+nbwPmHpimycBKz4sai1JNGa0wJY51t7r/tijymzh+tTdPrUZ
   g==;
IronPort-SDR: s77K5eSt5i9fBugt+9bBUsnbvRP+i5w5IJ4O1kZUzUr846zNvk8F1Fat3qdQWLMmFXsgGaNKAd
 dmIk866jIcHR/2pmRKMgsiqL3zAf4l0b5XZO4jMlUZuvMPmrtTy/tmUDk3FL4xX3hGUBLQK4VR
 aWyAJj5VIIRZT7JYKLF1iyVusA2e1T6Onja37+jEj1DbpDyamHThhhp2wTMu49Oiv49+4UUquZ
 aDeTTwnIp2GImB4vNfHLVGcBKMmrKcI50FHz0Ue60WPungvz2ApnWgla49uzLMalGDrtmtjPvT
 pdw=
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="106101154"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 06:02:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 06:02:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 20 Jan 2021 06:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hm4Z2oxUA1MSTqSXTfpvKz7UMq7e4e4RpYDEzDH0FrsM7SRC+qXpJH/weG8Ke+iD78aGCyAMLgsZyA7C2cih2EQie8/Bxq2zupjnbFI7S2FlZxKT6FdLxARSutCl2i7A8LRqh8+GrVRK2tDJXoUx6zKAo8SrnHdWu+6S5qCA1u44q6qs4M+vYeJp8jVmXxJlvvFQ73ZoZ0xoWySF955GWTXbSuUgSdwyzdamwyc9BI8iCKAcHeNnA1MHU8LSicyFsAHLp0H+Z9e+y7tNn0DfNI+2immlmcmLfjwPOiEozbT/dKdIP9m8qrdCTlPTePnOFkZYWW3aHq1PkVwbsLHSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAsgC8XDcV/RPuv5CcyY5SdKzJSf7D6s9PwFs6llirU=;
 b=e9KheeJv7tsALIt7aSGplw+JurOt0s16tlU2M+yqIggRtXhEJaVwSRcxdzJ6dWK+Il6VOfGdmTRccBplC9ATKBCr6Z0kXlJpb9sVQr9CePhr8LqCxNKpHvF7QAsqRh5e8wQ+K/eIFOlsGqtglsUMm0Vqpm9N/lX71z58dUghPqH164iedS05VNOYMUroyjN6eRa8xGbmSiSotl7THyb8Vlidk9QDHUCFQyoCcrZNPHWQqGjhYskpYkllyzGEPoPXk4q3crMVSbfz/8wRvBmj7D5uZke+imspZd8flHYjtQ+8oJYHh36Phrp1g96Cu5S0d5We8K493C+2Smj7VLiOXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAsgC8XDcV/RPuv5CcyY5SdKzJSf7D6s9PwFs6llirU=;
 b=AOvoettrdgm4efbI0U9WGIRCD+rzfrMV2rLJ2fPgTO/2EJR8WJ3iRyRY/6wqhvsIDVbeJBpswyvioO95PCJNTK9KupxPPZrMfoz3T3IlOK6Wo8ZmuxWuLtZJ6rsPy7tYii8OCp1XGBu1dUWT2sWhzVOGp3CTxu5IITV0fliHodk=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2941.namprd11.prod.outlook.com (2603:10b6:805:dc::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 13:02:21 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 13:02:21 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <vigneshr@ti.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <Kavyasree.Kotagiri@microchip.com>, <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: sst: Add support for Global Unlock on
 sst26vf
Thread-Topic: [PATCH 2/2] mtd: spi-nor: sst: Add support for Global Unlock on
 sst26vf
Thread-Index: AQHW7yx9bcFo09HT2UCZICu/WmasJQ==
Date:   Wed, 20 Jan 2021 13:02:21 +0000
Message-ID: <fb42e33b-2ad2-9607-0540-138bfd70c9ba@microchip.com>
References: <20210120105411.254890-1-tudor.ambarus@microchip.com>
 <20210120105411.254890-2-tudor.ambarus@microchip.com>
 <20210120122940.2xkiwghtszzyylnm@ti.com>
In-Reply-To: <20210120122940.2xkiwghtszzyylnm@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c4fa5ed-c71d-46e6-fff6-08d8bd439fe0
x-ms-traffictypediagnostic: SN6PR11MB2941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2941617AEC306029F6130F2CF0A20@SN6PR11MB2941.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5uHJtgH5Nq2r9qkb8DLrmrRCp5a88Njn0YzfG2J6yRyMlfrAeT1Ib7v3MTcou1fi6ZR0V1f5Pr1h/VNau2wV1TSTv87MW+BEIgnL10CZY5hEnO00Jv4XVxtonPImJ3kOtGyG18RUyhvTBsrkZZOA1ryEUFTptrtQicSBExTgwlRs1QIeY6H6QoO27f0ucENkeSCJuzubcSzDQA8781Cpg2dolAFFZmam1gmiBkx+bssnL5SEdWe+oFEaPxns8xUbvYzdYl9x7BcTASuEooTANHjLEX2p1jQde3BpyZyDKK/YZ+tH9qNQHXPod5Y48ybTt38IIH7fM3aZQ45jUW66LbALI5YDcBJ+moEj8j0iRn+NKqcn64KsPVDv4PsAeWXVb3cKVa6hcKpwoyRBetDlB9+N1fUI8fmx6MDNQlEoE/j56K11Z3Uv3vV+hmyhvwpuk/mVkD44i09YH+I3UFVF1sUu5ebQWHwHjdNpOsmYQ44QJIpEtKilhALZvX22IKsZcgOPIOEFeEjJc2mg9JJZnjxbKeJKf1YxOaQ3u9v0msEi8FxkSJJ05tou6wmQG2z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(26005)(54906003)(8936002)(498600001)(6506007)(53546011)(31696002)(66946007)(66556008)(71200400001)(64756008)(66446008)(4326008)(66476007)(86362001)(6916009)(91956017)(6486002)(2616005)(8676002)(966005)(76116006)(83380400001)(5660300002)(36756003)(2906002)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?NW9rckM4SmNRTUFpczN0YWc5M1BmUzBDTHRmQUN3cFFOeHY3a1ZUalVJSUVR?=
 =?utf-8?B?M3V5WVNqTWJSNHZqaGZsdnZ4SjdqcXhmbkFGZ3dWQWFZOXFSNG52TjJ2STEw?=
 =?utf-8?B?M0RPaHV6dVNqelpoTzlzWllDU29WWmR3QXptU1BpNEo1ZGxUeG1HcDA2aFZ3?=
 =?utf-8?B?SXFOa0lZM0tPMy9GNkxncU44NW9welZrK1EzSjV3NUpzWDQzQ3hjT2dVU0Vp?=
 =?utf-8?B?c0hOaEtHN0FvTXFCcHAwQXdLK09IbEFKRmRDa1JoY2x2Rlc3dUpXSlo4NzFJ?=
 =?utf-8?B?a0RQUFc5QVhMVmU2RC9QQnl0N2VFUW0wOHZWRzlXL3VXZkUybTdNQSs2a05G?=
 =?utf-8?B?cE54TVNyLzV6ZjQ2ZDZSOXN2YUZZQW9pV2dSYlVjTjRuSUZKSGswSkhlUnRY?=
 =?utf-8?B?U29zZUFabGxubGFRY3orWGVRbGpyOUNIRllFc0RnM29yYkFlM1RkM0FPYWhS?=
 =?utf-8?B?NUtmc2ZSRmVKQ0dKa2N4bHkzUVJKZUFoRncvWUl5amR3b3g0Ly92Q2FDTmFu?=
 =?utf-8?B?TjNnRzQyY2FoT0E5WW1wVjIwYkJJcGwzREFnNm1nbGFUMC9DOUZoWGFIbFNx?=
 =?utf-8?B?enlBYWlUY3FjeUd6VDFIOCt3aXdGakVyRUwra3RDbklNSzIvUHN5aG1LZGMw?=
 =?utf-8?B?dHhYR050OS9PdVlzcDQ1djkrVzNmSzM3dTJjUFlNbXVJc29zTGFvY2N6WkNF?=
 =?utf-8?B?d2tzcWhndTRLQVc0TGJsakV6bkllWjlWbzR0MEpwL216YkZEQmdsYzYvWmFY?=
 =?utf-8?B?a2s2MDIyZFE5UWQyVVEyS0wrT0hyTmw5U1R5ZnJSMXlCdHJKNWpFcURFeFJr?=
 =?utf-8?B?UUNrckJaT1J3dUFqYzNjR2NKWnhvUk83Q3ZiUEgrcnNod2VRcTEwS3pzRUkz?=
 =?utf-8?B?RDlxYXgramJhS1RqZ0tWTkUrMFBQUEJiRW5iVzVvQk1PblJ6SkJhRlFnNEN4?=
 =?utf-8?B?NkE5OTNrNVpzUHpoMEp2KzFOWEFrMGdCZTVrN0ZzcHlKZ1VoZ09UTk00UDNo?=
 =?utf-8?B?R1g4SUsyOTcyelc4Q2hJYVdIM1Q1T2hNbUt2c2dqS3JQRTBKUnp4UytZckpG?=
 =?utf-8?B?TWxKbGZ6TC9uZVJVdXhoa3hBTzdIOGZHN2ZyMVJDTHZIMDJWenI3ZFZnOGVu?=
 =?utf-8?B?YUZwdFZ0ZGk2VTV6SmNDMHVIUXlpbmJnbEd6Wjk2ZEJJYmpGTjF4eFRzQ0pR?=
 =?utf-8?B?M09wNFA3QjY0djY0V2VabmFENXRtM1dRRU5IdUQzSFZVR1hxaEtnZThQNmlZ?=
 =?utf-8?B?V2tHT2RnR04xemZmc0h4Ri9qK1VpdGtCaVlFTjFkS3VLcHhqcHRidmg5RU1M?=
 =?utf-8?B?VnhpazBNYVcwTU1SNHQxTnp2N2FocmYxeW03ZzR5TzZWWEcxTExaZFNVeWYr?=
 =?utf-8?Q?t+/BvwgJBWJBEUhwLi2isHIi8btHG75c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C32A84A273DB0B4685178DC4D95992ED@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4fa5ed-c71d-46e6-fff6-08d8bd439fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 13:02:21.4302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXuR9QFXVSMHFFQwQqRtLb9TAz63waynOwpL/4hkDD0nVTpqZYsJmyAzs/N8FTr4prI4vm7o6aAJ2ZkMe3LLPYeehX2Yg4Gof3Ja4DvYi8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2941
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMC8yMSAyOjI5IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBUdWRvciwNCj4gDQo+IE9uIDIwLzAxLzIx
IDEyOjU0UE0sIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBFdmVuIGlmIHNzdDI2dmYgc2hhcmVz
IHRoZSBTUElOT1JfT1BfR0JVTEsgb3Bjb2RlIHdpdGgNCj4+IE1hY3Jvbml4IChleC4gTVgyNVUx
MjgzNUYpIGFuZCBXaW5ib3VuZCAoZXguIFcyNVExMjhGViksDQo+PiBpdCBoYXMgaXRzIG93biBJ
bmRpdmlkdWFsIEJsb2NrIFByb3RlY3Rpb24gc2NoZW1lLCB3aGljaA0KPj4gaXMgYWxzbyBjYXBh
YmxlIHRvIHJlYWQtbG9jayBpbmRpdmlkdWFsIHBhcmFtZXRlciBibG9ja3MuDQo+PiBUaHVzIHRo
ZSBzc3QyNnZmJ3MgSW5kaXZpZHVhbCBCbG9jayBQcm90ZWN0aW9uIHNjaGVtZSB3aWxsDQo+PiBy
ZXNpZGUgaW4gdGhlIHNzdC5jIG1hbnVmYWN0dXJlciBkcml2ZXIuDQo+Pg0KPj4gQWRkIHN1cHBv
cnQgdG8gdW5sb2NrIHRoZSBlbnRpcmUgZmxhc2ggbWVtb3J5LiBUaGUgZGV2aWNlDQo+PiBpcyB3
cml0ZS1wcm90ZWN0ZWQgYnkgZGVmYXVsdCBhZnRlciBhIHBvd2VyLW9uIHJlc2V0IGN5Y2xlDQo+
PiAodm9sYXRpbGUgc29mdHdhcmUgcHJvdGVjdGlvbiksIGluIG9yZGVyIHRvIGF2b2lkIGluYWR2
ZXJ0ZW50DQo+PiB3cml0ZXMgZHVyaW5nIHBvd2VyLXVwLiBDb3VsZCBkbyBhbiBlcmFzZSwgd3Jp
dGUsIHJlYWQgYmFjaywNCj4+IGFuZCBjb21wYXJlIHdoZW4gTVREX1NQSV9OT1JfU1dQX0RJU0FC
TEVfT05fVk9MQVRJTEU9eS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBUdWRvciBBbWJhcnVzIDx0
dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL210ZC9zcGkt
bm9yL3NzdC5jIHwgMzggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4+
ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zc3QuYyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3Ivc3N0LmMNCj4+IGluZGV4IDAwZTQ4ZGEwNzQ0YS4uMWNkMmEzNjBjNDFlIDEwMDY0NA0K
Pj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zc3QuYw0KPj4gKysrIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9zc3QuYw0KPj4gQEAgLTgsNiArOCwzOSBAQA0KPj4NCj4+ICAjaW5jbHVkZSAiY29y
ZS5oIg0KPj4NCj4+ICtzdGF0aWMgaW50IHNzdDI2dmZfbG9jayhzdHJ1Y3Qgc3BpX25vciAqbm9y
LCBsb2ZmX3Qgb2ZzLCB1aW50NjRfdCBsZW4pDQo+PiArew0KPj4gKyAgICAgcmV0dXJuIC1FT1BO
T1RTVVBQOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHNzdDI2dmZfdW5sb2NrKHN0cnVj
dCBzcGlfbm9yICpub3IsIGxvZmZfdCBvZnMsIHVpbnQ2NF90IGxlbikNCj4+ICt7DQo+PiArICAg
ICBpZiAoIW9mcyAmJiBsZW4gPT0gbm9yLT5wYXJhbXMtPnNpemUpDQo+IA0KPiBOaXRwaWNrOiBv
ZnMgaXMgbm90IGEgYm9vbGVhbiB2YWx1ZS4gRG9uJ3QgdHJlYXQgaXQgYXMgc3VjaC4gKG9mcyA9
PSAwDQo+ICYmIGxlbiA9PSBub3ItPnBhcmFtcy0+c2l6ZSkgbWFrZXMgdGhlIGludGVudCBtdWNo
IGNsZWFyZXIuDQoNCkkgYWdyZWUsIHdpbGwgY2hhbmdlLiBDaGVlcnMsDQp0YQ0KDQo+IA0KPj4g
KyAgICAgICAgICAgICByZXR1cm4gc3BpX25vcl9nbG9iYWxfYmxvY2tfdW5sb2NrKG5vcik7DQo+
PiArDQo+PiArICAgICByZXR1cm4gLUVPUE5PVFNVUFA7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRp
YyBpbnQgc3N0MjZ2Zl9pc19sb2NrZWQoc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IG9mcywg
dWludDY0X3QgbGVuKQ0KPj4gK3sNCj4+ICsgICAgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4+ICt9
DQo+PiArDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfbm9yX2xvY2tpbmdfb3BzIHNzdDI2
dmZfbG9ja2luZ19vcHMgPSB7DQo+PiArICAgICAubG9jayA9IHNzdDI2dmZfbG9jaywNCj4+ICsg
ICAgIC51bmxvY2sgPSBzc3QyNnZmX3VubG9jaywNCj4+ICsgICAgIC5pc19sb2NrZWQgPSBzc3Qy
NnZmX2lzX2xvY2tlZCwNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyB2b2lkIHNzdDI2dmZfZGVm
YXVsdF9pbml0KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiArew0KPj4gKyAgICAgbm9yLT5wYXJh
bXMtPmxvY2tpbmdfb3BzID0gJnNzdDI2dmZfbG9ja2luZ19vcHM7DQo+PiArfQ0KPj4gKw0KPj4g
K3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc3BpX25vcl9maXh1cHMgc3N0MjZ2Zl9maXh1cHMgPSB7DQo+
PiArICAgICAuZGVmYXVsdF9pbml0ID0gc3N0MjZ2Zl9kZWZhdWx0X2luaXQsDQo+PiArfTsNCj4+
ICsNCj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IGZsYXNoX2luZm8gc3N0X3BhcnRzW10gPSB7DQo+
PiAgICAgICAvKiBTU1QgLS0gbGFyZ2UgZXJhc2Ugc2l6ZXMgYXJlICJvdmVybGF5cyIsICJzZWN0
b3JzIiBhcmUgNEsgKi8NCj4+ICAgICAgIHsgInNzdDI1dmYwNDBiIiwgSU5GTygweGJmMjU4ZCwg
MCwgNjQgKiAxMDI0LCAgOCwNCj4+IEBAIC0zOSw4ICs3Miw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZmxhc2hfaW5mbyBzc3RfcGFydHNbXSA9IHsNCj4+ICAgICAgIHsgInNzdDI2dmYwMTZiIiwg
SU5GTygweGJmMjY0MSwgMCwgNjQgKiAxMDI0LCAzMiwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQpIH0sDQo+PiAgICAgICB7ICJzc3Qy
NnZmMDY0YiIsIElORk8oMHhiZjI2NDMsIDAsIDY0ICogMTAyNCwgMTI4LA0KPj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8DQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgU1BJX05PUl9RVUFEX1JFQUQpIH0sDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05P
Ul9RVUFEX1JFQUQgfA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfSEFT
X0xPQ0sgfCBTUElfTk9SX1NXUF9JU19WT0xBVElMRSkNCj4+ICsgICAgICAgICAgICAgLmZpeHVw
cyA9ICZzc3QyNnZmX2ZpeHVwcyB9LA0KPj4gIH07DQo+Pg0KPj4gIHN0YXRpYyBpbnQgc3N0X3dy
aXRlKHN0cnVjdCBtdGRfaW5mbyAqbXRkLCBsb2ZmX3QgdG8sIHNpemVfdCBsZW4sDQo+PiAtLQ0K
Pj4gMi4yNS4xDQo+Pg0KPj4NCj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXw0KPj4gTGludXggTVREIGRpc2N1c3Npb24gbWFpbGluZyBsaXN0
DQo+PiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10
ZC8NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFByYXR5dXNoIFlhZGF2DQo+IFRleGFzIEluc3Ry
dW1lbnRzIEluZGlhDQo+IA0KDQo=
