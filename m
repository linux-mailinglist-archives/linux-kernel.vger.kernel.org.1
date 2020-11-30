Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3C22C922C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgK3XKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:10:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58858 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728460AbgK3XKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:10:06 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUN79JH012548;
        Mon, 30 Nov 2020 15:09:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=C0MWjPalZq4U/6jHuyaZM8RORtkDqaiPRtIvqnzkwrg=;
 b=WvAVHeYWivujrNrsCxJ6pC/UQp1FQJHl90XtXZdtzutu1Snn3WPIXa6HnK1vClKwGbPr
 3/Vdu1Cd6IYnvWBQv8CRcBTN/6JmrWUGJgBg/Phh+OB8bUjXRofKKI32X6J4v7yM3kL9
 WHeYrgDpx0/0vyhnIu/rANKhF4Y0paDM5Ko= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 354d4g76hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 15:09:19 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 15:09:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpBWkwQRbQyClwc3w6lkdszzuaUKWowG5ML9oaYtDuumuT5blkKD4qKjDMT9/F+JPei9niX3tNjvWLQR/DSbqRzk47o8KGV15b1oqZ/fNzlHxCupYl39sII6cVYniV1LYDBPehyNhf+7a0cqkRKscnmoXkK23N34aOkjs1sTQ4EiuJTi3gY3d0CliwYeAuSjfs5AfqBqsOSGIjP9HzD5PxZp7Av+A0eTyp8kOOjy1LhPi6rlEz/BbdUlsPZ8B16URCCP2Yqx3IpeyzmGKaVAfho94w61FWXZZC9E2NdOLPYsCVytkeLl5bk/mhhSFiYsLg7ZJ/7S2gMyWPzqq5cH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0MWjPalZq4U/6jHuyaZM8RORtkDqaiPRtIvqnzkwrg=;
 b=XFmBQ8G/OaCyCLV4vFrSzDVPZ2kanV6o8Zxim7OPCp4cU/CqWi4XfJrO6yJVntTXuz6jq786sTYzBMyFE2HOPuN7IXoRkAuACsIDy2YoQQBvO8lbbIRD4i/Kv1SIg1ISvWHrkb1Tsq1jFw/+3sipzqicO/7A3dCXddbGSKnn0rC1DyKJ1o6Vdrd7/v5oiYCTFxtBTtzynDfRHQc+csLDirK7ZkdygtWGasPip4YKUmoi7eOrLinyXfgrRN4Yzeb+TEVZDYBQfm4xWpXCk0WVyNlQELsniG7/9IDgCal1fJLXzjntEdOXj9EuaQq4FOvM0yKfkX0EqaYNXq17gxuWEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0MWjPalZq4U/6jHuyaZM8RORtkDqaiPRtIvqnzkwrg=;
 b=GfUDJZm2uVB0yIm7qwRuMef8oyJpSGWJs9m2kwmGdJdUzUPJYG2vRH+0JN8bpZJvRkbhRL0mmTI15tp2Tj1O24DBORjqb/1md7hvUKs4/sV/s7k6d8RVhOM8paCZsz0MFo4RyadC+96Z/SNVjAf9nJ3SFljoaHgEt9qe54H6PXI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2503.namprd15.prod.outlook.com (2603:10b6:a02:89::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Mon, 30 Nov
 2020 23:09:16 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 23:09:16 +0000
Date:   Mon, 30 Nov 2020 15:09:11 -0800
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
Message-ID: <20201130230911.GB1375014@carbon.DHCP.thefacebook.com>
References: <20201130184514.551950-1-shy828301@gmail.com>
 <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
 <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com>
 <20201130225255.GF840171@carbon.dhcp.thefacebook.com>
 <CAHbLzkoK+oFmmpmK7D7vc7fs__fdos+Ckuuj6CBVoP0Yb90YCw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoK+oFmmpmK7D7vc7fs__fdos+Ckuuj6CBVoP0Yb90YCw@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:a17f]
