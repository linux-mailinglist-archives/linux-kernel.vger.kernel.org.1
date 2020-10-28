Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD1C29D3AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgJ1VqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:46:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726459AbgJ1Vpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:45:50 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09S5WWkO004053;
        Wed, 28 Oct 2020 01:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : mime-version : content-type; s=pp1;
 bh=YPe3avegKNPJIUROW0vifdqTsXY0DhxKdJ1AJeLXLiM=;
 b=FIKQZdD3hRTngZRgZP3DEgEeNj8ypvamoYrqgN2nL0IywLHUCTw6cJIDRDPPGTMTX+IU
 N9LPSwYnjNzIJknASjToY2DKcE6xI96VMD4UZd6gSHlNvLvkibLae/KOk1RRnu/rZENM
 49cLQ2sgdNAdOJ9EiDOzK967OnFM9iOrzTk85w3svJC1A4x+gZzsYeiEG2hBzfON5JL8
 d71BxwFZENT3HzLvJ0fTm+5le5HQD9qR/4ah/+j79lFcxZXSShvqJWqRiKBimhXwB7OT
 9YiPV37SMIuJ6iVhtjv9h3HLgjGT8b7BH1ro8T1Gx5lAvrxco+pEkpPPTKnsVayKeJE6 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34emb59sqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 01:50:39 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09S5WWgV003986;
        Wed, 28 Oct 2020 01:50:39 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34emb59sq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 01:50:39 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09S5ipL4002083;
        Wed, 28 Oct 2020 05:50:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 34ejqe8dy5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 05:50:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09S5oYbI37028170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 05:50:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 432E952051;
        Wed, 28 Oct 2020 05:50:34 +0000 (GMT)
