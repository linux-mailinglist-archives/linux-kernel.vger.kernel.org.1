Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1284E2C7319
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbgK1VuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:00 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:19957 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgK1SEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:04:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606586645; x=1638122645;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=XQ5Endbh612e6sTS1PflIxZ7qdtUzKpEnDu5/eHBP7k=;
  b=hcrUAcC2ARE/eC0hV+3nnLLMRwAzItwyssBF8CAYXkP31YUNCCwTd2aJ
   3TaTKiR/kcpxpyoPm/yOy/sZBwn7cxjsLMs7cWnwgSN8bOcbj0Yvcl0PO
   HExsMFU3QWT1c/GjwhBooZslQNKWt7n+EI9D+i72u4c/uJztc9SpFVtQW
   M3/7egCUvtgcppqWPZV/+imUG1n2XnlO3Q3WzvOs0cstgVXqeRNZ67Lwr
   HZGrA5aqcD66w4OIy7RaeACulHGFzdApQ3MVdzu/Bv6cSPZWhZF6HOhkc
   kzb49JcibVa6kJZP5SUBii/nM2huLC8BJxR4Ui5VMLu/jOdyJ0VO8XPsP
   A==;
IronPort-SDR: wxQPCn+ATf9O9CprgmCKc4LUyOrQzVz4UIeQHPPlbglbO6dVgMpTgJZJFRX72alI+5QLN7t/Mx
 6OCOO3fXNmCwavw52oCy9GsSL3IxknWoeN58EnDkr1LBPbLaI4g+2mm8R+S66alG2qFttTClqJ
 coerG2JzxBakOV0uSMgOF64LECOSrKMEwb35gw66bGTmX6x4fgGdgdI7BQy2K54+vWrSA8Nzxw
 GfyRUozXLu0fTIxGOvrdP+1/iVN2tXaxJkmd0Lx8gs0wb/O8+wnLs99Br7mQiQLTB8l7Ev+dKj
 2NQ=
X-IronPort-AV: E=Sophos;i="5.78,377,1599548400"; 
   d="scan'208";a="35282272"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2020 03:59:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 28 Nov 2020 03:59:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Sat, 28 Nov 2020 03:59:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd+DULFjZubZO0EG9pFhtb1rP9YTYzIpt6i/U83tmmRrWNH+RBa2bkdOvySvx7LGI7UQsJqdZKInVAkQY2qCDo8ZBQboA4RXLp3CB6k2h7De5DpHg3ckhl9oUaFolQjxaaKcOrNtpgvKEbZpC0Pz0wqeauKyLP7zZdVxis5krMbmHQR2zq1ByVaNt+MBb1JFfbXYi4agZhmhUTu45XcUxx2adSYeZKAdmZjyU63hH/kOH+nHFP5nZW+hVLBrUGW/FaRS0PvZ3guodzL3BEUpUA0qwesRAxAPowGKmDZaZmNzsukRqFydnTLiltHgcAgX8gyt6prJG0pbzggWimSNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ5Endbh612e6sTS1PflIxZ7qdtUzKpEnDu5/eHBP7k=;
 b=ERPWS7phehmpWJDhTrrKE6HdY6MF+aEopGZIRQyJWsOdAvEVIBoAxM7cTE/0/qlv9nXroM/ryuOLN3C1lFJMv1rS/O5wN4V3bHAQ3P4G+K0EOjsfMct9NzjlUUbDhNIGOUCxPnveCJDYbWwbLhAbjhTOOT/2/RJ6LrPsF+eyRDC1YglOBbDiMgpvFH2Ullh9aE4OuOzZ1jH6iHtYo1wnyqY3QkCgRONazk0z+Kj48gLwP8tjGlHDTgeg9wdJJXlVi1A0NSWTBMASME5dWisWqJF9LFm0SFk/4eoCkYwgdt2RVwt8Pj9m2XJ70dLlArykLkOnGdUN3p/If1vgJYsmyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQ5Endbh612e6sTS1PflIxZ7qdtUzKpEnDu5/eHBP7k=;
 b=OzjWZP9kPhQI2U31qI2/On7CH5yJgY22ieJdFTx3Rvn+KyrOFKvhWh08Mle7+oYcG4NDeUzqBYi3UotuGaeeVa6+CtlfE+eFDv6il233m5NmApTTzVkXshzFftKoFgYOzlXIrGBV+NgVqIWiobIAN2J40i9beHE/YLjMMO/iX3g=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2832.namprd11.prod.outlook.com (2603:10b6:805:5b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Sat, 28 Nov
 2020 10:59:30 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3611.026; Sat, 28 Nov 2020
 10:59:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] mtd: spi-nor: core: Allow flashes to specify MTD
 writesize
