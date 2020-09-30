Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7015827E284
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbgI3HXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:23:10 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:36534 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3HXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601450590; x=1632986590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SI+SazYUtOAc1ZjlQzmU7raWR/7kT/kpGONZ5OdspuI=;
  b=O9pUGIE1vlL5NdG603uzfybQRaVZTxP2oqKCu7U+rKVFttHhFuequ01d
   hiuuqy+VbEfEAMz46Ke6J9y5PgSup+vaQVklEHKq0RzHU62oT0H3zcbG5
   pqTbUvvG95ZrSw1ol20XyPMVc2MrzMpVi8U72kkWXiNLL6+rvwh7Ldg5d
   Wa9WCz6KGNAnGcI2D8yaj11NAG4jNHCapCp5mAHZgq8Ult9FjX12E+GMe
   gB29L5slMzHgwTzNtbBdFGHkf0ZrwLthniW/jqMln37cdhZxerhu5M7fU
   iF5f6hu4pml/2SrusK+9qF8JxPuB18/6BVi3V17Bj0BHBwQ2Gu482Fo8g
   A==;
IronPort-SDR: DuqUSN3IPq/5c/N8alkoiJVLWDOuXFj0QdNcmXngZX9Z16OCl3hhcsnhiiLG0Tn+DCAseqx9nC
 2Dw+7lyhSZSZElzHba3UHfdUv2MGP+N04NRtG86ZamgxBr4VCIt2swKpBz8BfhB5O+f5L/V+0h
 N4nyueq1GmwlH69fc9prXkOuGGgL9wT+syKnNHBS/zX6KP88MHufM8Wu9oeIWNAjA+WbLo5x4m
 vSsTjOhMRR2Vjf2mKYLJOCbedKVSwxRHC4ryEbRQUYkCZhzbrwPxiGuC9PbZahdK2LxTZEM82D
 7Cg=
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="92916250"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 00:23:10 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 00:23:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Sep 2020 00:22:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb1598zKzu1IYOY1ZpNQxVJadN0ASM/+z7LNniY7ngb/KKpUz0tVNGmHcJC48/MfTt0KV3sGU+44F2oasC7evLsneifIQ8LQyhab95qljJ5ly1SDrhizQI/CqiocB9xZpfrczoPhmUk3JlGGPH0pJq33LLaiEI9fo5Oph56MY0/tGY3puRCJYIO/JOAHjzqH/SLugNRQsMB0NqAgOlcCUGEgQYr2+sZmsYGHxFtCpmelFEAi3CZ2OhRLij42PUXFch9bjYkcVSu5B2iKJGJpE1OMwaOkUIXrB0v1wYrPE4OgHQggSY6pPIwRJ5SF0kl4ghSKviLrYqSvGy1sWSX6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI+SazYUtOAc1ZjlQzmU7raWR/7kT/kpGONZ5OdspuI=;
 b=ALFBZGAHtI60/EaVl1/gmmrY43i34zdOk7QEGxFuXcxT3xQQwodYu1Zecq1wowCNLExQDDPwFM1RMpni5R2iW2Kt10N7BBtPqs3dASuesi7QtU+xE2E+r47olRZFSSVknmOjn67oGVoH1dZjRM6V23JlFixo+fJ+40m+RkxdhmYrgxbz3eiqmA/Yq6fqGZvGr20r00W6Kr1pgEA9wwQX1HRrdq1nh7MnG2sQQha0Ta7XAKPFER3BvF1XRzHrEt7Q29hW3u+UuGVZZUwh/H5qSpgV2YWHboGVTEbrQC4LDT/yxgdMKox5VzjWgHTGKBa6QK3PIJuFUsDL4bJ76v3HlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI+SazYUtOAc1ZjlQzmU7raWR/7kT/kpGONZ5OdspuI=;
 b=udzFvZuRxHs+sHCEEiLU55wRl9h5IJmgGZOaNCCts96rFBPh2MoDxRhHHKtti9Tt8h4sZOwP2faLGyK3alil8WEkh4M9QtD3Xt+5XA9kiSTpB+Bn/vO5j0WE54KfEYAwO+kJ9QPpDaRpokvRVvVDVcfaid2EsBxdHTpulO8CAAs=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM6PR11MB3401.namprd11.prod.outlook.com (20.176.119.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34; Wed, 30 Sep 2020 07:23:04 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 07:23:04 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 10/15] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Thread-Topic: [PATCH v13 10/15] mtd: spi-nor: sfdp: detect Soft Reset sequence
 support from BFPT
