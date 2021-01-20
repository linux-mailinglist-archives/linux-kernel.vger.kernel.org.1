Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA27B2FD4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391153AbhATQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:00:05 -0500
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:64129
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389866AbhATP4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcjqDMNQRzP1ueTuYzxL//PZ7+c4PhD0t8xCULVlzek=;
 b=UruA77PvxNqDBeif9n46AkQEBIaRV+T9498t6wbu+NHTtdKSt8W04B4svIdMudJc+dra5zdXOVpLAkxaK9gVFnolOwgnf+z7m+7qlRASsiZcnPotnXEXP9zLsyX99qtgq+V1vcB3eZA9kzusBllF7jWPvAlGzoBuYqSSh/Wp3qQ=
Received: from DB6PR0201CA0023.eurprd02.prod.outlook.com (2603:10a6:4:3f::33)
 by AM6PR08MB3477.eurprd08.prod.outlook.com (2603:10a6:20b:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11; Wed, 20 Jan
 2021 15:55:42 +0000
Received: from DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::2c) by DB6PR0201CA0023.outlook.office365.com
 (2603:10a6:4:3f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10 via Frontend
 Transport; Wed, 20 Jan 2021 15:55:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT059.mail.protection.outlook.com (10.152.21.175) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 15:55:42 +0000
Received: ("Tessian outbound 2b57fdd78668:v71"); Wed, 20 Jan 2021 15:55:42 +0000
X-CR-MTA-TID: 64aa7808
Received: from 004d6a5061bc.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 90835FF5-2A01-4C40-9727-7610D0E74BDF.1;
        Wed, 20 Jan 2021 15:55:37 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 004d6a5061bc.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 20 Jan 2021 15:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yd5bQ6O419OnNpjryHXXFkBI55Ga/FbnfBfmtbDTtlRzpPEXJNsgaZW9kuv/oj1ySTtfgQr8QehAOvolnKiOSkIzWN1cRiq2hTsppHXkrmMqEwAfFg03/rZHHEGdpjnHW8QL9PjQ6DTA2rwmdGIXQoPqC/YnH87zrX73xFvWY81ExUziL+XONvp6FN3gBx3eWqYIr6YEDxF7D5GRaQfocI2U4oZu8oyC7+gKjRZ2OfO8yrhPTw/zFrH2JrPI8nH0JYxeSXeTpEAXIzKMs8vsPheaoRTEBuISJj2ULjh4v8KgxpLr2a4rFj+Kca8D6gVRD7vy7ZM0MUZcwiW0UQpi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcjqDMNQRzP1ueTuYzxL//PZ7+c4PhD0t8xCULVlzek=;
 b=DhkCoLaO3Yg/4qv7IozUjTK4f+7JRkZqBTHEj6lt20O9pvQfCB+mTXNfXULo4SMTn6/dpbsI56D5CiqxCT/s4jCq+aCV/VNbw6QjPkiOPbGujfeOWiC2J/JfnidjZshUhzNUdwNGqXWip0GP8Nwd6jRgLUs6EgiVK27qC6KhQqeAY9KxNVaNprZK6+VVjbZWg7siU3VoV776ODFhSKYckP6jbkLSkJrZA//GqIkLpRfQiqArgcLDn6MyMj6jJpRUIf9mnu+ywt4CDQ9kFHF/8dSNoaf2IkxNCGehWJmLgwLDJ6Dc1RFdvhT3gDdNyZVlVWtUKjH+EPvEKphmZz3j+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcjqDMNQRzP1ueTuYzxL//PZ7+c4PhD0t8xCULVlzek=;
 b=UruA77PvxNqDBeif9n46AkQEBIaRV+T9498t6wbu+NHTtdKSt8W04B4svIdMudJc+dra5zdXOVpLAkxaK9gVFnolOwgnf+z7m+7qlRASsiZcnPotnXEXP9zLsyX99qtgq+V1vcB3eZA9kzusBllF7jWPvAlGzoBuYqSSh/Wp3qQ=
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by AM6PR08MB4984.eurprd08.prod.outlook.com (2603:10a6:20b:ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.13; Wed, 20 Jan
 2021 15:55:34 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::912:f387:b95f:fea8]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::912:f387:b95f:fea8%7]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 15:55:34 +0000
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
Thread-Index: Adbu5+JvnpOuAYGvSAeGYH7FUfQeewAM0ikAAAnHHlA=
Date:   Wed, 20 Jan 2021 15:55:34 +0000
Message-ID: <AM6PR08MB43767517972A292A9AA15586F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <AM6PR08MB43763910418580E3A470BF27F7A20@AM6PR08MB4376.eurprd08.prod.outlook.com>
 <e8a45079ae30232eaa889f026439da9e@kernel.org>
