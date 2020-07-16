Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3080B222E52
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 00:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGPWBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 18:01:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51436 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726293AbgGPWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 18:01:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GLLCQT024826;
        Thu, 16 Jul 2020 18:01:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ax789cvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 18:01:14 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GLjmKk089979;
        Thu, 16 Jul 2020 18:01:14 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32ax789cvj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 18:01:14 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GLj9HS025253;
        Thu, 16 Jul 2020 22:01:13 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 327529c1at-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 22:01:13 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GM1C6t63504884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 22:01:12 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 474FC7809D;
        Thu, 16 Jul 2020 22:01:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E999F7809F;
        Thu, 16 Jul 2020 22:01:08 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.8.110])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Thu, 16 Jul 2020 22:01:08 +0000 (GMT)
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com> <159466090332.24747.9255471295044653085.stgit@hbathini.in.ibm.com> <871rld8mic.fsf@morokweng.localdomain> <30e8f02a-f009-70a5-01e9-dec9eff213b1@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Hari Bathini <hbathini@linux.ibm.com>
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
Subject: Re: [PATCH v3 05/12] powerpc/drmem: make lmb walk a bit more flexible
In-reply-to: <30e8f02a-f009-70a5-01e9-dec9eff213b1@linux.ibm.com>
Date:   Thu, 16 Jul 2020 19:01:05 -0300
Message-ID: <877dv3ce72.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_11:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 bulkscore=0
 adultscore=0 spamscore=100 priorityscore=1501 mlxscore=100
 mlxlogscore=-1000 phishscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hari Bathini <hbathini@linux.ibm.com> writes:

> On 15/07/20 9:20 am, Thiago Jung Bauermann wrote:
>> 
>> Hari Bathini <hbathini@linux.ibm.com> writes:
>> 
>>> @@ -534,7 +537,7 @@ static int __init early_init_dt_scan_memory_ppc(unsigned long node,
>>>  #ifdef CONFIG_PPC_PSERIES
>>>  	if (depth == 1 &&
>>>  	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
>>> -		walk_drmem_lmbs_early(node, early_init_drmem_lmb);
>>> +		walk_drmem_lmbs_early(node, NULL, early_init_drmem_lmb);
>> 
>> walk_drmem_lmbs_early() can now fail. Should this failure be propagated
>> as a return value of early_init_dt_scan_memory_ppc()?
>   
>> 
>>>  		return 0;
>>>  	}
>>>  #endif
>> <snip>
>> 
>>> @@ -787,7 +790,7 @@ static int __init parse_numa_properties(void)
>>>  	 */
>>>  	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
>>>  	if (memory) {
>>> -		walk_drmem_lmbs(memory, numa_setup_drmem_lmb);
>>> +		walk_drmem_lmbs(memory, NULL, numa_setup_drmem_lmb);
>> 
>> Similarly here. Now that this call can fail, should
>> parse_numa_properties() handle or propagate the failure?
>
> They would still not fail unless the callbacks early_init_drmem_lmb() & numa_setup_drmem_lmb()
> are updated to have failure scenarios. Also, these call sites always ignored failure scenarios
> even before walk_drmem_lmbs() was introduced. So, I prefer to keep them the way they are?

Ok, makes sense. In this case:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center
