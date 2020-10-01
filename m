Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6978727FA9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbgJAHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:50:59 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:29881 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgJAHu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601538657; x=1633074657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PjiHrx1x2qoJ8KPnGzelpCAUXcIr8ovZQBZoitJVkZ0=;
  b=gv44c88U3F7oQgKqw1g1SmWTCMzhxIX7a8CcewD2PTg7MSH5qvNj3Uwf
   kCTzsGKVpQQQ0pSznvj/MFMS7bnirpSoJKWnLDk0cNJb8sgo4qDbUoOTj
   xQWYr/2lk3lTQE6m06TUSUzejcj11zuVSf9ByRF1ukGKeXMrHIL0WjSUD
   +NkaioNAETB+RvYZgO4Hnhqevl0U662bnzBJzDAfVfxeDtE7snm5lx1+d
   FlyNZ2zw7yQjd9uKcEly89ZJDqdm4wd9XCwQtIjQdyHC/8Rn++iFgTajT
   D94YOFjuKxRmRBJvIFAt9zKZRVjtx6uYvsJXGSw4NRJkYybTIgx3wYwy/
   w==;
IronPort-SDR: WT0OlUbH6LfRKURwiLZJw+94Huc1eo+J3tRTNhGe+kbzjk03Lg45EhbjPlQFcdFc0ng7hFIx5A
 lnYb5mr0PaV58EMZfIbQF/KN4WQ7sygmHrw4RfjEmrbBmzImnsqTBudXMCWXRbMdWEbvbxU8l4
 CgD4vbkBWL8i8clNtbrvG9j8oOWu8lHTkZKYOFdeAtlE4du55M24Qc6qPfBP55BJYrgFh59Pre
 QwRqBC4SRTbj8fuu7V1g0OivZfnNa0KyDQGMdm5lNSQ8qN+Rjjv2sabcOnNR1NeIJi+UOx9eJ+
 EVk=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="88757941"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 00:50:56 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 00:50:26 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 1 Oct 2020 00:50:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JI0dlq1W6pasyOeC33bF9PWpKpFWz2ZY4XnmiFjhldfC+JU3SiSnwVG22jfXWMZDFKChgG0eiE06qfUu5tdX/Fa8BT77a5rtCeB1LzYbaaCtPUFcSxDxKRseKoas3qJKM0uaM7wzU0biQi66ss6ViiQdh7sLafxQKwdHSe5Jr3gLKWSRqpOu+oauxDn1vw+3VmgeHPmk4YJjpCbDbqSq7atcAVHMcgIqWCCaPGIR+2HqLQrUSLTsAS3IGhTmCqazQ9e86uSp5m7GRLWz+e00U7kzo7MIoGmZaKfmkfhdE5W7tzXUuRVI4rt9JwCiAJK0QV+EPgbELgAA4bU26VV3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjiHrx1x2qoJ8KPnGzelpCAUXcIr8ovZQBZoitJVkZ0=;
 b=LaC9bzJxgMLjx/yQR6/NiERxZqYF1hsvtJHAO5mRuSQviVUoABojkNZWPOa4IA6q9eDkQAmtOXfFaCO9QWnyakDp+5k3YaJVffMfvW4XFWo64+I1Km78CPS7dcrCr0B1kWYhr2TWl1jTncvKvdxpbBk3Xv3Vfqp2hTwwkfhD8F6K8QCIuLx47MvihItwUVIi6IxLGbsylwUqjDxgQEokswD58GCO3VD64WSQnP0WBODJAZ0N4XGvm7tgJstULZemIDbPnMuS7dMSnS7CGE63SeerylnuN2WmjbPxh/pXhMH4t1NALu0zQ2r4Os1AUPNedNb3oRaxItlL+yneRHB+Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PjiHrx1x2qoJ8KPnGzelpCAUXcIr8ovZQBZoitJVkZ0=;
 b=azZvG+ghDsujccr6GdeBrsxTLCSW/ROVjpL1TNnX4wzqarEWFZR3wkwr2JKeYYb49UDiBKGfdLFLgu443a/iEbIV634hlziLSFsoRSOI46UQlNPVH5D6TYooxC/el9JOg5pFjVr+omo3TP+cvXu9aMYNSZ5rG3UKcP/iwV/bB4k=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Thu, 1 Oct
 2020 07:50:49 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 07:50:49 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 06/15] mtd: spi-nor: core: use dummy cycle and address
 width info from SFDP
