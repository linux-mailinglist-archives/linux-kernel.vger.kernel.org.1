Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369D72CD954
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389200AbgLCOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:37:29 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:16426 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389179AbgLCOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607006246; x=1638542246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EjjriIpz/9t1vKbSIhlb73dg0+Ywv/2T7HJ1tHKcJro=;
  b=CzBdfSAJ2ukBgAvwM0aHshNM8NtKo5VbotKrwudLWLrkfbZr6HJ+fRRP
   g6flAZlAwNeuaGW7HwxynaCqUSUV9Ky4/ibg38Vb6dpoc2suBy/wqvFBJ
   w+NDCDiPC43xptu9yMO3NZWbN6AvZGyQiShh+siXdGJsWb4b2wmVi/1cU
   smrnWP4tRdY1NdwBfbVutBP1PrTY2+ZTQdTbP5REqCfhF9UStIDbHZ7Vh
   eHwZTdqPClUMB1lRyZt5EVK57RxtiH85pri3gGC6//E+GIbl0AwV03Uol
   WMro7rpRt99sCNzasHqS+Wbwhis/d8nqKAUy/vOvw8j/Th3nrcUryOTr1
   Q==;
IronPort-SDR: eqtjMG8c9vFtwnwqdYC/6Wc2vaPX4igwva7bXS3Ay0ndGkp9AvYqLfWGJIo9shquNVfOzc3fY8
 LTWUnIxUmp3YjNfOFSCjlJW69xRgls8nv53dcfE9ct/5OhmQaF4NkgEVlVKm8lI1Hu5qW7fADo
 d7mGXHpI6/3S0BMDDiuq2eu3Jy0coUZqnNYLZcUUx0FiC/ll9BilQA8z1kHtM3boF7yRO0D5Os
 xUW4XzFMxwyhOWRj1pu0fPLFW3G2lPp+xt9aic5aXDUraCUTsoLQ2LtAyVzmRklOfLS3yoP1I3
 G2M=
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="106011962"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Dec 2020 07:36:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 07:36:20 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 3 Dec 2020 07:36:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPO1VfiesUKOM1a6l3qiAGm3HdqgRo4I1blW0oLbDsI5dDR1q7MeuyVpzXo5ay5GsaopRETYIRMbOLdgxFQIOeauY08S/wsLEWHJ32RXFGVjSC2rb522nCtaMA/0zMgvhm3Lj++stuPVMCyUwQQGolUQQCFBKqulnTLtgPhxJk6mnnVZv8euptA7ZZ2cPJXeBICzfzCQ+eEMkoz03yAPmUBsivn7LmNhMis61HxDxO/GFT6k4sISlXKMntQU4n94G+ds1whM4MXSWanm9SOySMpyL6D28M0rNCvuw61TBglw2DZEi9hOLsX9wYTwd6Oe+h0t3MUkv2ZLYkL/XuwO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjjriIpz/9t1vKbSIhlb73dg0+Ywv/2T7HJ1tHKcJro=;
 b=jkldp1jsWXkWzax5Eo+cnJBezeOplKg5FHr/M+6p/N2OB9o4+YtvxL5zR0nxG/GH6A2ec3MKy2p6v5VlE4OqVgFFShbydF9Lw2eoQ8mu7UNpDgO7pz/qPfvBDhk2B9REdKHoSDsHn/z0HFt9K/q23uTJ5cNZaDf8fh19hMZQ+nyI9RzOZ8qxvizIm15y9PhVxEeO/0NKOA3rzo1S9x3vQKpSGa4M27gJqbA9/mqYW5/3NRgW4UklLRpJsx2axD9dWDqauD08rI1PsXPQlxv1hMXexafSLfXxnw+DyleodonOG++dhRXl6f7xR+5ngXceUZughsUsJH0gzDzG4SeOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjjriIpz/9t1vKbSIhlb73dg0+Ywv/2T7HJ1tHKcJro=;
 b=LFAmG3eZ4bDdJVdYBcWMOpYEue7n+54+i18TyGmpiwBPjE01i40WCegD9Dq7tO13VXqEnwmgtMuNDVRVUB4pO+bpxYyBtAKQShZQNTs689eASXK7NcREbQKRSJb9bYQjxkqnayOXzmiPW0csnTtoCqFBlvX6d/4B3pQsQfNGzZo=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA0PR11MB4687.namprd11.prod.outlook.com (2603:10b6:806:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 14:36:19 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3632.020; Thu, 3 Dec 2020
 14:36:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v7 2/7] mtd: spi-nor: ignore errors in
 spi_nor_unlock_all()
