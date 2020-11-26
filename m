Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA89F2C542D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbgKZMpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:45:47 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:18007 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389407AbgKZMpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606394745; x=1637930745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TugqgWrdBxHjtjKlpuLaP7PxpYYySDgV9rIdDjY9s14=;
  b=iMmiVBwIsbb7xGbDX286xzUoaMxC16/ht0sStc61EcEjtVy7o0Z1p75g
   3SHyrHJnHAYnedSBel09bJX9ViyMqwi4Db9rDfZxCaBuwYHhSWM8rX1yV
   8X3uH8d+l2q1kKH0IA7Qve50LtIcHccmwZUTwSWw7A7K24PdZTryF+uRC
   Yg4uMGA61rCoVdusEFyhKJXde1UHeKrnPM5VqGGTwmuRKWzdewQsMAPNb
   sa/y/A9wCxZKZPr4PFNHzrblt6bu5PoHisyPbBYLkE+x7IBupzsjYZGvt
   ry7NKlOrdP9gU8YsTx+S/tCnHvxI+BzQYoWk7qvZSKHQsALon5QosVA8j
   Q==;
IronPort-SDR: p0os5kXtcaVWNQhJ9H8wbo8552g/RJJIL/7QrRX259byxH1859sCb2VtQJ5aM9B6dO7i3qANBo
 zlqUv755cd4HYTX2pFHjwF6pK5VApRhibjflDhz8oHk566avlcAv4DL1Wfc7nWtdIZGibszDWQ
 uqrP8MrpVm3gr4dsgHwroJmm3byjpUfxEu6u5CAuS9xxJiA+AJiOc82nDTpY0ejmm5mw9yy3Tl
 XJgpzrRh8rQWN1O9VZVlHj5BxHEP+j2F1+Jeq43atUVEbT1lpwZ4pZSxpfhur43m1kU6CxUmUZ
 oKE=