Thread-Topic: [PATCH v2 2/3] mtd: spi-nor: core: Allow flashes to specify MTD
 writesize
Thread-Index: AQHWxXWLYEkUgBO3xkCZq/N6gX5vSA==
Date:   Sat, 28 Nov 2020 10:59:30 +0000
Message-ID: <939dcad9-b556-ea3e-9eca-c008a86fd01b@microchip.com>
References: <20201118182459.18197-1-p.yadav@ti.com>
 <20201118182459.18197-3-p.yadav@ti.com>
In-Reply-To: <20201118182459.18197-3-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: ded96399-0819-4146-252e-08d8938caea5
x-ms-traffictypediagnostic: SN6PR11MB2832:
x-microsoft-antispam-prvs: <SN6PR11MB28326B985FDB7F380F938879F0F70@SN6PR11MB2832.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V0OiGApRGHedECaq96YBhDUu2gD8HtKHR0QFHhFbLFJUykhzdKs0ltLQESx0e1vUukjpdVJUq+R7pngVJ1XZBHERSOA/QvapjC3QALXGL2HOEHj4vuaD+E00swItQhRZ4/bQio74JNQqRIJaJq/1XVCDbAlQ+GIpOvjj4S1HGXXLdP09YQIyA1k+45X4qaulpJZbVGl9tGw/1AlliyXB4PXK6pjxhb1NRMsk40z/qr3odV/ZySmKCWJ51HrdCHlzQ0iwhF5Uz2SMYj2T0x8UWCA+ne7mKndLpHp6FIJBdVuds+VHiii1drpMw/pYdB211GXqWYcOunbkIfmQFci5DX53DFV0Vz5QoGL3rpkEF3/TPQsKu4poEw+Js9D+Ozi6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(136003)(346002)(396003)(366004)(376002)(2616005)(83380400001)(6486002)(36756003)(31686004)(478600001)(86362001)(76116006)(316002)(6512007)(53546011)(71200400001)(64756008)(66946007)(66556008)(2906002)(66446008)(66476007)(110136005)(5660300002)(186003)(6506007)(26005)(31696002)(8676002)(8936002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?c2RsTEcycHhXWFhBZCtlTVNFQVNzR2JCUHNwb3JjRExUdlFGSm1GcEZ2eEU5?=
 =?utf-8?B?aCt0V0dpYndXMERObHprU0FLS01aWko3M0R5dklrb0ZIdEVHYWxKcGRZMm1N?=
 =?utf-8?B?SDhsV2RmOWw1VDBDaVlpWVFDNWpxR01vZUc5ekhBTEFPNnBseDBaWFllNkVx?=
 =?utf-8?B?TkEzb3pqNnE4ZnN5WjRkWi92RlplOGdRRHdDK1JaNVdtTnNqbXFXQ2Jpc29h?=
 =?utf-8?B?UEx4MGlOM0RwS05tc1NEQlYxZlhJNXZ2cFBXeXhZcEZ0a3FiQlBrK0YwYXpF?=
 =?utf-8?B?RUlHaXNtd2FnOHVpbDQraWE1RTFWNmVYd0hwYmZ2YVdpY0JhMy9hTE0vdWpr?=
 =?utf-8?B?cForVHNadnFhRTkvS0RmYVV0b0wraFRHUngvYThOK280NHVlQkxGTzFvK25m?=
 =?utf-8?B?YVVRdkNCWFBGQVRtS3I3ZGtnUGVhUndEdzh0cXVBeVRDcGxQa3F3Ky9sWmlT?=
 =?utf-8?B?TzA0QllmM3VILytBZzlETGNsZy9NVmt3ZmUzTEdocXV3Z2hOeWNYUGxOS0RV?=
 =?utf-8?B?NzRpWiszenRYRUZWcU9ld2greTVOd1JNejMvaXdVQ2dOaURGei83MFVySEpl?=
 =?utf-8?B?SG5IUnBhT2pQVmpZK3BrQWhVeU9OdndhSUpNSFMrMmFjb1BKZ25zQ0c3bEZp?=
 =?utf-8?B?Tnh6UFNRS2FIWkN3ZXpReHFEWWplZmJjV1ErWUJmVlhqOXBwZXloQ1ZBVnNL?=
 =?utf-8?B?S0RVbldmRUxCWC8wYzF0eWNIYUlRTTV5ekJqYkp1S1pjNkgwYm5XM091S0xL?=
 =?utf-8?B?VEduQWZXUUhiTXNJVUxGOWxBRWhrK3BtZ3dpY1lMNnZnTlV4Y0pOUkNwK0FT?=
 =?utf-8?B?YkU5S3ovZEhFSXRlUHoyY1pGQjNNMFJudlVLdWYrWitLQWlLSytYTWltSjZF?=
 =?utf-8?B?YWVpVHhrWXhOUTVOSGZXVy9aUHFPbmhrT2V4T0VBSTlBRlFocHJQTk5PWkpB?=
 =?utf-8?B?QVRmUVc1L3NPRXNNR1BpQXFJZVV0SVRtdUgxQUJUYmpVYk90SjY3eXNRdmlq?=
 =?utf-8?B?SmdmYm9jMDN3YXlnM3poR1QvSzhGeFVKYm56U2dmcGRMTkJQQUw1cFROU0RB?=
 =?utf-8?B?U2ZsSmNGVEw0bVNCbGw0a0taQzI2aS9BNjZsSGtvS1R3MEhnWjFTQ2lscVJi?=
 =?utf-8?B?cjJiMExFNFY3VjRycmdiTWhsMHhpTGh2TytVdHY2a2RteEk2N3Z2djdqeUN6?=
 =?utf-8?B?V3R4d0tUaVdSMEdBQWkxZG9Pamw5QnI0UE1SUklZdHNmMnN3aU1tWlFzaUR2?=
 =?utf-8?B?Vk16SFN0dEdvNnpnRU9pK3ZJbXZ4V3NGVnQzRzJZT2V3UUU4NUNQYkFNbGhV?=
 =?utf-8?Q?oLwXAjg2pyHz8=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D9F1D6CC489434384B242E9823CE890@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded96399-0819-4146-252e-08d8938caea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2020 10:59:30.6413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BbwxInlz3CD/ES+Uu09kKseb4EP4hJPyr5VUb+KXj8odBgDeQxt40G8+Fw8iv2LP64ayrXT0Y4wG4+ZGFDPmJnG478VbCyz0fCL2QUdg250=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2832
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMTgvMjAgODoyNCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gU29tZSBmbGFzaGVzIGxpa2UgdGhlIEN5cHJl
c3MgUzI4IGZhbWlseSB1c2UgRUNDLiBVbmRlciB0aGlzIEVDQyBzY2hlbWUsDQo+IG11bHRpLXBh
c3Mgd3JpdGVzIHRvIGFuIEVDQyBibG9jayBpcyBub3QgYWxsb3dlZC4gSW4gb3RoZXIgd29yZHMs
IG9uY2UNCj4gZGF0YSBpcyBwcm9ncmFtbWVkIHRvIGFuIEVDQyBibG9jaywgaXQgY2FuJ3QgYmUg
cHJvZ3JhbW1lZCBhZ2FpbiB3aXRob3V0DQo+IGVyYXNpbmcgaXQgZmlyc3QuDQo+IA0KPiBVcHBl
ciBsYXllcnMgbGlrZSBmaWxlIHN5c3RlbXMgbmVlZCB0byBiZSBnaXZlbiB0aGlzIGluZm9ybWF0
aW9uIHNvIHRoZXkNCj4gZG8gbm90IGNhdXNlIGVycm9yIGNvbmRpdGlvbnMgb24gdGhlIGZsYXNo
IGJ5IGF0dGVtcHRpbmcgbXVsdGktcGFzcw0KPiBwcm9ncmFtbWluZy4gVGhpcyBjYW4gYmUgZG9u
ZSBieSBzZXR0aW5nICd3cml0ZXNpemUnIGluICdzdHJ1Y3QNCj4gbXRkX2luZm8nLg0KPiANCj4g
U2V0IHRoZSBkZWZhdWx0IHRvIDEgYnV0IGFsbG93IGZsYXNoZXMgdG8gbW9kaWZ5IGl0IGluIGZp
eHVwIGhvb2tzLiBJZg0KPiBtb3JlIGZsYXNoZXMgc2hvdyB1cCB3aXRoIHRoaXMgY29uc3RyYWlu
dCBpbiB0aGUgZnV0dXJlIGl0IG1pZ2h0IGJlDQo+IHdvcnRoIGl0IHRvIGFkZCBpdCB0byAnc3Ry
dWN0IGZsYXNoX2luZm8nLCBidXQgZm9yIG5vdyBpbmNyZWFzaW5nIGl0cw0KPiBzaXplIGlzIG5v
dCB3b3J0aCBpdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2
QHRpLmNvbT4NCj4gLS0tDQo+IA0KPiBOb3RlczoNCj4gICAgIE5ldyBpbiB2Mi4NCj4gDQo+ICBk
cml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyB8IDQgKysrLQ0KPiAgZHJpdmVycy9tdGQvc3BpLW5v
ci9jb3JlLmggfCAzICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUu
YyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4IDViZWU3YzhkYTRkYy4uODBm
YmNiOWMwODI4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMzA1NCw2ICszMDU0LDggQEAg
c3RhdGljIGludCBzcGlfbm9yX2luaXRfcGFyYW1zKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICAg
ICAgICAgaWYgKCFub3ItPnBhcmFtcykNCj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVN
Ow0KPiANCj4gKyAgICAgICBub3ItPnBhcmFtcy0+d3JpdGVzaXplID0gMTsNCj4gKw0KDQpwbGVh
c2UgZG8gZGVmYXVsdCBpbml0cyBpbiBzcGlfbm9yX2luZm9faW5pdF9wYXJhbXMoKS4gQSBnb29k
IHBsYWNlIHdvdWxkIGJlOg0KDQotLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KKysr
IGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCkBAIC0yODg1LDYgKzI4ODUsNyBAQCBzdGF0
aWMgdm9pZCBzcGlfbm9yX2luZm9faW5pdF9wYXJhbXMoc3RydWN0IHNwaV9ub3IgKm5vcikNCiAg
ICAgICAgbm9yLT5mbGFncyB8PSBTTk9SX0ZfSEFTXzE2QklUX1NSOw0KIA0KICAgICAgICAvKiBT
ZXQgU1BJIE5PUiBzaXplcy4gKi8NCisgICAgICAgcGFyYW1zLT53cml0ZXNpemUgPSAxOw0KICAg
ICAgICBwYXJhbXMtPnNpemUgPSAodTY0KWluZm8tPnNlY3Rvcl9zaXplICogaW5mby0+bl9zZWN0
b3JzOw0KICAgICAgICBwYXJhbXMtPnBhZ2Vfc2l6ZSA9IGluZm8tPnBhZ2Vfc2l6ZTsNCg0KDQo+
ICAgICAgICAgc3BpX25vcl9pbmZvX2luaXRfcGFyYW1zKG5vcik7DQo+IA0KPiAgICAgICAgIHNw
aV9ub3JfbWFudWZhY3R1cmVyX2luaXRfcGFyYW1zKG5vcik7DQo+IEBAIC0zNDMwLDcgKzM0MzIs
NyBAQCBpbnQgc3BpX25vcl9zY2FuKHN0cnVjdCBzcGlfbm9yICpub3IsIGNvbnN0IGNoYXIgKm5h
bWUsDQo+ICAgICAgICAgICAgICAgICBtdGQtPm5hbWUgPSBkZXZfbmFtZShkZXYpOw0KPiAgICAg
ICAgIG10ZC0+cHJpdiA9IG5vcjsNCj4gICAgICAgICBtdGQtPnR5cGUgPSBNVERfTk9SRkxBU0g7
DQo+IC0gICAgICAgbXRkLT53cml0ZXNpemUgPSAxOw0KPiArICAgICAgIG10ZC0+d3JpdGVzaXpl
ID0gbm9yLT5wYXJhbXMtPndyaXRlc2l6ZTsNCj4gICAgICAgICBtdGQtPmZsYWdzID0gTVREX0NB
UF9OT1JGTEFTSDsNCj4gICAgICAgICBtdGQtPnNpemUgPSBub3ItPnBhcmFtcy0+c2l6ZTsNCj4g
ICAgICAgICBtdGQtPl9lcmFzZSA9IHNwaV9ub3JfZXJhc2U7DQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IGlu
ZGV4IDBhNzc1YTdiNTYwNi4uNDEzZWEzMTFlNjMyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiBA
QCAtMTk3LDYgKzE5Nyw4IEBAIHN0cnVjdCBzcGlfbm9yX2xvY2tpbmdfb3BzIHsNCj4gICAqIEBy
ZHNyX2R1bW15OiAgICAgICAgICAgICAgICBkdW1teSBjeWNsZXMgbmVlZGVkIGZvciBSZWFkIFN0
YXR1cyBSZWdpc3RlciBjb21tYW5kLg0KPiAgICogQHJkc3JfYWRkcl9uYnl0ZXM6ICBkdW1teSBh
ZGRyZXNzIGJ5dGVzIG5lZWRlZCBmb3IgUmVhZCBTdGF0dXMgUmVnaXN0ZXINCj4gICAqICAgICAg
ICAgICAgICAgICAgICAgY29tbWFuZC4NCj4gKyAqIEB3cml0ZXNpemUgICAgICAgICAgTWluaW1h
bCB3cml0YWJsZSBmbGFzaCB1bml0IHNpemUuIERlZmF1bHRzIHRvIDEuIFNldCB0bw0KPiArICog
ICAgICAgICAgICAgICAgICAgICBFQ0MgdW5pdCBzaXplIGZvciBFQ0MtZWQgZmxhc2hlcy4NCj4g
ICAqIEBod2NhcHM6ICAgICAgICAgICAgZGVzY3JpYmVzIHRoZSByZWFkIGFuZCBwYWdlIHByb2dy
YW0gaGFyZHdhcmUNCj4gICAqICAgICAgICAgICAgICAgICAgICAgY2FwYWJpbGl0aWVzLg0KPiAg
ICogQHJlYWRzOiAgICAgICAgICAgICByZWFkIGNhcGFiaWxpdGllcyBvcmRlcmVkIGJ5IHByaW9y
aXR5OiB0aGUgaGlnaGVyIGluZGV4DQo+IEBAIC0yMjIsNiArMjI0LDcgQEAgc3RydWN0IHNwaV9u
b3JfZmxhc2hfcGFyYW1ldGVyIHsNCj4gICAgICAgICB1MzIgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHBhZ2Vfc2l6ZTsNCg0KSSB3b3VsZCBwdXQgd3JpdGVzaXplIGJlZm9yZSBvciBhZnRl
ciBwYWdlX3NpemUsIGJlY2F1c2UgdGhleSBhcmUgcmVsYXRlZC4NCkFsc28sIGl0IHdvdWxkIHBy
b2JhYmx5IGF2b2lkIHBhZGRpbmcuDQoNCldpdGggdGhlc2UgYWRkcmVzc2VkLCBvbmUgY2FuIGFk
ZDoNCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlw
LmNvbT4NCg0KPiAgICAgICAgIHU4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmRzcl9k
dW1teTsNCj4gICAgICAgICB1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJkc3JfYWRk
cl9uYnl0ZXM7DQo+ICsgICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3cml0
ZXNpemU7DQo+IA0KPiAgICAgICAgIHN0cnVjdCBzcGlfbm9yX2h3Y2FwcyAgICAgICAgICAgaHdj
YXBzOw0KPiAgICAgICAgIHN0cnVjdCBzcGlfbm9yX3JlYWRfY29tbWFuZCAgICAgcmVhZHNbU05P
Ul9DTURfUkVBRF9NQVhdOw0KPiAtLQ0KPiAyLjI4LjANCj4gDQoNCg==
