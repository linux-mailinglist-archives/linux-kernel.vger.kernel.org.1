Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 174592C3B06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 09:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgKYIXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 03:23:19 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:53571 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgKYIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 03:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606292596; x=1637828596;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GH40gUjsDaAUM4h3eOTmmqmDxXHZ9y53Y50Io+K0n64=;
  b=gRd1Yb0/zSN3IDr/YTUCgdYak9omP5iRhD7AHSSrXNVXLn4/1ThFYRlI
   yI0RWPbdZ++59O8nlUY2FBqcJ5Pmuh15fxLK3zMwLm6LajVS4zEQoGMwj
   JUE1YsYH6kOFoe9tqraSqTmlXV8tSkuPbhy4skDJXg+FWbmO5DMmPHqVO
   P44/wHlQvS1U4afroZ7fmZdtUGpMCl0pwyjpQyRC07KaNxSTbDXIccEzL
   Ok14n5617ZN8MGIUEIIv3+LCpqP9BxzmZZ9HOZUSaRIFmZpa2wVJYKlEX
   uDlUGHfgM7Hi0WXiOuBHEVso1XEe4plgnF2maQEzRzkyHFmkoE2DQfSRq
   Q==;
IronPort-SDR: rYTz8LKAegkNdQwaf3rUBHMDXQSR8FHdxytdgfJ3pzt+1cRRqw0PgOViwWuIVKxmNo9u9euB0v
 5JKIVWh+JZd68g8Df8O5pcBNmMxvtFrSHq6fp0CPr5apaS7noncfXO4wsHS2ul8w0jJrUAHCG9
 rQwohDZr3pQWKokbtQOkRPR9JoFFMl7hv6+2mAos8mjoKX6S2IknC7bAMXzDuGXvXnmVWNUJ7R
 mSyV+bh+BUK6dFLeRnR0M+yYPh5W8wWSCBy18+DpCHqrJouhi0BZafDQJ7niBei0Z5599TRDsa
 8Fk=
