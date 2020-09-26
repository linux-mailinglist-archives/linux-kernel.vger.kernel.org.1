Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE327985D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgIZKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 06:25:18 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50087 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgIZKZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1601115916; x=1632651916;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SYFXd250sMnTqc3osa+fFriRQBckvLKx0RHjEQxxjYo=;
  b=ofNLnGQDht9LQE3qtwwBloG5QifVZJxwNwopFA1cxPU/ylccXMqgFUT0
   oWrDA2RiepUmOCYQoFNp7KDArzBu+lBwVx/ZwQwWPsrqop5HrpTWVBfnS
   R6Xl6MRKMZ/zjRAYHEEo3AjutHUSgb2GlVav09Tg39ymoI2r67XK4V3+V
   kAAWhVUdOKuNzDHZ/XEsvKLJ54Jgg0Gf05FUAANJHU8iBnrmc078TrSKm
   EPeWLrEqfYViZJTi4/ZS0Q7HVuz694pe212RFvaIB4QZl5ZbCvo3tGy7X
   4Jwpayg0AW1/Vmp5Nbw4BxLJqQKLc+6XYIg2EXvbH4jAyGEC7dtFndoQ/
   Q==;
IronPort-SDR: ZrvRo80YRV2OzWlRR8RVnhNz5qJnIPMide+81urnivmPVG2stNsvPVbr7hyuZaJtH4efdYTZPC
 qOgclnt09p0vLGSMgV/6Ud0T5mQ+KJ5AgX09/mNiY6lZE1j3rsFLtu3mgAYKXJP0bpUfNnSkSF
 x7kh+EcQAi5cpPy0qOgqwVIAomSSzqLSyfMzpz10f6eErKVHLQsjWDXhd92Fv0J9tfDbgtq7Fq
 wTLOL2B+KaV5Kep5gMfwOTTdDqPfFD23+P7VaI8gDH0JVuZ1P9eozWZLq2rlWS97UO6nDpe7fY
 +U4=
X-IronPort-AV: E=Sophos;i="5.77,305,1596470400"; 
   d="scan'208";a="148252633"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2020 18:25:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCIgUS+jHX1pfuNXqo1BHiQOlSkPcazBP/iKGX0QvnPN+kKgzAnrLDFLJ/yWrEgRUMoqSqx193TnnBhGZm/8Ek4lUQDA3yKd9i0I/sqJcLaLxhTX5jhl3sPnYvtbS7YjrcAdyNCAkRAvr0zAX28gDXjdI5Kpny/jQNtHGJw/eDBcU59A27RdkV3nAPM1FIw57aTOtQsSBvaXAlPs/Fkb7RuVxXcth0leXdp8f6M2rErExvPMeygrukRI64qrPiDjw5eeMAJFVEMOxSI9uVK/Bx1bZ0UR0dAZNMaEF3StNHYal0e5YgzIYlgLq2dcl8h9mN5wPIA4+V7J8n9ncN0tzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYFXd250sMnTqc3osa+fFriRQBckvLKx0RHjEQxxjYo=;
 b=jvJvDU/ey2s5d9Yq+XKhsHQoDiqaozRstuQ55utWCyAz+jaldcB1l+LmC0iUtg4P0leV+YNBxRWG2N0As3QoJcUvhSM+24FPYCUdWDoMjZ2HQhW+1rBE2XbwXJ++K3N9e6fKLbA9v8f6tkPApgYbSB99lhIYMWRLGqCFFU9IAHh21um2paNDmGFpPpFhjcDIvv0BkxTgbySrvJrEmh8AoAoALoARvOMHh2TjyJPyrJ7I5a7PQ4mtu+gtOA66CIS8eXCvd0uNBt0F9nHZRPGyvxk66d29ymV2L/QxxXt8/l1YExLWKpUVFwULBRiYMpy4VQrZRXsSLjC5A87+mtoSlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYFXd250sMnTqc3osa+fFriRQBckvLKx0RHjEQxxjYo=;
 b=Fw5Xm4/OYLgtSw73uSF5w43sjNPvnnykEpRFb3EmxBsK5cWVxZeQBAHIK8LlfDUsz/zcaEdJAXgf/aPHKjK0QeYnR51Xrq3LWTaVA+1xxhHjvXwepX95cQP+Heu9qWJXHcAW26Eur9RJUXbJW6JBpUZvwrZZD49L/5KgkaKCJjY=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0374.namprd04.prod.outlook.com (2603:10b6:903:bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Sat, 26 Sep
 2020 10:25:14 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3412.024; Sat, 26 Sep 2020
 10:25:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "macro@linux-mips.org" <macro@linux-mips.org>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        "palmerdabbelt@google.com" <palmerdabbelt@google.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "anup@brainfault.org" <anup@brainfault.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: Check clint_time_val before use
Thread-Topic: [PATCH] RISC-V: Check clint_time_val before use
Thread-Index: AQHWk9aYSJLcKwhKG0OB2/Vy4ql06al6pkQAgAAB0ICAAAQAAIAABouAgAAEV4A=
Date:   Sat, 26 Sep 2020 10:25:14 +0000
Message-ID: <8a99b16ae3037487b762fb1bbcd81b576d9e11ab.camel@wdc.com>
References: <20200926072750.807764-1-anup.patel@wdc.com>
         <1ee25b9bca3956d15a4a0dbf83f43d1ead454220.camel@wdc.com>
         <DM6PR04MB62017875C739101DF83280ED8D370@DM6PR04MB6201.namprd04.prod.outlook.com>
         <0e1990c99bf2a342cd2e78ec7ecfc2fdecaf67fb.camel@wdc.com>
         <alpine.LFD.2.21.2009261054270.3561363@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.2009261054270.3561363@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-1.fc32) 
