Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4218F2C72FE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgK1Vt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:49:57 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:24253 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgK1SCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:02:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606586556; x=1638122556;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=P8/pe3ruIH0FqiTY/DGUDJs6U4GX+jFB4a5qWn9L2+0=;
  b=uwHWEhyvso5WiNzE3xGG1yNihB82zEmSGSONsOyfRJTtkUCjMY+PX1Og
   Ra6Z4yYrQAU4SO6F0Mx9mpNpDpw9/fCPKI3pGoXuvsqrfts+36dMcMqBc
   UcXN8u55Oed7M8hbUgd1ofLafm0JfgLmCe+DD0c4h85I7FmOrmO1Geyks
   aIjx1RCUuu0jAKTAG50QgXbvR5Kbbo3MpaRPbL2LjBrRN7thYxb+4ga/b
   KhYfOKIPofW79tPP2+Z2f3njvK3dulIYDhzu7w7GzUOUlqfSqi5Gf11gF
   REG1VL3RQvAkO+8Q8+UjaIIEtEU9y2TUARnkQ/ynsdtsDz1Eg4i3jRGGG
   Q==;
IronPort-SDR: QWQSbJvYUnj7T6HBG1efrN3UN+bkn6ixAf0Fs1WQwT28pn9MPEcIR3T2Ot26Uo3s5BiNBJQrAH
 Q1Q22lk4QL2r9OeW2pqjWgsCtuVFvkycEPTh3fi6eMhyjHwyMrcIuyiJ069p+9czCVUGTnapsg
 W+fIbYt73duajsCqaHES4+TCeNPcmij86oKdlOrvtEp2oPybOuFlgS/apCBJCXmP1SyXwDUNbU
 wralCXTbxeUuZIQ0zYy0QLWUqftz+oXN8oEP73JN2JapkDDvttkRTyRLOSFVPjB9A3FWRX8qcQ
 jJk=
X-IronPort-AV: E=Sophos;i="5.78,377,1599548400"; 
   d="scan'208";a="97853979"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2020 03:58:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 28 Nov 2020 03:58:06 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Sat, 28 Nov 2020 03:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LidxHGIiFamCj9pumZ4CGArFrwXeAGWhLFfXeSsRJ8sEKsaJcr7zldKv4gK/Q6KiauKoBrvzl9vBDK7T1bBDUa9Ub1Thx25Vsqm56fFKEFsmoxyhlRlhLafgKB7P1FZdES/TDtvGMH6UFM9xa6vwxMpcYO9qVo5Jb7tgfnbSf8w592AOTRFm9HP1Mfg/D/3v4yXpC0t9JE8llAuMbsxAUj/ySKooNGCEJHJgPvir7TtGGG910W60/U1OhnoXP5muLsUlijP6Ifq+JAIF46PSIVt4vLWziikASOam2jMw6J6MBozirRNc9RzKoxKGoh0csb7mZNpFXCXMsnoEyvjHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8/pe3ruIH0FqiTY/DGUDJs6U4GX+jFB4a5qWn9L2+0=;
 b=bf0znYgAWszrkQ1HXAc12p+vz4CWYdtanvIg6yo+KEfLprW8VHe/o5Xfq7C7KKyV+nHqXZ6PXXPtSc/pYREsMHxLiROYX2Y2tRkD/EEBmlbvwhuIzRAez9QRKsT/FhRsJyKcuY1oVCbHJ3xLuhwg3cfkCUijM6mJGHXn3Yjl/CWBDsx9qSgqtyqMmBBGztF+3q7Us4TmgVAhMvM0X2xpVq/HLcdDrm+EJP4GN2g8DWriEsCIrwG8karASYUoyfRkbQXaMzWVjaLd+sNu5mAoYBDSrLEauXoVHuaGbEGvjIY59CM+2ox3Ec1gDPxpjqlwDAQv0ko86GpWyWjoWXJn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8/pe3ruIH0FqiTY/DGUDJs6U4GX+jFB4a5qWn9L2+0=;
 b=AcnsyAHo60FLwPd6wwelUNxSy1P47O4TUa91HBxV65uVto4ryN6bECVQUW9LyPwdgtagOwPx5adMmc9/gF38BgXkDlPFJM1mU+u87ri1l5dObV+k/7QSFNZd6xOm50eS1jXYKIFucxHbBziTZdU+xpGIVTZErQJ1RuyP8sWtuaA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2832.namprd11.prod.outlook.com (2603:10b6:805:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sat, 28 Nov
 2020 10:58:03 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3611.026; Sat, 28 Nov 2020
 10:58:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] UBI: Do not zero out EC and VID on ECC-ed NOR
 flashes
Thread-Topic: [PATCH v2 1/3] UBI: Do not zero out EC and VID on ECC-ed NOR
 flashes
