Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9980C27E307
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgI3Hvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:51:41 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:60075 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgI3Hvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601452299; x=1632988299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZAjli6RJSPscFkZUAzuDpLjDdXPQTsrWnUM+VQjgggU=;
  b=2UmZTu1UfFyI2gn8RhpG1alKdX+YPWpV8Ti8ztZH6rqsdgiwVHDDrt4v
   yvmtad/3i5eLORDcDH54tQ2s/z/xXiocc9S0x72WPt6wZDeYoeJXJi8bh
   xIJfLGTRUO7rLanyLHvE1OBKhkIreQiBn7Yfi6mlXmYgpVQmkjiylc9gE
   9cc68NxSYPWLHtIH9jppchFFbgoVP3O2v2Ehe9/4HRy1MSTJnbu+nure+
   RyNAsOOQfZC7kk3i5J06/9UBb8bOHEtbsqr7CniKpWHyPXZpcq0kNouYa
   6g2y2k8X+xc+vYly+vRiHF52yy8O2FGnzZkk8CkwPyGwh3Lvf+/x54wTI
   A==;
IronPort-SDR: EyF74EnMl7M4LgizkIWVdDtKWqHIReAAePCtYw8fx+QDSGRxJyqoTb1YEokn/cPNANmhAHuoHf
 o5/RQh1EPx9IPjiWj/UmsYEQamAjJp1gT9ka173wB7hRaidsLRiQo4hTkEdjcSwOjiGnODCPNN
 NTD2TCE9DHADBgqBswDB9r+Ue+rLtJRS3JvfXHQmEwZVv8ijMGlW2qjAkhg4WYOgh56buHjaWo
 UWh2bpgLRvTlBQcvNkvRPwfrWgcZKCs5gDKTeJB/Zs3Lx5gqhgG7D0/EJXyjEQYmI74zs9F/sQ
 bFY=
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="28191639"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 00:51:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 00:51:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 30 Sep 2020 00:51:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P63+iR61rmr9feKrRAEzfZjDRa/4/Pxofjdnp10k4PxUef861H5LV3h4o76G3SLrCUHFtxv0xabm8jCwg7xsXzQCe+EBmxeMI8yeIl/u816aOgv7Po0yLdj2UCmrqCVJ7eB8T5y8kZUoklEGc6n0FslALXtSoFA985QtyRqCwMpk21sbzQCIJK5njavgt1H/Ba/1bMge+Oflg+4Iccp/NcDSU0cUphIepyMe1BfZGt61e5rkpba2Fo2Jf4HI4yprcQw0SGfKOIe9hIz11qjq6T4+dKRp9tyOV+gopfuiT1apGpnix2Mpn8IsvISFBW0aWzbUAciHy1gcFCtBxZPmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAjli6RJSPscFkZUAzuDpLjDdXPQTsrWnUM+VQjgggU=;
 b=kdfeRixH/tcT5koax2MC3albCdqEexSi5lvFXMlUAaXHmquEp/lrF+QIO1Q2FUu5yc9sp1MJXbzHOiuk0PwCQNP1x3W3oiCiFctMBE/enmH/Qyxmc0707lXIf5UoX4wCdUHg6KnBiBuHdWIRCoj0FGPZK/TEY1onnJSof6OFAexE0RzafIkWYJ18fq4EkvlXtQRullaaZtP2p9RIHBlCZr4TZ6nuzqvbxn6zbH1X1jOlhxJKyaD9FrXXxdX7Yeqiln2B8lYwK4lcLUYMH6Gr0U/aGoMCmg1UCfRmDmgPv8iThJm9z3TWZ3tyS56sqC5GZ33b8AgyjMFBkuD+M/OJIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAjli6RJSPscFkZUAzuDpLjDdXPQTsrWnUM+VQjgggU=;
 b=B1zo3aTFZK9+bVcXMyawm71X01sHZz84z8EcMm6yIt9rlO07/fiSMeCFlxAYrgeIc7gtStlTeyUh56Dzf8QtSW2CTzBxbtFgc+wmfBYyQsfue96zUSdIbjvaj/5xephPXSxCF/oFwJeS6nobL7QrPLJX1gISMwRDYUmXachcgiY=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM6PR11MB2650.namprd11.prod.outlook.com (20.176.98.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Wed, 30 Sep 2020 07:51:37 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 07:51:37 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 13/15] mtd: spi-nor: core: expose
 spi_nor_default_setup() in core.h
