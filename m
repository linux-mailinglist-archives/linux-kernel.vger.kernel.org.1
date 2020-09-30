Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0A127E0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgI3GRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:17:06 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:53037 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3GRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601446625; x=1632982625;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h2dqXd+6+GhMdKUZmlFiHQKroTtaKxnoNCqqny0u5y0=;
  b=HvlPR7tz6d/9AjHOjcRab2K52kh/9qWQZfyaNo6yH5kh5u6fNfP2YzwY
   P5GEcL4g1xrgS2YDqVZ1MXk4QSL73VzdAFDjH9HMD/qtwjOs7Omi7QmVw
   euohomCFTs7oCRcUk+LiOQJbMxBOGLn2PuGtaziiD2ldOAz2g7RsIOlnY
   1swmrCgPS5XAtGfh/aNBWugaTTG3OLJoUrYRo1Zja7eYvRx+76kzVM+EQ
   vWuZerjvYpqfslU8ROZXB9J60GjmPhhm4JVeToCt/0X0r+ti17A1an74I
   iPvPACOj9+mfyt3ZIWFR6TKkGR0a/oW4YDvKwfK7wR4xRhtJbANS8bge9
   Q==;
IronPort-SDR: c59upbEy+1vNHWArxoWS2UqZcx52EX2FhEXgoZtSgf/dkiP6mPXsU289edjzH5Kg4EWcfnUq9D
 IB47aBmy6iGIHsjzM1zIYT56x0nje12dnR+uWa7acNUEQqjXyKEU+BjcfhRPAPxw2URvIkAYJ1
 mSyWRa14SXrKO/UBXzX+t4+U5UbJfQYJ7q7UuAWTe5ogdLQQjeY0rR11MT7UeVYBawss3laTVl
 aWSPOyM9DZ0GXlVH1nE03YCutGBVffj7r2QVZ+3dgDTvuP+jI4UUp9RZjlkRH53ATiBDwtpSuW
 xUY=
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="88626517"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 23:17:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 23:16:49 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Tue, 29 Sep 2020 23:17:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R08/SGk62tzwbOTgic4ALFXH6ucBuoslBSBYKWGcBwQOSKSOWFvfbLuW+M97LWtCYnnFzsW+HZxe9b7b11Eq9lC8JjidO6BqggqNNamwoI/T7Pupv2koF3wlwBGSEfdrFDEKunm1MiRIpZwmPosh4tOSay3IWaAqo/skbvhY2wt+3aCEmpucg1sOq81hMrR8lmXp7s7zhcmawFI7LqDm81CeZtIExvTvrXkPPhO7ma6kWAr4c543fD6QW7ulqxvXrDXC1k3czBu2n5CBk2ezyDHOKiLK9ugsLcich4uDb3OpAxigNFtH6W33ezckSCyhSRuU0CQeIXDgVIsvBc/NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2dqXd+6+GhMdKUZmlFiHQKroTtaKxnoNCqqny0u5y0=;
 b=im6VvTx/3hgBQ2u5AcwwViIdYDVqV1p8egxZho1lQswZfrsb1WR0l+Zqf6QNk3Lzwm8+a/73RNuPTf+ye2aTs3cLsrBM8EeQjMMp+c7RM/r3fD0b5kNdbbj9r+kRPrmsATB3SXLG3tCXbobtadl2TILAHJrA7v2zZW8XqkprQRDVjP04OWh82zhp+6tizjy4NDtcOqmF7/uUUGgi5KPWzPUyFZqZX9qHZsThUN/VMGQrF6WA0FNgXVZtSW9LRUABEymiSVZGnsgyCEcYooz01HHQVpi/68IqnOtblDdWNEUgDAxA3URrUwwHcrTTLxsyrAxCBtrKCDv06Uf1s4km0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2dqXd+6+GhMdKUZmlFiHQKroTtaKxnoNCqqny0u5y0=;
 b=l50mPkLxABVJPtlMfriZzWcaokxzGi71bMg/adFM7oFVgzNWbZU/Q2wgkuTEmie9ZixKzvyZ2AR+HipUg6CsWXzKRH9y1Fh6NVKUUz10TkFpOdYlSVyp08ueltfZEvKbzZJc/6DTNmkoYnnZ7UTS2OiMkeY6KfBqQLittBVd7hs=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1946.namprd11.prod.outlook.com (2603:10b6:3:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Wed, 30 Sep
 2020 06:17:02 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 06:17:02 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 05/15] mtd: spi-nor: sfdp: get command opcode
 extension type from BFPT
