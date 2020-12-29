Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33D2E709B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgL2MX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:23:28 -0500
Received: from mail-db8eur05on2055.outbound.protection.outlook.com ([40.107.20.55]:54017
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgL2MXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txs29QLkTDu3I7+MObLzTHlM826p6rMfu8FsPagcT6k=;
 b=zq3SHcCUhtEt27fhLW2D6prITfsnExDl1reE6GUrg0rWLcXrQDvjIYFWBS5DfSkTTPLnmepjNlXaq0fahxKQTTWLLSV3AfO6fFgdAuZvX6Z14jkarQufURW/XA6S3vS0MoaAWdqCllFg6nf1X9Y37fNmdYysYbvtlYzPz4pmNTg=
Received: from AM5PR0701CA0002.eurprd07.prod.outlook.com
 (2603:10a6:203:51::12) by HE1PR0801MB1948.eurprd08.prod.outlook.com
 (2603:10a6:3:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.31; Tue, 29 Dec
 2020 12:22:34 +0000
Received: from AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:51:cafe::9d) by AM5PR0701CA0002.outlook.office365.com
 (2603:10a6:203:51::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.11 via Frontend
 Transport; Tue, 29 Dec 2020 12:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT063.mail.protection.outlook.com (10.152.16.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.27 via Frontend Transport; Tue, 29 Dec 2020 12:22:34 +0000
Received: ("Tessian outbound fc5cc0046d61:v71"); Tue, 29 Dec 2020 12:22:33 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5a3d72f38f673c3d
X-CR-MTA-TID: 64aa7808
Received: from 170a74428bd5.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id ADFFD27E-CEEA-4756-9CCC-2A8ABA65AC69.1;
        Tue, 29 Dec 2020 12:22:18 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 170a74428bd5.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 29 Dec 2020 12:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnxaIj5P9rxsoNtwVE85V9YQhE5XMcmmkyoQj0F6jmlQUkf0C+GuuJ3i2f2xrrUcw6wxpOLSNcOIeKXnRoPX6MNpKLDrBXDg3CscueFKlxdsM4ptkNroU/NGshA2O7RlbPqEHScwpFTrwHXZFkz9KKLCAiuEyPgARZHpHz/VvTyZHOk5W3BeRTprnyLjDfIsb6W/CuhrP0YdCu5dG0VP8ojn/BebNmaYvBsQCcKuaEk4BbBFQwWAxd7gN4whEQVy75w73HGYkJaJdW5bccSWXqQk0Kk5c16pc+3Us5B6JAh6IYTP0/WMO0i0YG58EVHAR7zWcpU0Znr5zfegMIFAUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txs29QLkTDu3I7+MObLzTHlM826p6rMfu8FsPagcT6k=;
 b=lspR3jSSn/wsPEi8rO2DrM1KIQJKuHDl7xHnCN8oQWETtqAnF1KHvhp9CwYBpTCkEh2IhVUeqWc/pITGaFHjHyv80goUwd8R51LeK2c1LdqtkoOL/mDa+GCIQw7Ng5wkYt/xTc8yB0VhqSmcxkL5oeUMC3zrC8uJpKZqD6DtCNPXaZDBtp9HxZ9qfjHxxX5rHOtDMnqLop2TenytNhhR/YZy4Ez6cCLUFxHuzFn28wg+yFT6Kqx4ewoh7bByR0DD6Zs302Dq9tQ1eURbMPpvGBFKuaroLleCRAIEAncSBlL7oQzp7BNTygTYkQ7oEjHSA267yIC2jf6lyIFJEVTrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txs29QLkTDu3I7+MObLzTHlM826p6rMfu8FsPagcT6k=;
 b=zq3SHcCUhtEt27fhLW2D6prITfsnExDl1reE6GUrg0rWLcXrQDvjIYFWBS5DfSkTTPLnmepjNlXaq0fahxKQTTWLLSV3AfO6fFgdAuZvX6Z14jkarQufURW/XA6S3vS0MoaAWdqCllFg6nf1X9Y37fNmdYysYbvtlYzPz4pmNTg=
Received: from VI1PR08MB2973.eurprd08.prod.outlook.com (2603:10a6:803:4d::16)
 by VE1PR08MB5774.eurprd08.prod.outlook.com (2603:10a6:800:1a1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Tue, 29 Dec
 2020 12:22:16 +0000
Received: from VI1PR08MB2973.eurprd08.prod.outlook.com
 ([fe80::714d:8ffd:571e:a72b]) by VI1PR08MB2973.eurprd08.prod.outlook.com
 ([fe80::714d:8ffd:571e:a72b%3]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 12:22:16 +0000
From:   Carsten Haitzler <Carsten.Haitzler@arm.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
Thread-Topic: [PATCH] drm/komeda: use bitmap API to convert U32 to bitmap
Thread-Index: AQHW3VHXC7i+0tuLdkuqg5HqDqUHaKoM6q8AgAAFuwCAAQ9vAA==
Date:   Tue, 29 Dec 2020 12:22:16 +0000
Message-ID: <808b7555-5ba2-f1fe-3800-1d5f59c47b52@arm.com>
References: <20201228194343.88880-1-yury.norov@gmail.com>
 <20201228195016.GD4077@smile.fi.intel.com>
 <CAAH8bW9UvDAB4NSQB6CuhBU6D=R6Ex6=5V=Ld74hYGK474_Trw@mail.gmail.com>
In-Reply-To: <CAAH8bW9UvDAB4NSQB6CuhBU6D=R6Ex6=5V=Ld74hYGK474_Trw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
Authentication-Results-Original: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [217.140.96.140]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d209b526-e1ec-4efe-8bfa-08d8abf46bd6
x-ms-traffictypediagnostic: VE1PR08MB5774:|HE1PR0801MB1948:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1948D5F87B654D573C6C053D8CD80@HE1PR0801MB1948.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XU0TTh4yDkxqsUwC2xbZcuVFL8L+E4SGRnKkXAUTh0cQaN8GsfJY4Sp2Km7WP98QiWq90IdEG5y3U3nVvoJxiAqik2RxAQ8Miy/Enpqe0za+b9C4ZH4KuS8xP/3hatpEAlqf6ezGTuonbAGzjEbLDeH9nvtpwDXZBjgL7SBSyxTmFvEWywd8kQ01shYo0s++AfddF+VhdWc2pIlyBbap0LQBH2UTYEpefKSZgUjAbo3PJZHRYUgdwfUT/dYAkhIqdWV5tx09nEhtRk3wm6AKnjHAtpfnMC23s6jIUg2c4xh307AT/FgAiUvfZ1mESEvU5T6cRj2PoqSFQ4sVtSTc20HrH4G6SCrkpryl25BLIflSbfMH15rBKmS1ZLlBoVrDigY5Mus6XPQbTpYE4IvUkv21lCuXzkx1cj3mBL4ZsQttLoThz4VzXWgOQzMeqRSfj11Y2ksjui2LpCvEGTD68eyLVgo6706gERU/2E1G0d4=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB2973.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(136003)(376002)(396003)(346002)(5660300002)(6506007)(53546011)(2616005)(86362001)(54906003)(64756008)(316002)(478600001)(186003)(31686004)(26005)(83380400001)(31696002)(36756003)(66476007)(66946007)(66556008)(76116006)(6512007)(71200400001)(6486002)(8936002)(110136005)(8676002)(66446008)(4326008)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WmdUbU5PZEhQK0lnT2h3NGZnMEdVRHlMZ05pcVdKRVAxSFhMUTdHVnIySElq?=
 =?utf-8?B?SjByYW5jdWhqNDRDRVV6RTZaYUR0Zzhjb01zWVAzeDhPNUlkZWExUGRKTDRW?=
 =?utf-8?B?VG1nMGpscCtua3dmMVp6c2lCUGhlRkVyOGJNNHRjZnlLYnN0cmE5VTQrd3Jj?=
 =?utf-8?B?ZUdrb1N6bXFucmVTR0hYOG5YU2xXbTBidjhMYUR0UnN3cGozbWRFRklFVlBr?=
 =?utf-8?B?aXFvelZ1aVV6YUZEeHNiRU5Cc2x6bi9RdXRtK051NnpiWG5UTVJkNDErYTdz?=
 =?utf-8?B?Z3BBY2NkSXZ2OFgrT0NoZ0pKTlRPdVZoZDlibDNuZk5GRlhSSEFKMjhMV3Mr?=
 =?utf-8?B?d0pSUytQeDlJMEJDZmVReWZ3L2dRRG1BSHF5dGlQQ290RVJtcTRaQkF0Rk9P?=
 =?utf-8?B?UUZhZG50Rm5vemxOUDhaa2NKM1NSVHNLZm1FOVRwc3dFWGxTZGpjL3JScXVs?=
 =?utf-8?B?K214YTZjbGhZanJXWjJrUTdpLzFZRnlDZUJTdC92QjFKbE03STI5aHlaVlJC?=
 =?utf-8?B?QTZMcllzQ3ZHN1RQQU9BazFCQ3NwOE5IeHpscTZUaW0vMTVzT0o1NnFzanYw?=
 =?utf-8?B?VTFrOXZ1aTdNcDhVd0E5MVBpanJBTHplM3VOanFJKytISzMwYU9tT2s0ZU9X?=
 =?utf-8?B?SzMyT05rcXg5SzkyajhEM1Q2dmk3KytobzJnRnluV3E2WGJ1ZVJTNjVoeTFQ?=
 =?utf-8?B?OC93NGh2SnpUdXdxUm9nSjlXMW1YOVNTZDU2ZHk3Q1FJUkZPbDV0RU1sMDdv?=
 =?utf-8?B?dUQ1VmJqcThhdThNalBkRG5sSmh1Tk1MVjVNbGg5aWhYTjJ6TmlVM3FBalQv?=
 =?utf-8?B?M3o3M2p5bnlLbjVNWDM4MEZEVlpocFlmcUNMUjVsRzhYL0ZIWVVhYkthckxL?=
 =?utf-8?B?TU9Yb0hHUTVaY0VDYWFJYjBuVmVPTHBocWRxWTRIVWFKRW5oWGpsZXRKZEtJ?=
 =?utf-8?B?cmgvVGROMzM3a3BmbCtKTEQxQm8rTDNQbFJFUEpNQWUyUzdmcCtPK1JCVzdx?=
 =?utf-8?B?S3hVeUhCVzBBdklnUkE5N095QzBKc1RpQnF3S3FkQ3d4VFcrUXo5REgvcSs3?=
 =?utf-8?B?eCs2SzJ1aWtua250aGpNbE4vc1RaSGxrTjNXbCs5ajh1bHZmQkZPMWpWSlhU?=
 =?utf-8?B?YUE4azVnb2x0TXd3VVRwT3JOTVB0aFRIcWR6M0QrenI1WkFuR2tuUGF0NjhT?=
 =?utf-8?B?MHhteWF0eE5HRjllUHB2d0h6eVp4bFkwMFhRcThzdlpHVHNJSFBlL2MzZWJh?=
 =?utf-8?B?YTRJa2xjMVJ6a1FxRzNVNkdFU1VkTEJYbmYrb2YyeUFtS042bzdvZEduMzhx?=
 =?utf-8?Q?rn6UU1FYuxWNU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC5A5B6D13D6AF47A5FD65E23230F4D2@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5774
Original-Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 05ffedbd-9d1c-4545-fb37-08d8abf46159
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ChtGjNFP0pxzjjACXYVZ6ZjPmyttBHV5DqSlt4l2QBo1DM+rr06IGNBobBTwLPZkF9KRZxVttR/dJM/XYadha6I1OQomS4Nw7U72+58qLzwdx/92APdjiqaBk9DDQr3D9eNR/LManb8II0rny339u59He3EdOvJlycVgoC1S7T4RJPFJtq+Yq+RJ0FPTMdRq6/oqOPMUYZrbfM9hrFfjBjrmOSp5sB445/tX0cDnC/EWBfibmEbVjb6hbnDXlMetGSZRRaBzU7xPV50Hu1ytVDrSkrqyJqxiw3GVZ3knCoeDRuGhzlC8QRKuf4NjwOzlowk/Hn/g6a4YpWc1KaK3DYZ5jvJhIANBjkStaPpGgF1FNSyeKCq8p1+bustmaPrK7NYWsxMtie6FFByyXMyET1WAMS2+efJ3XsTLibVmMba3fVs6ZTy2EJaIu7nzgI3Nvg247Vl2pbWsem8g/uf7lP2yTI6NffvGf9uYFIGE9L+dJ7J5LjxIRFKrEZ5LyWkp
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(136003)(376002)(396003)(46966006)(8676002)(47076005)(53546011)(4326008)(36756003)(70206006)(31696002)(70586007)(186003)(2906002)(26005)(356005)(5660300002)(82740400003)(316002)(81166007)(110136005)(2616005)(336012)(82310400003)(478600001)(8936002)(6512007)(83380400001)(6486002)(31686004)(86362001)(107886003)(6506007)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 12:22:34.1928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d209b526-e1ec-4efe-8bfa-08d8abf46bd6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT063.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1948
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMjgvMjAgODoxMCBQTSwgWXVyeSBOb3JvdiB3cm90ZToNCj4gT24gTW9uLCBEZWMgMjgs
IDIwMjAgYXQgMTE6NDkgQU0gQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPj4gT24gTW9uLCBEZWMgMjgsIDIwMjAgYXQgMTE6NDM6
NDNBTSAtMDgwMCwgWXVyeSBOb3JvdiB3cm90ZToNCj4+PiBUaGUgY29tbWl0IGJlM2U0NzdlZmZi
YTYzNmFkMjUgKCJkcm0va29tZWRhOiBGaXggYml0DQo+Pj4gY2hlY2sgdG8gaW1wb3J0IHRvIHZh
bHVlIG9mIHByb3BlciB0eXBlIikgZml4ZXMgcG9zc2libGUNCj4+PiBvdXQtb2YtYm91bmQgaXNz
dWUgcmVsYXRlZCB0byBmaW5kX2ZpcnN0X2JpdCgpIHVzYWdlLCBidXQNCj4+PiBkb2VzIG5vdCBh
ZGRyZXNzIHRoZSBlbmRpYW5uZXNzIHByb2JsZW0uDQo+PiBIbW0uLi4gQ2FuIHlvdSBlbGFib3Jh
dGU/DQo+Pg0KPj4gLi4uDQo+Pg0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdTMyIGNvbXBfbWFzaykNCj4+PiAtICAgICB1bnNpZ25lZCBsb25nIGNvbXBfbWFza19sb2Nh
bCA9ICh1bnNpZ25lZCBsb25nKWNvbXBfbWFzazsNCj4+IEhlcmUgd2UgY29udmVydCB1MzIgdG8g
dW5zaWduZWQgbG9uZyAoTFNCIGlzIGtlcHQgTFNCIHNpbmNlIGl0IGhhcHBlbnMgaW4NCj4+IG5h
dGl2ZSBlbmRpYW5lc3MpLg0KPj4NCj4+PiAtICAgICBpZCA9IGZpbmRfZmlyc3RfYml0KCZjb21w
X21hc2tfbG9jYWwsIDMyKTsNCj4+IEhlcmUgaXQgdGFrZXMgYW4gYWRkcmVzcyB0byB1bnNpZ25l
ZCBsb25nIGFuZCB0cmllcyBvbmx5IGxvd2VyIDMyIGJpdHMuDQo+Pg0KPj4gQXJlIHlvdSB0ZWxs
aW5nIHRoYXQgZmluZF9maXJzdF9iaXQoKSBoYXMgYW4gaXNzdWU/DQo+IEl0IHNlZW1zIHlvdSdy
ZSByaWdodCwgdGhlcmUncyBubyBpc3N1ZSB3aXRoIGVuZGlhbm5lc3MgaW4gZXhpc3RpbmcgY29k
ZS4NCj4gSW4gZmFjdCwgdGhlIGxpbmUNCg0KSW5kZWVkIEFuZHkgY292ZXJlZCB0aGlzLiBUYWtl
IExTQjMyIHdpdGggdGhlIGNhc3QgdG8gImxvY2FsIG9uLXN0YWNrDQpsb25nIiBhbmQgcG9zc2li
bGUgZXh0ZW5kIHVwcGVyIDMyYml0cyB3aXRoIDAncyBpZiBuZWVkZWQgKDY0Yml0IGxvbmdzKS4N
Cg0KPj4+IC0gICAgIHVuc2lnbmVkIGxvbmcgY29tcF9tYXNrX2xvY2FsID0gKHVuc2lnbmVkIGxv
bmcpY29tcF9tYXNrOw0KPiBpcyBhbiBvcGVuY29kZWQgdmVyc2lvbiBvZiBiaXRtYXBfZnJvbV9h
cnIzMihkc3QsIHNyYywgMzIpLg0KPg0KPiBNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdXNl
IHRoZSBiaXRtYXAgQVBJIGhlcmUsIGJ1dCBleGlzdGluZyBjb2RlIGlzDQo+IGNvcnJlY3QuIFNv
cnJ5IGZvciB0aGUgbm9pc2UuDQpXaGlsZSB5b3VyIGNvZGUgaXMgc2VlbWluZ2x5IGFsc28gdmFs
aWQgKEkgY2FuIGNoZWNrIHRvIGJlIHN1cmUgd2l0aA0KS0FTQU4gaWYgeW91IHdhbnQgc3RpbGwp
LCBpdCBkb2VzIHNlZW0gYSBsaXR0bGUgbGVzcyAibmljZSB0byByZWFkIiB3aXRoDQptb3JlIGxp
bmVzIG9mIGNvZGUgZm9yIHRoZSBzYW1lIHdvcmsuIElzIGl0IHdvcnRoIG1ha2luZyB0aGUgY29k
ZSBhDQpsaXR0bGUgbG9uZ2VyIGhlcmUgYXMgaXQncyBub3QgYWN0dWFsbHkgZml4aW5nIGFueXRo
aW5nIHRvIGRvIGl0IHRoaXMNCm90aGVyIHdheT8gREVDTEFSRV9CSVRNQVAoKSBpcyBhIGJpdCBv
ZiBhbiBvYnNjdXJlIHdheSB0byBkZWNsYXJlIGENCnNpbmdsZSB1bnNpZ25lZCBsb25nIChpbiB0
aGlzIGNhc2UpIHdoZXJlIHRoZSBjb21waWxlciBkb2VzIHRoZSByaWdodA0KdGhpbmcgYW55d2F5
IHdpdGggYSBzaW1wbGUgYXNzaWduK2Nhc3QgbWFraW5nIGl0IGVhc2llciB0byByZWFkL2ZvbGxv
dyBJTUhPLg0KDQpJTVBPUlRBTlQgTk9USUNFOiBUaGUgY29udGVudHMgb2YgdGhpcyBlbWFpbCBh
bmQgYW55IGF0dGFjaG1lbnRzIGFyZSBjb25maWRlbnRpYWwgYW5kIG1heSBhbHNvIGJlIHByaXZp
bGVnZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNpcGllbnQsIHBsZWFzZSBub3Rp
ZnkgdGhlIHNlbmRlciBpbW1lZGlhdGVseSBhbmQgZG8gbm90IGRpc2Nsb3NlIHRoZSBjb250ZW50
cyB0byBhbnkgb3RoZXIgcGVyc29uLCB1c2UgaXQgZm9yIGFueSBwdXJwb3NlLCBvciBzdG9yZSBv
ciBjb3B5IHRoZSBpbmZvcm1hdGlvbiBpbiBhbnkgbWVkaXVtLiBUaGFuayB5b3UuDQo=
