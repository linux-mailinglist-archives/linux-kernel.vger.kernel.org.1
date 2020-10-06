Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D2284AA0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgJFLDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:03:04 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:45607 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgJFLDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601982199; x=1633518199;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q0OhbCu/3MyNvlezO5I3mvRw/SRHc4WQt8QcrGCXnVs=;
  b=iW+J17U/hDVwKzALaYsJC+Ypg+Lco3bBBxFBXRdJ95+S7v1YEkDfrE2k
   CRcdSx1ozd2uKRtAZxhGCMStE97wlFnRJcc+69G4sVl/YEuB75Ee8CAVO
   2QdD0xgpH48bfY2By/xfuVCkJhgxCLCYLzlzqX3iwpV7hctPjYwn8SknT
   fdqzDIFULxh6MlWTcJypPAbZY5BJn27hCfRFfBeUMNmnXAj/gxkAucCAB
   RfGgSsQexz5Jz3Lv+8xetJGnMGv1NEeVwsBmUpR2ZJiSjdO5cG2MorDD3
   ecxSAlE2grXyQ/GxPo/5RUdRPt3rtHEoa1kxH+Je0TF1upOiYzRJp5fGn
   Q==;
IronPort-SDR: Sg4knI0vpkyOR10q4HuaHO5bpCn5S1PJlt1ZrEwVvGKF0hlVXwnZOMWkMmiMl3pQb3NMZgSSL+
 B3zdoUyIsHCfS47sI8i3MBw5RSxgMgDlI0QHymiXhWySh04dqtH3uAJzeIxCfgL35yb3Ou2mBv
 IPiBeIeBo+BEx8ctlXeWbxsPZdnA4tZXvvQ+olARGoPO61sj+O6NPnSGxaiceavewwANqljBq6
 eMLWGV3wVLEJZuZ0t6sZm57ihereePXTOLCKXBtUYJh253owl9l3aQ+jpFx4rX6TrFP+kyX081
 SXU=
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="94361456"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Oct 2020 04:03:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 6 Oct 2020 04:03:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 6 Oct 2020 04:03:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XW9J0fRlI8PSiE07FypQa53e7+bD2vP4tP2CoKVcdcxdbYTHKXhTKFm/jrLucIDFbKLHKywlPafyLIV4vdgZ2rZORFOkfVN1t3uPNlUBhnBcUBhpq+jIJTwZVIKEJafM1ldceJWU3RWURSlyMmnOtuhBssG/Vv8Ff7CDE0gDFJUqDAc0a4G9cvF77UPMzINFg0lQQd5xViAFKcFmnbI49kNHJ/nKhSVJnWneJJgQcEnKcWssOqUenOlHOFC5c54/9BPmLvLtsklju7y3+xY73aEuKE/inwdtUfBSAcJWHyMBjLkwfpeFRFZVMrHBRd4FeqeNP8QuWNRe0W/0v9nqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0OhbCu/3MyNvlezO5I3mvRw/SRHc4WQt8QcrGCXnVs=;
 b=TV0qWddz0bmK4PohTBFnEzhsYgiHTvrXz+yFiea4X9mWomB3vRkqGZkCGo/lkajNXraa3CUyE2JfTODrlh8HPgiaTfo9XLe8e+V+IvyNBmFigAFpelECIv6RxDr94UI2UxK8PmRVNBuz9aG4EbJkYsjN952JHFn6K8xhw5AWTrlHreWtYseBw1cGZf0SkzYaa5XDsmQxkKIBgFr81z0OffXZoj5fvC6tMaVHvGCDM6bapgBYH1MtIDjVW8yiGIgpJdkxrlQmkWtWAdJtV/1cz+QXOgfw5Y6DDAcqRANrzyY0gxf3xbrGakikGJeqNwsCTMfF4krGL8Ox9kMl+17FTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0OhbCu/3MyNvlezO5I3mvRw/SRHc4WQt8QcrGCXnVs=;
 b=Ko+JCYbxM43Xw+K195tgK4qcCUpQZ1tDSLix+cDzWk6RBJwLE7w6neUU3QFQIx1uXitVO+bvCF/tizLXG15CE4ffVDkYlZ50sO2MchqNi1RvLtsM2DPq39PpsPmhvVYXxCVOmZ0ykegiRke+J59WnGsIitxMpfn9ek9aQzz8dzQ=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Tue, 6 Oct
 2020 11:03:17 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::7c1b:6212:7f1e:5c6f%3]) with mapi id 15.20.3455.021; Tue, 6 Oct 2020
 11:03:17 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <bert@biot.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Topic: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Thread-Index: AQHWm9BKX2rNJEczUkGjcv47/rFXbw==
Date:   Tue, 6 Oct 2020 11:03:17 +0000
Message-ID: <ed7e13a5-db3e-79ad-0cdc-d2875cef2d22@microchip.com>
References: <20200930235611.6355-1-bert@biot.com>
 <20201001063421.qcjdikj2tje3jn6k@ti.com>
