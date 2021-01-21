Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBA52FE1BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 06:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbhAUFdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 00:33:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725829AbhAUFcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 00:32:05 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10L51sXc116161;
        Thu, 21 Jan 2021 00:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=enJxI14Sb0p7wXKtv5BjA0nqn6WNI8xn1QA89qoIAY8=;
 b=rqUxqo8veykDmV1E1mauz+IqSGnmNa5r6ksBbDqESXqWZ9a6mul9xozGDyDLhmIZ7DKV
 0yAoSERkHOrqQhH2z/aAdIYLyH5r7PFoWVJvJf+JE88Pm/3jjSYdG3lBp5V+6kJNR1f6
 uSmMNSP51WvN3LcaweaePjVT5KWMpdSLc4iC8gCQlyO1RUlB10wAO7z74R0chOQHuDHA
 NgWSiFqO3op1QKzqNb1j8T7jyVungZ60drpuixUcKOGbfj/9JeFKGSmwmK9jMLuzGIMi
 07tX2afgLlaCp0PFK6aOsYk2q0OGqK20DQE343YkgbycAQaQnPa5Q+ikA+PM7eTxj3ev sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36730e8tt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 00:31:13 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10L52CPZ117432;
        Thu, 21 Jan 2021 00:31:12 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36730e8tse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 00:31:12 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10L5LVKF006500;
        Thu, 21 Jan 2021 05:31:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3668pasa7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Jan 2021 05:31:10 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10L5V72U23200016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jan 2021 05:31:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D385C42045;
        Thu, 21 Jan 2021 05:31:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 924294203F;
        Thu, 21 Jan 2021 05:31:05 +0000 (GMT)
Received: from in.ibm.com (unknown [9.79.213.236])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 21 Jan 2021 05:31:05 +0000 (GMT)
Date:   Thu, 21 Jan 2021 11:00:03 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        vbabka@suse.cz, shakeelb@google.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210121053003.GB2587010@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-21_02:2021-01-20,2021-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101210020
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:36:31PM +0100, Vincent Guittot wrote:
> Hi,
> 
> On Wed, 18 Nov 2020 at 09:28, Bharata B Rao <bharata@linux.ibm.com> wrote:
> >
> > The page order of the slab that gets chosen for a given slab
> > cache depends on the number of objects that can be fit in the
> > slab while meeting other requirements. We start with a value
> > of minimum objects based on nr_cpu_ids that is driven by
> > possible number of CPUs and hence could be higher than the
> > actual number of CPUs present in the system. This leads to
> > calculate_order() chosing a page order that is on the higher
> > side leading to increased slab memory consumption on systems
> > that have bigger page sizes.
> >
> > Hence rely on the number of online CPUs when determining the
> > mininum objects, thereby increasing the chances of chosing
> > a lower conservative page order for the slab.
> >
> > Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> > ---
> > This is a generic change and I am unsure how it would affect
> > other archs, but as a start, here are some numbers from
> > PowerPC pseries KVM guest with and without this patch:
> >
> > This table shows how this change has affected some of the slab
> > caches.
> > ===================================================================
> >                 Current                         Patched
> > Cache   <objperslab> <pagesperslab>     <objperslab> <pagesperslab>
> > ===================================================================
> > TCPv6           53    2                 26    1
> > net_namespace   53    4                 26    2
> > dtl             32    2                 16    1
> > names_cache     32    2                 16    1
> > task_struct     53    8                 13    2
> > thread_stack    32    8                 8     2
> > pgtable-2^11    16    8                 8     4
> > pgtable-2^8     32    2                 16    1
> > kmalloc-32k     16    8                 8     4
> > kmalloc-16k     32    8                 8     2
> > kmalloc-8k      32    4                 8     1
> > kmalloc-4k      32    2                 16    1
> > ===================================================================
> >
> > Slab memory (kB) consumption comparision
> > ==================================================================
> >                         Current         Patched
> > ==================================================================
> > After-boot              205760          156096
> > During-hackbench        629145          506752 (Avg of 5 runs)
> > After-hackbench         474176          331840 (after drop_caches)
> > ==================================================================
> >
> > Hackbench Time (Avg of 5 runs)
> > (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> > ==========================================
> > Current         Patched
> > ==========================================
> > 10.990          11.010
> > ==========================================
> >
> > Measuring the effect due to CPU hotplug
> > ----------------------------------------
> > Since the patch doesn't consider all the possible CPUs for page
> > order calcluation, let's see how affects the case when CPUs are
> > hotplugged. Here I compare a system that is booted with 64CPUs
> > with a system that is booted with 16CPUs but hotplugged with
> > 48CPUs after boot. These numbers are with the patch applied.
> >
> > Slab memory (kB) consumption comparision
> > ===================================================================
> >                         64bootCPUs      16bootCPUs+48HotPluggedCPUs
> > ===================================================================
> > After-boot              390272          159744
> > After-hotplug           -               251328
> > During-hackbench        1001267         941926 (Avg of 5 runs)
> > After-hackbench         913600          827200 (after drop_caches)
> > ===================================================================
> >
> > Hackbench Time (Avg of 5 runs)
> > (hackbench -s 1024 -l 200 -g 200 -f 25 -P)
> > ===========================================
> > 64bootCPUs      16bootCPUs+48HotPluggedCPUs
> > ===========================================
> > 12.554          12.589
> > ===========================================
> >  mm/slub.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> 
> I'm facing significant performances regression on a large arm64 server
> system (224 CPUs). Regressions is also present on small arm64 system
> (8 CPUs) but in a far smaller order of magnitude
> 
> On 224 CPUs system : 9 iterations of hackbench -l 16000 -g 16
> v5.11-rc4 : 9.135sec (+/- 0.45%)
> v5.11-rc4 + revert this patch: 3.173sec (+/- 0.48%)
> v5.10: 3.136sec (+/- 0.40%)
> 
> This is a 191% regression compared to v5.10.
> 
> The problem is that calculate_order() is called a number of times
> before secondaries CPUs are booted and it returns 1 instead of 224.
> This makes the use of num_online_cpus() irrelevant for those cases
> 
> After adding in my command line "slub_min_objects=36" which equals to
> 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> , the regression diseapears:
> 
> 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)

Should we have switched to num_present_cpus() rather than
num_online_cpus()? If so, the below patch should address the
above problem.

From 252b332ccbee7152da1e18f1fff5b83f8e01b8df Mon Sep 17 00:00:00 2001
From: Bharata B Rao <bharata@linux.ibm.com>
Date: Thu, 21 Jan 2021 10:35:08 +0530
Subject: [PATCH] mm/slub: let number of present CPUs determine the slub
 page order

Commit 045ab8c9487b ("mm/slub: let number of online CPUs determine
the slub page order") changed the slub page order to depend on
num_online_cpus() from nr_cpu_ids. However we find that certain
caches (kmalloc) are initialized even before the secondary CPUs
are onlined resulting in lower slub page order and subsequent
regression.

Switch to num_present_cpus() instead.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
Fixes: 045ab8c9487b ("mm/slub: let number of online CPUs determine the slub page order")
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index d9e4e10683cc..2f3e412c849d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3433,7 +3433,7 @@ static inline int calculate_order(unsigned int size)
 	 */
 	min_objects = slub_min_objects;
 	if (!min_objects)
-		min_objects = 4 * (fls(num_online_cpus()) + 1);
+		min_objects = 4 * (fls(num_present_cpus()) + 1);
 	max_objects = order_objects(slub_max_order, size);
 	min_objects = min(min_objects, max_objects);
 
-- 
2.26.2



