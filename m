Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6F130211A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbhAYE3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:29:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbhAYE3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:29:17 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10P3Wm6P122647;
        Sun, 24 Jan 2021 23:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=lBURt//ZdQDVDGPWKPhVijkBdOR/OHduunbYxyLV06E=;
 b=cufY8Be7QK4XRB2y9ZpGcPUyf2EcqhiZZ1jQBw8YYC7ZJ1J7X/Tutx4jp0PXMqPQJleX
 Lrl3KyY9tJw+sl6JKHdrhp1aPeM4/uh0JwikAs6achmdRpewMLJEzaJaInVv5ofv96tj
 ybZDLdz9c3JjALLlZmx1rR7cfInPh+xpVkPbY40ZWx76Few8JAYtvQNV6evR/yl2uKiW
 jdxKp1Sg3EnjeotLg9KG6LLwccQ0CxeJoCJ8qzNVVIYAP/ylSfy479VyQpWdB9Ji8hXU
 HQzCQN+/v+Gl9+ApYbiFuRpd1NytDcoQtOgxv6qzHkrMEuRthCZJktzmHBiZlFNKCHt8 Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 369neu1rn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 23:28:23 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10P3kYuV169290;
        Sun, 24 Jan 2021 23:28:23 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 369neu1rmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 23:28:22 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10P4RG3p009380;
        Mon, 25 Jan 2021 04:28:20 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 368be89f9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 04:28:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10P4SIpu46072288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Jan 2021 04:28:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6841942042;
        Mon, 25 Jan 2021 04:28:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14D9442041;
        Mon, 25 Jan 2021 04:28:16 +0000 (GMT)
Received: from in.ibm.com (unknown [9.102.2.59])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jan 2021 04:28:15 +0000 (GMT)
Date:   Mon, 25 Jan 2021 09:58:13 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Jann Horn <jannh@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <20210125042813.GA2869122@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAG48ez0gutKNuRj4E22tkv8mQKo-6TExGMxvpHCtUz8sFonb3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0gutKNuRj4E22tkv8mQKo-6TExGMxvpHCtUz8sFonb3A@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-25_01:2021-01-22,2021-01-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101250019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 02:05:47PM +0100, Jann Horn wrote:
> On Thu, Jan 21, 2021 at 7:19 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > On 1/21/21 11:01 AM, Christoph Lameter wrote:
> > > On Thu, 21 Jan 2021, Bharata B Rao wrote:
> > >
> > >> > The problem is that calculate_order() is called a number of times
> > >> > before secondaries CPUs are booted and it returns 1 instead of 224.
> > >> > This makes the use of num_online_cpus() irrelevant for those cases
> > >> >
> > >> > After adding in my command line "slub_min_objects=36" which equals to
> > >> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
> > >> > , the regression diseapears:
> > >> >
> > >> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
> >
> > I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
> > supposed to be a scheduler benchmark? What exactly is going on?
> 
> Uuuh, I think powerpc doesn't have cmpxchg_double?
> 
> "vgrep cmpxchg_double arch/" just spits out arm64, s390 and x86? And
> <https://liblfds.org/mediawiki/index.php?title=Article:CAS_and_LL/SC_Implementation_Details_by_Processor_family>
> says under "POWERPC": "no DW LL/SC"
> 
> So powerpc is probably hitting the page-bitlock-based implementation
> all the time for stuff like __slub_free()? Do you have detailed
> profiling results from "perf top" or something like that?

I can check that, but the current patch was aimed at reducing
the page order of the slub caches so that they don't end up
consuming more memory on 64K systems.

> 
> (I actually have some WIP patches and a design document for getting
> rid of cmpxchg_double in struct page that I hacked together in the
> last couple days; I'm currently in the process of sending them over to
> some other folks in the company who hopefully have cycles to
> review/polish/benchmark them so that they can be upstreamed, assuming
> that those folks think they're important enough. I don't have the
> cycles for it...)

Sounds interesting, will keep a watch to see its effect on powerpc.

Regards,
Bharata.
