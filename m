Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF362CBA9C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgLBKdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:33:17 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:21023 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgLBKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606905194; x=1638441194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=phU+/phwC69i+bAcjioeX0SMwbs5IeMp4f2RLHPgouA=;
  b=AFxwC723nGYJzPYJhnnNBy/ydmJYTstrL/Adhm+7UcmXfJeep0+R9jSt
   GZUzA0VBQvkp2W30Di2vXu/6FnVjJTUNCVnuwS/Nn6tBdGK7BvXD2cw5f
   K7HZ2keuoly1Ug3ViukRf1VCWdPpTc1JQaLMCmw/5R21/J+qksCbtiksQ
   SnvP5sSdeihO4gLeepONqZIJvIiV3yMIwqzSzh810wxWWBCYp9PxSN7N2
   TMe2+mYNELTIQLLi65hoSXe5p/Lfo+471WC3CR/A16QRW0WNu70ASvqYm
   7z6SyxqohX3hVO82fEFsbIdhEjKvBBaPYMndYogPnMGi/6XJ5MwhrXhh+
   A==;
IronPort-SDR: VQ74nePTBLCyYDE6+c4zmUTgIngnLS3jfn6Dp7cqrAv4AkWtGEAGnGPs6omFnZQp7Nhjj35z3k
 WmuKiQJX7kbYcJN7FbWWITV8p1/V0Y2IV3x2wuBo+Hd55xQ9Mdouz++MttpWL/2LoNj14HGAfj
 BS0isxJbuSQjRa38dbqJeytyAiDcf40n3mWcVU/fPOXt4FLMT6k3RrFKtch/fNOh9Dp9P3mCs8
 dZE5NSf+WKtuZQPFLcR1Gqc2QrXEL2oesvuGP6I6TfnscOysA8QJiSmIHp+zlaxfe3xqdWQTEW
 R6U=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="100570844"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 03:32:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 03:32:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 2 Dec 2020 03:32:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPH9HaC8Z0nx3JwECU0aOwtuiXebVyVSHqIHf8qbBvE1Kl/7aCNHwossyBLEXbwYsOA1z0C7+doYmrzIrBKtyhrdDwGZw3gado2HnfQnAcQxjdiwJRn+ilGdB1C/vP+ZXQZ8WiWZ+YXanuY+bCZOi0/KzruOukyZDqpI2v53Twj9ukQe6TS+42MY0yJt7OYg4LU1UEBvgQ2PBsHoS6vn3MA7CyEmo6tBGsMfoIuRQOaFWKIF7Qmy6dlJWd00DXBV9N0gB8KF09RHhuSXYaqchLkduW36y3IhF/0H9I6Cpj8oJ8dGDXnzHRAiXBXQ2ItyM+P0UTXLycwWexRTHaO3fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phU+/phwC69i+bAcjioeX0SMwbs5IeMp4f2RLHPgouA=;
 b=Cq/ngzIghP/WOln7taS+1cxfrxDFavpkuOAyN8V/sTFmcMODNG/v05H2n7NRRLylmiqH2t+0yKwYfGuLiyqiGuqfqsitS86gABPl+UcQoTdWV5ZdEGKn1z73IZTrFLvnJNAhGaI4D8hMDOAlVLrciHuIkVXPui7N/54aRervZ4jWKeCrx9ii9lR4o9CsO0CBUmhszqh7ZezHwM0glePlDNYyWcOAgjE5F3qc/9Oj8FKL4N5VKx5NhLXgsogGNXuIZzrebF4D7xLTIEjiYjhaUOjOFvkyJMrFIE+yo14Lhy3QYWc3cGVkiLtQhO5rLJWoTRipScuY184ATz08jwW1mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phU+/phwC69i+bAcjioeX0SMwbs5IeMp4f2RLHPgouA=;
 b=X4wYzfPkrI1GJ5l/VeJ7M3Dpx8ZtHTyIxSbThrcJ54375m1Brt6T8ZC+w+/Gwi6ru05+KwyyZQ/KL1Xfdy0Wbjg+xOgJ+q6CzG9yEcq/oF0fBFTEyn4hQaNoJ4BSPpfBFDYosbDBf3tc9usSEjGVfAbwFPxxVdTf9x8A5/Wa1+I=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2831.namprd11.prod.outlook.com (2603:10b6:805:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 10:32:04 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6903:3212:cc9e:761%7]) with mapi id 15.20.3632.017; Wed, 2 Dec 2020
 10:32:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
Subject: Re: [PATCH v6 4/5] mtd: spi-nor: atmel: Fix unlock_all() for
 AT25FS010/040
