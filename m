Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAA02291A5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731337AbgGVHGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 03:06:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgGVHGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 03:06:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06M73Lfm098772;
        Wed, 22 Jul 2020 03:06:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xx6gu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 03:06:38 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06M73l8x102034;
        Wed, 22 Jul 2020 03:06:37 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1xx6grj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 03:06:37 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06M7563h014061;
        Wed, 22 Jul 2020 07:06:35 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03wdc.us.ibm.com with ESMTP id 32brq99vx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 07:06:35 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06M76X7l66454014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 07:06:33 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C0AD7805C;
        Wed, 22 Jul 2020 07:06:33 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1522D78063;
        Wed, 22 Jul 2020 07:06:32 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.82.72])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 07:06:32 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id CF9902E340E; Wed, 22 Jul 2020 12:36:28 +0530 (IST)
Date:   Wed, 22 Jul 2020 12:36:28 +0530
From:   Gautham R Shenoy <ego@linux.vnet.ibm.com>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michael Ellerman <michaele@au1.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Nick Piggin <npiggin@au1.ibm.com>,
        Oliver OHalloran <oliveroh@au1.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@linux.ibm.com>,
        Anton Blanchard <anton@au1.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v2 10/10] powerpc/smp: Implement cpu_to_coregroup_id
Message-ID: <20200722070628.GG31038@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <20200721113814.32284-1-srikar@linux.vnet.ibm.com>
 <20200721113814.32284-11-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721113814.32284-11-srikar@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_03:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007220052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 05:08:14PM +0530, Srikar Dronamraju wrote:
> Lookup the coregroup id from the associativity array.
> 
> If unable to detect the coregroup id, fallback on the core id.
> This way, ensure sched_domain degenerates and an extra sched domain is
> not created.
> 
> Ideally this function should have been implemented in
> arch/powerpc/kernel/smp.c. However if its implemented in mm/numa.c, we
> don't need to find the primary domain again.
> 
> If the device-tree mentions more than one coregroup, then kernel
> implements only the last or the smallest coregroup, which currently
> corresponds to the penultimate domain in the device-tree.
> 
> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Michael Ellerman <michaele@au1.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Nick Piggin <npiggin@au1.ibm.com>
> Cc: Oliver OHalloran <oliveroh@au1.ibm.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Michael Neuling <mikey@linux.ibm.com>
> Cc: Anton Blanchard <anton@au1.ibm.com>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
> Cc: Jordan Niethe <jniethe5@gmail.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Looks good to me.

Reviewed-by : Gautham R. Shenoy <ego@linux.vnet.ibm.com>


> ---
> Changelog v1 -> v2:
> powerpc/smp: Implement cpu_to_coregroup_id
> 	Move coregroup_enabled before getting associativity (Gautham)
> 
>  arch/powerpc/mm/numa.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index ef8aa580da21..ae57b68beaee 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1218,6 +1218,26 @@ int find_and_online_cpu_nid(int cpu)
> 
>  int cpu_to_coregroup_id(int cpu)
>  {
> +	__be32 associativity[VPHN_ASSOC_BUFSIZE] = {0};
> +	int index;
> +
> +	if (cpu < 0 || cpu > nr_cpu_ids)
> +		return -1;
> +
> +	if (!coregroup_enabled)
> +		goto out;
> +
> +	if (!firmware_has_feature(FW_FEATURE_VPHN))
> +		goto out;
> +
> +	if (vphn_get_associativity(cpu, associativity))
> +		goto out;
> +
> +	index = of_read_number(associativity, 1);
> +	if (index > min_common_depth + 1)
> +		return of_read_number(&associativity[index - 1], 1);
> +
> +out:
>  	return cpu_to_core_id(cpu);
>  }
> 
> -- 
> 2.17.1
> 
