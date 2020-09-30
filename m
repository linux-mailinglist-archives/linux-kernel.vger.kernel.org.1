Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B527E5C7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 11:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgI3J5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 05:57:12 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:12294 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI3J5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 05:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601459830; x=1632995830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oy+zjxaLiiUd0sbpo1fg3iDBOFpEZaUXO3vi2U33xiI=;
  b=Q6JFZ4Cjatd8wRBtpTW3wTflCBRti+Zj9Xg/KEkA3dFsLTxImJBCxSEh
   HxJ07sqawgM9GlQ4nc5sQ8wadnlOjMydgTgFKXyXvXobBXtRZviLY7gE3
   FEpIsW2tt6ArQfm4KTOkSrHY1io49k9Y3HZLdlodWcLkDdXzKrQNU6Gwn
   NWJGj7C22yuoDaToJRnO7kQo395bqnGc6Be48SyxDWQE1Qx4jEUCOon63
   BCGCB5xAQs8TmH2g5+Dpw35Ig5HXyr29I4EBi+VEd7rjcQQax5fO1DAMR
   PFDBxPHwPuce0zUcDPY3q5+8tLcBVO2DipMToBDylbemOHwfrRApO2vFu
   w==;
IronPort-SDR: CqgIw+gmdD1T38n9iylH8rkCWjm8uyACW/bITQBmlNYmcPj3VozrTdyzvmbhODiHAl0bAuKcxf
 B07SV6fl3YhyN7nlXiYm78r7lYegiHSW1SwM4+YLb/LqdhHYNYjpxtvPJjS6wbx3ZHF68RwD1T
 kN9Jn7OdscPUgTyJ2rljD+VRITDbie558s7Gp07M8NpuGiwSJ00Ma9u62Cy7aHYQIVz3h+Agj5
 UBbLMv3T26hivpUuZBPRz0nSCX7ghB3DirLUj1UD0/kN+SDDWf8IfnZt4HGVJie4AMkYd8gsfo
 FVA=
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="90923872"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 02:57:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 02:57:10 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 30 Sep 2020 02:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiAckfMacbIhe+TsUn9Su8gmGAuLlAMbmPNFoJ9MCesMKMLuCCGO+L5CXQUy7Ei2UenFFK1HftVBKQDPHeE1i3Qf8vCchsSLNTApj/ZjT+FrdFOcb8t/P+tGaLAAu4/WBNl/mE/CR156Horo+tuto/Qs1ZadlcD1Ta6snvHW3AAJNa0A4BKkseY9mUReDajwe24f9yXgZ8xa2GuKDyeLo+1xlYMSqcBN8XmiAobOSDGcV04gk8Tw3Bw8dshrg9bsE22YZFuDNVmJvGhoBJURGv8mZHPT3aziVEu7DidTOhBu1l0PI5kQx2FT8SVs/1r2+dKJ6dqazvo5XWgKI3cyKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy+zjxaLiiUd0sbpo1fg3iDBOFpEZaUXO3vi2U33xiI=;
 b=JOZKBapDz2kyBJxWpds9jm4DHdfFF29zzqm/9tnDnOqtgXPHBbI1YTJZ9WOHd8t+YiwIFZ1WE5bqBpt8eoTRMTAqUdSaS+1LRj+vpvEnHs/kGdU4phaXi6fSruOIHy0xV2ZJQON5LOeUU9e/6xzyDx74q/VOHpxaR3JAImtuoR3j/mEPzDSi1JS2NunW6+GeYN073jqQRN4LrZ8xsBQkKZcEzv/kZKM70/1GFb2YlwMYXP7NQGTyJ8afCq9o4g6hktVe3qTyW7PjkSgUFmZIjnY7Qz4XHVadOzKpw2jJ0y7lQEnoJeC7fzwoAsTS+zbZwythL2Ekqhp2Rb0STrRRfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy+zjxaLiiUd0sbpo1fg3iDBOFpEZaUXO3vi2U33xiI=;
 b=XOGACClKFX1XhDXHcPMZblIYfTPPWO48rTJ6Sfa5WBpyU2yZffvda9SFoxQs3G+Tk77nqhKRLhERRGPVmOrkGlK7EvGDJa4khy768OHMt0mZ/ZbWIEdIH5RL/RJ1dQnnXpWdlWAKKBiLY7K0+mviYrRlWmxROwU0KRwITPKsd1c=
