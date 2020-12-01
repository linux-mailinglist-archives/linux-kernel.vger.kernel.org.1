Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454212CA8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404041AbgLAQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:52:47 -0500
Received: from mail-db8eur05on2061.outbound.protection.outlook.com ([40.107.20.61]:57967
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387795AbgLAQwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:52:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noml8yJsUgQa4MVDmeCgsmYutTV9eWSfGLsMWgY4H4nUG1UpEsDeABp7QQi0t1XbBj6S1JQf7WbLdERrhdx7dFDNPmuo4Pnqjdjgae5x4CawGu6V0ZLKJNVw/V+MHoMsl3LpuzPuZ0WAjP/A52d+b94jCdRVhKm8Pa+3grsW1Se/AHdi4KfE5wYQmRFwkdzdEpAm6w0P0ITV0jWeCAaNLHzf5y0cYV3ctHdfUPMApqW/WmvRNWXavWxKMFZA2+IYuDX6l87CPHnXJQ4N745pcVTBDYizZFKR4KUsWdHaTQ0vvDRGjCg4+WZt55juHd9zg5YlOQOCH7BdG+uxQJZQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUBTfqcvayTrpMtuwdJTWd1jxDC19ETPJxZOmrRNH20=;
 b=f95Iv54nhNHTEViDUTuLvRCkUEayH5tDrPq5VMrE9FLitKfmKHjlSNYih3JmzSL3KrF/3TcMmKEa+d+OVPKzoXZiqEns7+rLjscdiGt6m9fN015ycmkRfR9cDyVvS5aiuUXFYx77ZQXKA+EYFH/Y9Qqme4k4OQ3ihON5AtPz/y8nJME2OE3J20BlZ7YMjUF2ZO1G6kEoFC6f5djF7tXfTwbVKb/21wc53THq5tn/34TXmsgfRcb0sZ5dXiPK5HTBjO03uD+EJaRARZUXubU07ffD8xoNtSaU7P2FPESPPfeNtawC6Q5w0xfgpR54AKHs/BTl7+s5RP0itThYLu8jGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUBTfqcvayTrpMtuwdJTWd1jxDC19ETPJxZOmrRNH20=;
 b=PWNZ/DOLJb4fVvtd2HHLPD+vmTCZ7zaVxINWYecwe671JOjIPGe6S3RBhz1pBrAmyYpziR+qHkdLqVIv/6haUMEYlWoV0WMq7muXoNpVcZYxfFWR9HaMyFQxahNt2aqlXxwEEyZ29YIFNk/yyZfjMHmcYQJiwWcNeTja0a74C/U=
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ac::5)
 by PA4PR10MB4384.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Tue, 1 Dec
 2020 16:51:43 +0000
Received: from PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67:233d:68c6:cabc]) by PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67:233d:68c6:cabc%7]) with mapi id 15.20.3611.023; Tue, 1 Dec 2020
 16:51:43 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V3 00/10] regulator: da9121: extend support to variants,
 add features
Thread-Topic: [PATCH V3 00/10] regulator: da9121: extend support to variants,
 add features
Thread-Index: AQHWxzog6Yib7XBzdU6un7pKnt6hn6niRXwAgAAvq9A=
Date:   Tue, 1 Dec 2020 16:51:43 +0000
Message-ID: <PR3PR10MB4142434AF67B4976D8095ABD80F40@PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1606755367.git.Adam.Ward.opensource@diasemi.com>
 <160683107677.35139.1688443189294014005.b4-ty@kernel.org>
