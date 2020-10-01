Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7955E27FB66
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbgJAIV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:21:57 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:41039 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbgJAIV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601540516; x=1633076516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qQk+dEvfvSATAq0mFvKsJCPy+7aMmw1iMPEKmZmhbAc=;
  b=pffeFPOI26rF0n89TXwXU931ZNirD1hoCwQ9eQokbRMSXVVsrF43+Gin
   hOLehv+Ez0G4ih/f3W9QnLNqfy3RuJNYal+ALss4Q7BjNHIQJ5sIv9X7z
   IpzjODu5hsCLbSO64FiGVWT/I/mp1WfkqQjVZOqojY+XUotrOGptxWjMu
   QL0Sl0y7gIoULwGrPhTxpy8gpWcqgQAlb8e5oLDH+nC5dlUONLX3/KtoW
   vk4ZZk4/FpKNgZge+UeuT7EcGECSXLTFO5/UOTfEaPD5lpOzlDGvFw7U1
   RRYe3X7lqZj+qasdDQluulQLq88VlxEDR4h2wL+2tbnMz27XY4jtMHjEp
   w==;
IronPort-SDR: TQxlE/nRWn907iJNEdFW0LOtVbl8RHWClIbHzaKA0XQhrgXRYnIMlbsVXUWFbnKAqS0S+iMoLa
 6eJ4IIE7idaz7ZboX1etGqBO+2vycDxR0/rcjpGlOrjVL6g9hmBXlequj/+reuyPXwm/Am9cLK
 B7EUzFm9eUCmNNZBfPue0k8lieSQWitvjtKe3oLFugvV+9/HXCAZDLp5jQhkwyU70TFiFC3Wkj
 c1YupHY9NUptcalJbdVkJ6fyr3mNmhDMj3dzMdQc+peF0TsjWmRMvvdG24NWx+4hBAvBGdffXI
 UrU=
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="91054103"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Oct 2020 01:21:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 1 Oct 2020 01:21:55 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 1 Oct 2020 01:21:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcolDNh1Sen2CXgc6l7k3SGM3tqyCDC8XCu3gakyZyGFQdq+VsgZ8BaST9VIh4y/aOXrZkmAyPDAcQ88NcZJOlodkFWvDlLe8lk5dmXONqouakanD5CYt4Zxp7eK6ZAjbkOtprFmRVtVngaouglwByJvYRrf/7X1Okw6L6EU/zZ4FLnnVk9LriQ9I6EhjKJtOQ05QLItTn35VKm4b+kgsZb9qCAS73T89mcD2Rbpvzw/R1j77VQihat8WAgrppakyia3dIJd5IaaIWI6b199fM2V3esnctD6HghHLzX7Dq72XKeySbHPAGBvmAgOU7OcheczmpHzKynXXLpQU6koxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQk+dEvfvSATAq0mFvKsJCPy+7aMmw1iMPEKmZmhbAc=;
 b=DlMTMW3JTndP0NVHMtC+hs5WLLX9KPWRVzAquYrQ+ERjUo3vd5VLrW7jL4Z6k54w65l1aTMgN34LPbyD04qgL3GRwWbOy3XaPEdm6t12d12SiWWcuam9kjypYhy4IrLY0qrm1HJa8X7FhsZe13o/WOTqxGbRlwvd2whnDx8aNHiObZgC4Ea4M+xYORV2SfzSxz9W7eQcezCkpBz2JMQdxa5fREiq3rLck7rVeBzNhBGTPSduESYkkEqxnfMnmoSsy8B/Fp8MFoXij3nl9AIYNWT/4Z3tM689xlDHzrn2aqZVT3q600/fMI4j6H2v38XtIu4B9Zu28nIvJ3bjRA1kRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQk+dEvfvSATAq0mFvKsJCPy+7aMmw1iMPEKmZmhbAc=;
 b=Vmwhj4S3pTulfPy3F7w5BsFGt1gYAh4MDKGM1MHRo4I3+wgXobQxqG9YHFQ9Aoh0W6oNY05wvO6dzt7fdBRwRF0N/qa6W2/kYIbuJZgDPA3MrPM4/zHQFMAqSH2QDaUp0fSTEQdEq5Ri2ST3bg70Fe9q/gTQHteZN0WjEhUPR5o=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (2603:10b6:3:112::12)
 by DM5PR11MB1947.namprd11.prod.outlook.com (2603:10b6:3:110::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Thu, 1 Oct
 2020 08:21:54 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 08:21:54 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v14 11/15] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Thread-Topic: [PATCH v14 11/15] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Thread-Index: AQHWl8vrAD9FOiJx+EWZ8429w5IrbA==
