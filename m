Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604B52E020A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgLUV03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:26:29 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7346 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgLUV02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:26:28 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLL7SfH013411;
        Mon, 21 Dec 2020 13:25:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FHXNtaC9kGyEZEDAcZtZlLND/nK/xQVbxcwJp7KMbWg=;
 b=Hj1jg872Losv8lSoGKWZdRmPO48TMVAJJBa8YTf2cjHiDwijOmQSd+KgtSHznso7eH9w
 ZGG6EB3qE2/V5j4D3WsoKjmyj/F21qwjDqZus1+NX0gBD0ZNUSxpKwx4dY/OguoNGjlt
 oP8fYJhK82KHGIwtLC7oImABAGPOwvMVpoY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35k0ev93c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 21 Dec 2020 13:25:25 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 21 Dec 2020 13:25:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ry7gWgqXi4MW8SVrYBHnBgrhsGNhCbocvmf639d7u6goefHBIxVC1Jq8IUe2j3Edy6rYIbxnrIUB+rsDxFbBQTNKY9J3s1FZ12q9byuo7LY1BrZ7vB2kIl0cqGvKCkXhIRu2Fq1UBuBOqOfO5GEl9mfZqDkJb/3Cwu33kSgSeSHpeL5wmy7JizoWXLkQWrd4O/G5GbHyx6RLDMFnFsDEEHWey7iSTPNqzBYGrhQQiSMarACzPvpEd0kntqp1gHX554KnZ1pjDT+Qfp6DA/TRbbaE/xCOUwuUxXpqvpSNhDGNeDzFagxrBDPK6dBKc+HEMth9PT8fomhaYukGHr3fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEeKbj3K0V4n55Mvl/Aa2QH3NiOn4EQreaWMoTvOCAE=;
 b=Bhd+9SN0AUAPRSJNTWT1tQ2tVwJQuScvz8ZBlrfeCiNTSY6O320SfmhvRtgT389R1fY2m4EHC+LQ2KJ0b6wl18VsUU5ON8L+9s3f+KFcSSVq+erAAVlDa7xv2MN+Zu0vRmAYtP/f1bie8/YKZyLfX7C/UyrzLd1hAMp06D6TVol30g2RJwG75ZRNe/JVzavlKPIrGWnGKGkaJc86uP7i6OliS1yV+9mtJEBLIB+45cdI6iF/2Wrm7H3t806xc7fZQVgHHpGrMtvhcrlizA33Wp8dK9p0IhX42VDV45SdlgJn/z3HtlBiOyGnGXwvDqFBRD6Fxw9cTQQzdkgS6ZdubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEeKbj3K0V4n55Mvl/Aa2QH3NiOn4EQreaWMoTvOCAE=;
 b=Q+jLvISJpqzYwHB3F+pQDhFvFpv14T64DqPuUs4QsucFoJ9BY9PbtgDlwmUUjUMP2wKE42JpIuR46+KnN54GIR0KH7dPkS8qK92SrDsZW4BymGBh3zqnJKk1AL8GlbifKb52s1KCq4EOM0y6UQU2d7LX6qHvjxGPN2ZPaQ9kBpQ=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2343.namprd15.prod.outlook.com (2603:10b6:a02:8b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Mon, 21 Dec
 2020 21:25:24 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3676.033; Mon, 21 Dec 2020
 21:25:24 +0000
Date:   Mon, 21 Dec 2020 13:25:19 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <syzkaller-bugs@googlegroups.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: INFO: task can't die in shrink_inactive_list (2)
Message-ID: <20201221212519.GC3428478@carbon.DHCP.thefacebook.com>
References: <0000000000000340a105b49441d3@google.com>
 <20201123195452.8ecd01b1fc2ce287dfd6a0d5@linux-foundation.org>
 <alpine.LSU.2.11.2012211128480.2302@eggly.anvils>
 <20201221203344.GG874@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221203344.GG874@casper.infradead.org>
X-Originating-IP: [2620:10d:c090:400::5:9d5d]
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:9d5d) by MW3PR06CA0029.namprd06.prod.outlook.com (2603:10b6:303:2a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Mon, 21 Dec 2020 21:25:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6b7c555-1062-420c-0625-08d8a5f6eddd
X-MS-TrafficTypeDiagnostic: BYAPR15MB2343:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2343ABC18A2C3FC21C4893ADBEC00@BYAPR15MB2343.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JHhxxuYyhXKg7GJmgW6tSuvhtxddYiRizQIttbX+q0nKIlE/j6pRc4wpUtw6Bk7TShErfy6zX6gtqt9phhoNsQMiOXtC+nheNwWsvyXMaoeAR5oS4qpQQdtSHDG68Uw7hvTvQuhle3/MPKUBzLhbOJMmV/vDwElM8bKqBsdR0ms/CofBIt9qrWCLzjp6COhTU0CdQiVesMfvSUNeP4xnubgoIgFyr/Gb4V+3VYiu+64e+yVA7bMskYoFKoiJZCMK/PoPLPLagObCBHK+v320tUEAL8iiS7KLoo8K5I5gk45LLh2fZxpAA+Q1VNvsy85WkKvLTzQMK6aLVUtGsHDvFrXM5eYONe/ZxjSPKu7g40cS1qW6qqNmttgTWtJnmMiboOpNLoZoCMWZB74p99mLXT7HUp/PLyyWxuQrtWuIPUG30DL+MgWihcRltbhAOMRKntT4VS1S/JZHQL2+5ae2kDBxwInCRbtaCAQNFN1vXVPNLAQZf8VZgJjlIrwouYV1SkafSUHvb/Io5mHsES97lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(366004)(136003)(376002)(8676002)(478600001)(6916009)(86362001)(55016002)(6666004)(186003)(16526019)(4326008)(1076003)(54906003)(33656002)(8936002)(7696005)(66476007)(966005)(66946007)(9686003)(83380400001)(52116002)(6506007)(66556008)(2906002)(5660300002)(316002)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?74r8EhaQ0Fat73EhIIYl1DKyri+XhyWYkHcIT0zeGcoPBoAJISn3OD3VvpSC?=
 =?us-ascii?Q?xJOaafNnGpU8p5blT9pyiDjrangF+Hfyu8Nwt4xILK7GqmhuOix1Qxsd4qmM?=
 =?us-ascii?Q?BMN3Rvbw4Ez4sB38vCrA6nkDjpd8V6XYCTZVgCSZaC2IDudbdg1wiRvAoYC3?=
 =?us-ascii?Q?BMLggE0051H74Y8DQ2nYeXmtnBpOJPRi8O19zihOVPypfJuVuPVD4IPnIGRp?=
 =?us-ascii?Q?9qL19jdQiJnHBCucw7VXHzgdzuimodjNGbmKrVkMMBGVNfQadPWGYzhp8FCX?=
 =?us-ascii?Q?0UJ2QpogoNBDwmWxYV4SftKeHzbyxOGbVFpfi1Mt45h0Lx9sFED6J/vTggp9?=
 =?us-ascii?Q?P2CtB/IuzsXp4q8KA3fS0BSZy2KO+u8nQwiNNvL+IqWVLVGXy6VDEnaOSZuG?=
 =?us-ascii?Q?g5HV9PsieyacY/p0rX7Q3qaUW2V8wsoWup2bNg/e5jJsWOoZ/7g+wovAmv12?=
 =?us-ascii?Q?+c/OA0IBnpAqRDHGmRK1wzu8VcgF9u/vFPxpIE67BEVMuFBRIq5kMvOUNynN?=
 =?us-ascii?Q?+5z6Qzx30cPi4lQ2poxogTOoGuWofqPlvewDklU2hKUbcTdBw2ePx+RH3nja?=
 =?us-ascii?Q?0iWmbCoPq1zBfN3z34vwyJDkanJ+7GaUQSVcWFxQQ9/caprWkR5iJsNfrm8z?=
 =?us-ascii?Q?O6xAzCZ92ReOQMAeJCMVrq2WWQZgAJtuqkFD9OmEU8Wq4dz9VLKfecOBtRsx?=
 =?us-ascii?Q?U6KpVbJPmFD+2mxNVKIAtcw9YYxZwp+ZlLzVGTJb0ojMKvTS5j0MLawzxPi9?=
 =?us-ascii?Q?5p/ud3spkj0iulU7euQ1gvBOLbHcyduVB5xnmFX/WDEVsHD8Ut3dBoVUZmID?=
 =?us-ascii?Q?CFG9QXkqbbzuTh9lq0r1q98PzhX/eNAyicX34LrCR3B42VY2Th8R/WIaTGAv?=
 =?us-ascii?Q?UQbhiCITXbRmSR0wVNcMNBgSQ4/2+yBlNTzRVzNuxOqpreVT1SLmbzPP8MBm?=
 =?us-ascii?Q?rWYGMLc/S9/wzt4FJE5FKGo6fPzvduamZ0wFA4EI5t2NHhWTLarnMf2VZgCs?=
 =?us-ascii?Q?VoN1W2S6oTxKFNOLst4oX+Vt3w=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2020 21:25:24.3374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b7c555-1062-420c-0625-08d8a5f6eddd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CBQXUCK+vb1bB6Qe3ZnINiiOLEibTpbxYcE57j1LicBpGFIBUVnmE71HS1UR98g4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2343
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 5 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_11:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012210144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 08:33:44PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 21, 2020 at 11:56:36AM -0800, Hugh Dickins wrote:
> > On Mon, 23 Nov 2020, Andrew Morton wrote:
> > > On Fri, 20 Nov 2020 17:55:22 -0800 syzbot <syzbot+e5a33e700b1dd0da20a2@syzkaller.appspotmail.com> wrote:
> > > 
> > > > Hello,
> > > > 
> > > > syzbot found the following issue on:
> > > > 
> > > > HEAD commit:    03430750 Add linux-next specific files for 20201116
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=13f80e5e500000 
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c4c3f27041fdb8 
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=e5a33e700b1dd0da20a2 
> > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12f7bc5a500000 
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10934cf2500000 
> > > 
> > > Alex, your series "per memcg lru lock" changed the vmscan code rather a
> > > lot.  Could you please take a look at that reproducer?
> > 
> > Andrew, I promised I'd take a look at this syzreport too (though I think
> > we're agreed by now that it has nothing to do with per-memcg lru_lock).
> > 
> > I did try, but (unlike Alex) did not manage to get the reproducer to
> > reproduce it.  No doubt I did not try hard enough: I did rather lose
> > interest after seeing that it appears to involve someone with
> > CAP_SYS_ADMIN doing an absurdly large ioctl(BLKFRASET) on /dev/nullb0
> > ("Null test block driver" enabled via CONFIG_BLK_DEV_NULL_BLK=y: that I
> > did enable) and faulting from it: presumably triggering an absurd amount
> > of readahead.
> > 
> > Cc'ing Matthew since he has a particular interest in readahead, and
> > might be inspired to make some small safe change that would fix this,
> > and benefit realistic cases too; but on the whole it didn't look worth
> > worrying about - or at least not by me.
> 
> Oh, interesting.  Thanks for looping me in, I hadn't looked at this one
> at all.  Building on the debugging you did, this is the interesting
> part of the backtrace to me:
> 
> > > >  try_to_free_pages+0x29f/0x720 mm/vmscan.c:3264
> > > >  __perform_reclaim mm/page_alloc.c:4360 [inline]
> > > >  __alloc_pages_direct_reclaim mm/page_alloc.c:4381 [inline]
> > > >  __alloc_pages_slowpath.constprop.0+0x917/0x2510 mm/page_alloc.c:4785
> > > >  __alloc_pages_nodemask+0x5f0/0x730 mm/page_alloc.c:4995
> > > >  alloc_pages_current+0x191/0x2a0 mm/mempolicy.c:2271
> > > >  alloc_pages include/linux/gfp.h:547 [inline]
> > > >  __page_cache_alloc mm/filemap.c:977 [inline]
> > > >  __page_cache_alloc+0x2ce/0x360 mm/filemap.c:962
> > > >  page_cache_ra_unbounded+0x3a1/0x920 mm/readahead.c:216
> > > >  do_page_cache_ra+0xf9/0x140 mm/readahead.c:267
> > > >  do_sync_mmap_readahead mm/filemap.c:2721 [inline]
> > > >  filemap_fault+0x19d0/0x2940 mm/filemap.c:2809
> 
> So ra_pages has been set to something ridiculously large, and as
> a result, we call do_page_cache_ra() asking to read more memory than
> is available in the machine.  Funny thing, we actually have a function
> to prevent this kind of situation, and it's force_page_cache_ra().
> 
> So this might fix the problem.  I only tested that it compiles.  I'll
> be happy to write up a proper changelog and sign-off for it if it works ...
> it'd be good to get it some soak testing on a variety of different
> workloads; changing this stuff is enormously subtle.
> 
> As a testament to that, I think Fengguang got it wrong in commit
> 2cbea1d3ab11 -- async_size should have been 3 * ra_pages / 4, not ra_pages
> / 4 (because we read-behind by half the range, so we're looking for a
> page fault to happen a quarter of the way behind this fault ...)
> 
> This is partially Roman's fault, see commit 600e19afc5f8.

Hi Matthew,

Lol, I had a hard time to imagine how I managed to break the readahead
by my recent changes before looking into the commit:  it's from 2015 :)

I wonder how a __GFP_NORETRY allocation is causing a 143 seconds stall.
The loop in page_cache_ra_unbounded() should in theory be easily broken
on the first allocation failure. So it could be that (partially) because of
the unrealistically high ra limit the memory is becoming completely depleted
and the memory pressure is insane.

Anyway, your change looks good to me. I'll ack the full version.

Thanks!
