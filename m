Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D9F30364B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbhAZGJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:09:54 -0500
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:32159
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728298AbhAYM5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:57:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9v2apaEGwtlOIYhm79EDOtgG2xthJK6R8joBg4i168=;
 b=5RSvjCg9n9AOqOXFDhiuIWk19fFH4mbGfF7K9z0yfZO2NbJfCCDhigfEiY7nG6FYseQivb1xB6YLBf96iyi8PgHSDWZhJ0u5S9+7m960qX+m67/ZqP89ThmuM8UZSEzSNml7U4pJOm/X3g9f5bgowmpxqpBMwd8fL14Og788Yys=
Received: from DB6PR0601CA0022.eurprd06.prod.outlook.com (2603:10a6:4:7b::32)
 by DB7PR08MB4217.eurprd08.prod.outlook.com (2603:10a6:10:7d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Mon, 25 Jan
 2021 12:55:49 +0000
Received: from DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::6d) by DB6PR0601CA0022.outlook.office365.com
 (2603:10a6:4:7b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Mon, 25 Jan 2021 12:55:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT064.mail.protection.outlook.com (10.152.21.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 12:55:49 +0000
Received: ("Tessian outbound 2b57fdd78668:v71"); Mon, 25 Jan 2021 12:55:49 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 329c2278e514d8e7
X-CR-MTA-TID: 64aa7808
Received: from 944e3224d1a9.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C7C639AA-E8C3-402A-AE54-DEEE62A6097E.1;
        Mon, 25 Jan 2021 12:55:37 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 944e3224d1a9.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 25 Jan 2021 12:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijvS6IqAX/NbWOyTeMpSt89ydOxzxVEdDrvm/cE5KtcuEi7rK5Wwdc+tTkFzbYA1FhLYVhxIfh58EoXKsP05gZ7g5RKnaP/x43/fy8iC9VcbPWfJ7OW1HjL+wPbBSVobBm7E/a7qlUpZ02RZ1sHwJ9xc+iMgRQX0UTbw2IIRVC31akU14c7eL6Zw/Tl3OjftEExnyBd8/HJhkpJN7XqDB89qE3BwH0tyF7hV8kTUGR1gL+kyDcZAz8sBDS7HYGICt+bfelb4vYIa3G+EnnAzvQEVUXqHACWdxSwudS0qmePgATtseDCSrEkZ7ybN58vyXIhkzwi82nxJgb+qcfS8/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9v2apaEGwtlOIYhm79EDOtgG2xthJK6R8joBg4i168=;
 b=Sm1aB3w1N8eDNAkt8TB9W/y+0R2ldxu+4+UHKepXmf2j9kAlE4vDl0+iz25SdcMN/EwKW0OCdogMlLhR72zrw43iHiozRqM9tKN5ReNo+NS6QGeLk60E4akpkAEIky8dIrVnqJ+GMb75qhUHUM5ErINvp13NqFZ2X7k8mLAMHG23TI8nvTKDSJPnyy6bzV3gDHLJqmLumRC319QkFrhP05XPD4aUlNQUfUodwZ4lc0rL3qLyE7dB5lrmtGRZrZn+5Cz3etddW1mr4JAcqErvgUrERWKIeC2BZ5sUOtMbI2ExqQgBgsBGOo/5W9xjwSquqZ7F/T7jpLFYiM0H3rX1QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9v2apaEGwtlOIYhm79EDOtgG2xthJK6R8joBg4i168=;
 b=5RSvjCg9n9AOqOXFDhiuIWk19fFH4mbGfF7K9z0yfZO2NbJfCCDhigfEiY7nG6FYseQivb1xB6YLBf96iyi8PgHSDWZhJ0u5S9+7m960qX+m67/ZqP89ThmuM8UZSEzSNml7U4pJOm/X3g9f5bgowmpxqpBMwd8fL14Og788Yys=
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM0PR08MB4018.eurprd08.prod.outlook.com (2603:10a6:208:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Mon, 25 Jan
 2021 12:55:33 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::5818:5e0e:3bb7:3b70]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::5818:5e0e:3bb7:3b70%5]) with mapi id 15.20.3784.017; Mon, 25 Jan 2021
 12:55:33 +0000
Subject: Re: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with Arm
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Auger Eric <eric.auger@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <a8fd0176-3888-44cf-d659-2e2213a59969@redhat.com>
 <ba4c30b9-1f31-f6b2-e69a-7bb71ce74d57@arm.com>
 <5b0c640a9a22411c840367785c9c23ac@huawei.com>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <057abe6d-5f82-710b-4ec7-5738d6b1483c@arm.com>
