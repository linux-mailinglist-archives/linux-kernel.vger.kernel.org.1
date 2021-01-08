Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97602EFBD2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 00:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAHXrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 18:47:47 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59891 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbhAHXrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 18:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610149665; x=1641685665;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ioMdoSOwIADbayZhkHQ3s0SQGvdlBaTi7whqvgvLPBs=;
  b=Vyj8PWA2lhBcXlIxbSXuZX9L1+nEztEGucqB9XhFAad5RCmdVQEaXw+u
   LOhGRyrN0ORWP4IGEEdXkWbdmZ1lzh56oaqJfPkA+dVVhQH6KlFMdvFOG
   7W7TZU+qwhzhoNJGcriL7W33RO6D2eXK+oGRLOGISzAeUTS2sJ/ggZiyR
   D/5HBMUB24fXW5hrPPwbopLhdPsiRa8rK7g7oB2VFPOBEDbuWqne+OaTW
   thVODMsxx9MKr2bMjZF/gQRU3GfoQJntBidptER1UUKGon04cm60PFxCf
   eKEJoiFs1ZQDiXLPJa1DRmGPwc5JmACCk1H0Ac0SYIUAMafAxMuK4Mc3K
   w==;
IronPort-SDR: HxJhnUWQHp2QUrMI6PTxQHVs1rUYZWmMfOWlF3ySwH5Mz+1EolQbNzvd75MkxIcutKoEutAtm4
 eMLubLbU8AQwFS8vkhGfTQyvgTp/Y94Zs4Ezq117W08wzB/JtyGwB0VjN3mqnxuPTjqT5pBzrz
 /aa76MQRzcLB/a9Y/wTpd4IsARsyJscbfjnN+ZiDxLbR4EXNn528XafBj295yRP7ITDxWnSpTL
 WXLPT1ZM0BKO+IPFJLou+X49izytpPWRYRHYNHb4iGgHtcnDCffSWdF6jZHAXd/rHrvtWbwflq
 WdI=
X-IronPort-AV: E=Sophos;i="5.79,333,1602518400"; 
   d="scan'208";a="161413295"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2021 07:46:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMgR/DlitOdN8RFNkQmS2n1ar0Y5880bzGx2eUbakJdlcj4luqIv784xnDJQRn4Lbm/S0qkGbg5Gh1JtMdOptp+65Tv0/ftCV1ti/2LQYWWMoPl8tWV1djCLhpnY/Be/iJFKFw6v9A2hmBxeBPeKbsLJW+JqKm9j7EWV4/FvpSBzvGtRu6gh+WWPS0RXosUEsv9wnj8qIMug1+3LCa4lBqwXgPqmSPgRzb4RTVs6Ef1baZtbCq/uI95p/nPkaasbb3LmFhFEiRdXk+BtVHfy3igW3iDnMmJ7eT62Y9EAieSdiYFJxHe9JqCYI85BB1psgepx3i4mdUVncAMUyZ8HcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioMdoSOwIADbayZhkHQ3s0SQGvdlBaTi7whqvgvLPBs=;
 b=FXCIczwq3Y61fwQHE3Po1MAyN0zlYvs6wOtqJJjsq+sEYEUiQ69RIVZ8smoVe8KyZqvB0xp6lIvacNFJX8xGrtVkoPrI+LO7ymmSWssK/1f3CuijanOP5HEJXt20SHFNGWNzzemAh72fW9KG+KoAXlHFzK8UJ2aRBueFVoqKuLWRpO+Gj+Tw90xNgt/JCK6nITFyMLNQwVHr3q11spzKp85rPkRL0re2ydnQSNjVYDWAsngiBYMyBFTGkwRxiGtUD1YRoE0jb4vi4tFrnp39W7ZuPjK9znw3QO8x5ysf532sfz5/Nd66S+Ypk+q/spPRFv1b7eWjP5GU93lqC1FFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioMdoSOwIADbayZhkHQ3s0SQGvdlBaTi7whqvgvLPBs=;
 b=LS0bzfqmHRybFHEXz9mHpUJR9Z2Y5MLU9Mj18My5kmX673H5B5lH8xxwECW5Dby0oYbCRiDsIvlgkR6WTPVIAYBN2hbowBioUmcxhonzTTmjip7hXaZ0qllgUcBcW2QBDbUPFekrbobALMMBvmTrf8/FQRtc90cB9iWVB33ActY=
