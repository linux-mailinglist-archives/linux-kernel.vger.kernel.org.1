Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103E2283E45
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgJESZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:25:59 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40762 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725960AbgJESZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:25:59 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095IPWwo022607;
        Mon, 5 Oct 2020 11:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QbzUutlD/bK6lIFMqoYVfjKuxpi+xT6Z0PZnbVNorDs=;
 b=nfwZU1YNruJMte9UtVz0fi9p9OdWVMhwifDsQMXLdtnhdCU8HGaEVT/f9QpxaNgZ4zse
 voDfcnWVDIUccEdA/Pznl8GZP3y/PexiU4qtqL2842IWv+NqywHNVw3A7Kqm5vwaYe1p
 9yhCAUIroiDefMQDvJSWDl6ZIirvpKvFuEk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33y9c3dy00-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 05 Oct 2020 11:25:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 5 Oct 2020 11:25:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2oGodrj2TnA7WcRwqlLEDXyoGxNpbqLW6y+1nS0+nZDUNQzWWKltPeZG8Csjwc6Qd/TYcBlhdTSNAetd5iREj49hnQwMs7+ySPrQS6zfLx4Y3vUSUCeGlvQnkRqioGnvnW/y07dQcWsKgNe0KiiMAe1ZddPa5TUn/bXfIzLoxRpnn65rYZGVUGHTGWEm2XHVFaidK2BNtv29MuZ6kd9X2i6vEwijTRgF2zlGJ60h8lWOYRBcMEorGXWcDBWgofLS2qw77pULf9hOI1LPwNVtgmQfbkDu+W61/kdQuRoDe5kLAsxr20a/MQcsrCKWgzDhcVt45u0/rOzwxDg7aLXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbzUutlD/bK6lIFMqoYVfjKuxpi+xT6Z0PZnbVNorDs=;
 b=apskMZNHgqB8IQA/AlQPaPyeTeIE6yU9vzbUl34F8wujbHkba+T9AxSpGF1KVFnUdK7gukBjxUjMmUdUFsYLOSRWGdvR0ixPXlQS/eitCsWzJDZFEB0uQYsVIWsgbgV8oVGoDxE31RsGA2EUooXo/ErsKdiHZKrQ3x3/xnQ/DLvlFA2A/Gh/RVALepSK+gxtYUIxfUqwvD8UL/rI7gxJTiEJjB4cpQeTT9xNNiQJdAH1mX1+41/vcRM4YpBs5+LnkoHLld+0cbwneeXGzcyCNWsrdMeSgB+u8UWaKgu3+GyBPfATnkD2leW97ryKZtvxHU99ESN4uTxWvIdU0Ex7Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QbzUutlD/bK6lIFMqoYVfjKuxpi+xT6Z0PZnbVNorDs=;
 b=CmuXeDCqAIo0+EOsJWMLabQosXQbSxPpV6a4Sa1E27gUbt2SkPPC1L+NqRo3SKWo7Zj2Q6+6yV4Qw80365V6ArpE1JiEfWa0zYXVgllkoexcqZyYy7HdbFgWAa3vvXVvd7+7dzYpHK7WTeNq+FIb5qo26SIe7Vf14Uc1vjo1VQY=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14) by SA0PR15MB3774.namprd15.prod.outlook.com
 (2603:10b6:806:89::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.36; Mon, 5 Oct
 2020 18:25:24 +0000
Received: from SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a]) by SN6PR1501MB4141.namprd15.prod.outlook.com
 ([fe80::e1a8:24c:73df:fe9a%7]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 18:25:24 +0000
Date:   Mon, 5 Oct 2020 11:25:18 -0700
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
Message-ID: <20201005182518.GA3001706@carbon.dhcp.thefacebook.com>
References: <20200928175428.4110504-1-zi.yan@sent.com>
 <20200930115505.GT2277@dhcp22.suse.cz>
 <73394A41-16D8-431C-9E48-B14D44F045F8@nvidia.com>
 <20201002073205.GC20872@dhcp22.suse.cz>
 <9a7600e2-044a-50ca-acde-bf647932c751@redhat.com>
 <20201002081023.GA4555@dhcp22.suse.cz>
 <645b35a5-970d-dcfe-2b4a-04ebd4444756@redhat.com>
 <F3606096-EF9F-4F69-89DC-287095B649DC@nvidia.com>
 <20201005171632.GB2990415@carbon.DHCP.thefacebook.com>
 <bb654219-8df6-60a7-3cf5-f886ef5ca565@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb654219-8df6-60a7-3cf5-f886ef5ca565@redhat.com>
X-Originating-IP: [2620:10d:c090:400::5:970f]
X-ClientProxiedBy: MWHPR19CA0078.namprd19.prod.outlook.com
 (2603:10b6:320:1f::16) To SN6PR1501MB4141.namprd15.prod.outlook.com
 (2603:10b6:805:e3::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:970f) by MWHPR19CA0078.namprd19.prod.outlook.com (2603:10b6:320:1f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Mon, 5 Oct 2020 18:25:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a90bfe8f-1161-4acb-dd28-08d8695c06c6
X-MS-TrafficTypeDiagnostic: SA0PR15MB3774:
X-Microsoft-Antispam-PRVS: <SA0PR15MB377409D6EE413EF47B9ACF23BE0C0@SA0PR15MB3774.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rkgz8I0FgXtoneLcba0YIZSxlK7UkCup0K3FEBG2wc/eLBXyKXGYnfMyd8dgkM7pvr5/TCTl7lG4EfVngfjWj2Wj8NBmbU64apDwpsG0O7JXRcHGJ21T4SSo6GCttRpdL2pQnV2y6+bMbwNogxRsYpE12WwdfFFNiDHA/SS9VxOv8/efEDCWaUnQJ7MGZ5pCxA0NMwFTff89PEQLUPxpk410Mv/V2utgoo7YvYLNRRP13zdIEhg/OhJN9Ru85sDXylqKiDSmqPxbsl3WefJQ1fTTDTollux+wbhuiXvd46p6itjjjZhq7+Y/KTlIwdNr1OWy66l5QO0C2ZjlPfynCE7OyACyV/WghobhOzghZT0zjgbrTlQrNuf748jtkoelAnrhsnruXm4jA14wgihtRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB4141.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(346002)(136003)(376002)(4326008)(7696005)(52116002)(53546011)(6506007)(8936002)(16526019)(478600001)(86362001)(33656002)(1076003)(5660300002)(8676002)(186003)(966005)(9686003)(66476007)(316002)(54906003)(55016002)(66556008)(66946007)(2906002)(6666004)(83380400001)(83080400001)(6916009)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Z3GC75Uo0sNmdPFTylgq76praeTnlsk+l+6Pna7CMbGIRCcy2+wS8VMn0GOP53qTUo/UsGmWj3BVftOAnkCKHUYMKj6qyNNSbZYG7FUeWgh76wmM8a6SlICTz1yw0GRet50NYVOoE6uXv8cuebrV8qL13jX9RZjUFOtIkPosJ3GOvoRV4ze3Hb2fdZ/RQxjhX+CyxuNjs0PEDIFp9vdvI8kQluhR47HIgNHRAbdze6ch6TFy+6X5YObua6mdQKkbQ9tHRiAXWKh3gohQAo3pnOuVTVSVtm1BpzU6h5bO3Ph7V2DgN/z7KAyrGqTG3auUPrdxc4/7sNF8BxmwaiSn88ylo8GPn+QKuwmcNqUQ4yVTplQkfCZ8wtmwX7IUErn8mCH3xStqNZtu/o+qu8rXfF0143S/W2mdOq/8JXIvNJcsrYB4rx45wsvIlf9OjnIW89SVh9OGRNpeDpPxKnj2xBdovS/k/Zvxu2FGtxI7bFQxnfzj0QVnY1orxJSCWVUsx1/G4QgAF4Ap31qPYLeWvqvzBp6cRhoP5icd4GDkLOLOjHLjECd4s9KMWrxeUhFF0PG9ScFAERN6U/M4bLfjfZF3BCoIxf5myNtWKZexSo2Al0kEP/f1rGec6C8J8MAHGpmSazL6tkFnzMZT2qRvEPuoOATqB059PbID8nf2490=
X-MS-Exchange-CrossTenant-Network-Message-Id: a90bfe8f-1161-4acb-dd28-08d8695c06c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB4141.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 18:25:24.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujTleExBlRAAmRQ/Gk1iVuhExxgtQLbmPYuGn9LnTO8D85eI+9IjAVEn5GMLm249
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3774
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_14:2020-10-05,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 07:27:47PM +0200, David Hildenbrand wrote:
> On 05.10.20 19:16, Roman Gushchin wrote:
> > On Mon, Oct 05, 2020 at 11:03:56AM -0400, Zi Yan wrote:
> >> On 2 Oct 2020, at 4:30, David Hildenbrand wrote:
> >>
> >>> On 02.10.20 10:10, Michal Hocko wrote:
> >>>> On Fri 02-10-20 09:50:02, David Hildenbrand wrote:
> >>>>>>>> - huge page sizes controllable by the userspace?
> >>>>>>>
> >>>>>>> It might be good to allow advanced users to choose the page sizes, so they
> >>>>>>> have better control of their applications.
> >>>>>>
> >>>>>> Could you elaborate more? Those advanced users can use hugetlb, right?
> >>>>>> They get a very good control over page size and pool preallocation etc.
> >>>>>> So they can get what they need - assuming there is enough memory.
> >>>>>>
> >>>>>
> >>>>> I am still not convinced that 1G THP (TGP :) ) are really what we want
> >>>>> to support. I can understand that there are some use cases that might
> >>>>> benefit from it, especially:
> >>>>
> >>>> Well, I would say that internal support for larger huge pages (e.g. 1GB)
> >>>> that can transparently split under memory pressure is a useful
> >>>> funtionality. I cannot really judge how complex that would be
> >>>
> >>> Right, but that's then something different than serving (scarce,
> >>> unmovable) gigantic pages from CMA / reserved hugetlbfs pool. Nothing
> >>> wrong about *real* THP support, meaning, e.g., grouping consecutive
> >>> pages and converting them back and forth on demand. (E.g., 1GB ->
> >>> multiple 2MB -> multiple single pages), for example, when having to
> >>> migrate such a gigantic page. But that's very different from our
> >>> existing gigantic page code as far as I can tell.
> >>
> >> Serving 1GB PUD THPs from CMA is a compromise, since we do not want to
> >> bump MAX_ORDER to 20 to enable 1GB page allocation in buddy allocator,
> >> which needs section size increase. In addition, unmoveable pages cannot
> >> be allocated in CMA, so allocating 1GB pages has much higher chance from
> >> it than from ZONE_NORMAL.
> > 
> > s/higher chances/non-zero chances
> 
> Well, the longer the system runs (and consumes a significant amount of
> available main memory), the less likely it is.
> 
> > 
> > Currently we have nothing that prevents the fragmentation of the memory
> > with unmovable pages on the 1GB scale. It means that in a common case
> > it's highly unlikely to find a continuous GB without any unmovable page.
> > As now CMA seems to be the only working option.
> > 
> 
> And I completely dislike the use of CMA in this context (for example,
> allocating via CMA and freeing via the buddy by patching CMA when
> splitting up PUDs ...).
> 
> > However it seems there are other use cases for the allocation of continuous
> > 1GB pages: e.g. secretfd ( https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_831628_&d=DwIDaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=mdcwiGna7gQ4-RC_9XdaxFZ271PEQ09M0YtCcRoCkf8&s=4KlK2p0AVh1QdL8XDVeWyXPz4F63pdbbSCoxQlkNaa4&e=  ), where using
> > 1GB pages can reduce the fragmentation of the direct mapping.
> 
> Yes, see RFC v1 where I already cced Mike.
> 
> > 
> > So I wonder if we need a new mechanism to avoid fragmentation on 1GB/PUD scale.
> > E.g. something like a second level of pageblocks. That would allow to group
> > all unmovable memory in few 1GB blocks and have more 1GB regions available for
> > gigantic THPs and other use cases. I'm looking now into how it can be done.
> 
> Anything bigger than sections is somewhat problematic: you have to track
> that data somewhere. It cannot be the section (in contrast to pageblocks)

Well, it's not a large amount of data: the number of 1GB regions is not that
high even on very large machines.

> 
> > If anybody has any ideas here, I'll appreciate a lot.
> 
> I already brought up the idea of ZONE_PREFER_MOVABLE (see RFC v1). That
> somewhat mimics what CMA does (when sized reasonably), works well with
> memory hot(un)plug, and is immune to misconfiguration. Within such a
> zone, we can try to optimize the placement of larger blocks.

Thank you for pointing at it!

The main problem with it is the same as with ZONE_MOVABLE: it does require
a boot-time educated guess on a good size. I admit that the CMA does too.

But I really hope that a long-term solution will not require a pre-configuration.
I do not see why fundamentally we can't group unmovable allocations in (few)
1GB regions. Basically all we need to do is to choose a nearby 2MB block if we
don't have enough free pages in the unmovable free list and going to steal a new
2MB block. I know, it doesn't work this way, but just as an illustration.
In the reality, when stealing a block, under some conditions we might want
to steal the whole 1GB region. In this case the following unmovable allocations
will not lead to stealing of new blocks from (potentially) different 1GB regions.
I have no working code yet, just thinking into this direction.

Thanks!
