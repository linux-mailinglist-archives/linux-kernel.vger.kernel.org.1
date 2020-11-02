Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC5FC2A2ADF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgKBMlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:41:49 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:19023 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgKBMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:41:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604320907; x=1635856907;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ASHJ/7zXT1a13nWrFo8skwV0nIZh1dJrdxJ97Ps9iP8=;
  b=roM0LVBItuqG4DjtrW9aHOHxcujV0zuwgH14B8S7rZC9sziZ4DF2aidd
   hQvC8C5dsHproWvZQaN7kaI3/692w+BFCbs5JozeK710KehgqVntOCo64
   srrZiMgp9EXS0z/iUj7mSLm3KODn9kmUybE3SeWAdv97OoucvKZRTM2gn
   UOC3Z0K3DfHQRKJPkOkVtB5Ix4kX1Ms/hHS0Yz3pdJNqQP8PycY0ou5up
   uQH5v39TVySERHzdK91pFlYuW2eIvCykNV/71o0mJPfRpwBKaoZbDTPU0
   nNkJP2Xay4lR4BTUoUAv9oi+Y0UkRLQIi3UF5Hj+N/uhdq2X5eLMoMxAW
   A==;
IronPort-SDR: c8LlSg8I4rWHPkoWRm3BRWrlhOOKJ3oDs/qmGW5Pa3O3kCXq5rOxJR5KMFVPbqqQOy13T5gCln
 vmQou//hM3SoaVxmOHPK3815UWfxFe3afqVTnddvVAe9FUkWMJ/Qg1Tg8w0NF58lqdOBH7R6zh
 jEXMCLtkXrEo089f1c/6uqHXEz3pjzGsDsVQrsIYw7qAqp3OBIgLiU8o+oe+BkJkhs/yI5cxx0
 8HPUoKE7IJ2YcGdb8VUYJ+z61JwvWJ73RJN+m36x3QP1nTGbo0OFsHttVa5hiaz01Np/LLdbAm
 tlU=
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="32050479"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Nov 2020 05:41:47 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 2 Nov 2020 05:41:47 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 2 Nov 2020 05:41:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4QliyRfDtU/9dLX3zp7fETYKmDmrp+sJg4eDNURfeEXkDYbQz/m9LN62idsNo2LlRo5/El7vQgz8WNJm+T2xrZmBkiEnxgUynVB/kXSaI2LBoaymXmge8GrI4BbCND6jm5ge8MUEvPSCYaOuIMOJGDsFY1w6IOBc7RvU/XjddL9UJkQ8nIASP7MGNCAMlohbf1EecycTLj37OWKjCdOh8mLxOBbFN3y/S5xO02xuKAyN4cAPoxlrx6yOzx34DGAD4qU0FfJjsZqvSLbdc5MH8VAMwv3+qTgBQ5MdHxetE4oNzWoB8YYeL0hgTbIOzfz5ONl2hFaY5yAmDFY6MoLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASHJ/7zXT1a13nWrFo8skwV0nIZh1dJrdxJ97Ps9iP8=;
 b=GRC9kD2/HyJj6uPekKtWnyhmbhYnq/Ge1Cx1PV8JEmD23dVChZswOjiCk8I8x0HURtmkseEoq8QFyDYijmbwEsVEDrDXfnIIjRnDOcXescEJeDc+JSmBnkC2qGrrOfgxVc/ZdJJtunzSZJGwocAnsouLjnNJ4j6bq7AJTOhqzmPcExs1k1LZT2AV+1ucSAwoD8Poyzv/MMRIMxhC7oXlzhT/Hfoz7LERudplHIXJPnItQ5IvWQGg8WB/bCzDZy0srFy0Q1VSzbx68BVF8y3gxG9CY2SCRDklbbNvRDFMvZuqZ8nTnLd1/JvsLSlQnfXYpkhsnK4Tmn9wJ0bB89UA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASHJ/7zXT1a13nWrFo8skwV0nIZh1dJrdxJ97Ps9iP8=;
 b=EmsyvZsBzKcNsSwHCWhS1eJ2tqGHG7rS3S4OO2kqA29GPYU9FR5/OsOj3CGDo/6/HbNlAo03qXP2hPAWqLSZ81QOFr/RInUCSl51Jeta00Ydl14nYMeRLZ2o1czfPWm6GybYM0M6+NxYykWyiutvV0ImA05EwS6fXZo0yBetl6M=
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 (2603:10b6:903:b1::22) by CY4PR11MB2008.namprd11.prod.outlook.com
 (2603:10b6:903:22::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 2 Nov
 2020 12:41:43 +0000
Received: from CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e]) by CY4PR1101MB2341.namprd11.prod.outlook.com
 ([fe80::908:a628:69ca:d62e%7]) with mapi id 15.20.3499.030; Mon, 2 Nov 2020
 12:41:43 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <lee.jones@linaro.org>