Thread-Topic: [PATCH v13 13/15] mtd: spi-nor: core: expose
 spi_nor_default_setup() in core.h
Thread-Index: AQHWlv6Gc8Ir4MjTDkiKaIPwKqe4Ew==
Date:   Wed, 30 Sep 2020 07:51:37 +0000
Message-ID: <ef62bf4e-1b2c-aa3e-39b7-fd8d118e582d@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200916124418.833-14-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-14-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: e8aab031-89e8-4bf0-97c3-08d86515a901
x-ms-traffictypediagnostic: DM6PR11MB2650:
x-microsoft-antispam-prvs: <DM6PR11MB2650108AC37460BD8D6FC235F0330@DM6PR11MB2650.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GgR61jbGE6kmT2M8EjrS8iXaqq5OGUYLfyAqiwEXL6yn5VXB1oJZH+zeQxexJZ7a+CwmZDIGs7QoQaNLwFc1W0av9YWOniXDfcZdKK+kjBjt2xyG6zKhUB72YOHsST/hkEBOB8C1TG+TNXo4qv1zS0JsUx0AXXLnL62hUcGxMzEKV21CM6ueaS33p+wyWt/L2EdT3N1fGABrDmA1t5hxHY9iIIuqv1oWuEw2UYnsgdut+e7ir1sR0I1d+VPZoeP7CPNj5VIps1mdhTHYzWUc5e3h+3gs+pfWre8riWGg3OvlhMh7Me8Tzt0TXQ+tlvoa4nwOxvlOO+cucM5+n9HWilZs17bLsHyayom/xZJukX1rMXbUog8lSHJ47MeyGW8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(136003)(366004)(110136005)(316002)(86362001)(54906003)(478600001)(76116006)(91956017)(66946007)(71200400001)(66446008)(64756008)(66556008)(66476007)(6506007)(26005)(36756003)(186003)(53546011)(5660300002)(2906002)(8676002)(4326008)(31696002)(6512007)(2616005)(6486002)(8936002)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QYyIw0i9DUoiQMjHcTvzHYotHyekF5AM4KyJNYJjS5Fi8B0O1WEIPBdXivVShRfv/xunesT/5vY1JeE1K/M/wkZsz2lS3BXfiTMiuDv6jfLCa8dkmevs6B6LpyfW1REM6Oy0o8Sng/tjhSOjt+Vs4gBEA2rGN+sc9IJKeFFlt2bLmdaUTU3GjnryKsSdbv0DKj+RpatBPJ5VYds2yBSJbSMMIsuUynvtZDJQy4Ra44nI/4BEIcDyDafL/++aXS2j5OV/MjFMewutAxbyV1wyx8HsGecdUu2wzIyndyrqKWyWDrYfOhkZryYiR+mcQGbjVxZlQa+iwC93qf1xZzU50hxyI26eMzWPSgPR6bk+7S5uT8IbRv/vyZULBxKS9IzskBY7E0xCNzRWOINqR2PBFaZhv1/E/JXpmWbw8LPYpV06NoQuOS5nKeKJ6y0h4Y9ffbYTaim8Zy4wALQpB+kmkR1EMWi67wJj3Xvn++Ft3BVJrgkL3vZroq48mYP9nYqBzTARq+UEw/ux9iacboDe1SJYJOk9QSYn+1xUWBgeXPgmhom5dFpgONGxqn7PcWR6I2l7nHHOi/yhfDSicgkiL2FWWMHklT8LamTFMHiBqUtlN7OB/0sIgHbWjj68JZuJY1dutrgei301M/5o4GMuqg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A07D6BE49333240B4F98E6332ED62C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8aab031-89e8-4bf0-97c3-08d86515a901
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 07:51:37.5328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rb3oSyJ67whgwvLPdXCVA53iyeUwjNHmg5KxD0cyyvTELKswCnCHe0vDhDrs+R8hNeAtHNp9BuFdFlMwnkmmOtKqj+rHg/CR+r8Bj3AQAPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2650
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGbGFzaGVzIG1pZ2h0IHdhbnQgdG8gYWRkIGEg
Y3VzdG9tIHNldHVwIGhvb2sgdG8gY29uZmlndXJlIHRoZSBmbGFzaCBpbg0KPiB0aGUgcHJvcGVy
IG1vZGUgZm9yIG9wZXJhdGlvbi4gQnV0IGFmdGVyIHRoYXQsIHRoZXkgd291bGQgc3RpbGwgd2Fu
dCB0bw0KPiBydW4gdGhlIGRlZmF1bHQgc2V0dXAgaG9vayBiZWNhdXNlIGl0IHNlbGVjdHMgdGhl
IHJlYWQsIHByb2dyYW0sIGFuZA0KPiBlcmFzZSBvcGVyYXRpb25zLiBTaW5jZSB0aGVyZSBpcyBs
aXR0bGUgcG9pbnQgaW4gcmVwZWF0aW5nIGFsbCB0aGF0DQo+IGNvZGUsIGV4cG9zZSB0aGUgc3Bp
X25vcl9kZWZhdWx0X3NldHVwKCkgaW4gY29yZS5oIHRvDQo+IG1hbnVmYWN0dXJlci1zcGVjaWZp
YyBmaWxlcy4NCg0KQnV0IHlvdSBkb24ndCB1c2UgaXQgaW4gdGhlIGZvbGxvd2luZyBwYXRjaGVz
LiBDYW4gd2UgZHJvcCB0aGlzIG9uZSBmb3Igbm93Pw0KPiANCj4gU2lnbmVkLW9mZi1ieTogUHJh
dHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbXRkL3NwaS1u
b3IvY29yZS5jIHwgNCArKy0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaCB8IDMgKysr
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRk
L3NwaS1ub3IvY29yZS5jDQo+IGluZGV4IGQ1YzkyYzljNzMwNy4uMzRlZGZjZjMzMTcyIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPiArKysgYi9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuYw0KPiBAQCAtMjc1OSw4ICsyNzU5LDggQEAgc3RhdGljIGludCBzcGlf
bm9yX3NlbGVjdF9lcmFzZShzdHJ1Y3Qgc3BpX25vciAqbm9yKQ0KPiAgICAgICAgIHJldHVybiAw
Ow0KPiAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgc3BpX25vcl9kZWZhdWx0X3NldHVwKHN0cnVjdCBz
cGlfbm9yICpub3IsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0
cnVjdCBzcGlfbm9yX2h3Y2FwcyAqaHdjYXBzKQ0KPiAraW50IHNwaV9ub3JfZGVmYXVsdF9zZXR1
cChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0
IHN0cnVjdCBzcGlfbm9yX2h3Y2FwcyAqaHdjYXBzKQ0KPiAgew0KPiAgICAgICAgIHN0cnVjdCBz
cGlfbm9yX2ZsYXNoX3BhcmFtZXRlciAqcGFyYW1zID0gbm9yLT5wYXJhbXM7DQo+ICAgICAgICAg
dTMyIGlnbm9yZWRfbWFzaywgc2hhcmVkX21hc2s7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210
ZC9zcGktbm9yL2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+IGluZGV4IGUy
YzczMjRkOTk3ZS4uMTBkYzAzNTA2ZjkzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPiBAQCAtNDUz
LDYgKzQ1Myw5IEBAIGludCBzcGlfbm9yX3Bvc3RfYmZwdF9maXh1cHMoc3RydWN0IHNwaV9ub3Ig
Km5vciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgc2ZkcF9i
ZnB0ICpiZnB0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzcGlfbm9y
X2ZsYXNoX3BhcmFtZXRlciAqcGFyYW1zKTsNCj4gDQo+ICtpbnQgc3BpX25vcl9kZWZhdWx0X3Nl
dHVwKHN0cnVjdCBzcGlfbm9yICpub3IsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgY29u
c3Qgc3RydWN0IHNwaV9ub3JfaHdjYXBzICpod2NhcHMpOw0KPiArDQo+ICBzdGF0aWMgc3RydWN0
IHNwaV9ub3IgX19tYXliZV91bnVzZWQgKm10ZF90b19zcGlfbm9yKHN0cnVjdCBtdGRfaW5mbyAq
bXRkKQ0KPiAgew0KPiAgICAgICAgIHJldHVybiBtdGQtPnByaXY7DQo+IC0tDQo+IDIuMjguMA0K
PiANCg0K
