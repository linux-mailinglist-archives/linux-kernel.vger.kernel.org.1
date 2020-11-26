Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB4F2C4CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 03:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbgKZB7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 20:59:52 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49060 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgKZB7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 20:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606355991; x=1637891991;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hLH1GZJznFxylLd3bh0gWdDDGMaTz9BQ4rFLGchGfas=;
  b=JYucGQpk/3pkvoUAWVVB+9+vpb6SpXkmfL0iCQN1Dw/VYA14KdrkxyFL
   ONL174tV0qOWFWvD2W2ewBHimXiwIS33RgIf1anMlZrtpTRcB+J5gpmxO
   fBRYp/PU9eQc0ked4T4drIxxZ0ZLn0yXbWGJ0mhR3cttJQUuGaP1X90QK
   MrQu3/ywvRrb+B1Orlv/9b0S6zN5rv5qVapYOZkyb2lHN9pbGVws2ojgg
   CKE0F+7gZCNIpLLikg/3/71NIzuEgH3ZM6DBy9RGeYDsf64YzhtGfVvm6
   YrjudTzOsY1VtHNo44eJvNvE54LvhycvMaQMGx5xYxTZO4fi9CYMcop3B
   Q==;
IronPort-SDR: HgBIPnsmKiIlRptB2Fs74YjdtiaOg7mkFS7uQ06oj+oHG3tNv7mwAxB7LlRnO8fT3LesSpoXHB
 eRWKl3f0i8OAOTCZkbtIpF/QlD2eTrDD9UdVfgbHLuPSLZUdPBI7lwXtz5IVEJVq4QcXRHZacS
 f1C6VpM4AA3JLTAgHQ6W+Va4bUJmjLSA5LhRypCot+TGzfEkTT6v3ep93y8Rlxz1wQ+ta2a55c
 ejU8MuGwQMf+XQlKuFbevyPGJj0H8U9tPdDNh56W7qlfaOSo05hSlJx0ufoAKeYT6622wEIPuh
 QCU=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="263589830"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 09:59:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+huePT5z6gag+5l6RVgUwA0zjj+2/6oFcSahf6KJOsIoxEgIvjiXWecd9e89MOV88jljgxhHKkoyf0gXizeQJK7yGYcGSGvtHJiyp7fkyLzI6SxWtZcC3qSq3tUBFEJYeSBYbZVZa/llO32WHP3BNVKx5gxk1cXO1O0rUJr2hSRD9NQeTVhS359fA8iDwMBN/S8CRQEShL3rENRsnEbBp/IcS4h8u6BSOCq63NxfrD2bsh1G+Pnwg5c+7rx2AKnFb9epIX1Scye7iytAONRlIbu9wkoCaIrc+Zd8nppxx1IEtkzuFCS9+b5fqbTPm5Micql9y45NBCTPZpJ3VWnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLH1GZJznFxylLd3bh0gWdDDGMaTz9BQ4rFLGchGfas=;
 b=W4a3jRBPGWG4jsj2zlsucIVVyeYCWhjKlJKmr3sPNP495S30Eezr6X9C7b30ZxfgAcZR3/PAfb0FMZ2mCE5zLTPz030j5mv5826X73GkY/0pOCCO6qtKVGjWtfwjj8JVed1kY2QLMNZQAvIGCClYjn2CktffUpKinoebD3h/vAOlo+PQCamYI7P1cefhEQzyVluP96B33PCA2ctpMxoVdqsfBdKkAoT1sEdCaG9XRUZxr6Y8YtzMvEArZev0+/sDia1914V5mQnuBn7qroKL9dKVo09GMIbV0w0PZODinnZaBaqH+acYigF1vH6WouIRxTvh8LutOSeHCdEhMfJ1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLH1GZJznFxylLd3bh0gWdDDGMaTz9BQ4rFLGchGfas=;
 b=G9PyLHoQBuJVHhK9e+VXnJ23HmVTHTIVt5AdB5qKpYpzPv/8sjL5v3Wl093Y10bOUD03aa0r4ilsOUkaNqff3WhQbzthfS+LVEH9f0uZH4Iectctesm+7HRRFbB1uEJp319BLDR3lt96FRgOLH1Xx057lZ9dQ7bst9EpiZrZiHQ=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6981.namprd04.prod.outlook.com (2603:10b6:610:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Thu, 26 Nov
 2020 01:59:49 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 01:59:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "geert@linux-m68k.org" <geert@linux-m68k.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
Thread-Topic: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
Thread-Index: AQHWwpO1HQiFqsmnr0WJzbSNTitMeanYzQ6AgADdbgA=
Date:   Thu, 26 Nov 2020 01:59:49 +0000
Message-ID: <90f3fe7ae4b7ff5164e2eca65f1fdb72deea7463.camel@wdc.com>
References: <20201124185738.3541314-1-geert@linux-m68k.org>
         <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
         <CAMuHMdW9dySq3y_Uixv8_7e+Pe2VKw4iGV36mx-DbX6-yzk-Gw@mail.gmail.com>
         <CH2PR04MB652268FD0FB44AA5DF36ACFBE7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
         <CAMuHMdXEzo4EOw_=MgskNXPrbkP4Ui+dHKZ5iyJ04h453BUAhQ@mail.gmail.com>
         <CH2PR04MB6522E6443C6E12CD28FD1A30E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
         <CAMuHMdW4YC4mNcX28s6HDSc-tuks2H7i-vojsOLbmaCBr2o2Ow@mail.gmail.com>
In-Reply-To: <CAMuHMdW4YC4mNcX28s6HDSc-tuks2H7i-vojsOLbmaCBr2o2Ow@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.1 (3.38.1-1.fc33) 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8d3e:27aa:85c2:44b5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b4245a8-8079-4dc0-e02c-08d891aef4ef
x-ms-traffictypediagnostic: CH2PR04MB6981:
x-microsoft-antispam-prvs: <CH2PR04MB698140F3C9F07E5F10B7D4F1E7F90@CH2PR04MB6981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4OwRSQahayX/4NvO9qOsC7+0YMwLxvW885ZpLHaBNYOZ8aYCipcQzQWJSSedBDkliq65kWE9xq4mlJF3g7mUFBN3DCHuc7wQ5eDpHQFUyJEWG8FaBM6g+w9TDaDM0TE5sWJXV/fw5V3NEOgPMArfYRbhgR7RifKH6+9Asw66ZiD7L/0OwjrlfMEOjJr9vNjAZhpYuKFOpKUy+4spA6BUSqINkwMLCg7ov1Kp3pbbWwhq26ST9u41A8uwa28DHAAyzVR3Cp1TxMuTMU9Y1TNbMfhBD/REk6Pq2XC9uks7LgGuNenIFHhkSFvXb2qQH/OqerlWiU4kTKqOOeApWFYCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(366004)(66476007)(91956017)(76116006)(66556008)(8936002)(83380400001)(71200400001)(4001150100001)(86362001)(8676002)(5660300002)(186003)(4326008)(66946007)(66446008)(6486002)(2616005)(64756008)(36756003)(478600001)(6916009)(316002)(54906003)(2906002)(53546011)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SlVWalVKeEF2Qm8yd2hiNGtUOU1JNTQrSEpERXVVNVV0eUNKdU95eHgxckZR?=
 =?utf-8?B?Ry9Zc0NOME9RWlpEbXM4SHZQRUV3L2Z0cE1SaklsUmQ3N1ZlSElTYlBrS3JQ?=
 =?utf-8?B?aG0rSHdRVzRzR2V5VzF0SlIrWnNYQWFXWkNhTUdFVTZWRmk0UU1CKzNUMDlr?=
 =?utf-8?B?V2txaXpKcStoTkhPOVBQSFFjWnlhTXpMdEdWVFA1VzZ5cFJNU21LYXZTNys0?=
 =?utf-8?B?a1BRdUZwK0lZZUpuVTVvbmR3QWRsdWo1VVU3aURFeWpNdlRGUyt3anBLTGI3?=
 =?utf-8?B?cXdpQi9weDVJZk5tcmM2RzBJNUlXdW1GWklBNmdCRXh3cGtlZ2VDaDhCa09r?=
 =?utf-8?B?d3JxSkN1NzRyMDhqck45UHFnWE9yNUJmcDd1aFdQdU1XcXRoZ0RwdDBCU1ZB?=
 =?utf-8?B?ZjRSdWlqcWZhRjFPNEpBbVFtaW8vV3lCc3JLR25EUnA1eWZETUw5SEVFaTFK?=
 =?utf-8?B?QVRwRHlOVk1TZTJtTGhUU3hvZW81Vi9BV0Z2Y0hoN0JYNDF6Wjk4VW95V3gw?=
 =?utf-8?B?TkN2QTU3K1U5M08xek92ckRyajc5ZFAvVjFISnhpS0hZbm1MWVNxajh6WnI3?=
 =?utf-8?B?aTUzcnloQXVkNTV2Y05BQlpBZHA4YW1XN0tsUEMzcE5yeXZFTjdTbjBieS85?=
 =?utf-8?B?ZnBSUWZLT1ROem9rWHFNQlN0MC9lNitZbXFRK1ZlQWlrMnV0UjU4TW82Rm9E?=
 =?utf-8?B?Z3p6MG84STZBMC8rWHdrUkRQSUZKY2dIajZDeUNRNXNuaFA0Ymh0Y1ZQOENm?=
 =?utf-8?B?MTdqbzFuc2gvWllobGZDTHdpcXlLQ0ZjQU9KeCtlQVRqbllsMFMzRjBsUDFp?=
 =?utf-8?B?OGJBZjdMZm5yY25JajlBbEliUitRTWpCYitEOEtxb0xKUlI5Y2lxNkRGc1lv?=
 =?utf-8?B?OFhLSmRhWE1DYzhXK0VraG5xbUQwTnVweHRKOXNlSHIyRHl1NWdoRWkyVXlK?=
 =?utf-8?B?djBsVnhnZS8vU1l3Q0RYeDR2VW1ucEZZdHlTeWhZMjFjTUpoYVZ6M0hRNFRl?=
 =?utf-8?B?NXNwdjZ5cERob3JWaUh3UWszdWlqbFJlZytxVWtJQ1ZIOENyRG14b2VjcFF2?=
 =?utf-8?B?K1d5Z3AwNFh6TE83VXl4QkVxUGZ5MERvWmIyNGF4WFJWajlDOWRubW9yK3R6?=
 =?utf-8?B?dzlXTE5pSGtKdllXTVFkRlc5MGprOUtxRlRBSmpQMkJDUjRqK08xNnFCL252?=
 =?utf-8?B?OHg2THh4Q0dyVHFMd2QrME1Ua3JaTGZXSFlybHU4QmxuaG1QNDlXUnRYUTJC?=
 =?utf-8?B?NHRrb2tObU9DS09wbklCaElkRGpoVGQwdEJENVpPcWI1bTVNczlrN3VRdVdo?=
 =?utf-8?B?NVgxZWEzWm1sZXpyTk5VVzdKbWdrWDlaR0Z0MmRjdmR2eEZxZmpCRHdwQlVO?=
 =?utf-8?B?NjlBK0VqUU1FTFkwK2hrVUZqL2xZTWhxbE1mWGUxMkJKK1pwRDdKbU5mYVRy?=
 =?utf-8?Q?l2l0AJqD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0B104DE972AAE4698E82461FD607D00@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4245a8-8079-4dc0-e02c-08d891aef4ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 01:59:49.1896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a7PC+nBa43k7oJo5uOLyE05CY++eyV1dF4r/6L7Sx4HggYRsgywkpPeA2RxMmigddNH5Yjw7KKctZe4SIMs0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTI1IGF0IDEzOjQ3ICswMTAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEhpIERhbWllbiwNCj4gDQo+IE9uIFdlZCwgTm92IDI1LCAyMDIwIGF0IDEyOjAwIFBN
IERhbWllbiBMZSBNb2FsIDxEYW1pZW4uTGVNb2FsQHdkYy5jb20+IHdyb3RlOg0KPiA+IE9uIDIw
MjAvMTEvMjUgMTg6MjYsIEdlZXJ0IFV5dHRlcmhvZXZlbiB3cm90ZToNCj4gPiA+IE9uIFdlZCwg
Tm92IDI1LCAyMDIwIGF0IDEwOjAyIEFNIERhbWllbiBMZSBNb2FsIDxEYW1pZW4uTGVNb2FsQHdk
Yy5jb20+IHdyb3RlOg0KPiA+ID4gPiBPbiAyMDIwLzExLzI1IDE3OjUxLCBHZWVydCBVeXR0ZXJo
b2V2ZW4gd3JvdGU6DQo+ID4gPiA+IEkgd2FzIGp1c3QgZmlkZGxpbmcgd2l0aCBDT05GSUdfVU5J
WDk4X1BUWVMuIERpc2FibGluZyBpdCBpcyBPSyB3aXRoIHRoZSBzaW1wbGUNCj4gPiA+ID4gYnVz
eWJveCB1c2Vyc3BhY2UgKG5vIHRlbG5ldC94dGVybSBsaWtlIGFwcCBydW5uaW5nKS4gQnV0IGl0
IHNhdmVzIG9ubHkgYWJvdXQNCj4gPiA+ID4gMUtCIHdpdGggbXkgdG9vbGNoYWluIChnY2MgOS4z
KS4gU28gSSBsZWZ0IHRoYXQgb25lIGVuYWJsZWQuIEkgYW0gc3VycHJpc2VkIHRoYXQNCj4gPiA+
ID4geW91IHNlZSAxNksgc2l6ZSBpbXBhY3QuLi4gSG93IGJpZyBpcyB5b3VyIGltYWdlID8NCj4g
PiA+ID4gDQo+ID4gPiA+IEZvciBtZSwgaXQgaXMgMS43NjggTUIgcmlnaHQgbm93IGZvciB0aGUg
c2RjYXJkIGRlZmNvbmZpZywgd2l0aCBDT05GSUdfVlQNCj4gPiA+ID4gZGlzYWJsZWQgYW5kIGV4
dDIgZW5hYmxlZC4NCj4gPiA+IA0KPiA+ID4gSXQgbWlnaHQgZGVwZW5kIG9uIGhvdyB5b3UgbWVh
c3VyZS4gICJzaXplIiBzYXlzIDE1IEtpQiBpbXBhY3QgZm9yIFVOSVg5OA0KPiA+ID4gcHR5cywg
d2hpbGUgYmxvYXQtby1tZXRlciByZXBvcnRlZCBsZXNzIHRoYW4gNyAobXkgc2NyaXB0IHVzZXMg
InNpemUiKS4NCj4gPiANCj4gPiBJIGxvb2sgYXQgdGhlIHNpemUgb2YgdGhlIGFyY2gvcmlzY3Yv
Ym9vdC9sb2FkZXIuYmluIGZpbGUgc2luY2UgdGhhdCBpcyB3aGF0DQo+ID4gZ2V0cyBsb2FkZWQg
aW4gUkFNIGFuZCBib290ZWQuIEl0IGlzIHNpZ25pZmljYW50bHkgc21hbGxlciB0aGFuIHZtbGlu
dXggZmlsZQ0KPiA+IHNpemUuIEUuZy4gZm9yIHRoZSBzZCBjYXJkIGRlZmNvbmZpZywgSSBoYXZl
Og0KPiA+IA0KPiA+IHZtbGludXg6IDIzNjk5MjAgQg0KPiA+IGxvYWRlci5iaW46IDE3NTEyNTAg
Qg0KPiANCj4gRG9lc24ndCBsb2FkZXIuYmluIGxhY2sgYnNzPw0KPiBCc3MgZG9lcyBjb25zdW1l
IFJBTSwgc28geW91IGRvIHdhbnQgdG8gdGFrZSB0aGF0IGludG8gYWNjb3VudCwgdG9vLg0KDQpJ
bmRlZWQuIEdvb2QgcG9pbnQuIFRoYW5rcyAhDQoNCj4gDQo+IEdye29ldGplLGVldGluZ31zLA0K
PiANCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgR2Vl
cnQNCj4gDQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRhbA0K
