Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD1277AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIXUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:43:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23762 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726183AbgIXUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:43:52 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OKhfLs014109;
        Thu, 24 Sep 2020 13:43:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=tHZtqnTQfa/08CO6WByMkb0/lvcPApruUvBGp1LEYp0=;
 b=Vq9Vk34A9GmhyWcBkBa/mBwtFs/iH0aPTBQ98dogxKyVUQIqjqr0alrnn2phXjtOp+86
 WpDLyGJ1jid0/aXiJV9O2CZmTj1kfzWjvPc0a6TR0qqOJx8OwpO5Oh6HNaVmLaym3Oim
 xbRyrY7BqWjn/U39d88LlL2YdAnxPEpSers= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp440tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 13:43:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 13:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN2e0DdW2DVUeYIX1PwnXyVNKhqTR+F/dkjUlpSlpN2ve7oYVqWffOHUUbYopFTmPH8tuzpsfxywveJztgAXuc0GsmBG0sE9RPX7kmjSMWA1X1i4DskL55GFjhavjMLFUA71hLQrGPLPIgB9W+KY2Wbfz0QaK3imY18C3AVxQY9hliCNmdUE+QhqQmGdii40XBJhzCQ+pt2eFbkMB8emLFJ9jgSsDMU9CpcWlz3ahY9gRDZ6I+70xFa0b23s2oaKFRe2Ewwq2Ohf8vuildtvmfJURu8DQF4oDZpWNWjFOyIkIpIF0iC09Y8emWZdejuPzl9tNoBlh1Y+ENU/msGU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHZtqnTQfa/08CO6WByMkb0/lvcPApruUvBGp1LEYp0=;
 b=Z1Kj1x+a08UzRIcrkz2GMLEdJk0CqTojqNhnG+XwDdH1dYwb5Ps+CONDRRkxPmJsUNOPFNcTHGBQ9yNoqFsvh0YG1mdVHhpScf6i/yX74Y5yRZAteZOS7TFeHrixmUtaLBXy8w4mf+H9N1NShkLG7kYkRid3TBlCIKgyBsu6SlS6K9e+m3C4lI03qaWC0ZT257jg3MpGdTQE/YLsTSsDR8q3LsIDc+LThQRoGQcHkvU1dY7P5LyjDClk0ruyJdyzpt88wAfV2WPGHpQsMJ4dJyQX1IQ7I1fNywLYprihwZEuJN0fewElTWrR9U99ff2SY43sva9nLBmEjPeTtu6m5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tHZtqnTQfa/08CO6WByMkb0/lvcPApruUvBGp1LEYp0=;
 b=SkqUFvInxOi/Ukdx+jQUdqSra0jl5z3xkwZ6nB3PDDLwg9Aee703LkjNNgxKq94/KNUGoNVjuBx6L2tuDxO43nj9bzvgCNh3MmZTt7otlWJAJrU0nxUz1X3/evNAgQLB9jJVTVcDFWNTa/U4vCljBIpf4vii94dTZnWUUYjLLso=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3031.namprd15.prod.outlook.com (2603:10b6:a03:b4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.22; Thu, 24 Sep
 2020 20:43:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 20:43:01 +0000
Date:   Thu, 24 Sep 2020 13:42:57 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v1 4/4] mm: convert page kmemcg type to a page memcg flag
Message-ID: <20200924204257.GE1899519@carbon.dhcp.thefacebook.com>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-5-guro@fb.com>
 <20200924201417.GE329853@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924201417.GE329853@cmpxchg.org>
