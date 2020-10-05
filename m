Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08711283D02
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbgJERFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:05:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12288 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbgJERFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:05:24 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095H3YmL023211;
        Mon, 5 Oct 2020 10:04:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=4CxWEO4LBhVhQvs7dXx8pUoBBe+kpJ4bcieqg5qjaO8=;
 b=oiapQ1VCk8MyjrA+JCcxw2SHm1mhBSB1NfGHSzQ8NMa5U42zyz2Fff8KdmQpjN6YgsYe
 ucJsd8T0x+Sir1oo1QqXgHvzKzpoFJoSyleAAfhmF6PqV7Kk6FVJPKiyGAhbFc2Zpu8o
 +sMf37N0V+mEPw04I8bfVzvL1ZUONeo7W/Y= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33y9jnnjdq-17
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Oct 2020 10:04:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 5 Oct 2020 10:04:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SP/lOMfZ/B+FC/pCSbLZeV3lLuLElGKhc0K1qXe/QpVvwqOLacxq2A6JIBqC4Sd0KOD5qo/F1vS25v9G7VSGGKIsbTMHkjGjnoqj6VqGh7EpxNlPvCGYhS7FSDIoWBFjRNB3n6geuTf9HBA4J0KdtXYkA7whMD9+0EwsjeIyoRx4OSGIdvD3lJDUXXspjhV3YGiQDh5yh3hgljY2GKHE5Ncgb+SRNN1Egkb9UsxlUJraRVfTnSJgf3ZMF6F9ZN0Tc6cpsbZWA1fiCPbwH8cZWcCb2Spodhwxx4ULNSL2/WcQx5bNhY1zEH0xAk+oGmyoByRYpfmCccxUxO0w/PJi9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CxWEO4LBhVhQvs7dXx8pUoBBe+kpJ4bcieqg5qjaO8=;
 b=nMWWnLf4Rbt7g9lbok2oApzHMb6xejNglpcRXvsRxP1Bq+iPvn92f/FED9PQNbWJ2DOGVoS2qiQpSPxGbmF7hvbHBsOeaGLCSl6lJ0r8Y9rw9Fx7PyhKfNKvIbZ1c7yii4m5tCSyZW/2UUEXermianvgoTKzYN9L2iOsPMakmXeTicdlonLmxPDvvCe70d0vX3W9qz+AWIFW31n2mwPWg68zIRzcqJ9mkp8bt8k/lp8ieaa5IrotTSqGj7e4ltdueQl2KKUPYlYYkB0qSOqfBu2wAe0oTVQYLr6/umvhPBpCvP8yNzDL6hvlW4ugi9gmEdWQpo6ige9q6UPhww+GfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CxWEO4LBhVhQvs7dXx8pUoBBe+kpJ4bcieqg5qjaO8=;
 b=f6k3DfwIWrDRPgOE8wkiFjvjoztW4FLU0tbBb/N0VL0RVR5vxiOz/hYPZWy4yRjx3cAsk99joHjlWoA/FZW8J2WoPxYxoggJTqBx8bsLI4+FxW9luE5wNPPN5h/xGDcejBU5acxzCXMgifusBlCR+SUDzewMUUCSWbJLi+00wyo=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR15MB2302.namprd15.prod.outlook.com
 (2603:10b6:805:19::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Mon, 5 Oct
 2020 17:04:54 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 17:04:54 +0000
Date:   Mon, 5 Oct 2020 10:04:48 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Message-ID: <20201005170448.GA2990415@carbon.DHCP.thefacebook.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <20201005155553.GM20115@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005155553.GM20115@casper.infradead.org>
X-Originating-IP: [2620:10d:c090:400::5:e6f7]
X-ClientProxiedBy: MWHPR14CA0058.namprd14.prod.outlook.com
 (2603:10b6:300:81::20) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:e6f7) by MWHPR14CA0058.namprd14.prod.outlook.com (2603:10b6:300:81::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Mon, 5 Oct 2020 17:04:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b02c9527-11b7-41f1-6d04-08d86950c79e
X-MS-TrafficTypeDiagnostic: SN6PR15MB2302:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2302E514FCCF4384C26FA507BE0C0@SN6PR15MB2302.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S3xK28JxPJiGW/r8H+bnJEx6UlXppLeVO05LXNHTcobx+GvE2hxiI7aqAFl/LXuJmRF8zoKhBwQRHG9DOWNVqxAxy8+YoWThJF5xbsAgGdWak3yK/TGp8kdzGVvaY6cBsGj8iIgnwJJSTlelJNgaUoR25QOZ/0EsbpEYJLbzQfaX3jbWrIo8oc0Pbl0urLBtymeyuQOOUglOqm0e898vym0qzuLbMnataNRcXpPnwsTbe5vsX5ESHOVqOW/uBnnjhzGuwQCE1P4dN5lD23MZSF5TJ/jRNfzIfPPaC3H9vx6mH6s8S1vzzM7sYX8838v8Ch4J+JfBnX0SgP//NZBN4r8o6A1vaYtZuu92I05IND7tVWCVt9kgPSR79KK6zjsWfRPhHDNY7Xm0+w/OV4shsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(376002)(366004)(136003)(346002)(4326008)(83080400001)(7416002)(66476007)(66946007)(16526019)(186003)(6916009)(316002)(9686003)(86362001)(66556008)(54906003)(33656002)(2906002)(478600001)(8936002)(83380400001)(55016002)(8676002)(5660300002)(53546011)(6506007)(966005)(52116002)(7696005)(6666004)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: b6YMHcCsOnJ0txFnuS7Pj7JEVdIt5s1SFvagEeRjQP3Te+Yhi6OxC8RtacmN+jGN0gmW1VgD/TaDvlMzHJVSTzbDLo94J+Oc5TNt7dYS3DPJzOx0DSV447w4w3QkTS6f3cCeemmcM/lmPBJY9rd1HemEnOMYMGh8DLsuSVjXtb+GNscN5/4uj+P8iKE1DAh+5oKjmH0PlCi9UjcMMiwYuxAjFCAkSh6qt8wWo0STx73sjSXLWi3z0if6Bk+CNvXBLFPDyMpxQorVjL4Y8b2K/Lr+Ihs7dmuofmN+hfb9C8GiaBuitBT/SxSQUPN2qmXJg+wRP2j64waZqv/Ibg5h8XzpOn7kZWzFAvN/YmfWiBpBTpdU3HyGynE6AZpg5MFndMYt6tuuxrvPJvghbs9g9NULNPe8G2AAOkUGdOab2zxQ4ucEQ0tNO8QOFHnJ1+ZYjd8cd0TkL1j2qaC2sSkmCrMmLe/iQloEvTdtZeiXkte2xAmw/RUYz4sBFRr0AKQlKDYqTtYLGPmPC1orIIukEM5P+JjPmfJMXWXRTrCLOtPsiI/8pAbjLMsGy1jGPSYTI09bs7T23Z+Xl1+2LfQc0Q5r8bLtaS7zFxrKbngCsu7qyheB/I0AvW8+4tast8o0k1wwRjqfCGLg0jqfHZfFT/70xvcjLzZd6FToEETOYgU=
X-MS-Exchange-CrossTenant-Network-Message-Id: b02c9527-11b7-41f1-6d04-08d86950c79e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 17:04:54.3532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk84duGVC1NFV2JO0TwlMSN5n9cWIWVoLWnlIj9ePcLf+QxKE+3A1THl6B6rDOEg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2302
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_12:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2010050126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 04:55:53PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 05, 2020 at 11:03:56AM -0400, Zi Yan wrote:
> > On 2 Oct 2020, at 4:30, David Hildenbrand wrote:
> > > Yes, I think one important feature would be that we don't end up placing
> > > a gigantic page where only a handful of pages are actually populated
> > > without green light from the application - because that's what some user
> > > space applications care about (not consuming more memory than intended.
> > > IIUC, this is also what this patch set does). I'm fine with placing
> > > gigantic pages if it really just "defragments" the address space layout,
> > > without filling unpopulated holes.
> > >
> > > Then, this would be mostly invisible to user space, and we really
> > > wouldn't have to care about any configuration.
> > 
> > I agree that the interface should be as simple as no configuration to
> > most users. But I also wonder why we have hugetlbfs to allow users to
> > specify different kinds of page sizes, which seems against the discussion
> > above. Are we assuming advanced users should always use hugetlbfs instead
> > of THPs?
> 
> Evolution doesn't always produce the best outcomes ;-)
> 
> A perennial mistake we've made is "Oh, this is a strange & new & weird
> feature that most applications will never care about, let's put it in
> hugetlbfs where nobody will notice and we don't have to think about it
> in the core VM"
> 
> And then what was initially strange & new & weird gradually becomes
> something that most applications just want to have happen automatically,
> and telling them all to go use hugetlbfs becomes untenable, so we move
> the feature into the core VM.
> 
> It is absurd that my phone is attempting to manage a million 4kB pages.
> I think even trying to manage a quarter-million 16kB pages is too much
> work, and really it would be happier managing 65,000 64kB pages.
> 
> Extend that into the future a decade or two, and we'll be expecting
> that it manages memory in megabyte sized units and uses PMD and PUD
> mappings by default.  PTE mappings will still be used, but very much
> on a "Oh you have a tiny file, OK, we'll fragment a megabyte page into
> smaller pages to not waste too much memory when mapping it" basis.  So,
> yeah, PUD sized mappings have problems today, but we should be writing
> software now so a Pixel 15 in a decade can boot a kernel built five
> years from now and have PUD mappings Just Work without requiring the
> future userspace programmer to "use hugetlbfs".
> 
> One of the longer-term todo items is to support variable sized THPs for
> anonymous memory, just like I've done for the pagecache.  With that in
> place, I think scaling up from PMD sized pages to PUD sized pages starts
> to look more natural.  Itanium and PA-RISC (two architectures that will
> never be found in phones...) support 1MB, 4MB, 16MB, 64MB and upwards.
> The RiscV spec you pointed me at the other day confines itself to adding
> support for 16, 64 & 256kB today, but does note that 8MB, 32MB and 128MB
> sizes would be possible additions in the future.

+1

> But, back to today, what to do with this patchset?  Even on my 16GB
> laptop, let alone my 4GB phone, I'm uncertain that allocating a 1GB
> page is ever the right decision to make.  But my laptop runs a "mixed"
> workload, and if you could convince me that Firefox would run 10% faster
> by using a 1GB page as its in-memory cache, well, I'd be sold.
> 
> I do like having the kernel figure out what's in the best interests of the
> system as a whole.  Apps don't have enough information, and while they
> can provide hints, they're often wrong.

It's definitely true for many cases, but not true for some other cases.

For example, we're running hhvm ( https://hhvm.com/ ) on a large number
of machines. Hhvm is known to have a significant performance benefit
when using hugepages. Exact numbers depend on the exact workload and
configuration, but there is a noticeable difference (in single digits of
percents) between using 4k pages only, 4k pages and 2MB pages, and
4k, 2MB and some 1GB pages.

As now, we have to use hugetlbfs mostly because of the lack of 1GB THP support.
It has some significant downsides: e.g. hugetlb memory is not properly accounted
on a memory cgroup level, it requires additional "management", etc.
If we could allocate 1GB THPs with something like new madvise,
having all memcg stats working and destroy them transparently on the application
exit, it's already valuable.

> So, let's say an app maps 8GB
> of anonymous memory.  As the app accesses it, we should probably start
> by allocating 4kB pages to back that memory.  As time goes on and that
> memory continues to be accessed and more memory is accessed, it makes
> sense to keep track of that, replacing the existing 4kB pages with, say,
> 16-64kB pages and allocating newly accessed memory with larger pages.
> Eventually that should grow to 2MB allocations and PMD mappings.
> And then continue on, all the way to 1GB pages.
> 
> We also need to be able to figure out that it's not being effective
> any more.  One of the issues with tracing accessed/dirty at the 1GB level
> is that writing an entire 1GB page is going to take 0.25 seconds on a x4
> gen3 PCIe link.  I know swapping sucks, but that's extreme.  So to use
> 1GB pages effectively today, we need to fragment them before choosing to
> swap them out (*)  Maybe that's the point where we can start to say "OK,
> this sized mapping might not be effective any more".  On the other hand,
> that might not work for some situations.  Imagine, eg, a matrix multiply
> (everybody's favourite worst-case scenario).  C = A * B where each of A,
> B and C is too large to fit in DRAM.  There are going to be points of the
> calculation where each element of A is going to be walked sequentially,
> and so it'd be nice to use larger PTEs to map it, but then we need to
> destroy that almost immediately to allow other things to use the memory.
> 
> 
> I think I'm leaning towards not merging this patchset yet.

Please, correct me if I'm wrong, but in my understanding the effort
required for a proper 1 GB THP support can be roughly split into two parts:
1) technical support of PUD-sized THPs,
2) heuristics to create and destroy them automatically .

The second part will likely require a lot of experimenting and fine-tuning
and obviously depends on the working part 1. So I don't see why we should
postpone the part 1, if only it doesn't add too much overhead (which is not
the case, right?). If the problem is the introduction of a semi-dead code,
we can put it under a config option (I would prefer to not do it though).

> I'm in
> agreement with the goals (allowing systems to use PUD-sized pages
> automatically), but I think we need to improve the infrastructure to
> make it work well automatically.  Does that make sense?

Is there a plan for this? How can we make sure there we're making a forward
progress here?

Thank you!