X-ClientProxiedBy: CO2PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:102:2::52) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:a17f) by CO2PR05CA0084.namprd05.prod.outlook.com (2603:10b6:102:2::52) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend Transport; Mon, 30 Nov 2020 23:09:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 543d5a7a-64d6-4bdc-b93d-08d89584f584
X-MS-TrafficTypeDiagnostic: BYAPR15MB2503:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2503C5B5044EE9F27F973F77BEF50@BYAPR15MB2503.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JsaVPbuxssBjfBHYNOJMWzW0AWbE05TnVFeXobcwGC4mk6pNLcymIR567ctd9hYYLowPT5tCOJPnQsN2uyZXhHHGFYu+BxveL+K7BeHi8XCy39nXtWaekKt2kDMVmGXFlwdaLfn78I8JXrCPDzFBJh0tnr6RtMS9jSKFQOSwpsJUJaB3bUsgrqc9KD3l+Yhx6bjDIkFEky2aCDEEXzg7C9UFNBDJuZUu3+yAMaEzXycFhxJMu/Rfc1n3+vmlWAttj3lijCEtj3vpASQ6iaR5luXND00PuoYn8sRHPegR1iBco9jizIxIWyMNvShrAZTK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39860400002)(376002)(136003)(54906003)(16526019)(186003)(316002)(66556008)(66946007)(66476007)(86362001)(55016002)(9686003)(53546011)(5660300002)(6506007)(8936002)(2906002)(8676002)(6666004)(7696005)(6916009)(33656002)(83380400001)(52116002)(4326008)(478600001)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?L86WCTvU54EUWgs5xMRD0Vb6rkD3lsV4j9QwMss5zJphggVYe96w3acW7A+p?=
 =?us-ascii?Q?OSao73rEzhAS3nuyETyWohXoiYQn0lFdm84UTBYPQM21Kp7Xd458JlEqWfZ4?=
 =?us-ascii?Q?826BUJdW7F9EHCmCe7pThcbDpKANmR0/x89JMMKzBM22EFnIK2l3fN5zZ/9f?=
 =?us-ascii?Q?NZ3xZvm8rSkz7s3d8VVd0Oh0ul9bj5r4YRorDPC9e4sVJgfWb4gPuF3p56Z2?=
 =?us-ascii?Q?j9SF/dxWpbjmIE312/4+syfPFT3LYBuxw4UnOmQQOiH+bnJrGxW3EgSvohW5?=
 =?us-ascii?Q?SpjuA79zi9fBtAtgCtlojeY2ho+uV9EP+WApWjbWcYwbYovu0p36m73d3cPV?=
 =?us-ascii?Q?gp8HPEYPeIyUuhc6y+8U9kiSkZuVxeaXnN2zT1tgr95coibP4FX3zuD+XIlS?=
 =?us-ascii?Q?kc2r6hxYFOlGRZ+ZuG17gT43ysMGvruD6Qjbj0G3WivXqKQrO5UTWUFLdHrg?=
 =?us-ascii?Q?bB/P5UxRlU17g+ZvJJNLOP1MWoC8tPFc7zrjov8qHNmwQWr0hYgpDCVIvPWG?=
 =?us-ascii?Q?5+nqSCJ7daNJeRkzTaHS5taLytOOvwr0CDExGP/46RrH7ShtnxT+07t9qEMl?=
 =?us-ascii?Q?SNp4BXslMic35TzTleY95vXP0S6wwLBRVz2VtEdHlNlyfQLkA8WGfrG83wiC?=
 =?us-ascii?Q?lw22ukEV50lT8bWoOHi7oRfQfR/5mrp+CHBlM63vxDNaO1LuY72ENOVhrZ/g?=
 =?us-ascii?Q?20WKoa1XRWXPClJulzpgVMabnIJI4nxnTshHLFKse9wjRUpbjdeEKEY5WFv/?=
 =?us-ascii?Q?UiSiTYsNewmV5d53o9ZVKeUbEF2Eq0flY1YMDR+288ck37tme3la0SSaEK6x?=
 =?us-ascii?Q?VDqxX4qqmr5TRXOT3i91ocAbs31KWu7k3q49XUig1cnKR+9kyvgeced4ii9Z?=
 =?us-ascii?Q?pB8qhofloKPYm8g7Nin97kwPt9bbjA4K7/Uz4kJaWtBDJ6ihxpakyTD3r2pA?=
 =?us-ascii?Q?C7qGAg7+51zg4gkLZ7vfhStT4Bkc/AQ/DO3OFKThmI01BmUpwifmi01NuUi8?=
 =?us-ascii?Q?fFISsmMIyjRUZLBZJuvsDugNQw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 543d5a7a-64d6-4bdc-b93d-08d89584f584
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 23:09:16.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6YZQGP1S6gsvdMFpl9iOYV1q/9vg4WlkCCdkVyKFxEZuf9ZNnTbZgiIqDfZkqDco
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 suspectscore=1
 mlxlogscore=999 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 02:57:23PM -0800, Yang Shi wrote:
