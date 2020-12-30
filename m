Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33A22E75AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 03:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgL3Cdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 21:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgL3Cdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 21:33:43 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2942C061799;
        Tue, 29 Dec 2020 18:32:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG++uJFN+cAhQ9SASEoy8MFT78i1U+tYegz9hv56H23RJn2GjcsU9Dh3R3V6D3i+g9lcMAunWLg5q+VXpU/DTXuWAwHEDQOhGHDz12O5cF+VAbG+zvOBrx1+dkyuCJLJCDuPXJ2xeaZjdEyptScD7VGe5Mx8K4iHc8XFxFRvWp+9aSdgRjaCfLRfWrBOhS/D+lnRiojqAT+dghI5j6JtFfNJlyiD7N/J3TzXA2JE9K2/NSKZ0kn405eVDydW+KocB9cPCHo4hBvWLcuccFfRse7g2gLuEvfsaVV0u1UsUet3OVCNmF7qOsXXLhMmsQVRQgtg5RIB+O+zVceXOQIG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb/wOxRj4EMa32IQZ5dyTADSPF9WneO7pUHasKqk3tA=;
 b=Okn8zX6gl36yfoaoR8wdVDFevXH7GTr3rS9DgU8HZFygBxwPa6UzTwwmwHNgzJaSItDC0FRCeu2AIDKIKST6lvg9bzZPtDTzqvGJWMSbai/T1SKJJ+x+AuETTKNmtaseOScTu/2MUVT8QXDIki9Isb6H5Gdr0qrcyfBVvTt4+moangtv++lC1F2Tcw4oo7NQDS6OBgN9IT2tQmCIl44GG9VN5+YgNo7e97YhI9rEX+TOwTkT65CESlsxG/IzqV9Kb5ymcJlf/h8nNGJ35WEoDMLtAJO04mIuRdMx0g0lPwls2O2PqXMfHh0TLNdMKzvItA/Znd7J+yxeqFSGX2nNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb/wOxRj4EMa32IQZ5dyTADSPF9WneO7pUHasKqk3tA=;
 b=QQzBT+/wfpUoO+ouIDIi7gUM5RvZrEDYotNIBIXJk4jfSjvAT9KYxFCBlm3sBgmw1v9uBLztLOO7/KnmBnsvCrAUosS0nFQn7UnHhNYYroKwlt/d6k466hzotLm7NFkM7IoTSJvtfV8rsIqVYKucYUWsSBGQocC/53AZ2oy3PW0=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5996.eurprd04.prod.outlook.com (2603:10a6:10:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Wed, 30 Dec
 2020 02:32:41 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3700.031; Wed, 30 Dec 2020
 02:32:41 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 3/4] arm64: dts: imx8mn: add spba bus node
Thread-Topic: [PATCH 3/4] arm64: dts: imx8mn: add spba bus node
Thread-Index: AQHW3duLbYhmQ5UsDkWjPU7MeJAKE6oOPz0AgACslHA=
Date:   Wed, 30 Dec 2020 02:32:41 +0000
Message-ID: <DB6PR0402MB2760208A9F845D2E1D30B69D88D70@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1609243245-9671-1-git-send-email-peng.fan@nxp.com>
 <1609243245-9671-4-git-send-email-peng.fan@nxp.com>
 <20201229161300.GB17229@kozik-lap>