Thread-Index: AQHWlvqIHkQZTJ8xTUKPfCCAzBC5iw==
Date:   Wed, 30 Sep 2020 07:23:04 +0000
Message-ID: <8346524d-487b-a147-6183-e8055a7ff54a@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-11-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-11-p.yadav@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.187]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d43a4c88-d7a4-4669-4ccc-08d86511abba
x-ms-traffictypediagnostic: DM6PR11MB3401:
x-microsoft-antispam-prvs: <DM6PR11MB340136FE8EA39B8D5649934BF0330@DM6PR11MB3401.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wk9xK5+uqV2Dn5TXs7Pj8w3eXsBGj8YYggSDyqowIxRaGnaRPSCFBceAOTr5DbGdufg78IC8GwIaTlDMI7zGhcSs0SBuyPVmDEZA5P/bDAj/ShK+n8RTbu7Hldmbwhxq7EqSN1unTWBgL2IoO50NOYR4FlHA2AdJ+W7A8bupRK+ozVisZkPYQpoehkDOL1n65BEU8kgTvi2ANVhPG67wjenTaTOKkWLKFq9mzCba/5kKt/Fu5aC49sHaMGz2N1Ed/PwnuT96teghjg4FthjIKPtAASFIc/Q7TQ9jsRwwRd+MfWuNNJhTTga1ok+P99Rko1kqGkC34SP3KZZLc8Ztg5xv0dyF3QtXlpVLeHLIrDq7HPIoEwLT4AQYD6xjKdl2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(2906002)(26005)(66946007)(91956017)(76116006)(66446008)(186003)(4326008)(64756008)(66476007)(66556008)(8676002)(6506007)(2616005)(31686004)(53546011)(6512007)(8936002)(6486002)(5660300002)(36756003)(31696002)(316002)(86362001)(54906003)(71200400001)(110136005)(478600001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RacwX+iixmt80ExDmWaKQ1igOrZ40M7fhBl5Al/I/iYrjswpqCqj2BVf1VsaHtjk+6daA5InRuzRZonUaqO6cjZ9Bpj6qGnVIEkr2lor8cEgxoe/y+RM0RAEASvTiL2LXAZvkqmhTJ+viVOxIHI0qEoBbokbh1F7MCFDaOrF+U3pAyZ7L0J7HVwrHRa8w2uoclcp6RA/yvlxrR/9Te8h++u67CKonhtGnJOjUxeyvMwgonABjcx/HaU3BfboDXpb/JseM5aRCED/DLdaIF6qlMF2Vr0yVSxvPvBsKR9VlB0kMT3S3sjRTYC37B0kiR7K5P90IyA2267k/vKsI4o5h6lc1J3q8KAdHCIYZMz1RhcljKIp2rpRJseuA9Y2kmB+fnPL7xtutN6FVCDYFV/qJ24V1pSHQGu5wBwCEZp/9PJn1p3Ccrj2nXKdk8ifM9k3NpYL9b5vles+XppOXseuPyEanfF1/z2uocGLN4TLfK3nY8wL32aeM0ZmJQFH4bBFPC0gbWKvPZOuorsT5ycyr4zUzMYZAolyqlQfEk+66vLRgLkia5sQaAMcrP7FbR83O/Ecl6uVSdA3RJ2iYYcvrZzqy36dBYkXgWNQmelXrT7Eqc664Css6vQcGue7FZXDVhWK+ti9y8PHx0XOjZdp2g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BA8D8F70AC7A34DAA49D91508C28096@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43a4c88-d7a4-4669-4ccc-08d86511abba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:23:04.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XnO8hgJka+p3SEn39ajDwt/k5uE2pNilJU+G3GRcZdvcXJqp+l8hoXIypeg1r/tZwUuOdq2U87lTPffiNCOCE496Y2NmWrdzemeLZjMuzrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3401
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBIFNvZnQgUmVzZXQgc2VxdWVuY2Ugd2lsbCBy
ZXR1cm4gdGhlIGZsYXNoIHRvIFBvd2VyLW9uLVJlc2V0IChQT1IpDQo+IHN0YXRlLiBJdCBjb25z
aXN0cyBvZiB0d28gY29tbWFuZHM6IFNvZnQgUmVzZXQgRW5hYmxlIGFuZCBTb2Z0IFJlc2V0Lg0K
PiBGaW5kIG91dCBpZiB0aGUgc2VxdWVuY2UgaXMgc3VwcG9ydGVkIGZyb20gQkZQVCBEV09SRCAx
Ni4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFByYXR5dXNoIFlhZGF2IDxwLnlhZGF2QHRpLmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCB8IDEgKw0KPiAgZHJpdmVycy9t
dGQvc3BpLW5vci9zZmRwLmMgfCA0ICsrKysNCj4gIGRyaXZlcnMvbXRkL3NwaS1ub3Ivc2ZkcC5o
IHwgMiArKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5oDQo+IGluZGV4IGZjYjVmMDcxZWJlZC4uZTJjNzMyNGQ5OTdlIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuaA0KPiBAQCAtMjYsNiArMjYsNyBAQCBlbnVtIHNwaV9ub3Jfb3B0aW9uX2ZsYWdzIHsN
Cj4gICAgICAgICBTTk9SX0ZfSEFTX1NSX1RCX0JJVDYgICA9IEJJVCgxMSksDQo+ICAgICAgICAg
U05PUl9GX0hBU180QklUX0JQICAgICAgPSBCSVQoMTIpLA0KPiAgICAgICAgIFNOT1JfRl9IQVNf
U1JfQlAzX0JJVDYgID0gQklUKDEzKSwNCj4gKyAgICAgICBTTk9SX0ZfU09GVF9SRVNFVCAgICAg
ICA9IEJJVCgxNCksDQo+ICB9Ow0KPiANCj4gIHN0cnVjdCBzcGlfbm9yX3JlYWRfY29tbWFuZCB7
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3Ivc2ZkcC5jDQo+IGluZGV4IGNhZGIxZWQyN2ZmZS4uZjE5MjcxMGFjYTMxIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYw0KPiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL3NmZHAuYw0KPiBAQCAtNjA0LDYgKzYwNCwxMCBAQCBzdGF0aWMgaW50IHNwaV9u
b3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgICAgICAgICAgICAgICAgYnJl
YWs7DQo+ICAgICAgICAgfQ0KPiANCj4gKyAgICAgICAvKiBTb2Z0IFJlc2V0IHN1cHBvcnQuICov
DQo+ICsgICAgICAgaWYgKGJmcHQuZHdvcmRzW0JGUFRfRFdPUkQoMTYpXSAmIEJGUFRfRFdPUkQx
Nl9TT0ZUX1JTVCkNCj4gKyAgICAgICAgICAgICAgIG5vci0+ZmxhZ3MgfD0gU05PUl9GX1NPRlRf
UkVTRVQ7DQoNCm1pbmltYWwgc3VwcG9ydCBmb3IgU1dSU1QgYnV0IHdlIGNhbiBleHRlbmQgaXQg
bGF0ZXIuIExvb2tzIGdvb2QuDQoNCj4gKw0KPiAgICAgICAgIC8qIFN0b3AgaGVyZSBpZiBub3Qg
SkVTRDIxNiByZXYgQyBvciBsYXRlci4gKi8NCj4gICAgICAgICBpZiAoYmZwdF9oZWFkZXItPmxl
bmd0aCA9PSBCRlBUX0RXT1JEX01BWF9KRVNEMjE2QikNCj4gICAgICAgICAgICAgICAgIHJldHVy
biBzcGlfbm9yX3Bvc3RfYmZwdF9maXh1cHMobm9yLCBiZnB0X2hlYWRlciwgJmJmcHQsDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaCBiL2RyaXZlcnMvbXRkL3NwaS1u
b3Ivc2ZkcC5oDQo+IGluZGV4IDZkNzI0MzA2NzI1Mi4uOGFlNTVlOTgwODRlIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL3NmZHAuaA0KPiBAQCAtOTAsNiArOTAsOCBAQCBzdHJ1Y3Qgc2ZkcF9iZnB0IHsNCj4gICNk
ZWZpbmUgQkZQVF9EV09SRDE1X1FFUl9TUjJfQklUMV9OT19SRCAgICAgICAgICAgICAgICAoMHg0
VUwgPDwgMjApDQo+ICAjZGVmaW5lIEJGUFRfRFdPUkQxNV9RRVJfU1IyX0JJVDEgICAgICAgICAg
ICAgICgweDVVTCA8PCAyMCkgLyogU3BhbnNpb24gKi8NCj4gDQo+ICsjZGVmaW5lIEJGUFRfRFdP
UkQxNl9TT0ZUX1JTVCAgICAgICAgICAgICAgICAgIEJJVCgxMikNCg0KdGhlIG5hbWUgaXMgdG9v
IGdlbmVyaWMuIEhvdyBhYm91dA0KDQojZGVmaW5lIEJGUFRfRFdPUkQxNl9TV1JTVF9FTl9SU1QJ
CUJJVCgxMikNCg0KPiArDQo+ICAjZGVmaW5lIEJGUFRfRFdPUkQxOF9DTURfRVhUX01BU0sgICAg
ICAgICAgICAgIEdFTk1BU0soMzAsIDI5KQ0KPiAgI2RlZmluZSBCRlBUX0RXT1JEMThfQ01EX0VY
VF9SRVAgICAgICAgICAgICAgICAoMHgwVUwgPDwgMjkpIC8qIFJlcGVhdCAqLw0KPiAgI2RlZmlu
ZSBCRlBUX0RXT1JEMThfQ01EX0VYVF9JTlYgICAgICAgICAgICAgICAoMHgxVUwgPDwgMjkpIC8q
IEludmVydCAqLw0KPiAtLQ0KPiAyLjI4LjANCj4gDQoNCg==
