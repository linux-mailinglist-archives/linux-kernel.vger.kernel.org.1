Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4851AD42B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 03:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728762AbgDQBco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 21:32:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:41817 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbgDQBco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 21:32:44 -0400
IronPort-SDR: PEfdzUnU2XUayUtmRmmdiqB7va/EBqDxC6fVE3nbOerA46+ooTI14DitE0y4qpaXito9ajA44H
 gf59JVNihRQQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 18:32:43 -0700
IronPort-SDR: hJPuNM5jwM9chUhk+3BADd+BW/45IX5LS/kMpqpAX8ZE1KhYeXCJT4dS0uBLG3CoUgrG6mCbGA
 t4Xgn08c8d9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="364180395"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga001.fm.intel.com with ESMTP; 16 Apr 2020 18:32:43 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 18:32:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 18:32:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wsu2UDSQgkevUR1TDZJ8H/rPVYFpuuffOLA5mIs7YkLeanyYQ3Mar8tMUr9Nq4dK682+Ba1RZ18W6oN1YfaFUwz3WzrCQeZGhUuo0+yYQ6bmzV+5vux+4J32d1THkCobQCysZcnDnw3nE2WGOoyGbm6w2MwiFdbkLPHDO2dzHz8M2gtQH7zyRQLKBLpjUxZbN/EVsrW2fap7S8CMHVpdHgwEeEFu6FNnQANVZDp+PZg5idd5CoSiMKBnockQ44d/iffQDrh0NHywxDf2Aj+EcoxGlyXhc5MD0QLfkbQyCMxYddZ61FOrE/E1COxXRpnfkSxt116XPA5iJVSFwWjRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQy0IeHAiujFwMPIkPRHF2wjoSDaxUiUwq6RVoSH474=;
 b=C2FqcLFYhynvwikAwnb/Zfa7iaIZmRA5iYTGTgh1k8rTw8Gzn43DPQbEpr6nizKfK5FGfZ6dVBk0diMVWGyLJ9PfKM2/sizqEM9pvhZ/zU4xCkTHPvDYkn0mZ8Naj09UAT7afMqnzPQOteUcWm21ITdZHAUcYo77f6Ys2IrqFP1kSNCWV+6j3reC7JYmYTeiFLopOJp5cLJbdklJgMLskEkt+wRPjE55OyMfqeejaI/wdKFZYUvarsY7hKgJUKkJfFbw8cF7iB5sh9oeu+hobkDYr6CvKdgM+HBwbXShLwAuaScfqcsXEHu3L6XSVtS7QFnrPVdqTIcxcOcqFbXC0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQy0IeHAiujFwMPIkPRHF2wjoSDaxUiUwq6RVoSH474=;
 b=YBrNLTNwq98NinpmXBPWeqHBN8Hca5X1VUX+Ki8gKyryRp7X/sOkW5gGnI+3fKqZ+VVJC7BWwe6Dwg66lAYikSpmCYjFzFdnT/WcfpUslJUHiuZpJCT3La8G3r6xZaKbeFvL+v7v25qCqnXKauhkjxnvztc9EnZK+l0MGJCnXqs=
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 (2603:10b6:405:5b::22) by BN6PR1101MB2084.namprd11.prod.outlook.com
 (2603:10b6:405:50::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 01:32:40 +0000
Received: from BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::344b:59bc:1455:37a6]) by BN6PR1101MB2132.namprd11.prod.outlook.com
 ([fe80::344b:59bc:1455:37a6%11]) with mapi id 15.20.2900.028; Fri, 17 Apr
 2020 01:32:40 +0000
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        "Mark Brown" <broonie@kernel.org>
Subject: RE: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
Thread-Topic: [PATCH v2] ASoC: bdw-rt5650: remove 3-channel capture support
Thread-Index: AQHWEW50RKvqbhd6GkSfOOyTIRYC+Kh21uiAgABBZRCAAeDygIADkBBw
Date:   Fri, 17 Apr 2020 01:32:40 +0000
Message-ID: <BN6PR1101MB2132BBB45C6683D6BE1FBCD897D90@BN6PR1101MB2132.namprd11.prod.outlook.com>
References: <1586766533-18557-1-git-send-email-brent.lu@intel.com>
 <9a484795-ea4a-e559-4ea9-3de24417ec9b@linux.intel.com>
 <BN6PR1101MB21320F655CFC1C271CCA9CE097DD0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <4b9455cb-d0d2-f5d8-f04c-df6e5abb4441@linux.intel.com>
