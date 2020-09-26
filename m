Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB32F27982A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgIZJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 05:25:35 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22863 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZJZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 05:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601112334; x=1632648334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x/1g18k0KP6s02Yc3v7a7SWPdZ/LjQcuMc3TOCrVK2Y=;
  b=HJJnqifI18GEp/2P/nKSFr64RUo6F1y9ijvGvqTKO03YIBTV7jLD4MdN
   3YSvv33B85WTVMWAxkZluh8nw8J3pijPAP5j7UI+Q5t+Iapk/ynbDjhYs
   m9aeUZCn2SH1v3fveRhIl/fYNi+LGXGHTD1EQ4OpnIEn/ikdxow1lxvel
   w6lbVhEXx2vAu0Fv1PvstJpDyyQyekMp6VTZiveEL7dYG7J4axgA//Kdz
   sDKG7srI0B867ZPPSwj5alxImrduFRdpGUi7VBFSVBj2ibJfgTqPM+gsB
   vLOELMuihhnGDWbMMHOvM3O9xzhIW75+qrxjzlg6a4tjgunWQogyad/uM
   A==;
IronPort-SDR: IVBb45TCeQK/hX+5hCH/dfobAwi78m8xAgoeMtZLshJNDe3nCijPB5hksRSU7rHAzD6tv7trHA
 sCaEgiZxX9eFthwcVY0UAPUHZR5zm3n6r1K2OCQ/8g8wVrTWcu8K2vaC66ngXh4dj6rkvC5JDj
 ZRTj1A47e78B1cRqKLh2YrskLXJlW2UkRK0R6zppPKfGzR0j+b5q5b5zznZRFp8Ko4i8409iCa
 MtbLax9veHb7DMSQqLC5OoCc7DR8KsMP9p96r6z8TbbU8k7Y5jhH9f7+bgpnJsO8yGm5MBwXmA
 lH0=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="149555784"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 17:25:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5tTF3KHlSEbplLsjDOnjMDbsGZOXNp/nBOR32iNfrN5Te+x6Xpv0GrrrfTCDmd2mjhcJ9TDxoFEpiNsGBZpP+VkbIDh6gJBeb6p0OeEupPwiflwNZfKkP3jwkSB+yFUuUCZQfKjgRG+w111m6i62768n+ioLo2xFrwAH5nC3r/p+GJUiuuGGPGNVSaZbNo+1zqaFaEF6pVTZQh+TWRf4lheKYS7iNSUesMGYmz3U10x305R7u4EUIO1cccgSJMktWiQPbsxtMtf1iLZuVuMN2DBEEBINMvmIFhbSqX6yudG5WYNGN7fMmGhNxFzW81NoPnP/hUHPTcKSSN0SEvurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/1g18k0KP6s02Yc3v7a7SWPdZ/LjQcuMc3TOCrVK2Y=;
 b=OI5Z+/0IS5ER6+uiHIwG9TY+Bge3YhLP+vDYQ0okKLse9dBm5QCsAyKV2oE0e0LTCVQZ0jWv+Px0rx7vIxRAJPKHS0/Eam7HBLvguSonOT+3J8FqydXPqZPFD+ZBUJ9/tu4/IQ1rr3CCvs4tmu+IBKMejM847PMfYo9QCbwMJflzsgxokz8sXTCEdDyOnRW48u04NEGHOTpJorvSt/iGkOhGTH7NM8AeBiYZ+n3/WSFVuxl8J2YDFKTSS7LOdw8VRWo2rz7d6ZcBnEFGiO1tm5Kd4btvOFtW+IysL1gWAiiXL1r+g1lc8neXtyrblLyl0Zg6aWGMNnbWoK/KTvaWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/1g18k0KP6s02Yc3v7a7SWPdZ/LjQcuMc3TOCrVK2Y=;
 b=U8uo791QMM7n9W+JRpU1YnOSZcaFlEL+Bv5+NbIY4kqctvjC9rvS2SLrS1A0QbMbG/BXWjVmeUse++I+Kdsw4EdhRWwv46WcA3GFisKtxENDgDfkclBPHCarfbcpaPCIj4F9kpujfZ6hAedow7tSodfygJBU89jekTUlFb/M4HE=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0377.namprd04.prod.outlook.com (2603:10b6:903:b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Sat, 26 Sep
 2020 09:25:30 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.024; Sat, 26 Sep 2020
 09:25:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC:     "anup@brainfault.org" <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
Thread-Topic: [PATCH] RISC-V: Check clint_time_val before use
Thread-Index: AQHWk9aYSJLcKwhKG0OB2/Vy4ql06al6pkQA
Date:   Sat, 26 Sep 2020 09:25:29 +0000
Message-ID: <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>
References: <20200926072750.807764-1-anup.patel@wdc.com>
In-Reply-To: <20200926072750.807764-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ad41837-9687-4f3b-50a6-08d861fe1c66
x-ms-traffictypediagnostic: CY4PR04MB0377:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0377D1FE9ECCF54D3718AF20E7370@CY4PR04MB0377.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qwZ7qGb1Q4qweO5I+pLeV3zFWBKeWryRx6NVQ0s+AMEYvKoyqSZwU3S/k0iFGUo1cab0aFeOLwSYgA6K1E87wXiiGZJoX4LtD+6eUwTdUl1W1NCtvvwKH5YEyxKcG+e4OysQ7C5ouPKDW0m0QUYGR2nJMolSba9un1NyGOuf5P5tHERi4njSGpbO/axlkH5yo7wfuRJI3n7paYm/PP7BHDbbhrDAw3x8WyG7pZem1gDlpX/Cm5c5cB1UD8M/snCY+b/UGdJnT1gKFxS8i1UF8LnwlFXhDKDSky5hW8E5Zbz3p/DcuPdoj30/WToNTEqWWjcgRgqU18ivXZk8zEICpnopyRkBg0j2uvw1j63rxjS0DNVyZuA6qFjdbpY73nPr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(6486002)(76116006)(83380400001)(71200400001)(64756008)(6506007)(478600001)(66476007)(91956017)(66556008)(66946007)(66446008)(4326008)(6512007)(54906003)(2906002)(186003)(110136005)(36756003)(2616005)(5660300002)(8936002)(86362001)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: KRO+CpZM9B0Xx13pnlQ2GhG9WzCwMiPcZ6FN5YGkyD5VYHZLA2W+bLIyIqCMHT9s9sYfouezvRRniyynPj7tcRWzq8RALi6Jm/1c9dURg7AXtbdq6HlBH73+NxKWLtzdJCNidACAAo7Er1rwuHIbAP4SlRnyDwU9XHsuL93iA3CSvbx7QVj+jfvAGwdZq8gV/fukPdo2HxaeFb6kmh0eNp2s380isfjmG6UYnEuhwF5ke982tzmLeLqwRXYYF+rM812z0eWMjzt+R2NHEvdRZp4Z9y/CamB0Lv/ZREeQ5bOV9x9Y66rgK0dg7fM9NqR72XjJTriyJvgdU0z0hG7VXdAFRLQ2+WDGSWOLbLwT/0wGUnojC8wt5vaPGgkppz+70lVAOxCXYJ0GC1+blvEfU6nylTs8S5m2KrPcc7aadXyPgyVi+oIK48tn/pCbVuhrH/6lfXPETGeQXK9lNdE6GoAmf+mkG+x2YNKCgOv8vGpo+vBY1wPJw1pX8oXpjZK4JmupAcceqE5PrJ1ZYBz01Z6OEU6Ld4KO4NOA50S6uAwRwz1PTxe1qvK2BdPJ6sW2fNJ8zcf8YIlpYs7wjbqEO+TqP52dJ9EKcl3qWL38Urk1pStP+LKq21bgcriqI+nAzBi9B/WxehUWr3zCpTUZiWLucEoaobNq6dk9b5kD8LUMNT6iryNFsxAAbBv5u5jwKcr5nfeIKNIeJo9dxGz8mg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5016A745084CBB4EBFE61EE7EA0C8D2E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad41837-9687-4f3b-50a6-08d861fe1c66
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 09:25:29.7280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hLOOvnNK3B6imgiN1+EUfQS6/4nj44Z8HlYQcPFHJWEZ612TYmJT+IQUKfYgoBLLr3Uis4HF2Q+UQhCYVawhCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0377
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA5LTI2IGF0IDEyOjU3ICswNTMwLCBBbnVwIFBhdGVsIHdyb3RlOg0KPiBU
aGUgTm9NTVUga2VybmVsIGlzIGJyb2tlbiBmb3IgUUVNVSB2aXJ0IG1hY2hpbmUgZnJvbSBMaW51
eC01LjktcmM2DQo+IGJlY2F1c2UgdGhlIGdldF9jeWNsZXMoKSBhbmQgZnJpZW5kcyBhcmUgY2Fs
bGVkIHZlcnkgZWFybHkgZnJvbQ0KPiByYW5kX2luaXRpYWxpemUoKSBiZWZvcmUgQ0xJTlQgZHJp
dmVyIGlzIHByb2JlZC4gVG8gZml4IHRoaXMsIHdlDQo+IHNob3VsZCBjaGVjayBjbGludF90aW1l
X3ZhbCBiZWZvcmUgdXNlIGluIGdldF9jeWNsZXMoKSBhbmQgZnJpZW5kcy4NCj4gDQo+IEZpeGVz
OiBkNWJlODlhOGQxMTggKCJSSVNDLVY6IFJlc3VycmVjdCB0aGUgTU1JTyB0aW1lciBpbXBsZW1l
bnRhdGlvbg0KPiBmb3IgTS1tb2RlIHN5c3RlbXMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBbnVwIFBh
dGVsIDxhbnVwLnBhdGVsQHdkYy5jb20+DQo+IC0tLQ0KPiAgYXJjaC9yaXNjdi9pbmNsdWRlL2Fz
bS90aW1leC5oIHwgMTIgKysrKysrKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRp
b25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvaW5j
bHVkZS9hc20vdGltZXguaCBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGltZXguaA0KPiBpbmRl
eCA3ZjY1OWRkYTAwMzIuLjUyYjQyYmIxNjAyYyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9yaXNjdi9p
bmNsdWRlL2FzbS90aW1leC5oDQo+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdGltZXgu
aA0KPiBAQCAtMTcsMTggKzE3LDI0IEBAIHR5cGVkZWYgdW5zaWduZWQgbG9uZyBjeWNsZXNfdDsN
Cj4gICNpZmRlZiBDT05GSUdfNjRCSVQNCj4gIHN0YXRpYyBpbmxpbmUgY3ljbGVzX3QgZ2V0X2N5
Y2xlcyh2b2lkKQ0KPiAgew0KPiAtCXJldHVybiByZWFkcV9yZWxheGVkKGNsaW50X3RpbWVfdmFs
KTsNCj4gKwlpZiAoY2xpbnRfdGltZV92YWwpDQo+ICsJCXJldHVybiByZWFkcV9yZWxheGVkKGNs
aW50X3RpbWVfdmFsKTsNCj4gKwlyZXR1cm4gMDsNCj4gIH0NCj4gICNlbHNlIC8qICFDT05GSUdf
NjRCSVQgKi8NCj4gIHN0YXRpYyBpbmxpbmUgdTMyIGdldF9jeWNsZXModm9pZCkNCj4gIHsNCj4g
LQlyZXR1cm4gcmVhZGxfcmVsYXhlZCgoKHUzMiAqKWNsaW50X3RpbWVfdmFsKSk7DQo+ICsJaWYg
KGNsaW50X3RpbWVfdmFsKQ0KPiArCQlyZXR1cm4gcmVhZGxfcmVsYXhlZCgoKHUzMiAqKWNsaW50
X3RpbWVfdmFsKSk7DQo+ICsJcmV0dXJuIDA7DQo+ICB9DQo+ICAjZGVmaW5lIGdldF9jeWNsZXMg
Z2V0X2N5Y2xlcw0KPiAgDQo+ICBzdGF0aWMgaW5saW5lIHUzMiBnZXRfY3ljbGVzX2hpKHZvaWQp
DQo+ICB7DQo+IC0JcmV0dXJuIHJlYWRsX3JlbGF4ZWQoKCh1MzIgKiljbGludF90aW1lX3ZhbCkg
KyAxKTsNCj4gKwlpZiAoY2xpbnRfdGltZV92YWwpDQo+ICsJCXJldHVybiByZWFkbF9yZWxheGVk
KCgodTMyICopY2xpbnRfdGltZV92YWwpICsgMSk7DQo+ICsJcmV0dXJuIDANCj4gIH0NCj4gICNk
ZWZpbmUgZ2V0X2N5Y2xlc19oaSBnZXRfY3ljbGVzX2hpDQo+ICAjZW5kaWYgLyogQ09ORklHXzY0
QklUICovDQoNCkFwcGx5aW5nIHRoaXMgb24gdG9wIG9mIHJjNiwgSSBub3cgZ2V0IGEgaGFuZyBv
biBLZW5kcnl0ZSBib290Li4uDQpObyBwcm9ibGVtcyB3aXRob3V0IHRoZSBwYXRjaCBvbiB0aGUg
b3RoZXIgaGFuZC4NCg0KDQotLSANCkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0YWwNCg==
