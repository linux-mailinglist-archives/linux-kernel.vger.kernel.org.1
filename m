Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1281302230
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbhAYGkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:40:37 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:43565
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727115AbhAYGht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XavW2G/9ZXRAnUS70KCdIBE75n6m9UxMrdDTwMn8+s=;
 b=aRyimTIbpqhxMdwjBr9TzHap9rvM/DVRF0sZujJE9FTfG0f3q1dl1ov+YrPkoV8szArgicFMW8n6Mx2I0crqOQojj2dr76QSAlYHTKpsi/eXz+i3KfUYLRi7LLz2pTQ7Htf63BHnVeyVWjCXbQ0zwh7N3skaNkRpa0uKsot42Sw=
Received: from DB7PR03CA0107.eurprd03.prod.outlook.com (2603:10a6:10:72::48)
 by DB6PR0801MB1734.eurprd08.prod.outlook.com (2603:10a6:4:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.16; Mon, 25 Jan
 2021 06:36:58 +0000
Received: from DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:72:cafe::e9) by DB7PR03CA0107.outlook.office365.com
 (2603:10a6:10:72::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Mon, 25 Jan 2021 06:36:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT028.mail.protection.outlook.com (10.152.20.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 06:36:58 +0000
Received: ("Tessian outbound 4d8113405d55:v71"); Mon, 25 Jan 2021 06:36:57 +0000
X-CR-MTA-TID: 64aa7808
Received: from c10a25dd982c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 1C03B38E-5423-4683-A248-01CB940707DE.1;
        Mon, 25 Jan 2021 06:36:52 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c10a25dd982c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 25 Jan 2021 06:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWL5pQMMDQtj60xRtYtUY2+v/y86T7fsqJqqWWarG5QeXF9ui71Sm8cfL9d7KG94frj8C7RfRifsxX95G1svCttpgjtf3t+Lp5fc+DAd3D+rC92k/UrF1yuQcyWPcsEC3cEkxmRNA/V6JjGU/e1gjrNfxH5GVEMDXC3GK3C4WInFPiqi9ndSlY0P1P/kFx6vUiWUMDc9tp2b/63UNzIfOghIPGPb2Rr9HVaVkGTfFF+DZzoFzzNUiQDYSOrh97qYUdb+Y4zUdCTgtyeA+Yqyx6LLFyyvPySWnAXpbjwSiOd81okNKyZ9FUDrD6XllNdnnNZvy7Y4vITaLD6x+4MN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XavW2G/9ZXRAnUS70KCdIBE75n6m9UxMrdDTwMn8+s=;
 b=gG95D4gnVsWRWJvMnEdsCEspnNeMBoB962e9IrL+RmFbBEL4h8ZsAY1+Rn1TLcFwnFVZbSDnkRTTYIG9sEHH6pVfudLugtiThgeJYFZcaHejyquLwNhVJ9NCDp+FkM377C2rch8ND+3ub+MK3CD3iS4cGysN60fZ1Op/oYOZxzUP5UpgZXWgJ+eCry+6QtN2lSUL5MNpRikqp/IyZW2+v8XCVBmGpmavI6jwSlGxSpGojX9gEYUQbeQUppAhSZCAEa+wOqcFEzlQbVblfq6Rb7Myy6Po+hVfRWNx8cpyUgkQ3G857jlDIPXiZO0Wb6B4zVx6II7qOAhMg6BUizq9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XavW2G/9ZXRAnUS70KCdIBE75n6m9UxMrdDTwMn8+s=;
 b=aRyimTIbpqhxMdwjBr9TzHap9rvM/DVRF0sZujJE9FTfG0f3q1dl1ov+YrPkoV8szArgicFMW8n6Mx2I0crqOQojj2dr76QSAlYHTKpsi/eXz+i3KfUYLRi7LLz2pTQ7Htf63BHnVeyVWjCXbQ0zwh7N3skaNkRpa0uKsot42Sw=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM5PR0802MB2578.eurprd08.prod.outlook.com (2603:10a6:203:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 06:36:51 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::912:f387:b95f:fea8]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::912:f387:b95f:fea8%7]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 06:36:51 +0000
From:   Justin He <Justin.He@arm.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Cristian Marussi <Cristian.Marussi@arm.com>
Subject: RE: [RFC PATCH 0/2] Avoid booting stall caused by
 idmap_kpti_install_ng_mappings
Thread-Topic: [RFC PATCH 0/2] Avoid booting stall caused by
 idmap_kpti_install_ng_mappings
Thread-Index: Adbu5+JvnpOuAYGvSAeGYH7FUfQeewAM0ikAAAnHHlAA6E5JkA==
Date:   Mon, 25 Jan 2021 06:36:51 +0000
Message-ID: <AM6PR08MB4376549A9337A835B68F696DF7BD0@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <AM6PR08MB43763910418580E3A470BF27F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <e8a45079ae30232eaa889f026439da9e@kernel.org>
 <AM6PR08MB43767517972A292A9AA15586F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB43767517972A292A9AA15586F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: C4E3B3F0841A0B48A00546C1EF51F940.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.111]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: edaf2e52-a4bb-417c-f5d4-08d8c0fb9d45
