Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5FD72C920F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgK3XIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:08:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18784 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727590AbgK3XIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:08:06 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUN3YnB005132;
        Mon, 30 Nov 2020 15:07:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=jCBPpLbSdD7em7DSUS9kWMuBtoqd8QcY79HnqbFZnNM=;
 b=Qdu85b9Pj1ZeBFy/naVgI69d7MBFbffYZes3lDkk6glWd419qUczjXPUgxOLVdt4jU8e
 vAkgFC22pRtpgyyjPpAOt3mNUz88T7B2tiNoMaSbzurG3h8aRUuZEh1jAC/Yo+8iv4Cp
 3rpzuCEAsgsbbsuPPHLZzRKukBuuNX6X2r4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35478pr1cv-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Nov 2020 15:07:19 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 15:07:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWWlfpqP8PSABplKwgLH30QDnlvw7sATeqTv+w1qHVQSWQnBCHSFcJjdemDEskiMljQFqDbwS5GHWovjxj6WzcnYlaCZCXV0z+NBqi8fp4LgFb6bH6qb0zPj/xT5PiDbr//auY0y1xOPPkYgG2QtM17HUUOU7VyqhGkAayNJ0S/9QICpdW28tDAUoSkl/CPyMBupx/9oQHM0NAgziqmxaArJVLqhnIwIqmnk3cjCMjDmIkwKAmQ44+uOL//41jR6UN4nXvbCtUO01K8HArxG4GzJ6Qmy324LCeB/L0gm1v/0i7HjNMnGe0h8UcpiTFV/X+eMkHskL9PAfueQTi/djA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCBPpLbSdD7em7DSUS9kWMuBtoqd8QcY79HnqbFZnNM=;
 b=Kk4SVaZIIceLyTu1VKYObyS6WlJypICh/E4qaBMM7DGCB1ViV0W3hsQ1925sDaiXFEdM81QK0FlIHYNLGep0sMhCQlbGT0n6HyEJ39RBylfo2Fiqv9SnFINNzp7dV8oVNNJNk1VBtpIzQTbDoEY/yct1R/8YixIz7Vx6YuV5o19MmGM4bRUOkPyLWAIClx6POM7zqkdVXIpALHRUXmbbvIm+jsLFUmbJ2Wi8Mn3MbxK6vCePrigUf5R2mRCJl3CuMnucbuFLJUxGIQZ7enpDYfzrVOJtYiJ4/jXp/X3bkzhQUQXsPUwtkseU3TXSXn1yg2AbLgg0rgv7NEUoYjQITA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCBPpLbSdD7em7DSUS9kWMuBtoqd8QcY79HnqbFZnNM=;
 b=bG/knFY+OSce0AGrvYKlJZavp6OElKXm71JGsN5axx3MXfA0UKNEa97xbLggSTh356m4BLI66UFdjiX6nh/wWJ/vWgAc1PTEdrFhpVWw1qHHmgLaccgUYl7iKowFOl3vy9eWaRYNMJMiARBq9eBtzUh++wxrVix309Pz0+jEPlI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3285.namprd15.prod.outlook.com (2603:10b6:a03:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 30 Nov
 2020 23:07:14 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::3925:e1f9:4c6a:9396%6]) with mapi id 15.20.3611.025; Mon, 30 Nov 2020
 23:07:14 +0000
Date:   Mon, 30 Nov 2020 15:07:09 -0800
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
Message-ID: <20201130230709.GA1375014@carbon.DHCP.thefacebook.com>
References: <20201130184514.551950-1-shy828301@gmail.com>
 <20201130200936.GA1354703@carbon.DHCP.thefacebook.com>
 <CAHbLzkoHqZ0=jFXBt8ByvU2-9wkYe+DfwxD_6ym0gfh4tefZPw@mail.gmail.com>
 <20201130223347.GE840171@carbon.dhcp.thefacebook.com>
 <CAHbLzkpLp+RQrzvBLXW9=xEw1z9hUodu0TqGdjeuhFO0vW=2TA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkpLp+RQrzvBLXW9=xEw1z9hUodu0TqGdjeuhFO0vW=2TA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:6c4e]