> On Mon, Nov 30, 2020 at 2:53 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Mon, Nov 30, 2020 at 12:57:47PM -0800, Yang Shi wrote:
> > > On Mon, Nov 30, 2020 at 12:09 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > > > On Mon, Nov 30, 2020 at 10:45:14AM -0800, Yang Shi wrote:
> > > > > When investigating a slab cache bloat problem, significant amount of
> > > > > negative dentry cache was seen, but confusingly they neither got shrunk
> > > > > by reclaimer (the host has very tight memory) nor be shrunk by dropping
> > > > > cache.  The vmcore shows there are over 14M negative dentry objects on lru,
> > > > > but tracing result shows they were even not scanned at all.  The further
> > > > > investigation shows the memcg's vfs shrinker_map bit is not set.  So the
> > > > > reclaimer or dropping cache just skip calling vfs shrinker.  So we have
> > > > > to reboot the hosts to get the memory back.
> > > > >
> > > > > I didn't manage to come up with a reproducer in test environment, and the
> > > > > problem can't be reproduced after rebooting.  But it seems there is race
> > > > > between shrinker map bit clear and reparenting by code inspection.  The
> > > > > hypothesis is elaborated as below.
> > > > >
> > > > > The memcg hierarchy on our production environment looks like:
> > > > >                 root
> > > > >                /    \
> > > > >           system   user
> > > > >
> > > > > The main workloads are running under user slice's children, and it creates
> > > > > and removes memcg frequently.  So reparenting happens very often under user
> > > > > slice, but no task is under user slice directly.
> > > > >
> > > > > So with the frequent reparenting and tight memory pressure, the below
> > > > > hypothetical race condition may happen:
> > > > >
> > > > >     CPU A                            CPU B                         CPU C
> > > > > reparent
> > > > >     dst->nr_items == 0
> > > > >                                  shrinker:
> > > > >                                      total_objects == 0
> > > > >     add src->nr_items to dst
> > > > >     set_bit
> > > > >                                      retrun SHRINK_EMPTY
> > > > >                                      clear_bit
> > > > >                                                                   list_lru_del()
> > > > > reparent again
> > > > >     dst->nr_items may go negative
> > > > >     due to current list_lru_del()
> > > > >     on CPU C
> > > > >                                  The second run of shrinker:
> > > > >                                      read nr_items without any
> > > > >                                      synchronization, so it may
> > > > >                                      see intermediate negative
> > > > >                                      nr_items then total_objects
> > > > >                                      may return 0 conincidently
> > > > >
> > > > >                                      keep the bit cleared
> > > > >     dst->nr_items != 0
> > > > >     skip set_bit
> > > > >     add scr->nr_item to dst
> >
> > Btw, I think I have a simpler explanation:
> >
> > A (0 objects)
> > |
> > B (N objects)
> >
> > Let's say the reparenting races with the deletion of a single slab object.
> > list_lru_del() can see parent's lru list and substract 1 from nr_items == 0,
> > setting A's nr_items to -1 (the item is actually still in B's list).
> >
> > memcg_drain_list_lru_node() will check !dst->nr_items && src->nr_items
> > !-1 && N => 0 and not set the bit. But now we have (N-1) objects in A's list
> > and the shrinker bit not set.
> 
> Yes, this is the exact race I elaborated in the commit log.

Yes, the same problem for sure, I just think if we don't need to actually run
into the shrinker code to mentally reproduce it, it's a bit easier model to follow.

> 
> >
> > My proposed fix should resolve it. Alternatively, we maybe can check if
> > dst->nr_items <= 0 and only then set the bit, but it seems to be an unnecessary
> > optimization.
> 
> Yes, I think "src->nr_items != 0" is good enough.

I agree.
