Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B869029413C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390578AbgJTRRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:17:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48230 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390535AbgJTRRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:17:48 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09KHEMt6026349;
        Tue, 20 Oct 2020 10:17:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=7DvJejlDHSjkgi47GxBXQrOaEMENuGwHXs5uGdOaLyw=;
 b=KAjr1dAr5ZTm8nXq0uehracToFo5QlNgGG8zy3pXG31HboGRnChiyMtUsjPip/eLRlTJ
 iIa/XB2jFL4AW8E5iGq2ofwQKbfh5g+Scili4pOLsoLO3kOb7UMF/EITqW8D4ysXP7qu
 ocCcpJz9/Yh4PT3CPpOc8gTB+DdnCdC0rM0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34a01e1g24-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Oct 2020 10:17:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 20 Oct 2020 10:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeoFsyk8rqAHw/uykbPCSDK7Pq2XQuFb5a4ii/RPnIPL019TGqdxI/x8k5vu5tdqYYcikz6Qb21NCnBxZY4GxF/gvvykpEwQchy24OfMrCxGA19STaIaBt5trOmueLGMea7e+PZMi16deOM2MCV/+FgdduaGSNBztbELhg6PSKBFhBdejhmWZBoLV9P/86A1YQWkmr1q50+/PeyEpeMFQmCvyv6oJaXSabLMVIMVCtC6Dy01W/v1ftSrlGwU7HRnUMSlbWG6joxMe1LMNfZmDrPxutzTcCisv+MjHibRuNNISaX/oUPwwff+9M7zQm7VkXU5d/GiKOcdZZWJvyMScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DvJejlDHSjkgi47GxBXQrOaEMENuGwHXs5uGdOaLyw=;
 b=gsjH54zt6VcVTafMJ+uASOxGSP8/WItpux9gcKMOsaNjvt4zusme5rnHH95OU+yw3+9YYdCiuvVYyGvUrTnZg9G0VjgHCIUAeG4cUI2EjfZwkjW61ksajaaBn93fmxv+ByVvspsg1RsG8fMr+LndXLIhgylH73Q6v6ZSe8b42pgx4iRv9S0PnuJqvOYbfCX9UdNHn0ij9Acbv9mG7UANVv3hYn7WRsLQEr+uyXemNRHLFWlCrzJq0OfMy1a0/KMh3T4DiOt7YVkddIXsHjlOAH8uwrx4QL8PwFk6LO6LRU1CmxtV25gPsSu9C6VY4Hu3C+/gQJX9V3Yvw+jJagLc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7DvJejlDHSjkgi47GxBXQrOaEMENuGwHXs5uGdOaLyw=;
 b=PaDqVN68PKd83Kpt+WJDgqQVPKHmh9JALY/e7QwgxMN4OAYM+/lCB/vcAfBnTi7HhCO7uWGGw+ivpGJzcrUERuvn05I4JSlp561M8zj3pj5keAKNVAXhWjEvEsS/N7RiEK2h4GbqC/BrBSqLzGo5Ly2TIF6ShUPc+r87EYs0+9M=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4155.namprd15.prod.outlook.com (2603:10b6:a03:2ee::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 17:17:19 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 17:17:19 +0000
Date:   Tue, 20 Oct 2020 10:17:14 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        LTP List <ltp@lists.linux.it>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201020171714.GB153102@carbon.DHCP.thefacebook.com>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook>
 <20201016145308.GA312010@cmpxchg.org>
 <20201016171502.GA102311@blackbook>
 <20201019222845.GA64774@carbon.dhcp.thefacebook.com>
 <CALvZod66ETQR2rKhZQfEZwdovuF0AaVTZ1g1JNjkLgLGgMKY8g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod66ETQR2rKhZQfEZwdovuF0AaVTZ1g1JNjkLgLGgMKY8g@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:41b5]
