Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AE32FCCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbhATIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:33:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730320AbhATIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:31:54 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10K8AgwQ126825;
        Wed, 20 Jan 2021 03:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=ougOjhkX18sPSH6z0ka9AWE013KhohxiwNpzt0X1Ezw=;
 b=ovSpxA8//L2mDLx7FvUWFWqW6huONoyBAx+TlXL1cAD3j2W7XI56UvwC540E6FHWCYz7
 bjkq9kKWEHyfLjf8In8NWHp1I/g9kjRFnf5UWeTDv8wvKcNpAwOkMWVNt5a233MXhMLG
 112pOX0QB/FnaihLqdjMrWZuZd2wHNIPKtWv3b+V6BtjvenLZESAgVlgcZr1Vc8CLh97
 L5qXPf3+2zgY3VT+swMEbPA5ig0jVw/KgdhSf9V0VzHWGIZagPQu3FgN513iUzZuz7m4
 kSeATjFnGUEhYK45NXOyDJSzYblQ5QiTmz6xUk9Q/uLNFtPhNeiGdsSZMbzA49TVuRZZ 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 366gs50f8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 03:30:55 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10K8AdWU126764;
        Wed, 20 Jan 2021 03:30:55 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 366gs50f8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 03:30:55 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10K8QMLM029056;
        Wed, 20 Jan 2021 08:30:54 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3668pqary1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jan 2021 08:30:54 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10K8Ur7m36045096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jan 2021 08:30:53 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 269946A051;
        Wed, 20 Jan 2021 08:30:53 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80DC66A04D;
        Wed, 20 Jan 2021 08:30:52 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.77.200.182])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jan 2021 08:30:52 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 2531F2E302A; Wed, 20 Jan 2021 14:00:18 +0530 (IST)
Date:   Wed, 20 Jan 2021 14:00:18 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210120083018.GA14462@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <20210119112211.3196-6-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119112211.3196-6-mgorman@techsingularity.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-20_02:2021-01-18,2021-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101200041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel, Peter,

On Tue, Jan 19, 2021 at 11:22:11AM +0000, Mel Gorman wrote:
> From: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Both select_idle_core() and select_idle_cpu() do a loop over the same
> cpumask. Observe that by clearing the already visited CPUs, we can
> fold the iteration and iterate a core at a time.
> 
> All we need to do is remember any non-idle CPU we encountered while
> scanning for an idle core. This way we'll only iterate every CPU once.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  kernel/sched/fair.c | 101 ++++++++++++++++++++++++++------------------
>  1 file changed, 61 insertions(+), 40 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 12e08da90024..822851b39b65 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c

[..snip..]


> @@ -6157,18 +6169,31 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	}
> 
>  	for_each_cpu_wrap(cpu, cpus, target) {
> -		if (!--nr)
> -			return -1;
> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> -			break;
> +		if (smt) {
> +			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +			if ((unsigned int)i < nr_cpumask_bits)
> +				return i;
> +
> +		} else {
> +			if (!--nr)
> +				return -1;
> +			i = __select_idle_cpu(cpu);
> +			if ((unsigned int)i < nr_cpumask_bits) {
> +				idle_cpu = i;
> +				break;
> +			}
> +		}
>  	}
> 
> -	if (sched_feat(SIS_PROP)) {
> +	if (smt)
> +		set_idle_cores(this, false);

Shouldn't we set_idle_cores(false) only if this was the last idle
core in the LLC ? 

--
Thanks and Regards
gautham.
