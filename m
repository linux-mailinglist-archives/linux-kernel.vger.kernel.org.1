Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD672E77B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 11:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgL3KPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 05:15:12 -0500
Received: from mail-mw2nam12on2083.outbound.protection.outlook.com ([40.107.244.83]:4321
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726247AbgL3KPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 05:15:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEzdcpaPoE1QAqnEM4M9mrE2FofQpZn4ggxG8ALdjV5oQCIuZXedWyXqvsyGnQRhzBmb1hukJ/zwepBdhGZidR1VCn1TOsUuiDtDDd3rIbUpgVE7nWKTDUHJiGrZz6bBOIw2uA7NVdJT5H4jEDgzzpGL0mtfSewh6gGpnAB29izYAToHh8C1i8+U+oLYjszIxrAucIcwKEqifHRDDtodJxJAV/ac7p0lxfvCXm8FeVtCR/bkuy+fFAqTwvk8GFy0h16yp2ZPleEKRFlSE/jhmvPQHv+HWN4Uxrckuf67xskzXin19nbNpcKNu6HmBQpqVGyfD98AEof1sFN54XywVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiDEoAcBsdaXhIobckg6LvHIMlrueLV6SXZbFI5/iCI=;
 b=IGAD1jXN67JArV4MfYFmBfnkYFP04P24HrTGlMI1Emh3t83fGd8AGb3tIAEX6qzUBsX3gAMZV78hZKKDxY6/9vu/Lh8UoXVSKONiLqfcXPHgZMbUSM0DQc0f0Eo7GebkS2vKOn6nmW7uMtuzCWIGhIElzd0zswLbN5/T8NTs36KmJBMcTIGOogZsU41m7zvsLRL4GAI2ohLw9dQT8K6FHsBQnRqJREK+p7jNb5SwGZIKqYsiuus37o1EN92pB1P7Qyc/kgcLmo/vshrAV7uXMRWWqJvCtzOhX20CpEdyYvKQ4vsgIq6x0wxyCgvyKQcK9CZ/Xslq3DwGVvmwjYwGbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QiDEoAcBsdaXhIobckg6LvHIMlrueLV6SXZbFI5/iCI=;
 b=R+UBpyCSxqoBFNP7G68w7+9sTHpqF3FId0Gax1qDcIHPxIJH8GJIQwLvtJSUODi1G/AIWOYZ0waZ8+UBWT1lvtItmF+zShUqmpvRMZP0ss8tphvPGNHHh34ES+p/Wg5NusKnipug2o6m4obsG9pTw/n8M5XROP3WaZOBZATyJAk=
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB4821.namprd11.prod.outlook.com (2603:10b6:510:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 30 Dec
 2020 10:14:23 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%5]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 10:14:23 +0000
From:   "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: RE: [PATCH v3] regmap: debugfs: Fix a memory leak when calling
 regmap_attach_dev
Thread-Topic: [PATCH v3] regmap: debugfs: Fix a memory leak when calling
 regmap_attach_dev
Thread-Index: AQHW3dCA5Vibwi8iDkqbAod4oyZ3B6oPZl4AgAAD4UA=
Date:   Wed, 30 Dec 2020 10:14:22 +0000
Message-ID: <PH0PR11MB5077EC74C0A81ABF8F082BC795D70@PH0PR11MB5077.namprd11.prod.outlook.com>
References: <20201229105046.41984-1-xiaolei.wang@windriver.com>
 <d516efdd-7e66-13fe-3798-cdea5ff012dc@web.de>
In-Reply-To: <d516efdd-7e66-13fe-3798-cdea5ff012dc@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [192.103.52.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99658cd3-7caf-4d55-7705-08d8acabae01
x-ms-traffictypediagnostic: PH0PR11MB4821:
x-microsoft-antispam-prvs: <PH0PR11MB4821F6921115CD149BD7177B95D70@PH0PR11MB4821.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4eJFufECR2HX4jtq9zDa1F5jMpNKtS8WqDc8LuxUGUgIJDQ8JF8m8XN7hLoAmXtoepHFbHMARoOgRU1n7Td7fMT6Ge16DxXru8GNcmbO3Del0rp4Jv2PO7Qg/GOCKEmLtlykTYX3ZCSPMPl+mQsbX5uzzy73z/cbAfpq3ye1ATJ2SDj1IgODNZVU6x2JEHU8Tc/MQateqn8z/MGYDqP2howwcUMHbQxYEPP/041nVPxHDPYBiy++/XIIGu669/7g2Dhs9EfsHsE7mC/tmXTfGRnomGFDES49fkdejKl9dowTBLwOJGzB2iW//yiOFolfmPNehCMPxKqR8txuWJktNEM6vt3j6z/2Hx1MOoCU4IxxXFKb7II1O4mx0A2CoY3FiuwEbl22pZRu46xRwheMaVZO5P8HhiK4P4jkze9hBlBpsf9xtS0QSKej2G7Z/8/RHHjGu/cDGvbUaHhJ1EfBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(396003)(376002)(136003)(346002)(54906003)(86362001)(110136005)(7696005)(66446008)(66946007)(52536014)(76116006)(64756008)(966005)(478600001)(55016002)(66476007)(6506007)(83380400001)(8936002)(66556008)(186003)(316002)(71200400001)(53546011)(26005)(33656002)(4326008)(2906002)(8676002)(9686003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TGp6TCtHYTRKUUgxNFRzYWJXbWJpVzByYjArTEQ2M1l1SDV3TmpML042UWtK?=
 =?utf-8?B?cW1lYjFPRE43bzZ0VVRWbGxqcVV6dWNyVGYyQ2FBbkpIU0VYT0ZXbFBOcERC?=
 =?utf-8?B?aUlkdkNzU1htNUMvZnFlRm10dTliQ0VjNmZsN0xtOGdndnlxWkx6VlU0L3NH?=
 =?utf-8?B?eDc1RzhHNHUvNmtMalpham1IYTE4UUtYc0NjMDlOVjQ1OFlRblo0RnFCOS93?=
 =?utf-8?B?UjJ6cDZKaDF1Nm92K0FKVlBJeHVFdFF5M01OZFVBRGpqVm9RcU5XWEorUUt6?=
 =?utf-8?B?cE80TzQ0Znp2OGtHYTVPdDkvUGZUNUl0b3lGVGo3VjRTcHFrUzdkKyt3MXFv?=
 =?utf-8?B?RVRUZUdaTFlTWW1QdzZRdUsvVTlFbE5mTmtNU1ZWaFBMOUdVN1RxUFhKRmI4?=
 =?utf-8?B?MlpLWEJxNmo0dm52dzV2S0ExeUFCM0trZmxNYWhGbkd0ODdkVXdWTEliMEYy?=
 =?utf-8?B?M09aMXdrdTNZRlNmRWhVUUZjRS9XaG5XSG9WdktvM3VuZUZuL3FSb0VyYkVh?=
 =?utf-8?B?a0tXOXVqc0hSclZzSGYwWW9FUXMrUFJkbE9VSEJ2eHF3NGlFOVZnUWRRQmF4?=
 =?utf-8?B?d1hqd0tMR3MzNG5OUW5OSlFGSzhJNG16UW5SekFkYklHaDVOdnBtK3BxQmM4?=
 =?utf-8?B?bXdUN0IxWmp0Q1I3ZUYvQnp1ZFpVQWZKam1SeW93MGI2NysydndBTWRyR1Yz?=
 =?utf-8?B?bXMvTy9IcmN0YmZxUUdCcW9zcmhrdG05ZmpBZ1pHb2ZsbkwxQjRJeVBrL2pK?=
 =?utf-8?B?SGpSd2krVFJKOVlsY0U1Y2xzc1lJUlBtUUNCOU5BMHBKQkswbXFUOEZUcTVa?=
 =?utf-8?B?RWRuVGRsMElPUmVoTDgxM1JLN2RoSlJKVlpOVktGQ0R0SWpvSGc2eEF2YlEw?=
 =?utf-8?B?WUFQeC9yMDNlQlRWczMxZ1cwb3lMWFd2anYzL1ZDcWtyTmo0Q21aN0FreHpo?=
 =?utf-8?B?NTdHS1BRUG1WMkhldEdZRTN3V05XazYzNXUyc2NqUGlXbnZvSW1FN1ZqeTNs?=
 =?utf-8?B?NndQTXM3SWxoOFVNV2F5Y1ZDRlZLY29tNFBlVUhJOHcxZG54UzRBcXAvVU1p?=
 =?utf-8?B?Q01QQUFTNnNpZEh6eklKUGxTSjN0aldKS2FtNi9LbjQyR2FJZTM5ODlVdXpI?=
 =?utf-8?B?Nnl5ZllUZWt5NU1jMTMzSFFKMm83VCtWV3YxSC9adFFKUk1Kb0VKNzJ6UGlM?=
 =?utf-8?B?SzhsV2x6NlM3Rkhwd1ZsSVJ1M25hcVFUMVkyZno0RS92K3JzUjBndWEyWlhL?=
 =?utf-8?B?TERaYzdDMTgxWUFSaHhNKzVPZ21rVEFkeGJvbGVzSjEyWGFzMnV4YlYwL2JD?=
 =?utf-8?Q?N/StVtfiVZXvE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99658cd3-7caf-4d55-7705-08d8acabae01
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 10:14:22.9521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcW1/Tf5+brBhCIv+0UajCJXWYrggOKRLd2ajbA9JjZFMytKfV9RemjGwEVGWhq0TgigUX+dJAxiekGglq1JOEOehlR8C67p4ZBJq2PTY8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4821
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2gsIHZlcnkgZ29vZCBzdWdnZXN0aW9uLCBk
byBJIG5lZWQgdG8gcmUtc2VuZCBhIHBhdGNoIHRvIGZpeCB0aGlzIHByb2JsZW0sIG9yIG1vZGlm
eSB0aGUgcHJldmlvdXMgcGF0Y2ggYW5kIHNlbmQgaXQgYWdhaW4/DQoNClRoYW5rcyANClhpYW9s
ZWkNCg0K4oCmDQo+ICsrKyBiL2RyaXZlcnMvYmFzZS9yZWdtYXAvcmVnbWFwLWRlYnVnZnMuYw0K
PiBAQCAtNTgyLDE4ICs1ODIsMjUgQEAgdm9pZCByZWdtYXBfZGVidWdmc19pbml0KHN0cnVjdCBy
ZWdtYXAgKm1hcCkNCuKApg0KPiArCQkJbWFwLT5kZWJ1Z2ZzX25hbWUgPSBrYXNwcmludGYoR0ZQ
X0tFUk5FTCwgIiVzLSVzIiwNCj4gIAkJCQkJICAgICAgZGV2bmFtZSwgbmFtZSk7DQoNCj4gSSBz
dWdnZXN0IHRvIHJlY29uc2lkZXIgdGhlIGFsaWdubWVudCBmb3IgZnVuY3Rpb24gY2FsbCBwYXJh
bWV0ZXJzIGZvciB0aGlzIHBhdGNoLg0KDQoNCuKApg0KPiArCQlpZiAoIW1hcC0+ZGVidWdmc19u
YW1lKQ0KPiArCQkJa2ZyZWUobWFwLT5kZWJ1Z2ZzX25hbWUpOw0KDQo+IFN1Y2ggYSBudWxsIHBv
aW50ZXIgY2hlY2sgaXMgcmVkdW5kYW50Lg0KDQo+IFNlZSBhbHNvOg0KPiBodHRwczovL2dpdC5r
ZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJl
ZS9zY3JpcHRzL2NvY2NpbmVsbGUvZnJlZS9pZm51bGxmcmVlLmNvY2NpP2lkPTEzOTcxMWYwMzNm
NjM2Y2M3OGI2YWFmNzM2MzI1MjI0MWI5Njk4ZWYjbjINCg0KDQoNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IE1hcmt1cyBFbGZyaW5nIDxNYXJrdXMuRWxmcmluZ0B3ZWIuZGU+
IA0KU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAzMCwgMjAyMCA1OjQ5IFBNDQpUbzogV2FuZywg
WGlhb2xlaSA8WGlhb2xlaS5XYW5nQHdpbmRyaXZlci5jb20+OyBrZXJuZWwtamFuaXRvcnNAdmdl
ci5rZXJuZWwub3JnDQpDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgRGF2aWQgTGVj
aG5lciA8ZGF2aWRAbGVjaG5vbG9neS5jb20+OyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPjsgTWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsgUmFm
YWVsIEouIFd5c29ja2kgPHJhZmFlbEBrZXJuZWwub3JnPjsgSnVsaWEgTGF3YWxsIDxqdWxpYS5s
YXdhbGxAbGlwNi5mcj4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjNdIHJlZ21hcDogZGVidWdmczog
Rml4IGEgbWVtb3J5IGxlYWsgd2hlbiBjYWxsaW5nIHJlZ21hcF9hdHRhY2hfZGV2DQoNCuKApg0K
PiArKysgYi9kcml2ZXJzL2Jhc2UvcmVnbWFwL3JlZ21hcC1kZWJ1Z2ZzLmMNCj4gQEAgLTU4Miwx
OCArNTgyLDI1IEBAIHZvaWQgcmVnbWFwX2RlYnVnZnNfaW5pdChzdHJ1Y3QgcmVnbWFwICptYXAp
DQrigKYNCj4gKwkJCW1hcC0+ZGVidWdmc19uYW1lID0ga2FzcHJpbnRmKEdGUF9LRVJORUwsICIl
cy0lcyIsDQo+ICAJCQkJCSAgICAgIGRldm5hbWUsIG5hbWUpOw0KDQpJIHN1Z2dlc3QgdG8gcmVj
b25zaWRlciB0aGUgYWxpZ25tZW50IGZvciBmdW5jdGlvbiBjYWxsIHBhcmFtZXRlcnMgZm9yIHRo
aXMgcGF0Y2guDQoNCg0K4oCmDQo+ICsJCWlmICghbWFwLT5kZWJ1Z2ZzX25hbWUpDQo+ICsJCQlr
ZnJlZShtYXAtPmRlYnVnZnNfbmFtZSk7DQoNClN1Y2ggYSBudWxsIHBvaW50ZXIgY2hlY2sgaXMg
cmVkdW5kYW50Lg0KDQpTZWUgYWxzbzoNCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9s
aW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL3NjcmlwdHMvY29jY2luZWxs
ZS9mcmVlL2lmbnVsbGZyZWUuY29jY2k/aWQ9MTM5NzExZjAzM2Y2MzZjYzc4YjZhYWY3MzYzMjUy
MjQxYjk2OThlZiNuMg0KDQpSZWdhcmRzLA0KTWFya3VzDQo=
