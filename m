Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793CA2D3190
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgLHR5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:57:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730860AbgLHR5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:57:49 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8HcLGi046833;
        Tue, 8 Dec 2020 12:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=EdY0U0J2gcVlEshkS8QsrpbR/zB+nrWtq0z4BHC6ZEg=;
 b=OwhG9aJ7Bdr2sBk8WTjuAqm221juDnnfKjm4SUuQHEJaeWhvZtvmqeQXwq64dqNYM35e
 JCnIMPG+G0CgGy99bq8HWzesFE9nj5e/ZgJUOTSHSFZTevKjlWP0OogpBlJsNQncWyjD
 /FBfKMaO7cp6aEoVR5ZWNeNKh721mQa6kGlVF3ZeoBEyDVUCocU7jdQfwqmPQtulqa3q
 rpoiGXyikyJHxtH8HdkGNFMCX4KuBFOUf+fHtLozzuWz6BrDmB7nX6tz87dB4YqApJfC
 8smmaZTPtYwjle6yjnaPc798Ww2Wu/QBY56kFkaJqX6rZMYtPz0qe1uIF73FvaiKrtFY kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a5ug1786-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 12:56:55 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8HngkA086334;
        Tue, 8 Dec 2020 12:56:55 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a5ug177q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 12:56:54 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Hm6CQ030966;
        Tue, 8 Dec 2020 17:56:53 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3581u9quqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 17:56:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8HurAS15204716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 17:56:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C6BEB2064;
        Tue,  8 Dec 2020 17:56:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C862EB2067;
        Tue,  8 Dec 2020 17:56:52 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.54.209])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 17:56:52 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id DE36F2E35A1; Tue,  8 Dec 2020 23:26:47 +0530 (IST)
Date:   Tue, 8 Dec 2020 23:26:47 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/cacheinfo: Print correct cache-sibling
 map/list for L2 cache
Message-ID: <20201208175647.GC14206@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1607057327-29822-1-git-send-email-ego@linux.vnet.ibm.com>
 <1607057327-29822-4-git-send-email-ego@linux.vnet.ibm.com>
 <20201207131138.GJ528281@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207131138.GJ528281@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_14:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080108
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 06:41:38PM +0530, Srikar Dronamraju wrote:
> * Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2020-12-04 10:18:47]:
> 
> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > 
> > 
> > Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > ---
> > 
> > +extern bool thread_group_shares_l2;
> >  /*
> >   * On big-core systems, each core has two groups of CPUs each of which
> >   * has its own L1-cache. The thread-siblings which share l1-cache with
> >   * @cpu can be obtained via cpu_smallcore_mask().
> > + *
> > + * On some big-core systems, the L2 cache is shared only between some
> > + * groups of siblings. This is already parsed and encoded in
> > + * cpu_l2_cache_mask().
> >   */
> >  static const struct cpumask *get_big_core_shared_cpu_map(int cpu, struct cache *cache)
> >  {
> >  	if (cache->level == 1)
> >  		return cpu_smallcore_mask(cpu);
> > +	if (cache->level == 2 && thread_group_shares_l2)
> > +		return cpu_l2_cache_mask(cpu);
> > 
> >  	return &cache->shared_cpu_map;
> 
> As pointed with lkp@intel.org, we need to do this only with #CONFIG_SMP,
> even for cache->level = 1 too.

Yes, I have fixed that in the next version.

> 
> I agree that we are displaying shared_cpu_map correctly. Should we have also
> update /clear shared_cpu_map in the first place. For example:- If for a P9
> core with CPUs 0-7, the cache->shared_cpu_map for L1 would have 0-7 but
> would display 0,2,4,6.
> 
> The drawback of this is even if cpus 0,2,4,6 are released L1 cache will not
> be released. Is this as expected?

cacheinfo populates the cache->shared_cpu_map on the basis of which
CPUs share the common device-tree node for a particular cache.  There
is one l1-cache object in the device-tree for a CPU node corresponding
to a big-core. That the L1 is further split between the threads of the
core is shown using ibm,thread-groups.

The ideal thing would be to add a "group_leader" field to "struct
cache" so that we can create separate cache objects , one per thread
group. I will take a stab at this in the v2.

Thanks for the review comments.



> 
> 
> -- 
> Thanks and Regards
> Srikar Dronamraju
