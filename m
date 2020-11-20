Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7182BA072
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 03:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgKTCa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 21:30:56 -0500
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:52961
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgKTCa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 21:30:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrq4kEg+cPOBxIFRoCjNuW1dJM8mIceNgfOSdaxBMq6Gnz6V7YauH5kbszrQ1m3OsONcvc8mvSy8QIv6EeYnmoCommfKtsLna5+Cl9l28QFSXVdTOreeZuZBetj7wZDQMhh339EnKnu/K1Fyb6MhNetvT/WmJ7+BZ24UccUgsYbxpPET/+p085kK+YTpXqqzjGhjKNZAcv+R1hdFNMveAbGbXqltdF1DLPY5xNdyn1deIv/4PDko/LJ9ExFb8JPN9iqF8ysq+9vZOVOktd4F6Bza5f4GUIh/pP9+t8TDCqm4Eto1gZ7tT8htLchs0cwGvIK60ypEZDyDmqM9lNmrmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb0aS4BYL2t41RuexeDswoWLeLWLeO4Q+Wox9xjRUJQ=;
 b=PN8S4JA/miLoAJHNomVqlLmOQ2bI+v119TIajAGjeiyerZ5ryvtT4f3F4c9ylc8ez/xfcQIDT2rwM5dCWiiDxqfnPwOW2xUdmTUEwSbmUhLO6S3uFThznwqpeb1vZ7T02oITqss7lY22XnXub2rdGj7o3yJo7h7K+C5zJUKB2p43xJcB3shbI5fZAM7DTOsE4ube+LY6pfzNZxach90BhaYm3Je4eRqVCIr1UUQMiuBXkGHPDem0gvE4MvbpxqrJSvuJFd8WOGzxY0dY7iU/pnFAzIpVA1SWy1JW5ka74QvBG++ccv93swa2HGHoKf3WOLr7tj+3D9SoLf95EDAW+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jb0aS4BYL2t41RuexeDswoWLeLWLeO4Q+Wox9xjRUJQ=;
 b=ivXvVqRMtvCFvFz2cCbBXmoZpLNoHjMwovBqQyLBzHrRV4iUA5FMyVrG8+6aB22MzBW6eSJtJhHBRM1ar8vSRJDCa48sAQYpaBiHaSs23/i47bXjnCFbxBCpeTu9VRcg+7vozWZqaSS/K9kHIuvEq1O93qgRUAB3wfCN261/Rmo=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3509.namprd12.prod.outlook.com (2603:10b6:a03:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 02:30:51 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3564.033; Fri, 20 Nov 2020
 02:30:51 +0000
Subject: Re: [PATCH v2] iommu/amd: Enforce 4k mapping for certain IOMMU data
 structures
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Will Deacon <will@kernel.org>
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, brijesh.singh@amd.com
References: <20201105145832.3065-1-suravee.suthikulpanit@amd.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <c189684a-27e5-c0c2-1629-063b9fb16957@amd.com>
Date:   Fri, 20 Nov 2020 09:30:40 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201105145832.3065-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2405:9800:b530:f552:3c90:71a9:614d:285]
X-ClientProxiedBy: SG2PR0302CA0009.apcprd03.prod.outlook.com
 (2603:1096:3:2::19) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (2405:9800:b530:f552:3c90:71a9:614d:285) by SG2PR0302CA0009.apcprd03.prod.outlook.com (2603:1096:3:2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.12 via Frontend Transport; Fri, 20 Nov 2020 02:30:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: baad8d94-28b5-4fd9-e0ca-08d88cfc4bbf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB35091098CF6F354062A9409BF3FF0@BYAPR12MB3509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXMgLqTaIIZ6amkLDE/dIr7QtNFqlOVSf/15kBrBm2DEAUlIdYVf8X1EaPDPsbBkUxMy7cfpodkkQIMJaU9zHwGT/vquYlTZhEQ1zk/VREBBMZfCSGe15wXXVlpRU5p1hht3pbnFo73M1hFOZCP6lpaI4NiPOdSp2Klo9sXiwVQtiVvmZCRiYmz8pttUsPEk89CGUct1ktu5DQHPjE5qtrwNTxb0lQSWDBk3hGOxhmjHVBoSlF3s7dQVxlzaWj508dGS3G0p23tuIr+UNgUr2Zoj7OuZDkG6MNk3ddIWZqxEeNjG7a3bym0d7JyvqG64ZYfwyF8ntlcx4yai7crU35fP7cVixqkx7a2XPy2pbvhTDgfCxl7cCIds9GW3rn7GaLaG4/KMAOp+uxos/jh9d7Qb5eWQ3zqa4F7MGUu2cSnFLfCUp04nQ+iZr1jwiSoPa9X9kUcyU4G6fzjOAZkXoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(83380400001)(6486002)(478600001)(86362001)(31696002)(6512007)(31686004)(6916009)(66556008)(66946007)(2616005)(53546011)(52116002)(66476007)(16526019)(8936002)(2906002)(5660300002)(6666004)(44832011)(186003)(4326008)(8676002)(6506007)(36756003)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: MnNUR2faBS3nYJ/HxOVWyAffWke0gXj1daLAbe3fxRUJlQNznmsPD2peMggDyJsU/3w/7JtUpyPak8e/8lC3rUO8aj9a1urasSa4RAJqCNmg7gVZJX5Exjun9hcEJZO3hdwxt8PJw4CLOa0DTvs4WlsjxKDF2vTTjMrXkPPJ4ZTpkGK8fpEdYcvqivq9gBF/UctOgrwLptDko/1TDMB2DMgpwDDpjV1BAanRoEe1+Gw7M/r/V69HXqO9Xi87fUXVpG3FuRSoAB4u19YZpWdqsKZ6B22/Ynr58g98ru7PwJoKv6qEietRc+pytVkUeo12cUHMOMHak29iUR08xVbkRuqPeGCFo0gx9qXbEc0Q6hP8hwXPHdWvGSjT4onLqPz938mGWkDTIk1Bg9D4JnQSQzNHfldFvw7AgMm3ngNOXgiIdwcsRnZ6dxdatlQ4kSLpmYAXuI3UruL5mvH80eaL8c/4NsVA6qy8n8Jhj8e8Q+v15r/uhhyuxVSwiZw3uQwOtF73wZj897AcRzucU6k+es+B6zOJpxX+UNq5RC1uj/c2NSDlIHwAnzKSQ6Wc8bS1eL3KKZuNr1jXMa2/AVk6tX+xBBge+CY1RF8OIBX9WI4QHdtFKX8q8eM0DXYbsGBZkXrD6oKtNYcbW7G9bGVyOi/XNZxnx+KFLd0kep9ddBPnrPICy8qopv5IpZrBLfcMxNrl7ClAc9+W6WTD7T/Q0w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baad8d94-28b5-4fd9-e0ca-08d88cfc4bbf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 02:30:50.7866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPBUYZrH64ehiXZV6pTeZ32E4UYCmGeai8lzPIImzumY9MQ+ZDbLOZsGWaZB9gxeDPkFpyeXvwl/QT+81art0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will,

To answer your questions from v1 thread.

On 11/18/20 5:57 AM, Will Deacon wrote:
 > On 11/5/20 9:58 PM, Suravee Suthikulpanit wrote:
 >> AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
 >> and the completion wait write-back regions. However, when allocating
 >> the pages, they could be part of large mapping (e.g. 2M) page.
 >> This causes #PF due to the SNP RMP hardware enforces the check based
 >> on the page level for these data structures.
 >
 > Please could you include an example backtrace here?

Unfortunately, we don't actually have the backtrace available here.
This information is based on the SEV-SNP specification.

 >> So, fix by calling set_memory_4k() on the allocated pages.
 >
 > I think I'm missing something here. set_memory_4k() will break the kernel
 > linear mapping up into page granular mappings, but the IOMMU isn't using
 > that mapping, right?

That's correct. This does not affect the IOMMU, but it affects the PSP FW.

 > It's just using the physical address returned by iommu_virt_to_phys(), so why does it matter?
 >
 > Just be nice to capture some of this rationale in the log, especially as
 > I'm not familiar with this device.

According to the AMD SEV-SNP white paper 
(https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf), 
the Reverse Map Table (RMP) contains one entry for every 4K page of DRAM that may be used by the VM. In this case, the 
pages allocated by the IOMMU driver are added as 4K entries in the RMP table by the SEV-SNP FW.

During the page table walk, the RMP checks if the page is owned by the hypervisor. Without calling set_memory_4k() to 
break the mapping up into 4K pages, pages could end up being part of large mapping (e.g. 2M page), in which the page 
access would be denied and result in #PF.

 >> Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
 >
 > I couldn't figure out how that commit could cause this problem. Please can
 > you explain that to me?

Hope this helps clarify. If so, I'll update the commit log and send out V3.

Thanks,
Suravee
