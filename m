Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5712ECEE1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbhAGLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:41:03 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48978 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbhAGLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610019661; x=1641555661;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hh88MeXfbWANBeEHLTM8SZbwNby/AistNL/iUpVK8l4=;
  b=2o9Fx2XcsYB7q0tKt4Bjtp6fSaHh1WtlwELyPsaK0ea5NTilCBMxPOQ9
   Q36POO9XTqbTIWXDTAIueuHWK3tX18AR18qL/N1m2+RVcapi0MyenjeBL
   cNJ2Lyv/E09Nq6Fl9NXYZL+eSyXePMUy+Oaf0Onnb8lr6mkFMJr3R62RX
   aT3rnjQKnVbWHvcCmwEMZGIrCZNtbw6/7TDYkDoZ3/JZKvUZVYdA/SZrG
   zu8qZ6gbcgN5vqw+MRiSSQf9rp2/fszqXFTFZ39JkwAbwXxUnV8DCT4rC
   aRwHBuEJ69Ug3gI5oxYRuW97RSr8WwvmMFVrgf8JDQg+aofvnbcygDO8E
   w==;
IronPort-SDR: /LFrllATivWoFB/cGnNYDhWO6pqui0YyWyA9svmSoExgmNGi/4o5YRnNaPC+pvpSbBJT69f08D
 /zMHAoGsBsCbnFZbilgaVFY2A9XU3MeC0bBukmoZFiIBKS/DgRD6WhLmk5TQChz/rWqbuHvm1y
 uv865GjYRuR99NVEPQ9L+SHqaM8ngqwC+GzlYy5Ve1fRbRXwDYlGpSQO384kShLfxwi6sOPS/I
 Zp4ERjqECM7ka2ErwdObdmSaDW6hSDdhXjOWt4Iew9x1xP4E7hpd9dy0XuVffK0m8p6jw372BK
 nCU=
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="39640441"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2021 04:39:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 04:39:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 7 Jan 2021 04:39:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQJhDMNpN2EHpL524e+eDkikeX/oAhZe0tST19vRxEPM6lBB2LBjQxZUVNz64DsdI30s/eyB2EPsuh83Es1HuitaG5KxwXYpaOOFO/Vs0iUzXSJlEa+yh/ysCX2dw77BBo9xrfW8j3ZueNQFkEomeW1WkDIdIMFKBAg0rCxUzlheWOk2jSH6Tjo79aARyDGl3UBtgJHzjLW3KNFl+fdaF8h7smxiM0QiQbC9gQ71Oc9MEC9qb4vaCXgtUMm78D1SLUaUaW7XjaMKnoNJQgxx8rJZmKI9oJgDN5fPkP4vIVeLU/2Z3YYwkb4sjZlr029ZGz+ESVrBILOAnAitkq3ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh88MeXfbWANBeEHLTM8SZbwNby/AistNL/iUpVK8l4=;
 b=XiNsH+JOc1iqa9JGcza/bMCF4nX/deK+GrSFEsYo7D9b3mSOpkv1rSE3Z6qP7T1baiE9D1Tv63MAKmjkAz9tvK2pVF2qYO+bWcO3gPH9LayuI52dteoH0tyCdtWna4IFcDqQ7S0eIlKJg9YpYTVf02cogIQVVVueoo20lUb3icHeXqJgELUoay9QYstjtn357RQ+0RkkaV0koFbt5YUAkN8VQVwWsa/LiGnw5XIDQafdahvG+gtFoc/x+EZnFW9KZq8Y3pE75xkKEx1UPAi1YHs5UFVXt8g0/ehfnQqZChw1feqk0wVUB1H4f9R29PJ50ZtARcFcjYGgB+B8GO9ZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hh88MeXfbWANBeEHLTM8SZbwNby/AistNL/iUpVK8l4=;
 b=NChjel/aM+2DlyGubhyVbx5Hf9kTdm3QYgCNB4HI/3MhT2RYha4FHQEY2Fw5pk6qhuQeVF0lFvnlqtezK803xPZ7Pli732aRwfA6j3nwL7MolTT/MKxUiEzCaTyHjTzki4bGWyAy5SqD+4aqRuzApy/ljVPqCgNRwQQJU63OU/8=
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by DM6PR11MB3578.namprd11.prod.outlook.com (2603:10b6:5:143::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.23; Thu, 7 Jan
 2021 11:39:41 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::2d16:756c:541c:7aa5]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::2d16:756c:541c:7aa5%6]) with mapi id 15.20.3742.006; Thu, 7 Jan 2021
 11:39:41 +0000
From:   <Cyril.Jean@microchip.com>
To:     <atish.patra@wdc.com>, <linux-kernel@vger.kernel.org>
CC:     <bin.meng@windriver.com>, <anup@brainfault.org>,
        <aou@eecs.berkeley.edu>, <alistair.francis@wdc.com>,
        <anup.patel@wdc.com>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <robh+dt@kernel.org>,
        <Ivan.Griffin@microchip.com>, <Daire.McNamara@microchip.com>,
        <Conor.Dooley@microchip.com>
