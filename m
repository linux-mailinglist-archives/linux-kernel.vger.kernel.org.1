Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869052A8159
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbgKEOsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:48:51 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:60859 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731124AbgKEOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604587685; x=1636123685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FQscbZ/6+mXASBxneJANWvmPus4bNyB8IEmS0L8F8c0=;
  b=miXUC7w3JGaJTRKNajHYpRlXBLfVIPOjaO4oLLQpxoiU93WpSyGPg2Rv
   PjqUf2Oa4GNZdzT6lclIkemsVyGLs0TVOvonP6kXcAEADKxxi4Ir2iA4e
   1TCy3EPrWBNORJRgCH9O20syhGDsIsOL4aSI30pT+wJAHvKE1pk1ZHKSB
   sHqTD/+Y0fBCZQfUqSimfn3r0Hp+9BeM0OAN9aZgDFDirIS6AsezlxxMF
   7klKRaxA4jcwj4ekBQtJZUBSzzEH5dJOnateBfCgrYFhU7pM2KIX3QlnL
   L/wqqD+uJ5SoK3WUOl30dPVeQHil06FAVs8s/63In0hECZkSlCaRaLEqe
   A==;
IronPort-SDR: 12S7eUZt1trzs/VF6JPcFgg/WuhLuJgfJRS3ue9BWPKVz3BwdmGJwTitdukgdqKiKQt14SUQ1l
 cbXpKfZTejgNWDHSg8jyQf8+kKMHczO5kfBpB9DXvi1YcKoiTCTqLQ1ZlFUrjSQOGdzeooBzBs
 uMFWZY0iL+CWLhWY+WvoASTaUgma1XX+Nt6JGwaYdABwKyCRqta2BZN6a0fZyj7JtAS+3khRoM
 OJUYfkbp/xPx6ux1jCwJhaYhUX9R/yKwU3KP9KqGxjpCoBYObzJuXEAnuCfbhF9/Y6FiUF1UNp
 5+o=
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="92621039"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Nov 2020 07:48:05 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 07:48:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 5 Nov 2020 07:48:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCq4BO7bB7Irqes6aTURogKPzskrlknAvvwWGIycPmBj4nTTkrww/IY6J2P2QiUERJrwhCiSdUNKVE0eHzA1dkK8zGmU48MKoh3iH1M5UjHbL2Oi0Pn50GbdjQZR2+E3to0CbHwXbnTcOnuZNiTYHrYYKML5XI4xJqfzrWDTnU9a+hHxovj1CThr/kv5Szm/uz64+FB2Ypz3v+UFv75d2EWqXemt3vJLIFk0/717S1WvKdKl+V4H099ElJYg4jdNjMcbw6zH2Wg8K+VAB1dgUnm6Pt7DLgcyFq1FvtZd73+DseN3wkoJVkvHj3DRaguRixl4yACPC/nsvXi8S5navg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQscbZ/6+mXASBxneJANWvmPus4bNyB8IEmS0L8F8c0=;
 b=XEDTllfJ6MlGhs4xm0iw5P09Cz4RGHTbMLGEQFCZuT55eW28MA0hF5oWZn3Q71x7PRzpFUsGUaKLFvPeRkksDD1ipwoHs+j7OfHektAjB8sehnpOegR0wuRAW8zmZZ42YE0jK8FspGu15626A8PGTz5UkHJKuPHdtQZzPXigbV7eRZKeQGHWsQ/mQQkNWsXLujEnLVjCzNUsOJrl92LkUsTuAeT7ECXlfXY/UiEj6oqiTM+pArHt0KDuXYWS6wHRAuUwuNURdR6YDukThsFECwA4uiGpOuWzk/comyiv0uEepn6QOnYLdcfXcdVhDmCzJH3Nn2nDq2/wrcwScvgHcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQscbZ/6+mXASBxneJANWvmPus4bNyB8IEmS0L8F8c0=;
 b=pQOlw5wrqsUlt8ZZT5vw5pu+fFKt0aAj3iaQP9ZuGXTqUP6CM4c0AtuTq3pSEwtc72BPc7YBba32JaGlYLzoOL/O0kQlyNSFHlU0+BmO7yL7cn4qU+3yEdOZGnT8FamzFL8z2tIaksMcd41wQtgHEGYu+YHLhbPff1/M47VjDH8=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR11MB1692.namprd11.prod.outlook.com (2603:10b6:3:d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Thu, 5 Nov 2020 14:48:03 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18%7]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 14:48:03 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH v2 0/8] clk: at91: adapt for dvfs
