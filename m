Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52E5269944
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgINWzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:55:55 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:7812 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgINWzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:55:51 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5ff4f40000>; Tue, 15 Sep 2020 06:55:48 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 14 Sep 2020 15:55:48 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 14 Sep 2020 15:55:48 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 14 Sep
 2020 22:55:48 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 14 Sep 2020 22:55:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxYfeh1Z5/GUY4yqaQP1z4b8l+qv5RafkKgYfinLScogoil3pizLDJlfHU1zyRQITDhSTzO2RRqkxvH86Itaw2aReRIq4QHGky7xBYzKohIDUlNWIMUlDkIecwRfz7xfiN3BDmgziNT4MDz7ABF6oDLQj5n7slIY7htqfCA/ctaqylHJeWmVdQW7avWhedObI4Kk3ByS8UywZ2cwEd50L8e3rFRqhnHIMGIbqt+Yzh6NYwqtSmoiqyT8qRR+0CoJ//N0fR5xFQ48GaNR/PQdZ7BXbocMvsFLTghZ5toSI2+4CnERrt6eBv/1LRwZsoT15pK2JHSf6/KbUKJd59MbDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BU6JOoY6t7txud03RmK8uln3t9178vTydHneT9/zD/0=;
 b=CbrlQka5f5jLg8Xmhg2pirYsaj+lJCNeNrojo58+ork5dveL08VWTFLZP7M4MBeYAUEa7m2d8PTTYJJnf3YYiKocmVqAiA8NMysK4yZujXN3ZGWX2MpnQRuyPbwR8I+CqzNb3m+u3u+1BCqiVGKNvW8tpIlZzvpmvWede/VOK+dQhqiaDyFqrxCtU+5/2alPjuEqQ3P8V17mL8jpeOxWRrSG4DhCpK2u/fsxcQFQ89B0ewFYFebZeN+yAPVMxi3f42oU0gxvSSAd94WnckFT2sDy70XOaxCF81XQIq98Zn+PvN4/mpDgFzHeMcmcDaHOMWz8jJoPGaK8Gmz4zxj/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1241.namprd12.prod.outlook.com (2603:10b6:3:72::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 22:55:46 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 22:55:46 +0000
Date:   Mon, 14 Sep 2020 19:55:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Leon Romanovsky <leonro@nvidia.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200914225542.GO904879@nvidia.com>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-2-peterx@redhat.com>
 <20200914143829.GA1424636@nvidia.com>
 <CAHk-=wj1EDd3dUGz_992_oRqvsy3LGDvxvyQBvutLhBqkYqgcQ@mail.gmail.com>
 <20200914183436.GD30881@xz-x1> <20200914211515.GA5901@xz-x1>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200914211515.GA5901@xz-x1>
X-ClientProxiedBy: YQXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::30) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YQXPR0101CA0017.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 22:55:45 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kHxNu-006H58-VI; Mon, 14 Sep 2020 19:55:42 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a45d0037-fc51-47a2-6cc6-08d8590150a7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1241:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1241F65F485DA1EA82CF8336C2230@DM5PR12MB1241.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mM8ueRWMwftr/WVRQ1dkGJR4yIf52vNiYU1PrU7w3K5vod2wkKh0fgd9ApbGY+++TzIcOuuTg1lmLlJ3RWqmhdMtw3iVA/Cbqd96hhjEruh7cixamyCcHecYkQ8essn8SkO1OmJnb14IglhdJsVf+HlFYkSIcgasrLKSNNWAtXbVlgc7LYOk74VTc7hMYCloLxe/Dm1NUJEl47wqUNg/dwEtal7nX5ZZ11pPScl0fkYDEv02giwldPmNBvywBwmL+q2a1Lde6wfG4OlQE7A5FIyaduY7amL0IVd9XrMXGHO0fxm4D6NULK7H2+zh3Ras6JCy6u7G6fC8Abh3IrPJiSDcTTfKqyqye/m8cgQuHx74pLtOCCIlPLV3vQ4okmBZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(4326008)(316002)(86362001)(54906003)(2616005)(478600001)(6916009)(33656002)(9746002)(9786002)(7416002)(66946007)(426003)(83380400001)(2906002)(8676002)(36756003)(8936002)(5660300002)(66556008)(66476007)(186003)(26005)(53546011)(1076003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: oAfSeMkdx6/ZCTnk+9XWFVrDtBv2CSpL44bnR5VE41fdcrpvFdWYS2CY4B2ZMVlGDgJ2wA3hbwsYyIrRknFjJTbsyFbcQ4IijSjRykP1N41oBsbqn0DgTmxF0/Ueg9ghoZ3UlZ2/PqNXyR57xOo82Wh5vw86SkBuC0s4MI4IrxTtnu3N5jE/OzU0He7YioVOHYKU9hCswrUEkYTdoDl6J1v2fxQe+erMrxcHf5GUbt0d1RikPyiyzYmXtlS3CbzmGhDyQpG4r2ZQxJU0uUwRF83iGy8hYdgw0XYx+vZeJulsZuBjmgs1QfuA21QbriRTF3R8fAe1ERcGP63w77Rcn6tkPYY+SG/VzoZMCoNAlzNZnvMWa6hD++fKuyyZwTKVwvHVtwjNCSMcH7BFEZoWywFDj3BMnlOBkxSnw1qBXuuVFkzwwaca2aI6rbFFve62t/InDw38ObY5ZcTShTf3unWze3TrRMduc41myBj2fdHe4dplJ17HQzFXdC/HZuY3J/y3/nzvTTLPLBVNFn2rMjw0oysi161MynqDGU9/D3lD5tF7cyX1F9klW/DqFPoxptZKAkodpcQ7PQCW9i/lKB8QZ0gbP/I6zwKSoRjfCJczvy55DhfUwLmVhjfMit4c8hOZ1PdHCDg7TERDf9esJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a45d0037-fc51-47a2-6cc6-08d8590150a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 22:55:45.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsDESgaFLcDu5hvYXrMRnLFWEAlpOV8imhuUqtVdHXYtNEgAKM3dl/LVS/NeiiGA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1241
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600124148; bh=BU6JOoY6t7txud03RmK8uln3t9178vTydHneT9/zD/0=;
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
        b=i4kUg96LnK52cSZ98DrETpJSRvoH5EySu8Vx9nKg96qi//HVQJduQH/WuyrQDIBW7
         nA+3RGS3Lxxi7EqAjVPD+RoEnwrPEg0It17fhsL9YQfNYsoZMDQHp7YwKmB/IU5fbC
         O9pHTti2m0fyzpkBKjh4zZLt6SAE7aCpQ987RNFrMnjjB/kfDEjfK4CCDGApSxjkC0
         7X2Ph5APF1pvKwC2AOhiaRe7nxxFD2gsqKIWhYuUDNa6zh1DTbhEZCvtHMgGI9+MMf
         YRH5Vv06prbonSsfX5EJWryI0xKLyyoYbsT/yMLpbTpp84XDLHKReULpFhytHDZ16r
         GmClTAs4IROhw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 05:15:15PM -0400, Peter Xu wrote:
> On Mon, Sep 14, 2020 at 02:34:36PM -0400, Peter Xu wrote:
> > On Mon, Sep 14, 2020 at 10:32:11AM -0700, Linus Torvalds wrote:
> > > On Mon, Sep 14, 2020 at 7:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> > > >
> > > > I don't have a detailed explanation right now, but this patch appears
> > > > to be causing a regression where RDMA subsystem tests fail. Tests
> > > > return to normal when this patch is reverted.
> > > >
> > > > It kind of looks like the process is not seeing DMA'd data to a
> > > > pin_user_pages()?
> > > 
> > > I'm a nincompoop. I actually _talked_ to Hugh Dickins about this when
> > > he raised concerns, and I dismissed his concerns with "but PAGE_PIN is
> > > special".
> > > 
> > > As usual, Hugh was right. Page pinning certainly _is_ special, but
> > > it's not that different from the regular GUP code.
> > > 
> > > But in the meantime, I have a lovely confirmation from the kernel test
> > > robot, saying that commit 09854ba94c results in a
> > > "vm-scalability.throughput 31.4% improvement", which was what I was
> > > hoping for - the complexity wasn't just complexity, it was active
> > > badness due to the page locking horrors.
> > > 
> > > I think what we want to do is basically do the "early COW", but only
> > > do it for FOLL_PIN (and not turn them into writes for anything but the
> > > COW code). So basically redo the "enforced COW mechanism", but rather
> > > than do it for everything, now do it only for FOLL_PIN, and only in
> > > that COW path.
> > > 
> > > Peter - any chance you can look at this? I'm still looking at the page
> > > lock fairness performance regression, although I now think I have a
> > > test patch for Phoronix to test out.
> > 
> > Sure, I'll try to prepare something like that and share it shortly.
> 
> Jason, would you please try the attached patch to see whether it unbreaks the
> rdma test?  Thanks!

Sure, I'll get back to you

> Fast gup is not affected by this because it is never used with FOLL_PIN.

? What is pin_user_pages_fast() then? That is the API the failing test
is using.

> Note: hugetlbfs is not considered throughout this patch, because it's missing
> some required bits after all (like proper setting of FOLL_COW when page fault
> retries).  Considering we may want to unbreak RDMA tests even during the rcs,
> this patch only fixes the non-hugetlbfs cases. THPs should still be in count.

People do RDMA with hugetlbfs too.

Just as an aside, the RDMA stuff is also supposed to set MADV_DONTFORK
on these regions, so I'm a bit puzzled what is happening here.

Jason
