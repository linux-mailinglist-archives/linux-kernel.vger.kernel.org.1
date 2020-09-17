Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D49026DD98
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 16:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgIQOK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 10:10:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727178AbgIQOAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:00:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HD1riJ024351;
        Thu, 17 Sep 2020 09:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zMq0AR2tn806xLq4+QK9619/ztpshfUM4wNvY8IcGDc=;
 b=BxZ2uX4JMhghsuiCG+l9e7CnHY53dlR2Zj3JMzfX8K2Gku4Bt2XAcEe3K316MDILXO7v
 PdkzOocyEBul9aMxWNNmC6ryZrbcYI/yZRoIwJABsqFPILU4+SmfEXGlsk/vseyW62u9
 5/y0KrAEzslkY1oAiDQvNRHiBbpyrx4b7KImOdWKBUBPWEhi1TvI1ggoQu34NirbOZmy
 f1n47saPL0NhNnOcnMPUJmXqEV/tZZ/Is0Q4ZPJMqIF1qIG/GO1gbLuCANR+lx1J/fxb
 m24afMZQBnFLhjkqPJezBE9JpJSXFNi3LKcAvhRw9ezmACkOTmFHYrFuiqeUw+rPoWQv 2A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33m7qea5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:26:14 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HD22wP025002;
        Thu, 17 Sep 2020 09:26:13 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33m7qea5e0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:26:13 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HDNEdM029011;
        Thu, 17 Sep 2020 13:26:12 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01dal.us.ibm.com with ESMTP id 33k6591e2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 13:26:12 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HDQCuW23658966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 13:26:12 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02287AE05F;
        Thu, 17 Sep 2020 13:26:12 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7930BAE063;
        Thu, 17 Sep 2020 13:26:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.95.89])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 13:26:08 +0000 (GMT)
Subject: Re: [PATCH v6 6/8] powerpc/watchpoint: Add hw_len wherever missing
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr
Cc:     mikey@neuling.org, jniethe5@gmail.com, pedromfc@linux.ibm.com,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        rogealve@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
 <20200902042945.129369-7-ravi.bangoria@linux.ibm.com>
From:   Rogerio Alves <rcardoso@linux.ibm.com>
Message-ID: <3698088e-fe00-227e-f15f-ee394735a9a5@linux.ibm.com>
Date:   Thu, 17 Sep 2020 10:26:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902042945.129369-7-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/20 1:29 AM, Ravi Bangoria wrote:
> There are couple of places where we set len but not hw_len. For
> ptrace/perf watchpoints, when CONFIG_HAVE_HW_BREAKPOINT=Y, hw_len
> will be calculated and set internally while parsing watchpoint.
> But when CONFIG_HAVE_HW_BREAKPOINT=N, we need to manually set
> 'hw_len'. Similarly for xmon as well, hw_len needs to be set
> directly.
> 
> Fixes: b57aeab811db ("powerpc/watchpoint: Fix length calculation for unaligned target")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Rogerio Alves <rcardoso@linux.ibm.com>
> ---
>   arch/powerpc/kernel/ptrace/ptrace-noadv.c | 1 +
>   arch/powerpc/xmon/xmon.c                  | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> index c9122ed91340..48c52426af80 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
> @@ -219,6 +219,7 @@ long ppc_set_hwdebug(struct task_struct *child, struct ppc_hw_breakpoint *bp_inf
>   	brk.address = ALIGN_DOWN(bp_info->addr, HW_BREAKPOINT_SIZE);
>   	brk.type = HW_BRK_TYPE_TRANSLATE | HW_BRK_TYPE_PRIV_ALL;
>   	brk.len = DABR_MAX_LEN;
> +	brk.hw_len = DABR_MAX_LEN;
>   	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_READ)
>   		brk.type |= HW_BRK_TYPE_READ;
>   	if (bp_info->trigger_type & PPC_BREAKPOINT_TRIGGER_WRITE)
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index df7bca00f5ec..55c43a6c9111 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -969,6 +969,7 @@ static void insert_cpu_bpts(void)
>   			brk.address = dabr[i].address;
>   			brk.type = (dabr[i].enabled & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
>   			brk.len = 8;
> +			brk.hw_len = 8;
>   			__set_breakpoint(i, &brk);
>   		}
>   	}
> 