Subject: Re: [PATCH v3 1/5] RISC-V: Add Microchip PolarFire SoC kconfig option
Thread-Topic: [PATCH v3 1/5] RISC-V: Add Microchip PolarFire SoC kconfig
 option
Thread-Index: AQHWyhu0xs81qxA4TUKGelrkN8HN26ocP1oA
Date:   Thu, 7 Jan 2021 11:39:41 +0000
Message-ID: <4655c810-e406-f807-d2dc-1b2e0198d945@microchip.com>
References: <20201204085835.2406541-1-atish.patra@wdc.com>
 <20201204085835.2406541-2-atish.patra@wdc.com>
In-Reply-To: <20201204085835.2406541-2-atish.patra@wdc.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.40.244.225]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f1d9d4e-6ccc-44d7-af57-08d8b300ec32
x-ms-traffictypediagnostic: DM6PR11MB3578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3578A6B39B6ECD17750D74379EAF0@DM6PR11MB3578.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpvj003fNUmuJOwwwyI1eMyXt6RjrYS5Jzmgvnp2kp4LP80Z2UVj4yKoi5rwM4g1xUu1qfP0PyhNJrxHyf/TdJsd1aua2JJdpmzxndGOUvF0tLn4QQzFZ/6lnioFUYSKmc6UMYJGdnVzEHto9z3EiBjR+Ur9ljvVVRNKKDBI84fm/x2mNMcHcjn5bW/e/YK9T27LjZ1LCVt+k/dttwco9c2ESo4EXWVHY3XavISzzvGORI7cEcOICVzuUOC6qkQ5PqFK/yhcV3zc2DBWcuVcGHFEGstO46m3cDaPbyEHDoaUy4qJgZUDQTRRSTHp6mAM6sTDo/uUJrPCQhnfOCOhcArvKyDJpr/4fC1AsrMyTKoH/o1nAg5CXn3U4MBzph7os/DYvqZLiuTJnPP2a599SLgEOQOfDKRcbL3dvKEWvX/lzfh4Uka/iyewSs+8SJNUB8+LRTjr5v2Bv7bypRyoO0c42tYJPXyAdvuwe5Dwsag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(91956017)(66946007)(7416002)(71200400001)(6506007)(4326008)(66476007)(26005)(186003)(53546011)(66446008)(31686004)(86362001)(66556008)(316002)(5660300002)(83380400001)(8936002)(64756008)(36756003)(54906003)(478600001)(6486002)(76116006)(31696002)(2906002)(8676002)(110136005)(6512007)(107886003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eUhMTUx1UlVuVXdXQzNCNG5RWWNqV0hWTk05KzF1cm9KZWc1eG9XcWJkRFM2?=
 =?utf-8?B?bm9LV3ZLbXdVek1PMUZaV1IxNW5rUGFqallwL2lkcnNFaC9OSEJHWXIvcHI1?=
 =?utf-8?B?SWRlUWc3WkZiN1laV3hIaTh4Rno0WVZwU3hFWjU1UEpMcXZIbGVkdzNGcHR2?=
 =?utf-8?B?Z0t2bDkwSFNDMXF5WUhpdlRKUWhvRmVhVjIwZWtSRzd1ZHByUTlad3BOcEo2?=
 =?utf-8?B?RE95MEN0OG9hdmo4YkdVQ0RlbjZjK1puSVVhanA3dEp5UzdCeGttbzEzc1lM?=
 =?utf-8?B?YzBHS1JTak1FaHdKSms2VTUwUm1QellQUDFteWMxdk5mZDFZalNrdTg3RndG?=
 =?utf-8?B?QzlRUStzNEVhT1FPOTBzTmlacEV4d003bjJncXdLcFFZNmZ4ZC83cDY3VFVP?=
 =?utf-8?B?SEZBSlNyR09GanZ4QktISUpMN0NJbit3MG1uc25OVWs4dU1TeG5RUkxNaUl6?=
 =?utf-8?B?YWIwRU5GRDUwRzJLL1c3bGdCU1Q3VTlZb2hiUmhHMmp0aDA5bWUyaDBQMzF3?=
 =?utf-8?B?cXFrTWF5U241MmhvaTJpc2MwZk5wNk1NOGdGRmZRNjdwcHVkV2VQdkVCT3pp?=
 =?utf-8?B?NWdySlI2azNpS2xucHQwVjlXQVMrYWxBTUpTL0NpaXdXMytBblU3ekxJODdP?=
 =?utf-8?B?RTVtYVprZUwvL2tyRHRicE9XRWcvY1JOL3A4UnZUZ05IdC9oRS9OZjhDTTZR?=
 =?utf-8?B?SXA5VTlWRCtjR2U2R0xTbXcwcm9WZzVBU2wwSWtEdi9maEhjQm5GN2txTmZu?=
 =?utf-8?B?SUN4NzFwWWNkQ2x2aEFBaitteEcrd3VFNkJQaDVZTmZMb3dXQW5FRHRjR1p6?=
 =?utf-8?B?bFFmbjFBU0R5RWRWaHhUeHI4N3JqMlVETFBWczV1N0lneURtUGZ0UjZ1R0ll?=
 =?utf-8?B?M1dzcGZYMTVGZFJpOFpXeUNzQklsK0FwbjVoZGc1b01VM2VCQy9OeXgrR3hq?=
 =?utf-8?B?czJUZ1VOUWpXbmN6bHdQU2p5eHFvSHU4N0tpanRrc1VVeitpOXBhRlRFcWhk?=
 =?utf-8?B?S2R2cjB4eHp6a1dabUVZWVNDL2RpR2RkcUUyVVpZQWk5dVVEZzJ0eVBoZFp1?=
 =?utf-8?B?MjZFVFpvcW9iUVI4LzJMbE50SjlJSGV5UWxBSEZFcXJaTzB5ckRNeFV3Ullw?=
 =?utf-8?B?Z0FJTkFDUGNteGlMZWVpU3FNcnhQVDFzWGVVbTBWUTZPalJ5WWljd3JaOFBC?=
 =?utf-8?B?bTBWbTg5T09xa3BPejFJdzlSclJjT0ZPQlJXTUNwbTREdkRNNlpYYnZVQk1y?=
 =?utf-8?B?bjhydHpJVWFJekNMcEJTNnIzdk5hengyY0NwRFUxaTVkb3VZbkI4T2RuWGF3?=
 =?utf-8?Q?9h0Cn2XXNaoqo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D74F8BCFDF8F684C87F495FD1FF81176@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f1d9d4e-6ccc-44d7-af57-08d8b300ec32
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2021 11:39:41.6092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7gI7V72CH41tCFYudKoMxV90Hxx01iq7qrH1T3XmtqeF4UkEKA2tcvuKus3nfhDbXkGhOZoAXECts7/7+MYWfZL/grWTdxINC0K8gJgZz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3578
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXRpc2gsDQoNCk9uIDEyLzQvMjAgODo1OCBBTSwgQXRpc2ggUGF0cmEgd3JvdGU6DQo+IEVY
VEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxl
c3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBBZGQgTWljcm9jaGlwIFBvbGFy
RmlyZSBrY29uZmlnIG9wdGlvbiB3aGljaCBzZWxlY3RzIFNvQyBzcGVjaWZpYw0KPiBhbmQgY29t
bW9uIGRyaXZlcnMgdGhhdCBpcyByZXF1aXJlZCBmb3IgdGhpcyBTb0MuDQo+DQo+IFNpZ25lZC1v
ZmYtYnk6IEF0aXNoIFBhdHJhIDxhdGlzaC5wYXRyYUB3ZGMuY29tPg0KPiBSZXZpZXdlZC1ieTog
QmluIE1lbmcgPGJpbi5tZW5nQHdpbmRyaXZlci5jb20+DQo+IFJldmlld2VkLWJ5OiBBbnVwIFBh
dGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPg0KPiAtLS0NCj4gICBhcmNoL3Jpc2N2L0tjb25maWcu
c29jcyB8IDcgKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4N
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzIGIvYXJjaC9yaXNjdi9LY29u
ZmlnLnNvY3MNCj4gaW5kZXggOGE1NWY2MTU2NjYxLi4xNDhhYjA5NTk2NmIgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvcmlzY3YvS2NvbmZpZy5zb2NzDQo+ICsrKyBiL2FyY2gvcmlzY3YvS2NvbmZpZy5z
b2NzDQo+IEBAIC0xLDUgKzEsMTIgQEANCj4gICBtZW51ICJTb0Mgc2VsZWN0aW9uIg0KPg0KPiAr
Y29uZmlnIFNPQ19NSUNST0NISVBfUE9MQVJGSVJFDQo+ICsgICAgICAgYm9vbCAiTWljcm9jaGlw
IFBvbGFyRmlyZSBTb0NzIg0KPiArICAgICAgIHNlbGVjdCBNQ0hQX0NMS19QRlNPQw0KQ2FuIHlv
dSBjaGFuZ2UgTUNIUF9DTEtfUEZTT0MgdG8gTUNIUF9DTEtfTVBGUyB0byBhbGlnbiB3aXRoIHRo
ZSB2MiANCmNsb2NrIGRyaXZlcj8NCj4gKyAgICAgICBzZWxlY3QgU0lGSVZFX1BMSUMNCj4gKyAg
ICAgICBoZWxwDQo+ICsgICAgICAgICBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3IgTWljcm9jaGlw
IFBvbGFyRmlyZSBTb0MgcGxhdGZvcm1zLg0KPiArDQo+ICAgY29uZmlnIFNPQ19TSUZJVkUNCj4g
ICAgICAgICAgYm9vbCAiU2lGaXZlIFNvQ3MiDQo+ICAgICAgICAgIHNlbGVjdCBTRVJJQUxfU0lG
SVZFIGlmIFRUWQ0KPiAtLQ0KPiAyLjI1LjENCj4NClJlZ2FyZHMsDQoNCkN5cmlsLg0KDQoNCg==