Thread-Topic: [PATCH v6 4/5] mtd: spi-nor: atmel: Fix unlock_all() for
 AT25FS010/040
Thread-Index: AQHWxV/7Y2BwcnWnOEKyWKfbGcieMg==
Date:   Wed, 2 Dec 2020 10:32:04 +0000
Message-ID: <33b3dd7d-3aa0-2cf2-6f0c-1afaa4dff61d@microchip.com>
References: <20201126202614.5710-1-michael@walle.cc>
 <20201126202614.5710-5-michael@walle.cc>
 <ba9850c1-a684-6376-7331-2e09567dcb73@microchip.com>
 <a8ce7d3a61d6f7bd988917291e938954@walle.cc>
In-Reply-To: <a8ce7d3a61d6f7bd988917291e938954@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 507f0404-e0b6-4888-231a-08d896ad82e1
x-ms-traffictypediagnostic: SN6PR11MB2831:
x-microsoft-antispam-prvs: <SN6PR11MB283153921D201155F345E2CAF0F30@SN6PR11MB2831.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kJO0zpBTZhkWxoZtKCg7luSqb/pBsTKC9TMr/YPIWN5AcY6a4wmJLbTJ7Ty/5yp6Fmpo6g9nLs5qosrrUUcrvVxvb7XHu/jfcdlkWXh88XtttBpp/AfG5xVyptM3QNArxaeqY3/7TyHJekQlN38Ghc14F3eVAA8gzSFNLP6/Tbevp+eqGHMAiTl0NnKsrySCSCi23sIO9FESoK/44k3AH3YLGTAClIJLa+iRwL5r1TKkhNoCUd8eV6wLcOIY+ZDGB0elPxcF4LFEHgaPf6BZ/nZ0kIGtkBdpHoMAfI40V5UojvquHjR6wepXpROKRk+27V7eGQOWqDRT8Kkp5qOq5enHe1KBFYGDjujcuTJZ2XE0ykSj2XRItqV8gKPGCOvCtFrZfJdpcfof1/eUJLvIlCIQYRWqH7lqJYLbroKpsJI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(4001150100001)(86362001)(6506007)(6916009)(8676002)(66556008)(66946007)(5660300002)(2616005)(83380400001)(76116006)(66476007)(31696002)(91956017)(66446008)(71200400001)(64756008)(31686004)(316002)(54906003)(2906002)(6512007)(53546011)(186003)(8936002)(36756003)(26005)(6486002)(478600001)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MTZGd3NsQWFZYUxUc0Y1b2hDUWFZY1VTL2MzR05lNkcraHJ0K2UvbVhuWWFW?=
 =?utf-8?B?SEVrZHBMa25vZjdyRkMrNUZoRVF3QXRVNlVjTHprSFhrM0ZYL3UyZGQ1dFAw?=
 =?utf-8?B?L2pYMFpLdUdNajdmZVJsN1daSCtzNTdZbDJJdzdBWHB2V3IyZXgyOVRDSmRT?=
 =?utf-8?B?Rk5JdEd0TTg2cXUzYVJSRW1SdTdHdjlWcEY3aVltRUtTUmJjdUFIeTZEWEFY?=
 =?utf-8?B?TEl1S3lleDJ1SG9XcjJzdDRiaDJydER1TTNFY3NvY3VISnJZWENWanlTcHQr?=
 =?utf-8?B?TEUyRnU0aWZQckR0LzRTS01RVGRnRkhZRlYyb1QwbjR6L1hiOC9NNWdKQ3No?=
 =?utf-8?B?Nnlwb1RNRFNGVnpYWTIvMUtRZnpuTHpjTjV5SFBqaHBnN0c4SHByL2kwYm5l?=
 =?utf-8?B?bDJmdHZ1d3BxWW5WbVJiTVJ4MitpNWFDSGRvSzl4WFVYckpkSDh6dHNweG84?=
 =?utf-8?B?N0cwZUlXMmNrNVdmU1A3YVI5YWFFZ1hTdXVwQXhDaVZLV3dWcmo5YnQ3MlhB?=
 =?utf-8?B?THNla2NHdGJDaUdlNis2MnM1dGl5dTRKaEFQNnkwV210SWQ2ZmNydFhyRTZW?=
 =?utf-8?B?WG1pNVpON2IxS1lIdHdIOFlQTU1ycEc3NiszOVR2eTNFeXJkMWwyWFNvUVlx?=
 =?utf-8?B?MS8vOGQ1TXEzSFVvdno1RExjeVY3N24vb09ndnBURFQ4STJHTmk5aCtaVFRY?=
 =?utf-8?B?WThydGdTWTdRTDBDT1RQNndNU2UwaVJhZmp5bWRnd29KbWcwdURKVUVVTjRz?=
 =?utf-8?B?Ukpsalh3bFlmdjZodVpUSmI5dXFiaCs5VGQrbkpUbWJ3Umt2RUFVRVR5YlQy?=
 =?utf-8?B?bEtFeFF5SmQ3SVJjR0U2eDZhNWNKQXRWb1ZGK3d2SG11Y1ZTNzRxWTVkSU9m?=
 =?utf-8?B?eERjY1VuSkhwMUdqNnlTcThFWG9wSVJuQ1UyM0M3NEtlZVdETTViRG1xNlYr?=
 =?utf-8?B?ZmoreXVPeDIzcHk2Vkp5eUFnWUJNUytQQVhuelVkQlZ6RTBCanZDQXJNWG9o?=
 =?utf-8?B?SmpGbFlOUWZzT1lWTXRjRUZ1bmFkRzRBd09INUNZa3pERXNwMFBVSC8zblcv?=
 =?utf-8?B?RUVrby9aa0ZiRGRaRlRmSE1wblhzSndESzU2cEFDOGpTbmtZY0lnVFB2MUtD?=
 =?utf-8?B?bUcyRkZqTHU4Ky9MQlZPVGpySEZnOFhRV25UaDhONk1ycVFRWlRqLy9WVnpp?=
 =?utf-8?B?NXU4QjcwdWJyM2JKWVBDd0ZHMjhHN0lSaU1DSERpRkI1RXpoczMzdDR5eHdl?=
 =?utf-8?B?bTBOMFNVY3laYkZlWVRTdzM2SCtMajVVVzk1QWltQ1pWUWVwaGZBZ01kdjRa?=
 =?utf-8?Q?qGLh2YOPU+wzY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A710CD02119814C95344F9B9D185CE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 507f0404-e0b6-4888-231a-08d896ad82e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 10:32:04.0762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xx//uDdI5I4GsXjqyMKOFPdZVRnoAMS/FoCCFTkWfvThW5OApW3mjugy/BK09Plk4MyUCkZPMqcJ2JUUG2kQYswn9cY6CLI9aZaXGHrCx64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2831
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMzAvMjAgNDoxNiBQTSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBbSAyMDIwLTExLTI4IDA5OjI1LCBzY2hyaWVi
IFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbToNCj4+IE9uIDExLzI2LzIwIDEwOjI2IFBNLCBN
aWNoYWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlu
a3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pj4NCj4+PiBUaGVzZSBmbGFzaGVzIGhhdmUgc29tZSB3ZWlyZCBCUCBiaXRzIG1h
cHBpbmcgd2hpY2ggYXJlbid0IHN1cHBvcnRlZA0KPj4+IGluDQo+Pj4gdGhlIGN1cnJlbnQgbG9j
a2luZyBjb2RlLiBKdXN0IGFkZCBhIHNpbXBsZSB1bmxvY2sgb3AgdG8gdW5wcm90ZWN0IHRoZQ0K
Pj4+IGVudGlyZSBmbGFzaCBhcnJheSB3aGljaCBpcyBuZWVkZWQgZm9yIGxlZ2FjeSBiZWhhdmlv
ci4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUu
Y2M+DQo+Pj4gLS0tDQo+Pj4gY2hhbmdlcyBzaW5jZSB2NQ0KPj4+IMKgLSBuZXcgcGF0Y2gNCj4+
Pg0KPj4+IMKgZHJpdmVycy9tdGQvc3BpLW5vci9hdG1lbC5jIHwgNTMNCj4+PiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL2Nv
cmUuY8KgIHzCoCAyICstDQo+Pj4gwqBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaMKgIHzCoCAx
ICsNCj4+PiDCoDMgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgYi9k
cml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+PiBpbmRleCA0OWQzOTJjNmM4YmMuLmZlNmE0
NjUzODIzZCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+
PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMNCj4+PiBAQCAtOCwxMCArOCw1OSBA
QA0KPj4+DQo+Pj4gwqAjaW5jbHVkZSAiY29yZS5oIg0KPj4+DQo+Pj4gKy8qDQo+Pj4gKyAqIFRo
ZSBBdG1lbCBBVDI1RlMwMTAvQVQyNUZTMDQwIHBhcnRzIGhhdmUgc29tZSB3ZWlyZCBjb25maWd1
cmF0aW9uDQo+Pj4gZm9yIHRoZQ0KPj4+ICsgKiBibG9jayBwcm90ZWN0aW9uIGJpdHMuIFdlIGRv
bid0IHN1cHBvcnQgdGhlbS4gQnV0IGxlZ2FjeSBiZWhhdmlvdXINCj4+PiBpbiBsaW51eA0KPj4+
ICsgKiBpcyB0byB1bmxvY2sgdGhlIHdob2xlIGZsYXNoIGFycmF5IG9uIHN0YXJ0dXAuIFRoZXJl
Zm9yZSwgd2UgaGF2ZQ0KPj4+IHRvIHN1cHBvcnQNCj4+PiArICogZXhhY3RseSB0aGlzIG9wZXJh
dGlvbi4NCj4+PiArICovDQo+Pj4gK3N0YXRpYyBpbnQgYXRtZWxfYXQyNWZzX2xvY2soc3RydWN0
IHNwaV9ub3IgKm5vciwgbG9mZl90IG9mcywNCj4+PiB1aW50NjRfdCBsZW4pDQo+Pj4gK3sNCj4+
PiArwqDCoMKgwqDCoMKgIHJldHVybiAtRU9QTk9UU1VQUDsNCj4+PiArfQ0KPj4+ICsNCj4+PiAr
c3RhdGljIGludCBhdG1lbF9hdDI1ZnNfdW5sb2NrKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZf
dCBvZnMsDQo+Pj4gdWludDY0X3QgbGVuKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoMKgwqDCoCAvKiBX
ZSBvbmx5IHN1cHBvcnQgdW5sb2NraW5nIHRoZSB3aG9sZSBmbGFzaCBhcnJheSAqLw0KPj4+ICvC
oMKgwqDCoMKgwqAgaWYgKG9mcyB8fCBsZW4gIT0gbm9yLT5wYXJhbXMtPnNpemUpDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4gKw0KPj4+ICvC
oMKgwqDCoMKgwqAgLyoNCj4+PiArwqDCoMKgwqDCoMKgwqAgKiBXcml0ZSAweDAwIHRvIHRoZSBz
dGF0dXMgcmVnaXN0ZXIgdG8gdHJ5IHRvIGRpc2FibGUgdGhlDQo+Pj4gd3JpdGUNCj4+PiArwqDC
oMKgwqDCoMKgwqAgKiBwcm90ZWN0aW9uLiBUaGlzIHdpbGwgZmFpbCBpZiBTUldEICh0aGUgZGF0
YXNoZWV0IGNhbGxzIGl0DQo+Pj4gV1BFTikgaXMNCj4+PiArwqDCoMKgwqDCoMKgwqAgKiBzZXQu
IEJ1dCB0aGVyZSBpcyBub3RoaW5nIHdlIGNhbiBkby4NCj4+PiArwqDCoMKgwqDCoMKgwqAgKi8N
Cj4+DQo+PiBjYW4ndCB3ZSBkbyB0aGUgc2FtZSBhcyB5b3UgZGlkIGluIDUvNT8NCj4gDQo+IFN1
cmUsIGJ1dCAtIGFzc3VtaW5nIGl0IGlzIG9ubHkgdXNlZCBmb3IgdGhlIGxlZ2FjeSB1bmxvY2sg
YWxsIG9wZXJhdGlvbg0KPiAtIHRoZQ0KPiBvdXRjb21lIHdpbGwgYmUgdGhlIHNhbWUuIEl0IHdp
bGwgZWl0aGVyIGtlZXAgYmVpbmcgbG9ja2VkIG9yIGFsbCB3aWxsDQo+IGJlDQo+IHVubG9ja2Vk
Lg0KDQpJbiBjYXNlIFdQIyBpcyBhc3NlcnRlZCwgd2UnbGwgY2F0Y2ggdGhpcyB2aWEgdGhlIGRl
dl9kYmcgbWVzc2FnZSBpbg0Kc3BpX25vcl93cml0ZV9zcl9hbmRfY2hlY2soKSB3aGVuIHRyeWlu
ZyB0byBjbGVhciB0aGUgU1JXRCBiaXQuIFdlIHdpbGwNCmhhdmUgYW4gaWRlYSBvZiB3aGF0J3Mg
Z29pbmcgb24sIGluc3RlYWQgb2YgYSBzaWxlbnQgZmFpbCB0byB1bmxvY2suDQoNCj4gDQo+IFRo
YXQgYmVpbmcgc2FpZCwgSSBjYW4gYWxzbyBjaGFuZ2UgaXQgdG8gdGhlIHNhbWUgYXMgdGhlDQo+
IGdsb2JhbF91bnByb3RlY3QoKS4NCj4gSSBkb24ndCBoYXZlIGFueSBvcHRpb24gb24gdGhhdCBv
dGhlciB0aGFuIHRoaXMgaXMgc2ltcGxlci4NCj4gDQo+IC1taWNoYWVsDQoNCg==
