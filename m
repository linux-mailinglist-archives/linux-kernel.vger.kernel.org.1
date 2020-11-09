Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F015D2ABB71
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbgKIN2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:28:20 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:6900 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733169AbgKIN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:28:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604928496; x=1636464496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r5avHiQkyvQexodZqUTGLEc5YQrwbiK544WIytT6JRE=;
  b=p7MF1Ccdq2h5BuIGx1k5z30+B5MRtmVTjddbbEvol7B2AOqXxN3ZpzSY
   s1MxqvbLHQsCJBeKtgV4OE2zEGh6kMcvVCb3ZA59KqH+itohws/HyVWGo
   D/OX7LucX5SDStGkogihg2bF9zbVqvhwNqucuazwfHLA/Can6MOlMUTG4
   Vr11O4Tsg5as0uYpIPgr4tzBZT2ED4Cu5W3cJHhreqamN3i3Nz7DmwfIO
   lSFnWxQMfgRrUga1hKvPAK9q8f5Ce+43Vp5BXBfd7ZeQU4zlo/izPX6T4
   RKHZQCncXAKD6pU5H/giWliUt5IG52sh/lq+5kTJGnktuSdm10UqqBbnd
   A==;
IronPort-SDR: Vvzam8V0O3m3LYkSiioUA9zHl79noTyPUlMM+2bGTMaUdzv3EGD/IiQq5cMl47sFg9cd0b35dN
 7JKQSwIkbhdO1htAgP2cVmo0IBAR3BqYYvJZulcHf9+X17ZJQjY6Ik4qMiIfjm+fKAWm42i94Y
 tXzu6H8t4CUDiNlN4ReXgtV2WdiEH71HQnSB0XXE53Nvg3PTnFeKp3o1ueJfLR+4j6x7zAqpzr
 D8K6MJTZx3dZG3XfVYBpVTuJ7OHR0HWuVdZyl9KU4GE9xyc2Eik6e0XgMP+7f5Ie9x7NKXJajj
 6gQ=
X-IronPort-AV: E=Sophos;i="5.77,463,1596524400"; 
   d="scan'208";a="102690367"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Nov 2020 06:28:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 9 Nov 2020 06:28:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 9 Nov 2020 06:28:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcJw0V5ZURAriAYOrPCN3VN4YlWc0TPrJS0RWbNI2SFh7DAjAe0TH8d/ZRv2SXZLDwXP6/cX86g/igO+P6vN7sb38Wo9PYsYP9TIi/vDL1oYdVHoD7Whv/XIUd1/MziiWT1utDHk/O1wlVFwt3a/S7GJ50jvIezrF+UZnhy78coVGRVmgb7DjB0zyhgdkFwg+O7nUbfnIJu8RdUZjHw2LgVTWdDvKEuTlHX743AgarRUo3k/FyoaYe69UyNh2fiWglQgAd9eEdUOO6sXRMLP1urhOK7y+FcYTDTvpxNK8VjFW0foshVqHRvJQGK0iTt3pTcOjDXjEA1c/k77L3I/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5avHiQkyvQexodZqUTGLEc5YQrwbiK544WIytT6JRE=;
 b=RJo9sXBI5HyWxE1YCZxUKhNdTWlq6GY9htGajkJACR3/tcwSadSnG5lMyCLCnYpKmXzqKMp/+fQrmj2TaPg4flT76l+L23mnKF8ocgU+5T9ufyse7d+gEf6c/VcNnVTrV37ffnJ1VPu2ZRE/5Basxyo8GKda6ZXXODa1HVAVzDJCRQUeqffv0Zb2xnLBFNlo8LDwvzSQLM+Oq3GQ75LahL4iSgKB0m0O3LfkLVTKIWWxCLvQF2eDhIeamSvXgEBbbqtTlR86CEVBHEi5tHTzVLgpeAxDQqsCB2NondHIceAzwlLDs79zZr9pB1ezpqIkESa11Gu1eLPwsP9K0FbX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5avHiQkyvQexodZqUTGLEc5YQrwbiK544WIytT6JRE=;
 b=Uj/5W0F4KQEVcXWIml3skBJigl4GPxIiITdQuX/PcVkpNMqn4gYq4MmAv5reH/4iohX17GhtIcF9H+bDpblqBypPn/rb/USgZKdCm8V/INAj24qbsbpPkLpytUcmwfV0asTr+EP2WEH69DeCDX1UyOcb8igOcz3b/DkeoA8w0Gg=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2685.namprd11.prod.outlook.com (2603:10b6:805:58::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 9 Nov
 2020 13:28:12 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3499.032; Mon, 9 Nov 2020
 13:28:12 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <vigneshr@ti.com>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v16 14/15] mtd: spi-nor: spansion: add support for Cypress
 Semper flash
Thread-Topic: [PATCH v16 14/15] mtd: spi-nor: spansion: add support for
 Cypress Semper flash