Thread-Topic: [PATCH v14 06/15] mtd: spi-nor: core: use dummy cycle and
 address width info from SFDP
Thread-Index: AQHWl8eTpp+MWVKbCEOMYFc8fxZtOg==
Date:   Thu, 1 Oct 2020 07:50:49 +0000
Message-ID: <769ddd25-3028-2c49-220d-7588a05b25e7@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-7-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-7-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.51.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d579683c-2f89-41de-b516-08d865deb67d
x-ms-traffictypediagnostic: DM6PR11MB4691:
x-microsoft-antispam-prvs: <DM6PR11MB46913B20F5E29BB8C38A61C2F0300@DM6PR11MB4691.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6BqYmHWSaduydsrZ5jXbo4ngSrdhBChnMP1LlscEG0X5YIPjLxHjypYu7YVW+7FhkI1WKpNtBSo+j8RWLCZKRk4JL2G/LYb+q5LLfk+pb1fwuGG+D/LlvlfzYnYc6GnC+zzdz28XXSeZsBRLe0SWuQdNfRA4rEWYvsdDQdXsBUPxouYECMWTcA9dipKXSt7IMSBaFAVoRpa995IuVF8rObSy9Dh2ty+m0GkREGELevIy2+gCIe2G1SyaBQJX1pvuGTyE2VLWkYs1NKDmVe8zlbCBbqjM0mXzdKTsfBh0AeJNLza5EryAOCoflNNDz7RZd/WEJOqF/4nKChCmsxIiSuq0bCTncQUEaVYZbNfi8QUMFMkWXUU7HvNKEvsreOV8shKNDvpYVxiAsiBqrNhqyw/KqEA5WDaAGXTDTXFlLjG355IPz7DQtGbpK4Kw0aa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(2906002)(316002)(91956017)(8676002)(186003)(110136005)(54906003)(66946007)(2616005)(53546011)(6512007)(26005)(6506007)(31686004)(8936002)(31696002)(36756003)(64756008)(6486002)(4326008)(71200400001)(66476007)(86362001)(5660300002)(66556008)(66446008)(478600001)(76116006)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2cvMbKL5gypcRNOvZvc2NMHO/uX6OEjw5jgdui24m+hrNOY36iNMWmkKGJuHzvT9XO8GlR08e/tgLICc1uyv3u/VvuBYVVtA/2zlzisGNl1co8HtGfKBPMtVkVtvNHTI3S6vGvFAvHjzWX0ShF6uehG8PyNl7/8+Khql0Nnet8zRr3oLiqX6pvmxsIRxrbgmK8QhzINvjVrUqEmP90G2eDKBFJqs8kRhitOMKqNuFQrYvmnCtOAgQjDWOkHM+/jMd93NtjTpvY/ZpEEZMQwSgp4yrUHnMMZS/cahL3yXMXM0bDB8DjJ134GtyplWwMMQDN7h91XX6vsHG8IiPTwomkWMG1q8Nda7kTxni665KMBa8457+Z2ndXECkPuTkHq0AWgZ46MS3eG0LqvEaEVFmQWxfnQhiuJy97nS6WqcMXdkZ3ItL+nr4VydV7Q1sdy1F3tS3383EOfWEM9dNe2ZBht41LULT+VSRrUMSeaPY0z9ZuDw93F9fSTpidGJWC+8terKbwrNBfMLDtj0PmWHpXev8/FUTQojO2pLRnQ5pOlOUuVNp8jvfcS2EwuKLLHzCuqvzP52RLwdweNvDZ27HLHPqRNuqrVeT4fOAdxXfUDVZamlXn8YVMrfOlmlTTVeJpwEXd27zDA+mRa5jAubtA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A7DC3927CDDAE49A79BFDFA0F1A68AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d579683c-2f89-41de-b516-08d865deb67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 07:50:49.0402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0C/vrdq56ikRToJ7KlRNrAqB9OpXCUoCPMl0xsO/LutaepfrHNNKs9ZSJP/qaFzJ9bSl67ncX+3O2FbUP00Ik75WoRRDF3vvCEnkmGx37ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBUaGUgeFNQSSBQcm9maWxlIDEuMCB0YWJsZSBz
cGVjaWZpZXMgaG93IG1hbnkgZHVtbXkgY3ljbGVzIGFuZCBhZGRyZXNzDQo+IGJ5dGVzIGFyZSBu
ZWVkZWQgZm9yIHRoZSBSZWFkIFN0YXR1cyBSZWdpc3RlciBjb21tYW5kIGluIG9jdGFsIERUUiBt
b2RlLg0KPiBVc2UgdGhhdCBpbmZvcm1hdGlvbiB0byBzZW5kIHRoZSBjb3JyZWN0IFJlYWQgU1Ig
Y29tbWFuZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRp
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9j
aGlwLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgMTAgKysr
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+IGluZGV4IDk3ZTgyYTQ4MjFmNi4uMTQ2NWNmODBmOTc4IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuYw0KPiBAQCAtMzg1LDYgKzM4NSwxMSBAQCBzdGF0aWMgaW50IHNwaV9ub3JfcmVhZF9z
cihzdHJ1Y3Qgc3BpX25vciAqbm9yLCB1OCAqc3IpDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgU1BJX01FTV9PUF9OT19EVU1NWSwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfSU4oMSwgc3IsIDApKTsNCj4gDQo+ICsgICAg
ICAgICAgICAgICBpZiAobm9yLT5yZWdfcHJvdG8gPT0gU05PUl9QUk9UT184XzhfOF9EVFIpIHsN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgb3AuYWRkci5uYnl0ZXMgPSBub3ItPnBhcmFtcy0+
cmRzcl9hZGRyX25ieXRlczsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgb3AuZHVtbXkubmJ5
dGVzID0gbm9yLT5wYXJhbXMtPnJkc3JfZHVtbXk7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsN
Cj4gICAgICAgICAgICAgICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29wKG5vciwgJm9wLCBub3It
PnJlZ19wcm90byk7DQo+IA0KPiAgICAgICAgICAgICAgICAgcmV0ID0gc3BpX21lbV9leGVjX29w
KG5vci0+c3BpbWVtLCAmb3ApOw0KPiBAQCAtNDE4LDYgKzQyMywxMSBAQCBzdGF0aWMgaW50IHNw
aV9ub3JfcmVhZF9mc3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgdTggKmZzcikNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX05PX0RVTU1ZLA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfREFUQV9JTigxLCBmc3IsIDAp
KTsNCj4gDQo+ICsgICAgICAgICAgICAgICBpZiAobm9yLT5yZWdfcHJvdG8gPT0gU05PUl9QUk9U
T184XzhfOF9EVFIpIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgb3AuYWRkci5uYnl0ZXMg
PSBub3ItPnBhcmFtcy0+cmRzcl9hZGRyX25ieXRlczsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgb3AuZHVtbXkubmJ5dGVzID0gbm9yLT5wYXJhbXMtPnJkc3JfZHVtbXk7DQo+ICsgICAgICAg
ICAgICAgICB9DQo+ICsNCj4gICAgICAgICAgICAgICAgIHNwaV9ub3Jfc3BpbWVtX3NldHVwX29w
KG5vciwgJm9wLCBub3ItPnJlZ19wcm90byk7DQo+IA0KPiAgICAgICAgICAgICAgICAgcmV0ID0g
c3BpX21lbV9leGVjX29wKG5vci0+c3BpbWVtLCAmb3ApOw0KPiAtLQ0KPiAyLjI4LjANCj4gDQoN
Cg==
