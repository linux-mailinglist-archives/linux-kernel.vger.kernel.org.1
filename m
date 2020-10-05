Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D05283F59
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgJETLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:11:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58422 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgJETLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:11:51 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095JBBlZ010657;
        Mon, 5 Oct 2020 12:11:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lA+nDoM5uDOYnYCguR+FbDr26CuQz+PMKQoCDCrXcj4=;
 b=TZBv5yidDIn0m2VjacYP9uwYdrxYwFfT9lQMJhPKSc5ePF9IbvH42ZZZb+oS0gqIy7mX
 7HezYBsCzQ9CWiaB3M7vKnTGdqU1P2QmDQTGtYyXg1BrMf2RmANmbaLLPos0ch8bdaIb
 6XvehRibbYntBk23sLLNgr4Z82SIT8pTvGc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33xq4gryad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Oct 2020 12:11:28 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 5 Oct 2020 12:11:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+ytNpWQrNU0Mb/jcusg1bl8tLL6HT/YFkabjWuRoZNBX5msUqekav2Qf+N4zHZa25GLQ69wHLmaNyuhxhQr4sMBhPy98Jd/hHZdvUqXNpzxOaQ9RDLtUxvbNt7aX9qPS3Fk8tJQCtUcNaVx/9TBLNOzZ6cJmYHgmK/YTOxENwn1CyPaSOq2CVm3BURR48DV/v+SDKesJD2ZbdMhTOaCLYWO8okhca/h8yh6ojwAyOsum3N4AA55GOzmFT7bqzU5tTpkTMlULTyWhFy/9Xsbgn5pHvxvT2Y5fBlFWA8JHpW4b8abc260qWto9A8TdBu+BwpcoYLO4mvP8odUJGeHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA+nDoM5uDOYnYCguR+FbDr26CuQz+PMKQoCDCrXcj4=;
 b=BIba/+K1/7X90ADU0UP56TWdvNBPivPR/Cem+Hx3KWUux3wcM+OOSNhwzZCY0RPGpe52yU0JzVMss/Vcy3tUs/+4gQeA9J+JaRlELReri6NrMCnrSA7V4JBCxMwA/hMh8MWCnEgsi70FpGohFgN6xxYpBw2aCPbEKiaCp8JaTmtCgRZgspwIyZFDnoR0bAmemHAUyu8Wi0TdIt8W8fTGTth7ecjWBaEX2LNrQOsp9VOKh8o3qo5xq0oBx9stsGdAz4pcvSgtcIA70LYKIe8yLngXd7I+CIyCqdMbYmy4bG3SfoitszwlBwujf3SI6EYF5h03brJSnRloCSdgXFTr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA+nDoM5uDOYnYCguR+FbDr26CuQz+PMKQoCDCrXcj4=;
 b=bENhcaZwN2hb7iKpL5M1yKTE4w4IJ/FcTMA/ndOaBO1rmSdkQpOG3jx6pmdAR7I/6YJNlfea9xbMDcRmakQkp2WNLojRFA5cqbL7JQMvORxygZm2d7kTvehLLzbaKEcLyHD29Ccgz5KMOXXYbE4kSL7P8YIblI71jL9n/AUbsfQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SN6PR1501MB2192.namprd15.prod.outlook.com
 (2603:10b6:805:12::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 19:11:24 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 19:11:24 +0000
Date:   Mon, 5 Oct 2020 12:11:18 -0700
From:   Roman Gushchin <guro@fb.com>
To:     David Hildenbrand <david@redhat.com>
CC:     Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        <linux-mm@kvack.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20201005191118.GB3001706@carbon.dhcp.thefacebook.com>
References: <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <20201005171632.GB2990415@carbon.DHCP.thefacebook.com>
 <bb654219-8df6-60a7-3cf5-f886ef5ca565@redhat.com>
 <20201005182518.GA3001706@carbon.dhcp.thefacebook.com>
 <824eee1c-a47b-361b-ad5b-6ed64a9cbd38@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <824eee1c-a47b-361b-ad5b-6ed64a9cbd38@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:1dfc]