X-ClientProxiedBy: MWHPR22CA0041.namprd22.prod.outlook.com
 (2603:10b6:300:69::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.DHCP.thefacebook.com (2620:10d:c090:400::5:41b5) by MWHPR22CA0041.namprd22.prod.outlook.com (2603:10b6:300:69::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 20 Oct 2020 17:17:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb3f56e2-4784-48fb-3da1-08d8751c0001
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4155:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB41555219836FD2B9C395EEE6BE1F0@SJ0PR15MB4155.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuUIpzhhcwXYSTGlIdkHYF4Omk/b3yC/A6WtFYpoGFUo8Gxvo+z6O+s0pPhuUHOEi2QPYH2E8klQDJqa9RXX4np3qjOD1Fj3OOta4MJ4HjuSrwkl8tefLR9e06IiSmF66Y9/08QIqPUCRZpWGRNqczLxjWT8a4dYu4FyT3eUctKc3cQEFy84zqyqHexQqZ0zaeMad3UKuv249OnhDMNYKxma/6clwD2daBRJGq1zHiuIier7O7sr558uqm2xIjAdnle+6dCovtjgwoawqHMnQNdbNRxii1lXfmzV5BaGJTiwdRz8AYdKK/DqvbSSnWSC/VbP/MmXLA5woWBQy1X+kw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(136003)(346002)(39860400002)(33656002)(6666004)(7416002)(66946007)(66476007)(66556008)(16526019)(83380400001)(86362001)(478600001)(54906003)(5660300002)(2906002)(8936002)(1076003)(316002)(4326008)(55016002)(53546011)(6506007)(9686003)(8676002)(6916009)(52116002)(7696005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cgpaODUgWbLZyJrWD5r1+OhRhS3gXVHQ3hWvJTZKdb9WHkcMTKAwdCM0V5TZSaAwOHWULV40sJKxGa6KKU9VWqTXJTs18WF6E5zAJWjLRqfWXgJxJZL8eCy6ZxlAfOLaZjQIlOC/lpDiaKxms3miiHdE3RRZvw0rvBUEpym6R6ZNKEq4X/AGRbIqdk9Dbx9/kUV03642C5iijo4KI1wL+8UEftzulfg0lMtvbhLr/eu0BrZ3hZzu7acy4DFRSVixi5cR1uwol6mzfk0ZF3HFfaL6Y1D8ypWe9gbtgS43uGfQUzOMZYw0aIcc0RoNlaB8hlVC6MyBX+70j5eB4/rGYT4cHSdk9gc+xXZ5RnpyvT3L5Gy3XJOlpEHwXzjlIFwzi6hHxRKfNleI2syA+VGqhGxYShNb6LVcY+8usFAlbhEd6wQyRMsGgxIhLHJBOK2YAWujGmT43i7Flbal5gYJ/+5c/2D7Qp2lZr4HFrdqQh2kHv0b8Q+3Cw9yEKEbClFI0E06uGGdrGDDRsCQHWyXEg2qvyWIJk39+CO7tbxbW0aETiwoDWH5DAzMzoNsSwTMEE05R0nQymF3Y+xT5354LrIHRPyyfNxDDKJZLzTtqUgUkXSqpwb9g2+Go5kgqZ7gcz8XB4t/+pZPk0TjowLBvbNo3+pb0vAs9LTOtccHWkY=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3f56e2-4784-48fb-3da1-08d8751c0001
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 17:17:19.4089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDAVKpvKmjnV4MjDrmFZYpn4y8U/+oOu1fODNF5r6IX/wxTP9I50NU3Ga83hJ9Sz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4155
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-20_10:2020-10-20,2020-10-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxlogscore=574
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010200118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:55:38AM -0700, Shakeel Butt wrote:
> On Mon, Oct 19, 2020 at 3:28 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 07:15:02PM +0200, Michal Koutny wrote:
> > > On Fri, Oct 16, 2020 at 10:53:08AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > The central try_charge() function charges recursively all the way up
> > > > to and including the root.
> > > Except for use_hiearchy=0 (which is the case here as Richard
> > > wrote). The reparenting is hence somewhat incompatible with
> > > new_parent.use_hiearchy=0 :-/
> > >
> > > > We should clean this up one way or another: either charge the root or
> > > > don't, but do it consistently.
> > > I agree this'd be good to unify. One upside of excluding root memcg from
> > > charging is that users are spared from the charging overhead when memcg
> > > tree is not created.  (Actually, I thought that was the reason for this
> > > exception.)
> >
> > Yeah, I'm completely on the same page. Moving a process to the root memory
> > cgroup is currently a good way to estimate the memory cgroup overhead.
> >
> > How about the patch below, which consistently avoids charging the root
> > memory cgroup? It seems like it doesn't add too many checks.
> >
> > Thanks!
> >
> > --
> >
> > From f50ea74d8f118b9121da3754acdde630ddc060a7 Mon Sep 17 00:00:00 2001
> > From: Roman Gushchin <guro@fb.com>
> > Date: Mon, 19 Oct 2020 14:37:35 -0700
> > Subject: [PATCH RFC] mm: memcontrol: do not charge the root memory cgroup
> >
> > Currently the root memory cgroup is never charged directly, but
> > if an ancestor cgroup is charged, the charge is propagated up to the
> > root memory cgroup. The root memory cgroup doesn't show the charge
> > to a user, neither it does allow to set any limits/protections.
> > So the information about the current charge is completely useless.
> >
> > Avoiding to charge the root memory cgroup allows to:
> > 1) simplify the model and the code, so, hopefully, fewer bugs will
> >    be introduced in the future;
> > 2) avoid unnecessary atomic operations, which are used to (un)charge
> >    corresponding root page counters.
> >
> > In the default hierarchy case or if use_hiearchy == true, it's very
> > straightforward: when the page counters tree is traversed to the root,
> > the root page counter (the one with parent == NULL), should be
> > skipped. To avoid multiple identical checks over the page counters
> > code, for_each_nonroot_ancestor() macro is introduced.
> >
> > To handle the use_hierarchy == false case without adding custom
> > checks, let's make page counters of all non-root memory cgroup
> > direct ascendants of the corresponding root memory cgroup's page
> > counters. In this case for_each_nonroot_ancestor() will work correctly
> > as well.
> >
> > Please, note, that cgroup v1 provides root level memory.usage_in_bytes.
> > However, it's not based on page counters (refer to mem_cgroup_usage()).
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> 
> This patch is only doing the page counter part of the cleanup (i.e. to
> not update root's page counters when descendent's page counter is
> updated) but not the stats part.
> 
> For the user memory, we do update the stats for the root memcg and do
> set page->mem_cgroup = root_mem_cgroup. However this is not done for
> the kmem/obj. I thought this is what Johannes was asking for the
> cleanup.

Yes, it's not the whole story, of course.

Actually I missed that we do export root kmem and tcpmem counters
on cgroup v1 (thanks Michal to pointing at it!). If we want them to function
properly, we have to go into the opposite direction and start charging
the root cgroup for all kinds of kernel memory allocations.

We also have the same problem with root MEMCG_SOCK stats, which seems
to be broken now.

I'll master a patch.

Thanks!
