Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759E3279837
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgIZKB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 06:01:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23008 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIZKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601114488; x=1632650488;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MvZBkz7bSacn8DuwqvbVk+t6b7fMTphW7tw3aVMsiuE=;
  b=Iw/AZZBGbS1XWYTC1nLS9/FpYGWSkKmmpZ3jPv0786i0G+Lix1rW2X4F
   T7m9h1SEoNbEZLQhSlfZ5OPnk4a+Xk1n0rApPWgEdW49AmNXsWLwYFF05
   oKLNLv3okamcxI5SVWZNrljgtm2j4vk7xUK0kXJbXLOuHG0MoYS7ikuNw
   qskauSVwAI0BVvZaPDjIQdufnKvuTfmJR6402EX8z4VsbmgWVMKFdcGGa
   Q9K1ny6UR7B21uswhEszE4gj9F4+lUuSOV2gsc9QpzfAjVN7iSRjidOfd
   6XmPAwoja3lvC7Lz7B4bZKYK2CTvkneq6q8znfUYL+S5vo/ExwEbwc3nU
   g==;
IronPort-SDR: 8EK1UhgBYmWgCzGL83m9rWHu3DBN01VQ/GbT6/DGnQOZSLrLKl2brMjQxva0tgqcLwY6wA4bGy
 rUmLdPgiVXuEBsoLK7zrKC4+OMsiAt4jmwSAZgpXbJglHLjQiompcfHTVnP/4vT+CF7YSvwPHR
 50Kz9cnSdxkBZLRi83chqdsA8ySMCYsptve8mJi8NJyEv+YJQdqarnoKkFrP2jabgYZEqf7Auj
 qN14IIaOEP1yLPPZJNFHL9Hk3Z/CyZ9I/3wTAhZMTXMJP4KwTkSu49MtBMKRmRoEQvidZrNbf1
 BKk=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="149556441"
Received: from mail-cys01nam02lp2051.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.51])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 18:01:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJn9f/sbYTBD2bwZjxu5K0Evd3ljO6o57vqIOk8qyLNBjFzqmZKsf0Df29LohWK57sRhv/HJ3aR9q1fqtD70wqBifNJp0BE8i0rgcGc+rdOJdish/MZuqWDEHKChBA0ACJ6DUmlINHv/Dm62fpjP+AdLfFHDP4w8YPOCpikrg32zdtynW6+us6ftLq6dhgPKhH5eEKF7aJUlA2H7uzUDxosmQShi2nLpHu0Jl0SP1H07Hmdh6jcjfGLMD4cy/beM7hH58Sci5FuExC/5MK+aks/UAy3Rvrv+NYwuECgHOmJo3INCO68BSrEt3Rw+q/ua4Z0FDvKkT0XzlcR7vy5uyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvZBkz7bSacn8DuwqvbVk+t6b7fMTphW7tw3aVMsiuE=;
 b=bHP4xQPuo5IotmFZtfutTYtxfAhrRfI4DBgROxaZtPa0qlLuEsUBlB4J9RJyKeUTcTe9ftQB9DQ2wXZwTtwYL4H1tx0ct/HfMmAC96Lrea+p5OCJUf5BIpYBxoRKaOe91q1n4CTqyS7RcgMwf+A0HmwSOuxknKz09ch3PjCQST+huFC2SN4T94IxaEthRPcmhudJYQGY/ZYALZMhYuxF4H0dfdGpZF5h6IUwbFmI1wbZ+ZP6hp1AtXzKGkgAOhRZecVPMi7H7LhyS9Iq4TKmbO0ti9IHsbqfvMqSzty4ioqx3J7bFfAROuT9a0OU61rX3RdGxfESh/TRUW5wwwi5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvZBkz7bSacn8DuwqvbVk+t6b7fMTphW7tw3aVMsiuE=;
 b=NRQCD5pbCX4o2lboSBI8QYB2GOabgVi//qWJxo3O0AIFQH+bJHguUP75/pORJ6xk0lasHwtBffhpZ3hhy25tkdywUiWfrkQ2vrjpVWQ/3n9Mlt+GaGuD+JrMKlD9ilcnynswUXCwSAdjCesSRb2aPpHnkxb70p2CMt52XZTXIwg=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2316.namprd04.prod.outlook.com (2a01:111:e400:c618::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Sat, 26 Sep
 2020 10:01:22 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.024; Sat, 26 Sep 2020
 10:01:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "anup@brainfault.org" <anup@brainfault.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
