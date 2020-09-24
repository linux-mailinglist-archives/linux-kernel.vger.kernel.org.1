Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8075277A2A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgIXU1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:27:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:27:19 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OKNPcM009011;
        Thu, 24 Sep 2020 13:27:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EweQx4iSjtzyC/CPYfknwpP8KyF2fl9BHmz2SiXfZsU=;
 b=T43/sqVt2OS68bxgqY7Sh7mr8WRU0TBkP3S2jsaGacaLJDI2LfRvnJ2J9M5v5rHF6uYn
 FSEPgCl9doqalPHgXRhO7R3d/K4ZmO90FyPuCq9HeCF9bzk3SwiLg/TZeRkOFvBOC3yg
 3+emCO/HQgArf9VMgf+kelF+uXFAMIP1Eh4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33qsp53v1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Sep 2020 13:27:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 24 Sep 2020 13:27:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHWA2/lmzfdhI9zutTQR0Gnx40PKHBa+1ABtpEjarsz95Sl87zWZvRVM6RpM9DPTptqPecoCsnYUT5J5pyvJLr1qcOCBRSMLLQjOr39cr5bzxRVgdLUNoHxxzvF4x/MCs3tWDS2U/KrWLBvkwjZ7FeQys+5qcSruoV6nfeH/yEG9sr8LJ3KpNBDUHP219JZjA6l8cG+khlF5SxB7yjO8DKHZBjBmatp7xFhCeCOZpY9lUI8alpacgwtVTgMXoKYIRnPFk9vvFBX8eUzbqpceQGcw4H5rgONZFM2Sky8c/4lMhywGgWWkvW+DXA1piu5Di4I8LlrfkFZntEGtcvyMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EweQx4iSjtzyC/CPYfknwpP8KyF2fl9BHmz2SiXfZsU=;
 b=E5kHfcN6NPQjsdRCL6Q4hM1/b6YgdU1BWUB9ePtaFmxKAjhe6XZqE+C+n6Tvg96XL4iDan0RphsA+2SG4DOZM9GQu5pCx71JbhemAQR9Z0vDLPJALi6cvlJoMyj7zjhtKSPX64vJntqxNJBDqlKsSnpigboUHza7z/w/HvepYbSBZegyiNW3hddbpD2KvSYGtM90qq4xZU5cT0u1Ld+kyO9INC6Ma4Pa9IUdZY1dqJu3XlPCrltxOvuCe1G0smpQFimchZYSAj62bRC0gCxxYFZ8gV/ezXqoWWKs7OJygAzSjlW66tvnPMzal+1wmeceJJVoyzSNKM0rqjLefm6ePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EweQx4iSjtzyC/CPYfknwpP8KyF2fl9BHmz2SiXfZsU=;
 b=calHDauIz83+a88xNFMTFw4moE+k29UxArupF2dEXmamTd5BPfdWX6Fgqetg82M4ME8YNs1Xrxd7U4D16nkLVhN1nl6sT3TJQqY8fI58xa64RkeiVM0QzzfYTfwYZyNWuSWlHhIx2rFUCW3ARslHSwKk6XgmF88PtJ3wrIJGUrw=
Authentication-Results: cmpxchg.org; dkim=none (message not signed)
 header.d=none;cmpxchg.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2630.namprd15.prod.outlook.com (2603:10b6:a03:14c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Thu, 24 Sep
 2020 20:27:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::354d:5296:6a28:f55e%6]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 20:27:05 +0000
Date:   Thu, 24 Sep 2020 13:27:00 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v1 1/4] mm: memcontrol: use helpers to access page's
 memcg data
Message-ID: <20200924202700.GB1899519@carbon.dhcp.thefacebook.com>
References: <20200922203700.2879671-1-guro@fb.com>
 <20200922203700.2879671-2-guro@fb.com>
 <20200924194508.GA329853@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924194508.GA329853@cmpxchg.org>