Thread-Topic: [PATCH v13 05/15] mtd: spi-nor: sfdp: get command opcode
 extension type from BFPT
Thread-Index: AQHWlvFPRAFvCXk6P0+9D5vQWa5FOg==
Date:   Wed, 30 Sep 2020 06:17:01 +0000
Message-ID: <db90b212-cbf9-a675-024d-11a4969b9a6b@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-6-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-6-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59f07913-fa0a-45d7-0c00-08d86508720c
x-ms-traffictypediagnostic: DM5PR11MB1946:
x-microsoft-antispam-prvs: <DM5PR11MB1946C513BED5F90D411FE471F0330@DM5PR11MB1946.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L0nHXuX6UsgYVPtbJlTRGSEl1ib3KfSmuUx1CmS05SIvKu82ZK8WBbH5w02tdybtnRgzlT7Ge9UkFY0ox5MReEcqTvfbv9Nz7yfGALVpukGe4cxitv8fD07rtLu57Yefkj0AcZ4LHI61GMUP1gEi298+M3bZF9pgKWOSU5A0oTMw7//v4GUA7AHwq3rhnklrxtLF0LlvLqWiopAO2gcgS3DwFhLeZLIlF+ifwAiP4T7ZOnru9pNY1fBET9Kg+jvLfqzJ+BS2ZRP0vRvfmySarGqExZvkJtY7M6QiXEP9OWenskGqbZ285+33Ou4CiYBVKVNjj37IzknZozI3qLYCfcIYZS3HpvFHOcvjvAt78v3tVzipsp87FR9+AP8YlulJS0PLAIyAhBFAM5Wgd6sZN4ZWH5jMJcyLYJxFo34IcyUWUrMhXBOOmfUX0lYTacpn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(346002)(136003)(376002)(8936002)(2906002)(71200400001)(4326008)(6486002)(86362001)(26005)(186003)(31696002)(53546011)(6506007)(2616005)(8676002)(478600001)(5660300002)(6512007)(316002)(36756003)(31686004)(91956017)(110136005)(66556008)(76116006)(54906003)(66476007)(66446008)(64756008)(66946007)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /KHjwtnR11HX+DLvAEIME0l1N6VW88vJkTUrQyfQ/KCg2dXneW4Zq7RH3ApZ+sV4zkEpY3rqBE4OvJhMe+OssHmbE2O2jP9aT14pFXbeYcUQ2qq204lw6tFBr+FZk1oJeKapVKsIulZG4vNKAQFfdSZvd0Z/fjBRwqsS5k94uJfySwg2t6VVE5zuJdItlyy4I48RGKhjfZRZczsDPOVS5vpYtpNl4VvgCYCq1dZLYdYHd4U+y2+oGIDF7sYbpvu3u5Td1e1P9PMXHukgck4FMHboo5Tr30v9I1KxttNN4+vm6XRGsHxJOFE+IJ3CW+E5R1lvO8/GFXf3u6Wlv1CTsy5wiaXiMams/YqL0LZSxTTUA3zDrtQLIfelQ4Q9EL9IeL6hRqX9+ZIAOQxJSoR3FbicO4/aDhwerFngBqkJoJ3ulemIVu0gQGbTZA7fO5m+H2856Y6pRSHuyk0bkeN1G1okhIffEDD82C/6UrcPBTCxC8sTWjpjWu8n8gZrlEfYFkh1UDE2N5AunsxxWkujYJmi6gLfHlw+E9Vt8CuRqh6kUwhtpV1A5ejRCgB9Ylnhgs1usoD364z7rzO/+A359N2ghEe0ugc1QBVaKxfCop7Zm2ck2N9z58wlDZXN5aBvFh5Ekx86X2gCC5y9MCwFRA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEC2888EC55E9B4FAF5B781BB72F0150@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f07913-fa0a-45d7-0c00-08d86508720c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 06:17:01.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xMdqz5aYBywd5QOZmITgKP3og6GVuPxzGKGdqMqVmaAIH1kLNjyy0Z0fcYq6r8qop2E2E/1Wg4xkJQ0jrdGfqrEVScT2Unc1twZRFkAMHL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1946
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBTb21lIGRldmljZXMgaW4gRFRSIG1vZGUgZXhw
ZWN0IGFuIGV4dHJhIGNvbW1hbmQgYnl0ZSBjYWxsZWQgdGhlDQo+IGV4dGVuc2lvbi4gVGhlIGV4
dGVuc2lvbiBjYW4gZWl0aGVyIGJlIHNhbWUgYXMgdGhlIG9wY29kZSwgYml0d2lzZQ0KPiBpbnZl
cnNlIG9mIHRoZSBvcGNvZGUsIG9yIGFub3RoZXIgYWRkaXRpb25hbCBieXRlIGZvcm1pbmcgYSAx
Ni1ieXRlDQo+IG9wY29kZS4gR2V0IHRoZSBleHRlbnNpb24gdHlwZSBmcm9tIHRoZSBCRlBULiBG
b3Igbm93LCBvbmx5IGZsYXNoZXMgd2l0aA0KPiAicmVwZWF0IiBhbmQgImludmVyc2UiIGV4dGVu
c2lvbnMgYXJlIHN1cHBvcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2
IDxwLnlhZGF2QHRpLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFt
YmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2Zk
cC5jIHwgMTggKysrKysrKysrKysrKysrKysrDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NmZHAu
aCB8ICA2ICsrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL3NmZHAuYw0KPiBpbmRleCAyMWZhOWFiNzhlYWUuLmM3NzY1NTk2OGY4MCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gKysrIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9zZmRwLmMNCj4gQEAgLTYwNiw2ICs2MDYsMjQgQEAgc3RhdGljIGludCBzcGlfbm9y
X3BhcnNlX2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAgICAgICBpZiAoYmZwdF9oZWFk
ZXItPmxlbmd0aCA9PSBCRlBUX0RXT1JEX01BWF9KRVNEMjE2QikNCj4gICAgICAgICAgICAgICAg
IHJldHVybiBzcGlfbm9yX3Bvc3RfYmZwdF9maXh1cHMobm9yLCBiZnB0X2hlYWRlciwgJmJmcHQs
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBhcmFt
cyk7DQo+ICsgICAgICAgLyogOEQtOEQtOEQgY29tbWFuZCBleHRlbnNpb24uICovDQo+ICsgICAg
ICAgc3dpdGNoIChiZnB0LmR3b3Jkc1tCRlBUX0RXT1JEKDE4KV0gJiBCRlBUX0RXT1JEMThfQ01E
X0VYVF9NQVNLKSB7DQo+ICsgICAgICAgY2FzZSBCRlBUX0RXT1JEMThfQ01EX0VYVF9SRVA6DQo+
ICsgICAgICAgICAgICAgICBub3ItPmNtZF9leHRfdHlwZSA9IFNQSV9OT1JfRVhUX1JFUEVBVDsN
Cj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICsgICAgICAgY2FzZSBCRlBUX0RXT1JE
MThfQ01EX0VYVF9JTlY6DQo+ICsgICAgICAgICAgICAgICBub3ItPmNtZF9leHRfdHlwZSA9IFNQ
SV9OT1JfRVhUX0lOVkVSVDsNCj4gKyAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICsgICAg
ICAgY2FzZSBCRlBUX0RXT1JEMThfQ01EX0VYVF9SRVM6DQo+ICsgICAgICAgICAgICAgICBkZXZf
ZGJnKG5vci0+ZGV2LCAiUmVzZXJ2ZWQgY29tbWFuZCBleHRlbnNpb24gdXNlZFxuIik7DQo+ICsg
ICAgICAgICAgICAgICBicmVhazsNCj4gKw0KPiArICAgICAgIGNhc2UgQkZQVF9EV09SRDE4X0NN
RF9FWFRfMTZCOg0KPiArICAgICAgICAgICAgICAgZGV2X2RiZyhub3ItPmRldiwgIjE2LWJpdCBv
cGNvZGVzIG5vdCBzdXBwb3J0ZWRcbiIpOw0KPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FT1BO
T1RTVVBQOw0KPiArICAgICAgIH0NCj4gDQo+ICAgICAgICAgcmV0dXJuIHNwaV9ub3JfcG9zdF9i
ZnB0X2ZpeHVwcyhub3IsIGJmcHRfaGVhZGVyLCAmYmZwdCwgcGFyYW1zKTsNCj4gIH0NCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5oIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9zZmRwLmgNCj4gaW5kZXggN2Y5ODQ2YjNhMWFkLi42ZDcyNDMwNjcyNTIgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1u
b3Ivc2ZkcC5oDQo+IEBAIC05MCw2ICs5MCwxMiBAQCBzdHJ1Y3Qgc2ZkcF9iZnB0IHsNCj4gICNk
ZWZpbmUgQkZQVF9EV09SRDE1X1FFUl9TUjJfQklUMV9OT19SRCAgICAgICAgICAgICAgICAoMHg0
VUwgPDwgMjApDQo+ICAjZGVmaW5lIEJGUFRfRFdPUkQxNV9RRVJfU1IyX0JJVDEgICAgICAgICAg
ICAgICgweDVVTCA8PCAyMCkgLyogU3BhbnNpb24gKi8NCj4gDQo+ICsjZGVmaW5lIEJGUFRfRFdP
UkQxOF9DTURfRVhUX01BU0sgICAgICAgICAgICAgIEdFTk1BU0soMzAsIDI5KQ0KPiArI2RlZmlu
ZSBCRlBUX0RXT1JEMThfQ01EX0VYVF9SRVAgICAgICAgICAgICAgICAoMHgwVUwgPDwgMjkpIC8q
IFJlcGVhdCAqLw0KPiArI2RlZmluZSBCRlBUX0RXT1JEMThfQ01EX0VYVF9JTlYgICAgICAgICAg
ICAgICAoMHgxVUwgPDwgMjkpIC8qIEludmVydCAqLw0KPiArI2RlZmluZSBCRlBUX0RXT1JEMThf
Q01EX0VYVF9SRVMgICAgICAgICAgICAgICAoMHgyVUwgPDwgMjkpIC8qIFJlc2VydmVkICovDQo+
ICsjZGVmaW5lIEJGUFRfRFdPUkQxOF9DTURfRVhUXzE2QiAgICAgICAgICAgICAgICgweDNVTCA8
PCAyOSkgLyogMTYtYml0IG9wY29kZSAqLw0KPiArDQo+ICBzdHJ1Y3Qgc2ZkcF9wYXJhbWV0ZXJf
aGVhZGVyIHsNCj4gICAgICAgICB1OCAgICAgICAgICAgICAgaWRfbHNiOw0KPiAgICAgICAgIHU4
ICAgICAgICAgICAgICBtaW5vcjsNCj4gLS0NCj4gMi4yOC4wDQo+IA0KDQo=