Thread-Index: AQHWtpwqZuIgH09300u0XqKhQVtAgw==
Date:   Mon, 9 Nov 2020 13:28:11 +0000
Message-ID: <2885e3ae-3a03-d6c1-4cb8-3c56256713ab@microchip.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
 <20201005153138.6437-15-p.yadav@ti.com>
 <7d058da8-90ef-8f71-fe86-cc0b27a2895a@ti.com>
In-Reply-To: <7d058da8-90ef-8f71-fe86-cc0b27a2895a@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.107.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d44dbc14-35e9-4265-f580-08d884b34e48
x-ms-traffictypediagnostic: SN6PR11MB2685:
x-microsoft-antispam-prvs: <SN6PR11MB268541CBD25AD358E5C7F092F0EA0@SN6PR11MB2685.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S+XntHtCxfCT3Ia3hzJQYPkgsJey6Caq+qJWBRDVuEYkis/Hhxsk0Jh4J0iNIIswX//5xTgTOqTfkbxudHcHMhkcd1HsGKYXLPtIIvqYEc7o3rxUJxDCd6P0V5J9Lz+9LwqYHepaRG3RhlPKOpx1GgfPlMkECOs6Jyxms87pjSKcXP9OERznamnLM5qPKuNEZf9ehID2S6jqQgu8Elj67D54hSf6d3Ei7hWbPwJb4vU1B6wClRma4XXAMiNVXp26bKAkDE/cSmWGzmrIquj/b6kvFqhcexz5QTInsQi1jrjOL3Nx/8Tb0Y5UZPZ3XHUhUClovlv6YrgGFzugYJ1DkA+q49I9iGwaNKSBzgK9BtxW8VwOrH1rcwueOiuqgsRd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(396003)(39860400002)(366004)(346002)(36756003)(2906002)(5660300002)(76116006)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(86362001)(31696002)(54906003)(71200400001)(110136005)(478600001)(186003)(26005)(4326008)(6486002)(83380400001)(8936002)(31686004)(6512007)(2616005)(8676002)(6506007)(53546011)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 8ivwJjPYpNMew6B7zTAeHtXlAJzgoJbBa5FitxR+TNdKKowxIYNji4qoz0WC5FceMX9jW9LD6cx64AgdxGK5UqmG008opNKsY1E9UV/7xbUV141E6dNVu5I5yTxF1J2h2ZUkXiU3w61RuxnYJenr4X7NaPNRCBmVLGbD13AKHw0fnBXj6pBEedATB44sOPO5g9s5aYI7qNyH0dGNFuOAixovCmkpIwReS0ZZI5A45ylHwYOhOclaQ5rDmr737kzjIdU8BjG88/0yJ1yX7rVeCgoy9O9elN4pSk5hPoE3Y27rXdyheY0eR53J+gJc6lcJ4OXWieeThhDLndH2ejGngLCmW+N77AkFKSUICN61ukiujsUny6rEGiVV3ssafuaoCiX6AXX1XWUTApOJMrd4no97o+MOXKCaWX6Skdvb+qmd/XrZhC1OMRV2YR/b/SsSJ2p+nyqvWxbH8+63QIMmj3nfIS/mScCow1f7vFtOpmROoIO1yo3UR/Akj4cVPuTyOXWPX4sC2qNBhGJCsz1u2KAfo3vYSCKCFiMABsAdeqcpeDztNFexcMqy3yJSZ/BWZB+Gqy6ws3NPFwQj399qFzr7wrDR89Xlgu8ocGOmez08q/3nUJLLhoYNXNVpWQ6FndJURBBupiy2fIrlVfxPxA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6BB0849F94A044DB169DBEF6567FE18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d44dbc14-35e9-4265-f580-08d884b34e48
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2020 13:28:11.9067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JpaDpO8YKwhkhOBGy0piH3+d7wclXzaP60GRzYPPPK8W8aveMehE2a+2Ts+gtnq5UNcKfznAPu8krRl+GCuco4epsyHgIlet6vgTVDVPxKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2685
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNy8yMCA5OjU4IEFNLCBWaWduZXNoIFJhZ2hhdmVuZHJhIHdyb3RlOg0KPiBFWFRFUk5B
TCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhpLA0KPiANCj4gWy4uLl0NCj4gDQo+
IE9uIDEwLzUvMjAgOTowMSBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+PiArc3RhdGljIGlu
dCBzcGlfbm9yX2N5cHJlc3Nfb2N0YWxfZHRyX2VuYWJsZShzdHJ1Y3Qgc3BpX25vciAqbm9yLCBi
b29sIGVuYWJsZSkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3Qgc3BpX21lbV9vcCBvcDsNCj4+ICsg
ICAgIHU4ICpidWYgPSBub3ItPmJvdW5jZWJ1ZjsNCj4+ICsgICAgIGludCByZXQ7DQo+PiArDQo+
PiArICAgICBpZiAoZW5hYmxlKSB7DQo+PiArICAgICAgICAgICAgIC8qIFVzZSAyNCBkdW1teSBj
eWNsZXMgZm9yIG1lbW9yeSBhcnJheSByZWFkcy4gKi8NCj4+ICsgICAgICAgICAgICAgcmV0ID0g
c3BpX25vcl93cml0ZV9lbmFibGUobm9yKTsNCj4+ICsgICAgICAgICAgICAgaWYgKHJldCkNCj4+
ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgICAgICAg
ICAqYnVmID0gU1BJTk9SX1JFR19DWVBSRVNTX0NGUjJWX01FTUxBVF8xMV8yNDsNCj4+ICsgICAg
ICAgICAgICAgb3AgPSAoc3RydWN0IHNwaV9tZW1fb3ApDQo+PiArICAgICAgICAgICAgICAgICAg
ICAgU1BJX01FTV9PUChTUElfTUVNX09QX0NNRChTUElOT1JfT1BfV1JfQU5ZX1JFRywgMSksDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0FERFIoMywgU1BJ
Tk9SX1JFR19DWVBSRVNTX0NGUjJWLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDEpLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFNQSV9NRU1fT1BfREFUQV9PVVQoMSwgYnVmLCAxKSk7DQo+PiArDQo+PiArICAgICAgICAg
ICAgIHJldCA9IHNwaV9tZW1fZXhlY19vcChub3ItPnNwaW1lbSwgJm9wKTsNCj4+ICsgICAgICAg
ICAgICAgaWYgKHJldCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4g
Kw0KPj4gKyAgICAgICAgICAgICByZXQgPSBzcGlfbm9yX3dhaXRfdGlsbF9yZWFkeShub3IpOw0K
Pj4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+PiArDQo+PiArICAgICAgICAgICAgIG5vci0+cmVhZF9kdW1teSA9IDI0Ow0KPj4g
KyAgICAgfQ0KPj4gKw0KPj4gKyAgICAgLyogU2V0L3Vuc2V0IHRoZSBvY3RhbCBhbmQgRFRSIGVu
YWJsZSBiaXRzLiAqLw0KPj4gKyAgICAgcmV0ID0gc3BpX25vcl93cml0ZV9lbmFibGUobm9yKTsN
Cj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArDQo+
PiArICAgICBpZiAoZW5hYmxlKQ0KPj4gKyAgICAgICAgICAgICAqYnVmID0gU1BJTk9SX1JFR19D
WVBSRVNTX0NGUjVWX09DVF9EVFJfRU47DQo+PiArICAgICBlbHNlDQo+PiArICAgICAgICAgICAg
ICpidWYgPSBTUElOT1JfUkVHX0NZUFJFU1NfQ0ZSNVZfT0NUX0RUUl9EUzsNCj4+ICsNCj4+ICsg
ICAgIG9wID0gKHN0cnVjdCBzcGlfbWVtX29wKQ0KPj4gKyAgICAgICAgICAgICBTUElfTUVNX09Q
KFNQSV9NRU1fT1BfQ01EKFNQSU5PUl9PUF9XUl9BTllfUkVHLCAxKSwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICBTUElfTUVNX09QX0FERFIoZW5hYmxlID8gMyA6IDQsDQo+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSU5PUl9SRUdfQ1lQUkVTU19DRlI1
ViwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMSksDQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfT1VUKDEsIGJ1ZiwgMSkpOw0KPj4gKw0K
Pj4gKyAgICAgaWYgKCFlbmFibGUpDQo+PiArICAgICAgICAgICAgIHNwaV9ub3Jfc3BpbWVtX3Nl
dHVwX29wKG5vciwgJm9wLCBTTk9SX1BST1RPXzhfOF84X0RUUik7DQo+PiArDQo+PiArICAgICBy
ZXQgPSBzcGlfbWVtX2V4ZWNfb3Aobm9yLT5zcGltZW0sICZvcCk7DQo+PiArICAgICBpZiAocmV0
KQ0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKyAgICAgLyogR2l2ZSBz
b21lIHRpbWUgZm9yIHRoZSBtb2RlIGNoYW5nZSB0byB0YWtlIHBsYWNlLiAqLw0KPj4gKyAgICAg
dXNsZWVwX3JhbmdlKDEwMDAsIDE1MDApOw0KPj4gKw0KPiANCj4gVGhpcyBkZWxheSBpcyBubyBs
b25nZXIgbmVlZGVkIHJpZ2h0PyBJIGNhbiBkcm9wIGl0IHdoaWxlIGFwcGx5aW5nLCBpZg0KPiB5
b3UgY29uZmlybS4NCj4gDQo+IFR1ZG9yOiBDb3VsZCB5b3UgcHJvdmlkZSB5b3VyIFItYnk/DQoN
CndpdGggdXNsZWVwX3JhbmdlIGRyb3BwZWQgb25lIGNhbiBhZGQ6DQoNClJldmlld2VkLWJ5OiBU
dWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQoNCkNoZWVycywNCnRh
DQo=