In-Reply-To: <20201229161300.GB17229@kozik-lap>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55ecab1f-4143-42ef-6bf2-08d8ac6b2e64
x-ms-traffictypediagnostic: DB7PR04MB5996:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB5996B438A4F12946FE0A7BCF88D70@DB7PR04MB5996.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kPqbljIZfUNtDOjn/YrbFIypyh5CvPociBCSoHHtaxJxJrdPNAXjuJK7bWpFZFLeLMQHUB2V/2m73M7IJ/B3xLzIViPNl/PY66JMHCNLwm+5+py3iu0QvwHVboP55PyNBrUXOiHQe39IpPhshIXOhYXgBbvFGO7eP0G3WrtVSYFGZ6nvGOyHDCOb/Ct8LnxPGO/pFnEwm13UIfqxWQuRwEL08QAHpuRS+hkUuunMQS2vyOrQGt9aySHOGXpkGYT82BF/OHABpZtRBujQa7Ld+nY4XXnlfdaK/dvEOkyyNoaApEkbqGIbWry1ITgzKwkubvFGPrJJircug8fGaYLBv56jU8ie/LAOsTdDFxELnpxrNW/sQDpDPhn9AwLH5rf18tDw8dPRNojpxK4noYdfgy78UzKhyucdUcKdW7pGoo0A4StGl27vTqBwgw8IaAb5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(39860400002)(346002)(6506007)(33656002)(71200400001)(86362001)(186003)(54906003)(26005)(316002)(7696005)(8936002)(8676002)(2906002)(44832011)(52536014)(4326008)(55016002)(478600001)(4744005)(66446008)(76116006)(66946007)(83380400001)(66556008)(64756008)(66476007)(6916009)(9686003)(5660300002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?clAzdlpDbjRFdDRaaXBobXdqa21lK0Zwb1p1aS9iQzdTeUpLbFFhV2JaQy9Z?=
 =?utf-8?B?QzF5L0RQVzRiWFR0b1RnMDB4ekxXclZoRWFrQ2wrM3BwTFBxVVE3MHBNVVRy?=
 =?utf-8?B?QzhrenJROHFjZ1hnZUJUNG0vVXNicmhZdWNob0FSU1FnSzE3SXZPTlFDMjJG?=
 =?utf-8?B?K3ZKSlllMEpENUVQQ0ZHSWdUVmlqendmT1lTdmx1eDE1M2NzOGx1cG5KWVlo?=
 =?utf-8?B?S3JsMzZlRnVVbUQ0eDh4WitMNmQvYlN2WElhNFYwMnBWZHV2NnA3clB3dVNP?=
 =?utf-8?B?S2pBcDg1TnBwbFFnRlM4SzRGTnI3QUR3bEhadVJsbHY5b2dyL2VicGxLWVRM?=
 =?utf-8?B?NDB5NFpWWCtxOTdUWVVtUEFUN3Q4a21TdGNCYjRVUGFWTS9pRTQxRno0dWl5?=
 =?utf-8?B?MEhWYmZoOGNtcC95WnR5ZFVZSGwrdGY0R0FyS3ZkMkNLdCs2RDFDN2djLzZL?=
 =?utf-8?B?V3dVek1LV294TUU5SFVySVJZNDRFS3I0OWxwdVhpNDNWR1hxRmVOU251L085?=
 =?utf-8?B?V3oyelRxM1lzbFVBUXMyYllreE80U29xOUczbFQxR2RoVWdwNWFXYjN0YVNy?=
 =?utf-8?B?R0FsL3lsYVVoZnozaXU3T1ZRd3p3bTVGNVR4cG44RXVjd1BkRGhONHhkSisv?=
 =?utf-8?B?ZG5kYlROTXlYZXkwSnM0eDdJeit3R3NIZHk0UzlZTzE5NnVJaWthRk92S3U2?=
 =?utf-8?B?RkRZV2lHUkt3TXFYQ0Q0OXZrWklxQWhEaElobGRXV2FheDBGZGlxWGo3VFA3?=
 =?utf-8?B?VDh4L2FnbnJ0NEpyaGI3UUlmUFYwMGJKZEExTzVZdFF2TzZuMFM4cTU1eVlJ?=
 =?utf-8?B?TjNVL1poWDlRUCtvR3FJUEs2OFpWN1Z1SG9LZ3IxRi9xZXhNMzJUbDR5RUhx?=
 =?utf-8?B?RFA0STZoTmNla1NMVTg0YldUMXpMNHR3Vk95ZWRoejc0Nmg3QmVPbjBvU3Zs?=
 =?utf-8?B?QXM3RE1LclkvUlJHQ2RqTENYSWQ2RUpqdzN6SmlmekdKLzRJdGlDZHdkYjhW?=
 =?utf-8?B?L2gzZGg2MUVTMWhYUUhmZmw5TXhTdjVQaURuamVPa08xajRRVktGVjkyMUly?=
 =?utf-8?B?aHMvWXVETjFDUGl6ZXYwRXFtSVZCZUwrV3hrRHc0VElhUTJyYkd1V3RoeVZk?=
 =?utf-8?B?MFFVaFcyTTVMNDhkRXRESmIxV2RQejBvRE9EM2VDcXFBOFdYOVZKUERqam9o?=
 =?utf-8?B?eDZVQkJJRG5ONmVORncrTSsrN25MMklDbzhMSkpxWXFYQ2czMkJ1MEZtUWVv?=
 =?utf-8?B?UXg4R0g2ZXBpc0UyRDRYcHRUakhIRGFzaDRjYjRLVm83VjJyNW1KUXBHTCty?=
 =?utf-8?Q?hSL9nwFT33B84=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ecab1f-4143-42ef-6bf2-08d8ac6b2e64
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2020 02:32:41.1107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpeIMBaVkwj7BsdZQnj4iJgRcH+++NtaKTqbIgbejv3MS9P4yad4wHK6DctPATMaLrjW7Ud7g6JaBkeXwtn8iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5996
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNF0gYXJtNjQ6IGR0czogaW14OG1uOiBhZGQgc3BiYSBi
dXMgbm9kZQ0KPiANCj4gT24gVHVlLCBEZWMgMjksIDIwMjAgYXQgMDg6MDA6NDRQTSArMDgwMCwg
cGVuZy5mYW5AbnhwLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5Abnhw
LmNvbT4NCj4gPg0KPiA+IEFjY29yZGluZyB0byBSTSwgdGhlcmUgaXMgYSBzcGJhIGJ1cyBpbnNp
ZGUgYWlwczMgYW5kIGFpcHMxLCBhZGQgaXQuDQo+IA0KPiBUaGlzIGRvZXMgbm90IGxvb2sgbGlr
ZSBtYXRjaGluZyBjb250ZW50cyBvZiBjb21taXQuDQoNClBvc3RlZCBpbiBhIHJ1c2guIEZvcmdv
dCB0byBzcXVhc2ggY29tbWl0cy4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gQmVzdCByZWdh
cmRzLA0KPiBLcnp5c3p0b2YNCj4gDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbi5kdHNpIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtbi5kdHNpDQo+ID4gaW5kZXggNzM2MDI4MzJjY2FhLi4wMzNmYTkwNTcw
ZmYgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1u
LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW4uZHRz
aQ0KPiA+IEBAIC03NDksNyArNzQ5LDcgQEAgdWFydDI6IHNlcmlhbEAzMDg5MDAwMCB7DQo+ID4g
IAkJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQo+ID4gIAkJCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCj4gPiAgCQkJCX07DQo+ID4gLQkJCX0NCj4gPiArCQkJfTsNCj4gPg0KPiA+ICAJ
CQljcnlwdG86IGNyeXB0b0AzMDkwMDAwMCB7DQo+ID4gIAkJCQljb21wYXRpYmxlID0gImZzbCxz
ZWMtdjQuMCI7DQo+ID4gLS0NCj4gPiAyLjI4LjANCj4gPg0K
