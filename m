Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60602FCA20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbhATEwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:52:53 -0500
Received: from mail-eopbgr60072.outbound.protection.outlook.com ([40.107.6.72]:53218
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726334AbhATEwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPym/Usl5lMx0RrdOkHIdbP99BTSLMDHINGSFkmxQ68=;
 b=UOhGZ24NjDzHlW5CjO2Tlu/UyEJyZZWDpUirsHLa19F6KjPLQRAHbu6DZxv48Ev2lNhHMnMS4wfTXvXDPpjVnGEv+oPJu+HTi6bAyetov1aarAVG6e9cw+PPp/j3VCmmjuSDp3roLg9m7U2OHsMJ9TzruScr62OZaund6Q1lwFQ=
Received: from AM5PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:206:1::27)
 by VE1PR08MB5680.eurprd08.prod.outlook.com (2603:10a6:800:1a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 20 Jan
 2021 04:51:52 +0000
Received: from AM5EUR03FT060.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::4) by AM5PR04CA0014.outlook.office365.com
 (2603:10a6:206:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend
 Transport; Wed, 20 Jan 2021 04:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT060.mail.protection.outlook.com (10.152.16.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.12 via Frontend Transport; Wed, 20 Jan 2021 04:51:51 +0000
Received: ("Tessian outbound 2b57fdd78668:v71"); Wed, 20 Jan 2021 04:51:50 +0000
X-CR-MTA-TID: 64aa7808
Received: from 4380d52efd5c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id ED08DA03-DD15-4E43-ADE4-15297529B3CE.1;
        Wed, 20 Jan 2021 04:51:45 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4380d52efd5c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 Jan 2021 04:51:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJPd0dCpRUFu2lCfZv3hXRseFeqKlIf+VwHHWutjK+dW7JT2hESDJSwLQdAtI8DbuMIoL19WlOJFZgS+p3iYVeIUCxqsDRsICcEWvHKhq0DdTkDttOUpRcXMvucZWrJjc+pNjdrO16uddVnaPsX2Gj0nPthszIzCaceUrD62A4I6G5O+CO+L3Rgg9ehpFXsssc/eLg8js0g8gNaK2QbhYfOG3vC5SqpMag9k3O9gRidcyig6jPNhfpOxC9BmzdI2wpTUB77IvNKv9zJvJc/m8hIj+V4FWRY8TEU3scgJbJcQlow7o/C0NCdNpMdUhvEXj5S+XURBPfWMSumD6lvz9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPym/Usl5lMx0RrdOkHIdbP99BTSLMDHINGSFkmxQ68=;
 b=IhgOGuCLWoJasKQUl2r5M00AJMoTXf0MAoTi2woAEga0/WMLMYjQPYJi3/8KCUpH6qn4fmh3OnZ5H4LyG0pUl4UmeeR0oOS5+0kdxwXYLb23BHp8sfGJZgr0f71/UKuY2DBMoz4kIsaYjVUwp8M+4qsmB4gdz9yDboOwSW0eqQUdFBg3+JQVfXEFa2B2Z4fGdoIy7ZMmW7AfOAEGuWeTuQ3lh9iWoRDORXKr2bmU23wQt7VDU42G48iUkO4+VSLEa2uuQSEQmUzZLg6Kc12Ri6W+lzVyqZEMXC0jPP3MmN0p34JWJKTkEFzgO5pUq8tqtcFi9puSyXZ7nC7nhQllcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPym/Usl5lMx0RrdOkHIdbP99BTSLMDHINGSFkmxQ68=;
 b=UOhGZ24NjDzHlW5CjO2Tlu/UyEJyZZWDpUirsHLa19F6KjPLQRAHbu6DZxv48Ev2lNhHMnMS4wfTXvXDPpjVnGEv+oPJu+HTi6bAyetov1aarAVG6e9cw+PPp/j3VCmmjuSDp3roLg9m7U2OHsMJ9TzruScr62OZaund6Q1lwFQ=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB3478.eurprd08.prod.outlook.com (2603:10a6:20b:4a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 20 Jan
 2021 04:51:42 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::912:f387:b95f:fea8]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::912:f387:b95f:fea8%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 04:51:42 +0000
From:   Justin He <Justin.He@arm.com>
To:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
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
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Cristian Marussi <Cristian.Marussi@arm.com>
Subject: RE: [RFC PATCH 0/2] Avoid booting stall caused by
 idmap_kpti_install_ng_mappings 
Thread-Topic: [RFC PATCH 0/2] Avoid booting stall caused by
 idmap_kpti_install_ng_mappings 
Thread-Index: Adbu5+JvnpOuAYGvSAeGYH7FUfQeew==
Date:   Wed, 20 Jan 2021 04:51:41 +0000
Message-ID: <AM6PR08MB43763910418580E3A470BF27F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: FFE40E838E3D904A93131E52EA0DD62A.0
x-checkrecipientchecked: true
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3cb1b2de-1854-40b7-1269-08d8bcff1a2b
x-ms-traffictypediagnostic: AM6PR08MB3478:|VE1PR08MB5680:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VE1PR08MB56809979ED289B4BC5A638CAF7A20@VE1PR08MB5680.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: VDJzBITPjnILpQiPGWD2TdR2Me/6x7OEjx11Bh6pvt1+ht5bW9E1EUcOkmP07YJZxzQIBIaCymikZsobNa6ECrwUkPqvYwuHFxKYY9FYF1SHyIFASQ5OK7aESWdIOiYVb1Z/jCyIXe7gwHAPV+rvmf5QzOfhWahZdfE63Z6w8hu03hWfOiZDFSnxY0FI9DMgnYmS04ChuW5hl3vrFpCyjTl1lyCWOOlgUv7OzGredo9CVIBqYuSTFaVXY9HzElGY9QVTKU7Aszthrw2U+1n0oDUNKj+hdd1gwV05RxEr+ti/CECdC1HlCl7kunmphcBw+JLfyYbhgba4zZcQZuh1d8dtw4nEJlXra1b3kprSGtRIWmbLMdHTbO658I5u57vy2Anoa9gdE8mR0oTxX9Lmbl+NXC+xJy3tvUMxwOU2554q7gNhsq2RaGHA9ddPdr3gEF7LzEuWroHEVjzpuO8T/eXtBmDEb0XrnRg/FAmVByHMzJGwswk7xaxwaQ9Wlv8JYqqwdrF3GyXTmFMw1nzFDQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39850400004)(366004)(136003)(396003)(2906002)(9686003)(71200400001)(478600001)(5660300002)(186003)(7696005)(26005)(55016002)(8936002)(66946007)(64756008)(66556008)(66446008)(66476007)(54906003)(33656002)(83380400001)(110136005)(86362001)(76116006)(53546011)(7416002)(8676002)(316002)(4743002)(6506007)(52536014)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RW9LODEzRGNlL0hDZ0pRTXlzK055SU1IdHpsKzBiSDBPZ21yKzMvaE1ESDhQ?=
 =?utf-8?B?U2FOQVRTa1BmenhCeHZtRU1uWThlaFRYazQ3RlF4RWtkOE5pdk5qTko1Nm9s?=
 =?utf-8?B?aGQ0TkJ2WlhMYjA4bkp1NlNlNTZ6YTBjSmNpRWtsRmlGMTRNdGJrNXVubkdn?=
 =?utf-8?B?NXYrRDAvSW5obWRIUVNIazFiQ2ExVjZFeEdTY2xtVXhUVEU1RmpXeDk5cFVB?=
 =?utf-8?B?RFJCRTRzZU9raC9SK2sycDNxZ1NVbTkzOFR6cTgwaHhNNE9YTmM2Tm82MUhh?=
 =?utf-8?B?bzNxdXVGZytmRFp1UXFqVlE3T0wwMy9Kb1ZTY0l5a2FBT2pHOWxwc1JhNFEy?=
 =?utf-8?B?QVV3MkljdnZROC9MWjNJK3lRSU53enB1dE5YeDJLeGorK21CZ244RjJ2bmxC?=
 =?utf-8?B?T0hQaGlOS0F5UGYvZXpFQUsyMXZ2WUdNRHY3WkdtcVdmNzZnQnpBekZxdlFP?=
 =?utf-8?B?VFljQ0xIMmx4QXN3YmxwN2RnS2hoNDIzTmNrVjRyditReVNnOU8rdW1BS2pO?=
 =?utf-8?B?NmtoN2ZNdW1MMUVQMmhtTHErR1puOXF3OWJ0THpYL3pPVVl0dU1IN0MxUm5Z?=
 =?utf-8?B?a1k5QnFUYm9jRFhjTFc3TGtzYjNJWXpsNmxNYm5KT2dQb3JmWWp6Q1grRFcv?=
 =?utf-8?B?dzMxUUxHdjB0ZDJ2TG1PZVVKU1JUZEdxZ1dFZHZ0bW5ZTzJXSmtReXBSU0p5?=
 =?utf-8?B?RTc4bERDRWhpVW9mMytZbE5GWG1yN2tZZUoycHYweDA3R3Jic2doNGhOZXVV?=
 =?utf-8?B?N1ZGakxXb0JNc1d1TUw4MW5lemNEL3dURzBPaGZGN2VURzdlVnRKN09BNDY0?=
 =?utf-8?B?dTkwcTE5OXZoZGNHL2t5K2R6OWNqOFppc2NGN3JMSS9mR1cyY1FzY0VZL3gz?=
 =?utf-8?B?OHkvZWxqN1JXWjFPTG9RN0R0bVNmbkcxWEFoM3RuZ3dEdGZScG1UWkJsc043?=
 =?utf-8?B?NHZDS3dreFBaengzRmllRm1uWTJvbGg4ZTNqSGZDQWtSUHZYVGRSRHBCRFJZ?=
 =?utf-8?B?bklIMW9WVG4rWUF5blo2eGwwandvS0Z2QnY2MGJMSlAxbXdtRiswT2gvTEtD?=
 =?utf-8?B?WUYreGFLejVXRWRLK3orNmk5V056UjE0QVZhUkQzSlkxNlpBRzZXbFhwTE1B?=
 =?utf-8?B?YlNGQWFrZDF4STUyTFdORkJJSkV3a2JFdmxRS1RVMWwxajRYaU51czNyV3dZ?=
 =?utf-8?B?K09GU2RuUkZlUm9lR1ZPbXBoa2JoYWlHMFdxa0dQZExzN3dsSWJwTERyU21R?=
 =?utf-8?B?ejlFbFJmQmNKVU1iWFhOYndscWdhQ3ppNVAyZ3paTHZCcmpZWDNGWmlMUW93?=
 =?utf-8?Q?zubvv9hMnRd8s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3478
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 29b9961f-4e6a-4242-2b13-08d8bcff149c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0FSoej7KRtzv4kfZP2h4tbmacoXA2xmmznXVsCTsaH7ktVEYQaB7ZKDM9TcK9X91RYf93fI4p0lxb7BRTshDLlDTlyOl2e/Yyueei24M4wOK9h9e0iP40eETjcxVDfOIyBnBL5jNeUeQPqa2AihFSBiazDDMIiycb8skFlgYrYRZB29OqbEhlx+KMoQKTPnlkwbubLMkdVHbZrJB6eAJXiZWPML3MODBjCneig+qw7KV8hugw9R8duVEzr63EkB7cXdgK7lx7VeXf/19SVGImq7XH+CqPI69z5yeU26KOXA6VGUU7+pFsOnI8TJAdNWEDOr2pzgDzQpXzXmOjMedUYFm3Nn6Xz8ecOlc8lkOt3xcyLMLM44gZqPd5Vm3svtttPlmZyraLMn89tw8Z9dT9l+vMO7I40e7MPBSYZLPeYyvi1xZ4nJCodLMQi21sxPepIoTgxuki2f+4SDJAkhZA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(46966006)(83380400001)(4326008)(47076005)(356005)(86362001)(82310400003)(82740400003)(336012)(54906003)(110136005)(70586007)(316002)(5660300002)(81166007)(478600001)(6506007)(4743002)(53546011)(55016002)(2906002)(8936002)(9686003)(70206006)(7696005)(26005)(52536014)(33656002)(8676002)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 04:51:51.4088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb1b2de-1854-40b7-1269-08d8bcff1a2b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT060.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQpLaW5kbHkgcGluZyDwn5iKDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
RnJvbTogSmlhIEhlIDxqdXN0aW4uaGVAYXJtLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBKYW51
YXJ5IDEzLCAyMDIxIDk6NDEgQU0NCj4gVG86IENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJp
bmFzQGFybS5jb20+OyBXaWxsIERlYWNvbg0KPiA8d2lsbEBrZXJuZWwub3JnPjsgbGludXgtYXJt
LWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBDYzogQW5zaHVtYW4gS2hhbmR1YWwgPEFuc2h1bWFuLktoYW5kdWFsQGFybS5jb20+
OyBTdXp1a2kgUG91bG9zZQ0KPiA8U3V6dWtpLlBvdWxvc2VAYXJtLmNvbT47IEp1c3RpbiBIZSA8
SnVzdGluLkhlQGFybS5jb20+OyBNYXJrIFJ1dGxhbmQNCj4gPE1hcmsuUnV0bGFuZEBhcm0uY29t
PjsgR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b2Fyc0BrZXJuZWwub3JnPjsNCj4gUmljaGFy
ZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+OyBEYXZlIFAgTWFydGlu
DQo+IDxEYXZlLk1hcnRpbkBhcm0uY29tPjsgU3RldmVuIFByaWNlIDxTdGV2ZW4uUHJpY2VAYXJt
LmNvbT47IEFuZHJldyBNb3J0b24NCj4gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+OyBNaWtl
IFJhcG9wb3J0IDxycHB0QGtlcm5lbC5vcmc+OyBBcmQNCj4gQmllc2hldXZlbCA8YXJkYkBrZXJu
ZWwub3JnPjsgR2F2aW4gU2hhbiA8Z3NoYW5AcmVkaGF0LmNvbT47IEtlZmVuZyBXYW5nDQo+IDx3
YW5na2VmZW5nLndhbmdAaHVhd2VpLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9y
Zz47IE1hcmMgWnluZ2llcg0KPiA8bWF6QGtlcm5lbC5vcmc+OyBDcmlzdGlhbiBNYXJ1c3NpIDxD
cmlzdGlhbi5NYXJ1c3NpQGFybS5jb20+DQo+IFN1YmplY3Q6IFtSRkMgUEFUQ0ggMC8yXSBBdm9p
ZCBib290aW5nIHN0YWxsIGNhdXNlZCBieQ0KPiANCj4gVGhlcmUgaXMgYSAxMHMgc3RhbGwgaW4g
aWRtYXBfa3B0aV9pbnN0YWxsX25nX21hcHBpbmdzIHdoZW4ga2VybmVsIGJvb3RzDQo+IG9uIGEg
QW1wZXJlIEVNQUcgc2VydmVyLg0KPiANCj4gQ29tbWl0IGY5OTJiNGRmZDU4YiAoImFybTY0OiBr
cHRpOiBBZGQgLT5lbmFibGUgY2FsbGJhY2sgdG8gcmVtYXANCj4gc3dhcHBlciB1c2luZyBuRyBt
YXBwaW5ncyIpIHVwZGF0ZXMgdGhlIG5HIGJpdCBydW50aW1lIGlmIGtwdGkgaXMNCj4gcmVxdWly
ZWQuDQo+IA0KPiBCdXQgdGhpbmdzIGdldCB3b3JzZSBpZiByb2RhdGE9ZnVsbCBpbiBtYXBfbWVt
KCkuIE5PX0JMT0NLX01BUFBJTkdTIHwNCj4gTk9fQ09OVF9NQVBQSU5HUyBpcyByZXF1aXJlZCB3
aGVuIGNyZWF0aW5nIHBhZ2V0YWJsZSBtYXBwaW5nLiBIZW5jZSBhbGwNCj4gcHRlcyBhcmUgZnVs
bHkgbWFwcGVkIGluIHRoaXMgY2FzZS4gT24gYSBBbXBlcmUgRU1BRyBzZXJ2ZXIgd2l0aCAyNTZH
DQo+IG1lbW9yeShwYWdlc2l6ZT00ayksIGl0IGNhdXNlcyB0aGUgMTBzIHN0YWxsLg0KPiANCj4g
QWZ0ZXIgbW92aW5nIGluaXRfY3B1X2ZlYXR1cmVzKCkgYWhlYWQgb2YgZWFybHlfZml4bWFwX2lu
aXQoKSwgd2UgY2FuIHVzZQ0KPiBjcHVfaGF2ZV9jb25zdF9jYXAgZWFybGllciB0aGFuIGJlZm9y
ZS4gSGVuY2Ugd2UgY2FuIGF2b2lkIHRoaXMgc3RhbGwNCj4gYnkgdXBkYXRpbmcgYXJtNjRfdXNl
X25nX21hcHBpbmdzLg0KPiANCj4gQWZ0ZXIgdGhpcyBwYXRjaCBzZXJpZXMsIGl0IHJlZHVjZXMg
dGhlIGtlcm5lbCBib290IHRpbWUgZnJvbSAxNC43cyB0bw0KPiA0LjFzOg0KPiBCZWZvcmU6DQo+
IFsgICAxNC43NTc1NjldIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTogNjA3NTJLDQo+IEFmdGVyOg0K
PiBbICAgIDQuMTM4ODE5XSBGcmVlaW5nIGluaXRyZCBtZW1vcnk6IDYwNzUySw0KPiANCj4gU2V0
IGl0IGFzIFJGQyBiZWNhdXNlIEkgd2FudCB0byByZXNvbHZlIGFueSBvdGhlciBwb2ludHMgd2hp
Y2ggSSBoYXZlDQo+IG1pc2NvbmVybmVkLg0KPiANCj4gSmlhIEhlICgyKToNCj4gICBhcm02NC9j
cHVpbmZvOiBNb3ZlIGluaXRfY3B1X2ZlYXR1cmVzKCkgYWhlYWQgb2YgZWFybHlfZml4bWFwX2lu
aXQoKQ0KPiAgIGFybTY0OiBrcHRpOiBVcGRhdGUgYXJtNjRfdXNlX25nX21hcHBpbmdzIGJlZm9y
ZSBwYWdldGFibGUgbWFwcGluZw0KPiANCj4gIGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vY3B1Lmgg
fCAgMSArDQo+ICBhcmNoL2FybTY0L2tlcm5lbC9jcHVpbmZvLmMgIHwgMTMgKysrKysrKysrKy0t
LQ0KPiAgYXJjaC9hcm02NC9rZXJuZWwvc2V0dXAuYyAgICB8IDE4ICsrKysrKysrKysrKystLS0t
LQ0KPiAgYXJjaC9hcm02NC9rZXJuZWwvc21wLmMgICAgICB8ICAzICstLQ0KPiAgNCBmaWxlcyBj
aGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIu
MTcuMQ0KDQo=