Received: from CH2PR04MB6725.namprd04.prod.outlook.com (2603:10b6:610:94::15)
 by CH2PR04MB6630.namprd04.prod.outlook.com (2603:10b6:610:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Fri, 8 Jan
 2021 23:46:37 +0000
Received: from CH2PR04MB6725.namprd04.prod.outlook.com
 ([fe80::bd97:28d8:19a4:3059]) by CH2PR04MB6725.namprd04.prod.outlook.com
 ([fe80::bd97:28d8:19a4:3059%2]) with mapi id 15.20.3721.026; Fri, 8 Jan 2021
 23:46:37 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     "cyril.jean@microchip.com" <cyril.jean@microchip.com>,
        "daire.mcnamara@microchip.com" <daire.mcnamara@microchip.com>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "padmarao.begari@microchip.com" <padmarao.begari@microchip.com>,
        "devicetree@vger.linux.org" <devicetree@vger.linux.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>
Subject: Re: [PATCH v2 0/2] CLK: microchip: Add clkcfg driver for Microchip
 PolarFire SoC
Thread-Topic: [PATCH v2 0/2] CLK: microchip: Add clkcfg driver for Microchip
 PolarFire SoC
Thread-Index: AQHW5Ok69LDYftaUuUODzIdNrvPcsaoeZy4A
Date:   Fri, 8 Jan 2021 23:46:37 +0000
Message-ID: <50b7e971fe1ec3020401ca81bbc354fcbabc105a.camel@wdc.com>
References: <20210107113500.15642-1-daire.mcnamara@microchip.com>
In-Reply-To: <20210107113500.15642-1-daire.mcnamara@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.2 
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [99.13.229.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 516bd751-29d3-4fde-61a5-08d8b42fa380
x-ms-traffictypediagnostic: CH2PR04MB6630:
x-microsoft-antispam-prvs: <CH2PR04MB6630047DF3991FF854CEB4F2FAAE0@CH2PR04MB6630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xNo+udQJWEui+Z6jlHAZA7USEQWbHJK1TOc/XOfzuq4kyN3clB0PpVuBE268KHxBJUs8aEtIVw/HHiPSPtqn/AUf9rhF6aMRK/MWte3EdpyvKRjX9D+74xY46TDrIXCpV6EpJ4FzoQNsTEi6VR5/OjPtM2NBS+5vGTiLluBgYNl20fzKjYYmYt00X4xYTF6R3odrF5x1jvQkXF9+dBRFh/+FvvqSWx0x6vdCKcjaylEtJohihPvL8Toszaer9LUtXbitzFHXu6/2LKlofwDdCOEuCu1WJn4Ri5Xn78jOHXhXq3XdXx7aAVxK8SwOYpURMMDuPeILRRlt6jbillOJqlnjhuCDhn4vVQdVr2zrNUS5MLU1mZeiRPG25VYITILqFgkkA8Gn7OIZGXub9XRra3dzvJxIlFRfsGEenBTp4qiK/7hsfPBMOuScUDp833laDZLSMKO78sJPrEiagodPmEqcJ3rNukzVqqAj5lNP4gC0WOkR5rotrAI2KPw2meld4ewgpAjNS/wb6IVgwlK26Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6725.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(478600001)(86362001)(71200400001)(6506007)(2906002)(2616005)(26005)(5660300002)(186003)(966005)(4326008)(66946007)(7416002)(110136005)(316002)(36756003)(8676002)(66446008)(83380400001)(66556008)(64756008)(8936002)(66476007)(6486002)(54906003)(91956017)(76116006)(6512007)(40753002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TlAvTzNQZ25qZFErbDBqWWkzVWZsaHlLTWRlWTBHQkFNL0xYYkFLQ2lxOUI2?=
 =?utf-8?B?emlMN3M3MVE2OXUvZ2k2Y1FGeDd3WDcvRTROVy9GbC9DcTlaNDFrWnpuK014?=
 =?utf-8?B?THVRa2I5UWh3NEUwWTUwUVZtSXFkT1c0Qy8xejI1L0UybnFjTkVoYnlDQ0Yy?=
 =?utf-8?B?eDI5YTVxZzdMSEQ2aEYraGVtTjlFajVGSkdrQXRPYU1RVE5JcjNCbXQ2VmZu?=
 =?utf-8?B?MDUyYXRVQ21JUWxOT0s1dk16dXZQVCtJd3NndktnTDZaQlhSVmZhOTBMUjBv?=
 =?utf-8?B?WTVGU1p1UDJ5cW1HNFNwbXFVM3p2VUdNdk5uTTEzMHFSUTE5Q1JaZFRrNkhp?=
 =?utf-8?B?eU1aSjRocVllMHBBUExRZEZQbFExcURIN1d0VjFEemdjYWREM3l1QW1wYmY4?=
 =?utf-8?B?R2tzYzZocU9KVUE0T2owOWZXdmFSTjJUaUxEZ3dQMjhBUjFVM0YrQTZHR21R?=
 =?utf-8?B?alB4ZTJUU213QWVOcGRtV0ZUYWI2a042K2NMTFdmMExjWWhzNE5qMVUweldi?=
 =?utf-8?B?M0NNNXlzVW8yOFNVWE9ZTEpRS1FnYkh6SkpNSmsrRXNKTzBRdnRnenNNWHFN?=
 =?utf-8?B?M1dYTkRxK3JxY3BrS3BSNThpMGtteFpRS1l2c0pIbzI1UU12djhkaFYyYkpC?=
 =?utf-8?B?ekNyK1oxOXNxNEd0OVR5b3lXOHQ5OUVxZ0FmYUJxZ3YwcnBtNC8xcTdDMTVN?=
 =?utf-8?B?OGxwQldNa2pDUC9QUGhlOGRKMGRVenBqRDAwbW1vZVZSUGFmcHFMQjBUb085?=
 =?utf-8?B?UHFWWldEWC9uc0FKc0xlNTRxQUtJbzkzV3RPK1ppOTlLbG1yb0VmWHVrL0tE?=
 =?utf-8?B?QUx1ZUttTjhYK0QweUFHRVk2QVNuSUJDUmFqWTU4RlBVNjA2MTl2Tmh1Y0Jt?=
 =?utf-8?B?RmdBUHdMU1h1N3Y5N2VRa3I0UUZJd1pNWllmZ2I1bWRYME1LT2Q5aytuQVhU?=
 =?utf-8?B?T0J0YkdzVnNJYjI5NzU5TVYwUWhEZDdweExuSHhxYnR5eDErQnhkazVNVnZy?=
 =?utf-8?B?K2tJQlhjOVQ0dk16RjUzMTRVaTNkc3VtNHlIdWxnRnpTYmhGRnQ5bGw0Sklu?=
 =?utf-8?B?djlKWDNrRG1CR2cvL1pLNXN5QW5NQmxJU2pNOG5sQWNWQ1pTbkpjckplMmtt?=
 =?utf-8?B?Njd6S2o0WWxXbW1QK0k1RE9URGpkSEtWcmFjTExjZFJLRmNhK1U3bUloZmx1?=
 =?utf-8?B?dGxOUjVrMUcwZUtJOXB5N1FGdTV6bHZyYWN2amhQSUF3S3RGei9saXhqSmJ3?=
 =?utf-8?B?b0pReUowWWVpc1NZbXQ0eHlGQk52RklTSURsSDloT3E3dmxQYncrRmd1R0VE?=
 =?utf-8?Q?xUhgM681Ikr5jo+4JsoQCbc0rmsg7eXs5m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <12CA0314F527694FA9FAD4BE46603720@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6725.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516bd751-29d3-4fde-61a5-08d8b42fa380
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 23:46:37.1024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 11OV34YXFoPs0BQxhFC3Krg/lXjoVWGysQOt78d1FQENutpQC1Sck00hdy1shgdOrSuUd45WBoooSJ40TyHmIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6630
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIxLTAxLTA3IGF0IDExOjM0ICswMDAwLCBkYWlyZS5tY25hbWFyYUBtaWNyb2No
aXAuY29tIHdyb3RlOg0KPiBGcm9tOiBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWlj
cm9jaGlwLmNvbT4NCj4gDQo+IFRoaXMgcGF0Y2hzZXQgYWRkcyBzdXBwb3J0IGZvciB0aGUgTWlj
cm9jaGlwIFBvbGFyRmlyZSBjbGtjZmcNCj4gaGFyZHdhcmUgYmxvY2suDQo+IA0KPiBNYWpvciBj
aGFuZ2VzIHNpbmNlIHYxOg0KPiDCoCogRGVwZW5kZW5jeSBvbiBTT0NfTUlDUk9DSElQX1BPTEFS
RklSRQ0KDQpEb2VzIHRoZSBzZGNhcmQgd29yayBmb3Igd2l0aCBsYXRlc3Qga2VybmVsID8NCg0K
SSBnZXQgZm9sbG93aW5nIGVycm9yIHdoaWxlIGRldGVjdGluZyB0aGUgc2RjYXJkDQoNClsgICAg
MS4wNjM4OTddIE5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMTANClsgICAgMS4wNzEw
NDJdIFNlZ21lbnQgUm91dGluZyB3aXRoIElQdjYNClsgICAgMS4wNzUwMjNdIHNpdDogSVB2Niwg
SVB2NCBhbmQgTVBMUyBvdmVyIElQdjQgdHVubmVsaW5nIGRyaXZlcg0KWyAgICAxLjA4MjQyN10g
TkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAxNw0KWyAgICAxLjA4NTgxMl0gbW1jMDog
U0RIQ0kgY29udHJvbGxlciBvbiAyMDAwODAwMC5zZGhjIFsyMDAwODAwMC5zZGhjXQ0KdXNpbmcg
QURNQSA2NC1iaXQNClsgICAgMS4wODc1MDhdIDlwbmV0OiBJbnN0YWxsaW5nIDlQMjAwMCBzdXBw
b3J0DQpbICAgIDEuMDk5NjE0XSBLZXkgdHlwZSBkbnNfcmVzb2x2ZXIgcmVnaXN0ZXJlZA0KWyAg
ICAxLjEwNDQ2Ml0gZGVidWdfdm1fcGd0YWJsZTogW2RlYnVnX3ZtX3BndGFibGUgICAgICAgICBd
Og0KVmFsaWRhdGluZyBhcmNoaXRlY3R1cmUgcGFnZSB0YWJsZSBoZWxwZXJzDQpbICAgIDEuMTIy
NjI1XSBXYWl0aW5nIGZvciByb290IGRldmljZSAvZGV2L21tY2JsazBwMy4uLg0KWyAgIDExLjIy
OTcyNV0gbW1jMDogVGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBjbWQgaW50ZXJydXB0Lg0K
WyAgIDExLjIzNTU5Ml0gbW1jMDogc2RoY2k6ID09PT09PT09PT09PSBTREhDSSBSRUdJU1RFUiBE
VU1QDQo9PT09PT09PT09PQ0KDQpIZXJlIGlzIHNlcmllcyByZWJhc2VkIG9uIHRvcCBvZiA1LjEx
LXJjMg0KDQpodHRwczovL2dpdGh1Yi5jb20vYXRpc2hwMDQvbGludXgvdHJlZS9wb2xhcmZpcmVf
c3VwcG9ydF91cHN0cmVhbV92NA0KDQpGWUk6IEkgaGF2ZSBhZGRlZCBiZWxvdyBtYWNiIGZpeCBv
biB0b3Agb2YgbGFzdCB2ZXJzaW9uIG9mIHRoZSBzZXJpZXMNCmFsb25nIHdpdGggZmV3IG90aGVy
IG1pbm9yIGR0IGZpeHVwcy4NCg0KbmV0OiBtYWNiOiBBZGQgZGVmYWlsdCB1c3JpbyBjb25maWcg
dG8gZGVmYXVsdCBnZW0gY29uZmlnDQoNCj4gwqAqIEFsbCByZWZlcmVuY2VzIHRvIFBGU09DL3Bm
c29jIGNoYW5nZWQgdG8gTVBGUy9tcGZzDQo+IMKgKiBDbGVhbmVkIGVycm9yIGhhbmRsaW5nIGlu
IF9wcm9iZQ0KPiDCoCogUmUtb3JkZXJlZCBjb2RlIHRvIHBsYWNlIHN0cnVjdHMgZXQgYWwgYXQg
dG9wDQo+IA0KPiBEYWlyZSBNY05hbWFyYSAoMik6DQo+IMKgIGR0LWJpbmRpbmdzOiBjbGs6IG1p
Y3JvY2hpcDogQWRkIE1pY3JvY2hpcCBQb2xhckZpcmUgaG9zdCBiaW5kaW5nDQo+IMKgIGNsazog
bWljcm9jaGlwOiBBZGQgZHJpdmVyIGZvciBNaWNyb2NoaXAgUG9sYXJGaXJlIFNvQw0KPiANCj4g
wqAuLi4vYmluZGluZ3MvY2xvY2svbWljcm9jaGlwLG1wZnMueWFtbMKgwqDCoMKgwqDCoMKgIHzC
oCA3MyArKysNCj4gwqBkcml2ZXJzL2Nsay9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAxICsNCj4gwqBkcml2ZXJzL2Nsay9N
YWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDIgKy0NCj4gwqBkcml2ZXJzL2Nsay9taWNyb2NoaXAvS2NvbmZpZ8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDcgKw0KPiDCoGRyaXZlcnMvY2xrL21pY3JvY2hp
cC9NYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA2ICstDQo+IMKg
ZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8IDQ0Mw0KPiArKysrKysrKysrKysrKysrKysNCj4gwqAuLi4vZHQtYmluZGluZ3MvY2xvY2sv
bWljcm9jaGlwLG1wZnMtY2xvY2suaMKgIHzCoCA0NSArKw0KPiDCoDcgZmlsZXMgY2hhbmdlZCwg
NTc0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0
DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jbG9jay9taWNyb2NoaXAsbXBm
cy55YW1sDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL21pY3JvY2hpcC9LY29u
ZmlnDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY2xrL21pY3JvY2hpcC9jbGstbXBm
cy5jDQo+IMKgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svbWlj
cm9jaGlwLG1wZnMtY2xvY2suaA0KPiANCj4gDQo+IGJhc2UtY29tbWl0OiBmODA0YjMxNTk0ODJl
ZWRiYjQyNTBiMWU5MjQ4YzMwOGZiNjNiODA1DQo+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogOTYx
ZDhlODhhODk3OWFkZDFkNTYzYjlmODQxYTQyNmYwY2EwMDYxZA0KPiBwcmVyZXF1aXNpdGUtcGF0
Y2gtaWQ6IDI3ZTAzNzkyYTVhYzc0MTI3YzY2ZWNiYTQ3YmQ3ZDViMTQ3MWRmZWYNCj4gcHJlcmVx
dWlzaXRlLXBhdGNoLWlkOiA4YzljNGY1NjUxOTcxOTBmNGUyZWQ1MmMzZDgzNDE4MTMzZWY1YTUx
DQo+IHByZXJlcXVpc2l0ZS1wYXRjaC1pZDogYmQ3M2ZiMDVjZTNkNmNlMTIyNmE5NWExZWU0ZmYy
ZTgwODhhMGQ0YQ0KPiBwcmVyZXF1aXNpdGUtcGF0Y2gtaWQ6IGQzM2YyZjFmZjU3MDc2ZDc4NDVh
ZjI3MjQyZDNiODZkNWE5ZTgwNTkNCg0KLS0gDQpSZWdhcmRzLA0KQXRpc2gNCg==