Received: from in.ibm.com (unknown [9.77.207.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 560395204E;
        Wed, 28 Oct 2020 05:50:32 +0000 (GMT)
Date:   Wed, 28 Oct 2020 11:20:30 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, cl@linux.com, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, guro@fb.com,
        vbabka@suse.cz, shakeelb@google.com, hannes@cmpxchg.org,
        aneesh.kumar@linux.ibm.com
Subject: Higher slub memory consumption on 64K page-size systems?
Message-ID: <20201028055030.GA362097@in.ibm.com>
Reply-To: bharata@linux.ibm.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-28_01:2020-10-26,2020-10-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=3
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On POWER systems, where 64K PAGE_SIZE is default, I see that slub
consumes higher amount of memory compared to any 4K page-size system.
While slub is obviously going to consume more memory on 64K page-size
systems compared to 4K as slabs are allocated in page-size granularity,
I want to check if there are any obvious tuning (via existing tunables
or via some code change) that we can do to reduce the amount of memory
consumed by slub.

Here is a comparision of the slab memory consumption between 4K and
64K page-size pseries hash KVM guest with 16 cores and 16G memory
configuration immediately after boot:

64K	209280 kB
4K	67636 kB

64K configuration may never be able to consume as less as a 4K configuration,
but it certainly shows that the slub can be optimized for 64K page-size better.

slub_max_order
--------------
The most promising tunable that shows consistent reduction in slab memory
is slub_max_order. Here is a table that shows the number of slabs that
end up with different orders and the total slab consumption at boot
for different values of slub_max_order:
-------------------------------------------
slub_max_order	Order	NrSlabs	Slab memory
-------------------------------------------
		0	276
	3	1	16	207488 kB
    (default)	2	4
		3	11
-------------------------------------------
		0	276
	2	1	16	166656 kB
		2	4
-------------------------------------------
		0	276	144128 kB
	1	1	31
-------------------------------------------

Though only a few bigger sized caches fall into order-2 or order-3, they
seem to make a considerable difference to the overall slab consumption.
If we take task_struct cache as an example, this is how it ends up when
slub_max_order is varied:

task_struct, objsize=9856
--------------------------------------------
slub_max_order	objperslab	pagesperslab
--------------------------------------------
3		53		8
2		26		4
1		13		2
--------------------------------------------

The slab page-order and hence the number of objects in a slab has a
bearing on the performance, but I wonder if some caches like task_struct
above can be auto-tuned to fall into a conservative order and do good
both wrt both memory and performance?

mm/slub.c:calulate_order() has the logic which determines the the
page-order for the slab. It starts with min_objects and attempts
to arrive at the best configuration for the slab. The min_objects
is starts like this:

min_objects = 4 * (fls(nr_cpu_ids) + 1);

Here nr_cpu_ids depends on the maxcpus and hence this can have a
significant effect on those systems which define maxcpus. Slab numbers
post-boot for a KVM pseries guest that has 16 boottime CPUs and varying
number of maxcpus look like this:
-------------------------------
maxcpus		Slab memory(kB)
-------------------------------
64		209280
256		253824
512		293824
-------------------------------

Page-order is a one time setting and obviously can't be tweaked dynamically
on CPU hotplug, but just wanted to bring out the effect of the same.

And that constant multiplicative factor of 4 was infact added by the commit
9b2cd506e5f2 - "slub: Calculate min_objects based on number of processors."

Reducing that to say 2, does give some reduction in the slab memory
and also same hackbench performance with reduced slab memory, but I am not
sure if that could be assumed to be beneficial for all scenarios.

MIN_PARTIAL
-----------
This determines the number of slabs left on the partial list even if they
are empty. My initial thought was that the default MIN_PARTIAL value of 5
is on the higher side and we are accumulating MIN_PARTIAL number of
empty slabs in all caches without freeing them. However I hardly find
the case where an empty slab is retained during freeing on account of
partial slabs being lesser than MIN_PARTIAL.

However what I find in practice is that we are accumulating a lot of partial
slabs with just one in-use object in the whole slab. High number of such
partial slabs is indeed contributing to the increased slab memory consumption.

For example, after a hackbench run, I find the distribution of objects
like this for kmalloc-2k cache:

total_objects		3168
objects			1611
Nr partial slabs	54
Nr parital slabs with
just 1 inuse object	38

With 64K page-size, so many partial slabs with just 1 inuse object can
result in high memory usage. Is there any workaround possible prevent this
kind of situation?

cpu_partial
-----------
Here is how the slab consumption post-boot varies when all the slab
caches are forced with the fixed cpu_partial value:
---------------------------
cpu_partial	Slab Memory
---------------------------
0		175872 kB
2		187136 kB
4		191616 kB
default		204864 kB
---------------------------

It has been suggested earlier that reducing cpu_partial and/or making
cpu_partial 64K page-size aware will benefit. In set_cpu_partial(),
for bigger sized slabs (size > PAGE_SIZE), cpu_partial is already set
to 2. A bit of tweaking there to introduce cpu_partial=1 for certain
slabs does give some benefit.

diff --git a/mm/slub.c b/mm/slub.c
index a28ed9b8fc61..e09eff1199bf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3626,7 +3626,9 @@ static void set_cpu_partial(struct kmem_cache *s)
         */
        if (!kmem_cache_has_cpu_partial(s))
                slub_set_cpu_partial(s, 0);
-       else if (s->size >= PAGE_SIZE)
+       else if (s->size >= 8192)
+               slub_set_cpu_partial(s, 1);
+       else if (s->size >= 4096)
                slub_set_cpu_partial(s, 2);
        else if (s->size >= 1024)
                slub_set_cpu_partial(s, 6);

With the above change, the slab consumption post-boot reduces to 186048 kB.
Also, here are the hackbench numbers with and w/o the above change:

Average of 10 runs of 'hackbench -s 1024 -l 200 -g 200 -f 25 -P'
Slab consumption captured at the end of each run
--------------------------------------------------------------
		Time		Slab memory
--------------------------------------------------------------
Default		11.124s		645580 kB
Patched		11.032s		584352 kB
--------------------------------------------------------------

I have mostly looked at reducing the slab memory consumption here.
But I do understand that default tunable values have been arrived
at based on some benchmark numbers. Are there ways or possibilities
to reduce the slub memory consumption with the existing level of
performance is what I would like to understand and explore.

Regards,
Bharata.