In-Reply-To: <160683107677.35139.1688443189294014005.b4-ty@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.196.102]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8deea1e1-0271-47cc-8d85-08d896196230
x-ms-traffictypediagnostic: PA4PR10MB4384:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PA4PR10MB4384F07FB0A436B4F23F38ACA7F40@PA4PR10MB4384.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELHBrBRUC3u/3WGMg7rhilQJDl3MQuLYgqeJ/Cin3FTf3SbMnqhSaellQe18nDYa0/cHK6XiWoauRAvVXJwJd8hG+rtuEFGr5UryqvcVhUFMHrme9TVmcsbhkxcElChWak82ddJXE7R0nPdw5KaTjSYyTTckNO2+v80b20kaRSpfBgFk12BbUYIuVI2PKUjKUcRYni4n3KZdWmvpqLdlOykQ4eRSrR4NdN/4RPPAuReTgWStU4hoFN5aQZrdgy7DABeg+BbfH+D6ZtlCvyOm80xi/CiHtjOs165XpftHOl+61r33F/slVP6JE2vWOnpCWxXso74xrT4rnlBbhV//hcTsQnRN2LKN53cinlNomXtD0TVAIP8zzRM8lPycHYiUFuFSWhble4wOsGzS6f3ANg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(396003)(346002)(366004)(4326008)(9686003)(8936002)(110136005)(55016002)(86362001)(966005)(8676002)(316002)(66476007)(64756008)(66946007)(76116006)(33656002)(66556008)(66446008)(52536014)(54906003)(7696005)(6636002)(2906002)(478600001)(186003)(5660300002)(26005)(53546011)(55236004)(6506007)(4744005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?elpqcHNFRHBUakR6NGZDdUJjTmpxK052UkFQVjhoNXJmZ3lkZXlSVk8xNkNz?=
 =?utf-8?B?cDBIK1gyT0tDWElaMjV5WmQrZnRDR1RvdFpoYjU5RFVYRm94djNCNG1udkRP?=
 =?utf-8?B?Ti9LT2Q1SG9yLzB1ZEVWQVlpNkVCSkRRTjZiV0IzdURXTEdKWFBTa0hxazMw?=
 =?utf-8?B?empwdk5rOFR4Y250dGptU3Q3UUxYTW9ybHpHd042eFFHZjRwUzE0OHk1U3Ns?=
 =?utf-8?B?a1NZMjNNb1RGWXVpVS84bEtqSGpCVFhJaW15WmIxM0xCb0pEWkdjMFUrSHpm?=
 =?utf-8?B?a3hTak1RSWdlanp6a1NGVXZjUWJvdGlpN3lYalp2ZFdkOVh1anUwL0VCd3Ba?=
 =?utf-8?B?cWN4RGd5aVl4VnBTZ0toQVZjNUYvM2ZhVXBESjZNM1hrTTZ3Q2tQNythazhJ?=
 =?utf-8?B?dWp5eGFBNE01STViTjZKSTZjL0MvUzVJTmQ5dldCT3dMUzZlSmhTQytKWEJQ?=
 =?utf-8?B?dlRxY0w2OWhtNldQbzB5NGN3cEVYNVpsMTU0aldlRElSZmVDOW1sL1pOQmpC?=
 =?utf-8?B?aVhkS0RISy8xTisvRGpLMUg2WW1OUnloYnovNTFRTzlZalVjTU1MajRKdDhl?=
 =?utf-8?B?N3FYR2pRZG9WaUtqdTAzVzNucWlldmhKQlJ2QnBGRkszZUM5ZWMvVVBIQlVU?=
 =?utf-8?B?R3pOTk51T2FMeXpTVWNmM3hYZ0t4aUcwSlNYQnRvQ3RORUd0TElkbndaSHJD?=
 =?utf-8?B?aDRmVENjMW42cDlwVXBLaDJCbzRNSG1BNkZ3cnRPWk1waExrM2tzV0ZYbGFH?=
 =?utf-8?B?dmNlcEJaU25WN1lCeGRvTGF1QXlyL0pGcWJiTlVIUi80aVBXS0ZtMWtoZThY?=
 =?utf-8?B?QWh2czhaQmpiQkZSOTVLZGxIMGYybGxITzl0YndwMzFrUGNTdXNIZGtnTFF1?=
 =?utf-8?B?bklOV2NMRnp2NEdMN05IdHdvOWF4bkozSHM4bVd2elNIWVR6ZFY2M2k3bTVa?=
 =?utf-8?B?TUI5MHBTNS82eDJrZU4ySnlNMXRVQm12ZUpxZWg3SzJGWXNvaW5BblhrNU1J?=
 =?utf-8?B?UGJSNzk5Z1JKUlNTRU9OUXJIVU1YM2drTEtBamREcHVMWUx3YlVVaDE2L3F5?=
 =?utf-8?B?QWNNMmlaM09TQnArcWhFN28wTEJWcFdKd2xwK2hRdnNwWG1qNkJ5bHVOSjdK?=
 =?utf-8?B?NTU3OHBybWJRV21uSTlPS2dBa091eVdlQStoTWpEV2k4bVFrSXNFRVR0Y1hh?=
 =?utf-8?B?enlRYThXTkEwbEs0RlFIS0pnWVlHZmRxZW5lMm10WnhPN3BEL3F0dFN6dG9C?=
 =?utf-8?B?NjVJV0MvRFdpMlB0NEhBUGZwK1ZVT1gwdlVMR250dTArRExsdkhaQThNMTVP?=
 =?utf-8?Q?dJnb/TBRx+WPA3CzzPrE1SDxpa2DfqSG2r?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4142.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8deea1e1-0271-47cc-8d85-08d896196230
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 16:51:43.7916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YempX900f3sfs766hu0cPanYYIR9cBOAiJDbM99bNAChRn2dohXyTMKqhnbULi9+JGjv+5BOr1XZvzLSN7OepUTNYEX5NS48J2OlInhqxm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4384
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEgRGVjZW1iZXIgMjAyMCAxMzo1OCwgTWFyayBCcm93biB3cm90ZToNCg0KPiBPbiBNb24s
IDMwIE5vdiAyMDIwIDE2OjU5OjA0ICswMDAwLCBBZGFtIFdhcmQgd3JvdGU6DQo+ID4gVGhpcyBz
ZXJpZXMgZXh0ZW5kcyB0aGUgREE5MTIxIGRyaXZlciB0byBhZGQgc3VwcG9ydCBmb3IgcmVsYXRl
ZCBwcm9kdWN0czoNCj4gPg0KPiA+ICAgREE5MTMwLCAxMEEsIER1YWwtUGhhc2UgKEF1dG9tb3Rp
dmUgR3JhZGUpDQo+ID4gICBEQTkxMjIsIDVBICsgNUENCj4gPiAgIERBOTEzMSwgNUEgKyA1QSAo
QXV0b21vdGl2ZSBHcmFkZSkNCj4gPiAgIERBOTIyMCwgM0EgKyAzQQ0KPiA+ICAgREE5MTMyLCAz
QSArIDNBIChBdXRvbW90aXZlIEdyYWRlKQ0KPiA+ICAgREE5MjE3LCA2QSwgRHVhbC1QaGFzZQ0K
PiA+DQo+ID4gWy4uLl0NCj4gDQo+IEFwcGxpZWQgdG8NCj4gDQo+ICAgIGh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2Jyb29uaWUvc291bmQuZ2l0IGZvci1u
ZXh0DQo+IA0KDQpIaSBNYXJrLA0KDQpXYXMgdGhlIGludGVudGlvbiB0byBhcHBseSB0aGVzZSB0
byB0aGUgQVNvQyByZXBvLCBhcyB0aGlzIHBhdGNoIHNldCBpcyBqdXN0DQpmb3IgcmVndWxhdG9y
PyBKdXN0IHdhbnRlZCB0byBjaGVjay4NCg==
