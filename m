Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684612CBE90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgLBNkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:40:09 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:55736 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbgLBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606916407; x=1638452407;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ytH8oYzZls5b//puk3Fd9uR0jcjWTPxA6N50PVaXZR4=;
  b=tLaHfMyHJz22BApNXLV0zEhMG7R1BcyiyFtWBY3BLOdgvASM7mPHnick
   WeeJpZSyrhJ3vgsUhnveHJhtiHYI0VwVh2XPrDaZfmihHtt1LbIuxp1Ak
   lTW5flkj29KirOY8GI1IOxDyk04KD0kN8On6AafrtSAMheOhgnQ17RJpi
   VZPmrKLWmaRYRBaZbTVMNMTvnkoQ8OnhyOx496bDioqcFMaO31DH5adfy
   rbdNZiRAp2KXw/5N6wrvEwl/uJVlUAgZ/2ezO/6xGGjD1pgt0CxUjTkhQ
   ncpmH48FOQgdQ11p3pcVjKm6szkEsq/FEFy9h5wWvxkWCCy5lTMGb9fAq
   Q==;
IronPort-SDR: YJepfAXtRz2xpZSBRuQqyYZM7HGv82Zlh08T1qu8ublK/qXFSjazl7UlvYWlpyo2bOkzzflY5k
 xmcjwxs5qrBc5UHykbRFSO43cKHkZ21apE/UVqkyGYMKF3h06oHEkWkGyDOUcOzIer1y5FCjUz
 5o4aNukKY1ORooriz3MLjI5DK6IT5Y7Xb0w1eUu1MWTpFDd85w665SwMTbFFFCZ8WK7H51/twV
 8tCIQ6z3KNv5/0NveoGIhNeV+9yj30yHkG3jSu5f8YhhI22LnB6ljnmOor/W7y0BHMXwzaiuPx
 Z24=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="35790169"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 06:39:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 06:39:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 2 Dec 2020 06:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhKpCZF0kDL8ihMlDKMCH2qkCLDyjgXDtCZKQjk3XgT/fKxTQ2sATxL4LtqYsOgKm4DwlspwVoNAMfVfhFEJSXoTz8AmR03Rt0LIXc4PiLCDLpG7/GM4RPZev2DETlsAJRHRfwnVxjrK9WhRdiUX63s2k0W+GXMsjkUTHbUGhcS4XXHRhOHYz/BaFdjV+U98sekZUMs4MLCtusao4URto5C+pxrD/kCGRfnGFoXWjcENb7zBUOvb62A8iu1P+sItajo1LrXP48q53KGGILkQwvNt16wGhVm/GTqVWL2Gts77ReFglvTOBaqP5VUeEd9BMXbdPP8phP+8SKqKQdaZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytH8oYzZls5b//puk3Fd9uR0jcjWTPxA6N50PVaXZR4=;
 b=GfRTSPQsMlU+8DoriuzqITpXJDTifPa7LPZd1PdWshudFRgGTfuTx5vvFDodyzfwDSobM4ZoroEDqqp/ElONcCqMOk3sKWSTt1U9cltNRWjCzkeMuuTD00DZ/G1V1DtLhssnvBrvwfqP6ZavHTlQ2FR9qWMeY8lJTJ90oFCL00Skx+PAkpesnpxfWvmHxDHJ5owlSdOwUxSVljyNPd1YlOqP7XNkrjczpbDLmWgGTnvpwyvX6TRw+otsbNewjkbQUW3WGmAeJr8rrd6pbkxZlUuEhcUWtyyPmh427lUj0VZcxf0365NduW7mPIP2X3rTwIXcV8F1NLAhuakdIH4HnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytH8oYzZls5b//puk3Fd9uR0jcjWTPxA6N50PVaXZR4=;
 b=NBQjJtvFGMYKvJlEv1fSGNVty02YwT/K304cjpkKGzQ5JK+iK7VXVxH3P/yT15jPWU6gPmxkqMb20biDvY4+PLbsgVe0s99O1DA2D7EZxIwF7Idouv4bJaRbXc9O30VXIfTU/yR4dJ1yrUGz9b/sOMaFT/69r3Gds4EYqvKcxww=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3866.namprd11.prod.outlook.com (2603:10b6:5:199::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 13:38:56 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18%7]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 13:38:56 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: at91: sam9x60: remove atmel,osc-bypass support
