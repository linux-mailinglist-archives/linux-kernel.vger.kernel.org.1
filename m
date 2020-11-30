Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC02C8EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 21:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgK3UKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 15:10:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:5306 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727328AbgK3UKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 15:10:32 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AUK3FSW016613;
        Mon, 30 Nov 2020 12:09:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QPf24082yRVrMU9Vh1ALk46NAX7zLfq1a1dBrMWI+3A=;
 b=rlmP05QDd9u849e69kRpl7kB1/v9+RWrjwb8evLtOXBabllJj9Y20rs2k0e0VsVO3bLF
 6O5EC8C6ZYjSN7HJsH6oDi5YXo02ioCImD6rB0yBESG+wcYHjfGPX4s95jjLkRTnbaex
 Evnl2KwlHJxOUuXG1B30HU0/8lSxcY0On5U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 354g9udnv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 12:09:44 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 12:09:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VKdF+1ndEYSWMgJawuRc7NLLnqAyCRw89YljBgE9nTBdhwUzrlhEOLfdrmVOOc9OLom5JTi8oRB5lv4MRZLqxZvSWIF1bTQsoDNBzfISlYxUofKVF2pWVQMk4YiHiE8j0U93lGcnBMMdx3Fyjn1TDCa137XEUxW5MIVzal8j5hhtx0PaEh/fGUvIuuzD0fRTyxnOXD9XqnPXbaLDIanzDeUM8c9j0Pxi5HZbrDtaO28BD7Pvzl81WeuLYjgpl4gmFammPgwoMZB/8OLbWX/VZiqM7dL5UA0qs1vKuWNkiuPofo6GNKAJl/+Ry3jZwxRMf2v7uc3M7xyQZY/WGVmteg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPf24082yRVrMU9Vh1ALk46NAX7zLfq1a1dBrMWI+3A=;
 b=lYLhXuNfoTPBJjUxA/TdK54k5n1CR1QNrwIwI/XOI7nPP86IYfFVu0snPrv8ieFC47ESjv5e8FdmKQyu+Bm1yY9+l6CKHrcyLUcRoBbCrXVJeLGiYwwrYGsDH4/qzdZ3UsSZN0KaNNvpiR05JWT3SO0tebD3j6n5D2yTl8yTG+oVVQA+TwC0WZhYRIWgXI1s06XkqfTQ/KNNqzP56wsnw/ZLqgCGWJlzrsdA/vdkdwN/SO/xR4ZHzgyLzOQMN9vPYsFs0hSWs2V3JrrS8IWpOGNToWhM4qhc/RcZtNa3+SsdRQDfWgdv6xSHeoFs6YrXrRr47tUReoD0a724Jf6fkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPf24082yRVrMU9Vh1ALk46NAX7zLfq1a1dBrMWI+3A=;
 b=c0Q+LJx0WvZ3xyN7bNI1HkL/3X1BoiRqHzpvosE0cAU3ECv33l+OsoJ80CEY++ivuhyNgHUNVal8hzmMWOQZ0gNP8MEeK5qyCvXv6t9ufsiZXiSM1XWwTRB9tx0eZVpx/GnLRMKVNq27D1sWTZMXGS4nnua5P98HIqVs3TFXhc4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2870.namprd15.prod.outlook.com (2603:10b6:a03:ff::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 20:09:42 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 20:09:42 +0000
Date:   Mon, 30 Nov 2020 12:09:36 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <vdavydov.dev@gmail.com>, <ktkhai@virtuozzo.com>,
        <shakeelb@google.com>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient
 negative nr_items
Message-ID: <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
References: <20201130184514.551950-1-shy828301@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130184514.551950-1-shy828301@gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:4376]
X-ClientProxiedBy: MWHPR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:300:13d::30) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:4376) by MWHPR20CA0020.namprd20.prod.outlook.com (2603:10b6:300:13d::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 20:09:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c81408df-475c-427e-4736-08d8956bdfa3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2870:
X-Microsoft-Antispam-PRVS: <BYAPR15MB287025A717DFE47576DF7586BEF50@BYAPR15MB2870.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MP9WtttOY12q8qm/GdlpkTgWi0YNQYt5zUPIzSJ65f28OqCvmjSPKYNPmNZA6GHow7gmtSb2WfLKVx9nHgCfVKusRIlmrOJU5+4eevVHO9C541nLs3Qxklc9ZDD4aRFf6DC43rTrOvdfnfaD3rDdaSWXc2UF81c/ZrN4l2+V2Ti423OS8EOC6Kt2XqacZiSEWAvkETG2QTDq9ztTlvcDzXzpsBfy+dPvjeXehbbrxBQ8V4T2xZtjKQ5A8YPk9Ef9cg8j+sn4bpyKSqumgZTPZm7bjZESiIn7bu1WQoh9q31EoxV/D1HK9hSx/ANSg7bQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(346002)(396003)(366004)(55016002)(7696005)(316002)(52116002)(86362001)(6916009)(478600001)(9686003)(8936002)(186003)(4326008)(16526019)(8676002)(6506007)(2906002)(33656002)(6666004)(5660300002)(66556008)(1076003)(66946007)(83380400001)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YcaNFpWIURYDLcGVBjIET9lUZqcqPgaIWsXvtf39U4DdqBfEL8irXpyfgCP/?=
 =?us-ascii?Q?EPvxUhbdd4Wyc8XOMvqyQkwylMjabBAoaMLVPwHzzKqTp1CXC6U2EUEm9XCm?=
 =?us-ascii?Q?9MGYDIwa2Z9He45dLkVVteMftExQJ6YZmY74CPRyXLb/SxfMBUYXI9DrIK4J?=
 =?us-ascii?Q?LAnCwvjlInix3jWItLn3f+kDpsYq9Fgza7sWDXqRcvH0bsRojRBnbSwMYjVj?=
 =?us-ascii?Q?YThr/zZxVK7LLw48CpXdjFJk5wigFFunXaG6qwU2VOfx+aeIL38k7iQ3eKZb?=
 =?us-ascii?Q?sRx8/qwMFQ1Juq5ZniaqfRSJtLjgz9SaitMFHNLHRqHoyzwEVND58K60ok2Z?=
 =?us-ascii?Q?ljd2CxR3e277WRsRS9tKryQ2yGczBqRk1BeZuesODkkmS9E3+uG5xQ+p0AOR?=
 =?us-ascii?Q?PINMQdP49aQlRowix8vrln692scvfcMFbfFnCpeDBbPn9khHH8+zV6nP2avt?=
 =?us-ascii?Q?YmBv0rLwa0jiMtE9jcZgJ9wCziGeGBqmJJ/eFXGn/1vCXMkQ/AH6Ag/e4Tuo?=
 =?us-ascii?Q?BjLg3nd7jC6mAb5ufY0MpKPLSGa1Ww6pVbpcL/UkRXU0ry6R8z/fyr0ocd5i?=
 =?us-ascii?Q?UcUJtPpOGgWm4q1lxhJ86MIPPVS+YVP3OhLTjtOZV3K/T2H+ILaQrrT27j5u?=
 =?us-ascii?Q?QmcTR2Co/8D2gDNb2/Gxt6tdS4yowTfCOXl3z9mTN17ZaBREp4tYXf6us7Qn?=
 =?us-ascii?Q?aj1XY54mDCAcWPLVzbNbvMw60ZYw2/WTp7g9HWv/jTFsuu3O5fvZumBsObGN?=
 =?us-ascii?Q?UDk6QFLU9ZWC6B9cY+AoS3Ik4rBt6NAAvs8jHPQ21vEnS4jQpjTC9rMEyr9O?=
 =?us-ascii?Q?TjyW1PCl6B7monXEz615yOLyKNcziCQoz71lqNpqkJKckDc4EkQMHwlAO9vc?=
 =?us-ascii?Q?4vlKsF0xWi9WK42hSN+IqNguyRwp9dx4vrvs2YE1zkU47S93+FBYvTejpGsr?=
 =?us-ascii?Q?0dTZJG/sfPZlMIW6MAZBx+Ikqv4PF0qDPnPrNzxIxJiQoCqO3KgLmfMTEPbW?=
 =?us-ascii?Q?cJz04XZsUzQYCHdW7TwVP+6f6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c81408df-475c-427e-4736-08d8956bdfa3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 20:09:42.2712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0FOw4lpNxh+GlykmkPSOdQcfFixN+nfAy05dwZSYGL3qVgyISdabgaKXeJbRt7j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2870
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_08:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=5 clxscore=1011 impostorscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
> When investigating a slab cache bloat problem, significant amount of
> negative dentry cache was seen, but confusingly they neither got shrunk
> by reclaimer (the host has very tight memory) nor be shrunk by dropping
> cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> but tracing result shows they were even not scanned at all.  The further
> investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> to reboot the hosts to get the memory back.
> 
> I didn't manage to come up with a reproducer in test environment, and the
> problem can't be reproduced after rebooting.  But it seems there is race
> between shrinker map bit clear and reparenting by code inspection.  The
> hypothesis is elaborated as below.
> 
> The memcg hierarchy on our production environment looks like:
>                 root
>                /    \
>           system   user
> 
> The main workloads are running under user slice's children, and it creates
> and removes memcg frequently.  So reparenting happens very often under user
> slice, but no task is under user slice directly.
> 
> So with the frequent reparenting and tight memory pressure, the below
> hypothetical race condition may happen:
> 
>     CPU A                            CPU B                         CPU C
> reparent
>     dst->nr_items == 0
>                                  shrinker:
>                                      total_objects == 0
>     add src->nr_items to dst
>     set_bit
>                                      retrun SHRINK_EMPTY
>                                      clear_bit
>                                                                   list_lru_del()
> reparent again
>     dst->nr_items may go negative
>     due to current list_lru_del()
>     on CPU C
>                                  The second run of shrinker:
>                                      read nr_items without any
>                                      synchronization, so it may
>                                      see intermediate negative
>                                      nr_items then total_objects
>                                      may return 0 conincidently
> 
>                                      keep the bit cleared
>     dst->nr_items != 0
>     skip set_bit
>     add scr->nr_item to dst
> 
> After this point dst->nr_item may never go zero, so reparenting will not
> set shrinker_map bit anymore.  And since there is no task under user
> slice directly, so no new object will be added to its lru to set the
> shrinker map bit either.  That bit is kept cleared forever.
> 
> How does list_lru_del() race with reparenting?  It is because
> reparenting replaces childen's kmemcg_id to parent's without protecting
> from nlru->lock, so list_lru_del() may see parent's kmemcg_id but
> actually deleting items from child's lru, but dec'ing parent's nr_items,
> so the parent's nr_items may go negative as commit
> 2788cf0c401c268b4819c5407493a8769b7007aa ("memcg: reparent list_lrus and
> free kmemcg_id on css offline") says.
> 
> Can we move kmemcg_id replacement after reparenting?  No, because the
> race with list_lru_del() may result in negative src->nr_items, but it
> will never be fixed.  So the shrinker may never return SHRINK_EMPTY then
> keep the shrinker map bit set always.  The shrinker will be always
> called for nonsense.
> 
> Can we synchronize list_lru_del() and reparenting?  Yes, it could be
> done.  But it seems we need introduce a new lock or use nlru->lock.  But
> it sounds complicated to move kmemcg_id replacement code under nlru->lock.
> And list_lru_del() may be called quite often to exacerbate some hot
> path, i.e. dentry kill.
> 
> So, it sounds acceptable to synchronize reading nr_items to avoid seeing
> intermediate negative nr_items given the simplicity and it is typically
> just called by shrinkers when counting the freeable objects.
> 
> The patch is tested with some shrinker intensive workloads, no
> noticeable regression is soptted.

Hi Yang!

It's really tricky, thank you for digging in! It's a perfect analysis!

I wonder though, if it's better to just always set the shrinker bit on reparenting
if we do reparent some items? Then we'll avoid adding new synchronization
to the hot path. What do you think?

--

@@ -534,7 +534,6 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	struct list_lru_node *nlru = &lru->node[nid];
 	int dst_idx = dst_memcg->kmemcg_id;
 	struct list_lru_one *src, *dst;
-	bool set;
 
 	/*
 	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
@@ -546,9 +545,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
 	dst = list_lru_from_memcg_idx(nlru, dst_idx);
 
 	list_splice_init(&src->list, &dst->list);
-	set = (!dst->nr_items && src->nr_items);
 	dst->nr_items += src->nr_items;
-	if (set)
+	if (src->nr_items)
 		memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
 	src->nr_items = 0;
 

--

Btw, it seems that the bug is quite old. I wonder why we haven't seen it before?
Any ideas?


Thanks!


> 
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/list_lru.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 5aa6e44bc2ae..5c128a7710ff 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -178,10 +178,17 @@ unsigned long list_lru_count_one(struct list_lru *lru,
>  	struct list_lru_one *l;
>  	unsigned long count;
>  
> -	rcu_read_lock();
> +	/*
> +	 * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> +	 * we have to use IRQ-safe primitives here to avoid deadlock.
> +	 *
> +	 * Hold the lock to prevent from seeing transient negative
> +	 * nr_items value.
> +	 */
> +	spin_lock_irq(&nlru->lock);
>  	l = list_lru_from_memcg_idx(nlru, memcg_cache_id(memcg));
>  	count = READ_ONCE(l->nr_items);
> -	rcu_read_unlock();
> +	spin_unlock_irq(&nlru->lock);
>  
>  	return count;
>  }
> -- 
> 2.26.2
> 
