Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D012B79D0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgKRI6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:58:45 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49126 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRI6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:58:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605689923; x=1637225923;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wNH6dWwa/adS2pNA+hybt3c11A0A1UW76Jvh8B6vIJc=;
  b=Yrfqy0kqkeDcAmcVJd2F97A/aSyU8bBo4eSSsBixfkpxvs7i2KN9Q2uk
   WXCa17lMFtUvuiNyiy16cT69FWdI4kEccqJBimt4UjkUoD3WONl9bvTFU
   2B/Wam5q0eY9HeRkCDGuVeKJQMGxLQyRbLZM8bQhN1WLMz+gxVUwRo3u1
   Of7iBe78e5m1Apt03wToRaZ/mVYMAx8nVJYp/Lc+Mayt3ITCoXBJTtejc
   SQZvK+bYVKtSvjFartiz8UmF/l8F6j/zDZUxjNWYNjSO9fMlFGyodwlhm
   BeZ20pEZwtr9ihGcO5VnZR6BI2DYZoHh9lj7JNutGBdVKDWSN+Q5xv5xb
   w==;
IronPort-SDR: GEiDqWS4VrP7m6riMCoiBom5UzEHzF8/74nj0yq1XWh5yiPeAspJYy+mOjNy/zUbqHnWIq+xbY
 ZN/27mv6jk8KZ1WU23A9/jflG3W0NEVemK6cMgMncghVCBXjZCuGkbIDJ14gsxHQnNekgwaZlK
 Rk0i/gO8NxHd2CNceJZ+qbl50pyBe0J1Itj7Li7D6acPZfWyS1K7cSRTw/JMNhvLzI/m7tIxu1
 6Wn94bStfWadV0FouUv+BQTNSAu1gjx3obbofoFU7mB6rTuv4zJfGWJ14nq1msFSJDT0QHw7tK
 9aY=
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="104002916"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2020 01:58:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 01:58:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 18 Nov 2020 01:58:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQOJSskTw+sx3XPmRqw2asRO6qMWW2w+q2Z6xxgSJKBHCF85NluTq/Y3p7y89jlObhzgEzEvkGOXgamNivmupFjWNM63T4WC33zs/+lEZAOv7FcZKOqD4cihVXa6CbkI9BPQE7n5x4rosbVcpnzRf4NIZPq2OKg2r5F4exkAqBQx5fRBaldymY5G/9k5Aq5Ec+OJ4qnqOdv/EEsktlutuUtks+crBNtUzYdyE2FxGVfPFLhEph/gtSNoWLWsBcAfMjqCC1MU2i8eyGtVrmTMO45h5fDbvjySKYW6W0SydcIR0sSXuIMAkpmfOpjrud/OPavyyyacllyGt3fw71iimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNH6dWwa/adS2pNA+hybt3c11A0A1UW76Jvh8B6vIJc=;
 b=GXjflSOYV7oKkyUC9rOgSUN/O3mJv9F/KSZy+2RNsyR+B0mJUuYUZt0AV6JNWb/OKi3xVfksT3TBjZbJsg911+af9gxmlez2CfMUB5iTqWBy0M1eb5Y4TfEc2rdX7W5rspJzaJUEiIAs34KFfjNwVV4p4fgJgsVHPg/6FRu5ADPt8x4F2VD1clbQgiORzjvcCT/Ik/ap/XQ5EU5g6Ar4Qde8xlh7IpzVxaKBIOspldckdl6FCyCnMaUIr2exks/DflutxMaur9ZEIRbU9nWAY0MKblTwvJ4pdiFYALZ+6HP/I4WI6QEfxmUC4OK78lpLk9i8H9fgbFQm62pcPy+vBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNH6dWwa/adS2pNA+hybt3c11A0A1UW76Jvh8B6vIJc=;
 b=V6zkbJiaAZGFwjascXmNfC0opjG/Y72/H3K+h/NtzYgdwSxBpBp1z9fp7tcJorMPQMuM1gWn6sWhzev6GjlvepAYjjqQAG+j9QH8MS1EMInb7bpFnOEoWvVyO4gxaZ5Y6c8MzCDW6zSOA6+5+PpUOuTmA9tWBrnIMUZMnxDp99I=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (20.177.218.95) by
 DM5PR1101MB2108.namprd11.prod.outlook.com (10.174.105.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Wed, 18 Nov 2020 08:58:41 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::f983:dc6d:ad81:9e18%7]) with mapi id 15.20.3589.021; Wed, 18 Nov 2020
 08:58:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sboyd@kernel.org>, <Ludovic.Desroches@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <mturquette@baylibre.com>, <robh+dt@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 06/11] clk: at91: clk-sam9x60-pll: allow runtime
 changes for pll
