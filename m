Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CD5268DF7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbgINOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:39:25 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4084 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgINOij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:38:39 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5f805b0003>; Mon, 14 Sep 2020 07:38:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 07:38:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 14 Sep 2020 07:38:32 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 14:38:32 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 HQMAIL101.nvidia.com (172.20.187.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 14:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODBxlYbcX8TO17iRWc2EJJDVseFdE2tUTwl7YAkFC1DJAg25fqf5s4CdtgQPNi9TLNgQ5blRKuwbxbCUdYuNkB/6uh4+N/AItBExWwxGoFDXKUjsZvvrNviBfW44TvP2Cj/o8dRkcEl8sI91/396b8D8hykevJbC3sIwTBWw1oa9EjE73h1qZhHdfscnevUYB59E1hvRT3FLAgWa9zwTq8JNCCb2gkqtq67nr+AIP+ublfimWnAkoH6nvtEvUU0rUpdjayoYr1zEdzOVhlgX/jk1Fsg2TmCYKIC1aEZS/unN6W2gW8f4RJai2K7thcMQxiCygDRshBn6NP5AwcBp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y424OEM+rDsuVQAP/OPev6tnQJj5kOVa1XOyU8zde/w=;
 b=AlQg7A2ijBpkfr0Iyh3qmIZ+FNsW7khsfsfUxUs8Tnjg7D7pHLPfTc0DyCHQcneoPvVooumS76pWCkgRZwZ9k2huHdK30WUgEBd5Qn8QYbCZbvX7ngrvnSR/sIIBIUaiFZNyNj3UYegI0pcaPl/UXf/pQjTz5KTWxEFWtRM0AmN+CBqwagYKBaj86NyOrtvwbIdSDKUYXCAVlrFcuSbuKManXl5y5WkqDhbPt878dqqiIs23RNfjqOUlxVK5BXv+4/mF54DCSh7Vx38SyIEVeXbxcd+NI6wKbNY5sm1++m1oTIv/EzTXubM8vDqpnusfSge/sRWa2eDltNM+jc0TYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 14:38:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 14:38:31 +0000
Date:   Mon, 14 Sep 2020 11:38:29 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200914143829.GA1424636@nvidia.com>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200821234958.7896-2-peterx@redhat.com>
X-ClientProxiedBy: CH2PR17CA0029.namprd17.prod.outlook.com
 (2603:10b6:610:53::39) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:610:53::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 14:38:30 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHpcj-005ygP-Kp; Mon, 14 Sep 2020 11:38:29 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47dd8966-ccaa-4e3f-2fe3-08d858bbd9bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB31149FD746E50A207C708082C2230@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JfT5aCwg7NTNFSbBDJva/dqIXmaVLRxqAZs66iUi6yktHgEveoQNHUzR80JrnUDWYOQMOlvErIhmO1AyyVfzHU284KSbnG3dNPBg6i/6gB3Pdof8+4B7Laxu8fGF0pHJBdeP12yNEa6NFVG8JdV0AGeWUPMrou7cp4ApPtIi4WBBYxsnAHYr5EcQxI+Vqymx8lhj3DglO+tUJ89DjuTc9G7fCSY3jMxuj7NZ+Sltbg8oKqI0wRLRGO1s04P94Hu9d3NeCSoGEZyL3G8Y39a8ghldCN7kT5yq6kw0Sp0XUcRG/EEQR9Ta3Wq/sAR5EdUnvCxru9rIIp/A2+kXiFWnIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(26005)(7416002)(316002)(33656002)(8676002)(8936002)(83380400001)(36756003)(186003)(54906003)(86362001)(110136005)(4326008)(9786002)(9746002)(478600001)(5660300002)(4744005)(2616005)(66946007)(1076003)(426003)(66476007)(66556008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: wlswMPesSJkNzKc9wjLjn/0Va1gmbusPDWhRCuW206uZIDnZDK60hXQZBz1ECydS3v7Od5dI8A5vRoDD87+67bRF+GPn/sBlrCR7z7C8yVCxWfdi2WijIuPLC5wEdsyeA6FiaAsIXC+8f3X2LcuAaSLL8u0U11E5dOQxV/0SMyktFYtMhiw3E5LaaEwkm8nBzmWMJAITWkxftNnFd9cQEQJnNtX4d7uER81bfqg9my0FyUCgPIPOPCX2bUkikv5ENXKWigHIxyvIBXU9FgyrXbuduN+C/O+FU/EcOTLtTcGIpZMzI0stpveJCf2pYJvNefgHxpregbA6mmFB9RbZCgCLqQojFAdrTNKDXh6EMEY3LRC5LW+IjuXeVrkQ5pOXRptcSfAaJ5GmPc28YhGaTr1iwzmOAPDfeLNv5mzK7h1X1bugs7ldBlvGpGxfoLJzJ0gVwo8AL44Df//LIqAF8XKDvUh+8DA3elBMOyRkzKRcmda8qEffe46U2KcELEB5kb0F7dRnilrgZ7UBVRenbVJ+UlmayWImVWPx50JwwEji+MkaCYmIpZpxQO+CJ45MDdzJGDHz9EKR2hHFpXtGT0AEsNUN1dtxS52UW42ne5SRTQVi6xBK1KbkXYA+N8dIvgBc45amQYOZSiOYTi19nQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 47dd8966-ccaa-4e3f-2fe3-08d858bbd9bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 14:38:31.0861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KdYJDy+QSZk2T551d8Ic+u3TegtIcusQM597eMyS05BiW+xcx2twplWoeQ/9uEQ+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600094299; bh=y424OEM+rDsuVQAP/OPev6tnQJj5kOVa1XOyU8zde/w=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=WPwy59YK73hKNoWdWVNFT7btv0OEGdauPQEAkFjEAPSGfkb3k4Fm2/tGuhg762KIL
         uitR0oIkn48u1l375ZpOUl/awXFihj88siUa5elQD7eCdCLcg+lCyxGcsTsDcxdObn
         /tvO9KviLydhgKp7l+XVvUA1BSKk4C5mqNiwWb7J8aNJsgEHzkuvcg7qcEN9p1wkuX
         +twLMQT3lHSMoawp9aST3Sd2q73Tq0HVLLnvAuzmCPfRgsVC4MZ2yHsI4MvCR4IaWh
         7UQ2fYgblAFgBZs0EeP5byjzZHu4aH0776cTuFKHdL688luajHu4/dL2NrX1Cmmykj
         BGlNFFmGI8tBw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 07:49:55PM -0400, Peter Xu wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> How about we just make sure we're the only possible valid user fo the
> page before we bother to reuse it?
> 
> Simplify, simplify, simplify.
> 
> And get rid of the nasty serialization on the page lock at the same time.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> [peterx: add subject prefix]
> Signed-off-by: Peter Xu <peterx@redhat.com>
>  mm/memory.c | 59 +++++++++++++++--------------------------------------
>  1 file changed, 17 insertions(+), 42 deletions(-)

I don't have a detailed explanation right now, but this patch appears
to be causing a regression where RDMA subsystem tests fail. Tests
return to normal when this patch is reverted.

It kind of looks like the process is not seeing DMA'd data to a
pin_user_pages()?

Thanks,
Jason
