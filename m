Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649412CBB7B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgLBLVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:21:45 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:23661 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLBLVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:21:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606908103; x=1638444103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vRAm3J01QGFO/tits1Y0TfbrjmwdoAC5nliolZKnTCg=;
  b=QCoh1VypKRgwO77d4nOEjp0UPNwV8xfOuyqu6sR5wXeW0JyqLVZONaY1
   /xS+itNc3kKY4XODK9HL2fBYEXpBWpC0opuX4WloQ8r8jfPrnp44ElYGN
   XjAUzcKmkMzMl+zxVticgmFoBDZY1g1GIm15ULu5Y2CnPYrpvmLNZnnR7
   z0PEcGzdwgw1UUNRSZWdDM+7gqJBxalUYwSWrKTItEczXf4nu9pC1CSO5
   PaY1HPehkt2kbCkkxlkD7OApWqItt8gRhM2i5PVX/n4bWoTpVcuFQjCF+
   jf8R2Th3AVQVkbupAR7RTkY5F36vTQagIdFdEpa2muSPpxZeiNuPKw8hh
   Q==;
IronPort-SDR: fyna+Y2sT6yCV3vwFnanpUKk9y3jzZi+rqRLc1k8/mwMykzFfdDKiD/g9KF+Lq/NjjnTvp19Ju
 EMByiHIACzH359fqERVBf3rQq7ZFaeOWA3vUNy1OEaupF7qnAq7Uywf2P2bSfhjkBtWhLL6rFI
 hWqwmTKFCexf89HqSj55k3f9r8z/NOTviV0acQjd2tJkGycwPza8VEdHCPfGKENrWG1S8ECL5x
 AQiQvtsw0D74dLZAFAukR+zeTRTB+YerR55VaaiMTpe7vkFzVnIXlhK/P5+tzVwNenR5GtwUh+
 Z9c=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101108113"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 04:20:38 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 04:20:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 2 Dec 2020 04:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSZYOARN75m2vJLj6vlmUwQo0q7FMSVMxEaGmPI0DvKquFEvhiaK9BricAWBlC3Wu+UwDdN3m6WyyUiOJIxK7VuYqjzTFKFV/lPSLpbLcqemLNtESr6CCcAut7FExhP7jGp3HOL7kpkivfcXLwX5r5CkQPUe/GMf+KA3ptWjkyAYcOoZfUn2VZU/1Jx0p3g49NDAjRfV77ZAZyqI7C7ipVScE226gWWgRukLrmOpBG2F6HM1sU+3oPyZO0HHDCAo6SaNiyFXq9LUM5ACfKu2gGhRbO5DlxGUTn9Q1WEWn9BpzpRIcsPNFbkakbvxvRc9FiTPk6rASOtWMVKGAJs98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRAm3J01QGFO/tits1Y0TfbrjmwdoAC5nliolZKnTCg=;
 b=NMTN9EGQy9us+vZdKweaCGauap19plYAvVNH9fUvG1Qc6GOUR721dVCzy935QkupnJa5jKB+PXi1hJGeHl3L4HVGHfUDgZ2D+IeQiH48wD0L/wp7fzM6g/e9OcDsVF5rO9PyLzYK6+rTka4cSVDtgXHGLyK4YGgy7FMtZbHSUfCXiuiz9ELmJWLW7/wkI3V7XL7lXCjAU85clk5ELYLAMk9sKYJ2tgd0zi9I38jSGT6CaQhWc2W2DoXD0ROyuj4tBPmentHz+3O0ak+J0mue6tF9ketWbcr2C4vIG7T3Tz5vsLWlRRe2nBDpVeskR39I4sTzmcPb6VsRrM4Q5EvSrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRAm3J01QGFO/tits1Y0TfbrjmwdoAC5nliolZKnTCg=;
 b=CfNBcy5C3d49vzx/imTTA8LchEsxa7NmLQWKihSBK3TM17asMYJU4N9ajU7nYMy8cH/ZjeLEKr44KbdLG1qpHUZgOMZLaVkunK6753NGsYWQYzQyDfZk+RVQbrzJi4PRBR0IFkOnRpz00HNHdhIWMyHrb4JXujnpo08wH/Zog44=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2831.namprd11.prod.outlook.com (2603:10b6:805:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 11:20:36 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3632.017; Wed, 2 Dec 2020
 11:20:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <j.neuschaefer@gmx.net>, <linux-mtd@lists.infradead.org>
CC:     <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: Fix multiple typos
Thread-Topic: [PATCH v2] mtd: spi-nor: Fix multiple typos
Thread-Index: AQHWyJ0nNlXYNCD99Uy5RGoZjaBwYw==
Date:   Wed, 2 Dec 2020 11:20:35 +0000
Message-ID: <72f13128-e2c3-07ce-c00f-d69833e2d69a@microchip.com>
References: <20201130152416.1283972-1-j.neuschaefer@gmx.net>
In-Reply-To: <20201130152416.1283972-1-j.neuschaefer@gmx.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmx.net; dkim=none (message not signed)
 header.d=none;gmx.net; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4668cc58-4715-43ac-64e2-08d896b44a6d
x-ms-traffictypediagnostic: SN6PR11MB2831:
x-microsoft-antispam-prvs: <SN6PR11MB28319DF18B55471BE42C826BF0F30@SN6PR11MB2831.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K6cKXtKYSiwZShfhD4qgn6j4s/sptCb8uZJfKmWqHmcTfqu1gCMDK85Kh2wCvVP5gZqQNnPTT84EU1ddQBf9iMQSr3t2V8pDaDG3Oo/vl4QPxIssrje4ktWy3df8XRYKQYX8jL6XAIpdMewVgN55eRunrYmpUSaupdH/OQ0npcn2WJidjQXtXA55Ok22dYNrPCOMcX8a1TzsA6jstkaI0SHbv6eDntfzVJSZpkBfnwwKygm6uck51n4+DNiT2LjyX3dJaTxJdIlgkWt92FYKOm/jj368Eon2va5z9oVRE0mgILoS9XaQD1AMf/orUMu/F9yAhnSW1RBM0D3H/YsyYtE+PKHAdVu233GViknBklxCRo8v+fb2L/YkjcElW3SqTQDcsJ7Tsc0BJ9i09CGV165juLY1/2zuDqyUShQzAps=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(54906003)(31686004)(316002)(2906002)(110136005)(26005)(478600001)(4326008)(36756003)(6486002)(6512007)(8936002)(53546011)(186003)(8676002)(66556008)(5660300002)(2616005)(66946007)(6506007)(86362001)(64756008)(71200400001)(66446008)(31696002)(83380400001)(76116006)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZStSam5FY0tWU2tjcFR5Y3N3MStaenQ5WnhWWnVLOEFRa2NvaWxDdmxKWVh6?=
 =?utf-8?B?QTUzUm9HVzJtTzVETjRSNDFCbldteWVvVGJmUWlxVVVRMC8vdXIvaHArSU00?=
 =?utf-8?B?b3AxdURGWW8ySVVMU0lsRUZUY043QTBMWVJadzJ3dXloRW83bFRiZEJ4QUZS?=
 =?utf-8?B?MjdFblp3eTV0Umw2RnpYWUxsOGd3NjRMV0JVT0s1ZXFoVXZ2dXVnY2h3U0tZ?=
 =?utf-8?B?ZXdvZU1VOXlzamVXdWNHdi9WRHVER05ZSkFIeXJCdXR3T0J6a0hicGNPYkVx?=
 =?utf-8?B?dElkekZZL3FoUnUvWHZtVHZhNk9NVzVMQWRHbzFhWWRMUElXL2c0SVNkMXc1?=
 =?utf-8?B?d05kN1hwbFRRZk9PejNEeXY3cnVLcjRnbTV1dU53bFlWSXFiVmp1SkdYWW4x?=
 =?utf-8?B?cnFUaFhUekhveXJyYXVwWkM2SXo1MnJkc09XOU1ucUFBWnFVU1JBMVI1SjE5?=
 =?utf-8?B?bG9VZ0VIenJUYVE1SW56bTd1UGRYRlo2dG9ZUjJRYTlOVjV1bnFLOWt5YVJw?=
 =?utf-8?B?VGZ2ci9KUFdTY1J6Z082ZnMrN1c5cW1zWFhLNFBuNjNqNm9pZjlIVnA3bUlB?=
 =?utf-8?B?V2o4YXJsb0JOQVhQa2Zlek5YczByYUFWVXhRemxaYSs4U29WZ25vNFQ3d1E2?=
 =?utf-8?B?YzYybVJTaUcyeXJ1VkhEUHcrM1FaZEtUbGhVcGRjSzRGL3lkMllZbnJYWTlO?=
 =?utf-8?B?ajJzOUtyTlMrNmY0KzhyUmJsRklocUtBemhOR0dCdzBEQjRac1Z4aFlLWmFH?=
 =?utf-8?B?TDBWU3hka2hWVXNBY1FTeWNXcVZWbnVwQnB4N1FjcU5nMXFOc3BVQ0dYc2F4?=
 =?utf-8?B?UkFZTzhaMDZNM0JIN214S25NZEpIcDEwTDd3UHpDeXJvUytHR2luYUFVWEps?=
 =?utf-8?B?NGVZSEpBSEVNUmJCVElEV3g2WnhrTDF0bm5Ea1RzcXhBSzVaQnBVVHZ6Y1c2?=
 =?utf-8?B?dlBrUWtrL3pnNnlQcStRbFZETGJad3BQVVkrQnd6WFk1NFU4dEs2dzdRMERl?=
 =?utf-8?B?eWNqRnpqV3VOQXBNWjJmaHdHL095cm1hQWYwVEFxVDdwVm1XRVE3dUhGWUpv?=
 =?utf-8?B?YjJNUm5EYzg1UHhjckpBZ01HWjRDU2xlenNJRGxDemw5L25pd2FqSWd6TVhE?=
 =?utf-8?B?QnNEOExHZllWYTc1TUlqWWFqdWdUSUFYcGFMejErcGp0azJmMmY1WXM0cDEx?=
 =?utf-8?B?bmZVQmJKSkNsSFhzdVprRnRpaExqaElFM3JRZVRzTkI3TlY5SXhFRWNGMkZF?=
 =?utf-8?B?UTNpNmxsbDBGTWxhK3BMa21oQU1tZWg4RkRpYy95Nm1BK2VMZlJTYXJwS2FN?=
 =?utf-8?Q?nGIlc8WaR/SgU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA5B7B435121A40843B2C0A7C43B0BE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4668cc58-4715-43ac-64e2-08d896b44a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 11:20:35.8902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2W5+cNiZhM4O+BmkQGdVINL2lctRvVcegZ/jCQmkCJqRIjDqoD3y/DE2DfbFYECrvg1EAIP79tMWrACQZLAzuybO7y9y45hP+AluplEZfrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMzAvMjAgNToyNCBQTSwgSm9uYXRoYW4gTmV1c2Now6RmZXIgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhlcmUgYXJlIGEgZmV3IHR5cG9z
IGluIGNvbW1lbnRzIGluIHRoZSBTUEkgTk9SIGZyYW1ld29yazsgZml4IHRoZW0uDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBOZXVzY2jDpGZlciA8ai5uZXVzY2hhZWZlckBnbXgubmV0
Pg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jICB8IDQgKystLQ0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9zZmRwLmMgIHwgMiArLQ0KPiAgaW5jbHVkZS9saW51eC9tdGQvc3Bp
LW5vci5oIHwgMiArLQ0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMg
Yi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRleCBmMGFlN2EwMTcwM2ExLi5iMjI0
YjI3NTEyNWEzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiAr
KysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMTQ0Nyw3ICsxNDQ3LDcgQEAg
c3RhdGljIGludCBzcGlfbm9yX2VyYXNlX211bHRpX3NlY3RvcnMoc3RydWN0IHNwaV9ub3IgKm5v
ciwgdTY0IGFkZHIsIHUzMiBsZW4pDQo+IA0KPiAgLyoNCj4gICAqIEVyYXNlIGFuIGFkZHJlc3Mg
cmFuZ2Ugb24gdGhlIG5vciBjaGlwLiAgVGhlIGFkZHJlc3MgcmFuZ2UgbWF5IGV4dGVuZA0KPiAt
ICogb25lIG9yIG1vcmUgZXJhc2Ugc2VjdG9ycy4gIFJldHVybiBhbiBlcnJvciBpcyB0aGVyZSBp
cyBhIHByb2JsZW0gZXJhc2luZy4NCj4gKyAqIG9uZSBvciBtb3JlIGVyYXNlIHNlY3RvcnMuICBS
ZXR1cm4gYW4gZXJyb3IgaWYgdGhlcmUgaXMgYSBwcm9ibGVtIGVyYXNpbmcuDQoNClRoZXJlJ3Mg
YSBkb3VibGUgc3BhY2UgYmVmb3JlICJSZXR1cm4iIHRoYXQgY291bGQgYmUgdHJpbW1lZC4NCk1h
eWJlIFZpZ25lc2ggd2lsbCBkbyBpdCB3aGVuIGFwcGx5aW5nLiBJdCdzIGdvb2QgdG8gc2VlIHR5
cG9zDQpmaXhlZCwgdGhhbmtzLg0KDQpSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3Iu
YW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+ICAgKi8NCj4gIHN0YXRpYyBpbnQgc3BpX25vcl9l
cmFzZShzdHJ1Y3QgbXRkX2luZm8gKm10ZCwgc3RydWN0IGVyYXNlX2luZm8gKmluc3RyKQ0KPiAg
ew0KPiBAQCAtMjUzNyw3ICsyNTM3LDcgQEAgc3BpX25vcl9zZWxlY3RfdW5pZm9ybV9lcmFzZShz
dHJ1Y3Qgc3BpX25vcl9lcmFzZV9tYXAgKm1hcCwNCj4gICAgICAgICAgICAgICAgIH0NCj4gDQo+
ICAgICAgICAgICAgICAgICAvKg0KPiAtICAgICAgICAgICAgICAgICogT3RoZXJ3aXNlLCB0aGUg
Y3VycmVudCBlcmFzZSBzaXplIGlzIHN0aWxsIGEgdmFsaWQgY2FuZGl0YXRlLg0KPiArICAgICAg
ICAgICAgICAgICogT3RoZXJ3aXNlLCB0aGUgY3VycmVudCBlcmFzZSBzaXplIGlzIHN0aWxsIGEg
dmFsaWQgY2FuZGlkYXRlLg0KPiAgICAgICAgICAgICAgICAgICogU2VsZWN0IHRoZSBiaWdnZXN0
IHZhbGlkIGNhbmRpZGF0ZS4NCj4gICAgICAgICAgICAgICAgICAqLw0KPiAgICAgICAgICAgICAg
ICAgaWYgKCFlcmFzZSAmJiB0ZXN0ZWRfZXJhc2UtPnNpemUpDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL210ZC9zcGktbm9yL3NmZHAuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+IGlu
ZGV4IGUyYTQzZDM5ZWI1ZjQuLjA1YjIyYzY1NzY4MzIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc2ZkcC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+
IEBAIC01OSw3ICs1OSw3IEBAIHN0cnVjdCBzZmRwX2JmcHRfcmVhZCB7DQo+IA0KPiAgc3RydWN0
IHNmZHBfYmZwdF9lcmFzZSB7DQo+ICAgICAgICAgLyoNCj4gLSAgICAgICAgKiBUaGUgaGFsZi13
b3JkIGF0IG9mZnNldCA8c2hpZnQ+IGluIERXT1JEIDxkd29hcmQ+IGVuY29kZXMgdGhlDQo+ICsg
ICAgICAgICogVGhlIGhhbGYtd29yZCBhdCBvZmZzZXQgPHNoaWZ0PiBpbiBEV09SRCA8ZHdvcmQ+
IGVuY29kZXMgdGhlDQo+ICAgICAgICAgICogb3AgY29kZSBhbmQgZXJhc2Ugc2VjdG9yIHNpemUg
dG8gYmUgdXNlZCBieSBTZWN0b3IgRXJhc2UgY29tbWFuZHMuDQo+ICAgICAgICAgICovDQo+ICAg
ICAgICAgdTMyICAgICAgICAgICAgICAgICAgICAgZHdvcmQ7DQo+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L210ZC9zcGktbm9yLmggYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4g
aW5kZXggNjBiYWMyYzBlYzQ1Ni4uNTgyZWUwNGVlZWEyMCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9tdGQvc3BpLW5vci5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbXRkL3NwaS1ub3Iu
aA0KPiBAQCAtNDA2LDcgKzQwNiw3IEBAIHN0YXRpYyBpbmxpbmUgc3RydWN0IGRldmljZV9ub2Rl
ICpzcGlfbm9yX2dldF9mbGFzaF9ub2RlKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+ICAgKiBAbmFt
ZTogICAgICB0aGUgY2hpcCB0eXBlIG5hbWUNCj4gICAqIEBod2NhcHM6ICAgIHRoZSBoYXJkd2Fy
ZSBjYXBhYmlsaXRpZXMgc3VwcG9ydGVkIGJ5IHRoZSBjb250cm9sbGVyIGRyaXZlcg0KPiAgICoN
Cj4gLSAqIFRoZSBkcml2ZXJzIGNhbiB1c2UgdGhpcyBmdWN0aW9uIHRvIHNjYW4gdGhlIFNQSSBO
T1IuDQo+ICsgKiBUaGUgZHJpdmVycyBjYW4gdXNlIHRoaXMgZnVuY3Rpb24gdG8gc2NhbiB0aGUg
U1BJIE5PUi4NCj4gICAqIEluIHRoZSBzY2FubmluZywgaXQgd2lsbCB0cnkgdG8gZ2V0IGFsbCB0
aGUgbmVjZXNzYXJ5IGluZm9ybWF0aW9uIHRvDQo+ICAgKiBmaWxsIHRoZSBtdGRfaW5mb3t9IGFu
ZCB0aGUgc3BpX25vcnt9Lg0KPiAgICoNCj4gLS0NCj4gMi4yOS4yDQo+IA0KDQo=