Thread-Topic: [PATCH v4 06/11] clk: at91: clk-sam9x60-pll: allow runtime
 changes for pll
Thread-Index: AQHWvAsXdqHXVxqoU0quyuo4xeR8ew==
Date:   Wed, 18 Nov 2020 08:58:40 +0000
Message-ID: <354a80e9-d072-bd75-daa3-fa0f66c9415f@microchip.com>
References: <1604655988-353-1-git-send-email-claudiu.beznea@microchip.com>
 <1604655988-353-7-git-send-email-claudiu.beznea@microchip.com>
 <160538849947.60232.12002724470272520124@swboyd.mtv.corp.google.com>
 <24d975ca-1942-5f7f-ae89-7b572f48812c@microchip.com>
 <160566417078.60232.18106288530854376790@swboyd.mtv.corp.google.com>
In-Reply-To: <160566417078.60232.18106288530854376790@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.124.22.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68033ac9-799c-471d-750e-08d88ba02558
x-ms-traffictypediagnostic: DM5PR1101MB2108:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB21082DB6A2B8A6729B13AC8187E10@DM5PR1101MB2108.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8rDd6l0ubreQz8r8utgvv9AJJGkUy6HNu1+3/CSiMogOoHEORZxbtE694dhqP/o1TvIQ0m8cveA1fh+xOQ4cBDbnuBe893e5tpQExvxgXxfs7Ohe8LFn+4TIzXSAyCFj5At6RRYJLKgrMjD1JYTqcnEmU+C9ya342t4eJQCqq6p//7YckepnfTlUaAiQ0xzmNeaKEIeeyqQFttdtwNU5+IiAJakGndaN1g32pgJvp1YPKTaGAGTMtEucN+z1M1iSKbRELpLK1grRGvLoydv16S2c4w2a/FYN0MH4KS7qp5iDJ0E1WVSZQMX3ZitAal1hFeXOTYzCZ1sjcewushe6OKf2TyLSlWjSYAO6h8WpCGCDS33TMyz3aoW/OEtqvFB9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(376002)(396003)(366004)(2906002)(54906003)(31696002)(6506007)(53546011)(36756003)(5660300002)(66946007)(4326008)(83380400001)(31686004)(4001150100001)(2616005)(478600001)(186003)(110136005)(316002)(8676002)(26005)(8936002)(6512007)(86362001)(6486002)(71200400001)(66446008)(66476007)(76116006)(66556008)(64756008)(91956017)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Yn8roq1vcGGJtdy2zy6Yp8l3ep3n/H/lmf94Tg90J57Yz6n9RKUp6yjysKyg/D3hovEzWjuadabN2wEpvFN/zMks5Z+Zz0XU/Tj/sjJ4uvijUEI6egXToxMFqW/sCzL+P06RHP6zJofiqKWzdeYdEJXnyK5LSlZ6aHcVk7+QLgetPdm2F6r4u5RJ17a7gBeNeXGk4qOULMmq774kApA5IGODqjwhaxFt1rR3QEniTB+OS/IuEDWxmZnc2RNxJ8OSrDFu0ikpKJ6Vgi2eqHz4Qxll+1BCuuwrVHgtgRd5V5BWRZRvn3GOsjdnz0FUwU4ZtCSWxmLD45RbyCarWY+u5eUMBtF+pYoT3lJ14/OVYYil2IQilYJysr42/zqKKOY4+BPlRWU3nSMt5Z0Wps7bJWZIkTxaiWAMN0GiST9X9PBM2N75VKUl14Nlm9vn3HlCjDSoNB+i3EiYixYCHRVPT/L2Q9/xyMUZPEw97TD0Qxxxp+Ot8KruzC9WG6nigr6hIrQs7OvMIyYiNOGJjxloc1PS/HtyJfZ4c+gH+BnN6A2cpO8JSPTOo+BqnK3ArFSrR8zq/9J4ZAPsRn8+tbMd9ozaJuY2FUYcz84K+Fg3ffb2twk1/REZquHssbPtpRt7y5lGwLCL1LqFYbzua/uKVMrHj1xahRf2gt1i268yTqR6YumZoyxupGxvud6wUmFjR7L8Da9LxW7vEzjzPSdG3kxkbVCJom6YHxpnAMKLRvkHuDuM158QlzCqOdSm5UhtQDTXnYw+U2ztG7lItlw3tnh2+Q7g1nP1FfNbB6ghTVbSgzNl8TpLRCovlKyMN/3shfc7kKzYjq2ttfBwRuc8HkWnHRiqHc3ZTBv9OaHF86c8pFApPeJkGJ6ggywdhwVnpVwGQU+cw+pGvlWtUH3C4g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <58134C7DBA12704CB9D4D9AA8148DEB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68033ac9-799c-471d-750e-08d88ba02558
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 08:58:40.9648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mszR1l55hosCRqxZdoCHBNqbdlsj/adpaN9NaXWeKKTT+TyVy+w5SH8+9Fc7+09SoxNV3gfpFnEShZSopJ7U2nnYH6FubUQEYCVEnixUdWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LjExLjIwMjAgMDM6NDksIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBRdW90aW5nIENsYXVkaXUuQmV6bmVhQG1p
Y3JvY2hpcC5jb20gKDIwMjAtMTEtMTYgMDM6MjQ6NTQpDQo+Pg0KPj4NCj4+IE9uIDE0LjExLjIw
MjAgMjM6MTQsIFN0ZXBoZW4gQm95ZCB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250
ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IFF1b3RpbmcgQ2xhdWRpdSBCZXpuZWEgKDIwMjAtMTEtMDYg
MDE6NDY6MjMpDQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hdDkxL2Nsay1zYW05eDYw
LXBsbC5jIGIvZHJpdmVycy9jbGsvYXQ5MS9jbGstc2FtOXg2MC1wbGwuYw0KPj4+PiBpbmRleCA3
OGY0NThhN2IyZWYuLjZmZTVkODUzMGEwYyAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy9jbGsv
YXQ5MS9jbGstc2FtOXg2MC1wbGwuYw0KPj4+PiArKysgYi9kcml2ZXJzL2Nsay9hdDkxL2Nsay1z
YW05eDYwLXBsbC5jDQo+Pj4+IEBAIC0yMjUsOCArMjI1LDUxIEBAIHN0YXRpYyBpbnQgc2FtOXg2
MF9mcmFjX3BsbF9zZXRfcmF0ZShzdHJ1Y3QgY2xrX2h3ICpodywgdW5zaWduZWQgbG9uZyByYXRl
LA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgbG9u
ZyBwYXJlbnRfcmF0ZSkNCj4+Pj4gIHsNCj4+Pj4gICAgICAgICBzdHJ1Y3Qgc2FtOXg2MF9wbGxf
Y29yZSAqY29yZSA9IHRvX3NhbTl4NjBfcGxsX2NvcmUoaHcpOw0KPj4+PiArICAgICAgIHN0cnVj
dCBzYW05eDYwX2ZyYWMgKmZyYWMgPSB0b19zYW05eDYwX2ZyYWMoY29yZSk7DQo+Pj4+ICsgICAg
ICAgc3RydWN0IHJlZ21hcCAqcmVnbWFwID0gY29yZS0+cmVnbWFwOw0KPj4+PiArICAgICAgIHVu
c2lnbmVkIGxvbmcgaXJxZmxhZ3MsIGNsa2ZsYWdzID0gY2xrX2h3X2dldF9mbGFncyhodyk7DQo+
Pj4+ICsgICAgICAgdW5zaWduZWQgaW50IHZhbCwgY2ZyYWMsIGNtdWw7DQo+Pj4+ICsgICAgICAg
bG9uZyByZXQ7DQo+Pj4+ICsNCj4+Pj4gKyAgICAgICByZXQgPSBzYW05eDYwX2ZyYWNfcGxsX2Nv
bXB1dGVfbXVsX2ZyYWMoY29yZSwgcmF0ZSwgcGFyZW50X3JhdGUsIHRydWUpOw0KPj4+PiArICAg
ICAgIGlmIChyZXQgPD0gMCB8fCAoY2xrZmxhZ3MgJiBDTEtfU0VUX1JBVEVfR0FURSkpDQo+Pj4N
Cj4+PiBJcyB0aGlzIGZ1bmN0aW9uIGJlaW5nIGNhbGxlZCB3aGVuIHRoZSBjbGsgaXMgZW5hYmxl
ZCBhbmQgaXQgaGFzIHRoZQ0KPj4+IENMS19TRVRfUkFURV9HQVRFIGZsYWcgc2V0Pw0KPj4NCj4+
IFllcywgdGhpcyBmdW5jdGlvbiBjb3VsZCBiZSBjYWxsZWQgd2hlbiBDTEtfU0VUX1JBVEVfR0FU
RSBpcyBzZXQuDQo+PiBPbiBTQU1BN0c1IHRoZXJlIGFyZSBtdWx0aXBsZSBQTEwgYmxvY2tzIG9m
IHRoZSBzYW1lIHR5cGUuIEFsbCB0aGVzZSBQTExzDQo+PiBhcmUgY29udHJvbGxlZCBieSBjbGst
c2FtOXg2MC1wbGwuYyBkcml2ZXIuIE9uZSBvZiB0aGlzIFBMTCBibG9jayBmZWQgdGhlDQo+PiBD
UFUgd2hvJ3MgZnJlcXVlbmN5IGNvdWxkIGJlIGNoYW5nZWQgYXQgcnVuIHRpbWUuIEF0IHRoZSBz
YW1lIHRpbWUgdGhlcmUNCj4+IGFyZSBQTExzIHRoYXQgZmVkIGhhcmR3YXJlIGJsb2NrIG5vdCBn
bGl0Y2ggZnJlZSBhd2FyZSBvciB0aGF0IHdlIGRvbid0DQo+PiB3YW50IHRvIGFsbG93IHRoZSBy
YXRlIGNoYW5nZSAodGhpcyBpcyB0aGUgY2FzZSBvZiBTQU05WDYwJ3MgQ1BVIFBMTCwgb3INCj4+
IHRoZSBERFIgUExMIG9uIFNBTUE3RzUpLg0KPj4NCj4+IEknbSBjb25mdXNlZCB3aHkgdGhpcyBk
cml2ZXIgbmVlZHMgdG8gY2hlY2sNCj4+PiB0aGlzIGZsYWcuDQo+Pg0KPj4gQmVjYXVzZSB3ZSBo
YXZlIG11bHRpcGxlIFBMTHMgb2YgdGhlIHNhbWUgdHlwZSwgc29tZSBvZiB0aGVtIGZlZWQgaGFy
ZHdhcmUNCj4+IGJsb2NrcyB0aGF0IGFyZSBnbGl0Y2ggZnJlZSBhd2FyZSBvZiB0aGVzZSBQTExz
JyBmcmVxdWVuY2llcyBjaGFuZ2VzLCBzb21lDQo+PiBmZWVkIGhhcmR3YXJlIGJsb2NrcyB0aGF0
IGFyZSBub3QgZ2xpdGNoIGZyZWUgYXdhcmUgb2YgUExMcycgZnJlcXVlbmNpZXMNCj4+IGNoYW5n
ZXMgb3IgZm9yIHNvbWUgb2YgdGhlbSB3ZSBkb24ndCB3YW50IHRoZSBmcmVxdWVuY3kgY2hhbmdl
cyBhdCBhbGwuDQo+IA0KPiBDYW4gd2UgaGF2ZSBkaWZmZXJlbnQgY2xrX29wcyBmb3IgdGhlIGRp
ZmZlcmVudCB0eXBlcyBvZiBQTExzPw0KDQpTdXJlISBJJ2xsIHN3aXRjaCB0byB0aGlzIHdheS4N
Cg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLA0KQ2xhdWRpdSBCZXpuZWENCg0KPiBJdCBs
b29rcw0KPiBsaWtlIHRoZSBmbGFnIGlzIGJlaW5nIHVzZWQgdG8gb3ZlcmxvYWQgdGhpcyBmdW5j
dGlvbiB0byBkbyBkaWZmZXJlbnQNCj4gdGhpbmdzIGRlcGVuZGluZyBvbiBob3cgdGhlIGZsYWdz
IGFyZSBzZXQuIFdoYXQgaGFwcGVucyBpZiB3ZSBkZWNpZGUgdG8NCj4gY2hhbmdlIHRoZSBzZW1h
bnRpY3Mgb2YgdGhpcyBjbGsgZmxhZz8gSG93IGRvZXMgaXQgbWFwIHRvIHRoaXMgZHJpdmVyPw0K
PiBJZGVhbGx5IHRoaXMgZHJpdmVyIHNob3VsZG4ndCBuZWVkIHRvIHdvcnJ5IGFib3V0IHRoaXMg
ZmxhZywgYXQgbGVhc3QNCj4gbm90IGluIHRoaXMgZnVuY3Rpb24sIGV4Y2VwdCB0byBmaWd1cmUg
b3V0IGlmIGl0IHNob3VsZCBkbyBzb21ldGhpbmcNCj4gZGlmZmVyZW50IGxpa2Ugbm90IHdyaXRl
IHRoZSB2YWx1ZSB0byB0aGUgaGFyZHdhcmUgb3Igc29tZXRoaW5nIGxpa2UNCj4gdGhhdC4NCj4g
DQo+IFRoZSBmbGFnIGluZGljYXRlcyB0byB0aGUgY2xrIGZyYW1ld29yayB0aGF0IHRoaXMgY2xr
IHNob3VsZCBiZSBnYXRlZA0KPiB3aGVuIGNsa19zZXRfcmF0ZSgpIGlzIGNhbGxlZCBvbiBpdC4g
VGhlIGRyaXZlciBzaG91bGQgYmUgYWJsZSB0byBmaWd1cmUNCj4gb3V0IHRoYXQgdGhlIGNsayBp
cyBkaXNhYmxlZCBieSByZWFkaW5nIHRoZSBoYXJkd2FyZSBoZXJlIGFuZCBjaGVja2luZw0KPiB0
aGUgZW5hYmxlIHN0YXRlLCBvciBpdCBjb3VsZCBqdXN0IGhhdmUgZGlmZmVyZW50IGNsa19vcHMg
Zm9yIHRoZQ0KPiBkaWZmZXJlbnQgdHlwZSBvZiBQTEwgYW5kIGRvIHNvbWV0aGluZyBkaWZmZXJl
bnQgd2l0aG91dCBjaGVja2luZyB0aGUNCj4gZmxhZy4gRWl0aGVyIHdheSwgY2hlY2tpbmcgdGhl
IGZsYWcgbG9va3Mgd3JvbmcuDQo+IA0KPj4+PiAtICAgICAgICAgICAgICAgICAuYyA9IDEsDQo+
Pj4+ICsgICAgICAgICAgICAgICAgIC5mID0gQ0xLX0lTX0NSSVRJQ0FMIHwgQ0xLX1NFVF9SQVRF
X0dBVEUsDQo+Pj4NCj4+PiBQbGVhc2UgaW5kaWNhdGUgd2h5IGNsa3MgYXJlIGNyaXRpY2FsLg0K
Pj4NCj4+IFN1cmUhIEknbGwgZG8gaXQgaW4gbmV4dCB2ZXJzaW9uLiBJIGNob3NlIGl0IGxpa2Ug
dGhpcyBiZWNhdXNlIHRoZXkgYXJlDQo+PiBmZWVkaW5nIGNyaXRpY2FsIHBhcnRzIG9mIHRoZSBz
eXN0ZW0gbGlrZSBDUFUgb3IgbWVtb3J5Lg0KPj4NCj4+PiBXaGVuZXZlciB0aGUgQ0xLX0lTX0NS
SVRJQ0FMIGZsYWcNCj4+PiBpcyB1c2VkIHdlIHNob3VsZCBoYXZlIGEgY29tbWVudCBpbmRpY2F0
aW5nIHdoeS4NCj4+DQo+PiBJIHdhcyBub3QgYXdhcmUgb2YgdGhpcyBydWxlLiBJJ2xsIHVwZGF0
ZSB0aGUgY29kZSBhY2NvcmRpbmdseS4NCj4gDQo+IFNvcnJ5LiBJIHNob3VsZCBwdXQgYSBkb2N1
bWVudCBjb21tZW50IG5leHQgdG8gdGhlIGZsYWcuDQo+IA==
