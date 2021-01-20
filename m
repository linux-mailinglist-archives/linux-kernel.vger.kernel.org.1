Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9047A2FD63F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391678AbhATQ6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:58:23 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:1587 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391700AbhATQ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:58:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611161882; x=1642697882;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rFyJXDctDB9ZudqLm04JYxZWYVgg6uhDF2UT9V2HeQw=;
  b=spqVKrGyLG1w2o/b63xnL9C2NmSpwBLpcECPL0SlV7G5ltAqqofx5sA8
   neKD15dicGyzdfqKTz+gf2G2XmANWMCGBLAX9wF7UG3NdOs8Jqw7NX3Ka
   PVo6/SqMj9X48XXexf8Tb4Q9KybqAR2QpGtL17mrnslO7WPfCw0gZIPbt
   +D29Bc4bGMkKCVWlDJpnOq/PNnVoKSYevg8Mty1U1IvqVtg8w9m9/8wH+
   QDiEMAbCSWiJFTytBlUxpyeCq2rY8ip1uj/FlzIkEHzws/Kd10xAeVnBj
   h6jPjEk5gQhrOsWc1+CDO/2JR+Cbni7JGgXV4VEU9mXfB1IyHyE55FjzJ
   g==;
IronPort-SDR: CEgDedjG85mBQ6/kAxt3CJhIZ04YiCEhRm4lCp1WvV8TCLO962SLUPw2gibw5O52AM+bEHvYJy
 Wyqy5FdL30jcqHiJOeCkU9rVpAbAU7khsBOSDCT2gqvf4qp197G0sqnTRuLNPxD7Jy8hXE/hyt
 5BlQjXQoFxoa6sR9OJ0GK/2KNOW0UmK0p7Pby8w4HHz6YsQbK1SYV2oLMS99RbOyYBAtxhUscS
 7FwLyDWTPXwnoD751YBgMZEX+rKIhzyZtww2TOEjXUNDpBn+X7EMzXCHLhzFh5qxXe5MbEE8RE
 HiU=
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="111795913"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 09:56:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 09:56:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 20 Jan 2021 09:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A13D8OCkNhfik2RiAewdXjcDamC7QREP1MTBgMKZN5D71K41n3duSvibkPfBn6tOOPHY4BYSzAfZyqij6NMPS8A7/J3Vwbzcs5M6IozzZ5l5+u0tO19auxOGcetwH4GmVCwAUf/RWoQjgfO6XhB12PyYTIW3pC3MsYidw7+m2nEKcBm4SjPxG0q8g0tkajNnaKs08sMfRRUacjD1cthqHDQ0m0erhj+16ESa0/EtEOCfJHZo1Uwibm05OllJZEUWTWEICqM3T7m83ycjj4YupCvFhZV10ENT8sdWr83Gsxrmc6vDNrXQ/FDZkSiwJbW3q9qe1A0E5GSKIkl0R9sgzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFyJXDctDB9ZudqLm04JYxZWYVgg6uhDF2UT9V2HeQw=;
 b=VbMT1ckdHJ4Xp58aQXrrhk65xpfvGIno6cukQ56hO4ah6QejLABADRaIxNIOpl8fHG+G/XZ+whMRISHSS2GhA/UU9h9s6Gm7OPzCGeSWLilXM2eUnpO2i5wlQyyl+hxdY9zpq7geEF9GGvEGKPNVtUwgYPHQOrNDXzNERAjVTsG14bWUUIYaGTEHc8vdM/SwO52SK3S/o7RQnVTCntTEwBOVzVo33JoOKJ5wPT9aZ2usxUq7q29BbWm8hGZZrCQ871aiDfWjvDbzwi5hx4f+kA5YLTGZKEjgiwBadGVVhgeP+8Gscl7PeNZx5dBr3ag4GwXK2J510vm3d6yKAEK2Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFyJXDctDB9ZudqLm04JYxZWYVgg6uhDF2UT9V2HeQw=;
 b=h5V/790NFGPBuVdJOzadwRKlu1JArOUHSbBQLIbYeCMJ9n3lnCB5E15W7bLt4utGJ5yXhU6wlmZNjZkuWdAvWAiuj45LB9ES3k8cKX8ps2vKS8tXrE7CEAi3C/2/WcqV8TdOf6ccjcEiKv6xHIl5bG2sAy1VLIX05F/ysGGt2xs=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SN6PR11MB2829.namprd11.prod.outlook.com (2603:10b6:805:62::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 16:56:27 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 16:56:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <vigneshr@ti.com>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock
 on sst26vf
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock
 on sst26vf
Thread-Index: AQHW7zvWbgOMYI+QzkWXPBRNkt6zcg==
Date:   Wed, 20 Jan 2021 16:56:27 +0000
Message-ID: <a9bddf44-3a7f-b701-a4dd-030818b68f5a@microchip.com>
References: <20210120131914.277363-1-tudor.ambarus@microchip.com>
 <20210120131914.277363-2-tudor.ambarus@microchip.com>
 <b3a61abec8927c7229c27415d2c769a8@walle.cc>
 <ad0cc416-73b7-f626-115f-d192fac17957@microchip.com>
 <447aca9c61a45b05f7869b9747e2c301@walle.cc>
 <8a0e7885-4b9e-be62-eb46-1af74c65afa8@microchip.com>
 <e1e5f647fd9e91538fd730c626beff52@walle.cc>
 <6c4adaa7-9397-2373-16aa-a3dd2775c63f@microchip.com>
 <c62393288e9d82b08d14d74a9a8389ad@walle.cc>
In-Reply-To: <c62393288e9d82b08d14d74a9a8389ad@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5aedd88-6095-4145-aa56-08d8bd645410
x-ms-traffictypediagnostic: SN6PR11MB2829:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2829150CF29237BEE5BA076BF0A29@SN6PR11MB2829.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /F2vwUwDbXWT9AtTCKf2P9AxdmFpwxfnED7Md3F7bnMlPOriiS9y02OsaVsGF0YpKv2eTL7GqN0GIYlt3cga4RwUHdXUlvfFGiCFhZTsm70vtObzigkOFTo7yI7/KOd2gvU3ru50ZTeZdTlW+WCoOnry8V5KdiGq5/d444Iec4+kO6R6VSE+/FKTs0WcrVrIm/+V2xxXER3uvXX7qX/gMNVp8yF2hQB3N1/ZSC4jZ3l3+CNyC9lQl7AlJTlHsppsn0SA0zsa1ZgsfAWPZehtUP2ztmUsA29C2icuJ5FjzE8OEiTJT2mIxS/LM0WUEHH68F4W4O1AA4WGfx4DHKv5Y4MApKNOQAcsIYUz5D5O79hG9t8G69gwGwvuxP8ncZbyXBNmnRD3wDcos7oTnf6SIcV+m9DBEaQzjmruE7Nx8wBqvC0IhPjSel6izmGBX33jPgvfi3j06wbX6ddutBtU8OELpcvLBVblLJ+Oc/aXmYw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(366004)(136003)(53546011)(8936002)(71200400001)(36756003)(2616005)(107886003)(316002)(4326008)(54906003)(66556008)(8676002)(5660300002)(26005)(66446008)(66476007)(186003)(66946007)(64756008)(76116006)(91956017)(6916009)(6506007)(478600001)(86362001)(31696002)(31686004)(6486002)(83380400001)(2906002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MyysKxiz6TU0BAmKmMlYoRFhcRQgsqd2YqpqOfk+jyBG0R7k2akPEWMuGmgfQMJN1WulbLO+ezvjujpGSwgkHWP/mup2zlaew58cJUpyACyIQzYKunCbHH6ZogKPBH3tzsZogDM5MslggkbTpfcNYthkbL5SkdZGLKpmS/twl8xuqe63nVCmo8lAQUF/0uNvkq+RxiY9KnvQ3uUmmhxtKB4kfZPTNFdaVtNfB7X99tyYLr8VL2N13Rrcfr2VEkyvYw/GJK5sQGnlhdLekg4640xxm00dft9tZ/bHBNhnmqBp7N6t4XQYFR2chLJpkJlJHntsJGtmtBCHIEz8oK1csYWKg9rcoJZk9EWo25mtwwC1UED4GgWqPmDoNyV4L/+SOFJ2mTWa19h6AG6YdZHO6WCsnqAdVWUwktzSmZRhmAqbsLFb5pvnLudZ5LjGoe20arlx7F8n8ZD76qNYPHOpIfoogfH+upbQnvdQyDHlz7ccLOIL7a3GcsCtTQMn7atdWrsKK9NdHcvi4bRq+5CJqOwI3xTOVxpW9CxdRy9h9pDUmhU/JYFQ+NZq+wiha96Y9eUutFK7I6Es6/7AtkXpMdFHPI1MNQ/xSi0IkokfoInM5ur9sxJEJO8+rOE1jTScF3cCHTTbQe3z88GXUh8aqU6EP2D46FzvpFtetDXzWFECNiLvFRCo/3I6RNGftpGcTgpWKWUuO19ECTF3upEnM+i9se4fur5ZmPmuafyj5To=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C706790F8EBB1B4D95F8AB88C96CFB7E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5aedd88-6095-4145-aa56-08d8bd645410
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 16:56:27.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BIve3ywhoUj3FkOu4fsfOIuPFBAHFwDGkKym9MpjHFeOywh0qlgSJz8//V6y6j35pafAjEVu3hFRfXmVPREV6GSZFPyR1uz3aJTqBL+ziDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2829
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMC8yMSA2OjQ3IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFtIDIwMjEtMDEtMjAgMTc6MjUsIHNjaHJpZWIg
VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4gT24gMS8yMC8yMSA1OjQ5IFBNLCBNaWNo
YWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pj4NCj4+PiBBbSAyMDIxLTAxLTIwIDE2OjM5LCBzY2hyaWViIFR1ZG9yLkFtYmFydXNA
bWljcm9jaGlwLmNvbToNCj4+Pj4gT24gMS8yMC8yMSA1OjAyIFBNLCBNaWNoYWVsIFdhbGxlIHdy
b3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4+Pj4+IGtub3cNCj4+Pj4+IHRoZSBjb250ZW50IGlzIHNh
ZmUNCj4+Pj4+DQo+Pj4+PiBBbSAyMDIxLTAxLTIwIDE1OjUyLCBzY2hyaWViIFR1ZG9yLkFtYmFy
dXNAbWljcm9jaGlwLmNvbToNCj4+Pj4+PiBPbiAxLzIwLzIxIDQ6MDUgUE0sIE1pY2hhZWwgV2Fs
bGUgd3JvdGU6DQo+Pj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zc3Qu
Yw0KPj4+Pj4+Pj4gYi9kcml2ZXJzL210ZC9zcGktbm9yL3NzdC5jDQo+Pj4+Pj4+PiBpbmRleCAw
MGU0OGRhMDc0NGEuLmQ2ZTEzOTZhYmI5NiAxMDA2NDQNCj4+Pj4+Pj4+IC0tLSBhL2RyaXZlcnMv
bXRkL3NwaS1ub3Ivc3N0LmMNCj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3N0
LmMNCj4+Pj4+Pj4+IEBAIC04LDYgKzgsMzkgQEANCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiDCoCNpbmNs
dWRlICJjb3JlLmgiDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gK3N0YXRpYyBpbnQgc3N0MjZ2Zl9sb2Nr
KHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCBvZnMsDQo+Pj4+Pj4+PiB1aW50NjRfdA0KPj4+
Pj4+Pj4gbGVuKQ0KPj4+Pj4+Pj4gK3sNCj4+Pj4+Pj4+ICvCoMKgwqDCoCByZXR1cm4gLUVPUE5P
VFNVUFA7DQo+Pj4+Pj4+PiArfQ0KPj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4gK3N0YXRpYyBpbnQgc3N0
MjZ2Zl91bmxvY2soc3RydWN0IHNwaV9ub3IgKm5vciwgbG9mZl90IG9mcywNCj4+Pj4+Pj4+IHVp
bnQ2NF90DQo+Pj4+Pj4+PiBsZW4pDQo+Pj4+Pj4+PiArew0KPj4+Pj4+Pj4gK8KgwqDCoMKgIGlm
IChvZnMgPT0gMCAmJiBsZW4gPT0gbm9yLT5wYXJhbXMtPnNpemUpDQo+Pj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzcGlfbm9yX2dsb2JhbF9ibG9ja191bmxvY2sobm9y
KTsNCj4+Pj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU29tZSBibG9ja3MgbWlnaHQgbm90IGJlIHVu
bG9ja2VkIGJlY2F1c2UgdGhleSBhcmUgcGVybWFuZW50bHkNCj4+Pj4+Pj4gbG9ja2VkLiBEb2Vz
IGl0IG1ha2Ugc2Vuc2UgdG8gcmVhZCBCUE5WIG9mIHRoZSBjb250cm9sIHJlZ2lzdGVyDQo+Pj4+
Pj4+IGFuZCBhZGQgYSBkZWJ1ZyBtZXNzYWdlIGhlcmU/DQo+Pj4+Pj4NCj4+Pj4+PiBJdCB3b3Vs
ZCwgeWVzLiBJZiBhbnkgYmxvY2sgaXMgcGVybWFuZW50bHkgbG9ja2VkIGluIHRoZSB1bmxvY2tf
YWxsDQo+Pj4+Pj4gY2FzZSwNCj4+Pj4+PiBJJ2xsIGp1c3QgcHJpbnQgYSBkYmcgbWVzc2FnZSBh
bmQgcmV0dXJuIC1FSU5WQUwuIFNvdW5kcyBnb29kPw0KPj4+Pj4NCj4+Pj4+IHNwaV9ub3Jfc3Jf
dW5sb2NrKCksIGF0bWVsX2F0MjVmc191bmxvY2soKSBhbmQNCj4+Pj4+IGF0bWVsX2dsb2JhbF91
bnByb3RlY3QoKQ0KPj4+Pj4gd2lsbCByZXR1cm4gLUVJTyBpbiBjYXNlIHRoZSBTUiB3YXNuJ3Qg
d3JpdGFibGUuDQo+Pj4+DQo+Pj4+IFlvdSBtZWFuIGluIHRoZSBzcGlfbm9yX3dyaXRlX3NyX2Fu
ZF9jaGVjaygpIGNhbGxzLiAtRUlPIGlzIGZpbmUNCj4+Pj4gdGhlcmUgaWYgd2hhdCB3ZSB3cm90
ZSBpcyBkaWZmZXJlbnQgdGhhbiB3aGF0IHdlIHJlYWQgYmFjaywgaXQgd291bGQNCj4+Pj4gaW5k
aWNhdGUgYW4gSU8gZXJyb3IuDQo+Pj4+DQo+Pj4+IEdCVUxLIGNvbW1hbmQgY2xlYXJzIGFsbCB0
aGUgd3JpdGUtcHJvdGVjdGlvbiBiaXRzIGluIHRoZSBCbG9jaw0KPj4+PiBQcm90ZWN0aW9uIHJl
Z2lzdGVyLCBleGNlcHQgZm9yIHRob3NlIGJpdHMgdGhhdCBoYXZlIGJlZW4gcGVybWFuZW50bHkN
Cj4+Pj4gbG9ja2VkIGRvd24uIFNvIGV2ZW4gaWYgd2UgaGF2ZSBmZXcgYmxvY2tzIHBlcm1hbmVu
dGx5IGxvY2tlZCwgaS5lLg0KPj4+PiBDUi5CUE5WID09IDEsIHRoZSBHQlVMSyBjYW4gY2xlYXIg
dGhlIHByb3RlY3Rpb24gZm9yIHRoZSByZW1haW5pbmcNCj4+Pj4gYmxvY2tzLiBTbyBub3QgcmVh
bGx5IGFuIElPIGVycm9yLCBidXQgcmF0aGVyIGFuIC1FSU5WQUwsIGJlY2F1c2UNCj4+Pj4gdGhl
IHVzZXIgYXNrcyB0byB1bmxvY2sgbW9yZSB0aGFuIHdlIGNhbi4NCj4+Pg0KPj4+IERvZXNuJ3Qg
RUlOVkFMIGluZGljYXRlIHdyb25nIHBhcmFtZXRlcnMsIGJ1dCBkb2VzIG5vdGhpbmc/IEluIHRo
aXMNCj4+PiBjYXNlLCB1bmxvY2sgd291bGQgYmUgcGFydGlhbGx5IHN1Y2Nlc3NmdWwuDQo+Pj4N
Cj4+IHllcywgdGhhdCdzIHdoYXQgSSBzYWlkIEknbGwgZG86ICJJZiBhbnkgYmxvY2sgaXMgcGVy
bWFuZW50bHkgbG9ja2VkDQo+PiBpbiB0aGUgdW5sb2NrX2FsbCBjYXNlLCBJJ2xsIGp1c3QgcHJp
bnQgYSBkYmcgbWVzc2FnZSBhbmQgcmV0dXJuDQo+PiAtRUlOVkFMIiwNCj4+IHdpdGhvdXQgc2Vu
ZGluZyBhIEdCVUxLIGNtZC4gQ2FsbGVyIHdyb25nbHkgYXNrcyB0byB1bmxvY2sgYWxsLCB3aGVu
IHdlDQo+PiBjYW4ganVzdCB1bmxvY2sgcGFydGlhbCBtZW1vcnkuDQo+IA0KPiBEb2gsIEkndmUg
bWlzc2VkIHRoYXQgeW91IHdpbGwgZG8gaXQgYmVmb3JlaGFuZC4gWWVzIHRoZW4gRUlOVkFMDQo+
IGlzIGZpbmUgYnkgbWUuDQo+IA0KPiBCdXQgeW91IHdvbid0IHVubG9jayB0aGUgZmxhc2ggZHVy
aW5nIHN0YXJ0dXAgKGdpdmVuIHRoZSBjb25maWcgb3B0aW9uDQo+IGlzIGVuYWJsZWQpIGlmIGFu
eSBibG9ja3MgaGFzIGJlZW4gcGVybWFuZW50bHkgbG9ja2VkLiBUaHVzIGlmIGp1c3QgdGhlDQo+
IHRvcG1vc3QgNGsgYmxvY2sgaXMgcGVybWFuZW50bHkgbG9ja2VkIGRvd24sIHRoZSB3aG9sZSBm
bGFzaCB3b3VsZG4ndCBiZQ0KPiB3cml0YWJsZSwgcmlnaHQ/LiBJIGRvbid0IGhhdmUgYSBzdHJv
bmcgb3BpbmlvbiBvbiB0aGF0Lg0KDQpDb3JyZWN0LiBJIGRvbid0IHNlZSBwcm9ibGVtcyB3aXRo
IHRoYXQuIEluZGl2aWR1YWwgQmxvY2sgcHJvdGVjdGlvbg0Kd2l0aCB1bmxvY2sgb24gYSBzbWFs
bGVyIGdyYW51bGFyaXR5IGNhbiBiZSBhZGRlZCBsYXRlciBvbiwgYW5kIHRoZQ0KYmVoYXZpb3Ig
ZHVyaW5nIGJvb3Qgd2lsbCByZW1haW4gdGhlIHNhbWUuDQoNCkNoZWVycywNCnRhDQo=
