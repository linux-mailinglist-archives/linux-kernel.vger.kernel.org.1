Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6510B301334
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 06:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbhAWFRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 00:17:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725287AbhAWFRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 00:17:09 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10N52MWO156466;
        Sat, 23 Jan 2021 00:16:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=ZQsy86RAvRtqIUQoqjMh4KCy18QmyIQIKPpcv3T6VTE=;
 b=iX/feD1P2IOnJhwWikIozd/eSCuBek8BoVLUs83rT2Hc7zyrPaYWWrgxuB6rH7WeGIkt
 9iZfS2RL9lkoZophr+4R4pTp0If9UqdK4tpoRAVhl7xtNApkkHxr1bSUuTuSQyxGHfCi
 ygHTBg6QqU0VPuG+KjoX7eri8i1jtsxzTgP2yANiW8XlAX4Mdj+Ob9Ts5FagFnnzfdaU
 tYWZSQJIjGWvLd8OSyTPn3sPRhNgJNB5Ko6t2U6Z05PHYk3nF4ujf+uFaTvkj1VZnLXs
 Ub5UrB7mPDhU/dK19j1lLgx5Afo0OQG/oQjw3DJr/O5WHOQQ70lLwMnK9VXkQqN2heLX 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 368d2sge0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 00:16:16 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10N5FDsQ004640;
        Sat, 23 Jan 2021 00:16:16 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 368d2sge0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 00:16:15 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10N5Caix030027;
        Sat, 23 Jan 2021 05:16:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 368be88118-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Jan 2021 05:16:14 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10N5GBf142860842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 23 Jan 2021 05:16:11 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD7BA52050;
        Sat, 23 Jan 2021 05:16:11 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.74.106])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 71C4652052;
        Sat, 23 Jan 2021 05:16:09 +0000 (GMT)
Date:   Sat, 23 Jan 2021 10:46:07 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Christoph Lameter <cl@linux.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210123051607.GC2587010@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-23_01:2021-01-22,2021-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101230023
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 01:03:57PM +0100, Vlastimil Babka wrote:
> On 1/22/21 9:03 AM, Vincent Guittot wrote:
> > On Thu, 21 Jan 2021 at 19:19, Vlastimil Babka <vbabka@suse.cz> wrote:
> >>
> >> On 1/21/21 11:01 AM, Christoph Lameter wrote:
> >> > On Thu, 21 Jan 2021, Bharata B Rao wrote:
> >> >
> >> >> > The problem is that calculate_order() is called a number of times
> >> >> > before secondaries CPUs are booted and it returns 1 instead of 224.
> >> >> > This makes the use of num_online_cpus() irrelevant for those cases
> >> >> >
> >> >> > After adding in my command line "slub_min_objects=36" which equals to
> >> >> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> >> >> > , the regression diseapears:
> >> >> >
> >> >> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
> >>
> >> I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
> >> supposed to be a scheduler benchmark? What exactly is going on?
> >>
> > 
> > From hackbench description:
> > Hackbench is both a benchmark and a stress test for the Linux kernel
> > scheduler. It's  main
> >        job  is  to  create a specified number of pairs of schedulable
> > entities (either threads or
> >        traditional processes) which communicate via either sockets or
> > pipes and time how long  it
> >        takes for each pair to send data back and forth.
> 
> Yep, so I wonder which slab entities this is stressing that much.
> 
> >> Things would be easier if we could trust *on all arches* either
> >>
> >> - num_present_cpus() to count what the hardware really physically has during
> >> boot, even if not yet onlined, at the time we init slab. This would still not
> >> handle later hotplug (probably mostly in a VM scenario, not that somebody would
> >> bring bunch of actual new cpu boards to a running bare metal system?).
> >>
> >> - num_possible_cpus()/nr_cpu_ids not to be excessive (broken BIOS?) on systems
> >> where it's not really possible to plug more CPU's. In a VM scenario we could
> >> still have an opposite problem, where theoretically "anything is possible" but
> >> the virtual cpus are never added later.
> > 
> > On all the system that I have tested num_possible_cpus()/nr_cpu_ids
> > were correctly initialized
> > 
> > large arm64 acpi system
> > small arm64 DT based system
> > VM on x86 system
> 
> So it's just powerpc that has this issue with too large nr_cpu_ids? Is it caused
> by bios or the hypervisor? How does num_present_cpus() look there?

PowerPC PowerNV Host: (160 cpus)
num_online_cpus 1 num_present_cpus 160 num_possible_cpus 160 nr_cpu_ids 160 

PowerPC pseries KVM guest: (-smp 16,maxcpus=160)
num_online_cpus 1 num_present_cpus 16 num_possible_cpus 160 nr_cpu_ids 160 

That's what I see on powerpc, hence I thought num_present_cpus() could
be the correct one to use in slub page order calculation.

> 
> What about heuristic:
> - num_online_cpus() > 1 - we trust that and use it
> - otherwise nr_cpu_ids
> Would that work? Too arbitrary?

Looking at the following snippet from include/linux/cpumask.h, it
appears that num_present_cpus() should be reasonable compromise
between online and possible/nr_cpus_ids to use here.

/*
 * The following particular system cpumasks and operations manage
 * possible, present, active and online cpus.
 *
 *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
 *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
 *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
 *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
 *
 *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
 *
 *  The cpu_possible_mask is fixed at boot time, as the set of CPU id's
 *  that it is possible might ever be plugged in at anytime during the
 *  life of that system boot.  The cpu_present_mask is dynamic(*),
 *  representing which CPUs are currently plugged in.  And
 *  cpu_online_mask is the dynamic subset of cpu_present_mask,
 *  indicating those CPUs available for scheduling.
 *
 *  If HOTPLUG is enabled, then cpu_possible_mask is forced to have
 *  all NR_CPUS bits set, otherwise it is just the set of CPUs that
 *  ACPI reports present at boot.
 *
 *  If HOTPLUG is enabled, then cpu_present_mask varies dynamically,
 *  depending on what ACPI reports as currently plugged in, otherwise
 *  cpu_present_mask is just a copy of cpu_possible_mask.
 *
 *  (*) Well, cpu_present_mask is dynamic in the hotplug case.  If not
 *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
 */

So for host systems, present is (usually) equal to possible and for
guest systems present should indicate the CPUs found to be present
at boottime. The intention of my original patch was to use this
metric in slub page order calculation rather than nr_cpus_ids
or num_cpus_possible() which could be high on guest systems that
typically support CPU hotplug.

Regards,
Bharata.