X-ClientProxiedBy: CO2PR06CA0065.namprd06.prod.outlook.com
 (2603:10b6:104:3::23) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:1dfc) by CO2PR06CA0065.namprd06.prod.outlook.com (2603:10b6:104:3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Mon, 5 Oct 2020 19:11:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d8b1112-6645-4f7f-49c5-08d869627386
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2192:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB21925ABB62D7E62432CAEA4DBE0C0@SN6PR1501MB2192.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SorxbJVA/USM3VdVHC6m9QTVXfoVwaqGMqtJxW0jDCeRpKIc3trHwEfSGP2fz+scsL4PWRGd9V5iJaoXRfDOGbAwwK2fADA/xalA4Hw91ZesmWeRJ8hHMgnGfSmk6LjsyXggsNmxOGacGW8UTCA5AbbeZBHHRbYMmmA1ELbwiVYwToNam4UO6qXs9NqZke4jKGC0ZoyXW4TT5BmK0cQnBT+MjkvfinXREjCEJH58mX1ugpqRJTNlmnI4vfzbBHmJbKB+Ez5sCXVoVdsLtndWwdB08XQ9PNfgMSU0r7nTC4giO1Wy0Yk3Grf8pcERlLY3ZtZHmD5jzvcm051nW0BPHzPayqxMiwUFzHLgn1+vbB1GRVR0DwsJtJg9KsIS1TUZh9ZeFIizFc4bPNcqCIsoKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(376002)(346002)(366004)(8936002)(6916009)(6666004)(2906002)(966005)(186003)(8676002)(86362001)(16526019)(55016002)(52116002)(7416002)(6506007)(54906003)(1076003)(4326008)(83380400001)(316002)(9686003)(53546011)(66556008)(33656002)(66476007)(7696005)(5660300002)(83080400001)(66946007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: F9UTHkio3WhshCkix/X6PuRl+GFGQSTY3PCB+4HZdP+0Bl+7PVQ/BOgKCIG/U5wISEIGAm1AZSD2QAoq8ksghINXA+GlIQHtrO3xMe33U3idlz7ppvGZeMu7F7mO936exR0cF3HV4Z9cuJbiKInYXFKUiCfFTCcRMqzjQeWCV0phLJIgYoVEXhUxLAzH0LFoNftOfj3ZtV8WsbSyygv2AulSDggBljW26tTGgNrBtWfhQEHI2kpcdoaYXStdFqA72T4DJokX4DS57c+b9E9eJytGRZ1WqbjTZB7q6iWHmYniVBXv5k1ftmcFy/DNgD6JgkjLuCcGskah5Wi0jgJ+tBa2+87ESh2ANbFLIcZk15Uq0kadQ3i8ZaXLnmRj/UbStqthWxgCghgQIWb0oTSh30/JyLr9SbSpyiSgBi0rloSUNkng94WJPuGh5pPaee/Yli967QtCXTWXmRuet8gkA6/PADDoUxr8rT4N7LEp+aHzBTIkxqTqpXGD07dkS1LCqKCPp8KvUBkGhGXF8RzZPoZ2mzL0Xe3EB3BWqH9FpHXYhNZef23Qn3OQfWT8RyNG5uMH9JKxRbConsRu12CH0i+FYs6YnmeyrFjxhy3Mllzrn/ZHOHmDo9rNVfy+11l6V/79rL5T1ZfsSW3Q+K3qum9QoSHPHlyXGWDkWH8iNEo=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8b1112-6645-4f7f-49c5-08d869627386
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 19:11:23.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /d5gDTM+C2rIZX9OQZ4yIwVoSxhx4z9PS5gadil6NzPKezdEVlqxUIGDIXzEky1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_15:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=986 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050137
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 08:33:44PM +0200, David Hildenbrand wrote:
> On 05.10.20 20:25, Roman Gushchin wrote:
> > On Mon, Oct 05, 2020 at 07:27:47PM +0200, David Hildenbrand wrote:
> >> On 05.10.20 19:16, Roman Gushchin wrote:
> >>> On Mon, Oct 05, 2020 at 11:03:56AM -0400, Zi Yan wrote:
> >>>> On 2 Oct 2020, at 4:30, David Hildenbrand wrote:
> >>>>
> >>>>> On 02.10.20 10:10, Michal Hocko wrote:
> >>>>>> On Fri 02-10-20 09:50:02, David Hildenbrand wrote:
> >>>>>>>>>> - huge page sizes controllable by the userspace?
> >>>>>>>>>
> >>>>>>>>> It might be good to allow advanced users to choose the page sizes, so they
> >>>>>>>>> have better control of their applications.
> >>>>>>>>
> >>>>>>>> Could you elaborate more? Those advanced users can use hugetlb, right?
> >>>>>>>> They get a very good control over page size and pool preallocation etc.
> >>>>>>>> So they can get what they need - assuming there is enough memory.
> >>>>>>>>
> >>>>>>>
> >>>>>>> I am still not convinced that 1G THP (TGP :) ) are really what we want
> >>>>>>> to support. I can understand that there are some use cases that might
> >>>>>>> benefit from it, especially:
> >>>>>>
> >>>>>> Well, I would say that internal support for larger huge pages (e.g. 1GB)
> >>>>>> that can transparently split under memory pressure is a useful
> >>>>>> funtionality. I cannot really judge how complex that would be
> >>>>>
> >>>>> Right, but that's then something different than serving (scarce,
> >>>>> unmovable) gigantic pages from CMA / reserved hugetlbfs pool. Nothing
> >>>>> wrong about *real* THP support, meaning, e.g., grouping consecutive
> >>>>> pages and converting them back and forth on demand. (E.g., 1GB ->
> >>>>> multiple 2MB -> multiple single pages), for example, when having to
> >>>>> migrate such a gigantic page. But that's very different from our
> >>>>> existing gigantic page code as far as I can tell.
> >>>>
> >>>> Serving 1GB PUD THPs from CMA is a compromise, since we do not want to
> >>>> bump MAX_ORDER to 20 to enable 1GB page allocation in buddy allocator,
> >>>> which needs section size increase. In addition, unmoveable pages cannot
> >>>> be allocated in CMA, so allocating 1GB pages has much higher chance from
> >>>> it than from ZONE_NORMAL.
> >>>
> >>> s/higher chances/non-zero chances
> >>
> >> Well, the longer the system runs (and consumes a significant amount of
> >> available main memory), the less likely it is.
> >>
> >>>
> >>> Currently we have nothing that prevents the fragmentation of the memory
> >>> with unmovable pages on the 1GB scale. It means that in a common case
> >>> it's highly unlikely to find a continuous GB without any unmovable page.
> >>> As now CMA seems to be the only working option.
> >>>
> >>
> >> And I completely dislike the use of CMA in this context (for example,
> >> allocating via CMA and freeing via the buddy by patching CMA when
> >> splitting up PUDs ...).
> >>
> >>> However it seems there are other use cases for the allocation of continuous
> >>> 1GB pages: e.g. secretfd ( https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_831628_&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=mdcwiGna7gQ4-RC_9XdaxFZ271PEQ09M0YtCcRoCkf8&s=4KlK2p0AVh1QdL8XDVeWyXPz4F63pdbbSCoxQlkNaa4&e=  ), where using
> >>> 1GB pages can reduce the fragmentation of the direct mapping.
> >>
> >> Yes, see RFC v1 where I already cced Mike.
> >>
> >>>
> >>> So I wonder if we need a new mechanism to avoid fragmentation on 1GB/PUD scale.
> >>> E.g. something like a second level of pageblocks. That would allow to group
> >>> all unmovable memory in few 1GB blocks and have more 1GB regions available for
> >>> gigantic THPs and other use cases. I'm looking now into how it can be done.
> >>
> >> Anything bigger than sections is somewhat problematic: you have to track
> >> that data somewhere. It cannot be the section (in contrast to pageblocks)
> > 
> > Well, it's not a large amount of data: the number of 1GB regions is not that
> > high even on very large machines.
> 
> Yes, but then you can have very sparse systems. And some use cases would
> actually want to avoid fragmentation on smaller levels (e.g., 128MB) -
> optimizing memory efficiency by turning off banks and such ...

