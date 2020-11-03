Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAB2A4F61
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgKCSuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:50:15 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:60784 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCSuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604429413; x=1635965413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s4ESc5UvxEmF2IcLqv2KPEYOJ2YumC1iWvUITlZsP3E=;
  b=ERTD+flT+5qpt0yoJNSi/vnc3WNB9nR7E2Q0YgNmgV3WQSghKOHyRYvv
   3491SmP+j1b6tZq/iCajFhUC0shU4WD7uDfg9UK/JBZztDujcBfgV4HnQ
   OZq9efqYDT01FpMYSvLGvhE9gLLkiDdumNoPWir/ZBV2zZU6M/f6qBwf3
   zzYE+meY/jFh8kNNDxqUnpZYPxD0aOfx6iARgkSwlyQ6QK07304Tnx1uI
   wLVLvrZolCjLzotTjCBgXXVYtAdQ2mCv2+AVS7cTfi0ugh7mP+G1FIkbz
   tHKfSjn5D90SHplUInfUBNQoyO+l/h2JHU1tPBia7biW3/zmqnZpTqMyS
   g==;
IronPort-SDR: 1oqvI1lEPl03WwEPWLOBtTSNYj5Hb38BRwdeAKgVkGtIV33aVxTv7KxlHeF6bGsy+fUxEH6JFz
 QYQNETk4aoSMD/8cOGRSrm9DL5r6cMiCHQ3s5MgFlMfuZ+UfIProHpyExjB2jcJzJ2cJobYA+g
 ImkVEDSQEhahqcK17woigtaB9KJWu2V6wXDoexHGdavVHQY8fnI8QaDZN6QRiO/ubYjLrvW01d
 D0NKYtqJTyeQlwIBaTNPPN1YIHAuKS+upEydv7ZpIkbd5wPdLbLwKZDquf6Q4jBpzwoJm2dd2k
 dOA=
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="102026131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2020 11:50:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 11:50:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 3 Nov 2020 11:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+jnZw3EZNH6icPizd6kJYtRTdMx1blYXE2am3Kl3fVJmQfY+PRhMI03p/J50gzEpobJTnZ0m9f9t34LIsREUlLiLJJEDUBQnfQQlIybQk5x2uBlnILMWLmQcSdNfrQv3QMXwZh2OHFNZIJxByg6QzEvcrE4GeC+tuXFUIf5PjhpJ/Dvi13qG5BI3rqL6odzZFG2XQOif+0sdM9tgUJT+jBR4i+j0UJ1m+bcHtzwh3lkWlYDc19PJcZJIChZR/FEjkG+TrDwq1W/Hrb0UlKx3CGSSHaDfmUyZYJWqOydm+aXZa+Dam+5f0/JH3DYwfQTLNI/pLrgERoggmOWlFQ3Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4ESc5UvxEmF2IcLqv2KPEYOJ2YumC1iWvUITlZsP3E=;
 b=k3r9Vtp9+IVBQuTCxGNyzqv2rA02HfgTmW4ZfgW0wNq/zts0xYLBhFmBRP3ZcNwn8zo83XRgwDJmXMu+Upgddnq2H5JBeXZQs/sQentZVcI0ccUMteIQygWINo1aVN/IR+lPZJQv1KjWMopAlaphogWjhr8XaTCrdi011WfJNqolFM6r2+7yMqa4sk+5yYZm49Fm5KWlnRSQnKfX4zvFUBFseWzbqx4ThNJ9UDsJ+ttZsQXEbzi6D0lBLNUGDQtpY8lZ69zEI1L3efI+V+jEYGVepvmdcVvRdvEDLoc8NsCUjUBu5EY11+HuBo2PAke7SiPgkNtlEOqdEx7roFtOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4ESc5UvxEmF2IcLqv2KPEYOJ2YumC1iWvUITlZsP3E=;
 b=TR7AvTHJuERMHKNjCfqsKFjs9xUkMY46Ej4agSylrpMhb05ZAOWdqMf7u3sx66fNELgDcx6A31qOeRMo8LvlrTYgC/JMAnJ38RNL2Q5aVeHuvvnrnAFB663+hzL6lzy9aYl5XBaU+Xf1xE0mxGbbiK/eB98hGnYLgEivfl05tng=
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by DM6PR11MB2762.namprd11.prod.outlook.com (2603:10b6:5:c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.24; Tue, 3 Nov
 2020 18:50:10 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::8dfc:4424:3709:9e69]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::8dfc:4424:3709:9e69%6]) with mapi id 15.20.3499.030; Tue, 3 Nov 2020
 18:50:10 +0000
