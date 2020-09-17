Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E98726E5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 21:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgIQT4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 15:56:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbgIQOqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 10:46:31 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08HD2sQZ088902;
        Thu, 17 Sep 2020 09:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wmOzpjGG1h2Oq7Ir2GbzRIjQQIyrtaS+Bel/vK91xI0=;
 b=sC4ib1q4eMwT34d/lTDP0VzNmoCxlDn+bZunq61KViNMpmCpi5i1DzhvgoDa2cr90RfT
 dZGjljZ6JQx2dODyh4ENX93cv7i+LPZU7jRFDfzM71fA5VrJL3ZJcaDV/fjrgsvT1bzw
 9jTkVkcJ3jwRsIfMFsTnycTCJckLHRx9M6GDv41a6fXsiUdogflXiSMUX9wfaXA79Shq
 fQc1I7V1riO9Vif6MqxyxsuemVehpnAlr4CYmSYpLAv5Se0f0WB6F6bOecym7MDmCMiZ
 K68Lwz8m0ap7Rk9nR5eDDhd5YhsZWbhKjoz2VVVTv5+6yI3N9av5dMJJc8fPIeqSZLER 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m86sh5g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:25:32 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08HD39K5090326;
        Thu, 17 Sep 2020 09:25:31 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33m86sh5ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 09:25:31 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08HDMdgl008441;
        Thu, 17 Sep 2020 13:25:30 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 33k5v20xdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 13:25:30 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08HDPTLY45351318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 13:25:29 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FEA2AE063;
        Thu, 17 Sep 2020 13:25:29 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A74EAE060;
        Thu, 17 Sep 2020 13:25:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.95.89])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 17 Sep 2020 13:25:25 +0000 (GMT)
Subject: Re: [PATCH v6 1/8] powerpc/watchpoint: Fix quarword instruction
 handling on p10 predecessors
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mpe@ellerman.id.au,
        christophe.leroy@c-s.fr
Cc:     mikey@neuling.org, jniethe5@gmail.com, pedromfc@linux.ibm.com,
        linux-kernel@vger.kernel.org, paulus@samba.org,
        rogealve@linux.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
 <20200902042945.129369-2-ravi.bangoria@linux.ibm.com>
From:   Rogerio Alves <rcardoso@linux.ibm.com>
Message-ID: <4522c423-c020-3abc-8db6-acdc2a095d21@linux.ibm.com>
Date:   Thu, 17 Sep 2020 10:25:24 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902042945.129369-2-ravi.bangoria@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_09:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/20 1:29 AM, Ravi Bangoria wrote:
> On p10 predecessors, watchpoint with quarword access is compared at
> quardword length. If the watch range is doubleword or less than that
> in a first half of quarword aligned 16 bytes, and if there is any
> unaligned quadword access which will access only the 2nd half, the
> handler should consider it as extraneous and emulate/single-step it
> before continuing.
> 
> Reported-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
> Fixes: 74c6881019b7 ("powerpc/watchpoint: Prepare handler to handle more than one watchpoint")
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Rogerio Alves <rcardoso@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/hw_breakpoint.h |  1 +
>   arch/powerpc/kernel/hw_breakpoint.c      | 12 ++++++++++--
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
> index db206a7f38e2..9b68eafebf43 100644
> --- a/arch/powerpc/include/asm/hw_breakpoint.h
> +++ b/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -42,6 +42,7 @@ struct arch_hw_breakpoint {
>   #else
>   #define HW_BREAKPOINT_SIZE  0x8
>   #endif
> +#define HW_BREAKPOINT_SIZE_QUADWORD	0x10
>   
>   #define DABR_MAX_LEN	8
>   #define DAWR_MAX_LEN	512
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 1f4a1efa0074..9f7df1c37233 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -520,9 +520,17 @@ static bool ea_hw_range_overlaps(unsigned long ea, int size,
>   				 struct arch_hw_breakpoint *info)
>   {
>   	unsigned long hw_start_addr, hw_end_addr;
> +	unsigned long align_size = HW_BREAKPOINT_SIZE;
>   
> -	hw_start_addr = ALIGN_DOWN(info->address, HW_BREAKPOINT_SIZE);
> -	hw_end_addr = ALIGN(info->address + info->len, HW_BREAKPOINT_SIZE);
> +	/*
> +	 * On p10 predecessors, quadword is handle differently then
> +	 * other instructions.
> +	 */
> +	if (!cpu_has_feature(CPU_FTR_ARCH_31) && size == 16)
> +		align_size = HW_BREAKPOINT_SIZE_QUADWORD;
> +
> +	hw_start_addr = ALIGN_DOWN(info->address, align_size);
> +	hw_end_addr = ALIGN(info->address + info->len, align_size);
>   
>   	return ((ea < hw_end_addr) && (ea + size > hw_start_addr));
>   }
> 
