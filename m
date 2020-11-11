Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4032AEC95
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgKKJEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:04:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgKKJEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:04:09 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB92emq179778;
        Wed, 11 Nov 2020 04:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=GQWhUiIZfJxqaiAQg+tbzqNbDXwZUVuqnUExpiAOF+M=;
 b=owX2hxsmeJe3bkb8D9wmoCFPFKCwwfx6kN18aDPTBYHN+cpvrcennS3cISvwRfOBW2Ox
 T2evPB9aprumvVaGHLy4gR3HszAzQQJVqMGjZT2r+wu/F0SYGbb36boMIF6hV3IIh0oN
 wMz6cok3zLLugerdNJoEnhObFSqZpdqhkxz8fMjCDmfd1/dGqwtUKwgPFpm9dCX6nVSE
 D33J2j+pdi7HJTwnl+9Dq1xSBe3uyq/YXYZND0sqp8drEecAOFTq/WY/cWssgvx4ah6d
 y9g7hBQzliw9Dzi9wz+fH2504KkK88glWtvJtCs3d9IgVw0ZY7tkEj3XFYxdR9eW1twS KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qsbdkwyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 04:03:57 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AB93uGd188563;
        Wed, 11 Nov 2020 04:03:57 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qsbdkw1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 04:03:56 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AB91l3A024354;
        Wed, 11 Nov 2020 09:02:53 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 34p26pkc04-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 09:02:53 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AB92p6h1704494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Nov 2020 09:02:51 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11C555205A;
        Wed, 11 Nov 2020 09:02:51 +0000 (GMT)
Received: from in.ibm.com (unknown [9.85.72.149])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 094CE5206C;
        Wed, 11 Nov 2020 09:02:48 +0000 (GMT)
Date:   Wed, 11 Nov 2020 14:32:46 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, guro@fb.com, shakeelb@google.com,
        hannes@cmpxchg.org, aneesh.kumar@linux.ibm.com
Subject: Re: Higher slub memory consumption on 64K page-size systems?
Message-ID: <20201111090246.GA1006690@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20201028055030.GA362097@in.ibm.com>
 <5150e942-516b-83c8-8e52-e0f294138a71@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5150e942-516b-83c8-8e52-e0f294138a71@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=1 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011110046
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 05:47:03PM +0100, Vlastimil Babka wrote:
> On 10/28/20 6:50 AM, Bharata B Rao wrote:
> > slub_max_order
> > --------------
> > The most promising tunable that shows consistent reduction in slab memory
> > is slub_max_order. Here is a table that shows the number of slabs that
> > end up with different orders and the total slab consumption at boot
> > for different values of slub_max_order:
> > -------------------------------------------
> > slub_max_order	Order	NrSlabs	Slab memory
> > -------------------------------------------
> > 		0	276
> > 	3	1	16	207488 kB
> >      (default)	2	4
> > 		3	11
> > -------------------------------------------
> > 		0	276
> > 	2	1	16	166656 kB
> > 		2	4
> > -------------------------------------------
> > 		0	276	144128 kB
> > 	1	1	31
> > -------------------------------------------
> > 
> > Though only a few bigger sized caches fall into order-2 or order-3, they
> > seem to make a considerable difference to the overall slab consumption.
> > If we take task_struct cache as an example, this is how it ends up when
> > slub_max_order is varied:
> > 
> > task_struct, objsize=9856
> > --------------------------------------------
> > slub_max_order	objperslab	pagesperslab
> > --------------------------------------------
> > 3		53		8
> > 2		26		4
> > 1		13		2
> > --------------------------------------------
> > 
> > The slab page-order and hence the number of objects in a slab has a
> > bearing on the performance, but I wonder if some caches like task_struct
> > above can be auto-tuned to fall into a conservative order and do good
> > both wrt both memory and performance?
> 
> Hmm ideally this should be based on objperslab so if there's larger page
> sizes, then the calculated order becomes smaller, even 0?

It is indeed based on number of objects that could be optimally
fit within a slab. As I explain below, curently we start with a
minimum objects value that ends up pushing the page order higher
for some slab sizes and page size combination. The question is can
we start with a more conservative/lower value for min_objects in
calculate_order()?

