Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86642C656E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgK0MM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:12:29 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:1844 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbgK0MM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606479147; x=1638015147;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YLi9IuNinfSvUe7JDdLuLmbdMKdezzCGk5xJbjkCrpg=;
  b=wpc2Fl0c7VpF+8ZyR8dmLbpcLUwY6wHOVQuFqKI/K/HeUAkQXQLfZw9J
   dRhlOtHPOFjmrSzNmyhmK8Lg0w2SHKJtSDngdLXl3ZmRLBcq9mGUiJ2Z3
   GsdJa5dQBLfpAnefBajuFIspbbGI4htRrZas5xZXXlWlnGxuePD0q4kRp
   JkVSoTfuF4bkv3+Mj0+5HJIbo9Tue1igEQAReuC/IlmI1wW72a9P4Smon
   WrhmwfcXvViPntzMccEtD1ROvr7MC4dN4QHD+Or3IjGMxGCduO/dHhmUg
   n4zRBf+zEzjYHQQedZukxd7V404DfrAfhClYzHoaj+qmmJgd1CygClMBv
   Q==;
IronPort-SDR: 50Druhv1KgLtxD+jgXvgXKth6ZN3vQ7SSfKUUya2xoSbq6IKQdpEkhJ9SgS3Khd3vMVnbfaCrW
 vI9sTkk3ax46aHkKKSUkUpqM2dA/ZD+9cgq6B9xUcKzdv2W2DMO1ReD+PlMAPP+cd8sPiFD8zz
 j42U91fwoJXBBemiLYr0VdE5K+b2tQ18whO1KWn8UxnxxcZjQoKhoaZRrURcr9QN9bmuWhcmpf
 K8/CmqHDOawd6uKcjQublGoMcdfcRmM3ADDYx8la+EvW3DDYxjHHaCcO2sW2VWY6nQQcHuTmc7
 Q2s=
X-IronPort-AV: E=Sophos;i="5.78,374,1599548400"; 
   d="scan'208";a="95043763"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Nov 2020 05:12:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 05:12:26 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 27 Nov 2020 05:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0u0ybd69nQ+42fwzWLseHJqAbyPyjiH+2XmY8gnWgrC/EpopYUeTb6aCLYoYYfQWRYaZCoF6PsR7DUZARAzRuOsI+B3QT9ELm3/Oq3fczx55KycYa0t9YHZRKBrHMT4TWRFfJi9PtsymSjg/9jibLj2G7F5zhdOjwA6nr6etAkTwoahXBz/3eszrW3Yw6ehuFFHcJ2vtaW1Kco62drcP0zyRwirbRPL/Y9YD1vTkSueFdUqe3xTju4Qp9y9RLSU9XSApCplU5+u5fYXmqWRoIQFBgY8Rf3sGBn/cd4k6mVc65DgCNZnvnuuztM1dy7XBdkxkhLTOLg9jTxZLxwaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLi9IuNinfSvUe7JDdLuLmbdMKdezzCGk5xJbjkCrpg=;
 b=LVEMlvZUUZ30DIlmjWTPWUr5/OYDKahvHPwP9W+O6ym8SKoIquwaCDiGv4yEvw11V0vCR4DB7SdSkvxppFtwLRFr5gt1AtnRTuQaAwo6EesFXUgxxORW/PjMeC3qmbgxH3oMPZMix3bd/+x1xPFRbyKcb9TDeQwAZSiyirriQOEHmZdOceN9CLX3sI9RaedIpuxyr80tmsFtDxHp941rOJ4plA4fBfztLQ/jAgMIRYRZvpTODSpqIt6gwpmJAgbliYv74lq4pp7jkyFTxflJ62EO9PTYXiYk4VGChQDJIhZ98sD8PcdHdBrOlPIWSCZ7tjFrl7j5cd95DCA6nTxVJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLi9IuNinfSvUe7JDdLuLmbdMKdezzCGk5xJbjkCrpg=;
 b=Jno6aux+JwlRxrgCub6olXvJpCnOoB5qKpJH7xps4d86nzPZUNy8/Lx/6twhTkAR3WXDGBvsCyVrsjqEgO6Hp1VxeG5A4km2QIvsVQz9b75US9Qbsqis6LV1ixVuzd5D76bFDvXV/fSunSGSIW1Rncxib7+yRJAlPQGyiVGneeA=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB0028.namprd11.prod.outlook.com (2603:10b6:4:67::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Fri, 27 Nov 2020 12:12:23 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18%7]) with mapi id 15.20.3589.032; Fri, 27 Nov 2020
 12:12:23 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v6 00/11] clk: at91: clk-master: re-factor master clock