Thread-Index: AQHWxXVXIQOfePlSqE2QYyUaWfStsQ==
Date:   Sat, 28 Nov 2020 10:58:02 +0000
Message-ID: <2f07715e-fe44-c5fd-6194-b74ba9f22545@microchip.com>
References: <20201118182459.18197-1-p.yadav@ti.com>
 <20201118182459.18197-2-p.yadav@ti.com>
In-Reply-To: <20201118182459.18197-2-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03bbe0d2-5d98-4ce9-3285-08d8938c7a4f
x-ms-traffictypediagnostic: SN6PR11MB2832:
x-microsoft-antispam-prvs: <SN6PR11MB28324D5376F68DB2E90F757AF0F70@SN6PR11MB2832.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iOpVQnELlw0W1OZ+BVuJ1eXhIs79jkG2YUIcZFbmZzV5dkwIhXLIE7+luIOyXOxk6R2Sgo84z3SDs8vg2OSHxKJfnpImk2n2/8axx/gL1C2bGgzWG6WY9ZU3YKomAT030qlntkpbv8tzfFk0ao3rapJPMfeKu4fLjovqd9ujcRM3dQGHvhu44ndT6Ro2QNGBZxV0pmoTn9U/Rov4TRTbo2s34jf4NLZG8ZP8qd3SXkk76I0j0yE3TIPlQsYXsBdxg4ib/3Vm8SbjV0Lp6WvPlTi7FslWI9cJ+qdoll29a4sOG19Ro2I8mVhmgfj2Y6aw8GUQHhXj7VIJOiJWtqNjswS+e+/SZbS3jKM9XWgIIQRsN1KOLeNvqsKKQ71bTPsC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(346002)(396003)(366004)(376002)(2616005)(83380400001)(6486002)(36756003)(31686004)(478600001)(86362001)(76116006)(316002)(6512007)(53546011)(71200400001)(64756008)(66946007)(66556008)(2906002)(66446008)(66476007)(110136005)(5660300002)(186003)(6506007)(26005)(31696002)(8676002)(8936002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?YkhUWTdycjJaZFA5ZHE1bFhHeGxocmp5UWgrYllMSDZ6Ykk5cFl1T0NLYUo0?=
 =?utf-8?B?eFlENXJXb2UxZjhJcDVLWjkxMWcyWXM3RWNKNExXKzFka2s2ZDB2RnVnK0VP?=
 =?utf-8?B?WnlRdkxYaUJvSys3TEtUd0c0NFNLN0pWZm9rbDNwTER5T1JsRHVDeGxpeFI5?=
 =?utf-8?B?TGx5M1Yza0hDMUFkNExmdVpBZllBKzBQVEZvanZxSHR6ZHgxemF6MTdvR1Ny?=
 =?utf-8?B?TlZ6L0ZueUFuaTFZemdZd1RQYXBadlBaTGxiSXUyNTZJSjZ3SmFRcVV6QW9F?=
 =?utf-8?B?SzdNelE5emwwZVQrSjFLRE1CVTI0OUxtNWRVYkQ4TnphcnZVTTgyRnMyL3Fk?=
 =?utf-8?B?WEVqM0JrcmdmVk8wQUQ1QWx1QkJTcGRsUGFYeUUwR2VtMWFhRTlRekZzSW5w?=
 =?utf-8?B?MWF0OUl6aDVxaEtBaTRjZ3BBZ1hEOUI2eVZ4WDgzMTZwUFUzNVd6L0hVMjFH?=
 =?utf-8?B?S1RGd0R6SkN3SkZITFA0cGJaallGNU5zK0s5WVdZbWMzWXJnQWlwUUhFS295?=
 =?utf-8?B?cXR1b1dzNnF4YU5lT1dCZ2xkaEZiQXczYzB0K1JTTmEyK2NkSDBmcUpCa0hw?=
 =?utf-8?B?NHlVbkJZWGJ0OTkrZmNYK01DT09aUnJsNGxsMVZLeTZ2RjlQTmllNEY0emlU?=
 =?utf-8?B?RWJrRHhoL1dLOWw3bU50VENmazJ1TW9vWkpxaDh2Yk81Q0kyUnNZNjdzQ2hP?=
 =?utf-8?B?Y0U1N1ZsMHZZWmNOVWROMFFPZUlxalFIY3E0KzRyMW9vR3dSUGN0aFJCWjVx?=
 =?utf-8?B?a0tIT1ZheFlRaTlxdVhGaG1Gbko0SnBFRVUzcXVtV3BCYm9kQTF0YjRRak81?=
 =?utf-8?B?SXo4TGoySk0vbVdFTWlCUmhtNG1INk9yQlBmT1I1TTJxUFA1QSszQVFTZ044?=
 =?utf-8?B?VXpmUGZ3akxaT0E0dVA0WEtrM2I0TEVQRW83U2dBMkdhMDFOb3RQNnVpTWtF?=
 =?utf-8?B?SG84clJIQ2tma0Zab245V3VMRHZxazF1ZCtoSUtuVldkOEVrOEZidE9UOTVu?=
 =?utf-8?B?K1hTazBKWm44b0Z2eUVraUk5ME9tSyszT094YjRUTDB0Rk5uZ0pKSXVoWVdF?=
 =?utf-8?B?OGJ4OEJYVDhvRVBKcnljd1FZQTJXWVg1Wm9MWno3N1RETFhzM0JIMFlkeWxm?=
 =?utf-8?B?WDk0Qk5pOThuLzhoeStad0kwVVUvUWFXLzJpVmlaSHhObFJqcUtWSElhdndz?=
 =?utf-8?B?M20zUnRGaHF3OXhuOHJIMWMwYXhnL2FoMS9xUzBsaTlld0pDbmMyS3Y4RnRS?=
 =?utf-8?B?a3Ixd1FVcktRU2xSbEowWlBqN2grSVZ2bEcxQ2xZakNjWWpRNjBpN0s1cnFC?=
 =?utf-8?Q?pGB2RX59LRoow=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBAF3EB6E166164C8D31D6DC0BF742F7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bbe0d2-5d98-4ce9-3285-08d8938c7a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2020 10:58:02.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ae6FeI+CH/gcNKzXnhRwbmSWZhvjhIoDq7Mrlp4wkxx1Yrr4FVmq5WGrkv5MXCtPP1tmQIAk1YhYfixbomjcNNy0n9N20G55igmKqAbmaXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2832
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTgvMjAgODoyNCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gRm9yIE5PUiBmbGFzaGVzIEVDIGFuZCBWSUQg
YXJlIHplcm9lZCBvdXQgYmVmb3JlIGFuIGVyYXNlIGlzIGlzc3VlZCB0bw0KPiBtYWtlIHN1cmUg
VUJJIGRvZXMgbm90IG1pc3Rha2VubHkgdHJlYXQgdGhlIFBFQiBhcyB1c2VkIGFuZCBhc3NvY2lh
dGUgaXQNCj4gd2l0aCBhbiBMRUIuDQo+IA0KPiBCdXQgb24gc29tZSBmbGFzaGVzLCBsaWtlIHRo
ZSBDeXByZXNzIFNlbXBlciBTMjggU1BJIE5PUiBmbGFzaCBmYW1pbHksDQo+IG11bHRpLXBhc3Mg
cGFnZSBwcm9ncmFtbWluZyBpcyBub3QgYWxsb3dlZCBvbiB0aGUgZGVmYXVsdCBFQ0Mgc2NoZW1l
Lg0KPiBUaGlzIG1lYW5zIHplcm9pbmcgb3V0IHRoZXNlIG1hZ2ljIG51bWJlcnMgd2lsbCByZXN1
bHQgaW4gdGhlIGZsYXNoDQo+IHRocm93aW5nIGEgcGFnZSBwcm9ncmFtbWluZyBlcnJvci4NCj4g
DQo+IERvIG5vdCB6ZXJvIG91dCBFQyBhbmQgVklEIGZvciBzdWNoIGZsYXNoZXMuIEEgd3JpdGVz
aXplID4gMSBpcyBhbg0KPiBpbmRpY2F0aW9uIG9mIGFuIEVDQy1lZCBmbGFzaC4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4NCj4gLS0tDQo+IA0K
PiBOb3RlczoNCj4gICAgIENoYW5nZXMgaW4gdjI6DQo+IA0KPiAgICAgLSBVc2UgbXRkLT53cml0
ZXNpemUgdG8gY2hlY2sgaWYgbXVsdGktcGFzcyBwcm9ncmFtbWluZyBjYW4gYmUgZG9uZQ0KPiAg
ICAgICBpbnN0ZWFkIG9mIHVzaW5nIE1URF9OT19NVUxUSV9QQVNTX1dSSVRFLg0KPiAgICAgLSBS
ZW1vdmUgdGhlIGFzc2VydGlvbiB0aGF0IGEgTk9SIGZsYXNoIG1vc3QgaGF2ZSB3cml0ZXNpemUg
b2YgMS4NCj4gDQo+ICBkcml2ZXJzL210ZC91YmkvYnVpbGQuYyB8IDQgKy0tLQ0KPiAgZHJpdmVy
cy9tdGQvdWJpL2lvLmMgICAgfCA5ICsrKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9t
dGQvdWJpL2J1aWxkLmMgYi9kcml2ZXJzL210ZC91YmkvYnVpbGQuYw0KPiBpbmRleCBlODViMDRl
OTcxNmIuLjI1ZmQ3ODE2YjFmNCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvdWJpL2J1aWxk
LmMNCj4gKysrIGIvZHJpdmVycy9tdGQvdWJpL2J1aWxkLmMNCj4gQEAgLTYyOCwxMCArNjI4LDgg
QEAgc3RhdGljIGludCBpb19pbml0KHN0cnVjdCB1YmlfZGV2aWNlICp1YmksIGludCBtYXhfYmVi
X3BlcjEwMjQpDQo+ICAgICAgICAgICAgICAgICB1YmktPmJhZF9wZWJfbGltaXQgPSBnZXRfYmFk
X3BlYl9saW1pdCh1YmksIG1heF9iZWJfcGVyMTAyNCk7DQo+ICAgICAgICAgfQ0KPiANCj4gLSAg
ICAgICBpZiAodWJpLT5tdGQtPnR5cGUgPT0gTVREX05PUkZMQVNIKSB7DQo+IC0gICAgICAgICAg
ICAgICB1YmlfYXNzZXJ0KHViaS0+bXRkLT53cml0ZXNpemUgPT0gMSk7DQo+ICsgICAgICAgaWYg
KHViaS0+bXRkLT50eXBlID09IE1URF9OT1JGTEFTSCkNCj4gICAgICAgICAgICAgICAgIHViaS0+
bm9yX2ZsYXNoID0gMTsNCj4gLSAgICAgICB9DQo+IA0KPiAgICAgICAgIHViaS0+bWluX2lvX3Np
emUgPSB1YmktPm10ZC0+d3JpdGVzaXplOw0KPiAgICAgICAgIHViaS0+aGRyc19taW5faW9fc2l6
ZSA9IHViaS0+bXRkLT53cml0ZXNpemUgPj4gdWJpLT5tdGQtPnN1YnBhZ2Vfc2Z0Ow0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvdWJpL2lvLmMgYi9kcml2ZXJzL210ZC91YmkvaW8uYw0KPiBp
bmRleCAxNGQ4OTBiMDBkMmMuLjJmMzMxMmMzMWU1MSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9t
dGQvdWJpL2lvLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvdWJpL2lvLmMNCj4gQEAgLTUzNSw3ICs1
MzUsMTQgQEAgaW50IHViaV9pb19zeW5jX2VyYXNlKHN0cnVjdCB1YmlfZGV2aWNlICp1YmksIGlu
dCBwbnVtLCBpbnQgdG9ydHVyZSkNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRVJPRlM7DQo+
ICAgICAgICAgfQ0KPiANCj4gLSAgICAgICBpZiAodWJpLT5ub3JfZmxhc2gpIHsNCj4gKyAgICAg
ICAvKg0KPiArICAgICAgICAqIElmIHRoZSBmbGFzaCBpcyBFQ0MtZWQgdGhlbiB3ZSBoYXZlIHRv
IGVyYXNlIHRoZSBFQ0MgYmxvY2sgYmVmb3JlIHdlDQo+ICsgICAgICAgICogY2FuIHdyaXRlIHRv
IGl0LiBCdXQgdGhlIHdyaXRlIGlzIGluIHByZXBhcmF0aW9uIHRvIGFuIGVyYXNlIGluIHRoZQ0K
PiArICAgICAgICAqIGZpcnN0IHBsYWNlLiBUaGlzIG1lYW5zIHdlIGNhbm5vdCB6ZXJvIG91dCBF
QyBhbmQgVklEIGJlZm9yZSB0aGUNCj4gKyAgICAgICAgKiBlcmFzZSBhbmQgd2UganVzdCBoYXZl
IHRvIGhvcGUgdGhlIGZsYXNoIHN0YXJ0cyBlcmFzaW5nIGZyb20gdGhlDQo+ICsgICAgICAgICog
c3RhcnQgb2YgdGhlIHBhZ2UuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKHViaS0+bm9y
X2ZsYXNoICYmIHViaS0+bXRkLT53cml0ZXNpemUgPT0gMSkgew0KDQpBcmUgdGhlcmUgYW55IFNQ
SSBOT1JzIHdpdGggRUNDIGJsb2NrIHNpemUgb2YgNCBieXRlcz8gU2hvdWxkIHdlIGNhbGwNCm5v
cl9lcmFzZV9wcmVwYXJlKCkgaW4gdGhpcyBjYXNlPw0KDQpBbnl3YXksIHRoZXJlJ3Mgbm9uZSBp
biBTUEkgTk9SIGFzIG9mIG5vdywgc286DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0
dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCj4gICAgICAgICAgICAgICAgIGVyciA9IG5v
cl9lcmFzZV9wcmVwYXJlKHViaSwgcG51bSk7DQo+ICAgICAgICAgICAgICAgICBpZiAoZXJyKQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiAtLQ0KPiAyLjI4LjANCj4g
DQoNCg==