In-Reply-To: <4b9455cb-d0d2-f5d8-f04c-df6e5abb4441@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brent.lu@intel.com; 
x-originating-ip: [192.55.52.216]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc26efb6-5156-4c17-ff53-08d7e26f37c8
x-ms-traffictypediagnostic: BN6PR1101MB2084:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1101MB20847BE98F02E6A12D41BCC597D90@BN6PR1101MB2084.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1101MB2132.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(376002)(396003)(39860400002)(366004)(346002)(26005)(316002)(71200400001)(2906002)(33656002)(5660300002)(86362001)(478600001)(4744005)(186003)(6506007)(54906003)(110136005)(4326008)(66446008)(7416002)(8936002)(81156014)(8676002)(55016002)(9686003)(66476007)(7696005)(64756008)(52536014)(76116006)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6d+FMmSrpopoix8xTELED9bWhHYJL6MbQlo5fT1iKCv7k0YbwxgWZEkxekRSYbI5zQQn+SO7mKlDstJwwIIt/5+zvQlaw09RTWEDFXyIpmoJP9T+qWwtrFQG6OE8ADMVDm70lEDjtgmJGMwd+ZcjL4Z5AZfLWGU4o5ciQJAeE8nPnK9uXl/1FQs0qss7ry/EXBJPl19jKz8HU1gpjVjMv9JZ/T2izrKgItZ+7Rk5QBxvZ/+aEjh9fQjDqVV904QubeCs9GW5OYAK+D9NEHOi/Waa7TlUxhQfEl213c0aehy5A0lVZZ7N3f8Yyqx/a/M5UPVDjUUMFJjZWUqepEa2VNw60FJNnpsAwK5qh8Qd+FWawC+GNRYuuA4bxqS7IAStl9nrsRU2mZGVuJchE+FOOXLvD2HnpdvRzLE9tF/YQfkBWAhmwhD3UOXdTTJR2Z/
x-ms-exchange-antispam-messagedata: ZQLd4rRRIbi4SkTo4U/jHHAI2bXfR4ohVGVYh104wV77OqznZ6zfbhhIFbA3ADxdP86Ua2cfqlbC5yjvxOaLnsb4g2rPLZvQqf8oNsbKAryqYS97653At3aQuJmFO64cMLXJFETaAfScXDVUXYp+SQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fc26efb6-5156-4c17-ff53-08d7e26f37c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 01:32:40.0671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irnBGPqEHBRj3TeLZrN9SOGDaWBSiIqQLK6OqVMZQeydDQ0KH4uBnJ1qpet9KXHT8T4DGlJqCalYPzXmmPVO4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2084
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSXQgc2VlbXMgbGlrZSBhIGdlbmVyaWMgcHJvYmxlbSBvbiBhbGwgQnJvYWR3ZWxsIGRl
dmljZXMgc28gbGV0J3Mgc29sdmUgd2l0aA0KPiBvbmUgYSBzaW5nbGUgcGF0Y2hzZXQuDQo+IA0K
PiBTaG91bGRuJ3Qgd2UganVzdCBhZGQgdGhlIDJjaCBjb25zdHJhaW50cyBmb3IgYnJvYWR3ZWxs
LmMgYW5kIGJkdy1ydDU2NzcuYywNCj4gYW5kIHRoZSAyIG9yIDRjaCBjb25zdHJhaW50IGZvciBi
ZHctcnQ1NjUwLmM/IFdvdWxkIHRoaXMgd29yayBmb3IgeW91Pw0KPiANCj4gVGhhbmtzDQo+IC1Q
aWVycmUNCg0KSGkgUGllcnJlLA0KDQpBcmUgeW91IHNheWluZyBzdWJtaXR0aW5nIGEgbmV3IHBh
dGNoIHRvIGFkZCBjb25zdHJhaW50cyB0byBhbGwgdGhyZWUgYnJvYWR3ZWxsLmMsDQpiZHctcnQ1
NjUwLmMsIGFuZCBiZHctcnQ1Njc3LmM/DQoNCg0KUmVnYXJkcywNCkJyZW50DQo=