Thread-Topic: [PATCH v6 00/11] clk: at91: clk-master: re-factor master clock
Thread-Index: AQHWxLaMw3lxk2Dm4U+d4ZMZSgXx5g==
Date:   Fri, 27 Nov 2020 12:12:22 +0000
Message-ID: <51c33456-5627-3d6f-2996-b7f617b4dc5a@microchip.com>
References: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1605800597-16720-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.124.22.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b324c0b0-0866-4441-da91-08d892cdb26a
x-ms-traffictypediagnostic: DM5PR11MB0028:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB0028A91FF18CAA44632AC74287F80@DM5PR11MB0028.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ixX8jb0FEfEf9DSpZph4L4D4lhfnjDJ6VFbeo79lyKrI1sdXrRcx/6yShFKjpJDm5wH4hXDSs3+PizpZjHF2Es7Z1VgH2BZGUzud3YcAgZXJWv1SIbiGkdLoblrEdE/RwqZPmHm3XCi0FU7m7mmyNoIpA2RWSp19nrWdsRUtrlVblWcp4rzLbFuqi/nGWtL4o1hTzDdVHSJK3FnqF5N2O4UKOLxHZiXUQhdj57R7AlZWDaQnn900XuMCD/eRbPLDzswkP4XrhxVEgNwXfca28iQoZRhS6NfNtqWP5rmvgcRSJ1yC01SXwhykte6SiAZuiDmdUcak+v1Xlk0X4uXz+Psp9QOnXpc/xBBurIjnqTfw8tAtrSVmlb+lhQLbK6K8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(39860400002)(346002)(366004)(136003)(8676002)(2616005)(6506007)(53546011)(6512007)(31696002)(83380400001)(91956017)(86362001)(71200400001)(2906002)(26005)(5660300002)(4326008)(186003)(76116006)(54906003)(31686004)(66446008)(478600001)(64756008)(8936002)(66476007)(110136005)(66556008)(6486002)(316002)(66946007)(36756003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?N2dRRG9hMGdnOTFxbTRNVnJ0SkZIaUR0SHo0eGFGZktRakpDeG5VamFVcFpm?=
 =?utf-8?B?RzdjZ2k5dTUvSVU2Vm5sYXRHT0hLL0Z2cVQ2cjQvTWp2U2c2bTRsUFZzc2t5?=
 =?utf-8?B?MXZQei9IZzJ1QUp6bmVDRHdrbk02L1ZYZWRoMCtTTWhkWkgrSkE0TG9UWEVS?=
 =?utf-8?B?Z3M3TWcyMFNxS1l5RjdCYkFBOTNQNW03cmJONHRqZDJsaEIvN0h3aVQ5RW5C?=
 =?utf-8?B?TndIbHNwbWhBVFZUcmQ5eHpOb3NvQk52bFVMNXI5R0dhd25xMVFMbkxqL2tn?=
 =?utf-8?B?VHhWMDQ5RlBlaFIwMk9hdS9BbkpiRG5PeEJwZGw4Z0UzeEx0Y0xuVElXRFF1?=
 =?utf-8?B?c1VKRzhKVS9uVnNaNVcweTlSQ2lmVnhDcjlVQXJ4T25TZ1VoZXpHZ29EQ3Nw?=
 =?utf-8?B?VFVyYVBKbUJPazFQZXF2cm4vYWpHUUxPWWV2dXFoR1FMME42WE1IU1BFR3M4?=
 =?utf-8?B?S3NaY2hVL2dabEF2b001bTFPalZVUXlkQU9zRks3Z2ozd2NsTVRGemQwcGZ5?=
 =?utf-8?B?b2xMMStiTCtLbG9tYzFjTiswdys1MzlWejFvTGJqeU4rRXFseXh1dkxlV0ZF?=
 =?utf-8?B?TU5vcnlUNGlHVkFuUE5OaDlwcXVTOE5kcVl5dEhSRTk0bVQ4Q2IxdWtCK0Rw?=
 =?utf-8?B?dWJBSFV1OUY2cUtiUEhmRzNGbHFlbC85Qyt0S0VBZkNIaVZiUWdNUnhkRWhR?=
 =?utf-8?B?d1pxRGJ4UnBCeVllSjRCWFRtcWVYZ21zT0VQTTgyeVhXRjVGS1JBSlNycytR?=
 =?utf-8?B?bnlTLzJDMW93MVpYUG1xVGM5Wlh6S1ZUTktxd1YweGN4Q1B2Y2tRQ1A0R0w1?=
 =?utf-8?B?eEFKSXVoRytXMmlIekcyVmtDcG8xdnF3UDg1MkVMOE43QUdVc1VSMXpTMjNS?=
 =?utf-8?B?SlcwaTlaQWtDQ3RLMTVRRjJPMjZ1NmM1UnBCTE45Sy9wclJmOG9VdFpORm91?=
 =?utf-8?B?V3ZVVFQ2WlIyaVlldzJtVklQV1M5NVd1Z3ZMRkxEMjNjN3VTc2xQV2lmQ1BK?=
 =?utf-8?B?eGhKU3VxQTI2MTJubGo1bWY5OGJPdmFsU3c1aEo5MnpZZWlRWXZEMnF1ajQw?=
 =?utf-8?B?UXo1a20vUmZ0bGxNbGszVWpDVG4wcWRoYkxXYkJlZlRBVERiNVlFNWxxTG51?=
 =?utf-8?B?eGdqQkppVDVHSWx2ckFPc0JEaVBweHd6cUw5UFlpZlhOYUh6UzdWZEc3Z2Zm?=
 =?utf-8?B?bkpGd3JtRzF4MmxsNzhpeTJUZkE5eHhjcituWXlLdm8vbUpnbVlkdEkvSEht?=
 =?utf-8?B?Tmp2Ukxsdks3b01EZWFkbHlNeVd3WGpNVFRqNDBKV3EyM3RiSEw5bVFaV2wy?=
 =?utf-8?Q?8qnibJ/PMx56RCjzikgNkrCG5EmPhVqLiW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <05FFCD3CE6375A4A867B017D0579D839@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b324c0b0-0866-4441-da91-08d892cdb26a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 12:12:23.0384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDPRxJKoE2e5nIbQPOuvi1k7+gmxviLXjCd2qNg1rGEqLGIaRf3JImYyMGthvIDKhwg4B9Z0WtdHgC2k3f6nYIvaxUh4O4BNzEwq17gi48g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBoYXZlIGp1c3Qgbm90aWNlZCB0aGF0IHRoZSB0aXRsZSBvZiB0aGlzIGNvdmVyIGxldHRlciBp
cyB3cm9uZy4NCkl0IHNob3VsZCBoYXZlIGJlZW46DQoNCiJjbGs6IGF0OTE6IGFkYXB0IGZvciBk
dmZzIg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8gc2VuZCBhIG5ldyB2
ZXJzaW9uIGZvciB0aGlzIHVwZGF0ZS4NCg0KVGhhbmsgeW91LA0KQ2xhdWRpdQ0KDQpPbiAxOS4x
MS4yMDIwIDE3OjQzLCBDbGF1ZGl1IEJlem5lYSB3cm90ZToNCj4gSGksDQo+IA0KPiBTQU1BN0c1
IGlzIGNhcGFibGUgb2YgRFZGUy4gVGhlIHN1cHBvcnRlZCBDUFUgY2xvY2sgZnJlcXVlbmNpZXMg
Y291bGQgYmUNCj4gb2J0YWluZWQgZnJvbSBDUFUgUExMLiBUaGUgaGFyZHdhcmUgYmxvY2sgZGlh
Z3JhbSBmb3IgY2xvY2sgZmVlZGluZyB0aGUNCj4gQ1BVIGlzIGFzIGZvbGxvd3M6DQo+IA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0tLS0tLS0tKw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICArLS0+fGRpdmlkZXIxfC0tPiBDUFUgY2xvY2sNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICstLS0tLS0tLSsNCj4gKy0tLS0tLS0tKyAgICstLS0tLS0tLS0t
KyAgfCAgICstLS0tLS0tLSsNCj4gfENQVSBQTEwgfC0tPnxwcmVzY2FsbGVyfC0tKy0tPnxkaXZp
ZGVyMHwtLT4gTUNLMCBjbG9jaw0KPiArLS0tLS0tLS0rICAgKy0tLS0tLS0tLS0rICAgICAgKy0t
LS0tLS0tKw0KPiANCj4gV2hlbiBzd2l0Y2hpbmcgQ1BVIGNsb2NrIGZyZXF1ZW5jaWVzIHRoZSBN
Q0swIGlzIGFsc28gY2hhbmdlZCBieSBEVkZTDQo+IGRyaXZlciB0byBhdm9pZCBpdHMgb3Zlci91
bmRlciBjbG9ja2luZyAoZGVwZW5kaW5nIG9uIENQVSBjbG9jayBmcmVxdWVuY3kNCj4gcmVxdWVz
dGVkIGJ5IERWRlMgYWxnb3JpdGhtcykuIFNvbWUgb2YgSVBzIGZlZWQgYnkgTUNLMCBhcmUgTUNL
MCBnbGljaA0KPiBhd2FyZSwgc29tZSBhcmUgbm90LiBGb3IgdGhpcyBNQ0swIHdhcyByZW1vdmVk
IGZyb20gdGhlIHBhcmVudHMgbGlzdCBvZg0KPiB0aGUgSVBzIHdoaWNoIGFyZSBub3QgTUNLMCBn
bGl0Y2ggYXdhcmUgKHBhdGNoIDcvMTEpLg0KPiANCj4gVGhpcyBzZXJpZXMgYWRhcHQgQVQ5MSBj
bG9ja3MgKG1vc3RseSBzYW05eDYwLXBsbCBhbmQgbWFzdGVyIGNsb2NrIGRyaXZlcnMpDQo+IHNv
IHRoYXQgcnVudGltZSBjaGFuZ2VzIG9mIHRoZXNlIGNsb2NrcyB0byBiZSBhbGxvd2VkLg0KPiAN
Cj4gVGhlIENQVSBjbG9jayB3YXMgcmVnaXN0ZXJlZCBmcm9tIHByZXNjYWxsZXIgY2xvY2sgKHNl
ZSBhYm92ZSBkaWFncmFtKQ0KPiBhbmQgbm8gc29mdHdhcmUgY29udHJvbCBoYXMgYmVlbiBhZGRl
ZCBmb3IgZGl2aWRlcjEgYmVjYXVzZSB0aGUgZnJlcXVlbmNpZXMNCj4gc3VwcG9ydGVkIGJ5IFNB
TUE3RzUncyBDUFUgY291bGQgYmUgZGlyZWN0bHkgb2J0YWluZWQgZnJvbSBDUFUgUExMICsNCj4g
cHJlc2NhbGxlci4NCj4gDQo+IE9uIHRvcCBvZiB0aGlzIHNlcmllcyBJIGFsc28gYWRkZWQgYSBm
aXggZm9yIHNhbWE3ZzUuYyBjb2RlIChwYXRjaCAxLzExKS4NCj4gUGxlYXNlIGxldCBtZSBrbm93
IGlmIHlvdSB3b3VsZCBsaWtlIG1lIHRvIHNlbmQgdGhpcyBvbmUgc2VwYXJ0ZWx5IChpdA0KPiB3
b3VsZCBiZSBuaWNlIGlmIHRoaXMgZml4IGNvdWxkIGJlIGludGVncmF0ZWQgaW4gNS4xMCkuDQo+
IA0KPiBDaGFuZ2VzIHdlcmUgdGVzdGVkIG9uIFNBTUE1RDIsIFNBTUE1RDMsIFNBTTlYNjAgYW5k
IFNBTUE3RzUuDQo+IA0KPiBUaGFuayB5b3UsDQo+IENsYXVkaXUgQmV6bmVhDQo+IA0KPiBDaGFu
Z2VzIGluIHY2Og0KPiAtIHJlbW92ZSBpZiAoY2xrX2h3X2dldF9mbGFncyhodykgJiBDTEtfU0VU
X1JBVEVfR0FURSkgaW4gcGF0Y2ggMTAvMTEgYXMNCj4gICB3ZSB1c2UgZGlmZmVyZW50IGNsb2Nr
IG9wcyBub3cgZm9yIHByZXMsIGRpdiBzdXBwb3J0aW5nIHJ1bi10aW1lIGNoYW5nZXMNCj4gICAN
Cj4gQ2hhbmdlcyBpbiB2NToNCj4gLSB1c2Ugc2VwYXJhdGUgY2xrX29wcyBmb3IgUExMcyBhbmQg
bWFzdGVyIGNsb2NrIGRpdiwgcHJlcyBzdXBwb3J0aW5nDQo+ICAgcnVuLXRpbWUgY2hhbmdlcyAo
cGF0Y2hlcyA2LzExLCAxMC8xMSkNCj4gLSB1c2UgdW5zaWduZWQgbG9uZyB0eXBlIGZvciBmIG1l
bWJlciBvZiBzdHJ1Y3QgdHlwZW9mKHNhbWE3ZzVfcGxscykNCj4gLSBkb2N1bWVudCB0aGUgdXNh
Z2Ugb2YgQ0xLX0lTX0NSSVRJQ0FMDQo+IA0KPiBDaGFuZ2VzIGluIHY0Og0KPiAtIGFkZGVkIFJl
dmlld2VkLWJ5LCBUZXN0ZWQtYnkgdGFncyBmb3Jnb3RlbiBpbiB2Mw0KPiANCj4gQ2hhbmdlcyBp
biB2MzoNCj4gLSBjb2xsZWN0ZWQgUmV2aWV3ZWQtYnksIFRlc3RlZC1ieSB0YWdzDQo+IC0gYWRk
IHBhdGNoZXMgNC8xMSwgNS8xMSwgOS8xMQ0KPiAtIGluIHBhdGNoIDEwLzExIHVzZSBDTEtfU0VU
X1JBVEVfR0FURSBvbiBNQ0sgZGl2IGFuZCBNQ0sgcHJlcyBmb3IgYWxsDQo+ICAgdGhlIHBsYXRm
b3JtcyBleGNlcHQgc2FtYTdnNQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoNCj4gLSBzL2F0OTFybTky
MDBfbWNrX2xvY2svYXQ5MXNhbTkyNjBfbWNrX2xvY2sgaW4gcGF0Y2ggNy84DQo+IA0KPiBDbGF1
ZGl1IEJlem5lYSAoNyk6DQo+ICAgY2xrOiBhdDkxOiBzYW1hN2c1OiBmaXggY29tcGlsYXRpb24g
ZXJyb3INCj4gICBjbGs6IGF0OTE6IGNsay1zYW05eDYwLXBsbDogYWxsb3cgcnVudGltZSBjaGFu
Z2VzIGZvciBwbGwNCj4gICBjbGs6IGF0OTE6IHNhbWE3ZzU6IHJlbW92ZSBtY2swIGZyb20gcGFy
ZW50IGxpc3Qgb2Ygb3RoZXIgY2xvY2tzDQo+ICAgY2xrOiBhdDkxOiBzYW1hN2c1OiBkZWNyZWFz
ZSBsb3dlciBsaW1pdCBmb3IgTUNLMCByYXRlDQo+ICAgY2xrOiBhdDkxOiBzYW1hN2c1OiBkbyBu
b3QgYWxsb3cgY3B1IHBsbCB0byBnbyBoaWdoZXIgdGhhbiAxR0h6DQo+ICAgY2xrOiBhdDkxOiBj
bGstbWFzdGVyOiByZS1mYWN0b3IgbWFzdGVyIGNsb2NrDQo+ICAgY2xrOiBhdDkxOiBzYW1hN2c1
OiByZWdpc3RlciBjcHUgY2xvY2sNCj4gDQo+IEV1Z2VuIEhyaXN0ZXYgKDQpOg0KPiAgIGR0LWJp
bmRpbmdzOiBjbG9jazogYXQ5MTogYWRkIHNhbWE3ZzUgcGxsIGRlZmluZXMNCj4gICBjbGs6IGF0
OTE6IHNhbWE3ZzU6IGFsbG93IFNZUyBhbmQgQ1BVIFBMTHMgdG8gYmUgZXhwb3J0ZWQgYW5kDQo+
ICAgICByZWZlcmVuY2VkIGluIERUDQo+ICAgY2xrOiBhdDkxOiBjbGstbWFzdGVyOiBhZGQgNXRo
IGRpdmlzb3IgZm9yIG1jayBtYXN0ZXINCj4gICBjbGs6IGF0OTE6IHNhbWE3ZzU6IGFkZCA1dGgg
ZGl2aXNvciBmb3IgbWNrMCBsYXlvdXQgYW5kDQo+ICAgICBjaGFyYWN0ZXJpc3RpY3MNCj4gDQo+
ICBkcml2ZXJzL2Nsay9hdDkxL2F0OTFybTkyMDAuYyAgICAgIHwgIDIxICsrLQ0KPiAgZHJpdmVy
cy9jbGsvYXQ5MS9hdDkxc2FtOTI2MC5jICAgICB8ICAyNiArKy0NCj4gIGRyaXZlcnMvY2xrL2F0
OTEvYXQ5MXNhbTlnNDUuYyAgICAgfCAgMzIgKysrLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9hdDkx
c2FtOW4xMi5jICAgICB8ICAzNiArKy0tDQo+ICBkcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05cmwu
YyAgICAgIHwgIDIzICsrLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9hdDkxc2FtOXg1LmMgICAgICB8
ICAyOCArKy0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvY2xrLW1hc3Rlci5jICAgICAgfCAzMzcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9j
bGstc2FtOXg2MC1wbGwuYyB8IDE0NSArKysrKysrKysrKysrKy0tDQo+ICBkcml2ZXJzL2Nsay9h
dDkxL2R0LWNvbXBhdC5jICAgICAgIHwgIDE1ICstDQo+ICBkcml2ZXJzL2Nsay9hdDkxL3BtYy5o
ICAgICAgICAgICAgIHwgIDIyICsrLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9zYW05eDYwLmMgICAg
ICAgICB8ICA0NSArKystLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQyLmMgICAgICAgICB8
ICA0MiArKystLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQzLmMgICAgICAgICB8ICAzOCAr
KystLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9zYW1hNWQ0LmMgICAgICAgICB8ICA0MCArKystLQ0K
PiAgZHJpdmVycy9jbGsvYXQ5MS9zYW1hN2c1LmMgICAgICAgICB8IDIyMyArKysrKysrKysrKysr
KysrLS0tLS0tLS0NCj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svYXQ5MS5oICAgfCAgMTEg
KysNCj4gIDE2IGZpbGVzIGNoYW5nZWQsIDg0MCBpbnNlcnRpb25zKCspLCAyNDQgZGVsZXRpb25z
KC0pDQo+IA==