Received: from DM5PR11MB1914.namprd11.prod.outlook.com (10.175.91.12) by
 DM6PR11MB3242.namprd11.prod.outlook.com (20.176.120.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.29; Wed, 30 Sep 2020 09:57:06 +0000
Received: from DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a]) by DM5PR11MB1914.namprd11.prod.outlook.com
 ([fe80::f44a:f58e:c13b:947a%4]) with mapi id 15.20.3433.032; Wed, 30 Sep 2020
 09:57:06 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nsekhar@ti.com>, <boris.brezillon@collabora.com>
Subject: Re: [PATCH v13 00/15] mtd: spi-nor: add xSPI Octal DTR support
Thread-Topic: [PATCH v13 00/15] mtd: spi-nor: add xSPI Octal DTR support
Thread-Index: AQHWlxANNWms9uU8o0WS4BnhtiydLg==
Date:   Wed, 30 Sep 2020 09:57:06 +0000
Message-ID: <1cd1b952-9126-516f-d8a7-91149a815ff0@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
In-Reply-To: <20200916124418.833-1-p.yadav@ti.com>
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
x-ms-office365-filtering-correlation-id: 5b04dd2d-5461-414b-8ae2-08d8652730ac
x-ms-traffictypediagnostic: DM6PR11MB3242:
x-microsoft-antispam-prvs: <DM6PR11MB32420444CC3B9C552A71134AF0330@DM6PR11MB3242.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8VPBSChpM96R0HZkqDHBfopu+q3XI9qDN381+BODrGW0YwhBHGuMUwwn9WpAMpjUic4TFl4qOLFAs+Xcmeoixi1I8uoJZXmK+sXd20cOWWltCIzYy5FjqcIzwaC+qRigwfU3w8+VoDh8uXMwYO8J0nWNTm2pLicKnefihzhRWbVa/v+eBY/LQ/rNoKz3xDpJx39gcBMxbLDsZaCvHdFN23ub3JLcEdqJ+nYmnES8E0TvAT1nk6bk66hxwha2QldAz2UCArxjr4714/A2mvMcemAlrZgzWXRl0Z0o+zmdajRXHBWN0ZBLqQ9cIuRXY8QpuB3puylJlZEPLtB/7BhSa2cllu4ptYHFJd1OZHv49X3eBTX5SncVP+DDgcDglLmNmhi+4owOoCCpFX5+9EVzK6j6BvtSGVsreAuleSDMIucqAHIZpAjncNlOHLO5E5rB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(6506007)(53546011)(31686004)(478600001)(66446008)(83380400001)(64756008)(66556008)(66476007)(8936002)(5660300002)(36756003)(6512007)(4326008)(86362001)(2906002)(26005)(2616005)(71200400001)(91956017)(66946007)(76116006)(31696002)(6486002)(8676002)(54906003)(316002)(110136005)(186003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Zy5BxJ1RF0teLLFjyf9XQ4szclIEN0E5VC6KmTsLxalKQSiYVn0swk8Kit4smfjade7JqPdWYkLufwGTa4xCaa2RHAXMM760Ddz4YUuuKLja/QasFxcVFLOrwTFc/3hjV6k1ry0xVqkSvNSn5QZenC8DcaeDQ0S0qLW9WE5QY1KqZ/qUCzvLE49DVLP5yhUooB4SIsj5xiXkxPfAlQn44MqMqmm7ph3bLFz8Zcnlh+PyZa6ijqcxcbiiytDH69o0PqrA0w7tHwbkKqXz6MT/paJOf8fDTIa6GnNkbDqD7pY1ubCbEW4ykGV4IEf2I+yLG6n5wqBD7tP/WEhSKtNWsUe9RLKPxJwKcRnvY4wWOVC1SPoqvNFkdq53ZTRZ1beAFuE3li8U2/nCD7ul0h+0/uLswhwfRGBfOWKlfIZtXpLIMH9o2KDRJ+ppE3vC2wzQVNqOYbxPqOh0kCLkWTXIaq/iNV0xM5UkC5OdAXZvljYTk3kxNKWkydvTxWfQWBBpUJVApGP85deIaareq0UQIUj9rA6pHvAcrg7iZihLLB4kEuMQOWKwXuSdgb9xK0LoabuMYAQyczcOQRO/7/mU00idMNYhBoZDn9LboDBI3QHEtudd+w0x6l4Jhd7BDnp4C0CaWqOFGb2AjjVvsVfyxw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8F6EA078592F744697B7D7EB5018B968@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b04dd2d-5461-414b-8ae2-08d8652730ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2020 09:57:06.6289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zi++KMPqHLCS2tVDsAxjuOZuKbQvEJRFlrfwMK+pI4CPEqGt3lDbnxLlmGtayH9BSgiYXom34yvJESpZfpRGwRLKFJHAEqpJUCsBYrqc6/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOS8xNi8yMCAzOjQ0IFBNLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gSGksDQoNCkhlbGxv
LA0KDQo+IA0KPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIE9jdGFsIERUUiBmbGFzaGVz
IGluIHRoZSBTUEkgTk9SIGZyYW1ld29yaywNCj4gYW5kIHRoZW4gYWRkcyBob29rcyBmb3IgdGhl
IEN5cHJlc3MgU2VtcGVyIGFuZCBNaWNyb24gWGNlbGxhIGZsYXNoZXMgdG8NCj4gYWxsb3cgcnVu
bmluZyB0aGVtIGluIE9jdGFsIERUUiBtb2RlLiBUaGlzIHNlcmllcyBhc3N1bWVzIHRoYXQgdGhl
IGZsYXNoDQo+IGlzIGhhbmRlZCB0byB0aGUga2VybmVsIGluIExlZ2FjeSBTUEkgbW9kZS4NCj4g
DQoNCkkgbGlrZSB0aGlzIHNlcmllcy4gVGhlcmUgYXJlIHNvbWUgY29tbWVudHMgdGhhdCBjYW4g
YmUgYWRkcmVzc2VkLCBubyBiaWcNCmRlYWwgdGhvdWdoLg0KDQpJIHRoaW5rIHRoYXQgd2Ugc2hv
dWxkbid0IGxldCB0aGUgZG9vciBvcGVuIGZvciB1c2VycyB3aXRoIGZsYXNoZXMgdGhhdA0KZW50
ZXIgaW4gYSBYLVgtWCBtb2RlIGluIGEgbm9uLXZvbGF0aWxlIHdheS4gVGhpbmsgb2YgdHdvIGZs
YXNoZXMgdGhhdCBoYXZlDQp0aGUgc2FtZSBYLVgtWCBtb2RlIGVuYWJsZSBzZXF1ZW5jZSwgYnV0
IGluIHdoaWNoIG9ubHkgdGhlIEVOIGJpdCBkaWZmZXJzOg0KZm9yIG9uZSB0aGUgRU4gYml0IGlz
IHZvbGF0aWxlIGFuZCBmb3IgdGhlIG90aGVyIGl0IGlzIG5vbi12b2xhdGlsZS4gVXNlcnMNCm9m
IHRoZSBsYXRlciBmbGFzaCB0aGF0IHRyeSB0byBlbmFibGUgdGhlIFgtWC1YIG1vZGUgKHVzaW5n
IG91ciBjb2RlKSB3aWxsDQplbmQgdXAgd2l0aCB0aGUgZmxhc2ggaW4gYSBtb2RlIGZyb20gd2hp
Y2ggdGhleSBjYW4ndCByZWNvdmVyLiBUaHVzIG15IGFkdmljZQ0KaXMgdG8gY29uc2lkZXIgYnkg
ZGVmYXVsdCBhbGwgdGhlIGZsYXNoZXMsIGFzIFgtWC1YIG1vZGUgbm9uLXZvbGF0aWxlIGZsYXNo
ZXMsDQphbmQgdG8gbm90IGxldCB0aGVtIHVzZSB0aGUgWC1YLVggbW9kZSBlbmFibGUgbWV0aG9k
cy4gRmxhc2hlcyB0aGF0IGNhbiBlbnRlcg0KWC1YLVggbW9kZXMgaW4gYSB2b2xhdGlsZSB3YXks
IHNob3VsZCBkaXNjb3ZlciB0aGlzIGNhcGFiaWxpdHkgYnkgcGFyc2luZyB0aGUNCm9wdGlvbmFs
IFNGRFAgU0NDUiBNYXAuIFRob3NlIHRoYXQgZG9uJ3QgZGVmaW5lIHRoaXMgdGFibGUsIHNob3Vs
ZCBwYXNzIHRoaXMNCmNhcGFiaWxpdHkgYXMgYSBmbGFzaF9pbmZvIGZsYWcgd2hlbiBkZWNsYXJp
bmcgdGhlIGZsYXNoLiBXaXRoIHRoZXNlLCB1c2Vycw0Kc2hvdWxkIGJlIGNvbnNjaW91cyBhYm91
dCB0aGUgViBvciBOViBtb2RlcywgYW5kIHRoZSByaXNrIHRvIGVuZCB1cCB3aXRoDQpmbGFzaGVz
IGZvciB3aGljaCB0aGVyZSBpcyBubyBzb2Z0d2FyZSB0byByZWNvdmVyIGlzIGRpbWluaXNoZWQu
IFRoaXMgaXMgd2hhdA0KSSB0cmllZCBpbiBSRkMgMS8zIGFuZCBSRkMgMy8zLiBJIHRoaW5rIHRo
b3NlIDIgcGF0Y2hlcyBzaG91bGQgYmUgcGFydCBvZg0KdGhpcyBzZXJpZXMuIDE0LzE1IGFuZCAx
NS8xNSBzaG91bGQgYmUgdXBkYXRlZCBhY2NvcmRpbmdseS4gUkZDIDIvMyBoYXMgcm9vbQ0KZm9y
IGRpc2N1c3Npb25zIGJlY2F1c2UgaXQgcHJvdmlkZXMgYWNjZXNzIHN5c3RlbS13aXNlLCB3aGls
ZSBpZGVhbGx5IHdvdWxkIGJlDQp0byBkbyBpdCBhdCBmbGFzaCBncmFudWxhcml0eS4gSSdsbCB3
YWl0IGZvciB5b3VyIGZlZWRiYWNrIG9uIHRob3NlLg0KDQo+IFRlc3RlZCBvbiBUSSBKNzIxRSBF
Vk0gd2l0aCAxLWJpdCBFQ0Mgb24gdGhlIEN5cHJlc3MgZmxhc2guDQoNCkFzIGEgdGlwLCB3aGVu
IGludHJvZHVjaW5nIHNvbWUgYmlnIGNoYW5nZXMgdG8gdGhlIGNvcmUsIHdvdWxkIGJlIG5pY2Ug
dG8gYmUNCmFzc3VyZWQgdGhhdCB0aGluZ3MgdGhhdCB3b3JrZWQgcHJldmlvdXNseSBhcmUgc3Rp
bGwgd29ya2luZyBub3cuDQpBbiBlcmFzZS13cml0ZS1yZWFkLWJhY2sgdGVzdCBpbiBRdWFkIFNQ
SSB3b3VsZCBzdWZmaWNlLiBQcm9iYWJseSB5b3UgaGF2ZQ0KYWxyZWFkeSBkaWQgdGhhdCwgYnV0
IEkgaGF2ZW4ndCBzZWVuIGl0IG1lbnRpb25lZC4NCg0KQ2hlZXJzLA0KdGENCg0K
