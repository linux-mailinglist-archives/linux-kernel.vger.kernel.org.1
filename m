Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B052CC6C0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgLBTfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:35:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731039AbgLBTfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:35:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2JXS7R053552;
        Wed, 2 Dec 2020 14:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XIVFvOaZOXM90r2r6ru3t6GuWG7i5inRBsG/IHcgvTA=;
 b=NdxmUMNuKSICGzjCl6ENG48Z++L/i3lV5tj1hSWIyUeF+F9Q5dNmP2hTKFUStLKIOxL2
 k1urKfrxK4Fya6oTYeD8F2XkputgNzR+XNuiT150ZPzCFuGryKEvs4tVwTSmpnYAzlLe
 yOMVL+E7sQJbowFIKf8H9ZCXULzTyy09GD2A9VA10XzM7iSyyuKgi9ggGlXaqR0ClAA0
 raLJmXkc7L1Ef0JzGEMO8Y9gcvb7b3LXrEbCX9+N7HwgGDDYV0EJAT61q7cQ2HUz1lgC
 SA/iPGmjvjfpFLdn1cH7YO39IHLzsmfMRz5LJkN8cDzksqqhQR1DH8kk0AVLQWCgdws3 sA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 355sr627ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 14:34:09 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2JVq4w027011;
        Wed, 2 Dec 2020 19:34:05 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 35693xgdak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 19:34:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2JY2MH2228908
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 19:34:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A298C5204E;
        Wed,  2 Dec 2020 19:34:02 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.9.70])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id AA91B52051;
        Wed,  2 Dec 2020 19:34:01 +0000 (GMT)
Subject: Re: [PATCH 2/5] s390/vtime: Use the generic IRQ entry accounting
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20201202115732.27827-1-frederic@kernel.org>
 <20201202115732.27827-3-frederic@kernel.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <e62cd8fd-802f-1220-e31b-49f4e6916346@de.ibm.com>
Date:   Wed, 2 Dec 2020 20:34:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202115732.27827-3-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_12:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.12.20 12:57, Frederic Weisbecker wrote:
> s390 has its own version of IRQ entry accounting because it doesn't
> account the idle time the same way the other architectures do. Only
> the actual idle sleep time is accounted as idle time, the rest of the
> idle task execution is accounted as system time.
> 
> Make the generic IRQ entry accounting aware of architectures that have
> their own way of accounting idle time and convert s390 to use it.
> 
> This prepares s390 to get involved in further consolidations of IRQ
> time accounting.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>

As far as I can tel,l this patch should be a no-op for s390 function-wise.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

> ---
>  arch/Kconfig                  |  7 ++++++-
>  arch/s390/Kconfig             |  1 +
>  arch/s390/include/asm/vtime.h |  1 -
>  arch/s390/kernel/vtime.c      |  4 ----
>  kernel/sched/cputime.c        | 13 ++-----------
>  5 files changed, 9 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 56b6ccc0e32d..0f151b49c7b7 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -627,6 +627,12 @@ config HAVE_TIF_NOHZ
>  config HAVE_VIRT_CPU_ACCOUNTING
>  	bool
>  
> +config HAVE_VIRT_CPU_ACCOUNTING_IDLE
> +	bool
> +	help
> +	  Architecture has its own way to account idle CPU time and therefore
> +	  doesn't implement vtime_account_idle().
> +
>  config ARCH_HAS_SCALED_CPUTIME
>  	bool
>  
> @@ -641,7 +647,6 @@ config HAVE_VIRT_CPU_ACCOUNTING_GEN
>  	  some 32-bit arches may require multiple accesses, so proper
>  	  locking is needed to protect against concurrent accesses.
>  
> -
>  config HAVE_IRQ_TIME_ACCOUNTING
>  	bool
>  	help
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 4a2a12be04c9..6f1fdcd3b5db 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -181,6 +181,7 @@ config S390
>  	select HAVE_RSEQ
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
> +	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
>  	select IOMMU_HELPER		if PCI
>  	select IOMMU_SUPPORT		if PCI
>  	select MODULES_USE_ELF_RELA
> diff --git a/arch/s390/include/asm/vtime.h b/arch/s390/include/asm/vtime.h
> index 3622d4ebc73a..fac6a67988eb 100644
> --- a/arch/s390/include/asm/vtime.h
> +++ b/arch/s390/include/asm/vtime.h
> @@ -2,7 +2,6 @@
>  #ifndef _S390_VTIME_H
>  #define _S390_VTIME_H
>  
> -#define __ARCH_HAS_VTIME_ACCOUNT
>  #define __ARCH_HAS_VTIME_TASK_SWITCH
>  
>  #endif /* _S390_VTIME_H */
> diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
> index f9f2a11958a5..ebd8e5655789 100644
> --- a/arch/s390/kernel/vtime.c
> +++ b/arch/s390/kernel/vtime.c
> @@ -247,10 +247,6 @@ void vtime_account_kernel(struct task_struct *tsk)
>  }
>  EXPORT_SYMBOL_GPL(vtime_account_kernel);
>  
> -void vtime_account_irq_enter(struct task_struct *tsk)
> -__attribute__((alias("vtime_account_kernel")));
> -
> -
>  /*
>   * Sorted add to a list. List is linear searched until first bigger
>   * element is found.
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 61ce9f9bf0a3..2783162542b1 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -417,23 +417,14 @@ void vtime_task_switch(struct task_struct *prev)
>  }
>  # endif
>  
> -/*
> - * Archs that account the whole time spent in the idle task
> - * (outside irq) as idle time can rely on this and just implement
> - * vtime_account_kernel() and vtime_account_idle(). Archs that
> - * have other meaning of the idle time (s390 only includes the
> - * time spent by the CPU when it's in low power mode) must override
> - * vtime_account().
> - */
> -#ifndef __ARCH_HAS_VTIME_ACCOUNT
>  void vtime_account_irq_enter(struct task_struct *tsk)
>  {
> -	if (!in_interrupt() && is_idle_task(tsk))
> +	if (!IS_ENABLED(CONFIG_HAVE_VIRT_CPU_ACCOUNTING_IDLE) &&
> +	    !in_interrupt() && is_idle_task(tsk))
>  		vtime_account_idle(tsk);
>  	else
>  		vtime_account_kernel(tsk);
>  }
> -#endif /* __ARCH_HAS_VTIME_ACCOUNT */
>  
>  void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  		    u64 *ut, u64 *st)
> 
