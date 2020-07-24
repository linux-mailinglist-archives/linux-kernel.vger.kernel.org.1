Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D4A22BEA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 09:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgGXHG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 03:06:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726554AbgGXHG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:06:56 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06O70cVu070279;
        Fri, 24 Jul 2020 03:06:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fadftct3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 03:06:36 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06O722bf075663;
        Fri, 24 Jul 2020 03:06:36 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fadftcsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 03:06:36 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06O758ct021508;
        Fri, 24 Jul 2020 07:06:35 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 32brq9tgjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 07:06:35 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06O76YTT40435974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 07:06:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2C45B205F;
        Fri, 24 Jul 2020 07:06:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F12E6B2065;
        Fri, 24 Jul 2020 07:06:33 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.93.226])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 07:06:33 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 5A35A2E3C48; Fri, 24 Jul 2020 12:36:29 +0530 (IST)
Date:   Fri, 24 Jul 2020 12:36:29 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v3 02/10] powerpc/smp: Merge Power9 topology with Power
 topology
Message-ID: <20200724070629.GA21415@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200723085116.4731-1-srikar@linux.vnet.ibm.com>
 <20200723085116.4731-3-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723085116.4731-3-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_01:2020-07-24,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007240047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 02:21:08PM +0530, Srikar Dronamraju wrote:
> A new sched_domain_topology_level was added just for Power9. However the
> same can be achieved by merging powerpc_topology with power9_topology
> and makes the code more simpler especially when adding a new sched
> domain.
> 
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jordan Niethe <jniethe5@gmail.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

LGTM.


Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
> Changelog v1 -> v2:
> 	Replaced a reference to cpu_smt_mask with per_cpu(cpu_sibling_map, cpu)
> 	since cpu_smt_mask is only defined under CONFIG_SCHED_SMT
> 
>  arch/powerpc/kernel/smp.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index edf94ca64eea..283a04e54f52 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -1313,7 +1313,7 @@ int setup_profiling_timer(unsigned int multiplier)
>  }
> 
>  #ifdef CONFIG_SCHED_SMT
> -/* cpumask of CPUs with asymetric SMT dependancy */
> +/* cpumask of CPUs with asymmetric SMT dependency */
>  static int powerpc_smt_flags(void)
>  {
>  	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
> @@ -1326,14 +1326,6 @@ static int powerpc_smt_flags(void)
>  }
>  #endif
> 
> -static struct sched_domain_topology_level powerpc_topology[] = {
> -#ifdef CONFIG_SCHED_SMT
> -	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
> -#endif
> -	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
> -	{ NULL, },
> -};
> -
>  /*
>   * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
>   * This topology makes it *much* cheaper to migrate tasks between adjacent cores
> @@ -1351,7 +1343,13 @@ static int powerpc_shared_cache_flags(void)
>   */
>  static const struct cpumask *shared_cache_mask(int cpu)
>  {
> -	return cpu_l2_cache_mask(cpu);
> +	if (shared_caches)
> +		return cpu_l2_cache_mask(cpu);
> +
> +	if (has_big_cores)
> +		return cpu_smallcore_mask(cpu);
> +
> +	return per_cpu(cpu_sibling_map, cpu);
>  }
> 
>  #ifdef CONFIG_SCHED_SMT
> @@ -1361,7 +1359,7 @@ static const struct cpumask *smallcore_smt_mask(int cpu)
>  }
>  #endif
> 
> -static struct sched_domain_topology_level power9_topology[] = {
> +static struct sched_domain_topology_level powerpc_topology[] = {
>  #ifdef CONFIG_SCHED_SMT
>  	{ cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT) },
>  #endif
> @@ -1386,21 +1384,10 @@ void __init smp_cpus_done(unsigned int max_cpus)
>  #ifdef CONFIG_SCHED_SMT
>  	if (has_big_cores) {
>  		pr_info("Big cores detected but using small core scheduling\n");
> -		power9_topology[0].mask = smallcore_smt_mask;
>  		powerpc_topology[0].mask = smallcore_smt_mask;
>  	}
>  #endif
> -	/*
> -	 * If any CPU detects that it's sharing a cache with another CPU then
> -	 * use the deeper topology that is aware of this sharing.
> -	 */
> -	if (shared_caches) {
> -		pr_info("Using shared cache scheduler topology\n");
> -		set_sched_topology(power9_topology);
> -	} else {
> -		pr_info("Using standard scheduler topology\n");
> -		set_sched_topology(powerpc_topology);
> -	}
> +	set_sched_topology(powerpc_topology);
>  }
> 
>  #ifdef CONFIG_HOTPLUG_CPU
> -- 
> 2.18.2
> 
