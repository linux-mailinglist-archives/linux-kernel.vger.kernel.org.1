Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF9E2A19AC
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 19:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgJaShj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 14:37:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12032 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727967AbgJaShj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 14:37:39 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09VIW3W3085396;
        Sat, 31 Oct 2020 14:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=AB//ymYESAXZkjglSKJ/7mxvND607bOfUNBtbtyweEY=;
 b=YBMIv/y+c67JLyWiPZuuIKr8YPXTAUtJ5OiiAULJbTX8FGAEAmssV9Ix06rjIQEJC6q1
 I6dAMSdYqV4fzXej2k3SFKUGGuZ7FRJl+IssaDUwJMxVL6TrvCwGhf11EEOCaAU/Skpj
 3jx4hSArFn9L9NjbpPc7IJoacUFYwZdOLysgBLo6boVe2E/sGztifhiA/5AeVKo+8aWj
 1ZAzGyoz5mLy3hxrrOHz2lm1aN+6Gb7GqURqHs4LU7tAi4vIF7ZKb/IGcnHzgX05psxu
 4qv86yWsDpgoqXHSwg7dD+wWxWs7Xy13kd++e2Zk8v1NrSCOHztw8+0x0PxQZG9+Q8Da ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34h0tb62xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Oct 2020 14:37:33 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09VIaEH3099524;
        Sat, 31 Oct 2020 14:37:32 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34h0tb62w9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Oct 2020 14:37:32 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09VIRXqC023141;
        Sat, 31 Oct 2020 18:37:30 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 34h01qr8m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 31 Oct 2020 18:37:29 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09VIbQmV3998422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 31 Oct 2020 18:37:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6A3452057;
        Sat, 31 Oct 2020 18:37:26 +0000 (GMT)
Received: from osiris (unknown [9.171.9.119])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 88BB452050;
        Sat, 31 Oct 2020 18:37:26 +0000 (GMT)
Date:   Sat, 31 Oct 2020 19:37:25 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Qian Cai <cai@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201031183725.GA9529@osiris>
References: <20201028182742.13773-1-cai@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028182742.13773-1-cai@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-31_06:2020-10-30,2020-10-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010310152
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:27:42PM -0400, Qian Cai wrote:
> The call to rcu_cpu_starting() in smp_init_secondary() is not early
> enough in the CPU-hotplug onlining process, which results in lockdep
> splats as follows:
> 
>  WARNING: suspicious RCU usage
>  -----------------------------
>  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  RCU used illegally from offline CPU!
>  rcu_scheduler_active = 1, debug_locks = 1
>  no locks held by swapper/1/0.
> 
>  Call Trace:
>  show_stack+0x158/0x1f0
>  dump_stack+0x1f2/0x238
>  __lock_acquire+0x2640/0x4dd0
>  lock_acquire+0x3a8/0xd08
>  _raw_spin_lock_irqsave+0xc0/0xf0
>  clockevents_register_device+0xa8/0x528
>  init_cpu_timer+0x33e/0x468
>  smp_init_secondary+0x11a/0x328
>  smp_start_secondary+0x82/0x88
> 
> This is avoided by moving the call to rcu_cpu_starting up near the
> beginning of the smp_init_secondary() function. Note that the
> raw_smp_processor_id() is required in order to avoid calling into
> lockdep before RCU has declared the CPU to be watched for readers.
> 
> Link: https://lore.kernel.org/lkml/160223032121.7002.1269740091547117869.tip-bot2@tip-bot2/
> Signed-off-by: Qian Cai <cai@redhat.com>
> ---
>  arch/s390/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Could you provide the config you used? I'm wondering why I can't
reproduce this even though I have lot's of debug options enabled.

I will apply it anyway after rc2 has been released, just curious.