Thread-Topic: [PATCH] clk: at91: sam9x60: remove atmel,osc-bypass support
Thread-Index: AQHWyLB7ytq3fSWiwEeFxFXEagJVxA==
Date:   Wed, 2 Dec 2020 13:38:56 +0000
Message-ID: <37d33058-f766-4afb-3948-da04f95925d0@microchip.com>
References: <20201202125816.168618-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20201202125816.168618-1-alexandre.belloni@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.124.22.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 698b5942-5a7c-4ca5-3d03-08d896c79dfb
x-ms-traffictypediagnostic: DM6PR11MB3866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3866378533C711408513867D87F30@DM6PR11MB3866.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:530;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b5oByq5iLbO9Roz/pZ4LukFvUFUJ2EvyrYemFk3GhpLlVskeN75Jabbyv4Hht/D1vxHbGQ0KZ09G9FcmnchIDn7qr9WbNXHS3dZNozFlqUKN3XHzaUF+MXuB10u+xSgsMF/cmD+zfpsQVShyLPjLZo317jev2Jhl+c4FbnWk8Sk78THBeSvrKjgpoINOIT0jSUDdKWuKmJ9J3l7Cu0ScrLV6zJfNckA5N4i2Ksz/R2oRr4vy8/OvRJ1EGV/73RAFS2YxJttKLtNBGbRIFv964lcZpWs4sYb7lQ87kzbHHO9CR2BpD/SmlPuea7ihtQJ3lhYUAqsrElPmVTNisjolbpb0w0M3mMysL32Zvt6xo6A5w5PHJk0g+c7Zg2Wv4mRfVqY7BYAAc1B8eAKt2hPdow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(91956017)(6506007)(53546011)(31696002)(36756003)(5660300002)(316002)(110136005)(31686004)(86362001)(2616005)(2906002)(26005)(71200400001)(66446008)(186003)(6512007)(4326008)(8936002)(83380400001)(6636002)(6486002)(8676002)(54906003)(478600001)(66556008)(66946007)(66476007)(64756008)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?emhnM0dNN0cxMVd5WXZ4M3VhOTBpUm1hTXE2R3hxZStPaksybUd1bkUyY3U4?=
 =?utf-8?B?YTFKd3lBUGJtZVg4WTJGOTRkK0VPTlJSSTNXamtKbnhCUnQ3Slo5Vm9tUHJ4?=
 =?utf-8?B?Rldab084TzZmRStIeDIvTDcyWUFyQnhiQk04UHlkUWdDMUx0TStISFRWM0NU?=
 =?utf-8?B?Mlo3OHF3OE5PbHpOUytBY1R6VnFoMWUyUm1EcFZ5RkxmdU9yMDBIL3dCNVRq?=
 =?utf-8?B?SVBBV3ZVb2Y0VUZZSEdYY0FLamxpSkZsMmIrQmlnWXZUUG1XdTdoNnpvWThV?=
 =?utf-8?B?dkZuaC9Mc3lrMkNQdEhiRXplSzZkeUpuSVFkcXFHT1NYNFJkWm15bmcrV2VF?=
 =?utf-8?B?eUZ4MGp6cHhYM0pDdmdJUjZhWUFtcU5EaTNxSlZLUmVjSHB4UDNCU2lDcEls?=
 =?utf-8?B?OXg5WFlaTExodnByS0t4U05DL2c5SHphaUI4UnJRVzJ5b3luVEFQYkRKWkJZ?=
 =?utf-8?B?WHd4VzI1TEVoNnBUUW02QzNzcW45dFhONlVESHpUa05BSmw5elFuZTNoUXRw?=
 =?utf-8?B?L0cxMUN4ejRQNU5aa084WHBKTnNpSkNoaE5xVHlicytYSitSM2tkL0dHZnBj?=
 =?utf-8?B?UU9iZHZudGdhTVIzRmFJelV3MjFyemtwaEFXT0g3clVEMkY4Wi9wZUY2UEJl?=
 =?utf-8?B?WWdWditCUC9BOTMwZUR0aENqayt3WXhmTFd1cEh1ekpjNkdIYUFWd3lpK1JC?=
 =?utf-8?B?VW8zVUc2T09sdVJIbi9qTTZ5dkNUblF2UlhDM2lHdEYyRXVxRzYydnBsMmNU?=
 =?utf-8?B?ZldQNEZ5ZU9xZ091a0xsSVF0bnFTZzhCclMwNEVvV0hwTWR0N3U2bzBZUDdU?=
 =?utf-8?B?amVuWUYrS1VIWDlWQ2JwVGR2WkVPdWpvZzlwaHBmOXVMSlZRMS8xWVdPRzdP?=
 =?utf-8?B?TlNDMCtIeENMZGpnRWFPTTF3RTl2UEpSVEN5V0NBTnhSazFWM0F6cENqdE9i?=
 =?utf-8?B?TzBzUUdBZExLUUhXM2UybVNkcGU3d1p5Uk1KYm4yZXJ3a2lMaGVNb2FKNStP?=
 =?utf-8?B?Nk5zV0hLK05MVE5sTkY2Vi9VNzViNGhzbUVtSDNxaitkWldLZXBZQ0M2bVBq?=
 =?utf-8?B?SnNzamlsZmNHWnNJVFV3M2VDMUJYM2kxcHRJSmcwQXpZQktLMTFSMzVHY1d1?=
 =?utf-8?B?Q25FL285UzlCNFdOQmQ0NTdUaFgwckF2bnYwWlhFaTFSUThYT2VqSnJkVVNp?=
 =?utf-8?B?M1hjTThMeVpoMm1Jcmd0MHZ4WmtLNU5KTEFHb3pSazVOTWgydXhGYlZIWEJH?=
 =?utf-8?B?bHVVTVAzNmRSUVYwTzhIT0RpQllkc1VNbVJGeHFUWnA4UjBvNnF1KzVsc2k3?=
 =?utf-8?Q?IA2tqVbBtKlE9SSauxrbqnjOG4fVuAK3WY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0AB349DA3B8A74AAEB907D3B603C9A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698b5942-5a7c-4ca5-3d03-08d896c79dfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 13:38:56.5321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GvPyNVLqT4pamAu/A9IgYSlvU1B+CB188VHZqc93feeGaQIndFnf9q1mjNT9aPuH6NfF40bJeumwZIkQ7k5f0mzrWBHHtwfyZC7FWQ9AU8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3866
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDAyLjEyLjIwMjAgMTQ6NTgsIEFsZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBFWFRF
Uk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNz
IHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoZSBzYW05eDYwIGRvZXNuJ3Qg
aGF2ZSB0aGUgTU9TQ1hUQlkgYml0IHRvIGVuYWJsZSB0aGUgY3J5c3RhbCBvc2NpbGxhdG9yDQo+
IGJ5cGFzcy4NCj4gDQo+IEZpeGVzOiAwMWUyMTEzZGU5YTUgKCJjbGs6IGF0OTE6IGFkZCBzYW05
eDYwIHBtYyBkcml2ZXIiKQ0KPiBSZXBvcnRlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRyZSBCZWxsb25p
IDxhbGV4YW5kcmUuYmVsbG9uaUBib290bGluLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IENsYXVkaXUg
QmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KVGVzdGVkLWJ5OiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZl
cnMvY2xrL2F0OTEvc2FtOXg2MC5jIHwgNiArLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Ns
ay9hdDkxL3NhbTl4NjAuYyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtOXg2MC5jDQo+IGluZGV4IDNj
NGM5NTYwMzU5NS4uYzhjYmVjNTMwOGYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9hdDkx
L3NhbTl4NjAuYw0KPiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL3NhbTl4NjAuYw0KPiBAQCAtMTc0
LDcgKzE3NCw2IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW05eDYwX3BtY19zZXR1cChzdHJ1Y3Qg
ZGV2aWNlX25vZGUgKm5wKQ0KPiAgICAgICAgIHN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4gICAg
ICAgICBzdHJ1Y3QgY2xrX2h3ICpodzsNCj4gICAgICAgICBpbnQgaTsNCj4gLSAgICAgICBib29s
IGJ5cGFzczsNCj4gDQo+ICAgICAgICAgaSA9IG9mX3Byb3BlcnR5X21hdGNoX3N0cmluZyhucCwg
ImNsb2NrLW5hbWVzIiwgInRkX3NsY2siKTsNCj4gICAgICAgICBpZiAoaSA8IDApDQo+IEBAIC0y
MDksMTAgKzIwOCw3IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzYW05eDYwX3BtY19zZXR1cChzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgICAgICAgIGlmIChJU19FUlIoaHcpKQ0KPiAgICAgICAg
ICAgICAgICAgZ290byBlcnJfZnJlZTsNCj4gDQo+IC0gICAgICAgYnlwYXNzID0gb2ZfcHJvcGVy
dHlfcmVhZF9ib29sKG5wLCAiYXRtZWwsb3NjLWJ5cGFzcyIpOw0KPiAtDQo+IC0gICAgICAgaHcg
PSBhdDkxX2Nsa19yZWdpc3Rlcl9tYWluX29zYyhyZWdtYXAsICJtYWluX29zYyIsIG1haW54dGFs
X25hbWUsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBieXBhc3Mp
Ow0KPiArICAgICAgIGh3ID0gYXQ5MV9jbGtfcmVnaXN0ZXJfbWFpbl9vc2MocmVnbWFwLCAibWFp
bl9vc2MiLCBtYWlueHRhbF9uYW1lLCAwKTsNCj4gICAgICAgICBpZiAoSVNfRVJSKGh3KSkNCj4g
ICAgICAgICAgICAgICAgIGdvdG8gZXJyX2ZyZWU7DQo+ICAgICAgICAgbWFpbl9vc2NfaHcgPSBo
dzsNCj4gLS0NCj4gMi4yOC4wDQo+IA==
