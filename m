Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1A2B6BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgKQR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:29:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:32303 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgKQR3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:29:14 -0500
IronPort-SDR: AHrNXTCsB0YSpaKc0R1n03PJSRJhK1lJaXkuus9AVN+SFDo12x0SilJ4jH6juIXLRfgcX/S84X
 Ek454JXvXlrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="158000634"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="158000634"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 09:29:10 -0800
IronPort-SDR: 1GNo4EGS7u7Jv5CkkId9EhRHOUL8pZ1QrK4TjY8IokCMQacjJGYhiF9ikoojEYsjodUtHMTdQl
 8/MLHE+t13ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="310285629"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 17 Nov 2020 09:29:09 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 09:29:08 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 09:29:08 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 09:29:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqJIyBTVwKXuEzPzs2MCk4OWnz3gmW6f5HDyECUzSYcyI+QsuQ7ZdNDmEfHW/iaRKE/jPrsSSnLGqavwoDs4xwGlgqIiV5ignZVJpi5CqBfyDXrhP6oLMSjWyS1/StPXgl3iKA79JwQXtYlnkoJJlm0hcP1U4tTT7KmJUq3NPzwcRE78SFWwEJqfSqNMKrjNKzL9RsUz6ddC3oWFAINP+kI1Yg7sohXIP2UYCBtdD9DrxFdJhKEGHfaBm/PKVoGp5n70hOZUdy9mvytGvbyRev4CZwsnRmGANHXJgp2EUTGPlOH5vx5p+XamrlB4s+f/G+EzydHw5YkMTiS2lfebBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y+zaE2Yi+Yrx+fIKIWJicQO/I52yIi8sC0GY4ZUkY8=;
 b=JmlmqvyXWzqkugbBinDvlr6B4Z6lX1RP57ezxyG+uCW/6QqLG/v6zSk348vnBW3EOOHDZl5jHI5EnXm9jZC/qY1kHzbUO4X72JxzZfwCV4KwmcKICloRMoq93z98CqNPRU6E20fh+JclxszWu4NzGXKk5/clspWvvKHsMwhYoBM2dGJh1dmqVsz0mvM5umH4M9Au+sLLFAoz16JMjWUXzTxiYtsNGO0fXBteCU6g3fRcCT+ivLrMLfjg8tDK3M+okqf0+y0kLsRXiXulRdIvs9r5nvijj2izBXxB1X9kfY60hybFa5IUoBzDfa/XOGMzUlOHM8eSnmSFjSgnVY2gRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+y+zaE2Yi+Yrx+fIKIWJicQO/I52yIi8sC0GY4ZUkY8=;
 b=C3RSaLHuZnlPS1Y6b9dgqPKUwbBuESfBleK3Zpu6Rbpn4Vr9yNtmxCeRuJvmtt1VfyrW9HhSfoFQfR6Ur2O+c6ILeT3sgvSL2mx09Kn5M2WNUGd/1QsoNpYLzxbJ1G4slQa3rrJxyPoi+k6E+RJNavFoSke/ldq5vDK+J8CkqD8=
Received: from DM6PR11MB4250.namprd11.prod.outlook.com (2603:10b6:5:1df::18)
 by DM5PR11MB1451.namprd11.prod.outlook.com (2603:10b6:4:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 17:29:01 +0000
Received: from DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef]) by DM6PR11MB4250.namprd11.prod.outlook.com
 ([fe80::b90d:d053:9de6:e5ef%4]) with mapi id 15.20.3589.020; Tue, 17 Nov 2020
 17:29:01 +0000
From:   "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
To:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "Linux Memory Management List" <linux-mm@kvack.org>,
        "Lai, Poey Seng" <poey.seng.lai@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        lkp <lkp@intel.com>
Subject: RE: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Thread-Topic: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Thread-Index: AQHWu/gOwJsV/Qehpk218Q5UlO0i2KnMlCrA
Date:   Tue, 17 Nov 2020 17:29:01 +0000
Message-ID: <DM6PR11MB4250E11A47E3B45FE0BEDC26FBE20@DM6PR11MB4250.namprd11.prod.outlook.com>
References: <202011160303.qi5aRChY-lkp@intel.com>
 <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.106.177.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e6cc576-b9b1-4e89-42b5-08d88b1e466f