In-Reply-To: <20201001063421.qcjdikj2tje3jn6k@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dde44286-2e8c-4016-19b0-08d869e76de0
x-ms-traffictypediagnostic: SA0PR11MB4687:
x-microsoft-antispam-prvs: <SA0PR11MB4687C9BBBD3CFC9CC1D1100EF00D0@SA0PR11MB4687.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j5WzV8QeCE3HNePeoTSxO9vcPbbshUtm7+Io3VgzEJKtMG/GNRWe9J23wal4yv6GyETjb0HRKz1giBanP6Sdo5/KPDK/VaxyRMDe5v43SAFahN9N/6ZfkKEKOcUwTbNU26umowjpBZM0yr5ZamdlBAIMN1EEozfPav/YaKWXdi22+yeTvVyTHgNpczB5oJKogaRo1gtLh8zYr5GbyQTAjGBX5oiBSghERA/HL+jX99jWFi0ar0a6RjqCDe0bgc2DJsGjRpTXpscLOF7srZ/dqniTFox/4guOUVRldtGHrLzOGbeZUMmFyFGXKc55+j0ifMnpoBkdVj/i+rt2u5C8heMTdQBx+vAfHMZp+T1BRPKRXUGlGedebwLBFqIjyKty
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(376002)(346002)(66446008)(110136005)(54906003)(64756008)(66556008)(31686004)(8936002)(5660300002)(4744005)(76116006)(66946007)(316002)(31696002)(71200400001)(2906002)(66476007)(478600001)(4326008)(186003)(86362001)(2616005)(6486002)(36756003)(26005)(6512007)(53546011)(8676002)(6506007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QPzyNpW6cSoETz9rBOTJgn+Dji4DrKbEP9D9rDAQZbrVuLH4T2Yek1flV/u8bV7Mk5j9qtzsVwNDj4s2fhHhgKJZFrOP1RKhRzRf9BMrO1ga2Ce7IZrT1yNe62kWssFUIkfREYnTCT+6/fYYuaXoHTePmZMfyRAcF6qFwTczdcBZ+eHqSSxsr9/s2XH1GxS8y5+hNZqgWny5gkr8NXpR7QTmVv/RJ7WSqOv34IuQqr11qvg0jHYRgLekYYcxnny2eP/uSvOscmvCxltPUsK4VA14NDwfoHIM8tLDGpBmrPcdeyIZa1whYS9p+fjw/7IztiuS6bkfTglHHRioA655IQqjes0QkvUTZGIeRpOKjmM2yTtYxoCUQ+E3/dwGqoWqasA79cLNX8DRFicS5J7iF1sVpir/03XiQBSz3d16tqAF7dVmvSuwUgrg0CQd0ugozoBLRMeF5GBuf1CgBbmVRHrbDOTC37q7D1BhD97noEiy3vVQx0L3miS0G8tyjYeRo3kiTIYaduXW1EFHpz9KqiLtny+tDTUkOWuAW/hcyoKv/873Kc8Wjfntu0iJadI7SmumoL/VyQMXU1CFhKJ+cxa9HqWVvxipDupKZ+gTBBoVXZabV3af5ewSyQ2poXRGVGbisOE4opnwuln44pCT2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EF7B6F44963AE4FB31F90812C5C4245@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde44286-2e8c-4016-19b0-08d869e76de0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2020 11:03:17.1593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aIPKpZOYD2v39hCf3GAxpY/uda58AEngaxuOBXo9w2BD0p8WM4MMKqOei4m6H/xm8jXhj3DsKkRlBuDbbGU+j2wg1MtfVosw1pSkKxG/yRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCA5OjM0IEFNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gU28gdXNpbmcgYW4g
YWRkcmVzcyB3aWR0aCBvZiA0IGhlcmUgaXMgbm90IG5lY2Vzc2FyaWx5IHRoZSByaWdodCB0aGlu
Zw0KPiB0byBkby4gVGhpcyBjaGFuZ2Ugd291bGQgYnJlYWsgU01QVCBwYXJzaW5nIGZvciBhbGwg
Zmxhc2hlcyB0aGF0IHVzZQ0KPiAzLWJ5dGUgYWRkcmVzc2luZyBieSBkZWZhdWx0IGJlY2F1c2Ug
U01QVCBwYXJzaW5nIGNhbiBpbnZvbHZlIHJlZ2lzdGVyDQo+IHJlYWRzL3dyaXRlcy4gT25lIHN1
Y2ggZGV2aWNlIGlzIHRoZSBDeXByZXNzIFMyOEhTIGZsYXNoLiBJbiBmYWN0LCB0aGlzDQo+IHdh
cyB3aGF0IHByb21wdGVkIG1lIHRvIHdyaXRlIHRoZSBwYXRjaCBbMF0uDQoNCkRvIHlvdSByZWZl
ciB0byBzcGlfbm9yX2dldF9tYXBfaW5fdXNlKCk/IGFkZHIgd2lkdGgsIGR1bW15IGFuZCBvcGNv
ZGUNCmFyZSBkaXNjb3ZlcmVkIHdoZW4gcmVhZGluZyBzZmRwLCB3ZSBzaG91bGQgYmUgZmluZS4g
SWYgUkVBRCBTRkRQDQpyZXF1aXJlbWVudHMgaGF2ZSBjaGFuZ2VkIGZvciBvY3RhbCBkZHIsIHRo
ZW4gd2UnbGwgaGF2ZSB0byBoYW5kbGUgdGhhdA0Kc2VwYXJhdGVseS4NCg0KQ2hlZXJzLA0KdGEg
DQo=