From:   <Cyril.Jean@microchip.com>
To:     <atishp@atishpatra.org>
CC:     <bmeng.cn@gmail.com>, <anup@brainfault.org>,
        <devicetree@vger.kernel.org>, <aou@eecs.berkeley.edu>,
        <Daire.McNamara@microchip.com>, <anup.patel@wdc.com>,
        <linux-kernel@vger.kernel.org>, <atish.patra@wdc.com>,
        <robh+dt@kernel.org>, <alistair.francis@wdc.com>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>, <Padmarao.Begari@microchip.com>
Subject: Re: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
Thread-Topic: [RFC PATCH 2/3] RISC-V: Initial DTS for Microchip ICICLE board
Thread-Index: AQHWrYIX44xaU0n+lU+FVu/TfSg/namv3J0AgAZYq4CAAIteAIAABVqAgAADSoA=
Date:   Tue, 3 Nov 2020 18:50:10 +0000
Message-ID: <c137885d-374b-64ed-42a5-7e8efe004660@microchip.com>
References: <20201028232759.1928479-1-atish.patra@wdc.com>
 <20201028232759.1928479-3-atish.patra@wdc.com>
 <CAAhSdy0pW8AFCDtFkEO_4zjg8Exp+XTb09AjhErdX9u-Jw3OuQ@mail.gmail.com>
 <CAEUhbmUm6EyP33FU1n4LhEk-xcBtR13-xS+Tpt76ug1HQv8CEg@mail.gmail.com>
 <e9bad05c-db34-ba2c-df5c-ff2f7f53e15b@microchip.com>
 <CAOnJCULkC65FgOakjPgoACdpiQFWTiEPCox3ayMWWZwVa91fVA@mail.gmail.com>
