Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0D2CC6AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgLBT3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:29:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726148AbgLBT3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:29:48 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B2J44ZU020769;
        Wed, 2 Dec 2020 14:28:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=bL6D+P0QeIA3e72nYQ71AKZB/PJjWXB5JNPMBLA76W8=;
 b=tr+9HPfk29r18kauu63njzGnWc3gqsgwD1mBKilCYNIdHYG8yfPF9jxYTdcS8P8Mv7+/
 dbhaMdqzJiM1DApNhdAJWKC0qFOqhiP0y6Y484Rlhdal6jscXr8+/LnduXPuKrvC1ocZ
 +z0cZjKPbbAF3A4mbVTOu19Rg+rQ0Ircbe4DpETGaKKpwaf1G/RBg4SF7mSCNkJxG260
 DcvDfUl9u/vJVMblgrEqanmMU+MJfjmTuw39LKHOKguFYbGdfHrIGuFQgyBcE6T0olpk
 kVRAaybTpQeH080udn9Y6V/dA3St6tYsPrIFExsacKgSWCsGBhCuvHLiIt3DddCiVk2h 8w== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 356a0vf1kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 14:28:36 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B2JMf5V015419;
        Wed, 2 Dec 2020 19:28:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 353e68ch69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 19:28:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B2JSVOd24248580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 19:28:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B99252057;
        Wed,  2 Dec 2020 19:28:31 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.9.70])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0DA7152050;
        Wed,  2 Dec 2020 19:28:29 +0000 (GMT)
Subject: Re: [PATCH 1/5] sched/cputime: Remove symbol exports from IRQ time
 accounting
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
 <20201202115732.27827-2-frederic@kernel.org>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <6c42e7f1-ace6-a433-4472-9463b1022128@de.ibm.com>
Date:   Wed, 2 Dec 2020 20:28:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201202115732.27827-2-frederic@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_10:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 clxscore=1011 suspectscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02.12.20 12:57, Frederic Weisbecker wrote:
> account_irq_enter_time() and account_irq_exit_time() are not called
> from modules. EXPORT_SYMBOL_GPL() can be safely removed from the IRQ
> cputime accounting functions called from there.
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
> ---
>  arch/s390/kernel/vtime.c | 10 +++++-----
>  kernel/sched/cputime.c   |  2 --
>  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
> index 8df10d3c8f6c..f9f2a11958a5 100644
> --- a/arch/s390/kernel/vtime.c
> +++ b/arch/s390/kernel/vtime.c
> @@ -226,7 +226,7 @@ void vtime_flush(struct task_struct *tsk)
>   * Update process times based on virtual cpu times stored by entry.S
>   * to the lowcore fields user_timer, system_timer & steal_clock.
>   */
> -void vtime_account_irq_enter(struct task_struct *tsk)
> +void vtime_account_kernel(struct task_struct *tsk)
>  {
>  	u64 timer;
>  
> @@ -245,12 +245,12 @@ void vtime_account_irq_enter(struct task_struct *tsk)
>  
>  	virt_timer_forward(timer);
>  }
> -EXPORT_SYMBOL_GPL(vtime_account_irq_enter);
> -
> -void vtime_account_kernel(struct task_struct *tsk)
> -__attribute__((alias("vtime_account_irq_enter")));
>  EXPORT_SYMBOL_GPL(vtime_account_kernel);
>  
> +void vtime_account_irq_enter(struct task_struct *tsk)
> +__attribute__((alias("vtime_account_kernel")));
> +
> +

One new line is enough I think. Apart from that this looks sane from an s390 perspective.
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