Date:   Mon, 25 Jan 2021 18:25:25 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5b0c640a9a22411c840367785c9c23ac@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:c::13) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by PN1PR0101CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Mon, 25 Jan 2021 12:55:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfed5d55-9116-4aac-43cf-08d8c1308a08
X-MS-TrafficTypeDiagnostic: AM0PR08MB4018:|DB7PR08MB4217:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR08MB4217AB4805608811B117339989BD0@DB7PR08MB4217.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: e5TFHhi2BKKxAW44HaueWAzCuo80xnfoFW9wMQI1zCAu6BKHLdYGwUkdvIzsl0rdqJX/yw8vraaYzZhubuaAS3tqQhB87H8RY20wZFjKWtCXgAsGltur0zZEKglC5vtBAjUTyuhInsLMSE9Lfm+FMiXUklXB8SFFgiJEFWuP1u0VrIx7cutnSG7zttXGVu0b+1JRZkjb+IyMRWgcrGJQ/1/OHmkNljvmvNfhC7LyJLT36ISpoP9hf0QDjPwUK+EH8CBQeoOZsZPqcUAyQMTZa2d0CIGQFo/6aNaarbqycrE5yMBCqlfAjeu1+z0KwHhgdnwtcw2kufXid9oYOqhxZKij73sMwviDJWwYjOyC5gA7xpm3ARo53TJv7tUbjdLvoerASlzMPC+xIMdC/wdZqAtHTlBI9PDCrUbNwdTTukDd8CskayAsYjinLi0nXkyqQB7djFIzxCZKkLkhSUY1vhw9NH/EG4sIYThXUxPUI0k1c7MmxFERUNjxiERBnT0IpsXkv8B9v9nhJtS2TLxQLMMfrLF1VX51KdGqdRZSDfIQ8iixOikS0P+0V4jJCxcH
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3268.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(16526019)(4326008)(36756003)(8676002)(6666004)(53546011)(186003)(2906002)(86362001)(8936002)(26005)(31686004)(31696002)(52116002)(478600001)(110136005)(83380400001)(956004)(16576012)(316002)(6486002)(66476007)(66946007)(66556008)(5660300002)(7416002)(2616005)(54906003)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TSsyT045K1JqOFVJb2pXM0tQbXpaUFdBTjYvUmR5TWR5cHo3YjNyVVUzdW5p?=
 =?utf-8?B?ems1bDduNTVDVWthSi9qZW5qVzljRDZhZXdqbS9mTjZPY01jQnRCQUQ2a0dI?=
 =?utf-8?B?QlFhKzg4MlVPQnlVL3hzQmozQ3VMMHJYZ1drNks4YmxqbGE2aVY3L29BZ0lG?=
 =?utf-8?B?cEh0dytmUlQ2VUMweENZUGNRN2ZPeThlSFpzblJlWTZOVENrTHZxOWlHUXhD?=
 =?utf-8?B?MjYrRUV4STIySXZBNHpoS3k5WklYUFFDcHhYRUVrS0lBV2dLcTZZUFdjYkFD?=
 =?utf-8?B?U1VpT1B6RmxidUFvTlFZVEM0VVZwcUxxY2xRREMwK1hqb1NHMklsWEpmWmRR?=
 =?utf-8?B?aUs3dEt6S1ppanFWN2ZyaDFvMFZMdmhsSmVucVFEWlZzV0U1Z2pnNDBEQzJR?=
 =?utf-8?B?bUd5NksxRVVFM1J5d3ZNelVMYVZ1Wi9VK3AxU0FXNUVGSU16SDRzSUxaQ2Z6?=
 =?utf-8?B?UUdLcWdybzg2YlBwdWxROXZJU3d1RW8xMVRzOFNjSnV3RzFqRVVqMHRvSVNx?=
 =?utf-8?B?eW5rdEMza1dhZlk4WnZYcCs3ckszNHpjSDZPWDMyaWhScXVHbzBFaGNEbFM0?=
 =?utf-8?B?b3FzVzBnQlRNc1hCc1l3L2cwWEwxNmZNTlpjUXhuQjhWaDAyYVRERklWZ1U1?=
 =?utf-8?B?U0htaTArdmE4enc4SlQwMzREbk1ScEVLNmlKWmhQa2VCMEsxcUNPemNQWEpR?=
 =?utf-8?B?Uzg0a2pOTm13Z25uc1JDUEJUMUI5di9UOTEzcVdMVHEwOUxsc0tvcEFxbk02?=
 =?utf-8?B?ckdWVlA5RGVVVVpUMU40QkNHSjRRdW5GVk9Vc1g4STdHL1VxaE02WUFhT0Nq?=
 =?utf-8?B?N3pzSXpaMURWRTloUWhWOEJxL29vaWtIYk5USE1Mdkx6Snd5NWxIMXFtaUZv?=
 =?utf-8?B?cm5HYUl0c0x1b0w1dkp6WVZxU3NUOTVERysxdFZYdTlvZkhnYnFFMkwyMzQx?=
 =?utf-8?B?bEhUdTZpUzBpNU5yVkxib08rMG44cmJDaGMrNFY3UFBPYkJwa1JkcHRDMXBl?=
 =?utf-8?B?YmVodXdFelBieVBLK3dlTmVhQ042eHBhOG1FVjFWSkNZOVRMR2RoWWtKb0Vw?=
 =?utf-8?B?NU9xbUFkWnFJQm1zNmNRUHMySkI4WlhJeDB5R2pWUlRMbytjR2lneTJqQkZq?=
 =?utf-8?B?Q094alVMWWt2Mk5jV3RDQVR0QzlNbFlaVzI2aGhKb1lUc0Vjekg0NzdCQmlB?=
 =?utf-8?B?aVl3NElHSit0L3ordDRhdDl5azJQNURHbVl1blZmczlXSW5ab0JEVGZFQUVx?=
 =?utf-8?B?cERJd1JSVm1qa3k4TnZZSDV3T2l6MXUxVTBtRWhrNjRZSklGZHdSUUVoZFpw?=
 =?utf-8?Q?OraVppKurs2kKFfiBlQDhfR/VmgTOYgYL1?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4018
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 33415a94-d36c-4e30-1e8c-08d8c1308095
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XPx/tKNMSgUlXgYDSYEeLrJu44cZK/9ipFj+2o9XxG0Vpwa1ghiE4XgCnr295bkDXe3+Y4Sq2TnkXjomHUivm4zyFVp/+ePRFkn2H7ub1TVIPj1kl2GpyB2NKDKBh0f6BfWSVEWFAUKk3RKnxsnIsS0oAwXBgjW8qrhFJoG+UF0mMNqvb8FvPCV8ZNzrOye6FBK3tRf4n++ihh+s4kHwqr4wt5Gl3uvo/NV05mrIFzzdkvCiPhirqfbw43JjD8xuKOWJyigjIecnqPtV1Rn1rxJQpsbHayv2FmzzCNxAl55QhW1SZGj8j+TDgJdno7lLYAIJAxrBFZRseQFdFQTcLfMP47hJktoerud4Xda18DSMdsxU+CRVF4vsX8mqIHPz5cYU5k+FR+o/C4GDkNXVG+Lt8c8vNBaDbgeHNCkZdKbkbABBiSez3AxQNrv/glqmFdW+GWdMtHy+miljuCmJuMUQ4RZ/RdJFpKzyW9WNTH7ItBBQo4tmgPYxOI9OO+zve14EH9gog7j4xDfWgpEOaiPqn1XiKfiDr7ksw6xWz+x341H6sCtamdgTgTZ+GaLCDyXcKQ0n6oMuxHftJoW4Y8+T7u+2PPoXRhLM+MNSOhqxZEFMY9xsTi7j8o0hmlNHg1aMUFlZ+M6wMkDHQgKksBIJmBGINYz6irc0BiwwEalkByS0Vk5DwBRL3UGpS4zG25YHU4M7WGUNqpjAW1ZRA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(46966006)(86362001)(2906002)(31696002)(47076005)(8936002)(4326008)(6486002)(54906003)(83380400001)(956004)(2616005)(70586007)(316002)(8676002)(110136005)(5660300002)(70206006)(16526019)(186003)(336012)(6666004)(16576012)(26005)(53546011)(966005)(478600001)(81166007)(356005)(36756003)(31686004)(82740400003)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2021 12:55:49.1233
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfed5d55-9116-4aac-43cf-08d8c1308a08
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT064.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB4217
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,