Date:   Thu, 1 Oct 2020 08:21:54 +0000
Message-ID: <42ac8a85-8d39-07c9-e117-1c26f11c18e4@microchip.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
 <20200930185732.6201-12-p.yadav@ti.com>
In-Reply-To: <20200930185732.6201-12-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: c7c2f4d8-55d3-40e4-8c16-08d865e30e62
x-ms-traffictypediagnostic: DM5PR11MB1947:
x-microsoft-antispam-prvs: <DM5PR11MB19472A171DD52C3ABABCBB68F0300@DM5PR11MB1947.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OCICqK6kPmmU1yG8IPes4pAeIGZjCQDzZJh8fY/nduILolpJV7Tkg1MQ9MgtTpv6GUTrsowAcOzwB3vlvdnaFYy7FRGNLDGSd0U+tHo8aJny38eCTxqLfwzA9Tm4GIPDTydV7UhMiXYFsSj8SsJDLnQHIZweSmgQUgH6Rtf8v2Cr1se0K4yjgOhZO79sXBMkqtsidqscWyUVZENZJBmXUxmbAwKPlWP05i8Uoe+71EMl43h13rbn8tXeTJsrij3DTckqaebKWHOikbPZy2hlXGGxvl1g5jAzuO5pLxEWdNaRyPd9x1W+CEdk5uYi5WaTwIF/JH2fhv0JaUXPcoSWKwCEw9FrCJ1hzY01ozy7w/Jn00NOP6uedCZk8PngcAO3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(4326008)(66946007)(478600001)(64756008)(66556008)(316002)(66476007)(71200400001)(91956017)(186003)(110136005)(2906002)(76116006)(86362001)(66446008)(36756003)(26005)(2616005)(6506007)(5660300002)(53546011)(31696002)(8936002)(31686004)(6512007)(6486002)(8676002)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NS+Pg+QNYMEayZFPBg83e5qT9JKbhj9DYmzVX00AY/t5IM02U2CBVb7jWsv/gi7K5T8hZqMJSNQL59A0RIjTDSLTyxi5VtuqQPFBhLzMe1hbxiJ1ZjgUuAXY2fBQQrwfk394lc+u4p37QzZ2VB+LqMhTivB2RavqQ1JG9ilP4atGVwj6/uUxdAohTc5TLIWQ2mJ1k/b+Ay5iy1OwdARYYD5JwFKJzbADtld+NYrP5Y9I1JHaeLcknkN5Sz/Bq7/wmEe9gD+TRLxQXZZtxzuTmVXV1rzfkvK8eaNqWfkq+xgAF8HXB1v0yXmZ3Sa37Mb5tRJ/xfNhGVniVtu2B8i39b6sxkz+cjoDumo3pbVzeppLYw45tywxJMFYRJz2RKqQCTrKzyBM2hgSR7lnInC4OMpNs010GbzIsDyBB+vEF6/hN1A86ruGiKbRooj8/c5A/g+BM+JQ4jK5Hoe8hN/cu3H5fS7jETZzSyCcR6+bDRxLoZzujRJsEuXwj7m6dEDQYmDxXOpyhYzPr/3ffhhlrqlcZqXFYGA7oFo77jG7CrcStiHiSe6m6yrEW+aGKysrd52jfIj24hLoGHzyJWWUW/mf44NxTOIkQPIG5i9SuTu2Xtj+mE475IldosSw9rocYyXVncNm9N3YSCkMxbtDMw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <872E48137618514A899BD4641EDD7E32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c2f4d8-55d3-40e4-8c16-08d865e30e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2020 08:21:54.4946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vUMDIrtRiYeTzqH24FXcmM7VLkW8CJJogpOdkDUpormBEb/436GI7BpsVVsk1agVNCowEZmvOF6ShE/oHa8ym6N6EK7sabIvv69KLQ1gErk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1947
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8zMC8yMCA5OjU3IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBIFNvZnQgUmVzZXQgc2VxdWVuY2Ugd2lsbCBy
ZXR1cm4gdGhlIGZsYXNoIHRvIFBvd2VyLW9uLVJlc2V0IChQT1IpDQo+IHN0YXRlLiBJdCBjb25z
aXN0cyBvZiB0d28gY29tbWFuZHM6IFNvZnQgUmVzZXQgRW5hYmxlIGFuZCBTb2Z0IFJlc2V0Lg0K
PiBGaW5kIG91dCBpZiB0aGUgc2VxdWVuY2UgaXMgc3VwcG9ydGVkIGZyb20gQkZQVCBEV09SRCAx
Ni4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4N
Cg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNv
bT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIHwgMSArDQo+ICBkcml2
ZXJzL210ZC9zcGktbm9yL3NmZHAuYyB8IDQgKysrKw0KPiAgZHJpdmVycy9tdGQvc3BpLW5vci9z
ZmRwLmggfCAyICsrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oIGIvZHJpdmVycy9tdGQvc3Bp
LW5vci9jb3JlLmgNCj4gaW5kZXggMTA1YTRkZGViMzA5Li4wYTc3NWE3YjU2MDYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29yZS5oDQo+IEBAIC0yNyw2ICsyNyw3IEBAIGVudW0gc3BpX25vcl9vcHRpb25fZmxh
Z3Mgew0KPiAgICAgICAgIFNOT1JfRl9IQVNfNEJJVF9CUCAgICAgID0gQklUKDEyKSwNCj4gICAg
ICAgICBTTk9SX0ZfSEFTX1NSX0JQM19CSVQ2ICA9IEJJVCgxMyksDQo+ICAgICAgICAgU05PUl9G
X0lPX01PREVfRU5fVk9MQVRJTEUgPSBCSVQoMTQpLA0KPiArICAgICAgIFNOT1JfRl9TT0ZUX1JF
U0VUICAgICAgID0gQklUKDE1KSwNCj4gIH07DQo+IA0KPiAgc3RydWN0IHNwaV9ub3JfcmVhZF9j
b21tYW5kIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gaW5kZXggMGI1YjllYTQ0Y2ZjLi5mNmQ3NzAwNGZk
NGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+ICsrKyBiL2Ry
aXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5jDQo+IEBAIC02MDgsNiArNjA4LDEwIEBAIHN0YXRpYyBp
bnQgc3BpX25vcl9wYXJzZV9iZnB0KHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICAgICAgICAgICAg
ICAgICBicmVhazsNCj4gICAgICAgICB9DQo+IA0KPiArICAgICAgIC8qIFNvZnQgUmVzZXQgc3Vw
cG9ydC4gKi8NCj4gKyAgICAgICBpZiAoYmZwdC5kd29yZHNbQkZQVF9EV09SRCgxNildICYgQkZQ
VF9EV09SRDE2X1NXUlNUX0VOX1JTVCkNCj4gKyAgICAgICAgICAgICAgIG5vci0+ZmxhZ3MgfD0g
U05PUl9GX1NPRlRfUkVTRVQ7DQo+ICsNCj4gICAgICAgICAvKiBTdG9wIGhlcmUgaWYgbm90IEpF
U0QyMTYgcmV2IEMgb3IgbGF0ZXIuICovDQo+ICAgICAgICAgaWYgKGJmcHRfaGVhZGVyLT5sZW5n
dGggPT0gQkZQVF9EV09SRF9NQVhfSkVTRDIxNkIpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4g
c3BpX25vcl9wb3N0X2JmcHRfZml4dXBzKG5vciwgYmZwdF9oZWFkZXIsICZiZnB0LA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmggYi9kcml2ZXJzL210ZC9zcGktbm9y
L3NmZHAuaA0KPiBpbmRleCA2ZDcyNDMwNjcyNTIuLjg5MTUyYWUxY2YzZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmgNCj4gKysrIGIvZHJpdmVycy9tdGQvc3BpLW5v
ci9zZmRwLmgNCj4gQEAgLTkwLDYgKzkwLDggQEAgc3RydWN0IHNmZHBfYmZwdCB7DQo+ICAjZGVm
aW5lIEJGUFRfRFdPUkQxNV9RRVJfU1IyX0JJVDFfTk9fUkQgICAgICAgICAgICAgICAgKDB4NFVM
IDw8IDIwKQ0KPiAgI2RlZmluZSBCRlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxICAgICAgICAgICAg
ICAoMHg1VUwgPDwgMjApIC8qIFNwYW5zaW9uICovDQo+IA0KPiArI2RlZmluZSBCRlBUX0RXT1JE
MTZfU1dSU1RfRU5fUlNUICAgICAgICAgICAgICBCSVQoMTIpDQo+ICsNCj4gICNkZWZpbmUgQkZQ
VF9EV09SRDE4X0NNRF9FWFRfTUFTSyAgICAgICAgICAgICAgR0VOTUFTSygzMCwgMjkpDQo+ICAj
ZGVmaW5lIEJGUFRfRFdPUkQxOF9DTURfRVhUX1JFUCAgICAgICAgICAgICAgICgweDBVTCA8PCAy
OSkgLyogUmVwZWF0ICovDQo+ICAjZGVmaW5lIEJGUFRfRFdPUkQxOF9DTURfRVhUX0lOViAgICAg
ICAgICAgICAgICgweDFVTCA8PCAyOSkgLyogSW52ZXJ0ICovDQo+IC0tDQo+IDIuMjguMA0KPiAN
Cg0K