X-ClientProxiedBy: CO1PR15CA0059.namprd15.prod.outlook.com
 (2603:10b6:101:1f::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:6c4e) by CO1PR15CA0059.namprd15.prod.outlook.com (2603:10b6:101:1f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 30 Nov 2020 23:07:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d221d5-9961-4986-e3bd-08d89584acc6
X-MS-TrafficTypeDiagnostic: BYAPR15MB3285:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3285B9AD92EC6B95C9055A0ABEF50@BYAPR15MB3285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Xxl7/zWhzr5ltz90Aj2Ub1ZiSp3PupdT8w9yvX34AJldBylPBWLAwDBOgdaEWDsJm6EqkraIEsYFyTmNnTjiFT3f3mzDIdqN5nAlRUMVWGv5JeG8HuoQP1YzepuF+US+NAK8uaTQsboruA75d7+qtKYCqQRAuj8cxdyBusyMc/iUvgfk2TkUuq/Qmvz6BYjhGNk+uUSvXkMC+vceGdbHgLC0wh7wEuIHDNe335lBoQkdVnbYREWMgVH321euxTyOZMchrDbPNSo8awoN1HKng8ZOujXdxTyItGXrBgyPMDJC/OH4Ej3tU8uphus0GIN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(376002)(346002)(66556008)(66476007)(33656002)(5660300002)(8676002)(8936002)(1076003)(4326008)(9686003)(55016002)(478600001)(6666004)(83380400001)(2906002)(7696005)(186003)(53546011)(66946007)(6506007)(316002)(86362001)(54906003)(52116002)(16526019)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hCEdN+6MQvlT2kFdz++86C0gWFcmPhlj9gA+FJRQ1RH9IQmNLzznN/iGxaeL?=
 =?us-ascii?Q?UiK4tFnmtbElCHjbibuXQX7WG/HhneVrG7qzSm3z1ZyN+69q+M+S+3+uB4IH?=
 =?us-ascii?Q?CN94I0/5VTHw18RX7dQxhhpRsAr+feHHnrspKBFCboRxCeQYY0Bb1Jer8mth?=
 =?us-ascii?Q?7GGiVIj5C/roK9c3XKZyETIGOcuikiWeYrURvmmVAn9GLrxWx4vlXGnxyRuE?=
 =?us-ascii?Q?Dj3qmymOog/8iAj+QkQeP7veFnTSbFMPoJ0KeWaC8sO0HQKEOkgTO8Ia7Ue1?=
 =?us-ascii?Q?zjM4qyV4ba7ACTeRDu6Rc9pkSpx0q1qHfTs0pt//CFriCWm86NnvduGIz32p?=
 =?us-ascii?Q?5Mldd2BQ+iTjLQUhwiyetiAFO1uW2cm5Dl4nW5mgYaFAByvGGB2IbGpERouN?=
 =?us-ascii?Q?7kllY13zFcwJ4BT9SOjxrhBqAi8aj/AGo2nXoqc5HibxYbHxgIRTL9aOra6e?=
 =?us-ascii?Q?/6BHaiQgE2MB8dZge5KyOjol77Tple+EFK+MvHFRFNsG5SjHkjevUcD40/BW?=
 =?us-ascii?Q?8A7F44Gdq4IXp4lKZOLxROIoZ/IvMu8v1Nc2rRX32Sc4N3Ab/l5yR6Ij306G?=
 =?us-ascii?Q?USibYolngq4v5+nzejuTsm0tGwSNga3MGIpeRPmGjwk3MieuyOubwICo9JkJ?=
 =?us-ascii?Q?JkgKb+ueyW14QwXeRW2xdpbeR7BMXMRqE/fkZlgYkmrs2AOStJ7EKad1IHM3?=
 =?us-ascii?Q?cev03h30W8NeimjKZKj7MmjUxDpXG1NPn8NXFZCLqrGDwSQ5KUvAWlnliVSy?=
 =?us-ascii?Q?9d7qShNQBNUb03I+ivTOtJn6GK9DYCFVazpcSsCnZjNoKUfyPXx007DBbHtq?=
 =?us-ascii?Q?Rav+78XkQyMRumjcGET3twuByVgnqwZthwyqOuFLfRVBAwBrKzJSXppZ2nrh?=
 =?us-ascii?Q?C5+5hdip6w0vz+o3ZXiQPmAdhb/mvrY7LjreO3u3RlqTx6AhMkQIfs3EB/i9?=
 =?us-ascii?Q?T3nozzXg1OU7ciCbH0m5HKKwCHxVc5nxeJ2ZypzUWp+LFQElqowc/vf5bypV?=
 =?us-ascii?Q?36UhosxjiebaV2YKnsLvjTUnNw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d221d5-9961-4986-e3bd-08d89584acc6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 23:07:14.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sR1I5u12bgRy4XPz6TeHL4m6Ba9GpchWfoiMrG0pvfS92l2sXSKxcx9qJ/zd1Vm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3285
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_12:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=5
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300143
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 02:54:02PM -0800, Yang Shi wrote:
> On Mon, Nov 30, 2020 at 2:33 PM Roman Gushchin <guro@fb.com> wrote:
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
> > > > >
> > > > > After this point dst->nr_item may never go zero, so reparenting will not
> > > > > set shrinker_map bit anymore.  And since there is no task under user
> > > > > slice directly, so no new object will be added to its lru to set the
> > > > > shrinker map bit either.  That bit is kept cleared forever.
> > > > >
> > > > > How does list_lru_del() race with reparenting?  It is because
> > > > > reparenting replaces childen's kmemcg_id to parent's without protecting
> > > > > from nlru->lock, so list_lru_del() may see parent's kmemcg_id but
> > > > > actually deleting items from child's lru, but dec'ing parent's nr_items,
> > > > > so the parent's nr_items may go negative as commit
> > > > > 2788cf0c401c268b4819c5407493a8769b7007aa ("memcg: reparent list_lrus and
> > > > > free kmemcg_id on css offline") says.
> >
> > Also note that since the introduction of the slab reparenting, list_lru_from_kmem()
> > can return the parent lru.
> 
> Do you mean slab charge reparenting or lru reparenting? I think
> list_lru_from_kmem() can return the parent lru since lru reparenting.

objcg reparenting to be precise. It's actually kinda weird now, because
there are two slightly different reparenting mechanisms. We might to
wanna merge them in the future.

> 
> >
> > > > >
> > > > > Can we move kmemcg_id replacement after reparenting?  No, because the
> > > > > race with list_lru_del() may result in negative src->nr_items, but it
> > > > > will never be fixed.  So the shrinker may never return SHRINK_EMPTY then
> > > > > keep the shrinker map bit set always.  The shrinker will be always
> > > > > called for nonsense.
> > > > >
> > > > > Can we synchronize list_lru_del() and reparenting?  Yes, it could be
> > > > > done.  But it seems we need introduce a new lock or use nlru->lock.  But
> > > > > it sounds complicated to move kmemcg_id replacement code under nlru->lock.
> > > > > And list_lru_del() may be called quite often to exacerbate some hot
> > > > > path, i.e. dentry kill.
> > > > >
> > > > > So, it sounds acceptable to synchronize reading nr_items to avoid seeing
> > > > > intermediate negative nr_items given the simplicity and it is typically
> > > > > just called by shrinkers when counting the freeable objects.
> > > > >
> > > > > The patch is tested with some shrinker intensive workloads, no
> > > > > noticeable regression is soptted.
> > > >
> > > > Hi Yang!
> > > >
> > > > It's really tricky, thank you for digging in! It's a perfect analysis!
> > > >
> > > > I wonder though, if it's better to just always set the shrinker bit on reparenting
> > > > if we do reparent some items? Then we'll avoid adding new synchronization
> > > > to the hot path. What do you think?
> > >
> > > Thanks a lot for the suggestion. I was thinking about the same
> > > approach too, but I thought src->nr_items may go zero due to
> > > concurrent list_lru_del() at the first place. But I just rethought the
> > > whole thing, it seems impossible that dst->nr_items goes negative and
> > > src->nr_items goes zero at the same time.
> >
> > Even if it would be possible, it seems less scary: the next reparenting
> > will likely set the bit. So we'll not get into the permanently bad state.
> 
> Unfortunately, no. Once the race happens, reparenting won't set the
> bit anymore since dst->nr_items won't go zero because the shrinker
> will not be called.

I mean if we don't check dst->nr_items. Anyway, because it's an impossible case,
no matter to discuss it :)
