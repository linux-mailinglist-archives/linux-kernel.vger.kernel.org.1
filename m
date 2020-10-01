Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B531C27FFF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbgJANVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:21:36 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:48204 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgJANVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601558493; x=1633094493;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FYHHSBn8heQUx5/79FLaPU5U/gHWri+t6Tre4kerS3w=;
  b=W9vcmDeY/mbGU80GS/0MZZiM29eVrpTq6jSUF74oB/9DBa/s9EfRDp6s
   jyk9KFjalLQ3ICiEMecrZV+l8yMPB5xjhczyTX24T3dVyCCfJaJmEBfKB
   JQXe27lxP750tUJtqEO5XFSQRlA+kSqFl+XodvdSrhBPHDT/GK0T2gwX+
   2PtukOokTocQnIaOglSoWY96A0XE8upn3B8EQKGhVDnepjyury29BJNye
   /iu0i793C615B2UqDeaVpTTK3UwbObO8dn0VjLhNS6zTpcfHy+M65k54E
   /UJABrDt/L0/yArRApFT1AqNxZZm1+IyTztNlfID4sXZDCXyRqRTTVJHz
   Q==;
IronPort-SDR: 0XHgO32+4RZno7SOhxifpkGrodL+sbGG8smdpfhgvzjEkHk4m/fPcAxOTij7gBAD5Kyo1Q8okK
 MIlvsLJEHT0zo+fP9rH6zmEyLRD2ABgYr50C5TtdGyw5Mf75LkatwiLk14SJsKKbjFNtw/Iw8T
 f4yy2xSV2ysgOS/kQU6hLUS1uXyvLLwX/jWPKaMsMDlLKq0yUygElRGIRq2l08yjrJiV+J4alo
 60QKN3taTapc3amQqLRQkWdwVjvrh7WKnsp+AFshpcPNpaRFU6WVhSeh3RliXm9YsR+4yI7R4P
 Agk=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="91088525"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 06:21:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 06:21:07 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 06:21:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWikvx/OpYOL+ZaEa9BQ+xwo6SSV8HCIEF01EZ1F958neSfcUkNN5xDgz2YSPOi+dCa9PPeBY6C/UctiqNrhzsERKA/C4YoRqnSeIHAfCR9g4Ar9dL4ccvb+mZI6ljeDbAjjEAU+qrG723W8teU2Te1EbFSQ+jm98+iRuNH9F3nt9IZd/gdebuzdGlwW8Li9GpKGble5V3EyR2PWru0sUVQBnyx9X3mPZbdUrkurmmJMECvMFFoDTTgfqDILv0Su/ANIBXm1RCMFRSyq+/gGxrAqAAUubpuRtiFz/6AM772833zkATuhRXZ5NoFUCBdbuqyrR+BHQEELH7ShME6FTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYHHSBn8heQUx5/79FLaPU5U/gHWri+t6Tre4kerS3w=;
 b=BJgVcGhymWk/ts20PzQEXE1Iyfo8C4VCy4//d3ZyrJjiiFSFQbnfOyoM35suVM8fDZ+rlb2lgDORNxfFktiG53/cU4WPBeYopKMrz2MR09NRmJN46+gFlK/pDKwVL0yQXi+YNJLzOM955B9mZD5zMgonrh9SiOxorRMzY2ffUFd1qLOtiS/0akG0zN+7zo+c/EsPmkrCyAkN/W0R9uQKB3gm8TN6jn14wMKhVyoeThHg+ViEk9aPjaZNpUyjtUfvBDqy07bq5F+ANsJoF94elbxNrVTvQftqRcExMjQZ8RrNGzjoTFjAoPhcAGMBHCl/Oz5gnwutgHo2nBSkglSnKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYHHSBn8heQUx5/79FLaPU5U/gHWri+t6Tre4kerS3w=;
 b=K/vcFotl2KSyum4t7VnG1U5yh39bhL9LQpOdGCGidwWkl8Ha6DRYRKnFsIKGDQKz+BuiHCzb2rtyDKP2DYz4o9aOMjN/LbT16ZcT1mfvHCt/IEB+DUG14vDeN4b5jmFaqzj67Cl45ajwmILKEbed/LDT8fcMt4f00pnvMhrBLl0=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1467.namprd11.prod.outlook.com (2603:10b6:4:a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.35; Thu, 1 Oct 2020 13:21:30 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 13:21:30 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Topic: [RFC PATCH 1/2] mtd: spi-nor: atmel: remove global
 SNOR_F_HAS_LOCK
Thread-Index: AQHWl/XGolQmpEhmZUmGKx8TlQY45g==
Date:   Thu, 1 Oct 2020 13:21:30 +0000
Message-ID: <915f2c88-1832-3c15-09ee-b0959e0ae70c@microchip.com>
References: <20201001122828.23186-1-michael@walle.cc>
In-Reply-To: <20201001122828.23186-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eedbf0e2-de6b-40f8-c0ab-08d8660ce8ef
x-ms-traffictypediagnostic: DM5PR11MB1467:
x-microsoft-antispam-prvs: <DM5PR11MB1467D3FE3F9D40FD142609FEF0300@DM5PR11MB1467.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zB0hGQky0FNyPk+znpS3rI3LQcSGxwpycOfM+uRp4O6CmVGQtEc7NU3iAtebWAHGfdg/LPaKo90Tmp+SEYeCqdXOddKOWElBxL91Oe7+KPyGN3l+P4W0lTEfDKQSxuf5dxls09xWuJ+Q8jCnY9fWD80tv7LkiYJqjXAyrQkBJeDWYca95UHpEhjmwzv8vUNke675mllFLb380aqZ0GWCePxru4ZmjVJsTptCk8KuiwuvTHbPEXl8x6WZlGuGnq3Ijd1CEdvDisBv9ilyx56nlcRmqwLuGG5r7iWtkLdTYf9I3WNwgz6SRLnmPIHGb4oMcmE4mk6gSh7Tji41Ag06UiowYt39SQypMdu4USp3ZJBb7bVURsVn4cv0CVITc82
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(39860400002)(136003)(66446008)(6506007)(8676002)(53546011)(26005)(31686004)(5660300002)(186003)(36756003)(110136005)(66946007)(76116006)(316002)(91956017)(54906003)(478600001)(2616005)(8936002)(71200400001)(6486002)(64756008)(83380400001)(6512007)(86362001)(2906002)(31696002)(4326008)(66476007)(66556008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tzT+ca2ze6OXKpVGeEBRG+8A7ZFYraXzctkCpDLFR5LTM5gG7N0vrPkxOHOqk/gwrcKCPEh7qwnmGsGW+UtSA/z/PAP1lIC/0vp3PZTQ3ZfH5EtUWuZssFESdncoH4tlmnuFMz0vg7T06rbtET9N18k0uq+ZPjP130sx9YmIBeLUm0QaPNzEQHKxFzqSSwJKjG+/X5kUA8IZttKTcdbgNiXdvxGFXGDy/s5kUJW6ycaBoH8t5rrE8GPSUZlTm0IGy6Lf+RhlyBBQRNzVLrDH5WyTWt3UD6K5CEJTOcpgQ8BpEvTm4vG/jtJjZo1FOLgaYqPsDCrWbv8c4tGYmJTPMRIf3TOB+cJnHQzO620IHMo3efPvW69UzZFnlfarMsbI90MJsudz5l6cwaA+TgI7xoj678mmVEbwbo02ECq1uodmGgu5kMMt273JHB2uBgn3q4CBycHfl8Uc7ItmCnUTind71OarB8QZ2dZZBTEi2llcfh1pMWCLgzBTve0e+ESKL8DGFshb9eCctj2bM0dJEeha1q4eaIf6I9jCdqbz9LFsKTFJ4x5ym6bCBQr3XzBssgeQJ4t4qNTALAg9ac6ZROrqrLi8t90+DPpUoxKZDJGa9wRS97c4o+33bz+mViO31MjYG6oGdYu3/e5H6VJszw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4305E60F56515846A3215E59ABEF803F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedbf0e2-de6b-40f8-c0ab-08d8660ce8ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 13:21:30.5063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wofotMS2whTh/MLgiNdmBoLCWz00lXYmrHtYrCwn07N92OFCCXnE5SMqWJiU7q/u+4Mqe1EBvvQMnvoAU+2foqAZoanNKBSM41xd1fWRQ8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1467
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCAzOjI4IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IFRoaXMgaXMgY29uc2lkZXJlZCBiYWQgZm9yIHRo
ZSBmb2xsb3dpbmcgcmVhc29uczoNCj4gICgxKSBXZSBvbmx5IHN1cHBvcnQgdGhlIGJsb2NrIHBy
b3RlY3Rpb24gd2l0aCBCUG4gYml0cyBmb3Igd3JpdGUNCj4gICAgICBwcm90ZWN0aW9uLiBOb3Qg
YWxsIEF0bWVsIHBhcnRzIHN1cHBvcnQgdGhpcy4NCj4gICgyKSBOZXdseSBhZGRlZCBmbGFzaCBj
aGlwIHdpbGwgYXV0b21hdGljYWxseSBpbmhlcml0IHRoZSAiaGFzDQo+ICAgICAgbG9ja2luZyIg
c3VwcG9ydCBhbmQgdGh1cyBuZWVkcyB0byBleHBsaWNpdGx5IHRlc3RlZC4gQmV0dGVyDQo+ICAg
ICAgYmUgb3B0LWluIGluc3RlYWQgb2Ygb3B0LW91dC4NCj4gICgzKSBUaGVyZSBhcmUgYWxyZWFk
eSBzdXBwb3J0ZWQgZmxhc2hlcyB3aGljaCBkb24ndCBzdXBwb3J0IHRoZSBsb2NraW5nDQo+ICAg
ICAgICAgIHNjaGVtZS4gU28gSSBhc3N1bWUgdGhpcyB3YXNuJ3QgcHJvcGVybHkgdGVzdGVkIGJl
Zm9yZSBhZGRpbmcgdGhhdA0KPiAgICAgICAgICBjaGlwOyB3aGljaCBlbmZvcmNlcyBteSBwcmV2
aW91cyBhcmd1bWVudCB0aGF0IGxvY2tpbmcgc3VwcG9ydCBzaG91bGQNCj4gICAgICAgICAgYmUg
YW4gb3B0LWluLg0KPiANCj4gUmVtb3ZlIHRoZSBnbG9iYWwgZmxhZyBhbmQgYWRkIGluZGl2aWR1
YWwgZmxhZ3MgdG8gYWxsIGZsYXNoZXMNCj4gd2hpY2ggc3VwcG9ydHMgQlAgbG9ja2luZy4gSW4g
cGFydGljdWxhciB0aGUgZm9sbG93aW5nIGZsYXNoZXMNCj4gZG9uJ3Qgc3VwcG9ydCB0aGUgQlAg
c2NoZW1lOg0KPiAgLSBBVDI2RjAwNA0KPiAgLSBBVDI1U0wzMjENCj4gIC0gQVQ0NURCMDgxRA0K
PiANCg0KSSBsaWtlIHRoZSBpZGVhLiBUaGFua3MgZm9yIHRoZSBlZmZvcnQuIFdpbGwgY2hlY2sg
YWxsIHRob3NlIGRhdGFzaGVldHMNCmFuZCBnZXQgYmFjayB0byB5b3UuDQoNCj4gU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCj4gLS0tDQo+ICBkcml2ZXJz
L210ZC9zcGktbm9yL2F0bWVsLmMgfCAyOCArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2F0bWVsLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2F0bWVsLmMNCj4gaW5kZXggM2Y1ZjIxYTQ3M2E2Li40OWQzOTJjNmM4YmMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvYXRtZWwuYw0KPiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL2F0bWVsLmMNCj4gQEAgLTEwLDM3ICsxMCwyNyBAQA0KPiANCj4gIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyBhdG1lbF9wYXJ0c1tdID0gew0KPiAgICAgICAgIC8qIEF0
bWVsIC0tIHNvbWUgYXJlIChjb25mdXNpbmdseSkgbWFya2V0ZWQgYXMgIkRhdGFGbGFzaCIgKi8N
Cj4gLSAgICAgICB7ICJhdDI1ZnMwMTAiLCAgSU5GTygweDFmNjYwMSwgMCwgMzIgKiAxMDI0LCAg
IDQsIFNFQ1RfNEspIH0sDQo+IC0gICAgICAgeyAiYXQyNWZzMDQwIiwgIElORk8oMHgxZjY2MDQs
IDAsIDY0ICogMTAyNCwgICA4LCBTRUNUXzRLKSB9LA0KPiArICAgICAgIHsgImF0MjVmczAxMCIs
ICBJTkZPKDB4MWY2NjAxLCAwLCAzMiAqIDEwMjQsICAgNCwgU0VDVF80SyB8IFNQSV9OT1JfSEFT
X0xPQ0spIH0sDQo+ICsgICAgICAgeyAiYXQyNWZzMDQwIiwgIElORk8oMHgxZjY2MDQsIDAsIDY0
ICogMTAyNCwgICA4LCBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSykgfSwNCj4gDQo+IC0gICAg
ICAgeyAiYXQyNWRmMDQxYSIsIElORk8oMHgxZjQ0MDEsIDAsIDY0ICogMTAyNCwgICA4LCBTRUNU
XzRLKSB9LA0KPiAtICAgICAgIHsgImF0MjVkZjMyMSIsICBJTkZPKDB4MWY0NzAwLCAwLCA2NCAq
IDEwMjQsICA2NCwgU0VDVF80SykgfSwNCj4gLSAgICAgICB7ICJhdDI1ZGYzMjFhIiwgSU5GTygw
eDFmNDcwMSwgMCwgNjQgKiAxMDI0LCAgNjQsIFNFQ1RfNEspIH0sDQo+IC0gICAgICAgeyAiYXQy
NWRmNjQxIiwgIElORk8oMHgxZjQ4MDAsIDAsIDY0ICogMTAyNCwgMTI4LCBTRUNUXzRLKSB9LA0K
PiArICAgICAgIHsgImF0MjVkZjA0MWEiLCBJTkZPKDB4MWY0NDAxLCAwLCA2NCAqIDEwMjQsICAg
OCwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+ICsgICAgICAgeyAiYXQyNWRmMzIx
IiwgIElORk8oMHgxZjQ3MDAsIDAsIDY0ICogMTAyNCwgIDY0LCBTRUNUXzRLIHwgU1BJX05PUl9I
QVNfTE9DSykgfSwNCj4gKyAgICAgICB7ICJhdDI1ZGYzMjFhIiwgSU5GTygweDFmNDcwMSwgMCwg
NjQgKiAxMDI0LCAgNjQsIFNFQ1RfNEsgfCBTUElfTk9SX0hBU19MT0NLKSB9LA0KPiArICAgICAg
IHsgImF0MjVkZjY0MSIsICBJTkZPKDB4MWY0ODAwLCAwLCA2NCAqIDEwMjQsIDEyOCwgU0VDVF80
SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+IA0KPiAgICAgICAgIHsgImF0MjVzbDMyMSIsICBJ
TkZPKDB4MWY0MjE2LCAwLCA2NCAqIDEwMjQsIDY0LA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8IFNQSV9OT1JfUVVBRF9SRUFEKSB9
LA0KPiANCj4gICAgICAgICB7ICJhdDI2ZjAwNCIsICAgSU5GTygweDFmMDQwMCwgMCwgNjQgKiAx
MDI0LCAgOCwgU0VDVF80SykgfSwNCj4gLSAgICAgICB7ICJhdDI2ZGYwODFhIiwgSU5GTygweDFm
NDUwMSwgMCwgNjQgKiAxMDI0LCAxNiwgU0VDVF80SykgfSwNCj4gLSAgICAgICB7ICJhdDI2ZGYx
NjFhIiwgSU5GTygweDFmNDYwMSwgMCwgNjQgKiAxMDI0LCAzMiwgU0VDVF80SykgfSwNCj4gLSAg
ICAgICB7ICJhdDI2ZGYzMjEiLCAgSU5GTygweDFmNDcwMCwgMCwgNjQgKiAxMDI0LCA2NCwgU0VD
VF80SykgfSwNCj4gKyAgICAgICB7ICJhdDI2ZGYwODFhIiwgSU5GTygweDFmNDUwMSwgMCwgNjQg
KiAxMDI0LCAxNiwgU0VDVF80SyB8IFNQSV9OT1JfSEFTX0xPQ0spIH0sDQo+ICsgICAgICAgeyAi
YXQyNmRmMTYxYSIsIElORk8oMHgxZjQ2MDEsIDAsIDY0ICogMTAyNCwgMzIsIFNFQ1RfNEsgfCBT
UElfTk9SX0hBU19MT0NLKSB9LA0KPiArICAgICAgIHsgImF0MjZkZjMyMSIsICBJTkZPKDB4MWY0
NzAwLCAwLCA2NCAqIDEwMjQsIDY0LCBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSykgfSwNCj4g
DQo+ICAgICAgICAgeyAiYXQ0NWRiMDgxZCIsIElORk8oMHgxZjI1MDAsIDAsIDY0ICogMTAyNCwg
MTYsIFNFQ1RfNEspIH0sDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyB2b2lkIGF0bWVsX2RlZmF1bHRf
aW5pdChzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAtew0KPiAtICAgICAgIG5vci0+ZmxhZ3MgfD0g
U05PUl9GX0hBU19MT0NLOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IHNwaV9u
b3JfZml4dXBzIGF0bWVsX2ZpeHVwcyA9IHsNCj4gLSAgICAgICAuZGVmYXVsdF9pbml0ID0gYXRt
ZWxfZGVmYXVsdF9pbml0LA0KPiAtfTsNCj4gLQ0KPiAgY29uc3Qgc3RydWN0IHNwaV9ub3JfbWFu
dWZhY3R1cmVyIHNwaV9ub3JfYXRtZWwgPSB7DQo+ICAgICAgICAgLm5hbWUgPSAiYXRtZWwiLA0K
PiAgICAgICAgIC5wYXJ0cyA9IGF0bWVsX3BhcnRzLA0KPiAgICAgICAgIC5ucGFydHMgPSBBUlJB
WV9TSVpFKGF0bWVsX3BhcnRzKSwNCj4gLSAgICAgICAuZml4dXBzID0gJmF0bWVsX2ZpeHVwcywN
Cj4gIH07DQo+IC0tDQo+IDIuMjAuMQ0KPiANCg0K
