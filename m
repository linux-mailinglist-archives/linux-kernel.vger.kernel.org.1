Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F32D117F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgLGNMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:12:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgLGNMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:12:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B7D2Bx4045870;
        Mon, 7 Dec 2020 08:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=WHXphbVjeJDgHgn5XibvhdAbLfM2z0E3WZL+Rif4r44=;
 b=ami/VGSc794gvTQDhcZ41lA3gYpjOV6vQx/ruOr1qmAkOeygTOoocNboiA985grf8YD0
 fww8Jy3ik91krDd1KbqSgk1I0v0UGuNdVA6oiDdJE7hHXb4vqSdL3jnsrhdFfL5Tz/Kx
 6FCr8R3Hp9FiGgGdGcOxjDXEBUgi8I18TCnoYBTN1ynEdCzYjYKcozOhV+2qjX8GGBKK
 cnOtkqEXmL5/D3OlUYGwiHZt09+O3jLL/Dt1ryx6AWyUptl6hjSq6BG51ZCZlwKbuFMm
 v0zNv+EiXoVfpCMs8BoQrf3MAdol3biYY0X6exTC9C2Lc3+Oz9UxNQ8+fFKyBEmf1nqw hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 359m8x9mf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 08:11:45 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B7D2Bhu045828;
        Mon, 7 Dec 2020 08:11:45 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 359m8x9mek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 08:11:45 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7D6aDK029563;
        Mon, 7 Dec 2020 13:11:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3581fhjgnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 13:11:43 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B7DBfPv9306794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 13:11:41 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F122A405C;
        Mon,  7 Dec 2020 13:11:41 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0DBAA4060;
        Mon,  7 Dec 2020 13:11:38 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon,  7 Dec 2020 13:11:38 +0000 (GMT)
Date:   Mon, 7 Dec 2020 18:41:38 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     Anton Blanchard <anton@ozlabs.org>,
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
Message-ID: <20201207131138.GJ528281@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1607057327-29822-1-git-send-email-ego@linux.vnet.ibm.com>
 <1607057327-29822-4-git-send-email-ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1607057327-29822-4-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_11:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=1 clxscore=1015 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Gautham R. Shenoy <ego@linux.vnet.ibm.com> [2020-12-04 10:18:47]:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
> 
> +extern bool thread_group_shares_l2;
>  /*
>   * On big-core systems, each core has two groups of CPUs each of which
>   * has its own L1-cache. The thread-siblings which share l1-cache with
>   * @cpu can be obtained via cpu_smallcore_mask().
> + *
> + * On some big-core systems, the L2 cache is shared only between some
> + * groups of siblings. This is already parsed and encoded in
> + * cpu_l2_cache_mask().
>   */
>  static const struct cpumask *get_big_core_shared_cpu_map(int cpu, struct cache *cache)
>  {
>  	if (cache->level == 1)
>  		return cpu_smallcore_mask(cpu);
> +	if (cache->level == 2 && thread_group_shares_l2)
> +		return cpu_l2_cache_mask(cpu);
> 
>  	return &cache->shared_cpu_map;

As pointed with lkp@intel.org, we need to do this only with #CONFIG_SMP,
even for cache->level = 1 too.

I agree that we are displaying shared_cpu_map correctly. Should we have also
update /clear shared_cpu_map in the first place. For example:- If for a P9
core with CPUs 0-7, the cache->shared_cpu_map for L1 would have 0-7 but
would display 0,2,4,6.

The drawback of this is even if cpus 0,2,4,6 are released L1 cache will not
be released. Is this as expected?


-- 
Thanks and Regards
Srikar Dronamraju
