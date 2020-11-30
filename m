Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32AC2C9133
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbgK3Wen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:34:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64228 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730767AbgK3Wem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:34:42 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUMUJJt000983;
        Mon, 30 Nov 2020 14:33:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DZus6SvPFolhrVUHZ2s6HMw6nvfXXYk8JZEOIqVAoHc=;
 b=qHkdrjN5ei/qmiaV477GKilJSJQIx1CzsrIYHbKbh7DtZyCo0s0RpgvjoUyDe8ZaI5WL
 B4UYGMVgWD2Sm8Adp4LMHJztYrbsBt2+EtesSgj7z+Fn3sofJQ5cMzcIQd5uFYKjqPrf
 sBOLbkIDYrOLzYk8YxIgtbRnZZ/R0nrTuIE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3547g8fsgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 14:33:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 14:33:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvqq0V+VKyS/Qo3k6U8x3RCUKuUDr3K2VUdQ75BWvYvecnymoU0LCXcG3vkdTejweeOF81jLkZXlhh9L+JqySd9tmVAqvm2l2mDe86Y8v4g95TzhNU6biG/ULitN4nqUcu0qtyAzwGBfQesy2NMWVpmoKbKfD9skxdZyBJ11Q6ZKNqzpKJDJ7+WPYFLs5STOpZaK1s/h4GTrlprwE5w2iTpSp1UolJ5rCVTQdb+SHSNdEjcQyklehgInyJdP5+chZwP4RNNkcUyEz7vxV+aL+g02U263iGY5tSmNxY342gEX2wO9NI7dfdjtou7dkm9esCJyOtdqwG/2s0vy6zdNAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZus6SvPFolhrVUHZ2s6HMw6nvfXXYk8JZEOIqVAoHc=;
 b=aXHO2bb9n1zbluZGUDnCbbFDqpeVTS2orRZ8gq2dX5xQu2iKaWNcWoTEZGH/CoTU8YqDEfEDvbH8ErOAmO059GcMxiSRhCQmePFDbwpCxCCYtyor7TpS+4rqEDutO2fPZYe+1/KRj7BIB0jINet0sGBizSmBXowjmTYjadKz/i0Xk2WHb+MLiO6l+hsLm27FStkKW9wkh+L1+TctKrCgbuUCjQOFDs1CSkCAs80o/ZJkVxOecc+LmRN4xk9dHx6keKEy/gCGDrJYIDrRjY/fwyl1+MbQ7IYZIMPByIhLXg6r/aR5eD5xFQ6EUbpKEi6FgwMZNey5USibfrVRJRSbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZus6SvPFolhrVUHZ2s6HMw6nvfXXYk8JZEOIqVAoHc=;
 b=ezTpMGK/uYgm1DDUMqJeZoJvOm2CuzwiUGcOrbidcH5IJwleli4Vtt7t3CyL69IDY5rjayTiERx5ce8ufdVO/3QiK4GQMUeSnvD0X7KW7nYzYwFoc0B2pg7l5KDGwQ5zCL5pNHVFN4oIToSqHoImXinQLPNsq88WNfjByL9ZZdU=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4154.namprd15.prod.outlook.com (2603:10b6:a03:2ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 22:33:52 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 22:33:52 +0000
Date:   Mon, 30 Nov 2020 14:33:47 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Vladimir Davydov <vdavydov.dev@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: list_lru: hold nlru lock to avoid reading transient
 negative nr_items
Message-ID: <20201130223347.GE840171@carbon.dhcp.thefacebook.com>
References: <20201130184514.551950-1-shy828301@gmail.com>
 <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
 <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:f8af]
