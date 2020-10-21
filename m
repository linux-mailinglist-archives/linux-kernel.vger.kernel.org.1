Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D93294E67
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443434AbgJUOUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:20:48 -0400
Received: from mga01.intel.com ([192.55.52.88]:14010 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443427AbgJUOUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:20:47 -0400
IronPort-SDR: YlJ6iVcmfIc+BAgRdUr+aoZFOiW3rLZtWiJk/tCND06j7UiXtm66FGUEMDrkvx8IACpcdM4pbu
 sAO4JNw+gMDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="185030693"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="185030693"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 07:20:46 -0700
IronPort-SDR: ZPNkK7FUyGH82d3fPaY1Azv/dsAA9e2vkTcBDgMmsVUEAbFd+WuW6oQNOq+6yJj8Yt3Y9pTeA/
 H/7xdcE09rwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="302088998"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 21 Oct 2020 07:20:46 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 21 Oct 2020 07:20:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 21 Oct 2020 07:20:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 21 Oct 2020 07:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6VUMGQtntp3+yy6+KvWPZlkEB8GHjmIGCqs+taXzfiiKgKXGmWkppSymSpd0rQieniob9mwnj6Nzg17BiMwHdMXNJogwlrSpXTkdZahIfhI18tGnBnbRusTANOhNN7Go7yUjCg74bf074ekxvTyHZFO/pVKD2tGlE5yOHxMZ221ZW4XO/w3zVTxPrNk7CyhqfqmLMYtfH2IkJaGETCdJbI9OjC7LpYgu9eAkBfEE/LfllXRoHs1uYmIwVAFmdRZODmzB3xMm9+jGBzA9h5cbjqWKWbO7Qd4E4L15k7VyXYg1XoKE4Z/+oCHN64KwQIYygXCIHuNC7vVTsKxLre7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3pd/5OLXaum2j4pYWzWUpRy6Cs8FRHjmOceXX4Q0DI=;
 b=nVne+YSA/DRqveMhRR5nsdza6ymspQl4YZViZjRU0cGfElKrPkbjHsYWhV2yES/Qagjr+jHLU1/OH2tdonV7SsP/146/yUIYv+r7q5Rh2Hl6ZJAAQwWYow1hhD2J5U3M/+jWX33l0Hy8gmOtiU92WuwBWgwpGa1fNb0GLqHSXyu7yo0LG9yj171V2Qq8/SrhyvUG+9XCw5CqryAGdnk9DOzPUwQKLubn7W26X1mTxkJC/bSlEmCJ63pwViaP/FNFx+fifayAb/e+BBihjgKsdKU9WII9pgDOXkkMC7OlM6MiUdcA7Vq0pvUmMmg7/1r1AvIdtnec230deu3HHbAOmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3pd/5OLXaum2j4pYWzWUpRy6Cs8FRHjmOceXX4Q0DI=;
 b=RtAjGob1ouwpnLVgNrag8XbeX9ZHWnjqR+DFtXgMLgc6iVkpDviJrJMLpMNmPIfXxXDwHqqay32FXQKe9hfiSb5lntx+FmNxfRnfpB2FfJf9eBVF2BiiygZAoYRaWcK+pvZatnDWzXOEUTwjMjlZiLsSqvBL9e1sKwgtR5MTJj0=
Received: from DM6PR11MB3642.namprd11.prod.outlook.com (2603:10b6:5:138::26)
 by DM6PR11MB3260.namprd11.prod.outlook.com (2603:10b6:5:b::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Wed, 21 Oct 2020 14:20:37 +0000
Received: from DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::e05d:6beb:bff:1a52]) by DM6PR11MB3642.namprd11.prod.outlook.com
 ([fe80::e05d:6beb:bff:1a52%4]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 14:20:37 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Nujella, Sathyanarayana" <sathyanarayana.nujella@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Zhi, Yong" <yong.zhi@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "R, Dharageswari" <dharageswari.r@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: Intel: sof_rt5682: update quirk for cml boards
Thread-Topic: [PATCH] ASoC: Intel: sof_rt5682: update quirk for cml boards
Thread-Index: AQHWp30eIpxxbRuwQEak8sWeZEUqXKmiFRqAgAAFDtA=
Date:   Wed, 21 Oct 2020 14:20:36 +0000
Message-ID: <DM6PR11MB364206FD71215B0A57FF9672971C0@DM6PR11MB3642.namprd11.prod.outlook.com>
References: <20201021072646.7980-1-brent.lu@intel.com>
 <9ae005e9-4cd9-31ef-56cb-504edc4cd503@linux.intel.com>
In-Reply-To: <9ae005e9-4cd9-31ef-56cb-504edc4cd503@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [111.248.47.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4218d7c0-e613-49a4-65d1-08d875cc7b1b
x-ms-traffictypediagnostic: DM6PR11MB3260:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB32608B08964AA1286351A2E5971C0@DM6PR11MB3260.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EQHk01bBB7wvJHqhCXhDCICgkADjelSIeMWUj7yZpJIsm3ejImfrKGEzE6/6TqFuudxgHVX9tIEomPhI9YRDuulEFdM2wxX/cASn0UO/kZFK2R39/gAdrgOHVqYLodzN0EnZ7rW8JYAnhVqZiJLDWkE57qIL//83vBH9pYPx1rBhgUz6CeNH0pEoBEkgHjHx531t4QtGBgbmyRjJZMQFkh/Ofoq8W0JJQy3Mi494Snpky9AUKzr29Y5isNNXSsgyLYp3O6xGo3vGvBq27qJzKpQ00ip8B6CLQ6s81ENKjmTzZA7HP8mKoghRmWajUk3ZCQzIvTLjJGYJ5sdjQZQOjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3642.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(110136005)(4326008)(54906003)(316002)(4744005)(64756008)(186003)(478600001)(6506007)(66446008)(66556008)(9686003)(7696005)(5660300002)(26005)(66476007)(33656002)(52536014)(76116006)(71200400001)(66946007)(2906002)(7416002)(86362001)(8936002)(8676002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hR8ODfdDikofh6vARGQ1Yx+kl0glQYXYK7e/2nDzSvIZ1/QYcOZmJXn2ZHleLQDlAJf1cX72gyLjCNbIDS9aiazvX0TM0eQ74w6e1A66JGdK+sYzScj4KYb54/rOpDjJEVzP1AVL6JmABOIxPc8wWTf0xw3fPekEczkLr6GQ1rBvJGHfSaEUmdakWtNC+6k+/Gsw/uIaiDGYPWgc6Htd+sC4l2CtcqejpXcRLLk4kXk5mdf2rUWR+UHm9iCabqijoFA9bfVqs5J+7Pne3O1EiF0L9DsX/oZgJ0OMSUwS8o2Y7u3jA3Pmaq1lmW8wPfMKG1JwjdOtE9Va95Il9QRYpmIPK8bx+s2bLiDM0WIxJ9S54q/vXUi6eyrRlehduyE2lc8lrv2vfDl3vJd5cVZJAfgZL5k2CoMc00NA150Wxt8wI1pbDDxU5vzcfRupRf50EsMSf0qhzNgqxo6I/uHTuO15DTBYx9YBU9pww1kSMSAmbwCDPrsaYbOQtVzjVyomx3GmeLCIfZV5FgbX3Ljfg+dC26P9TRuEaXjEsN+TeVe0TWN624hPP1PEaVA6Wei8eJhrHu3rUvg70S9ezxCd4f7NR462TXUpiEowSiBwLA+7ZHCKx67lkUPkOv8iHB5XANYWbRNTn2L1ubWutmTVCQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3642.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4218d7c0-e613-49a4-65d1-08d875cc7b1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2020 14:20:37.0637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Po/dZ1cKsY1FljlhZjKlOTpnY8NA0Qv3Zmj+TEWr5Va5iaLO8U+5hjP57yi80DEIzCUOh8gZQ6/u7FnChVYhSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3260
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gVGhhdCBzZXR0aW5nIGlzIG5vdCB3cm9uZywgYnV0IGlzIGl0IHN1ZmZpY2llbnQ/DQo+
IA0KPiBzZWUgZS5nLiB3aGF0IHdlIHNldCBmb3IgZXhpc3RpbmcgcGxhdGZvcm1zIHdoaWNoIG5l
ZWQgMjQgTWh6IGluIHRoaXMNCj4gZHJpdmVyOg0KPiANCj4gRE1JIHF1aXJrczoNCj4gDQo+IAl7
DQo+IAkJLmNhbGxiYWNrID0gc29mX3J0NTY4Ml9xdWlya19jYiwNCj4gCQkubWF0Y2hlcyA9IHsN
Cj4gCQkJRE1JX01BVENIKERNSV9QUk9EVUNUX0ZBTUlMWSwNCj4gIkdvb2dsZV9IYXRjaCIpLA0K
PiAJCX0sDQo+IAkJLmRyaXZlcl9kYXRhID0gKHZvaWQgKikoU09GX1JUNTY4Ml9NQ0xLX0VOIHwN
Cj4gCQkJCQlTT0ZfUlQ1NjgyX01DTEtfMjRNSFogfA0KPiAJCQkJCVNPRl9SVDU2ODJfU1NQX0NP
REVDKDApIHwNCj4gCQkJCQlTT0ZfU1BFQUtFUl9BTVBfUFJFU0VOVCB8DQo+IAkJCQkJU09GX1JU
NTY4Ml9TU1BfQU1QKDEpKSwNCj4gCX0sDQo+IA0KDQpIaSBQaWVycmUsDQoNCkNNTCBjaHJvbWVi
b3ggaXMgdXNpbmcgRE1JIHF1aXJrIHNvIHdlIGRvbid0IG5lZWQgdGhpcyBwYXRjaC4gU29ycnkN
CmZvciBub3Qgbm90aWNpbmcgaXQuDQoNCkhhbmRsZSAweDAwMDEsIERNSSB0eXBlIDEsIDI3IGJ5
dGVzDQpTeXN0ZW0gSW5mb3JtYXRpb24NCiAgICAgICAgTWFudWZhY3R1cmVyOiBHb29nbGUNCiAg
ICAgICAgUHJvZHVjdCBOYW1lOiBEdWZmeQ0KICAgICAgICBWZXJzaW9uOiByZXYzDQogICAgICAg
IFNlcmlhbCBOdW1iZXI6IDEyMzQ1Njc4OQ0KICAgICAgICBVVUlEOiBOb3QgU2V0dGFibGUNCiAg
ICAgICAgV2FrZS11cCBUeXBlOiBSZXNlcnZlZA0KICAgICAgICBTS1UgTnVtYmVyOiBza3UzMzU1
NDQzOQ0KICAgICAgICBGYW1pbHk6IEdvb2dsZV9IYXRjaA0KDQoNCg==
