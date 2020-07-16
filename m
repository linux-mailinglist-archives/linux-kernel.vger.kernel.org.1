Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD07222D71
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 23:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgGPVJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 17:09:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38110 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726665AbgGPVJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:09:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GL3GfG084584;
        Thu, 16 Jul 2020 17:09:49 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32autamr7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:09:48 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GL3JoY084887;
        Thu, 16 Jul 2020 17:09:48 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32autamr6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 17:09:48 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GKpeKs022862;
        Thu, 16 Jul 2020 21:09:46 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 3274pgwsyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 21:09:46 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GL9h2b27656218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 21:09:43 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08403AE045;
        Thu, 16 Jul 2020 21:09:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06B33AE055;
        Thu, 16 Jul 2020 21:09:40 +0000 (GMT)
Received: from [9.102.2.181] (unknown [9.102.2.181])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jul 2020 21:09:39 +0000 (GMT)
From:   Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v3 05/12] powerpc/drmem: make lmb walk a bit more flexible
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     Pingfan Liu <piliu@redhat.com>, Nayna Jain <nayna@linux.ibm.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466090332.24747.9255471295044653085.stgit@hbathini.in.ibm.com>
 <871rld8mic.fsf@morokweng.localdomain>
Message-ID: <30e8f02a-f009-70a5-01e9-dec9eff213b1@linux.ibm.com>
Date:   Fri, 17 Jul 2020 02:39:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <871rld8mic.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 spamscore=100
 priorityscore=1501 suspectscore=0 mlxscore=100 phishscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=-1000 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/07/20 9:20 am, Thiago Jung Bauermann wrote:
> 
> Hari Bathini <hbathini@linux.ibm.com> writes:
> 
>> @@ -534,7 +537,7 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
>>  #ifdef CONFIG_PPC_PSERIES
>>  	if (depth == 1 &&
>>  	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
>> -		walk_drmem_lmbs_early(node, early_init_drmem_lmb);
>> +		walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
> 
> walk_drmem_lmbs_early() can now fail. Should this failure be propagated
> as a return value of early_init_dt_scan_memory_ppc()?
  
> 
>>  		return 0;
>>  	}
>>  #endif
> <snip>
> 
>> @@ -787,7 +790,7 @@ static int __init parse_numa_properties(void)
>>  	 */
>>  	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>>  	if (memory) {
>> -		walk_drmem_lmbs(memory, numa_setup_drmem_lmb);
>> +		walk_drmem_lmbs(memory, NULL, numa_setup_drmem_lmb);
> 
> Similarly here. Now that this call can fail, should
> parse_numa_properties() handle or propagate the failure?

They would still not fail unless the callbacks early_init_drmem_lmb() & numa_setup_drmem_lmb()
are updated to have failure scenarios. Also, these call sites always ignored failure scenarios
even before walk_drmem_lmbs() was introduced. So, I prefer to keep them the way they are?

Thanks
Hari
