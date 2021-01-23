Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF68B301522
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 13:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbhAWMUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 07:20:17 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62809 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAWMUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 07:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611404401; x=1642940401;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nJ/o+NRhjhYmNj589NSP8NUbieKv3nM9Zwx7nL7DOSc=;
  b=s4eMWi9Al51DLu2WEHCofPLiP4nxpRbAMD9Hdt69bJDNKHMh5eRvbUky
   58mw6ecsoCIblsA5qr7PG1OwcCZFOC/ozjSEaqTR2NbPJ81pYVkduNrou
   D12fguWuNflbq49GoBfAeT7bfGe19dQSYSCfL+Bj0G15BVFHF3JntrgWw
   WMH45U897i+JV6onZ6Ukkw7Ii5kVvQ/dC9kkHdARc9OtGY/bK8/tFeX2/
   FWS+Ralsb7owENRpXKrEp/TEmKRacEtqOZVrDr4/6gHxs8/XtX87kNPHR
   fK3M9kCbtn6fkxGnoHAlSXFhWXF7ytNbOpDqtSElD8EEr4GCy4+15M9BT
   g==;
IronPort-SDR: AhKnPlwZMp2O1pwF2cyzgCuttRuP7xOVmcVpzvmQG/pwuWINFSm0bWbtZxzGFqx6KUZJOEYNOt
 jfCuaEZ9idY9kQ5weigiunkQDgXk72BY/zAz+BkHaGXYHoVSZ8FH6NNMASHIf3qJA5nUg8WRp8
 7b1ity8qRsLk+Gy+tNZyiikv8cvAZFEqB09ad0WBUHyJAb+HtYCBkdaDtE+Qz/dHvGTOdbs/Wn
 r7N+lAC827PQ/QUJIkzJ5o/wHWv460I4Hbwdj8iK7o42qw953WAj7KlyQqTD7ILH7YLQdyaTDy
 W7E=
X-IronPort-AV: E=Sophos;i="5.79,369,1602572400"; 
   d="scan'208";a="41475742"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jan 2021 05:18:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 23 Jan 2021 05:18:44 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Sat, 23 Jan 2021 05:18:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHCbxIu416fwLd7I2hWUA6yf5xjBz57Ae8LycT82EjkJeijA9xlPNa05uWcgGXxA0gyheJShdLjvIhksHgqSU7oGABmhA+ecLxJmIC/B8zPUKoZY5s8FlvsL+Fd+B+PjwKE+AwUzJm5w9Yrwyv1Sy6OwhXoo3LZasmxOqycS9pdyyaP46Pi3/F6c1hcgNsOwsJvt29G7VDLeLdscl1dOByilWcbMbcJ1qFkIaS+FuLMDZeyCd5uNofGi2viyBG+CBklvrNcdysx40CiOwKAI4gPHs34icZFI480itDX6eHBzD1RQrt4RTltWQCLfGcY/+799u7CwuksRsOal7aZV5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ/o+NRhjhYmNj589NSP8NUbieKv3nM9Zwx7nL7DOSc=;
 b=nVLEmXi3zeJmg21iLpmOYTjJTup2NAHdbAKrlx1u9FZeLGRazyZ+R3nvzfsNRbdqIBVjK00UcUR56XLyl6XtojYaOvC2rZigM+hJlTpalU4h2m0I8KY5Ur+p9G8NJaNZtFKaOdn1uxAhta06CF4U3vwApPK9/Eed53ivkw82mPd/q4gNnw/eyZq0jV8ggxad9gMbSPPu+XvKKAAsoxvKea/T7hKSjSsLa+J+ic/JZ2Rk3WEvgcl1rB/8kzGh2iH69NNwDuIllZPLefk90SSM0V+lXKosbFsc4E2QIDnXZJmmb/vDrdHtmALLI1ZY8YMf1W/KkQLCXnLz6fGPKHz9kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ/o+NRhjhYmNj589NSP8NUbieKv3nM9Zwx7nL7DOSc=;
 b=TVI5NDlWLFGAF9lmEmmLQkGLwCN6YKqGklgI5+e6SUZ234HS2FA17bFHsgW5dGYfxBBGaoJ0kRtiQxW3eOCj/ZwQuGMDSs8ThOs8l+S0IVOpKRkbA7p6AYDxGdJzg4jhUKJ7/IBp4JVOyecKc8GQsNQN6vgU74iDAU0Q2xwOHP0=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Sat, 23 Jan
 2021 12:18:42 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.017; Sat, 23 Jan 2021
 12:18:41 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <liew.s.piaw@gmail.com>, <michael@walle.cc>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: spi-nor: macronix: enable 4-bit BP support for
 MX25L6405D