X-IronPort-AV: E=Sophos;i="5.78,372,1599548400"; 
   d="scan'208";a="94962733"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Nov 2020 05:45:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 26 Nov 2020 05:45:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 26 Nov 2020 05:45:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Isc3223G+FIaMuZ22NG/KZsIuK3ckQgPvZ+dnywtimDMNNJKmqoqOWY/ydMdAYSSPn1/Y1TzgUAUig0y5tkyQL9QWhP3vd7KFxHEEg8u4dYkN3cwpZ5JvFRD0tHrqf8AttrrI/GWExX4e2le+WQqDo+h2X+tKtKpasQgmItCVt2mztkWBThVOaYG/pkeoZswqtdcgPx6NcZpIefi/iB3v6rKEW7t7shPvzZHivxm8RUb0D+I5Ovdqudr1i5N+GKfwpjyCKCgbdO8q4S4fyHKSaIHGNX+PdEz6Kem01tKnVT3ydD/KwzekDpdPQ6eEUmpNgfZpJxtUaS9TfzJi1aifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TugqgWrdBxHjtjKlpuLaP7PxpYYySDgV9rIdDjY9s14=;
 b=ofaxEifZO2BnZ3Vf5rcJQY22OVZr5hSdjpYUX/PoZbs5Qqqf4p/h+1N3CaBMhMiTKm7+0dMhytFrdSS9kwJH5cf/mUHndTqnpWNsnGIhdRv1rNGvc76FdE0ywv0+bO4r5aCwl1w+97V6VmDj/cRFz6WYrFQIQWoPgU05YNAp4sA4uFIbN6h5B8xmiemlLsyQ/l4qmKTbX+u1TStmawA7GVcitVh0Pk/nyGyG9kv9PzZDvk3F288e7rO7B4iqRQ6a7mSnRp9ahPKj+GejJ9O9bZDVUB4ib7fgPEbRKie4deWUjRUyOkF1i0hZ/Q6tsX3Ldbu89kIqws+JVPe5kgoG0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TugqgWrdBxHjtjKlpuLaP7PxpYYySDgV9rIdDjY9s14=;
 b=GJeHr13zqiMkfu+y0fpEnPStHfOjfIo6PwdMYnfkQZA9jXakRO7DTIDyKdZ60iSCHO+qmLwiKS0Cp/vR3nNbEJtxpnCyNJ6BVEAlYuQ6dRIoH+8jcK0Na8y9XM3/1MRscEUHuxQNhm+Rpbv/W/pMWTkp8+HxECG7QL5yLM5uFLs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2574.namprd11.prod.outlook.com (2603:10b6:805:59::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Thu, 26 Nov
 2020 12:45:41 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3611.021; Thu, 26 Nov 2020
 12:45:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection flag
Thread-Topic: [PATCH v5 1/3] mtd: spi-nor: atmel: remove global protection
 flag
Thread-Index: AQHWwpVIheOE53CDUkK+sIaiGLI1Ug==
Date:   Thu, 26 Nov 2020 12:45:41 +0000
Message-ID: <a8e086ac-a5f8-f422-82e1-758c7da794b4@microchip.com>
References: <20201003153235.29762-1-michael@walle.cc>
 <20201003153235.29762-2-michael@walle.cc>
 <7b5159c1-5457-b43c-2bf2-1a17ed6df34a@microchip.com>
 <f9724ff71809557283beb7c8c4d4b356@walle.cc>
In-Reply-To: <f9724ff71809557283beb7c8c4d4b356@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.172]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69402589-d845-46bd-d335-08d892092ef8
x-ms-traffictypediagnostic: SN6PR11MB2574:
x-microsoft-antispam-prvs: <SN6PR11MB25740E6821C1291DB2C14D5FF0F90@SN6PR11MB2574.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szucTKXu+1V+wgwU7lGeYFX0j/6+FPQtUoXlaMEEswJTwtl7D9qBQHnGexdcgSUhfNUdhHJradtq5Wz8qE3U2XUcdfthTUU6VWCOK+wAKr+8TqHnIln9gFBoWVewSeE1DlN1/PKYOX6LVt6AmVXi+JWQMDPwIlarnpZZu95DNHrbckPwZeD/jE+gsNkM6cpipA6/mJ7YJa7+CcBIiEZHG2FFEsXAIZ/i2P4Ih0479IKGQkJhDqOuKD30J+rrrFRkk5brmexxLG+ZJXyWCppXgZ6tOucHEzeaUYwMaKKTCKlpw/xpqnia8R8kBM7ZnEb/m50xn2LVcmFoiMuu9p1Esi87TPY0XOieC0ssrvVTVZUzFwPwPvjCyajR2v4ogu7X3MLfMc7bkGJhTw24uHsXgxVdNwhT7Pv9Lk0INPev38FPMKfOu16nmBZo9U3lC7H6PPZHJ6pUkR5eugKBOcymcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(366004)(346002)(396003)(136003)(66476007)(8936002)(83380400001)(76116006)(66556008)(2616005)(2906002)(66446008)(66946007)(6486002)(71200400001)(31686004)(64756008)(53546011)(4326008)(86362001)(31696002)(186003)(316002)(36756003)(26005)(54906003)(4001150100001)(966005)(6916009)(478600001)(6512007)(8676002)(5660300002)(6506007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VCs4V0k3SWxOc1lCcFk2VW1sc3JaZERiU1N4NnRjaktHZHpjMk1NRWU4UEVV?=
 =?utf-8?B?MDJlVHlVenhFMm5DYUQzYk13dHlaZ1cwcXJ4dGh4c2FTOXZRR1RQR0RGWFhs?=
 =?utf-8?B?MjFaamljQUxVN2crczhLMWRFZ05vOG5oT21CQUF2ZnRyZVB0Vk50WEZIZUF6?=
 =?utf-8?B?ZEtRWjA1Qi9TdnllSGJjb3ZNbGVobVlXRnRXdWxaOE0zV0xBWWNsUFpiUnlr?=
 =?utf-8?B?bUJtR29zcVNhdzQxR3BGdmtUSUcwTEFGL001Yjl2ZkdYQnpNMnhqUTN2NDRN?=
 =?utf-8?B?S0NPd0hMV09RNi81WTBEbWZlZDI2NzNlUlFUemdmT042WUV2MlFabUtDUE5F?=
 =?utf-8?B?OU1OK25ZTzJJN1owTVc3SlNXUDljSGkwMStnSFZKRHI5NWcrMHdBZDFRNUh4?=
 =?utf-8?B?UjhKNW43c1BldUVmZ2tTZDBmNFZhZzlWanB2VnFrN3VZYTEyZW0zbGdtOWVp?=
 =?utf-8?B?N2FQL1ZHdzk5Tkw2TmVyVEVkbDZiYUx0aDlpSkE2NmE4eE9ZZFNJQktURlhF?=
 =?utf-8?B?MTFpdGoyWHpqS2dDVXB4aU9pbTV5TGE3YjFoUGhOMDV2NklyT256S2RwcEZt?=
 =?utf-8?B?TThUZkd6R2xOQ1FmKzJ1UUgxOGh2N25iaXVQREhSbjd6Slhtc1NnOWU3WmJw?=
 =?utf-8?B?M3N2cEZJdUVyWDlaTEI4RmVHT0RxL0oyd0tmRlVKRGlCc25aNlZwZFdSODVV?=
 =?utf-8?B?bGVNelFDeE9tZWRDMGppeTgrRm01NWNncm84byt4dXUxRXpVZWdEYmFsMlRr?=
 =?utf-8?B?MG5QRnlSTXVQNVNEZnh6Y0VMQnBMZWxHeUtReFd2TlNLUVo0WDZFQTFNbHYz?=
 =?utf-8?B?ZTVGWFF5RlBhMlpnNExOWFZ0eVRlcTBkSE5DZzZud2xsWlJSaGVJV2ZaVjNE?=
 =?utf-8?B?L2FEUzU1eExqczBYOGU1cUU5UWMvU093dDErOWwvU2dlSjA3VUFmS09tT0NP?=
 =?utf-8?B?WnVsa0dxcFVoM01vdHp1NVdUbjZESEdQLzBCMGcyS2FnMUdMdDYrS3hPSG9I?=
 =?utf-8?B?NzZLOUNuU1Axd2JQUHRGemc3TXZVLzV2dkZ0Sk45VWhuU1o0NklZMG10SGV1?=
 =?utf-8?B?QXFjb1RDZmgwTGN0UzdzemsvTVRqUE01SlNEVnpJL1Irc2JCSlM0aFdZUnZV?=
 =?utf-8?B?M3J3RDlnLzQyY0JTd3hMMTZ4VnZHUkhRY21Ea3dHcnNTekVKcEFEUkNyNm0r?=
 =?utf-8?B?MVc0WWYwbmRzM1ovT0MrNHJrUTRvWktuRklDaVJLU3IxWlFRcHE1N3c4WXF0?=
 =?utf-8?B?ZVZXK0ZQNCtmZXcvcUQrVk16NXhSN0tBR3RXdms5NlpXaXNwTmswTFVKT1lF?=
 =?utf-8?Q?gUHVIXO0PdDpU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DFCB0A3F310FA4E8AEE42F97787B232@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69402589-d845-46bd-d335-08d892092ef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 12:45:41.2787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OhADRt4t83i6x22IibR/XaUKku5Pho8sBnBfFrgSQCztuj1VP4jNgKeGGR6yMJhsVkSSpuogcc03at17aso5BKScwtaLSL7f5UcXRUDM7kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2574
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMjUvMjAgODoxNyBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIwLTExLTI0IDIwOjA5LCBzY2hyaWVi
IFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDEwLzMvMjAgNjozMiBQTSwgTWlj
aGFlbCBXYWxsZSB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93DQo+Pj4gdGhlIGNvbnRlbnQgaXMg
c2FmZQ0KPj4+DQo+Pj4gVGhpcyBpcyBjb25zaWRlcmVkIGJhZCBmb3IgdGhlIGZvbGxvd2luZyBy
ZWFzb25zOg0KPj4+IMKgKDEpIFdlIG9ubHkgc3VwcG9ydCB0aGUgYmxvY2sgcHJvdGVjdGlvbiB3
aXRoIEJQbiBiaXRzIGZvciB3cml0ZQ0KPj4+IMKgwqDCoMKgIHByb3RlY3Rpb24uIE5vdCBhbGwg
QXRtZWwgcGFydHMgc3VwcG9ydCB0aGlzLg0KPj4+IMKgKDIpIE5ld2x5IGFkZGVkIGZsYXNoIGNo
aXAgd2lsbCBhdXRvbWF0aWNhbGx5IGluaGVyaXQgdGhlICJoYXMNCj4+PiDCoMKgwqDCoCBsb2Nr
aW5nIiBzdXBwb3J0IGFuZCB0aHVzIG5lZWRzIHRvIGV4cGxpY2l0bHkgdGVzdGVkLiBCZXR0ZXIN
Cj4+PiDCoMKgwqDCoCBiZSBvcHQtaW4gaW5zdGVhZCBvZiBvcHQtb3V0Lg0KPj4+IMKgKDMpIFRo
ZXJlIGFyZSBhbHJlYWR5IHN1cHBvcnRlZCBmbGFzaGVzIHdoaWNoIGRvZXNuJ3Qgc3VwcG9ydA0K
Pj4+IMKgwqDCoMKgIHRoZSBsb2NraW5nIHNjaGVtZS4gU28gSSBhc3N1bWUgdGhpcyB3YXNuJ3Qg
cHJvcGVybHkgdGVzdGVkDQo+Pj4gwqDCoMKgwqAgYmVmb3JlIGFkZGluZyB0aGF0IGNoaXA7IHdo
aWNoIGVuZm9yY2VzIG15IHByZXZpb3VzIGFyZ3VtZW50DQo+Pj4gwqDCoMKgwqAgdGhhdCBsb2Nr
aW5nIHN1cHBvcnQgc2hvdWxkIGJlIGFuIG9wdC1pbi4NCj4+Pg0KPj4+IFJlbW92ZSB0aGUgZ2xv
YmFsIGZsYWcgYW5kIGFkZCBpbmRpdmlkdWFsIGZsYWdzIHRvIGFsbCBmbGFzaGVzIHdoaWNoDQo+
Pj4gc3VwcG9ydHMgQlAgbG9ja2luZy4gSW4gcGFydGljdWxhciB0aGUgZm9sbG93aW5nIGZsYXNo
ZXMgZG9uJ3Qgc3VwcG9ydA0KPj4+IHRoZSBCUCBzY2hlbWU6DQo+Pj4gwqAtIEFUMjZGMDA0DQo+
Pj4gwqAtIEFUMjVTTDMyMQ0KPj4+IMKgLSBBVDQ1REIwODFEDQo+Pj4NCj4+PiBQbGVhc2Ugbm90
ZSwgdGhhdCBzb21lIGZsYXNoZXMgd2hpY2ggYXJlIG1hcmtlZCBhcyBTUElfTk9SX0hBU19MT0NL
DQo+Pj4ganVzdA0KPj4+IHN1cHBvcnQgR2xvYmFsIFByb3RlY3Rpb24sIGkuZS4gbm90IG91ciBz
dXBwb3J0ZWQgYmxvY2sgcHJvdGVjdGlvbg0KPj4+IGxvY2tpbmcgc2NoZW1lLiBUaGlzIGlzIHRv
IGtlZXAgYmFja3dhcmRzIGNvbXBhdGliaWxpdHkgd2l0aCB0aGUNCj4+PiBjdXJyZW50ICJ1bmxv
Y2sgYWxsIGF0IGJvb3QiIG1lY2hhbmlzbS4gSW4gcGFydGljdWxhciB0aGUgZm9sbG93aW5nDQo+
Pj4gZmxhc2hlcyBkb2Vzbid0IGhhdmUgQlAgYml0czoNCj4+PiDCoC0gQVQyNURGMDQxQQ0KPj4+
IMKgLSBBVDI1REYzMjENCj4+PiDCoC0gQVQyNURGMzIxQQ0KPj4+IMKgLSBBVDI1REY2NDENCj4+
PiDCoC0gQVQyNkRGMDgxQQ0KPj4+IMKgLSBBVDI2REYxNjFBDQo+Pj4gwqAtIEFUMjZERjMyMQ0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4N
Cj4+DQo+PiBSZXZpZXdlZC1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2No
aXAuY29tPg0KPj4NCj4+PiAtLS0NCj4+PiBjaGFuZ2VzIHNpbmNlIHY0Og0KPj4+IMKgLSBub25l
DQo+Pj4NCj4+PiBjaGFuZ2VzIHNpbmNlIHYzL3YyL3YxOg0KPj4+IMKgLSB0aGVyZSB3YXMgbm8g
c3VjaCB2ZXJzaW9uIGJlY2F1c2UgdGhpcyBwYXRjaCB3YXMgYnVuZGxlZCB3aXRoDQo+Pj4gYW5v
dGhlcg0KPj4+IMKgwqAgcGF0Y2gNCj4+Pg0KPj4+IGNoYW5nZXMgc2luY2UgUkZDOg0KPj4+IMKg
LSBtZW50aW9uIHRoZSBmbGFzaGVzIHdoaWNoIGp1c3Qgc3VwcG9ydCB0aGUgIkdsb2JhbCBVbnBy
b3RlY3QiIGluDQo+Pj4gdGhlDQo+Pj4gwqDCoCBjb21taXQgbWVzc2FnZQ0KPj4+DQo+Pj4gwqBk
cml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgfCAyOCArKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tDQo+Pj4gwqAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMo
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgYi9k
cml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+PiBpbmRleCAzZjVmMjFhNDczYTYuLjQ5ZDM5
MmM2YzhiYyAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+
PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+PiBAQCAtMTAsMzcgKzEwLDI3
IEBADQo+Pj4NCj4+PiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBhdG1lbF9wYXJ0
c1tdID0gew0KPj4+IMKgwqDCoMKgwqDCoMKgIC8qIEF0bWVsIC0tIHNvbWUgYXJlIChjb25mdXNp
bmdseSkgbWFya2V0ZWQgYXMgIkRhdGFGbGFzaCIgKi8NCj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0
MjVmczAxMCIswqAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LMKgwqAgNCwgU0VDVF80Sykg
fSwNCj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVmczA0MCIswqAgSU5GTygweDFmNjYwNCwgMCwg
NjQgKiAxMDI0LMKgwqAgOCwgU0VDVF80SykgfSwNCj4+PiArwqDCoMKgwqDCoMKgIHsgImF0MjVm
czAxMCIswqAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LMKgwqAgNCwgU0VDVF80SyB8DQo+
Pj4gU1BJX05PUl9IQVNfTE9DSykgfSwNCj4+DQo+PiBodHRwczovL2RhdGFzaGVldHNwZGYuY29t
L3BkZi1maWxlLzU4NzE2NC9BVE1FTENvcnBvcmF0aW9uL0FUMjVGUzAxMC8xDQo+PiBCUCBiaXRz
IGFyZSBhdCBiaXQgMiwgMywgNSBhbmQgNi4NCj4+IEJQMCwgQlAxLCBCUDMsIEJQNCBhbmQgV1BF
TiwgYXJlIG5vbnZvbGF0aWxlIGNlbGxzDQo+Pg0KPj4+ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWZz
MDQwIizCoCBJTkZPKDB4MWY2NjA0LCAwLCA2NCAqIDEwMjQswqDCoCA4LCBTRUNUXzRLIHwNCj4+
PiBTUElfTk9SX0hBU19MT0NLKSB9LA0KPj4NCj4+IGh0dHBzOi8vZGF0YXNoZWV0c3BkZi5jb20v
cGRmLWZpbGUvNTg3MTY1L0FUTUVMQ29ycG9yYXRpb24vQVQyNUZTMDQwLzENCj4+IEJQIGJpdHMg
YXJlIGF0IGJpdCAyLCAzLCA0LCA1LCBhbmQgNi4NCj4+IEJQMCwgQlAxLCBCUDIsIEJQMywgQlA0
IGFyZSBub252b2xhdGlsZSBjZWxscw0KPj4NCj4+Pg0KPj4+IC3CoMKgwqDCoMKgwqAgeyAiYXQy
NWRmMDQxYSIsIElORk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCzCoMKgIDgsIFNFQ1RfNEspIH0s
DQo+Pj4gLcKgwqDCoMKgwqDCoCB7ICJhdDI1ZGYzMjEiLMKgIElORk8oMHgxZjQ3MDAsIDAsIDY0
ICogMTAyNCzCoCA2NCwgU0VDVF80SykgfSwNCj4+PiAtwqDCoMKgwqDCoMKgIHsgImF0MjVkZjMy
MWEiLCBJTkZPKDB4MWY0NzAxLCAwLCA2NCAqIDEwMjQswqAgNjQsIFNFQ1RfNEspIH0sDQo+Pj4g
LcKgwqDCoMKgwqDCoCB7ICJhdDI1ZGY2NDEiLMKgIElORk8oMHgxZjQ4MDAsIDAsIDY0ICogMTAy
NCwgMTI4LCBTRUNUXzRLKSB9LA0KPj4+ICvCoMKgwqDCoMKgwqAgeyAiYXQyNWRmMDQxYSIsIElO
Rk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCzCoMKgIDgsIFNFQ1RfNEsgfA0KPj4+IFNQSV9OT1Jf
SEFTX0xPQ0spIH0sDQo+Pg0KPj4gaHR0cHM6Ly9kYXRhc2hlZXRzcGRmLmNvbS9wZGYtZmlsZS85
NzUzMzEvQWRlc3RvL0FUMjVERjA0MUEvMQ0KPj4gR2xvYmFsIFByb3RlY3QvVW5wcm90ZWN0IHVz
aW5nIFdyaXRlIFNSIGNvbW1hbmQ6DQo+PiBHbG9iYWwgVW5sb2NrOiB3cml0ZSAweDAwIHRvIFNS
DQo+PiBHbG9iYWwgTG9jazogUmVhZCBTUi4gSWYgU1IuU1BSTCBpcyAxIHdyaXRlIDB4ZmYgdG8g
U1IsIGVsc2Ugd3JpdGUNCj4+IDB4N2YuDQo+IA0KPiBUaGF0IGlzIG5vdCBteSB1bmRlcnN0YW5k
aW5nLiBRdW90ZToNCj4gwqAgVG8gcGVyZm9ybSBhIEdsb2JhbCBQcm90ZWN0LCB0aGUgYXBwcm9w
cmlhdGUgV1AgcGluIGFuZCBTUFJMDQo+IMKgIGNvbmRpdGlvbnMgbXVzdCBiZSBtZXQsIGFuZCB0
aGUgc3lzdGVtIG11c3Qgd3JpdGUgYSBsb2dpY2FsIOKAnDHigJ0NCj4gwqAgdG8gYml0cyA1LCA0
LCAzLCBhbmQgMiBvZiB0aGUgU3RhdHVzIFJlZ2lzdGVyLg0KPiANCj4gQW5kDQo+IMKgIENvbnZl
cnNlbHksIHRvIHBlci1mb3JtIGEgR2xvYmFsIFVucHJvdGVjdCwgdGhlIHNhbWUgV1AgYW5kIFNQ
UkwNCj4gwqAgY29uZGl0aW9ucyBtdXN0IGJlIG1ldCBidXQgdGhlIHN5c3RlbSBtdXN0IHdyaXRl
IGEgbG9naWNhbCDigJww4oCdIHRvDQo+IMKgIGJpdHMgNSwgNCwgMywgYW5kIDIgb2YgdGhlIFN0
YXR1cyBSZWdpc3Rlcg0KPiANCg0KUmlnaHQuIEkgdGhpbmsgd2UgYXJlIGJvdGggY29ycmVjdCwg
YW5kIHdlIHNob3VsZCBjaG9vc2Ugb25lIG1ldGhvZA0Kb3IgdGhlIG90aGVyIGRlcGVuZGluZyBv
biB0aGUgbGV2ZWwgb2Ygc3VwcG9ydCB3ZSB3YW50IHRvIGludHJvZHVjZS4NCklmIHdlIHdhbnQg
ImxvY2tpbmcgb3BzIiwgaS5lLiBwYXJ0aWFsIG9yIGZ1bGwgbG9jayBhbmQgdW5sb2NrIG9mIHRo
ZQ0KZmxhc2gsIHdlJ2xsIGdvIHlvdXIgd2F5LiBJZiB3ZSB3YW50IHRvIGtlZXAgdGhpbmdzIGFz
IHRoZXkgd2VyZSBiZWZvcmUNCjNlMDkzMGYxMDllNzYsIHdlJ2xsIGp1c3Qgc3VwcG9ydCB0aGUg
Z2xvYmFsIHVubG9jayBieSB3cml0aW5nIDB4MDAgdG8gU1IuDQoNCkhlcmUncyB3aGF0IEkgZm9s
bG93ZWQgaW4gdGhlIGRhdGFzaGVldDoNCicnJw0KRXNzZW50aWFsbHksIGlmIHRoZSBTUFJMIGJp
dCBvZiB0aGUgU3RhdHVzIFJlZ2lzdGVyIGlzIGluIHRoZSBsb2dpY2FsIOKAnDDigJ0NCnN0YXRl
IChTZWN0b3IgUHJvdGVjdGlvbiBSZWdpc3RlcnMgYXJlIG5vdCBsb2NrZWQpLCB0aGVuIHdyaXRp
bmcgYSAwMGgNCnRvIHRoZSBTdGF0dXMgUmVnaXN0ZXIgd2lsbCBwZXJmb3JtIGEgR2xvYmFsIFVu
cHJvdGVjdCB3aXRob3V0IGNoYW5naW5nDQp0aGUgc3RhdGUgb2YgdGhlIFNQUkwgYml0LiBTaW1p
bGFybHksIHdyaXRpbmcgYSA3RmggdG8gdGhlIFN0YXR1cyBSZWdpc3Rlcg0Kd2lsbCBwZXJmb3Jt
IGEgR2xvYmFsIFByb3RlY3QgYW5kIGtlZXAgdGhlIFNQUkwgYml0IGluIHRoZSBsb2dpY2FsIOKA
nDDigJ0gc3RhdGUuDQpUaGUgU1BSTCBiaXQgY2FuLCBvZiBjb3Vyc2UsIGJlIGNoYW5nZWQgdG8g
YSBsb2dpY2FsIOKAnDHigJ0gYnkgd3JpdGluZyBhbiBGRmgNCmlmIHNvZnR3YXJlLWxvY2tpbmcg
b3IgaGFyZHdhcmUtbG9ja2luZyBpcyBkZXNpcmVkIGFsb25nIHdpdGggdGhlIEdsb2JhbCBQcm90
ZWN0Lg0KJycnDQoNCkFsc286DQonJycNCklmIHRoZSBkZXNpcmUgaXMgdG8gb25seSBjaGFuZ2Ug
dGhlIFNQUkwgYml0IHdpdGhvdXQgcGVyZm9ybWluZyBhIEdsb2JhbCBQcm90ZWN0DQpvciBHbG9i
YWwgVW5wcm90ZWN0LCB0aGVuIHRoZSBzeXN0ZW0gY2FuIHNpbXBseSB3cml0ZSBhIDBGaCB0byB0
aGUgU3RhdHVzIFJlZ2lzdGVyDQp0byBjaGFuZ2UgdGhlIFNQUkwgYml0IGZyb20gYSBsb2dpY2Fs
IOKAnDHigJ0gdG8gYSBsb2dpY2FsIOKAnDDigJ0gcHJvdmlkZWQgdGhlIFdQIHBpbiBpcw0KZGVh
c3NlcnRlZC4NCicnJw0KDQo+IEtlZXAgaW4gbWluZCB0aGF0IGJpdCA1LCA0LCAzIGFuZCAyIGlz
IGV4YWN0bHkgdGhlDQo+IEFUTUVMX1NSX0dMT0JBTF9QUk9URUNUX01BU0suIFRoZSBTUFJMIGJp
dCBpcyBoYW5kbGVkIGluIHRoZSB1bmxvY2soKQ0KPiBmdW5jdGlvbi4gQWNjb3JpbmcgdG8gdGFi
bGUgOS4yIHlvdSBhbHNvIGhhdmUgdG8gZmlyc3QgZGlzYWJsZSB0aGUgU1BSTA0KPiBiaXQgYW5k
IHRoZW4gd3JpdGUgdGhlIEJQIGJpdHMgdG8gemVyby4NCg0KSWYgU1BSTCBpcyAxIGFuZCB3ZSB3
YW50IHRvIHVubG9jayB0aGUgZW50aXJlIGZsYXNoLCB3cml0aW5nIDB4MDAgdG8gU1Igd291bGQg
bm90DQpzdWZmaWNlLiBXZSBtdXN0IHNldCBTUFJMIHRvIHplcm8gZmlyc3QsIGkuZS4gd3JpdGUg
MHgwZiB0byBTUiBhbmQgdGhlbiB3cml0ZSAweDAwDQpvciBzZXQgdGhlIEJQIGJpdHMgdG8gMCBp
biBvcmRlciB0byB1bmxvY2sgYWxsLiBMb29rcyBsaWtlIHNwaV9ub3Jfc3JfdW5sb2NrKCkNCmRv
ZXMgbm90IHRyZWF0IFNSX1NSV0QgYXMgaXQgc2hvdWxkLg0KDQpMZXQgbWUga25vdyB3aGF0IG1l
dGhvZCB5b3UgY2hvb3NlLCBJJ2xsIGhhdmUgdG8gZ28gYWdhaW4gdGhyb3VnaCB0aGUgZGF0YXNo
ZWV0cy4NClRoaXMgdGltZSBzaG91bGQgYmUgZWFzaWVyLg0KDQo+IA0KPiAtbWljaGFlbA0KDQpU
aGFua3MgZm9yIHRoZSBlZmZvcnQgYW5kIHBhdGllbmNlLg0KdGENCg==