X-IronPort-AV: E=Sophos;i="5.78,368,1599494400"; 
   d="scan'208";a="157906195"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2020 16:23:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RCvNIlzJ/Yj05XKQq6dIyobOi26LRC+aFOee/rD0PiaVcgLx+vZXjx9dw/zCGq9O4V3YsmGIuRAbzmUSMve3Q71/cQ5tu9Zi/3h3huELu3BEsV2I2N1w9HuQubulrOeI12m7a0Y0smD0E7dZv7ik/aA4opio8LBLADXF2oJ7VjuJIXQUCH8/Fpwz1ZsJsA9t1X7IYcMg7v3ncvbsjNLgrxiZCBFPOsnCGwzjHDJktGU4p7YRoSHAVvy6C7Pg3kMTK8BLi971/ht1AlA78dY3ycisDi8u2njtQqGTaFVUJRQxB9Wpn7PMSMvfOH2OLkQMV7g0qxKuejlsT8B0LMeavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH40gUjsDaAUM4h3eOTmmqmDxXHZ9y53Y50Io+K0n64=;
 b=SGhJlpuMItoY8PIr1gVvz7KQHb+TRfzp4LY7QVM+z8pZFpBWPfOYkfBTMwlNtzsUvxGhlvrvDqPCsuwRaXjFWeeAF5rXAN52uuAAN4sP5VboALKACt+ybNZPhzf1+8hGFf/J7XzW+wtbgrpNdUaruKVRtpwKGdLiXZQVO9D+CbAki/upAdDC6L1X8QmJyyY7UWJyw1JMcHpLnblpnUVCD1WSbWjZQByJZojovLCM93hTmFhSxr9f63chQEQm1Bal0Hyb5XyoogMA1Jikvw2MvpPAo2aEySA3vyNRUgegUR1Sz19WW+GU+lIF1dTUGztf/UOtoDkaEa6TVrAZYI6QFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH40gUjsDaAUM4h3eOTmmqmDxXHZ9y53Y50Io+K0n64=;
 b=rzwxWigYEtMtgh6/wBFbES3YF435rq49suptyHTtYYgYqsC3tB4p8hFls/TU48eYgJJZJ6I8uIJXUH5p6iWizf1pNTAEQSYEbZ1Q5J/B71J4/iXS3KooTxt3Dw79kIUTxRwzOR5O/TaeEZJFtwl13ptRM1vUVH2j0FbIkmBZWu0=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB7126.namprd04.prod.outlook.com (2603:10b6:610:96::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 25 Nov
 2020 08:23:12 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Wed, 25 Nov 2020
 08:23:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "geert@linux-m68k.org" <geert@linux-m68k.org>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
Thread-Topic: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
Thread-Index: AQHWwpO1HQiFqsmnr0WJzbSNTitMeanYgm6AgAAA1oA=
Date:   Wed, 25 Nov 2020 08:23:12 +0000
Message-ID: <2cdeff2f8c483b83879e46786169b79497b03492.camel@wdc.com>
References: <20201124185738.3541314-1-geert@linux-m68k.org>
         <CH2PR04MB652231C5B82E9F8184F496D8E7FA0@CH2PR04MB6522.namprd04.prod.outlook.com>
         <CAMuHMdX7FvJAPtGaAa1=V3X-LVA9oB+MK7GNg02pj5874MMLVQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX7FvJAPtGaAa1=V3X-LVA9oB+MK7GNg02pj5874MMLVQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 0d6cf9fb-b3fb-4e6a-fcbe-08d8911b59a6
x-ms-traffictypediagnostic: CH2PR04MB7126:
x-microsoft-antispam-prvs: <CH2PR04MB7126CE03D5FAE6E625B21438E7FA0@CH2PR04MB7126.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MysTP8gClybzf9uNmEsEkPKVoi8UyNXkYhdWnq7Q9j86YwSqzAq9nf1qxzN7VoqPJ43pd4gvPGSb5y5lPGt8USxfnxEvKlQgJazzuxhyyLpkXdu7FuljD77zOdNNwcBRqTH0BnMbVBfwmeELOOBpnCQmD1Vkkotmv+k+UxsuZ7JyagRGEsDLrQpzE9m6iwY2tJ0iaG9QaLHG4MBr2WaYCEo4VZZVwfhJvOS/9jdNw0oWxPBz7EfjT7EeX0Y5y+YCU0YK3gVceTTFH/a8mf9EITkNoWvZ1yDEtxDE23FoexhxrJz0C6oyEwMkD07dt/D5hBKWK5l4llgnvReyg1ZDxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(2906002)(6512007)(478600001)(83380400001)(4326008)(316002)(5660300002)(2616005)(8936002)(86362001)(186003)(4001150100001)(6506007)(54906003)(6486002)(8676002)(6916009)(36756003)(4744005)(66556008)(66446008)(66476007)(71200400001)(66946007)(53546011)(91956017)(76116006)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aXpjUXRBcXJPcmNQd1M1ZEYyT1RPQll3amJ4amV1S2VxOFg4Nk1jK3RQRnRz?=
 =?utf-8?B?WTNmMENzanR4SXJBdDdxcTRoSXlXU0FiL1lacHRZTFhSeVRUNlFvM3BjWFFQ?=
 =?utf-8?B?N1FWcDBCazkxYU9RV0xUQlk5SmxhNlNIczBldjU0ejBCNlg5U0toS0NORkdB?=
 =?utf-8?B?cGRMZGQwVU95dFYyZTlENkt1ZXNpVm1zMmI5Tnp0RzNmUmlwenJIcXZmMnh0?=
 =?utf-8?B?L3hRVUQwUVN4dmYwQ0VldVE0TVB2azU4VGhsRDdPWWRHYi81VXNRRm9VWUlt?=
 =?utf-8?B?WDFwK0RHcFE0Y253blIvVU84MllIU2NpUFJQWElicDlrYi9kTkl0VHE0SlEy?=
 =?utf-8?B?azBBVkRwNTFjaktaM0RTY29UZThSVFhIMnEyUTJReWx0dDBLOVlRbE81Z1Zp?=
 =?utf-8?B?alFNS21uTmtGbTBJRytHQkFtSU0rbGFySlM4WStTQUJPMkM0aXR4WFc3cS9Q?=
 =?utf-8?B?b0FTbUhUZHUzd2ZFUTRaaDMvUEdTTGgvYXR6SHFERDRwRU8zZWZtSXFId0xz?=
 =?utf-8?B?WVhVUWNkY0lQL205cEJjdi84L3R5c1laOXZ5T0xxMk8xYTROWmpVeWVVbVdt?=
 =?utf-8?B?aDRqdVB6c3pyLzJQajE2bEVyK1lKLzBwby9oUHBMaTNxWEZZOHVNZ2NPSm85?=
 =?utf-8?B?aWF5dzBKMWhJNnlqNCs3aDJkNlQ0U0N0L0lsY09tVDdPY1EwMVVUY3VYMTJF?=
 =?utf-8?B?RnEvcVl0MWFNeGpmQWo0ampVN2JiOWZhd2tTZ0JBTmFWYzV1SVl0d3lMcE9F?=
 =?utf-8?B?YlMwcTdnMHRxcm1YdDMxWW5RR2FNQ1pCWWsyZkU0QlA3NjJNSjFCTEpLTDd5?=
 =?utf-8?B?ZWZ2SnoxbHBPT2FLTGxrSU5NemRrV3F3ZURKc2VQbHhTUk96ZG9WT0pFVWs2?=
 =?utf-8?B?cXV6dktYRDRnOWhzUGdZeE9UMmRKZVl1WU9tVFdUKy9vbnJtYVlPZEkzSjE1?=
 =?utf-8?B?RFhRQXliRHg2VE1SbW44aysrVzk2UFovSHAyYkFRWkRmZmtMSzkvWmh1MXhV?=
 =?utf-8?B?SDNPNGQyeG01TGZrM1ZlVDVvdko4ZzU4ZjljZTRMMEU5NysvU3V4UjU3K1Ra?=
 =?utf-8?B?d0hYU0wvaTFyQ0EwZlE3Y1M5QW9TOG9BK2QvVkpoeS9QU1phRFRqZmV3eXBO?=
 =?utf-8?B?MDZLZHBIcmN6TlNWMDk1d2VQVzQwRmZtaXRVWk00OVpWbm5WMHJ6Qm1tM2FE?=
 =?utf-8?B?c2ZNS0V4SmlSN3NrRlFEVDQ2eTFzNXEvdmtpMmxaSnY3R2o4dFRzNkE3SWFE?=
 =?utf-8?B?MXVmVXdJcjA1NE1CT1ViSjVadFlpNFhsdkdkcHEyVVZ3VVBBUDBLNEVrLzFK?=
 =?utf-8?B?bGRzNU9pc3hvTUZHRHBpVFZ1MzhFemlGbHMvaitPT2FpZ05JY3VReldVSEFH?=
 =?utf-8?B?aDJDUFFNK3dSaGdGazRiTThWU0E4dVZjM08rOGJiVWNvTkJCMVBXUHhHaDZx?=
 =?utf-8?Q?t8Xh/rK5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <67A03975B9C7EB49ADE9FDBE7E729781@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6cf9fb-b3fb-4e6a-fcbe-08d8911b59a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2020 08:23:12.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tB5GGYML1hdB1T3vXYe2CW/goCmqMvQ836NYNxkJcGIQiyrRo78xgPk8KPfnFJgjXa7gWZEdDCcJC616l06HXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTExLTI1IGF0IDA5OjIwICswMTAwLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEhpIERhbWllbiwNCj4gDQo+IE9uIFdlZCwgTm92IDI1LCAyMDIwIGF0IDc6MTQgQU0g
RGFtaWVuIExlIE1vYWwgPERhbWllbi5MZU1vYWxAd2RjLmNvbT4gd3JvdGU6DQo+ID4gT24gMjAy
MC8xMS8yNSAzOjU3LCBHZWVydCBVeXR0ZXJob2V2ZW4gd3JvdGU6DQo+ID4gPiBUaGVyZSBpcyBu
byBuZWVkIHRvIGVuYWJsZSBWaXJ0dWFsIFRlcm1pbmFsIHN1cHBvcnQgaW4gdGhlIENhbmFhbg0K
PiA+ID4gS2VuZHJ5dGUgSzIxMCBkZWZjb25maWdzLCBhcyBubyB0ZXJtaW5hbCBkZXZpY2VzIGFy
ZSBzdXBwb3J0ZWQgYW5kDQo+ID4gPiBlbmFibGVkLiAgSGVuY2UgZGlzYWJsZSBDT05GSUdfVlQs
IGFuZCByZW1vdmUgdGhlIG5vIGxvbmdlciBuZWVkZWQNCj4gPiA+IG92ZXJyaWRlIGZvciBDT05G
SUdfVkdBX0NPTlNPTEUuDQo+ID4gPiANCj4gPiA+IFRoaXMgcmVkdWNlcyBrZXJuZWwgc2l6ZSBi
eSBjYS4gNjUgS2lCLg0KPiA+IA0KPiA+IEluZGVlZCwgbmljZSBzYXZpbmcuIEp1c3QgdGVzdGVk
LCBhbmQgYWxsIGlzIGdvb2QuDQo+ID4gDQo+ID4gQ2FuIEkgc3F1YXNoIHRoaXMgcGF0Y2ggaW50
byB0aGUgMiBkZWZjb25maWcgdXBkYXRlIHBhdGNoZXMgb2YgdGhlIHNlcmllcywNCj4gPiBhZGRp
bmcgeW91ciBzaWduZWQtb2ZmLWJ5ID8gT3Igd291bGQgeW91IHByZWZlciB0aGF0IEkga2VlcCBp
dCBhcyBhIHNlcGFyYXRlIHBhdGNoID8NCj4gDQo+IEZlZWwgZnJlZSB0byBzcXVhc2ggaXQgaW50
byB5b3VyIHF1ZXVlZCB1cGRhdGVzLg0KPiBObyBuZWVkIHRvIGFkZCBteSBTb0IsIGFzIHRoZSBm
dWxsIHVwZGF0ZXMgZG9uJ3QgcGFzcyB0aHJvdWdoIG1lLg0KDQpEb25lLiBUaGFua3MgIQ0KDQo+
IA0KPiBUaGFua3MhDQo+IA0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEdlZXJ0DQo+IA0KDQotLSANCkRh
bWllbiBMZSBNb2FsDQpXZXN0ZXJuIERpZ2l0YWwNCg==