It's a definitely a good question.

> > 
> >>
> >>> If anybody has any ideas here, I'll appreciate a lot.
> >>
> >> I already brought up the idea of ZONE_PREFER_MOVABLE (see RFC v1). That
> >> somewhat mimics what CMA does (when sized reasonably), works well with
> >> memory hot(un)plug, and is immune to misconfiguration. Within such a
> >> zone, we can try to optimize the placement of larger blocks.
> > 
> > Thank you for pointing at it!
> > 
> > The main problem with it is the same as with ZONE_MOVABLE: it does require
> > a boot-time educated guess on a good size. I admit that the CMA does too.
> 
> "Educated guess" of ratios like 1:1. 1:2, and even 1:4 (known from
> highmem times) ares usually perfectly fine. And if you mess up - in
> comparison to CMA - you won't shoot yourself in the foot, you get less
> gigantic pages - which is usually better than before. I consider that a
> clear win. Perfect? No. Can we be perfect? unlikely.

I'm not necessarily opposing your idea, I just think it will be tricky
to not introduce an additional overhead if the ratio is not perfectly
chosen. And there is simple a cost of adding a zone.

But fundamentally we're speaking about the same thing: grouping pages
by their movability on a smaller scale. With a new zone we'll split
pages into two parts with a fixed border, with new pageblock layer
in 1GB blocks.

I think the agreement is that we need such functionality.

Thanks!