Thread-Topic: [PATCH v2] mtd: spi-nor: macronix: enable 4-bit BP support for
 MX25L6405D
Thread-Index: AQHW8YHiFrgqo+NJ502dydKbSKn4ZQ==
Date:   Sat, 23 Jan 2021 12:18:41 +0000
Message-ID: <93b7f8e8-cdf4-5b09-da17-636d8fcaf0ee@microchip.com>
References: <20201208011938.GB12175@DESKTOP-8REGVGF.localdomain>
 <20201208015730.12351-1-liew.s.piaw@gmail.com>
In-Reply-To: <20201208015730.12351-1-liew.s.piaw@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfdea3f3-359e-422e-9bf6-08d8bf9905ad
x-ms-traffictypediagnostic: SA2PR11MB5177:
x-microsoft-antispam-prvs: <SA2PR11MB5177498407B6C66F846D2197F0BF9@SA2PR11MB5177.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Qnl4ysHvtERqQh1oHTylqNmCyFfN4QEP8kSnp6bTb77Mps6gFDIqTFpi39QaQhRNTqBYH2MZI2eRXW2Rih3oVrb8rAVnxAG/x94vaCrDG7AjDtPh4kBe5zsFEpS2t64M4aIpX59at+LkDO1SvdReNQFl4SGWvcj70W766RNh50u4SnIDuMIiCTbnjGJ5UjnRhqevmomXh4c7JpVpfvtDURixZZ//xz4Yc/Sa0I+81iQAFeSO7NoyeTCUBYxVv0GxTgHJ5pqNGlrNaA3oDj9hEoIPR871QRdEv0EXVOpjl3HocL/hU6+V0BLT/6ocE5JgLexNHW4f86vOXBq0F4hXO1LmZNzwhkRSE21E4y9gdiDW7y9OmcYMMLZboQJNdA2xwyZ+wCAUZxjRdtQd5sn+ASB+aj4ASsNQmBWL5aKUfRobDkMErAtXBJsU3CXIBJuV7X9gjiNXXrt/sROKhUiFlme6yJV6EYmGLBIQiYgbBxYTYtXM7/6Xhu5mnspO0YajwgztXcCKGRNMFJZOYSRE0Oi3dqis2R8l6jEu43T5DwQ/tGeSnVIAuU/94CIRFIN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(376002)(39860400002)(396003)(66574015)(316002)(8676002)(54906003)(110136005)(6486002)(36756003)(31686004)(83380400001)(86362001)(26005)(66556008)(64756008)(66446008)(8936002)(66476007)(186003)(2906002)(66946007)(6506007)(2616005)(91956017)(53546011)(71200400001)(76116006)(31696002)(966005)(5660300002)(4326008)(478600001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?emh4MnFYSGh5djdPK3J1NUlnUTRRRWxXNXhFaERHbGQvVUdDSGp3dVM5T3g2?=
 =?utf-8?B?OXNqZmJUWUlCWVliSTlNUmxGYndHaXlKSTROQ05QNHJwbEprcDBKWEtpcnNh?=
 =?utf-8?B?bGtiYXZ5Tm80cXovRDdnclA5K09VQnY5NE1tZURydmhNKzREM3VnS2lob2dT?=
 =?utf-8?B?VWlmckt4YmlFbEV4NWJEb20vUkY5WmxuWmlsVENPY01JSktBdStCY2pCOEZM?=
 =?utf-8?B?OCttb29pbGY2UjRvUkFvVjJDV2hpQ1JuYW04M0RON2hMUDBjSFJMK3l3VmZq?=
 =?utf-8?B?R3FLMlN6QVFMcWpMelJCVnE2TG5Ra2FMZ1JqWFRRbXlQdmd1cjRQL09oOWJo?=
 =?utf-8?B?QWczNjVOa0dGSFhwY215cklpQjc3WTlCajRJRi9FR2tJaEdPSTczSkZEUm9t?=
 =?utf-8?B?S3cvSjJjY1poT2lRMzJVY0ZnUTlaSnBHMlgzRk5TdXd0ZVN5NXUwSm5jMFQr?=
 =?utf-8?B?ejZrcnZrRDFBd0E5a2R1UTQ0YnRieU1LUzZQZ3FhUkhOY3g3TkJOaGZlTFRM?=
 =?utf-8?B?Wk54Sk1pUDlkeTZWZHpaQVk1Uk5JMXIvNXpRd0JSTzJYdFRkT25IY0VtTFRT?=
 =?utf-8?B?eFFzZ1ZZQzI1WTgzejl1ZDczaHFyNThlQXNIRHZYZGhVbUczbkwrWmJWQ2lI?=
 =?utf-8?B?UEZxcGFyZHZoL01EVWtqTVhJdm9HLy9GTmUvR0JzelJIWXBsZ3BFMnpTZ3JJ?=
 =?utf-8?B?blMwSzZKVHgwSjc1Sk5WaEk2K0E3NEtaZytGQkNOdkd2UWlQeDB2d2xuc2Z5?=
 =?utf-8?B?cjY4VU9TdDljSnpkMnpTd05Rdzc0YnVndnRYNnByQnY0OUpIVVRMTGJVNU5E?=
 =?utf-8?B?UUJOWEZlWXI3ZlJWMStGTHVjL0lFWUhGSFlaT29tVlFnRlNmd0FTV2RVNXNH?=
 =?utf-8?B?UEtnSVZxNkltUFdEUTJvb1hUSkx6eWtBa1Bmd2lLREcrOWl0cVBxaElVcUdr?=
 =?utf-8?B?a2hyTjJNT21mSnY5c1RuL2o4U1VXZmRseVA0UG05RzRUaWhsV01LRjZ6UUcw?=
 =?utf-8?B?aXpHOXRaeXV5YWRoaDVCd1NhVG1BbXRPQ3FuWGZ3dG81TEgzc3Vncnh2Nlc4?=
 =?utf-8?B?bzJ1UEplRGJva0U1NFZZbVZOM2twYWxNcUhacG5EQVJxU2VMN3ZPT292M2J4?=
 =?utf-8?B?RmVmamx1dXRZN01rMldaTVdocVl3YWk2WEcxR1RzWndtMnJIQlo2dVVhaXBM?=
 =?utf-8?B?cFlHUGhIUmpqYkd1NHRCNC9lUXg0UzNxTU55VDZiRDhPblc2QndKZ0Vkdzhl?=
 =?utf-8?B?Z1pVWGMrTEFYMG9UMGN1STNySjlCRXd1S0p4RE1CL0dkbVVHdHEwMUYwT1JZ?=
 =?utf-8?B?d0pvamRpOUFmQWRhQXFDNzlQSjRNTFlkdmh0KzRjeUV1dEl0TWhRSHY0VzZW?=
 =?utf-8?Q?kK2vv7U6RGxUW/t+Q/VFmZrBgwt1vPFg=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE7B95B050859E49B4149B1753724281@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdea3f3-359e-422e-9bf6-08d8bf9905ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 12:18:41.5984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LPBoNJdOEUCbwrtNSq59lS2wsTGFCPEppost8X5RNK5wA3U0b3YmvWCRXL5FZvson1J+QAc++MW1mtbgXsjiC53SUdjeXHBInJ90RKsYgTE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNpZW5nLA0KDQpPbiAxMi84LzIwIDM6NTcgQU0sIFNpZW5nIFBpYXcgTGlldyB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBFbmFibGUgNC1iaXQg