authentication-results: linux-mips.org; dkim=none (message not signed)
 header.d=none;linux-mips.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eeb29367-931a-4cff-75b8-08d862067504
x-ms-traffictypediagnostic: CY4PR04MB0374:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0374196E67F93C4A31F2CE5FE7370@CY4PR04MB0374.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MV+JkOO1D58xOHUl17dRBw22W+nUSzn5kpBMKevtN5wSmbA8T0SOVTZ98lbGfFY5YIEdCQPF0AZv86mlVGkSD63l1pl0gsR5BAFRxuO9MrNVhYCWz0KPK1UYNTe/v5lGJXsl9FiFK6zx+TQKyMWkVwHiQuu+8jfDeIsiDOVyhIO5RpyYgvAcbdkJkmeBFV47JbWoLrc9a1zNVA442YReOEvUunDn0zLFI+nqFRuTVGAOdBosCPOda3UJnv1fZvVoxt6VNRnHnc3ZXNK0v7XUcE8GNmxCz/RMKNlH3Pr9fkQFh4/BnnqluxNPbqNeQUwqUOcPCcUfDCWEF/Stt4rq/GQ67OZWSWJ/KSEHXMwau5yPVfOqx/LHNax01xGVrjrV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(6916009)(83380400001)(316002)(8676002)(2906002)(36756003)(66476007)(186003)(66446008)(6506007)(8936002)(66556008)(64756008)(86362001)(4744005)(54906003)(2616005)(71200400001)(91956017)(76116006)(4326008)(6512007)(5660300002)(66946007)(6486002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uXRoYkDg2657Nef/dKSlPjiQ5mbKQN2Kvy29ZOF3uT/MmpSGw/4k5yoCZB957sXh/0nBQqNWWftgr+7hVQXrTd+dxKNhGlXkcZ8tmt5Q/jWpsgmN4Dx/kAKlPfb0JylU4L5goR7v11V0w49rZdE00Tr0/marylLMKFWK29bsA+uh5PTdGN5KRtFjUw1Alv7lfZIbboj/K/6dZyA0zgabmmxaPzza45aBflaMfFUQ7/3AmqBABxYHX73Or5+CfM/tn2iM0FlvtKJ7nzeGFRBazh6KSI32ljRK365aBGVAss3o3oYQiybj2trtGNe327sMbsCt8vW65Evc9Tcdg2fLov65UO20gMclBOCzkdP30iOuVACVHmNRilDDzgDG+BbwXsu2/+DsiOUdoYLTyb86BgEqPOY6NczFplXvTk6+J/+Ag+jJWCPpAv9Jhepx3ysg11GRzwMXrKLgJDGIKlh3tAZEJOb5VQx41dhfJfaJrp6qvPJLgBSQ/6N7Q6tTQNVaVce1fmVHvLBc2QIcWPwjePMvUp/8UHfHJOWBY6C02JdNrpIgfu58WxC2Mw8qNP098E2ymPBWg9FL8StiQaNrqbPdvmpG9E5A8UVhW01365wL15goLumWHBJ6xGgHcnpM+ok/ABw8DsUbBBqAzzMK7MPJ7WtUHcaKcbBfp/Hw63sX2ZrEkQMY7vuhmL1wry7RrHVQZpKffGs+8zS/GMHkXg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D72529E8F39F41B0AB513AFB31D33C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb29367-931a-4cff-75b8-08d862067504
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2020 10:25:14.4378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QEXBRA/V1FKQqu/IQvk+s/cDA9zLzS3tUsA6aEOGyFHymMcnCoTzavegsYCVEZD6O/fszkaW/xCrEvQ315No1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0374
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU2F0LCAyMDIwLTA5LTI2IGF0IDExOjA5ICswMTAwLCBNYWNpZWogVy4gUm96eWNraSB3cm90
ZToNCj4gT24gU2F0LCAyNiBTZXAgMjAyMCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6DQo+IA0KPiA+
ID4gPiBBcHBseWluZyB0aGlzIG9uIHRvcCBvZiByYzYsIEkgbm93IGdldCBhIGhhbmcgb24gS2Vu
ZHJ5dGUgYm9vdC4uLg0KPiA+ID4gPiBObyBwcm9ibGVtcyB3aXRob3V0IHRoZSBwYXRjaCBvbiB0
aGUgb3RoZXIgaGFuZC4NCj4gPiA+IA0KPiA+ID4gTm90IHN1cmUgYWJvdXQgdGhlIGlzc3VlIHdp
dGggS2VuZHJ5dGUgYnV0IEkgZ2V0IGEgY3Jhc2ggb24NCj4gPiA+IFFFTVUgdmlydCBtYWNoaW5l
IHdpdGhvdXQgdGhpcyBwYXRjaC4NCj4gPiANCj4gPiBXaXRoIHRoaXMgYXBwbGllZCBpbiBhZGRp
dGlvbiB0byB5b3VyIHBhdGNoLCBpdCB3b3Jrcy4NCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jbG9ja3NvdXJjZS90aW1lci1jbGludC5jIGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1l
ci0NCj4gPiBjbGludC5jDQo+ID4gaW5kZXggZDE3MzY3ZGVlMDJjLi44ZGJlYzg1OTc5ZmQgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jbGludC5jDQo+ID4gKysr
IGIvZHJpdmVycy9jbG9ja3NvdXJjZS90aW1lci1jbGludC5jDQo+ID4gQEAgLTM3LDcgKzM3LDcg
QEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY2xpbnRfdGltZXJfZnJlcTsNCj4gPiAgc3RhdGljIHVu
c2lnbmVkIGludCBjbGludF90aW1lcl9pcnE7DQo+ID4gIA0KPiA+ICAjaWZkZWYgQ09ORklHX1JJ
U0NWX01fTU9ERQ0KPiA+IC11NjQgX19pb21lbSAqY2xpbnRfdGltZV92YWw7DQo+ID4gK3U2NCBf
X2lvbWVtICpjbGludF90aW1lX3ZhbCA9IE5VTEw7DQo+ID4gICNlbmRpZg0KPiANCj4gIEhtbSwg
QlNTIGluaXRpYWxpc2F0aW9uIGlzc3VlPw0KDQpOb3QgYSBzdGF0aWMgdmFyaWFibGUsIHNvIGl0
IGlzIG5vdCBpbiBCU1MsIG5vID8NCg0KPiANCj4gICBNYWNpZWoNCg0KLS0gDQpEYW1pZW4gTGUg
TW9hbA0KV2VzdGVybiBEaWdpdGFsDQo=