Thread-Topic: [PATCH v2 0/8] clk: at91: adapt for dvfs
Thread-Index: AQHWs4KplaiO81PP/U6Bla1L1qoVSQ==
Date:   Thu, 5 Nov 2020 14:48:02 +0000
Message-ID: <6f8d8f2c-997c-7942-c894-319e8b96188f@microchip.com>
References: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1604511926-29516-1-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.124.22.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a59aa68-4a27-421f-e0c5-08d88199cc50
x-ms-traffictypediagnostic: DM5PR11MB1692:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB169225AA06378A2B4460B65187EE0@DM5PR11MB1692.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DqT/M9SbK6dTCn+0JwGXKdhpkPcaIV9gUB2fnZAkHSAoCmpuaA5VMrEAoRWH9suMQLKXWetxcqhTuBjj3qbAyRjdP3QkWb1oFpWuGt/Q7Ln+ILN03g5eAzw5R8I9HuuN7nZoaxiiEzxLoP6fLu026AddfK9yC6eNz+tF8b5pVkvNL2KZlnBeSWV1u6Qp/o638sobtgK8exfSiejMsOoWOGAKHVi7GiKPiJrWr3MLEx4g46uxcZSfijCCF2j8M4VLxFo3NSuXhJvpL/KErSA2bk8AdNS+gsf3QRW2NiFTR5RJM2DebN700RfCqFkxWIOv+5KTtsyRwNXb2J2bi/IyfV0aRr/Be9b1VGusazjBLV8JV4w1hjwuk7X6DnVDCo/G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(396003)(376002)(366004)(136003)(64756008)(6486002)(53546011)(66556008)(6506007)(76116006)(66946007)(66476007)(91956017)(83380400001)(8676002)(31696002)(8936002)(66446008)(6512007)(86362001)(2616005)(5660300002)(26005)(2906002)(31686004)(71200400001)(186003)(4326008)(54906003)(110136005)(478600001)(316002)(107886003)(36756003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5q2mY0HeHxprRACWqyqc0ppni/TiEkLMR80oZ4HseKQ8DDOr2qxbwP/XWZBcWETNb/gPwK9f31D35gMekHwFsb0qhrRmq/EY0I/qmOHVTTHFIno2tFg7T1yiaMH5P4QDfowXPUmiXMXgd8yMqRZlVssKS2W/1+etM6sB0dLGvUl9iYOuby1VyYr8FNktHkBN9XvC/AYiBIo5YN97g7lC87pQXdIq0eFV19KQGelBifcgJ1ldg4SBjSIkF7aQcYpctqERMkGdOievP3uso/UjTG3zQ2hJhYR2h3h24ju3nNea8ruPetJ1RB77HFM1rcNHGS9TvwXV67ucyuqt7qNe5yHBmOOs9+uyu/1HFsAJIMByxZUkOQE23ntLhansxUuCw6Bj3GjQmRe8k0vWWCjid8Azxs8YkPHJqHTfFHG473u1Hfo+nAmaRJyKq68mDbEEEmPQMk9af5jkBDFDkm9lDTROq8ytvFOCYSnQoeevL7tbZcj9wxwj5Ofx4IEJdC44eTl8ZfFNeTkke/uWIvjRgiDlcEY6Uo4WHneDlu4vJtkh/xqI3hnANQF+C1j5ceAtHMYXN/3m8nDKTi+Fj+JjLjleFNs4zbcX62XFNmrc0+b19fD/uC8wzSMh3oMrWKId2QA+ToF48rdTQuhBpi0qSw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6355AE09821B4244B321E48CD4E5B344@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a59aa68-4a27-421f-e0c5-08d88199cc50
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 14:48:02.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RhWd+kqRaOSmufgJJGqETTXmu/K3y/yipza08g1r6VZJOAzSUwYHgZ3GZbiVS9retMCkdQltOlrXFzO/GrnaAaKc0FnkJ06CoRlRJsceDr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1692
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClBsZWFzZSBpZ25vcmUgdGhpcyBzZXJpZXMgZm9yIHRoZSBtb21lbnQgYXMgSSB3aWxs
IGhhdmUgdG8gcnVuIGZldyBtb3JlDQp0ZXN0cyBvbiBpdC4gU29ycnkgZm9yIHRoZSBub2lzZSEN
Cg0KVGhhbmsgeW91LA0KQ2xhdWRpdSBCZXpuZWENCg0KT24gMDQuMTEuMjAyMCAxOTo0NSwgQ2xh
dWRpdSBCZXpuZWEgd3JvdGU6DQo+IEhpLA0KPiANCj4gU0FNQTdHNSBpcyBjYXBhYmxlIG9mIERW
RlMuIFRoZSBzdXBwb3J0ZWQgQ1BVIGNsb2NrIGZyZXF1ZW5jaWVzIGNvdWxkIGJlDQo+IG9idGFp
bmVkIGZyb20gQ1BVIFBMTC4gVGhlIGhhcmR3YXJlIGJsb2NrIGRpYWdyYW0gZm9yIGNsb2NrIGZl
ZWRpbmcgdGhlDQo+IENQVSBpcyBhcyBmb2xsb3dzOg0KPiANCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICstLS0tLS0tLSsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgKy0t
PnxkaXZpZGVyMXwtLT4gQ1BVIGNsb2NrDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICArLS0tLS0tLS0rDQo+ICstLS0tLS0tLSsgICArLS0tLS0tLS0tLSsgIHwgICArLS0tLS0tLS0r
DQo+IHxDUFUgUExMIHwtLT58cHJlc2NhbGxlcnwtLSstLT58ZGl2aWRlcjB8LS0+IE1DSzAgY2xv
Y2sNCj4gKy0tLS0tLS0tKyAgICstLS0tLS0tLS0tKyAgICAgICstLS0tLS0tLSsNCj4gDQo+IFdo
ZW4gc3dpdGNoaW5nIENQVSBjbG9jayBmcmVxdWVuY2llcyB0aGUgTUNLMCBpcyBhbHNvIGNoYW5n
ZWQgYnkgRFZGUw0KPiBkcml2ZXIgdG8gYXZvaWQgaXRzIG92ZXIvdW5kZXIgY2xvY2tpbmcgKGRl
cGVuZGluZyBvbiBDUFUgY2xvY2sgZnJlcXVlbmN5DQo+IHJlcXVlc3RlZCBieSBEVkZTIGFsZ29y
aXRobXMpLiBTb21lIG9mIElQcyBmZWVkIGJ5IE1DSzAgYXJlIE1DSzAgZ2xpY2gNCj4gYXdhcmUs
IHNvbWUgYXJlIG5vdC4gRm9yIHRoaXMgTUNLMCB3YXMgcmVtb3ZlZCBmcm9tIHRoZSBwYXJlbnRz
IGxpc3Qgb2YNCj4gdGhlIElQcyB3aGljaCBhcmUgbm90IE1DSzAgZ2xpdGNoIGF3YXJlIChwYXRj
aCA1LzgpLg0KPiANCj4gVGhpcyBzZXJpZXMgYWRhcHQgQVQ5MSBjbG9ja3MgKG1vc3RseSBzYW05
eDYwLXBsbCBhbmQgbWFzdGVyIGNsb2NrIGRyaXZlcnMpDQo+IHNvIHRoYXQgcnVudGltZSBjaGFu
Z2VzIG9mIHRoZXNlIGNsb2NrcyB0byBiZSBhbGxvd2VkLg0KPiANCj4gVGhlIENQVSBjbG9jayB3
YXMgcmVnaXN0ZXJlZCBmcm9tIHByZXNjYWxsZXIgY2xvY2sgKHNlZSBhYm92ZSBkaWFncmFtKQ0K
PiBhbmQgbm8gc29mdHdhcmUgY29udHJvbCBoYXMgYmVlbiBhZGRlZCBmb3IgZGl2aWRlcjEgYmVj
YXVzZSB0aGUgZnJlcXVlbmNpZXMNCj4gc3VwcG9ydGVkIGJ5IFNBTUE3RzUncyBDUFUgY291bGQg
YmUgZGlyZWN0bHkgb2J0YWluZWQgZnJvbSBDUFUgUExMICsNCj4gcHJlc2NhbGxlci4NCj4gDQo+
IE9uIHRvcCBvZiB0aGlzIHNlcmllcyBJIGFsc28gYWRkZWQgYSBmaXggZm9yIHNhbWE3ZzUuYyBj
b2RlIChwYXRjaCAxLzgpLg0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IHdvdWxkIGxpa2Ug
bWUgdG8gc2VuZCB0aGlzIG9uZSBzZXBhcnRlbHkgKGl0DQo+IHdvdWxkIGJlIG5pY2UgaWYgdGhp
cyBmaXggY291bGQgYmUgaW50ZWdyYXRlZCBpbiA1LjEwKS4NCj4gDQo+IFRoYW5rIHlvdSwNCj4g
Q2xhdWRpdSBCZXpuZWENCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gcy9hdDkxcm05MjAwX21j
a19sb2NrL2F0OTFzYW05MjYwX21ja19sb2NrIGluIHBhdGNoIDcvOA0KPiANCj4gQ2xhdWRpdSBC
ZXpuZWEgKDYpOg0KPiAgIGNsazogYXQ5MTogc2FtYTdnNTogZml4IGNvbXBpbGF0aW9uIGVycm9y
DQo+ICAgY2xrOiBhdDkxOiBjbGstc2FtOXg2MC1wbGw6IGFsbG93IHJ1bnRpbWUgY2hhbmdlcyBm
b3IgcGxsDQo+ICAgY2xrOiBhdDkxOiBzYW1hN2c1OiByZW1vdmUgbWNrMCBmcm9tIHBhcmVudCBs
aXN0IG9mIG90aGVyIGNsb2Nrcw0KPiAgIGNsazogYXQ5MTogc2FtYTdnNTogZGVjcmVhc2UgbG93
ZXIgbGltaXQgZm9yIE1DSzAgcmF0ZQ0KPiAgIGNsazogYXQ5MTogY2xrLW1hc3RlcjogcmUtZmFj
dG9yIG1hc3RlciBjbG9jaw0KPiAgIGNsazogYXQ5MTogc2FtYTdnNTogcmVnaXN0ZXIgY3B1IGNs
b2NrDQo+IA0KPiBFdWdlbiBIcmlzdGV2ICgyKToNCj4gICBkdC1iaW5kaW5nczogY2xvY2s6IGF0
OTE6IGFkZCBzYW1hN2c1IHBsbCBkZWZpbmVzDQo+ICAgY2xrOiBhdDkxOiBzYW1hN2c1OiBhbGxv
dyBTWVMgYW5kIENQVSBQTExzIHRvIGJlIGV4cG9ydGVkIGFuZA0KPiAgICAgcmVmZXJlbmNlZCBp
biBEVA0KPiANCj4gIGRyaXZlcnMvY2xrL2F0OTEvYXQ5MXJtOTIwMC5jICAgICAgfCAgMjAgKyst
DQo+ICBkcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05MjYwLmMgICAgIHwgIDI0ICsrLQ0KPiAgZHJp
dmVycy9jbGsvYXQ5MS9hdDkxc2FtOWc0NS5jICAgICB8ICAzMCArKy0tDQo+ICBkcml2ZXJzL2Ns
ay9hdDkxL2F0OTFzYW05bjEyLmMgICAgIHwgIDM0ICsrLS0NCj4gIGRyaXZlcnMvY2xrL2F0OTEv
YXQ5MXNhbTlybC5jICAgICAgfCAgMjIgKystDQo+ICBkcml2ZXJzL2Nsay9hdDkxL2F0OTFzYW05
eDUuYyAgICAgIHwgIDI3ICsrKy0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvY2xrLW1hc3Rlci5jICAg
ICAgfCAzMjMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgZHJpdmVy
cy9jbGsvYXQ5MS9jbGstc2FtOXg2MC1wbGwuYyB8IDEwMiArKysrKysrKysrLS0NCj4gIGRyaXZl
cnMvY2xrL2F0OTEvZHQtY29tcGF0LmMgICAgICAgfCAgMTUgKy0NCj4gIGRyaXZlcnMvY2xrL2F0
OTEvcG1jLmggICAgICAgICAgICAgfCAgMjAgKystDQo+ICBkcml2ZXJzL2Nsay9hdDkxL3NhbTl4
NjAuYyAgICAgICAgIHwgIDM1ICsrLS0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMi5jICAg
ICAgICAgfCAgNDEgKysrLS0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkMy5jICAgICAgICAg
fCAgMzcgKysrLS0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTVkNC5jICAgICAgICAgfCAgMzkg
KysrLS0NCj4gIGRyaXZlcnMvY2xrL2F0OTEvc2FtYTdnNS5jICAgICAgICAgfCAxMzkgKysrKysr
KysrLS0tLS0tLQ0KPiAgaW5jbHVkZS9kdC1iaW5kaW5ncy9jbG9jay9hdDkxLmggICB8ICAxMSAr
Kw0KPiAgMTYgZmlsZXMgY2hhbmdlZCwgNjkyIGluc2VydGlvbnMoKyksIDIyNyBkZWxldGlvbnMo
LSkNCj4g
