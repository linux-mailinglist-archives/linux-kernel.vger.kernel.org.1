Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC25D29537E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505364AbgJUUdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:33:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:5864 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2505357AbgJUUdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:33:08 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09LKFMJk007252;
        Wed, 21 Oct 2020 13:32:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=fCi9AMGFPIX1uSknab2Hq3nN3r6mzRtmNfU+5+32G6A=;
 b=SJKE1tVsQhe141Pglwo/RrITehuHsdDL7NDgvIXv6oVwPLgS/BPtufekjNKkllQNnd9q
 c7C8gUdO6b9Zxc73w22oeEqPSMO0qjwbGCDg7aFI6QeNFKbEK1v+ZqNXOuXm3EqNvSHd
 Rc4+r3u/cMxR8kAMtiGtT2Q9I99syCxws3U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34a57ypt0f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 21 Oct 2020 13:32:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 21 Oct 2020 13:32:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehCvbu7SKGhRMCGCDkmW7sGbbginns2qr8peX7U0gd45mtFWFAtUEfynUtoYwl8lX63Yse+qak7cPbZm8OkDxsPBNjMZaP7jOxfBeJAs5cp+mi1/GsCFFL8OaqvRHMWHM3I+nETAlqin80id/tdn+tzYr8XH8eUdtklmmh6a50E5wPEwlCL8uL63AfvC0XTkdH4Rm/vtSRiU3tj0foi81gucMrK/APIIeSPaHDF97rh9dCCT9p/OLk0uoFShWxSdgXhbaUgy+IxUi8jJCrWbETKkHJKSkEzl+C76Lc8EttiudxhlkhaEQxenpo5u1DQtebXnfTGtI58eYJxbTCrSyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCi9AMGFPIX1uSknab2Hq3nN3r6mzRtmNfU+5+32G6A=;
 b=KQyZpADSHGx9tEAcL9UYeBSsBKzHagY9oxAYSZRJ6Jhv2eocmOZNEho2KJZJyZlw+WbQDtW24SUdchEpiT3ub9n30JBv1mJrcCmvHuY9GHolrxrl6eyYAQwuvXH9ELgzoY+/CCUzJWooSv6jt2ihew6xJaZUNfIL4d5B3yeFP6n6L9bIInHTj5eOLdCOmHziCS/ptIxHVAe1XX2TogxrlD7i9eJSDgR+IufZqkWxvWVvzjOlN9C33oan8UGdmVm5xxxE1u231wUB9iQiWxrbHrtsb1WgS1t+audkb07+uYeX4oPazn1x4bI7AA6C2jxaKIle6EtwglSPI71mEYraKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCi9AMGFPIX1uSknab2Hq3nN3r6mzRtmNfU+5+32G6A=;
 b=VL5G2bT0FzJ/gFXPSEjGr6wrwRBQofriB+MeDmJg7q/CD6bJaMYp5LMEJ8hQxaR1g1mZRqwcySnXkpUTFua+iTGu2xwqaTjOVuw/PYZHyZtjA5jaPfTKeQ/XOfbzTu9IsVJyt5QcK0Lplnku55iNq7Tco6ly2UVIGLP6zIGzxF0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2341.namprd15.prod.outlook.com (2603:10b6:a02:81::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 20:32:36 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::d834:4987:4916:70f2%5]) with mapi id 15.20.3477.028; Wed, 21 Oct 2020
 20:32:36 +0000
Date:   Wed, 21 Oct 2020 13:32:31 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     <rpalethorpe@suse.de>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] mm: memcg/slab: Stop reparented obj_cgroups from
 charging root
Message-ID: <20201021203231.GB300658@carbon.dhcp.thefacebook.com>
References: <87lfg2ob83.fsf@suse.de>
 <20201019095812.25710-1-rpalethorpe@suse.com>
 <CALvZod6FNH3cZfZxLSFXtQR5bV_2Tese0793Ve9rd1YNW22MKg@mail.gmail.com>
 <87mu0hwik7.fsf@suse.de>
 <87eeltvwg4.fsf@suse.de>
 <CALvZod45mAzyo9LNR4YtX_3J0gZJDagYTNv8NbJAuXzwK5A2DA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod45mAzyo9LNR4YtX_3J0gZJDagYTNv8NbJAuXzwK5A2DA@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:5b8e]