x-ms-traffictypediagnostic: AM5PR0802MB2578:|DB6PR0801MB1734:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1734C388A58EF76F08C981DBF7BD0@DB6PR0801MB1734.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:5797;OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ByLo1zHG4dqcWOCvXVlqQyUHTOje8mtb6SV8W1Yg+CpcinDgCGcOJHVSZca6HzPHSM7cOm3wbIiVCtiqfI0mO90mc6djUzAF3J5542DQlgMI10qKPH1gP0J1NhZk4Gi7Gn9KE1xaoEcAjVH6/RqKi74VW/rgzaRLhjJzrSbPTbX4Xvo/2BRgHmMI3UkYmXlole2ZYbupB5GlH5ltvJSgSoDURSe1eOEyesygje+xbV2S74P+gksRYtJGbbaK1YkQKh3GK89ffVmi04NypxDuWhP/Fwdcn0quFcZrWqsf3KOwEWVXbr2fHganY7CpNmDSTlpXmeMbOsggWvlntvLrPT0Wmi2ilPr2Ax4f5lLFk4VYldFLtSw7SEzqHNkRF3tkRBtNDx2wpRrMqnUY/LUtgQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(6916009)(64756008)(86362001)(4326008)(6506007)(2906002)(9686003)(478600001)(8676002)(186003)(26005)(53546011)(66446008)(5660300002)(7696005)(54906003)(83380400001)(52536014)(33656002)(66556008)(66476007)(7416002)(76116006)(66946007)(316002)(8936002)(55016002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aWVNVzZNY1NoNlJCSGx6MUFSTW1vUFByY25lMTBZNTJxUEFIZ0pTRkNtLzJX?=
 =?utf-8?B?WitmUVZHaUhtSko1UnNnZnBnZ2xKN1cwbERKSzMvb1k0aDZCVjRKeGJTdjNK?=
 =?utf-8?B?QlcyQ1hWU01RU1EyUVVLRHVWT1Njb1N2OGpIY1Qrb1UxaUtTd3BsT01hdWhS?=
 =?utf-8?B?cGNCSURqSlBKcG0vY0llMVYvMjlqamRqSzVJWkpqOE54bFMrOE0xV3ZaS1Rm?=
 =?utf-8?B?YjFXOUg3Nm1IUFZ4WE9MNXZORDBRT05Da2lnSHBNMm16SHZsQk9WMmcreXMy?=
 =?utf-8?B?aWR6Ukk4cjh4VTVpRDl6WEEvSmV1K3hkQzdjWkloVWh4TFpHSFhKSmtlRE1v?=
 =?utf-8?B?MWh6QlNHNWkwbmtrdURwbVZWWkMzU2JMaVZYQ1k5V1VxejM2YmdqbG95UGFP?=
 =?utf-8?B?UFMwd3RFNEczcUYrRFNnV2IzekFnNVVjMzNDYUxRRDVFK3VRVFVKTmhBaVJJ?=
 =?utf-8?B?eDY4RisveldhVU5TSmdYdWpKL2doVHludmVoYklKNDVseFp5ZndnYUhLT0xM?=
 =?utf-8?B?STRrb0NKWnZYN2MwdGVLSjJTSTVRVDJnMzRZdXVXaWZnZW85Z3djYXFnVnRT?=
 =?utf-8?B?aXVVNFhMY2FBMURNUGRWN1IxT0JyeHMxU0JXS2ZjMzdycERIS25ibVdjTGh2?=
 =?utf-8?B?UURVRWRFeDRhK1Q1a3NMWldidjZLMDNsSE11c2ZGeHg0TVRiRlNjMUdKWko1?=
 =?utf-8?B?NTgzNXF6OUY3eEFBY29IYUlmRDJBdW1TTEZpMUd2Smw5WTZaVkdaN3NEdHZ1?=
 =?utf-8?B?MUZlQVQ2dDVxMS94amV0c0dtc2ZqTnNhWDRZbVp2Q29kbXJ6bjNCc2dPMjhG?=
 =?utf-8?B?RVZOUkRrR2dmdTNOWGFESXlUVmlpSnYvck1mT1cyVTBGRzBIQWhubHNMdTIw?=
 =?utf-8?B?U2phVGREOFk1a3V2ZG1RVHp0YnBIdFkzOGF3R2Q2blEwcWFhODMzL1NIMWlq?=
 =?utf-8?B?USs5N3lLd2wwRGFKL28zM3JRUmFkalRRSDgrTFpKVTM0OTBUeVI2V2tROW1o?=
 =?utf-8?B?UEwwMlNyMmdRdlB2c1djWkI4eEhmKzJFb0V0b055SUtOWm5zc1NqY1N1a2Qz?=
 =?utf-8?B?OHcvSjRjSWtaVDd4QU5WVFlEd08wS0ZqeForWWx2eW1UK2FrUUpCOUlhUlg3?=
 =?utf-8?B?aUxwYmgxK3FScDFNMjJaTkpPVkpyWmZWR2o2ZW9lZjkzS2JGWnBBMzhaaFRu?=
 =?utf-8?B?bkppNklKQW1KdGxDeTRwQkVidElwVXRPR0FQbkJ1ZnN1aWNjY0RodjJYNmVi?=
 =?utf-8?B?UkEzRTZ3V1BybnpKcTdxOVpOWTYwRVIremhVbHRpNERGZHBoZy9hdXp5YUJn?=
 =?utf-8?B?STNqUGdxN2NsWEZ3ZUYrSEMxZlA3UnpGbWQ2OVFGRlZvL3F6b0tlUXRDWlph?=
 =?utf-8?B?ZVFYTmlqTGdrc1dSZDJtZEpvMEY1M3VTalpnOHFYa2xYeUFqYVJnbE9tUUpV?=
 =?utf-8?Q?Gt7zVsus?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2578
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: d871d879-fc43-468f-d58a-08d8c0fb993a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7sChVGl6cUD13aVbWPpBO7oKAaMQCYoAIcKpaHeuVvtAaBiuq1TWOadjd71I77gVRbxdXB7qO3CxniMBPzp/3Ham091SqdEXvlKqVP0lbDtMbDi5achPuE0V0sgcN9aXHoK4JlOI32Eq2UpXDSdaCB3dF+kaCl+b+Vu9eTO65PCX45GTyKRBILczA25o+0so28FLCZfwCiIOYEj+HDZ5WaQeJPGeWQ+vlRbHLergiAnfPuW9dtoxst7+D4nzCxUNh1X8WeurM+PLNqDJ6ZuDgJe7QWkuWrXSYqh1AUs2NPiq+DcMpJQ9MHkgFLI3kRWpFdzciN8BQ7LyE1dU+saVS3HO0QUm/QFbLSAXebRUBZ2CDqZS+uLyZ/6rb737ZX+RYvL9ckonceD4JaNeYOiQuaCVypCFGJamx1fYSVn/dEi+bEZatKjrxben4K5bFVtWlgnNeP02ZW9Dveo2QCN2Pw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(346002)(46966006)(8676002)(52536014)(2906002)(47076005)(82310400003)(5660300002)(70206006)(4326008)(186003)(86362001)(70586007)(336012)(54906003)(53546011)(6506007)(33656002)(478600001)(6862004)(26005)(55016002)(9686003)(316002)(356005)(82740400003)(8936002)(83380400001)(81166007)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 06:36:58.0757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edaf2e52-a4bb-417c-f5d4-08d8c0fb9d45
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1734
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEp1c3RpbiBI
ZQ0KPiBTZW50OiBXZWRuZXNkYXksIEphbnVhcnkgMjAsIDIwMjEgMTE6NTYgUE0NCj4gVG86IE1h
cmMgWnluZ2llciA8bWF6QGtlcm5lbC5vcmc+DQo+IENjOiBDYXRhbGluIE1hcmluYXMgPENhdGFs
aW4uTWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24NCj4gPHdpbGxAa2VybmVsLm9yZz47IGxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IEFuc2h1bWFuIEtoYW5kdWFsIDxBbnNodW1hbi5LaGFuZHVhbEBhcm0uY29t
PjsNCj4gU3V6dWtpIFBvdWxvc2UgPFN1enVraS5Qb3Vsb3NlQGFybS5jb20+OyBNYXJrIFJ1dGxh
bmQNCj4gPE1hcmsuUnV0bGFuZEBhcm0uY29tPjsgR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2
b2Fyc0BrZXJuZWwub3JnPjsNCj4gUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+OyBEYXZlIFAgTWFydGluDQo+IDxEYXZlLk1hcnRpbkBhcm0uY29tPjsgU3Rl
dmVuIFByaWNlIDxTdGV2ZW4uUHJpY2VAYXJtLmNvbT47IEFuZHJldyBNb3J0b24NCj4gPGFrcG1A
bGludXgtZm91bmRhdGlvbi5vcmc+OyBNaWtlIFJhcG9wb3J0IDxycHB0QGtlcm5lbC5vcmc+OyBB
cmQNCj4gQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgR2F2aW4gU2hhbiA8Z3NoYW5AcmVk
aGF0LmNvbT47IEtlZmVuZyBXYW5nDQo+IDx3YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbT47IE1h
cmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47IENyaXN0aWFuDQo+IE1hcnVzc2kgPENyaXN0
aWFuLk1hcnVzc2lAYXJtLmNvbT4NCj4gU3ViamVjdDogUkU6IFtSRkMgUEFUQ0ggMC8yXSBBdm9p
ZCBib290aW5nIHN0YWxsIGNhdXNlZCBieQ0KPiBpZG1hcF9rcHRpX2luc3RhbGxfbmdfbWFwcGlu
Z3MNCj4gDQo+IEhpIE1hcmMNCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiBGcm9tOiBNYXJjIFp5bmdpZXIgPG1hekBrZXJuZWwub3JnPg0KPiA+IFNlbnQ6IFdlZG5lc2Rh
eSwgSmFudWFyeSAyMCwgMjAyMSA2OjU4IFBNDQo+ID4gVG86IEp1c3RpbiBIZSA8SnVzdGluLkhl
QGFybS5jb20+DQo+ID4gQ2M6IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFzQGFybS5j
b20+OyBXaWxsIERlYWNvbg0KPiA+IDx3aWxsQGtlcm5lbC5vcmc+OyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPiA+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IEFuc2h1bWFuIEtoYW5kdWFsIDxBbnNodW1hbi5LaGFuZHVhbEBhcm0uY29tPjsNCj4gPiBTdXp1
a2kgUG91bG9zZSA8U3V6dWtpLlBvdWxvc2VAYXJtLmNvbT47IE1hcmsgUnV0bGFuZA0KPiA+IDxN
YXJrLlJ1dGxhbmRAYXJtLmNvbT47IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2Vy
bmVsLm9yZz47DQo+ID4gUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmc+OyBEYXZlIFAgTWFydGluDQo+ID4gPERhdmUuTWFydGluQGFybS5jb20+OyBTdGV2ZW4g
UHJpY2UgPFN0ZXZlbi5QcmljZUBhcm0uY29tPjsgQW5kcmV3IE1vcnRvbg0KPiA+IDxha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnPjsgTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPjsgQXJk
DQo+ID4gQmllc2hldXZlbCA8YXJkYkBrZXJuZWwub3JnPjsgR2F2aW4gU2hhbiA8Z3NoYW5AcmVk
aGF0LmNvbT47IEtlZmVuZyBXYW5nDQo+ID4gPHdhbmdrZWZlbmcud2FuZ0BodWF3ZWkuY29tPjsg
TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPjsgQ3Jpc3RpYW4NCj4gPiBNYXJ1c3NpIDxD
cmlzdGlhbi5NYXJ1c3NpQGFybS5jb20+DQo+ID4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMC8y
XSBBdm9pZCBib290aW5nIHN0YWxsIGNhdXNlZCBieQ0KPiA+IGlkbWFwX2twdGlfaW5zdGFsbF9u
Z19tYXBwaW5ncw0KPiA+DQo+ID4gSGkgSnVzdGluLA0KPiA+DQo+ID4gT24gMjAyMS0wMS0yMCAw
NDo1MSwgSnVzdGluIEhlIHdyb3RlOg0KPiA+ID4gSGksDQo+ID4gPiBLaW5kbHkgcGluZyDwn5iK
DQo+ID4gPg0KPiA+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPj4gRnJvbTog
SmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gPiA+PiBTZW50OiBXZWRuZXNkYXksIEphbnVh
cnkgMTMsIDIwMjEgOTo0MSBBTQ0KPiA+ID4+IFRvOiBDYXRhbGluIE1hcmluYXMgPENhdGFsaW4u
TWFyaW5hc0Bhcm0uY29tPjsgV2lsbCBEZWFjb24NCj4gPiA+PiA8d2lsbEBrZXJuZWwub3JnPjsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4gPiA+PiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPj4gQ2M6IEFuc2h1bWFuIEtoYW5kdWFsIDxBbnNodW1h
bi5LaGFuZHVhbEBhcm0uY29tPjsgU3V6dWtpIFBvdWxvc2UNCj4gPiA+PiA8U3V6dWtpLlBvdWxv
c2VAYXJtLmNvbT47IEp1c3RpbiBIZSA8SnVzdGluLkhlQGFybS5jb20+OyBNYXJrIFJ1dGxhbmQN
Cj4gPiA+PiA8TWFyay5SdXRsYW5kQGFybS5jb20+OyBHdXN0YXZvIEEuIFIuIFNpbHZhIDxndXN0
YXZvYXJzQGtlcm5lbC5vcmc+Ow0KPiA+ID4+IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhl
bmRlcnNvbkBsaW5hcm8ub3JnPjsgRGF2ZSBQIE1hcnRpbg0KPiA+ID4+IDxEYXZlLk1hcnRpbkBh
cm0uY29tPjsgU3RldmVuIFByaWNlIDxTdGV2ZW4uUHJpY2VAYXJtLmNvbT47IEFuZHJldw0KPiA+
ID4+IE1vcnRvbg0KPiA+ID4+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTWlrZSBSYXBv
cG9ydCA8cnBwdEBrZXJuZWwub3JnPjsgQXJkDQo+ID4gPj4gQmllc2hldXZlbCA8YXJkYkBrZXJu
ZWwub3JnPjsgR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT47IEtlZmVuZw0KPiA+ID4+IFdh
bmcNCj4gPiA+PiA8d2FuZ2tlZmVuZy53YW5nQGh1YXdlaS5jb20+OyBNYXJrIEJyb3duIDxicm9v
bmllQGtlcm5lbC5vcmc+OyBNYXJjDQo+ID4gPj4gWnluZ2llcg0KPiA+ID4+IDxtYXpAa2VybmVs
Lm9yZz47IENyaXN0aWFuIE1hcnVzc2kgPENyaXN0aWFuLk1hcnVzc2lAYXJtLmNvbT4NCj4gPiA+
PiBTdWJqZWN0OiBbUkZDIFBBVENIIDAvMl0gQXZvaWQgYm9vdGluZyBzdGFsbCBjYXVzZWQgYnkN
Cj4gPiA+Pg0KPiA+ID4+IFRoZXJlIGlzIGEgMTBzIHN0YWxsIGluIGlkbWFwX2twdGlfaW5zdGFs
bF9uZ19tYXBwaW5ncyB3aGVuIGtlcm5lbA0KPiA+ID4+IGJvb3RzDQo+ID4gPj4gb24gYSBBbXBl
cmUgRU1BRyBzZXJ2ZXIuDQo+ID4gPj4NCj4gPiA+PiBDb21taXQgZjk5MmI0ZGZkNThiICgiYXJt
NjQ6IGtwdGk6IEFkZCAtPmVuYWJsZSBjYWxsYmFjayB0byByZW1hcA0KPiA+ID4+IHN3YXBwZXIg
dXNpbmcgbkcgbWFwcGluZ3MiKSB1cGRhdGVzIHRoZSBuRyBiaXQgcnVudGltZSBpZiBrcHRpIGlz
DQo+ID4gPj4gcmVxdWlyZWQuDQo+ID4gPj4NCj4gPiA+PiBCdXQgdGhpbmdzIGdldCB3b3JzZSBp
ZiByb2RhdGE9ZnVsbCBpbiBtYXBfbWVtKCkuIE5PX0JMT0NLX01BUFBJTkdTIHwNCj4gPiA+PiBO
T19DT05UX01BUFBJTkdTIGlzIHJlcXVpcmVkIHdoZW4gY3JlYXRpbmcgcGFnZXRhYmxlIG1hcHBp
bmcuIEhlbmNlDQo+ID4gPj4gYWxsDQo+ID4gPj4gcHRlcyBhcmUgZnVsbHkgbWFwcGVkIGluIHRo
aXMgY2FzZS4gT24gYSBBbXBlcmUgRU1BRyBzZXJ2ZXIgd2l0aCAyNTZHDQo+ID4gPj4gbWVtb3J5
KHBhZ2VzaXplPTRrKSwgaXQgY2F1c2VzIHRoZSAxMHMgc3RhbGwuDQo+ID4gPj4NCj4gPiA+PiBB
ZnRlciBtb3ZpbmcgaW5pdF9jcHVfZmVhdHVyZXMoKSBhaGVhZCBvZiBlYXJseV9maXhtYXBfaW5p
dCgpLCB3ZSBjYW4NCj4gPiA+PiB1c2UNCj4gPiA+PiBjcHVfaGF2ZV9jb25zdF9jYXAgZWFybGll
ciB0aGFuIGJlZm9yZS4gSGVuY2Ugd2UgY2FuIGF2b2lkIHRoaXMgc3RhbGwNCj4gPiA+PiBieSB1
cGRhdGluZyBhcm02NF91c2VfbmdfbWFwcGluZ3MuDQo+ID4gPj4NCj4gPiA+PiBBZnRlciB0aGlz
IHBhdGNoIHNlcmllcywgaXQgcmVkdWNlcyB0aGUga2VybmVsIGJvb3QgdGltZSBmcm9tIDE0Ljdz
IHRvDQo+ID4gPj4gNC4xczoNCj4gPiA+PiBCZWZvcmU6DQo+ID4gPj4gWyAgIDE0Ljc1NzU2OV0g
RnJlZWluZyBpbml0cmQgbWVtb3J5OiA2MDc1MksNCj4gPiA+PiBBZnRlcjoNCj4gPiA+PiBbICAg
IDQuMTM4ODE5XSBGcmVlaW5nIGluaXRyZCBtZW1vcnk6IDYwNzUySw0KPiA+ID4+DQo+ID4gPj4g
U2V0IGl0IGFzIFJGQyBiZWNhdXNlIEkgd2FudCB0byByZXNvbHZlIGFueSBvdGhlciBwb2ludHMg
d2hpY2ggSSBoYXZlDQo+ID4gPj4gbWlzY29uZXJuZWQuDQo+ID4NCj4gPiBCdXQgeW91IGRvbid0
IHJlYWxseSBleHBsYWluICp3aHkqIGhhdmluZyB0aGUgQ1BVIEZlYXR1cmUgZGlzY292ZXJ5DQo+
ID4gZWFybHkgaGVscHMgYXQgYWxsLiBJcyB0aGF0IHNvIHRoYXQgeW91IGNhbiBieXBhc3MgdGhl
IGlkbWFwIG1hcHBpbmc/DQo+IA0KPiBBZGRpbmcgbkcgYml0cyBjYW4gYmUgYXZvaWRlZCBieSBo
YXZpbmcgdGhlIGRpc2NvdmVyeSBvZiBib290IGNwdSBmZWF0dXJlDQo+IGVhcmxpZXIgc2luY2Ug
dGhlIG5HIGJpdCBoYWQgYmVlbiBzZXQgaW4gUFRFX01BWUJFX05HL1BNRF9NQVlCRV9ORw0KPiAN
Cj4gQmVmb3JlIHRoaXMgcGF0Y2g6DQo+IDEuIGtlcm5lbCB3aWxsIGZpcnN0bHkgY3JlYXRlIG1h
cHBpbmcgaW4gc2V0dXBfYXJjaC0+cGFnaW5nX2luaXQtPm1hcF9tZW0NCj4gLT4gX19tYXBfbWVt
YmxvY2sNCj4gMi4gVGhlbiBpZiBrcHRpIGlzIHJlcXVpcmVkLCBrZXJuZWwgd2lsbCBhZGQgbkcg
Yml0cyBmb3IgZWFjaCBwdGUgZW50cnkuDQo+IDMuIEluIGV4dHJlbWUgY2FzZSwgZS5nLiBwaHlz
aWNhbCBtZW1vcnkgaXMgMjU2Ryxyb2RhdGE9ZnVsbCwgYW5kIHBhZ2VzaXplDQo+IGlzIDRLLCB0
aGUgbkcgYml0cyB1cGRhdGluZyBpbiBzdGVwIDIgdGFrZXMgYWJvdXQgMTBzLg0KPiANCj4gPiBJ
J2QgZXhwZWN0IHNvbWV0aGluZyB0aGF0IGV4cGxhaW4gdGhlIHByb2JsZW0gaW5zdGVhZCBvZiBw
YXJhcGhyYXNpbmcNCj4gPiB0aGUgcGF0Y2hlcy4NCj4gPg0KPiA+IEFub3RoZXIgdGhpbmcgaXMg
d2hldGhlciB5b3UgaGF2ZSB0ZXN0ZWQgdGhpcyBvbiBzb21lIFRodW5kZXJYIEhXDQo+IA0KPiBJ
IHdpbGwgZmluZCBhIFRYMSBhcyB5b3UgdG9sZCB0byBzZWUgYW55IGRpZmZlcmVuY2UuDQo+IA0K
PiANCkkgZm9ydHVuYXRlbHkgZm91bmQgYSBjYXZpdW0gVFgxLiANClNlZW1zIHRoYXQgdW5tYXBf
a2VybmVsX2F0X2VsMCBpcyBmYWxzZToNCi4uLg0KWyAgICAwLjAwMDAwMF0gTWFjaGluZSBtb2Rl
bDogQ2F2aXVtIFRodW5kZXJYIENOODhYWCBib2FyZA0KLi4uDQpbICAgIDAuMDAwMDAwXSBDUFUg
ZmVhdHVyZXM6IGtlcm5lbCBwYWdlIHRhYmxlIGlzb2xhdGlvbiBmb3JjZWQgT0ZGIGJ5IEFSTTY0
X1dPUktBUk9VTkRfQ0FWSVVNXzI3NDU2DQouLi4NCg0KSGVuY2Ugbm8gc3VjaCBzdGFsbCAqYmVm
b3JlKiBhbmQgKmFmdGVyKiB0aGlzIHBhdGNoIHNldCBiZWNhdXNlIGtwdGkgaXMgbm90IGVuYWJs
ZWQuDQoNCg0KLS0NCkNoZWVycywNCkp1c3RpbiAoSmlhIEhlKQ0KDQoNCg0KDQo=