X-ClientProxiedBy: MWHPR22CA0030.namprd22.prod.outlook.com
 (2603:10b6:300:69::16) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a448) by MWHPR22CA0030.namprd22.prod.outlook.com (2603:10b6:300:69::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 20:43:00 +0000
X-Originating-IP: [2620:10d:c090:400::5:a448]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b90e4e5d-48f6-4102-c813-08d860ca6dcc
X-MS-TrafficTypeDiagnostic: BYAPR15MB3031:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB303189D31BA1AF58D16EE205BE390@BYAPR15MB3031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p150idQ4SABV2+S75wX+dHTvED30B/03puRZOcyR9nF+1jYORiD8Pg4bRcylqR+FLAF6SJSHaQHE53/4yss9orx8axcG/JpJ4bZv69hzFXuzGpo/kwVB3Mxv7/jfTsmis9RHM4Ly9fS7tsBuV1Q6BoaDI2u88ybWinT8No8OzJTasnikER0k7SepOy9GNd2se0mxV/7p4mYM7V9OsTcY8kc40h+7iqPr3OWFgjjavXpUpPepDZchq2Bezm7UxZU9pAXORlqAw8Itu5urI1IImkakgjD0CO1A/+VBWwb8upelyzvDSh09SFZKwWSN5bWIMHKi0zmMvd6wqjNimt5u3Nv5G5Ft577poYGdH/yuzr6/msbL7hkc2CFW2ltI35e3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(346002)(39860400002)(376002)(9686003)(8936002)(66946007)(6916009)(55016002)(83380400001)(1076003)(66476007)(5660300002)(4326008)(66556008)(6666004)(8676002)(6506007)(16526019)(186003)(2906002)(316002)(33656002)(86362001)(478600001)(7696005)(52116002)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: jV308T5cDKNQ6OHvLCTj5dimgx5gpgTEFqpZdYzDrjm4DqKNcrRggPXRSVOPRy1hjMKMoZShmq/C8cwlTkQeGfiz8lZtnQziVzRLKkylA9AWBc6vvmeDvZVSSGHGomf+8WvB9vpei1HDeJpdARPt000HqOZbYGJLuzgEFSoBeK3OEBabboaavcq8nhe/aYS4rQAHwB7B/GwiHXOP7/MQIQM0wf7GOdNs7PBtHciCtbxGGeBZFz0F0j6IQIoUPXIoBxIFcN2kOcQhLC+UyIKRYl8joLWgQwPtR2OO9kKjMHdx6QTRq31ldauSW5+o03WuSJ3e+vfIihLai5eZ9yXrt3HqN55I/RyvjFLTYfeIhkV4/YUJqEf+hFTt7bymH0GKALXnfPrrU0FcU4kYbWxelPhbNlpgIHpHN+YwBIJHb9UnxwETuaRRt4fCAWDdHp5Y4wRjoH9S39rfte8mdIi6aDTovsya02Lrqyv8TLcOnHz2miNcidyuThtK0OdeXgHLmQa9WHrV23CkeoRl6b9v3LusO57DcOXuJ18cIdQE/5G4NH4R1FAD1Hkwbv9s2xyjvPIJCmOfEBoPnbKyKtZx2nMWRKwC5B7qyOzoM9DwvBEkXUHFuAkre4lKwg0IFGZhsD24llcL5MBceQyP9ccoovlDJFTCZ8RAnpJ6/lpnoys=
X-MS-Exchange-CrossTenant-Network-Message-Id: b90e4e5d-48f6-4102-c813-08d860ca6dcc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 20:43:01.6661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7Qs3Fr4LZR6LyL5u80LE5xvbEThAIms69YfAbbpQREHnsgKe6ek9afdshosn/pp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3031
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_15:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 suspectscore=1 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240152
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 04:14:17PM -0400, Johannes Weiner wrote:
> On Tue, Sep 22, 2020 at 01:37:00PM -0700, Roman Gushchin wrote:
> > PageKmemcg flag is currently defined as a page type (like buddy,
> > offline, table and guard). Semantically it means that the page
> > was accounted as a kernel memory by the page allocator and has
> > to be uncharged on the release.
> > 
> > As a side effect of defining the flag as a page type, the accounted
> > page can't be mapped to userspace (look at page_has_type() and
> > comments above). In particular, this blocks the accounting of
> > vmalloc-backed memory used by some bpf maps, because these maps
> > do map the memory to userspace.
> > 
> > One option is to fix it by complicating the access to page->mapcount,
> > which provides some free bits for page->page_type.
> > 
> > But it's way better to move this flag into page->memcg_data flags.
> > Indeed, the flag makes no sense without enabled memory cgroups
> > and memory cgroup pointer set in particular.
> > 
> > This commit replaces PageKmemcg() and __SetPageKmemcg() with
> > PageMemcgKmem() and SetPageMemcgKmem(). __ClearPageKmemcg()
> > can be simple deleted because clear_page_mem_cgroup() already
> > does the job.
> > 
> > As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
> > be compiled out.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> That sounds good to me!

Great!

> 
> > ---
> >  include/linux/memcontrol.h | 58 ++++++++++++++++++++++++++++++++++++--
> >  include/linux/page-flags.h | 11 ++------
> >  mm/memcontrol.c            | 14 +++------
> >  mm/page_alloc.c            |  2 +-
> >  4 files changed, 62 insertions(+), 23 deletions(-)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 9a49f1e1c0c7..390db58500d5 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -346,8 +346,14 @@ extern struct mem_cgroup *root_mem_cgroup;
> >  enum page_memcg_flags {
> >  	/* page->memcg_data is a pointer to an objcgs vector */
> >  	PG_MEMCG_OBJ_CGROUPS,
> > +	/* page has been accounted as a non-slab kernel page */
> > +	PG_MEMCG_KMEM,
> > +	/* the next bit after the last actual flag */
> > +	PG_MEMCG_LAST_FLAG,
> 
> *_NR_FLAGS would be customary.

Ok, __NR_PAGE_MEMCG_FLAGS ? Similar to __NR_PAGE_FLAGS.

> 
> >  };
> >  
> > +#define MEMCG_FLAGS_MASK ((1UL << PG_MEMCG_LAST_FLAG) - 1)
> 
> Probably best to stick to the same prefix as the enum items.

You mean PG_MEMCG_FLAGS_MASK?

> 
> > + * PageMemcgKmem - check if the page has MemcgKmem flag set
> > + * @page: a pointer to the page struct
> > + *
> > + * Checks if the page has MemcgKmem flag set. The caller must ensure that
> > + * the page has an associated memory cgroup. It's not safe to call this function
> > + * against some types of pages, e.g. slab pages.
> > + */
> > +static inline bool PageMemcgKmem(struct page *page)
> > +{
> > +	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &page->memcg_data), page);
> > +	return test_bit(PG_MEMCG_KMEM, &page->memcg_data);
> > +}
> > +
> > +/*
> > + * SetPageMemcgKmem - set the page's MemcgKmem flag
> > + * @page: a pointer to the page struct
> > + *
> > + * Set the page's MemcgKmem flag. The caller must ensure that the page has
> > + * an associated memory cgroup. It's not safe to call this function
> > + * against some types of pages, e.g. slab pages.
> > + */
> > +static inline void SetPageMemcgKmem(struct page *page)
> > +{
> > +	VM_BUG_ON_PAGE(!page->memcg_data, page);
> > +	VM_BUG_ON_PAGE(test_bit(PG_MEMCG_OBJ_CGROUPS, &page->memcg_data), page);
> > +	__set_bit(PG_MEMCG_KMEM, &page->memcg_data);
> 
> It may be good to keep the __ prefix from __SetPageMemcg as long as
> this uses __set_bit, in case we later add atomic bit futzing.

Yeah, I agree. I though about it. Maybe not so useful now, but more future-proof.

Thanks!