On 1/22/21 9:19 PM, Shameerali Kolothum Thodi wrote:
> Hi Vivek,
> 
>> -----Original Message-----
>> From: Vivek Kumar Gautam [mailto:vivek.gautam@arm.com]
>> Sent: 21 January 2021 17:34
>> To: Auger Eric <eric.auger@redhat.com>; linux-kernel@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; iommu@lists.linux-foundation.org;
>> virtualization@lists.linux-foundation.org
>> Cc: joro@8bytes.org; will.deacon@arm.com; mst@redhat.com;
>> robin.murphy@arm.com; jean-philippe@linaro.org;
>> alex.williamson@redhat.com; kevin.tian@intel.com;
>> jacob.jun.pan@linux.intel.com; yi.l.liu@intel.com; lorenzo.pieralisi@arm.com;
>> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Subject: Re: [PATCH RFC v1 00/15] iommu/virtio: Nested stage support with
>> Arm
>>
>> Hi Eric,
>>
>>
>> On 1/19/21 2:33 PM, Auger Eric wrote:
>>> Hi Vivek,
>>>
>>> On 1/15/21 1:13 PM, Vivek Gautam wrote:
>>>> This patch-series aims at enabling Nested stage translation in guests
>>>> using virtio-iommu as the paravirtualized iommu. The backend is
>>>> supported with Arm SMMU-v3 that provides nested stage-1 and stage-2
>> translation.
>>>>
>>>> This series derives its purpose from various efforts happening to add
>>>> support for Shared Virtual Addressing (SVA) in host and guest. On
>>>> Arm, most of the support for SVA has already landed. The support for
>>>> nested stage translation and fault reporting to guest has been proposed [1].
>>>> The related changes required in VFIO [2] framework have also been put
>>>> forward.
>>>>
>>>> This series proposes changes in virtio-iommu to program PASID tables
>>>> and related stage-1 page tables. A simple iommu-pasid-table library
>>>> is added for this purpose that interacts with vendor drivers to
>>>> allocate and populate PASID tables.
>>>> In Arm SMMUv3 we propose to pull the Context Descriptor (CD)
>>>> management code out of the arm-smmu-v3 driver and add that as a glue
>>>> vendor layer to support allocating CD tables, and populating them with right
>> values.
>>>> These CD tables are essentially the PASID tables and contain stage-1
>>>> page table configurations too.
>>>> A request to setup these CD tables come from virtio-iommu driver
>>>> using the iommu-pasid-table library when running on Arm. The
>>>> virtio-iommu then pass these PASID tables to the host using the right
>>>> virtio backend and support in VMM.
>>>>
>>>> For testing we have added necessary support in kvmtool. The changes
>>>> in kvmtool are based on virtio-iommu development branch by
>>>> Jean-Philippe Brucker [3].
>>>>
>>>> The tested kernel branch contains following in the order bottom to
>>>> top on the git hash -
>>>> a) v5.11-rc3
>>>> b) arm-smmu-v3 [1] and vfio [2] changes from Eric to add nested page
>>>>      table support for Arm.
>>>> c) Smmu test engine patches from Jean-Philippe's branch [4]
>>>> d) This series
>>>> e) Domain nesting info patches [5][6][7].
>>>> f) Changes to add arm-smmu-v3 specific nesting info (to be sent to
>>>>      the list).
>>>>
>>>> This kernel is tested on Neoverse reference software stack with Fixed
>>>> virtual platform. Public version of the software stack and FVP is
>>>> available here[8][9].
>>>>
>>>> A big thanks to Jean-Philippe for his contributions towards this work
>>>> and for his valuable guidance.
>>>>
>>>> [1]
>>>> https://lore.kernel.org/linux-iommu/20201118112151.25412-1-eric.auger
>>>> @redhat.com/T/ [2]
>>>>
>> https://lore.kernel.org/kvmarm/20201116110030.32335-12-eric.auger@red
>>>> hat.com/T/ [3]
>>>> https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
>>>> [4] https://jpbrucker.net/git/linux/log/?h=sva/smmute
>>>> [5]
>>>> https://lore.kernel.org/kvm/1599734733-6431-2-git-send-email-yi.l.liu
>>>> @intel.com/ [6]
>>>> https://lore.kernel.org/kvm/1599734733-6431-3-git-send-email-yi.l.liu
>>>> @intel.com/ [7]
>>>> https://lore.kernel.org/kvm/1599734733-6431-4-git-send-email-yi.l.liu
>>>> @intel.com/ [8]
>>>> https://developer.arm.com/tools-and-software/open-source-software/arm
>>>> -platforms-software/arm-ecosystem-fvps
>>>> [9]
>>>> https://git.linaro.org/landing-teams/working/arm/arm-reference-platfo
>>>> rms.git/about/docs/rdn1edge/user-guide.rst
>>>
>>> Could you share a public branch where we could find all the kernel pieces.
>>>
>>> Thank you in advance
>>
>> Apologies for the delay. It took a bit of time to sort things out for a public
>> branch.
>> The branch is available in my github now. Please have a look.
>>
>> https://github.com/vivek-arm/linux/tree/5.11-rc3-nested-pgtbl-arm-smmuv3-vi
>> rtio-iommu
>  > Thanks for this. Do you have a corresponding kvmtool branch mentioned 
above as public?

Thanks for showing interest. I will publish the kvmtool branch asap. 
Though the current development is based on Jean's branch for 
virtio-iommu [1], I plan to rebase the changes to master soon.

Thanks & regards
Vivek

[1] https://jpbrucker.net/git/kvmtool/log/?h=virtio-iommu/devel
> 
> Thanks,
> Shameer
> 
