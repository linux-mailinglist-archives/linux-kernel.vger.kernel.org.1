Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E47C2FD5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391607AbhATQkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:40:01 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:16780 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbhATQ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611159987; x=1642695987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xBnY/c3jGKLW6jpsVjjIeiFFNhFXsL7cDmopym/oz18=;
  b=LDQpksLDS6qajfirXGSZLB6oHUGPCxygOBvedW0jOOz+W5bcPbMNuUJ7
   QuSJuXYdHss4ztauMqVhBG/SrKzIYtPDjqElJekDQTvGd88+05FiFwgny
   LBb6RNyYNpCC8NWEwt2MrAzPtQcD65FtkeTDSEf30UAFtjU5M32aY8wqc
   ScAcA1KIRrcXI8ARD/URPZu1rFJkCA7hshjGdS63eMGHlU5IxpL5k1lC8
   ADWcVcfYEhpQgxhiRVzSnai1QBdXTt6+ob5AXwX/m7lKWVlyO8ESSf/L3
   e/ZkzLRhbiW2rT5AbjPrWtkTIAUK2O392J5tAGmA4mOLVfhoARZBsQJBh
   g==;
IronPort-SDR: 7Dj8la/wk3bPTfI5PjY8cAAqq+RKgh6GqUR8B6saXZzpCp27exzvK40UvJu+XVOhYVgcisiDrP
 38N0ZiJ2+7hBzBDOohwNdA08gN+fgeggT71IU0UhZBbH8LuLHvpqC2k0TBRW/qybQCE/1/ZK2c
 cHA9TnD78TYop5Di+5+N9L33WBSJvPKi3aJvVajo4Rco09rB7+hjRoXUzsY0aN3vM3WeQidEoA
 Kutn0j76rU9fvdVwRkLudE7NjLVC7C4fliJsOrKf7oHV/H2EvJ6w/Eckoizp6MX5h66AnV7Jkc
 6FA=
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="103581636"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 09:25:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 09:25:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 20 Jan 2021 09:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9wdYGIZZTDKVeLwHzSBmg4v62PExqCtnRtZRIhUOP046k2ptjE1lIzM7H5AW81y4swgdUwrwfEnlPQGgZOluSZ+voveSivF6wyd50z8vj/1K8FrxphODgaCjHVfVXp7T3twiuypiLn1wv0WkVWFgKIRmSE7hofi02ypmAhF7I10ZRRtO20WTAmlh4+4mmaFpRBBcM5eORoLPt4i2y6Cp/Mo5CoRqFlx5iJ8rT/hv7wiBAVSXLNEw7du+ZUM/cdU3L7c0VrhkmwDv2ZfEfipK+yfLVyVK45cLT/YUDcuv6h0AlMIfplk8gmvG/shKDgZqiid73pZY99IiGFJ4Jh1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBnY/c3jGKLW6jpsVjjIeiFFNhFXsL7cDmopym/oz18=;
 b=e4dgkUeTQNlS6aezTUAq9iQ43MDIqNotr09uz5FzwfcgH76ErvvSQSGfhFilZTHwcIjxWHRp4HAULATu/btpmI1sywRip5DcRNX1QZFtxrJzuc5s2YiP8IOHMhay/qpFc5oYiZrQZTTly/mLYGLNoP3v+VnSExwiC6i/ki8Pfwd/OGLsdm1knSHFcBRW52+z0mxtN4NIbS08tSNYBQmJ4PPKq9ADvp3I6a1q9yRO3mu81i0PxegxjkD8AxIHNpOKOL47P0lrhhirrqQ931D+XsVa0s4aLqAww4pr7dNMeK3cOu/EjJN21cVtoYtRcgyh8VyFUM6GL4MFwiMm8+EGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBnY/c3jGKLW6jpsVjjIeiFFNhFXsL7cDmopym/oz18=;
 b=LRtc7MGD0ydjIrKglqc7gIH+97DguFBblx/G4hLSF4CHu0ShH0PoXP+YOWmQP2YFSevZ+SQNqiUvMavW3yPW+RerLdpP5DlPDwDO6gGYc0vY+YMZLVmM1cRBLk/Z7EBcYNWVXOH8hsZC+wtqf6RLyK47aohlCap9t2lwuK9FFts=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by SA2PR11MB5020.namprd11.prod.outlook.com (2603:10b6:806:11f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 16:25:00 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::f4e3:108c:4222:7dab%3]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 16:25:00 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <vigneshr@ti.com>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>