CC:     <Nicolas.Ferre@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <richard.genoud@gmail.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Topic: [PATCH] ARM: dts: at91: add serial MFD sub-node for usart
Thread-Index: AQHWrq0BNGYIfVuhjkKKUxhuAsgrHKmwJpcAgAAMyICABF5uAIAAO+AA
Date:   Mon, 2 Nov 2020 12:41:43 +0000
Message-ID: <6313146b-9b2c-097b-9852-d85fc1bf16b4@microchip.com>
References: <20201030110702.886638-1-codrin.ciubotariu@microchip.com>
 <b054ce5c-58fd-dd86-2cb6-1e1f06a0899e@microchip.com>
 <f370bbf7-5cfc-1524-8103-061698ba6b67@microchip.com>
 <20201102090724.GG4127@dell>
In-Reply-To: <20201102090724.GG4127@dell>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.121.145.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a44f06-d0ad-4fa9-5d3c-08d87f2ca748
x-ms-traffictypediagnostic: CY4PR11MB2008:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB20082F672A8DD2469DA9BB7DE7100@CY4PR11MB2008.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fiip18FiMP64ZvYpbT3U5H/mIk0xVWNCY0sbDivz+ISdYrTbWhOV9MwlGRNGS3n1HO6u1rq1wjZHvVJCC8AhXQ9UzQ5M8MuNK3ewXn4/eWUjNhT0191YIiQLv9oP5liNru5c1JD5sJSjJMnfA4TPwdgkktQHGxabT5NW8sMVgRJRfAyyHjAwm8H+8jaLISmmFUu6JpblU1pn8qHWqc7K/l3cLxtHpMnd3x2iB6nnkeMnwPg8aM/w6K3bxOP2yt4bS2H3eODIoaQQ+dLMGcbvtM2dkGKYSrAbeOsBmzYwt1LeHO17zaK/U3DZZNPRh2xT2O+KLlSjqlIoAeoAe+9joxhpkKVYgFNAdRPBB7OiHx1ihW9NbInImeizDTTQf+cg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1101MB2341.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(376002)(366004)(107886003)(36756003)(86362001)(6916009)(4326008)(31686004)(2616005)(8676002)(66446008)(66946007)(186003)(66556008)(8936002)(316002)(71200400001)(91956017)(2906002)(31696002)(76116006)(64756008)(66476007)(6506007)(53546011)(6512007)(54906003)(478600001)(26005)(83380400001)(5660300002)(6486002)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vd+fqnwe0PUGVY4fW82sKaKbo737otfr5mJcze2KmDMlSJtYYHOnKM9DtYND1W9UvoGq3kNKekTxMXwG5SEfZKDQS/FI92JKe1q19mma+gviIlfjdG+L/u/8Ss5t6IBvmGc9aJKDlhtp/iRNpv4DawAhrpsM5MBqud/+/8w3VnJltnuxfhRhDGDC77NN6prt4PPpdc0m7Se+l5RN3821dSpVtsIcIjvZKa86DvpRluE0hSfqtUETXxlQPtH1oLiFO4Kiq0bK0hTe54Qf6OnygKqXD45EWG5Sdw8MSfAUbHVuLuVCrHFonH5trJtUtQntBUh4HUF1mZp9yu/RiEKPPQ6PeWYE1b7Bc66+wTvAehVsZ9OUmYGMQhQz4Cd2xgUP+UjFhXKUUuzHHUqEDy0f8a5COoPHdwRy2oQdo68cBh3Lh3a42syRalbxvi+c3RkQ54cHAsWB8Nq5RN/7IJcem/FBAfTwhWiEs0zfHJIGQasWhdU/g7hMWOmn5XdltYNHCu/xA5R5hB1ZB2jU8BopLTLdoNegMPkY6Wr9keH8kJ4pXE+p4PHkiI22aeSYZJR2JBKeeAQIQjhynWbYIcW74VNTK/HKFJG/0HDdVic4nLjrLnJLJ++qn+b56+1LhUyW+ANKpANFiLk9oYovAEtIhw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <29E50F4CF71A6A46890B4DD00153A90D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1101MB2341.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a44f06-d0ad-4fa9-5d3c-08d87f2ca748
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2020 12:41:43.4161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yLBI7lsId7UkIgNJJaSyILLjHEfy/PgBcFBDfShihugaicomD1dquDqzRj6SqXyNDOAuVXhPY8VAcpPm/nbGUJnR+f5egSw1yVPqOw/kl1k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIuMTEuMjAyMCAxMTowNywgTGVlIEpvbmVzIHdyb3RlOg0KPiBPbiBGcmksIDMwIE9jdCAy
MDIwLCBDb2RyaW4uQ2l1Ym90YXJpdUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiANCj4+IE9uIDMw
LjEwLjIwMjAgMTU6MzgsIE5pY29sYXMgRmVycmUgd3JvdGU6DQo+Pj4gT24gMzAvMTAvMjAyMCBh
dCAxMjowNywgQ29kcmluIENpdWJvdGFyaXUgd3JvdGU6DQo+Pj4+IFRoZSAiYXRtZWwsYXQ5MXNh
bTkyNjAtdXNhcnQiIGRyaXZlciBpcyBhIE1GRCBkcml2ZXIsIHNvIGl0IG5lZWRzDQo+Pj4+IHN1
Yi1ub2Rlcw0KPj4+PiB0byBtYXRjaCB0aGUgcmVnaXN0ZXJlZCBwbGF0Zm9ybSBkZXZpY2UuIEZv
ciB0aGlzIHJlYXNvbiwgd2UgYWRkIGEgc2VyaWFsDQo+Pj4+IHN1Ym5vZGUgdG8gYWxsIHRoZSAi
YXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiIHNlcmlhbCBjb21wYXRpYmxlIG5vZHMuIFRoaXMNCj4+
Pj4gd2lsbCBhbHNvIHJlbW92ZSB0aGUgYm9vdCB3YXJuaW5nOg0KPj4+PiAiYXRtZWxfdXNhcnRf
c2VyaWFsOiBGYWlsZWQgdG8gbG9jYXRlIG9mX25vZGUgW2lkOiAtMl0iDQo+Pj4NCj4+PiBJIGRv
bid0IHJlbWVtYmVyIHRoaXMgd2FybmluZyB3YXMgcmFpc2VkIHByZXZpb3VzbHkgZXZlbiBpZiB0
aGUgTUZEDQo+Pj4gZHJpdmVyIHdhcyBhZGRlZCBhIHdoaWxlIGFnbyAoU2VwdC4gMjAxOCkuDQo+
Pj4NCj4+PiBJIHdvdWxkIHNheSBpdCdzIGR1ZSB0byA0NjZhNjJkNzY0MmYgKCJtZmQ6IGNvcmU6
IE1ha2UgYSBiZXN0IGVmZm9ydA0KPj4+IGF0dGVtcHQgdG8gbWF0Y2ggZGV2aWNlcyB3aXRoIHRo
ZSBjb3JyZWN0IG9mX25vZGVzIikgd2hpY2ggd2FzIGFkZGVkIG9uDQo+Pj4gbWlkIEF1Z3VzdCBh
bmQgY29ycmVjdGVkIHdpdGggMjIzODBiNjVkYzcwICgibWZkOiBtZmQtY29yZTogRW5zdXJlDQo+
Pj4gZGlzYWJsZWQgZGV2aWNlcyBhcmUgaWdub3JlZCB3aXRob3V0IGVycm9yIikgYnV0IG1heWJl
IG5vdCBjb3ZlcmluZyBvdXINCj4+PiBjYXNlLg0KPj4NCj4+IFdlbGwsIGl0J3Mgbm90IGNvdmVy
aW5nIG91ciBlbmFibGVkIGRldmljZXMuDQo+Pg0KPj4+DQo+Pj4gU28sIHdlbGwsIEkgZG9uJ3Qg
a25vdyB3aGF0J3MgdGhlIGJlc3Qgb3B0aW9uIHRvIHRoaXMgY2hhbmdlLiBNb3Jlb3ZlciwNCj4+
PiBJIHdvdWxkIHNheSB0aGF0IGFsbCBvdGhlciBVU0FSVCByZWxhdGVkIHByb3BlcnRpZXMgZ28g
aW50byB0aGUgY2hpbGQNCj4+PiBub3QgaWYgdGhlcmUgaXMgYSBuZWVkIGZvciBvbmUuDQo+Pj4N
Cj4+PiBMZWUsIEkgc3VzcGVjdCB0aGF0IHdlJ3JlIG5vdCB0aGUgb25seSBvbmVzIGV4cGVyaWVu
Y2luZyB0aGlzIHVnbHkNCj4+PiB3YXJuaW5nIGR1cmluZyB0aGUgYm9vdCBsb2c6IGNhbiB5b3Ug
cG9pbnQgdXMgb3V0IGhvdyB0byBkZWFsIHdpdGggaXQNCj4+PiBmb3Igb3VyIGV4aXN0aW5nIGF0
bWVsX3NlcmlhbC5jIHVzZXJzPw0KPj4NCj4+IE15IHVuZGVyc3RhZGluZyBpcyB0aGF0IHBsYXRm
b3JtIGRldmljZXMgcmVnaXN0ZXJlZCBieSBNRkQgc2hvdWxkIGhhdmUgYQ0KPj4gY29ycmVzcG9u
ZGlnIERUIG5vZGUuIFRoZSBwYXJyZW50IHByb3BlcnRpZXMgYXJlIGFsc28gYXZhaWxhYmxlIGZv
ciB0aGUNCj4+IG90aGVyIHVzYXJ0IGRldmljZSAodXNhcnQtc3BpKSwgc28gSSB0aGluayB3ZSBz
aG91bGQga2VlcCB0aGVtIGluIHRoZQ0KPj4gcGFycmVudC4NCj4gDQo+IERldmljZSBUcmVlIGFu
ZCBNRkQgYXJlIHVucmVsYXRlZC4gIE1GRHMgZG9uJ3QgZXZlbiBleGlzdCAtIHRoZXkgYXJlIGEN
Cj4gZmlnbWVudCBvZiBhIExpbnV4IEtlcm5lbCBFbmdpbmVlcidzIGltYWdpbmF0aW9uIC0gd2Ug
bWFkZSB0aGVtIHVwIQ0KPiANCj4gVGhlIERUIHNob3VsZCBkZXNjcmliZSB0aGUgaGFyZHdhcmUg
YW5kIG5vdGhpbmcgZWxzZS4gIElmIHdlIHdpc2ggdG8NCj4gbWVzcyB3aXRoIGRldmljZXMgZm9y
IG91ciBvd24gZ2FpbiBpLmUuIG9yZ2FuaXNlIHRoZW0gaW50byBkaWZmZXJlbnQNCj4gc3Vic3lz
dGVtcywgd2UgaGF2ZSB0byBkbyB0aGF0IGluIHNvZnR3YXJlLiAgVGhhdCdzIHdoYXQgTUZEIGlz
IGZvci4NCg0KWW91IGFyZSByaWdodCwgSSBtaXhlZCB1cCB0aGluZ3MuIFdlIGFyZSB1c2luZyB0
aGUgTUZEIGhlcmUgdG8gZGVzY3JpYmUgDQphIGhhcmR3YXJlIFVTQVJUIElQIHRoYXQgY2FuIGFs
c28gZnVuY3Rpb24gYXMgYW4gU1BJLCBidXQgbm90IGF0IHRoZSANCnNhbWUgdGltZS4gVGhlIGRl
Y2lzaW9uIG9mIHdoZXRoZXIgdGhlIElQIHdvcmtzIGFzIGEgbm9ybWFsIFVTQVJUIG9yIGFuIA0K
U1BJIGlzIERUIGNvbmZpZ3VyYWJsZSwgYXQgdGhpcyBtb21lbnQuIEl0IGlzIGRvaW5nIG1vcmUg
dGhhbiBqdXN0IA0KZGVzY3JpYmluZyB0aGUgSFcsIGJ1dCBJIGRvbid0IGtub3cgaG93IHRvIGRl
c2NyaWJlIGl0IG90aGVyd2lzZS4NCg0KQmVzdCByZWdhcmRzLA0KQ29kcmluDQoNCg==
