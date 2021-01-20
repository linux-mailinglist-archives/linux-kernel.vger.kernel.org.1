Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA302FDAD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388269AbhATUaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:30:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732867AbhATN4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:56:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10KDnd7D087118;
        Wed, 20 Jan 2021 08:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=3q4hsFpqxWcQZYMF9NS2+yvRVqay+kH3bDts7lgla7I=;
 b=qkJ24rKIVB6moRON4GTQy5IF9UlQu8gkKNC5G/XpY+ne9yHxKCk9dsssH+YYfAsiKagc
 Ns38tnfg4FDyjBdoMn0QZ5YvaTjJNMYTjYtRG9XuRO2dKHccn987vWQzr0TLgiPydvcB
 bMi4iZ+KBvsGJfnslT6ROc3KSOOfRq4ewwlr7KHfTFcCrNYaIDfyhx3nid9EjlZ4if3R
 hGYTNrZ31oOPOdavaN+ype44A7RauhuL75f/U0JbOnup2CTnZtO1Mx83I2XFmcDjw0xk
 +qnoAp3Z9tZ/JR/adBS7n/tCbKk8qaalHa0/z06gz7QKEL0ihnONmEvNmXJkgVFiZ1Vp qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 366nrbr3xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 08:55:42 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10KDtNCF109910;
        Wed, 20 Jan 2021 08:55:42 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 366nrbr3xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 08:55:42 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10KDkoZP019759;
        Wed, 20 Jan 2021 13:55:41 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04dal.us.ibm.com with ESMTP id 3668p2nruk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 13:55:41 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10KDtf4229426162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 13:55:41 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE239112061;
        Wed, 20 Jan 2021 13:55:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B15F112062;
        Wed, 20 Jan 2021 13:55:40 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.84.198])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 13:55:40 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 1BEB12E2EE0; Wed, 20 Jan 2021 19:25:06 +0530 (IST)
Date:   Wed, 20 Jan 2021 19:25:06 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210120135506.GA884@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <20210119112211.3196-6-mgorman@techsingularity.net>
 <20210120083018.GA14462@in.ibm.com>
 <20210120091235.GT3592@techsingularity.net>
 <CAKfTPtBYuxKywCPeEd=vYCu31Ni0=uXoJa4v3ZV_T9J0TsVyhg@mail.gmail.com>
 <20210120095420.GU3592@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120095420.GU3592@techsingularity.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_05:2021-01-20,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Jan 20, 2021 at 09:54:20AM +0000, Mel Gorman wrote:
> On Wed, Jan 20, 2021 at 10:21:47AM +0100, Vincent Guittot wrote:
> > On Wed, 20 Jan 2021 at 10:12, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Jan 20, 2021 at 02:00:18PM +0530, Gautham R Shenoy wrote:
> > > > > @@ -6157,18 +6169,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > > > >     }
> > > > >
> > > > >     for_each_cpu_wrap(cpu, cpus, target) {
> > > > > -           if (!--nr)
> > > > > -                   return -1;
> > > > > -           if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > > > -                   break;
> > > > > +           if (smt) {
> > > > > +                   i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > > > > +                   if ((unsigned int)i < nr_cpumask_bits)
> > > > > +                           return i;
> > > > > +
> > > > > +           } else {
> > > > > +                   if (!--nr)
> > > > > +                           return -1;
> > > > > +                   i = __select_idle_cpu(cpu);
> > > > > +                   if ((unsigned int)i < nr_cpumask_bits) {
> > > > > +                           idle_cpu = i;
> > > > > +                           break;
> > > > > +                   }
> > > > > +           }
> > > > >     }
> > > > >
> > > > > -   if (sched_feat(SIS_PROP)) {
> > > > > +   if (smt)
> > > > > +           set_idle_cores(this, false);
> > > >
> > > > Shouldn't we set_idle_cores(false) only if this was the last idle
> > > > core in the LLC ?
> > > >
> > >
> > > That would involve rechecking the cpumask bits that have not been
> > > scanned to see if any of them are an idle core. As the existance of idle
> > > cores can change very rapidly, it's not worth the cost.
> > 
> > But don't we reach this point only if we scanned all CPUs and didn't
> > find an idle core ?

Indeed, I missed that part that we return as soon as we find an idle
core in the for_each_cpu_wrap() loop above. So here we clear the
"has_idle_cores" when there are no longer any idle-cores. Sorry for
the noise!


> 
> Yes, but my understanding of Gauthams suggestion was to check if an
> idle core found was the last idle core available and set has_idle_cores
> to false in that case.

That would have been nice, but since we do not keep a count of idle
cores, it is probably not worth the effort as you note below.

> I think this would be relatively expensive and
> possibly futile as returning the last idle core for this wakeup does not
> mean there will be no idle core on the next wakeup as other cores may go
> idle between wakeups.


> 
> -- 
> Mel Gorman
> SUSE Labs

--
Thanks and Regards
gautham.