x-ms-traffictypediagnostic: DM5PR11MB1451:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB14517B4FD35812B4EFA2CAD0FBE20@DM5PR11MB1451.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cY20wus1xem9h+RM/wvBzKw17UPG5HKTS4vR/Pmdb6bJRxt9WGi+Oh2jznI4NaaSQYCax3WNyn5Co6MOG14H9i9JA2UVptegfTzwRwqVfo8jmzDfLhO7dYsO6m/nn+AF4gS1UVJ4s9AiU1jHcFn/qCz/SY3Dr/VK4KUM52ROc+jrKDjus2XMyiMbgnQLoQtkDJx3r9vT40MlgGs9Sowc0kfNvx9h8sTmWq0uIT5ODmhOTCyLh2UGi1uFIu0POvpFehHb47gTvj+GdDvDObS9Q0cQOkRFrsg0ObJ27xE6kUTWt+UKAwdrxCdy83053qZB9AL5wcfoTALjCBfwtZG3aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4250.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(76116006)(33656002)(66946007)(66476007)(64756008)(71200400001)(53546011)(2906002)(66446008)(66556008)(4326008)(5660300002)(8676002)(7696005)(54906003)(9686003)(86362001)(186003)(55016002)(316002)(8936002)(6506007)(478600001)(83380400001)(26005)(110136005)(66574015)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fkfjf4xH34XpUA7HbnpDi41cIBgJCTAZzXuvRJYMlOgTfnkMU8zyavxYswrDAFE1+PiZZHfbirqKpEI1RyiHfxXgnaSQdD8lYt7aqMP1nK8+MmMzBx2L6hFil+nrMnP2FTJuojphf4zbrgNgz8kTZLnidAw4/TSIbEqC10HABEqklOqoRsvcnJIQlk3CL6YaL6m58IzRMveH/ze/KBQBjHHMNnyCeRekUJUyLUR0OaNMbvp1+gOyu0N1qvb6xBkmZogKUO3XJT1xRmaQGwLcf889dqAe1XyCca1qlgYYaC38KinwvZYk4D3eK4ue6Z8vyQWfcbAIVaNX9tWqFtHMsPncosz94sjtC7cU9T8LIxiFZU1mGWAhpkbE71GBifZwxTR8girqmjZcrI5ujlJRarFrlxbk+wzVuucUdrHV13kRLNqzYX6Nvi3BqYnOzwz4sBMKlQijRV1lRnSHdOwKCcrclDVgmY19FtBZWPYPzt8TQBiBO7wrAjs8tLX8Ggr7NQZAa7KAcKig31eJKcRTCWZ1NphaXTS7IrX8kOX3JU0NUKKmhLzTTgmme69eCR5wfUKBC4+CmM3C6ZCiWvXo+Rmd6gANvbVvGXFc+W4VxX8tMtnWqLNW3aKC31vJ40y1frJUh8p2LwHXHERoBt6OnE57ttrEH+w56FNkQqnydaEOX82URiy5EKC84b7WgbbnFEkoYfRHkshIJUEhuW1z+t0JF7BW+uGP6jHLdjPCTr5cdLQwCX8AIZhFuOsfIzQ0nHq8jqid7kBxLaA79cMEm2pFeCIYebbl3KkLJz/bsujB8wu1gbDoYeWKxv/JGBO0Bqu85H+65GnwGzLxJCwdwKxLLp3Zn1clvsr74OfXynAWIWD+Hy9WOBot29Japj3yJ+A1M/sVyA3L1S4akmczaQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4250.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6cc576-b9b1-4e89-42b5-08d88b1e466f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 17:29:01.9032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o+J/NDomOYjGYF3Nqi6gGqEUpake9F6a+6Sjkp/8yMkPu9YOSgSBXRIG2s84vMYvbnnB7yWw4ejtSkNV1Uv6pIFmXQJA9n12yRTT3A8mXQhero7iUqf58iA7jX8mCQLA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1451
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVXdlLA0KDQo+IEZyb206IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVu
Z3V0cm9uaXguZGU+DQo+IFNlbnQ6IE1vbmRheSwgMTYgTm92ZW1iZXIsIDIwMjAgNTowOCBQTQ0K
PiBTdWJqZWN0OiBbUEFUQ0ggUkZDXSBwd206IGtlZW1iYXk6IEZpeCBidWlsZCBmYWlsdXJlIHdp
dGggLU9zDQo+IA0KPiBUaGUgZHJpdmVyIHVzZWQgdGhpcyBjb25zdHJ1Y3Q6DQo+IA0KPiAJI2Rl
ZmluZSBLTUJfUFdNX0xFQURJTl9NQVNLICAgICAgICAgICAgIEdFTk1BU0soMzAsIDApDQo+IA0K
PiAJc3RhdGljIGlubGluZSB2b2lkIGtlZW1iYXlfcHdtX3VwZGF0ZV9iaXRzKHN0cnVjdCBrZWVt
YmF5X3B3bQ0KPiAqcHJpdiwgdTMyIG1hc2ssDQo+IAkJCQkJCSAgIHUzMiB2YWwsIHUzMiBvZmZz
ZXQpDQo+IAl7DQo+IAkJdTMyIGJ1ZmYgPSByZWFkbChwcml2LT5iYXNlICsgb2Zmc2V0KTsNCj4g
DQo+IAkJYnVmZiA9IHUzMl9yZXBsYWNlX2JpdHMoYnVmZiwgdmFsLCBtYXNrKTsNCj4gCQl3cml0
ZWwoYnVmZiwgcHJpdi0+YmFzZSArIG9mZnNldCk7DQo+IAl9DQo+IA0KPiAJLi4uDQo+IAlrZWVt
YmF5X3B3bV91cGRhdGVfYml0cyhwcml2LCBLTUJfUFdNX0xFQURJTl9NQVNLLCAwLA0KPiAJCQkJ
CUtNQl9QV01fTEVBRElOX09GRlNFVChwd20tDQo+ID5od3B3bSkpOw0KPiANCj4gV2l0aCBDT05G
SUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkUgdGhlIGNvbXBpbGVyIChoZXJlOiBnY2MgMTAuMi4wKSB0
aGlzDQo+IHRyaWdnZXJzOg0KPiANCj4gCUluIGZpbGUgaW5jbHVkZWQgZnJvbSAvaG9tZS91d2Uv
Z3NyYy9saW51eC9kcml2ZXJzL3B3bS9wd20tDQo+IGtlZW1iYXkuYzoxNjoNCj4gCUluIGZ1bmN0
aW9uIOKAmGZpZWxkX211bHRpcGxpZXLigJksDQo+IAkgICAgaW5saW5lZCBmcm9tIOKAmGtlZW1i
YXlfcHdtX3VwZGF0ZV9iaXRz4oCZIGF0DQo+IC9ob21lL3V3ZS9nc3JjL2xpbnV4L2luY2x1ZGUv
bGludXgvYml0ZmllbGQuaDoxMjQ6MTc6DQo+IAkvaG9tZS91d2UvZ3NyYy9saW51eC9pbmNsdWRl
L2xpbnV4L2JpdGZpZWxkLmg6MTE5OjM6IGVycm9yOiBjYWxsIHRvDQo+IOKAmF9fYmFkX21hc2vi
gJkgZGVjbGFyZWQgd2l0aCBhdHRyaWJ1dGUgZXJyb3I6IGJhZCBiaXRmaWVsZCBtYXNrDQo+IAkg
IDExOSB8ICAgX19iYWRfbWFzaygpOw0KPiAJICAgICAgfCAgIF5+fn5+fn5+fn5+fg0KPiAJSW4g
ZnVuY3Rpb24g4oCYZmllbGRfbXVsdGlwbGllcuKAmSwNCj4gCSAgICBpbmxpbmVkIGZyb20g4oCY
a2VlbWJheV9wd21fdXBkYXRlX2JpdHPigJkgYXQNCj4gL2hvbWUvdXdlL2dzcmMvbGludXgvaW5j
bHVkZS9saW51eC9iaXRmaWVsZC5oOjE1NDoxOg0KPiAJL2hvbWUvdXdlL2dzcmMvbGludXgvaW5j
bHVkZS9saW51eC9iaXRmaWVsZC5oOjExOTozOiBlcnJvcjogY2FsbCB0bw0KPiDigJhfX2JhZF9t
YXNr4oCZIGRlY2xhcmVkIHdpdGggYXR0cmlidXRlIGVycm9yOiBiYWQgYml0ZmllbGQgbWFzaw0K
PiAJICAxMTkgfCAgIF9fYmFkX21hc2soKTsNCj4gCSAgICAgIHwgICBefn5+fn5+fn5+fn4NCj4g
DQo+IFRoZSBjb21waWxlciBkb2Vzbid0IHNlZW0gdG8gYmUgYWJsZSB0byBub3RpY2UgdGhhdCB3
aXRoIGZpZWxkIGJlaW5nDQo+IDB4M2ZmZmZmZiB0aGUgZXhwcmVzc2lvbg0KPiANCj4gCWlmICgo
ZmllbGQgfCAoZmllbGQgLSAxKSkgJiAoKGZpZWxkIHwgKGZpZWxkIC0gMSkpICsgMSkpDQo+IAkJ
X19iYWRfbWFzaygpOw0KPiANCj4gY2FuIGJlIG9wdGltaXplZCBhd2F5Lg0KPiANCj4gU28gdXNl
IF9fYWx3YXlzX2lubGluZSBhbmQgZG9jdW1lbnQgdGhlIHByb2JsZW0gaW4gYSBjb21tZW50IHRv
IGZpeA0KPiB0aGlzLg0KPiANCj4gUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BA
aW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUt
a29lbmlnQHBlbmd1dHJvbml4LmRlPg0KDQpUaGFuayB5b3UgZm9yIHNwZW5kaW5nIHRpbWUgaW4g
cmVzb2x2aW5nIHRoaXMgYnVpbGQgZmFpbHVyZS4NCg0KSSBzaGFsbCBwcmVwYXJlIGFuZCBzaGFy
ZSB0aGUgbmV4dCB2ZXJzaW9uIG9mIHBhdGNoIHdpdGggeW91ciBhcHByb2FjaC4NCiANCj4gLS0t
DQo+IEhlbGxvLA0KPiANCj4gSSdtIG5vdCBzdXJlIHRoaXMgaXMgdGhlIHJpZ2h0IGZpeC4gTWF5
YmUgdGhlIGJpdGZpZWxkIHN0dWZmIGNhbiBiZQ0KPiBjaGFuZ2VkIHNvbWVob3cgdG8gbWFrZSB0
aGlzIHByb2JsZW0gZ28gYXdheSwgdG9vPw0KPiANCj4gQmVzdCByZWdhcmRzDQo+IFV3ZQ0KPiAN
Cj4gIGRyaXZlcnMvcHdtL3B3bS1rZWVtYmF5LmMgfCA3ICsrKysrKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3B3bS9wd20ta2VlbWJheS5jIGIvZHJpdmVycy9wd20vcHdtLWtlZW1iYXkuYw0KPiBp
bmRleCAyYjZkZDA3MGRhYTQuLmNkZmRlZjY2ZmY4ZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9w
d20vcHdtLWtlZW1iYXkuYw0KPiArKysgYi9kcml2ZXJzL3B3bS9wd20ta2VlbWJheS5jDQo+IEBA
IC02Myw3ICs2MywxMiBAQCBzdGF0aWMgaW50IGtlZW1iYXlfY2xrX2VuYWJsZShzdHJ1Y3QgZGV2
aWNlICpkZXYsDQo+IHN0cnVjdCBjbGsgKmNsaykNCj4gIAlyZXR1cm4gZGV2bV9hZGRfYWN0aW9u
X29yX3Jlc2V0KGRldiwga2VlbWJheV9jbGtfdW5wcmVwYXJlLCBjbGspOw0KPiAgfQ0KPiANCj4g
LXN0YXRpYyBpbmxpbmUgdm9pZCBrZWVtYmF5X3B3bV91cGRhdGVfYml0cyhzdHJ1Y3Qga2VlbWJh
eV9wd20gKnByaXYsIHUzMg0KPiBtYXNrLA0KPiArLyoNCj4gKyAqIFdpdGggZ2NjIDEwLCBDT05G
SUdfQ0NfT1BUSU1JWkVfRk9SX1NJWkUgYW5kIG9ubHkgImlubGluZSIgaW5zdGVhZCBvZg0KPiAr
ICogIl9fYWx3YXlzX2lubGluZSIgdGhpcyBmYWlscyB0byBjb21waWxlIGJlY2F1c2UgdGhlIGNv
bXBpbGVyIGRvZXNuJ3Qgbm90aWNlDQo+ICsgKiBmb3IgYWxsIHZhbGlkIG1hc2tzIChlLmcuIEtN
Ql9QV01fTEVBRElOX01BU0spIHRoYXQgdGhleSBhcmUgb2suDQo+ICsgKi8NCj4gK3N0YXRpYyBf
X2Fsd2F5c19pbmxpbmUgdm9pZCBrZWVtYmF5X3B3bV91cGRhdGVfYml0cyhzdHJ1Y3QNCj4ga2Vl
bWJheV9wd20gKnByaXYsIHUzMiBtYXNrLA0KPiAgCQkJCQkgICB1MzIgdmFsLCB1MzIgb2Zmc2V0
KQ0KPiAgew0KPiAgCXUzMiBidWZmID0gcmVhZGwocHJpdi0+YmFzZSArIG9mZnNldCk7DQo+IC0t
DQo+IDIuMjguMA0KDQpUaGFua3MsDQpWaWpheQ0K