Thread-Topic: [PATCH v7 2/7] mtd: spi-nor: ignore errors in
 spi_nor_unlock_all()
Thread-Index: AQHWyYGpH7wscYLT9UyjYlIzinWO/A==
Date:   Thu, 3 Dec 2020 14:36:19 +0000
Message-ID: <00e79a8f-17f5-d954-5d1a-20acf9dda4ff@microchip.com>
References: <20201202230040.14009-1-michael@walle.cc>
 <20201202230040.14009-3-michael@walle.cc>
In-Reply-To: <20201202230040.14009-3-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.95]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8a9de43-2814-41f7-673a-08d89798cc5e
x-ms-traffictypediagnostic: SA0PR11MB4687:
x-microsoft-antispam-prvs: <SA0PR11MB4687E04514891AFDADDFD3BFF0F20@SA0PR11MB4687.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: La2Di8uY1P44R7PRvymQuvBzjpQKzNtv2nuAENm1BLSWa/sC9YX4jbcWpEBfnKDCgi3nLEkpThiukMovxlI3EsNlQKFupB+rHsKwXX8M+3ixAqlZszzHqa1Jz4InQOgNy0nkzpxA8lQP2hdJJ1xIh5iEvvfPJ1irt2eKoXZ8MmZhsoAuaIK1GiD3TzXyhI/3C7oEYmBNqmodaIHSexmKipQWGDikwTsqs8gOPP21bjzWylTHDGzHEe3xPrhiGX57fz8uT3rbiCiAZ0GVmVfmIP+G6MifNAuDaB6SVWbYK+Tq/Gr6rRcOHE/iCQ6jZoHLCYhMaYCAsiEDnax1+twRnTuekL/qAZWbJGRRNIZjCH+wfn8rieTOcczHLjDFep1CY2mm/gVuwoUNXKJeo3XKWSj/bzu2M1lsz7idhprqAzg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(39860400002)(376002)(346002)(6486002)(36756003)(54906003)(86362001)(71200400001)(64756008)(8676002)(66946007)(316002)(66476007)(2906002)(4326008)(31696002)(110136005)(76116006)(66446008)(66556008)(2616005)(8936002)(31686004)(186003)(6512007)(26005)(83380400001)(53546011)(5660300002)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?STRjcWYyZy91enkvNXNTUGhPZWoyN2Z6cjJwUCtXVk5WZUUrM1BxM2IxNGNW?=
 =?utf-8?B?SnB6bE1reER6RjZ4WHBjNHBvRytaN2dtUlpUVzc0bFQ3VFUvQnpEOFJWR0Jp?=
 =?utf-8?B?b1l5NlFCQUp3c3hIM1VMM2QzRjFSLzcrRW5uRENRS0huQUZZbmgzRW15ZWZ4?=
 =?utf-8?B?MnpwZCtWcldhNHR6aHJmMGMzK3E3YTVUc3NoL2NBK3d0M2d2SUx0RzRaN1N2?=
 =?utf-8?B?RjhRcEZlUkI3U3NqUU1sYzBnVm9oQkF3TXo0RnhqU2tMVklIZWJnUEFLaUZ0?=
 =?utf-8?B?ZERGQ1JtRStmWVRGQkxiZnpKUjJvdEZHTkx2SlEvSVJmdmtkQmJUb3p0Y0Vx?=
 =?utf-8?B?L3luQWw5eVRtcXVJOFlKYUlzQXNqM0d5NWV6UzNYOWU3a3VCcExsQXRDY01E?=
 =?utf-8?B?U1lBVmIwbGYvdzhCMXNnT05BN3B0b0Z6TzRKNE1HZHoxL1NEOEEvQVN5RGJn?=
 =?utf-8?B?TG5ab1lsOTI0QXM3YW9KUXBJeWRvcXNOQzk3eWZ1ZS93akJMWTR4ZEJGeG1B?=
 =?utf-8?B?K0NTSXRxVnRIdlJ4cEh3K0hQRG04eEp4ckFoeTNTRzJxdUZQc3Mzb1hCanMy?=
 =?utf-8?B?VkV6NGMzWklWcmNFRm9kTVNYUUM4dGp5SlgyVVB6Zk9vV01NWk1ra1JwWHhK?=
 =?utf-8?B?M1ZhRmlrczVCT2dnQUF0L1NINzcwQXdPdTFVZGVsL281T2VQcEwvTWgxNisr?=
 =?utf-8?B?bFRzZ0pGa0hDOXo1c3dvaWViMEZPNDE1TGkrNWQ3WnJhejVIUUozcTRLSzdD?=
 =?utf-8?B?WC9MOUxMZjFIdmdMUGZmOENyWEkraEg3R2RNUFlQNDhwZVhPeURNV1BtSUhk?=
 =?utf-8?B?Slp5SnF3YjdDeHlqRjFxdFU2Mkg3YjJYdG0vSzNFY3Q3WTY5Mk5uaXQ0Qytx?=
 =?utf-8?B?QlZDWloxR0FnWmF5N1BDWDhkcWFGM04zTHJwemYyZjhTdVF2MXorV3dsN0Vp?=
 =?utf-8?B?YjhiZnJ4cmd4L2pSWUdjNDFVVmx3Tk1hNThBeUtLVWhSd3h4Z1JUUWlVVFJx?=
 =?utf-8?B?TVd2TEZOOFY3RnhCYXFqMUhzc2huZGY4S1JQMC8rUUtTanBvdksrZk1USndy?=
 =?utf-8?B?ZDVhYnBKNGxIbTYwOHJQR2h2TEhlQUtRcnVvMm5nNW10N3BFaFlkMXAzLysr?=
 =?utf-8?B?Ukw4MFRKR2hNWUt6bWxCODhWZVNDMFk2N2RxVTlHVXZENXBqTy84ZG1kVWpl?=
 =?utf-8?B?cVdqSXJBeEJHUFRBZ045VkF1aVkyY3Y0YkF1bG5NVHdBci9McVVNaEVUVnhu?=
 =?utf-8?B?c0QxUjV4UjROc2c5TDdrdXZaRUZHUDhoTkZuYUx5amJVZTY0NW9jTmg2eCtP?=
 =?utf-8?Q?fM9G1QyB+kWMk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC612DA40BE3A546A46DD790B4EECCB9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a9de43-2814-41f7-673a-08d89798cc5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 14:36:19.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uuViZ30k7g4PgKQvXMmIe0zVKzEBLgHtg7nA75J02SecGOE5rswiTU+NLyMy0l0CTQaj/bxpa1MTCtZJG3ymA2CtPEUJ5bI7obXlMcgA6RA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4687
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMy8yMCAxOjAwIEFNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEp1c3QgdHJ5IHRvIHVubG9jayB0aGUgd2hvbGUg
U1BJLU5PUiBmbGFzaCBhcnJheS4gRG9uJ3QgYWJvcnQgdGhlDQo+IHByb2JpbmcgaW4gY2FzZSBv
ZiBhbiBlcnJvci4gSnVzdGlmaWNhdGlvbnM6DQo+ICAoMSkgRm9yIHNvbWUgYm9hcmRzLCB0aGlz
IGp1c3Qgd29ya3MgYmVjYXVzZQ0KPiAgICAgIHNwaV9ub3Jfd3JpdGVfMTZiaXRfc3JfYW5kX2No
ZWNrKCkgaXMgYnJva2VuIGFuZCBqdXN0IGNoZWNrcyB0aGUNCj4gICAgICBzZWNvbmQgaGFsZiBv
ZiB0aGUgMTZiaXQuIE9uY2UgdGhhdCB3aWxsIGJlIGZpeGVkLCBTUEkgcHJvYmUgd2lsbA0KPiAg
ICAgIGZhaWwgZm9yIGJvYXJkcyB3aGljaCBoYXMgaGFyZHdhcmUtd3JpdGUgcHJvdGVjdGVkIFNQ
SS1OT1IgZmxhc2hlcy4NCj4gICgyKSBVbnRpbCBub3csIGhhcmR3YXJlIHdyaXRlLXByb3RlY3Rp
b24gd2FzIHRoZSBvbmx5IHZpYWJsZSBzb2x1dGlvbg0KPiAgICAgIHRvIHVzZSB0aGUgYmxvY2sg
cHJvdGVjdGlvbiBiaXRzLiBUaGlzIGlzIGJlY2F1c2UgdGhpcyB2ZXJ5DQo+ICAgICAgZnVuY3Rp
b24gc3BpX25vcl91bmxvY2tfYWxsKCkgd2lsbCBiZSBjYWxsZWQgdW5jb25kaXRpb25hbGx5IG9u
DQo+ICAgICAgZXZlcnkgbGludXggYm9vdC4gVGhlcmVmb3JlLCB0aGlzIGJpdHMgb25seSBtYWtl
cyBzZW5zZSBpbg0KPiAgICAgIGNvbWJpbmF0aW9uIHdpdGggdGhlIGhhcmR3YXJlIHdyaXRlLXBy
b3RlY3Rpb24uIElmIHdlIHdvdWxkIGZhaWwNCj4gICAgICB0aGUgU1BJIHByb2JlIG9uIGFuIGVy
cm9yIGluIHNwaV9ub3JfdW5sb2NrX2FsbCgpIHdlJ2QgYnJlYWsNCj4gICAgICB2aXJ0dWFsbHkg
YWxsIHVzZXJzIG9mIHRoZSBibG9jayBwcm90ZWN0aW9uIGJpdHMuDQo+ICAoMykgV2Ugc2hvdWxk
IHRyeSBoYXJkIHRvIGtlZXAgdGhlIE1URCB3b3JraW5nIGV2ZW4gaWYgdGhlIGZsYXNoIG1pZ2h0
DQo+ICAgICAgbm90IGJlIHdyaXRhYmxlL2VyYXNhYmxlLg0KPiANCj4gRml4ZXM6IDNlMDkzMGYx
MDllNyAoIm10ZDogc3BpLW5vcjogUmV3b3JrIHRoZSBkaXNhYmxpbmcgb2YgYmxvY2sgd3JpdGUg
cHJvdGVjdGlvbiIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2Fs
bGUuY2M+DQoNClJldmlld2VkLWJ5OiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3Jv
Y2hpcC5jb20+DQoNCj4gLS0tDQo+IGNoYW5nZXMgc2luY2UgdjY6DQo+ICAtIG5ldyBwYXRjaA0K
PiANCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgMjMgKysrKysrKysrKysrKy0tLS0t
LS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZl
cnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+IGluZGV4IDViZWU3YzhkYTRkYy4uMDEzMTk4YWJlOTI5
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMzEyMSwyMCArMzEyMSwyNyBAQCBzdGF0aWMg
aW50IHNwaV9ub3JfcXVhZF9lbmFibGUoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gIH0NCj4gDQo+
ICAvKioNCj4gLSAqIHNwaV9ub3JfdW5sb2NrX2FsbCgpIC0gVW5sb2NrcyB0aGUgZW50aXJlIGZs
YXNoIG1lbW9yeSBhcnJheS4NCj4gKyAqIHNwaV9ub3JfdHJ5X3VubG9ja19hbGwoKSAtIFRyaWVz
IHRvIHVubG9jayB0aGUgZW50aXJlIGZsYXNoIG1lbW9yeSBhcnJheS4NCj4gICAqIEBub3I6ICAg
ICAgIHBvaW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InLg0KPiAgICoNCj4gICAqIFNvbWUgU1BJ
IE5PUiBmbGFzaGVzIGFyZSB3cml0ZSBwcm90ZWN0ZWQgYnkgZGVmYXVsdCBhZnRlciBhIHBvd2Vy
LW9uIHJlc2V0DQo+ICAgKiBjeWNsZSwgaW4gb3JkZXIgdG8gYXZvaWQgaW5hZHZlcnRlbnQgd3Jp
dGVzIGR1cmluZyBwb3dlci11cC4gQmFja3dhcmQNCj4gICAqIGNvbXBhdGliaWxpdHkgaW1wb3Nl
cyB0byB1bmxvY2sgdGhlIGVudGlyZSBmbGFzaCBtZW1vcnkgYXJyYXkgYXQgcG93ZXItdXANCj4g
ICAqIGJ5IGRlZmF1bHQuDQo+ICsgKg0KPiArICogVW5wcm90ZWN0aW5nIHRoZSBlbnRpcmUgZmxh
c2ggYXJyYXkgd2lsbCBmYWlsIGZvciBib2FyZHMgd2hpY2ggYXJlIGhhcmR3YXJlDQo+ICsgKiB3
cml0ZS1wcm90ZWN0ZWQuIFRodXMgYW55IGVycm9ycyBhcmUgaWdub3JlZC4NCj4gICAqLw0KPiAt
c3RhdGljIGludCBzcGlfbm9yX3VubG9ja19hbGwoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gK3N0
YXRpYyB2b2lkIHNwaV9ub3JfdHJ5X3VubG9ja19hbGwoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4g
IHsNCj4gLSAgICAgICBpZiAobm9yLT5mbGFncyAmIFNOT1JfRl9IQVNfTE9DSykNCj4gLSAgICAg
ICAgICAgICAgIHJldHVybiBzcGlfbm9yX3VubG9jaygmbm9yLT5tdGQsIDAsIG5vci0+cGFyYW1z
LT5zaXplKTsNCj4gKyAgICAgICBpbnQgcmV0Ow0KPiANCj4gLSAgICAgICByZXR1cm4gMDsNCj4g
KyAgICAgICBpZiAoIShub3ItPmZsYWdzICYgU05PUl9GX0hBU19MT0NLKSkNCj4gKyAgICAgICAg
ICAgICAgIHJldHVybjsNCj4gKw0KPiArICAgICAgIHJldCA9IHNwaV9ub3JfdW5sb2NrKCZub3It
Pm10ZCwgMCwgbm9yLT5wYXJhbXMtPnNpemUpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAg
ICAgICAgICAgICBkZXZfZGJnKG5vci0+ZGV2LCAiRmFpbGVkIHRvIHVubG9jayB0aGUgZW50aXJl
IGZsYXNoIG1lbW9yeSBhcnJheVxuIik7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGludCBzcGlfbm9y
X2luaXQoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gQEAgLTMxNTMsMTEgKzMxNjAsNyBAQCBzdGF0
aWMgaW50IHNwaV9ub3JfaW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgICAgICAgICAgICAg
ICAgcmV0dXJuIGVycjsNCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAgIGVyciA9IHNwaV9ub3Jf
dW5sb2NrX2FsbChub3IpOw0KPiAtICAgICAgIGlmIChlcnIpIHsNCj4gLSAgICAgICAgICAgICAg
IGRldl9kYmcobm9yLT5kZXYsICJGYWlsZWQgdG8gdW5sb2NrIHRoZSBlbnRpcmUgZmxhc2ggbWVt
b3J5IGFycmF5XG4iKTsNCj4gLSAgICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+IC0gICAgICAg
fQ0KPiArICAgICAgIHNwaV9ub3JfdHJ5X3VubG9ja19hbGwobm9yKTsNCj4gDQo+ICAgICAgICAg
aWYgKG5vci0+YWRkcl93aWR0aCA9PSA0ICYmDQo+ICAgICAgICAgICAgIG5vci0+cmVhZF9wcm90
byAhPSBTTk9SX1BST1RPXzhfOF84X0RUUiAmJg0KPiAtLQ0KPiAyLjIwLjENCj4gDQoNCg==