X-ClientProxiedBy: MWHPR1701CA0020.namprd17.prod.outlook.com
 (2603:10b6:301:14::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:a448) by MWHPR1701CA0020.namprd17.prod.outlook.com (2603:10b6:301:14::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 20:27:04 +0000
X-Originating-IP: [2620:10d:c090:400::5:a448]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6cfcb73-0e0a-43fa-ef57-08d860c8338f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2630:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2630DD179CE66C49C7228347BE390@BYAPR15MB2630.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K32IbQpV3Q/lYiYJsvc/pJbaBRTVdJm2fASuCduCYPeE0UD3FMuoig5ZVF4qFiJ9u21aaeRRKWUo8xYXsDvXHeyRxiJtefu1AX3LDskCdBKuJuwl6NlPmjwwiU5HaEJR8zoHnvEccRutqlc255jFfSEaXF7PBhHRLecwF9GOzswLu8h78Gb7pBxAj2l2TOiSrv+h9zdrEc8BzbwKFRucEepPbkwIPsergoPzZnX/BIsSXJwDMCPoc/4Ay/rRatZ1c1HJBcvI4yYvzrBthXURXVpeFLd2GhvCv/HLveIVy3GlnoSMNEqR2TWL03hzfROdix6UHWozfIYBAzTO1AKURwSD73tYGZ4K8CKEaFDav874bDv/XCfVeOimT/v1Tzjf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(6666004)(33656002)(7696005)(5660300002)(66946007)(52116002)(6506007)(30864003)(54906003)(83380400001)(86362001)(16526019)(6916009)(8936002)(9686003)(4326008)(55016002)(186003)(8676002)(2906002)(66476007)(1076003)(478600001)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: b/wPF3Zk/FnmCMEl8F9OX811ZGsSI71qSKxu7Y+m2QQ65XEhZYzFuLQz7Rn5YQckQOrDxlhTDBpnl5b1LPrm4WvQWHvASz6vqJNcCKhPxf+jcNji/FVUmccCPmNetvy407Su2lA/s1fKHhvh4HMYjNOzE78aeUHNupcI8FMjCaead05Rhvxcfp76hhXdgy7JsV6REChHNZ36zMCIEl4zuXy9HdR6joTQKUmpfDxd9dqQCE1z5iBGplv0T+qwKadBKNuhjkykvZ6Ba+QfpVM+qh+9oYQp5xQjMfpyiBgtk+TsX8hwxYZof/OQ1clX0uzwJgoK8PUbilGAFSJv9sCeNl35UCRBwwSyxuU04TA8TyeUu11kcsH9HEO7zEUfiV0taiZ0f1lAj90KETxWr55OWh8Ot+U5Y0LJU1CC/oSVjAOpjaWLuVLu/nAfJhTNeKqoY+/sNaoMprFBWAFwg8J9m9XzCxrtNQWpGAOMD9ShWJHuv316Y+K0xLqSGLhOLU3vbEbJD3eIumckeVROz7x/ACYd/n0EGGZTJd3GOIM4VBxiTAbFTOJekH6P/TUeusmVaHl+Sj85phy2aVH8xTceodc5xQR/uN1sj35SMe2w3g4wjtRG0Zb8aSmytPc4FBikWCLMoO448XTNMLhOarGE6fAbysGK2ARMVEoxsKwF9Ypd4KjpumTHsblcFfUnmZmJ
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cfcb73-0e0a-43fa-ef57-08d860c8338f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 20:27:05.0850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: viFcmXQNNiUbO4qqfGapO2vbNqC5vJVkDc3/KCOHevlC7nnyaFTRf//+WQ/dBORL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2630
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_15:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 suspectscore=1 bulkscore=0
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240149
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 03:45:08PM -0400, Johannes Weiner wrote:
> On Tue, Sep 22, 2020 at 01:36:57PM -0700, Roman Gushchin wrote:
> > Currently there are many open-coded reads and writes of the
> > page->mem_cgroup pointer, as well as a couple of read helpers,
> > which are barely used.
> > 
> > It creates an obstacle on a way to reuse some bits of the pointer
> > for storing additional bits of information. In fact, we already do
> > this for slab pages, where the last bit indicates that a pointer has
> > an attached vector of objcg pointers instead of a regular memcg
> > pointer.
> > 
> > This commits introduces 4 new helper functions and converts all
> > raw accesses to page->mem_cgroup to calls of these helpers:
> >   struct mem_cgroup *page_mem_cgroup(struct page *page);
> >   struct mem_cgroup *page_mem_cgroup_check(struct page *page);
> >   void set_page_mem_cgroup(struct page *page, struct mem_cgroup *memcg);
> >   void clear_page_mem_cgroup(struct page *page);
> 
> Sounds reasonable to me!
> 
> > page_mem_cgroup_check() is intended to be used in cases when the page
> > can be a slab page and have a memcg pointer pointing at objcg vector.
> > It does check the lowest bit, and if set, returns NULL.
> > page_mem_cgroup() contains a VM_BUG_ON_PAGE() check for the page not
> > being a slab page. So do set_page_mem_cgroup() and clear_page_mem_cgroup().
> > 
> > To make sure nobody uses a direct access, struct page's
> > mem_cgroup/obj_cgroups is converted to unsigned long memcg_data.
> > Only new helpers and a couple of slab-accounting related functions
> > access this field directly.
> > 
> > page_memcg() and page_memcg_rcu() helpers defined in mm.h are removed.
> > New page_mem_cgroup() is a direct analog of page_memcg(), while
> > page_memcg_rcu() has a single call site in a small rcu-read-lock
> > section, so it's just not worth it to have a separate helper. So
> > it's replaced with page_mem_cgroup() too.
> 
> page_memcg_rcu() does READ_ONCE(). We need to keep that for lockless
> accesses.

Ok, how about page_memcg() and page_objcgs() which always do READ_ONCE()?
Because page_memcg_rcu() has only a single call site, I would prefer to
have one helper instead of two.

> 
> > @@ -343,6 +343,72 @@ struct mem_cgroup {
> >  
> >  extern struct mem_cgroup *root_mem_cgroup;
> >  
> > +/*
> > + * page_mem_cgroup - get the memory cgroup associated with a page
> > + * @page: a pointer to the page struct
> > + *
> > + * Returns a pointer to the memory cgroup associated with the page,
> > + * or NULL. This function assumes that the page is known to have a
> > + * proper memory cgroup pointer. It's not safe to call this function
> > + * against some type of pages, e.g. slab pages or ex-slab pages.
> > + */
> > +static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
> > +{
> > +	VM_BUG_ON_PAGE(PageSlab(page), page);
> > +	return (struct mem_cgroup *)page->memcg_data;
> > +}
> 
> This would also be a good place to mention what's required for the
> function to be called safely, or in a way that produces a stable
> result - i.e. the list of conditions in commit_charge().

Makes sense.

> 
> > + * page_mem_cgroup_check - get the memory cgroup associated with a page
> > + * @page: a pointer to the page struct
> > + *
> > + * Returns a pointer to the memory cgroup associated with the page,
> > + * or NULL. This function unlike page_mem_cgroup() can take any  page
> > + * as an argument. It has to be used in cases when it's not known if a page
> > + * has an associated memory cgroup pointer or an object cgroups vector.
> > + */
> > +static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
> > +{
> > +	unsigned long memcg_data = page->memcg_data;
> > +
> > +	/*
> > +	 * The lowest bit set means that memcg isn't a valid
> > +	 * memcg pointer, but a obj_cgroups pointer.
> > +	 * In this case the page is shared and doesn't belong
> > +	 * to any specific memory cgroup.
> > +	 */
> > +	if (memcg_data & 0x1UL)
> > +		return NULL;
> > +
> > +	return (struct mem_cgroup *)memcg_data;
> > +}
> 
> Here as well.
> 
> > +
> > +/*
> > + * set_page_mem_cgroup - associate a page with a memory cgroup
> > + * @page: a pointer to the page struct
> > + * @memcg: a pointer to the memory cgroup
> > + *
> > + * Associates a page with a memory cgroup.
> > + */
> > +static inline void set_page_mem_cgroup(struct page *page,
> > +				       struct mem_cgroup *memcg)
> > +{
> > +	VM_BUG_ON_PAGE(PageSlab(page), page);
> > +	page->memcg_data = (unsigned long)memcg;
> > +}
> > +
> > +/*
> > + * clear_page_mem_cgroup - clear an association of a page with a memory cgroup
> > + * @page: a pointer to the page struct
> > + *
> > + * Clears an association of a page with a memory cgroup.
> > + */
> > +static inline void clear_page_mem_cgroup(struct page *page)
> > +{
> > +	VM_BUG_ON_PAGE(PageSlab(page), page);
> > +	page->memcg_data = 0;
> > +}
> > +
> >  static __always_inline bool memcg_stat_item_in_bytes(int idx)
> >  {
> >  	if (idx == MEMCG_PERCPU_B)
> > @@ -743,15 +809,15 @@ static inline void mod_memcg_state(struct mem_cgroup *memcg,
> >  static inline void __mod_memcg_page_state(struct page *page,
> >  					  int idx, int val)
> >  {
> > -	if (page->mem_cgroup)
> > -		__mod_memcg_state(page->mem_cgroup, idx, val);
> > +	if (page_mem_cgroup(page))
> > +		__mod_memcg_state(page_mem_cgroup(page), idx, val);
> >  }
> >  
> >  static inline void mod_memcg_page_state(struct page *page,
> >  					int idx, int val)
> >  {
> > -	if (page->mem_cgroup)
> > -		mod_memcg_state(page->mem_cgroup, idx, val);
> > +	if (page_mem_cgroup(page))
> > +		mod_memcg_state(page_mem_cgroup(page), idx, val);
> >  }
> >  
> >  static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
> > @@ -838,12 +904,12 @@ static inline void __mod_lruvec_page_state(struct page *page,
> >  	struct lruvec *lruvec;
> >  
> >  	/* Untracked pages have no memcg, no lruvec. Update only the node */
> > -	if (!head->mem_cgroup) {
> > +	if (!page_mem_cgroup(head)) {
> >  		__mod_node_page_state(pgdat, idx, val);
> >  		return;
> >  	}
> >  
> > -	lruvec = mem_cgroup_lruvec(head->mem_cgroup, pgdat);
> > +	lruvec = mem_cgroup_lruvec(page_mem_cgroup(head), pgdat);
> >  	__mod_lruvec_state(lruvec, idx, val);
> 
> The repetition of the function call is a bit jarring, especially in
> configs with VM_BUG_ON() enabled (some distros use it for their beta
> release kernels, so it's not just kernel developer test machines that
> pay this cost). Can you please use a local variable when the function
> needs the memcg more than once?

Sure.

> 
> > @@ -878,8 +944,8 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
> >  static inline void count_memcg_page_event(struct page *page,
> >  					  enum vm_event_item idx)
> >  {
> > -	if (page->mem_cgroup)
> > -		count_memcg_events(page->mem_cgroup, idx, 1);
> > +	if (page_mem_cgroup(page))
> > +		count_memcg_events(page_mem_cgroup(page), idx, 1);
> >  }
> >  
> >  static inline void count_memcg_event_mm(struct mm_struct *mm,
> > @@ -941,6 +1007,25 @@ void mem_cgroup_split_huge_fixup(struct page *head);
> >  
> >  struct mem_cgroup;
> >  
> > +static inline struct mem_cgroup *page_mem_cgroup(struct page *page)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline struct mem_cgroup *page_mem_cgroup_check(struct page *page)
> > +{
> > +	return NULL;
> > +}
> > +
> > +static inline void set_page_mem_cgroup(struct page *page,
> > +				       struct mem_cgroup *memcg)
> > +{
> > +}
> > +
> > +static inline void clear_page_mem_cgroup(struct page *page)
> > +{
> > +}
> > +
> >  static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
> >  {
> >  	return true;
> > @@ -1430,7 +1515,7 @@ static inline void mem_cgroup_track_foreign_dirty(struct page *page,
> >  	if (mem_cgroup_disabled())
> >  		return;
> >  
> > -	if (unlikely(&page->mem_cgroup->css != wb->memcg_css))
> > +	if (unlikely(&page_mem_cgroup(page)->css != wb->memcg_css))
> >  		mem_cgroup_track_foreign_dirty_slowpath(page, wb);
> >  }
> >  
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 17e712207d74..5e24ff2ffec9 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1476,28 +1476,6 @@ static inline void set_page_links(struct page *page, enum zone_type zone,
> >  #endif
> >  }
> >  
> > -#ifdef CONFIG_MEMCG
> > -static inline struct mem_cgroup *page_memcg(struct page *page)
> > -{
> > -	return page->mem_cgroup;
> > -}
> > -static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> > -{
> > -	WARN_ON_ONCE(!rcu_read_lock_held());
> > -	return READ_ONCE(page->mem_cgroup);
> > -}
> > -#else
> > -static inline struct mem_cgroup *page_memcg(struct page *page)
> > -{
> > -	return NULL;
> > -}
> > -static inline struct mem_cgroup *page_memcg_rcu(struct page *page)
> > -{
> > -	WARN_ON_ONCE(!rcu_read_lock_held());
> > -	return NULL;
> > -}
> > -#endif
> 
> You essentially renamed these existing helpers, but I don't think
> that's justified. Especially with the proliferation of callsites, the
> original names are nicer. I'd prefer we keep them.
> 
> > @@ -560,16 +560,7 @@ ino_t page_cgroup_ino(struct page *page)
> >  	unsigned long ino = 0;
> >  
> >  	rcu_read_lock();
> > -	memcg = page->mem_cgroup;
> > -
> > -	/*
> > -	 * The lowest bit set means that memcg isn't a valid
> > -	 * memcg pointer, but a obj_cgroups pointer.
> > -	 * In this case the page is shared and doesn't belong
> > -	 * to any specific memory cgroup.
> > -	 */
> > -	if ((unsigned long) memcg & 0x1UL)
> > -		memcg = NULL;
> > +	memcg = page_mem_cgroup_check(page);
> 
> This should actually have been using READ_ONCE() all along. Otherwise
> the compiler can issue multiple loads to page->mem_cgroup here and you
> can end up with a pointer with the lowest bit set leaking out.
> 
> > @@ -2928,17 +2918,6 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
> >  
> >  	page = virt_to_head_page(p);
> >  
> > -	/*
> > -	 * If page->mem_cgroup is set, it's either a simple mem_cgroup pointer
> > -	 * or a pointer to obj_cgroup vector. In the latter case the lowest
> > -	 * bit of the pointer is set.
> > -	 * The page->mem_cgroup pointer can be asynchronously changed
> > -	 * from NULL to (obj_cgroup_vec | 0x1UL), but can't be changed
> > -	 * from a valid memcg pointer to objcg vector or back.
> > -	 */
> > -	if (!page->mem_cgroup)
> > -		return NULL;
> > -
> >  	/*
> >  	 * Slab objects are accounted individually, not per-page.
> >  	 * Memcg membership data for each individual object is saved in
> > @@ -2956,8 +2935,14 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
> >  		return NULL;
> >  	}
> >  
> > -	/* All other pages use page->mem_cgroup */
> > -	return page->mem_cgroup;
> > +	/*
> > +	 * page_mem_cgroup_check() is used here, because page_has_obj_cgroups()
> > +	 * check above could fail because the object cgroups vector wasn't set
> > +	 * at that moment, but it can be set concurrently.
> > +	 * page_mem_cgroup_check(page) will guarantee tat a proper memory
> > +	 * cgroup pointer or NULL will be returned.
> > +	 */
> > +	return page_mem_cgroup_check(page);
> 
> The code right now doesn't look quite safe. As per above, without the
> READ_ONCE the compiler might issue multiple loads and we may get a
> pointer with the low bit set.
> 
> Maybe slightly off-topic, but what are "all other pages" in general?
> I don't see any callsites that ask for ownership on objects whose
> backing pages may belong to a single memcg. That wouldn't seem to make
> too much sense. Unless I'm missing something, this function should
> probably tighten up its scope a bit and only work on stuff that is
> actually following the obj_cgroup protocol.

Kernel stacks can be slabs or generic pages/vmallocs. Also large kmallocs
are using the page allocator, so they don't follow the objcg protocol.

Thanks!