In-Reply-To: <e8a45079ae30232eaa889f026439da9e@kernel.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 4B0B5E1A7677B64BA555B08848485453.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [223.166.32.19]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffddbb27-92f3-421e-6103-08d8bd5bd777
x-ms-traffictypediagnostic: AM6PR08MB4984:|AM6PR08MB3477:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB34776C14D29FF96990E67A90F7A20@AM6PR08MB3477.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1443;OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bDjIrgXiwT8ExbkMFMb5nctXLL2Z2PeGaz/l8Ss7BE/X10lPMgXKd2awNUxW3hyBs45XDRmYYVqsdqYaR+4ggDeCSfSA6R3NWmxAUmuxcqzLm3XG3SrMIrCx3YK7mGKGy5dP65NxHDigiCLLVTHs3miUPbKfcaPcctP0kp9RbqvjEV/dmq1dtBVzY47DM84M+llJmMHyL0vzPTAq1zcG+xk6UwKQ/bedP4UzA/1jBfOoo7TxGh7s3B8ClFZo3Fvvu4eTK/Omne+eKJD3WtCo74AMoJxAHLBo9WF6IFJytudRmJYAvSD0j4+If3QyqAAfIb94V5JQGStjVso+kKcKOpuwjJMPGAnGzVWh1jHTSU4oVpBBbuZ7Co2ToJRoK1W1BhgvgguYM0ZoD9s3bFwOMQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(53546011)(478600001)(66476007)(66946007)(86362001)(9686003)(6506007)(316002)(64756008)(26005)(33656002)(7696005)(66446008)(8936002)(66556008)(186003)(55016002)(8676002)(71200400001)(83380400001)(5660300002)(52536014)(7416002)(54906003)(76116006)(2906002)(6916009)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S3pTZGhURFluNnErbUtkNFFvNElCTGU3YkFhL0dtQlN1aHo3RGJETEx1SVcy?=
 =?utf-8?B?cmZtVHlZK2VKVkY3UFFudHZ1ekhIZElNbGhiNTh2ZHk5anpFQm4xVnRIMEpi?=
 =?utf-8?B?K0l0blMvZGZYODNscFg3V2xjeThBRjlkV21sR0tCemx2Zmk2RDcxczlXWXVE?=
 =?utf-8?B?ekJheXNmcGdodkZpaTNDRzN1azJmOVd0NzBDbXpFYy91RzVLdml6TUJKMUxR?=
 =?utf-8?B?L3VYelpuaUNuMDF3a3Y3Y2h2MzZJVUl4cXRqUGdIU1pKaE9XZzR1ZW1MZkp0?=
 =?utf-8?B?T2NQVitOcTNKbXBkMVo1K1JaeUVBQ2hGdC9KRTh4TXAxR1FtbHFNVGcvQTRL?=
 =?utf-8?B?UzJXMlVBZDFCMFR3WU1FOE5BNGZFbTFkbDZxOGpMR2hLd1NuQ1N1VXVja3hF?=
 =?utf-8?B?ZGg4RDZqaHlTdEMxVXArSzlyRFRsdTlFL1F3alQwbS9uV200eGx0UExOTHZj?=
 =?utf-8?B?NkN6bFFhMGxiSENaOVBHRVZiL0E2VlZad0Q1VkQ2OVAzZWY3ZlFTUXBYUk1z?=
 =?utf-8?B?aVIrSEJxaTBuOGJ6OHFWaGJRV3d2Rk5zdFF6M2dWVHJZLzZYSXc5Ry9CcEJy?=
 =?utf-8?B?YSt0RXM5c0syQzFiTE5kQkF3MmxrODZLelp1Wnpxa0FheTh6RkJiS2VUWEk5?=
 =?utf-8?B?S2YrclVyRmxWUE5hUjdYRnVEWEx2L2xkMkJ0dldFN2dPZjd4cUpuQlYrZVBs?=
 =?utf-8?B?YkFybjUwTmMxb1hURUJyN0dOdzVEcjdlbC9SbklPbkNyaExZN29nTWlMN2do?=
 =?utf-8?B?cEYxRURiaEM1V2luMUtyanZ1UHNEeEhRK0JGN2xpVEQyRzNMNFZDSG1xTy9L?=
 =?utf-8?B?WmdibW14Nm9JZ0ZwQ1A5TTMwU09mdHgraEhBYzZYTVZ0K2hqRVUwbXl6ZkN3?=
 =?utf-8?B?Sjg3VThScU5iVmNzNWtqbVJPYzlSM0RCanZUQmF3WHNMa3dTS3lFWG1FT0RZ?=
 =?utf-8?B?UXFlc25BVjliTWtpYXFpWmhGMnZsUTlKZTE1V0NpOUxXUkRQM2MvTnFnMDRP?=
 =?utf-8?B?OFhQK2FCd0NmNXU5NlNKdVBvWXNiVmZ1ZktiNkUwVWZYOVBCS1hwck80aWJx?=
 =?utf-8?B?RkdGK3Jzay9wVHVxTG1Fb3NWQzhxVHJ4SndnakxDdGdnK0ZVcTE2eGg3dzR6?=
 =?utf-8?B?OGdmTlR5TU83Q3NVYzJJTDVKNkxvd0ZCT1ZLY0FmVlVaU01hdXRiVlNvNHF5?=
 =?utf-8?B?VWtHNnhwZHpJb0RxcWxwYjIzTXpHTHJnZG54NjJORll0OUhIVUhrY2Y0RXhn?=
 =?utf-8?B?dFJxTGlZZWQxcmRlZHI1c0lLTndsSUlkdGpkaDVUZmRZSkp5L3ZxdlFSd0VZ?=
 =?utf-8?Q?+uDSOev80fYAQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4984
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 29bb5e30-f9c3-4938-ceaf-08d8bd5bd2cc
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bKrXaj88d5ZFxlSrRQhRwIYE9J/p9OAFVFkCdlM8XgIoH9MC4QixgJzFove+kljevtJiwm8tGDhOLq7jdMcdChA33vQs9BAv7OcA5XjBG9K9W2UEDeD8KSK6VmebpKk56brUB+io7cRdAtfeNU1fZkyZdfN+BRGZZyQ6oz1s6SFydkgKxIf36+bvpnDxq7x0uFbtuZxBtzCIxrAD5sJuCzkgRSVO+0KDtBH8vVuI2TybKSg6qNElYtqSt9945uYcS7656IjPTX8uUJbtPoOm+a8glLy1QpD5V4itcvrah+y9Ln4fEmd53GncvBMUuTwccgi4tM2Y80IOyRwV3Dv7R5XmDJyLqsYS4q/vZpblCuvTttbcEmkkBbWJwiSWiLBqd+ChCYJmlxzeKAsX/+nLTp5hDAeLJpQr2Iw6/cY5l2rm7QqsHxo2x/3zR5aHDyJZdRv2Jb2+11mHxTOy7fmLEA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(7696005)(2906002)(26005)(83380400001)(186003)(6862004)(53546011)(70586007)(70206006)(54906003)(82740400003)(81166007)(47076005)(316002)(356005)(33656002)(4326008)(52536014)(6506007)(5660300002)(55016002)(82310400003)(9686003)(336012)(8936002)(86362001)(478600001)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 15:55:42.7453
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffddbb27-92f3-421e-6103-08d8bd5bd777
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT059.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3477
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFyYw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmMgWnlu
Z2llciA8bWF6QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAyMCwgMjAy
MSA2OjU4IFBNDQo+IFRvOiBKdXN0aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPg0KPiBDYzogQ2F0
YWxpbiBNYXJpbmFzIDxDYXRhbGluLk1hcmluYXNAYXJtLmNvbT47IFdpbGwgRGVhY29uDQo+IDx3
aWxsQGtlcm5lbC5vcmc+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBBbnNodW1hbiBLaGFuZHVhbCA8QW5zaHVt
YW4uS2hhbmR1YWxAYXJtLmNvbT47DQo+IFN1enVraSBQb3Vsb3NlIDxTdXp1a2kuUG91bG9zZUBh
cm0uY29tPjsgTWFyayBSdXRsYW5kDQo+IDxNYXJrLlJ1dGxhbmRAYXJtLmNvbT47IEd1c3Rhdm8g
QS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz47DQo+IFJpY2hhcmQgSGVuZGVyc29u
IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgRGF2ZSBQIE1hcnRpbg0KPiA8RGF2ZS5N
YXJ0aW5AYXJtLmNvbT47IFN0ZXZlbiBQcmljZSA8U3RldmVuLlByaWNlQGFybS5jb20+OyBBbmRy
ZXcgTW9ydG9uDQo+IDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPjsgTWlrZSBSYXBvcG9ydCA8
cnBwdEBrZXJuZWwub3JnPjsgQXJkDQo+IEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz47IEdh
dmluIFNoYW4gPGdzaGFuQHJlZGhhdC5jb20+OyBLZWZlbmcgV2FuZw0KPiA8d2FuZ2tlZmVuZy53
YW5nQGh1YXdlaS5jb20+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBDcmlzdGlh
bg0KPiBNYXJ1c3NpIDxDcmlzdGlhbi5NYXJ1c3NpQGFybS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UkZDIFBBVENIIDAvMl0gQXZvaWQgYm9vdGluZyBzdGFsbCBjYXVzZWQgYnkNCj4gaWRtYXBfa3B0
aV9pbnN0YWxsX25nX21hcHBpbmdzDQo+IA0KPiBIaSBKdXN0aW4sDQo+IA0KPiBPbiAyMDIxLTAx
LTIwIDA0OjUxLCBKdXN0aW4gSGUgd3JvdGU6DQo+ID4gSGksDQo+ID4gS2luZGx5IHBpbmcg8J+Y
ig0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IEppYSBI
ZSA8anVzdGluLmhlQGFybS5jb20+DQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAxMywg
MjAyMSA5OjQxIEFNDQo+ID4+IFRvOiBDYXRhbGluIE1hcmluYXMgPENhdGFsaW4uTWFyaW5hc0Bh
cm0uY29tPjsgV2lsbCBEZWFjb24NCj4gPj4gPHdpbGxAa2VybmVsLm9yZz47IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+ID4+IGtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gPj4gQ2M6IEFuc2h1bWFuIEtoYW5kdWFsIDxBbnNodW1hbi5LaGFuZHVhbEBhcm0u
Y29tPjsgU3V6dWtpIFBvdWxvc2UNCj4gPj4gPFN1enVraS5Qb3Vsb3NlQGFybS5jb20+OyBKdXN0
aW4gSGUgPEp1c3Rpbi5IZUBhcm0uY29tPjsgTWFyayBSdXRsYW5kDQo+ID4+IDxNYXJrLlJ1dGxh
bmRAYXJtLmNvbT47IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9hcnNAa2VybmVsLm9yZz47
DQo+ID4+IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsg
RGF2ZSBQIE1hcnRpbg0KPiA+PiA8RGF2ZS5NYXJ0aW5AYXJtLmNvbT47IFN0ZXZlbiBQcmljZSA8
U3RldmVuLlByaWNlQGFybS5jb20+OyBBbmRyZXcNCj4gPj4gTW9ydG9uDQo+ID4+IDxha3BtQGxp
bnV4LWZvdW5kYXRpb24ub3JnPjsgTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwub3JnPjsgQXJk
DQo+ID4+IEJpZXNoZXV2ZWwgPGFyZGJAa2VybmVsLm9yZz47IEdhdmluIFNoYW4gPGdzaGFuQHJl
ZGhhdC5jb20+OyBLZWZlbmcNCj4gPj4gV2FuZw0KPiA+PiA8d2FuZ2tlZmVuZy53YW5nQGh1YXdl
aS5jb20+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBNYXJjDQo+ID4+IFp5bmdp
ZXINCj4gPj4gPG1hekBrZXJuZWwub3JnPjsgQ3Jpc3RpYW4gTWFydXNzaSA8Q3Jpc3RpYW4uTWFy
dXNzaUBhcm0uY29tPg0KPiA+PiBTdWJqZWN0OiBbUkZDIFBBVENIIDAvMl0gQXZvaWQgYm9vdGlu
ZyBzdGFsbCBjYXVzZWQgYnkNCj4gPj4NCj4gPj4gVGhlcmUgaXMgYSAxMHMgc3RhbGwgaW4gaWRt
YXBfa3B0aV9pbnN0YWxsX25nX21hcHBpbmdzIHdoZW4ga2VybmVsDQo+ID4+IGJvb3RzDQo+ID4+
IG9uIGEgQW1wZXJlIEVNQUcgc2VydmVyLg0KPiA+Pg0KPiA+PiBDb21taXQgZjk5MmI0ZGZkNThi
ICgiYXJtNjQ6IGtwdGk6IEFkZCAtPmVuYWJsZSBjYWxsYmFjayB0byByZW1hcA0KPiA+PiBzd2Fw
cGVyIHVzaW5nIG5HIG1hcHBpbmdzIikgdXBkYXRlcyB0aGUgbkcgYml0IHJ1bnRpbWUgaWYga3B0
aSBpcw0KPiA+PiByZXF1aXJlZC4NCj4gPj4NCj4gPj4gQnV0IHRoaW5ncyBnZXQgd29yc2UgaWYg
cm9kYXRhPWZ1bGwgaW4gbWFwX21lbSgpLiBOT19CTE9DS19NQVBQSU5HUyB8DQo+ID4+IE5PX0NP
TlRfTUFQUElOR1MgaXMgcmVxdWlyZWQgd2hlbiBjcmVhdGluZyBwYWdldGFibGUgbWFwcGluZy4g
SGVuY2UNCj4gPj4gYWxsDQo+ID4+IHB0ZXMgYXJlIGZ1bGx5IG1hcHBlZCBpbiB0aGlzIGNhc2Uu
IE9uIGEgQW1wZXJlIEVNQUcgc2VydmVyIHdpdGggMjU2Rw0KPiA+PiBtZW1vcnkocGFnZXNpemU9
NGspLCBpdCBjYXVzZXMgdGhlIDEwcyBzdGFsbC4NCj4gPj4NCj4gPj4gQWZ0ZXIgbW92aW5nIGlu
aXRfY3B1X2ZlYXR1cmVzKCkgYWhlYWQgb2YgZWFybHlfZml4bWFwX2luaXQoKSwgd2UgY2FuDQo+
ID4+IHVzZQ0KPiA+PiBjcHVfaGF2ZV9jb25zdF9jYXAgZWFybGllciB0aGFuIGJlZm9yZS4gSGVu
Y2Ugd2UgY2FuIGF2b2lkIHRoaXMgc3RhbGwNCj4gPj4gYnkgdXBkYXRpbmcgYXJtNjRfdXNlX25n
X21hcHBpbmdzLg0KPiA+Pg0KPiA+PiBBZnRlciB0aGlzIHBhdGNoIHNlcmllcywgaXQgcmVkdWNl
cyB0aGUga2VybmVsIGJvb3QgdGltZSBmcm9tIDE0LjdzIHRvDQo+ID4+IDQuMXM6DQo+ID4+IEJl
Zm9yZToNCj4gPj4gWyAgIDE0Ljc1NzU2OV0gRnJlZWluZyBpbml0cmQgbWVtb3J5OiA2MDc1MksN
Cj4gPj4gQWZ0ZXI6DQo+ID4+IFsgICAgNC4xMzg4MTldIEZyZWVpbmcgaW5pdHJkIG1lbW9yeTog
NjA3NTJLDQo+ID4+DQo+ID4+IFNldCBpdCBhcyBSRkMgYmVjYXVzZSBJIHdhbnQgdG8gcmVzb2x2
ZSBhbnkgb3RoZXIgcG9pbnRzIHdoaWNoIEkgaGF2ZQ0KPiA+PiBtaXNjb25lcm5lZC4NCj4gDQo+
IEJ1dCB5b3UgZG9uJ3QgcmVhbGx5IGV4cGxhaW4gKndoeSogaGF2aW5nIHRoZSBDUFUgRmVhdHVy
ZSBkaXNjb3ZlcnkNCj4gZWFybHkgaGVscHMgYXQgYWxsLiBJcyB0aGF0IHNvIHRoYXQgeW91IGNh
biBieXBhc3MgdGhlIGlkbWFwIG1hcHBpbmc/DQoNCkFkZGluZyBuRyBiaXRzIGNhbiBiZSBhdm9p
ZGVkIGJ5IGhhdmluZyB0aGUgZGlzY292ZXJ5IG9mIGJvb3QgY3B1IGZlYXR1cmUNCmVhcmxpZXIg
c2luY2UgdGhlIG5HIGJpdCBoYWQgYmVlbiBzZXQgaW4gUFRFX01BWUJFX05HL1BNRF9NQVlCRV9O
RyANCg0KQmVmb3JlIHRoaXMgcGF0Y2g6DQoxLiBrZXJuZWwgd2lsbCBmaXJzdGx5IGNyZWF0ZSBt
YXBwaW5nIGluIHNldHVwX2FyY2gtPnBhZ2luZ19pbml0LT5tYXBfbWVtDQotPiBfX21hcF9tZW1i
bG9jaw0KMi4gVGhlbiBpZiBrcHRpIGlzIHJlcXVpcmVkLCBrZXJuZWwgd2lsbCBhZGQgbkcgYml0
cyBmb3IgZWFjaCBwdGUgZW50cnkuDQozLiBJbiBleHRyZW1lIGNhc2UsIGUuZy4gcGh5c2ljYWwg
bWVtb3J5IGlzIDI1Nkcscm9kYXRhPWZ1bGwsIGFuZCBwYWdlc2l6ZQ0KaXMgNEssIHRoZSBuRyBi
aXRzIHVwZGF0aW5nIGluIHN0ZXAgMiB0YWtlcyBhYm91dCAxMHMuDQoNCj4gSSdkIGV4cGVjdCBz
b21ldGhpbmcgdGhhdCBleHBsYWluIHRoZSBwcm9ibGVtIGluc3RlYWQgb2YgcGFyYXBocmFzaW5n
DQo+IHRoZSBwYXRjaGVzLg0KPiANCj4gQW5vdGhlciB0aGluZyBpcyB3aGV0aGVyIHlvdSBoYXZl
IHRlc3RlZCB0aGlzIG9uIHNvbWUgVGh1bmRlclggSFcNCg0KSSB3aWxsIGZpbmQgYSBUWDEgYXMg
eW91IHRvbGQgdG8gc2VlIGFueSBkaWZmZXJlbmNlLg0KDQoNCi0tDQpDaGVlcnMsDQpKdXN0aW4g
KEppYSBIZSkNCg0KDQo+ICh0aGUgZmlyc3QgdmVyc2lvbiwgbm90IFRYMiksIGFzIHRoaXMgaXMg
dGhlIHdob2xlIHJlYXNvbiBmb3IgdGhpcw0KPiBjb2RlLi4uDQo+IA0KPiBUaGFua3MsDQo+IA0K
PiAgICAgICAgICBNLg0KPiAtLQ0KPiBKYXp6IGlzIG5vdCBkZWFkLiBJdCBqdXN0IHNtZWxscyBm
dW5ueS4uLg0K