In-Reply-To: <CAOnJCULkC65FgOakjPgoACdpiQFWTiEPCox3ayMWWZwVa91fVA@mail.gmail.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: atishpatra.org; dkim=none (message not signed)
 header.d=none;atishpatra.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [86.40.244.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd6add71-0e5a-4eca-d31c-08d880294a88
x-ms-traffictypediagnostic: DM6PR11MB2762:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB276215F19FB47D74A1ADC0CB9E110@DM6PR11MB2762.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5TRDpjC4aXteflKUMRMDeATefUTIMyfDC8eOlLT0gAVnpWK8pivUBeKGNJmDIfOUPZ+pzw0T4s9KQSXvdkOd6IwKrQHsx0AuszLYCi0T+I2QJgqG8bcFnxRc0KPYl9otUCjGRKjG7kQV3FU6wNZLxtrMLAPKIKWWjS755i4u1WFbDCA/G1/RYtKTNPvUYLSsF8+iG5ZX6LRIx0rRZsAbrHkNBBD7pd0I9nSrFXYLUbGJPhVahKbtz3rO67vqt3yFkZyOdLE5mYXUHL2o2YexpQ+VlUww8HZlb4M84fzotkFtFpS9fD82jEHNQFKSazVXYvaXV48+6UUoSFJGBfIUQAgurPH8n1NiBK6UBswEkk/hn4Ohqd8T1J54bcQoast
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(39860400002)(346002)(136003)(54906003)(66446008)(186003)(66476007)(86362001)(71200400001)(7416002)(2906002)(316002)(5660300002)(6512007)(53546011)(26005)(64756008)(66556008)(6506007)(107886003)(2616005)(31686004)(83380400001)(91956017)(8676002)(36756003)(8936002)(4326008)(6916009)(6486002)(66946007)(31696002)(76116006)(478600001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yRA5LJrw/zhpy3+j6IJIUIMaIVTwmbcxNzq+5opqW6nAPjWQCoV6e+wgSEyrm83VRaQIJoYrE3yepKX2fvhb320tmtIL+TNHz5OQWV28bxe4qGpgXxw75SlXLIKIt/2FPRFWhOgD44ie/vEgKUejhebTL4w0WHwSFMlUp7VViiW2DYASfmlgAfbG4005GaX6IbAMcUUJzGBMGGP+0exXGMsL+BKgydfd+lXauKDi3ZPNoB5ravD4tTvj8aVAcQ6rcUIcbxIJKzyAe/DeQE1jmGhng9ci4CAXb1RMweiZ0SdTizLL62DjEC/sp1kIxIkfJIkm0hh+MaPS9CQ5GJ+etbXyCo+Brc1KqwrHfI2kvBRd1ivfbJSDk/oqux0GCteUIX4kXDKr9eSzIj4CX/iQlWQEPlbbdcuf55Jc4mV/QOR55TplLy3Bx6o6LtCO3h4VQ8GJ1DyobgE7jCNzb+R4wRo83h2B/ibU22d8D9WnrhiwsbFN1kdzdputf9AXXFsMBkk8lwxVkZL+K+qH409uAhLlecZUcvabbti3IaMEJhmkD/thiB/tRSjZ31RRspKOyaAnI372j28Z0z+w9eqh513toyJe7QrFEsJ1tR4CK3crMtcnGEWjYG94K+AxvRK/8LQddaSgEwTytk05pSgcvA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CE7B812EEA3604EB13D62DA3714E4C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6add71-0e5a-4eca-d31c-08d880294a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2020 18:50:10.5010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /6gohuHHZOH47/w0iPXcyJFwPmIMDwX6olVzdPfvHqM/ijWuzzLWD+ZzfqPKhbmkrTag2uq9JEbYGveDNl37Tak4p8Qi6O7cnaUg6hDJeC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvMy8yMCA2OjM4IFBNLCBBdGlzaCBQYXRyYSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+DQo+IE9uIFR1ZSwgTm92IDMsIDIwMjAgYXQgMTA6MTkgQU0g
PEN5cmlsLkplYW5AbWljcm9jaGlwLmNvbT4gd3JvdGU6DQo+PiBPbiAxMS8zLzIwIDEwOjAwIEFN
LCBCaW4gTWVuZyB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUN
Cj4+Pg0KPj4+IE9uIEZyaSwgT2N0IDMwLCAyMDIwIGF0IDU6MDggUE0gQW51cCBQYXRlbCA8YW51
cEBicmFpbmZhdWx0Lm9yZz4gd3JvdGU6DQo+Pj4+IE9uIFRodSwgT2N0IDI5LCAyMDIwIGF0IDQ6
NTggQU0gQXRpc2ggUGF0cmEgPGF0aXNoLnBhdHJhQHdkYy5jb20+IHdyb3RlOg0KPj4+Pj4gQWRk
IGluaXRpYWwgRFRTIGZvciBNaWNyb2NoaXAgSUNJQ0xFIGJvYXJkIGhhdmluZyBvbmx5DQo+Pj4+
PiBlc3NlbnRpYWwgZGV2Y2llcyAoY2xvY2tzLCBzZGhjaSwgZXRoZXJuZXQsIHNlcmlhbCwgZXRj
KS4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBBdGlzaCBQYXRyYSA8YXRpc2gucGF0cmFA
d2RjLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+Pj4gICAgYXJjaC9yaXNjdi9ib290L2R0cy9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4+Pj4+ICAgIGFyY2gvcmlzY3YvYm9vdC9kdHMv
bWljcm9jaGlwL01ha2VmaWxlICAgICAgICB8ICAgMiArDQo+Pj4+PiAgICAuLi4vbWljcm9jaGlw
L21pY3JvY2hpcC1pY2ljbGUta2l0LWEwMDAuZHRzICAgfCAzMTMgKysrKysrKysrKysrKysrKysr
DQo+Pj4+IEkgc3VnZ2VzdCB3ZSBzcGxpdCB0aGlzIERUUyBpbnRvIHR3byBwYXJ0czoNCj4+Pj4g
MS4gU09DIChtaWNyb2NoaXAtcG9sYXJmaXJlLmR0c2kpDQo+Pj4+IDIuIEJvYXJkIChtaWNyb2No
aXAtaWNpY2xlLWtpdC1hMDAwLmR0cykNCj4+PiBJIGFsc28gZG91YnQgd2hhdCBpcyB0aGUgY29y
cmVjdCBib2FyZCBuYW1lLiBJIHN1c3BlY3QgdGhlIC1hMDAwIGNvbWVzDQo+Pj4gZnJvbSB0aGUg
U2lGaXZlIGJvYXJkIG5hbWUgY29udmVudGlvbiwgYnV0IGRvZXMgbm90IGFwcGx5IHRvIHRoZQ0K
Pj4+IEljaWNsZSBLaXQgYm9hcmQuDQo+Pj4NCj4+PiBAQ3lyaWwsIHBsZWFzZSBjb25maXJtLg0K
Pj4+DQo+PiBDb3JyZWN0LiBTb3JyeSBQYWRtYXJhbywgSSBtaXNzZWQgdGhhdCBvbmUuDQo+Pg0K
PiBPay4gSSBwaWNrZWQgdGhhdCBvbmUgZnJvbSBVLUJvb3QuIFdoYXQgc2hvdWxkIGJlIHRoZSBj
b3JyZWN0IGJvYXJkDQo+IG5hbWUgaW4gdGhhdCBjYXNlID8NCj4NCj4gbWljcm9jaGlwLXBmc29j
LWljaWNsZS1raXQgPw0KDQpNeSBwcmVmZXJlbmNlIHdvdWxkIGdvIGZvciBtaWNyb2NoaXAtbXBm
cy1pY2ljbGUta2l0LiBJIHByZWZlciAibXBmcyIgDQpvdmVyICJwZnNvYyIgYXMgIm1wZnMiIGlz
IHRoZSBwYXJ0IG51bWJlciBwcmVmaXggZm9yIHRoZSBQb2xhckZpcmUgU29DIA0KZGV2aWNlIGZh
bWlseS4NCg0KDQpSZWdhcmRzLA0KDQpDeXJpbC4NCg0KDQo=
