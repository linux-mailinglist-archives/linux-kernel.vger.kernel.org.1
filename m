Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC328DC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgJNJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:13:53 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com ([40.107.7.115]:53981
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726323AbgJNJNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUk4P5IdJkiHxJ6iynyMbcb4IlLISNHKYRPNJ1MpTo4SkuMHevJ9uBFXSj4r+87eW73Q+ibJc6Iwh06/kE7V8KZ2FoHF2EGRMABOSFcHr4Sj3DJIfqSXrj5iadJ4Tc0pMncRT827j5j/m+sVXV7ULYedrNoWVdvQbPShHMq9uMbUa+pnI5qYm3IXZ6kHwHZuNHsQGWXOvXJBtD6F071/GaSBFcZtXOGVIXzfvDyk+UpYQjhRSEF6MIqxeG+THH01dG6GAGhsmiKMHtx+kC6un3pOg0zCUzlhYbq3T/CXGKggU27SUT/AN+CSxfm+pFQqlJJ9Fj1pzcF2GOmNIzuCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzt3MHncyHrB/3Zd7u5FgwVDWa7p8tiIJ/9U8pw6YFM=;
 b=ZvVQl6Y1+/2MSySwxXe6ItPbGMMTiVy057n3w1WHIKU10wIgDxrKk0iYFTaKe/+ECC+ZSQyprKxAdTTg6Iur9fD8XjQCbgs/PnVPHMczjMPmJNf9zoQ36FcQfdMDv01L7TsljkSMqq8eBLqMT03ULOLXBU9Ar/I7mI3LVI9bInoHpsLoJZhbswA8H4JF5pfZx5hYn48F6FgNo37l1XPyyJchFn8rKGt1ZdA/p47rEMZD6uEL8qWw3ArumA2aDtQqFWWtslIXme8mB0GJbJ1y3/Im18WDiqzYksZ2PLDpe+2MEloxRkjyqFmvoqbuhjh6pwgNRdmkrJP/xY2BqzpdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzt3MHncyHrB/3Zd7u5FgwVDWa7p8tiIJ/9U8pw6YFM=;
 b=YFLS0orOCs9tbUoA4Xlcc9ah+ow4QVy0KoYRhAwZhI0TL6alZXZXTE5qNZMRxxHgIZfJvgggot8G+6C/brPr0R7LbP+TtEwq3MvPfXyoArACx/cMMM9WaMNZCQvcvBv9NMNSkNkPrvDdtMSWyxDYCfOrzbfhhQlhD4l6j/AdeOA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4348.eurprd02.prod.outlook.com (2603:10a6:10:43::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Wed, 14 Oct
 2020 09:13:41 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::9178:a26c:c1e1:636b%4]) with mapi id 15.20.3477.020; Wed, 14 Oct 2020
 09:13:41 +0000
Subject: Re: using one gpio for multiple dht22 sensors
From:   Peter Rosin <peda@axentia.se>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <91c25030-d5d1-e3e7-2d26-ac631dddc756@rasmusvillemoes.dk>
 <1c0d4c55-1d76-8256-ac45-6e0e150309d9@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <bf643eea-f1c0-663b-c12d-21b9081dadc8@axentia.se>
Date:   Wed, 14 Oct 2020 11:13:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <1c0d4c55-1d76-8256-ac45-6e0e150309d9@axentia.se>
Content-Type: text/plain; charset=windows-1252
Content-Language: sv-SE
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.229.94.207]
X-ClientProxiedBy: HE1PR05CA0142.eurprd05.prod.outlook.com
 (2603:10a6:7:28::29) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.13.3] (85.229.94.207) by HE1PR05CA0142.eurprd05.prod.outlook.com (2603:10a6:7:28::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Wed, 14 Oct 2020 09:13:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17e379fb-f21c-4f46-1b50-08d8702171bc
X-MS-TrafficTypeDiagnostic: DB7PR02MB4348:
X-Microsoft-Antispam-PRVS: <DB7PR02MB434846E5302FEAC0A488C5ECBC050@DB7PR02MB4348.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58CRx/GNwwubStzaYLdjGaVZjfBVDTqWehpM9wfGNCNPEBozXJevNPCbwqzerYPbO2G6Qd2JyS5h3fEMmCW592ThpewYySra6ttAgRFnmDpVjkKsiW/j2yMuPNgf76OXipsfUYH7GvGxgmAWhFTWe6iec8OD5pYHnTvNmNZnGl7W45rK7O9S4rsyeaISKNNw3GQeoFf4t6ZbtLaXJM0vm6CzZDB0dnJfPjCnt3OFsTAb4ITrW0LqgDfsPJ3mu8RT+fNlIWpiSo1SdC6cg/ERubT6lGeM6Ip3Agv5ptvjJga/6hTAefizBeYwlDqDox66WSmh05XqDBKw2lALbvT5pfpmVRaeIcnNYXiWxD3Ya1ffUqDrOWEuwvN30diO6VEU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(366004)(396003)(376002)(346002)(6916009)(956004)(5660300002)(478600001)(66946007)(8936002)(8676002)(86362001)(2616005)(4326008)(558084003)(6486002)(4001150100001)(66476007)(52116002)(31696002)(36756003)(31686004)(53546011)(66556008)(316002)(16526019)(26005)(186003)(2906002)(16576012)(36916002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: G+gt4jqy5KawJytVXWHmeMYNYCFG53fpuYl5HSnuOC8fU9gLccx3pavrdhj9iGQq8/UnwyktgvvRGXWZeqf+Oywgm6RFebqyFm+KM03na497b6EqLMPneStd1VfWMfLoe+1yyA6pmtNziL6wltbKb3W2qYHsUBuUd8X2HFJviAFY7nxGzCMhg8pCWtFuBNmnAjUQSVz5GTivI4eMUHTKoUq7vvBTSWIZasd87dt1BmlVOA3XdpYKAOgmLvPTETPx3vxBBGHOJvrYlbfvnXwqCMwVtbmlZtgoOP35w9GxDenDB5RgTRCdFYRqqD+8FGhEyQHUFj2PJG7UEuuPoUBR8V3k+zByqwG64nwABYy6zCVjU8E3vGzGh38hlYuLuPUMaFkW3F7TmSFy93PGd1E7JVnQnp5Zxi2lXV8ETJlTrmydX2ONK6UbLL/0Et2iHXR8V2otooMmE3CI7fhVCwNBxO9kIGXp+OHT8hZeLTdOnRfr39VycN50xdqPlY8kLvl/3zs07kDqiFGU34Dv4rrEirkj3rvBa5n86v1m/4TQtt1B1obrE7JzvBGzyTegY4xqjxExp9O/uZDMUPp4jyeaaCOOJ4UP5cecqnWLMEChjbT1Etc2WTOj2anXLDovaaZpMF2XjDx/m6f/jyxNgb4t8A==
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e379fb-f21c-4f46-1b50-08d8702171bc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2020 09:13:41.9088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPUZTqcG0Nhm0ImXVzNh3m66FM2XzSCDOZw/OTkQnW/KYpXF9tVhMNM58Jse7SkM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4348
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 11:12, Peter Rosin wrote:
> Hi Rasnus,

Rasmus.

*Blush*

Cheers,
Peter