Thread-Topic: [PATCH] RISC-V: Check clint_time_val before use
Thread-Index: AQHWk9aYSJLcKwhKG0OB2/Vy4ql06al6pkQAgAAB0ICAAAQAAIAAAxGAgAABJYA=
Date:   Sat, 26 Sep 2020 10:01:22 +0000
Message-ID: <6c2d3e6bc1574d2ec3b566ee2138ba354459aeb8.camel@wdc.com>
References: <20200926072750.807764-1-anup.patel@wdc.com>
         <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>
         <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com>
         <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
         <CAAhSdy0-rj3LWf+Ma6PTJkiwnMPq-mRXdvR+esfZefhcZeyayA@mail.gmail.com>
In-Reply-To: <CAAhSdy0-rj3LWf+Ma6PTJkiwnMPq-mRXdvR+esfZefhcZeyayA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: brainfault.org; dkim=none (message not signed)
 header.d=none;brainfault.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 526a4056-828c-4ed1-1e34-08d862031f35
x-ms-traffictypediagnostic: CY1PR04MB2316:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB2316528B12FB09C3CC5A5AD6E7370@CY1PR04MB2316.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tpaCjdIdfR9EUlRQkGuwuW1ryHqw78cGKTiXK/k+bJTo7UFt4JLC9TxEPLyiXvygplAXxFKxwOkGshaz+tvDTZNt417nQeJ3OZGAbMOJISEVDC/52+BTR1J0Tw6VBQ0u/Ft76zxeJ/3ziQyjwPoKzRsksYNf9qbZsGzsaKGliM0/m5H46ASMzHoMneYKQpZfYZ/ZEFCC50BaHCt/vcqSVXlFnEeyWt/0NxQtYR9aleTPYpXG3Ka69PqWFOpMyypR6JRUYAl/3wS9RoV2Y2fFo2RFWckjRqD9AGyi1DBPZemPYpBCiK4a7Gmj2pGVZ2y+A+3RfPFY0i9RLfBhnMwo+2l5B7kTzRUlKyBlCtjggb9Z2Gy9jdGrW3vCPMK7GMCv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(186003)(54906003)(2906002)(36756003)(86362001)(83380400001)(6506007)(53546011)(316002)(66946007)(6486002)(8676002)(478600001)(8936002)(71200400001)(2616005)(6916009)(66446008)(6512007)(5660300002)(66476007)(76116006)(91956017)(64756008)(66556008)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fmv9GP776bWT5cogBIK6ow9YxShL/8XOW4lTB/kGXmEhkAgzO3cv/pZQUSe5mQKxnDbMKH+3awwcYqvFH3Ln3EbuadWuI/P1XBqo/cunpzJntmTjJUVxommrHqxjSagkdAePgso5kovZa8Sk3IccQuerYJEPZmR+g9gPzNg2QHSNbuG15892dHhrjYHWLha+BK7JN0gv3wEuPAJiMgBwW1ksXrPmRKoq4wo/q63MN0G9Bx2o0nUxYzgnbGPDpS3X8nXNu6I9/LFnn+35ZI4+2x94nNhTA/9l2eCnaulABqymgOmJ8jLxuaZY7L+QzJ+nk2GFCqa3TpTclc7ig36+4B2jTp1lb+/Hpc0SAN92cvl31nDRYi3fiVhSLFhSRs9IOpqBti8W0W5ATb+J1hh5h64ycRacgk54b//L78oXd+a+tbbATrEhngTZSS7wQIe8wQDr0TdYC9PkNoBQcs2uj3vDYQsVnF2AfsUD/3EjlLGR06IB2y95VtVmnJQdo5W0Iut8K7M+PYxradXAATcaLWUW9EfwJWWss30XiqWPaUNkNwNt6zrT2jw0fgIZTpJR1iEI2I+EcW9kNr1hcGSiR9bRXk6NpFotxaUZUi3V++YdD12DttLS6tcea6hLY2ITkQlTyWEqnZ0vmTyYdf1rV+/X+nBsNqPHkTJFozg8LojldGCdB6d9GjxiegzBji3Sp7J2UPPsKgYrVQiF7RxQDg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EC163FD21CDF047B836AEB211E92BC3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 526a4056-828c-4ed1-1e34-08d862031f35
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 10:01:22.0224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLnekPAIjgu2TciJROnroXdXjK/ssyWg40p9pk92fIZ1ddlb4Qt5azxoOCJwJNP+aZrPcxJFLNO566TuO7GmtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2316
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA5LTI2IGF0IDE1OjI3ICswNTMwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBP
biBTYXQsIFNlcCAyNiwgMjAyMCBhdCAzOjE2IFBNIERhbWllbiBMZSBNb2FsIDxEYW1pZW4uTGVN
b2FsQHdkYy5jb20+IHdyb3RlOg0KPiA+IE9uIFNhdCwgMjAyMC0wOS0yNiBhdCAwOTozMSArMDAw
MCwgQW51cCBQYXRlbCB3cm90ZToNCj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+ID4gRnJvbTogRGFtaWVuIExlIE1vYWwgPERhbWllbi5MZU1vYWxAd2RjLmNvbT4NCj4g
PiA+ID4gU2VudDogMjYgU2VwdGVtYmVyIDIwMjAgMTQ6NTUNCj4gPiA+ID4gVG86IHBhdWwud2Fs
bXNsZXlAc2lmaXZlLmNvbTsgcGFsbWVyQGRhYmJlbHQuY29tOw0KPiA+ID4gPiBwYWxtZXJkYWJi
ZWx0QGdvb2dsZS5jb207IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT47DQo+ID4gPiA+
IGFvdUBlZWNzLmJlcmtlbGV5LmVkdQ0KPiA+ID4gPiBDYzogYW51cEBicmFpbmZhdWx0Lm9yZzsg
bGludXgtcmlzY3ZAbGlzdHMuaW5mcmFkZWFkLm9yZzsgQXRpc2ggUGF0cmENCj4gPiA+ID4gPEF0
aXNoLlBhdHJhQHdkYy5jb20+OyBBbGlzdGFpciBGcmFuY2lzIDxBbGlzdGFpci5GcmFuY2lzQHdk
Yy5jb20+OyBsaW51eC0NCj4gPiA+ID4ga2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBSSVNDLVY6IENoZWNrIGNsaW50X3RpbWVfdmFsIGJlZm9yZSB1
c2UNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFNhdCwgMjAyMC0wOS0yNiBhdCAxMjo1NyArMDUzMCwg
QW51cCBQYXRlbCB3cm90ZToNCj4gPiA+ID4gPiBUaGUgTm9NTVUga2VybmVsIGlzIGJyb2tlbiBm
b3IgUUVNVSB2aXJ0IG1hY2hpbmUgZnJvbSBMaW51eC01LjktcmM2DQo+ID4gPiA+ID4gYmVjYXVz
ZSB0aGUgZ2V0X2N5Y2xlcygpIGFuZCBmcmllbmRzIGFyZSBjYWxsZWQgdmVyeSBlYXJseSBmcm9t
DQo+ID4gPiA+ID4gcmFuZF9pbml0aWFsaXplKCkgYmVmb3JlIENMSU5UIGRyaXZlciBpcyBwcm9i
ZWQuIFRvIGZpeCB0aGlzLCB3ZQ0KPiA+ID4gPiA+IHNob3VsZCBjaGVjayBjbGludF90aW1lX3Zh
bCBiZWZvcmUgdXNlIGluIGdldF9jeWNsZXMoKSBhbmQgZnJpZW5kcy4NCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBGaXhlczogZDViZTg5YThkMTE4ICgiUklTQy1WOiBSZXN1cnJlY3QgdGhlIE1NSU8g
dGltZXIgaW1wbGVtZW50YXRpb24NCj4gPiA+ID4gPiBmb3IgTS1tb2RlIHN5c3RlbXMiKQ0KPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEFudXAgUGF0ZWwgPGFudXAucGF0ZWxAd2RjLmNvbT4NCj4g
PiA+ID4gPiAtLS0NCj4gPiA+ID4gPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90aW1leC5oIHwg
MTIgKysrKysrKysrLS0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2Fy
Y2gvcmlzY3YvaW5jbHVkZS9hc20vdGltZXguaA0KPiA+ID4gPiA+IGIvYXJjaC9yaXNjdi9pbmNs
dWRlL2FzbS90aW1leC5oIGluZGV4IDdmNjU5ZGRhMDAzMi4uNTJiNDJiYjE2MDJjDQo+ID4gPiA+
ID4gMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90aW1leC5o
DQo+ID4gPiA+ID4gKysrIGIvYXJjaC9yaXNjdi9pbmNsdWRlL2FzbS90aW1leC5oDQo+ID4gPiA+
ID4gQEAgLTE3LDE4ICsxNywyNCBAQCB0eXBlZGVmIHVuc2lnbmVkIGxvbmcgY3ljbGVzX3Q7ICAj
aWZkZWYNCj4gPiA+ID4gPiBDT05GSUdfNjRCSVQgIHN0YXRpYyBpbmxpbmUgY3ljbGVzX3QgZ2V0
X2N5Y2xlcyh2b2lkKSAgew0KPiA+ID4gPiA+IC0gcmV0dXJuIHJlYWRxX3JlbGF4ZWQoY2xpbnRf
dGltZV92YWwpOw0KPiA+ID4gPiA+ICsgaWYgKGNsaW50X3RpbWVfdmFsKQ0KPiA+ID4gPiA+ICsg
ICAgICAgICByZXR1cm4gcmVhZHFfcmVsYXhlZChjbGludF90aW1lX3ZhbCk7DQo+ID4gPiA+ID4g
KyByZXR1cm4gMDsNCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ICAjZWxzZSAvKiAhQ09ORklHXzY0
QklUICovDQo+ID4gPiA+ID4gIHN0YXRpYyBpbmxpbmUgdTMyIGdldF9jeWNsZXModm9pZCkNCj4g
PiA+ID4gPiAgew0KPiA+ID4gPiA+IC0gcmV0dXJuIHJlYWRsX3JlbGF4ZWQoKCh1MzIgKiljbGlu
dF90aW1lX3ZhbCkpOw0KPiA+ID4gPiA+ICsgaWYgKGNsaW50X3RpbWVfdmFsKQ0KPiA+ID4gPiA+
ICsgICAgICAgICByZXR1cm4gcmVhZGxfcmVsYXhlZCgoKHUzMiAqKWNsaW50X3RpbWVfdmFsKSk7
DQo+ID4gPiA+ID4gKyByZXR1cm4gMDsNCj4gPiA+ID4gPiAgfQ0KPiA+ID4gPiA+ICAjZGVmaW5l
IGdldF9jeWNsZXMgZ2V0X2N5Y2xlcw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICBzdGF0aWMgaW5s
aW5lIHUzMiBnZXRfY3ljbGVzX2hpKHZvaWQpICB7DQo+ID4gPiA+ID4gLSByZXR1cm4gcmVhZGxf
cmVsYXhlZCgoKHUzMiAqKWNsaW50X3RpbWVfdmFsKSArIDEpOw0KPiA+ID4gPiA+ICsgaWYgKGNs
aW50X3RpbWVfdmFsKQ0KPiA+ID4gPiA+ICsgICAgICAgICByZXR1cm4gcmVhZGxfcmVsYXhlZCgo
KHUzMiAqKWNsaW50X3RpbWVfdmFsKSArIDEpOw0KPiA+ID4gPiA+ICsgcmV0dXJuIDANCj4gPiA+
ID4gPiAgfQ0KPiA+ID4gPiA+ICAjZGVmaW5lIGdldF9jeWNsZXNfaGkgZ2V0X2N5Y2xlc19oaQ0K
PiA+ID4gPiA+ICAjZW5kaWYgLyogQ09ORklHXzY0QklUICovDQo+ID4gPiA+IA0KPiA+ID4gPiBB
cHBseWluZyB0aGlzIG9uIHRvcCBvZiByYzYsIEkgbm93IGdldCBhIGhhbmcgb24gS2VuZHJ5dGUg
Ym9vdC4uLg0KPiA+ID4gPiBObyBwcm9ibGVtcyB3aXRob3V0IHRoZSBwYXRjaCBvbiB0aGUgb3Ro
ZXIgaGFuZC4NCj4gPiA+IA0KPiA+ID4gTm90IHN1cmUgYWJvdXQgdGhlIGlzc3VlIHdpdGggS2Vu
ZHJ5dGUgYnV0IEkgZ2V0IGEgY3Jhc2ggb24NCj4gPiA+IFFFTVUgdmlydCBtYWNoaW5lIHdpdGhv
dXQgdGhpcyBwYXRjaC4NCj4gPiANCj4gPiBXaXRoIHRoaXMgYXBwbGllZCBpbiBhZGRpdGlvbiB0
byB5b3VyIHBhdGNoLCBpdCB3b3Jrcy4NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9j
bG9ja3NvdXJjZS90aW1lci1jbGludC5jIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci0NCj4g
PiBjbGludC5jDQo+ID4gaW5kZXggZDE3MzY3ZGVlMDJjLi44ZGJlYzg1OTc5ZmQgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jbGludC5jDQo+ID4gKysrIGIvZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci1jbGludC5jDQo+ID4gQEAgLTM3LDcgKzM3LDcgQEAgc3Rh
dGljIHVuc2lnbmVkIGxvbmcgY2xpbnRfdGltZXJfZnJlcTsNCj4gPiAgc3RhdGljIHVuc2lnbmVk
IGludCBjbGludF90aW1lcl9pcnE7DQo+ID4gDQo+ID4gICNpZmRlZiBDT05GSUdfUklTQ1ZfTV9N
T0RFDQo+ID4gLXU2NCBfX2lvbWVtICpjbGludF90aW1lX3ZhbDsNCj4gPiArdTY0IF9faW9tZW0g
KmNsaW50X3RpbWVfdmFsID0gTlVMTDsNCj4gPiAgI2VuZGlmDQo+ID4gDQo+ID4gIHN0YXRpYyB2
b2lkIGNsaW50X3NlbmRfaXBpKGNvbnN0IHN0cnVjdCBjcHVtYXNrICp0YXJnZXQpDQo+IA0KPiBB
aGgsIGNsaW50X3RpbWVfdmFsIGlzIGFuIHVuaW5pdGlhbGl6ZWQgdmFyaWFibGUuDQo+IA0KPiBJ
IHdpbGwgc2VuZCBhIHYyIHdpdGggeW91ciBTb0IuDQoNCk5vIG5lZWQgZm9yIG15IHNvYi4gSnVz
dCBtZXJnZSB0aGF0IGluIHlvdXIgcGF0Y2guDQoNCj4gDQo+IFJlZ2FyZHMsDQo+IEFudXANCj4g
DQo+ID4gLS0NCj4gPiBEYW1pZW4gTGUgTW9hbA0KPiA+IFdlc3Rlcm4gRGlnaXRhbA0KDQotLSAN
CkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0YWwNCg==