QmxvY2sgUHJvdGVjdCBzdXBwb3J0IGZvciBNWDI1NjQwNUQgYW5kIGl0cyB2YXJpYW50cyB1c2lu
Zw0KPiB0aGUgc2FtZSBJRC4NCj4gDQo+IFRlc3RlZCBvbiBJbm5hY29tIFczNDAwVjYgcm91dGVy
IHdpdGggTVgyNUw2NDA2RSBjaGlwLg0KPiBodHRwczovL2dpdGh1Yi5jb20vb3BlbndydC9vcGVu
d3J0L3B1bGwvMzUwMQ0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2llbmcgUGlhdyBMaWV3IDxsaWV3
LnMucGlhd0BnbWFpbC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIEFkZCBTUElf
Tk9SX0hBU19MT0NLIHdoaWNoIFNQSV9OT1JfNEJJVF9CUCByZXF1aXJlZC4NCj4gDQo+ICBkcml2
ZXJzL210ZC9zcGktbm9yL21hY3Jvbml4LmMgfCA0ICsrKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L210ZC9zcGktbm9yL21hY3Jvbml4LmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL21hY3Jvbml4LmMN
Cj4gaW5kZXggOTIwM2FiYWFjMjI5Li4wMzNlZGUzODE2NzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbXRkL3NwaS1ub3IvbWFjcm9uaXguYw0KPiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL21h
Y3Jvbml4LmMNCj4gQEAgLTQyLDcgKzQyLDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmbGFzaF9p
bmZvIG1hY3Jvbml4X3BhcnRzW10gPSB7DQo+ICAgICAgICAgeyAibXgyNWwxNjA2ZSIsICBJTkZP
KDB4YzIyMDE1LCAwLCA2NCAqIDEwMjQsICAzMiwgU0VDVF80SykgfSwNCj4gICAgICAgICB7ICJt
eDI1bDMyMDVkIiwgIElORk8oMHhjMjIwMTYsIDAsIDY0ICogMTAyNCwgIDY0LCBTRUNUXzRLKSB9
LA0KPiAgICAgICAgIHsgIm14MjVsMzI1NWUiLCAgSU5GTygweGMyOWUxNiwgMCwgNjQgKiAxMDI0
LCAgNjQsIFNFQ1RfNEspIH0sDQo+IC0gICAgICAgeyAibXgyNWw2NDA1ZCIsICBJTkZPKDB4YzIy
MDE3LCAwLCA2NCAqIDEwMjQsIDEyOCwgU0VDVF80SykgfSwNCj4gKyAgICAgICB7ICJteDI1bDY0
MDVkIiwgIElORk8oMHhjMjIwMTcsIDAsIDY0ICogMTAyNCwgMTI4LA0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9IQVNfTE9DSyB8DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfNEJJVF9CUCkgfSwNCg0KSSd2ZSByZWFkIGFn
YWluIHRoZSBkYXRhc2hlZXRbMV0sIGFuZCB0byBtZSBpdCBsb29rcyBsaWtlIHdlDQpkb24ndCBz
dXBwb3J0IHRoZSBsb2NraW5nIHNjaGVtZSBmb3IgdGhpcyBmbGFzaC4NCldoYXQgbXgyNWw2NDA1
ZCBjYWxscyBCUDMsIHdlIHJlZmVyIHRvIGFzIFRvcC9Cb3R0b20gc3VwcG9ydCAoVEIgYml0KS4N
ClRoZSBwcm9ibGVtIHRoYXQgSSBzZWUgaXMgdGhhdCBteDI1bDY0MDVkIHVzZXMgc29tZSBraW5k
IG9mIHR3aXN0ZWQNClRCIGJpdC4NCg0KRm9yIGV4YW1wbGUsIGZvciBCUDM9MSwgQlAyPTAsIEJQ
MT0wLCBCUDA9MSwgdGhlIGZsYXNoJ3MgZGF0YXNoZWV0DQpzdGF0ZXMgdGhhdCB0aGUgbG93ZXIg
aGFsZiBibG9ja3MgYXJlIHByb3RlY3RlZCAoMHRoLTYzdGgpLCB3aGlsZSBpbiANCm91ciBjb2Rl
IHdlIHdvdWxkIGV4cGVjdCB0aGF0IGp1c3QgdGhlIGxvd2VyIGZpcnN0IHR3byBibG9ja3MgdG8g
YmUNCnByb3RlY3RlZCAoMHRoIGFuZCAxc3QpLiBXZSBuZWVkIG5ldyBzdXBwb3J0IGZvciB0aGlz
IGZsYXNoLg0KDQpDaGVlcnMsDQp0YQ0KDQpbMV0gaHR0cHM6Ly93d3cubWFjcm9uaXguY29tL0xp
c3RzL0RhdGFzaGVldC9BdHRhY2htZW50cy83MzA5L01YMjVMNjQwNUQsJTIwM1YsJTIwNjRNYiwl
MjB2MS41LnBkZg0KDQo+ICAgICAgICAgeyAibXgyNXUyMDMzZSIsICBJTkZPKDB4YzIyNTMyLCAw
LCA2NCAqIDEwMjQsICAgNCwgU0VDVF80SykgfSwNCj4gICAgICAgICB7ICJteDI1dTMyMzVmIiwg
IElORk8oMHhjMjI1MzYsIDAsIDY0ICogMTAyNCwgIDY0LA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBTRUNUXzRLIHwgU1BJX05PUl9EVUFMX1JFQUQgfA0KPiAtLQ0KPiAyLjE3LjEN
Cj4gDQoNCg==
