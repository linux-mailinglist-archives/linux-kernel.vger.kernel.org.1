Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC33281012
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbgJBJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:47:50 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:45254 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJBJrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601632068; x=1633168068;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ry+6ExZTvSGUY05KyCUbs0WORZ1KM/MPOYQlE3Eee2k=;
  b=w1KbWEKi0R6f34k/fYGrGMEpyoFweyZI3OhOLlz8PEd57qOgH4/LV4Ae
   Q1Po9yWNCuV6rk2nW1Q/11juqrIZ4wANqbmbd8YG+pKCYgn6EcNFY1MXH
   JtMlUCSO9VUFd1ET4IX5Yv0sW3kh2JThxZiX3oiB0PYolyth8UI0M8DJk
   pf+FXsJTaw7zb4o5j3jny293+9fosEb0ndYK3r0MDdEmcg5Y6ou9uQJDT
   WyxYgitPnt3p9925WZP8IwlG3nGijvL8+jhJQZpFh4I39EaYv3Ysz6Jud
   6Ok7DQ4OqjQr3LGBuTlMp260V9+SWYkRp8ryknqX9f7hmUjqTnSN9Wo8H
   A==;
IronPort-SDR: Dx/N2sqOlQvNz5t+9YgWEeww2WietgyDtd9fdRJ6Vh68U3qNkThFBXMx31z7/7JgzTmgg5JLA4
 VDFMxy/tzv0g1V+ltU7qV9zKqotSmMj88UsfVcf8CCL7m1KzRFqYHHTge4ZpkRiGKQFh49Mr8m
 A5QfZG4uNTfe3WIDZlzoYH44yxkJZsXZJIc9JUEIymin0nJTADcGQO4pSJl/HW24OMBz2SiaX5
 yu1ol5GZcw8YKGy9PaukYu9Ik3wMpiVVy8fLjym0nvo/4SKbbQFidVyFdW8WBHwZAfBLfgHjmC
 62g=
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="28488956"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Oct 2020 02:47:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 2 Oct 2020 02:47:15 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 2 Oct 2020 02:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkjOPTAaUP7zRK5GbkGPjFJdij7/UVNN6qINp4BFcO5ODAHm4Kl7oZJYV+wyRJeST1LpAl5lNAsezmRMUwXsiRmsExCEx4xWDmL1FUwf8iRjpqYTuz1TU2pqViyas+EfGymyq0XayeJBoDAMLePmVwkeXJvNmMa85rKJvLaj+Hcz2QY8Xa2ACz7AwFW4XxWc+R6uQ70Xv0EIXkgmcMsGNL7rxCOGJWLSqpk+P4s2v8JTtE7AKUAzuPgS+YXDwJtAD9c+c6CD4VvzNDtRlyJjYyLkwR0qBiYjANzMDS2fWdUDsILLIz1mbptYulBX4hmDx1Fby+QyVJgdd1FWaKMxaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry+6ExZTvSGUY05KyCUbs0WORZ1KM/MPOYQlE3Eee2k=;
 b=idFJi5o9GZSa57sAUZRjKOLTDcvzevY19B8rSwEXYH83CHt1a8r42A8fgZ7LxJrICujoWNttimfgLs8IBOAOwzUWSy+UssmsbkmgUvIwOPm1JhgXh5gWmtmhAKSynqv2yiCELjCD1C0RwKTdB6oTAwxwwNidR/D0H0oOAcAqEtEc9avQzL09vrFFNfIfQ9XNU4QP9VbtwBq5/LkZs+e9j9EReq+Sg4j069zygl3cCv2Zr3/1wvbZSOzdxqnV7XKst3arhWJdaUOxbPSUjAfME18vHt+Nb7pCq+oiVo93vq9FsXb0JpgeGfvexjSuzBqfPeJMhlSOTQS2Z7w1coiSAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ry+6ExZTvSGUY05KyCUbs0WORZ1KM/MPOYQlE3Eee2k=;
 b=AQZfHCh1jqxyAF5WLFYFTjzLq1BkutQpQE0Qzic3mjWr2M79QVvp6rQsI1qXOeLsIB/kRfjqt8rn2DHRfSShv68mrwU2hv7TZl3vKkzLbcDj8IFx4Nr9tKABIBDQI6tJFDPjVqn35KDwAZM8LPIoJagenbJBOonwTK5+hYzLmUY=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB0073.namprd11.prod.outlook.com (2603:10b6:4:67::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.26; Fri, 2 Oct
 2020 09:47:45 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 09:47:45 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v15 10/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Topic: [PATCH v15 10/15] mtd: spi-nor: core: enable octal DTR mode when
 possible
Thread-Index: AQHWmKEU2iGDqswa+Uy5b5nAZAV7tw==
Date:   Fri, 2 Oct 2020 09:47:45 +0000
Message-ID: <1bd8bbb1-af99-3a55-cfbb-7bffd317e402@microchip.com>
References: <20201001202045.21499-1-p.yadav@ti.com>
 <20201001202045.21499-11-p.yadav@ti.com>
In-Reply-To: <20201001202045.21499-11-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3dc617fb-4872-4172-64b6-08d866b836f6
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-microsoft-antispam-prvs: <DM5PR11MB007374B0A675040D888366BAF0310@DM5PR11MB0073.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8i5icf3vZ4avDIbv92XsJ43ZRvH7+XOFUe6DGY1dY6mmpL6o8BQqclV1wdM4sfhpHAoYYfCZuqynJAVIiAT8njb0xlb+0ol/XN9g0zhfMxXJuULGJXxBwYoU7EAci40d7w0MrSNBdd6kHT5XuKWQOLHH4q/pWnBs9dEGur4GP+ZvtlrywXo4E/yIPPMqypyveegQS3dLbPKqIWspUbFpWOFpBxsVqxzYOwacnYHFZjrFoCvLPbazH2+FyeVrWdXtFf5CKvWbLEBOvITA7c4JUlK4m1xlkelUVP7O784eCHUOQPF5YEKAbwQwl3IopKDRoYRUGrOQHzUgbnvhfAS5kiFJZ4qCJ6pQwmefINdAZni2i46ji1CVAYpHb//TL1qOzxEHeW+cLrWIzuOxWAJB8WFWmrLZvfXAim4yoxv9ETJKxEclwmY5aOdf7hB1Jw4K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(376002)(396003)(136003)(366004)(8936002)(4326008)(83380400001)(6506007)(31696002)(110136005)(66446008)(54906003)(31686004)(316002)(36756003)(478600001)(71200400001)(86362001)(64756008)(66556008)(66946007)(66476007)(26005)(53546011)(5660300002)(91956017)(76116006)(6512007)(2906002)(6486002)(2616005)(186003)(8676002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: D/a1XBoiPVBLb0Yk6axwG5C9XbKEgbTRfbvPtyShmnlSaRv2jAcIblwiRnuo/Lti4ov5c124/PSsU7f2JI3AbY8ZQAFEOvR6pGwBWgjTezxvHDK6YPuelniKkOVrDS40+1b8d1DLBfCPLAR56MHxZZc9xnbuQcYp2Y0dLtDjAll6z6aIY5pVUL3NbbNlbAIv0+QdTbrk8qbHR3s3Lu/E9oeR6cWoJHHM/xFl5US54Ohf6ApcIlQojwnhosbH/udp7H8Uh5VDMyp6RA39xODhWUY/Yj0j0MOru4oWY/PhT2sD9+VtGQ0aKI6PXjj/oY/S5lCdiCeZrk5csDB8qcyQ7OHaogZSOQZJmwNmgSGWhA2qIYwclxyaPDT/lelKNHmy3GvVT9mU0YsMLnnKaVMPMH5S33c+aSCX5UEz9p1iOFs3vzQBSPwuQRjU5h475S5XDzXyTgv4HQXPIWFI0kQaOrIv0iJW9zjDD7UdSpLgKkLyZmfXx0+31vovpi8tKcYxQpmljv9Onf0vgs9qutchR8w6WI52chx3ydYGCtYg7ELjx8W3P4+sBUHVeYhumAX5+wuM6p+mKmvkcIkRiPRJ47K9yDSQFuIEU+jJ5S+sA5KvhIN6Sjhs+zCG+ERk3BsWpw6ko/OruDwAe5fNd6U43Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6396B15F2969F141A3770CD3DDBA2879@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc617fb-4872-4172-64b6-08d866b836f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 09:47:45.2959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdUfjjhcWKwztKCF+u+1nhjMZO/O31YsmxLE5BrPyEPRctrXEY25fa+2rmtVig15WnT9e05SHUK3NpbX0zakI7VnPUjIdXFzaOvFvdWIcPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMS8yMCAxMToyMCBQTSwgUHJhdHl1c2ggWWFkYXYgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQWxsb3cgZmxhc2hlcyB0byBzcGVjaWZ5IGEg
aG9vayB0byBlbmFibGUgb2N0YWwgRFRSIG1vZGUuIFVzZSB0aGlzIGhvb2sNCj4gd2hlbmV2ZXIg
cG9zc2libGUgdG8gZ2V0IG9wdGltYWwgdHJhbnNmZXIgc3BlZWRzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KDQpSZXZpZXdlZC1ieTogVHVk
b3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0KDQo+IC0tLQ0KPiAgZHJp
dmVycy9tdGQvc3BpLW5vci9jb3JlLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmggfCAgMiArKw0KPiAgMiBm
aWxlcyBjaGFuZ2VkLCA0MCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiBpbmRl
eCBlOTFkZGI0MDk2OTkuLmNmNmFkYTdjOGE3YiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQv
c3BpLW5vci9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4gQEAg
LTMwNjgsNiArMzA2OCwzOCBAQCBzdGF0aWMgaW50IHNwaV9ub3JfaW5pdF9wYXJhbXMoc3RydWN0
IHNwaV9ub3IgKm5vcikNCj4gICAgICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+ICsvKiogc3Bp
X25vcl9vY3RhbF9kdHJfZW5hYmxlKCkgLSBlbmFibGUgT2N0YWwgRFRSIEkvTyBpZiBuZWVkZWQN
Cj4gKyAqIEBub3I6ICAgICAgICAgICAgICAgICBwb2ludGVyIHRvIGEgJ3N0cnVjdCBzcGlfbm9y
Jw0KPiArICogQGVuYWJsZTogICAgICAgICAgICAgIHdoZXRoZXIgdG8gZW5hYmxlIG9yIGRpc2Fi
bGUgT2N0YWwgRFRSDQo+ICsgKg0KPiArICogUmV0dXJuOiAwIG9uIHN1Y2Nlc3MsIC1lcnJubyBv
dGhlcndpc2UuDQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQgc3BpX25vcl9vY3RhbF9kdHJfZW5hYmxl
KHN0cnVjdCBzcGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKQ0KPiArew0KPiArICAgICAgIGludCBy
ZXQ7DQo+ICsNCj4gKyAgICAgICBpZiAoIW5vci0+cGFyYW1zLT5vY3RhbF9kdHJfZW5hYmxlKQ0K
PiArICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ICsNCj4gKyAgICAgICBpZiAoIShub3ItPnJl
YWRfcHJvdG8gPT0gU05PUl9QUk9UT184XzhfOF9EVFIgJiYNCj4gKyAgICAgICAgICAgICBub3It
PndyaXRlX3Byb3RvID09IFNOT1JfUFJPVE9fOF84XzhfRFRSKSkNCj4gKyAgICAgICAgICAgICAg
IHJldHVybiAwOw0KPiArDQo+ICsgICAgICAgaWYgKCEobm9yLT5mbGFncyAmIFNOT1JfRl9JT19N
T0RFX0VOX1ZPTEFUSUxFKSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiArDQo+ICsg
ICAgICAgcmV0ID0gbm9yLT5wYXJhbXMtPm9jdGFsX2R0cl9lbmFibGUobm9yLCBlbmFibGUpOw0K
PiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiArDQo+
ICsgICAgICAgaWYgKGVuYWJsZSkNCj4gKyAgICAgICAgICAgICAgIG5vci0+cmVnX3Byb3RvID0g
U05PUl9QUk9UT184XzhfOF9EVFI7DQo+ICsgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAg
bm9yLT5yZWdfcHJvdG8gPSBTTk9SX1BST1RPXzFfMV8xOw0KPiArDQo+ICsgICAgICAgcmV0dXJu
IDA7DQo+ICt9DQo+ICsNCj4gIC8qKg0KPiAgICogc3BpX25vcl9xdWFkX2VuYWJsZSgpIC0gZW5h
YmxlIFF1YWQgSS9PIGlmIG5lZWRlZC4NCj4gICAqIEBub3I6ICAgICAgICAgICAgICAgIHBvaW50
ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InDQo+IEBAIC0zMTA3LDYgKzMxMzksMTIgQEAgc3RhdGlj
IGludCBzcGlfbm9yX2luaXQoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4gIHsNCj4gICAgICAgICBp
bnQgZXJyOw0KPiANCj4gKyAgICAgICBlcnIgPSBzcGlfbm9yX29jdGFsX2R0cl9lbmFibGUobm9y
LCB0cnVlKTsNCj4gKyAgICAgICBpZiAoZXJyKSB7DQo+ICsgICAgICAgICAgICAgICBkZXZfZGJn
KG5vci0+ZGV2LCAib2N0YWwgbW9kZSBub3Qgc3VwcG9ydGVkXG4iKTsNCj4gKyAgICAgICAgICAg
ICAgIHJldHVybiBlcnI7DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAgZXJyID0gc3BpX25v
cl9xdWFkX2VuYWJsZShub3IpOw0KPiAgICAgICAgIGlmIChlcnIpIHsNCj4gICAgICAgICAgICAg
ICAgIGRldl9kYmcobm9yLT5kZXYsICJxdWFkIG1vZGUgbm90IHN1cHBvcnRlZFxuIik7DQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1u
b3IvY29yZS5oDQo+IGluZGV4IGVhZWNlMTEyM2MwYi4uMTA1YTRkZGViMzA5IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuaA0KPiBAQCAtMjA0LDYgKzIwNCw3IEBAIHN0cnVjdCBzcGlfbm9yX2xvY2tpbmdf
b3BzIHsNCj4gICAqICAgICAgICAgICAgICAgICAgICAgIGhpZ2hlciBpbmRleCBpbiB0aGUgYXJy
YXksIHRoZSBoaWdoZXIgcHJpb3JpdHkuDQo+ICAgKiBAZXJhc2VfbWFwOiAgICAgICAgIHRoZSBl
cmFzZSBtYXAgcGFyc2VkIGZyb20gdGhlIFNGRFAgU2VjdG9yIE1hcCBQYXJhbWV0ZXINCj4gICAq
ICAgICAgICAgICAgICAgICAgICAgIFRhYmxlLg0KPiArICogQG9jdGFsX2R0cl9lbmFibGU6ICBl
bmFibGVzIFNQSSBOT1Igb2N0YWwgRFRSIG1vZGUuDQo+ICAgKiBAcXVhZF9lbmFibGU6ICAgICAg
IGVuYWJsZXMgU1BJIE5PUiBxdWFkIG1vZGUuDQo+ICAgKiBAc2V0XzRieXRlX2FkZHJfbW9kZTog
cHV0cyB0aGUgU1BJIE5PUiBpbiA0IGJ5dGUgYWRkcmVzc2luZyBtb2RlLg0KPiAgICogQGNvbnZl
cnRfYWRkcjogICAgICBjb252ZXJ0cyBhbiBhYnNvbHV0ZSBhZGRyZXNzIGludG8gc29tZXRoaW5n
IHRoZSBmbGFzaA0KPiBAQCAtMjI3LDYgKzIyOCw3IEBAIHN0cnVjdCBzcGlfbm9yX2ZsYXNoX3Bh
cmFtZXRlciB7DQo+IA0KPiAgICAgICAgIHN0cnVjdCBzcGlfbm9yX2VyYXNlX21hcCAgICAgICAg
ZXJhc2VfbWFwOw0KPiANCj4gKyAgICAgICBpbnQgKCpvY3RhbF9kdHJfZW5hYmxlKShzdHJ1Y3Qg
c3BpX25vciAqbm9yLCBib29sIGVuYWJsZSk7DQo+ICAgICAgICAgaW50ICgqcXVhZF9lbmFibGUp
KHN0cnVjdCBzcGlfbm9yICpub3IpOw0KPiAgICAgICAgIGludCAoKnNldF80Ynl0ZV9hZGRyX21v
ZGUpKHN0cnVjdCBzcGlfbm9yICpub3IsIGJvb2wgZW5hYmxlKTsNCj4gICAgICAgICB1MzIgKCpj
b252ZXJ0X2FkZHIpKHN0cnVjdCBzcGlfbm9yICpub3IsIHUzMiBhZGRyKTsNCj4gLS0NCj4gMi4y
OC4wDQo+IA0KDQo=