X-ClientProxiedBy: MW2PR16CA0071.namprd16.prod.outlook.com
 (2603:10b6:907:1::48) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:f8af) by MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 22:33:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3953066-9f60-42f7-c056-08d895800387
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4154:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4154248852F94EAF1975CCC8BEF50@SJ0PR15MB4154.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 47sdh5uzMxykRO67KEq+mIQ23C0pQRCV98jqwp7bmRA+y2FWy9rd/uyoGriFWGbWdNjXAY2SSR6u4CprVOW3iHmoRAWXXmhRuZZd/r5D8rvyIOu4qCkToF2Km2YXJ1YB8XACvq8iGmoXkpLhWjtSk3OtkM+YLcsYNwEPuF4wEPt+vuI3GxMLR9oVaJtFbvzsiA+j3OcGKORNXIMt49yNm+g98v/lQDfk4n94+vOXqOLQ/dM8coWY8zVhuUI0eN0h0q+UeOQ/xxXYtsV9I+b9X9JEZa1yeZaIYbk/MqLO7fqMYo+Elm3CrgMRgUDfixh7wqyf6QJQlegR+n8EN/YrGl6H0H0taBdIZNkEibBsG30snvyjkYx2FrmWuzubo64nWT6yuIg/BLgqxaRymezhtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(366004)(346002)(33656002)(6666004)(1076003)(478600001)(4326008)(16526019)(186003)(7696005)(6506007)(52116002)(5660300002)(2906002)(966005)(83380400001)(8676002)(53546011)(55016002)(86362001)(66476007)(66556008)(6916009)(54906003)(8936002)(66946007)(9686003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K43AJH0SS105Xm+D4p8FW/+it/Vt/gboZSyvRHLqtaCrg3/nRFStFXAZCtU4?=
 =?us-ascii?Q?XaJwT6YHVM6Gv9LydCcIBr8pwt0yarOUU1QXtRlBJdRoJAWOLAAgnwK3T1i8?=
 =?us-ascii?Q?UVC08BmVb3Dy4s3FBE+TokJIouMf5Q24xjnW4Rp0nWBie10xgBwKxI1yTib5?=
 =?us-ascii?Q?xWZVUKEi2LLAQOZAeKmYfAo6Nuc6bWbz4+u6qnIOsoY7074YYwedfTeZnPS+?=
 =?us-ascii?Q?J53+wY2shiTGkhHbClqitjZp9180P7sU4Qo2G0pTF1CjcJ8a51IevyGYWicE?=
 =?us-ascii?Q?WTIJuOSFwdVUinNxhLWDHKXEMbLkuS8a6yJmOymrbjJZ+DG8RyYCofbFnEwm?=
 =?us-ascii?Q?pm49EVcKCVCngg0jedaBzgM0Uz/ZY/OZecjXwOmUY/gilwQUCw6ofR0s6JNg?=
 =?us-ascii?Q?7kGPPGYGks2ds8F9To6rIDYjvEq7VGRTMyjj0JfcL5kMGDgGijsDogZQm1XG?=
 =?us-ascii?Q?cIQZvVljHt6KNASsmIQsGqnTXI5lpw9rU34UgJghlHMi4bElIzIEYMse6dF1?=
 =?us-ascii?Q?rGIoObHCWqGkl8dg7c3fPdhrVpiMBM63DYjML1gfQNHHBrS9KEjlbWMcugaf?=
 =?us-ascii?Q?xVtsou6rwnuwIz4358uUShyNP8AreOZhPP0SNaKfjDvNybrvFuqD4DlqrHON?=
 =?us-ascii?Q?Q0ohX+1kgV0b18X+XwhQbawsHPTBT8+58ZiVWX8+lzUcToo6Jd1SKpspUyif?=
 =?us-ascii?Q?uSgzFOE5ZCxl5h/m2EvAYo1lUb6reqfcqJX/AKTeGZtYXroRCG3B91DR+yo3?=
 =?us-ascii?Q?d5ytqgMzuxJJ3XjvowuTMLfE7FfIQoeE+zb5yUczZdD1xVRokGUBEB4RKopC?=
 =?us-ascii?Q?Ebs/TgASW6gwPYvA0rHQS6NqwjLcP83a0zv2jgs9m5Fm0LptsBsap3Xatyvp?=
 =?us-ascii?Q?LGyX7oOi9PCH/zrubOwu9KMnYRVerV5OIWMYJxHoMgz6LEHJ4zHTpcZZTxEr?=
 =?us-ascii?Q?+hXmrkFEfIcKcxsU8F71rDdVI7Y4yqr1KJkj9PeKwPS2DYa5jx+iaUfmWWb6?=
 =?us-ascii?Q?eSPy8AUWKSEIRLzon/kCov4KxQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3953066-9f60-42f7-c056-08d895800387
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 22:33:52.3624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLfrK1h6gEtCuIbHpJIf0Cs1Q7fishd5I/E7VQqWkCIjH9Xii/yfjFPbzbL2NjEO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4154
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 12:57:47PM -0800, Yang Shi wrote:
> On Mon, Nov 30, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
> > > When investigating a slab cache bloat problem, significant amount of
> > > negative dentry cache was seen, but confusingly they neither got shrunk
> > > by reclaimer (the host has very tight memory) nor be shrunk by dropping
> > > cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> > > but tracing result shows they were even not scanned at all.  The further
> > > investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> > > reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> > > to reboot the hosts to get the memory back.
> > >
> > > I didn't manage to come up with a reproducer in test environment, and the
> > > problem can't be reproduced after rebooting.  But it seems there is race
> > > between shrinker map bit clear and reparenting by code inspection.  The
> > > hypothesis is elaborated as below.
> > >
> > > The memcg hierarchy on our production environment looks like:
> > >                 root
> > >                /    \
> > >           system   user
> > >
> > > The main workloads are running under user slice's children, and it creates
> > > and removes memcg frequently.  So reparenting happens very often under user
> > > slice, but no task is under user slice directly.
> > >
> > > So with the frequent reparenting and tight memory pressure, the below
> > > hypothetical race condition may happen:
> > >
> > >     CPU A                            CPU B                         CPU C
> > > reparent
> > >     dst->nr_items == 0
> > >                                  shrinker:
> > >                                      total_objects == 0
> > >     add src->nr_items to dst
> > >     set_bit
> > >                                      retrun SHRINK_EMPTY
> > >                                      clear_bit
> > >                                                                   list_lru_del()
> > > reparent again
> > >     dst->nr_items may go negative
> > >     due to current list_lru_del()
> > >     on CPU C
> > >                                  The second run of shrinker:
> > >                                      read nr_items without any
> > >                                      synchronization, so it may
> > >                                      see intermediate negative
> > >                                      nr_items then total_objects
> > >                                      may return 0 conincidently
> > >
> > >                                      keep the bit cleared
> > >     dst->nr_items != 0
> > >     skip set_bit
> > >     add scr->nr_item to dst
> > >
> > > After this point dst->nr_item may never go zero, so reparenting will not
> > > set shrinker_map bit anymore.  And since there is no task under user
> > > slice directly, so no new object will be added to its lru to set the
> > > shrinker map bit either.  That bit is kept cleared forever.
> > >
> > > How does list_lru_del() race with reparenting?  It is because
> > > reparenting replaces childen's kmemcg_id to parent's without protecting
> > > from nlru->lock, so list_lru_del() may see parent's kmemcg_id but
> > > actually deleting items from child's lru, but dec'ing parent's nr_items,
> > > so the parent's nr_items may go negative as commit
> > > 2788cf0c401c268b4819c5407493a8769b7007aa ("memcg: reparent list_lrus and
> > > free kmemcg_id on css offline") says.

Also note that since the introduction of the slab reparenting, list_lru_from_kmem()
can return the parent lru.

> > >
> > > Can we move kmemcg_id replacement after reparenting?  No, because the
> > > race with list_lru_del() may result in negative src->nr_items, but it
> > > will never be fixed.  So the shrinker may never return SHRINK_EMPTY then
> > > keep the shrinker map bit set always.  The shrinker will be always
> > > called for nonsense.
> > >
> > > Can we synchronize list_lru_del() and reparenting?  Yes, it could be
> > > done.  But it seems we need introduce a new lock or use nlru->lock.  But
> > > it sounds complicated to move kmemcg_id replacement code under nlru->lock.
> > > And list_lru_del() may be called quite often to exacerbate some hot
> > > path, i.e. dentry kill.
> > >
> > > So, it sounds acceptable to synchronize reading nr_items to avoid seeing
> > > intermediate negative nr_items given the simplicity and it is typically
> > > just called by shrinkers when counting the freeable objects.
> > >
> > > The patch is tested with some shrinker intensive workloads, no
> > > noticeable regression is soptted.
> >
> > Hi Yang!
> >
> > It's really tricky, thank you for digging in! It's a perfect analysis!
> >
> > I wonder though, if it's better to just always set the shrinker bit on reparenting
> > if we do reparent some items? Then we'll avoid adding new synchronization
> > to the hot path. What do you think?
> 
> Thanks a lot for the suggestion. I was thinking about the same
> approach too, but I thought src->nr_items may go zero due to
> concurrent list_lru_del() at the first place. But I just rethought the
> whole thing, it seems impossible that dst->nr_items goes negative and
> src->nr_items goes zero at the same time.

Even if it would be possible, it seems less scary: the next reparenting
will likely set the bit. So we'll not get into the permanently bad state.

> list_lru_del() should just
> see either dst or src, it can't manipulate both lists simultaneously.
> So I think your suggestion should work. I will incarnate your
> suggestion in v2.
> 
> >
> > --
> >
> > @@ -534,7 +534,6 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> >         struct list_lru_node *nlru = &lru->node[nid];
> >         int dst_idx = dst_memcg->kmemcg_id;
> >         struct list_lru_one *src, *dst;
> > -       bool set;
> >
> >         /*
> >          * Since list_lru_{add,del} may be called under an IRQ-safe lock,
> > @@ -546,9 +545,8 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> >         dst = list_lru_from_memcg_idx(nlru, dst_idx);
> >
> >         list_splice_init(&src->list, &dst->list);
> > -       set = (!dst->nr_items && src->nr_items);
> >         dst->nr_items += src->nr_items;
> > -       if (set)
> > +       if (src->nr_items)
> >                 memcg_set_shrinker_bit(dst_memcg, nid, lru_shrinker_id(lru));
> >         src->nr_items = 0;
> >
> >
> > --
> >
> > Btw, it seems that the bug is quite old. I wonder why we haven't seen it before?
> > Any ideas?
> 
> It is not new, but not that old from my point of view. The
> shrinker_map thing was introduced since v4.19, I bet pre-v4.19 kernel
> may still dominate in production environment. And, it needs some
> conditions (i.e. nr_inode + nr_dentry == 0 coincidently, and there is
> not task under dst memcg directly, etc) to trigger, so it seems
> unlikely to hit.
> 
> And the consequence may be not noticeable to the most people at all.
> We happened to see frequent OOMs on a couple of small machines (32G
> memory w/o swap, but most memory was consumed by anonymous pages)
> recently and they were already up for long time (almost 300 days),
> then the investigation leads to this race condition.

I agree that most users will unlikely notice it.

But https://www.spinics.net/lists/cgroups/msg27295.html looks very similar
and can be caused by the same problem. Once you'll have v2, let's ask
them to test it too.

Thanks!