X-ClientProxiedBy: MWHPR21CA0034.namprd21.prod.outlook.com
 (2603:10b6:300:129::20) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:5b8e) by MWHPR21CA0034.namprd21.prod.outlook.com (2603:10b6:300:129::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.17 via Frontend Transport; Wed, 21 Oct 2020 20:32:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fa12978-4caf-45f0-26c3-08d876007232
X-MS-TrafficTypeDiagnostic: BYAPR15MB2341:
X-Microsoft-Antispam-PRVS: <BYAPR15MB2341E3D5FDB398B9C6249A12BE1C0@BYAPR15MB2341.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5CamJFx4qvJwSSTy4hEfgaUZxm2tvnhGOEhrEZ1oup8xqH+XIEknGXIBSJmKMUDtIn/X4KFuJorHO6KtFms6+ICGiZT2V3v7lX4GcN5M/2onrz1BRz3WRyL52ReQzLuBsXSPUW0V8vs4OlfWwEO5XxILCal4BN/twyOTHqTiIvE8ljxuG5Z6xgy+JbJzhoJ4pYZx2ILWWGYHPgqZ5EGt80RIn3iEsp/DKSdgcazXub3w1kcro/LEuzwqvE+EEtYPXyapl6m7yXaPXk+60AgUwm3HtiUKfF6WK3mlhCCKNrj7wFNUtpEN0GROW9N7Rz+1eFYjAYIhZBm8dQDXR0wyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(136003)(376002)(346002)(396003)(83380400001)(16526019)(7696005)(86362001)(66476007)(52116002)(478600001)(54906003)(8676002)(186003)(4326008)(55016002)(8936002)(316002)(33656002)(1076003)(53546011)(66946007)(5660300002)(9686003)(6916009)(7416002)(66556008)(6506007)(2906002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xt+7WFB8+Ed4JahbfFpIiHznjBXkG4xqXE8QKMXkpJv5KJR48KEvg7CdI+LCetmu2gVo/T71JDx9N/3l2ETOzW/UPu/NCTYjdq+vxFQr3QcNNCHgajQ0hGK1AcyhOSYOlxR7hd+KYbG/a+N/Um4AVj9i/P7Htu1Gjd8TCJIS9tp7NKxYc10mq0Qq5oEJKq5X2cbDsp1rmu1NvMPK9JIsoHb7i1UUHcVbndx18RQOns5Onvf4cijIePX9m9WvXN2iZ4TnY+vPigngJIJINgXLhGRtLWqAZnpMsEcirHobIv6EyzXIItkvwkMbtjsGNzJx2iZMm74KEzSeZxl5hqnMZSwSaQJ4Q/B/NLjgJ0B+IH066t6sXYMTfVIFaeNEWdUjT0+dYWswNIYI9X88hkJ/mkWoHzCviV0Kmli+VAYNy0efUzR/LWIlS3mYgq4MG+CMLucln+cA/6PiHzEwKGTLhkuFX+SCRGthpgUvQgnEzZ7YymW6ty2mS3vmBkpuF/m6z43blN/nDyUPPm0V3gMxWMU15Cl+3FpFecrO4rlH+sNMf9+YQcdo9AbFqs5o3Wg9asZYyz3RE/3hAFGSF/z3u5rKTtIkc96hJPsjUBySQ4OsIj7XCb//T4Xl+xEwmlvLAJEVlv171M7qFvj9VmsgAmHSAN8Fw6XGSG+JgnaSwA4=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa12978-4caf-45f0-26c3-08d876007232
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 20:32:36.3000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4KsohI7cEHjPD2pZ2mIoyqvvnHAe2+h+lezoc4yE1SEbMI8C4tFGagqDqkXsPPQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2341
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_12:2020-10-20,2020-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 clxscore=1011 adultscore=0 priorityscore=1501 suspectscore=1
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010210141
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:56:51AM -0700, Shakeel Butt wrote:
> On Tue, Oct 20, 2020 at 6:49 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >
> > Hello,
> >
> > Richard Palethorpe <rpalethorpe@suse.de> writes:
> >
> > > Hello Shakeel,
> > >
> > > Shakeel Butt <shakeelb@google.com> writes:
> > >>>
> > >>> V3: Handle common case where use_hierarchy=1 and update description.
> > >>>
> > >>>  mm/memcontrol.c | 7 +++++--
> > >>>  1 file changed, 5 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > >>> index 6877c765b8d0..34b8c4a66853 100644
> > >>> --- a/mm/memcontrol.c
> > >>> +++ b/mm/memcontrol.c
> > >>> @@ -291,7 +291,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> > >>>
> > >>>         spin_lock_irqsave(&css_set_lock, flags);
> > >>>         memcg = obj_cgroup_memcg(objcg);
> > >>> -       if (nr_pages)
> > >>> +       if (nr_pages && (!mem_cgroup_is_root(memcg) || memcg->use_hierarchy))
> > >>
> > >> If we have non-root memcg with use_hierarchy as 0 and this objcg was
> > >> reparented then this __memcg_kmem_uncharge() can potentially underflow
> > >> the page counter and give the same warning.
> > >
> > > Yes, although the kernel considers such a config to be broken, and
> > > prints a warning to the log, it does allow it.
> >
> > Actually this can not happen because if use_hierarchy=0 then the objcg
> > will be reparented to root.
> >
> 
> Yup, you are right. I do wonder if we should completely deprecate
> use_hierarchy=0.

+1

Until that happy time maybe we can just link all page counters
to root page counters if use_hierarchy == false?
That would solve the original problem without complicating the code
in the main use_hierarchy == true mode.

Are there any bad consequences, which I miss?

Thanks!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2636f8bad908..fbbc74b82e1a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5339,17 +5339,22 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
                memcg->swappiness = mem_cgroup_swappiness(parent);
                memcg->oom_kill_disable = parent->oom_kill_disable;
        }
-       if (parent && parent->use_hierarchy) {
+       if (!parent) {
+               page_counter_init(&memcg->memory, NULL);
+               page_counter_init(&memcg->swap, NULL);
+               page_counter_init(&memcg->kmem, NULL);
+               page_counter_init(&memcg->tcpmem, NULL);
+       } else if (parent->use_hierarchy) {
                memcg->use_hierarchy = true;
                page_counter_init(&memcg->memory, &parent->memory);
                page_counter_init(&memcg->swap, &parent->swap);
                page_counter_init(&memcg->kmem, &parent->kmem);
                page_counter_init(&memcg->tcpmem, &parent->tcpmem);
        } else {
-               page_counter_init(&memcg->memory, NULL);
-               page_counter_init(&memcg->swap, NULL);
-               page_counter_init(&memcg->kmem, NULL);
-               page_counter_init(&memcg->tcpmem, NULL);
+               page_counter_init(&memcg->memory, &root_mem_cgroup->memory);
+               page_counter_init(&memcg->swap, &root_mem_cgroup->swap);
+               page_counter_init(&memcg->kmem, &root_mem_cgroup->kmem);
+               page_counter_init(&memcg->tcpmem, &root_mem_cgroup->tcpmem);
                /*
                 * Deeper hierachy with use_hierarchy == false doesn't make
                 * much sense so let cgroup subsystem know about this