Subject: Re: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock
 on sst26vf
Thread-Topic: [PATCH v2 2/2] mtd: spi-nor: sst: Add support for Global Unlock
 on sst26vf
Thread-Index: AQHW7zvWbgOMYI+QzkWXPBRNkt6zcg==
Date:   Wed, 20 Jan 2021 16:25:00 +0000
Message-ID: <6c4adaa7-9397-2373-16aa-a3dd2775c63f@microchip.com>
References: <20210120131914.277363-1-tudor.ambarus@microchip.com>
 <20210120131914.277363-2-tudor.ambarus@microchip.com>
 <b3a61abec8927c7229c27415d2c769a8@walle.cc>
 <ad0cc416-73b7-f626-115f-d192fac17957@microchip.com>
 <447aca9c61a45b05f7869b9747e2c301@walle.cc>
 <8a0e7885-4b9e-be62-eb46-1af74c65afa8@microchip.com>
 <e1e5f647fd9e91538fd730c626beff52@walle.cc>
In-Reply-To: <e1e5f647fd9e91538fd730c626beff52@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [5.13.1.111]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b046c3b-d397-4398-d29a-08d8bd5fef22
x-ms-traffictypediagnostic: SA2PR11MB5020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5020EF8B8A9E4209131FB898F0A20@SA2PR11MB5020.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 32qvmNi+3ddP1GJ98SPVSqRWfzgYYGyIfAKYJvJa1rs1x7O5YKcgLTkeuG94cb/AFadD1a4TjZDBXvZDtJhoXZFI9c2VjpJft/eGNuo9E8jHrGDdfz1HkkNuEBCL83/ghIrNEeO32cQFxHEc2dLdJ1Rz72f6eAIrtPMMvPIrOjohfTEfPMT+d38GdSmC6e6Gi+U5rRRS0Mkpz/cbmrM60kCbaxnE85LGA3GWVGyeARiBGdc91fPUadlS9mhLpBlY6uq4g1mKJ+uDZbV/8Vms6Mrqfr445pnCaWivoC8mm4BRw++sIKpV2o8611jGL9oNT8gaqQKfXqUEGc8QJCIK2B/51t8xWQI5dt87SG1zCmUC6Cycwl4fEgdy8m+N9/AFCHyqX7zy+pX5EEd+QatiHWnxoneSZx+p1ZNqcnlmciwcHZFvX+YXFFg5cAvK7BxaOte2lCtBnIaKdFtlB1AQTDMcfIUIc1jL3OmbFTWqJAxa8t1suMxmanuY/VnHfxsSbBvyYneUTPB03zUo5CMqGp26MjAIjM05Nh9wx42dmMMzjkqE0U4QePRtEhaula1Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(136003)(346002)(366004)(53546011)(2616005)(83380400001)(91956017)(5660300002)(26005)(966005)(8676002)(6916009)(54906003)(86362001)(4326008)(76116006)(36756003)(6506007)(6486002)(6512007)(316002)(186003)(8936002)(107886003)(31696002)(66476007)(2906002)(66946007)(66556008)(478600001)(66446008)(64756008)(31686004)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?cXIzZWlIQXdDZUF0TW5QWmtlUEpEdmVmbUpNeS9kZVQ3UXlnY1BJVWYvSHlo?=
 =?utf-8?B?RjZWY2FydjZIOFI1SDh6dEQ1TWx4SHZ5NVBhRDc2M0U1b3VBbXpzME5lbXVp?=
 =?utf-8?B?ditMdmZ4dmgxcU4rWVVvUHA4dFMybmM3Y1RCUUdnVzNuMlJsaU5RTUI2enA1?=
 =?utf-8?B?QmN2MmF3emM2aGZOa3dhTDVUQnp0WmloeUdWYTc1V0U5cFFtd1FLTEovQ01D?=
 =?utf-8?B?Ym5XM0tETDc2eUxFZ254WXE2MWJqbHZaTWoxUkpCNm1OSWxZQmt2cDVTYU0v?=
 =?utf-8?B?SGduN0FLQUJEamsrYmtQRWUxcmQ3aTFvZ29UMjlMVlZFMVp6RlVkWVNNMzZD?=
 =?utf-8?B?UUdXQm16VjR6bWxodCtyTnc0ZHpvV3N4TStqanRKRk1iQWtOMG9mbkhVN3JG?=
 =?utf-8?B?MUtaUS9TcjFuOFJqcStQRGs2KzVWc2pJaDE2MGNoa1JCY1FRRjdWbUUrY0dh?=
 =?utf-8?B?dWM3VWdSMlNvUStoV2krMFRkbEIxendaUEF0MmZ1UWprN2lWay9rSE9oY2w4?=
 =?utf-8?B?YXlYS2E0cEtVelZ0WFZyN1M0Zm9pYkk1QTVha0RNNHhkVEVMWlNRRGF0V3NG?=
 =?utf-8?B?bXVWUTFHUGtQMHEySURkSkpFbVJ1Q0JDSExFSnVOTURqd3VGOE9rWEZBZGEz?=
 =?utf-8?B?SzFzdzIvdGRBM1B3OFNxMU91R0NsOTNMQkNhTGxqcXJIZlBHME44bHRocUQ4?=
 =?utf-8?B?Qm16L2pEVjR6cXhsS2poSUs4SmgrZkt4dkU4WDFpeVdFMlFQVmYzeDNIUTFp?=
 =?utf-8?B?bCsreUVMWTdFd2l2RnVGdjJsMnp4V2pwL1FhZDRlQlplSWZJM3ZwT1JaQXJ6?=
 =?utf-8?B?NnQ1dWhKMkdDUExsU3laSmdmUHdySXlZOG12Tm93UGpGd0xPRStSa2hqbGZ0?=
 =?utf-8?B?dEdOa0tXeDUrWG5FQzJ4aURuZ2xIR2VIM2FjeDRzaTRZV21HU0NMVzBHc0tV?=
 =?utf-8?B?OHpHbVl0R1lzL1plRGNDYk5ERGJ1Mk5CbkEycU1ya3plbW9xV21GVlVXTVZn?=
 =?utf-8?B?Nk0yRVY1c01XemZyMFZ6VVo2LzZZdnVvYURUbWhRUE0zVkRWandaZnFOUnRz?=
 =?utf-8?B?Vzc3UXBnUlZoVDVZb2NqdzNIMjJHNjhLZXJsc2V5K1NHT1V3L2JTc2dWNXMy?=
 =?utf-8?B?ZTNLS1ZiUTZGTU5XUnRiVXI5YmZpZXh2MVh2MFl6Z3dqd05URE1lRW8rT3dE?=
 =?utf-8?B?MmhLbWtRd3l0d0VBSUZzK2lXbVlMdHl3MXowcmZXMHZiRW4yaWRHWjNWNEFR?=
 =?utf-8?B?WlMrVEwwWDVMWGxEQS9iWVVGT2k5bHZTWWtENm5YRWIyM1o0S3RodG5nM3VM?=
 =?utf-8?B?K0NYcHF0TFE4RTFiOUM2U2FqL2RoVmJPQ3RUM25nWkJhbkNkWW1LNmNVdzhl?=
 =?utf-8?Q?vysniNtQTGO4Y9541z6VQZCLncMcQb08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <72FFDC9208146E4C8BACA1F592480C87@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b046c3b-d397-4398-d29a-08d8bd5fef22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 16:25:00.3847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/+/4uhl6VblkMnrLrGz4LXoZ6Wm/agmvr4VjtCBBvJUc65fiK1SCj3IOEQjD/bOjn/A0lxkobkddoMfuR7rnBj5sxIeVMPMkiagQDVoylQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMS8yMC8yMSA1OjQ5IFBNLCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEFtIDIwMjEtMDEtMjAgMTY6MzksIHNjaHJpZWIg
VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tOg0KPj4gT24gMS8yMC8yMSA1OjAyIFBNLCBNaWNo
YWVsIFdhbGxlIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cNCj4+PiB0aGUgY29udGVudCBpcyBz
YWZlDQo+Pj4NCj4+PiBBbSAyMDIxLTAxLTIwIDE1OjUyLCBzY2hyaWViIFR1ZG9yLkFtYmFydXNA
bWljcm9jaGlwLmNvbToNCj4+Pj4gT24gMS8yMC8yMSA0OjA1IFBNLCBNaWNoYWVsIFdhbGxlIHdy
b3RlOg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3NzdC5jIGIvZHJp
dmVycy9tdGQvc3BpLW5vci9zc3QuYw0KPj4+Pj4+IGluZGV4IDAwZTQ4ZGEwNzQ0YS4uZDZlMTM5
NmFiYjk2IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivc3N0LmMNCj4+
Pj4+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL3NzdC5jDQo+Pj4+Pj4gQEAgLTgsNiArOCwz
OSBAQA0KPj4+Pj4+DQo+Pj4+Pj4gwqAjaW5jbHVkZSAiY29yZS5oIg0KPj4+Pj4+DQo+Pj4+Pj4g
K3N0YXRpYyBpbnQgc3N0MjZ2Zl9sb2NrKHN0cnVjdCBzcGlfbm9yICpub3IsIGxvZmZfdCBvZnMs
IHVpbnQ2NF90DQo+Pj4+Pj4gbGVuKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gK8KgwqDCoMKgIHJldHVy
biAtRU9QTk9UU1VQUDsNCj4+Pj4+PiArfQ0KPj4+Pj4+ICsNCj4+Pj4+PiArc3RhdGljIGludCBz
c3QyNnZmX3VubG9jayhzdHJ1Y3Qgc3BpX25vciAqbm9yLCBsb2ZmX3Qgb2ZzLA0KPj4+Pj4+IHVp
bnQ2NF90DQo+Pj4+Pj4gbGVuKQ0KPj4+Pj4+ICt7DQo+Pj4+Pj4gK8KgwqDCoMKgIGlmIChvZnMg
PT0gMCAmJiBsZW4gPT0gbm9yLT5wYXJhbXMtPnNpemUpDQo+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gc3BpX25vcl9nbG9iYWxfYmxvY2tfdW5sb2NrKG5vcik7DQo+Pj4+
Pg0KPj4+Pj4NCj4+Pj4+IFNvbWUgYmxvY2tzIG1pZ2h0IG5vdCBiZSB1bmxvY2tlZCBiZWNhdXNl
IHRoZXkgYXJlIHBlcm1hbmVudGx5DQo+Pj4+PiBsb2NrZWQuIERvZXMgaXQgbWFrZSBzZW5zZSB0
byByZWFkIEJQTlYgb2YgdGhlIGNvbnRyb2wgcmVnaXN0ZXINCj4+Pj4+IGFuZCBhZGQgYSBkZWJ1
ZyBtZXNzYWdlIGhlcmU/DQo+Pj4+DQo+Pj4+IEl0IHdvdWxkLCB5ZXMuIElmIGFueSBibG9jayBp
cyBwZXJtYW5lbnRseSBsb2NrZWQgaW4gdGhlIHVubG9ja19hbGwNCj4+Pj4gY2FzZSwNCj4+Pj4g
SSdsbCBqdXN0IHByaW50IGEgZGJnIG1lc3NhZ2UgYW5kIHJldHVybiAtRUlOVkFMLiBTb3VuZHMg
Z29vZD8NCj4+Pg0KPj4+IHNwaV9ub3Jfc3JfdW5sb2NrKCksIGF0bWVsX2F0MjVmc191bmxvY2so
KSBhbmQNCj4+PiBhdG1lbF9nbG9iYWxfdW5wcm90ZWN0KCkNCj4+PiB3aWxsIHJldHVybiAtRUlP
IGluIGNhc2UgdGhlIFNSIHdhc24ndCB3cml0YWJsZS4NCj4+DQo+PiBZb3UgbWVhbiBpbiB0aGUg
c3BpX25vcl93cml0ZV9zcl9hbmRfY2hlY2soKSBjYWxscy4gLUVJTyBpcyBmaW5lDQo+PiB0aGVy
ZSBpZiB3aGF0IHdlIHdyb3RlIGlzIGRpZmZlcmVudCB0aGFuIHdoYXQgd2UgcmVhZCBiYWNrLCBp
dCB3b3VsZA0KPj4gaW5kaWNhdGUgYW4gSU8gZXJyb3IuDQo+Pg0KPj4gR0JVTEsgY29tbWFuZCBj
bGVhcnMgYWxsIHRoZSB3cml0ZS1wcm90ZWN0aW9uIGJpdHMgaW4gdGhlIEJsb2NrDQo+PiBQcm90
ZWN0aW9uIHJlZ2lzdGVyLCBleGNlcHQgZm9yIHRob3NlIGJpdHMgdGhhdCBoYXZlIGJlZW4gcGVy
bWFuZW50bHkNCj4+IGxvY2tlZCBkb3duLiBTbyBldmVuIGlmIHdlIGhhdmUgZmV3IGJsb2NrcyBw
ZXJtYW5lbnRseSBsb2NrZWQsIGkuZS4NCj4+IENSLkJQTlYgPT0gMSwgdGhlIEdCVUxLIGNhbiBj
bGVhciB0aGUgcHJvdGVjdGlvbiBmb3IgdGhlIHJlbWFpbmluZw0KPj4gYmxvY2tzLiBTbyBub3Qg
cmVhbGx5IGFuIElPIGVycm9yLCBidXQgcmF0aGVyIGFuIC1FSU5WQUwsIGJlY2F1c2UNCj4+IHRo
ZSB1c2VyIGFza3MgdG8gdW5sb2NrIG1vcmUgdGhhbiB3ZSBjYW4uDQo+IA0KPiBEb2Vzbid0IEVJ
TlZBTCBpbmRpY2F0ZSB3cm9uZyBwYXJhbWV0ZXJzLCBidXQgZG9lcyBub3RoaW5nPyBJbiB0aGlz
DQo+IGNhc2UsIHVubG9jayB3b3VsZCBiZSBwYXJ0aWFsbHkgc3VjY2Vzc2Z1bC4NCj4gDQp5ZXMs
IHRoYXQncyB3aGF0IEkgc2FpZCBJJ2xsIGRvOiAiSWYgYW55IGJsb2NrIGlzIHBlcm1hbmVudGx5
IGxvY2tlZA0KaW4gdGhlIHVubG9ja19hbGwgY2FzZSwgSSdsbCBqdXN0IHByaW50IGEgZGJnIG1l
c3NhZ2UgYW5kIHJldHVybiAtRUlOVkFMIiwNCndpdGhvdXQgc2VuZGluZyBhIEdCVUxLIGNtZC4g
Q2FsbGVyIHdyb25nbHkgYXNrcyB0byB1bmxvY2sgYWxsLCB3aGVuIHdlDQpjYW4ganVzdCB1bmxv
Y2sgcGFydGlhbCBtZW1vcnkuIA0KDQpJdCdzIHNpbWlsYXIgdG8gd2hhdCBpcyBhdDoNCmh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L210ZC9saW51eC5naXQv
dHJlZS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYz9oPXNwaS1ub3IvbmV4dCNuMTk0Ng0KDQo+
IEluIGFueSBjYXNlLCBteSBwb2ludCB3YXMgdGhhdCBkZXBlbmRpbmcgb24gdGhlIHVuZGVybHlp
bmcgbG9ja2luZw0KPiBvcHMsIGVpdGhlciAtRUlPIG9yIC1FSU5WQUwgaXMgcmV0dXJuZWQgaWYg
c3BpX25vcl91bmxvY2soKSBmYWlscw0KPiBmb3IgdGhlIHNhbWUgcmVhc29uLCB0aGF0IGlzIHVu
bG9jaygpIHdhc24ndCBwb3NzaWJsZSBiZWNhdXNlIG9mDQo+IHNvbWUgc29ydCBvZiBoYXJkd2Fy
ZSB3cml0ZSBwcm90ZWN0aW9uLiBBbmQgSU1ITyBpdCBzaG91bGQgcmV0dXJuDQo+IHRoZSBzYW1l
IGVycm5vICh3aGF0ZXZlciB0aGUgY29ycmVjdCBlcnJubyBpcyBpbiB0aGlzIGNhc2UpLg0KPiAN
Cg0KQnV0IHRoZSByZWFzb25zIGFyZSBkaWZmZXJlbnQ6IDEvY2FsbGVyIHdyb25nbHkgYXNrcyB0
byB1bmxvY2sNCm1vcmUgdGhhbiB3ZSBjYW4sIHRodXMgLUVJTlZBTCAyLyAtRUlPIHdoZW4gd2Ug
ZG9uJ3QgcmVhZCB3aGF0DQp3ZSBleHBlY3QgdG8gcmVhZC4NCg0KQ2hlZXJzLA0KdGENCg0K