> 
> > mm/slub.c:calulate_order() has the logic which determines the the
> > page-order for the slab. It starts with min_objects and attempts
> > to arrive at the best configuration for the slab. The min_objects
> > is starts like this:
> > 
> > min_objects = 4 * (fls(nr_cpu_ids) + 1);
> > 
> > Here nr_cpu_ids depends on the maxcpus and hence this can have a
> > significant effect on those systems which define maxcpus. Slab numbers
> > post-boot for a KVM pseries guest that has 16 boottime CPUs and varying
> > number of maxcpus look like this:
> > -------------------------------
> > maxcpus		Slab memory(kB)
> > -------------------------------
> > 64		209280
> > 256		253824
> > 512		293824
> > -------------------------------
> 
> Yeah IIRC nr_cpu_ids is related to number of possible cpus which is rather
> excessive on some systems, so a relation to actually online cpus would make
> more sense.

May be I can send a patch to change the above calculation of
min_objects to be based on online cpus and see how it is received.

> 
> > Page-order is a one time setting and obviously can't be tweaked dynamically
> > on CPU hotplug, but just wanted to bring out the effect of the same.
> > 
> > And that constant multiplicative factor of 4 was infact added by the commit
> > 9b2cd506e5f2 - "slub: Calculate min_objects based on number of processors."
> > 
> > Reducing that to say 2, does give some reduction in the slab memory
> > and also same hackbench performance with reduced slab memory, but I am not
> > sure if that could be assumed to be beneficial for all scenarios.
> > 
> > MIN_PARTIAL
> > -----------
> > This determines the number of slabs left on the partial list even if they
> > are empty. My initial thought was that the default MIN_PARTIAL value of 5
> > is on the higher side and we are accumulating MIN_PARTIAL number of
> > empty slabs in all caches without freeing them. However I hardly find
> > the case where an empty slab is retained during freeing on account of
> > partial slabs being lesser than MIN_PARTIAL.
> > 
> > However what I find in practice is that we are accumulating a lot of partial
> > slabs with just one in-use object in the whole slab. High number of such
> > partial slabs is indeed contributing to the increased slab memory consumption.
> > 
> > For example, after a hackbench run, I find the distribution of objects
> > like this for kmalloc-2k cache:
> > 
> > total_objects		3168
> > objects			1611
> > Nr partial slabs	54
> > Nr parital slabs with
> > just 1 inuse object	38
> > 
> > With 64K page-size, so many partial slabs with just 1 inuse object can
> > result in high memory usage. Is there any workaround possible prevent this
> > kind of situation?
> 
> Probably not, this is just fundamental internal fragmentation problem and
> that we can't predict which objects will have similar lifetime and thus put
> it together. Larger pages make just make the effect more pronounced. It
> would be wrong if we allocated new pages instead of reusing the partial
> ones, but that's not the case, IIUC?

Correct, that shouldn't be the case, I will check by adding some
instrumentation and ascertain if it indeed the case.

> 
> But you are measuring "after a hackbench run", so is that an important data
> point? If the system was in some kind of steady state workload, the pages
> would be better used I'd expect.

May be, I am not sure, we will have to check. I measured at two points: immediately
after boot as initial state and after hackbench run as an exteme state. I chose
hackbench as I see that earlier changes to some of these slab code/tunables
have been supported by hackbench numbers.

> 
> > cpu_partial
> > -----------
> > Here is how the slab consumption post-boot varies when all the slab
> > caches are forced with the fixed cpu_partial value:
> > ---------------------------
> > cpu_partial	Slab Memory
> > ---------------------------
> > 0		175872 kB
> > 2		187136 kB
> > 4		191616 kB
> > default		204864 kB
> > ---------------------------
> > 
> > It has been suggested earlier that reducing cpu_partial and/or making
> > cpu_partial 64K page-size aware will benefit. In set_cpu_partial(),
> > for bigger sized slabs (size > PAGE_SIZE), cpu_partial is already set
> > to 2. A bit of tweaking there to introduce cpu_partial=1 for certain
> > slabs does give some benefit.
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index a28ed9b8fc61..e09eff1199bf 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -3626,7 +3626,9 @@ static void set_cpu_partial(struct kmem_cache *s)
> >           */
> >          if (!kmem_cache_has_cpu_partial(s))
> >                  slub_set_cpu_partial(s, 0);
> > -       else if (s->size >= PAGE_SIZE)
> > +       else if (s->size >= 8192)
> > +               slub_set_cpu_partial(s, 1);
> > +       else if (s->size >= 4096)
> >                  slub_set_cpu_partial(s, 2);
> >          else if (s->size >= 1024)
> >                  slub_set_cpu_partial(s, 6);
> > 
> > With the above change, the slab consumption post-boot reduces to 186048 kB.
> 
> Yeah, making it agnostic to PAGE_SIZE makes sense.

Ok, let me send a separate patch for this.

Thanks for your inputs.

Regards,
Bharata.
